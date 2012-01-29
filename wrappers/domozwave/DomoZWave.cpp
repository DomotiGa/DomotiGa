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

// wrapper
#include "DomoZWave.h"

using namespace OpenZWave;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

int home;       // The homeId for our controller. Ideally I think this should be done differently in case people
		// have multiple homeIds in their network. 
xmlrpc_env env;
xmlrpc_client* clientP;
char url[35];

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
	cout << endl << endl << endl << "AddValue(" << homeID << ":" << nodeID << endl << endl << endl;
	//cout << "Genre=" << valueID.GetGenre() << endl;
	cout << "CommandClassId=" << valueID.GetCommandClassId() << endl;
	cout << "CommandClassInstance=" << valueID.GetInstance() << endl;
	//cout << "Index=" << valueID.GetIndex() << endl;
	cout << "Type=" << valueID.GetType() << endl;
	cout << "Value=" << value << endl;
}

void RPC_RemoveValue( int homeID, int nodeID/*, int valueID*/ )
{
	//cout << endl << endl << endl << "RemoveValue(" << homeID << ":" << nodeID << endl << endl << endl;
}

// This is called when a device reports that a value has changed. 
// If it was the basic command class we'll report that value back to domotiga.
// Also try to get channel/instance and report that back
void RPC_ChangeValue( int homeID, int nodeID, ValueID valueID, uint8 value )
{
	cout << endl << endl << endl << "ChangeValue(" << homeID << ":" << nodeID << endl << endl << endl;
	cout << endl << endl << endl << "ChangeValue Node id: " << nodeID << endl << endl << endl;
	//cout << "Genre=" << (int)(valueID.GetGenre()) << endl;
	int id = valueID.GetCommandClassId();
	int index = valueID.GetIndex();
	cout << "CommandClassId=" << (int)(valueID.GetCommandClassId()) << endl;
	int instanceID = valueID.GetInstance();
	cout << "CommandClassInstance=" << instanceID << endl;
	//cout << "Index=" << (int)(valueID.GetIndex()) << endl;
	cout << "Type=" << (int)(valueID.GetType()) << endl;
	cout << "Value=" << (int)(value) << endl;
	//cout << "Label=" << Manager::Get()->GetValueLabel( valueID ) << endl;
	//cout << "Units=" << Manager::Get()->GetValueUnits( valueID ) << endl;

	uint8 byteValue;
	Manager::Get()->GetValueAsByte( valueID, &byteValue );
	if (( id == COMMAND_CLASS_BASIC || id ==  COMMAND_CLASS_SWITCH_BINARY || id == COMMAND_CLASS_SWITCH_MULTILEVEL) && index == 0 )
	{
		cout << "basic command class value changed" << endl;
		cout << "instance" << instanceID << endl;
		xmlrpc_value* resultP = NULL;
// 		xmlrpc_client_call2f(&env, clientP, url, "zwave.basicreport", &resultP, "(iiii)", homeID, nodeID, instanceID, (int)byteValue );
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
	//cout << endl << endl << endl << "AddNode(" << homeID << ":" << nodeID << endl << endl << endl;
}

// We got results to a Protocol Info query. 
// Send them over to domotiga.
void RPC_ProtocolInfo( int homeID, int nodeID )
{
	//cout << endl << endl << endl << "Protocol(" << homeID << ":" << nodeID << endl << endl << endl;

	xmlrpc_int32 basic = Manager::Get()->GetNodeBasic( homeID, nodeID );
	xmlrpc_int32 generic = Manager::Get()->GetNodeGeneric( homeID, nodeID );
	xmlrpc_int32 specific = Manager::Get()->GetNodeSpecific( homeID, nodeID );
	xmlrpc_int32 capabilities = 0; // Caps is broken into Version, BaudRate, listening, routing
	xmlrpc_int32 security = Manager::Get()->GetNodeSecurity( homeID, nodeID );
	xmlrpc_bool sleeping = !Manager::Get()->IsNodeListeningDevice( homeID, nodeID );

	//cout << "node=" << nodeID << endl;
	//cout << "basic=" << basic << endl;
	//cout << "generic=" << generic << endl;
	//cout << "specific=" << specific << endl;
	//cout << "cap=" << capabilities << endl;
	//cout << "security=" << security << endl;

	xmlrpc_value* resultP = NULL;
 	xmlrpc_client_call2f(&env, clientP, url, "zwave.createnode", &resultP, "(iiiiiib)", nodeID, basic, generic, specific, capabilities, security, sleeping );

	if ( resultP )
	{
		xmlrpc_DECREF(resultP);
	}

}

void RPC_NodeEvent( int homeID, int nodeID, int value )
{
	cout << endl << endl << endl << "NodeEvent(" << homeID << ":" << nodeID << endl << endl << endl;
	
	xmlrpc_value* resultP = NULL;
 	xmlrpc_client_call2f(&env, clientP, url, "zwave.basicreport", &resultP, "(iii)", homeID, nodeID, value );
	if ( resultP )
	{
		xmlrpc_DECREF(resultP);
	}
}

void RPC_EnabledPolling( int homeID, int nodeID )
{
	//cout << endl << endl << endl << "EnabledPolling(" << homeID << ":" << nodeID << endl << endl << endl;
}

void RPC_DisabledPolling( int homeID, int nodeID )
{
	//cout << endl << endl << endl << "DisabledPolling(" << homeID << ":" << nodeID << endl << endl << endl;
}

void RPC_DriverReady( int homeID, int nodeID )
{
	home = homeID;
	//cout << endl << endl << endl << "DriverReady(" << homeID << ":" << nodeID << endl << endl << endl;

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

	Manager::Create();
	Log::SetLoggingState( enableLog );

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

/*
void DomoZWave_SetNodeOn( int node )
{
	//cout << "Turn on Node " << home << ":" << node << endl;
	Manager::Get()->SetNodeOn( home, node );
}

void DomoZWave_SetNodeOff( int node )
{
	//cout << "Turn off Node " << home << ":" << node << endl;
	Manager::Get()->SetNodeOff( home, node );
}

void DomoZWave_SetNodeLevel( int node, int level )
{
	//cout << "Set Node Level " << home << ":" << node << " => " << level << endl;
	Manager::Get()->SetNodeLevel( home, node, level );
}
*/

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

}
