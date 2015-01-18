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
// Define and get version numbers of DomoZWave and the open-zwave
//-----------------------------------------------------------------------------
char domozwave_vers[] = "DomoZWave version 2.10";
#include <vers.cpp> // OpenZWave 1.0.r706 and later

//-----------------------------------------------------------------------------

// system
#include <iostream>
#include <fstream>
#include <sstream>
#include <stdio.h>
#include <pthread.h>
#include <ctime>
#include <sys/time.h>
#include <map>

// json-rpc
#include <json/json.h>

// curl
#include <curl/curl.h>

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
// Define macro to easy convert integer to std::string
//-----------------------------------------------------------------------------

#define SSTR( x ) dynamic_cast< std::ostringstream & >( std::ostringstream() << std::dec << x ).str()

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

// Define serialport string, we require the serialport if we want to stop the Open Z-Wave library properly
list<string> serialPortName;

//
int32 jsonrpcid = 0;

// Enable/Disable DomoZWave debugging
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
	string		m_serialPort;
	uint32		m_homeId;
	uint8		m_controllerId;
	uint32		m_controllerAllQueried;
	bool		m_controllerBusy;
	uint8		m_nodeId;
	list<m_cmdItem>	m_cmd;
	uint8		m_userCodeEnrollNode;
	time_t		m_userCodeEnrollTime;
	time_t		m_lastWriteXML;
	bool		m_running;
	char		m_jsonrpcurl[255];
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

// Storage for configuration item modified for a certain amount of time. Otherwise
// the Open Z-Wave Commander can show the "old" value instead of the new value.
// Normally applicable for sleeping devices and during time-out of other devices.
// For sleeping devices the expiry time is based on the wake-up time and for
// listening devices we give it a minute orso.

typedef struct
{
        uint8		m_valuetype; // Numeric or List (string)
        int32		m_valuenumeric; // Store Bool, Byte, Integer, Short
	string		m_valuestring; // Store List
        time_t          m_expiretime; // When this value will expiry and the open-zwave stored value will be returned
} m_configItem;

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
	std::map<int,std::map<int,string> > instanceLabel;
	list<ValueID>	m_values;
	std::map<int,m_configItem*> m_config;
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
		tm->tm_hour, tm->tm_min, tm->tm_sec, (int)(tv.tv_usec / 1000) );

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
// <RPC_ValueRemoved>
// This is called if a Value is removed, normally happens when the controller
// shuts down
//-----------------------------------------------------------------------------

void RPC_ValueRemoved( uint32 homeID, int nodeID, ValueID valueID )
{
	int id = valueID.GetCommandClassId();
	int genre = valueID.GetGenre();

	WriteLog( LogLevel_Debug, true, "ValueRemoved: HomeId=0x%x Node=%d", homeID, nodeID );
	WriteLog( LogLevel_Debug, false, "Genre=%s (%d)", DomoZWave_GenreIdName(genre), genre );
	WriteLog( LogLevel_Debug, false, "CommandClass=%s (%d)",  DomoZWave_CommandClassIdName(id), id );
	WriteLog( LogLevel_Debug, false, "Instance=%d", valueID.GetInstance() );
	WriteLog( LogLevel_Debug, false, "Index=%d", valueID.GetIndex() );
}

//-----------------------------------------------------------------------------
// <RPC_ValueChanged>
// This is called when a device reports that a value has changed or added.
// If it was from a known command class we'll report that value back to DomotiGa.
//-----------------------------------------------------------------------------

void RPC_ValueChanged( uint32 homeID, int nodeID, ValueID valueID, bool add )
{
	int id = valueID.GetCommandClassId();
	int genre = valueID.GetGenre();
	string label = Manager::Get()->GetValueLabel( valueID );
	string unit = Manager::Get()->GetValueUnits( valueID );
	int instanceID = valueID.GetInstance();
	int type = valueID.GetType();
	char dev_value[1024];
	char dev_result[1024];
	string dev_label;
	int dev_index = 0;
	NodeInfo* nodeInfo;

	WriteLog( LogLevel_Debug, true, "%s: HomeId=0x%x Node=%d", (add)?"ValueAdded":"ValueChanged", homeID, nodeID );
	WriteLog( LogLevel_Debug, false, "Genre=%s (%d)", DomoZWave_GenreIdName(genre), genre );
	WriteLog( LogLevel_Debug, false, "CommandClass=%s (%d)",  DomoZWave_CommandClassIdName(id), id );
	WriteLog( LogLevel_Debug, false, "Instance=%d", instanceID );
	WriteLog( LogLevel_Debug, false, "Index=%d", valueID.GetIndex() );
	WriteLog( LogLevel_Debug, false, "Label=%s", label.c_str() );
	WriteLog( LogLevel_Debug, false, "Units=%s", unit.c_str() );

	nodeInfo = GetNodeInfo( homeID, nodeID );
	if ( nodeInfo == NULL )
	{
		WriteLog( LogLevel_Error, false, "ERROR: %s: HomeId=0x%x Node=%d - Node exists in Z-Wave Network, but not in internal Open-ZWave wrapper list - Please report this as a BUG", (add)?"ValueAdded":"ValueChanged", homeID, nodeID );
		return;
	}

	// We need to check which ValueType it is, before we can output it as a string
	switch ( type )
	{
		case ValueID::ValueType_Bool:
		{
			bool bool_value;
			Manager::Get()->GetValueAsBool( valueID, &bool_value );
			snprintf( dev_value, 1024, "%i", bool_value );
			WriteLog( LogLevel_Debug, false, "Type=Bool (raw value=%s)", dev_value );
			break;
		}
		case ValueID::ValueType_Byte:
		{
			uint8 byte_value;
			Manager::Get()->GetValueAsByte( valueID, &byte_value );
			snprintf( dev_value, 1024, "%i", byte_value );
			WriteLog( LogLevel_Debug, false, "Type=Byte (raw value=%s)", dev_value );
			break;
		}
		case ValueID::ValueType_Decimal:
		{
			string decimal_value;
			Manager::Get()->GetValueAsString( valueID, &decimal_value );
			snprintf( dev_value, 1024, "%s", strdup( decimal_value.c_str() ) );
			WriteLog( LogLevel_Debug, false, "Type=Decimal (raw value=%s)", dev_value );
			break;
		}
		case ValueID::ValueType_Int:
		{
			int int_value;
			Manager::Get()->GetValueAsInt( valueID, &int_value );
			snprintf( dev_value, 1024, "%d", int_value );
			WriteLog( LogLevel_Debug, false, "Type=Integer (raw value=%s)", dev_value );
			break;
		}
		case ValueID::ValueType_Short:
		{
			int16 short_value;
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
			string string_value;
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
			string list_value;
			Manager::Get()->GetValueListSelection( valueID, &list_value );
			snprintf( dev_value, 1024, "%s", strdup( list_value.c_str() ) );
			WriteLog( LogLevel_Debug, false, "Type=List (raw value=%s)", dev_value );
			break;
		}
		case ValueID::ValueType_Raw:
		{
			// We can use AsString on a Raw
			string string_value;
			Manager::Get()->GetValueAsString( valueID, &string_value );
			snprintf( dev_value, 1024, "%s", strdup( string_value.c_str() ) );
			WriteLog( LogLevel_Debug, false, "Type=Raw (raw value=%s)", dev_value );
			break;
		}
		default:
		WriteLog( LogLevel_Debug, false, "Type=Unknown" );
		return;
	}

	// If it is a ValueChange, CommandClass Basic and mapping is in place, override the id
	// This will map the Basic value to the SENSOR, BINARY_SWITCH, MULTILEVEL, etc
	if (( ! add ) && ( id == COMMAND_CLASS_BASIC ) && ( nodeInfo->basicmapping > 0 ) )
	{
		bool found = false;

		// Find the mapped commandclass
		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			if ( ( v.GetCommandClassId() == nodeInfo->basicmapping ) && ( v.GetInstance() == instanceID ) )
			{
				// No need to convert from Byte to Bool
				id = v.GetCommandClassId();
				label = Manager::Get()->GetValueLabel( v );
				found = true;
				break;
			}
		}

		// The mapped commandclass has to be found
		if ( ! found )
		{
WriteLog( LogLevel_Error, false, "ERROR: HomeId=0x%x Node=%d Instance=%d - CommandClass Basic can't be mapped to the '%s', because it doesn't exist (bug in device?)", homeID, nodeID, instanceID, DomoZWave_CommandClassIdName(nodeInfo->basicmapping) );
                        return;
		}
	}

	//////////////////////////////////////////////////////////////////////////////////////////

	switch ( id )
	{
		// We shouldn't see this COMMAND_CLASS_BASIC anymore, because it should be
		// mapped already. We leave it in for backwards compatibility reasons
		case COMMAND_CLASS_BASIC:
		{
			// A commandclass basic can only have label=basic and valuetype=byte
			if ( ( label == "Basic" ) && ( type == ValueID::ValueType_Byte ) && ( nodeInfo->basicmapping == 0 ) )
			{
				dev_index = 1;
				dev_label = label;

				if ( strcmp( dev_value, "255" ) == 0 )
				{
					strcpy(dev_result, "On" );
				}
				else if ( strcmp( dev_value, "100" ) == 0 )
				{
					strcpy( dev_result, "On" );
				}
				else if ( strcmp( dev_value, "99" ) == 0 )
				{
					strcpy( dev_result, "On" );
				}
				else if ( strcmp( dev_value, "1" ) == 0 )
				{
					strcpy( dev_result, "On");
				}
				else
				{
					strcpy( dev_result, "Off" );
				}
			}

			break;
		}
		case COMMAND_CLASS_SWITCH_BINARY:
		{
			if (( label == "Switch" ) && ( type == ValueID::ValueType_Bool ) )
			{
				dev_index = 2;
				dev_label = "Switch-Level";

				if ( strcmp( dev_value, "0" ) == 0 )
				{
					strcpy( dev_result, "Off" );
				} else {
					strcpy( dev_result, "On" );
				}
			}

			break;
		}
		case COMMAND_CLASS_SWITCH_MULTILEVEL:
		{	
			if ( ( label == "Level" ) && ( type == ValueID::ValueType_Byte ) )
			{
				dev_index = 2;
				dev_label = "Switch-Level";

				// Retrieve the value again, we need to check for >100
				uint8 byte_value;
				Manager::Get()->GetValueAsByte( valueID, &byte_value );

				if ( byte_value > 100 )
				{
					strcpy( dev_value, "100" );
				}

				sprintf( dev_result, "Dim %s", dev_value );

				if ( strcmp( dev_result, "Dim 0" ) == 0 )
				{
					strcpy( dev_result, "Off" );
				}
				else if ( strcmp( dev_result, "Dim 99" ) == 0 )
				{
					strcpy( dev_result, "On" );
				}
				else if ( strcmp( dev_result, "Dim 100" ) == 0 )
				{
					strcpy( dev_result, "On" );
				}
			}

			break;
		}
		case COMMAND_CLASS_METER:
		{
			if ( type == ValueID::ValueType_Decimal )
			{
				if ( ( label == "Power" ) && ( unit == "W" ) )
				{
					dev_index = 11;
					dev_label = "Power|W";
				}
				else if ( ( label == "Energy" ) && ( unit == "kWh" ) )
				{
					dev_index = 12;
					dev_label = "Energy|kWh";
				}
				else if ( label == "Power" ) // ### Doesn't exist! Only W maps to Power ###
				{
					dev_index = 13;
					dev_label = label;
				}
				else if ( label == "Energy" ) // ### kVAh ###
				{
					dev_index = 14;
					dev_label = label;
				}
				else if ( label == "Voltage" )
				{
					dev_index = 15;
					dev_label = label;
				}
				else if ( label == "Current" )
				{
					dev_index = 16;
					dev_label = label;
				}
				else if ( label == "Count" )
				{
					dev_index = 17;
					dev_label = label;
				}
				else if ( label == "Power Factor" )
				{
					dev_index = 18;
					dev_label = label;
				}
				else if ( ( label == "Gas" ) & ( unit == "cubic meters" ) )
				{
					dev_index = 19;
					dev_label = "Gas|cubic meters";
				}
				else if ( ( label == "Gas" ) & ( unit == "cubic feet" ) )
				{
					dev_index = 20;
					dev_label = "Gas|cubic feet";
				}
				else if ( ( label == "Gas" ) & ( unit == "pulses" ) )
				{
					dev_index = 21;
					dev_label = "Gas|pulses";
				}
				else if ( ( label == "Water" ) & ( unit == "cubic meters" ) )
				{
					dev_index = 22;
					dev_label = "Water|cubic meters";
				}
				else if ( ( label == "Water" ) & ( unit == "cubic feet" ) )
				{
					dev_index = 23;
					dev_label = "Water|cubic feet";
				}
				else if ( ( label == "Water" ) & ( unit == "US gallons" ) )
				{
					dev_index = 24;
					dev_label = "Water|US gallons";
				}
				else if ( ( label == "Water" ) & ( unit == "pulses" ) )
				{
					dev_index = 25;
					dev_label = "Water|pulses";
				}

				if ( dev_index > 0 )
				{
					strcpy( dev_result, dev_value );
				}
			}

			break;
		}
		case COMMAND_CLASS_SENSOR_BINARY:
		{	
			if ( type == ValueID::ValueType_Bool )
			{
				if ( label == "Sensor" )
				{
					dev_index = 31;
				}
				else if ( label == "Motion Sensor" )
				{
					dev_index = 32;
				}
				else if ( label == "Door/Window Sensor" )
				{
					dev_index = 33;
				}
				else if ( label == "Tamper Sensor" )
				{
					dev_index = 34;
				}
				else if ( label == "Magnet open" )
				{
					dev_index = 35;
				}

				// Only store the result if it is a valid valuenumber
				if ( dev_index > 0 )
				{
					dev_label = label;

					if ( strcmp( dev_value, "0" ) == 0 )
					{
						// Open
						strcpy( dev_result, "Off" );
					}
					else
					{
						// Closed
						strcpy( dev_result, "On" );
					}
				}
			}

			break;
		}
		case COMMAND_CLASS_BATTERY:
		{
			if ( ( label == "Battery Level" ) && ( type == ValueID::ValueType_Byte ) )
			{
				dev_index = 255; // Fixed
				dev_label = label;
				strcpy( dev_result, dev_value );
			}

			break;
		}
		case COMMAND_CLASS_SENSOR_MULTILEVEL:
		{
			if ( type == ValueID::ValueType_Decimal )
			{
				if ( label == "General" )
				{
					dev_index = 51;
				}
				else if ( label == "Temperature" )
				{
					dev_index = 52;
				}
				else if ( label == "Relative Humidity" )
				{
					dev_index = 53;
				}
				else if ( label == "Luminance" )
				{
					dev_index = 54;
				}
				else if ( label == "Power" )
				{
					dev_index = 55;
				}
				else if ( label == "Velocity" )
				{
					dev_index = 56;
				}
				else if ( label == "Direction" )
				{
					dev_index = 57;
				}
				else if ( label == "Atmospheric Pressure" )
				{
					dev_index = 58;
				}
				else if ( label == "Barometric Pressure" )
				{
					dev_index = 59;
				}
				else if ( label == "Solar Radiation" )
				{
					dev_index = 60;
				}
				else if ( label == "Dew Point" )
				{
					dev_index = 61;
				}
				else if ( label == "Rain Rate" )
				{
					dev_index = 62;
				}
				else if ( label == "Tide Level" )
				{
					dev_index = 63;
				}
				else if ( label == "Weight" )
				{
					dev_index = 64;
				}
				else if ( label == "Voltage" )
				{
					dev_index = 65;
				}
				else if ( label == "Current" )
				{
					dev_index = 66;
				}
				else if ( label == "CO2 Level" )
				{
					dev_index = 67;
				}
				else if ( label == "Air Flow" )
				{
					dev_index = 68;
				}
				else if ( label == "Tank Capacity" )
				{
					dev_index = 69;
				}
				else if ( label == "Distance" )
				{
					dev_index = 70;
				}
				else if ( label == "Angle Position" )
				{
					dev_index = 71;
				}
				else if ( label == "Rotation" )
				{
					dev_index = 72;
				}
				else if ( label == "Water Temperature" )
				{
					dev_index = 73;
				}
				else if ( label == "Soil Temperature" )
				{
					dev_index = 74;
				}
				else if ( label == "Seismic Intensity" )
				{
					dev_index = 75;
				}
				else if ( label == "Seismic Magnitude" )
				{
					dev_index = 76;
				}
				else if ( ( label == "Ultraviolet" ) || ( label == "Utraviolet" ) )
				{
					dev_index = 77;
				}
				else if ( label == "Electrical Resistivity" )
				{
					dev_index = 78;
				}
				else if ( label == "Electrical Conductivity" )
				{
					dev_index = 79;
				}
				else if ( label == "Loudness" )
				{
					dev_index = 80;
				}
				else if ( label == "Moisture" )
				{
					dev_index = 81;
				}
				else if ( label == "Frequency" )
				{
					dev_index = 82;
				}
				else if ( label == "Time" )
				{
					dev_index = 83;
				}
				else if ( label == "Target Temperature" )
				{
					dev_index = 84;
				}

				if ( dev_index > 0 )
				{
					dev_label = label;
					strcpy( dev_result, dev_value );
				}
			}

			break;
		}
		case COMMAND_CLASS_ALARM:
		{
			if ( label == "Alarm Level" )
			{
				dev_index = 91;

				if ( strcmp( dev_value, "0" ) == 0 )
				{
					strcpy( dev_result, "Secure" );
				}
				else
				{
					strcpy( dev_result, "Tamper" );
				}
			}

			break;
		}
		case COMMAND_CLASS_SENSOR_ALARM:
		{
			if ( type == ValueID::ValueType_Byte )
			{
				if ( label == "General" )
				{
					dev_index = 111;
				}
				else if ( label == "Smoke" )
				{
					dev_index = 112;
				}
				else if ( label == "Carbon Monoxide" )
				{
					dev_index = 113;
				}
				else if ( label == "Carbon Dioxide" )
				{
					dev_index = 114;
				}
				else if ( label == "Heat" )
				{
					dev_index = 115;
				}
				else if ( label == "Flood" )
				{
					dev_index = 116;
				}

				// Only store the result if it is a valid valuenumber
				if ( dev_index > 0 )
				{
					dev_label = label;

					if ( strcmp( dev_value, "0" ) == 0 )
					{
						strcpy( dev_result, "Off" );
					}
					else
					{
						strcpy( dev_result, "On" );
					}
				}
			}

			break;
		}
		case COMMAND_CLASS_THERMOSTAT_SETPOINT:
		{
			if ( type == ValueID::ValueType_Decimal )
			{
				// The heating temperature is stored in value2, because value1 is used to set the SETPOINT
				if ( label == "Heating 1" )
				{
					dev_index = 131;
				}
				else if ( label == "Cooling 1" )
				{
					dev_index = 132;
				}
				else if ( label == "Unused 3" )
				{
					dev_index = 133;
				}
				else if ( label == "Unused 4" )
				{
					dev_index = 134;
				}
				else if ( label == "Unused 5" )
				{
					dev_index = 135;
				}
				else if ( label == "Unused 6" )
				{
					dev_index = 136;
				}
				else if ( label == "Furnace" )
				{
					dev_index = 137;
				}
				else if ( label == "Dry Air" )
				{
					dev_index = 138;
				}
				else if ( label == "Moist Air" )
				{
					dev_index = 139;
				}
				else if ( label == "Auto Changeover" )
				{
					dev_index = 140;
				}
				else if ( label == "Heating Econ" )
				{
					dev_index = 141;
				}
				else if ( label == "Cooling Econ" )
				{
					dev_index = 142;
				}
				else if ( label == "Away Heating" )
				{
					dev_index = 143;
				}

				if ( dev_index > 0 )
				{
					dev_label = label;
					strcpy( dev_result, dev_value );
				}
			}

			break;
		}
	}

	//////////////////////////////////////////////////////////////////////////////////////////

	// We want to skip "add" values, because they are coming from the content of the zwcfg*xml. Normally
	// only previously stored values are given. DomotiGa is the only one using that file, thus all the
	// known values are already in the DomotiGa DB. Also if you do a start and directly restart and the
	// value hasn't been refreshed, after the restart the value is empty == GARBAGE

	// We will store the COMMAND_CLASS_ information (for the device and per instance)
	// We will store the number of instances
	// We will store the configuration items available 

	bool missedvalueadd = false;
	if ( ( dev_index >= 1 ) && ( ! add ) ) {

		uint valueid = std::distance( nodeInfo->instanceLabel[instanceID].begin(), nodeInfo->instanceLabel[instanceID].find(dev_index) );
		if ( valueid >= nodeInfo->instanceLabel[instanceID].size() )
		{
			WriteLog( LogLevel_Debug, false, "Extra=This ValueChange didn't trigger dev_index the last time" );
			missedvalueadd = true;
		}
	}

	if ( ( add ) || ( missedvalueadd ) )
	{
		WriteLog( LogLevel_Debug, false, "ValueKnown=%s, ReadOnly=%s, WriteOnly=%s", ( Manager::Get()->IsValueSet( valueID ) )?"true":"false", ( Manager::Get()->IsValueReadOnly( valueID ) )?"true":"false", ( Manager::Get()->IsValueWriteOnly( valueID ) )?"true":"false" );

		// Only show min and max when it is numeric
		if ( ( type == ValueID::ValueType_Byte ) || ( type == ValueID::ValueType_Short ) || ( type = ValueID::ValueType_Int ) )
		{
			WriteLog( LogLevel_Debug, false, "Min=%d", Manager::Get()->GetValueMin( valueID ) );
			WriteLog( LogLevel_Debug, false, "Max=%d", Manager::Get()->GetValueMax( valueID ) );
		}

		// Report the index if the type is something we want to send to DomotiGa
		if ( dev_index > 0 )
		{
			WriteLog( LogLevel_Debug, false, "Value=%s (Index=%d)", dev_result, dev_index );
		}
		else
		{
			WriteLog( LogLevel_Debug, false, "Value=%s", dev_value );
		}

		if ( Manager::Get()->GetValueHelp( valueID ) != "" )
		{
			WriteLog( LogLevel_Debug, false, "Help=%s", Manager::Get()->GetValueHelp( valueID ).c_str() );
		}

		// Check how many instance we got per node, if we got a higher instanceID, store it
		if ( instanceID > nodeInfo->instancecount )
		{
			nodeInfo->instancecount = instanceID;
		}

		// Add to the nodeInfo commandclass list
		string tmp_str;
		tmp_str = string( DomoZWave_CommandClassIdName( id ) );
		tmp_str.append( "|" );

		if ( nodeInfo->commandclass == "" )
		{
			nodeInfo->commandclass = "|";
			nodeInfo->commandclass.append( tmp_str );
		}
		else
		{
			if ( nodeInfo->commandclass.find(tmp_str) == string::npos )
			{
				nodeInfo->commandclass.append(tmp_str);
			}
		}

		// We also need to store it per instance. This information can be used to
		// determine if an issues is a Switch/Dim device
		if ( nodeInfo->instancecommandclass.find(instanceID) != nodeInfo->instancecommandclass.end() )
		{
			if ( nodeInfo->instancecommandclass[instanceID].find(tmp_str) == string::npos )
			{
				nodeInfo->instancecommandclass[instanceID].append(tmp_str);
			}
		}
		else
		{
			nodeInfo->instancecommandclass[instanceID] = "";
			nodeInfo->instancecommandclass[instanceID].append("|");
			nodeInfo->instancecommandclass[instanceID].append(tmp_str);
		}

		// Lets store the instance & known labels (variable), but "Basic" is skipped
		// When a ValueChange happens, we need to try to map them to Value1 - X
		if ( dev_index > 1  )
		{
			// Store the index and label when we receive a ValueUpdate, then we can map it to the right DomotiGa valueX
			nodeInfo->instanceLabel[instanceID][dev_index] = dev_label;
		} 

		if ( add ) {
			// We will not send the ValueAdd to DomotiGa, because they are in general unreliable and
			// open-zwave in most cases during a restart send empty values
			WriteLog( LogLevel_Debug, false, "Note=Value not send to DomotiGa to with ValueAdd (values are unreliable at startup)" );
			return;
		}
	}

	// Handle CommandClass Basic in a special way
	if ( id == COMMAND_CLASS_BASIC )
	{
		// If we are CommandClass Basic and mapping is enabled for this device, report it and exit
		if (nodeInfo->basicmapping > 0 )
		{
			// We have a mapping, we report it to the logfile
			WriteLog( LogLevel_Debug, false, "Mapping=COMMAND_CLASS_BASIC mapped to %s", DomoZWave_CommandClassIdName( nodeInfo->basicmapping ) );
		}
		else
		{
			WriteLog( LogLevel_Debug, false, "Mapping=None" );
			return;
		}
	}

	// Only send it to DomotiGa if the value is >0 (1, 2, 3, 4 or 255)
	if ( dev_index > 0 )
	{
		uint valueid = std::distance( nodeInfo->instanceLabel[instanceID].begin(), nodeInfo->instanceLabel[instanceID].find(dev_index) );
	
		// Check if the index/label exists in our list
		if ( valueid >= nodeInfo->instanceLabel[instanceID].size() )
		{
			WriteLog( LogLevel_Error, false, "ERROR: HomeId=0x%x Node=%d Instance=%d Index=%d Label=%s - Index/Label hasn't been added during ValueAdd - Please report this as a BUG", homeID, nodeID, instanceID, dev_index, dev_label.c_str() );
			return;
		}

		// Add +1 to the valueid, because we started with 0
		valueid++; 

		// Battery level needs to stay on 255
		if ( dev_index == 255 )
		{
			valueid = 255;
		}

		// Heating 1 requires to go in value2
		if ( ( dev_index == 131 ) && ( valueid == 1 ) )
		{
			valueid = 2;
		}
		
		WriteLog( LogLevel_Debug, false, "Value%d=%s", valueid, dev_result );

		json_object *jparams = json_object_new_object();
		json_object *jhomeid = json_object_new_int( homeID );
		json_object *jnodeid = json_object_new_int( nodeID );
		json_object *jinstanceid = json_object_new_int( instanceID );
		json_object *jvalueid = json_object_new_int( valueid );
		json_object *jvalue = json_object_new_string( dev_result );
		json_object *jlabel = json_object_new_string( label.c_str() );
		json_object *junit = json_object_new_string( unit.c_str() );

		json_object_object_add( jparams, "homeid", jhomeid );
		json_object_object_add( jparams, "nodeid", jnodeid );
		json_object_object_add( jparams, "instanceid", jinstanceid );
		json_object_object_add( jparams, "valueid", jvalueid );
		json_object_object_add( jparams, "value", jvalue );
		json_object_object_add( jparams, "label", jlabel );
		json_object_object_add( jparams, "unit", junit );

		cURL_Post_JSON( homeID, "openzwave.setvalue", jparams );

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

void RPC_NodeAdded( uint32 homeID, int nodeID )
{
	WriteLog( LogLevel_Debug, true, "NodeAdd: HomeId=0x%x Node=%d", homeID, nodeID );
}

//-----------------------------------------------------------------------------
// <RPC_RemoveNode>
// Node is removed from the Z-Wave network. Is only done if the open-zwave wrapper is running.
//-----------------------------------------------------------------------------

void RPC_NodeRemoved( uint32 homeID, int nodeID )
{
	WriteLog( LogLevel_Debug, true, "NodeRemoved: HomeId=0x%x Node=%d", homeID, nodeID );

	// Retrieve current controller information, we only should remove when controller is initialized
	m_structCtrl* ctrl = GetControllerInfo( homeID );

	if (( ctrl != NULL ) && ( ctrl->m_running == true ))
	{
		json_object *jparams = json_object_new_object();
		json_object *jhomeid = json_object_new_int( homeID );
		json_object *jnodeid = json_object_new_int( nodeID );
		json_object_object_add( jparams, "homeid", jhomeid );
		json_object_object_add( jparams, "nodeid", jnodeid );

		cURL_Post_JSON( homeID, "openzwave.removenode", jparams );
	}

}

//-----------------------------------------------------------------------------
// <RPC_NodeNew>
//
//-----------------------------------------------------------------------------

void RPC_NodeNew( uint32 homeID, int nodeID )
{
	WriteLog( LogLevel_Debug, true, "NodeNew: HomeId=0x%x Node=%d", homeID, nodeID );
}

//-----------------------------------------------------------------------------
// <RPC_NodeProtocolInfo>
// We got results to a Protocol Info query, send them over to domotiga.
//-----------------------------------------------------------------------------

void RPC_NodeProtocolInfo( uint32 homeID, int nodeID )
{
	int32 basic = Manager::Get()->GetNodeBasic( homeID, nodeID );
	int32 generic = Manager::Get()->GetNodeGeneric( homeID, nodeID );
	int32 specific = Manager::Get()->GetNodeSpecific( homeID, nodeID );
	bool listening = Manager::Get()->IsNodeListeningDevice( homeID, nodeID );
	bool frequentlistening = Manager::Get()->IsNodeFrequentListeningDevice( homeID, nodeID );
	bool beaming = Manager::Get()->IsNodeBeamingDevice( homeID, nodeID );
	bool routing = Manager::Get()->IsNodeRoutingDevice( homeID, nodeID );
	bool security = Manager::Get()->IsNodeSecurityDevice( homeID, nodeID );
	int32 maxbaudrate = Manager::Get()->GetNodeMaxBaudRate( homeID, nodeID );
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

	WriteLog( LogLevel_Debug, true, "NodeProtocolInfo: HomeId=0x%x Node=%d", homeID, nodeID );
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

	json_object *jparams = json_object_new_object();
	json_object *jhomeid = json_object_new_int( homeID );
	json_object *jnodeid = json_object_new_int( nodeID );
	json_object *jbasic = json_object_new_int( basic );
	json_object *jgeneric = json_object_new_int( generic );
	json_object *jspecific = json_object_new_int( specific );
	json_object *jlistening = json_object_new_boolean( listening );
	json_object *jfrequentlistening = json_object_new_boolean( frequentlistening );
	json_object *jbeaming = json_object_new_boolean( beaming );
	json_object *jrouting = json_object_new_boolean( routing );
	json_object *jsecurity = json_object_new_boolean( security );
	json_object *jmaxbaudrate = json_object_new_int( maxbaudrate );
	json_object *jversion = json_object_new_int( version );

	json_object_object_add( jparams, "homeid", jhomeid );
	json_object_object_add( jparams, "nodeid", jnodeid );
	json_object_object_add( jparams, "basic", jbasic );
	json_object_object_add( jparams, "generic", jgeneric );
	json_object_object_add( jparams, "specific", jspecific );
	json_object_object_add( jparams, "listening", jlistening );
	json_object_object_add( jparams, "frequentlistening", jfrequentlistening );
	json_object_object_add( jparams, "beaming", jbeaming );
	json_object_object_add( jparams, "routing", jrouting );
	json_object_object_add( jparams, "security", jsecurity );
	json_object_object_add( jparams, "maxbaudrate", jmaxbaudrate );
	json_object_object_add( jparams, "version", jversion );

	cURL_Post_JSON( homeID, "openzwave.addnode", jparams );

}

//-----------------------------------------------------------------------------
// <RPC_Group>
//
//-----------------------------------------------------------------------------

void RPC_Group( uint32 homeID, int nodeID )
{
	WriteLog( LogLevel_Debug, true, "GroupEvent: HomeId=0x%x Node=%d", homeID, nodeID );
}

//-----------------------------------------------------------------------------
// <RPC_NodeEvent>
//
//-----------------------------------------------------------------------------

void RPC_NodeEvent( uint32 homeID, int nodeID, ValueID valueID, int value )
{
	int id = valueID.GetCommandClassId();
	int instanceID = valueID.GetInstance();
	int value_no = 1;
	char dev_value[1024];

	// Instance can never be zero, we need to be backwards compatible
	if ( instanceID == 0 ) {
		instanceID = 1;
	}

	WriteLog( LogLevel_Debug, true, "NodeEvent: HomeId=0x%x Node=%d", homeID, nodeID );
	WriteLog( LogLevel_Debug, false, "CommandClass=%s (%d)",  DomoZWave_CommandClassIdName(id), id );
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

	json_object *jparams = json_object_new_object();
	json_object *jhomeid = json_object_new_int( homeID );
	json_object *jnodeid = json_object_new_int( nodeID );
	json_object *jinstanceid = json_object_new_int( instanceID );
	json_object *jvalueid = json_object_new_int( value_no );
	json_object *jvalue = json_object_new_string( dev_value );

	json_object_object_add( jparams, "homeid", jhomeid );
	json_object_object_add( jparams, "nodeid", jnodeid );
	json_object_object_add( jparams, "instanceid", jinstanceid );
	json_object_object_add( jparams, "valueid", jvalueid );
	json_object_object_add( jparams, "value", jvalue );

	cURL_Post_JSON( homeID, "openzwave.setvalue", jparams );

}

//-----------------------------------------------------------------------------
// <RPC_NodeScene>
// Handle Scene event
//-----------------------------------------------------------------------------

void RPC_NodeScene( uint32 homeID, int nodeID, ValueID valueID, int value )
{
	int id = valueID.GetCommandClassId();
	int instanceID = valueID.GetInstance();
	int value_no = 1;
	char dev_value[1024];

	// Instance can never be zero, we need to be backwards compatible
	if ( instanceID == 0 ) {
		instanceID = 1;
	}

	WriteLog( LogLevel_Debug, true, "NodeScene: HomeId=0x%x Node=%d", homeID, nodeID );
	WriteLog( LogLevel_Debug, false, "CommandClass=%s (%d)",  DomoZWave_CommandClassIdName(id), id );
	WriteLog( LogLevel_Debug, false, "Instance=%d", instanceID );
	WriteLog( LogLevel_Debug, false, "Type=Byte (raw value=%d)", value );
	snprintf( dev_value, 1024, "%d", value );

	WriteLog( LogLevel_Debug, false, "Value%d=%s", value_no, dev_value );

	// Only send it if it isn't a scene action command class
	if ( id != COMMAND_CLASS_SCENE_ACTIVATION ) { 
		json_object *jparams = json_object_new_object();
		json_object *jhomeid = json_object_new_int( homeID );
		json_object *jnodeid = json_object_new_int( nodeID );
		json_object *jinstanceid = json_object_new_int( instanceID );
		json_object *jvalueid = json_object_new_int( value_no );
		json_object *jvalue = json_object_new_string( dev_value );

		json_object_object_add( jparams, "homeid", jhomeid );
		json_object_object_add( jparams, "nodeid", jnodeid );
		json_object_object_add( jparams, "instanceid", jinstanceid );
		json_object_object_add( jparams, "valueid", jvalueid );
		json_object_object_add( jparams, "value", jvalue );

		cURL_Post_JSON( homeID, "openzwave.setvalue", jparams );
	} else {
	}

}

//-----------------------------------------------------------------------------
// <RPC_PollingEnabled>
//
//-----------------------------------------------------------------------------

void RPC_PollingEnabled( uint32 homeID, int nodeID )
{
	WriteLog( LogLevel_Debug, true, "PollingEnabled: HomeId=0x%x Node=%d", homeID, nodeID );
}

//-----------------------------------------------------------------------------
// <RPC_PollingDisabled>
//
//-----------------------------------------------------------------------------

void RPC_PollingDisabled( uint32 homeID, int nodeID )
{
	WriteLog( LogLevel_Debug, true, "PollingDisabled: HomeId=0x%x Node=%d", homeID, nodeID );
}

//-----------------------------------------------------------------------------
// <RPC_NodeNaming>
//
//-----------------------------------------------------------------------------

void RPC_NodeNaming( uint32 homeID, int nodeID )
{
	WriteLog( LogLevel_Debug, true, "NodeNaming: HomeId=0x%x Node=%d", homeID, nodeID );
	WriteLog( LogLevel_Debug, false, "ManufacturerId=%s", Manager::Get()->GetNodeManufacturerId( homeID, nodeID ).c_str() );
	WriteLog( LogLevel_Debug, false, "ManufacturerName=%s", Manager::Get()->GetNodeManufacturerName( homeID, nodeID ).c_str() );
	WriteLog( LogLevel_Debug, false, "ProductType=%s, ProductId=%s", Manager::Get()->GetNodeProductType( homeID, nodeID ).c_str(), Manager::Get()->GetNodeProductId( homeID, nodeID ).c_str() );
	WriteLog( LogLevel_Debug, false, "ProductName=%s", Manager::Get()->GetNodeProductName( homeID, nodeID ).c_str() );
}

//-----------------------------------------------------------------------------
// <RPC_DriverReady>
// The driver is ready, add it to our internal controller list
//-----------------------------------------------------------------------------

void RPC_DriverReady( uint32 homeID, int nodeID )
{
	// Retrieve the serialport name of this homeid
	string controllerPath = Manager::Get()->GetControllerPath( homeID );

	for ( list<m_structCtrl*>::iterator it = g_allControllers.begin(); it != g_allControllers.end(); ++it )
	{
		m_structCtrl* ctrl = *it;
		if ( ctrl->m_serialPort == controllerPath )
		{
			ctrl->m_homeId = homeID;
			ctrl->m_controllerId = nodeID;
		}
	}

	WriteLog( LogLevel_Debug, true, "DriverReady: HomeId=0x%x Node=%d", homeID, nodeID );

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

	WriteLog( LogLevel_Debug, false, "ControllerPath=%s", controllerPath.c_str() );

	json_object *jparams = json_object_new_object();
	json_object *jhomeid = json_object_new_int( homeID );
	json_object *jcontrollerid = json_object_new_int( nodeID );
	json_object *jcontrollerpath = json_object_new_string( controllerPath.c_str() );
	json_object_object_add( jparams, "homeid", jhomeid );
	json_object_object_add( jparams, "controllerid", jcontrollerid );
	json_object_object_add( jparams, "serialport", jcontrollerpath );

	cURL_Post_JSON( homeID, "openzwave.homeid", jparams );

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
			//RPC_ValueAdded( data->GetHomeId(), (int)data->GetNodeId(), data->GetValueID(), data->GetByte() );
			RPC_ValueChanged( data->GetHomeId(), (int)data->GetNodeId(), data->GetValueID(), true );

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

			RPC_ValueRemoved( data->GetHomeId(), (int)data->GetNodeId(), data->GetValueID() );
			break;
		}
		case Notification::Type_NodeNaming:
		{
			RPC_NodeNaming( data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_ValueChanged:
		{
			RPC_ValueChanged( data->GetHomeId(), (int)data->GetNodeId(), data->GetValueID(), false );

			// Update LastSeen and DeviceState
			if ( NodeInfo* nodeInfo = GetNodeInfo( data ) )
			{
				nodeInfo->m_LastSeen = time( NULL );
				nodeInfo->m_DeviceState = DZType_Alive;
			}

			// Check if zwcfg*xml has been written 3600+ sec, then flush to disk
			m_structCtrl* ctrl = GetControllerInfo( data->GetHomeId() );
			if ( ctrl->m_lastWriteXML > 0 )
			{
				double seconds;
				seconds = difftime( time( NULL ), ctrl->m_lastWriteXML );

				if ( seconds > 3600 )
				{
					Manager::Get()->WriteConfig( data->GetHomeId() );
					WriteLog( LogLevel_Debug, true, "DomoZWave_WriteConfig: HomeId=0x%x (%.f seconds)", data->GetHomeId(), seconds );
					ctrl->m_lastWriteXML = time( NULL );
				}
			}	

			break;
		}
		case Notification::Type_Group:
		{
			RPC_Group( data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_NodeNew:
		{
			RPC_NodeNew( data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_NodeAdded:
		{
			m_structCtrl* ctrl = GetControllerInfo( data->GetHomeId() );

			NodeInfo* nodeInfo = new NodeInfo();
			nodeInfo->m_homeId = data->GetHomeId();
			nodeInfo->m_nodeId = data->GetNodeId();
			nodeInfo->m_LastSeen = 0;

			// The controller will always be alive
			if ( ctrl->m_controllerId == data->GetNodeId() )
			{ 
				nodeInfo->m_DeviceState = DZType_Alive;
			}
			else
			{
				nodeInfo->m_DeviceState = DZType_Unknown;
			}

			g_nodes.push_back( nodeInfo );
			
			RPC_NodeAdded( data->GetHomeId(), (int)data->GetNodeId() );
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

			pthread_mutex_unlock( &g_criticalSection );

			RPC_NodeRemoved( data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_NodeProtocolInfo:
		{
			RPC_NodeProtocolInfo( data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_NodeEvent:
		{
			// Event caused by basic set or hail
			RPC_NodeEvent( data->GetHomeId(), (int)data->GetNodeId(), data->GetValueID(), (int)data->GetEvent() );

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
			RPC_PollingEnabled( data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_PollingDisabled:
		{
			RPC_PollingDisabled( data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_DriverReady:
		{
			RPC_DriverReady( data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_AllNodesQueried:
		case Notification::Type_AwakeNodesQueried:
		case Notification::Type_AllNodesQueriedSomeDead:
		{
			m_structCtrl* ctrl = GetControllerInfo( data->GetHomeId() );

			if ( data->GetType() == Notification::Type_AllNodesQueried ) WriteLog( LogLevel_Debug, true, "AllNodesQueried: HomeId=0x%x", data->GetHomeId() );
			if ( data->GetType() == Notification::Type_AwakeNodesQueried ) WriteLog( LogLevel_Debug, true, "AwakeNodesQueried: HomeId=0x%x", data->GetHomeId() );
			if ( data->GetType() == Notification::Type_AllNodesQueriedSomeDead ) WriteLog( LogLevel_Debug, true, "AllNodesQueriedSomeDead: HomeId=0x%x", data->GetHomeId() );

			if ( ctrl->m_controllerAllQueried == 0 )
			{ 
				// Write zwcfg*xml file
				Manager::Get()->WriteConfig( data->GetHomeId() );

				// The zwcfg*xml is written, save the current time
				ctrl->m_lastWriteXML = time( NULL );

				pthread_mutex_unlock( &g_criticalSection );

				json_object *jparams = json_object_new_object();
				json_object *jhomeid = json_object_new_int( data->GetHomeId() );
				json_object_object_add( jparams, "homeid", jhomeid );

				cURL_Post_JSON( data->GetHomeId(), "openzwave.allqueried", jparams );
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
			WriteLog( LogLevel_Debug, true, "CreateButton: HomeId=0x%x Node=%d", data->GetHomeId(), (int)data->GetNodeId() );
			WriteLog( LogLevel_Debug, false, "ButtonId=%d", (int)data->GetButtonId() );
			break;
		}	
		case Notification::Type_DeleteButton:
		{
			WriteLog( LogLevel_Debug, true, "DeleteButton: HomeId=0x%x Node=%d", data->GetHomeId(), (int)data->GetNodeId() );
			WriteLog( LogLevel_Debug, false, "ButtonId=%d", (int)data->GetButtonId() );
			break;
		}	
		case Notification::Type_ButtonOn:
		{
			WriteLog( LogLevel_Debug, true, "ButtonOn: HomeId=0x%x Node=%d", data->GetHomeId(), (int)data->GetNodeId() );
			WriteLog( LogLevel_Debug, false, "ButtonId=%d", (int)data->GetButtonId() );
			break;
		}	
		case Notification::Type_ButtonOff:
		{
			WriteLog( LogLevel_Debug, true, "ButtonOff: HomeId=0x%x Node=%d", data->GetHomeId(), (int)data->GetNodeId() );
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
		case Notification::Type_DriverRemoved:
		{
			WriteLog( LogLevel_Debug, true, "DriverRemoved" );
			break;
		}
		case Notification::Type_EssentialNodeQueriesComplete:
		{
			WriteLog( LogLevel_Debug, true, "EssentialNodeQueriesComplete: HomeId=0x%x Node=%d", data->GetHomeId(), (int)data->GetNodeId() );

			// We require the configuration parameters when the device is essentially queried
			// This still need to be optimized, because we do it with every startup now
			Manager::Get()->RequestAllConfigParams( data->GetHomeId(), data->GetNodeId() );
			break;
		}
		case Notification::Type_NodeQueriesComplete:
		{
			WriteLog( LogLevel_Debug, true, "NodeQueriesComplete: HomeId=0x%x Node=%d", data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_ValueRefreshed:
		{
			WriteLog( LogLevel_Debug, true, "ValueRefreshed: HomeId=0x%x Node=%d", data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_SceneEvent:
		{
			//RPC_NodeScene( data->GetHomeId(), (int)data->GetNodeId(), data->GetValueID(), (int)data->GetEvent() );
			RPC_NodeScene( data->GetHomeId(), (int)data->GetNodeId(), data->GetValueID(), data->GetSceneId() );

			// Update LastSeen and DeviceState
			if ( NodeInfo* nodeInfo = GetNodeInfo( data ) )
			{
			        nodeInfo->m_LastSeen = time( NULL );
			        nodeInfo->m_DeviceState = DZType_Alive;
			}
			break;
		}
		case Notification::Type_Notification:
		{
			switch ( data->GetNotification() )
			{
				case Notification::Code_MsgComplete:
				{
					WriteLog( LogLevel_Debug, true, "MsgComplete: HomeId=0x%x Node=%d", data->GetHomeId(), (int)data->GetNodeId() );

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
					string str = "Unknown Device";

					// Update DeviceState
					if ( NodeInfo* nodeInfo = GetNodeInfo( data ) )
					{
						// Only report timeout if it is a listening device. If it is a sleeping device, most likely the device went to sleep already
						if ( Manager::Get()->IsNodeListeningDevice( data->GetHomeId(), data->GetNodeId() ) ) {
							str = "Listening Device";
							nodeInfo->m_DeviceState = DZType_Timeout;
						}
						else
						{
							str = "Sleeping Device - Reporting \"Sleep\"";
							nodeInfo->m_DeviceState = DZType_Sleep;
						}
					}
					WriteLog( LogLevel_Debug, true, "Code_Timeout: HomeId=0x%x Node=%d (%s)", data->GetHomeId(), (int)data->GetNodeId(), str.c_str() );
					break;
				}
				case Notification::Code_NoOperation:
				{
					WriteLog( LogLevel_Debug, true, "Code_NoOperation: HomeId=0x%x Node=%d", data->GetHomeId(), (int)data->GetNodeId() );
					break;
				}
				case Notification::Code_Awake:
				{
					WriteLog( LogLevel_Debug, true, "Code_Awake: HomeId=0x%x Node=%d", data->GetHomeId(), (int)data->GetNodeId() );

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
					WriteLog( LogLevel_Debug, true, "Code_Sleep: HomeId=0x%x Node=%d", data->GetHomeId(), (int)data->GetNodeId() );

					// Update DeviceState
					if ( NodeInfo* nodeInfo = GetNodeInfo( data ) )
					{
						nodeInfo->m_DeviceState = DZType_Sleep;
					}
					break;
				}
				case Notification::Code_Dead:
				{
					WriteLog( LogLevel_Debug, true, "Code_Dead: HomeId=0x%x Node=%d", data->GetHomeId(), (int)data->GetNodeId() );

					// Update DeviceState
					if ( NodeInfo* nodeInfo = GetNodeInfo( data ) )
					{
						nodeInfo->m_DeviceState = DZType_Dead;
					}
					break;
				}
				case Notification::Code_Alive:
				{
					WriteLog( LogLevel_Debug, true, "Code_Alive: HomeId=0x%x Node=%d", data->GetHomeId(), (int)data->GetNodeId() );

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
					WriteLog( LogLevel_Debug, true, "Notification: HomeId=0x%x Node=%d, Unknown: %d", data->GetHomeId(), (int)data->GetNodeId(), data->GetNotification() );
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
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=0x%x - Normal - no command in progress", ctrl->m_homeId );
			ctrl->m_controllerBusy = false;
			break;
		}
		case Driver::ControllerState_Starting:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=0x%x - Starting - the command is starting", ctrl->m_homeId );
			break;
		}
		case Driver::ControllerState_Cancel:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=0x%x - Cancel - the command was cancelled", ctrl->m_homeId );
			break;
		}
		case Driver::ControllerState_Error:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=0x%x - Error - command invocation had error(s) and was aborted", ctrl->m_homeId );
			break;
		}
		case Driver::ControllerState_Sleeping:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=0x%x - Sleeping - controller command is on a sleep queue wait for device", ctrl->m_homeId );
			break;
		}
		case Driver::ControllerState_Waiting:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=0x%x - Waiting - waiting for a user action", ctrl->m_homeId );
			break;
		}
		case Driver::ControllerState_InProgress:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=0x%x - InProgress - communicating with the other device", ctrl->m_homeId );
			break;
		}
		case Driver::ControllerState_Completed:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=0x%x - Completed - command has completed successfully", ctrl->m_homeId );
			ctrl->m_controllerBusy = false;
			break;
		}
		case Driver::ControllerState_Failed:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=0x%x - Failed - command has failed", ctrl->m_homeId );
			ctrl->m_controllerBusy = false;
			break;
		}
		case Driver::ControllerState_NodeOK:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=0x%x - NodeOK - the node is OK", ctrl->m_homeId );
			ctrl->m_controllerBusy = false;

			// Store Node State

			break;
		}
		case Driver::ControllerState_NodeFailed:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=0x%x - NodeFailed - the node has failed", ctrl->m_homeId );
			ctrl->m_controllerBusy = false;

			// Store Node State

			break;
		}
		default:
		{
			WriteLog( LogLevel_Debug, true, "ControllerState Event: HomeId=0x%x - unknown response", ctrl->m_homeId );
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
					WriteLog( LogLevel_Debug, true, "DomoZWave_HasNodeFailed: HomeId=0x%x Node=%d (Queued)", ctrl->m_homeId, cmd.m_nodeId );
					response = Manager::Get()->BeginControllerCommand( ctrl->m_homeId, Driver::ControllerCommand_HasNodeFailed, OnControllerUpdate, ctrl, true, cmd.m_nodeId );
		                        WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
					break;
				}
				case Driver::ControllerCommand_RequestNodeNeighborUpdate:
				{
					ctrl->m_controllerBusy = true;
					WriteLog( LogLevel_Debug, true, "DomoZWave_RequestNodeNeighborUpdate: HomeId=0x%x Node=%d (Queued)", ctrl->m_homeId, cmd.m_nodeId );
					response = Manager::Get()->BeginControllerCommand( ctrl->m_homeId, Driver::ControllerCommand_RequestNodeNeighborUpdate, OnControllerUpdate, ctrl, false, cmd.m_nodeId );
		                        WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"CommandSend":"ControllerBusy" );
					break;
				}
				default:
				{
					WriteLog( LogLevel_Debug, true, "DomoZWave_OnControllerUpdate: HomeId=0x%x Node=%d (Queued)", ctrl->m_homeId, cmd.m_nodeId );
					WriteLog( LogLevel_Debug, false, "ERROR: Invalid Command %d", cmd.m_command );
					break;
				}
			}
		}
	}
}

//-----------------------------------------------------------------------------
//
//-----------------------------------------------------------------------------

static size_t WriteCallback(void *contents, size_t size, size_t nmemb, void *userp)
{
((std::string*)userp)->append((char*)contents, size * nmemb);
return size * nmemb;
}

//-----------------------------------------------------------------------------
// <cURL_Post_JSON>
// Call CURL to post the JSON-RPC to DomotiGa
//-----------------------------------------------------------------------------

void cURL_Post_JSON( uint32 homeID, const char* method, json_object *jparams )
{
	// Increment the id and check we didn't reach our max
	if ( jsonrpcid > 0xFFFF ) jsonrpcid = 0;
	jsonrpcid++;

	// Construct JSON-RPC request
	json_object *jrequest = json_object_new_object();

	json_object *jjsonrpc = json_object_new_string( "2.0" );
	json_object *jmethod = json_object_new_string( method );

	json_object_object_add( jrequest, "jsonrpc", jjsonrpc );
	json_object_object_add( jrequest, "method", jmethod );
	if ( jparams != NULL )
	{
		json_object_object_add( jrequest, "params", jparams );
	}

	// Add id, because cURL doesn't like "no-response"
	json_object *jid = json_object_new_int( jsonrpcid );
	json_object_object_add( jrequest, "id", jid );

	WriteLog( LogLevel_Debug, true, "JSON-RPC: HomeId=0x%x Method=%s", homeID, method );
	WriteLog( LogLevel_Debug, false, "Data=%s", json_object_to_json_string( jrequest ) );

	CURL *curl;
	CURLcode res;
	curl_slist *httpheader = NULL;
	string readBuffer;

	// Initialize cURL
	curl_global_init( CURL_GLOBAL_ALL );

	// Get a cURL handle
	curl = curl_easy_init( );
	if( curl )
	{
		m_structCtrl* ctrl = GetControllerInfo( homeID );
		curl_easy_setopt( curl, CURLOPT_URL, ctrl->m_jsonrpcurl );

		httpheader = curl_slist_append( httpheader, "Content-Type: application/json" );
		res = curl_easy_setopt( curl, CURLOPT_HTTPHEADER, httpheader );
		res = curl_easy_setopt( curl, CURLOPT_CONNECTTIMEOUT, 3 );
		res = curl_easy_setopt( curl, CURLOPT_TIMEOUT, 3 );

		//CURLOPT_USERNAME
		//CURLOPT_PASSWORD
		//CURLOPT_HTTPAUTH

		// Set the http headers - set content-type and remove 100-continue header
		curl_easy_setopt( curl, CURLOPT_POSTFIELDS, json_object_to_json_string( jrequest ) );

		//
		curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
		curl_easy_setopt(curl, CURLOPT_WRITEDATA, &readBuffer);

		// Perform the request, rest will get the return code
		res = curl_easy_perform( curl );

		// Check for errors
		if( res != CURLE_OK )
		{
			WriteLog( LogLevel_Error, true, "ERROR: JSON-RPC call \"%s\" returned cURL msg \"%s\"", method, curl_easy_strerror(res) );
		}
		else
		{
			// Check if the buffer is empty, then it is an invalid one anyway
			if ( readBuffer == "" ) {
				WriteLog( LogLevel_Error, true, "ERROR: JSON-RPC call \"%s\" didn't return a response", method );

				// Clean-up cURL
				curl_easy_cleanup( curl );
				return;
			}

			// Decode JSON-RPC response
			json_object *jrobj = json_tokener_parse( readBuffer.c_str() );
			json_object *jrjsonrpc = json_object_object_get( jrobj, "jsonrpc" );
			json_object *jrerror = json_object_object_get( jrobj, "error" );
			json_object *jrresult = json_object_object_get( jrobj, "result" );
			json_object *jrid = json_object_object_get( jrobj, "id" );

			// Test for jsonrpc=2.0
			if (( json_object_get_type( jrjsonrpc ) != json_type_string ) || ( strcmp( json_object_get_string( jrjsonrpc ), "2.0" ) != 0 ))
			{
				WriteLog( LogLevel_Error, true, "ERROR: JSON-RPC call \"%s\" didn't return a valid \"jsonrpc\" version. Data=%s", method, readBuffer.c_str() );

				// Clean-up cURL
				curl_easy_cleanup( curl );
				return;
			}

			// Test for id
			if (( json_object_get_type( jrid ) != json_type_int ) || ( json_object_get_int( jrid ) != jsonrpcid ))
			{
				WriteLog( LogLevel_Error, true, "ERROR: JSON-RPC call \"%s\" didn't return a valid \"id\". Data=%s", method, readBuffer.c_str() );

				// Clean-up cURL
				curl_easy_cleanup( curl );
				return;
			}

			// Check if we got a result
			if ( json_object_get_type( jrresult ) == json_type_boolean )
			{
					if ( json_object_get_boolean( jrresult ) == true ) 
					{
						WriteLog( LogLevel_Debug, false, "JSON-RPC call successful" );
					}
					else
					{
						WriteLog( LogLevel_Error, true, "JSON-RPC call failed" );
					}
			}
			else
			{
				if ( json_object_get_type( jrerror ) == json_type_object )
				{
					WriteLog( LogLevel_Error, true, "ERROR: JSON-RPC call \"%s\" returned error. Data=%s", method, readBuffer.c_str() );
				}
				else
				{
					WriteLog( LogLevel_Error, true, "ERROR: JSON-RPC call \"%s\" returned invalid data. Data=%s", method, readBuffer.c_str() );
				}
			}
		}

		// Clean-up cURL
		curl_easy_cleanup( curl );
	}
	else
	{
		// Always clean-up the cURL enviroment
		curl_global_cleanup();
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

bool DomoZWave_HomeIdPresent( uint32 home, const char* _param )
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
// url = The URL to post the JSON-RPC to
//
// NOTE: You need to call DomoZWave_AddSerialPort to complete the initialization
//-----------------------------------------------------------------------------

void DomoZWave_Init( const char* configdir, const char* zwdir, const char* logname, bool enableInitLog )
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
	debugging = enableInitLog;

	// Open the logfile, required for errors and debug
	logfile.open( logfile_name.c_str(), ios::app );
	if ( ! logfile.is_open() )
	{
		cout << OZW_datetime << " [DomoZwave] " << "***FATAL*** Unable to write to \"" << logfile_name << "\"" << endl;
	}

	WriteLog( LogLevel_Debug, true, "DomoZWave_Init: Initializing Open-ZWave Wrapper" );

	// OpenZWave version <ozw_vers_major>.<ozw_vers_minor>.R<ozw_vers_revision>
	char ozw_vers2[100];
	snprintf( ozw_vers2, 100, "OpenZWave version %d.%d.r%d", ozw_vers_major, ozw_vers_minor, ozw_vers_revision );
	WriteLog( LogLevel_Debug, false, "%s", ozw_vers2 );

	pthread_mutexattr_t mutexattr;

	pthread_mutexattr_init ( &mutexattr );
	pthread_mutexattr_settype( &mutexattr, PTHREAD_MUTEX_RECURSIVE );
	pthread_mutex_init( &g_criticalSection, &mutexattr );
	pthread_mutexattr_destroy( &mutexattr );

	Options::Create( configdir, zwdir, "" );
	Options::Get()->AddOptionBool( "AppendLogFile", false );
	Options::Get()->AddOptionBool( "ConsoleOutput", false );

	// Disable polling, this will be enabled in a later moment
	Options::Get()->AddOptionInt( "PollInterval", 0 );
	Options::Get()->AddOptionBool( "IntervalBetweenPolls", true );
	Options::Get()->AddOptionBool( "SuppressValueRefresh", false );
	Options::Get()->AddOptionBool( "PerformReturnRoutes", false );

	Options::Get()->Lock();

	Manager::Create();

	// Enable OZW_Log.txt - if applicable
	DomoZWave_Log( enableInitLog );

	Manager::Get()->AddWatcher( OnNotification, NULL );

// TODO create json something?

}

//-----------------------------------------------------------------------------
// <DomoZWave_Log>
//-----------------------------------------------------------------------------

void DomoZWave_Log( bool logging )
{

	if ( logging )
	{
		Log::SetLoggingState( LogLevel_Detail, LogLevel_Debug, LogLevel_Error );
	}
	else
	{
		Log::SetLoggingState( LogLevel_None, LogLevel_None, LogLevel_None );
	}

}

//-----------------------------------------------------------------------------
// <DomoZWave_AddSerialPort>
// Add the serialport from the open-zwave library, it can have multiple serialports connected
//-----------------------------------------------------------------------------

void DomoZWave_AddSerialPort( const char* serialPort, const char* jsonrpcurl, bool logging )
{
	m_structCtrl* ctrl;
	string Name;

	// Store the serialPort used
	Name = serialPort; 

	// Loop through available controllers and check it doesn't exist
	// Do NOT add if it already exist
	for ( list<m_structCtrl*>::iterator it = g_allControllers.begin(); it != g_allControllers.end(); ++it )
	{
		ctrl = *it;
		if ( ctrl->m_serialPort == Name )
		{
			// It exists, write log and exit
			WriteLog( LogLevel_Error, true, "SerialPort=%s already exist in SerialPort list", serialPort );
			return;
		}
	}

	// Create and store new controller information
	ctrl = new m_structCtrl();

	ctrl->m_serialPort = Name;
	ctrl->m_homeId = 0;
	ctrl->m_controllerId = 0;
	ctrl->m_controllerAllQueried = 0;
	ctrl->m_controllerBusy = false;
	ctrl->m_nodeId = 0;
	ctrl->m_lastWriteXML = 0;
	ctrl->m_running = true;

	// Store the url
	sprintf( ctrl->m_jsonrpcurl, "%s", jsonrpcurl );
	WriteLog( LogLevel_Debug, false, "SerialPort=%s (Add)", serialPort );
	WriteLog( LogLevel_Debug, false, "JSON-RPC URL=%s", ctrl->m_jsonrpcurl );

	g_allControllers.push_back( ctrl );

	Manager::Get()->AddDriver( serialPort );

}

//-----------------------------------------------------------------------------
// <DomoZWave_RemoveSerialPort>
// Remove the serialport from the open-zwave library
//-----------------------------------------------------------------------------

void DomoZWave_RemoveSerialPort( const char* serialPort )
{
	m_structCtrl* ctrl;
	string Name;

	// Store the serialPort used
	Name = serialPort; 

	// Loop through available controllers and set running to false
	// Otherwise the zwave.removenode can fail/hang
	for ( list<m_structCtrl*>::iterator it = g_allControllers.begin(); it != g_allControllers.end(); ++it )
	{
		ctrl = *it;
		if ( ctrl->m_serialPort == Name )
		{
			WriteLog( LogLevel_Debug, true, "SerialPort=%s (Remove)", serialPort );

			ctrl->m_running = false;

			// Only removedriver it is existed
			Manager::Get()->RemoveDriver( serialPort );
		}
	}

	// Remove the ctrl from the list, it is removed now
	if ( ctrl != NULL ) {
		g_allControllers.remove ( ctrl );
	}
}


//-----------------------------------------------------------------------------
// <DomoZWave_Destroy>
// Stops the Open-Zwave wrapper
//-----------------------------------------------------------------------------

void DomoZWave_Destroy( )
{

	// Loop through available controllers and set running to false
	// Otherwise the zwave.removenode can fail/hang
	for ( list<m_structCtrl*>::iterator it = g_allControllers.begin(); it != g_allControllers.end(); ++it )
	{
		m_structCtrl* ctrl = *it;
		ctrl->m_running = false;
	}

	for ( list<string>::iterator it = serialPortName.begin(); it != serialPortName.end(); ++it )
	{
		string Name = *it;
		Manager::Get()->RemoveDriver( Name );
	}

	pthread_mutex_lock( &g_criticalSection );

	Manager::Get()->RemoveWatcher( OnNotification, NULL );

	Manager::Get()->Destroy();
	//cout << OZW_datetime << "Destroyed manager" << endl;
	Options::Get()->Destroy();
	//cout << OZW_datetime << "Destroyed options" << endl;

	pthread_mutex_unlock( &g_criticalSection );
	pthread_mutex_destroy( &g_criticalSection );

	serialPortName.clear();

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
	string ozw_vers;

	// OpenZWave version <ozw_vers_major>.<ozw_vers_minor>.R<ozw_vers_revision>
	char ozw_vers2[100];
	snprintf( ozw_vers2, 100, "OpenZWave version %d.%d.r%d", ozw_vers_major, ozw_vers_minor, ozw_vers_revision );

	ozw_vers = ozw_vers2;
	return ozw_vers.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_WriteConfig>
// Write the zwcfg*xml. Normally not required, because it is written when all
// the nodes are queried and when wrapper exits
//-----------------------------------------------------------------------------

void DomoZWave_WriteConfig( uint32 home )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_WriteConfig" ) == false ) return;
	WriteLog( LogLevel_Debug, true, "DomoZWave_WriteConfig: HomeId=0x%x", home );
	Manager::Get()->WriteConfig( home );
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetLibraryVersion>
//
//-----------------------------------------------------------------------------

const char* DomoZWave_GetLibraryVersion( uint32 home )
{
	string LibraryVersion;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetLibraryVersion" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetLibraryVersion: HomeId=0x%x", home );
	LibraryVersion =  Manager::Get()->GetLibraryVersion( home );
	WriteLog( LogLevel_Debug, false, "LibraryVersion=%s", LibraryVersion.c_str() );
	return LibraryVersion.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetLibraryTypeName>
//
//-----------------------------------------------------------------------------

const char* DomoZWave_GetLibraryTypeName( uint32 home )
{
	string LibraryTypeName;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetLibraryTypeName" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetLibraryTypeName: HomeId=0x%x", home );
	LibraryTypeName = Manager::Get()->GetLibraryTypeName( home );
	WriteLog( LogLevel_Debug, false, "LibraryTypeName=%s", LibraryTypeName.c_str() );
	return LibraryTypeName.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_ControllerType>
// Retrieves the Z-Wave controller type, possible values are:
// Primary or Secondary and possible SUC and/or Bridge mode
//-----------------------------------------------------------------------------

const char* DomoZWave_ControllerType( uint32 home )
{
	string ctype;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_ControllerType" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_ControllerType: HomeId=0x%x", home );

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
// <DomoZWave_GetPollInterval>
// Gets the poll interval of the OpenZWave driver for the nodes
//-----------------------------------------------------------------------------
int32 DomoZWave_GetPollInterval( )
{
	int32 milliseconds;

	milliseconds = Manager::Get()->GetPollInterval();
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetPollInterval: Interval=%d msec", milliseconds );

	return milliseconds;
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetPollInterval>
// Enable the poll interval of the OpenZWave driver for the nodes, it will be enabled for all controllers connected
//-----------------------------------------------------------------------------
void DomoZWave_SetPollInterval( int32 milliseconds, bool intervalbetweenpolls )
{
	WriteLog( LogLevel_Debug, true, "DomoZWave_SetPollInterval: Interval=%d msec", milliseconds );

	Manager::Get()->SetPollInterval( milliseconds, intervalbetweenpolls );
}

//-----------------------------------------------------------------------------
// <DomoZWave_EnablePolling>
// Enable polling of the devices by open-zwave. This only works for basic values,
// values like kWh, Temperature, etc this doesn't work (then DynamicState need
// to be used)
//-----------------------------------------------------------------------------

void DomoZWave_EnablePolling( uint32 home, int32 node, int32 polltime )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_EnablePolling" ) == false ) return;

	WriteLog( LogLevel_Debug, true, "DomoZWave_EnablePolling: HomeId=0x%x Node=%d", home, node );

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

void DomoZWave_DisablePolling( uint32 home, int32 node )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_DisablePolling" ) == false ) return;

	WriteLog( LogLevel_Debug, true, "DomoZWave_DisablePolling: HomeId=0x%x Node=%d", home, node );

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

const char* DomoZWave_GetNodeQueryStage( uint32 home, int32 node )
{
	string QueryStage;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeQueryStage" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeQueryStage: HomeId=0x%x Node=%d", home, node );
	QueryStage = Manager::Get()->GetNodeQueryStage( home, node );
	WriteLog( LogLevel_Debug, false, "QueryStage=%s", QueryStage.c_str() );
	return QueryStage.c_str();

}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeManufacturerName>
// Retrieves the manufacturer name of a device
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeManufacturerName( uint32 home, int32 node )
{
	string ManufacturerName;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeManufacturerName" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeManufacturerName: HomeId=0x%x Node=%d", home, node );
	ManufacturerName = Manager::Get()->GetNodeManufacturerName( home, node );
	WriteLog( LogLevel_Debug, false, "ManufacturerName=%s", ManufacturerName.c_str() );
	return ManufacturerName.c_str();

}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeProductName>
// Retrieves the product name of a device
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeProductName( uint32 home, int32 node )
{
	string ProductName;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeProductName" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeProductName: HomeId=0x%x Node=%d", home, node );
	ProductName = Manager::Get()->GetNodeProductName( home, node );
	WriteLog( LogLevel_Debug, false, "ProductName=%s", ProductName.c_str() );
	return ProductName.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeName>
// Get the node name, this value isn't retrieved from the device itself. This can
// be set in the zwcfg*xml. We aren't using it (yet)
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeName( uint32 home, int32 node )
{
	string NodeName;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeName" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeName: HomeId=0x%x Node=%d", home, node );
	NodeName = Manager::Get()->GetNodeName( home, node );
	WriteLog( LogLevel_Debug, false, "NodeName=%s", NodeName.c_str() );
	return NodeName.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeLocation>
// Get the node location information, this is also not retrieved from the device.
// This can be set in the zwcfg*xml. We aren't using it.
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeLocation( uint32 home, int32 node )
{
	string NodeLocation;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeLocation" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeLocation: HomeId=0x%x Node=%d", home, node );
	NodeLocation = Manager::Get()->GetNodeLocation( home, node );
	WriteLog( LogLevel_Debug, false, "NodeLocation=%s", NodeLocation.c_str() );
	return NodeLocation.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeManufacturerId>
// Get the manufacturer id of the device, normally not too interesting
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeManufacturerId( uint32 home, int32 node )
{
	string ManufacturerId;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeManufacturerId" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeManufacturerId: HomeId=0x%x Node=%d", home, node );
	ManufacturerId = Manager::Get()->GetNodeManufacturerId( home, node );
	WriteLog( LogLevel_Debug, false, "ManufacturerId=%s", ManufacturerId.c_str() );
	return ManufacturerId.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeProductType>
// Get the product type id of the device
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeProductType( uint32 home, int32 node )
{
	string ProductType;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeProductType" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeProductType: HomeId=0x%x Node=%d", home, node );
	ProductType = Manager::Get()->GetNodeProductType( home, node );
	WriteLog( LogLevel_Debug, false, "ProductType=%s", ProductType.c_str() );
	return ProductType.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeProductId>
// Get the product id of the device
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeProductId( uint32 home, int32 node )
{
	string ProductId;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeProductId" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeProductId: HomeId=0x%x Node=%d", home, node );
	ProductId = Manager::Get()->GetNodeProductId( home, node );
	WriteLog( LogLevel_Debug, false, "ProductId=%s",ProductId.c_str() );
	return ProductId.c_str();
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetNodeManufacturerName>
//
//-----------------------------------------------------------------------------

void DomoZWave_SetNodeManufacturerName( uint32 home, int32 node, const char* manufacturerName )
{
	string NewManufacturerName(manufacturerName);

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetNodeManufacturerName" ) == false ) return;
	WriteLog( LogLevel_Debug, true, "DomoZWave_SetNodeManufacturerName: HomeId=0x%x Node=%d", home, node );
	WriteLog( LogLevel_Debug, false, "New ManufacturerName=%s", manufacturerName );
	Manager::Get()->SetNodeManufacturerName( home, (uint8)node, NewManufacturerName );
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetNodeProductName>
//
//-----------------------------------------------------------------------------

void DomoZWave_SetNodeProductName( uint32 home, int32 node, const char* productName )
{
	string NewProductName(productName);

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetNodeProductName" ) == false ) return;
	WriteLog( LogLevel_Debug, true, "DomoZWave_SetNodeProductName: HomeId=0x%x Node=%d", home, node );
	WriteLog( LogLevel_Debug, false, "New ProductName=%s", productName );
	Manager::Get()->SetNodeProductName( home, (uint8)node, NewProductName );
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetNodeName>
//
//-----------------------------------------------------------------------------

void DomoZWave_SetNodeName( uint32 home, int32 node, const char* nodeName )
{
	string NewNodeName(nodeName);

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetNodeName" ) == false ) return;
	WriteLog( LogLevel_Debug, true, "DomoZWave_SetNodeName: HomeId=0x%x Node=%d", home, node );
	WriteLog( LogLevel_Debug, false, "New NodeName=%s", nodeName );
	Manager::Get()->SetNodeName( home, (uint8)node, NewNodeName );
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetNodeLocation>
//
//-----------------------------------------------------------------------------

void DomoZWave_SetNodeLocation( uint32 home, int32 node, const char* nodeLocation )
{
	string NewNodeLocation(nodeLocation);

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetNodeLocation" ) == false ) return;
	WriteLog( LogLevel_Debug, true, "DomoZWave_SetNodeLocation: HomeId=0x%x Node=%d", home, node );
	WriteLog( LogLevel_Debug, false, "New NodeLocation=%s", nodeLocation );
	Manager::Get()->SetNodeLocation( home, (uint8)node, NewNodeLocation );
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeLibraryVersion>
// Retrieves the Library Version information of the node (if available)
// NOTE: It can be required to first poll the version information before it is returned here
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeLibraryVersion( uint32 home, int32 node )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeLibraryVersion" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeLibraryVersion: HomeId=0x%x Node=%d", home, node );

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

const char* DomoZWave_GetNodeProtocolVersion( uint32 home, int32 node )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeProtocolVersion" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeProtocolVersion: HomeId=0x%x Node=%d", home, node );

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

const char* DomoZWave_GetNodeApplicationVersion( uint32 home, int32 node )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeApplicationVersion" ) == false ) return "";
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeApplicationVersion: HomeId=0x%x Node=%d", home, node );

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
// <DomoZWave_GetNodeLastSeen>
// Returns the last seen date/time of the node as unix timestamp
//-----------------------------------------------------------------------------

uint32 DomoZWave_GetNodeLastSeen( uint32 home, int32 node )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeLastSeen" ) == false ) return 0;
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeLastSeen: HomeId=0x%x Node=%d", home, node );

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
		if ( nodeInfo->m_LastSeen == 0 )
		{
			WriteLog( LogLevel_Debug, false, "LastSeen=Never" );
		}
		else
		{
			char buf[20];
			strftime( buf, sizeof(buf), "%Y-%m-%d %H:%M:%S", localtime(&nodeInfo->m_LastSeen) );
			WriteLog( LogLevel_Debug, false, "LastSeen=%d (%s)", nodeInfo->m_LastSeen, buf);
		}

		return nodeInfo->m_LastSeen;
	}

	return 0;
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeStatus>
// Returns the status of the node, e.g. alive, dead, sleep, etc
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeStatus( uint32 home, int32 node )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeStatus" ) == false ) return "";

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
		string status;

		switch ( nodeInfo->m_DeviceState )
	        {
			case DZType_Alive:
			{
				status = "Alive";
				break;
			}
			case DZType_Dead:
			{
				status = "Dead";
				break;
			}
			case DZType_Sleep:
			{
				status = "Sleep";
				break;
			}
			case DZType_Awake:
			{
				status = "Awake";
				break;
			}
			case DZType_Timeout:
			{
				status = "Timeout";
				break;
			}
			case DZType_Unknown:
			{
				status = "Unknown";
				break;
			}
			default:
			{
				status = "Other";
				break;
			}
		}

		WriteLog( LogLevel_Debug, false, "Status=%s", status.c_str() );
		return status.c_str();
	}

	return "";
}

//-----------------------------------------------------------------------------
// <DomoZWave_RequestNodeState>
//
//-----------------------------------------------------------------------------

bool DomoZWave_RequestNodeState( uint32 home, int32 node )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RequestNodeState" ) == false ) return false;
	WriteLog( LogLevel_Debug, true, "DomoZWave_RequestNodeState: HomeId=0x%x Node=%d", home, node );
	return Manager::Get()->RequestNodeState( home, node );
}

//-----------------------------------------------------------------------------
// <DomoZWave_RequestNodeDynamic>
//
//-----------------------------------------------------------------------------

bool DomoZWave_RequestNodeDynamic( uint32 home, int32 node )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RequestNodeDynamic" ) == false ) return false;
	WriteLog( LogLevel_Debug, true, "DomoZWave_RequestNodeDynamic: HomeId=0x%x Node=%d", home, node );
	return Manager::Get()->RequestNodeDynamic( home, node );
}

//-----------------------------------------------------------------------------
// <DomoZWave_RequestNodeNeighborUpdate>
// Request the node to update its neighborhood, to optimize z-wave commands
// through the network (mash network)
//-----------------------------------------------------------------------------

bool DomoZWave_RequestNodeNeighborUpdate( uint32 home, int32 node, bool addqueue = false )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RequestNodeNeighborUpdate" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_RequestNodeNeighborUpdate: HomeId=0x%x Node=%d", home, node );

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

bool DomoZWave_RefreshNodeInfo( uint32 home, int32 node )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RefreshNodeInfo" ) == false ) return false;
	WriteLog( LogLevel_Debug, true, "DomoZWave_RefreshNodeInfo: HomeId=0x%x Node=%d", home, node );
	response = Manager::Get()->RefreshNodeInfo( home, node );
	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"true":"false" );
	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_RequestNodeVersion>
// Request the open-zwave to update the node version information (if applicable)
// Library, Protocol and Application version can be updated
//-----------------------------------------------------------------------------

bool DomoZWave_RequestNodeVersion( uint32 home, int32 node )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RequestNodeVersion" ) == false ) return false;
	WriteLog( LogLevel_Debug, true, "DomoZWave_RequestNodeVersion: HomeId=0x%x Node=%d", home, node );

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

bool DomoZWave_RequestNodeMeter( uint32 home, int32 node )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RequestNodeMeter" ) == false ) return false;
	WriteLog( LogLevel_Debug, true, "DomoZWave_RequestNodeMeter: HomeId=0x%x Node=%d", home, node );

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

bool DomoZWave_SetValue( uint32 home, int32 node, int32 instance, int32 value )
{
	bool bool_value;
	int int_value;
	uint8 uint8_value;
	uint16 uint16_value;
	float float_value;
	bool response;
	bool cmdfound = false;
	uint8 usecc;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetValue" ) == false ) return false;

	WriteLog( LogLevel_Debug, true, "DomoZWave_SetValue: HomeId=0x%x Node=%d", home, node );

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{

		// First check if the instance is known in our CommandClass list, else it is a problem
		if ( nodeInfo->instancecommandclass.find(instance) != nodeInfo->instancecommandclass.end() )
		{
			// First try to detect the MULTILEVEL, then try SWITCH_BINARY and last THERMOSTAT_SETPOINT
			// This should solve problems for device like Qubino, they advertise too many CommandClasses
			if ( nodeInfo->instancecommandclass[instance].find("COMMAND_CLASS_SWITCH_MULTILEVEL") != string::npos )
			{
				usecc = COMMAND_CLASS_SWITCH_MULTILEVEL;
			}
			else if ( nodeInfo->instancecommandclass[instance].find("COMMAND_CLASS_SWITCH_BINARY") != string::npos )
			{
				usecc = COMMAND_CLASS_SWITCH_BINARY;
			}
			else if ( nodeInfo->instancecommandclass[instance].find("COMMAND_CLASS_THERMOSTAT_SETPOINT") != string::npos )
			{
				usecc = COMMAND_CLASS_THERMOSTAT_SETPOINT;
			} else {
				// Set to-use CommandClass to zero, because we didn't find anything :-(
				WriteLog( LogLevel_Debug, false, "Return=false (instance doesn't have a CommandClass MULTILEVEL, SWITCH_BINARY or THERMOSTAT_SETPOINT)" );
				return false;
				usecc = 0;
			} 

		}
		else
		{
			WriteLog( LogLevel_Debug, false, "Return=false (instance doesn't exist - it doesn't have a CommandClass list)" );
			return false;
		}

		// Find the correct instance
		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			uint8 id = (*it).GetCommandClassId();
			uint8 inst = (*it).GetInstance();
			string label = Manager::Get()->GetValueLabel( (*it) );

			// Now check the ValueIDs CommandClass id with the preferred CommandClass
			if ( id == usecc )
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
					case COMMAND_CLASS_THERMOSTAT_SETPOINT:
					{
						// Currently we only support Heating 1
						if ( label != "Heating 1" )
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
					else if ( ValueID::ValueType_Decimal == (*it).GetType() )
					{
						// We don't get a float, so divide by 1000 to get the right value
						float_value = (float)value / 1000;
						response = Manager::Get()->SetValue( *it, float_value );
						cmdfound = true;
					}
					else
					{
						WriteLog(LogLevel_Debug, false, "Return=false (unknown ValueType)");
						return false;
					}

					WriteLog( LogLevel_Debug, false, "CommandClass=%s (%d)",  DomoZWave_CommandClassIdName(id), id );
					WriteLog( LogLevel_Debug, false, "Instance=%d", instance );
					if ( ValueID::ValueType_Decimal == (*it).GetType() ) {
						WriteLog( LogLevel_Debug, false, "Value=%f (decimal)", float_value );
					}
					else
					{
						WriteLog( LogLevel_Debug, false, "Value=%d", value );
					}
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
// Set the configuration item to a certain numeric value
//-----------------------------------------------------------------------------

bool DomoZWave_SetConfigParam( uint32 home, int32 node, int32 param, int32 value, int32 size )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetConfigParam" ) == false ) return false;

	WriteLog( LogLevel_Debug, true, "DomoZWave_SetConfigParam: HomeId=0x%x Node=%d", home, node );
	WriteLog( LogLevel_Debug, false, "Parameter=%d", param );
	WriteLog( LogLevel_Debug, false, "Value=%d", value );
	WriteLog( LogLevel_Debug, false, "Size=%d", size );

	// Store value in cache list, used to resolve returning "old" config values
	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
		m_configItem* cachedconfig;
		uint32 timeadd;

		cachedconfig = new m_configItem();

		// Check if it is a listening or sleeping device
		if ( Manager::Get()->IsNodeListeningDevice( home, node ) == true )
		{
			// Lets wait 60 seconds
			timeadd = 60;
		}
		else
		{
			// If nothing found, just wait 60 seconds
			timeadd = 60;

			// Check for wake-up commandclass
			for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
			{
				ValueID v = *it;

				// Find the wake-up interval of this node
				if (( v.GetCommandClassId() == COMMAND_CLASS_WAKE_UP ) && ( v.GetGenre() == ValueID::ValueGenre_System ) && ( v.GetInstance() == 1 ))
				{
					// Only return proper value if it is the right label and integer value
					if (( Manager::Get()->GetValueLabel( v ) == "Wake-up Interval" ) && ( v.GetType() == ValueID::ValueType_Int )) {
						int32 int_value;
						Manager::Get()->GetValueAsInt( v, &int_value );
						timeadd = int_value;
						it = nodeInfo->m_values.end();
					}
				}
			}
		}

		cachedconfig->m_valuetype = ValueID::ValueType_Int;
		cachedconfig->m_valuenumeric = value;
		cachedconfig->m_expiretime = time( NULL ) + timeadd;
		nodeInfo->m_config[ param ] = cachedconfig;
	}

	response = Manager::Get()->SetConfigParam( home, node, param, value, size );
	WriteLog( LogLevel_Debug, false, "Return=%s", (response)?"true":"false" );
	return response;
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetConfigParamList>
// Sets a configuration list item, because it is a string
//-----------------------------------------------------------------------------

bool DomoZWave_SetConfigParamList( uint32 home, int32 node, int32 param, const char* value )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetConfigList" ) == false ) return false;

	WriteLog( LogLevel_Debug, true, "DomoZWave_SetConfigList: HomeId=0x%x Node=%d", home, node );
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
						// Store value in cache list, used to resolve returning "old" config values
						m_configItem* cachedconfig;
						uint32 timeadd;

						cachedconfig = new m_configItem();

						// Check if it is a listening or sleeping device
						if ( Manager::Get()->IsNodeListeningDevice( home, node ) == true )
						{
							// Lets wait 60 seconds
							timeadd = 60;
						}
						else
						{
							// If nothing found, just wait 60 seconds
							timeadd = 60;

							// Check for wake-up commandclass
							for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
							{
								ValueID v = *it;

								// Find the wake-up interval of this node
								if (( v.GetCommandClassId() == COMMAND_CLASS_WAKE_UP ) && ( v.GetGenre() == ValueID::ValueGenre_System ) && ( v.GetInstance() == 1 ))
								{
									// Only return proper value if it is the right label and integer value
									if (( Manager::Get()->GetValueLabel( v ) == "Wake-up Interval" ) && ( v.GetType() == ValueID::ValueType_Int )) {
										int32 int_value;
										Manager::Get()->GetValueAsInt( v, &int_value );
										timeadd = int_value;
										it = nodeInfo->m_values.end();
									}
								}
							}
						}

						// Convert char* to string
						string string_value(value);

						// Setup cached entry and store it
						cachedconfig->m_valuetype = ValueID::ValueType_List;
						cachedconfig->m_expiretime = time( NULL ) + timeadd;
						cachedconfig->m_valuestring = string_value; 
						nodeInfo->m_config[ param ] = cachedconfig;

						// Finally set the string/list value
						return Manager::Get()->SetValueListSelection( v, string_value );
					} else {
						WriteLog( LogLevel_Error, true, "HomeId=0x%x Node=%d Param=%d isn't a list item", home, node, param );
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

void DomoZWave_RequestConfigParam( uint32 home, int32 node, int32 param ) 
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RequestConfigParam" ) == false ) return;
	WriteLog( LogLevel_Debug, true, "DomoZWave_RequestConfigParam: HomeId=0x%x Node=%d", home, node );
	WriteLog( LogLevel_Debug, false, "Parameter=%d", param );
	Manager::Get()->RequestConfigParam( home, node, param );
}

//-----------------------------------------------------------------------------
// <DomoZWave_RequestAllConfigParams>
//
//-----------------------------------------------------------------------------

void DomoZWave_RequestAllConfigParams( uint32 home, int32 node )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RequestAllConfigParams" ) == false ) return;
	WriteLog( LogLevel_Debug, true, "DomoZWave_RequestAllConfigParams: HomeId=0x%x Node=%d", home, node );
	Manager::Get()->RequestAllConfigParams( home, node );
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeConfig>
// Get all the configuration parameters of this node
//-----------------------------------------------------------------------------
const char* DomoZWave_GetNodeConfig( uint32 home, int32 node )
{
	string str;
	bool bool_value;
	uint8 byte_value;
	float float_value;
	string list_value;
	string string_value;
	int int_value;
	int16 short_value;
	int32 count;

	// Create json objects for the node
	json_object *jnode = json_object_new_object();
	json_object *jconfig = json_object_new_object();
	json_object *jarray = json_object_new_array();
	json_object *jvalue;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeConfig" ) == false ) return "";

	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeConfig: HomeId=0x%x Node=%d", home, node );

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
		count = 0;

		jnode = json_object_new_object();
		jarray = json_object_new_array();

		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			// Find the configuration items of this node 
			if ( ( v.GetCommandClassId() == COMMAND_CLASS_CONFIGURATION  ) && ( v.GetGenre() == ValueID::ValueGenre_Config ) && ( v.GetInstance() == 1 ) )
			{
				count++;

				// Check for cached items 
				m_configItem* cachedconfig;
				if ( nodeInfo->m_config.find( v.GetIndex() ) != nodeInfo->m_config.end() )
				{
					// We got a cached item, but check first if it didn't expire
					// If expired, remove item and return NULL
					cachedconfig = nodeInfo->m_config[ v.GetIndex() ];
					if ( difftime( time( NULL ), cachedconfig->m_expiretime ) > 0 ) {
						nodeInfo->m_config.erase( v.GetIndex() );
						cachedconfig = NULL;	
					};
				}
				else
				{
					cachedconfig = NULL;
				}

				jconfig = json_object_new_object();

				// Add index to the node config item
				json_object *jint = json_object_new_int( v.GetIndex() );
				json_object_object_add( jconfig, "index", jint );

				// Add label
				str = Manager::Get()->GetValueLabel( v );
				jvalue = json_object_new_string( str.c_str() );
				json_object_object_add( jconfig, "label", jvalue );

				// Add type, value and possible list entries
				switch ( v.GetType() )
				{
					case ValueID::ValueType_Bool:
					{
						jvalue = json_object_new_string( "bool" );
						json_object_object_add( jconfig, "type", jvalue );

						if ( cachedconfig == NULL )
						{
							Manager::Get()->GetValueAsBool( v, &bool_value );
							jvalue = json_object_new_boolean( bool_value );
						}
						else
						{
							if ( cachedconfig->m_valuenumeric == 0 )
							{
								jvalue = json_object_new_boolean( false );
							}
							else
							{
								jvalue = json_object_new_boolean( true );
							}
						}
						json_object_object_add( jconfig, "value", jvalue );
						break;
					}
					case ValueID::ValueType_Byte:
					{
						jvalue = json_object_new_string( "byte" );
						json_object_object_add( jconfig, "type", jvalue );

						if ( cachedconfig == NULL ) 
						{
							Manager::Get()->GetValueAsByte( v, &byte_value );
							jvalue = json_object_new_int( byte_value );
						}
						else
						{
							jvalue = json_object_new_int( cachedconfig->m_valuenumeric );
						}
						json_object_object_add( jconfig, "value", jvalue );

						byte_value = Manager::Get()->GetValueMin( v );
						jvalue = json_object_new_int( byte_value );
						json_object_object_add( jconfig, "min", jvalue );
						byte_value = Manager::Get()->GetValueMax( v );
						jvalue = json_object_new_int( byte_value );
						json_object_object_add( jconfig, "max", jvalue );
						break;
					}
					case ValueID::ValueType_Decimal:
					{
						jvalue = json_object_new_string( "decimal" );
						json_object_object_add( jconfig, "type", jvalue );
						Manager::Get()->GetValueAsFloat( v, &float_value );
						jvalue = json_object_new_double( float_value );
						json_object_object_add( jconfig, "value", jvalue );
						break;
					}
					case ValueID::ValueType_Int:
					{
						jvalue = json_object_new_string( "int" );
						json_object_object_add( jconfig, "type", jvalue );

						if ( cachedconfig == NULL )
						{
							Manager::Get()->GetValueAsInt( v, &int_value );
							jvalue = json_object_new_int( int_value );
						}
						else
						{
							jvalue = json_object_new_int( cachedconfig->m_valuenumeric );
						}
						json_object_object_add( jconfig, "value", jvalue );

						int_value = Manager::Get()->GetValueMin( v );
						jvalue = json_object_new_int( int_value );
						json_object_object_add( jconfig, "min", jvalue );
						int_value = Manager::Get()->GetValueMax( v );
						jvalue = json_object_new_int( int_value );
						json_object_object_add( jconfig, "max", jvalue );
						break;
					}
					case ValueID::ValueType_Short:
					{
						jvalue = json_object_new_string( "short" );
						json_object_object_add( jconfig, "type", jvalue );

						if ( cachedconfig == NULL )
						{
							Manager::Get()->GetValueAsShort( v, &short_value );
							jvalue = json_object_new_int( short_value );
						}
						else
						{
							jvalue = json_object_new_int( cachedconfig->m_valuenumeric );
						}
						json_object_object_add( jconfig, "value", jvalue );

						short_value = Manager::Get()->GetValueMin( v );
						jvalue = json_object_new_int( short_value );
						json_object_object_add( jconfig, "min", jvalue );
						short_value = Manager::Get()->GetValueMax( v );
						jvalue = json_object_new_int( short_value );
						json_object_object_add( jconfig, "max", jvalue );
						break;
					}
					case ValueID::ValueType_Schedule:
					{
						jvalue = json_object_new_string( "schedule" );
						json_object_object_add( jconfig, "type", jvalue );
						break;
					}
					case ValueID::ValueType_String:
					{
						jvalue = json_object_new_string( "string" );
						json_object_object_add( jconfig, "type", jvalue );

						if ( cachedconfig == NULL )
						{
							Manager::Get()->GetValueAsString( v, &string_value );
							jvalue = json_object_new_string( string_value.c_str() );
						}
						else
						{
							jvalue = json_object_new_string( cachedconfig->m_valuestring.c_str() );
						}
						json_object_object_add( jconfig, "value", jvalue );
						break;
					}
					case ValueID::ValueType_Button:
					{
						jvalue = json_object_new_string( "button" );
						json_object_object_add( jconfig, "type", jvalue );
						break;
					}
					case ValueID::ValueType_List:
					{
						jvalue = json_object_new_string( "list" );
						json_object_object_add( jconfig, "type", jvalue );

						if ( cachedconfig == NULL )
						{
							Manager::Get()->GetValueListSelection( v, &list_value );
							jvalue = json_object_new_string( list_value.c_str() );
						}
						else
						{
							jvalue = json_object_new_string( cachedconfig->m_valuestring.c_str() );
						}
						json_object_object_add( jconfig, "value", jvalue );

						json_object *jarraylist = json_object_new_array();
						vector<string> strs;
						string str;

						Manager::Get()->GetValueListItems( v, &strs );

						for (vector<string>::iterator it = strs.begin(); it != strs.end(); it++)
						{
							str = (*it);
							jvalue = json_object_new_string( str.c_str() );
							json_object_array_add(jarraylist, jvalue );
						}

						json_object_object_add( jconfig, "list", jarraylist );

						break;
					}
					default:
					{
						jvalue = json_object_new_string( "none" );
						json_object_object_add( jconfig, "type", jvalue );
						break;
					}
				}

				// Add cachedconfig information
				if ( cachedconfig == NULL )
				{
					jvalue = json_object_new_boolean( false );
					json_object_object_add( jconfig, "cached", jvalue );
				}
				else
				{
					double seconds;
					seconds = difftime( time( NULL ), cachedconfig->m_expiretime );
					seconds = -seconds;

					jvalue = json_object_new_boolean( true );
					json_object_object_add( jconfig, "cached", jvalue );
					jvalue = json_object_new_int( seconds );
					json_object_object_add( jconfig, "expiry", jvalue );
				}	

				// Add help to the node config item
				str = Manager::Get()->GetValueHelp( v );
				jvalue = json_object_new_string( str.c_str() );
				json_object_object_add( jconfig, "help", jvalue );

				bool_value = Manager::Get()->IsValueReadOnly( v );
				jvalue = json_object_new_boolean( bool_value );
				json_object_object_add( jconfig, "readonly", jvalue );

				// Also report the writonly, required to know if the value is useable or not
				bool_value = Manager::Get()->IsValueWriteOnly( v );
				jvalue = json_object_new_boolean( bool_value );
				json_object_object_add( jconfig, "writeonly", jvalue );

				json_object_array_add( jarray, jconfig );
			}

		}

		jvalue = json_object_new_int( nodeInfo->m_nodeId );
		json_object_object_add( jnode, "node_id", jvalue );
		jvalue = json_object_new_int( count );
		json_object_object_add( jnode, "count", jvalue );
		json_object_object_add( jnode, "config", jarray );

		return json_object_to_json_string( jnode );

	}

	WriteLog( LogLevel_Debug, false, "Config=None (node doesn't exist)" );
	return json_object_to_json_string( jnode );
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeNeighborsList>
// Retrieves the list of neigbors and it will be displayed in the example format:
// 2|3|4|6|7
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeNeighborsList( uint32 home, int32 node )
{
	string neighborslist;
	uint8 *neighbors;
	uint32 numNeighbors;
	char dev_value[1024];

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeNeighborsList" ) == false ) return "";

	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeNeighborsList: HomeId=0x%x Node=%d", home, node );

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

const char* DomoZWave_GetNodeCommandClassList( uint32 home, int32 node, int32 instance = 0 )
{
	string commandclass;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeCommandClassList" ) == false ) return "";

	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeCommandClassList: HomeId=0x%x Node=%d Instance=%d", home, node, instance );

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
// <DomoZWave_GetNodeGroup>
// Get all the group (association) parameters of this node
//-----------------------------------------------------------------------------
const char* DomoZWave_GetNodeGroup( uint32 home, int32 node )
{
	uint32 count;

	// Create json objects for the node
	json_object *jnode = json_object_new_object();
	json_object *jgroup = json_object_new_object();
	json_object *jarray = json_object_new_array();
	json_object *jvalue;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeGroup" ) == false ) return "";

	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeGroup: HomeId=0x%x Node=%d", home, node );

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
		jnode = json_object_new_object();
		jarray = json_object_new_array();

		count = Manager::Get()->GetNumGroups( home, node );

		for( uint32 i=1; i<=count; ++i )
		{
			jgroup = json_object_new_object();

			jvalue = json_object_new_int( i );
			json_object_object_add( jgroup, "group", jvalue );

			uint32 max = Manager::Get()->GetMaxAssociations(home, node, i );
			jvalue = json_object_new_int( max );
			json_object_object_add( jgroup, "max", jvalue );

			string str = Manager::Get()->GetGroupLabel(home, node, i );
			jvalue = json_object_new_string( str.c_str() );
			json_object_object_add( jgroup, "label", jvalue );

			uint8 *associations;
			uint32 numAssociations = Manager::Get()->GetAssociations(home, node, i, &associations );

			json_object *jarrayassoc = json_object_new_array();

			for( uint32 j=0; j<numAssociations; ++j )
			{
				jvalue = json_object_new_int( associations[j] );
				json_object_array_add( jarrayassoc, jvalue );
			}

			json_object_object_add( jgroup, "association", jarrayassoc );
			json_object_array_add( jarray, jgroup );
		}

		jvalue = json_object_new_int( nodeInfo->m_nodeId );
		json_object_object_add( jnode, "node_id", jvalue );
		jvalue = json_object_new_int( count );
		json_object_object_add( jnode, "count", jvalue );
		json_object_object_add( jnode, "group", jarray );

		return json_object_to_json_string( jnode );

	}

	WriteLog( LogLevel_Debug, false, "Group=None (node doesn't exist)" );
	return json_object_to_json_string( jnode );
}

//-----------------------------------------------------------------------------
// <DomoZWave_AddAssociation>
// Adds a node association to a group of a node
//-----------------------------------------------------------------------------

void DomoZWave_AddAssociation( uint32 home, int32 node, int32 group, int32 otherNode )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_AddAssociation" ) == false ) return;
	
	WriteLog( LogLevel_Debug, true, "DomoZWave_AddAssociation: HomeId=0x%x Node=%d", home, node );
	WriteLog( LogLevel_Debug, false, "Group=%d, Node=%d", group, otherNode );

	Manager::Get()->AddAssociation( home, node, group, otherNode );
	// Refresh isn't required anymore with r564
	//Manager::Get()->RefreshNodeInfo( home, node);
}

//-----------------------------------------------------------------------------
// <DomoZWave_RemoveAssociation>
// Remove a group association
//-----------------------------------------------------------------------------

void DomoZWave_RemoveAssociation( uint32 home, int32 node, int32 group, int32 otherNode )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RemoveAssociation" ) == false ) return;

	WriteLog( LogLevel_Debug, true, "RemoveAssociation for HomeId=0x%x Node=%d", home, node );
	WriteLog( LogLevel_Debug, false, "Group=%d, Node=%d", group, otherNode );

	Manager::Get()->RemoveAssociation( home, node, group, otherNode );
	// Refresh isn't required anymore with r564
	//Manager::Get()->RefreshNodeInfo( home, node);
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeUserCode>
// Retrieves the UserCodes for a node
// Format of value is in 0x00 0x00 0x00 ... etc
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeUserCode( uint32 home, int32 node )
{
	uint32 count;

	// Create json objects for the node
	json_object *jnode = json_object_new_object();
	json_object *jusercode = json_object_new_object();
	json_object *jarray = json_object_new_array();
	json_object *jvalue;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeUserCode" ) == false ) return "";

	WriteLog( LogLevel_Debug, true, "DomoZWave_GetNodeUserCode: HomeId=0x%x Node=%d", home, node );

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
		jnode = json_object_new_object();
		jarray = json_object_new_array();

		count = 0;

		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			// Find the usercode items of this node 
			if (( v.GetCommandClassId() == COMMAND_CLASS_USER_CODE ) && ( v.GetGenre() == ValueID::ValueGenre_User ) && ( v.GetInstance() == 1 ))
			{
				jusercode = json_object_new_object();

				jvalue = json_object_new_int( v.GetIndex() );
				json_object_object_add( jusercode, "usercode", jvalue );

				string str = Manager::Get()->GetValueLabel( v );
				jvalue = json_object_new_string( str.c_str() );
				json_object_object_add( jusercode, "label", jvalue );

				if ( v.GetType() == ValueID::ValueType_Raw )
				{
					string string_value;
					Manager::Get()->GetValueAsString( v, &string_value );
					jvalue = json_object_new_string( string_value.c_str() );
					json_object_object_add( jusercode, "value", jvalue );
				}
				else
				{
					// Not implemented
				}

				// Check the index, and if we find a higher value, store it
				if ( v.GetIndex() > count )
				{
					count = v.GetIndex();
				}

				json_object_array_add( jarray, jusercode );
			}

		}

		jvalue = json_object_new_int( nodeInfo->m_nodeId );
		json_object_object_add( jnode, "node_id", jvalue );
		jvalue = json_object_new_int( count );
		json_object_object_add( jnode, "count", jvalue );
		json_object_object_add( jnode, "usercode", jarray );

		return json_object_to_json_string( jnode );

	}

	WriteLog( LogLevel_Debug, false, "UserCode=None (node doesn't exist)" );
	return json_object_to_json_string( jnode );
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetNodeUserCodeStart>
//-----------------------------------------------------------------------------

bool DomoZWave_SetNodeUserCodeStart( uint32 home, int32 node )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetNodeUserCodeStart" ) == false ) return false;

WriteLog( LogLevel_Debug, true, "DomoZWave_SetNodeUserCodeStart: HomeId=0x%x Node=%d", home, node );

m_structCtrl* ctrl = GetControllerInfo( home );

	ctrl->m_userCodeEnrollNode = node;
	ctrl->m_userCodeEnrollTime = time( NULL );

	return true;
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetNodeUserCodeStop>
//-----------------------------------------------------------------------------

bool DomoZWave_SetNodeUserCodeStop( uint32 home )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetNodeUserCodeStop" ) == false ) return false;

WriteLog( LogLevel_Debug, true, "DomoZWave_SetNodeUserCodeStop: HomeId=0x%x", home );

m_structCtrl* ctrl = GetControllerInfo( home );

	ctrl->m_userCodeEnrollNode = 0;
	ctrl->m_userCodeEnrollTime = 0;

	return true;
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetNodeUserCodeRemove>
//-----------------------------------------------------------------------------

bool DomoZWave_SetNodeUserCodeRemove( uint32 home, int32 node, int32 usercode )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetNodeUserCodeRemove" ) == false ) return false;

WriteLog( LogLevel_Debug, true, "DomoZWave_SetNodeUserCodeRemove: HomeId=0x%x Node=%d UserCode=%d", home, node, usercode );

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
					int32 count = 0;
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
// <DomoZWave_GetNodeWakeUpInterval>
// Returns the Wake-Up interval in seconds
// Return -1 if we can't find the value
//-----------------------------------------------------------------------------

long DomoZWave_GetNodeWakeUpInterval( uint32 home, int32 node )
{
	int32 int_value;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeWakeUpInterval" ) == false ) return 0;

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{

		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			// Find the wake-up interval of this node 
			if (( v.GetCommandClassId() == COMMAND_CLASS_WAKE_UP ) && ( v.GetGenre() == ValueID::ValueGenre_System ) && ( v.GetInstance() == 1 ))
			{
				// Only return proper value if it is the right label and integer value 
				if (( Manager::Get()->GetValueLabel( v ) == "Wake-up Interval" ) && ( v.GetType() == ValueID::ValueType_Int )) {
					Manager::Get()->GetValueAsInt( v, &int_value );
					WriteLog( LogLevel_Debug, false, "Wake-Up Value=%d seconds", int_value );
					return int_value;
				}
			}
		}

		WriteLog( LogLevel_Debug, false, "Wake-Up value can't be found (not a sleeping device?)" );
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "Value=None (node doesn't exist)" );
	}

	return -1;
}

//-----------------------------------------------------------------------------
// <DomoZWave_SetNodeWakeUpInterval>
//-----------------------------------------------------------------------------

bool DomoZWave_SetNodeWakeUpInterval( uint32 home, int32 node, int32 interval )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SetNodeWakeUpInterval" ) == false ) return false;

	if ( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{

		for ( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			ValueID v = *it;

			// Find the wake-up interval of this node 
			if (( v.GetCommandClassId() == COMMAND_CLASS_WAKE_UP ) && ( v.GetGenre() == ValueID::ValueGenre_System ) && ( v.GetInstance() == 1 ))
			{
				// Only return proper value if it is the right label and integer value 
				if (( Manager::Get()->GetValueLabel( v ) == "Wake-up Interval" ) && ( v.GetType() == ValueID::ValueType_Int )) {
					Manager::Get()->SetValue( v, interval );
					WriteLog( LogLevel_Debug, false, "Wake-Up Value=%d seconds", interval );
					return true;
				}
			}
		}

		WriteLog( LogLevel_Debug, false, "Wake-Up value can't be found (not a sleeping device?)" );
	}
	else
	{
		WriteLog( LogLevel_Debug, false, "Value=None (node doesn't exist)" );
	}

	return false;
}

//-----------------------------------------------------------------------------
// <DomoZWave_ControllerState>
// Returns the state of the Z-Wave controller. This state is required to
// determine if we can send certain commands to the controller or if we should
// wait/pause for a moment
//-----------------------------------------------------------------------------

bool DomoZWave_ControllerBusy( uint32 home )
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

void DomoZWave_ControllerSoftReset( uint32 home )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_ControllerSoftReset" ) == false ) return;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_ControllerSoftReset: HomeId=0x%x", home );
	Manager::Get()->SoftReset( home );

	ctrl->m_controllerBusy = false;
}

//-----------------------------------------------------------------------------
// <DomoZWave_ControllerHardReset>
// Resets the Controller HARD - it will loose *all* configuration, only do it
// when you're really-really-really sure
//-----------------------------------------------------------------------------

void DomoZWave_ControllerHardReset( uint32 home )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_ControllerHardReset" ) == false ) return;

	// Retrieve controller information and set running to false
	m_structCtrl* ctrl = GetControllerInfo( home );
	ctrl->m_running = false;

	WriteLog( LogLevel_Debug, true, "DomoZWave_ControllerHardReset: HomeId=0x%x", home );
	Manager::Get()->ResetController( home );

	// TBC:
	// We should remove the controller from the list and remove all values?
}

//-----------------------------------------------------------------------------
// <DomoZWave_CancelControllerCommand>
//
//-----------------------------------------------------------------------------

bool DomoZWave_CancelControllerCommand( uint32 home )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_CancelControllerCommand" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );
	ctrl->m_nodeId = 0;

	WriteLog( LogLevel_Debug, true, "DomoZWave_CancelControllerCommand: HomeId=0x%x", home );
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

bool DomoZWave_AddDevice( uint32 home )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_AddDevice" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog(LogLevel_Debug, true, "DomoZWave_AddDevice: HomeId=0x%x", home );

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

bool DomoZWave_RemoveDevice( uint32 home )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RemoveDevice" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_RemoveDevice: HomeId=0x%x", home );

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

bool DomoZWave_AssignReturnRoute( uint32 home, int32 node, int32 destnode )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_AssignReturnRoute" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_AssignReturnRoute: HomeId=0x%x Node=%d", home, node );

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

bool DomoZWave_DeleteAllReturnRoutes( uint32 home, int32 node )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_DeleteAllReturnRoutes" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_DeleteAllReturnRoutes: HomeId=0x%x Node=%d", home, node );

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

bool DomoZWave_RequestNetworkUpdate( uint32 home, int32 node )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RequestNetworkUpdateFromPrimary" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_RequestNetworkUpdateFromPrimary: HomeId=0x%x", home );

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

bool DomoZWave_CreateNewPrimary( uint32 home )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_CreateNewPrimary" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_CreateNewPrimary: HomeId=0x%x", home );

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

bool DomoZWave_TransferPrimaryRole( uint32 home )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_TransferPrimaryRole" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_TransferPrimaryRole: HomeId=0x%x", home );

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

bool DomoZWave_ReceiveConfiguration( uint32 home )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_ReceiveConfiguration" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_ReceiveConfiguration: HomeId=0x%x", home );

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

bool DomoZWave_HasNodeFailed( uint32 home, int32 node, bool addqueue = false )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_HasNodeFailed" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_HasNodeFailed: HomeId=0x%x Node=%d", home, node );

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

bool DomoZWave_RemoveFailedNode( uint32 home, int32 node )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_RemoveFailedNode" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_RemoveFailedNode: HomeId=0x%x Node=%d", home, node );

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

bool DomoZWave_ReplaceFailedNode( uint32 home, int32 node )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_ReplaceFailedNode" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_ReplaceFailedNode: HomeId=0x%x Node=%d", home, node );

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

bool DomoZWave_SendNodeInformation( uint32 home, int32 node )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_SendNodeInformation" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_SendNodeInformation: HomeId=0x%x Node=%d", home, node );

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

bool DomoZWave_ReplicationSend( uint32 home, int32 node )
{
	bool response;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_ReplicationSend" ) == false ) return false;
	m_structCtrl* ctrl = GetControllerInfo( home );

	WriteLog( LogLevel_Debug, true, "DomoZWave_ReplicationSend: HomeId=0x%x Node=%d", home, node );

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

void DomoZWave_HealNetworkNode( uint32 home, int32 node, bool doRR )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_HealNetworkNode" ) == false ) return;

	WriteLog( LogLevel_Debug, true, "DomoZWave_HealNetworkNode: HomeId=0x%x Node=%d", home, node );

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

void DomoZWave_HealNetwork( uint32 home, bool doRR )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_HealNetwork" ) == false ) return;

	WriteLog( LogLevel_Debug, true, "DomoZWave_HealNetwork: HomeId=0x%x", home );

	Manager::Get()->HealNetwork( home, doRR );
}

//-----------------------------------------------------------------------------
// <DomoZWave_TestNetworkNode>
// Do testing of network stability/quality for a specific node
//-----------------------------------------------------------------------------

void DomoZWave_TestNetworkNode( uint32 home, int32 node, int32 count )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_TestNetworkNode" ) == false ) return;

	WriteLog( LogLevel_Debug, true, "DomoZWave_TestNetworkNode: HomeId=0x%x Node=%d", home, node );

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

void DomoZWave_TestNetwork( uint32 home, int32 count )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_TestNetwork" ) == false ) return;

	WriteLog( LogLevel_Debug, true, "DomoZWave_TestNetwork: HomeId=0x%x", home );

	Manager::Get()->TestNetwork( home, count );
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetDriverStatistics>
// Return the Driver statistics for the homeid
//-----------------------------------------------------------------------------

const char* DomoZWave_GetDriverStatistics( uint32 home )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetDriverStatistics" ) == false ) return "";

	Driver::DriverData data;
	Manager::Get()->GetDriverStatistics( home, &data );

	json_object *jstats = json_object_new_object();
	json_object *jcount = json_object_new_int( data.m_SOFCnt );
	json_object_object_add( jstats, "sof", jcount );
	jcount = json_object_new_int( data.m_readAborts );
	json_object_object_add( jstats, "readaborts", jcount );
	jcount = json_object_new_int( data.m_badChecksum );
	json_object_object_add( jstats, "badchecksum", jcount );
	jcount = json_object_new_int( data.m_readCnt );
	json_object_object_add( jstats, "read", jcount );
	jcount = json_object_new_int( data.m_writeCnt );
	json_object_object_add( jstats, "write", jcount );
	jcount = json_object_new_int( data.m_CANCnt );
	json_object_object_add( jstats, "can", jcount );
	jcount = json_object_new_int( data.m_NAKCnt );
	json_object_object_add( jstats, "nak", jcount );
	jcount = json_object_new_int( data.m_ACKCnt );
	json_object_object_add( jstats, "ack", jcount );
	jcount = json_object_new_int( data.m_OOFCnt );
	json_object_object_add( jstats, "oof", jcount );
	jcount = json_object_new_int( data.m_dropped );
	json_object_object_add( jstats, "dropped", jcount );
	jcount = json_object_new_int( data.m_retries );
	json_object_object_add( jstats, "retries", jcount );
	jcount = json_object_new_int( data.m_callbacks );
	json_object_object_add( jstats, "callbacks", jcount );
	jcount = json_object_new_int( data.m_badroutes );
	json_object_object_add( jstats, "badroutes", jcount );
	jcount = json_object_new_int( data.m_noack );
	json_object_object_add( jstats, "noack", jcount );
	jcount = json_object_new_int( data.m_netbusy );
	json_object_object_add( jstats, "netbusy", jcount );
	jcount = json_object_new_int( data.m_notidle );
	json_object_object_add( jstats, "notidle", jcount );
	jcount = json_object_new_int( data.m_nondelivery );
	json_object_object_add( jstats, "nondelivery", jcount );
	jcount = json_object_new_int( data.m_routedbusy );
	json_object_object_add( jstats, "routedbusy", jcount );
	jcount = json_object_new_int( data.m_broadcastReadCnt );
	json_object_object_add( jstats, "broadcastread", jcount );
	jcount = json_object_new_int( data.m_broadcastWriteCnt );
	json_object_object_add( jstats, "broadcastwrite", jcount );

	return json_object_to_json_string( jstats );
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetNodeStatistics>
// Return the node statistics
//-----------------------------------------------------------------------------

const char* DomoZWave_GetNodeStatistics( uint32 home, int32 node )
{
	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetNodeStatistics" ) == false ) return "";

	Node::NodeData data;
	Manager::Get()->GetNodeStatistics( home, node, &data );

	json_object *jstats = json_object_new_object();
	json_object *jcount = json_object_new_int( data.m_sentCnt );
	json_object_object_add( jstats, "sent", jcount );
	jcount = json_object_new_int( data.m_sentFailed );
	json_object_object_add( jstats, "sentfailed", jcount );

	jcount = json_object_new_int( data.m_retries );
	json_object_object_add( jstats, "retries", jcount );
	jcount = json_object_new_int( data.m_receivedCnt );
	json_object_object_add( jstats, "received", jcount );
	jcount = json_object_new_int( data.m_receivedDups );
	json_object_object_add( jstats, "receiveddups", jcount );
	jcount = json_object_new_int( data.m_receivedUnsolicited );
	json_object_object_add( jstats, "receivedunsolicited", jcount );
	jcount = json_object_new_int( data.m_lastRequestRTT );
	json_object_object_add( jstats, "lastrequestrtt", jcount );
	jcount = json_object_new_int( data.m_lastResponseRTT );
	json_object_object_add( jstats, "lastresponsertt", jcount );
	json_object *jvalue = json_object_new_string( data.m_sentTS.c_str() );
	json_object_object_add( jstats, "sentts", jvalue );
	jvalue = json_object_new_string( data.m_receivedTS.c_str() );
	json_object_object_add( jstats, "receivedts", jvalue );
	jcount = json_object_new_int( data.m_averageRequestRTT );
	json_object_object_add( jstats, "averagerequestrtt", jcount );
	jcount = json_object_new_int( data.m_averageResponseRTT );
	json_object_object_add( jstats, "averageresponsertt", jcount );
	jcount = json_object_new_int( data.m_quality );
	json_object_object_add( jstats, "quality", jcount );

//memcpy( _data->m_lastReceivedMessage, m_lastReceivedMessage, sizeof(m_lastReceivedMessage) );
//for( map<uint8,CommandClass*>::const_iterator it = m_commandClassMap.begin(); it != m_commandClassMap.end(); ++it )
//{
//  CommandClassData ccData;
//  ccData.m_commandClassId = it->second->GetCommandClassId();
//  ccData.m_sentCnt = it->second->GetSentCnt();
//  ccData.m_receivedCnt = it->second->GetReceivedCnt();
//  _data->m_ccData.push_back( ccData );
//}

	return json_object_to_json_string( jstats );
}

//-----------------------------------------------------------------------------
// <DomoZWave_GetSendQueueCount>
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// <DomoZWave_GetSendQueueCount>
//-----------------------------------------------------------------------------

long DomoZWave_GetSendQueueCount( uint32 home )
{
	long count;

	if ( DomoZWave_HomeIdPresent( home, "DomoZWave_GetSendQueueCount" ) == false ) return 0;
	WriteLog( LogLevel_Debug, true, "DomoZWave_GetSendQueueCount: HomeId=0x%x", home );
	count = Manager::Get()->GetSendQueueCount( home );
	WriteLog( LogLevel_Debug, false, "Count=%d", count );
	return count;
}

//-----------------------------------------------------------------------------
// <DomoZWave_CommandClassIdName>
// Returns a readable name of a COMMAND_CLASS. If it is unknown, it will display "Unknown"
//-----------------------------------------------------------------------------

const char* DomoZWave_CommandClassIdName(int class_value)
{

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
		case 0x2C: return "COMMAND_CLASS_SCENE_ACTUATOR_CONF";
		case 0x2D: return "COMMAND_CLASS_SCENE_CONTROLLER_CONF";
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
		case 0x56: return "COMMAND_CLASS_CRC_16_ENCAP";
		case 0x59: return "COMMAND_CLASS_ASSOCIATION_GROUP_INFORMATION";
		case 0x5A: return "COMMAND_CLASS_DEVICE_RESET_LOCALLY";
		case 0x5B: return "COMMAND_CLASS_CENTRAL_SCENE";
		case 0x5E: return "COMMAND_CLASS_ZWAVE_PLUS";
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
		case 0x7A: return "COMMAND_CLASS_FIRMWARE_UPDATE_MD";
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
			// We need to report unknown commandclass, the value is in decimal
			string str = SSTR( "Unknown (" << class_value << ")" );
			WriteLog( LogLevel_Debug, true, "DomoZWave_CommandClassIdName: %s", str.c_str() );
			return str.c_str();
		}
	}
}

//-----------------------------------------------------------------------------
// <DomoZWave_GenreIdName>
//
//-----------------------------------------------------------------------------

const char* DomoZWave_GenreIdName( int genre )
{
	char tmp_str[100];

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
			snprintf( tmp_str, 100, "UNKNOWN (0x%02X)", genre );
			return string(tmp_str).c_str();
		}
	}
}

//-----------------------------------------------------------------------------
// <DomoZWave_BasicTypeName>
// Returns readable basic type information
//-----------------------------------------------------------------------------

const char* DomoZWave_BasicTypeName( int32 basictype )
{

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
			// We need to report unknown basic types, the value is in decimal
			string str = SSTR( "Unknown (" << basictype << ")" );
			WriteLog( LogLevel_Debug, true, "DomoZWave_BasicTypeName: %s", str.c_str() );
			return str.c_str();
		}
	}
}

//-----------------------------------------------------------------------------
// <DomoZWave_GenericTypeName>
// Returns readable generic type information
//-----------------------------------------------------------------------------

const char* DomoZWave_GenericTypeName( int32 generictype )
{

	return DomoZWave_SpecificTypeName( generictype, 0 );

}

//-----------------------------------------------------------------------------
// <DomoZWave_SpecificTypeName>
// Return generic (specific=0) or specific type. If specific type is unknown, the generic is returned
//-----------------------------------------------------------------------------

const char* DomoZWave_SpecificTypeName( int32 generictype, int32 specifictype )
{

	switch ( generictype )
	{
		case GENERIC_TYPE_GENERIC_CONTROLLER:
			switch ( specifictype )
			{
				case 0x01: return "Portable Remote Controller";
				case 0x02: return "Portable Scene Controller";
				case 0x03: return "Portable Installer Tool";
			} 
			return "Generic Controller";
		case GENERIC_TYPE_STATIC_CONTROLLER:
			switch ( specifictype )
			{
				case 0x01: return "Static PC Controller";
				case 0x02: return "Static Scene Controller";
				case 0x03: return "Static Installer Tool";
			} 
			return "Static Controller";
		case GENERIC_TYPE_AV_CONTROL_POINT:
			switch ( specifictype )
			{
				case 0x04: return "Satellite Receiver";
				case 0x11: return "Satellite Receiver V2";
				case 0x12: return "Doorbell";
			} 
			return "AV Control Point";
		case GENERIC_TYPE_DISPLAY:
			switch ( specifictype )
			{
				case 0x01: return "Simple Display";
			} 
			return "Display";
		case GENERIC_TYPE_THERMOSTAT:
			switch ( specifictype )
			{
				case 0x01: return "Heating Thermostat";
				case 0x02: return "General Thermostat";
				case 0x03: return "Setback Schedule Thermostat";
				case 0x04: return "Setpoint Thermostat";
				case 0x05: return "Setback Thermostat";
				case 0x06: return "General Thermostat V2";
			} 
			return "Thermostat";
		case GENERIC_TYPE_WINDOW_COVERING:
			switch ( specifictype )
			{
				case 0x01: return "Simple Window Covering";
			}
			return "Window Covering";
		case GENERIC_TYPE_REPEATER_SLAVE:
			switch ( specifictype )
			{
				case 0x01: return "Basic Repeater Slave";
			}
			return "Repeating Slave";
		case GENERIC_TYPE_SWITCH_BINARY:
			switch ( specifictype )
			{
				case 0x01: return "Binary Power Switch";
				case 0x03: return "Binary Scene Switch";
			}
			return "Binary Switch";
		case GENERIC_TYPE_SWITCH_MULTILEVEL:
			switch ( specifictype )
			{
				case 0x01: return "Multilevel Power Switch";
				case 0x03: return "Multiposition Motor";
				case 0x04: return "Multilevel Scene Switch";
				case 0x05: return "Motor Control Class A";
				case 0x06: return "Motor Control Class B";
				case 0x07: return "Motor Control Class C";
			}
			return "Multilevel Switch";
		case GENERIC_TYPE_SWITCH_REMOTE:
			switch ( specifictype )
			{
				case 0x01: return "Binary Remote Switch";
				case 0x02: return "Multilevel Remote Switch";
				case 0x03: return "Binary Toggle Remote Switch";
				case 0x04: return "Multilevel Toggle Remote Switch";
			}
			return "Remote Switch";
		case GENERIC_TYPE_SWITCH_TOGGLE:
			switch ( specifictype )
			{
				case 0x01: return "Binary Toggle Switch";
				case 0x02: return "Multilevel Toggle Switch";
			}
			return "Toggle Switch";
		case GENERIC_TYPE_ZIP_GATEWAY:
			switch ( specifictype )
			{
				case 0x01: return "Z/IP Tunneling Gateway";
				case 0x02: return "Z/IP Advanced Gateway";
			}
			return "Zip Gateway";
		case GENERIC_TYPE_ZIP_NODE:
			switch ( specifictype )
			{
				case 0x01: return "Z/IP Tunneling Node";
				case 0x02: return "Z/IP Advanced Node";
			}
			return "Zip Node";
		case GENERIC_TYPE_VENTILATION:
			switch ( specifictype )
			{
				case 0x01: return "Residential Heat Recovery Ventilation";
			}
			return "Ventilation";
		case GENERIC_TYPE_SENSOR_BINARY:
			switch ( specifictype )
			{
				case 0x01: return "Routing Binary Sensor";
			}
			return "Binary Sensor";
		case GENERIC_TYPE_SENSOR_MULTILEVEL:
			switch ( specifictype )
			{
				case 0x01: return "Routing Multilevel Sensor";
			}
			return "Multilevel Sensor";
		case GENERIC_TYPE_METER_PULSE:
			switch ( specifictype )
			{
			}
			return "Pulse Meter";
		case GENERIC_TYPE_METER:
			switch ( specifictype )
			{
				case 0x01: return "Simple Meter";
			}
			return "Meter";
		case GENERIC_TYPE_ENTRY_CONTROL:
			switch ( specifictype )
			{
				case 0x01: return "Door Lock";
				case 0x02: return "Advanced Door Lock";
				case 0x03: return "Secure Keypad Door Lock";
			}
			return "Entry Control";
		case GENERIC_TYPE_SEMI_INTEROPERABLE:
			switch ( specifictype )
			{
				case 0x01: return "Energy Production";
			}
			return "Semi Interoperable";
		case GENERIC_TYPE_SENSOR_ALARM:
			switch ( specifictype )
			{
				case 0x01: return "Basic Routing Alarm Sensor";
				case 0x02: return "Routing Alarm Sensor";
				case 0x03: return "Basic Zensor Alarm Sensor";
				case 0x04: return "Zensor Alarm Sensor";
				case 0x05: return "Advanced Zensor Alarm Sensor";
				case 0x06: return "Basic Routing Smoke Sensor";
				case 0x07: return "Routing Smoke Sensor";
				case 0x08: return "Basic Zensor Smoke Sensor";
				case 0x09: return "Zensor Smoke Sensor";
				case 0x0a: return "Advanced Zensor Smoke Sensor";
			}
			return "Alarm Sensor";
		case GENERIC_TYPE_NON_INTEROPERABLE:
			switch ( specifictype )
			{
				// Nothing yet
			}
			return "Non Interoperable";
		default:
		{
			// We need to report unknown generic types, the value is in decimal
			string str = SSTR( "Unknown (" << generictype << ")" );
			WriteLog( LogLevel_Debug, true, "DomoZWave_Generic/SpecificTypeName: %s", str.c_str() );
			return str.c_str();
		}
	}
}

///////////////////////////////////////////////////////////////////////////////

}
