
extern "C" {
#define COMMAND_CLASS_SWITCH_BINARY       0x25
#define COMMAND_CLASS_SWITCH_MULTILEVEL   0x26

void DomoZWave_Init( const char* serialPort, int rpcPort, const char* configdir, const char* zwdir, bool enableLog );
void DomoZWave_SetNodeOn( int node );
void DomoZWave_SetNodeOff( int node );
void DomoZWave_SetNodeLevel( int node, int level );
void DomoZWave_EnablePolling( int node, int polltime );
void DomoZWave_DisablePolling( int node );
void DomoZWave_RequestNodeState( int node );
void DomoZWave_RequestNetworkUpdate( );
void DomoZWave_AddDevice();
void DomoZWave_RemoveDevice( int node );
void DomoZWave_RequestNodeNeighborUpdate( int node );
void DomoZWave_CancelControllerCommand();
void DomoZWave_SetConfigParam( int node, int param, int value );
void DomoZWave_RequestAllConfigParams( int node );
void DomoZWave_SetValue( int node, int instance, int value );
}
