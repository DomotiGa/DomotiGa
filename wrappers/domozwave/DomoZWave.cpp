//-----------------------------------------------------------------------------
//
// DomoZWave a C++/C-wrapper to add open-zwave support to DomotiGa.
// Special thanks to Jaren for creating the wrapper and Alexie for updating it.
//
// DomotiGa - an open source home automation program.
// Copyright (C) Ron Klinkien, The Netherlands.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General PUBLIC License for more details.
//
// You should have received a copy of the GNU General PUBLIC License
// along with this program. If not, see <http://www.gnu.org/licenses/>.
//
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// Define and get version numbers of DomoZWave and the open-zwave (vers.c)
//-----------------------------------------------------------------------------
char domozwave_vers[] = "DomoZWave version r1143";
#include <vers.c>
//-----------------------------------------------------------------------------

// system
#include <iostream>
#include <fstream>
#include <stdio.h>
#include <pthread.h>
#include <ctime>
#include <sys/time.h>
#include <map>

// xmlrpc
#include <xmlrpc-c/base.h>
#include <xmlrpc-c/client.h>

// open-zwave
#include "Options.h"
#include "Log.h"
#include "Manager.h"
#include "Node.h"
#include "Group.h"
#include "Notification.h"
#include "ValueStore.h"
#include "Value.h"
#include "ValueBool.h"
#include "ValueByte.h"
#include "ValueDecimal.h"
#include "ValueInt.h"
#include "ValueList.h"
#include "ValueShort.h"
#include "ValueString.h"

// wrapper
#include "DomoZWave.h"
using namespace OpenZWave;

//-----------------------------------------------------------------------------
// Internal enum types
//-----------------------------------------------------------------------------

enum TypeNodeState
{
	DZType_Unknown = 0,
	DZType_Alive,
	DZType_Dead,
	DZType_Sleep,
	DZType_Awake,
	DZType_Timeout
};

//-----------------------------------------------------------------------------
// Variables
//-----------------------------------------------------------------------------

// We need to store globally the logfile stream and filename
string logfile_prefix;
string logfile_name;
ofstream logfile;

// Define serialport string, we require the serialport if we want to stop the
// Open Z-Wave library properly
list<string> serialPortName;

xmlrpc_env env;
xmlrpc_client* clientP;
char url[35];
bool debugging;

static pthread_mutex_t g_criticalSection;

///////////////////////////////////////////////////////////////////////////////
// Basic Command Class Mapping
///////////////////////////////////////////////////////////////////////////////

// Define map/hash to store COMMAND_CLASS_BASIC to other COMMAND_CLASS mapping
// This prevents multi ValueChanged events for a single event
// NOTE: This information is known in the Open Z-Wave library, but not accessible
//       for us. Maybe in the future this is possible? 
std::map<string, int> MapCommandClassBasic;

///////////////////////////////////////////////////////////////////////////////
// Controller/homeId information, includes multiple controller support
///////////////////////////////////////////////////////////////////////////////

typedef struct
{
	uint8		m_command;
	uint8		m_nodeId;
	time_t		m_time;
} m_cmdItem;


typedef struct
{
	uint32		m_homeId;
	uint8		m_controllerId;
	uint32		m_controllerAllQueried;
	bool		m_controllerBusy;
	uint8		m_nodeId;
	list<m_cmdItem>	m_cmd;
	uint8		m_userCodeEnrollNode;
	time_t		m_userCodeEnrollTime;
} m_structCtrl;

static list<m_structCtrl*> g_allControllers;

///////////////////////////////////////////////////////////////////////////////
// ControllerInfo Functions for Open Z-Wave
///////////////////////////////////////////////////////////////////////////////

m_structCtrl* GetControllerInfo
(
	uint32 const homeId
)
{
	for ( list<m_structCtrl*>::iterator it = g_allControllers.begin(); it != g_allControllers.end(); ++it )
	{
		m_structCtrl* ctrl = *it;
		if ( ctrl->m_homeId == homeId )
		{
			return ctrl;
		}
	}

	return NULL;
}

///////////////////////////////////////////////////////////////////////////////
// Structure of internal Open Z-Wave node information
///////////////////////////////////////////////////////////////////////////////

// To enable polling we need a nodeId->ValueID mapping. I asked on the mailing
// list and the only suggestion I got was to store them off when the values are
// added. So we store a list of structs to hold this mapping.

typedef struct
{
	uint32		m_homeId;
	uint8		m_nodeId;
	uint8		basicmapping;
	uint8		instancecount;
	string		commandclass;
	time_t		m_LastSeen;
	TypeNodeState	m_DeviceState;
	std::map<int,string> instancecommandclass;
	std::map<int,string> instanceLabel;
	list<ValueID>	m_values;
} NodeInfo;

static list<NodeInfo*> g_nodes;

///////////////////////////////////////////////////////////////////////////////
// NodeInfo Functions for Open Z-Wave
///////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
// <GetNodeInfo>
// Callback that is triggered when a value, group or node changes
//-----------------------------------------------------------------------------

NodeInfo* GetNodeInfo
(
	uint32 const homeId,
	uint8 const nodeId
)
{
	for ( list<NodeInfo*>::iterator it = g_nodes.begin(); it != g_nodes.end(); ++it )
	{
		NodeInfo* nodeInfo = *it;
		if ( ( nodeInfo->m_homeId == homeId ) && ( nodeInfo->m_nodeId == nodeId ) )
		{
			return nodeInfo;
		}
	}

	return NULL;
}

NodeInfo* GetNodeInfo
(
	Notification const* notification
)
{
	uint32 const homeId = notification->GetHomeId();
	uint8 const nodeId = notification->GetNodeId();
	return GetNodeInfo( homeId, nodeId );
}

///////////////////////////////////////////////////////////////////////////////
// Generic Functions
///////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
// <InitVars>
// Initialize the map/arrays to be used by the Open Z-wave Wrapper
//-----------------------------------------------------------------------------

void InitVars()
{
	// List of the CommandClass Basic mapping to a specific one
	MapCommandClassBasic.clear();
	MapCommandClassBasic["0x03|0x11"] = 0x94;
	MapCommandClassBasic["0x03|0x12"] = 0x30;
	MapCommandClassBasic["0x08|0x02"] = 0x40;
	MapCommandClassBasic["0x08|0x03"] = 0x46;
	MapCommandClassBasic["0x08|0x04"] = 0x43;
	MapCommandClassBasic["0x08|0x05"] = 0x40;
	MapCommandClassBasic["0x08|0x06"] = 0x40;
	MapCommandClassBasic["0x09|0x01"] = 0x50;
	MapCommandClassBasic["0x10"] = 0x25;
	MapCommandClassBasic["0x11"] = 0x26;
	MapCommandClassBasic["0x12|0x01"] = 0x25;
	MapCommandClassBasic["0x12|0x02"] = 0x26;
	MapCommandClassBasic["0x12|0x03"] = 0x28;
	MapCommandClassBasic["0x12|0x04"] = 0x29;
	MapCommandClassBasic["0x13|0x01"] = 0x28;
	MapCommandClassBasic["0x13|0x02"] = 0x29;
	MapCommandClassBasic["0x16|0x01"] = 0x39;
	MapCommandClassBasic["0x20"] = 0x30;
	MapCommandClassBasic["0x21"] = 0x31;
	MapCommandClassBasic["0x30"] = 0x35;
	MapCommandClassBasic["0x31|0x01"] = 0x32;
	MapCommandClassBasic["0x40|0x01"] = 0x62;
	MapCommandClassBasic["0x40|0x02"] = 0x62;
	MapCommandClassBasic["0x40|0x03"] = 0x62;
	MapCommandClassBasic["0xa1"] = 0x71;

}

//-----------------------------------------------------------------------------
// Returns current date/time in readable format, used for cout
//-----------------------------------------------------------------------------

ostream &OZW_datetime(ostream &stream)
{
	// Get a timestamp
	struct timeval tv;
	gettimeofday(&tv, NULL);
	struct tm *tm;
	tm = localtime( &tv.tv_sec );

	// create a timestamp string for the log message
	char localt[100];
	snprintf( localt, sizeof(localt), "%04d-%02d-%02d %02d:%02d:%02d:%03d",
		tm->tm_year + 1900, tm->tm_mon + 1, tm->tm_mday,
		tm->tm_hour, tm->tm_min, tm->tm_sec, tv.tv_usec / 1000 );

	stream << localt;

	return stream;
}

//-----------------------------------------------------------------------------
// <WriteLog>
//
//-----------------------------------------------------------------------------

// Possible LogLevel values (re-use from Open Z-Wave):
// LogLevel_None, LogLevel_Always, LogLevel_Fatal, LogLevel_Error, LogLevel_Warning, 
// LogLevel_Alert, LogLevel_Info, LogLevel_Detail, LogLevel_Debug, LogLevel_Internal
//
// BUT we only use _Error and _Debug

void WriteLog
(
	LogLevel _log, 
	bool	_newline,
	char const* _format,
	...
)
{
	char buffer[1024];
	va_list args;
	string tfilename;

	if ( ( _log == LogLevel_Error ) || ( ( _log == LogLevel_Debug ) && ( debugging ) ) ) 
	{
		va_start( args, _format );
		vsnprintf( buffer, 1023, _format, args );

		if ( logfile.is_open() )
		{
			// Get a timestamp for Year and Month
			struct timeval tv;
			gettimeofday(&tv, NULL);
			struct tm *tm;
			tm = localtime( &tv.tv_sec );

			// create a timestamp string with Year and Month
			char localt[100];
			snprintf( localt, sizeof(localt), "%04d-%02d", tm->tm_year + 1900, tm->tm_mon + 1 );

			tfilename = logfile_prefix;
			tfilename.append(localt);
			tfilename.append(".log");

			// If the year/month changed, close and re-open
			if ( logfile_name != tfilename )
			{
				logfile_name = tfilename;

				logfile.close();
				logfile.open( logfile_name.c_str(), ios::app );

				// Catch an error during the re-open
				if ( ! logfile.is_open() )
				{
					cout << OZW_datetime << " [DomoZwave] " << "***FATAL*** Unable to write to \"" << logfile_name << "\"" << endl;
					if ( _newline == true ) cout << endl;
					cout << OZW_datetime << " [DomoZwave] " << buffer << endl;
				}
				else
				{
					if ( _newline == true ) logfile << endl;
					logfile << OZW_datetime << " [DomoZwave] " << buffer << endl;
				}
			}
			else
			{
				if ( _newline == true ) logfile << endl;
				logfile << OZW_datetime << " [DomoZwave] " << buffer << endl;
			}
		}
		else
		{
			if ( _newline == true ) cout << endl;
			cout << OZW_datetime << " [DomoZwave] " << buffer << endl;
		}

		va_end( args );
	}
}

///////////////////////////////////////////////////////////////////////////////
// RPC Helper Functions
///////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
// <fault_occured>
//
//-----------------------------------------------------------------------------

bool fault_occurred( const char* funct, xmlrpc_env* env )
{
	if ( env->fault_occurred )
	{
		WriteLog( LogLevel_Error, true, "ERROR: In call \"%s\"", funct );
		WriteLog( LogLevel_Error, false, "ERROR: XML-RPC Fault: %s (%d)", env->fault_string, env->fault_code ); 
		return true;
	}
	return false; 
}

//-----------------------------------------------------------------------------
// <RPC_ValueRemoved>
// This is called if a Value is removed, normally happens when the controller
// shuts down
//-----------------------------------------------------------------------------

void RPC_ValueRemoved( int homeID, int nodeID, ValueID valueID )
{
	int id = valueID.GetCommandClassId();
	int genre = valueID.GetGenre();
	int instanceID = valueID.GetInstance();

	WriteLog(LogLevel_Debug, true, "ValueRemoved: HomeId=%d Node=%d", homeID, nodeID);
	WriteLog(LogLevel_Debug, false, "Genre=%d", genre);
	WriteLog(LogLevel_Debug, false, "GenreName=%s", DomoZWave_GenreIdName(genre));
	WriteLog(LogLevel_Debug, false, "CommandClassId=%d", id);
	WriteLog(LogLevel_Debug, false, "CommandClassName=%s", DomoZWave_CommandClassIdName(id));
	WriteLog(LogLevel_Debug, false, "Instance=%d", instanceID);
	WriteLog(LogLevel_Debug, false, "Index=%d", valueID.GetIndex());
}

//-----------------------------------------------------------------------------
// <RPC_ValueChanged>
// This is called when a device reports that a value has changed or added.
// If it was from a known command class we'll report that value back to DomotiGa.
//-----------------------------------------------------------------------------

void RPC_ValueChanged( int homeID, int nodeID, ValueID valueID, bool add )
{
	int id = valueID.GetCommandClassId();
	int genre = valueID.GetGenre();
	string label = Manager::Get()->GetValueLabel( valueID );
	string unit = Manager::Get()->GetValueUnits( valueID );
	int instanceID = valueID.GetInstance();
	int type = valueID.GetType();
	char dev_value[1024];
	char tmp_dev_value[1024];
	uint8 byte_value;
	bool bool_value;
	string decimal_value;
	string list_value;
	string string_value;
	int int_value;
	int16 short_value;
	int value_no = 0;
	string str_tmp;
	NodeInfo* nodeInfo;

	WriteLog( LogLevel_Debug, true, "%s: HomeId=%d Node=%d", (add)?"ValueAdded":"ValueChanged", homeID, nodeID );
	WriteLog( LogLevel_Debug, false, "Genre=%d", genre );
	WriteLog( LogLevel_Debug, false, "GenreName=%s", DomoZWave_GenreIdName( genre ) );
	WriteLog( LogLevel_Debug, false, "CommandClassId=%d", id );
	WriteLog( LogLevel_Debug, false, "CommandClassName=%s", DomoZWave_CommandClassIdName( id ) );
	WriteLog( LogLevel_Debug, false, "Instance=%d", instanceID );
	WriteLog( LogLevel_Debug, false, "Index=%d", valueID.GetIndex() );
	WriteLog( LogLevel_Debug, false, "Label=%s", label.c_str() );
	WriteLog( LogLevel_Debug, false, "Units=%s", unit.c_str() );

	nodeInfo = GetNodeInfo( homeID, nodeID );
	if ( nodeInfo == NULL )
	{
		WriteLog( LogLevel_Error, false, "ERROR: %s: HomeId=%d Node=%d - Node exists in Z-Wave Network, but not in internal Open-ZWave wrapper list - Please report this as a BUG", (add)?"ValueAdded":"ValueChanged", homeID, nodeID );
		return;
	}

/*
	if ( add )
	{
		Manager::Get()->SetChangeVerified( valueID, true );
	}
*/

	// We need to check which ValueType it is, before we can output it as a string
	switch ( type )
	{
		case ValueID::ValueType_Bool:
		{
			Manager::Get()->GetValueAsBool( valueID, &bool_value );
			snprintf( dev_value, 1024, "%i", bool_value );
			WriteLog( LogLevel_Debug, false, "Type=Bool (raw value=%s)", dev_value );
			break;
		}
		case ValueID::ValueType_Byte:
		{
			Manager::Get()->GetValueAsByte( valueID, &byte_value );
			snprintf( dev_value, 1024, "%i", byte_value );
			WriteLog( LogLevel_Debug, false, "Type=Byte (raw value=%s)", dev_value );
			break;
		}
		case ValueID::ValueType_Decimal:
		{
			Manager::Get()->GetValueAsString( valueID, &decimal_value );
			snprintf( dev_value, 1024, "%s", strdup( decimal_value.c_str() ) );
			WriteLog( LogLevel_Debug, false, "Type=Decimal (raw value=%s)", dev_value );
			break;
		}
		case ValueID::ValueType_Int:
		{
			Manager::Get()->GetValueAsInt( valueID, &int_value );
			snprintf( dev_value, 1024, "%d", int_value );
			WriteLog( LogLevel_Debug, false, "Type=Integer (raw value=%s)", dev_value );
			break;
		}
		case ValueID::ValueType_Short:
		{
			Manager::Get()->GetValueAsShort( valueID, &short_value );
			snprintf( dev_value, 1024, "%d", short_value );
			WriteLog( LogLevel_Debug, false, "Type=Short (raw value=%s)", dev_value );
			break;
		}
		case ValueID::ValueType_Schedule:
		{
			WriteLog( LogLevel_Debug, false, "Type=Schedule (not implemented)" );
			return;
			//break;
		}
		case ValueID::ValueType_String:
		{
			Manager::Get()->GetValueAsString( valueID, &string_value );
			snprintf( dev_value, 1024, "%s", strdup( string_value.c_str() ) );
			WriteLog( LogLevel_Debug, false, "Type=String (raw value=%s)", dev_value );
			break;
		}
		case ValueID::ValueType_Button:
		{
			WriteLog( LogLevel_Debug, false, "Type=Button (not implemented)" );
			return;
			//break;
		}
		case ValueID::ValueType_List:
		{
			Manager::Get()->GetValueListSelection( valueID, &list_value );
			snprintf( dev_value, 1024, "%s", strdup( list_value.c_str() ) );
			WriteLog( LogLevel_Debug, false, "Type=List (raw value=%s)", dev_value );
			break;
		}
		case ValueID::ValueType_Raw:
		{
			// We can use AsString on a Raw
			Manager::Get()->GetValueAsString( valueID, &string_value );
			snprintf( dev_value, 1024, "%s", strdup( string_value.c_str() ) );
			WriteLog( LogLevel_Debug, false, "Type=Raw (raw value=%s)", dev_value );
			break;
		}
		default:
		WriteLog( LogLevel_Debug, false, "Type=Unknown" );
		return;
	}

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

	switch ( id )
	{
		// We shouldn't see thie COMMAND_CLASS_BASIC anymore, because it should be
		// mapped already. We leave it in for backwards compatibility reasons
		case COMMAND_CLASS_BASIC:
		{
			if ( label == "Basic" )
			{
				// Store the label, because it is a known one
				value_no = 1;

				if ( strcmp( dev_value, "255" ) == 0 ) 
				{
					strcpy(dev_value, "On" );
				}
				else if ( strcmp( dev_value, "99" ) == 0 ) 
				{
					strcpy( dev_value, "On" );
				}
				else if ( strcmp( dev_value, "1" ) == 0 ) 
				{
					strcpy( dev_value, "On");
				}
				else if ( strcmp( dev_value, "0" ) == 0 ) 
				{
					strcpy( dev_value, "Off" );
				}
/*
				else
				{
					sprintf( tmp_dev_value, "Dim %s", dev_value );
					strcpy( dev_value, tmp_dev_value );
				}
*/
			}

			break;
		}
		case COMMAND_CLASS_SWITCH_BINARY:
		{
			if ( label == "Switch" )
			{
				value_no = 1;

				if ( strcmp( dev_value, "1" ) == 0 ) 
				{
					strcpy( dev_value, "On" );
				} else {
					strcpy( dev_value, "Off" );
				}
			}

			break;
		}
		case COMMAND_CLASS_SWITCH_MULTILEVEL:
		{	
			if ( label == "Level" )
			{
				value_no = 1;

				sprintf( tmp_dev_value, "Dim %s", dev_value );
				strcpy( dev_value, tmp_dev_value );

				if ( strcmp( dev_value, "Dim 0" ) == 0 )
				{
					strcpy( dev_value, "Off" );
				}
				else if ( strcmp( dev_value, "Dim 99" ) == 0 )
				{
					strcpy( dev_value, "On" );
				}
				else if ( strcmp( dev_value, "Dim 100" ) == 0 )
				{
					strcpy( dev_value, "On" );
				}
			}

			break;
		}
		case COMMAND_CLASS_METER:
		{
			if ( label == "Power" )
			{
				value_no = 2;
			}
			else if ( ( label == "Energy" ) && ( unit == "kWh" ) )
			{
				value_no = 3;
			}

			break;
		}
		case COMMAND_CLASS_SENSOR_BINARY:
		{	
			if ( label == "Sensor" )
			{
				value_no = 1;

				if ( strcmp( dev_value, "1" ) == 0 )
				{
					// Closed
					strcpy( dev_value, "On" );
				}
				else
				{
					// Open
					strcpy( dev_value, "Off" );
				}
			}

			break;
		}
		case COMMAND_CLASS_BATTERY:
		{
			if ( label == "Battery Level" )
			{
				value_no = 255;
			}

			break;
		}
		case COMMAND_CLASS_ALARM:
		{
			if ( label == "Alarm Level" )
			{
				value_no = 2;

				if ( strcmp( dev_value, "0" ) == 0 )
				{
					strcpy( dev_value, "Secure" );
				}
				else
				{
					strcpy( dev_value, "Tamper" );
				}
			}

			break;
		}
		case COMMAND_CLASS_SENSOR_MULTILEVEL:
		{
			if ( label == "Temperature" )
			{
				value_no = 1;
			}
			else if ( label == "Luminance" )
			{
				value_no = 3;
			}
			else if ( label == "Relative Humidity" )
			{
				value_no = 2;
			} 

			break;
		}
	}

	// We want to skip "add" values, because they are coming from the content of the zwcfg*xml. Normally
	// only previously stored values are giving. DomotiGa is the only one using that file, thus all the
	// known values are already in the DomotiGa DB. Also if you do a start and directly restart and the
	// value hasn't been refreshed, after the restart the value is empty == GARBAGE

	// We will store the COMMAND_CLASS_ information (for the device and per instance)
	// We will store the number of instances
	// We will store the configuration items available 
	if ( add )
	{
		WriteLog( LogLevel_Debug, false, "ValueKnown=%s, ReadOnly=%s, WriteOnly=%s", ( Manager::Get()->IsValueSet( valueID ) )?"true":"false", ( Manager::Get()->IsValueReadOnly( valueID ) )?"true":"false", ( Manager::Get()->IsValueWriteOnly( valueID ) )?"true":"false" );
		WriteLog( LogLevel_Debug, false, "Min=%d", Manager::Get()->GetValueMin( valueID ) );
		WriteLog( LogLevel_Debug, false, "Max=%d", Manager::Get()->GetValueMax( valueID ) );

		if ( value_no > 0 )
		{
			WriteLog( LogLevel_Debug, false, "Value%d=%s", value_no, dev_value );
		}
		else
		{
			WriteLog( LogLevel_Debug, false, "Value=%s", dev_value );
		}

		if ( ( Manager::Get()->GetValueHelp( valueID ) != "" ) && ( add ) )
		{
			WriteLog( LogLevel_Debug, false, "Help=%s", Manager::Get()->GetValueHelp( valueID ).c_str() );
		}

		// Check how many instance we got per node, if we got a higher instanceID, store it
		if ( instanceID > nodeInfo->instancecount )
		{
			nodeInfo->instancecount = instanceID;
		}

		// Add to the nodeInfo commandclass list
		str_tmp = string( DomoZWave_CommandClassIdName( id ) );
		str_tmp.append( "|" );

		if ( nodeInfo->commandclass == "" )
		{
			nodeInfo->commandclass = "|";
			nodeInfo->commandclass.append( str_tmp );
		}
		else
		{
			if ( nodeInfo->commandclass.find(str_tmp) == string::npos )
			{
				nodeInfo->commandclass.append(str_tmp);
			}
		}

		// We also need to store it per instance. This information can be used to
		// determine if an issues is a Switch/Dim device
		if ( nodeInfo->instancecommandclass.find(instanceID) != nodeInfo->instancecommandclass.end() )
		{
			if ( nodeInfo->instancecommandclass[instanceID].find(str_tmp) == string::npos )
			{
				nodeInfo->instancecommandclass[instanceID].append(str_tmp);
			}
		}
		else
		{
			nodeInfo->instancecommandclass[instanceID] = "";
			nodeInfo->instancecommandclass[instanceID].append("|");
			nodeInfo->instancecommandclass[instanceID].append(str_tmp);
		}

		// We need to skip the "Basic" label if we got a basicmapping
		if ( ( id == COMMAND_CLASS_BASIC ) && (nodeInfo->basicmapping > 0 ) )
		{
			value_no = 0;
		}

		// Lets store the instance & known labels (variable)
		// When a ValueChange happens, we need to try to map them to Value1 - 4
		if ( ( value_no >= 1  ) && ( value_no <= 254 ) )
		{

			// All possible labels (sorted in priority):
			// Basic, Switch, Level, Sensor, Power, Energy, Temperature, Luminance, Relative Humidity, Alarm Level

			// NOTE: Basic+Switch+Level are normally same the for a switch/dimmer

			// Known and supported combinations:
			// Switch + Power + Energy + Alarm Level (e.g. GreenWave PowerNode 1)
			// Sensor + Alarm Level (e.g. Everspring SP103) 
			// Sensor + Temperature + Luminance + Humidity (e.g. Aeon 4in1)
			// Sensor + Temperature + Alarm Level? (e.g. Digital Home System DHS-ZW-SNMT-01)

			// Following code concats the label to the string, also adds a "|" delimiter
			// After it is added, we need re-sort the string to make it useable in ValueChanged
			if ( nodeInfo->instanceLabel.find( instanceID ) != nodeInfo->instanceLabel.end() )
			{
				nodeInfo->instanceLabel[instanceID].append(label);
				nodeInfo->instanceLabel[instanceID].append("|");

				str_tmp = "|";
				if ( nodeInfo->instanceLabel[instanceID].find("|Basic|") != string::npos ) { str_tmp.append("Basic|"); }

				// Normally a dimmer has Switch+Level, so we need to combine in the same value
				if ( ( nodeInfo->instanceLabel[instanceID].find("|Switch|") != string::npos ) &&  ( nodeInfo->instanceLabel[instanceID].find("|Level|") != string::npos ) )
				{
					str_tmp.append("Switch-Level|");
				}
				else if ( nodeInfo->instanceLabel[instanceID].find("|Switch-Level|") != string::npos )
				{
					str_tmp.append("Switch-Level|");
				}
				else if ( nodeInfo->instanceLabel[instanceID].find("|Switch|") != string::npos )
				{
					str_tmp.append("Switch|");
				}
				else if ( nodeInfo->instanceLabel[instanceID].find("|Level|") != string::npos )
				{
					str_tmp.append("Level|");
				}

				if ( nodeInfo->instanceLabel[instanceID].find("|Sensor|") != string::npos ) { str_tmp.append("Sensor|"); }
				if ( nodeInfo->instanceLabel[instanceID].find("|Power|") != string::npos ) { str_tmp.append("Power|"); }
				if ( nodeInfo->instanceLabel[instanceID].find("|Energy|") != string::npos ) { str_tmp.append("Energy|"); }
				if ( nodeInfo->instanceLabel[instanceID].find("|Temperature|") != string::npos ) { str_tmp.append("Temperature|"); }
				if ( nodeInfo->instanceLabel[instanceID].find("Relative Humidity") != string::npos ) { str_tmp.append("Relative Humidity|"); }
				if ( nodeInfo->instanceLabel[instanceID].find("|Luminance|") != string::npos ) { str_tmp.append("Luminance|"); }
				if ( nodeInfo->instanceLabel[instanceID].find("Alarm Level") != string::npos ) { str_tmp.append("Alarm Level|"); }

				// Replace the previous string with the newly generated
				nodeInfo->instanceLabel[instanceID] = str_tmp;

			}
			else
			{
				nodeInfo->instanceLabel[instanceID] = "";
				nodeInfo->instanceLabel[instanceID].append("|");
				nodeInfo->instanceLabel[instanceID].append(label);
				nodeInfo->instanceLabel[instanceID].append("|");
			}
		} 

		// We will not send the ValueAdd to DomotiGa, because they are in general unreliable and open-zwave in most cases
		// during a restart send empty values
		WriteLog( LogLevel_Debug, false, "Note=Value not send to DomotiGa to with ValueAdd (values are unreliable at startup)" );
		return;
	}

	// If we are CommandClass Basic and mapping is enabled for this device, report it and exit
	if ( ( id == COMMAND_CLASS_BASIC ) && (nodeInfo->basicmapping > 0 ) )
	{
		// We have a mapping, we report it to the logfile
		WriteLog( LogLevel_Debug, false, "Mapping=COMMAND_CLASS_BASIC mapped to %s", DomoZWave_CommandClassIdName( nodeInfo->basicmapping ) );
		WriteLog( LogLevel_Debug, false, "Note=Value not send to DomotiGa, because COMMAND_CLASS_BASIC mapping exists" );
		return;
	}
	else
	{
		// Report Mapping=None if we found a device which doesn't support it
		if ( id == COMMAND_CLASS_BASIC )
		{
			WriteLog( LogLevel_Debug, false, "Mapping=None" );
		}
	}

	// Only send it to DomotiGa if the value is >0 (1, 2, 3, 4 or 255)
	if ( value_no > 0 )
	{
		// If we have a list of instanceLabels, write it to the debug logfile
		if ( nodeInfo->instanceLabel.find(instanceID) != nodeInfo->instanceLabel.end() )
		{
			//WriteLog(LogLevel_Debug, false, "Node=%d, Instance=%d, InstanceLabel=%s", nodeID, instanceID, nodeInfo->instanceLabel[instanceID].c_str());
			WriteLog( LogLevel_Debug, false, "InstanceLabel=%s", nodeInfo->instanceLabel[instanceID].c_str() );

			// Only overrule the value_no if the node and labels are known for this instance
			// So if an error or unknown device happens, it falls back to the old mapping

			string next = "";
			string tnext;
			int delimitercount = 0;

			for ( string::const_iterator it = nodeInfo->instanceLabel[instanceID].begin(); it != nodeInfo->instanceLabel[instanceID].end(); it++ )
			{
				tnext = *it;
				if ( tnext == "|" )
				{
					delimitercount++;

					if ( next.length() > 0 )
					{

						if ( label == next )
						{
							value_no = delimitercount - 1;
							break;
						}

						// Captures the special Switch-Level case
						if ( ( label == "Switch" ) || ( label == "Level" ) )
						{
							if ( next == "Switch-Level" )
							{
								value_no = delimitercount - 1;
								break;
							}
						}

						next = "";
					}
				}
				else
				{
					next += *it;
				}
			}
		}

		WriteLog( LogLevel_Debug, false, "Value%d=%s", value_no, dev_value );

		// Re-initialize the env, else after the FIRST error, the DomoZWave is dead in the water
		xmlrpc_env_init( &env );
		xmlrpc_value* resultP = NULL;
		xmlrpc_client_call2f( &env, clientP, url, "zwave.setvalue", &resultP, "(iiiis)", homeID, nodeID, instanceID, value_no, dev_value );

		// Check if we didn't receive an error, then check if we get TRUE back (FALSE isn't good ;-))
		if ( ! fault_occurred ( "zwave.setvalue", &env ) )
		{
			xmlrpc_bool bvalue;
			
			xmlrpc_read_bool( &env, resultP, &bvalue );

			if ( ! bvalue )
			{
				WriteLog( LogLevel_Error, true, "ERROR: In call \"zwave.setvalue\" returned FALSE" );
			}
		}

		if ( resultP )
		{
			xmlrpc_DECREF( resultP );
		}
	} else {
		WriteLog( LogLevel_Debug, false, "Value=%s", dev_value );
		WriteLog( LogLevel_Debug, false, "Note=Value not send, CommandClassId & label combination isn't supported by DomotiGa (this is not an issue)" );
	}

	// Here we do special actions for (automatic) UserCode enrollment
	// If the Index=0, that seems to be the "new" UserCode, which need to be added
	if (( id == COMMAND_CLASS_USER_CODE ) && ( instanceID == 1 ) && ( genre == ValueID::ValueGenre_User ) && ( valueID.GetIndex() == 0 ) && ( valueID.GetType() == ValueID::ValueType_Raw ))
	{

		m_structCtrl* ctrl = GetControllerInfo( homeID );

		// Only do the enrollment, if it matches are preselected node
		if ( ctrl->m_userCodeEnrollNode == nodeID )
		{
			WriteLog( LogLevel_Debug, false, "UserCode=New User Code or Tag Code received, controller is in enroll mode" );

			// We matched, find a "free" UserCode in our node list and do a SetValue
			for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
			{
				ValueID v = *it;

				// Find the usercode items of this node
				if (( v.GetCommandClassId() == COMMAND_CLASS_USER_CODE ) && ( v.GetGenre() == ValueID::ValueGenre_User ) && ( v.GetInstance() == 1 ) && ( v.GetType() == ValueID::ValueType_Raw ))
				{
					// Only allow index >=1, because the "new" UserCode has index=0
					if ( v.GetIndex() >= 1 )
					{
						string string_value;
						Manager::Get()->GetValueAsString( v, &string_value );

						// We assume if the value starts with "0x00" that it is empty
						if ( string_value.find("0x00") == 0 )
						{
							WriteLog( LogLevel_Debug, false, "UserCode=Code %d is available, setting the received code", v.GetIndex() );
							WriteLog( LogLevel_Debug, false, "" );
							string_value = dev_value;
							//response = Manager::Get()->SetValue( v, string_value );
							Manager::Get()->SetValue( v, string_value );
							break;
						}
					}
				}
			}
		}
		else
		{
			WriteLog( LogLevel_Debug, false, "UserCode=New User Code or Tag Code received, but controller isn't in enroll mode" );
		}
	}
}

//-----------------------------------------------------------------------------
// <RPC_NodeAdd>
//
//-----------------------------------------------------------------------------

void RPC_NodeAdded( int homeID, int nodeID )
{
	WriteLog( LogLevel_Debug, true, "NodeAdd: HomeId=%d Node=%d", homeID, nodeID );
}

//-----------------------------------------------------------------------------
// <RPC_RemoveNode>
//
//-----------------------------------------------------------------------------

void RPC_NodeRemoved( int homeID, int nodeID )
{
	WriteLog( LogLevel_Debug, true, "NodeRemoved: HomeId=%d Node=%d", homeID, nodeID );
}

//-----------------------------------------------------------------------------
// <RPC_NodeNew>
//
//-----------------------------------------------------------------------------

void RPC_NodeNew( int homeID, int nodeID )
{
	WriteLog( LogLevel_Debug, true, "NodeNew: HomeId=%d Node=%d", homeID, nodeID );
}

//-----------------------------------------------------------------------------
// <RPC_NodeProtocolInfo>
// We got results to a Protocol Info query, send them over to domotiga.
//-----------------------------------------------------------------------------

void RPC_NodeProtocolInfo( int homeID, int nodeID )
{
	xmlrpc_int32 basic = Manager::Get()->GetNodeBasic( homeID, nodeID );
	xmlrpc_int32 generic = Manager::Get()->GetNodeGeneric( homeID, nodeID );
	xmlrpc_int32 specific = Manager::Get()->GetNodeSpecific( homeID, nodeID );
	xmlrpc_bool listening = Manager::Get()->IsNodeListeningDevice( homeID, nodeID );
	xmlrpc_bool frequentlistening = Manager::Get()->IsNodeFrequentListeningDevice( homeID, nodeID );
	xmlrpc_bool beaming = Manager::Get()->IsNodeBeamingDevice( homeID, nodeID );
	xmlrpc_bool routing = Manager::Get()->IsNodeRoutingDevice( homeID, nodeID );
	xmlrpc_bool security = Manager::Get()->IsNodeSecurityDevice( homeID, nodeID );
	xmlrpc_int32 maxbaudrate = Manager::Get()->GetNodeMaxBaudRate( homeID, nodeID );
	const char* nodetype = Manager::Get()->GetNodeType( homeID, nodeID).c_str();
	const char* name = Manager::Get()->GetNodeName( homeID, nodeID).c_str();
	const char* location = Manager::Get()->GetNodeLocation( homeID, nodeID).c_str();
	uint8 version = Manager::Get()->GetNodeVersion( homeID, nodeID ); 
	uint8 basicmapping = 0;
	char buffer[50];

	// Get NodeInfo information
	if ( NodeInfo* nodeInfo = GetNodeInfo( homeID, nodeID ) )
	{
		// This is a "new" node, we set basicmapping to 0 now
		nodeInfo->basicmapping = 0;

		// Convert Generic+Specific to string
		snprintf( buffer,20, "0x%02X|0x%02X", generic, specific );

		// Check if we have a mapping in our map table
		if ( MapCommandClassBasic.find(buffer) != MapCommandClassBasic.end() )
		{
			nodeInfo->basicmapping = MapCommandClassBasic[buffer];
			basicmapping = MapCommandClassBasic[buffer];
		} else {

			// We didn't find a Generic+Specifc in the table, now we check
			// for Generic only
			snprintf( buffer,20, "0x%02X", generic );

			// Check if we have a mapping in our map table
			if ( MapCommandClassBasic.find(buffer) != MapCommandClassBasic.end() )
			{
				nodeInfo->basicmapping = MapCommandClassBasic[buffer];
				basicmapping = MapCommandClassBasic[buffer];
			}
		}
	}

	// Following parameters are kept for backwards compatibility
	xmlrpc_bool sleeping = !listening;
	xmlrpc_int32 capabilities = 0; // Caps is broken into Version, BaudRate, listening, routing
	xmlrpc_int32 isecurity = 0;

	WriteLog( LogLevel_Debug, true, "NodeProtocolInfo: HomeId=%d Node=%d", homeID, nodeID );
	WriteLog( LogLevel_Debug, false, "Basic=%d", basic );
	WriteLog( LogLevel_Debug, false, "Generic=%d", generic );
	WriteLog( LogLevel_Debug, false, "Specific=%d", specific );
	WriteLog( LogLevel_Debug, false, "Type=%s", nodetype );
	if ( basicmapping > 0 ) {
		WriteLog( LogLevel_Debug, false, "Mapping=COMMAND_CLASS_BASIC maps to %s", DomoZWave_CommandClassIdName( basicmapping ) );
	}
	WriteLog( LogLevel_Debug, false, "Listening=%s", (listening)?"true":"false" );
	WriteLog( LogLevel_Debug, false, "FrequentListening=%s", (frequentlistening)?"true":"false" );
	WriteLog( LogLevel_Debug, false, "Beaming=%s", (beaming)?"true":"false" );
	WriteLog( LogLevel_Debug, false, "Routing=%s", (routing)?"true":"false" );
	WriteLog( LogLevel_Debug, false, "MaxBaudRate=%d", maxbaudrate );
	WriteLog( LogLevel_Debug, false, "Version=%d", version );
	WriteLog( LogLevel_Debug, false, "Security=%s", (security)?"true":"false" );
	WriteLog( LogLevel_Debug, false, "Name=%s", name );
	WriteLog( LogLevel_Debug, false, "Location=%s", location );

	// Re-initialize the env, else after the FIRST error, the DomoZWave is dead in the water
	xmlrpc_env_init( &env );
	xmlrpc_value* resultP = NULL;
 	xmlrpc_client_call2f(&env, clientP, url, "zwave.createnode", &resultP, "(iiiiiib)", nodeID, basic, generic, specific, capabilities, isecurity, sleeping );

	// Check if we didn't receive an error, then check if we get TRUE back (FALSE isn't good ;-))
	if ( ! fault_occurred ( "zwave.createnode", &env ) )
	{
		xmlrpc_bool bvalue;

		xmlrpc_read_bool( &env, resultP, &bvalue );

		if ( ! bvalue )
		{
			WriteLog( LogLevel_Error, true, "ERROR: In call \"zwave.createnode\" returned FALSE" );
		}
	}

	if ( resultP )
	{
		xmlrpc_DECREF( resultP );
	}
}

//-----------------------------------------------------------------------------
// <RPC_Group>
//
//-----------------------------------------------------------------------------

void RPC_Group( int homeID, int nodeID )
{
	WriteLog( LogLevel_Debug, true, "GroupEvent: HomeId=%d Node=%d", homeID, nodeID );
}

//-----------------------------------------------------------------------------
// <RPC_NodeEvent>
//
//-----------------------------------------------------------------------------

void RPC_NodeEvent( int homeID, int nodeID, ValueID valueID, int value )
{
	int instanceID = valueID.GetInstance();
	int value_no = 1;
	char dev_value[1024];

	// Instance can never be zero, we need to be backwards compatible
	if ( instanceID == 0 ) {
		instanceID = 1;
	}

	WriteLog( LogLevel_Debug, true, "NodeEvent: HomeId=%d Node=%d", homeID, nodeID );
	WriteLog( LogLevel_Debug, false, "Instance=%d", instanceID );
	WriteLog( LogLevel_Debug, false, "Type=Byte (raw value=%d)", value );
	snprintf( dev_value, 1024, "%d", value );

	if ( strcmp( dev_value, "255" ) == 0 )
	{
		strcpy( dev_value, "On" );
	}
	else { 
		strcpy( dev_value, "Off" );
	}

	WriteLog( LogLevel_Debug, false, "Value%d=%s", value_no, dev_value );

	// Re-initialize the env, else after the FIRST error, the DomoZWave is dead in the water
	xmlrpc_env_init( &env );
	xmlrpc_value* resultP = NULL;
	xmlrpc_client_call2f( &env, clientP, url, "zwave.setvalue", &resultP, "(iiiis)", homeID, nodeID, instanceID, value_no, dev_value );

	if ( ! fault_occurred ( "zwave.setvalue", &env ) )
	{
		xmlrpc_bool bvalue;

		xmlrpc_read_bool( &env, resultP, &bvalue );

		if ( ! bvalue )
		{
			WriteLog( LogLevel_Error, true, "ERROR: In call \"zwave.setvalue\" returned FALSE" );
		}
	}

	if ( resultP )
	{
		xmlrpc_DECREF( resultP );
	}
}

//-----------------------------------------------------------------------------
// <RPC_PollingEnabled>
//
//-----------------------------------------------------------------------------

void RPC_PollingEnabled( int homeID, int nodeID )
{
	WriteLog( LogLevel_Debug, true, "PollingEnabled: HomeId=%d Node=%d", homeID, nodeID );
}

//-----------------------------------------------------------------------------
// <RPC_PollingDisabled>
//
//-----------------------------------------------------------------------------

void RPC_PollingDisabled( int homeID, int nodeID )
{
	WriteLog( LogLevel_Debug, true, "PollingDisabled: HomeId=%d Node=%d", homeID, nodeID );
}

//-----------------------------------------------------------------------------
// <RPC_NodeNaming>
//
//-----------------------------------------------------------------------------

void RPC_NodeNaming( int homeID, int nodeID )
{
	WriteLog( LogLevel_Debug, true, "NodeNaming: HomeId=%d Node=%d", homeID, nodeID );
	WriteLog( LogLevel_Debug, false, "ManufacturerId=%s", Manager::Get()->GetNodeManufacturerId( homeID, nodeID ).c_str() );
	WriteLog( LogLevel_Debug, false, "ManufacturerName=%s", Manager::Get()->GetNodeManufacturerName( homeID, nodeID ).c_str() );
	WriteLog( LogLevel_Debug, false, "ProductType=%s, ProductId=%s", Manager::Get()->GetNodeProductType( homeID, nodeID ).c_str(), Manager::Get()->GetNodeProductId( homeID, nodeID ).c_str() );
	WriteLog( LogLevel_Debug, false, "ProductName=%s", Manager::Get()->GetNodeProductName( homeID, nodeID ).c_str() );
}

//-----------------------------------------------------------------------------
// <RPC_DriverReady>
//
//-----------------------------------------------------------------------------

void RPC_DriverReady( int homeID, int nodeID )
{
	//home = homeID;
	//controllerid = nodeID;

	m_structCtrl* ctrl = new m_structCtrl();

	ctrl->m_homeId = homeID;
	ctrl->m_controllerId = nodeID;
	ctrl->m_controllerAllQueried = 0;
	ctrl->m_controllerBusy = false;
	ctrl->m_nodeId = 0;

	g_allControllers.push_back( ctrl );

	WriteLog( LogLevel_Debug, true, "DriverReady: HomeId=%d Node=%d", homeID, nodeID );

	switch( Manager::Get()->GetControllerInterfaceType( homeID ) )
        {
                case Driver::ControllerInterface_Serial:
                {
			WriteLog( LogLevel_Debug, false, "ControllerInterface=Serial" );
			break;
		}
		case Driver::ControllerInterface_Hid:
		{
			WriteLog( LogLevel_Debug, false, "ControllerInterface=Hid" );
			break;
		}
		default:
		{
			WriteLog( LogLevel_Debug, false, "ControllerInterface=Unknown" );
			break;
		}
	}

	string controllerPath = Manager::Get()->GetControllerPath( homeID ); 
	WriteLog( LogLevel_Debug, false, "ControllerPath=%s", controllerPath.c_str() );

	// Re-initialize the env, else after the FIRST error, the DomoZWave is dead in the water
	xmlrpc_env_init( &env );
	xmlrpc_value* resultP = NULL;
 	xmlrpc_client_call2f( &env, clientP, url, "zwave.setids", &resultP, "(ii)", homeID, nodeID );

	// Check if we didn't receive an error, then check if we get TRUE back (FALSE isn't good ;-))
	if ( ! fault_occurred ( "zwave.setids", &env ) )
	{
		xmlrpc_bool bvalue;

		xmlrpc_read_bool( &env, resultP, &bvalue );

		if ( ! bvalue )
		{
			WriteLog( LogLevel_Error, true, "ERROR: In call \"zwave.setids\" returned FALSE" );
		}
	}

	if ( resultP )
	{
		xmlrpc_DECREF( resultP );
	}

	// Re-initialize the env, else after the FIRST error, the DomoZWave is dead in the water
	xmlrpc_env_init( &env );
	resultP = NULL;
 	xmlrpc_client_call2f( &env, clientP, url, "zwave.removenodes", &resultP, "()" );

	// Check if we didn't receive an error, then check if we get TRUE back (FALSE isn't good ;-))
	if ( ! fault_occurred ( "zwave.removenodes", &env ) )
	{
		xmlrpc_bool bvalue;

		xmlrpc_read_bool( &env, resultP, &bvalue );

		if ( ! bvalue )
		{
			WriteLog( LogLevel_Error, true, "ERROR: In call \"zwave.removenodes\" returned FALSE" );
		}
	}

	if ( resultP )
	{
		xmlrpc_DECREF( resultP );
	}
}

///////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
// <OnNotification>
// Open-ZWave calls this whenever it has a notification ready for us. 
//-----------------------------------------------------------------------------

void OnNotification
(
	Notification const* data,
	void* context
)
{
	pthread_mutex_lock( &g_criticalSection );

	switch( data->GetType() )
	{
		case Notification::Type_ValueAdded:
		{
			if ( NodeInfo* nodeInfo = GetNodeInfo( data ) )
        		{
				// Add the new value to our list
				nodeInfo->m_values.push_back( data->GetValueID() );
			}
			//RPC_ValueAdded( (int)data->GetHomeId(), (int)data->GetNodeId(), data->GetValueID(), data->GetByte() );
			RPC_ValueChanged( (int)data->GetHomeId(), (int)data->GetNodeId(), data->GetValueID(), true );

			break;
		}
		case Notification::Type_ValueRemoved:
		{
			if ( NodeInfo* nodeInfo = GetNodeInfo( data ) )
			{
				// Remove the value from out list
				for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
				{
					if ( (*it) == data->GetValueID() )
					{
						nodeInfo->m_values.erase( it );
						break;
					}
				}
			}

			RPC_ValueRemoved( (int)data->GetHomeId(), (int)data->GetNodeId(), data->GetValueID() );
			break;
		}
		case Notification::Type_NodeNaming:
		{
			RPC_NodeNaming( (int)data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_ValueChanged:
		{
			RPC_ValueChanged( (int)data->GetHomeId(), (int)data->GetNodeId(), data->GetValueID(), false );

			// Update LastSeen and DeviceState
			if ( NodeInfo* nodeInfo = GetNodeInfo( data ) )
			{
				nodeInfo->m_LastSeen = time( NULL );
				nodeInfo->m_DeviceState = DZType_Alive;
			}
			break;
		}
		case Notification::Type_Group:
		{
			RPC_Group( (int)data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_NodeNew:
		{
			RPC_NodeNew( (int)data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_NodeAdded:
		{
			NodeInfo* nodeInfo = new NodeInfo();
			nodeInfo->m_homeId = data->GetHomeId();
			nodeInfo->m_nodeId = data->GetNodeId();
			nodeInfo->m_DeviceState = DZType_Unknown;
			nodeInfo->m_LastSeen = 0;
			g_nodes.push_back( nodeInfo );
			
			RPC_NodeAdded( (int)data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_NodeRemoved:
		{
			uint32 const homeId = data->GetHomeId();
			uint8 const nodeId = data->GetNodeId();

                        for ( list<NodeInfo*>::iterator it = g_nodes.begin(); it != g_nodes.end(); ++it )
                        {
				NodeInfo* nodeInfo = *it;
				if ( ( nodeInfo->m_homeId == homeId ) && ( nodeInfo->m_nodeId == nodeId ) )
				{
					g_nodes.erase( it );
					break;
				}
			}

			RPC_NodeRemoved( (int)data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_NodeProtocolInfo:
		{
			RPC_NodeProtocolInfo( (int)data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_NodeEvent:
		{
			// Event caused by basic set or hail
			RPC_NodeEvent( (int)data->GetHomeId(), (int)data->GetNodeId(), data->GetValueID(), (int)data->GetEvent() );

			// Update LastSeen and DeviceState
			if ( NodeInfo* nodeInfo = GetNodeInfo( data ) )
			{
				nodeInfo->m_LastSeen = time( NULL );
				nodeInfo->m_DeviceState = DZType_Alive;
			}
			break;
		}
		case Notification::Type_PollingEnabled:
		{
			RPC_PollingEnabled( (int)data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_PollingDisabled:
		{
			RPC_PollingDisabled( (int)data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_DriverReady:
		{
			RPC_DriverReady( (int)data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_AllNodesQueried:
		case Notification::Type_AwakeNodesQueried:
		case Notification::Type_AllNodesQueriedSomeDead:
		{
			m_structCtrl* ctrl = GetControllerInfo( (int)data->GetHomeId() );

			if ( data->GetType() == Notification::Type_AllNodesQueried ) WriteLog( LogLevel_Debug, true, "AllNodesQueried: HomeId=%d", (int)data->GetHomeId() );
			if ( data->GetType() == Notification::Type_AwakeNodesQueried ) WriteLog( LogLevel_Debug, true, "AwakeNodesQueried: HomeId=%d", (int)data->GetHomeId() );
			if ( data->GetType() == Notification::Type_AllNodesQueriedSomeDead ) WriteLog( LogLevel_Debug, true, "AllNodesQueriedSomeDead: HomeId=%d", (int)data->GetHomeId() );

			if ( ctrl->m_controllerAllQueried == 0 )
			{ 
				Manager::Get()->WriteConfig( (int)data->GetHomeId() );

				// Re-initialize the env, else after the FIRST error, the DomoZWave is dead in the water
				xmlrpc_env_init( &env );
				xmlrpc_value* resultP = NULL;
				pthread_mutex_unlock( &g_criticalSection );
 				xmlrpc_client_call2f( &env, clientP, url, "zwave.allqueried", &resultP, "()" );

				// Check if we didn't receive an error, then check if we get TRUE back (FALSE isn't good ;-))
				if ( ! fault_occurred ( "zwave.allqueried", &env ) )
				{
					xmlrpc_bool bvalue;

					xmlrpc_read_bool( &env, resultP, &bvalue );

					if ( ! bvalue )
					{
						WriteLog( LogLevel_Error, true, "ERROR: In call \"zwave.allqueried\" returned FALSE" );
					}
				}

				if ( resultP )
				{
					xmlrpc_DECREF( resultP );
				}
			}
			else
			{
				// If we got 2 or more a AllQueried, then there is something really wrong somewhere
				if ( ctrl->m_controllerAllQueried > 1 )
				{
					WriteLog( LogLevel_Error, true, "ERROR: AllNodesQueried happened %d times (max should be 2)", ctrl->m_controllerAllQueried );
				}
			}

			ctrl->m_controllerAllQueried++;
			break;
		}
		case Notification::Type_CreateButton:
		{
			WriteLog( LogLevel_Debug, true, "CreateButton: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId() );
			WriteLog( LogLevel_Debug, false, "ButtonId=%d", (int)data->GetButtonId() );
			break;
		}	
		case Notification::Type_DeleteButton:
		{
			WriteLog( LogLevel_Debug, true, "DeleteButton: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId() );
			WriteLog( LogLevel_Debug, false, "ButtonId=%d", (int)data->GetButtonId() );
			break;
		}	
		case Notification::Type_ButtonOn:
		{
			WriteLog( LogLevel_Debug, true, "ButtonOn: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId() );
			WriteLog( LogLevel_Debug, false, "ButtonId=%d", (int)data->GetButtonId() );
			break;
		}	
		case Notification::Type_ButtonOff:
		{
			WriteLog( LogLevel_Debug, true, "ButtonOff: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId() );
			WriteLog( LogLevel_Debug, false, "ButtonId=%d", (int)data->GetButtonId() );
			break;
		}	
		case Notification::Type_DriverFailed:
		{
			WriteLog( LogLevel_Error, true, "ERROR: DriverFailed !" );
			break;
		}
		case Notification::Type_DriverReset:
		{
			WriteLog( LogLevel_Error, true, "ERROR: DriverReset !" );
			// Clear the internal node information and send xmlrpc to DomotiGa to remove all nodes
			// The OnNotification will (re)send all the information again
			break;
		}
		case Notification::Type_EssentialNodeQueriesComplete:
		{
			WriteLog( LogLevel_Debug, true, "EssentialNodeQueriesComplete: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId() );

			// We require the configuration parameters when the device is essentially queried
			// This still need to be optimized, because we do it with every startup now
			Manager::Get()->RequestAllConfigParams( data->GetHomeId(), data->GetNodeId() );
			break;
		}
		case Notification::Type_NodeQueriesComplete:
		{
			WriteLog( LogLevel_Debug, true, "NodeQueriesComplete: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_ValueRefreshed:
		{
			WriteLog( LogLevel_Debug, true, "ValueRefreshed: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_SceneEvent:
		{
			WriteLog( LogLevel_Debug, true, "SceneEvent: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_Notification:
		{
			switch ( data->GetNotification() )
			{
				case Notification::Code_MsgComplete:
				{
					WriteLog( LogLevel_Debug, true, "MsgComplete: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId() );

					// Update LastSeen and DeviceState
					if ( NodeInfo* nodeInfo = GetNodeInfo( data ) )
					{
						nodeInfo->m_LastSeen = time( NULL );
						nodeInfo->m_DeviceState = DZType_Alive;
					}
					break;
				}
				case Notification::Code_Timeout:
				{
					WriteLog( LogLevel_Debug, true, "Code_Timeout: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId() );
					break;
				}
				case Notification::Code_NoOperation:
				{
					WriteLog( LogLevel_Debug, true, "Code_NoOperation: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId() );
					break;
				}
				case Notification::Code_Awake:
				{
					WriteLog( LogLevel_Debug, true, "Code_Awake: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId() );

					// Update LastSeen and DeviceState
					if ( NodeInfo* nodeInfo = GetNodeInfo( data ) )
					{
						nodeInfo->m_LastSeen = time( NULL );
						nodeInfo->m_DeviceState = DZType_Awake;
					}
					break;
				}
				case Notification::Code_Sleep:
				{
					WriteLog( LogLevel_Debug, true, "Code_Sleep: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId() );
					break;
				}
				case Notification::Code_Dead:
				{
					WriteLog( LogLevel_Debug, true, "Code_Dead: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId() );
					break;
				}
				case Notification::Code_Alive:
				{
					WriteLog( LogLevel_Debug, true, "Code_Alive: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId() );

					// Update LastSeen and DeviceState
					if ( NodeInfo* nodeInfo = GetNodeInfo( data ) )
					{
						nodeInfo->m_LastSeen = time( NULL );
						nodeInfo->m_DeviceState = DZType_Alive;
					}
					break;
				}
				default:
				{
					WriteLog( LogLevel_Debug, true, "Notification: HomeId=%d Node=%d, Unknown: %d", (int)data->GetHomeId(), (int)data->GetNodeId(), data->GetNotification() );
					break;
				}
			}
		}
		default:
		break;
	}

	pthread_mutex_unlock( &g_criticalSection );
}

//-----------------------------------------------------------------------------
// <OnControllerUpdate>
// Open-ZWave calls this whenever the controller state changes.
//-----------------------------------------------------------------------------

void OnControllerUpdate( Driver::ControllerState cs, Driver::ControllerError err, void *ct )
{
	m_structCtrl *ctrl = (m_structCtrl *)ct;

	// Possible ControllerState values:
	// ControllerState_Normal     - No command in progress.
	// ControllerState_Starting   - The command is starting.
	// ControllerState_Cancel     - The command was cancelled.
	// ControllerState_Error      - Command invocation had error(s) and was aborted.
	// ControllerState_Sleeping   - Controller command is on a sleep queue wait for device.
	// ControllerState_Waiting    - Controller is waiting for a user action.
	// ControllerState_InProgress - The controller is communicating with the other device to carry out the command.
	// ControllerState_Completed  - The command has completed successfully.
	// ControllerState_Failed     - The command has failed.
	// ControllerState_NodeOK     - Used only with ControllerCommand_HasNodeFailed to indicate that the controller thinks the node is OK.
	// ControllerState_NodeFailed - Used only with ControllerCommand_HasNodeFailed to indicate that the controller thinks the node has failed.

	pthread_mutex_lock( &g_criticalSection );

	switch (cs) {
		case Driver::ControllerState_Normal:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=%d - Normal - no command in progress", ctrl->m_homeId );
			ctrl->m_controllerBusy = false;
			break;
		}
		case Driver::ControllerState_Starting:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=%d - Starting - the command is starting", ctrl->m_homeId );
			break;
		}
		case Driver::ControllerState_Cancel:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=%d - Cancel - the command was cancelled", ctrl->m_homeId );
			break;
		}
		case Driver::ControllerState_Error:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=%d - Error - command invocation had error(s) and was aborted", ctrl->m_homeId );
			break;
		}
		case Driver::ControllerState_Sleeping:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=%d - Sleeping - controller command is on a sleep queue wait for device", ctrl->m_homeId );
			break;
		}
		case Driver::ControllerState_Waiting:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=%d - Waiting - waiting for a user action", ctrl->m_homeId );
			break;
		}
		case Driver::ControllerState_InProgress:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=%d - InProgress - communicating with the other device", ctrl->m_homeId );
			break;
		}
		case Driver::ControllerState_Completed:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=%d - Completed - command has completed successfully", ctrl->m_homeId );
			ctrl->m_controllerBusy = false;
			break;
		}
		case Driver::ControllerState_Failed:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=%d - Failed - command has failed", ctrl->m_homeId );
			ctrl->m_controllerBusy = false;
			break;
		}
		case Driver::ControllerState_NodeOK:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=%d - NodeOK - the node is OK", ctrl->m_homeId );
			ctrl->m_controllerBusy = false;

			// Store Node State

			break;
		}
		case Driver::ControllerState_NodeFailed:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=%d - NodeFailed - the node has failed", ctrl->m_homeId );
			ctrl->m_controllerBusy = false;

			// Store Node State

			break;
		}
		default:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=%d - unknown response", ctrl->m_homeId );
			ctrl->m_controllerBusy = false;
			break;
		}
	}

	// Additional possible error information
	switch (err) {
		case Driver::ControllerError_None:
		{
			//WriteLog( LogLevel_Debug, false, "Error=None" );
			break;
		}
		case Driver::ControllerError_ButtonNotFound:
		{
			WriteLog( LogLevel_Debug, false, "Error=Button Not Found" );
			break;
		}
		case Driver::ControllerError_NodeNotFound:
		{
			WriteLog( LogLevel_Debug, false, "Error=Node Not Found" );
			break;
		}
		case Driver::ControllerError_NotBridge:
		{
			WriteLog( LogLevel_Debug, false, "Error=Not a Bridge" );
			break;
		}
		case Driver::ControllerError_NotPrimary:
		{
			WriteLog( LogLevel_Debug, false, "Error=Not Primary Controller" );
			break;
		}
		case Driver::ControllerError_IsPrimary:
		{
			WriteLog( LogLevel_Debug, false, "Error=Is Primary Controller" );
			break;
		}
		case Driver::ControllerError_NotSUC:
		{
			WriteLog( LogLevel_Debug, false, "Error=Not Static Update Controller" );
			break;
		}
		case Driver::ControllerError_NotSecondary:
		{
			WriteLog( LogLevel_Debug, false, "Error=Not Secondary Controller" );
			break;
		}
		case Driver::ControllerError_NotFound:
		{
			WriteLog( LogLevel_Debug, false, "Error=Not Found" );
			break;
		}
		case Driver::ControllerError_Busy:
		{
			WriteLog( LogLevel_Debug, false, "Error=Controller Busy" );
			break;
		}
		case Driver::ControllerError_Failed:
		{
			WriteLog( LogLevel_Debug, false, "Error=Failed" );
			break;
		}
		case Driver::ControllerError_Disabled:
		{
			WriteLog( LogLevel_Debug, false, "Error=Disabled" );
			break;
		}
		case Driver::ControllerError_Overflow:
		{
			WriteLog( LogLevel_Debug, false, "Error=Overflow" );
			break;
		}
		default:
		{
			WriteLog( LogLevel_Debug, false, "Error=Unknown error (%d)", err );
			break;
		}
	}

	pthread_mutex_unlock( &g_criticalSection );

	// If the controller isn't busy anymore and we still got something in the queue, fire off the command now
	if ( ctrl->m_controllerBusy == false )
	{
		if ( ! ctrl->m_cmd.empty() )
		{
			bool response;
			m_cmdItem cmd;

			cmd = ctrl->m_cmd.front();
			ctrl->m_cmd.pop_front();

			// Now start the BeginControllerCommand with the 2 supported options
			switch( cmd.m_command ) {
				case Driver::ControllerCommand_HasNodeFailed:
				{
					ctrl->m_controllerBusy = true;
					WriteLog( LogLevel_Debug, true, "DomoZWave_HasNodeFailed: HomeId=%d Node=%d (Queued)", ctrl->m_homeId, cmd.m_nodeId );
					response = Manager::Get()->BeginControllerCommand( ctrl->m_homeId, Driver::ControllerCommand_HasNodeFailed, OnControllerUpdate, ctrl, true, cmd.m_nodeId );
		                        WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
					break;
				}
				case Driver::ControllerCommand_RequestNodeNeighborUpdate:
				{
					ctrl->m_controllerBusy = true;
					WriteLog( LogLevel_Debug, true, "DomoZWave_RequestNodeNeighborUpdate: HomeId=%d Node=%d (Queued)", ctrl->m_homeId, cmd.m_nodeId );
					response = Manager::Get()->BeginControllerCommand( ctrl->m_homeId, Driver::ControllerCommand_RequestNodeNeighborUpdate, OnControllerUpdate, ctrl, false, cmd.m_nodeId );
		                        WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
					break;
				}
				default:
				{
					WriteLog( LogLevel_Debug, true, "DomoZWave_OnControllerUpdate: HomeId=%d Node=%d (Queued)", ctrl->m_homeId, cmd.m_nodeId );
					WriteLog( LogLevel_Debug, false, "ERROR: Invalid Command %d", cmd.m_command );
					break;
				}
			}
		}
	}
}

///////////////////////////////////////////////////////////////////////////////
// C style bindings are required since we call these functions from gambas.
///////////////////////////////////////////////////////////////////////////////

extern "C" {

//-----------------------------------------------------------------------------
// <DomoZWave_HomeIdPresent>
//
//-----------------------------------------------------------------------------

bool DomoZWave_HomeIdPresent( int32 home, const char* _param )
{
	// home has to be none-zero
	if ( home == 0 ) {
		WriteLog(LogLevel_Error, false, "ERROR: %s - HomeId=0, can't continue", _param);
		return false;
	} else {

		if ( m_structCtrl* ctrl = GetControllerInfo( home ) )
		{
			// The home is in the g_allController list
			ctrl = ctrl;
			return true;
		}
		else
		{
			// The home is in the g_allController list
			return false;
		}
	}
}

//-----------------------------------------------------------------------------
// <DomoZWave_Init>
// Initializes the Open-Zwave Wrapper
// configdir = ~/domotiga/wrappers/domozwave/open-zwave/config (default)
// zwdir = ~/domotiga/wrappers/domozwave (default)
// logname = ~/domotiga/logs/domozwave- or ~/domotiga/logs/server-domozwave- (default)
// rpcPort = 9009 (default)
// enableLog = True/False
// enableOZWLog = True/False
// polltime = <integer> in milliseconds
//
// NOTE: You need to call DomoZWave_AddSerialPort to complete the initialization
//-----------------------------------------------------------------------------

void DomoZWave_Init( const char* configdir, const char* zwdir, const char* logname, int rpcPort, bool enableLog, bool enableOZWLog, int polltime )
{
	// Get a timestamp for Year and Month
	struct timeval tv;
	gettimeofday(&tv, NULL);
	struct tm *tm;
	tm = localtime( &tv.tv_sec );

	// Clear the current list of controllers
	g_allControllers.clear();
	serialPortName.clear();

	// create a timestamp string with Year and Month
	char localt[100];
	snprintf( localt, sizeof(localt), "%04d-%02d", tm->tm_year + 1900, tm->tm_mon + 1 );

	logfile_prefix = logname;
	logfile_name = logfile_prefix;
	logfile_name.append(localt);
	logfile_name.append(".log");

	// Call the InitVars procedure to initialize all local variables
	InitVars( );

	// Store debugging option, this only is valid for the wrapper. The open-zwave has its own configuration
	debugging = enableLog;

	// Open the logfile, required for errors and debug
	logfile.open( logfile_name.c_str(), ios::app );
	if ( ! logfile.is_open() )
	{
		cout << OZW_datetime << " [DomoZwave] " << "***FATAL*** Unable to write to \"" << logfile_name << "\"" << endl;
	}

	WriteLog( LogLevel_Debug, true, "DomoZWave_Init: Initializing Open-ZWave Wrapper" );
	WriteLog( LogLevel_Debug, false, "%s", domozwave_vers );
	WriteLog( LogLevel_Debug, false, "%s", ozw_vers );

	pthread_mutexattr_t mutexattr;

	pthread_mutexattr_init ( &mutexattr );
	pthread_mutexattr_settype( &mutexattr, PTHREAD_MUTEX_RECURSIVE );
	pthread_mutex_init( &g_criticalSection, &mutexattr );
	pthread_mutexattr_destroy( &mutexattr );

	sprintf( url, "http://localhost:%d", rpcPort ); 

	Options::Create( configdir, zwdir, "" );
	Options::Get()->AddOptionBool( "AppendLogFile", false );
	Options::Get()->AddOptionBool( "ConsoleOutput", false );

	if ( enableOZWLog )
	{
		Options::Get()->AddOptionInt( "SaveLogLevel", LogLevel_Detail );
	  	Options::Get()->AddOptionInt( "QueueLogLevel", LogLevel_Debug );
	   	Options::Get()->AddOptionInt( "DumpTriggerLevel", LogLevel_Error );
	}

	Options::Get()->AddOptionInt( "PollInterval", polltime );
	Options::Get()->AddOptionBool( "IntervalBetweenPolls", true );
	Options::Get()->AddOptionBool( "SuppressValueRefresh", false );
	Options::Get()->AddOptionBool( "PerformReturnRoutes", false );

	Options::Get()->Lock();

	Manager::Create();
	Log::SetLoggingState( debugging );

	Manager::Get()->AddWatcher( OnNotification, NULL );

 	// Initialize our error-handling environment.
 	xmlrpc_env_init( &env );
 	xmlrpc_client_setup_global_const( &env );
 	xmlrpc_client_create( &env, XMLRPC_CLIENT_NO_FLAGS, "DomoZWaveClient", "1.0", NULL, 0, &clientP );
	if ( fault_occurred( "xml_create", &env ) )
	{
		return;
	}
}


//-----------------------------------------------------------------------------
// <DomoZWave_AddSerialPort>
//-----------------------------------------------------------------------------

void DomoZWave_AddSerialPort( const char* serialPort )
{
	string Name;

	Manager::Get()->AddDriver( serialPort );
	// Store the serialPort used
	Name = serialPort; 

	serialPortName.push_back( Name );
}

//-----------------------------------------------------------------------------
// <DomoZWave_Destroy>
// Stops the Open-Zwave wrapper
//-----------------------------------------------------------------------------

void DomoZWave_Destroy( )
{
	pthread_mutex_lock( &g_criticalSection );

	for ( list<string>::iterator it = serialPortName.begin(); it != serialPortName.end(); ++it )
	{
		string Name = *it;
		Manager::Get()->RemoveDriver( Name );
	}

	Manager::Get()->RemoveWatcher( OnNotification, NULL );

	//cout << OZW_datetime << "Destroyed xmlrpc" << endl;
	Manager::Get()->Destroy();
	//cout << OZW_datetime << "Destroyed manager" << endl;
	Options::Get()->Destroy();
	//cout << OZW_datetime << "Destroyed options" << endl;

	pthread_mutex_unlock( &g_criticalSection );
	pthread_mutex_destroy( &g_criticalSection );

	serialPortName.clear();

	// Clean up our error-handling environment. 
	xmlrpc_env_clean( &env );

	xmlrpc_client_destroy( clientP );

	WriteLog( LogLevel_Debug, true, "DomoZWave_Destroy: Destroyed Open-ZWave Wrapper" );

	// Close the logfile now
	if ( logfile.is_open() )
	{
		logfile.close();
	}

	// Clear the current list of controllers
	g_allControllers.clear();
}

//-----------------------------------------------------------------------------
// <DomoZWave_Version>
// Returns the readable open-zwave wrapper revision
//-----------------------------------------------------------------------------

const char* DomoZWave_Version( )
{
	return domozwave_vers;
}

//-----------------------------------------------------------------------------
// <DomoZWave_OZWVersion>
// Returns the readable open-zwave revision
//-----------------------------------------------------------------------------

const char* DomoZWave_OZWVersion( )
{
	return ozw_vers;
}

//-----------------------------------------------------------------------------
// <DomoZWave_WriteConfig>
// Write the zwcfg*xml. Normally not required, because it is written when all
// the nodes are queried and when wrapper exits
//-----------------------------------------------------------------------------

void DomoZWave_WriteConfig( int32 home )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_WriteConfig" ) == false ) return;
	WriteLog( LogLevel_Debug, true, "DomoZWave_WriteConfig: HomeId=%d", home );
	Manager::Get()->WriteConfig( home );
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetLibraryVersion>
//
//-----------------------------------------------------------------------------

const char* DomoZWave_GetLibraryVersion( int32 home )
{
	string LibraryVersion;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetLibraryVersion" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetLibraryVersion: HomeId=%d", home );
	LibraryVersion =  Manager::Get()->GetLibraryVersion( home );
	WriteLog( LogLevel_Debug, false, "LibraryVersion=%s", LibraryVersion.c_str() );
	return LibraryVersion.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetLibraryTypeName>
//
//-----------------------------------------------------------------------------

const char* DomoZWave_GetLibraryTypeName( int32 home )
{
	string LibraryTypeName;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetLibraryTypeName" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetLibraryTypeName: HomeId=%d", home );
	LibraryTypeName = Manager::Get()->GetLibraryTypeName( home );
	WriteLog( LogLevel_Debug, false, "LibraryTypeName=%s", LibraryTypeName.c_str() );
	return LibraryTypeName.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_ControllerType>
// Retrieves the Z-Wave controller type, possible values are:
// Primary or Secondary and possible SUC and/or Bridge mode
//-----------------------------------------------------------------------------

const char* DomoZWave_ControllerType( int32 home )
{
	string ctype;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_ControllerType" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_ControllerType: HomeId=%d", home );

	if ( Manager::Get()->IsStaticUpdateController ( home ) )
	{
		ctype = "SUC";
	}
	else
	{
		if ( Manager::Get()->IsPrimaryController ( home ) )
		{
			ctype = "Primary";
		}
		else
		{
			ctype = "Slave";
		}
	}

	WriteLog( LogLevel_Debug, false, "ControllerType=%s", ctype.c_str() );
	return ctype.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_EnablePolling>
// Enable polling of the devices by open-zwave. This only works for basic values,
// values like kWh, Temperature, etc this doesn't work (then DynamicState need
// to be used)
//-----------------------------------------------------------------------------

void DomoZWave_EnablePolling( int32 home, int32 node, int32 polltime )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_EnablePolling" ) == false ) return;

	WriteLog( LogLevel_Debug, true, "DomoZWave_EnablePolling: HomeId=%d Node=%d", home, node );

	if ( Manager::Get()->GetNodeBasic( home, node ) < 0x03 )
	{	
		WriteLog( LogLevel_Debug, false, "Polltime=None (node is a controller)" );
		return;
	}

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
		// If we got basic mapping, then poll the "right" commandclass directly
		uint8 cmdclass;

		if ( nodeInfo->basicmapping > 0 )
		{
			cmdclass = nodeInfo->basicmapping;
		}
		else
		{
			cmdclass = COMMAND_CLASS_BASIC;
		}

		bool found = false;

	   	// Mark the basic command class values for polling
		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
 			ValueID v = *it;
			if ( v.GetCommandClassId() == cmdclass )
			{
				// It works fine, EXCEPT for MULTILEVEL, then we need to ignore all except the first one
				if ( v.GetCommandClassId() == COMMAND_CLASS_SWITCH_MULTILEVEL )
				{
					if ( v.GetIndex() != 0 )
					{
						continue;
					}
				}

				Manager::Get()->EnablePoll( *it, 2 );

				if ( found == false )
				{
					WriteLog( LogLevel_Debug, false, "Polltime=%d", polltime );
					found = true;
				}
			}
		}

		if ( found == false )
		{
			WriteLog( LogLevel_Debug, false, "Polltime=None (node doesn't have COMMAND_CLASS_BASIC)" );
		}
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "Polltime=None (node doesn't exist)" );
	}
}

//-----------------------------------------------------------------------------
// <DomoZWave_DisablePolling>
// Disable automatic polling of basic values from a node
//-----------------------------------------------------------------------------

void DomoZWave_DisablePolling( int32 home, int32 node )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_DisablePolling" ) == false ) return;

	WriteLog( LogLevel_Debug, true, "DomoZWave_DisablePolling: HomeId=%d Node=%d", home, node );

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
	   	// disable polling for all values of this node
		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			// Check if the ValueID is polled, to prevent warnings in OZW_Log.txt
			if ( Manager::Get()->isPolled( *it ) )
			{
				Manager::Get()->DisablePoll( *it );	
			}
		}
	}
}

//-----------------------------------------------------------------------------
// <GetNodeQueryStage>
// Retrieves the query stage of a node
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeQueryStage( int32 home, int32 node )
{
	string QueryStage;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeQueryStage" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeQueryStage: HomeId=%d Node=%d", home, node );
	QueryStage = Manager::Get()->GetNodeQueryStage( home, node );
	WriteLog( LogLevel_Debug, false, "QueryStage=%s", QueryStage.c_str() );
	return QueryStage.c_str();

}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeManufacturerName>
// Retrieves the manufacturer name of a device
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeManufacturerName( int32 home, int32 node )
{
	string ManufacturerName;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeManufacturerName" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeManufacturerName: HomeId=%d Node=%d", home, node );
	ManufacturerName = Manager::Get()->GetNodeManufacturerName( home, node );
	WriteLog( LogLevel_Debug, false, "ManufacturerName=%s", ManufacturerName.c_str() );
	return ManufacturerName.c_str();

}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeProductName>
// Retrieves the product name of a device
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeProductName( int32 home, int32 node )
{
	string ProductName;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeProductName" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeProductName: HomeId=%d Node=%d", home, node );
	ProductName = Manager::Get()->GetNodeProductName( home, node );
	WriteLog( LogLevel_Debug, false, "ProductName=%s", ProductName.c_str() );
	return ProductName.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeName>
// Get the node name, this value isn't retrieved from the device itself. This can
// be set in the zwcfg*xml. We aren't using it (yet)
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeName( int32 home, int32 node )
{
	string NodeName;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeName" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeName: HomeId=%d Node=%d", home, node );
	NodeName = Manager::Get()->GetNodeName( home, node );
	WriteLog( LogLevel_Debug, false, "NodeName=%s", NodeName.c_str() );
	return NodeName.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeLocation>
// Get the node location information, this is also not retrieved from the device.
// This can be set in the zwcfg*xml. We aren't using it.
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeLocation( int32 home, int32 node )
{
	string NodeLocation;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeLocation" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeLocation: HomeId=%d Node=%d", home, node );
	NodeLocation = Manager::Get()->GetNodeLocation( home, node );
	WriteLog( LogLevel_Debug, false, "NodeLocation=%s", NodeLocation.c_str() );
	return NodeLocation.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeManufacturerId>
// Get the manufacturer id of the device, normally not too interesting
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeManufacturerId( int32 home, int32 node )
{
	string ManufacturerId;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeManufacturerId" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeManufacturerId: HomeId=%d Node=%d", home, node );
	ManufacturerId = Manager::Get()->GetNodeManufacturerId( home, node );
	WriteLog( LogLevel_Debug, false, "ManufacturerId=%s", ManufacturerId.c_str() );
	return ManufacturerId.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeProductType>
// Get the product type id of the device
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeProductType( int32 home, int32 node )
{
	string ProductType;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeProductType" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeProductType: HomeId=%d Node=%d", home, node );
	ProductType = Manager::Get()->GetNodeProductType( home, node );
	WriteLog( LogLevel_Debug, false, "ProductType=%s", ProductType.c_str() );
	return ProductType.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeProductId>
// Get the product id of the device
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeProductId( int32 home, int32 node )
{
	string ProductId;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeProductId" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeProductId: HomeId=%d Node=%d", home, node );
	ProductId = Manager::Get()->GetNodeProductId( home, node );
	WriteLog( LogLevel_Debug, false, "ProductId=%s",ProductId.c_str() );
	return ProductId.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetNodeManufacturerName>
//
//-----------------------------------------------------------------------------

void DomoZWave_SetNodeManufacturerName( int32 home, int32 node, const char* manufacturerName )
{
	string NewManufacturerName(manufacturerName);

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetNodeManufacturerName" ) == false ) return;
	WriteLog( LogLevel_Debug, true, "DomoZWave_SetNodeManufacturerName: HomeId=%d Node=%d", home, node );
	WriteLog( LogLevel_Debug, false, "New ManufacturerName=%s", manufacturerName );
	Manager::Get()->SetNodeManufacturerName( home, (uint8)node, NewManufacturerName );
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetNodeProductName>
//
//-----------------------------------------------------------------------------

void DomoZWave_SetNodeProductName( int32 home, int32 node, const char* productName )
{
	string NewProductName(productName);

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetNodeProductName" ) == false ) return;
	WriteLog( LogLevel_Debug, true, "DomoZWave_SetNodeProductName: HomeId=%d Node=%d", home, node );
	WriteLog( LogLevel_Debug, false, "New ProductName=%s", productName );
	Manager::Get()->SetNodeProductName( home, (uint8)node, NewProductName );
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetNodeName>
//
//-----------------------------------------------------------------------------

void DomoZWave_SetNodeName( int32 home, int32 node, const char* nodeName )
{
	string NewNodeName(nodeName);

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetNodeName" ) == false ) return;
	WriteLog( LogLevel_Debug, true, "DomoZWave_SetNodeName: HomeId=%d Node=%d", home, node );
	WriteLog( LogLevel_Debug, false, "New NodeName=%s", nodeName );
	Manager::Get()->SetNodeName( home, (uint8)node, NewNodeName );
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetNodeLocation>
//
//-----------------------------------------------------------------------------

void DomoZWave_SetNodeLocation( int32 home, int32 node, const char* nodeLocation )
{
	string NewNodeLocation(nodeLocation);

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetNodeLocation" ) == false ) return;
	WriteLog( LogLevel_Debug, true, "DomoZWave_SetNodeLocation: HomeId=%d Node=%d", home, node );
	WriteLog( LogLevel_Debug, false, "New NodeLocation=%s", nodeLocation );
	Manager::Get()->SetNodeLocation( home, (uint8)node, NewNodeLocation );
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeLibraryVersion>
// Retrieves the Library Version information of the node (if available)
// NOTE: It can be required to first poll the version information before it is returned here
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeLibraryVersion( int32 home, int32 node )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeLibraryVersion" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeLibraryVersion: HomeId=%d Node=%d", home, node );

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
		// Find the COMMAND_CLASS_VERSION
		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			if ( v.GetCommandClassId() == COMMAND_CLASS_VERSION )
			{
				if ( Manager::Get()->GetValueLabel( v ) == "Library Version" )
				{
					string string_value;
					Manager::Get()->GetValueAsString( v, &string_value );
					return string_value.c_str();
				}
			}
		}

		return "";
	}
	else
	{
		return "";
	}
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeProtocolVersion>
// Retrieves the Protocol Version information of the node (if available)
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeProtocolVersion( int32 home, int32 node )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeProtocolVersion" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeProtocolVersion: HomeId=%d Node=%d", home, node );

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
		// Find the COMMAND_CLASS_VERSION
		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			if ( v.GetCommandClassId() == COMMAND_CLASS_VERSION )
			{
				if ( Manager::Get()->GetValueLabel( v ) == "Protocol Version" )
				{
					string string_value;
					Manager::Get()->GetValueAsString( v, &string_value );
					return string_value.c_str();
				}
			}
		}

		return "";
	}
	else
	{
		return "";
	}
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeApplicationVersion>
// Retrieves the Application Version information of the node (if available)
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeApplicationVersion( int32 home, int32 node )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeApplicationVersion" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeApplicationVersion: HomeId=%d Node=%d", home, node );

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
		// Find the COMMAND_CLASS_VERSION
		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			if ( v.GetCommandClassId() == COMMAND_CLASS_VERSION )
			{
				if ( Manager::Get()->GetValueLabel( v ) == "Application Version" )
				{
					string string_value;
					Manager::Get()->GetValueAsString( v, &string_value );
					return string_value.c_str();
				}
			}
		}

		return "";
	}
	else
	{
		return "";
	}
}

//-----------------------------------------------------------------------------
// <DomoZWave_RequestNodeState>
//
//-----------------------------------------------------------------------------

bool DomoZWave_RequestNodeState( int32 home, int32 node )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RequestNodeState" ) == false ) return false;
	WriteLog( LogLevel_Debug, true, "DomoZWave_RequestNodeState: HomeId=%d Node=%d", home, node );
	return Manager::Get()->RequestNodeState( home, node );
}

//-----------------------------------------------------------------------------
// <DomoZWave_RequestNodeDynamic>
//
//-----------------------------------------------------------------------------

bool DomoZWave_RequestNodeDynamic( int32 home, int32 node )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RequestNodeDynamic" ) == false ) return false;
	WriteLog( LogLevel_Debug, true, "DomoZWave_RequestNodeDynamic: HomeId=%d Node=%d", home, node );
	return Manager::Get()->RequestNodeDynamic( home, node );
}

//-----------------------------------------------------------------------------
// <DomoZWave_RequestNodeNeighborUpdate>
// Request the node to update its neighborhood, to optimize z-wave commands
// through the network (mash network)
//-----------------------------------------------------------------------------

bool DomoZWave_RequestNodeNeighborUpdate( int32 home, int32 node, bool addqueue = false )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RequestNodeNeighborUpdate" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_RequestNodeNeighborUpdate: HomeId=%d Node=%d", home, node );

	if ( addqueue )
	{
		if ( ctrl->m_controllerBusy == false )
		{
			// Send the request - this is the first one
			ctrl->m_nodeId = node;
			ctrl->m_controllerBusy = true;

			response = Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_RequestNodeNeighborUpdate, OnControllerUpdate, ctrl, false, node );
			WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
		}
		else
		{
			// Queue up the request
			m_cmdItem cmd;
			bool toqueue;

			cmd.m_command = Driver::ControllerCommand_RequestNodeNeighborUpdate;
			cmd.m_nodeId = node;
			cmd.m_time = time( NULL );
			toqueue = true;

			// Check if the command is already in the queue, then don't add
			for ( list<m_cmdItem>::iterator it = ctrl->m_cmd.begin(); it != ctrl->m_cmd.end(); ++it )
			{
				m_cmdItem v = *it;

				if ( ( v.m_command == Driver::ControllerCommand_RequestNodeNeighborUpdate ) && ( v.m_nodeId = node ) )
				{
					toqueue = false;
				}	
			}

			if ( toqueue )
			{
				ctrl->m_cmd.push_back( cmd );
				WriteLog( LogLevel_Debug, false, "Return=Queued" );
			}
			else
			{
				WriteLog( LogLevel_Debug, false, "Return=Duplicate (Not Queued)" );
			}

			response = true;
		}

		return response;
	}
	else
	{
		// Only allows it when the controller isn't busy
		if ( ctrl->m_controllerBusy == false )
		{
			ctrl->m_nodeId = node;
			ctrl->m_controllerBusy = true;

			response = Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_RequestNodeNeighborUpdate, OnControllerUpdate, ctrl, false, node );
		}
		else
		{
			response = false;
		}

		WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
		return response;
	}
}

//-----------------------------------------------------------------------------
// <DomoZWave_RefreshNodeInfo>
// Triggers the open-zwave to refresh the node information, like it has been
// added just to the z-wave network. Normally not required to be executed.
//-----------------------------------------------------------------------------

bool DomoZWave_RefreshNodeInfo( int32 home, int32 node )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RefreshNodeInfo" ) == false ) return false;
	WriteLog( LogLevel_Debug, true, "DomoZWave_RefreshNodeInfo: HomeId=%d Node=%d", home, node );
	response = Manager::Get()->RefreshNodeInfo( home, node );
	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"true":"false" );
	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_RequestNodeVersion>
// Request the open-zwave to update the node version information (if applicable)
// Library, Protocol and Application version can be updated
//-----------------------------------------------------------------------------

bool DomoZWave_RequestNodeVersion( int32 home, int32 node )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RequestNodeVersion" ) == false ) return false;
	WriteLog( LogLevel_Debug, true, "DomoZWave_RequestNodeVersion: HomeId=%d Node=%d", home, node );

	response = false;

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			// Find the versions of this node
			if ( v.GetCommandClassId() == COMMAND_CLASS_VERSION )
			{
				Manager::Get()->RefreshValue( v );
				response = true;
			}
		}
	}

	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"true":"false" );
	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_RequestNodeMeter>
// Request the open-zwave to update the node meter (Watt/kWh) information (if applicable)
//-----------------------------------------------------------------------------

bool DomoZWave_RequestNodeMeter( int32 home, int32 node )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RequestNodeMeter" ) == false ) return false;
	WriteLog( LogLevel_Debug, true, "DomoZWave_RequestNodeMeter: HomeId=%d Node=%d", home, node );

	response = false;

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			// Find the versions of this node
			if ( v.GetCommandClassId() == COMMAND_CLASS_METER )
			{
				Manager::Get()->RefreshValue( v );
				response = true;
			}
		}
	}

	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"true":"false" );
	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetValue>
// Set the On, Off or Dim xyz of a device and instance
// 0=Off or 255=On - COMMAND_CLASS_SWITCH_BINARY
// <other>=Dim & COMMAND_CLASS_SWITCH_MULTILEVEL 
//-----------------------------------------------------------------------------

bool DomoZWave_SetValue( int32 home, int32 node, int32 instance, int32 value )
{
	bool bool_value;
	int int_value;
	uint8 uint8_value;
	uint16 uint16_value;
	bool response;
	bool cmdfound = false;

        if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetValue" ) == false ) return false;

	WriteLog( LogLevel_Debug, true, "DomoZWave_SetValue: HomeId=%d Node=%d", home, node );

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
		// Find the correct instance
		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			int id = (*it).GetCommandClassId();
			int inst = (*it).GetInstance();
			string label = Manager::Get()->GetValueLabel( (*it) );

			if ( id == COMMAND_CLASS_SWITCH_MULTILEVEL || id == COMMAND_CLASS_SWITCH_BINARY )
			{

				switch ( id )
				{
					case COMMAND_CLASS_SWITCH_BINARY:
					{
						// label="Switch" is mandatory, else it isn't a switch
						if ( label == "Switch" )
						{
							// If it is a binary CommandClass, then we only allow 0 (off) or 255 (on)
							if ( value > 0 && value < 255 )
							{
								continue;
							}
						}

						break;
					}
					case COMMAND_CLASS_SWITCH_MULTILEVEL:
					{
						// label="Level" is mandatory, else it isn't a dimmer type device
						if ( label != "Level" )
						{
							continue;
						}

						break;
					}
					default:
					{
						continue;
					}
				}

				if ( inst == instance )
				{
			        	if ( ValueID::ValueType_Bool == (*it).GetType() )
					{
						bool_value = (bool)value;
						response = Manager::Get()->SetValue( *it, bool_value );
						cmdfound = true;
					}
					else if ( ValueID::ValueType_Byte == (*it).GetType() )
					{
						uint8_value = (uint8)value;
						response = Manager::Get()->SetValue( *it, uint8_value );
						cmdfound = true;
					}
					else if ( ValueID::ValueType_Short == (*it).GetType() )
					{
						uint16_value = (uint16)value;
						response = Manager::Get()->SetValue( *it, uint16_value );
						cmdfound = true;
					}
					else if ( ValueID::ValueType_Int == (*it).GetType() )
					{
						int_value = value;
						response = Manager::Get()->SetValue( *it, int_value );
						cmdfound = true;
					}
					else if ( ValueID::ValueType_List == (*it).GetType() )
					{
						response = Manager::Get()->SetValue( *it, value );
						cmdfound = true;
	       				}
      					else
					{
						WriteLog(LogLevel_Debug, false, "Return=false (unknown ValueType)");
						return false;
					}

					WriteLog( LogLevel_Debug, false, "CommandClassId=%d", id );
					WriteLog( LogLevel_Debug, false, "CommandClassName=%s", DomoZWave_CommandClassIdName(id) );
					WriteLog( LogLevel_Debug, false, "Instance=%d", instance );
					WriteLog( LogLevel_Debug, false, "Value=%d", value );
					WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"true":"false" );
				}
			}
		}


		if ( cmdfound == false )
		{
			WriteLog( LogLevel_Debug, false, "Instance=%d", instance );
			WriteLog( LogLevel_Debug, false, "Value=%d", value );
			WriteLog( LogLevel_Debug, false, "Error=Couldn't match node to the required COMMAND_CLASS_SWITCH_BINARY or COMMAND_CLASS_SWITCH_MULTILEVEL");
			return false;
		}

	}
	else
	{
		WriteLog( LogLevel_Debug, false, "Return=false (node doesn't exist)" );
		response = false;
	}

	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetConfigParam>
//
//-----------------------------------------------------------------------------

bool DomoZWave_SetConfigParam( int32 home, int32 node, int32 param, int32 value, int32 size )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetConfigParam" ) == false ) return false;

	WriteLog( LogLevel_Debug, true, "DomoZWave_SetConfigParam: HomeId=%d Node=%d", home, node );
	WriteLog( LogLevel_Debug, false, "Parameter=%d", param );
	WriteLog( LogLevel_Debug, false, "Value=%d", value );
	WriteLog( LogLevel_Debug, false, "Size=%d", size );

	response = Manager::Get()->SetConfigParam( home, node, param, value, size );
	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"true":"false" );
	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetConfigParamList>
// Sets a configuration list item, because it is a string
//-----------------------------------------------------------------------------

bool DomoZWave_SetConfigParamList( int32 home, int32 node, int32 param, const char* value )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetConfigList" ) == false ) return false;

	WriteLog( LogLevel_Debug, true, "DomoZWave_SetConfigList: HomeId=%d Node=%d", home, node );
	WriteLog( LogLevel_Debug, false, "Parameter=%d", param );
	WriteLog( LogLevel_Debug, false, "Value=%s", value );

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			// Find the configuration items of this node 
			if ( ( v.GetCommandClassId() == COMMAND_CLASS_CONFIGURATION  ) && ( v.GetGenre() == ValueID::ValueGenre_Config ) && ( v.GetInstance() == 1 ) )
			{
				if ( v.GetIndex() == param )
				{
					if ( v.GetType() == ValueID::ValueType_List )
					{
						string string_value(value);
						return Manager::Get()->SetValueListSelection( v, string_value );
					} else {
						WriteLog( LogLevel_Error, true, "HomeId=%d Node=%d Param=%d isn't a list item", home, node, param );
						return false;
					}
				}
			}
		}
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "SetConfigList==None (node doesn't exist)" );
		return false;
	}
	return false;
}

//-----------------------------------------------------------------------------
// <DomoZWave_RequestConfigParam>
//
//-----------------------------------------------------------------------------

void DomoZWave_RequestConfigParam( int32 home, int32 node, int32 param ) 
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RequestConfigParam" ) == false ) return;
	WriteLog( LogLevel_Debug, true, "DomoZWave_RequestConfigParam: HomeId=%d Node=%d", home, node );
	WriteLog( LogLevel_Debug, false, "Parameter=%d", param );
	Manager::Get()->RequestConfigParam( home, node, param );
}

//-----------------------------------------------------------------------------
// <DomoZWave_RequestAllConfigParams>
//
//-----------------------------------------------------------------------------

void DomoZWave_RequestAllConfigParams( int32 home, int32 node )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RequestAllConfigParams" ) == false ) return;
	WriteLog( LogLevel_Debug, true, "DomoZWave_RequestAllConfigParams: HomeId=%d Node=%d", home, node );
	Manager::Get()->RequestAllConfigParams( home, node );
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeConfigList>
// The output will be in the format "1|2|3", then it has 3 parameters to be configure
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeConfigList( int32 home, int32 node )
{
	char dev_value[1024];
	string configlist;
	string str_tmp;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeConfigList" ) == false ) return "";

	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeConfigList: HomeId=%d Node=%d", home, node );

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			// Find the configuration items of this node 
			if ( ( v.GetCommandClassId() == COMMAND_CLASS_CONFIGURATION  ) && ( v.GetGenre() == ValueID::ValueGenre_Config ) && ( v.GetInstance() == 1 ) )
			{
				snprintf( dev_value, 100, "%d", v.GetIndex() );
				str_tmp = string ( dev_value );

				if ( configlist.length() >= 1 )
				{
					configlist.append( "|" );
				}

				configlist.append( str_tmp );
			}
		}
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "ConfigList==None (node doesn't exist)" );
		return "";
	}

	WriteLog( LogLevel_Debug, false, "ConfigList=%s", configlist.c_str() );

	// We convert from string to char*, because else garbage is reported to gambas
	char *tconfiglist;
	tconfiglist=new char [configlist.size() + 1];
	strcpy( tconfiglist, configlist.c_str() );
	return tconfiglist;
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeConfigLabel>
// Get configuration item's label
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeConfigLabel( int32 home, int32 node, int32 item )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeConfigLabel" ) == false ) return "";

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{

		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			// Find the configuration items of this node 
			if ( ( v.GetCommandClassId() == COMMAND_CLASS_CONFIGURATION  ) && ( v.GetGenre() == ValueID::ValueGenre_Config ) && ( v.GetInstance() == 1 ) )
			{
				// Check the index, only if this matches, get the Label
				if ( v.GetIndex() == item )
				{
					string valuelabel;
					valuelabel = Manager::Get()->GetValueLabel( v );

					// We convert from string to char*, because else garbage is reported to gambas
					char *tvaluelabel;
					tvaluelabel=new char [valuelabel.size()+1];
					strcpy( tvaluelabel, valuelabel.c_str() );
					return tvaluelabel;
				}
			}
		}
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "Label=None (node doesn't exist)" );
		return "";
	}

	WriteLog( LogLevel_Debug, false, "Label=<doesn't exist>" );
	return "";
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeConfigHelp>
// Get configuration item's help description
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeConfigHelp( int32 home, int32 node, int32 item )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeConfigHelp" ) == false ) return "";

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{

		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			// Find the configuration items of this node 
			if (( v.GetCommandClassId() == COMMAND_CLASS_CONFIGURATION  ) && ( v.GetGenre() == ValueID::ValueGenre_Config ) && ( v.GetInstance() == 1 ))
			{
				// Check the index, only if this matches, get the Label
				if ( v.GetIndex() == item )
				{
					string valuehelp;
					valuehelp = Manager::Get()->GetValueHelp( v );

					// We convert from string to char*, because else garbage is reported to gambas
					char *tvaluehelp;
					tvaluehelp=new char [valuehelp.size()+1];
					strcpy( tvaluehelp, valuehelp.c_str() );
					return tvaluehelp;
				}
			}
		}
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "Help=None (node doesn't exist)" );
		return "";
	}

	WriteLog( LogLevel_Debug, false, "Help=<doesn't exist>" );
	return "";
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeConfigValue>
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeConfigValue( int32 home, int32 node, int32 item )
{
	char dev_value[1024];
	uint8 byte_value;
	bool bool_value;
	string decimal_value;
	string list_value;
	string string_value;
	int int_value;
	int16 short_value;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeConfigValue" ) == false ) return "";

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{

		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			// Find the configuration items of this node 
			if (( v.GetCommandClassId() == COMMAND_CLASS_CONFIGURATION  ) && ( v.GetGenre() == ValueID::ValueGenre_Config ) && ( v.GetInstance() == 1 ))
			{
				// Check the index, only if this matches, get the Label
				if ( v.GetIndex() == item )
				{
					switch ( v.GetType() )
					{
						case ValueID::ValueType_Bool:
						{
							Manager::Get()->GetValueAsBool( v, &bool_value );
							snprintf( dev_value, 1024, "%i", bool_value );
							break;
						}
						case ValueID::ValueType_Byte:
						{
							Manager::Get()->GetValueAsByte( v, &byte_value );
							snprintf( dev_value, 1024, "%i", byte_value );
							break;
						}
						case ValueID::ValueType_Decimal:
						{
							Manager::Get()->GetValueAsString( v, &decimal_value );
							snprintf( dev_value, 1024, "%s", strdup( decimal_value.c_str() ) );
							break;
						}
						case ValueID::ValueType_Int:
						{
							Manager::Get()->GetValueAsInt( v, &int_value );
							snprintf( dev_value, 1024, "%d", int_value );
							break;
						}
						case ValueID::ValueType_Short:
						{
							Manager::Get()->GetValueAsShort( v, &short_value );
							snprintf( dev_value, 1024, "%d", short_value );
							break;
						}
						case ValueID::ValueType_Schedule:
						{
							return "";
						}
						case ValueID::ValueType_String:
						{
							Manager::Get()->GetValueAsString( v, &string_value );
							snprintf( dev_value, 1024, "%s", strdup( string_value.c_str() ) );
							break;
						}
						case ValueID::ValueType_Button:
						{
							return "";
						}
						case ValueID::ValueType_List:
						{
							Manager::Get()->GetValueListSelection( v, &list_value );
							snprintf( dev_value, 1024, "%s", strdup( list_value.c_str() ) );
							break;
						}
						default:
							return "";
					}

					char *tvalue;
					tvalue =new char [sizeof(dev_value)];
					strcpy( tvalue, dev_value );
					return tvalue;
				}
			}
		}
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "Value=None (node doesn't exist)" );
	}

	return "";

}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeConfigValueType>
// Returns the type of value for the configuration item. Normally we should only
// give Byte of List
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeConfigValueType( int32 home, int32 node, int32 item )
{

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeConfigValueType" ) == false ) return "";

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{

		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			// Find the configuration items of this node 
			if (( v.GetCommandClassId() == COMMAND_CLASS_CONFIGURATION  ) && ( v.GetGenre() == ValueID::ValueGenre_Config ) && ( v.GetInstance() == 1 ))
			{
				// Check the index, only if this matches, get the Label
				if ( v.GetIndex() == item )
				{
					switch ( v.GetType() )
					{
						case ValueID::ValueType_Bool: return "Bool";
						case ValueID::ValueType_Byte: return "Byte";
						case ValueID::ValueType_Decimal: return "Decimal";
						case ValueID::ValueType_Int: return "Int";
						case ValueID::ValueType_Short: return "Short";
						case ValueID::ValueType_Schedule: return "Schedule";
						case ValueID::ValueType_String: return "String";
						case ValueID::ValueType_Button: return "Button";
						case ValueID::ValueType_List: return "List";
						default: return "";
					}
				}
			}
		}
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "ValueType=None (node doesn't exist)" );
	}

	return "";

}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeConfigValueList>
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeConfigValueList( int32 home, int32 node, int32 item )
{

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeConfigValueList" ) == false ) return "";

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{

		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			// Find the configuration items of this node 
			if (( v.GetCommandClassId() == COMMAND_CLASS_CONFIGURATION  ) && ( v.GetGenre() == ValueID::ValueGenre_Config ) && ( v.GetInstance() == 1 ))
			{
				// Check the index, only if this matches, get the Label
				if ( v.GetIndex() == item )
				{
					if ( v.GetType() == ValueID::ValueType_List )
					{
						vector<string> strs;
						string str;

						Manager::Get()->GetValueListItems( v, &strs );

						for (vector<string>::iterator it = strs.begin(); it != strs.end(); it++)
						{
							if ( str.length() >= 1 )
							{
								str.append( "|" );
							}

							str.append( (*it) );
						}

						// We convert from string to char*, because else garbage is reported to gambas
						char *tvalue;
						tvalue=new char [str.size()+1];
						strcpy( tvalue, str.c_str() );
						return tvalue;

					}
					else
					{
						return "";
					}
				}
			}
		}
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "Value=None (node doesn't exist)" );
	}

	return "";
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeConfigValueReadOnly>
//-----------------------------------------------------------------------------

bool DomoZWave_GetNodeConfigValueReadOnly( int32 home, int32 node, int32 item )
{

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeConfigValueReadOnly" ) == false ) return false;

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{

		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			// Find the configuration items of this node 
			if (( v.GetCommandClassId() == COMMAND_CLASS_CONFIGURATION  ) && ( v.GetGenre() == ValueID::ValueGenre_Config ) && ( v.GetInstance() == 1 ))
			{
				// Check the index, only if this matches, get the Label
				if ( v.GetIndex() == item )
				{
					return Manager::Get()->IsValueReadOnly( v );
				}
			}
		}
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "Value=None (node doesn't exist)" );
	}

	// Set default value to ReadWrite
	return false;
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeNeighborsList>
// Retrieves the list of neigbors and it will be displayed in the example format:
// 2|3|4|6|7
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeNeighborsList( int32 home, int32 node )
{
	string neighborslist;
	uint8 *neighbors;
	uint32 numNeighbors;
	char dev_value[1024];

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeNeighborsList" ) == false ) return "";

	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeNeighborsList: HomeId=%d Node=%d", home, node );

	numNeighbors = Manager::Get()->GetNodeNeighbors( home, node, &neighbors );

	WriteLog( LogLevel_Debug, false, "NumberOfNeighbors=%d", numNeighbors );

	for( uint32 i=0; i<numNeighbors; ++i )
	{
		// Convert integer to char
		snprintf(dev_value, 1024, "%d", neighbors[i]);

		// Format the string with "|"
		if ( i != 0 )
		{
			neighborslist += "|";
		}

		neighborslist += dev_value;
	}

	WriteLog( LogLevel_Debug, false, "NeighborsList=%s", neighborslist.c_str() );

	// We convert from string to char*, because else garbage is reported to gambas
	char *tneighborslist;
	tneighborslist=new char [neighborslist.size()+1];
	strcpy( tneighborslist, neighborslist.c_str() );
	return tneighborslist;
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeCommandClassList>
// Retrieves the list of supported COMMAND_CLASS'es for a node.
// An example list is: COMMAND_CLASS_BASIC|COMMAND_CLASS_SWITCH_BINARY
// Default instance=0 - ALL CommandClasses of the device are reported
// If e.g. instance=1, only the CommandClasses of that specific instance are reported
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeCommandClassList( int32 home, int32 node, int32 instance = 0 )
{
	string commandclass;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeCommandClassList" ) == false ) return "";

	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeCommandClassList: HomeId=%d Node=%d Instance=%d", home, node, instance );

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
		if ( instance == 0 )
		{
		commandclass = nodeInfo->commandclass;
		}
		else
		{
			if ( nodeInfo->instancecommandclass.find(instance) != nodeInfo->instancecommandclass.end() )
			{
				commandclass = nodeInfo->instancecommandclass[instance];
			}
		}
		
		// Remove first "|" character
		if ( commandclass.length() >= 1 )
		{
			commandclass.replace(0, 1, "");
		}

		// Remove last "|" character
		if ( commandclass.length() >= 1 )
		{
			commandclass.replace( commandclass.length() - 1, 1, "" );
		}
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "CommandClassList=None (node doesn't exist)" );
		return "";
	}

	WriteLog( LogLevel_Debug, false, "CommandClassList=%s", commandclass.c_str() );

	// We convert from string to char*, because else garbage is reported to gambas
	char *tcommandclass;
	tcommandclass=new char [commandclass.size() + 1];
	strcpy( tcommandclass, commandclass.c_str() );
	return tcommandclass;
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeGroupCount>
// Retrieves the number of group of this node
//-----------------------------------------------------------------------------

int DomoZWave_GetNodeGroupCount( int32 home, int32 node )
{
	int32 count;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeGroupCount" ) == false ) return 0;
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeGroupCount: HomeId=%d Node=%d", home, node );
	count = Manager::Get()->GetNumGroups( home, node );
	WriteLog( LogLevel_Debug, false, "Count=%d", count );
	return count;
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeGroupList>
// Retrieves the nodes assigned to a group
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeGroupList(int32 home, int32 node, int32 ogroup )
{
	uint32 group;
	uint32 numGroups;
	string grouplist;
	char dev_value[1024];
	uint32 numAssociations;
	uint8 *associations;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeGroupList" ) == false ) return "";

	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeGroupList: HomeId=%d Node=%d Group=%d", home, node, ogroup );

	group = ogroup;
        numGroups = Manager::Get()->GetNumGroups( home, node );

	// Only try to retrieve a list, if it is a valid group number
	if (( group >= 1) && ( group <= numGroups ))
	{

		numAssociations = Manager::Get()->GetAssociations(home, node, group, &associations );

		for( uint32 i=0; i<numAssociations; ++i )
		{
			snprintf(dev_value, 1024, "%d", associations[i]);
			grouplist += dev_value;

			if ( ( i + 1 ) != numAssociations )
			{
				grouplist += ",";
			}
		}
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "GroupList=None (group doesn't exist)" );
		return "";
	}

	WriteLog( LogLevel_Debug, false, "GroupList=%s", grouplist.c_str() );

	// We convert from string to char*, because else garbage is reported to gambas
	char *tgrouplist;
	tgrouplist=new char [grouplist.size() + 1];
	strcpy( tgrouplist, grouplist.c_str() );
	return tgrouplist;
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeGroupMax>
// Retrieves the maximum number of nodes per group
//-----------------------------------------------------------------------------

int DomoZWave_GetNodeGroupMax( int32 home, int32 node, int32 ogroup )
{
	uint32 group;
	uint32 numGroups;
	int32 count;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeGroupMax" ) == false ) return 0;

	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeGroupMax: HomeId=%d Node=%d Group=%d", home, node, ogroup );

	group = ogroup;
        numGroups = Manager::Get()->GetNumGroups( home, node );

	// Only try to retrieve a list, if it is a valid group number
	if (( group >= 1) && ( group <= numGroups ))
	{
		count = Manager::Get()->GetMaxAssociations(home, node, group );
		WriteLog( LogLevel_Debug, false, "GroupMax=%d", count );
		return count;
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "GroupMax=None (group doesn't exist)" );
		return 0;
	}
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeGroupLabel>
// Retrieves the label text of a group
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeGroupLabel( int32 home, int32 node, int32 ogroup )
{
	uint32 numGroups;
	uint32 group;
	string grouplabel;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeGroupLabel" ) == false ) return "";

	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeGroupLabel: HomeId=%d Node=%d Group=%d", home, node, ogroup );

	group = ogroup;
        numGroups = Manager::Get()->GetNumGroups( home, node );

	// Only try to retrieve a list, if it is a valid group number
	if (( group >= 1) && ( group <= numGroups ))
	{
		grouplabel = Manager::Get()->GetGroupLabel(home, node, group );
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "GroupLabel=None (group doesn't exist)" );
		return "";
	}

	WriteLog( LogLevel_Debug, false, "GroupLabel=%s", grouplabel.c_str() );

	// We convert from string to char*, because else garbage is reported to gambas
	char *tgrouplabel;
	tgrouplabel=new char [grouplabel.size() + 1];
	strcpy( tgrouplabel, grouplabel.c_str() );
	return tgrouplabel;
}

//-----------------------------------------------------------------------------
// <DomoZWave_AddAssociation>
// Adds a node association to a group of a node
//-----------------------------------------------------------------------------

void DomoZWave_AddAssociation( int32 home, int32 node, int32 group, int32 otherNode )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_AddAssociation" ) == false ) return;
	
	WriteLog( LogLevel_Debug, true, "DomoZWave_AddAssociation: HomeId=%d Node=%d", home, node );
	WriteLog( LogLevel_Debug, false, "Group=%d, Node=%d", group, otherNode );

	Manager::Get()->AddAssociation( home, node, group, otherNode );
	// Refresh isn't required anymore with r564
	//Manager::Get()->RefreshNodeInfo( home, node);
}

//-----------------------------------------------------------------------------
// <DomoZWave_RemoveAssociation>
// Remove a group association
//-----------------------------------------------------------------------------

void DomoZWave_RemoveAssociation( int32 home, int32 node, int32 group, int32 otherNode )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RemoveAssociation" ) == false ) return;

	WriteLog( LogLevel_Debug, true, "RemoveAssociation for HomeId=%d Node=%d", home, node );
	WriteLog( LogLevel_Debug, false, "Group=%d, Node=%d", group, otherNode );

	Manager::Get()->RemoveAssociation( home, node, group, otherNode );
	// Refresh isn't required anymore with r564
	//Manager::Get()->RefreshNodeInfo( home, node);
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeUserCodeCount>
// Returns the number of usercounts supported by the device
// 0 is returned if no UserCode CommandClass exists
//-----------------------------------------------------------------------------

int DomoZWave_GetNodeUserCodeCount( int32 home, int32 node )
{
	uint32 Count = 0;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeUserCodeCount" ) == false ) return 0;

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{

		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			// Find the usercode items of this node 
			if (( v.GetCommandClassId() == COMMAND_CLASS_USER_CODE ) && ( v.GetGenre() == ValueID::ValueGenre_User ) && ( v.GetInstance() == 1 ))
			{
				// Check the index, and if we find a higher value, store it
				if ( v.GetIndex() > Count )
				{
					Count = v.GetIndex();
				}
			}
		}
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "Value=None (node doesn't exist)" );
	}

	return Count;
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeUserCodeLabel>
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeUserCodeLabel( int32 home, int32 node, int32 usercode )
{

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeUserCodeLabel" ) == false ) return "";

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{

		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			// Find the usercode items of this node 
			if (( v.GetCommandClassId() == COMMAND_CLASS_USER_CODE ) && ( v.GetGenre() == ValueID::ValueGenre_User ) && ( v.GetInstance() == 1 ))
			{
				// Check the index, and if we find a higher value, store it
				if ( v.GetIndex() == usercode )
				{
					string valuelabel;
					valuelabel = Manager::Get()->GetValueLabel( v );

					// We convert from string to char*, because else garbage is reported to gambas
					char *tvaluelabel;
					tvaluelabel=new char [valuelabel.size()+1];
					strcpy( tvaluelabel, valuelabel.c_str() );
					return tvaluelabel;
				}
			}
		}
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "Value=None (node doesn't exist)" );
	}

	return "";
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeUserCodeValue>
// Retrieves the UserCode value for the specific UserCode
// Format is in 0x00 0x00 0x00 ... etc
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeUserCodeValue( int32 home, int32 node, int32 usercode )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeUserCodeValue" ) == false ) return "";

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{

		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			// Find the usercode items of this node 
			if (( v.GetCommandClassId() == COMMAND_CLASS_USER_CODE ) && ( v.GetGenre() == ValueID::ValueGenre_User ) && ( v.GetInstance() == 1 ))
			{
				if (( v.GetIndex() == usercode ) && ( v.GetType() == ValueID::ValueType_Raw ))
				{
					string string_value;
					Manager::Get()->GetValueAsString( v, &string_value );

					// We convert from string to char*, because else garbage is reported to gambas
					char *tstring_value;
					tstring_value=new char [string_value.size()+1];
					strcpy( tstring_value, string_value.c_str() );
					return tstring_value;
				}
			}
		}
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "Value=None (node doesn't exist)" );
	}

	return "";
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetNodeUserCodeStart>
//-----------------------------------------------------------------------------

bool DomoZWave_SetNodeUserCodeStart( int32 home, int32 node )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetNodeUserCodeStart" ) == false ) return false;

        WriteLog( LogLevel_Debug, true, "DomoZWave_SetNodeUserCodeStart: HomeId=%d Node=%d", home, node );

        m_structCtrl* ctrl = GetControllerInfo( home );

	ctrl->m_userCodeEnrollNode = node;
	ctrl->m_userCodeEnrollTime = time( NULL );

	return true;
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetNodeUserCodeStop>
//-----------------------------------------------------------------------------

bool DomoZWave_SetNodeUserCodeStop( int32 home )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetNodeUserCodeStop" ) == false ) return false;

        WriteLog( LogLevel_Debug, true, "DomoZWave_SetNodeUserCodeStop: HomeId=%d", home );

        m_structCtrl* ctrl = GetControllerInfo( home );

	ctrl->m_userCodeEnrollNode = 0;
	ctrl->m_userCodeEnrollTime = 0;

	return true;
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetNodeUserCodeRemove>
//-----------------------------------------------------------------------------

bool DomoZWave_SetNodeUserCodeRemove( int32 home, int32 node, int32 usercode )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetNodeUserCodeRemove" ) == false ) return false;

        WriteLog( LogLevel_Debug, true, "DomoZWave_SetNodeUserCodeRemove: HomeId=%d Node=%d UserCode=%d", home, node, usercode );

        m_structCtrl* ctrl = GetControllerInfo( home );

	ctrl->m_userCodeEnrollNode = 0;
	ctrl->m_userCodeEnrollTime = 0;

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{

		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			// Find the usercode items of this node 
			if (( v.GetCommandClassId() == COMMAND_CLASS_USER_CODE ) && ( v.GetGenre() == ValueID::ValueGenre_User ) && ( v.GetInstance() == 1 ))
			{
				if (( v.GetIndex() == usercode ) && ( v.GetType() == ValueID::ValueType_Raw ))
				{
					string string_value;
					Manager::Get()->GetValueAsString( v, &string_value );

					// Count the number of x = 0x?? values
					int count = 0;
  					for (size_t i = 0; i < string_value.size(); i++)
						if (string_value[i] == 'x') count++;

					// Set the string_value to 0x00 ...
					string_value = "";

					for (int i = 0; i < count; i++)
					{
						if ( string_value.length() >= 1 )
						{
							string_value.append( " 0x00" );
						}
						else
						{
							string_value.append( "0x00" );
						}
					}

					WriteLog( LogLevel_Debug, false, "SetValue=%s", string_value.c_str() );

					// Now we really set only if it is a sleeping device - it can take a while
					return Manager::Get()->SetValue( v, string_value );
				}
			}
		}
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "Value=None (node doesn't exist)" );
	}

	return true;
}

//-----------------------------------------------------------------------------
// <DomoZWave_ControllerState>
// Returns the state of the Z-Wave controller. This state is required to
// determine if we can send certain commands to the controller or if we should
// wait/pause for a moment
//-----------------------------------------------------------------------------

bool DomoZWave_ControllerBusy( int32 home )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_ControllerBusy" ) == false ) return true;
	m_structCtrl* ctrl = GetControllerInfo( home );
	response = ctrl->m_controllerBusy;

	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"true":"false" );
	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_ControllerSoftReset>
// Resets the controller in a soft way, no configuration is lost. We don't
// have to re-initialize, because all data stays valid
//-----------------------------------------------------------------------------

void DomoZWave_ControllerSoftReset( int32 home )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_ControllerSoftReset" ) == false ) return;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_ControllerSoftReset: HomeId=%d", home );
	Manager::Get()->SoftReset( home );

	ctrl->m_controllerBusy = false;
}

//-----------------------------------------------------------------------------
// <DomoZWave_ControllerHardReset>
// Resets the Controller HARD - it will loose *all* configuration, only do it
// when you're really-really-really sure
//-----------------------------------------------------------------------------

void DomoZWave_ControllerHardReset( int32 home )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_ControllerHardReset" ) == false ) return;
	//m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_ControllerHardReset: HomeId=%d", home );
	Manager::Get()->ResetController( home );

	// TBC:
	// We should remove the controller from the list and remove all values?
}

//-----------------------------------------------------------------------------
// <DomoZWave_CancelControllerCommand>
//
//-----------------------------------------------------------------------------

bool DomoZWave_CancelControllerCommand( int32 home )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_CancelControllerCommand" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );
	ctrl->m_nodeId = 0;

	WriteLog( LogLevel_Debug, true, "DomoZWave_CancelControllerCommand: HomeId=%d", home );
	response = Manager::Get()->CancelControllerCommand( home );
	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"true":"false" );

	// Change the ControllerState to normal
	ctrl->m_controllerBusy = false;

	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_AddDevice>
//
//-----------------------------------------------------------------------------

bool DomoZWave_AddDevice( int32 home )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_AddDevice" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog(LogLevel_Debug, true, "DomoZWave_AddDevice: HomeId=%d", home );

	if ( ctrl->m_controllerBusy == false )
	{
		ctrl->m_nodeId = 0;
		ctrl->m_controllerBusy = true;

		response = Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_AddDevice, OnControllerUpdate, ctrl, true, 0xff );
	}
	else
	{
		response = false;
	}

	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_RemoveDevice>
//
//-----------------------------------------------------------------------------

bool DomoZWave_RemoveDevice( int32 home )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RemoveDevice" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_RemoveDevice: HomeId=%d", home );

	if ( ctrl->m_controllerBusy == false )
	{
		ctrl->m_nodeId = 0;
		ctrl->m_controllerBusy = true;

		response = Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_RemoveDevice, OnControllerUpdate, ctrl, true );
	}
	else
	{
		response = false;
	}

	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_AssignReturnRoute>
//
//-----------------------------------------------------------------------------

bool DomoZWave_AssignReturnRoute( int32 home, int32 node, int32 destnode )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_AssignReturnRoute" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_AssignReturnRoute: HomeId=%d Node=%d", home, node );

	if ( ctrl->m_controllerBusy == false )
	{
		ctrl->m_nodeId = node;
		ctrl->m_controllerBusy = true;

		response = Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_AssignReturnRoute, OnControllerUpdate, ctrl, true, node, destnode );
	}
	else
	{
		response = false;
	}

	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_DeleteAllReturnRoutes>
//
//-----------------------------------------------------------------------------

bool DomoZWave_DeleteAllReturnRoutes( int32 home, int32 node )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_DeleteAllReturnRoutes" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_DeleteAllReturnRoutes: HomeId=%d Node=%d", home, node );

	if ( ctrl->m_controllerBusy == false )
	{
		ctrl->m_nodeId = node;
		ctrl->m_controllerBusy = true;

		response = Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_DeleteAllReturnRoutes, OnControllerUpdate, ctrl, true, node );
	}
	else
	{
		response = false;
	}

	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_RequestNetworkUpdate>
// Request network information from the SUC/SIS
//-----------------------------------------------------------------------------

bool DomoZWave_RequestNetworkUpdate( int32 home, int32 node )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RequestNetworkUpdateFromPrimary" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_RequestNetworkUpdateFromPrimary: HomeId=%d", home );

	if ( ctrl->m_controllerBusy == false )
	{
		ctrl->m_nodeId = node;
		ctrl->m_controllerBusy = true;

		response = Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_RequestNetworkUpdate, OnControllerUpdate, ctrl, false, node );
	}
	else
	{
		response = false;
	}

	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_CreateNewPrimary>
// Add a new controller to the Z-Wave network. The new controller will be the
// primary, and the current primary will become a secondary controller
//-----------------------------------------------------------------------------

bool DomoZWave_CreateNewPrimary( int32 home )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_CreateNewPrimary" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_CreateNewPrimary: HomeId=%d", home );

	if ( ctrl->m_controllerBusy == false )
	{
		ctrl->m_nodeId = 0;
		ctrl->m_controllerBusy = true;

		response = Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_CreateNewPrimary, OnControllerUpdate, ctrl, true );
	}
	else
	{
		response = false;
	}

	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_TransferPrimaryRole>
// Make a different controller the primary
//-----------------------------------------------------------------------------

bool DomoZWave_TransferPrimaryRole( int32 home )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_TransferPrimaryRole" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_TransferPrimaryRole: HomeId=%d", home );

	if ( ctrl->m_controllerBusy == false )
	{
		ctrl->m_nodeId = 0;
		ctrl->m_controllerBusy = true;

		response = Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_TransferPrimaryRole, OnControllerUpdate, ctrl, true );
	}
	else
	{
		response = false;
	}

	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_ReceiveConfiguration>
// Receive Z-Wave network configuration information from another controller
//-----------------------------------------------------------------------------

bool DomoZWave_ReceiveConfiguration( int32 home )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_ReceiveConfiguration" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_ReceiveConfiguration: HomeId=%d", home );

	if ( ctrl->m_controllerBusy == false )
	{
		ctrl->m_nodeId = 0;
		ctrl->m_controllerBusy = true;

		response = Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_ReceiveConfiguration, OnControllerUpdate, ctrl, true );
	}
	else
	{
		response = false;
	}

	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_HasNodeFailed>
// Check whether a node is in the controller's failed nodes list
//-----------------------------------------------------------------------------

bool DomoZWave_HasNodeFailed( int32 home, int32 node, bool addqueue = false )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_HasNodeFailed" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_HasNodeFailed: HomeId=%d Node=%d", home, node );

	if ( addqueue )
	{
		if ( ctrl->m_controllerBusy == false )
		{
			// Send the request - this is the first one
			ctrl->m_nodeId = node;
			ctrl->m_controllerBusy = true;

			response = Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_HasNodeFailed, OnControllerUpdate, ctrl, true, node );
			WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
		}
		else
		{
			// Queue up the request
			m_cmdItem cmd;
			bool toqueue;

			cmd.m_command = Driver::ControllerCommand_HasNodeFailed;
			cmd.m_nodeId = node;
			cmd.m_time = time( NULL );
			toqueue = true;

			// Check if the command is already in the queue, then don't add
			for ( list<m_cmdItem>::iterator it = ctrl->m_cmd.begin(); it != ctrl->m_cmd.end(); ++it )
			{
				m_cmdItem v = *it;

				if ( ( v.m_command == Driver::ControllerCommand_HasNodeFailed ) && ( v.m_nodeId = node ) )
				{
					toqueue = false;
				}
			}

			if ( toqueue )
			{
				ctrl->m_cmd.push_back( cmd );
				WriteLog( LogLevel_Debug, false, "Return=Queued" );
			}
			else
			{
				WriteLog( LogLevel_Debug, false, "Return=Duplicate (Not Queued)" );
			}

			response = true;
		}

		return response;
	} else
	{
		if ( ctrl->m_controllerBusy == false )
		{
			ctrl->m_nodeId = node;
			ctrl->m_controllerBusy = true;

			response = Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_HasNodeFailed, OnControllerUpdate, ctrl, true, node );
		}
		else
		{
			response = false;
		}

		WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
		return response;
	}
}

//-----------------------------------------------------------------------------
// <DomoZWave_RemoveFailedNode>
// move a node to the controller's list of failed nodes. The node must actually
// have failed or have been disabled since the command will fail if it responds.
// A node must be in the controller's failed nodes list for 
// ControllerCommand_ReplaceFailedNode to work.
//-----------------------------------------------------------------------------

bool DomoZWave_RemoveFailedNode( int32 home, int32 node )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RemoveFailedNode" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_RemoveFailedNode: HomeId=%d Node=%d", home, node );

	if ( ctrl->m_controllerBusy == false )
	{
		ctrl->m_nodeId = node;
		ctrl->m_controllerBusy = true;

		response = Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_RemoveFailedNode, OnControllerUpdate, ctrl, true, node );
	}
	else
	{
		response = false;
	}

	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_ReplaceFailedNode>
// replace a failed device with another. If the node is not in the controller's/
// failed nodes list, or the node responds, this command will fail.
//-----------------------------------------------------------------------------

bool DomoZWave_ReplaceFailedNode( int32 home, int32 node )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_ReplaceFailedNode" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_ReplaceFailedNode: HomeId=%d Node=%d", home, node );

	if ( ctrl->m_controllerBusy == false )
	{
		ctrl->m_nodeId = node;
		ctrl->m_controllerBusy = true;

		response = Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_ReplaceFailedNode, OnControllerUpdate, ctrl, true, node );
	}
	else
	{
		response = false;
	}

	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_SendNodeInformation>
// Send a node information frame
//-----------------------------------------------------------------------------

bool DomoZWave_SendNodeInformation( int32 home, int32 node )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SendNodeInformation" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_SendNodeInformation: HomeId=%d Node=%d", home, node );

	if ( ctrl->m_controllerBusy == false )
	{
		ctrl->m_nodeId = node;
		ctrl->m_controllerBusy = true;

		response = Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_SendNodeInformation, OnControllerUpdate, ctrl, true, node );
	}
	else
	{
		response = false;
	}

	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_ReplicationSend>
// Send information from primary to secondary
//-----------------------------------------------------------------------------

bool DomoZWave_ReplicationSend( int32 home, int32 node )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_ReplicationSend" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_ReplicationSend: HomeId=%d Node=%d", home, node );

	if ( ctrl->m_controllerBusy == false )
	{
		ctrl->m_nodeId = node;
		ctrl->m_controllerBusy = true;

		response = Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_ReplicationSend, OnControllerUpdate, ctrl, true, node );
	}
	else
	{
		response = false;
	}

	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_HealNetworkNode>
// Heal a specific network node by updating its neighborhood list
// Optionally we can do a "doRR" then the return routes are refreshed also
//-----------------------------------------------------------------------------

void DomoZWave_HealNetworkNode( int32 home, int32 node, bool doRR )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_HealNetworkNode" ) == false ) return;

	WriteLog( LogLevel_Debug, true, "DomoZWave_HealNetworkNode: HomeId=%d Node=%d", home, node );

	if ( GetNodeInfo( home, node ) )
	{
		Manager::Get()->HealNetworkNode( home, node, doRR );
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "Node=%d doesn't exist", node );
	}
}

//-----------------------------------------------------------------------------
// <DomoZWave_HealNetwork>
// Heal the complete network by updating its neighborhood list
// Optionally we can do a "doRR" then the return routes are refreshed also
// This can take a while if we execute it on a big network
//-----------------------------------------------------------------------------

void DomoZWave_HealNetwork( int32 home, bool doRR )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_HealNetwork" ) == false ) return;

	WriteLog( LogLevel_Debug, true, "DomoZWave_HealNetwork: HomeId=%d", home );

	Manager::Get()->HealNetwork( home, doRR );
}

//-----------------------------------------------------------------------------
// <DomoZWave_TestNetworkNode>
// Do testing of network stability/quality for a specific node
//-----------------------------------------------------------------------------

void DomoZWave_TestNetworkNode( int32 home, int32 node, int32 count )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_TestNetworkNode" ) == false ) return;

	WriteLog( LogLevel_Debug, true, "DomoZWave_TestNetworkNode: HomeId=%d Node=%d", home, node );

	if ( GetNodeInfo( home, node ) )
	{
		Manager::Get()->TestNetworkNode( home, node, count );
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "Node=%d doesn't exist", node );
	}
}

//-----------------------------------------------------------------------------
// <DomoZWave_TestNetwork>
// Do testing of network stability/quality for the whole network
//-----------------------------------------------------------------------------

void DomoZWave_TestNetwork( int32 home, int32 count )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_TestNetwork" ) == false ) return;

	WriteLog( LogLevel_Debug, true, "DomoZWave_TestNetwork: HomeId=%d", home );

	Manager::Get()->TestNetwork( home, count );
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetDriverStatistics>
//-----------------------------------------------------------------------------

const char* DomoZWave_GetDriverStatistics( int32 home )
{
	char dev_value[1024];

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetDriverStatistics" ) == false ) return "";

	// Driver::DriverData contains (r583):
	// m_SOFCnt             - Number of SOF bytes received
	// m_ACKWaiting         - Number of unsolicited messages while waiting for an ACK
	// m_readAborts         - Number of times read were aborted due to timeouts
	// m_badChecksum        - Number of bad checksums   
	// m_readCnt            - Number of messages successfully read
	// m_writeCnt           - Number of messages successfully sent
	// m_CANCnt             - Number of CAN bytes received
	// m_NAKCnt             - Number of NAK bytes received
	// m_ACKCnt             - Number of ACK bytes received
	// m_OOFCnt             - Number of bytes out of framing
	// m_dropped            - Number of messages dropped & not delivered
	// m_retries            - Number of messages retransmitted
	// m_callbacks          - Number of unexpected callbacks
	// m_badroutes          - Number of failed messages due to bad route response
	// m_noack              - Number of no ACK returned errors
	// m_netbusy            - Number of network busy/failure messages
	// m_nondelivery        - Number of messages not delivered to network
	// m_routedbusy         - Number of messages received with routed busy status
	// m_broadcastReadCnt   - Number of broadcasts read
	// m_broadcastWriteCnt  - Number of broadcasts sent

	Driver::DriverData data;
	Manager::Get()->GetDriverStatistics( home, &data );

	snprintf( dev_value, 1024, "sofcnt: %d|ackwaiting: %d|readaborts: %d|badchecksum: %d|readcnt: %d|writecnt: %d|cancnt: %d|nakcnt: %d|ackcnt: %d|oofcnt: %d|dropped: %d|retries: %d|callbacks: %d|badroutes: %d|noack: %d|netbusy: %d|nondelivery: %d|routedbusy: %d|broadcastreadcnt: %d|broadcastwritecnt: %d", data.m_SOFCnt, data.m_ACKWaiting, data.m_readAborts, data.m_badChecksum, data.m_readCnt, data.m_writeCnt, data.m_CANCnt, data.m_NAKCnt, data.m_ACKCnt, data.m_OOFCnt, data.m_dropped, data.m_retries, data.m_callbacks, data.m_badroutes, data.m_noack, data.m_netbusy, data.m_nondelivery, data.m_routedbusy, data.m_broadcastReadCnt, data.m_broadcastWriteCnt );

	char *tdev_value;
	tdev_value =new char [sizeof(dev_value)];
	strcpy( tdev_value, dev_value );
	return tdev_value;
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetSendQueueCount>
//-----------------------------------------------------------------------------

long DomoZWave_GetSendQueueCount( int32 home )
{
	long count;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetSendQueueCount" ) == false ) return 0;
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetSendQueueCount: HomeId=%d", home );
	count = Manager::Get()->GetSendQueueCount( home );
	WriteLog( LogLevel_Debug, false, "Count=%d", count );
	return count;
}

//-----------------------------------------------------------------------------
// <DomoZWave_CommandClassIdName>
// Returns a readable name of a COMMAND_CLASS. If it is unknown, it will
// display "UNKNOWN"
//-----------------------------------------------------------------------------

const char* DomoZWave_CommandClassIdName(int class_value)
{
	char str_tmp[100];

	switch ( class_value )
	{
		case 0x00: return "COMMAND_CLASS_NO_OPERATION";
		case 0x20: return "COMMAND_CLASS_BASIC";
		case 0x21: return "COMMAND_CLASS_CONTROLLER_REPLICATION";
		case 0x22: return "COMMAND_CLASS_APPLICATION_STATUS";
		case 0x23: return "COMMAND_CLASS_ZIP_SERVICES";
		case 0x24: return "COMMAND_CLASS_ZIP_SERVER";
		case 0x25: return "COMMAND_CLASS_SWITCH_BINARY";
		case 0x26: return "COMMAND_CLASS_SWITCH_MULTILEVEL";
		case 0x27: return "COMMAND_CLASS_SWITCH_ALL";
		case 0x28: return "COMMAND_CLASS_SWITCH_TOGGLE BINARY";
		case 0x29: return "COMMAND_CLASS_SWITCH_TOGGLE MULTILEVEL";
		case 0x2A: return "COMMAND_CLASS_CHIMNEY_FAN";
		case 0x2B: return "COMMAND_CLASS_SCENE_ACTIVATION";
		case 0x2C: return "COMMAND_CLASS_SCENE_ACTUATOR CONF";
		case 0x2D: return "COMMAND_CLASS_SCENE_CONTROLLER CONF";
		case 0x2E: return "COMMAND_CLASS_ZIP_CLIENT";
		case 0x2F: return "COMMAND_CLASS_ZIP_ADV_SERVICES";
		case 0x30: return "COMMAND_CLASS_SENSOR_BINARY";
		case 0x31: return "COMMAND_CLASS_SENSOR_MULTILEVEL";
		case 0x32: return "COMMAND_CLASS_METER";
		case 0x33: return "COMMAND_CLASS_ZIP_ADV_SERVER";
		case 0x34: return "COMMAND_CLASS_ZIP_ADV_CLIENT";
		case 0x35: return "COMMAND_CLASS_METER_PULSE";
		case 0x38: return "COMMAND_CLASS_THERMOSTAT_HEATING";
		case 0x40: return "COMMAND_CLASS_THERMOSTAT_MODE";
		case 0x42: return "COMMAND_CLASS_THERMOSTAT_OPERATING STATE";
		case 0x43: return "COMMAND_CLASS_THERMOSTAT_SETPOINT";
		case 0x44: return "COMMAND_CLASS_THERMOSTAT_FAN MODE";
		case 0x45: return "COMMAND_CLASS_THERMOSTAT_FAN STATE";
		case 0x46: return "COMMAND_CLASS_CLIMATE_CONTROL_SCHEDULE";
		case 0x47: return "COMMAND_CLASS_THERMOSTAT_SETBACK";
		case 0x4C: return "COMMAND_CLASS_DOOR_LOCK_LOGGING";
		case 0x4E: return "COMMAND_CLASS_SCHEDULE_ENTRY_LOCK";
		case 0x50: return "COMMAND_CLASS_BASIC_WINDOW_COVERING";
		case 0x51: return "COMMAND_CLASS_MTP_WINDOW_COVERING";
		case 0x60: return "COMMAND_CLASS_MULTI_INSTANCE";
		case 0x62: return "COMMAND_CLASS_DOOR_LOCK";
		case 0x63: return "COMMAND_CLASS_USER_CODE";
		case 0x70: return "COMMAND_CLASS_CONFIGURATION";
		case 0x71: return "COMMAND_CLASS_ALARM";
		case 0x72: return "COMMAND_CLASS_MANUFACTURER_SPECIFIC";
		case 0x73: return "COMMAND_CLASS_POWERLEVEL";
		case 0x75: return "COMMAND_CLASS_PROTECTION";
		case 0x76: return "COMMAND_CLASS_LOCK";
		case 0x77: return "COMMAND_CLASS_NODE_NAMING";
		case 0x7A: return "COMMAND_CLASS_FIRMWARE_UPDATE MD";
		case 0x7B: return "COMMAND_CLASS_GROUPING_NAME";
		case 0x7C: return "COMMAND_CLASS_REMOTE_ASSOCIATION_ACTIVATE";
		case 0x7D: return "COMMAND_CLASS_REMOTE_ASSOCIATION";
		case 0x80: return "COMMAND_CLASS_BATTERY";
		case 0x81: return "COMMAND_CLASS_CLOCK";
		case 0x82: return "COMMAND_CLASS_HAIL";
		case 0x84: return "COMMAND_CLASS_WAKE_UP";
		case 0x85: return "COMMAND_CLASS_ASSOCIATION";
		case 0x86: return "COMMAND_CLASS_VERSION";
		case 0x87: return "COMMAND_CLASS_INDICATOR";
		case 0x88: return "COMMAND_CLASS_PROPRIETARY";
		case 0x89: return "COMMAND_CLASS_LANGUAGE";
		case 0x8A: return "COMMAND_CLASS_TIME";
		case 0x8B: return "COMMAND_CLASS_TIME_PARAMETERS";
		case 0x8C: return "COMMAND_CLASS_GEOGRAPHIC_LOCATION";
		case 0x8D: return "COMMAND_CLASS_COMPOSITE";
		case 0x8E: return "COMMAND_CLASS_MULTI_INSTANCE_ASSOCIATION";
		case 0x8F: return "COMMAND_CLASS_MULTI_CMD";
		case 0x90: return "COMMAND_CLASS_ENERGY_PRODUCTION";
		case 0x91: return "COMMAND_CLASS_MANUFACTURER_PROPRIETARY";
		case 0x92: return "COMMAND_CLASS_SCREEN_MD";
		case 0x93: return "COMMAND_CLASS_SCREEN_ATTRIBUTES";
		case 0x94: return "COMMAND_CLASS_SIMPLE_AV_CONTROL";
		case 0x95: return "COMMAND_CLASS_AV_CONTENT_DIRECTORY_MD";
		case 0x96: return "COMMAND_CLASS_AV_RENDERER_STATUS";
		case 0x97: return "COMMAND_CLASS_AV_CONTENT_SEARCH_MD";
		case 0x98: return "COMMAND_CLASS_SECURITY";
		case 0x99: return "COMMAND_CLASS_AV_TAGGING_MD";
		case 0x9A: return "COMMAND_CLASS_IP_CONFIGURATION";
		case 0x9B: return "COMMAND_CLASS_ASSOCIATION_COMMAND_CONFIGURATION";
		case 0x9C: return "COMMAND_CLASS_SENSOR_ALARM";
		case 0x9D: return "COMMAND_CLASS_SILENCE_ALARM";
		case 0x9E: return "COMMAND_CLASS_SENSOR_CONFIGURATION";
		case 0xEF: return "COMMAND_CLASS_MARK";
		case 0xF0: return "NON_INTEROPERABLE";
		default:
		{
			// We report UNKNOWN including the 0xYY hexcode
			snprintf( str_tmp, 100, "UNKNOWN (0x%02X)", class_value );
			return string(str_tmp).c_str();
		}
	}
}

//-----------------------------------------------------------------------------
// <DomoZWave_GenreIdName>
//
//-----------------------------------------------------------------------------

const char* DomoZWave_GenreIdName( int genre )
{
	char str_tmp[100];

	switch ( genre )
	{
		case ValueID::ValueGenre_Basic:
			return "basic";
		case ValueID::ValueGenre_User:
			return "user";
		case ValueID::ValueGenre_Config:
			return "config";
		case ValueID::ValueGenre_System:
			return "system";
		case ValueID::ValueGenre_Count:
			return "count";
		default:
		{
			// We report UNKNOWN including the 0xYY hexcode
			snprintf( str_tmp, 100, "UNKNOWN (0x%02X)", genre );
			return string(str_tmp).c_str();
		}
  }
}

//-----------------------------------------------------------------------------
// <DomoZWave_BasicTypeName>
//
//-----------------------------------------------------------------------------

const char* DomoZWave_BasicTypeName( int basictype )
{
	char str_tmp[100];

	switch ( basictype )
	{
		case BASIC_TYPE_CONTROLLER:
			return "Controller";
		case BASIC_TYPE_STATIC_CONTROLLER:
			return "Static Controller";
		case BASIC_TYPE_SLAVE:
			return "Slave";
		case BASIC_TYPE_ROUTING_SLAVE:
			return "Routing Slave";
		default:
		{
			// We report UNKNOWN including the 0xYY hexcode
			snprintf( str_tmp, 100, "UNKNOWN (0x%02X)", basictype );
			return string(str_tmp).c_str();
		}
	}
}

//-----------------------------------------------------------------------------
// <DomoZWave_GenericTypeName>
//
//-----------------------------------------------------------------------------

const char* DomoZWave_GenericTypeName( int generictype )
{
	char str_tmp[100];

	switch ( generictype )
	{
		case GENERIC_TYPE_GENERIC_CONTROLLER:
			return "Generic Controller";
		case GENERIC_TYPE_STATIC_CONTROLLER:
			return "Static Controller";
		case GENERIC_TYPE_AV_CONTROL_POINT:
			return "AV Control Point";
		case GENERIC_TYPE_DISPLAY:
			return "Display";
		case GENERIC_TYPE_GARAGE_DOOR:
			return "Garage Door";
		case GENERIC_TYPE_THERMOSTAT:
			return "Thermostat";
		case GENERIC_TYPE_WINDOW_COVERING:
			return "Window Covering";
		case GENERIC_TYPE_REPEATER_SLAVE:
			return "Repeating Slave";
		case GENERIC_TYPE_SWITCH_BINARY:
			return "Binary Switch";
		case GENERIC_TYPE_SWITCH_MULTILEVEL:
			return "Multilevel Switch";
		case GENERIC_TYPE_SWITCH_REMOTE:
			return "Remote Switch";
		case GENERIC_TYPE_SWITCH_TOGGLE:
			return "Toggle Switch";
		case GENERIC_TYPE_ZIP_GATEWAY:
			return "Zip Gateway";
		case GENERIC_TYPE_ZIP_NODE:
			return "Zip Node";
		case GENERIC_TYPE_SENSOR_BINARY:
			return "Binary Sensor";
		case GENERIC_TYPE_SENSOR_MULTILEVEL:
			return "Multilevel Sensor";
		case GENERIC_TYPE_WATER_CONTROL:
			return "Water Control";
		case GENERIC_TYPE_METER_PULSE:
			return "Pulse Meter";
		case GENERIC_TYPE_METER:
			return "Meter";
		case GENERIC_TYPE_ENTRY_CONTROL:
			return "Entry Control";
		case GENERIC_TYPE_SEMI_INTEROPERABLE:
			return "Semi Interoperable";
		case GENERIC_TYPE_SENSOR_ALARM:
			return "Alarm Sensor";
		case GENERIC_TYPE_NON_INTEROPERABLE:
			return "Non Interoperable";			
		default:
		{
			// We report UNKNOWN including the 0xYY hexcode
			snprintf( str_tmp, 100, "UNKNOWN (0x%02X)", generictype );
			return string(str_tmp).c_str();
		}
	}
}

///////////////////////////////////////////////////////////////////////////////

}
