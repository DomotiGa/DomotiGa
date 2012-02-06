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

extern "C" {
extern const char *cclasstoStr( uint8 );
extern const char *cgenretoStr( uint8 );
void DomoZWave_Init( const char* serialPort, int rpcPort, const char* configdir, const char* zwdir, bool enableLog );
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
