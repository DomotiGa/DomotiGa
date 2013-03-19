#!/bin/sh
# restore symlinks between DomotiGa and DomotiGaServer

echo "This script will create symbolic links between shared code of DomotiGa and DomotiGaServer.\nPress CTRL-C to abort or ENTER to continue"
read dummy

cd ../DomotiGaServer
cp Main.module Main.module.back
rm *.class
rm *.module
cp Main.module.back Main.module
ln -s ../DomotiGa/Astro.module
ln -s ../DomotiGa/AVControl.module
ln -s ../DomotiGa/Bluetooth.module
ln -s ../DomotiGa/Bwired.module
ln -s ../DomotiGa/CallerID.module
ln -s ../DomotiGa/CAsterisk.class
ln -s ../DomotiGa/CCUL.class
ln -s ../DomotiGa/CCTX35.class
ln -s ../DomotiGa/CCurrentCost.class
ln -s ../DomotiGa/CDenon.class
ln -s ../DomotiGa/CDomotica.class
ln -s ../DomotiGa/CDSC.class
ln -s ../DomotiGa/CEIB.class
ln -s ../DomotiGa/CELVMAX.class
ln -s ../DomotiGa/CEZcontrol.class
ln -s ../DomotiGa/CFritzBox.class
ln -s ../DomotiGa/CGPS.class
ln -s ../DomotiGa/CHomeMatic.class
ln -s ../DomotiGa/CIPort.class
ln -s ../DomotiGa/CIRMan.class
ln -s ../DomotiGa/CIRTrans.class
ln -s ../DomotiGa/CIViewer.class
ln -s ../DomotiGa/CJeeLabs.class
ln -s ../DomotiGa/CK8055.class
ln -s ../DomotiGa/CLEDMatrix.class
ln -s ../DomotiGa/CLGTV.class
ln -s ../DomotiGa/CLIRC.class
ln -s ../DomotiGa/CMeteohub.class
ln -s ../DomotiGa/CMochad.class
ln -s ../DomotiGa/CMQTT.class
ln -s ../DomotiGa/CNcid.class
ln -s ../DomotiGa/CTemp08.class
ln -s ../DomotiGa/COnkyo.class
ln -s ../DomotiGa/COpenTherm.class
ln -s ../DomotiGa/COWFS.class
ln -s ../DomotiGa/COWW.class
ln -s ../DomotiGa/CPLCBUS.class
ln -s ../DomotiGa/CPioneer.class
ln -s ../DomotiGa/CPlugwise.class
ln -s ../DomotiGa/CPwrCtrl.class
ln -s ../DomotiGa/CRFXComRX.class
ln -s ../DomotiGa/CRFXComTX.class
ln -s ../DomotiGa/CRFXComTRX.class
ln -s ../DomotiGa/CRFXComxPL.class
ln -s ../DomotiGa/CSharpTV.class
ln -s ../DomotiGa/CSmartMeter.class
ln -s ../DomotiGa/CSMS.class
ln -s ../DomotiGa/CSqueezeServer.class
ln -s ../DomotiGa/CTimerDelay.class
ln -s ../DomotiGa/CTimerOnOff.class
ln -s ../DomotiGa/CUPS.class
ln -s ../DomotiGa/CVISCA.class
ln -s ../DomotiGa/CWebServer.class
ln -s ../DomotiGa/CTelnetServer.class
ln -s ../DomotiGa/CWeeder.class
ln -s ../DomotiGa/CYouLess.class
ln -s ../DomotiGa/CXBMCxPL.class
ln -s ../DomotiGa/CXMLRPC.class
ln -s ../DomotiGa/CxPL.class
ln -s ../DomotiGa/CxPLMsg.class
ln -s ../DomotiGa/CZWave.class
ln -s ../DomotiGa/Calendar.module
ln -s ../DomotiGa/Devices.module
ln -s ../DomotiGa/Digitemp.module
ln -s ../DomotiGa/DNS.module
ln -s ../DomotiGa/Energy.module
ln -s ../DomotiGa/EventLoop.module
ln -s ../DomotiGa/Events.module
ln -s ../DomotiGa/GLatitude.module
ln -s ../DomotiGa/HDDTemp.module
ln -s ../DomotiGa/X10Cmd.module
ln -s ../DomotiGa/Shell.module
ln -s ../DomotiGa/JSON.module
ln -s ../DomotiGa/Mail.module
ln -s ../DomotiGa/Pachube.module
ln -s ../DomotiGa/Ping.module
ln -s ../DomotiGa/RRDTool.module
ln -s ../DomotiGa/ServerStats.module
ln -s ../DomotiGa/Sounds.module
ln -s ../DomotiGa/TemperaturNu.module
ln -s ../DomotiGa/TVGuide.module
ln -s ../DomotiGa/Thermostat.module
ln -s ../DomotiGa/Twitter.module
ln -s ../DomotiGa/VideoServer.module
ln -s ../DomotiGa/VoiceText.module
