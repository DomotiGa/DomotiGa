//-----------------------------------------------------------------------------
//
// DomoZWave a C++/C-wrapper to add open-zwave support to DomotiGa.
// Special thanks to Jaren for creating the wrapper.
//
// DomotiGa - an open source home automation program
// Copyright(C) 2008-2012 Ron Klinkien
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

// system
#include <iostream>
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
// Variables
//-----------------------------------------------------------------------------

// the HomeId for our controller, needs fix if people use multiple home id's.
int home;
int controllerid;

// Define serialport string, we require the serialport if we want to stop the
//  Open Z-Wave library properly
string serialPortName = "";

xmlrpc_env env;
xmlrpc_client* clientP;
char url[35];
bool debugging;

static pthread_mutex_t g_criticalSection;

// Define map/hash to store COMMAND_CLASS_BASIC to other COMMAND_CLASS mapping
// This prevents multi ValueChanged events for a single event en fixes also a
// mixture of Byte and Bool values
// NOTE: This information is known in the Open Z-Wave library, but not accessible
//       for us. Maybe in the future this is possible? 
std::map<string, int> MapCommandClassBasic;

///////////////////////////////////////////////////////////////////////////////

// To enable polling we need a nodeId->ValueID mapping. 
// I asked on the mailing list and the only suggestion I got
// was to store them off when the values are added. 
// So we store a list of structs to hold this mapping.

typedef struct
{
	uint32		m_homeId;
	uint8		m_nodeId;
	uint8		basicmapping;
	std::map<int,string> instanceLabel;
	string		commandclass;
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

	if ( ( _log == LogLevel_Error ) || ( ( _log == LogLevel_Debug ) && ( debugging ) ) ) 
	{
		va_start (args, _format);
		vsnprintf (buffer, 1023, _format, args);

		if ( _newline == true ) cout << endl;
		cout << OZW_datetime << " [DomoZwave] " << buffer << endl;

		va_end (args);
	}
}

///////////////////////////////////////////////////////////////////////////////
// RPC Helper Functions
///////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
// <fault_occured>
//
//-----------------------------------------------------------------------------

bool fault_occurred(xmlrpc_env* env)
{
	if ( env->fault_occurred )
	{
		WriteLog(LogLevel_Error, true, "ERROR: XML-RPC Fault: %s (%d)", env->fault_string, env->fault_code); 
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
	string label =  Manager::Get()->GetValueLabel( valueID );
	int instanceID = valueID.GetInstance();
	int type = valueID.GetType();
	char dev_value[64];
	char tmp_dev_value[64];
	uint8 byte_value;
	bool bool_value;
	string decimal_value;
	string list_value;
	string string_value;
	int int_value;
	int16 short_value;
	int value_no = 0;
	string str_tmp;

	WriteLog(LogLevel_Debug, true, "%s: HomeId=%d Node=%d", (add)?"ValueAdded":"ValueChanged", homeID, nodeID);
	WriteLog(LogLevel_Debug, false, "Genre=%d", genre);
	WriteLog(LogLevel_Debug, false, "GenreName=%s", DomoZWave_GenreIdName(genre));
	WriteLog(LogLevel_Debug, false, "CommandClassId=%d", id);
	WriteLog(LogLevel_Debug, false, "CommandClassName=%s", DomoZWave_CommandClassIdName(id));
	WriteLog(LogLevel_Debug, false, "Instance=%d", instanceID);
	WriteLog(LogLevel_Debug, false, "Index=%d", valueID.GetIndex());
	WriteLog(LogLevel_Debug, false, "Label=%s", label.c_str());
	WriteLog(LogLevel_Debug, false, "Units=%s",Manager::Get()->GetValueUnits( valueID ).c_str());

/*
	if ( add )
	{
		Manager::Get()->SetChangeVerified( valueID, true );
	}
*/
	switch ( type )
	{
		case ValueID::ValueType_Bool:
		{
			Manager::Get()->GetValueAsBool(valueID, &bool_value );
			snprintf(dev_value, 64, "%i", bool_value);
			WriteLog(LogLevel_Debug, false, "Type=Bool (raw value=%s)", dev_value);
			break;
		}
		case ValueID::ValueType_Byte:
		{
			Manager::Get()->GetValueAsByte(valueID, &byte_value );
			snprintf(dev_value, 64, "%i", byte_value);
			WriteLog(LogLevel_Debug, false, "Type=Byte (raw value=%s)", dev_value);
			break;
		}
		case ValueID::ValueType_Decimal:
		{
			Manager::Get()->GetValueAsString(valueID, &decimal_value );
			snprintf(dev_value, 64, "%s", strdup(decimal_value.c_str()));
			WriteLog(LogLevel_Debug, false, "Type=Decimal (raw value=%s)", dev_value);
			break;
		}
		case ValueID::ValueType_Int:
		{
			Manager::Get()->GetValueAsInt(valueID, &int_value );
			snprintf(dev_value, 64, "%d", int_value);
			WriteLog(LogLevel_Debug, false, "Type=Integer (raw value=%s)", dev_value);
			break;
		}
		case ValueID::ValueType_Short:
		{
			Manager::Get()->GetValueAsShort(valueID, &short_value );
			snprintf(dev_value, 64, "%d.h", short_value);
			WriteLog(LogLevel_Debug, false, "Type=Short (raw value=%s)", dev_value);
			break;
		}
		case ValueID::ValueType_Schedule:
		{
			WriteLog(LogLevel_Debug, false, "Type=Schedule (not implemented)");
			return;
			//break;
		}
		case ValueID::ValueType_String:
		{
			Manager::Get()->GetValueAsString(valueID, &string_value );
			snprintf(dev_value, 64, "%s", strdup(string_value.c_str()));
			WriteLog(LogLevel_Debug, false, "Type=String (raw value=%s)", dev_value);
			break;
		}
		case ValueID::ValueType_Button:
		{
			WriteLog(LogLevel_Debug, false, "Type=Button (not implemented)");
			return;
			//break;
		}
		case ValueID::ValueType_List:
		{
			Manager::Get()->GetValueListSelection(valueID, &list_value );
			snprintf(dev_value, 64, "%s", strdup(list_value.c_str()));
			WriteLog(LogLevel_Debug, false, "Type=List (raw value=%s)", dev_value);
			break;
		}
		default:
		WriteLog(LogLevel_Debug, false, "Type=Unknown");
		return;
	}

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

	// Most devices map their COMMAND_CLASS_BASIC to another COMMAND_CLASS_*. In the following code
	// we do this mapping, because else it is possible we get different values e.g. "255", "Dim 99",
	// "Open" for the EXACT same event on the device. This is ofcourse not what we want in DomotiGa,
	// because every value change is recorded and displayed.

	// Get NodeInfo information
	if ( NodeInfo* nodeInfo = GetNodeInfo( homeID, nodeID ) )
	{
		// If we are CommandClass Basic and mapping is enabled for this device
		if ( ( id == COMMAND_CLASS_BASIC ) && (nodeInfo->basicmapping > 0 ) )
		{

			// We have a mapping, we report it to the logfile
			WriteLog(LogLevel_Debug, false, "Mapping=COMMAND_CLASS_BASIC mapped to %s", DomoZWave_CommandClassIdName(nodeInfo->basicmapping));


			// Check if the COMMAND_CLASS_BASIC has ValueType=Byte, otherwise our code doesn't work properly
			if ( type != ValueID::ValueType_Byte ) {
				WriteLog(LogLevel_Error, false, "ERROR: %s: HomeId=%d Node=%d - Node doesn't have Type=Byte for COMMAND_CLASS_BASIC (most likely Z-Wave device doesn't comply to the standards) - Please report this as a BUG/FEATURE", (add)?"ValueAdded":"ValueChanged", homeID, nodeID);

				// We don't exit, because *maybe* the following code can make something usefull of the none-standard
			}

			// Find ValueID
			for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
			{
				ValueID v = *it;

				// We only support index=0, because a basic mapping can't support multiple indexes
				if ( ( nodeInfo->basicmapping == v.GetCommandClassId() ) && ( instanceID == v.GetInstance() ) && ( v.GetIndex() == 0 ) )
				{
					// We found it, now do some magic to map basic to the special CommandClass

					// Overrule the CommandClass
					id = nodeInfo->basicmapping;

					// We also need to overrule the label, else the other code breaks
					label = Manager::Get()->GetValueLabel( v );
					WriteLog(LogLevel_Debug, false, "Mapping=Label=%s", label.c_str());

					// CommandClass Basic is always a Byte value, but we need to convert 
					// to the "right" value type Bool, Decimal, Int or Short
					switch ( v.GetType() )
					{
						case ValueID::ValueType_Bool:
						{
							if ( strcmp(dev_value, "0" ) == 0 )
							{
								strcpy(dev_value, "0");
							} else {
								strcpy(dev_value, "1");
							}

							WriteLog(LogLevel_Debug, false, "Mapping=Type=Bool (raw value=%s)", dev_value);
							break;
						}
						case ValueID::ValueType_Byte:
						{
							// Don't need to do anything, possible other scenario 
							// are fixed later

							WriteLog(LogLevel_Debug, false, "Mapping=Type=Byte (raw value=%s)", dev_value);
							break;
						}
						case ValueID::ValueType_Decimal:
						{
							WriteLog(LogLevel_Debug, false, "Mapping=Type=Decimal (raw value=%s)", dev_value);
							break;
						}
						case ValueID::ValueType_Int:
						{
							WriteLog(LogLevel_Debug, false, "Mapping=Type=Integer (raw value=%s)", dev_value);
							break;
						}
						case ValueID::ValueType_Short:
						{
							WriteLog(LogLevel_Debug, false, "Mapping=Type=Short (raw value=%s)", dev_value);
							break;
						}
						case ValueID::ValueType_String:
						{
							WriteLog(LogLevel_Debug, false, "Mapping=Type=String (raw value=%s)", dev_value);
							break;
						}
						default:
						WriteLog(LogLevel_Error, true, "ERROR: HomeId=%d Node=%d - BasicMapping - Unknown ValueType=%d", homeID, nodeID, v.GetType() );
						return;
					}


					if ( label == "Level" ) {

						// If we map Basic to Level, 255 -> Dim 99
						if ( strcmp(dev_value, "255" ) == 0 )
						{
							strcpy(dev_value, "99");
						}
					}

					break;
				} 
			}

		} else {
			WriteLog(LogLevel_Debug, false, "Mapping=None");
		}

	} else {
		WriteLog(LogLevel_Error, false, "ERROR: %s: HomeId=%d Node=%d - Node exists in Z-Wave Network, but not in internal Open-ZWave wrapper list - Please report this as a BUG", (add)?"ValueAdded":"ValueChanged", homeID, nodeID);
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

				if ( strcmp(dev_value, "255" ) == 0 ) 
				{
					strcpy(dev_value, "On");
				}
				else if ( strcmp(dev_value, "99" ) == 0 ) 
				{
					strcpy(dev_value, "On");
				}
				else if ( strcmp(dev_value, "1" ) == 0 ) 
				{
					strcpy(dev_value, "On");
				}
				else if ( strcmp(dev_value, "0" ) == 0 ) 
				{
					strcpy(dev_value, "Off");
				}
/*
				else
				{
					sprintf(tmp_dev_value, "Dim %s", dev_value);
					strcpy(dev_value, tmp_dev_value);
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

				if ( strcmp(dev_value, "1") == 0 ) 
				{
					strcpy(dev_value, "On");
				} else {
					strcpy(dev_value, "Off");
				}
			}

			break;
		}
		case COMMAND_CLASS_SWITCH_MULTILEVEL:
		{	
			if ( label == "Level" )
			{
				value_no = 1;

				sprintf(tmp_dev_value, "Dim %s", dev_value);
				strcpy(dev_value, tmp_dev_value);

				if ( strcmp(dev_value, "Dim 0") == 0 )
				{
					strcpy(dev_value, "Off");
				}
				else if ( strcmp(dev_value, "Dim 99") == 0 )
				{
					strcpy(dev_value, "On");
				}
				else if ( strcmp(dev_value, "Dim 100") == 0 )
				{
					strcpy(dev_value, "On");
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
			else if ( label == "Energy" )
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

				if ( strcmp(dev_value, "1") == 0 )
				{
					// Closed
					strcpy(dev_value, "On");
				}
				else
				{
					// Open
					strcpy(dev_value, "Off");
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

				if ( strcmp(dev_value, "0") == 0 )
				{
					strcpy(dev_value, "Secure");
				}
				else
				{
					strcpy(dev_value, "Tamper");
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
	if ( add )
	{
		WriteLog(LogLevel_Debug, false, "Min=%d", Manager::Get()->GetValueMin( valueID ));
		WriteLog(LogLevel_Debug, false, "Max=%d", Manager::Get()->GetValueMax( valueID ));

		if ( value_no > 0 )
		{
			WriteLog(LogLevel_Debug, false, "Value%d=%s", value_no, dev_value);
		}
		else
		{
			WriteLog(LogLevel_Debug, false, "Value=%s", dev_value);
		}

		if ( ( Manager::Get()->GetValueHelp( valueID ) != "" ) && ( add ) )
		{
			WriteLog(LogLevel_Debug, false, "Help=%s", Manager::Get()->GetValueHelp( valueID ).c_str());
		}

		if ( NodeInfo* nodeInfo = GetNodeInfo( homeID, nodeID ) )
		{
			// Add to the nodeInfo commandclass list
			str_tmp = string(DomoZWave_CommandClassIdName(id));
			str_tmp.append("|");

			if ( nodeInfo->commandclass == "" )
			{
				nodeInfo->commandclass = "|";
				nodeInfo->commandclass.append(str_tmp);
			}
			else
			{
				if ( nodeInfo->commandclass.find(str_tmp) == string::npos )
				{
					nodeInfo->commandclass.append(str_tmp);
				}
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
				if ( nodeInfo->instanceLabel.find(instanceID) != nodeInfo->instanceLabel.end() )
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
		}

		WriteLog(LogLevel_Debug, false, "Note=Value not send to DomotiGa to with ValueAdd (values are unreliable at startup)");
		return;
	}

	// Only send it to DomotiGa if the value is >0 (1, 2, 3, 4 or 255)
	if ( value_no > 0 )
	{
		// If we have a list of instanceLabels, write it to the debug logfile
		if ( NodeInfo* nodeInfo = GetNodeInfo( homeID, nodeID ) )
		{
			if ( nodeInfo->instanceLabel.find(instanceID) != nodeInfo->instanceLabel.end() )
			{
				//WriteLog(LogLevel_Debug, false, "Node=%d, Instance=%d, InstanceLabel=%s", nodeID, instanceID, nodeInfo->instanceLabel[instanceID].c_str());
				WriteLog(LogLevel_Debug, false, "InstanceLabel=%s", nodeInfo->instanceLabel[instanceID].c_str());

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
		}

		WriteLog(LogLevel_Debug, false, "Value%d=%s", value_no, dev_value);

		xmlrpc_value* resultP = NULL;
		xmlrpc_client_call2f(&env, clientP, url, "zwave.setvalue", &resultP, "(iiiis)", homeID, nodeID, instanceID, value_no, dev_value );
		if ( resultP )
		{
			xmlrpc_DECREF(resultP);
		}
	} else {
		WriteLog(LogLevel_Debug, false, "Value=%s", dev_value);
		WriteLog(LogLevel_Debug, false, "Note=Value not send to DomotiGa, CommandClassId & label combination isn't supported by DomotiGa");
	}
}

//-----------------------------------------------------------------------------
// <RPC_NodeAdd>
//
//-----------------------------------------------------------------------------

void RPC_NodeAdded( int homeID, int nodeID )
{
	WriteLog(LogLevel_Debug, true, "NodeAdd: HomeId=%d Node=%d", homeID, nodeID);
}

//-----------------------------------------------------------------------------
// <RPC_RemoveNode>
//
//-----------------------------------------------------------------------------

void RPC_NodeRemoved( int homeID, int nodeID )
{
	WriteLog(LogLevel_Debug, true, "NodeRemoved: HomeId=%d Node=%d", homeID, nodeID);
}

//-----------------------------------------------------------------------------
// <RPC_NodeNew>
//
//-----------------------------------------------------------------------------

void RPC_NodeNew( int homeID, int nodeID )
{
	WriteLog(LogLevel_Debug, true, "NodeNew: HomeId=%d Node=%d", homeID, nodeID);
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
	uint8 version = Manager::Get()->GetNodeVersion( homeID, nodeID); 
	uint8 basicmapping = 0;
	char buffer[50];

	// Get NodeInfo information
	if ( NodeInfo* nodeInfo = GetNodeInfo( homeID, nodeID ) )
	{
		// This is a "new" node, we set basicmapping to 0 now
		nodeInfo->basicmapping = 0;

		// Convert Generic+Specific to string
		snprintf(buffer,20, "0x%02X|0x%02X", generic, specific);

		// Check if we have a mapping in our map table
		if ( MapCommandClassBasic.find(buffer) != MapCommandClassBasic.end() )
		{
			nodeInfo->basicmapping = MapCommandClassBasic[buffer];
			basicmapping = MapCommandClassBasic[buffer];
		} else {

			// We didn't find a Generic+Specifc in the table, now we check
			// for Generic only
			snprintf(buffer,20, "0x%02X", generic);

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

	WriteLog(LogLevel_Debug, true, "NodeProtocolInfo: HomeId=%d Node=%d", homeID, nodeID);
	WriteLog(LogLevel_Debug, false, "Basic=%d", basic);
	WriteLog(LogLevel_Debug, false, "Generic=%d", generic);
	WriteLog(LogLevel_Debug, false, "Specific=%d", specific);
	WriteLog(LogLevel_Debug, false, "Type=%s", nodetype);
	if ( basicmapping > 0 ) {
		WriteLog(LogLevel_Debug, false, "Mapping=COMMAND_CLASS_BASIC maps to %s", DomoZWave_CommandClassIdName(basicmapping));
	}
	WriteLog(LogLevel_Debug, false, "Listening=%s", (listening)?"true":"false");
	WriteLog(LogLevel_Debug, false, "FrequentListening=%s", (frequentlistening)?"true":"false");
	WriteLog(LogLevel_Debug, false, "Beaming=%s", (beaming)?"true":"false");
	WriteLog(LogLevel_Debug, false, "Routing=%s", (routing)?"true":"false");
	WriteLog(LogLevel_Debug, false, "MaxBaudRate=%d", maxbaudrate);
	WriteLog(LogLevel_Debug, false, "Version=%d", version);
	WriteLog(LogLevel_Debug, false, "Security=%s", (security)?"true":"false");
	WriteLog(LogLevel_Debug, false, "Name=%s", name);
	WriteLog(LogLevel_Debug, false, "Location=%s", location);

	xmlrpc_value* resultP = NULL;
 	xmlrpc_client_call2f(&env, clientP, url, "zwave.createnode", &resultP, "(iiiiiib)", nodeID, basic, generic, specific, capabilities, isecurity, sleeping );

	if ( resultP )
	{
		xmlrpc_DECREF(resultP);
	}
}

//-----------------------------------------------------------------------------
// <RPC_Group>
//
//-----------------------------------------------------------------------------

void RPC_Group( int homeID, int nodeID )
{
	WriteLog(LogLevel_Debug, true, "GroupEvent: HomeId=%d Node=%d", homeID, nodeID);
}

//-----------------------------------------------------------------------------
// <RPC_NodeEvent>
//
//-----------------------------------------------------------------------------

void RPC_NodeEvent( int homeID, int nodeID, ValueID valueID, int value )
{
	int instanceID = valueID.GetInstance();
	int value_no = 1;
	char dev_value[64];

	// Instance can never be zero, we need to be backwards compatible
	if ( instanceID == 0 ) {
		instanceID = 1;
	}

	WriteLog(LogLevel_Debug, true, "NodeEvent: HomeId=%d Node=%d", homeID, nodeID);
	WriteLog(LogLevel_Debug, false, "Instance=%d", instanceID);
	WriteLog(LogLevel_Debug, false, "Type=Byte (raw value=%d)", value);
	snprintf(dev_value, 64, "%d", value);

	if ( strcmp(dev_value, "255" ) == 0 )
	{
		strcpy(dev_value, "On");
	}
	else { 
		strcpy(dev_value, "Off");
	}

	WriteLog(LogLevel_Debug, false, "Value%d=%s", value_no, dev_value);

	xmlrpc_value* resultP = NULL;
	xmlrpc_client_call2f(&env, clientP, url, "zwave.setvalue", &resultP, "(iiiis)", homeID, nodeID, instanceID, value_no, dev_value );
	if ( resultP )
	{
		xmlrpc_DECREF(resultP);
	}
}

//-----------------------------------------------------------------------------
// <RPC_PollingEnabled>
//
//-----------------------------------------------------------------------------

void RPC_PollingEnabled( int homeID, int nodeID )
{
	WriteLog(LogLevel_Debug, true, "PollingEnabled: HomeId=%d Node=%d", homeID, nodeID);
}

//-----------------------------------------------------------------------------
// <RPC_PollingDisabled>
//
//-----------------------------------------------------------------------------

void RPC_PollingDisabled( int homeID, int nodeID )
{
	WriteLog(LogLevel_Debug, true, "PollingDisabled: HomeId=%d Node=%d", homeID, nodeID);
}

//-----------------------------------------------------------------------------
// <RPC_NodeNaming>
//
//-----------------------------------------------------------------------------

void RPC_NodeNaming( int homeID, int nodeID )
{
	WriteLog(LogLevel_Debug, true, "NodeNaming: HomeId=%d Node=%d", homeID, nodeID);
	WriteLog(LogLevel_Debug, false, "ManufacturerId=%s", Manager::Get()->GetNodeManufacturerId( homeID, nodeID ).c_str());
	WriteLog(LogLevel_Debug, false, "ManufacturerName=%s", Manager::Get()->GetNodeManufacturerName( homeID, nodeID ).c_str());
	WriteLog(LogLevel_Debug, false, "ProductType=%s, ProductId=%s", Manager::Get()->GetNodeProductType( homeID, nodeID ).c_str(), Manager::Get()->GetNodeProductId( homeID, nodeID ).c_str());
	WriteLog(LogLevel_Debug, false, "ProductName=%s", Manager::Get()->GetNodeProductName( homeID, nodeID ).c_str());
}

//-----------------------------------------------------------------------------
// <RPC_DriverReady>
//
//-----------------------------------------------------------------------------

void RPC_DriverReady( int homeID, int nodeID )
{
	home = homeID;
	controllerid = nodeID;

	WriteLog(LogLevel_Debug, true, "DriverReady: HomeId=%d Node=%d", homeID, nodeID);

	xmlrpc_value* resultP = NULL;
 	xmlrpc_client_call2f(&env, clientP, url, "zwave.setids", &resultP, "(ii)", homeID, nodeID );
	if ( resultP )
	{
		xmlrpc_DECREF(resultP);
	}

	resultP = NULL;
 	xmlrpc_client_call2f(&env, clientP, url, "zwave.removenodes", &resultP, "()" );
	if ( resultP )
	{
		xmlrpc_DECREF(resultP);
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
			break;
		}
		case Notification::Type_Group:
		{
			RPC_Group( (int)data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_NodeAdded:
		{
			NodeInfo* nodeInfo = new NodeInfo();
			nodeInfo->m_homeId = data->GetHomeId();
			nodeInfo->m_nodeId = data->GetNodeId();
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
		{
			if ( data->GetType() == Notification::Type_AllNodesQueried ) WriteLog(LogLevel_Debug, true, "AllNodesQueried: HomeId=%d", home);
			if ( data->GetType() == Notification::Type_AwakeNodesQueried ) WriteLog(LogLevel_Debug, true, "AwakeNodesQueried: HomeId=%d", home);

			Manager::Get()->WriteConfig( home );

			xmlrpc_value* resultP = NULL;
			pthread_mutex_unlock( &g_criticalSection );
 			xmlrpc_client_call2f(&env, clientP, url, "zwave.allqueried", &resultP, "()" );
			if ( resultP )
			{
				xmlrpc_DECREF(resultP);
			}
			break;
		}
		case Notification::Type_CreateButton:
		{
			WriteLog(LogLevel_Debug, true, "CreateButton: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId());
			WriteLog(LogLevel_Debug, false, "ButtonId=%d", (int)data->GetButtonId());
			break;
		}	
		case Notification::Type_DeleteButton:
		{
			WriteLog(LogLevel_Debug, true, "DeleteButton: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId());
			WriteLog(LogLevel_Debug, false, "ButtonId=%d", (int)data->GetButtonId() );
			break;
		}	
		case Notification::Type_ButtonOn:
		{
			WriteLog(LogLevel_Debug, true, "ButtonOn: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId());
			WriteLog(LogLevel_Debug, false, "ButtonId=%d", (int)data->GetButtonId());
			break;
		}	
		case Notification::Type_ButtonOff:
		{
			WriteLog(LogLevel_Debug, true, "ButtonOff: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId());
			WriteLog(LogLevel_Debug, false, "ButtonId=%d", (int)data->GetButtonId());
			break;
		}	
		case Notification::Type_DriverFailed:
		{
			WriteLog(LogLevel_Error, true, "ERROR: DriverFailed !");
			break;
		}
		case Notification::Type_DriverReset:
		{
			WriteLog(LogLevel_Error, true, "ERROR: DriverReset !");
			break;
		}
		case Notification::Type_EssentialNodeQueriesComplete:
		{
			WriteLog(LogLevel_Debug, true, "EssentialNodeQueriesComplete: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId());
			break;
		}
		case Notification::Type_MsgComplete:
		{
			WriteLog(LogLevel_Debug, true, "MsgComplete: HomeId=%d", (int)data->GetHomeId());
			break;
		}
		case Notification::Type_NodeNew:
		{
			RPC_NodeNew( (int)data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_NodeQueriesComplete:
		{
			WriteLog(LogLevel_Debug, true, "NodeQueriesComplete: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId());
			break;
		}
		case Notification::Type_ValueRefreshed:
		{
			WriteLog(LogLevel_Debug, true, "ValueRefreshed: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId());
			break;
		}
/*
	========== Type_SceneEvent ===========
	Added in Open Z-Wave revision 556
	Currently DomotiGa doesn't need it yet
	======================================

		case Notification::Type_SceneEvent:
		{
			WriteLog(LogLevel_Debug, true, "SceneEvent: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId());
			break;
		}
*/
		case Notification::Type_Error:
		{
			WriteLog(LogLevel_Error, true, "ERROR: HomeId=%d Node=%d", (int)data->GetHomeId(), (int)data->GetNodeId());
			WriteLog(LogLevel_Error, false, "ErrorCode=%d", (int)data->GetErrorCode());
			break;
		}
		default:
		break;
	}

	pthread_mutex_unlock( &g_criticalSection );
}

///////////////////////////////////////////////////////////////////////////////
// C style bindings are required since we call these functions from gambas.
///////////////////////////////////////////////////////////////////////////////

extern "C" {

//-----------------------------------------------------------------------------
// <DomoZWave_Version>
// Function to get the DomoZWave version, to determine if the user need to
// recompile his/her wrapper. If we just call the wrapper, this can cause
// segmentation fault #11.
//-----------------------------------------------------------------------------

int DomoZWave_Version()
{
	return 1;
}

//-----------------------------------------------------------------------------
// <DomoZWave_HomeIdPresent>
//
//-----------------------------------------------------------------------------

bool DomoZWave_HomeIdPresent( const char* _param )
{
	if ( home == 0 ) {
		WriteLog(LogLevel_Error, false, "ERROR: %s - HomeId=0, can't continue", _param);
		return false;
	} else {
		return true;
	}
}

//-----------------------------------------------------------------------------
// <DomoZWave_Init>
// Initializes the Open-Zwave Wrapper
//-----------------------------------------------------------------------------

void DomoZWave_Init( const char* serialPort, int rpcPort, const char* configdir, const char* zwdir, bool enableLog, int polltime )
{
	// Call the InitVars procedure to initialize all local variables
	InitVars();

	debugging = enableLog;

	WriteLog(LogLevel_Debug, true, "Initializing Open-ZWave Wrapper");

	pthread_mutexattr_t mutexattr;

	pthread_mutexattr_init ( &mutexattr );
	pthread_mutexattr_settype( &mutexattr, PTHREAD_MUTEX_RECURSIVE );
	pthread_mutex_init( &g_criticalSection, &mutexattr );
	pthread_mutexattr_destroy( &mutexattr );

	sprintf( url, "http://localhost:%d", rpcPort ); 

	Options::Create( configdir, zwdir, "" );
	Options::Get()->AddOptionBool("AppendLogFile", false);
	Options::Get()->AddOptionBool("ConsoleOutput", false);

	if ( enableLog )
	{
		Options::Get()->AddOptionInt("SaveLogLevel", LogLevel_Detail );
	  	Options::Get()->AddOptionInt("QueueLogLevel", LogLevel_Debug);
	   	Options::Get()->AddOptionInt("DumpTriggerLevel", LogLevel_Error);
	}

	Options::Get()->AddOptionInt("PollInterval", polltime);
	Options::Get()->AddOptionBool("IntervalBetweenPolls", true);
	Options::Get()->AddOptionBool("SuppressValueRefresh", false);

	Options::Get()->Lock();

	Manager::Create();
	Log::SetLoggingState( debugging );

	Manager::Get()->AddWatcher( OnNotification, NULL );
	Manager::Get()->AddDriver( serialPort );

	// Store the serialPort used
	serialPortName = serialPort; 

 	// Initialize our error-handling environment.
 	xmlrpc_env_init(&env);
 	xmlrpc_client_setup_global_const(&env);
 	xmlrpc_client_create(&env, XMLRPC_CLIENT_NO_FLAGS, "DomoZWaveClient", "1.0", NULL, 0, &clientP);
	if ( fault_occurred(&env) ) return;
}

//-----------------------------------------------------------------------------
// <DomoZWave_Destroy>
// Stops the Open-Zwave wrapper
//-----------------------------------------------------------------------------

void DomoZWave_Destroy()
{
	pthread_mutex_lock( &g_criticalSection );

	if ( serialPortName != "" ) {
		Manager::Get()->RemoveDriver( serialPortName );
	}

	Manager::Get()->RemoveWatcher( OnNotification, NULL );

	//cout << OZW_datetime << "Destroyed xmlrpc" << endl;
	Manager::Get()->Destroy();
	//cout << OZW_datetime << "Destroyed manager" << endl;
	Options::Get()->Destroy();
	//cout << OZW_datetime << "Destroyed options" << endl;

	pthread_mutex_unlock( &g_criticalSection );
	pthread_mutex_destroy( &g_criticalSection );

	serialPortName = "";

	// Clean up our error-handling environment. 
	xmlrpc_env_clean(&env);

	xmlrpc_client_destroy(clientP);

	WriteLog(LogLevel_Debug, true, "Destroyed Open-ZWave Wrapper");
}

//-----------------------------------------------------------------------------
// <DomoZWave_EnablePolling>
//
//-----------------------------------------------------------------------------

void DomoZWave_EnablePolling( int node, int32 polltime )
{
	if ( DomoZWave_HomeIdPresent("EnablePolling") == false ) return;

	if ( Manager::Get()->GetNodeBasic( home, node ) < 0x03 )
	{	
		return;
	}

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
	   	// Mark the basic command class values for polling
		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
 			ValueID v = *it;
			if ( v.GetCommandClassId() == 0x20 )
			{
				Manager::Get()->EnablePoll( *it, 2 );

				WriteLog(LogLevel_Debug, true, "Enabled Polling for HomeId=%d Node=%d", home, node);

				break;
			}
		}
	}
}

//-----------------------------------------------------------------------------
// <DomoZWave_DisablePolling>
//
//-----------------------------------------------------------------------------

void DomoZWave_DisablePolling( int node )
{
	if ( DomoZWave_HomeIdPresent("DisablePolling") == false ) return;

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
	   	// disable polling for all values of this node
		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			Manager::Get()->DisablePoll( *it );	
			WriteLog(LogLevel_Debug, true, "Disabled Polling for HomeId=%d Node=%d", home, node);
		}
	}
}

//-----------------------------------------------------------------------------
// <DomoZWave_RequestNodeState>
//
//-----------------------------------------------------------------------------

void DomoZWave_RequestNodeState( int node )
{
	if ( DomoZWave_HomeIdPresent("RequestNodeState") == false ) return;

	WriteLog(LogLevel_Debug, true, "RequestNodeState for HomeId=%d Node=%d", home, node);

	Manager::Get()->RequestNodeState( home, node );
}

//-----------------------------------------------------------------------------
// <DomoZWave_RequestNodeDynamic>
//
//-----------------------------------------------------------------------------

void DomoZWave_RequestNodeDynamic( int node )
{
	if ( DomoZWave_HomeIdPresent("RequestNodeDynamic") == false ) return;

	WriteLog(LogLevel_Debug, true, "RequestNodeDynamic for HomeId=%d Node=%d", home, node);

	Manager::Get()->RequestNodeDynamic( home, node );
}

//-----------------------------------------------------------------------------
// <DomoZWave_RequestNetworkUpdate>
//
//-----------------------------------------------------------------------------

void DomoZWave_RequestNetworkUpdate( )
{
	if ( DomoZWave_HomeIdPresent("RequestNetworkUpdate") == false ) return;

	WriteLog(LogLevel_Debug,true,"RequestNetworkUpdate All nodes HomeId=%d", home);

	Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_RequestNetworkUpdate, NULL, NULL, false, 0xff );
}

//-----------------------------------------------------------------------------
// <DomoZWave_RequestNodeNeighborUpdate>
//
//-----------------------------------------------------------------------------

void DomoZWave_RequestNodeNeighborUpdate( int node )
{
	if ( DomoZWave_HomeIdPresent("RequestNodeNeighborUpdate") == false ) return;

	WriteLog(LogLevel_Debug, true, "RequestNodeNeighborUpdate for HomeId=%d Node=%d", home, node);

	Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_RequestNodeNeighborUpdate, NULL, NULL, false, node );
}

//-----------------------------------------------------------------------------
// <DomoZWave_AddDevice>
//
//-----------------------------------------------------------------------------

void DomoZWave_AddDevice( )
{
	if ( DomoZWave_HomeIdPresent("Controller AddDevice") == false ) return;

	WriteLog(LogLevel_Debug, true, "Controller AddDevice for HomeId=%d", home);

	Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_AddDevice, NULL, NULL, true, 0xff );
}

//-----------------------------------------------------------------------------
// <DomoZWave_RemoveDevice>
//
//-----------------------------------------------------------------------------

void DomoZWave_RemoveDevice( int node )
{
	if ( DomoZWave_HomeIdPresent("Controller RemoveDevice") == false ) return;

	WriteLog(LogLevel_Debug, true, "Controller RemoveDevice for HomeId=%d Node=%d", home, node);

	Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_RemoveDevice, NULL, NULL, false, node );
}

//-----------------------------------------------------------------------------
// <DomoZWave_CancelControllerCommand>
//
//-----------------------------------------------------------------------------

void DomoZWave_CancelControllerCommand( )
{
	if ( DomoZWave_HomeIdPresent("Controller CancelCommand") == false ) return;

	WriteLog(LogLevel_Debug, true, "Controller CancelCommand for HomeId=%d", home);

	Manager::Get()->CancelControllerCommand( home );
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetConfigParam>
//
//-----------------------------------------------------------------------------

void DomoZWave_SetConfigParam( int node, int param, int value, int size )
{
	if ( DomoZWave_HomeIdPresent("SetConfigParam") == false ) return;

	WriteLog(LogLevel_Debug, true, "SetConfigParam for HomeId=%d Node=%d", home, node);
	WriteLog(LogLevel_Debug, false, "Parameter=%d", param);
	WriteLog(LogLevel_Debug, false, "Value=%d", value);
	WriteLog(LogLevel_Debug, false, "Size=%d", size);

	Manager::Get()->SetConfigParam( home, node, param, value, size);
}

//-----------------------------------------------------------------------------
// <DomoZWave_RequestConfigParam>
//
//-----------------------------------------------------------------------------

void DomoZWave_RequestConfigParam( int node, int param ) 
{
	if ( DomoZWave_HomeIdPresent("RequestConfigParam") == false ) return;

	WriteLog(LogLevel_Debug, true, "RequestConfigParam for HomeId=%d Node=%d", home, node);
	WriteLog(LogLevel_Debug, false, "Parameter=%d", param);

	Manager::Get()->RequestConfigParam( home, node, param );
}

//-----------------------------------------------------------------------------
// <DomoZWave_RequestAllConfigParams>
//
//-----------------------------------------------------------------------------

void DomoZWave_RequestAllConfigParams( int node )
{
	if ( DomoZWave_HomeIdPresent("RequestAllConfigParams") == false ) return;

	WriteLog(LogLevel_Debug, true, "RequestAllConfigParam for HomeId=%d Node=%d", home, node);

	Manager::Get()->RequestAllConfigParams( home, node );
}

//-----------------------------------------------------------------------------
// <DomoZWave_AddAssociation>
//
//-----------------------------------------------------------------------------

void DomoZWave_AddAssociation( int node, int group, int otherNode )
{
        if ( DomoZWave_HomeIdPresent("AddAssociation") == false ) return;

	WriteLog(LogLevel_Debug, true, "AddAssociation for HomeId=%d Node=%d", home, node);
	WriteLog(LogLevel_Debug, false, "Group=%d, Node=%d", group, otherNode);

        Manager::Get()->AddAssociation( home, node, group, otherNode);
        Manager::Get()->RefreshNodeInfo( home, node);
}

//-----------------------------------------------------------------------------
// <DomoZWave_RemoveAssociation>
//
//-----------------------------------------------------------------------------

void DomoZWave_RemoveAssociation( int node, int group, int otherNode )
{
        if ( DomoZWave_HomeIdPresent("RemoveAssociation") == false ) return;

	WriteLog(LogLevel_Debug, true, "RemoveAssociation for HomeId=%d Node=%d", home, node);
	WriteLog(LogLevel_Debug, false, "Group=%d, Node=%d", group, otherNode);

        Manager::Get()->RemoveAssociation( home, node, group, otherNode);
        Manager::Get()->RefreshNodeInfo( home, node);
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetValue>
//
//-----------------------------------------------------------------------------

void DomoZWave_SetValue( int node, int instance, int value )
{
	bool bool_value;
	int int_value;
	uint8 uint8_value;
	uint16 uint16_value;

        if ( DomoZWave_HomeIdPresent("SetValue") == false ) return;

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
		// Find the correct instance
		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			int id = (*it).GetCommandClassId();
			int inst = (*it).GetInstance();

			if ( id == COMMAND_CLASS_SWITCH_MULTILEVEL || id == COMMAND_CLASS_SWITCH_BINARY )
			{
				if ( inst == instance )
				{
			        	if ( ValueID::ValueType_Bool == (*it).GetType() )
                                	{
						bool_value = (bool)value;
						Manager::Get()->SetValue( *it, bool_value );
         	                       	}
                                	else if ( ValueID::ValueType_Byte == (*it).GetType() )
                                	{
						uint8_value = (uint8)value;
						Manager::Get()->SetValue( *it, uint8_value );
               		                }
               		                else if ( ValueID::ValueType_Short == (*it).GetType() )
                                	{
						uint16_value = (uint16)value;
						Manager::Get()->SetValue( *it, uint16_value );
                               		}
                                	else if ( ValueID::ValueType_Int == (*it).GetType() )
                                	{
						int_value = value;
						Manager::Get()->SetValue( *it, int_value );
                                	}
                                	else if ( ValueID::ValueType_List == (*it).GetType() )
                                	{
						Manager::Get()->SetValue( *it, value );
                                	}
                                	else
                                	{
						return;
                        		}

					WriteLog(LogLevel_Debug, true, "SetValue for HomeId=%d Node=%d", home, node);
					WriteLog(LogLevel_Debug, false, "CommandClassId=%d", id);
					WriteLog(LogLevel_Debug, false, "CommandClassName=%s", DomoZWave_CommandClassIdName(id));
					WriteLog(LogLevel_Debug, false, "Instance=%d", instance);
					WriteLog(LogLevel_Debug, false, "Value=%d", value);
                        	}
			}
                }
        }
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeManufacturerName>
//
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeManufacturerName( int node )
{
	string ManufacturerName;

        if ( DomoZWave_HomeIdPresent("GetNodeManufacturerName") == false ) return "";

	WriteLog(LogLevel_Debug, true, "GetNodeManufacturerName for HomeId=%d Node=%d", home, node);

	ManufacturerName = Manager::Get()->GetNodeManufacturerName( home, node );

	return ManufacturerName.c_str();

}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeProductName>
//
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeProductName( int node )
{
	string ProductName;

        if ( DomoZWave_HomeIdPresent("GetNodeProductName") == false ) return "";

	WriteLog(LogLevel_Debug, true, "GetNodeProductName for HomeId=%d Node=%d", home, node);

	ProductName = Manager::Get()->GetNodeProductName( home, node );

	return ProductName.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeName>
//
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeName( int node )
{
        if ( DomoZWave_HomeIdPresent("GetNodeName") == false ) return "";

	WriteLog(LogLevel_Debug, true, "GetNodeName for HomeId=%d Node=%d", home, node);

	return Manager::Get()->GetNodeName( home, node ).c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeLocation>
//
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeLocation( int node )
{
        if ( DomoZWave_HomeIdPresent("GetNodeLocation") == false ) return "";

	WriteLog(LogLevel_Debug, true, "GetNodeLocation for HomeId=%d Node=%d", home, node);

	return Manager::Get()->GetNodeLocation( home, node ).c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeManufacturerId>
//
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeManufacturerId( int node )
{
        if ( DomoZWave_HomeIdPresent("GetNodeManufacturerId") == false ) return "";

	WriteLog(LogLevel_Debug, true, "GetNodeManufacturerId for HomeId=%d Node=%d", home, node);

	return Manager::Get()->GetNodeManufacturerId( home, node ).c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeProductType>
//
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeProductType( int node )
{
        if ( DomoZWave_HomeIdPresent("GetNodeProductType") == false ) return "";

	WriteLog(LogLevel_Debug, true, "GetNodeProductType for HomeId=%d Node=%d", home, node);

	return Manager::Get()->GetNodeProductType( home, node ).c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeProductId>
//
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeProductId( int node )
{
        if ( DomoZWave_HomeIdPresent("GetNodeProductId") == false ) return "";

	WriteLog(LogLevel_Debug, true, "GetNodeProductId for HomeId=%d Node=%d", home, node);

	return Manager::Get()->GetNodeProductId( home, node ).c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetLibraryVersion>
//
//-----------------------------------------------------------------------------

const char* DomoZWave_GetLibraryVersion()
{
        if ( DomoZWave_HomeIdPresent("GetLibraryVersion") == false ) return "";

	WriteLog(LogLevel_Debug, true, "GetLibraryVersion for HomeId=%d", home);

	return Manager::Get()->GetLibraryVersion( home ).c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetLibraryTypeName>
//
//-----------------------------------------------------------------------------

const char* DomoZWave_GetLibraryTypeName()
{
        if ( DomoZWave_HomeIdPresent("GetLibraryTypeName") == false ) return "";

	WriteLog(LogLevel_Debug, true, "GetLibraryType for HomeId=%d", home);

	return Manager::Get()->GetLibraryTypeName( home ).c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_ControllerType>
// Retrieves the Z-Wave controller type, possible values are:
// Primary or Secondary and possible SUC and/or Bridge mode
//-----------------------------------------------------------------------------

const char* DomoZWave_ControllerType()
{
	string ctype;

        if ( DomoZWave_HomeIdPresent("ControllerType") == false ) return "";

	if ( Manager::Get()->IsPrimaryController ( home ) )
	{
		ctype = "Primary";
	}
	else
	{
		ctype = "Secondary";
	}

	if ( Manager::Get()->IsStaticUpdateController ( home ) && Manager::Get()->IsBridgeController ( home ) )
	{
		ctype.append(" (SUC/Bridge)");
	}
	else if ( Manager::Get()->IsStaticUpdateController ( home ) )
	{
		ctype.append(" (SUC)");
	}
	else if ( Manager::Get()->IsBridgeController ( home ) )
	{
		ctype.append(" (Bridge)");
	}

	return ctype.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeNeighborsList>
// Retrieves the list of neigbors and it will be displayed in the example format:
// 2, 3, 4, 6, 7
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeNeighborsList( int node )
{
	string neighborslist;
	uint8* neighbors;
	uint32 numNeighbors;
	char dev_value[64];

	if ( DomoZWave_HomeIdPresent("GetNodeNeighborsList") == false ) return "";

	numNeighbors = Manager::Get()->GetNodeNeighbors( home, node, &neighbors );

	for( uint32 i=0; i<numNeighbors; ++i )
	{
		// Convert integer to char
		snprintf(dev_value, 64, "%d", neighbors[i]);

		// Format the string with ", " and " and "
		if ( i != 0 )
		{
			neighborslist += ", ";
		}

		neighborslist += dev_value;
	}

	return neighborslist.c_str();

	// We convert from string to char*, because else garbage is reported to gambas
	char *tneighborslist;
	tneighborslist=new char [neighborslist.size()+1];
	strcpy(tneighborslist,neighborslist.c_str());
	return tneighborslist;
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeCommandClassList>
// Retrieves the list of supported COMMAND_CLASS'es for a node.
// The "COMMAND_CLASS_" string will not be included in the name.
// An example list is: BASIC, SWITCH_BINARY, NODE_NAMING, VERSION
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeCommandClassList( int node )
{
	string commandclass;

	if ( DomoZWave_HomeIdPresent("GetNodeCommandClassList") == false ) return "";

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
		commandclass = nodeInfo->commandclass;

		if ( commandclass != "" )
		{

			size_t start_pos = 0;
			string from = "COMMAND_CLASS_";
			string to = "";

			while((start_pos = commandclass.find(from, start_pos)) != string::npos) {
				commandclass.replace(start_pos, from.length(), to);
				start_pos += to.length();
			}

			start_pos = 0;
			from = "|";
			to = ", ";

			if ( commandclass.length() >= 1 )
			{
				commandclass.replace(0, 1, "");
			}

			while((start_pos = commandclass.find(from, start_pos)) != string::npos) {
				commandclass.replace(start_pos, from.length(), to);
				start_pos += to.length();
			}

			if ( commandclass.length() >= 2 )
			{
				commandclass.replace(commandclass.length() - 2, 2, "");
			}
		}
	}

	// We convert from string to char*, because else garbage is reported to gambas
	char *tcommandclass;
	tcommandclass=new char [commandclass.size()+1];
	strcpy(tcommandclass,commandclass.c_str());
	return tcommandclass;
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetSendQueueCount>
//-----------------------------------------------------------------------------

long DomoZWave_GetSendQueueCount()
{
	if ( DomoZWave_HomeIdPresent("GetSendQueueCount") == false ) return 0;
	return Manager::Get()->GetSendQueueCount( home );
}

//-----------------------------------------------------------------------------
// <DomoZWave_CommandClassIdName>
// Returns a readable name of a COMMAND_CLASS. If it is unknown, it will
// display "UNKNOWN"
//-----------------------------------------------------------------------------

const char* DomoZWave_CommandClassIdName(uint8 class_value)
{
	char str_tmp[100];

	switch (class_value)
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
			snprintf(str_tmp,20, "UNKNOWN (0x%02X)", class_value);
			return string(str_tmp).c_str();
		}
	}
}

//-----------------------------------------------------------------------------
// <DomoZWave_GenreIdName>
//
//-----------------------------------------------------------------------------

const char* DomoZWave_GenreIdName(uint8 genre)
{
	char str_tmp[100];

	switch (genre)
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
			snprintf(str_tmp,20, "UNKNOWN (0x%02X)", genre);
			return string(str_tmp).c_str();
		}
  }
}

///////////////////////////////////////////////////////////////////////////////

}
