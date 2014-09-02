#!/bin/sh
# restore symlinks between DomotiGa3 and DomotiGaServer3

echo "This script will create symbolic links between shared code of DomotiGa3 and DomotiGaServer3.\nPress CTRL-C to abort or ENTER to continue"
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
ln -s ../../DomotiGa3/.src/Astro.module
ln -s ../../DomotiGa3/.src/AVControl.module
ln -s ../../DomotiGa3/.src/CallerID.module
ln -s ../../DomotiGa3/.src/CAsterisk.class
ln -s ../../DomotiGa3/.src/CBluetooth.class
ln -s ../../DomotiGa3/.src/CCUL.class
ln -s ../../DomotiGa3/.src/CBwiredMap.class
ln -s ../../DomotiGa3/.src/CCTX35.class
ln -s ../../DomotiGa3/.src/CCurrentCost.class
ln -s ../../DomotiGa3/.src/CDenon.class
ln -s ../../DomotiGa3/.src/CDeviceDiscover.class
ln -s ../../DomotiGa3/.src/CDigitemp.class
ln -s ../../DomotiGa3/.src/CDSC.class
ln -s ../../DomotiGa3/.src/CELVMAX.class
ln -s ../../DomotiGa3/.src/CEIB.class
ln -s ../../DomotiGa3/.src/CEZcontrol.class
ln -s ../../DomotiGa3/.src/CFritzBox.class
ln -s ../../DomotiGa3/.src/CGlobalVarEntry.class
ln -s ../../DomotiGa3/.src/CGMail.class
ln -s ../../DomotiGa3/.src/CGPS.class
ln -s ../../DomotiGa3/.src/CGenericIO.class
ln -s ../../DomotiGa3/.src/CHDDTemp.class
ln -s ../../DomotiGa3/.src/CHomeMatic.class
ln -s ../../DomotiGa3/.src/CIPort.class
ln -s ../../DomotiGa3/.src/CIRMan.class
ln -s ../../DomotiGa3/.src/CIRTrans.class
ln -s ../../DomotiGa3/.src/CIViewer.class
ln -s ../../DomotiGa3/.src/CJeeLabs.class
ln -s ../../DomotiGa3/.src/CJerome.class
ln -s ../../DomotiGa3/.src/CJSONRPC.class
ln -s ../../DomotiGa3/.src/CK8055.class
ln -s ../../DomotiGa3/.src/CKMTronicUDP.class
ln -s ../../DomotiGa3/.src/CLEDMatrix.class
ln -s ../../DomotiGa3/.src/CMochad.class
ln -s ../../DomotiGa3/.src/CMQTT.class
ln -s ../../DomotiGa3/.src/CMeteohub.class
ln -s ../../DomotiGa3/.src/CNcid.class
ln -s ../../DomotiGa3/.src/CLGTV.class
ln -s ../../DomotiGa3/.src/CLIRC.class
ln -s ../../DomotiGa3/.src/CNMA.class
ln -s ../../DomotiGa3/.src/COpenTherm.class
ln -s ../../DomotiGa3/.src/COpenZWave.class
ln -s ../../DomotiGa3/.src/COnkyo.class
ln -s ../../DomotiGa3/.src/COWFS.class
ln -s ../../DomotiGa3/.src/COWW.class
ln -s ../../DomotiGa3/.src/CP2000.class
ln -s ../../DomotiGa3/.src/CPachube.class
ln -s ../../DomotiGa3/.src/CPhilipsHue.class
ln -s ../../DomotiGa3/.src/CPLCBUS.class
ln -s ../../DomotiGa3/.src/CPluginEntry.class
ln -s ../../DomotiGa3/.src/CPlugwise.class
ln -s ../../DomotiGa3/.src/CPing.class
ln -s ../../DomotiGa3/.src/CPioneer.class
ln -s ../../DomotiGa3/.src/CPushover.class
ln -s ../../DomotiGa3/.src/CPushbullet.class
ln -s ../../DomotiGa3/.src/CProwl.class
ln -s ../../DomotiGa3/.src/CPVoutput.class
ln -s ../../DomotiGa3/.src/CPwrCtrl.class
ln -s ../../DomotiGa3/.src/CRaZberry.class
ln -s ../../DomotiGa3/.src/CRFXComRX.class
ln -s ../../DomotiGa3/.src/CRFXComTX.class
ln -s ../../DomotiGa3/.src/CRFXComTRX.class
ln -s ../../DomotiGa3/.src/CRFXComxPL.class
ln -s ../../DomotiGa3/.src/CSharpTV.class
ln -s ../../DomotiGa3/.src/CSMS.class
ln -s ../../DomotiGa3/.src/CSmartMeter.class
ln -s ../../DomotiGa3/.src/CSmartVISUServer.class
ln -s ../../DomotiGa3/.src/CSqueezeServer.class
ln -s ../../DomotiGa3/.src/CTelnetServer.class
ln -s ../../DomotiGa3/.src/CTemp08.class
ln -s ../../DomotiGa3/.src/CTemperaturNu.class
ln -s ../../DomotiGa3/.src/CToon.class
ln -s ../../DomotiGa3/.src/CTwitter.class
ln -s ../../DomotiGa3/.src/CUPS.class
ln -s ../../DomotiGa3/.src/CVISCA.class
ln -s ../../DomotiGa3/.src/CWeeder.class
ln -s ../../DomotiGa3/.src/CWebSocket.class
ln -s ../../DomotiGa3/.src/CWirelesstags.class
ln -s ../../DomotiGa3/.src/CX10Cmd.class
ln -s ../../DomotiGa3/.src/CXMLRPC.class
ln -s ../../DomotiGa3/.src/CXBMCxPL.class
ln -s ../../DomotiGa3/.src/CxPL.class
ln -s ../../DomotiGa3/.src/CxPLMsg.class
ln -s ../../DomotiGa3/.src/CVelbus.class
ln -s ../../DomotiGa3/.src/CViera.class
ln -s ../../DomotiGa3/.src/CVisonic.class
ln -s ../../DomotiGa3/.src/CYouLess.class
ln -s ../../DomotiGa3/.src/Calendar.module
ln -s ../../DomotiGa3/.src/Devices.module
ln -s ../../DomotiGa3/.src/DNS.module
ln -s ../../DomotiGa3/.src/DMXPlayer.module
ln -s ../../DomotiGa3/.src/Energy.module
ln -s ../../DomotiGa3/.src/EventLoop.module
ln -s ../../DomotiGa3/.src/Events.module
ln -s ../../DomotiGa3/.src/Log.module
ln -s ../../DomotiGa3/.src/Shell.module
ln -s ../../DomotiGa3/.src/Mail.module
ln -s ../../DomotiGa3/.src/Plugin.module
ln -s ../../DomotiGa3/.src/RRDTool.module
ln -s ../../DomotiGa3/.src/Scenes.module
ln -s ../../DomotiGa3/.src/ServerStats.module
ln -s ../../DomotiGa3/.src/Sounds.module
ln -s ../../DomotiGa3/.src/Util.module
ln -s ../../DomotiGa3/.src/TVGuide.module
ln -s ../../DomotiGa3/.src/Thermostat.module
ln -s ../../DomotiGa3/.src/VideoServer.module
ln -s ../../DomotiGa3/.src/VoiceText.module
ln -s ../../DomotiGa3/.src/WeatherUG.module
ln -s ../../DomotiGa3/.src/JsonRpc/JsonRpcFunction.class
ln -s ../../DomotiGa3/.src/JsonRpc/JsonRpcServer.class
ln -s ../../DomotiGa3/.src/Timers/CTimerDelay.class
ln -s ../../DomotiGa3/.src/Timers/CTimerOnOff.class
ln -s ../../DomotiGa3/.src/Timers/CTimerGeneric.class

