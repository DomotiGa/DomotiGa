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

#define COMMAND_CLASS_NO_OPERATION 0x00
#define COMMAND_CLASS_BASIC 0x20
#define COMMAND_CLASS_CONTROLLER_REPLICATION 0x21
#define COMMAND_CLASS_APPLICATION_STATUS 0x22
#define COMMAND_CLASS_ZIP_SERVICES 0x23
#define COMMAND_CLASS_ZIP_SERVER 0x24
#define COMMAND_CLASS_SWITCH_BINARY 0x25
#define COMMAND_CLASS_SWITCH_MULTILEVEL 0x26
#define COMMAND_CLASS_SWITCH_ALL 0x27
#define COMMAND_CLASS_SWITCH_TOGGLE_BINARY 0x28
#define COMMAND_CLASS_SWITCH_TOGGLE_MULTILEVEL 0x29
#define COMMAND_CLASS_CHIMNEY_FAN 0x2A
#define COMMAND_CLASS_SCENE_ACTIVATION 0x2B
#define COMMAND_CLASS_SCENE_ACTUATOR CONF 0x2C
#define COMMAND_CLASS_SCENE_CONTROLLER CONF 0x2D
#define COMMAND_CLASS_ZIP_CLIENT 0x2E
#define COMMAND_CLASS_ZIP_ADV_SERVICES 0x2F
#define COMMAND_CLASS_SENSOR_BINARY 0x30
#define COMMAND_CLASS_SENSOR_MULTILEVEL 0x31
#define COMMAND_CLASS_METER 0x32
#define COMMAND_CLASS_ZIP_ADV_SERVER 0x33
#define COMMAND_CLASS_ZIP_ADV_CLIENT 0x34
#define COMMAND_CLASS_METER_PULSE 0x35
#define COMMAND_CLASS_THERMOSTAT_HEATING 0x38
#define COMMAND_CLASS_THERMOSTAT_MODE 0x40
#define COMMAND_CLASS_THERMOSTAT_OPERATING_STATE 0x42
#define COMMAND_CLASS_THERMOSTAT_SETPOINT 0x43
#define COMMAND_CLASS_THERMOSTAT_FAN_MODE 0x44
#define COMMAND_CLASS_THERMOSTAT_FAN_STATE 0x45
#define COMMAND_CLASS_CLIMATE_CONTROL_SCHEDULE 0x46
#define COMMAND_CLASS_THERMOSTAT_SETBACK 0x47
#define COMMAND_CLASS_DOOR_LOCK_LOGGING 0x4C
#define COMMAND_CLASS_SCHEDULE_ENTRY_LOCK 0x4E
#define COMMAND_CLASS_BASIC_WINDOW_COVERING 0x50
#define COMMAND_CLASS_MTP_WINDOW_COVERING 0x51
#define COMMAND_CLASS_MULTI_INSTANCE 0x60
#define COMMAND_CLASS_DOOR_LOCK 0x62
#define COMMAND_CLASS_USER_CODE 0x63
#define COMMAND_CLASS_CONFIGURATION 0x70
#define COMMAND_CLASS_ALARM 0x71
#define COMMAND_CLASS_MANUFACTURER_SPECIFIC 0x72
#define COMMAND_CLASS_POWERLEVEL 0x73
#define COMMAND_CLASS_PROTECTION 0x75
#define COMMAND_CLASS_LOCK 0x76
#define COMMAND_CLASS_NODE_NAMING 0x77
#define COMMAND_CLASS_FIRMWARE_UPDATE_MD 0x7A
#define COMMAND_CLASS_GROUPING_NAME 0x7B
#define COMMAND_CLASS_REMOTE_ASSOCIATION_ACTIVATE 0x7C
#define COMMAND_CLASS_REMOTE_ASSOCIATION 0x7D
#define COMMAND_CLASS_BATTERY 0x80
#define COMMAND_CLASS_CLOCK 0x81
#define COMMAND_CLASS_HAIL 0x82
#define COMMAND_CLASS_WAKE_UP 0x84
#define COMMAND_CLASS_ASSOCIATION 0x85
#define COMMAND_CLASS_VERSION 0x86
#define COMMAND_CLASS_INDICATOR 0x87
#define COMMAND_CLASS_PROPRIETARY 0x88
#define COMMAND_CLASS_LANGUAGE 0x89
#define COMMAND_CLASS_TIME 0x8A
#define COMMAND_CLASS_TIME_PARAMETERS 0x8B
#define COMMAND_CLASS_GEOGRAPHIC_LOCATION 0x8C
#define COMMAND_CLASS_COMPOSITE 0x8D
#define COMMAND_CLASS_MULTI_INSTANCE_ASSOCIATION 0x8E
#define COMMAND_CLASS_MULTI_CMD 0x8F
#define COMMAND_CLASS_ENERGY_PRODUCTION 0x90
#define COMMAND_CLASS_MANUFACTURER_PROPRIETARY 0x91
#define COMMAND_CLASS_SCREEN_MD 0x92
#define COMMAND_CLASS_SCREEN_ATTRIBUTES 0x93
#define COMMAND_CLASS_SIMPLE_AV_CONTROL 0x94
#define COMMAND_CLASS_AV_CONTENT_DIRECTORY MD 0x95
#define COMMAND_CLASS_AV_RENDERER_STATUS 0x96
#define COMMAND_CLASS_AV_CONTENT_SEARCH_MD 0x97
#define COMMAND_CLASS_SECURITY 0x98
#define COMMAND_CLASS_AV_TAGGING_MD 0x99
#define COMMAND_CLASS_IP_CONFIGURATION 0x9A
#define COMMAND_CLASS_ASSOCIATION_COMMAND_CONFIGURATION 0x9B
#define COMMAND_CLASS_SENSOR_ALARM 0x9C
#define COMMAND_CLASS_SILENCE_ALARM 0x9D
#define COMMAND_CLASS_SENSOR_CONFIGURATION 0x9E
#define COMMAND_CLASS_MARK 0xEF
#define COMMAND_CLASS_NON_INTEROPERABLE 0xF0

extern "C" {
int DomoZWave_Version();
bool DomoZWave_HomeIdPresent( const char* _param );
void DomoZWave_Init( const char* serialPort, int rpcPort, const char* configdir, const char* zwdir, bool enableLog, int polltime );
void DomoZWave_EnablePolling( int node, int polltime );
void DomoZWave_DisablePolling( int node );
void DomoZWave_RequestNodeState( int node );
void DomoZWave_RequestNodeDynamic( int node );
void DomoZWave_RequestNetworkUpdate( );
void DomoZWave_AddDevice();
void DomoZWave_RemoveDevice( int node );
void DomoZWave_RequestNodeNeighborUpdate( int node );
void DomoZWave_CancelControllerCommand();
void DomoZWave_SetConfigParam( int node, int param, int value, int size );
void DomoZWave_RequestConfigParam( int node, int param );
void DomoZWave_RequestAllConfigParams( int node );
void DomoZWave_SetValue( int node, int instance, int value );
void DomoZWave_AddAssociation( int node, int group );
const char* DomoZWave_GetNodeManufacturerName( int node );
const char* DomoZWave_GetNodeProductName( int node );
const char* DomoZWave_GetNodeName( int node );
const char* DomoZWave_GetNodeLocation( int node );
const char* DomoZWave_GetNodeManufacturerId( int node );
const char* DomoZWave_GetNodeProductType( int node );
const char* DomoZWave_GetNodeProductId( int node );
const char* DomoZWave_GetLibraryVersion();
const char* DomoZWave_GetLibraryTypeName();
const char* DomoZWave_ControllerType();
const char* DomoZWave_GetNodeNeighborsList( int node );
const char* DomoZWave_GetNodeCommandClassList( int node );
long DomoZWave_GetSendQueueCount();

const char* DomoZWave_CommandClassIdName(uint8 class_value);
const char* DomoZWave_GenreIdName(uint8 genre);
}
