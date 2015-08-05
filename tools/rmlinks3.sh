#!/bin/sh
# remove symlinks between DomotiGa3 and DomotiGaServer3

echo "This script will remove any symbolic links between shared code of DomotiGa3 and DomotiGaServer3.\nAnd copy over original files instead.\nPress CTRL-C to abort or ENTER to continue"
read dummy
if [ -d DomotiGaServer3 ]; then
  cd DomotiGaServer3/.src/
else
  cd ../DomotiGaServer3/.src/
fi
#
cp Main.module Main.module.back
#
rm *.class
rm *.module
rm */*.class
rm */*.module
mkdir -p JsonRpc
mkdir -p Timers
#
cp Main.module.back Main.module
cp ../../DomotiGa3/.src/Astro.module .
cp ../../DomotiGa3/.src/AVControl.module .
cp ../../DomotiGa3/.src/CallerID.module .
cp ../../DomotiGa3/.src/CAsterisk.class .
cp ../../DomotiGa3/.src/CBluetooth.class .
cp ../../DomotiGa3/.src/CBroadcastUDP.class .
cp ../../DomotiGa3/.src/CCUL.class .
cp ../../DomotiGa3/.src/CBwiredMap.class .
cp ../../DomotiGa3/.src/CCTX35.class .
cp ../../DomotiGa3/.src/CConrad8Relay.class .
cp ../../DomotiGa3/.src/CCurrentCost.class .
cp ../../DomotiGa3/.src/CDenon.class .
cp ../../DomotiGa3/.src/CDeviceDiscover.class .
cp ../../DomotiGa3/.src/CDigitemp.class .
cp ../../DomotiGa3/.src/CDMXPlayer.class .
cp ../../DomotiGa3/.src/CDSC.class .
cp ../../DomotiGa3/.src/CELVMAX.class .
cp ../../DomotiGa3/.src/CEZcontrol.class .
cp ../../DomotiGa3/.src/CForecastIo.class .
cp ../../DomotiGa3/.src/CFritzBox.class .
cp ../../DomotiGa3/.src/CGlobalVarEntry.class .
cp ../../DomotiGa3/.src/CGMail.class .
cp ../../DomotiGa3/.src/CGPS.class .
cp ../../DomotiGa3/.src/CGenericIO.class .
cp ../../DomotiGa3/.src/CHDDTemp.class .
cp ../../DomotiGa3/.src/CHomeMatic.class .
cp ../../DomotiGa3/.src/CIPort.class .
cp ../../DomotiGa3/.src/CIpx800.class .
cp ../../DomotiGa3/.src/CIRMan.class .
cp ../../DomotiGa3/.src/CIRTrans.class .
cp ../../DomotiGa3/.src/CIViewer.class .
cp ../../DomotiGa3/.src/CJeeLabs.class .
cp ../../DomotiGa3/.src/CJerome.class .
cp ../../DomotiGa3/.src/CJSONRPC.class .
cp ../../DomotiGa3/.src/CK8055.class .
cp ../../DomotiGa3/.src/CKMTronicUDP.class .
cp ../../DomotiGa3/.src/CKNX.class .
cp ../../DomotiGa3/.src/CLEDMatrix.class .
cp ../../DomotiGa3/.src/CMochad.class .
cp ../../DomotiGa3/.src/CMQTT.class .
cp ../../DomotiGa3/.src/CMeteohub.class .
cp ../../DomotiGa3/.src/CMySensors.class .
cp ../../DomotiGa3/.src/CNcid.class .
cp ../../DomotiGa3/.src/CLGTV.class .
cp ../../DomotiGa3/.src/CLIRC.class .
cp ../../DomotiGa3/.src/CNMA.class .
cp ../../DomotiGa3/.src/CNetworkDetect.class .
cp ../../DomotiGa3/.src/COpenTherm.class .
cp ../../DomotiGa3/.src/COpenWeatherMap.class .
cp ../../DomotiGa3/.src/COpenZWave.class .
cp ../../DomotiGa3/.src/COmniksol.class .
cp ../../DomotiGa3/.src/COnkyo.class .
cp ../../DomotiGa3/.src/COWFS.class .
cp ../../DomotiGa3/.src/COWW.class .
cp ../../DomotiGa3/.src/CP2000.class .
cp ../../DomotiGa3/.src/CPhilipsHue.class .
cp ../../DomotiGa3/.src/CPLCBUS.class .
cp ../../DomotiGa3/.src/CPluginEntry.class .
cp ../../DomotiGa3/.src/CPlugwise.class .
cp ../../DomotiGa3/.src/CPioneer.class .
cp ../../DomotiGa3/.src/CPushbullet.class .
cp ../../DomotiGa3/.src/CPushover.class .
cp ../../DomotiGa3/.src/CProwl.class .
cp ../../DomotiGa3/.src/CPVoutput.class .
cp ../../DomotiGa3/.src/CPwrCtrl.class .
cp ../../DomotiGa3/.src/CRaZberry.class .
cp ../../DomotiGa3/.src/CRFXComRX.class .
cp ../../DomotiGa3/.src/CRFXComTX.class .
cp ../../DomotiGa3/.src/CRFXComTRX.class .
cp ../../DomotiGa3/.src/CRFXComxPL.class .
cp ../../DomotiGa3/.src/CSharpTV.class .
cp ../../DomotiGa3/.src/CShell.class .
cp ../../DomotiGa3/.src/CSMS.class .
cp ../../DomotiGa3/.src/CSmartMeter.class .
cp ../../DomotiGa3/.src/CSmartVISUServer.class .
cp ../../DomotiGa3/.src/CSqueezeServer.class .
cp ../../DomotiGa3/.src/CSSLServerSocket.class .
cp ../../DomotiGa3/.src/CSSLSocket.class .
cp ../../DomotiGa3/.src/CTelnetServer.class .
cp ../../DomotiGa3/.src/CTemp08.class .
cp ../../DomotiGa3/.src/CTemperaturNu.class .
cp ../../DomotiGa3/.src/CToon.class .
cp ../../DomotiGa3/.src/CTVGuide.class .
cp ../../DomotiGa3/.src/CTwitter.class .
cp ../../DomotiGa3/.src/CUPS.class .
cp ../../DomotiGa3/.src/CVISCA.class .
cp ../../DomotiGa3/.src/CWeeder.class .
cp ../../DomotiGa3/.src/CWebSocket.class .
cp ../../DomotiGa3/.src/CWirelesstags.class .
cp ../../DomotiGa3/.src/CWiringPi.class .
cp ../../DomotiGa3/.src/CX10Cmd.class .
cp ../../DomotiGa3/.src/CXMLRPC.class .
cp ../../DomotiGa3/.src/CXBMCxPL.class .
cp ../../DomotiGa3/.src/CxPL.class .
cp ../../DomotiGa3/.src/CxPLMsg.class .
cp ../../DomotiGa3/.src/CXively.class .
cp ../../DomotiGa3/.src/CVelbus.class .
cp ../../DomotiGa3/.src/CVideoServer.class .
cp ../../DomotiGa3/.src/CViera.class .
cp ../../DomotiGa3/.src/CVisonic.class .
cp ../../DomotiGa3/.src/CYouLess.class .
cp ../../DomotiGa3/.src/Calendar.module .
cp ../../DomotiGa3/.src/Devices.module .
cp ../../DomotiGa3/.src/DNS.module .
cp ../../DomotiGa3/.src/Energy.module .
cp ../../DomotiGa3/.src/EventLoop.module .
cp ../../DomotiGa3/.src/Events.module .
cp ../../DomotiGa3/.src/Log.module .
cp ../../DomotiGa3/.src/Mail.module .
cp ../../DomotiGa3/.src/Plugin.module .
cp ../../DomotiGa3/.src/RRDTool.module .
cp ../../DomotiGa3/.src/Scenes.module .
cp ../../DomotiGa3/.src/ServerStats.module .
cp ../../DomotiGa3/.src/Sounds.module .
cp ../../DomotiGa3/.src/Thermostat.module .
cp ../../DomotiGa3/.src/Util.module .
cp ../../DomotiGa3/.src/VoiceText.module .
cp ../../DomotiGa3/.src/CWeatherUnderground.class .
cp ../../DomotiGa3/.src/JsonRpc/* ./JsonRpc/
cp ../../DomotiGa3/.src/Timers/* ./Timers/
