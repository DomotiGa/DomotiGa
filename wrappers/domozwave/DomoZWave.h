
extern "C" {

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
}
