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

// system
#include <iostream>
#include <ctime>
#include <sys/time.h>
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
using namespace OpenZWave;

int home;	// the HomeId for our controller, needs fix if people use multiple home id's.
xmlrpc_env env;
xmlrpc_client* clientP;
char url[35];
bool debugging;

static pthread_mutex_t g_criticalSection;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Returns current date/time in readable format, used for cout

ostream &OZW_datetime(ostream &stream)
{
  // Get a timestamp
  struct timeval tv;
  gettimeofday(&tv, NULL);
  struct tm *tm;
  tm = localtime( &tv.tv_sec );

  // create a time stamp string for the log message
  char localt[100];
  snprintf( localt, sizeof(localt), "%04d-%02d-%02d %02d:%02d:%02d:%03d",
            tm->tm_year + 1900, tm->tm_mon + 1, tm->tm_mday,
            tm->tm_hour, tm->tm_min, tm->tm_sec, tv.tv_usec / 1000 );

  stream << localt << " [DomoZwave] ";

  return stream;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// To enable polling we need a nodeId->ValueID mapping. 
// I asked on the mailing list and the only suggestion I got
// was to store them off when the values are added. 
// So we store a list of structs to hold this mapping.
typedef struct
{
        uint32                  m_homeId;
        uint8                   m_nodeId;
        list<ValueID>		m_values;
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
		cout << OZW_datetime << "XML-RPC Fault: " <<  env->fault_string << " (" << env->fault_code << ")" << endl;
		return true;
	}
	return false; 
}

void RPC_RemoveValue( int homeID, int nodeID/*, int valueID*/ )
{
	if ( debugging )
	{
		cout << endl << OZW_datetime << "RemoveValue: " << homeID << ":" << nodeID << endl;
	}
}

// This is called when a device reports that a value has changed or added.
// If it was from a known command class we'll report that value back to DomotiGa.
void RPC_ChangeValue( int homeID, int nodeID, ValueID valueID, bool add )
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
	vector<string> list_strs;
	int int_value;
	int16 short_value;
	int value_no = 0;

	if ( debugging )
	{
		if ( add )
		{
			cout << endl << OZW_datetime << "AddValue: HomeId=" << homeID << " Node=" << nodeID << endl;
		}
		else
		{
			cout << endl << OZW_datetime << "ChangeValue: HomeId=" << homeID << " Node=" << nodeID << endl;
		}	
		cout << OZW_datetime << "Genre=" << genre << endl;
		cout << OZW_datetime << "GenreName=" << cgenretoStr(genre) << endl;
		cout << OZW_datetime << "CommandClassId=" << id << endl;
		cout << OZW_datetime << "CommandClassName=" << cclasstoStr(id) << endl;
		cout << OZW_datetime << "CommandClassInstance=" << instanceID << endl;
		cout << OZW_datetime << "Index=" << (int)(valueID.GetIndex()) << endl;
		cout << OZW_datetime << "Label=" << label << endl;
		cout << OZW_datetime << "Units=" << Manager::Get()->GetValueUnits( valueID ) << endl;
	}

	switch ( type )
	{
		case ValueID::ValueType_Bool:
		{
			if ( debugging )
			{
				cout << OZW_datetime << "Type=Bool" << endl;
			}
			Manager::Get()->GetValueAsBool(valueID, &bool_value );
			snprintf(dev_value, 64, "%i", bool_value);
			break;
		}
		case ValueID::ValueType_Byte:
		{
			if ( debugging )
			{
				cout << OZW_datetime << "Type=Byte" << endl;
			}
			Manager::Get()->GetValueAsByte(valueID, &byte_value );
			snprintf(dev_value, 64, "%i", byte_value);
			break;
		}
		case ValueID::ValueType_Decimal:
		{
			if ( debugging )
			{
				cout << OZW_datetime << "Type=Decimal" << endl;
			}
			Manager::Get()->GetValueAsString(valueID, &decimal_value );
			snprintf(dev_value, 64, "%s", strdup(decimal_value.c_str()));
			break;
		}
		case ValueID::ValueType_Int:
		{
			if ( debugging )
			{
				cout << OZW_datetime << "Type=Integer" << endl;
			}
			Manager::Get()->GetValueAsInt(valueID, &int_value );
			snprintf(dev_value, 64, "%d", int_value);
			break;
		}
		case ValueID::ValueType_Short:
		{
			if ( debugging )
			{
				cout << OZW_datetime << "Type=Short" << endl;
			}
			Manager::Get()->GetValueAsShort(valueID, &short_value );
			snprintf(dev_value, 64, "%d.h", short_value);
			break;
		}
		case ValueID::ValueType_Schedule:
		{
			if ( debugging )
			{
				cout << OZW_datetime << "Type=Schedule" << endl;
			}
			return;
			//break;
		}
		case ValueID::ValueType_String:
		{
			if ( debugging )
			{
				cout << OZW_datetime << "Type=String" << endl;
			}
			Manager::Get()->GetValueAsString(valueID, &string_value );
			snprintf(dev_value, 64, "%s", strdup(string_value.c_str()));
			break;
		}
		case ValueID::ValueType_Button:
		{
			if ( debugging )
			{
				cout << OZW_datetime << "Type=Button" << endl;
			}
			return;
			//break;
		}
		case ValueID::ValueType_List:
		{
			if ( debugging )
			{
				cout << OZW_datetime << "Type=List" << endl;
			}
			Manager::Get()->GetValueListSelection(valueID, &list_value );
			snprintf(dev_value, 64, "%s", strdup(list_value.c_str()));
			break;
		}
		default:
		if ( debugging ) 
		{
			cout << OZW_datetime << "Type=Unknown" << endl;
		}
		return;
	}

	switch ( id )
	{
		case COMMAND_CLASS_BASIC:
		{
			if (label == "Basic")
			{
				value_no = 1;
				if ( strcmp(dev_value, "255") == 0 ) 
				{
					strcpy(dev_value, "On");
				}
				else if ( strcmp(dev_value, "1") == 0 ) 
				{
					strcpy(dev_value, "On");
				}
				else if ( strcmp(dev_value, "0") == 0 ) 
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
			if (label == "Switch")
			{
				value_no = 1;
				if ( strcmp(dev_value, "1") == 0 ) 
				{
					strcpy(dev_value, "On");
				}
				else
				{
					strcpy(dev_value, "Off");
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
		case COMMAND_CLASS_METER:
		{
			if (label == "Power")
			{
				value_no = 2;
			}
			else if (label == "Energy")
			{
				value_no = 3;
			}
			break;
		}
		case COMMAND_CLASS_SENSOR_BINARY:
		{	
			if (label == "Sensor")
			{
				value_no = 1;
				if ( strcmp(dev_value, "1") == 0 )
                                {
                                        strcpy(dev_value, "Closed");
                                }
                                else
                                {
                                        strcpy(dev_value, "Open");
                                }

			}
		}
		case COMMAND_CLASS_BATTERY:
		case COMMAND_CLASS_ALARM:
		case COMMAND_CLASS_SENSOR_MULTILEVEL:
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
			else if (label == "Alarm Level")
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
		}
	}
	if ( debugging )
	{
		cout << OZW_datetime << "Value=" << dev_value << endl;
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
	if ( debugging )
	{
		cout << endl << OZW_datetime << "AddNode: HomeId=" << homeID << " Node=" << nodeID << endl;
	}

}
void RPC_RemoveNode( int homeID, int nodeID )
{
	if ( debugging )
	{
		cout << endl << OZW_datetime << "RemoveNode: HomeId=" << homeID << " Node=" << nodeID << endl;
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
		cout << endl << OZW_datetime << "ProtocolInfo: HomeId=" << homeID << " Node=" << nodeID << endl;
		cout << OZW_datetime << "Basic=" << basic << endl;
		cout << OZW_datetime << "Generic=" << generic << endl;
		cout << OZW_datetime << "Specific=" << specific << endl;
		cout << OZW_datetime << "Cap=" << capabilities << endl;
		cout << OZW_datetime << "Security=" << security << endl;
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
		cout << endl << OZW_datetime << "GroupEvent: " << homeID << ":" << nodeID << endl;
	}
}

void RPC_NodeEvent( int homeID, int nodeID, int value )
{
	if ( debugging )
	{
		cout << endl << OZW_datetime << "NodeEvent: " << homeID << ":" << nodeID << endl;
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
		cout << endl << OZW_datetime << "EnabledPolling: HomeId=" << homeID << " Node=" << nodeID << endl;
	}
}

void RPC_DisabledPolling( int homeID, int nodeID )
{
	if ( debugging )
	{
		cout << endl << OZW_datetime << "DisabledPolling: HomeId=" << homeID << " Node=" << nodeID << endl;
	}
}

void RPC_DriverReady( int homeID, int nodeID )
{
	home = homeID;
	if ( debugging )
	{
		cout << endl << OZW_datetime << "DriverReady: HomeId=" << homeID << " Node=" << nodeID << endl;
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
			//RPC_AddValue( (int)data->GetHomeId(), (int)data->GetNodeId(), data->GetValueID(), data->GetByte() );
			RPC_ChangeValue( (int)data->GetHomeId(), (int)data->GetNodeId(), data->GetValueID(), true );

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
		case Notification::Type_NodeNaming:
                    {
			cout << endl << OZW_datetime << "NodeNaming: HomeId=" << (int)data->GetHomeId() << " Node=" << (int)data->GetNodeId() << endl;
                        cout << OZW_datetime << "ManufacturerName=" << Manager::Get()->GetNodeManufacturerName( data->GetHomeId(), data->GetNodeId() ) <<endl;
                        cout << OZW_datetime << "ProductName=" << Manager::Get()->GetNodeProductName( data->GetHomeId(), data->GetNodeId() ) <<endl;
                        break;
                    }
		case Notification::Type_ValueChanged:
		{
			RPC_ChangeValue( (int)data->GetHomeId(), (int)data->GetNodeId(), data->GetValueID(), false );
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
		case Notification::Type_AllNodesQueried:
		case Notification::Type_AwakeNodesQueried:
		{
			if ( debugging )
			{
				cout << endl << OZW_datetime << "AwakeNodeQueries Done!" << endl;
			}
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
		default:
		break;
	}
        pthread_mutex_unlock( &g_criticalSection );
}

// C style bindings are required since we call these functions from gambas.
extern "C" {

void DomoZWave_Init( const char* serialPort, int rpcPort, const char* configdir, const char* zwdir, bool enableLog, int polltime )
{
	debugging = enableLog;

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

	if ( polltime > 0 )
	{
        	Options::Get()->AddOptionInt("PollInterval", polltime);
       		Options::Get()->AddOptionBool("IntervalBetweenPolls", true);
	}
	Options::Get()->AddOptionBool("SuppressValueRefresh", false);

        Options::Get()->Lock();

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

	//cout << OZW_datetime << "Destroyed xmlrpc" << endl;
	Manager::Get()->Destroy();
	//cout << OZW_datetime << "Destroyed manager" << endl;
	Options::Get()->Destroy();
	//cout << OZW_datetime << "Destroyed options" << endl;

	pthread_mutex_unlock( &g_criticalSection );
	pthread_mutex_destroy( &g_criticalSection );
}

void DomoZWave_EnablePolling( int node, int32 polltime )
{
	if ( Manager::Get()->GetNodeBasic( home, node ) < 0x03 )
	{	
		return;
	}

	if( NodeInfo* nodeInfo = GetNodeInfo( home, node ) )
	{
        	// Mark the basic command class values for polling
                for( list<ValueID>::iterator it = nodeInfo->m_values.begin(); it != nodeInfo->m_values.end(); ++it )
		{
 			ValueID v = *it;
                        if( v.GetCommandClassId() == 0x20 )
			{
				Manager::Get()->EnablePoll( *it, 2 );

				if ( debugging )
				{
					cout << endl << OZW_datetime << "Enabled Polling for node " << node << endl;
				}
				break;
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

void DomoZWave_RequestConfigParam( int node, int param ) 
{
	Manager::Get()->RequestConfigParam( home, node, param );
}

void DomoZWave_AddAssociation( int node, int group ) 
{
	Manager::Get()->AddAssociation( home, 1, group, node);
	Manager::Get()->RefreshNodeInfo( home, node);
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

                                	//cout << OZW_datetime << "SetValue for node " << node << endl;
                                	//cout << OZW_datetime << "class id " << id << endl;
                                	//cout << OZW_datetime << "instance " << instance << endl;
                                	//cout << OZW_datetime << "value " << value << endl;
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
