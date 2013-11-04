#!/bin/sh
# remove symlinks between DomotiGa3 and DomotiGaServer3

echo "This script will remove any symbolic links between shared code of DomotiGa3 and DomotiGaServer3.\nAnd copy over original files instead.\nPress CTRL-C to abort or ENTER to continue"
read dummy
if [ -d DomotiGaServer3 ]; then
  cd DomotiGaServer3/.src/
else
  cd ../DomotiGaServer3/.src/
fi
cp Main.module Main.module.back
rm *.class
rm *.module
cp Main.module.back Main.module
cp ../../DomotiGa3/.src/Astro.module .
cp ../../DomotiGa3/.src/AVControl.module .
cp ../../DomotiGa3/.src/Bluetooth.module .
cp ../../DomotiGa3/.src/Bwired.module .
cp ../../DomotiGa3/.src/CallerID.module .
cp ../../DomotiGa3/.src/CAsterisk.class .
cp ../../DomotiGa3/.src/CCUL.class .
cp ../../DomotiGa3/.src/CCTX35.class .
cp ../../DomotiGa3/.src/CCurrentCost.class .
cp ../../DomotiGa3/.src/CDenon.class .
cp ../../DomotiGa3/.src/CDigitemp.class .
cp ../../DomotiGa3/.src/CDMXPlayer.class .
cp ../../DomotiGa3/.src/CDomotica.class .
cp ../../DomotiGa3/.src/CDSC.class .
cp ../../DomotiGa3/.src/CELVMAX.class .
cp ../../DomotiGa3/.src/CEIB.class .
cp ../../DomotiGa3/.src/CEZcontrol.class .
cp ../../DomotiGa3/.src/CFritzBox.class .
cp ../../DomotiGa3/.src/CGPS.class .
cp ../../DomotiGa3/.src/CGenericIO.class .
cp ../../DomotiGa3/.src/CHomeMatic.class .
cp ../../DomotiGa3/.src/CIPort.class .
cp ../../DomotiGa3/.src/CIRMan.class .
cp ../../DomotiGa3/.src/CIRTrans.class .
cp ../../DomotiGa3/.src/CIViewer.class .
cp ../../DomotiGa3/.src/CJeeLabs.class .
cp ../../DomotiGa3/.src/CJSONRPC.class .
cp ../../DomotiGa3/.src/CK8055.class .
cp ../../DomotiGa3/.src/CKMTronicUDP.class .
cp ../../DomotiGa3/.src/CLEDMatrix.class .
cp ../../DomotiGa3/.src/CMochad.class .
cp ../../DomotiGa3/.src/CMQTT.class .
cp ../../DomotiGa3/.src/CMeteohub.class .
cp ../../DomotiGa3/.src/CNcid.class .
cp ../../DomotiGa3/.src/CLGTV.class .
cp ../../DomotiGa3/.src/CLIRC.class .
cp ../../DomotiGa3/.src/CTemp08.class .
cp ../../DomotiGa3/.src/COpenTherm.class .
cp ../../DomotiGa3/.src/COnkyo.class .
cp ../../DomotiGa3/.src/COWFS.class .
cp ../../DomotiGa3/.src/COWW.class .
cp ../../DomotiGa3/.src/CPLCBUS.class .
cp ../../DomotiGa3/.src/CPluginEntry.class .
cp ../../DomotiGa3/.src/CPlugwise.class .
cp ../../DomotiGa3/.src/CPioneer.class .
cp ../../DomotiGa3/.src/CPwrCtrl.class .
cp ../../DomotiGa3/.src/CRaZberry.class .
cp ../../DomotiGa3/.src/CRFXComRX.class .
cp ../../DomotiGa3/.src/CRFXComTX.class .
cp ../../DomotiGa3/.src/CRFXComTRX.class .
cp ../../DomotiGa3/.src/CRFXComxPL.class .
cp ../../DomotiGa3/.src/CSharpTV.class .
cp ../../DomotiGa3/.src/CSMS.class .
cp ../../DomotiGa3/.src/CSmartMeter.class .
cp ../../DomotiGa3/.src/CSmartVISUServer.class .
cp ../../DomotiGa3/.src/CSqueezeServer.class .
cp ../../DomotiGa3/.src/CTimerDelay.class .
cp ../../DomotiGa3/.src/CTimerOnOff.class .
cp ../../DomotiGa3/.src/CUPS.class .
cp ../../DomotiGa3/.src/CVISCA.class .
cp ../../DomotiGa3/.src/CTelnetServer.class .
cp ../../DomotiGa3/.src/CWeeder.class .
cp ../../DomotiGa3/.src/CWebSocket.class .
cp ../../DomotiGa3/.src/CX10Cmd.class .
cp ../../DomotiGa3/.src/CXMLRPC.class .
cp ../../DomotiGa3/.src/CXBMCxPL.class .
cp ../../DomotiGa3/.src/CxPL.class .
cp ../../DomotiGa3/.src/CxPLMsg.class .
cp ../../DomotiGa3/.src/CVisonic.class .
cp ../../DomotiGa3/.src/CYouLess.class .
cp ../../DomotiGa3/.src/CZWave.class .
cp ../../DomotiGa3/.src/Calendar.module .
cp ../../DomotiGa3/.src/Devices.module .
cp ../../DomotiGa3/.src/DNS.module .
cp ../../DomotiGa3/.src/Energy.module .
cp ../../DomotiGa3/.src/EventLoop.module .
cp ../../DomotiGa3/.src/Events.module .
cp ../../DomotiGa3/.src/HDDTemp.module .
cp ../../DomotiGa3/.src/Shell.module .
cp ../../DomotiGa3/.src/Log.module .
cp ../../DomotiGa3/.src/Mail.module .
cp ../../DomotiGa3/.src/NMA.module .
cp ../../DomotiGa3/.src/P2000.module .
cp ../../DomotiGa3/.src/Pachube.module .
cp ../../DomotiGa3/.src/Ping.module .
cp ../../DomotiGa3/.src/Plugin.module .
cp ../../DomotiGa3/.src/Pushover.module .
cp ../../DomotiGa3/.src/Prowl.module .
cp ../../DomotiGa3/.src/PVoutput.module .
cp ../../DomotiGa3/.src/RRDTool.module .
cp ../../DomotiGa3/.src/ServerStats.module .
cp ../../DomotiGa3/.src/Sounds.module .
cp ../../DomotiGa3/.src/TemperaturNu.module .
cp ../../DomotiGa3/.src/TVGuide.module .
cp ../../DomotiGa3/.src/Thermostat.module .
cp ../../DomotiGa3/.src/Twitter.module .
cp ../../DomotiGa3/.src/VideoServer.module .
cp ../../DomotiGa3/.src/VoiceText.module .
cp ../../DomotiGa3/.src/WeatherUG.module .
cp ../../DomotiGa3/.src/JsonRpc/JsonMiniServer.class .
cp ../../DomotiGa3/.src/JsonRpc/JsonRpcFunction.class .
cp ../../DomotiGa3/.src/JsonRpc/JsonRpcServer.class .

