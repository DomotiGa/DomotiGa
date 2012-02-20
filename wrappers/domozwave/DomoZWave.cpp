// DomoZWave a C++/C-wrapper to add open-zwave support to DomotiGa.
// Special thanks to Jaren for creating the wrapper.

// DomotiGa - an open source home automation program
// Copyright(C) 2008-2012 Ron Klinkien

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General PUBLIC License for more details.

// You should have received a copy of the GNU General PUBLIC License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

#include <iostream>
#include <stdio.h>
#include <pthread.h>

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

using namespace OpenZWave;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

int home;       // The homeId for our controller. Ideally I think this should be done differently in case people
		// have multiple homeIds in their network. 
xmlrpc_env env;
xmlrpc_client* clientP;
char url[35];
bool debugging;

int queriesFinishedTimes = 0; // A value used in a hacky way of determining when the startup queries are done. 
static pthread_mutex_t g_criticalSection;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// To enable polling we need a nodeId->ValueID mapping. 
// I asked on the mailing list and the only suggestion I got
// was to store them off when the values are added. 
// So we store a list of structs to hold this mapping.
typedef struct
{
        uint32                  m_homeId;
        uint8                   m_nodeId;
        list<ValueID>   m_values;
}NodeInfo;
static list<NodeInfo*> g_nodes;

// <GetNodeInfo>
// Callback that is triggered when a value, group or node changes
//-----------------------------------------------------------------------------
NodeInfo* GetNodeInfo
(
	uint32 const homeId,
	uint8 const nodeId
)
{
        for( list<NodeInfo*>::iterator it = g_nodes.begin(); it != g_nodes.end(); ++it )
        {
                NodeInfo* nodeInfo = *it;
                if( ( nodeInfo->m_homeId == homeId ) && ( nodeInfo->m_nodeId == nodeId ) )
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

/////////////////////////////////////////////////////////////////////////////////////
// RPC Helper Functions

bool fault_occurred(xmlrpc_env* env)
{
	if ( env->fault_occurred )
	{
		cout << "XML-RPC Fault: " <<  env->fault_string << " (" << env->fault_code << ")" << endl;
		return true;
	}
	return false; 
}

////////////////////////////////////////////////////////////////////////

void RPC_AddValue( int homeID, int nodeID, ValueID valueID, uint8 value )
{
	// Eventually we should probably store these in an sql table.
	// Then when we want to query values or set them we have them available. 
	//cout << endl << endl << endl << "AddValue(" << homeID << ":" << nodeID << endl << endl << endl;
	//cout << "Genre=" << valueID.GetGenre() << endl;
	//cout << "CommandClassId=" << valueID.GetCommandClassId() << endl;
	//cout << "CommandClassInstance=" << valueID.GetInstance() << endl;
	//cout << "Index=" << valueID.GetIndex() << endl;
	//cout << "Type=" << valueID.GetType() << endl;
	//cout << "Value=" << value << endl;
}

void RPC_RemoveValue( int homeID, int nodeID/*, int valueID*/ )
{
	//cout << endl << endl << endl << "RemoveValue(" << homeID << ":" << nodeID << endl << endl << endl;
}

// This is called when a device reports that a value has changed. 
// If it was the basic command class we'll report that value back to domotiga.
// Also try to get channel/instance and report that back
void RPC_ChangeValue( int homeID, int nodeID, ValueID valueID, int val )
{
	int id = valueID.GetCommandClassId();
	int genre = valueID.GetGenre();
	string label =  Manager::Get()->GetValueLabel( valueID );
	int instanceID = valueID.GetInstance();
	int type = valueID.GetType();

	if ( debugging )
	{
		//cout << endl << "ChangeValue(" << homeID << ":" << nodeID << endl << endl;
		//cout << endl << "ChangeValue Node id: " << nodeID << endl << endl;
		cout << "Genre=" << genre << endl;
		cout << "GenreName=" << cgenretoStr(genre) << endl;
		cout << "CommandClassId=" << id << endl;
		cout << "CommandClassName=" << cclasstoStr(id) << endl;
		cout << "CommandClassInstance=" << instanceID << endl;
		cout << "Index=" << (int)(valueID.GetIndex()) << endl;
		//cout << "Type=" << type << endl;
		cout << "Label=" << label << endl;
		cout << "Units=" << Manager::Get()->GetValueUnits( valueID ) << endl;
	}

	char dev_value[32];
	char tmp_dev_value[64];
	uint8 byte_value;
	bool bool_value;
	string decimal_value;
	string list_value;
	vector<string> list_strs;
	int int_value;
	int16 short_value;
	int value_no = 0;

	switch ( type )
	{
		case ValueID::ValueType_Bool:
		{
			if ( debugging )
			{
				cout << "BOOL" << endl;
			}
			Manager::Get()->GetValueAsBool(valueID, &bool_value );
			snprintf(dev_value, 32, "%i", bool_value);
			break;
		}
		case ValueID::ValueType_Byte:
		{
			if ( debugging )
			{
				cout << "BYTE" << endl;
			}
			Manager::Get()->GetValueAsByte(valueID, &byte_value );
			snprintf(dev_value, 32, "%i", byte_value);
			break;
		}
		case ValueID::ValueType_Decimal:
		{
			if ( debugging )
			{
				cout << "DECIMAL" << endl;
			}
			Manager::Get()->GetValueAsString(valueID, &decimal_value );
			snprintf(dev_value, 32, "%s", strdup(decimal_value.c_str()));
			break;
		}
		case ValueID::ValueType_Int:
		{
			if ( debugging )
			{
				cout << "INTEGER" << endl;
			}
			Manager::Get()->GetValueAsInt(valueID, &int_value );
			snprintf(dev_value, 32, "%d", int_value);
			break;
		}
		case ValueID::ValueType_Short:
		{
			if ( debugging )
			{
				cout << "SHORT" << endl;
			}
			Manager::Get()->GetValueAsShort(valueID, &short_value );
			snprintf(dev_value, 32, "%d.h", short_value);
			break;
		}
		case ValueID::ValueType_Schedule:
		{
			if ( debugging )
			{
				cout << "SCHEDULE" << endl;
			}
			return;
			//break;
		}
		case ValueID::ValueType_String:
		{
			if ( debugging )
			{
				cout << "STRING" << endl;
			}
			Manager::Get()->GetValueAsString(valueID, &decimal_value );
			snprintf(dev_value, 32, "%s", strdup(decimal_value.c_str()));
			break;
		}
		case ValueID::ValueType_Button:
		{
			if ( debugging )
			{
				cout << "BUTTON" << endl;
			}
			return;
			//break;
		}
		case ValueID::ValueType_List:
		{
			if ( debugging )
			{
				cout << "LIST" << endl;
			}
			//Manager::Get()->GetValueListItems(valueID, &list_strs );
			Manager::Get()->GetValueListSelection(valueID, &list_value );
			snprintf(dev_value, 32, "%s", strdup(list_value.c_str()));
			break;
		}
		default:
		if ( debugging ) 
		{
			cout << "UNKNOWN" << endl;
		}
		return;
	}

	switch ( id )
	{
		case COMMAND_CLASS_SWITCH_BINARY:
		{
			if (label == "Switch")
			{
				value_no = 1;
				if ( strcmp(dev_value, "1") == 0 ) 
				{
					strcpy(dev_value, "On");;
				}
				else
				{
					strcpy(dev_value, "Off");;
				}
			}
			break;				
		}
		case COMMAND_CLASS_SWITCH_MULTILEVEL:
		{	
			if (label == "Level")
			{
				value_no = 1;
				sprintf(tmp_dev_value, "Dim %s", dev_value);
				strcpy(dev_value, tmp_dev_value);
			}
			break;
		}
		case COMMAND_CLASS_SENSOR_MULTILEVEL:
		case COMMAND_CLASS_METER:
		{
			if (label == "Temperature")
			{
				value_no = 1;
			}
			else if (label == "Luminance")
			{
				value_no = 3;
			}
			else if (label == "Battery Level")
			{
				value_no = 255;
			}
			else if (label == "Power")
			{
				value_no = 2;
			}
			else if (label == "Energy")
			{
				value_no = 3;
			}
			break;
		}
	}
	if ( debugging )
	{
		cout << "Value=" << dev_value << endl;
	}
	if ( value_no > 0 )
	{
		xmlrpc_value* resultP = NULL;
		xmlrpc_client_call2f(&env, clientP, url, "zwave.setvalue", &resultP, "(iiiis)", homeID, nodeID, instanceID, value_no, dev_value );
		if ( resultP )
		{
			xmlrpc_DECREF(resultP);
		}
	}
}

void RPC_AddNode( int homeID, int nodeID )
{
	//cout << endl << endl << endl << "AddNode(" << homeID << ":" << nodeID << endl << endl << endl;

}
void RPC_RemoveNode( int homeID, int nodeID )
{
	if ( debugging )
	{
		cout << endl << endl << endl << "RemoveNode: " << homeID << ":" << nodeID << endl << endl;
	}
}

// We got results to a Protocol Info query, send them over to domotiga.
void RPC_ProtocolInfo( int homeID, int nodeID )
{
	xmlrpc_int32 basic = Manager::Get()->GetNodeBasic( homeID, nodeID );
	xmlrpc_int32 generic = Manager::Get()->GetNodeGeneric( homeID, nodeID );
	xmlrpc_int32 specific = Manager::Get()->GetNodeSpecific( homeID, nodeID );
	xmlrpc_int32 capabilities = 0; // Caps is broken into Version, BaudRate, listening, routing
	//xmlrpc_int32 security = Manager::Get()->GetNodeSecurity( homeID, nodeID );
	xmlrpc_bool sleeping = !Manager::Get()->IsNodeListeningDevice( homeID, nodeID );
	xmlrpc_int32 security = 0;
	if ( debugging )
	{
		cout << endl << endl << "ProtocolInfo: " << homeID << ":" << nodeID << endl << endl;
		cout << "node=" << nodeID << endl;
		cout << "basic=" << basic << endl;
		cout << "generic=" << generic << endl;
		cout << "specific=" << specific << endl;
		cout << "cap=" << capabilities << endl;
		cout << "security=" << security << endl;
	}
	xmlrpc_value* resultP = NULL;
 	xmlrpc_client_call2f(&env, clientP, url, "zwave.createnode", &resultP, "(iiiiiib)", nodeID, basic, generic, specific, capabilities, security, sleeping );

	if ( resultP )
	{
		xmlrpc_DECREF(resultP);
	}
}

void RPC_Group( int homeID, int nodeID )
{
	if ( debugging )
	{
		cout << endl << endl << endl << "GroupEvent: " << homeID << ":" << nodeID << endl << endl << endl;
	}
}

void RPC_NodeEvent( int homeID, int nodeID, int value )
{
	if ( debugging )
	{
		cout << endl << endl << endl << "NodeEvent: " << homeID << ":" << nodeID << endl << endl << endl;
	}
/*	
	xmlrpc_value* resultP = NULL;
 	xmlrpc_client_call2f(&env, clientP, url, "zwave.basicreport", &resultP, "(iii)", homeID, nodeID, value );
	if ( resultP )
	{
		xmlrpc_DECREF(resultP);
	}
*/
}

void RPC_EnabledPolling( int homeID, int nodeID )
{
	if ( debugging )
	{
		cout << endl << endl << endl << "EnabledPolling(" << homeID << ":" << nodeID << endl << endl << endl;
	}
}

void RPC_DisabledPolling( int homeID, int nodeID )
{
	if ( debugging )
	{
		cout << endl << endl << endl << "DisabledPolling(" << homeID << ":" << nodeID << endl << endl << endl;
	}
}

void RPC_DriverReady( int homeID, int nodeID )
{
	home = homeID;
	if ( debugging )
	{
		cout << endl << endl << "DriverReady: " << homeID << ":" << nodeID << endl << endl;
	}

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

//////////////////////////////////////////////////////////////////////////////////////////////////////

// Open-ZWave calls this whenever it has a notification ready for us. 
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
        		if( NodeInfo* nodeInfo = GetNodeInfo( data ) )
        		{
				// Add the new value to our list
				nodeInfo->m_values.push_back( data->GetValueID() );
			}
			RPC_AddValue( (int)data->GetHomeId(), (int)data->GetNodeId(), data->GetValueID(), data->GetByte() );

			break;
		}
		case Notification::Type_ValueRemoved:
		{

			RPC_RemoveValue( (int)data->GetHomeId(), (int)data->GetNodeId()/*, (int)data->GetValueID()*/ );
			if( NodeInfo* nodeInfo = GetNodeInfo( data ) )
                        {
                                // Remove the value from out list
                                for( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
                                {
                                        if( (*it) == data->GetValueID() )
                                        {
                                                nodeInfo->m_values.erase( it );
                                                break;
                                        }
                                }
                        }
			break;
		}
		case Notification::Type_ValueChanged:
		{
			RPC_ChangeValue( (int)data->GetHomeId(), (int)data->GetNodeId(), data->GetValueID(), data->GetByte() );
		}
		case Notification::Type_Group:
		{
			RPC_Group( (int)data->GetHomeId(), (int)data->GetNodeId() );
		}
		case Notification::Type_NodeAdded:
		{
			NodeInfo* nodeInfo = new NodeInfo();
                        nodeInfo->m_homeId = data->GetHomeId();
                        nodeInfo->m_nodeId = data->GetNodeId();
                        g_nodes.push_back( nodeInfo );
			
			RPC_AddNode( (int)data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_NodeRemoved:
		{
			RPC_RemoveNode( (int)data->GetHomeId(), (int)data->GetNodeId() );
                        uint32 const homeId = data->GetHomeId();
                        uint8 const nodeId = data->GetNodeId();
                        for( list<NodeInfo*>::iterator it = g_nodes.begin(); it != g_nodes.end(); ++it )
                        {
                                NodeInfo* nodeInfo = *it;
                                if( ( nodeInfo->m_homeId == homeId ) && ( nodeInfo->m_nodeId == nodeId ) )
                                {
                                        g_nodes.erase( it );
                                        break;
                                }
                        }

			break;
		}
		case Notification::Type_NodeProtocolInfo:
		{
			RPC_ProtocolInfo( (int)data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_NodeEvent:
		{
			// Event caused by basic set or hail. 
			RPC_NodeEvent( (int)data->GetHomeId(), (int)data->GetNodeId(), (int)data->GetEvent() );
			break;
		}
		case Notification::Type_PollingEnabled:
		{
			RPC_EnabledPolling( (int)data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_PollingDisabled:
		{
			RPC_DisabledPolling( (int)data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		case Notification::Type_DriverReady:
		{
			RPC_DriverReady( (int)data->GetHomeId(), (int)data->GetNodeId() );
			break;
		}
		// HACK ALERT
		// For some reason I'm not getting the AllNodesQueried or AwakeNodesQueried notifications EVER.
		// So for now, the 2nd time the controller node reports that it is done querying we'll assume we are done.
		case Notification::Type_AllNodesQueried:
		case Notification::Type_AwakeNodesQueried:
		//case Notification::Type_NodeQueriesComplete:
		{
			//cout << endl << endl << endl << "NodeQueriesComplete Node=" << (int)(data->GetNodeId()) << " times=" << queriesFinishedTimes << endl;
			Manager::Get()->WriteConfig( home );

			xmlrpc_value* resultP = NULL;
       			pthread_mutex_unlock( &g_criticalSection );
 			xmlrpc_client_call2f(&env, clientP, url, "zwave.allqueried", &resultP, "()" );
			if ( resultP )
			{
				xmlrpc_DECREF(resultP);
			}
			return;
		}

		default:
		break;
	}
        pthread_mutex_unlock( &g_criticalSection );
}

// C style bindings are required since we call these functions from gambas.
extern "C" {

void DomoZWave_Init( const char* serialPort, int rpcPort, const char* configdir, const char* zwdir, bool enableLog )
{
	pthread_mutexattr_t mutexattr;

	pthread_mutexattr_init ( &mutexattr );
	pthread_mutexattr_settype( &mutexattr, PTHREAD_MUTEX_RECURSIVE );
	pthread_mutex_init( &g_criticalSection, &mutexattr );
	pthread_mutexattr_destroy( &mutexattr );

	sprintf( url, "http://localhost:%d", rpcPort ); 

	Options::Create( configdir, zwdir, "" );
	Options::Get()->Lock();

	debugging = enableLog;

	Manager::Create();
	Log::SetLoggingState( debugging );

	Manager::Get()->AddWatcher( OnNotification, NULL );
	Manager::Get()->AddDriver( serialPort );

 	// Initialize our error-handling environment.
 	xmlrpc_env_init(&env);
 	xmlrpc_client_setup_global_const(&env);
 	xmlrpc_client_create(&env, XMLRPC_CLIENT_NO_FLAGS, "DomoZWaveClient", "1.0", NULL, 0, &clientP);
	if ( fault_occurred(&env) ) return;
}

void DomoZWave_Destroy()
{

	pthread_mutex_lock( &g_criticalSection );

	// Clean up our error-handling environment. 
	xmlrpc_env_clean(&env);
    
	xmlrpc_client_destroy(clientP);
	xmlrpc_client_teardown_global_const();

	//cout << "Destroyed xmlrpc" << endl;
	Manager::Get()->Destroy();
	//cout << "Destroyed manager" << endl;
	Options::Get()->Destroy();
	//cout << "Destroyed options" << endl;

	pthread_mutex_unlock( &g_criticalSection );
	pthread_mutex_destroy( &g_criticalSection );
}

void DomoZWave_EnablePolling( int node, int polltime )
{
	// Don't allow polling basic info on controllers.
	// I was seeing strange results when we did this. 
	if ( Manager::Get()->GetNodeBasic( home, node ) < 0x03 )
	{	
		//pthread_mutex_unlock( &g_criticalSection );
		return;
	}

	Manager::Get()->SetPollInterval( polltime );

	if( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
        	// Mark the basic command class values for polling
                for( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			int id = (*it).GetCommandClassId();
			if ( id == COMMAND_CLASS_BASIC )
			{
				Manager::Get()->EnablePoll( *it );	
				//cout << "Enable Polling for node " << node << endl;
			}
		}
        }
}

void DomoZWave_DisablePolling( int node )
{
	if( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
        	// Mark all the nodes for polling
                for( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
			Manager::Get()->DisablePoll( *it );	
		}
        }
}

void DomoZWave_RequestNodeState( int node )
{
	Manager::Get()->RequestNodeState( home, node );
}

void DomoZWave_RequestNetworkUpdate( )
{
	Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_RequestNetworkUpdate, NULL, NULL, false, 0xff );
}

void DomoZWave_AddDevice( )
{
	Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_AddDevice, NULL, NULL, true, 0xff );
}

void DomoZWave_RemoveDevice( int node )
{
	Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_RemoveDevice, NULL, NULL, false, node );
}

void DomoZWave_RequestNodeNeighborUpdate( int node )
{
	Manager::Get()->BeginControllerCommand( home, Driver::ControllerCommand_RequestNodeNeighborUpdate, NULL, NULL, false, node );
}

void DomoZWave_CancelControllerCommand( )
{
	Manager::Get()->CancelControllerCommand( home );
}

void DomoZWave_SetConfigParam( int node, int param, int value ) 
{
	Manager::Get()->SetConfigParam( home, node, param, value);
}

void DomoZWave_RequestAllConfigParams( int node )
{
	Manager::Get()->RequestAllConfigParams( home, node );
}

void DomoZWave_SetValue( int node, int instance, int value )
{
	bool bool_value;
	int int_value;
	uint8 uint8_value;
	uint16 uint16_value;

        if( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
        {
                // Find the correct instance
                for( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
                {
                        int id = (*it).GetCommandClassId();
                        int inst = (*it).GetInstance();
                        if ( id == COMMAND_CLASS_SWITCH_MULTILEVEL || id == COMMAND_CLASS_SWITCH_BINARY)
                        {
				if ( inst == instance )
				{
                                	if( ValueID::ValueType_Bool == (*it).GetType() )
                                	{
						bool_value = (bool)value;
						Manager::Get()->SetValue( *it, bool_value );
         	                       	}
                                	else if( ValueID::ValueType_Byte == (*it).GetType() )
                                	{
						uint8_value = (uint8)value;
						Manager::Get()->SetValue( *it, uint8_value );
               		                }
               		                else if( ValueID::ValueType_Short == (*it).GetType() )
                                	{
						uint16_value = (uint16)value;
						Manager::Get()->SetValue( *it, uint16_value );
                               		}
                                	else if( ValueID::ValueType_Int == (*it).GetType() )
                                	{
						int_value = value;
						Manager::Get()->SetValue( *it, int_value );
                                	}
                                	else if( ValueID::ValueType_List == (*it).GetType() )
                                	{
						Manager::Get()->SetValue( *it, value );
                                	}
                                	else
                                	{
						return;
                        		}

                                	//cout << "SetValue for node " << node << endl;
                                	//cout << "class id " << id << endl;
                                	//cout << "instance " << instance << endl;
                                	//cout << "value " << value << endl;
                        	}
			}
                }
        }
}

const char *cclasstoStr (uint8 class_value)
{
  switch (class_value)
  {
  case 0x00:
    return "COMMAND_CLASS_NO_OPERATION";
  case 0x20:
    return "COMMAND_CLASS_BASIC";
  case 0x21:
    return "COMMAND_CLASS_CONTROLLER_REPLICATION";
  case 0x22:
    return "COMMAND_CLASS_APPLICATION_STATUS";
  case 0x23:
    return "COMMAND_CLASS_ZIP_SERVICES";
  case 0x24:
    return "COMMAND_CLASS_ZIP_SERVER";
  case 0x25:
    return "COMMAND_CLASS_SWITCH_BINARY";
  case 0x26:
    return "COMMAND_CLASS_SWITCH_MULTILEVEL";
  case 0x27:
    return "COMMAND_CLASS_SWITCH_ALL";
  case 0x28:
    return "COMMAND_CLASS_SWITCH_TOGGLE BINARY";
  case 0x29:
    return "COMMAND_CLASS_SWITCH_TOGGLE MULTILEVEL";
  case 0x2A:
    return "COMMAND_CLASS_CHIMNEY_FAN";
  case 0x2B:
    return "COMMAND_CLASS_SCENE_ACTIVATION";
  case 0x2C:
    return "COMMAND_CLASS_SCENE_ACTUATOR CONF";
  case 0x2D:
    return "COMMAND_CLASS_SCENE_CONTROLLER CONF";
  case 0x2E:
    return "COMMAND_CLASS_ZIP_CLIENT";
  case 0x2F:
    return "COMMAND_CLASS_ZIP_ADV_SERVICES";
  case 0x30:
    return "COMMAND_CLASS_SENSOR_BINARY";
  case 0x31:
    return "COMMAND_CLASS_SENSOR_MULTILEVEL";
  case 0x32:
    return "COMMAND_CLASS_METER";
  case 0x33:
    return "COMMAND_CLASS_ZIP_ADV_SERVER";
  case 0x34:
    return "COMMAND_CLASS_ZIP_ADV_CLIENT";
  case 0x35:
    return "COMMAND_CLASS_METER_PULSE";
  case 0x38:
    return "COMMAND_CLASS_THERMOSTAT_HEATING";
  case 0x40:
    return "COMMAND_CLASS_THERMOSTAT_MODE";
  case 0x42:
    return "COMMAND_CLASS_THERMOSTAT_OPERATING STATE";
  case 0x43:
    return "COMMAND_CLASS_THERMOSTAT_SETPOINT";
  case 0x44:
    return "COMMAND_CLASS_THERMOSTAT_FAN MODE";
  case 0x45:
    return "COMMAND_CLASS_THERMOSTAT_FAN STATE";
  case 0x46:
    return "COMMAND_CLASS_CLIMATE_CONTROL_SCHEDULE";
  case 0x47:
    return "COMMAND_CLASS_THERMOSTAT_SETBACK";
  case 0x4C:
    return "COMMAND_CLASS_DOOR_LOCK_LOGGING";
  case 0x4E:
    return "COMMAND_CLASS_SCHEDULE_ENTRY_LOCK";
  case 0x50:
    return "COMMAND_CLASS_BASIC_WINDOW_COVERING";
  case 0x51:
    return "COMMAND_CLASS_MTP_WINDOW_COVERING";
  case 0x60:
    return "COMMAND_CLASS_MULTI_INSTANCE";
  case 0x62:
    return "COMMAND_CLASS_DOOR_LOCK";
  case 0x63:
    return "COMMAND_CLASS_USER_CODE";
  case 0x70:
    return "COMMAND_CLASS_CONFIGURATION";
  case 0x71:
    return "COMMAND_CLASS_ALARM";
  case 0x72:
    return "COMMAND_CLASS_MANUFACTURER_SPECIFIC";
  case 0x73:
    return "COMMAND_CLASS_POWERLEVEL";
  case 0x75:
    return "COMMAND_CLASS_PROTECTION";
  case 0x76:
    return "COMMAND_CLASS_LOCK";
  case 0x77:
    return "COMMAND_CLASS_NODE_NAMING";
  case 0x7A:
    return "COMMAND_CLASS_FIRMWARE_UPDATE MD";
  case 0x7B:
    return "COMMAND_CLASS_GROUPING_NAME";
  case 0x7C:
    return "COMMAND_CLASS_REMOTE_ASSOCIATION_ACTIVATE";
  case 0x7D:
    return "COMMAND_CLASS_REMOTE_ASSOCIATION";
  case 0x80:
    return "COMMAND_CLASS_BATTERY";
  case 0x81:
    return "COMMAND_CLASS_CLOCK";
  case 0x82:
    return "COMMAND_CLASS_HAIL";
  case 0x84:
    return "COMMAND_CLASS_WAKE_UP";
  case 0x85:
    return "COMMAND_CLASS_ASSOCIATION";
  case 0x86:
    return "COMMAND_CLASS_VERSION";
  case 0x87:
    return "COMMAND_CLASS_INDICATOR";
  case 0x88:
    return "COMMAND_CLASS_PROPRIETARY";
  case 0x89:
    return "COMMAND_CLASS_LANGUAGE";
  case 0x8A:
    return "COMMAND_CLASS_TIME";
  case 0x8B:
    return "COMMAND_CLASS_TIME_PARAMETERS";
  case 0x8C:
    return "COMMAND_CLASS_GEOGRAPHIC_LOCATION";
  case 0x8D:
    return "COMMAND_CLASS_COMPOSITE";
  case 0x8E:
    return "COMMAND_CLASS_MULTI_INSTANCE_ASSOCIATION";
  case 0x8F:
    return "COMMAND_CLASS_MULTI_CMD";
  case 0x90:
    return "COMMAND_CLASS_ENERGY_PRODUCTION";
  case 0x91:
    return "COMMAND_CLASS_MANUFACTURER_PROPRIETARY";
  case 0x92:
    return "COMMAND_CLASS_SCREEN_MD";
  case 0x93:
    return "COMMAND_CLASS_SCREEN_ATTRIBUTES";
  case 0x94:
    return "COMMAND_CLASS_SIMPLE_AV_CONTROL";
  case 0x95:
    return "COMMAND_CLASS_AV_CONTENT_DIRECTORY_MD";
  case 0x96:
    return "COMMAND_CLASS_AV_RENDERER_STATUS";
  case 0x97:
    return "COMMAND_CLASS_AV_CONTENT_SEARCH_MD";
  case 0x98:
    return "COMMAND_CLASS_SECURITY";
  case 0x99:
    return "COMMAND_CLASS_AV_TAGGING_MD";
  case 0x9A:
    return "COMMAND_CLASS_IP_CONFIGURATION";
  case 0x9B:
    return "COMMAND_CLASS_ASSOCIATION_COMMAND_CONFIGURATION";
  case 0x9C:
    return "COMMAND_CLASS_SENSOR_ALARM";
  case 0x9D:
    return "COMMAND_CLASS_SILENCE_ALARM";
  case 0x9E:
    return "COMMAND_CLASS_SENSOR_CONFIGURATION";
  case 0xEF:
    return "COMMAND_CLASS_MARK";
  case 0xF0:
    return "NON_INTEROPERABLE";
  }
  return "UNKNOWN";
}

const char *cgenretoStr (uint8 genre)
{
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
  }
  return "unknown";
}

}
