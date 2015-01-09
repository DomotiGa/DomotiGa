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

#define COMMAND_CLASS_NO_OPERATION 0x00 /* 0 */
#define COMMAND_CLASS_BASIC 0x20 /* 32 */
#define COMMAND_CLASS_CONTROLLER_REPLICATION 0x21 /* 33 */
#define COMMAND_CLASS_APPLICATION_STATUS 0x22 /* 34 */
#define COMMAND_CLASS_ZIP_SERVICES 0x23 /* 35 */
#define COMMAND_CLASS_ZIP_SERVER 0x24 /* 36 */
#define COMMAND_CLASS_SWITCH_BINARY 0x25 /* 37 */
#define COMMAND_CLASS_SWITCH_MULTILEVEL 0x26 /* 38 */
#define COMMAND_CLASS_SWITCH_ALL 0x27 /* 39 */
#define COMMAND_CLASS_SWITCH_TOGGLE_BINARY 0x28 /* 40 */
#define COMMAND_CLASS_SWITCH_TOGGLE_MULTILEVEL 0x29 /* 41 */
#define COMMAND_CLASS_CHIMNEY_FAN 0x2A /* 42 */
#define COMMAND_CLASS_SCENE_ACTIVATION 0x2B /* 43 */
#define COMMAND_CLASS_SCENE_ACTUATOR_CONF 0x2C /* 44 */
#define COMMAND_CLASS_SCENE_CONTROLLER_CONF 0x2D /* 45 */
#define COMMAND_CLASS_ZIP_CLIENT 0x2E /* 46 */
#define COMMAND_CLASS_ZIP_ADV_SERVICES 0x2F /* 47 */
#define COMMAND_CLASS_SENSOR_BINARY 0x30 /* 48 */
#define COMMAND_CLASS_SENSOR_MULTILEVEL 0x31 /* 49 */
#define COMMAND_CLASS_METER 0x32 /* 50 */
#define COMMAND_CLASS_ZIP_ADV_SERVER 0x33 /* 51 */
#define COMMAND_CLASS_ZIP_ADV_CLIENT 0x34 /* 52 */
#define COMMAND_CLASS_METER_PULSE 0x35 /* 53 */
#define COMMAND_CLASS_THERMOSTAT_HEATING 0x38 /* 56 */
#define COMMAND_CLASS_THERMOSTAT_MODE 0x40 /* 64 */
#define COMMAND_CLASS_THERMOSTAT_OPERATING_STATE 0x42 /* 66 */
#define COMMAND_CLASS_THERMOSTAT_SETPOINT 0x43 /* 67 */
#define COMMAND_CLASS_THERMOSTAT_FAN_MODE 0x44 /* 68 */
#define COMMAND_CLASS_THERMOSTAT_FAN_STATE 0x45 /* 69 */
#define COMMAND_CLASS_CLIMATE_CONTROL_SCHEDULE 0x46 /* 70 */
#define COMMAND_CLASS_THERMOSTAT_SETBACK 0x47 /* 71 */
#define COMMAND_CLASS_DOOR_LOCK_LOGGING 0x4C /* 76 */
#define COMMAND_CLASS_SCHEDULE_ENTRY_LOCK 0x4E /* 78 */
#define COMMAND_CLASS_BASIC_WINDOW_COVERING 0x50 /* 80 */
#define COMMAND_CLASS_MTP_WINDOW_COVERING 0x51 /* 81 */
#define COMMAND_CLASS_CENTRAL_SCENE 0x5B /* 91 */
#define COMMAND_CLASS_MULTI_INSTANCE 0x60 /* 96 */
#define COMMAND_CLASS_DOOR_LOCK 0x62 /* 98 */
#define COMMAND_CLASS_USER_CODE 0x63 /* 99 */
#define COMMAND_CLASS_CONFIGURATION 0x70 /* 112 */
#define COMMAND_CLASS_ALARM 0x71 /* 113 */
#define COMMAND_CLASS_MANUFACTURER_SPECIFIC 0x72 /* 114 */
#define COMMAND_CLASS_POWERLEVEL 0x73 /* 115 */
#define COMMAND_CLASS_PROTECTION 0x75 /* 117 */
#define COMMAND_CLASS_LOCK 0x76 /* 118 */
#define COMMAND_CLASS_NODE_NAMING 0x77 /* 119 */
#define COMMAND_CLASS_FIRMWARE_UPDATE_MD 0x7A /* 122 */
#define COMMAND_CLASS_GROUPING_NAME 0x7B /* 123 */
#define COMMAND_CLASS_REMOTE_ASSOCIATION_ACTIVATE 0x7C /* 124 */
#define COMMAND_CLASS_REMOTE_ASSOCIATION 0x7D /* 125 */
#define COMMAND_CLASS_BATTERY 0x80 /* 128 */
#define COMMAND_CLASS_CLOCK 0x81 /* 129 */
#define COMMAND_CLASS_HAIL 0x82 /* 130 */
#define COMMAND_CLASS_WAKE_UP 0x84 /* 132 */
#define COMMAND_CLASS_ASSOCIATION 0x85 /* 133 */
#define COMMAND_CLASS_VERSION 0x86 /* 134 */
#define COMMAND_CLASS_INDICATOR 0x87 /* 135 */
#define COMMAND_CLASS_PROPRIETARY 0x88 /* 136 */
#define COMMAND_CLASS_LANGUAGE 0x89 /* 137 */
#define COMMAND_CLASS_TIME 0x8A /* 138 */
#define COMMAND_CLASS_TIME_PARAMETERS 0x8B /* 139 */
#define COMMAND_CLASS_GEOGRAPHIC_LOCATION 0x8C /* 140 */
#define COMMAND_CLASS_COMPOSITE 0x8D /* 141 */
#define COMMAND_CLASS_MULTI_INSTANCE_ASSOCIATION 0x8E /* 142 */
#define COMMAND_CLASS_MULTI_CMD 0x8F /* 143 */
#define COMMAND_CLASS_ENERGY_PRODUCTION 0x90 /* 144 */
#define COMMAND_CLASS_MANUFACTURER_PROPRIETARY 0x91 /* 145 */
#define COMMAND_CLASS_SCREEN_MD 0x92 /* 146 */
#define COMMAND_CLASS_SCREEN_ATTRIBUTES 0x93 /* 147 */
#define COMMAND_CLASS_SIMPLE_AV_CONTROL 0x94 /* 148 */
#define COMMAND_CLASS_AV_CONTENT_DIRECTORY_MD 0x95 /* 149 */
#define COMMAND_CLASS_AV_RENDERER_STATUS 0x96 /* 150 */
#define COMMAND_CLASS_AV_CONTENT_SEARCH_MD 0x97 /* 151 */
#define COMMAND_CLASS_SECURITY 0x98 /* 152 */
#define COMMAND_CLASS_AV_TAGGING_MD 0x99 /* 153 */
#define COMMAND_CLASS_IP_CONFIGURATION 0x9A /* 154 */
#define COMMAND_CLASS_ASSOCIATION_COMMAND_CONFIGURATION 0x9B /* 155 */
#define COMMAND_CLASS_SENSOR_ALARM 0x9C /* 156 */
#define COMMAND_CLASS_SILENCE_ALARM 0x9D /* 157 */
#define COMMAND_CLASS_SENSOR_CONFIGURATION 0x9E /* 158 */
#define COMMAND_CLASS_MARK 0xEF /* 239 */
#define COMMAND_CLASS_NON_INTEROPERABLE 0xF0 /* 240 */

#define BASIC_TYPE_CONTROLLER 0x01 /* 1 */
#define BASIC_TYPE_STATIC_CONTROLLER 0x02 /* 2 */
#define BASIC_TYPE_SLAVE 0x03 /* 3 */
#define BASIC_TYPE_ROUTING_SLAVE 0x04 /* 4 */

#define GENERIC_TYPE_GENERIC_CONTROLLER 0x01 /* 1 */
#define GENERIC_TYPE_STATIC_CONTROLLER 0x02 /* 2 */
#define GENERIC_TYPE_AV_CONTROL_POINT 0x03 /* 3 */
#define GENERIC_TYPE_DISPLAY 0x04 /* 4 */
#define GENERIC_TYPE_THERMOSTAT 0x08 /* 8 */
#define GENERIC_TYPE_WINDOW_COVERING 0x09 /* 9 */
#define GENERIC_TYPE_REPEATER_SLAVE 0x0F /* 15 */
#define GENERIC_TYPE_SWITCH_BINARY 0x10 /* 16 */
#define GENERIC_TYPE_SWITCH_MULTILEVEL 0x11 /* 17 */
#define GENERIC_TYPE_SWITCH_REMOTE 0x12 /* 18 */
#define GENERIC_TYPE_SWITCH_TOGGLE 0x13 /* 19 */
#define GENERIC_TYPE_ZIP_GATEWAY 0x14 /* 20 */
#define GENERIC_TYPE_ZIP_NODE 0x15 /* 21 */
#define GENERIC_TYPE_VENTILATION 0x16 /* 22 */
#define GENERIC_TYPE_SENSOR_BINARY 0x20 /* 32 */
#define GENERIC_TYPE_SENSOR_MULTILEVEL 0x21 /* 33 */
#define GENERIC_TYPE_METER_PULSE 0x30 /* 48 */
#define GENERIC_TYPE_METER 0x31 /* 49 */
#define GENERIC_TYPE_ENTRY_CONTROL 0x40 /* 64 */
#define GENERIC_TYPE_SEMI_INTEROPERABLE 0x50 /* 80 */
#define GENERIC_TYPE_SENSOR_ALARM 0xA1 /* 161 */
#define GENERIC_TYPE_NON_INTEROPERABLE 0xFF /* 255 */

extern "C" {

// Initialize and destroy the wrapper
void DomoZWave_Init( const char* configdir, const char* zwdir, const char* logname, bool enableInitLog );
void DomoZWave_Destroy( );

//
void DomoZWave_Log( bool logging );

//
void DomoZWave_AddSerialPort( const char* serialPort, const char* jsonrpcurl, bool logging );
void DomoZWave_RemoveSerialPort( const char* serialPort );

// Write zwcfg*xml, normally this happens automatically when the open-wave initialized or exits
void DomoZWave_WriteConfig( uint32 home );

// Retrieve wrapper and controller information
bool DomoZWave_ControllerBusy( uint32 home );
const char* DomoZWave_Version( );
const char* DomoZWave_OZWVersion( );
const char* DomoZWave_GetLibraryVersion( uint32 home );
const char* DomoZWave_GetLibraryTypeName( uint32 home );
const char* DomoZWave_ControllerType( uint32 home );

// Enable/disable polling of the devices by open-zwave
int32 DomoZWave_GetPollInterval( );
void DomoZWave_SetPollInterval( int32 milliseconds, bool intervalbetweenpolls );
void DomoZWave_EnablePolling( uint32 home, int32 node, int32 polltime );
void DomoZWave_DisablePolling( uint32 home, int32 node );

// Retrieve or set node information
const char* DomoZWave_GetNodeQueryStage( uint32 home, int32 node );
const char* DomoZWave_GetNodeManufacturerName( uint32 home, int32 node );
const char* DomoZWave_GetNodeProductName( uint32 home, int32 node );
const char* DomoZWave_GetNodeName( uint32 home, int32 node );
const char* DomoZWave_GetNodeLocation( uint32 home, int32 node );
const char* DomoZWave_GetNodeManufacturerId( uint32 home, int32 node );
const char* DomoZWave_GetNodeProductType( uint32 home, int32 node );
const char* DomoZWave_GetNodeProductId( uint32 home, int32 node );
void DomoZWave_SetNodeManufacturerName( uint32 home, int32 node, const char* manufacturerName );
void DomoZWave_SetNodeProductName( uint32 home, int32 node, const char* productName );
void DomoZWave_SetNodeName( uint32 home, int32 node, const char* nodeName );
void DomoZWave_SetNodeLocation( uint32 home, int32 node, const char* nodeLocation );
const char* DomoZWave_GetNodeLibraryVersion( uint32 home, int32 node );
const char* DomoZWave_GetNodeProtocolVersion( uint32 home, int32 node );
const char* DomoZWave_GetNodeApplicationVersion( uint32 home, int32 node );
uint32 DomoZWave_GetNodeLastSeen( uint32 home, int32 node );
const char* DomoZWave_GetNodeStatus( uint32 home, int32 node);

// Request or update node state
bool DomoZWave_RequestNodeState( uint32 home, int32 node );
bool DomoZWave_RequestNodeDynamic( uint32 home, int32 node );
bool DomoZWave_RequestNodeNeighborUpdate( uint32 home, int32 node, bool addqueue );
bool DomoZWave_RefreshNodeInfo( uint32 home, int32 node );
bool DomoZWave_RequestNodeVersion( uint32 home, int32 node );
bool DomoZWave_RequestNodeMeter( uint32 home, int32 node );
bool DomoZWave_SetValue( uint32 home, int32 node, int32 instance, int32 value );

// Request or update node configuration
bool DomoZWave_SetConfigParam( uint32 home, int32 node, int32 param, int32 value, int32 size );
bool DomoZWave_SetConfigParamList( uint32 home, int32 node, int32 param, const char* value );
void DomoZWave_RequestConfigParam( uint32 home, int32 node, int32 param );
void DomoZWave_RequestAllConfigParams( uint32 home, int32 node );
const char* DomoZWave_GetNodeConfig( uint32 home, int32 node );

// Retrieve the node neighborhood list or commandclass list
const char* DomoZWave_GetNodeNeighborsList( uint32 home, int32 node );
const char* DomoZWave_GetNodeCommandClassList( uint32 home, int32 node, int32 instance );

// Request or update the group/association of a node
const char* DomoZWave_GetNodeGroup( uint32 home, int32 node );
void DomoZWave_AddAssociation( uint32 home, int32 node, int group, int otherNode );
void DomoZWave_RemoveAssociation( uint32 home, int32 node, int group, int otherNode );

// Request or set UserCode of a node
const char* DomoZWave_GetNodeUserCode( uint32 home, int32 node );
bool DomoZWave_SetNodeUserCodeStart( uint32 home, int32 node );
bool DomoZWave_SetNodeUserCodeStop( uint32 home );
bool DomoZWave_SetNodeUserCodeRemove( uint32 home, int32 node, int32 usercode );

// Request or set Wake-Up of a sleeping node
long DomoZWave_GetNodeWakeUpInterval( uint32 home, int32 node );
bool DomoZWave_SetNodeWakeUpInterval( uint32 home, int32 node, int32 interval );

// Soft or hard reset the controller
void DomoZWave_ControllerSoftReset( uint32 home );
void DomoZWave_ControllerHardReset( uint32 home );

// Controller commands
bool DomoZWave_CancelControllerCommand( uint32 home );
bool DomoZWave_AddDevice( uint32 home );
bool DomoZWave_RemoveDevice( uint32 home );
bool DomoZWave_AssignReturnRoute( uint32 home, int32 node, int32 destnode );
bool DomoZWave_DeleteAllReturnRoutes( uint32 home, int32 node );
bool DomoZWave_RequestNetworkUpdate( uint32 home, int32 node );
bool DomoZWave_CreateNewPrimary( uint32 home );
bool DomoZWave_TransferPrimaryRole( uint32 home );
bool DomoZWave_ReceiveConfiguration( uint32 home );
bool DomoZWave_HasNodeFailed( uint32 home, int32 node, bool addqueue );
bool DomoZWave_RemoveFailedNode( uint32 home, int32 node );
bool DomoZWave_ReplaceFailedNode( uint32 home, int32 node );
bool DomoZWave_SendNodeInformation( uint32 home, int32 node );
bool DomoZWave_ReplicationSend( uint32 home, int32 node );
void DomoZWave_HealNetworkNode( uint32 home, int32 node, bool doRR );
void DomoZWave_HealNetwork( uint32 home, bool doRR );
void DomoZWave_TestNetworkNode( uint32 home, int32 node, int32 count );
void DomoZWave_TestNetwork( uint32 home, int32 count );

// Statistical information
const char* DomoZWave_GetDriverStatistics( uint32 home );
const char* DomoZWave_GetNodeStatistics( uint32 home, int32 node );
long DomoZWave_GetSendQueueCount( uint32 home );

// Make certain information readable
const char* DomoZWave_CommandClassIdName( int class_value );
const char* DomoZWave_GenreIdName( int genre );
const char* DomoZWave_BasicTypeName( int basictype );
const char* DomoZWave_GenericTypeName( int generictype );
const char* DomoZWave_SpecificTypeName( int generictype, int specifictype );

//-----------------------------------------------------------------------------
// Thermostate and Scenes are not supported (yet)
//-----------------------------------------------------------------------------

void cURL_Post_JSON( uint32 homeID, const char* method, json_object *jparams );

}
