2013-09-18  alexie

    * 10009to10010.sql: Changed: Add an additional column to the globalvar table
      to recognize datatype

2013-09-17  alexie

    * .pot, CXMLRPC.class, Thermostat.module: Fixed: Some Thermostat issues in
      client/server mode

    * .pot, CDSC.class, CMochad.class, DomotiGa3.gambas, DomotiGaServer3.gambas,
      FHome.class, FMain.class: Fixed: Issue 324 - Home & Climate screen will
      show Temp/Humidity properly when using Z-Wave sensors. This is a
      workaround until the dynamic fields are implementedChanged: Replace Upper$
      with UCaseChanged: Replaced more "End If" with "Endif" to make the code
      more consistent

2013-09-16  alexie

    * .pot, CXMLRPC.class, CZWave.class, DomoZWave.cpp, DomotiGa3.gambas,
      DomotiGaServer3.gambas, FHeatingEditor.class, FMain.form,
      FSettingsOpenTherm.form, FThermostat.class, Thermostat.module: Fixed:
      Issue 323 - Del/Add Z-Wave device can generate duplicesFixed: FMain screen
      date/time wasn't complete visibleFixed: OpenTherm setting screen wasn't
      completely visibleFixed: Thermostat - if no temp is set and +/- is
      clicked, it takes the measured tempAdded: New XML-RPC method
      "device.updatedevice"

2013-09-13  alexie

    * .pot, DomotiGa3.gambas, DomotiGaServer3.gambas, FEditBwiredDevices.class,
      FEditCameraDevices.class, FEditContacts.class, FEditGlobalVars.class,
      FEditGraphs.class, FEditMenus.class, FEditPachubeDevices.class,
      FEditTVChannelsDetail.class, FEditTVProgramCategoriesDetail.class,
      FHeatingEditor.form, FScheduleEditor.class, FSettingsAstro.class,
      FSettingsAstroLatLong.class, FSettingsEmail.class,
      FSettingsFritzBox.class, FSettingsGMail.class, FSettingsGPS.class,
      FSettingsGUI.class, FSettingsHDDTemp.class, FSettingsIPort.class,
      FSettingsIRMan.class, FSettingsIRTrans.class, FSettingsIViewer.class,
      FSettingsJeeLabs.class, FSettingsK8055.class, FSettingsKMTronicUDP.class,
      FSettingsLEDMatrix.class, FSettingsLGTV.class, FSettingsLIRC.class,
      FSettingsMQTT.class, FSettingsMain.class, FSettingsMeteohub.class,
      FSettingsMochad.class, FSettingsMySQL.class, FSettingsNMA.class,
      FSettingsNcid.class, FSettingsOWFS.class, FSettingsOnkyo.class,
      FSettingsOpenTherm.class, FSettingsOww.class, FSettingsPLCBUS.class,
      FSettingsPVoutput.class, FSettingsPachube.class, FSettingsPing.class,
      FSettingsPlugwise.class, FSettingsProwl.class, FSettingsPushover.class,
      FSettingsPwrCtrl.class, FSettingsRFXComRX.class, FSettingsRFXComTRX.class,
      FSettingsRFXComTX.class, FSettingsRFXComxPL.class, FSettingsRRDTool.class,
      FSettingsSMS.class, FSettingsServerStats.class, FSettingsSharpTV.class,
      FSettingsShell.class, FSettingsSmartMeter.class,
      FSettingsSmartVisuServer.class, FSettingsSound.class,
      FSettingsSqueezeServer.class, FSettingsTVGuide.class,
      FSettingsTelnetServer.class, FSettingsTemp08.class,
      FSettingsTemperaturNu.class, FSettingsThermostat.class,
      FSettingsTwitter.class, FSettingsUPS.class, FSettingsVideoServer.class,
      FSettingsVisonic.class, FSettingsWeatherBug.class,
      FSettingsWeatherUG.class, FSettingsWeeder.class, FSettingsX10Cmd.class,
      FSettingsXBMCxPL.class, FSettingsXMLRPC.class, FSettingsYouLess.class,
      FSettingsZWave.class, FSettingsxPL.class, FTVGuide.class,
      FTVGuideChannelDetail.class, FTVGuideSearchDetail.class,
      FThermostat.class, FToolsBluetoothBrowser.class,
      FToolsDatabaseAdmin.class, FToolsSerialMon.class, FToolsSerialPorts.class,
      FToolsZWaveCmdr.class, Thermostat.module: Fixed: Thermostat requested
      temporary 0.0 wasn't a valid value (now it is -999)Changed: Replaced the
      "End If" by "Endif" in the GUI

2013-09-12  alexie

    * FConstantEditor.class: Fixed: Thermostat constant editor didn't always
      allow to save values

    * DomotiGa3.gambas, DomotiGaServer3.gambas, Thermostat.module: Fixed: Oeps,
      broke thermostat in revision 1343

    * .pot, 10009to10010.sql, DomotiGa3.gambas, DomotiGaServer3.gambas,
      FHeatingEditor.class, FHeatingEditor.form, FScheduleEditor.class,
      FThermostat.class, Thermostat.module: Fixed: Newly added thermostat
      heating didn't work, because secondary field wasn't properly initialized

    * FDebug.class, FScenarioEditor.class, WeatherUG.module: Fixed: Class/Module
      should use SetGlobalVar and GetGlobalVar only

    * .pot, DomotiGa3.gambas, DomotiGaServer3.gambas, FEditGlobalVars.class,
      FHome.class, FScheduleEditor.class, Thermostat.module: Fixed: Thermostat
      mode couldn't be changed in Home screenFixed: GlobalVar editor incorrectly
      displayed "<EMPTY>" valuesAdded: The thermostat module didn't report empty
      or invalid mode in debug mode

2013-09-11  alexie

    * 10009to10010.sql, FMain.class, domotiga-empty.sql, domotiga.sql: Fixed:
      Issue 329 - Table thermostat_schedule_entry Primary Key is invalidFixed:
      Planning Editor didn't work anymore

2013-09-10  rdnzl

    * COpenTherm.class, DomotiGa3.gambas, DomotiGaServer3.gambas: Fixed:
      OpenTherm convert hexdecimal values unsigned.

    * DomotiGa3.gambas, DomotiGaServer3.gambas, FMain.class, FMain.form,
      FScheduleEditor.class, FSettingsAstro.class, FSettingsAstroLatLong.class,
      FSettingsP2000.class, FSettingsP2000.form, Main.module, P2000.module:
      Added P2000 scanner module. See wiki.Code cleanup PollTime.Fixed Year
      globalvar update issue.

2013-09-09  alexie

    * Devices.module, DomotiGa3.gambas, DomotiGaServer3.gambas: Added: More
      debug logging for issue 321

    * DomotiGa3.gambas, DomotiGaServer3.gambas, FScheduleEditor.class,
      FScheduleEditor.form: Fixed: Thermostat could insert 2x the same
      schedule/heating, causing a fatal errorFixed: Thermostat layout fixes from
      revision 1269 (issue 255) where lost in 1.0.007Fixed: Thermostat secondary
      caused a fatal errorFixed: Thermostat could insert not existing
      schedule/heating

2013-09-08  alexie

    * FSplashScreen.class: Fixed: If authorization is enabled, switching back to
      Admin wasn't possibleFixed: If authorization is enabled, none-admin was
      able to configure Modules and Interfaces

    * DomotiGa3.gambas, FToolsZWaveCmdr.class: Fixed: Issue 328 - Removing nodes
      in association group doesn't work if ID => 9

    * DomoZWave.cpp: Fixed: Issue 327 - Cannot turn off Dimmer (FGD-211) after
      Rev.1328

2013-09-07  alexie

    * .pot, DomotiGa3.gambas, DomotiGaServer3.gambas, FEditUsers.class,
      FEditUsers.form, FSplashScreen.class, Main.module: Fixed: The system would
      go into mute after a restart

    * .pot, Devices.module, DomotiGa3.gambas, DomotiGaServer3.gambas,
      device.php: Fixed: Issue 271 - iPhone client "Dim 100" would cause a
      dimming cylce. Now "Dim 100" is translated to "On".

    * device.php: Fixed: WebClient iPhone only supported 1 dimmer (now it
      supports all)

2013-09-04  alexie

    * DomotiGa3.gambas, DomotiGaServer3.gambas, FWeatherUnderground.class,
      Main.module: Fixed: Issue 326 - WeatherUnderground module could
      crashFixed: Revision 1330 wasn't complete

2013-09-03  alexie

    * Main.module: Fixed: The Event loop was called each second, not every
      minute as it was before the GlobalVar update

2013-09-02  alexie

    * CXMLRPC.class: Fixed: Always respond to a "device.list" request, even if
      the "devices" table is empty (otherwise WebGUIs throw a weird exception).

    * DomoZWave.cpp: Changed: open-zwave wrapper will honor "Switch" and "Level"
      labels when doing a On, Off and Dim

2013-09-01  alexie

    * domotiga-empty.sql, domotiga.sql: Fixed: Also modified domotiga.sql &
      domotiga-empty.sql with r1326 changes

    * 10008to10009.sql: Fixed: Issue in the 1.0.008 to 1.0.009 SQL script

2013-09-01  rdnzl

    * 10008to10009.sql, CDMXPlayer.class, CMQTT.class, Devices.module,
      DomotiGa3.gambas, DomotiGaServer3.gambas, Edit, Events.module,
      FDeviceEditor.form, FEditBwiredDevices.class, FEditBwiredDevices.form,
      FEditCameraDevices.class, FEditCameraDevices.form, FEditCategories.class,
      FEditCategories.form, FEditContacts.class, FEditContacts.form,
      FEditDictionary.class, FEditDictionary.form, FEditDictionaryDetail.class,
      FEditDictionaryDetail.form, FEditEventThermostatProfiles.class,
      FEditEventThermostatProfiles.form, FEditGlobalVars.class,
      FEditGlobalVars.form, FEditGraphs.class, FEditGraphs.form,
      FEditMacro.class, FEditMacro.form, FEditMarkers.class, FEditMarkers.form,
      FEditMenus.class, FEditMenus.form, FEditModulesGroups.class,
      FEditModulesGroups.form, FEditNewsWeather.class, FEditNewsWeather.form,
      FEditNotify.class, FEditNotify.form, FEditPachubeDevices.class,
      FEditPachubeDevices.form, FEditTVChannels.class, FEditTVChannels.form,
      FEditTVChannelsDetail.class, FEditTVChannelsDetail.form,
      FEditTVProgramCategories.class, FEditTVProgramCategories.form,
      FEditTVProgramCategoriesDetail.class, FEditTVProgramCategoriesDetail.form,
      FEditUsers.class, FEditUsers.form, FMain.class, FMain.form,
      FSelectDate.class, FSelectDate.form, FSelectImage.class,
      FSelectImage.form, FSettingsAsterisk.class, FSettingsAsterisk.form,
      FSettingsAstro.class, FSettingsAstro.form, FSettingsAstroLatLong.class,
      FSettingsAstroLatLong.form, FSettingsBluetooth.class,
      FSettingsBluetooth.form, FSettingsBwiredMap.class,
      FSettingsBwiredMap.form, FSettingsCTX35.class, FSettingsCTX35.form,
      FSettingsCUL.class, FSettingsCUL.form, FSettingsCallerID.class,
      FSettingsCallerID.form, FSettingsCamVisca.class, FSettingsCamVisca.form,
      FSettingsCameras.class, FSettingsCameras.form, FSettingsCurrentCost.class,
      FSettingsCurrentCost.form, FSettingsDMXPlayer.class,
      FSettingsDMXPlayer.form, FSettingsDSC.class, FSettingsDSC.form,
      FSettingsDenon.class, FSettingsDenon.form, FSettingsDigitemp.class,
      FSettingsDigitemp.form, FSettingsDomotica.class, FSettingsDomotica.form,
      FSettingsEIB.class, FSettingsEIB.form, FSettingsELVMAX.class,
      FSettingsELVMAX.form, FSettingsEZcontrol.class, FSettingsEZcontrol.form,
      FSettingsEmail.class, FSettingsEmail.form, FSettingsFritzBox.class,
      FSettingsFritzBox.form, FSettingsGMail.class, FSettingsGMail.form,
      FSettingsGPS.class, FSettingsGPS.form, FSettingsGUI.class,
      FSettingsGUI.form, FSettingsHDDTemp.class, FSettingsHDDTemp.form,
      FSettingsHome.class, FSettingsHome.form, FSettingsHomeMatic.class,
      FSettingsHomeMatic.form, FSettingsIPort.class, FSettingsIPort.form,
      FSettingsIRMan.class, FSettingsIRMan.form, FSettingsIRTrans.class,
      FSettingsIRTrans.form, FSettingsIViewer.class, FSettingsIViewer.form,
      FSettingsJeeLabs.class, FSettingsJeeLabs.form, FSettingsK8055.class,
      FSettingsK8055.form, FSettingsKMTronicUDP.class,
      FSettingsKMTronicUDP.form, FSettingsLEDMatrix.class,
      FSettingsLEDMatrix.form, FSettingsLGTV.class, FSettingsLGTV.form,
      FSettingsLIRC.class, FSettingsLIRC.form, FSettingsMQTT.class,
      FSettingsMQTT.form, FSettingsMain.class, FSettingsMain.form,
      FSettingsMeteohub.class, FSettingsMeteohub.form, FSettingsMochad.class,
      FSettingsMochad.form, FSettingsMySQL.class, FSettingsMySQL.form,
      FSettingsNMA.class, FSettingsNMA.form, FSettingsNcid.class,
      FSettingsNcid.form, FSettingsOWFS.class, FSettingsOWFS.form,
      FSettingsOnkyo.class, FSettingsOnkyo.form, FSettingsOpenTherm.class,
      FSettingsOpenTherm.form, FSettingsOww.class, FSettingsOww.form,
      FSettingsPLCBUS.class, FSettingsPLCBUS.form, FSettingsPVoutput.class,
      FSettingsPVoutput.form, FSettingsPachube.class, FSettingsPachube.form,
      FSettingsPing.class, FSettingsPing.form, FSettingsPioneer.class,
      FSettingsPioneer.form, FSettingsPlugwise.class, FSettingsPlugwise.form,
      FSettingsProwl.class, FSettingsProwl.form, FSettingsPushover.class,
      FSettingsPushover.form, FSettingsPwrCtrl.class, FSettingsPwrCtrl.form,
      FSettingsRFXComRX.class, FSettingsRFXComRX.form, FSettingsRFXComTRX.class,
      FSettingsRFXComTRX.form, FSettingsRFXComTX.class, FSettingsRFXComTX.form,
      FSettingsRFXComxPL.class, FSettingsRFXComxPL.form, FSettingsRRDTool.class,
      FSettingsRRDTool.form, FSettingsSMS.class, FSettingsSMS.form,
      FSettingsServerStats.class, FSettingsServerStats.form,
      FSettingsSharpTV.class, FSettingsSharpTV.form, FSettingsShell.class,
      FSettingsShell.form, FSettingsSmartMeter.class, FSettingsSmartMeter.form,
      FSettingsSmartVisuServer.class, FSettingsSmartVisuServer.form,
      FSettingsSound.class, FSettingsSound.form, FSettingsSqueezeServer.class,
      FSettingsSqueezeServer.form, FSettingsTVGuide.class,
      FSettingsTVGuide.form, FSettingsTelnetServer.class,
      FSettingsTelnetServer.form, FSettingsTemp08.class, FSettingsTemp08.form,
      FSettingsTemperaturNu.class, FSettingsTemperaturNu.form,
      FSettingsThermostat.class, FSettingsThermostat.form,
      FSettingsTwitter.class, FSettingsTwitter.form, FSettingsUPS.class,
      FSettingsUPS.form, FSettingsVideoServer.class, FSettingsVideoServer.form,
      FSettingsVisonic.class, FSettingsVisonic.form, FSettingsVoiceText.class,
      FSettingsVoiceText.form, FSettingsWeatherBug.class,
      FSettingsWeatherBug.form, FSettingsWeatherUG.class,
      FSettingsWeatherUG.form, FSettingsWeeder.class, FSettingsWeeder.form,
      FSettingsX10Cmd.class, FSettingsX10Cmd.form, FSettingsXBMCxPL.class,
      FSettingsXBMCxPL.form, FSettingsXMLRPC.class, FSettingsXMLRPC.form,
      FSettingsYouLess.class, FSettingsYouLess.form, FSettingsZWave.class,
      FSettingsZWave.form, FSettingsxPL.class, FSettingsxPL.form,
      FTVGuide.class, FTVGuide.form, FTVGuideChannelDetail.class,
      FTVGuideChannelDetail.form, FTVGuideProgramDetail.class,
      FTVGuideProgramDetail.form, FTVGuideSearchDetail.class,
      FTVGuideSearchDetail.form, FToolsBluetoothBrowser.class,
      FToolsBluetoothBrowser.form, FToolsCULCmdr.class, FToolsCULCmdr.form,
      FToolsDatabaseAdmin.class, FToolsDatabaseAdmin.form,
      FToolsHomeMaticQuickSet.class, FToolsHomeMaticQuickSet.form,
      FToolsPLCBUSCmdr.class, FToolsPLCBUSCmdr.form, FToolsRFXComCmdr.class,
      FToolsRFXComCmdr.form, FToolsSerialMon.class, FToolsSerialMon.form,
      FToolsSerialPorts.class, FToolsSerialPorts.form, FToolsX10Cmdr.class,
      FToolsX10Cmdr.form, FToolsZWaveCmdr.class, FToolsZWaveCmdr.form,
      FWeather.class, FWeather.form, FWeatherBug.class, FWeatherBug.form,
      FWeatherUnderground.class, FWeatherUnderground.form, Main.module,
      NMA.module, P2000.module, Select, Settings, TV, Tools, WeatherUG.module,
      dmxplayer-module.jpg, domotiga-empty.sql, domotiga.sql, fixlinks3.sh,
      rmlinks3.sh: New version 1.0.009, you must upgrade your database.Please
      make a backup of your database and DomotiGa directory tree first!Small
      device editor fixes.Added initial support for DMXPlayer module, thanks
      Ronald!Completed WeatherUnderground support.WeatherUnderground GUI needs
      tidying up, any volunteers?You can now use WeatherUnderground data in
      events via globalvars starting with Weather_.Started putting GUI source
      files in separate directories.

2013-08-27  alexie

    * .pot, DomotiGa3.gambas, FMain.class: Fixed: Issue 320 - DomotiGa GUI
      doesn't exit if another window is open

2013-08-26  alexie

    * Devices.module: Added: The Devices.SetDevice also works with id´s now

    * .pot, CXMLRPC.class, DomotiGa3.gambas, DomotiGaServer3.gambas,
      EventLoop.module, Events.module, FActionScriptEditor.class,
      FConditionEditor.class, FEditGlobalVars.class, FEditGlobalVars.form,
      FHome.class, FMain.class, FMain.form, FMusic.class,
      FSettingsThermostat.class, FSplashScreen.class, FThermostat.class,
      FTriggerEditor.class, Mail.module, Main.module, Sounds.module,
      Thermostat.module, VoiceText.module, WeatherUG.module, XMLClient.module:
      Changed: GlobalVar values are directly updated into the database (with the
      exception of seconds/uptime)Add: GlobalVar values can be empty nowAdd:
      Html Encode/Decode functions for XML-RPC, XML 1.0 fifth & 1.1
      compatibleFixed: GlobalVar values with "<" or ">" generated a XML-RPC
      errorFixed: XMLClient error handling and loggingFixed: Thermostat Setting
      for polltime couldn't be savedFixed: GlobalVar "Tagline" was updated in
      DomotiGa Client, should only happen in the serverFixed: Some DomotiGa GUI
      layout issuesFixed: Some internal menu's weren't properly named

2013-08-24  alexie

    * XMLClient.module: Fixed: Some XMLClient errors weren't reported

2013-08-23  rdnzl

    * CCUL.class, CDenon.class, CEIB.class, CEZcontrol.class, CHomeMatic.class,
      CIPort.class, COWW.class, CPLCBUS.class, CPioneer.class, CPlugwise.class,
      CPwrCtrl.class, CRFXComRX.class, CRFXComTRX.class, CRFXComTX.class,
      CVISCA.class, CxPL.class, Devices.module, DomotiGa3.gambas,
      DomotiGaServer3.gambas, FBarcodes.class, FDeviceEditor.class,
      FEditCategories.class, FEditContacts.class,
      FEditEventThermostatProfiles.class, FEditMarkers.class,
      FEditModulesGroups.class, FEditNewsWeather.class, FEditNotify.class,
      FEditTVProgramCategoriesDetail.class, FEditUsers.class,
      FEventThermostat.class, FMain.class, FSettingsLEDMatrix.class,
      FSettingsTwitter.class, FTVGuide.class, FToolsRFXComCmdr.class,
      FTriggerEditor.class, Main.module, NMA.module, Prowl.module,
      Pushover.module, RRDTool.module, ScreenFunc.module, Thermostat.module,
      XMLParser.module: Removed all [GB2] comment lines.Made Devices.FindRegExp
      routine more generic.Also flush writes directly to logs in DomotiGa3
      program.

2013-08-22  alexie

    * AVControl.module, CAsterisk.class, CxPLMsg.class, DNS.module,
      FAbout.class, FClimate.class, FEditCategories.class,
      FEditDictionary.class, FEditDictionaryDetail.class, FEditGraphs.class,
      FEditMarkers.class, FEditModulesGroups.class, FEditNotify.class,
      FEditTVChannels.class, FEditTVProgramCategories.class,
      FEditTVProgramCategoriesDetail.class, FEmail.class, FEnergy.class,
      FGraphsPreview.class, FHVAC.class, FNetwork.class, FScenarioEditor.class,
      FSecurity.class, FSettingsCameras.class, FTextViewer.class,
      FToolsBluetoothBrowser.class: Changed: Updated all Class files to Gambas3
      format

2013-08-22  rdnzl

    * 10007to10008.sql, DomotiGa3.gambas, DomotiGaServer3.gambas,
      FScheduleEditor.class, Main.module, Thermostat.module, Twitter.module,
      domotiga-empty.sql, domotiga.sql: New version 1.0.008, you must upgrade
      your database.Please make a backup of your database and DomotiGa directory
      tree first!Made default setting values the same as active ones.Removed
      Google Latitude database entries.Added missing secondary thermostat
      database field, needs testing.

2013-08-21  alexie

    * Devices.module: Fixed: Jeelabs debug output showed "LGTV"

2013-08-21  rdnzl

    * CTimerOnOff.class, DomotiGa3.gambas, DomotiGaServer3.gambas,
      Thermostat.module, WeatherUG.module, fixlinks3.sh: Small fixes.

2013-08-20  alexie

    * 10007to10008.sql, domotiga-empty.sql, domotiga.sql: Changed: Issue 302 is
      also updated for the 1.0.007 to 1.0.008 SQL file and some minor updates in
      the default SQL files

2013-08-19  alexie

    * .pot, CYouLess.class, DomotiGa3.gambas, DomotiGaServer3.gambas,
      FDeviceEditor.class, FMain.class, FMain.form, FSettingsGLatitude.class,
      FSettingsGLatitude.form, GLatitude.module, Main.module: Changed: Issue 300
      - Google Latitude removed (stopped working on 9-Aug-2013)

2013-08-18  alexie

    * .pot, DomotiGa3.gambas, FSettingsZWave.class: Fixed: Issue 311 - can't
      enable Z-Wave when running client/server and open-zwave isn't installed on
      the Client

    * .pot, DomotiGa3.gambas, FEventEditor.class, FEventEditor.form,
      FToolsSerialPorts.class, FTriggerEditor.class, FTriggerEditor.form: Fixed:
      Issue 313 - SmartMeter not listen in Tools -> Serial Port UsageChanged:
      Triggers has the same drop-down list as ActionsChanged: New events are
      enabled by defaultFixed: Some misallignment of text in the GUI

2013-08-15  alexie

    * DomotiGa3.gambas, DomotiGaServer3.gambas: Fixed: Revision 1310 was
      compiled against latest TRUNK, should have been 3.4.2

    * DomotiGa3.gambas, DomotiGaServer3.gambas, Thermostat.module: Fixed: Issue
      312 - String Compare wasn't updated to Gambas 3.x specific mode

2013-08-08  alexie

    * DomotiGa3.gambas, DomotiGaServer3.gambas, Thermostat.module: Rollback:
      1.0.007 is missing the column "secondary" in table
      "thermostat_schedule_entry", revert back to the previous version for now

2013-08-07  alexie

    * domotiga-empty.sql, domotiga.sql: Fixed: Issue 302 - domotiga*.sql: The
      default and example module settings are different

    * .pot, DomotiGa3.gambas, DomotiGaServer3.gambas, FSettingsEmail.class,
      FSettingsEmail.form, Mail.module, Main.module: Added: Feature 289 - SMTP
      authentication + SSL to Email

    * .pot, DomotiGa3.gambas, DomotiGaServer3.gambas, Main.module: Change: If
      automatic timezone is enabled, timezones with *:15, *:30 and *:45 are
      honored properly now

2013-08-06  alexie

    * .pot, DomotiGa3.gambas, DomotiGaServer3.gambas, FSettingsAstro.class,
      FSettingsAstro.form, FSettingsAstroLatLong.class,
      FSettingsAstroLatLong.form, FSettingsWeatherUG.class,
      FSettingsWeatherUG.form, WeatherUG.module: Added: Search
      latitude/longitude in Astro settingsChange: WeatherUnderground search of
      country/city, included auto-detect your location

2013-08-05  rdnzl

    * CXMLRPC.class: Save all mysql arguments correctly when updating
      thermostat.

    * FSettingsOpenTherm.class: Fixed saving of OpenTherm polltime setting.

    * FSettingsOpenTherm.class: Several OpenTherm fixes.Enable save button when
      Polltime changed.Save polltime settings to database.Fix fetching defaults
      crash.

2013-08-04  alexie

    * FSettingsAstroLatLong.class: Fixed: Missing class file in revision 1300

    * .pot, DomotiGa3.gambas, DomotiGaServer3.gambas, FEvents.class,
      FSettingsAstro.class, FSettingsAstro.form, FSettingsAstroLatLong.form,
      FSettingsNMA.class, FSettingsProwl.class, FSettingsPushover.class,
      Main.module: Fixed: Notifier settings weren't reloaded if the DomotiGa
      restart it via XML-RPC

2013-08-04  rdnzl

    * DomotiGa, DomotiGa.desktop, DomotiGa.gambas, DomotiGa3.desktop,
      DomotiGaServer, DomotiGaServer.desktop, DomotiGaServer.gambas,
      DomotiGaServer3.desktop, README, compile.sh, domotiga.debian,
      domotiga.fedora, fixlinks.sh, startserver.sh: Removed Gambas2 code, and
      changed scripts for Gambas3.Checkout revision 1296 if you need the last
      Gambas2 code, which is not supported anymore.

    * 10006to10007.sql: Fixed typo in table name.

    * 10006to10007.sql: Added drop commands for scenes and scenes_action table.

2013-08-04  alexie

    * DomotiGa3.gambas, DomotiGaServer3.gambas, NMA.module, Prowl.module,
      Pushover.module: Add: DomotiGa3/DomotiGaServer3 binaries compiled with
      3.4.2Fixed: Wrong prowl/nma/pushover modules in DomotiGaServer3

2013-08-04  rdnzl

    * P2000.module, WeatherUG.module: Added missing modules.

    * .lang, 10006to10007.sql, CRFXComTRX.class, CRFXComxPL.class,
      CSmartVISUServer.class, CTimerDelay.class, CVisonic.class,
      CWebSocket.class, CXMLRPC.class, Calendar.module, Devices.module,
      EventLoop.module, Events.module, FActionEditor.class,
      FActionScriptEditor.class, FDSC.class, FDebug.class, FDeviceEditor.class,
      FDeviceEditor.form, FDevices.class, FEditNewsWeather.class, FEvents.class,
      FMain.class, FMain.form, FNews.class, FPhone.class, FScheduleEditor.class,
      FScheduleEditor.form, FSettingsAsterisk.class, FSettingsBluetooth.class,
      FSettingsBwiredMap.form, FSettingsCTX35.class, FSettingsCUL.class,
      FSettingsCallerID.class, FSettingsCamVisca.class,
      FSettingsCurrentCost.class, FSettingsDSC.class, FSettingsDenon.class,
      FSettingsDigitemp.class, FSettingsDomotica.class, FSettingsEIB.class,
      FSettingsELVMAX.class, FSettingsEZcontrol.class, FSettingsEmail.class,
      FSettingsEmail.form, FSettingsFritzBox.class, FSettingsGLatitude.class,
      FSettingsGLatitude.form, FSettingsGMail.class, FSettingsGMail.form,
      FSettingsGPS.class, FSettingsGUI.class, FSettingsHDDTemp.class,
      FSettingsIPort.class, FSettingsIRMan.class, FSettingsIRTrans.class,
      FSettingsIViewer.class, FSettingsJeeLabs.class, FSettingsK8055.class,
      FSettingsLGTV.class, FSettingsLIRC.class, FSettingsMQTT.class,
      FSettingsMQTT.form, FSettingsMeteohub.class, FSettingsNcid.class,
      FSettingsOWFS.class, FSettingsOnkyo.class, FSettingsOww.class,
      FSettingsPLCBUS.class, FSettingsPVoutput.form, FSettingsPachube.form,
      FSettingsPing.class, FSettingsPioneer.class, FSettingsPlugwise.class,
      FSettingsPwrCtrl.class, FSettingsRFXComRX.class, FSettingsRFXComTRX.class,
      FSettingsRFXComxPL.class, FSettingsRRDTool.class, FSettingsRRDTool.form,
      FSettingsSMS.class, FSettingsServerStats.class, FSettingsServerStats.form,
      FSettingsSharpTV.class, FSettingsShell.class, FSettingsSmartMeter.class,
      FSettingsSmartVisuServer.class, FSettingsSmartVisuServer.form,
      FSettingsSound.class, FSettingsSound.form, FSettingsSqueezeServer.class,
      FSettingsTVGuide.class, FSettingsTVGuide.form,
      FSettingsTelnetServer.class, FSettingsTelnetServer.form,
      FSettingsTemp08.class, FSettingsTemp08.form, FSettingsThermostat.class,
      FSettingsThermostat.form, FSettingsTwitter.class, FSettingsTwitter.form,
      FSettingsUPS.class, FSettingsVideoServer.class, FSettingsVoiceText.class,
      FSettingsVoiceText.form, FSettingsWeatherBug.class,
      FSettingsWeatherBug.form, FSettingsWeatherUG.class,
      FSettingsWeatherUG.form, FSettingsWeeder.class, FSettingsXBMCxPL.class,
      FSettingsXMLRPC.form, FSettingsxPL.class, FSplashScreen.form,
      FThermostat.class, FToolsCULCmdr.class, FToolsPLCBUSCmdr.class,
      Main.module, NMA.module, P2000.module, PVoutput.module, Prowl.module,
      Pushover.module, ScreenFunc.module, Thermostat.module, WeatherUG.module,
      domotiga-empty.sql, domotiga.sql, fixlinks3.sh: New version 1.0.007, you
      must upgrade your database.Please make a backup of your database and
      DomotiGa directory tree first! notify services, thank Alex!Correctly
      spelled RFXCom Transceiver, oops.Corrected X10Security protocol for Mochad
      interface.Added initial support for SmartVISU's websocket. Example site
      and docs follow.Added very initial support for P2000 monitor fetching, xml
      parsing needs to be coded.Added initial WeatherUnderground support.Just
      saving data to globalvar or virtdevice needs to be done.Added major patch
      made by Francois, thanks!Here a list of his contribution:Changed XML-RPC
      method device.getstate so you can get all device values.Added new XML-RPC
      methods thermostat.getderogateheating and thermostat.setsecondary.Added
      optional second thermostat schedule for each heating point and
      scenario.Reroute client setdevice calls via XML-RPC.Hidden devices and
      disabled devices doesn't have the same behavior.Hiding a device only
      removes it from the GUI but it is still updated and can trigger
      events.Calibration works on empty values. (useful for virtual devices)You
      can now use macros and thermostats in Event action scripts.You can now
      toggle a devices state from devices list menu.Changed the contextual menu
      in device tabs to switch device state and hide/unhide.Added contextual
      menu in event/trigger/condition/action.Edit/delete/run/disable DomotiGa
      checks if the trigger/condition/action is not used before accepting the
      removal.A fix for setglobalvar.

2013-08-04  alexie

    * .pot, DomotiGa3.gambas, DomotiGaServer3.gambas, Events.module,
      FSettingsNMA.class, FSettingsProwl.class, FSettingsPushover.class,
      Main.module, NMA.module, Prowl.module, Pushover.module: Change: Split
      Prowl/NMA/Pushover message send and test into separate functionsChange:
      Automatic DST detection was always enabled in main routine

2013-08-03  alexie

    * .pot, Astro.module, CTimerDelay.class, DomotiGa3.gambas,
      DomotiGaServer3.gambas, FSettingsAstro.class, FSettingsAstro.form,
      Main.module, domotiga-empty.sql, domotiga.sql: Add: Feature 287 -
      Automatic timezone/daylight savings detection. Now DomotiGa can detect the
      timezone and dst without having to configure it. Automatic is the default
      for new installations.

2013-08-02  alexie

    * .pot, .project, CZWave.class, FSettingsZWave.class, Main.module: Fixed:
      Issue 307 - missing open-zwave library could crash/hang DomotiGa

2013-08-01  alexie

    * FSettingsNMA.class, FSettingsProwl.class, FSettingsPushover.class,
      NMA.module, Prowl.module, Pushover.module: Update: Made Prowl, NMA and
      Pushover https calls async (then they will not "hang" DomotiGa if the
      internet is unreliable)

2013-07-31  alexie

    * FSettingsPushover.class: Fixed: Pushover test API Token/User Key button
      should only be available if module is activated

2013-07-27  alexie

    * .pot, FSettingsNMA.class, FSettingsNMA.form, FSettingsProwl.class,
      FSettingsProwl.form, FSettingsPushover.class, FSettingsPushover.form:
      Fixed: Some minors issues with setting up of prowl, nma and pushover

    * .pot, CDSC.class, CHomeMatic.class, CKMTronicUDP.class, CVisonic.class,
      CXMLRPC.class, DomotiGa3.gambas, DomotiGaServer3.gambas, Events.module,
      FActionEditor.class, FActionEditor.form, FConditionEditor.class,
      FConstantEditor.class, FControl.class, FDeviceEditor.class, FEvents.class,
      FSettingsPVoutput.class, Main.module, Pushover.module, ScreenFunc.module,
      X10Cmd.module: *** Please upgrade to the latest Gambas 3.4.2 ***Add:
      Preliminary support (part 2) for Prowl, NMA and Pushover. It will be fully
      enabled in 1.0.007Change: Action Editor uses a drop down list instead of
      the tab (gives a better view)Change: DomotiGa3/DomotiGaServer3 compiled
      with the official Gambas 3.4.2Change: Removed some unused variables in the
      code

2013-07-26  alexie

    * Main.module, NMA.module, Prowl.module, Pushover.module: Fixed: Forgot to
      add DomotiGaServer3 files in revision 1284

    * .pot, FMain.class, FMain.form, FSettingsBwiredMap.form,
      FSettingsEmail.form, FSettingsGLatitude.form, FSettingsGMail.form,
      FSettingsMQTT.form, FSettingsNMA.class, FSettingsNMA.form,
      FSettingsPVoutput.form, FSettingsPachube.form, FSettingsProwl.class,
      FSettingsProwl.form, FSettingsPushover.class, FSettingsPushover.form,
      FSettingsRRDTool.form, FSettingsServerStats.form, FSettingsSound.form,
      FSettingsTVGuide.form, FSettingsTelnetServer.form, FSettingsTemp08.form,
      FSettingsThermostat.form, FSettingsTwitter.form, FSettingsVoiceText.form,
      FSettingsWeatherBug.form, FSettingsXMLRPC.form, Main.module, NMA.module,
      Prowl.module, Pushover.module, nma.png, prowl.png, pushover.png: Add:
      Preliminary support for Prowl, NMA and Pushover. It will be fully enabled
      in 1.0.007

2013-07-20  alexie

    * CVisonic.class: Update: Major Visonic module update. PowerLink is
      established, many new events added.

2013-07-19  alexie

    * CMochad.class, DomotiGa3.gambas, DomotiGaServer3.gambas: Fixed: Issue 304
      should now work fine (last revision didn't yet)

2013-07-18  alexie

    * CMochad.class, DomotiGa3.gambas, DomotiGaServer3.gambas: Fixed: Mochad
      issue 303 (first command failed) and 304 (commands not recognized)

2013-07-18  jessekerkhoven

    * Devices.module, DomotiGa3.gambas, DomotiGaServer3.gambas: Add set devices
      if different

2013-07-16  alexie

    * .project, CXMLRPC.class, DomotiGaServer3.gambas: Fixed: Sync'ed up
      revision 1278 into the DomotiGaServer3

    * .pot, .project, CXMLRPC.class, DomotiGa3.gambas: Fixed: If device values
      contain HTML code, \r or \n the DomotiGa webclients didn't work. This is
      workaround, the XML-RPC needs to be made safe for all values.

2013-07-14  alexie

    * .connection, .lang, .pot, .public, CWebServer.class, DomotiGa3.gambas,
      DomotiGaServer3.gambas, FMain.class, FMain.form, FSettingsMain.class,
      FSettingsMain.form, FSettingsWebServer.class, FSettingsWebServer.form,
      Main.module: Changed: Removed internal WebServer, because Apache/Lighttpd
      can do this much betterChanged: Remove Main/Loop Timer, default setting
      250msec is always good enough

    * DomotiGa3.gambas, Main.module: Fixed: Only do a XML-RPC if DomotiGa is
      running in client mode with SetGlobalVar

2013-07-11  alexie

    * FMain.form: Enhancement: Moved RRDTool from interfaces to modules menu

2013-07-09  alexie

    * domotiga-empty.sql, domotiga.sql: Fixed: KMTronicUDP was enabled by
      default (only new installations were affected)

    * 10005to10006.sql, domotiga-empty.sql: Fixed: problem with
      domotiga-empty.sql on version 1.0.006

2013-07-08  alexie

    * FSettingsMain.form: Fixed: Text missallignment issue in the Setup -> Main
      screen

2013-07-07  alexie

    * DomotiGa3.gambas, FScheduleEditor.class, FScheduleEditor.form: Tried to
      fix issue 255 - Thermostate graphic behavior

    * DomotiGa3.gambas, FDeviceEditor.class, FDeviceEditor.form, FMain.form,
      FSettingsZWave.form: Change: Split up the "Setup" menu into Setup, Modules
      and Interfaces. This should make the menu more readable.Fixed: Z-Wave
      Setup menu, some text was not readableFixed: Device Editor, the "Address"
      label was unreadable when adding a new device

2013-07-07  rdnzl

    * DomotiGa3.gambas, DomotiGaServer3.gambas: Made all serialport fields 128
      chars long so '/dev/serial/by-id/' names can be used.

    * CKMTronicUDP.class, DomotiGa3.gambas, DomotiGaServer3.gambas: Fixed
      symbolic link issue.

    * DomotiGa3.gambas, DomotiGaServer3.gambas: Updated binaries.

    * 10005to10006.sql, CDSC.class, CELVMAX.class, CKMTronicUDP.class,
      CPlugwise.class, CRFXComTX.class, Devices.module, DomotiGa3.desktop,
      DomotiGaServer3.desktop, DomotiGaServer3.gambas, Events.module,
      FActionEditor.class, FMain.class, FMain.form, FSettingsKMTronicUDP.class,
      FSettingsKMTronicUDP.form, FSettingsPVoutput.class,
      FSettingsPVoutput.form, FSettingsYouLess.class, Main.module,
      PVoutput.module, domotiga-empty.sql, domotiga.sql, fixlinks3.sh: New
      version 1.0.006, you must upgrade your database.Please make a backup of
      your database and DomotiGa directory tree first!Added support for Plugwise
      Switch, please test.Added support for KMTronicUDP relays boards like
      DINo.Small code cleanups.

2013-07-06  alexie

    * DomotiGa3.gambas, FCalendar.class: Fixed: Issue 291 - Edit -> Planning
      causes a crash

2013-07-03  alexie

    * DomotiGa3.gambas, DomotiGaServer3.gambas, Main.module,
      domotigaserver3.debian, domotigaserver3.fedora: Fixed: Issue 284 -
      DomotiGa would exit directly if the open-zwave configuration directory is
      missing.Added: Scripts to auto-start DomotiGaServer3 on Ubuntu/Debian and
      Fedora

2013-07-02  rdnzl

    * FSplashScreen.form: Align text.

    * DomotiGa3.desktop, DomotiGaServer3.desktop, Gambas3.desktop: Provide
      example desktop shortcuts.

2013-07-02  alexie

    * DomotiGaServer3.gambas, Main.module: Fixed: Main logfile wasn´t regularly
      flushed when DomotiGaServer3 runs in the background or as daemon

2013-07-02  jessekerkhoven

    * DomotiGa3.gambas, DomotiGaServer3.gambas, Events.module, fixlinks3.sh:
      Update json, more async

2013-07-01  jessekerkhoven

    * FActionEditor.class: Fix missing end

    * Events.module, FActionEditor.class, FActionEditor.form, FEvents.class: Add
      json input and output

2013-06-29  alexie

    * 10004to10005.sql: Fixed: Upgrade 1.0.004 to 1.0.005 for new Visonic table

    * CVisonic.class, DomotiGa3.gambas, DomotiGaServer3.gambas,
      FSettingsVisonic.class, FSettingsVisonic.form, domotiga-empty.sql,
      domotiga.sql: Fixed: numerous issues with Visonic. Also the module can
      display the RAW messages properly now

    * domotiga.sql: Fixed: Issue 296 - Can't install DomotiGa with the example
      database (SQL ERROR: 1064)

    * CSqueezeServer.class, FMusic.class: Enhancement: DomotiGa(Server) will not
      crash anymore, if the Music device(s) are unavailable

    * CVisonic.class, DomotiGaServer3.gambas, Main.module: Fixed: Issue 292 -
      DomotiGa 1.0.005 GUI gives warning connecting to DomotiGaServer3

2013-06-28  alexie

    * DomotiGa3.gambas, DomotiGaServer3.gambas, FSettingsXMLRPC.class,
      Main.module: Fixed: Issue 290 - Could not restart XMLRPC module when using
      Gambas3 TRUNK

2013-06-27  alexie

    * CDSC.class: Issue 116 - Update of the DSC Alarm System module

    * DomotiGa.gambas, DomotiGaServer.gambas, Main.module: Gambas2 -
      DomotiGa/DomotiGaServer didn't run anymore

2013-06-27  wwolkers

    * CVisonic.class: Visonic CRC check

    * 10004to10005.sql: And the missing file. Thanks Ron!

    * domotiga-empty.sql, domotiga.sql: And the database updates for people
      starting from scratch.

    * .project, CVisonic.class, DomotiGa.gambas, DomotiGa3.gambas,
      DomotiGaServer.gambas, DomotiGaServer3.gambas, FMain.class, FMain.form,
      FSettingsVisonic.class, FSettingsVisonic.form, FToolsSerialPorts.class,
      Main.module: Initial Visonic PowerMax/PowerMaster plugin commit, only
      displaying debugging codeRaised version to 1.0.5

2013-06-25  alexie

    * DomotiGa3.gambas, FSettingsAstro.class: Seasons settings in Astro/Location
      is checked for validity now

2013-06-23  alexie

    * DomoZWave.cpp: Fixed: Issue 257 - Qees device KVAh values could overwrite
      kWh values

    * FSettingsMySQL.class, FSettingsMySQL.form: Invalid Setup/Database
      configuration could hang DomotiGa. Now the configuration is checked and
      rejected if invalid

2013-06-22  alexie

    * .project: Fixed default ExecPath in DomotiGa3 project file

    * .pot, .project, DomotiGa3.gambas, FInstallDBWizard.class, FMain.class,
      FSplashScreen.class, Main.module: Rewrote the revision 1234 code and
      DomotiGa will give a proper error if it can't connect to MySQL (and exit
      in a good way)

2013-06-18  alexie

    * .project, FInstallDBWizard.class, FMain.class, FSplashScreen.class:
      Enhancement of the cancel/exit of DomotiGa database installation, now no
      errors/warnings are shown.

2013-06-09  rdnzl

    * DomotiGa3.gambas, DomotiGaServer3.gambas, PVoutput.module: Fixed error in
      time format.

    * 10003to10004.sql, CDomotica.class, CEZcontrol.class, CFritzBox.class,
      CMeteohub.class, CPwrCtrl.class, CTemp08.class, CVISCA.class,
      Devices.module, DomotiGa3.gambas, DomotiGaServer3.gambas, FMain.class,
      FMain.form, FSettingsPVoutput.class, FSettingsPVoutput.form,
      GLatitude.module, Main.module, PVoutput.module, X10Cmd.module,
      domotiga-empty.sql, domotiga.sql, omniksol-module.jpg: New version
      1.0.004, you must upgrade your database.Please make a backup of your
      database and DomotiGa directory tree first!Some device module code
      enhancements.Added support to publish data to PVoutput site, thanks
      Pieter!Fixed uptime date layout.Remove unused database fields.Added X10Sec
      protocol to Mochad interface.Added Omniksol database changes. (code
      follows)Code cleanups.

2013-05-28  rdnzl

    * CRFXComTX.class, DomotiGa3.gambas, DomotiGaServer3.gambas: Implemented
      RFXComTX command buffer and read event.

2013-05-26  rdnzl

    * Devices.module, DomotiGa3.gambas, DomotiGaServer3.gambas, X10Cmd.module,
      XMLClient.module: More async XMLRPC clientcalls.

2013-05-24  rdnzl

    * DomotiGa3.gambas, DomotiGaServer3.gambas: Updated binaries.

    * XMLClient.module: Made some more XMLRPC calls async.

2013-05-12  jessekerkhoven

    * device.php, locations.php: Update iphone client

    * DomotiGa3.gambas, X10Cmd.module: Fix X10CMD for domotiga3 see 1215

2013-05-07  rdnzl

    * fixlinks3.sh: Fixed script.

    * .info, .list, .project, .settings, DomotiGa3.gambas,
      DomotiGaServer3.gambas, JSON.module: Removed JSON module, using gb.web's
      now.

    * CXMLRPC.class, CYouLess.class, DomotiGa3.gambas, DomotiGaServer3.gambas,
      FHome.class, FSettingsX10Cmd.class, FSettingsX10Cmd.form,
      FSettingsYouLess.class, FSettingsYouLess.form, Main.module, X10Cmd.module:
      Removed Fetchurl setting for YouLess.Try to send boolean globalvars as
      strings via XMLRPC.Added X10Cmd cm15demo monitor code made by Jesse,
      thanks!Display weather city on Home page.

2013-05-03  rdnzl

    * DomotiGa3.gambas, DomotiGaServer3.gambas, FHome.class, XMLClient.module:
      Made FHome page code more async.

2013-04-26  rdnzl

    * DomotiGa3.gambas, DomotiGaServer3.gambas, XMLClient.module: Catch errors
      in getglobalvars rpc call.

    * DomotiGa3.gambas, DomotiGaServer3.gambas, FMain.class, XMLClient.module:
      Made serverversion check at startup async.

    * DomotiGa3.gambas, DomotiGaServer3.gambas, Main.module: Update globalvar
      Year at startup.

2013-04-25  rdnzl

    * README: More info about the config parameters.

2013-04-23  rdnzl

    * domotiga.png.org: Removed unused image.

    * README, add_device.php, add_event.php, add_graph.php, add_heating.php,
      add_meteo.php, add_tab.php, add_tile_devices.php, add_tile_events.php,
      add_tile_heatings.php, add_widget.php, barometer.png, bootstrap.css,
      camera.png, captures.png, climate.png, cloudy1.png, cloudy1night.png,
      cloudy2.png, cloudy2night.png, cloudy3.png, cloudy3night.png, cloudy4.png,
      cloudy4night.png, cloudy5.png, config.php.example, control.png, css,
      devices.php, devices.png, domotiga.png, domotiga.png.org, dunno.png,
      eceboxigc, eceboxigc.sql, ecelogo.png, email.png, empty.png, energy.png,
      events.php, events.png, favicon.png, filters.php, floorplan.png, fog.png,
      fognight.png, footer.php, functions.php, general.js, graphs.php,
      graphs.png, hail.png, header.php, heatings.php, home.php, home.png,
      htaccess.example, hvac.png, hydrology.png, img, img_meteo, inc, index.php,
      init.php, jquery-1.8.3.js, jquery-ui-1.9.2.js, jquery-ui.css, lib,
      lightrain.png, location.php, locations.png, logs.png, mist.png,
      mistnight.png, modify_location.php, modify_tab.php, modify_widget.php,
      music.png, network.png, news.png, overcast.png, phone.png, playicon.png,
      remove_location.php, remove_tab.php, remove_widget.php, repeat.png,
      security.png, set_device.php, set_eventstate.php,
      set_thermostatscenario.php, shower1.png, shower1night.png, shower2.png,
      shower2night.png, shower3.png, sidebar.php, sidebarfilter.php, sleet.png,
      snow1.png, snow1night.png, snow2.png, snow2night.png, snow3.png,
      snow3night.png, snow4.png, snow5.png, stock.png, storm1.png,
      storm1night.png, storm2.png, storm2night.png, storm3.png, sun.png,
      sunny.png, sunnynight.png, system.png, tabs, tabs.php, tag.png,
      template.css, thermostat.png, tiles, tvguide.png, weather.php,
      weather.png, wind.png, wrench.png, www: Added ECEBoxIGC webclient made by
      students from ece.fr.Thanks guys!

    * CXMLRPC.class, DomotiGa3.gambas, DomotiGaServer3.gambas, RRDTool.module,
      XMLClient.module: Added XMLRPC V0.17 with new methods for upcoming
      webclient.

    * Bluetooth.module, CHomeMatic.class, CK8055.class, CRFXComTRX.class,
      Devices.module, Digitemp.module, DomotiGa3.gambas, DomotiGaServer3.gambas,
      GLatitude.module, Shell.module: Catch Exec errors when command is missing
      in several modules.Code cleanups.Suppress Google Latitude errors when
      debug is not enabled.Toggle Dimmed devices to Off.

2013-04-18  rdnzl

    * DomotiGa3.gambas, DomotiGaServer3.gambas, FDeviceEditor.form, Main.module:
      Fixed event trigger on new minute.Fixed option text length in device
      editor.

2013-04-14  rdnzl

    * DomotiGa3.gambas, DomotiGaServer3.gambas, FToolsRFXComCmdr.class: Disable
      RFXComTRX Commander send buttons in client mode.

    * DomotiGa3.gambas, DomotiGaServer3.gambas, VoiceText.module: Don't log
      VoiceText error's when debug is disabled.

    * CSmartMeter.class, DomotiGa3.gambas, DomotiGaServer3.gambas: Fixed
      SmartMeter parse error on 0-0:96.1.0 records.Added working TCP connect
      code to SmartMeter module.

    * DomotiGa3.gambas, DomotiGaServer3.gambas: Updated binaries.

    * CCTX35.class, CGPS.class, CIRMan.class, CIRTrans.class, CItems.class,
      CLIRC.class, COWW.class, CRFXComxPL.class, CSMS.class, CXMLRPC.class,
      Digitemp.module, FDevices.class, FEditGraphs.class,
      FEditPachubeDevices.class, FEvents.class, FMain.form, FSelectImage.class,
      FSettingsPlugwise.form, FSettingsXMLRPC.class, FSplashScreen.class,
      FTVGuide.class, FTVGuideChannelDetail.class, FThermostat.class,
      FToolsDatabaseAdmin.class, FToolsSerialMon.class, HDDTemp.module,
      Main.module, TemperaturNu.module, Twitter.module, XMLClient.module,
      XMLParser.module, fixlinks.sh, fixlinks3.sh: Better pwd detection for
      fixlink.sh scripts.Made GetGlobalVars async XMLRPC call.Less waiting when
      starting GUI to prevent issues.Code cleanups.

    * DomotiGa3.gambas, DomotiGaServer3.gambas: Updated binaries.

    * FEditBwiredDevices.class, FFloorplanEditor.class, FLogfiles.class,
      FMain.class, FMain.form, FSettingsBwiredMap.class, FSettingsPachube.class,
      TemperaturNu.module: Fixed layout of main status bar.Code cleanups.

    * FFloorplans.class: Display calibrated device values on floorplans.

    * FEditPachubeDevices.form: Sort Pachube device select list.

    * Devices.module: Devices.GetCurrentValueForDevice now returns calibrated
      values (for Pachube etc)

    * Energy.module: Suppress Energy debug output when debug is disabled.

    * DomotiGa3.gambas, DomotiGaServer3.gambas: Updates binaries.

    * FSplashScreen.class, Main.module: Update Dark, Sunset and other time
      related globalvars at startup.

    * CMochad.class: Made Mochad code work again, but needs testing, added
      support for x10sec RF, needs db change though.When reporting issues
      include log output.

2013-04-13  rdnzl

    * Shell.module: Catch error when Shell command is missing.

2013-04-12  rdnzl

    * config.php.example: Added location parameter to config example.

2013-04-06  rdnzl

    * CMochad.class, DomotiGa3.gambas, DomotiGaServer3.gambas: Better error
      catching in Mochad code, started to add RF decoding.

2013-04-02  rdnzl

    * DomotiGa3.gambas, DomotiGaServer3.gambas, FDeviceEditor.class: Check for
      valid DS names [a-zA-Z0-9_] upon saving device.

2013-03-31  rdnzl

    * DomotiGa3.gambas, DomotiGaServer3.gambas, FDeviceEditor.class: Use X10
      address selecttor for AB400 devices.

2013-03-30  mstranger

    * AndroidManifest.xml, MainActivity.java, XMLRPC.java, XMLRPCClientSSH.java,
      classes.dex, domotigapp.apk, jarlist.cache, res, resources.ap_: Simple
      User Level-Error Message for ssh and xml connection

2013-03-30  rdnzl

    * DomotiGa3.gambas, DomotiGaServer3.gambas, FDeviceEditor.form: Restored
      deviceeditor buttons.

    * Bluetooth.module, Bwired.module, CCUL.class, CDSC.class, CDenon.class,
      CELVMAX.class, CHomeMatic.class, CIPort.class, CIViewer.class,
      CJeeLabs.class, CK8055.class, CLEDMatrix.class, CLGTV.class, CMQTT.class,
      CNcid.class, COWFS.class, COnkyo.class, COpenTherm.class, CPioneer.class,
      CPlugwise.class, CRFXComRX.class, CRFXComTRX.class, CRFXComTX.class,
      CSharpTV.class, CSmartMeter.class, CSqueezeServer.class,
      CTelnetServer.class, CWebServer.class, CWeeder.class, CXBMCxPL.class,
      CYouLess.class, CallerID.module, CxPL.class, Devices.module,
      DomotiGa.gambas, DomotiGa3.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, Energy.module, Events.module, FActionEditor.class,
      FActionScriptEditor.class, FBarcodes.class, FCamera.class,
      FCaptures.class, FConditionEditor.class, FDeviceEditor.form,
      FDevices.class, FEditCameraDevices.class,
      FEditEventThermostatProfiles.class, FEditMacro.class,
      FEditTVChannelsDetail.class, FEditUsers.class, FEventEditor.class,
      FEventThermostat.class, FEvents.class, FFloorplans.class,
      FHeatingEditor.class, FHome.class, FLocations.class, FMain.class,
      FMusic.class, FScheduleEditor.class, FSelectDate.class,
      FSelectImage.class, FServerStats.class, FSettingsHome.class,
      FSettingsPlugwise.form, FSettingsTemperaturNu.class, FSettingsZWave.class,
      FTVGuideSearchDetail.class, FThermostat.class, FToolsDatabaseAdmin.class,
      FToolsHomeMaticQuickSet.class, FToolsRFXComCmdr.class,
      FToolsZWaveCmdr.class, FTriggerEditor.class, FWeather.class,
      GLatitude.module, JSON.module, Mail.module, Main.module, Pachube.module,
      Ping.module, RRDTool.module, ScreenFunc.module, ServerStats.module,
      Shell.module, TVGuide.module, Twitter.module, VideoServer.module,
      VoiceText.module, XMLClient.module: Code cleanups, unused variables and
      functions removed.Bwired correctly show http headers in debug log.Renamed
      local variables who had same name as global ones.Added support for more
      than one YouLess device, you have to specify the ip address as device
      address now.Made Plugwise settings form non-resizable.Correctly parse
      Pachube/COSM HTTP result status.Catch missing gnome-notify command.

2013-03-25  mstranger

    * .classpath, AboutActivity.java, Adler32.java, Buffer.class, CRC32.java,
      Channel$1.class, Channel$MyPipedInputStream.class,
      Channel$PassiveInputStream.class, Channel$PassiveOutputStream.class,
      Channel.class, ChannelAgentForwarding.class, ChannelDirectTCPIP.class,
      ChannelExec.class, ChannelForwardedTCPIP.class, ChannelSession.class,
      ChannelSftp$1.class, ChannelSftp$2.class, ChannelSftp$3.class,
      ChannelSftp$Header.class, ChannelSftp$LsEntry.class,
      ChannelSftp$LsEntrySelector.class,
      ChannelSftp$RequestQueue$OutOfOrderException.class,
      ChannelSftp$RequestQueue$Request.class, ChannelSftp$RequestQueue.class,
      ChannelSftp.class, ChannelShell.class, ChannelSubsystem.class,
      ChannelX11.class, Checksum.java, Cipher.class, CipherNone.class,
      Compression.class, DH.class, DHG1.class, DHG14.class, DHGEX.class,
      Deflate.java, Deflater.java, DeflaterOutputStream.java,
      DeviceListActivity.java, ForwardedTCPIPDaemon.class, GSSContext.class,
      GZIPException.java, GZIPHeader.java, GZIPInputStream.java,
      GZIPOutputStream.java, HASH.class, HostKey.class, HostKeyRepository.class,
      IO.class, Identity.class, IdentityFile.class, IdentityRepository.class,
      ImageActivity.java, InfBlocks.java, InfCodes.java, InfTree.java,
      Inflate.java, Inflater.java, InflaterInputStream.java, JSch$1.class,
      JSch.class, JSchAuthCancelException.class, JSchException.class,
      JSchPartialAuthException.class, JZlib.java, KeyExchange.class,
      KeyPair.class, KeyPairDSA.class, KeyPairGenDSA.class, KeyPairGenRSA.class,
      KeyPairRSA.class, KnownHosts$HashedHostKey.class, KnownHosts.class,
      LocalIdentityRepository.class, Logger.class, MAC.class, MainActivity.java,
      Packet.class, ParameterActivity.java, PortWatcher.class, Proxy.class,
      ProxyHTTP.class, ProxySOCKS4.class, ProxySOCKS5.class, Random.class,
      Request.class, RequestAgentForwarding.class, RequestEnv.class,
      RequestExec.class, RequestPtyReq.class, RequestSftp.class,
      RequestShell.class, RequestSignal.class, RequestSubsystem.class,
      RequestWindowChange.class, RequestX11.class, SSHTUNNEL.java,
      ServerSocketFactory.class, Session$1.class,
      Session$GlobalRequestReply.class, Session.class, Settings.java,
      SftpATTRS.class, SftpException.class, SftpProgressMonitor.class,
      Signature.class, SignatureDSA.class, SignatureRSA.class,
      SocketFactory.class, StaticTree.java, Tree.java,
      UIKeyboardInteractive.class, UserAuth.class, UserAuthGSSAPIWithMIC.class,
      UserAuthKeyboardInteractive.class, UserAuthNone.class,
      UserAuthPassword.class, UserAuthPublicKey.class, UserInfo.class,
      Util$1.class, Util.class, XMLRPC.java, XMLRPCClientSSH.java,
      ZInputStream.java, ZOutputStream.java, ZStream.java,
      ZStreamException.java, devices_list.xml, drawable-xhdpi, jcraft, jsch,
      jsch-0.1.49.jar, jzlib, libs, mainscreen.xml, org.eclipse.jdt.core.prefs,
      parameters.xml, project.properties, string.xml, strings.xml: preliminary
      SSH tunnel add

2013-03-24  wwolkers

    * CXMLRPC.class, Devices.module, DomotiGa.gambas, DomotiGa3.gambas,
      DomotiGaServer.gambas, DomotiGaServer3.gambas: Update to fix Feature
      request 259

2013-03-19  rdnzl

    * CRFXComRX.class, DomotiGa.gambas, DomotiGa3.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: Parse HE device group commands for RFXComRX.

    * FHome.class: Fixed inside sensor and added debug info.

    * DomotiGa3.gambas, DomotiGaServer3.gambas, FSettingsPlugwise.form: Made
      windowsize fixed.

    * CMQTT.class, CMochad.class, COpenTherm.class, CPLCBUS.class,
      DomotiGa.gambas, DomotiGa3.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, Events.module, GLatitude.module, fixlinks.sh,
      fixlinks3.sh: Synced with dev machine.

    * DomotiGa3.gambas, DomotiGaServer3.gambas, GLatitude.module: Removed debug
      line.

    * DomotiGa3.gambas, DomotiGaServer3.gambas, GLatitude.module: More Latitude
      fixes.

    * DomotiGa3.gambas, DomotiGaServer3.gambas, GLatitude.module: Fixed parsing
      new Google's ReverseGeo API, fixed async fetching.

    * DomotiGa3.gambas, DomotiGaServer3.gambas, FHome.class: Fixed hangs of
      HomeScreen, added more debug info.

2013-03-18  alexie

    * DomotiGa.gambas, DomotiGa3.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, GLatitude.module: Fixed: Try to fix issue #262,
      using a new Google Latitude URL/API

2013-03-14  rdnzl

    * Sounds.module: Don't wait on played sound, it may hang startup.

2013-03-13  rdnzl

    * DomotiGa.gambas, DomotiGa3.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: Updated binaries.

2013-03-12  rdnzl

    * CXMLRPC.class, FHome.class: Rename new xmlrpc method to lowercase.Fixed
      crash in Home screen.

2013-03-12  wwolkers

    * .connection, CXMLRPC.class, Devices.module, DomotiGa.gambas,
      DomotiGa3.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Implement
      feature request 259

2013-03-11  rdnzl

    * DomotiGa3.gambas, DomotiGaServer3.gambas: Updated Gambas3 binaries.

    * CRFXComTRX.class, X10Cmd.module: More X10Cmd error catching.Added
      RFXComTRX command buffer and better X10 security parsing.

2013-03-11  alexie

    * X10Cmd.module: Fixed: Try to fix stop of X10Cmd problem in
      DomotiGaServer3.gambas

2013-03-10  rdnzl

    * CRFXComTRX.class, DomotiGa3.gambas, DomotiGaServer3.gambas: Added Dim and
      Bright to Lighting1 transmit code.

2013-03-09  rdnzl

    * Astro.module, Bluetooth.module, CMQTT.class, CNcid.class,
      COpenTherm.class, CRFXComTRX.class, Devices.module, DomotiGa3.gambas,
      DomotiGaServer3.gambas, FConditionEditor.class, Pachube.module,
      compile.sh: Few code cleanups.Added publish code to MQTT class.Added
      command buffer to RFXcomTRX.Fixed parsing of some x10 security devices in
      RFXcomTRX.

2013-03-04  rdnzl

    * DomotiGa3.gambas, DomotiGaServer3.gambas, FToolsZWaveCmdr.class: Fixed
      combolist syntax error in ZWave commander.

    * CYouLess.class, DomotiGa.gambas, DomotiGa3.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: Removed requirement in YouLess code to have
      connection to Bidgely site.

2013-03-01  rdnzl

    * CMochad.class, DomotiGa.gambas, DomotiGa3.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: Fixed wrong Mochad interface name.

    * CCurrentCost.class, DomotiGa.gambas, DomotiGa3.gambas,
      DomotiGaServer.gambas, DomotiGaServer3.gambas: Read temperature from EnviR
      devices.

2013-02-28  alexie

    * FSettingsPlugwise.form: Fixed: Plugwise settings in DomotiGa3 didn't work

2013-02-27  rdnzl

    * CHomeMatic.class, DomotiGa.gambas, DomotiGa3.gambas,
      DomotiGaServer.gambas, DomotiGaServer3.gambas: Fixed double autocreate for
      HomeMatic devices, added more debug for serial no.

2013-02-26  rdnzl

    * CHomeMatic.class, DomotiGa.gambas, DomotiGa3.gambas,
      DomotiGaServer.gambas, DomotiGaServer3.gambas: Fixed another bug for
      HomeMatic pairing.

    * CHomeMatic.class, DomotiGa.gambas, DomotiGa3.gambas,
      DomotiGaServer.gambas, DomotiGaServer3.gambas: Fixed auto creation of
      paired HomeMatic devices.

2013-02-22  rdnzl

    * COpenTherm.class, DomotiGa.gambas, DomotiGa3.gambas,
      DomotiGaServer.gambas, DomotiGaServer3.gambas, Events.module: Fixed event
      condition check for DomotiGa3.Fixed OpenTherm startup code.

2013-02-18  rdnzl

    * DomotiGa.gambas, DomotiGa3.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, Main.module: Fixed time of day code.

    * DomotiGa.gambas, DomotiGa3.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, Main.module: Changed ip and broadcast address
      dectection code.

2013-02-17  rdnzl

    * 10002to10003.sql: Fixed upgrade script hopefully.

    * #project.pot, AVControl.pot, Astro.pot, Bluetooth.pot, Bwired.pot,
      CAsterisk.pot, CCTX35.pot, CCUL.pot, CCurrentCost.pot, CDSC.pot,
      CDenon.pot, CDomotica.pot, CEIB.pot, CELVMAX.pot, CEZcontrol.pot,
      CFritzBox.pot, CGPS.pot, CHomeMatic.pot, CIPort.pot, CIRMan.pot,
      CIRTrans.pot, CIViewer.pot, CItems.pot, CJeeLabs.pot, CK8055.pot,
      CLEDMatrix.pot, CLGTV.pot, CLIRC.pot, CMQTT.pot, CMeteohub.pot, CNcid.pot,
      COWFS.pot, COWW.pot, COnkyo.pot, COpenTherm.pot, CPLCBUS.pot,
      CPioneer.pot, CPlugwise.pot, CPwrCtrl.pot, CRFXComRX.pot, CRFXComTRX.pot,
      CRFXComTX.pot, CRFXComxPL.pot, CSMS.pot, CSharpTV.pot, CSmartMeter.pot,
      CSqueezeServer.pot, CTelnetServer.pot, CTemp08.pot, CTimerDelay.pot,
      CTimerOnOff.pot, CUPS.pot, CVISCA.pot, CWebServer.pot, CWeeder.pot,
      CXBMCxPL.pot, CXMLRPC.pot, CYouLess.pot, CZWave.pot, Calendar.pot,
      CallerID.pot, CxPL.pot, CxPLMsg.pot, DNS.pot, Devices.pot, Digitemp.pot,
      Energy.pot, EventLoop.pot, Events.pot, FAbout.pot, FActionEditor.pot,
      FActionScriptEditor.pot, FBarcodes.pot, FCalendar.pot, FCamera.pot,
      FCaptures.pot, FClimate.pot, FConditionEditor.pot, FConstantEditor.pot,
      FControl.pot, FDSC.pot, FDebug.pot, FDeviceEditor.pot, FDevices.pot,
      FEditBwiredDevices.pot, FEditCameraDevices.pot, FEditCategories.pot,
      FEditContacts.pot, FEditDictionary.pot, FEditDictionaryDetail.pot,
      FEditEventThermostatProfiles.pot, FEditGlobalVars.pot, FEditGraphs.pot,
      FEditMacro.pot, FEditMarkers.pot, FEditMenus.pot, FEditModulesGroups.pot,
      FEditNewsWeather.pot, FEditNotify.pot, FEditPachubeDevices.pot,
      FEditTVChannels.pot, FEditTVChannelsDetail.pot,
      FEditTVProgramCategories.pot, FEditTVProgramCategoriesDetail.pot,
      FEditUsers.pot, FEmail.pot, FEnergy.pot, FEventEditor.pot,
      FEventThermostat.pot, FEvents.pot, FFloorplanEditor.pot, FFloorplans.pot,
      FGraphsPreview.pot, FHVAC.pot, FHeatingEditor.pot, FHome.pot,
      FInstallDBWizard.pot, FLocations.pot, FLogfiles.pot, FMain.pot,
      FMusic.pot, FNetwork.pot, FNews.pot, FPhone.pot, FScenarioEditor.pot,
      FScheduleEditor.pot, FSecurity.pot, FSelectDate.pot, FSelectImage.pot,
      FServerStats.pot, FSettingsAsterisk.pot, FSettingsAstro.pot,
      FSettingsBluetooth.pot, FSettingsBwiredMap.pot, FSettingsCTX35.pot,
      FSettingsCUL.pot, FSettingsCallerID.pot, FSettingsCamVisca.pot,
      FSettingsCameras.pot, FSettingsCurrentCost.pot, FSettingsDSC.pot,
      FSettingsDenon.pot, FSettingsDigitemp.pot, FSettingsDomotica.pot,
      FSettingsEIB.pot, FSettingsELVMAX.pot, FSettingsEZcontrol.pot,
      FSettingsEmail.pot, FSettingsFritzBox.pot, FSettingsGLatitude.pot,
      FSettingsGMail.pot, FSettingsGPS.pot, FSettingsGUI.pot,
      FSettingsHDDTemp.pot, FSettingsHome.pot, FSettingsHomeMatic.pot,
      FSettingsIPort.pot, FSettingsIRMan.pot, FSettingsIRTrans.pot,
      FSettingsIViewer.pot, FSettingsJeeLabs.pot, FSettingsK8055.pot,
      FSettingsLEDMatrix.pot, FSettingsLGTV.pot, FSettingsLIRC.pot,
      FSettingsMQTT.pot, FSettingsMain.pot, FSettingsMeteohub.pot,
      FSettingsMySQL.pot, FSettingsNcid.pot, FSettingsOWFS.pot,
      FSettingsOnkyo.pot, FSettingsOpenTherm.pot, FSettingsOww.pot,
      FSettingsPLCBUS.pot, FSettingsPachube.pot, FSettingsPing.pot,
      FSettingsPioneer.pot, FSettingsPlugwise.pot, FSettingsPwrCtrl.pot,
      FSettingsRFXComRX.pot, FSettingsRFXComTRX.pot, FSettingsRFXComTX.pot,
      FSettingsRFXComxPL.pot, FSettingsRRDTool.pot, FSettingsSMS.pot,
      FSettingsServerStats.pot, FSettingsSharpTV.pot, FSettingsShell.pot,
      FSettingsSmartMeter.pot, FSettingsSound.pot, FSettingsSqueezeServer.pot,
      FSettingsTVGuide.pot, FSettingsTelnetServer.pot, FSettingsTemp08.pot,
      FSettingsTemperaturNu.pot, FSettingsThermostat.pot, FSettingsTwitter.pot,
      FSettingsUPS.pot, FSettingsVideoServer.pot, FSettingsVoiceText.pot,
      FSettingsWeatherBug.pot, FSettingsWebServer.pot, FSettingsWeeder.pot,
      FSettingsX10Cmd.pot, FSettingsXBMCxPL.pot, FSettingsXMLRPC.pot,
      FSettingsYouLess.pot, FSettingsZWave.pot, FSettingsxPL.pot,
      FSplashScreen.pot, FTVGuide.pot, FTVGuideChannelDetail.pot,
      FTVGuideProgramDetail.pot, FTVGuideSearchDetail.pot, FTextViewer.pot,
      FThermostat.pot, FToolsBluetoothBrowser.pot, FToolsCULCmdr.pot,
      FToolsDatabaseAdmin.pot, FToolsHomeMaticQuickSet.pot,
      FToolsPLCBUSCmdr.pot, FToolsRFXComCmdr.pot, FToolsSerialMon.pot,
      FToolsSerialPorts.pot, FToolsX10Cmdr.pot, FToolsZWaveCmdr.pot,
      FTriggerEditor.pot, FWeather.pot, GLatitude.pot, HDDTemp.pot, JSON.pot,
      Mail.pot, Main.pot, Pachube.pot, Ping.pot, RRDTool.pot, ScreenFunc.pot,
      ServerStats.pot, Shell.pot, Sounds.pot, TVGuide.pot, TemperaturNu.pot,
      Thermostat.pot, Twitter.pot, VideoServer.pot, VoiceText.pot, X10Cmd.pot,
      XMLClient.pot, XMLParser.pot: Removed compiled language files.

2013-02-16  rdnzl

    * .project, 10002to10003.sql, CEIB.class, CHomeMatic.class,
      CLEDMatrix.class, CMochad.class, COpenTherm.class, CPlugwise.class,
      CUPS.class, CXMLRPC.class, Devices.module, DomotiGa.gambas,
      DomotiGa3.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas,
      EventLoop.module, Events.module, FControl.class, FEditMenus.class,
      FLocations.class, FLogfiles.form, FMain.class, FMain.form,
      FSettingsMochad.class, FSettingsMochad.form, FSettingsOpenTherm.class,
      FSettingsOpenTherm.form, FSettingsPlugwise.class, FSettingsPlugwise.form,
      FSplashScreen.class, FThermostat.class, FToolsX10Cmdr.class, Main.module,
      Thermostat.module, XMLClient.module, domotiga-empty.sql, domotiga.sql,
      mochad.png: New version 1.0.003, you must upgrade your database.Please
      make a backup of your database and DomotiGa directory tree first!Fixed
      HomeMatic auto device create code.Extended OpenTherm database settings and
      updated code from forum, thanks Frank (BreFra)!Updated Plugwise code from
      forum, it's much faster now, and stores calibration data.Removed unused
      firmware database field.Added basic X10 support for Mochad a TCP gateway
      daemon for CM15A/CM19A, thanks Roland!Fixed auto create devices for
      LightwaveRF.Fixed Meiantech auto device create code.Optimized device
      location queries.Removed UseOpenZwave database field.Bug fixes and code by
      Francois (hplus):Fixed bug in UPS module while searching address.Added
      thermostat.getderogateheating method to XMLRPC module.Fetch
      derogateheating at startup.Catch error when new device is used in
      thermostat.Broadcast globalvar changes done by event actions.Changed event
      formula parsing to prevent Conditions return "No Return Value".Added
      BroadCastUDPClient error catch code.Rewrote SetGlobalVars code.Fixed
      repeatstate and resetvalue bugs in Device module.

2013-02-14  alexie

    * DomoZWave.cpp.r582: Remove: DomoZWave wrapper for open-zwave r582, this is
      extremely old

    * CZWave.class, DomoZWave.cpp, DomoZWave.h, DomotiGa.gambas,
      DomotiGa3.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas,
      FToolsZWaveCmdr.class, FToolsZWaveCmdr.form: Added: Support for open-zwave
      r640 (please upgrade to the latest version of the open-zwave
      library)Added: Z-Wave Commander GUI rewritten, configuration is more
      flexible, group associations are visible and usercode (e.g. Tag Readers)
      are supported now. NOTE: This will only be supported in DomotiGa3NOTE:
      Please recompile your open-zwave as described in the following
      link:http://www.domotiga.nl/projects/domotiga/wiki/Z-Wave#updaterecompile-open-zwave-andor-wrapper

2013-02-12  alexie

    * compile.sh: Fixed: compile.sh didn't work properly for DomotiGa3.gambas

    * DomotiGa3.gambas: Fixed: DomotiGa3.gambas didn't run/start

2013-02-09  alexie

    * FEditGlobalVars.class: Enhanced: Table edit of last row of GlobalVars
      works better now

2013-02-07  rdnzl

    * DomotiGa3.gambas, DomotiGaServer3.gambas: Updated binaries.

    * CEIB.class: Fixed reading KNX data from network socket.

2013-02-05  alexie

    * CRFXComRX.class, CRFXComTRX.class: Fixed: RFXCom values were padded with
      spaces in DomotiGa3/DomotiGaServer3

2013-02-03  alexie

    * CXMLRPC.class: Fixed: WebGUI didn't show the proper location (issue #249)

2013-02-02  alexie

    * .connection, Devices.module, DomotiGa.gambas, DomotiGa3.gambas,
      DomotiGaServer.gambas, DomotiGaServer3.gambas: Fixed: Couldn't replace 0
      or 1 with calibration (issue #241)

2013-02-01  wwolkers

    * .connection, FSettingsDenon.form: Add 9600 baud for Denon interface

2013-01-31  alexie

    * DomotiGa.gambas, DomotiGa3.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, EventLoop.module: Changed: Remove auto-mode,
      plants audio and goodmorning prompt (was hardcoded)

2013-01-26  alexie

    * DomotiGa.gambas, DomotiGa3.gambas, FSettingsGPS.form, FSettingsSMS.form,
      FToolsSerialMon.form: Fixed: DomotiGa r1130 couldn't be compiledAdd: 57600
      and 115200 baud rates for SerialMonitor and GPS

2013-01-26  wwolkers

    * .connection, FSettingsSMS.form: Adjusted serial speed to 115200, which is
      standard

2013-01-26  alexie

    * FSettingsSMS.form: Added: SMS Server baudrate 11500

2013-01-24  alexie

    * DomoZWave.cpp: Added: DomoZWave wrapper support open-zwave r635 and up

2013-01-23  alexie

    * DomotiGa3.gambas, FBarcodes.form, FCamera.form, FCaptures.form,
      FEditCameraDevices.form, FScenarioEditor.form, FSettingsAsterisk.form,
      FToolsBluetoothBrowser.form: Fixed: Gambas v2 to v3 automatic conversion
      screwed the textbox allignment (part 5)

2013-01-22  alexie

    * FDeviceEditor.class, FDeviceEditor.form: Fixed: Some minor issues in
      Device Editor and DomotiGa3 (gambas3)

2013-01-22  rdnzl

    * FSettingsRFXComTX.class: Adapted sql parameters to Gambas3 syntax.

2013-01-21  alexie

    * DomotiGa3.gambas, FEditCameraDevices.class, FEditGraphs.class,
      FHeatingEditor.class, FSettingsAstro.class, FSettingsBwiredMap.class,
      FSettingsRFXComRX.class, FSettingsRFXComTX.class,
      FSettingsSmartMeter.class, FSettingsVideoServer.class,
      FSettingsZWave.class: Fixed: gambas2 to gambas3 conversion errors with SQL
      commands

    * FSettingsRFXComTRX.class: Fixed: RFXComTRX settings didn't work properly
      in DomotiGa3

2013-01-20  alexie

    * FSettingsAstro.form, FSettingsBluetooth.form, FSettingsBwiredMap.form,
      FSettingsCamVisca.form, FSettingsDigitemp.form, FSettingsDomotica.form,
      FSettingsEIB.form, FSettingsEmail.form: Fixed: Gambas v2 to v3 automatic
      conversion screwed the textbox allignment (part 4)

    * FSplashScreen.class, FSplashScreen.form: Fixed: Gambas v2 to v3 automatic
      conversion screwed the textbox allignment (part 3)

    * FSettingsEZcontrol.form, FSettingsFritzBox.form, FSettingsGLatitude.form,
      FSettingsGPS.form, FSettingsHDDTemp.form, FSettingsIPort.form,
      FSettingsIRMan.form, FSettingsIRTrans.form, FSettingsIViewer.form,
      FSettingsJeeLabs.form, FSettingsK8055.form, FSettingsLEDMatrix.form,
      FSettingsLGTV.form, FSettingsLIRC.form, FSettingsMQTT.form,
      FSettingsMain.form, FSettingsMeteohub.form, FSettingsNcid.form,
      FSettingsOWFS.form, FSettingsOnkyo.form, FSettingsOpenTherm.form,
      FSettingsOww.form, FSettingsPLCBUS.form, FSettingsPachube.form,
      FSettingsPlugwise.form, FSettingsPwrCtrl.form, FSettingsSMS.form,
      FSettingsServerStats.form, FSettingsSharpTV.form, FSettingsShell.form,
      FSettingsSmartMeter.form, FSettingsSound.form,
      FSettingsSqueezeServer.form, FSettingsTVGuide.form,
      FSettingsTelnetServer.form, FSettingsTemp08.form,
      FSettingsTemperaturNu.form, FSettingsThermostat.form,
      FSettingsTwitter.form, FSettingsUPS.form, FSettingsVideoServer.form,
      FSettingsVoiceText.form, FSettingsWeatherBug.form,
      FSettingsWebServer.form, FSettingsWeeder.form, FSettingsX10Cmd.form,
      FSettingsXBMCxPL.form, FSettingsXMLRPC.form, FSettingsYouLess.form,
      FSettingsxPL.form, FToolsSerialMon.form, FToolsSerialPorts.form,
      FToolsX10Cmdr.form, FTriggerEditor.form: Fixed: Gambas v2 to v3 automatic
      conversion screwed the textbox allignment (part 2)

    * DomotiGa3.gambas, FAbout.form, FActionEditor.form,
      FActionScriptEditor.form, FBarcodes.form, FCalendar.form, FCamera.form,
      FCaptures.form, FClimate.form, FConditionEditor.form,
      FConstantEditor.form, FDeviceEditor.form, FDevices.form,
      FEditBwiredDevices.form, FEditCameraDevices.form, FEditCategories.form,
      FEditContacts.form, FEditGlobalVars.form, FEditGraphs.form,
      FEditMacro.form, FEditMarkers.form, FEditMenus.form,
      FEditModulesGroups.form, FEditNewsWeather.form, FEditNotify.form,
      FEditPachubeDevices.form, FEditUsers.form, FEnergy.form,
      FEventEditor.form, FEventThermostat.form, FEvents.form,
      FFloorplanEditor.form, FHVAC.form, FHeatingEditor.form, FHome.form,
      FInstallDBWizard.form, FMain.form, FMusic.form, FNetwork.form,
      FSettingsAsterisk.form, FSettingsBluetooth.form, FSettingsBwiredMap.form,
      FSettingsCTX35.form, FSettingsCUL.form, FSettingsCallerID.form,
      FSettingsCamVisca.form, FSettingsCurrentCost.form, FSettingsDSC.form,
      FSettingsDenon.form, FSettingsDigitemp.form, FSettingsDomotica.form,
      FSettingsEIB.form, FSettingsELVMAX.form, FSettingsEmail.form,
      FSettingsGMail.form, FSettingsGUI.form, FSettingsHomeMatic.form,
      FSettingsMySQL.form, FSettingsOpenTherm.form, FSettingsPing.form,
      FSettingsPioneer.form, FSettingsRFXComRX.form, FSettingsRFXComTRX.form,
      FSettingsRFXComTX.form, FSettingsRFXComxPL.form, FSettingsRRDTool.form,
      FSettingsZWave.form, FThermostat.form, FToolsBluetoothBrowser.form,
      FToolsCULCmdr.form, FToolsDatabaseAdmin.form,
      FToolsHomeMaticQuickSet.form, FToolsPLCBUSCmdr.form,
      FToolsRFXComCmdr.form, FToolsSerialMon.form, FToolsSerialPorts.form,
      FToolsX10Cmdr.form, FToolsZWaveCmdr.form, FTriggerEditor.form: Fixed:
      Gambas v2 to v3 automatic conversion screwed the textbox allignment

    * CLEDMatrix.class, DomotiGa3.gambas, FScenarioEditor.form,
      FScheduleEditor.form, FServerStats.form, FSettingsAsterisk.form,
      FSettingsAstro.form, FSettingsBluetooth.form, FSettingsBwiredMap.form,
      FSettingsCTX35.form, FSettingsCUL.form, FSettingsCallerID.form,
      FSettingsCamVisca.form, FSettingsCurrentCost.form, FSettingsDSC.form,
      FSettingsDenon.form, FSettingsDigitemp.form, FSettingsDomotica.form,
      FSettingsEIB.form, FSettingsELVMAX.form, FSettingsEZcontrol.form,
      FSettingsEmail.form, FSettingsFritzBox.form, FSettingsGLatitude.form,
      FSettingsGMail.form, FSettingsGPS.form, FSettingsGUI.form,
      FSettingsHDDTemp.form, FSettingsHome.form, FSettingsHomeMatic.class,
      FSettingsHomeMatic.form, FSettingsIPort.form, FSettingsIRMan.form,
      FSettingsIRTrans.form, FSettingsIViewer.form, FSettingsJeeLabs.form,
      FSettingsK8055.form, FSettingsLEDMatrix.class, FSettingsLEDMatrix.form,
      FSettingsLGTV.form, FSettingsLIRC.form, FSettingsMQTT.form,
      FSettingsMain.form, FSettingsMeteohub.form, FSettingsMySQL.form,
      FSettingsNcid.form, FSettingsOWFS.form, FSettingsOnkyo.form,
      FSettingsOpenTherm.form, FSettingsOww.form, FSettingsPLCBUS.form,
      FSettingsPachube.form, FSettingsPing.form, FSettingsPioneer.form,
      FSettingsPlugwise.form, FSettingsPwrCtrl.form, FSettingsRFXComRX.form,
      FSettingsRFXComTRX.form, FSettingsRFXComTX.form, FSettingsRFXComxPL.form,
      FSettingsRRDTool.form, FSettingsSMS.form, FSettingsServerStats.form,
      FSettingsSharpTV.form, FSettingsShell.form, FSettingsSmartMeter.form,
      FSettingsSound.form, FSettingsSqueezeServer.form, FSettingsTVGuide.form,
      FSettingsTelnetServer.form, FSettingsTemp08.form,
      FSettingsTemperaturNu.form, FSettingsThermostat.form,
      FSettingsTwitter.form, FSettingsUPS.form, FSettingsVideoServer.form,
      FSettingsVoiceText.form, FSettingsWeatherBug.form,
      FSettingsWebServer.form, FSettingsWeeder.form, FSettingsX10Cmd.form,
      FSettingsXBMCxPL.form, FSettingsXMLRPC.form, FSettingsYouLess.form,
      FSettingsZWave.form, FSettingsxPL.form, FSplashScreen.class,
      FSplashScreen.form: Fixed: Gambas v2 to v3 automatic conversion screwed
      the textbox sizes upFixed: Setting LED display didn't work (gambas3)Fixed:
      Setting HomeOMatic Didn't work (gambas3)

    * DomotiGa3.gambas, FLogfiles.class: Fixed: Bug #236 - Unknown symbol
      'BackColor' in class '_GridView_Data' in DomotiGa3

2013-01-20  wwolkers

    * CallerID.module: One more leftover read change

2013-01-20  rdnzl

    * RRDTool.module: Fixed RRDTool generating graphs.

2013-01-20  alexie

    * Bluetooth.module, CCTX35.class, CCUL.class, CCurrentCost.class,
      CDSC.class, CDenon.class, CDomotica.class, CEIB.class, CELVMAX.class,
      CFritzBox.class, CHomeMatic.class, CIPort.class, CIRMan.class,
      CIRTrans.class, CIViewer.class, CJeeLabs.class, CLEDMatrix.class,
      CLGTV.class, CLIRC.class, CMQTT.class, CMeteohub.class, CNcid.class,
      COWFS.class, COWW.class, COnkyo.class, COpenTherm.class, CPLCBUS.class,
      CPioneer.class, CPlugwise.class, CPwrCtrl.class, CRFXComRX.class,
      CRFXComTRX.class, CRFXComTX.class, CSMS.class, CSmartMeter.class,
      CSqueezeServer.class, CTelnetServer.class, CTemp08.class, CUPS.class,
      CVISCA.class, CWebServer.class, CWeeder.class, CYouLess.class, CxPL.class,
      Digitemp.module, DomotiGaServer3.gambas, GLatitude.module, HDDTemp.module,
      Mail.module, Ping.module, Shell.module, TVGuide.module,
      TemperaturNu.module, VideoServer.module, VoiceText.module, X10Cmd.module:
      Fixed: Need to keep DomotiGa3 and DomotiGaServer3 code in sync

2013-01-19  wwolkers

    * Bluetooth.module, CCTX35.class, CCUL.class, CCurrentCost.class,
      CDSC.class, CDenon.class, CDomotica.class, CEIB.class, CELVMAX.class,
      CFritzBox.class, CHomeMatic.class, CIPort.class, CIRMan.class,
      CIRTrans.class, CIViewer.class, CJeeLabs.class, CLEDMatrix.class,
      CLGTV.class, CLIRC.class, CMQTT.class, CMeteohub.class, CNcid.class,
      COWFS.class, COWW.class, COnkyo.class, COpenTherm.class, CPLCBUS.class,
      CPioneer.class, CPlugwise.class, CPwrCtrl.class, CRFXComRX.class,
      CRFXComTRX.class, CRFXComTX.class, CSMS.class, CSmartMeter.class,
      CSqueezeServer.class, CTelnetServer.class, CTemp08.class, CUPS.class,
      CVISCA.class, CWebServer.class, CWeeder.class, CYouLess.class,
      CallerID.module, CxPL.class, Digitemp.module, DomotiGa.gambas,
      DomotiGa3.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas,
      FBarcodes.class, FCamera.class, FHome.class, FMain.class, FNews.class,
      FToolsBluetoothBrowser.class, FToolsDatabaseAdmin.class,
      FToolsSerialMon.class, GLatitude.module, HDDTemp.module, Mail.module,
      Main.module, Ping.module, Shell.module, TVGuide.module,
      TemperaturNu.module, VideoServer.module, VoiceText.module, X10Cmd.module,
      XMLParser.module: Convert all read/write to Gambas3

    * index.php: urlencode the devicename when switching

2013-01-19  alexie

    * .project, DomotiGa.gambas, DomotiGa3.gambas, Main.module: Changed: Forced
      default font and font size to Sans Seriff 9 (looks better on gambas3 :-))

2013-01-18  alexie

    * FEvents.class: Fixed: Bug #233 - Events couldn't be selected based on
      category

    * DomoZWave.cpp: Fixed: Bug #226 is resolved now

    * CZWave.class, DomotiGa.gambas, DomotiGa3.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, FToolsZWaveCmdr.class, FToolsZWaveCmdr.form:
      Changed: Update Neighborhood is using HealNetwork now (works better)Added:
      Heal Network in Z-Wave CommanderFixed: Z-Wave controller itself can update
      its neighborhood

2013-01-18  MerlinIS

    * AboutActivity.java, AndroidManifest.xml, DeviceListActivity.java,
      MainActivity.java, ParameterActivity.java, Settings.java, about.xml,
      classes.dex, custom_style.xml, domotigapp.apk, ic_menu_back.png,
      logoo.png, mainscreen.xml, parameters.xml, resources.ap_,
      window_title.xml: - Updated About Screen with Domotiga logo and GPL3
      license.- Added a new title bar that looks a bit more fancy.- Added back
      and refresh button on the top bar for easier access.

2013-01-17  alexie

    * Devices.module: Fixed: Need to keep DomotiGa and DomotiGaServer code in
      sync

2013-01-16  wwolkers

    * Devices.module, DomotiGa.gambas, DomotiGa3.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: No need for a counter here

2013-01-16  alexie

    * DomotiGa.gambas, DomotiGa3.gambas, FMain.class: Fixed: Main screen and
      dynamic panels (e.g. climate, HVAC) on gambas3

2013-01-15  alexie

    * CZWave.class, DomoZWave.cpp, DomoZWave.h, DomotiGa.gambas,
      DomotiGa3.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Update:
      DomoZWave wrapper supports open-zwave r623+

    * Devices.module, DomotiGa3.gambas, FEditBwiredDevices.class,
      FEditPachubeDevices.class, FHeatingEditor.class, FHome.class,
      FSettingsTemperaturNu.class, FThermostat.class,
      FToolsHomeMaticQuickSet.class, FTriggerEditor.class, RRDTool.module:
      Fixed: DomotiGa3/DomotiGaServer3 are in sync with DomotiGa/DomotiGaServer
      nowFixed: Previous gambas3 binary didn't run

2013-01-15  wwolkers

    * Devices.module, FEditBwiredDevices.class, FEditPachubeDevices.class,
      FHeatingEditor.class, FHome.class, FSettingsTemperaturNu.class,
      FThermostat.class, FToolsHomeMaticQuickSet.class, FTriggerEditor.class,
      RRDTool.module: More devices updates & cleanup

2013-01-15  rdnzl

    * DomotiGa3.gambas, DomotiGaServer3.gambas: Updated binaries.

    * CRFXComTRX.class, DomotiGa.gambas, DomotiGa3.gambas,
      DomotiGaServer.gambas: Fixed negative temp decoding for RFXComTRX THB
      sensors.

2013-01-14  alexie

    * FHome.class: Fixed: FHome refresh on gambas3 (reparent also fixed on
      gambas2)

2013-01-14  MerlinIS

    * .classpath, .project, .settings, AboutActivity.java, AndroidManifest.xml,
      Base64Coder.java, Device.java, DeviceAdapter.java,
      DeviceListActivity.java, IXMLRPCSerializer.java, ImageActivity.java,
      MainActivity.java, MethodCall.java, ParameterActivity.java, Settings.java,
      Tag.java, WebImage.java, XMLRPC.java, XMLRPCClient.java,
      XMLRPCCommon.java, XMLRPCException.java, XMLRPCFault.java,
      XMLRPCSerializable.java, XMLRPCSerializer.java, XMLRPCServer.java,
      about.xml, adapter, android, assets, bin, border.xml, classes,
      classes.dex, com, data, default_off.png, default_on.png, devices_list.xml,
      devices_list_listview.xml, domotiga, domotigapp.apk, drawable-hdpi,
      drawable-ldpi, drawable-mdpi, fire_off.png, fire_on.png, gen,
      ic_menu_refresh.png, icon.png, image.xml, jarlist.cache, layout,
      light_off.png, light_on.png, mainscreen.xml, menu, menu.xml, org,
      org.eclipse.jdt.core.prefs, parameters.xml, project.properties, res,
      resources.ap_, src, string.xml, strings.xml, thermometre.png, tools,
      values, values-fr, wifi_off.png, wifi_on.png, xmlrpc: First CommmitChanges
      compared to the original DomotigaApp:Changes the homescreen (not done
      yet). It now shows your locations and when you choice one you will get all
      the devices from that location.When reopening the app it will
      automatically refresh the screen (if you are on a screen with devices)
      next commit the homescreen wil have this also.Color scheme has changed
      from black to white.All comments/suggestions can be send to
      cvanbrummelen@merlinsystems.nl

    * DomotigaAppV2, domotigapp: Initial import.

2013-01-13  alexie

    * Bluetooth.module, CXMLRPC.class, Devices.module, DomotiGaServer3.gambas,
      Events.module, Shell.module, Thermostat.module: Fixed: DomotiGaServer3 is
      in sync with the latest DomotiGa3 code now

    * CNcid.class: Fixed: Added the correct DomotiGaServer file "CNcid.class"
      now

    * CNcid.class: Fixed: Remove symbolic link in DomotiGaServer file
      "CNcid.class"

    * Bluetooth.module, CXMLRPC.class, Devices.module, DomotiGa3.gambas,
      Events.module, FActionEditor.class, FActionScriptEditor.class,
      FConditionEditor.class, FDeviceEditor.class, FDevices.class,
      FDevices.form, FEditBwiredDevices.class, FEditPachubeDevices.class,
      FHeatingEditor.class, FHome.class, FMain.class, FThermostat.class,
      FTriggerEditor.class, Shell.module, Thermostat.module: Fixed: DomotiGa3 is
      in sync with the latest DomotiGa code now

    * DomotiGa3.gambas, FDeviceEditor.class: Fixed: issue #232 for DomotiGa3

2013-01-13  rdnzl

    * CXMLRPC.class, Devices.module, DomotiGa.gambas, DomotiGa3.gambas,
      DomotiGaServer.gambas, Events.module, FActionEditor.class,
      FActionScriptEditor.class, FConditionEditor.class,
      FEditBwiredDevices.class, FEditPachubeDevices.class, FHeatingEditor.class,
      FHome.class, FMain.class, FThermostat.class, FTriggerEditor.class: More
      device query cleanups by Wouter.

    * Devices.module, DomotiGa.gambas, DomotiGa3.gambas, DomotiGaServer.gambas,
      FDeviceEditor.class, FDevices.class, FDevices.form, FHome.class: Fix for
      issue #232, added right click menu to devices list.

2013-01-12  rdnzl

    * .startup: Deleted obsolete file.

    * Bluetooth.module, CHomeMatic.class, CK8055.class, COWFS.class,
      COpenTherm.class, CPLCBUS.class, CPlugwise.class, CUPS.class,
      CXMLRPC.class, Devices.module, DomotiGa.gambas, DomotiGa3.gambas,
      DomotiGaServer.gambas, DomotiGaServer3.gambas, Events.module,
      FActionEditor.class, FDeviceEditor.class, FEditBwiredDevices.class,
      FEditPachubeDevices.class, FHeatingEditor.class, FHome.class, FMain.class,
      FMusic.class, FTriggerEditor.class, GLatitude.module, Ping.module,
      Shell.module, Thermostat.module: Lots of device query updates and code
      cleanups made by Wouter, thanks!

    * CHomeMatic.class: Removed hardcoded interface id.

    * .startup, Bluetooth.module, CHomeMatic.class, CK8055.class, COWFS.class,
      COpenTherm.class, CPLCBUS.class, CPlugwise.class, CUPS.class,
      CXMLRPC.class, Devices.module, DomotiGa.gambas, DomotiGa3.gambas,
      DomotiGaServer.gambas, DomotiGaServer3.gambas, Events.module,
      FActionEditor.class, FDeviceEditor.class, FEditBwiredDevices.class,
      FEditPachubeDevices.class, FHeatingEditor.class, FHome.class, FMain.class,
      FMusic.class, FTriggerEditor.class, GLatitude.module, Ping.module,
      Shell.module, Thermostat.module: Lots of device query updates and code
      cleanups made by Wouter, thanks!Same code for Gambas 3 DomotiGa projects
      follow shortly.

    * compile.sh: Added DomotiGa3 project to compile script.

    * Bluetooth.module, CHomeMatic.class, FActionEditor.form, X10Cmd.module:
      Small code cleanups.

    * fixlinks.sh, fixlinks3.sh: Added scripts for linking shared development
      files between server and client code.

    * FDevices.class: Refresh Devices page contents when it gets focus.

2013-01-11  rdnzl

    * device.php, locations.php: Added missing locations file to iPhone
      webclient.Temporarily disabled event handlers so scrolling works again.

    * change_device.php, device.php, functions.php, index.php: Added
      slider/dimming support to iPhone webclient.

2013-01-09  rdnzl

    * Devices.module, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: Added missing comma to sql query, thanks Wouter!

2013-01-09  alexie

    * FEditGlobalVars.class, FEditGlobalVars.form: Fixed: DomotiGa3 GlobalVar
      edit didn't work properly

2013-01-08  alexie

    * FDeviceEditor.class, FEventEditor.class, XMLParser.module: Removed:
      specific gambas2 code from DomotiG3 and gambas3 code from DomotiGa

2013-01-08  rdnzl

    * FDeviceEditor.class: Try to catch errors with missing icons in Device
      Editor.

2013-01-07  alexie

    * CXMLRPC.class, DomotiGaServer3.gambas: Fixed: DomotiGa GUI and
      DomotiGaServer3 incompatibility (issue #223), fix got rolled back in r1060

    * DomotiGa3.gambas, FActionEditor.form: Fixed: DomotiGa3 crash when do Event
      -> Add Action

    * DomotiGa3.gambas, DomotiGaServer3.gambas: Fixed: recompiled
      DomotiGa3/DomotiGaServer3 with gambas 3.3.4 (latest official release).
      This should prevent the following error "ERROR: #2: Cannot load class
      'CTimerDelay': Bytecode too recent. Please upgradeGambas."

    * DomotiGa3.gambas, FEditContacts.class, FEditContacts.form: Fixed:
      DomotiGa3 crashed when do Edit -> Contacts

2013-01-07  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      binaries.

    * CEIB.class: Fixed EIB/KNX Dim issue with wrong case check, thanks Perry!

2013-01-06  alexie

    * #project.pot, .action, .connection, .directory, .hidden, .icon.png, .info,
      .lang, .list, .pot, .project, .public, .settings, .src, .startup,
      AVControl.module, AVControl.pot, Astro.module, Astro.pot,
      Bluetooth.module, Bluetooth.pot, Bwired.module, Bwired.pot,
      CAsterisk.class, CAsterisk.pot, CCTX35.class, CCTX35.pot, CCUL.class,
      CCUL.pot, CCurrentCost.class, CCurrentCost.pot, CDSC.class, CDSC.pot,
      CDenon.class, CDenon.pot, CDomotica.class, CDomotica.pot, CEIB.class,
      CEIB.pot, CELVMAX.class, CELVMAX.pot, CEZcontrol.class, CEZcontrol.pot,
      CFritzBox.class, CFritzBox.pot, CGPS.class, CGPS.pot, CHomeMatic.class,
      CHomeMatic.pot, CIPort.class, CIPort.pot, CIRMan.class, CIRMan.pot,
      CIRTrans.class, CIRTrans.pot, CIViewer.class, CIViewer.pot, CItems.class,
      CItems.pot, CJeeLabs.class, CJeeLabs.pot, CK8055.class, CK8055.pot,
      CLEDMatrix.class, CLEDMatrix.pot, CLGTV.class, CLGTV.pot, CLIRC.class,
      CLIRC.pot, CMQTT.class, CMQTT.pot, CMeteohub.class, CMeteohub.pot,
      CNcid.class, CNcid.pot, COWFS.class, COWFS.pot, COWW.class, COWW.pot,
      COnkyo.class, COnkyo.pot, COpenTherm.class, COpenTherm.pot, CPLCBUS.class,
      CPLCBUS.pot, CPioneer.class, CPioneer.pot, CPlugwise.class, CPlugwise.pot,
      CPwrCtrl.class, CPwrCtrl.pot, CRFXComRX.class, CRFXComRX.pot,
      CRFXComTRX.class, CRFXComTRX.pot, CRFXComTX.class, CRFXComTX.pot,
      CRFXComxPL.class, CRFXComxPL.pot, CSMS.class, CSMS.pot, CSharpTV.class,
      CSharpTV.pot, CSmartMeter.class, CSmartMeter.pot, CSqueezeServer.class,
      CSqueezeServer.pot, CTelnetServer.class, CTelnetServer.pot, CTemp08.class,
      CTemp08.pot, CTimerDelay.class, CTimerDelay.pot, CTimerOnOff.class,
      CTimerOnOff.pot, CUPS.class, CUPS.pot, CVISCA.class, CVISCA.pot,
      CWebServer.class, CWebServer.pot, CWeeder.class, CWeeder.pot,
      CXBMCxPL.class, CXBMCxPL.pot, CXMLRPC.class, CXMLRPC.pot, CYouLess.class,
      CYouLess.pot, CZWave.class, CZWave.pot, Calendar.module, Calendar.pot,
      CallerID.module, CallerID.pot, CxPL.class, CxPL.pot, CxPLMsg.class,
      CxPLMsg.pot, DNS.module, DNS.pot, Devices.module, Devices.pot,
      Digitemp.module, Digitemp.pot, DomotiGa3, DomotiGa3.gambas, Energy.module,
      Energy.pot, EventLoop.module, EventLoop.pot, Events.module, Events.pot,
      FAbout.class, FAbout.form, FAbout.pot, FActionEditor.class,
      FActionEditor.form, FActionEditor.pot, FActionScriptEditor.class,
      FActionScriptEditor.form, FActionScriptEditor.pot, FBarcodes.class,
      FBarcodes.form, FBarcodes.pot, FCalendar.class, FCalendar.form,
      FCalendar.pot, FCamera.class, FCamera.form, FCamera.pot, FCaptures.class,
      FCaptures.form, FCaptures.pot, FClimate.class, FClimate.form,
      FClimate.pot, FConditionEditor.class, FConditionEditor.form,
      FConditionEditor.pot, FConstantEditor.class, FConstantEditor.form,
      FConstantEditor.pot, FControl.class, FControl.form, FControl.pot,
      FDSC.class, FDSC.form, FDSC.pot, FDebug.class, FDebug.form, FDebug.pot,
      FDeviceEditor.class, FDeviceEditor.form, FDeviceEditor.pot,
      FDevices.class, FDevices.form, FDevices.pot, FEditBwiredDevices.class,
      FEditBwiredDevices.form, FEditBwiredDevices.pot, FEditCameraDevices.class,
      FEditCameraDevices.form, FEditCameraDevices.pot, FEditCategories.class,
      FEditCategories.form, FEditCategories.pot, FEditContacts.class,
      FEditContacts.form, FEditContacts.pot, FEditDictionary.class,
      FEditDictionary.form, FEditDictionary.pot, FEditDictionaryDetail.class,
      FEditDictionaryDetail.form, FEditDictionaryDetail.pot,
      FEditEventThermostatProfiles.class, FEditEventThermostatProfiles.form,
      FEditEventThermostatProfiles.pot, FEditGlobalVars.class,
      FEditGlobalVars.form, FEditGlobalVars.pot, FEditGraphs.class,
      FEditGraphs.form, FEditGraphs.pot, FEditMacro.class, FEditMacro.form,
      FEditMacro.pot, FEditMarkers.class, FEditMarkers.form, FEditMarkers.pot,
      FEditMenus.class, FEditMenus.form, FEditMenus.pot,
      FEditModulesGroups.class, FEditModulesGroups.form, FEditModulesGroups.pot,
      FEditNewsWeather.class, FEditNewsWeather.form, FEditNewsWeather.pot,
      FEditNotify.class, FEditNotify.form, FEditNotify.pot,
      FEditPachubeDevices.class, FEditPachubeDevices.form,
      FEditPachubeDevices.pot, FEditTVChannels.class, FEditTVChannels.form,
      FEditTVChannels.pot, FEditTVChannelsDetail.class,
      FEditTVChannelsDetail.form, FEditTVChannelsDetail.pot,
      FEditTVProgramCategories.class, FEditTVProgramCategories.form,
      FEditTVProgramCategories.pot, FEditTVProgramCategoriesDetail.class,
      FEditTVProgramCategoriesDetail.form, FEditTVProgramCategoriesDetail.pot,
      FEditUsers.class, FEditUsers.form, FEditUsers.pot, FEmail.class,
      FEmail.form, FEmail.pot, FEnergy.class, FEnergy.form, FEnergy.pot,
      FEventEditor.class, FEventEditor.form, FEventEditor.pot,
      FEventThermostat.class, FEventThermostat.form, FEventThermostat.pot,
      FEvents.class, FEvents.form, FEvents.pot, FFloorplanEditor.class,
      FFloorplanEditor.form, FFloorplanEditor.pot, FFloorplans.class,
      FFloorplans.form, FFloorplans.pot, FGraphsPreview.class,
      FGraphsPreview.form, FGraphsPreview.pot, FHVAC.class, FHVAC.form,
      FHVAC.pot, FHeatingEditor.class, FHeatingEditor.form, FHeatingEditor.pot,
      FHome.class, FHome.form, FHome.pot, FInstallDBWizard.class,
      FInstallDBWizard.form, FInstallDBWizard.pot, FLocations.class,
      FLocations.form, FLocations.pot, FLogfiles.class, FLogfiles.form,
      FLogfiles.pot, FMain.class, FMain.form, FMain.pot, FMusic.class,
      FMusic.form, FMusic.pot, FNetwork.class, FNetwork.form, FNetwork.pot,
      FNews.class, FNews.form, FNews.pot, FPhone.class, FPhone.form, FPhone.pot,
      FScenarioEditor.class, FScenarioEditor.form, FScenarioEditor.pot,
      FScheduleEditor.class, FScheduleEditor.form, FScheduleEditor.pot,
      FSecurity.class, FSecurity.form, FSecurity.pot, FSelectDate.class,
      FSelectDate.form, FSelectDate.pot, FSelectImage.class, FSelectImage.form,
      FSelectImage.pot, FServerStats.class, FServerStats.form, FServerStats.pot,
      FSettingsAsterisk.class, FSettingsAsterisk.form, FSettingsAsterisk.pot,
      FSettingsAstro.class, FSettingsAstro.form, FSettingsAstro.pot,
      FSettingsBluetooth.class, FSettingsBluetooth.form, FSettingsBluetooth.pot,
      FSettingsBwiredMap.class, FSettingsBwiredMap.form, FSettingsBwiredMap.pot,
      FSettingsCTX35.class, FSettingsCTX35.form, FSettingsCTX35.pot,
      FSettingsCUL.class, FSettingsCUL.form, FSettingsCUL.pot,
      FSettingsCallerID.class, FSettingsCallerID.form, FSettingsCallerID.pot,
      FSettingsCamVisca.class, FSettingsCamVisca.form, FSettingsCamVisca.pot,
      FSettingsCameras.class, FSettingsCameras.form, FSettingsCameras.pot,
      FSettingsCurrentCost.class, FSettingsCurrentCost.form,
      FSettingsCurrentCost.pot, FSettingsDSC.class, FSettingsDSC.form,
      FSettingsDSC.pot, FSettingsDenon.class, FSettingsDenon.form,
      FSettingsDenon.pot, FSettingsDigitemp.class, FSettingsDigitemp.form,
      FSettingsDigitemp.pot, FSettingsDomotica.class, FSettingsDomotica.form,
      FSettingsDomotica.pot, FSettingsEIB.class, FSettingsEIB.form,
      FSettingsEIB.pot, FSettingsELVMAX.class, FSettingsELVMAX.form,
      FSettingsELVMAX.pot, FSettingsEZcontrol.class, FSettingsEZcontrol.form,
      FSettingsEZcontrol.pot, FSettingsEmail.class, FSettingsEmail.form,
      FSettingsEmail.pot, FSettingsFritzBox.class, FSettingsFritzBox.form,
      FSettingsFritzBox.pot, FSettingsGLatitude.class, FSettingsGLatitude.form,
      FSettingsGLatitude.pot, FSettingsGMail.class, FSettingsGMail.form,
      FSettingsGMail.pot, FSettingsGPS.class, FSettingsGPS.form,
      FSettingsGPS.pot, FSettingsGUI.class, FSettingsGUI.form, FSettingsGUI.pot,
      FSettingsHDDTemp.class, FSettingsHDDTemp.form, FSettingsHDDTemp.pot,
      FSettingsHome.class, FSettingsHome.form, FSettingsHome.pot,
      FSettingsHomeMatic.class, FSettingsHomeMatic.form, FSettingsHomeMatic.pot,
      FSettingsIPort.class, FSettingsIPort.form, FSettingsIPort.pot,
      FSettingsIRMan.class, FSettingsIRMan.form, FSettingsIRMan.pot,
      FSettingsIRTrans.class, FSettingsIRTrans.form, FSettingsIRTrans.pot,
      FSettingsIViewer.class, FSettingsIViewer.form, FSettingsIViewer.pot,
      FSettingsJeeLabs.class, FSettingsJeeLabs.form, FSettingsJeeLabs.pot,
      FSettingsK8055.class, FSettingsK8055.form, FSettingsK8055.pot,
      FSettingsLEDMatrix.class, FSettingsLEDMatrix.form, FSettingsLEDMatrix.pot,
      FSettingsLGTV.class, FSettingsLGTV.form, FSettingsLGTV.pot,
      FSettingsLIRC.class, FSettingsLIRC.form, FSettingsLIRC.pot,
      FSettingsMQTT.class, FSettingsMQTT.form, FSettingsMQTT.pot,
      FSettingsMain.class, FSettingsMain.form, FSettingsMain.pot,
      FSettingsMeteohub.class, FSettingsMeteohub.form, FSettingsMeteohub.pot,
      FSettingsMySQL.class, FSettingsMySQL.form, FSettingsMySQL.pot,
      FSettingsNcid.class, FSettingsNcid.form, FSettingsNcid.pot,
      FSettingsOWFS.class, FSettingsOWFS.form, FSettingsOWFS.pot,
      FSettingsOnkyo.class, FSettingsOnkyo.form, FSettingsOnkyo.pot,
      FSettingsOpenTherm.class, FSettingsOpenTherm.form, FSettingsOpenTherm.pot,
      FSettingsOww.class, FSettingsOww.form, FSettingsOww.pot,
      FSettingsPLCBUS.class, FSettingsPLCBUS.form, FSettingsPLCBUS.pot,
      FSettingsPachube.class, FSettingsPachube.form, FSettingsPachube.pot,
      FSettingsPing.class, FSettingsPing.form, FSettingsPing.pot,
      FSettingsPioneer.class, FSettingsPioneer.form, FSettingsPioneer.pot,
      FSettingsPlugwise.class, FSettingsPlugwise.form, FSettingsPlugwise.pot,
      FSettingsPwrCtrl.class, FSettingsPwrCtrl.form, FSettingsPwrCtrl.pot,
      FSettingsRFXComRX.class, FSettingsRFXComRX.form, FSettingsRFXComRX.pot,
      FSettingsRFXComTRX.class, FSettingsRFXComTRX.form, FSettingsRFXComTRX.pot,
      FSettingsRFXComTX.class, FSettingsRFXComTX.form, FSettingsRFXComTX.pot,
      FSettingsRFXComxPL.class, FSettingsRFXComxPL.form, FSettingsRFXComxPL.pot,
      FSettingsRRDTool.class, FSettingsRRDTool.form, FSettingsRRDTool.pot,
      FSettingsSMS.class, FSettingsSMS.form, FSettingsSMS.pot,
      FSettingsServerStats.class, FSettingsServerStats.form,
      FSettingsServerStats.pot, FSettingsSharpTV.class, FSettingsSharpTV.form,
      FSettingsSharpTV.pot, FSettingsShell.class, FSettingsShell.form,
      FSettingsShell.pot, FSettingsSmartMeter.class, FSettingsSmartMeter.form,
      FSettingsSmartMeter.pot, FSettingsSound.class, FSettingsSound.form,
      FSettingsSound.pot, FSettingsSqueezeServer.class,
      FSettingsSqueezeServer.form, FSettingsSqueezeServer.pot,
      FSettingsTVGuide.class, FSettingsTVGuide.form, FSettingsTVGuide.pot,
      FSettingsTelnetServer.class, FSettingsTelnetServer.form,
      FSettingsTelnetServer.pot, FSettingsTemp08.class, FSettingsTemp08.form,
      FSettingsTemp08.pot, FSettingsTemperaturNu.class,
      FSettingsTemperaturNu.form, FSettingsTemperaturNu.pot,
      FSettingsThermostat.class, FSettingsThermostat.form,
      FSettingsThermostat.pot, FSettingsTwitter.class, FSettingsTwitter.form,
      FSettingsTwitter.pot, FSettingsUPS.class, FSettingsUPS.form,
      FSettingsUPS.pot, FSettingsVideoServer.class, FSettingsVideoServer.form,
      FSettingsVideoServer.pot, FSettingsVoiceText.class,
      FSettingsVoiceText.form, FSettingsVoiceText.pot,
      FSettingsWeatherBug.class, FSettingsWeatherBug.form,
      FSettingsWeatherBug.pot, FSettingsWebServer.class,
      FSettingsWebServer.form, FSettingsWebServer.pot, FSettingsWeeder.class,
      FSettingsWeeder.form, FSettingsWeeder.pot, FSettingsX10Cmd.class,
      FSettingsX10Cmd.form, FSettingsX10Cmd.pot, FSettingsXBMCxPL.class,
      FSettingsXBMCxPL.form, FSettingsXBMCxPL.pot, FSettingsXMLRPC.class,
      FSettingsXMLRPC.form, FSettingsXMLRPC.pot, FSettingsYouLess.class,
      FSettingsYouLess.form, FSettingsYouLess.pot, FSettingsZWave.class,
      FSettingsZWave.form, FSettingsZWave.pot, FSettingsxPL.class,
      FSettingsxPL.form, FSettingsxPL.pot, FSplashScreen.class,
      FSplashScreen.form, FSplashScreen.pot, FTVGuide.class, FTVGuide.form,
      FTVGuide.pot, FTVGuideChannelDetail.class, FTVGuideChannelDetail.form,
      FTVGuideChannelDetail.pot, FTVGuideProgramDetail.class,
      FTVGuideProgramDetail.form, FTVGuideProgramDetail.pot,
      FTVGuideSearchDetail.class, FTVGuideSearchDetail.form,
      FTVGuideSearchDetail.pot, FTextViewer.class, FTextViewer.form,
      FTextViewer.pot, FThermostat.class, FThermostat.form, FThermostat.pot,
      FToolsBluetoothBrowser.class, FToolsBluetoothBrowser.form,
      FToolsBluetoothBrowser.pot, FToolsCULCmdr.class, FToolsCULCmdr.form,
      FToolsCULCmdr.pot, FToolsDatabaseAdmin.class, FToolsDatabaseAdmin.form,
      FToolsDatabaseAdmin.pot, FToolsHomeMaticQuickSet.class,
      FToolsHomeMaticQuickSet.form, FToolsHomeMaticQuickSet.pot,
      FToolsPLCBUSCmdr.class, FToolsPLCBUSCmdr.form, FToolsPLCBUSCmdr.pot,
      FToolsRFXComCmdr.class, FToolsRFXComCmdr.form, FToolsRFXComCmdr.pot,
      FToolsSerialMon.class, FToolsSerialMon.form, FToolsSerialMon.pot,
      FToolsSerialPorts.class, FToolsSerialPorts.form, FToolsSerialPorts.pot,
      FToolsX10Cmdr.class, FToolsX10Cmdr.form, FToolsX10Cmdr.pot,
      FToolsZWaveCmdr.class, FToolsZWaveCmdr.form, FToolsZWaveCmdr.pot,
      FTriggerEditor.class, FTriggerEditor.form, FTriggerEditor.pot,
      FWeather.class, FWeather.form, FWeather.pot, GLatitude.module,
      GLatitude.pot, HDDTemp.module, HDDTemp.pot, JSON.module, JSON.pot,
      Mail.module, Mail.pot, Main.module, Main.pot, Pachube.module, Pachube.pot,
      Ping.module, Ping.pot, RRDTool.module, RRDTool.pot, ScreenFunc.module,
      ScreenFunc.pot, ServerStats.module, ServerStats.pot, Shell.module,
      Shell.pot, Sounds.module, Sounds.pot, TVGuide.module, TVGuide.pot,
      TemperaturNu.module, TemperaturNu.pot, Thermostat.module, Thermostat.pot,
      Twitter.module, Twitter.pot, VideoServer.module, VideoServer.pot,
      VoiceText.module, VoiceText.pot, X10Cmd.module, X10Cmd.pot,
      XMLClient.module, XMLClient.pot, XMLParser.module, XMLParser.pot,
      actions.png, aibo.gif, asterisk.png, bt.png, bus.png, camera.png,
      captures.png, category.png, cdeject.png, charts.png, climate.png,
      conditions.png, contacts.png, control.png, controller.png,
      controlrepeat.png, current-cost.jpg, database.png, de.mo, de.png, de.po,
      devices.png, domotiga.png, donate.png, drive.png, email.png, en.png,
      en_US.mo, en_US.po, energy.png, event.png, events.png, film.png,
      floorplan.png, fr.mo, fr.png, fr.po, fritz.jpg, gmail.png, gps.png,
      gui.png, hd.png, heyu.png, home.png, hvac.gif, hvac.png, icons, images,
      ipod.png, iviewer.png, key.png, knx.png, labs.png, latitude.png,
      led-off.png, led-on.png, ledmatrix.png, light-on.png, lirc.png, list.png,
      locations.png, login.png, logo.png, logout.png, logs.png, markers.png,
      menus.png, modules.png, music.png, mute.png, network.png, news.png, nl.mo,
      nl.png, nl.po, notify.png, phone.png, plugwise.jpg, points.png,
      powerkeypad.png, question.png, rss.png, ru.mo, ru.png, ru.po,
      security.png, serial.png, serialterm.png, serverstats.png, settings.png,
      sms.png, sound.png, squeezecenter.png, stock.png, sun.png, sunset.jpg,
      system.png, telnet.png, thermostat.png, triggers.png, tv.png, tvguide.png,
      twitter.gif, unavail.gif, ups.gif, users.png, vars.png, voice.png,
      weather.png, webcam.png, webserver.png, weeder.png, wifi-on.png, wire.png,
      world.png, x10.gif, xml.png, xpl.png, zwave.png: Add: DomotiGa3 version,
      including source. NOTE: It is still in BETA and *will* contain bugs and
      errors. Please report them in the Forum.

2013-01-06  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      binaries.

    * CHomeMatic.class, FToolsHomeMaticQuickSet.class: Applied a few bugfixes
      for HomeMatic code, thanks JK.

    * CRFXComTRX.class: Fixed auto device creation of KD101 smoke detectors.

    * X10Cmd.module: Added support for AllOff command to X10Cmd module, thanks
      jweijers!

    * Bluetooth.module, CMQTT.class, COpenTherm.class, CSmartMeter.class,
      CXMLRPC.class, FSplashScreen.form, Main.module: Updated OpenTherm code to
      work with CombiFort, thanks BreFa.

2013-01-06  alexie

    * DomotiGa3.gambas, FPhone.class: Fixed: Bug in phone tab in gambas3Add:
      Pre-compiled DomotiGa3.gambas (is a direct port from the gambas2
      DomotiGa). Source will follow shortly

2013-01-03  alexie

    * FLogfiles.class: Fixed: DomotiGa could crash when clicking on Logs ->
      Devices

    * CXMLRPC.class, DomotiGaServer3.gambas: Fixed: DomotiGa GUI and
      DomotiGaServer3 incompatibility (issue #223)

2013-01-01  alexie

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas,
      FSettingsGUI.class, Main.module: Fixed: When DomotiGa Client -> Server
      mode it will not try to save invalid GlobalVarsFixed: DomotiGa Client will
      not save the GlobalVars when a new hour happens (only server should do
      this)Fixed: GlobalVars Sec, Min, Hour, Day, Month and Year are initialized
      during startup (they caused other issues, because they didn't exists)

2012-12-27  alexie

    * CZWave.class, DomoZWave.cpp, DomoZWave.h, DomotiGa.gambas,
      DomotiGaServer.gambas, DomotiGaServer3.gambas, FToolsZWaveCmdr.class,
      FToolsZWaveCmdr.form: Fixed: Updated the DomoZWave wrapper to support the
      latest open-zwave libraryRemoved: Add/Remove controller option from Z-Wave
      Commander (became obsolete)

2012-12-17  alexie

    * CZWave.class, DomoZWave.cpp, DomoZWave.cpp.r582, DomoZWave.h,
      DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas,
      FToolsZWaveCmdr.class, FToolsZWaveCmdr.form, Main.module: Added: Ability
      to remove faulty Z-Wave nodesAdded: Ability to replace faulty Z-Wave
      nodesAdded: open-zwave r591 compatibilityAdded: open-zwave r582
      compatibility, use DomoZWave.cpp.582 instead of DomoZWave.cppFixed: Aeon
      Energy Meter will not report "4" anymoreEnhancement: Optimized Z-Wave
      devices value updates

2012-12-12  alexie

    * CRFXComxPL.class: Fixed: RFXCom xPL had wrong "average speed" type

    * FFloorplanEditor.class: Fixed: wrong floorplan icon positions when
      scrolling (bug 51)

2012-12-11  alexie

    * CRFXComTRX.class: Fixed: When RFXCom Transceiver looses connectivity, the
      disk will not be filled up anymore

2012-12-02  alexie

    * FToolsZWaveCmdr.class: Fixed: Group association didn't allow nodenumbers
      above 9

2012-12-02  rdnzl

    * domotiga.sql: Corrected invalid condition example.

2012-12-01  alexie

    * CZWave.class, DomoZWave.cpp, DomoZWave.h, DomotiGa.gambas,
      DomotiGaServer.gambas, DomotiGaServer3.gambas, EventLoop.module,
      FSettingsZWave.class, FSettingsZWave.form, FToolsZWaveCmdr.class,
      FToolsZWaveCmdr.form, Main.module, Makefile, README: NOTE: Please
      recompile the Open Z-Wave wrapper as documented on the following page:
      http://www.domotiga.nl/projects/domotiga/wiki/Z-WaveAdded: OpenZWave
      wrapper can handle multiple Z-Wave controllers (but DomotiGa doesn't
      support it YET)Added: OpenZWave wrapper logs debug to
      ~/logs/domozwave-<year>-<month>.log instead of consoleAdded: OpenZWave
      wrapper writes version number to the debug logfileAdded: OpenZWave wrapper
      writes open-zwave version to the debug logfileFixed: DomoZWave wrapper
      will send XMLRPC requests after a faillure (previously all were
      lost)Fixed: DomoZWave wrapper will log errors nowFixed: DomoZWave wrapper
      compiles under Slackware nowEnhancement: Almost all open-zwave calls are
      exposed to DomotiGa (Thermostate calls are pending)Enhancement: OpenZWave
      wrapper README updatedEnhancement: The "not initialized" message of the
      OpenZWave wrapper is only given when really calling RunTasksAdded: Z-Wave
      Commander shows neighborsAdded: Z-Wave Commander shows
      commandclassesEnhancement: When requesting Z-Wave node information, it
      will do it in numeric orderEnhancement: Z-Wave add/remove devices is more
      clear nowEnhancement: Z-Wave Commander columns are resized automatically
      at startupRemoved: Native gambas Z-Wave support

2012-11-30  rdnzl

    * FDevices.class, FEvents.class: Try to fix double click behavior.

2012-11-29  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      binaries.

    * FDeviceEditor.class: Correctly display device address for RisingSun,
      PhilipsSBC and EMW200 devices in editor.

    * CRFXComTRX.class: Fixed bugs in selecting Lighting1 and Lighting5 protocol
      type when creating TX packet, thanks Steve!

2012-11-27  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas,
      Main.module: Prevent overflow error.

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas,
      Main.module: Don't trigger hour every minute.

    * CELVMAX.class, CMQTT.class, CRFXComTRX.class, CYouLess.class,
      DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas,
      Main.module: Fixes to GlobalVar code again.Updated DomotigaServer3 code
      with older fixes.

    * CELVMAX.class: Added ELV Max! patches.

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas,
      Main.module: Fixed GlobalVar Weekday and other issues, please test.

2012-11-25  rdnzl

    * ru.mo: Added missing language file.

2012-11-24  rdnzl

    * DomotiGa.gambas, DomotiGaServer3.gambas: Updated binaries.

    * FThermostat.class, XMLClient.module: Fixed Thermostat client/server
      derogate heating control, thanks hplus!

    * Main.module, ru.po: Added good start of Russian translation, thanks Andry!

2012-11-24  alexie

    * FHome.class, FWeather.class, XMLParser.module: Fixed: XML Parser of
      gambas2 was creating not-correct outputGambas3: Weather works with gambas3
      now (r5351 and up)

2012-11-21  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas,
      Main.module: Revert GlobalVar changes.

2012-11-17  rdnzl

    * CRFXComTRX.class, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, FToolsRFXComCmdr.class, FToolsRFXComCmdr.form:
      Fixed RFXComTRX Commander SetMode command.

    * CRFXComTRX.class, DomotiGa.gambas, DomotiGaServer3.gambas,
      FToolsRFXComCmdr.class, FToolsRFXComCmdr.form: Added Lighting6 tab to
      RFXComTRX Commander.

2012-11-16  rdnzl

    * DomotiGa.gambas, DomotiGaServer3.gambas, Main.module: Update status bar
      when GlobalVar changes.

2012-11-15  rdnzl

    * CYouLess.class, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: Made parsing YouLess JSON data more flexible.

    * .project, 10001to10002.sql, Astro.module, CELVMAX.class, CFritzBox.class,
      CMQTT.class, CMeteohub.class, CPLCBUS.class, CRFXComTRX.class,
      CSharpTV.class, CSmartMeter.class, CXMLRPC.class, CYouLess.class,
      Devices.module, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, FDeviceEditor.class, FMain.class, FMain.form,
      FSettingsYouLess.class, FSettingsYouLess.form, Main.module, about.xml,
      domotiga-empty.sql, domotiga.sql, index.php, json.php, settings.php,
      youless-ls110.jpg: New version 1.0.002, you must upgrade your
      database.Please make a backup of your database and DomotiGa directory tree
      first!Added support for YouLess energy sensor.Added support for
      controlling Blyss devices in RFXComTRX (Lighting6), needs testing.Fixed
      auto creation of Elec3 (OWL CM180) devices.Corrected example addressformat
      for a number of devicetypes.Fixed RFXComTRX firmware version check.Made
      small correction to Astro UTC calculation.Changed GlobalVar loop, so
      statusbar of GUI isn't updated every second anymore, only when
      needed.Removed SharpTV debug output.Fixed Copyright strings.

2012-11-14  rdnzl

    * CRFXComTRX.class, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: Fixed RFXComTRX Lighting5 switching
      hopefully.Added check for correct RFXComTRX firmware version for certain
      protocols.Started to add support for RFXComTRX Lighting6 (Blyss) devices
      control, needs database changes to be enabled.

    * DomotiGa.gambas, DomotiGaServer3.gambas, FSettingsGUI.class,
      FSettingsGUI.form, ru.png: Added Russian as possible language selection to
      GUI settings form.

2012-11-12  rdnzl

    * FSettingsMeteohub.class: Corrected wrong debug variable in Meteohub
      settings form.

    * domotiga-empty.sql, domotiga.sql: Disable ELV MAX! by default in install
      databases too.

2012-11-11  alexie

    * DomoZWave.cpp, DomoZWave.h, Makefile, default, vers.c: Enhancement:
      open-zwave wrapper can report its own and open-zwave version now. Also
      added the group information DomoZWave call. Included open-zwave r564
      support

    * DomotiGa.gambas, FControl.class: Fixed: Hopefully fixed Dim issue with
      devices (had to revert back an old fix)

2012-11-11  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      binaries.

    * CUPS.class: Fixed comparison in UPS class, thank Jean.

    * CMeteohub.class: Updated parsing of Meteohub rain values to match HTTP
      Logger V1.4 protocol.

2012-11-11  alexie

    * CXMLRPC.class, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: Fixed: DomotiGa will crash when devicelist was
      requested via a webclientFixed: An old CXMLRPC bug came back again, fixed
      again (if the on/off icon held a NULL value in the database, DomotiGa
      would crash)

2012-11-10  alexie

    * CZWave.class, DomotiGa.gambas, FToolsZWaveCmdr.class: Enhancement: When
      the Z-Wave interface is fully initialized, this will be written in the
      main logfileEnhancement: If you want to use the Z-Wave Commander and the
      Z-Wave interface isn't fully initialized, a popup is showed

    * DomotiGa.gambas, FDeviceEditor.class, FDeviceEditor.form,
      FEditGraphs.class, FEventEditor.class, FFloorplanEditor.class,
      FFloorplanEditor.form, FFloorplans.class, FHome.class, FSelectImage.class,
      FSettingsWeatherBug.class, FWeather.class, XMLParser.module: Fixed: Device
      floorplan has been changed, it is more useable now. E.g. the current icon
      and location will be showed (not what was in the database).Fixed: Device
      icon are refreshed if the icon is changed or removedFixed: Device
      floorplan editor also accepted an empty nameFixed: XMLParser didn't always
      split the elements correctly, a "|" was missingEnhancement: Device
      floorplan X and Y are readonly now (editor needs to be used)Enhancement:
      Device battery status is readonly nowGambas3: Numerous gambas3 fixes
      included

    * 10000to10001.sql: Fixed: ELV MAX! is standard disabled now

2012-11-10  rdnzl

    * CSmartMeter.class, Devices.module, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: Fixed problem with creating the same device types
      for each smartmeter meter type.

    * .project, 10000to10001.sql, Bluetooth.module, CDSC.class, CEIB.class,
      CELVMAX.class, CFritzBox.class, CMQTT.class, CMeteohub.class, COWFS.class,
      CPlugwise.class, CRFXComTRX.class, CRFXComxPL.class, CTelnetServer.class,
      CXBMCxPL.class, CXMLRPC.class, CxPL.class, Devices.module,
      DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas,
      Energy.module, EventLoop.module, FActionEditor.form, FDebug.class,
      FDeviceEditor.class, FDevices.class, FEditGlobalVars.class, FEvents.class,
      FMain.class, FMain.form, FPhone.class, FServerStats.class,
      FSettingsELVMAX.class, FSettingsELVMAX.form, FSettingsMQTT.class,
      FSettingsMQTT.form, FSettingsMeteohub.class, FSettingsMeteohub.form,
      FSettingsXBMCxPL.class, FSettingsXBMCxPL.form, FThermostat.class,
      FToolsRFXComCmdr.class, FToolsRFXComCmdr.form, Main.module,
      ServerStats.module, XMLClient.module, domotiga-empty.sql, domotiga.sql:
      New version 1.0.001, you must upgrade your database.Please make a backup
      of your database and DomotiGa directory tree first!Added code for a MQTT
      Client. (not finished yet)Started suppport for ELV MAX! devices thanks to
      Wouter! (not finished yet)Added support for reading Meteohub sensors via
      raw http.Fixed Rubicson support for RFXComxPL.Made Z-Wave serial port
      database field longer to be able to hold USB device path.A lot of
      DeviceEditor fixed/improvements.RFXComTRX fixed and additions:Removed
      depricated set mode commands. (not finished)Added RisingSun and Philips
      SBC SP370/375 support to Lighting1 code.Removed AB400 decode code.Added
      better address format checks for Lighting1More valid command checks for
      Lighting5Added support for Lighting5 Everflourish EMW100 and BBSB
      modules.Added support for OWL CM180 elec3.Added support for XBMCxPL
      plugin.Moved tablesort code to FMain.Fixed issue with 2x double click not
      working in Device list.Added Dallas DS2408 8-Channel Addressable Switch
      for OWFS.

2012-11-09  alexie

    * CZWave.class, DomoZWave.cpp, DomoZWave.h, DomotiGa.gambas,
      DomotiGaServer.gambas, DomotiGaServer3.gambas, FToolsZWaveCmdr.class,
      FToolsZWaveCmdr.form: Fixed: Z-Wave set/add association was wrongly
      implementedAdded: Z-Wave remove associationNOTE: Please recompile your
      Z-Wave wrapper to use association

2012-11-09  rdnzl

    * CRFXComxPL.class, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: Fixed dimming AC devices with RFXComxPL.

2012-11-04  alexie

    * CZWave.class, DomoZWave.cpp, DomoZWave.h, DomotiGa.gambas,
      DomotiGaServer.gambas, DomotiGaServer3.gambas, FMain.class,
      FToolsSerialMon.class, FToolsZWaveCmdr.class, FToolsZWaveCmdr.form,
      Main.module: Feature: The Open Z-Wave wrapper will not overwrite values
      anymore in DomotiGa. E.g. it could happen that Temperature and On/Off
      where stored in "Value1". This is an extension of the earlier submitted
      BASIC commandclass mapping feature.Feature: The Open Z-Wave wrapper
      support the recent devices which have multiple NodeEvents
      triggers.Enhancement: When using the Open Z-Wave wrapper DomotiGa will
      show an error message if it doesn't get a response within 10 seconds from
      the USB Stick.Enhancement: Z-Wave Commander is improved to show more node
      information in the same window (helpfull if you have >4
      nodes).Enhancement: If running in Client mode, the Z-Wave Commander will
      give a proper error message.Enhancement: If running Client and Server
      mode, and the Server is unavailable, only 1 error message is shown.Fixed:
      DomotiGa doesn't crash anymore, if trying to open a none-existing serial
      port in Serial Monitor.***NOTE: Please use the recent Open Z-Wave library
      r558 with this release of DomotiGa. The wrapper will work with older
      versions, but there have been too many fixes/config improvements in the
      recent revisions.NOTE: Please recompile the Open Z-Wave wrapper as
      documented on the following page:
      http://www.domotiga.nl/projects/domotiga/wiki/Z-Wave***

2012-11-03  rdnzl

    * COWFS.class, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: Convert read values of OWFS switches to On/Off.

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      binaries.

    * CEIB.class: Also update device value of EIB/KNX switch which status
      changed.

2012-10-28  alexie

    * domotiga.debian, logrotate.d.domotiga: Fixed: Debian startup script, the
      pid file was set wrong and it would only work with gambas2 from the
      official repository. Also updated the logrotate example, replacing
      "source" with "."

2012-10-25  alexie

    * FHome.class: Enhancement: The Home tab will show "--" if
      temperature/humidity isn't available. Less conversion error are reported
      now.

2012-10-24  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      binaries.

    * CEIB.class: Made EIB/KNX device commands case insensitive.

2012-10-24  alexie

    * FControl.class: Fixed: Slider issue in Control tab (Bug #78)

2012-10-23  alexie

    * FDevices.class: Fixed: Devices Doubleclick didn't always give a
      predictable result (and we got r1000 :-))

    * GLatitude.module: Enhancement: Now it is possible to have more then 1
      Google Lattitude device in DomotiGa (Bug #183)

2012-10-22  alexie

    * functions.php: Fixed: Weird characters in webclient if using the cURL
      option

2012-10-21  alexie

    * config.php.example, functions.php: Enhancement: for webclient/iphone it is
      possible to use the cURL library, this is required for Raspberry Pi
      devices

    * Twitter.module: Fixed: DomotiGa would crash if the twitter module was
      disabled and DomotiGa wanted to send a tweet (undefined Main.bTwitter
      variable)

2012-10-20  alexie

    * CXMLRPC.class: Fixed: When using the web interface and the on/off icons
      are NULL values, DomotiGa will crash. Thanks PaulRaison for reporting it

    * DomoZWave.cpp: Fixed: Issue with On/Off value when using a Z-Wave sensor
      in Open Z-Wave wrapper

2012-10-20  rdnzl

    * README: Updated README.

    * domotiga.conf, domotiga.conf.default, server-domotiga.conf,
      server-domotiga.conf.default: Added .default to config file names to
      prevent overwriting existing ones.

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      the binaries.

    * Twitter.module: Added some debug code to the Twitter module.

    * README, change_device.php, change_housemode.php, device.php, domotiga.js,
      functions.php, index.php, json.php: Added code to switch dimmable devices,
      thanks Rene!

2012-10-18  rdnzl

    * CRFXComxPL.class: Fixed HEEU address parsing for RFComxPL, addresses need
      to start with 0x, thanks Bert.

2012-10-17  alexie

    * DomoZWave.cpp: This revision includes a MAJOR change in the Open Z-Wave
      wrapper. Now the wrapper ties all the same type of event value (e.g.
      "255", "On", "Open", etc) from 1 device into 1 consistent value for switch
      and dim devices. This is done by mapping the COMMAND_CLASS_BASIC command
      to the device specific COMMAND_CLASS. Also the Open Z-Wave NodeEvent is
      using the same type of mapping. Now for binary switches the only possible
      values are "On" or "Off". For dim devices the possible values are "Off",
      "Dim 1" through "Dim 98" and "On".NOTE: This change requires a recompile
      of the DomoZWave wrapper

2012-10-17  rdnzl

    * Energy.module: Rewrote Energy module code.

2012-10-16  alexie

    * FToolsZWaveCmdr.class: Enhancement: The Z-Wave Commander is more robust
      now. Scrolling through Z-Wave devices works properly and if it isn't
      dimmer, the 0-100% doesn't work anymore

2012-10-16  rdnzl

    * CRFXComTRX.class, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: Moved decoding of Chime command from X10 to ARC
      for RFXComTRX.

2012-10-16  alexie

    * CZWave.class: Enhancement: Z-Wave Commander shows value, value2, value3
      and value4 correctly (all was stored in the first value) for a device

2012-10-16  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      binaries.

    * CRFXComTRX.class: Added LightwaveRF Dim support to RFXComTRX.

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      binaries.

    * Devices.module: Added log to db debug info.

2012-10-14  alexie

    * FSettingsZWave.class: Fixed: r976 Z-Wave enhancement still required some
      restart

2012-10-13  alexie

    * CZWave.class: Enhancement: Better Z-Wave logging during start-up. Now
      commands will only be send when the Open Z-Wave lib is fully initialized

2012-10-11  alexie

    * FSettingsZWave.class: Enhancement: Only restart ZWave module if it is
      really required (prevents slow restarts of Open Z-Wave)

2012-10-09  rdnzl

    * Energy.module, server-load-1h.png, server-memory-1h.png: Fixed saving
      multiple rfxmeter type data in Energy module.

2012-10-03  rdnzl

    * CPlugwise.class, CRFXComTRX.class, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: Fixed bug in Plugwise code (removed test code),
      thanks Jos for reporting.Added Chime decode code to RFXComTRX Lighting1
      routine, thanks Re.

2012-10-02  rdnzl

    * .project, 01208to01209.sql, 01209to10000.sql, AVControl.module,
      Astro.module, Bluetooth.module, Bwired.module, CAsterisk.class,
      CCTX35.class, CCUL.class, CCurrentCost.class, CDSC.class, CDenon.class,
      CDomotica.class, CEIB.class, CEZcontrol.class, CFritzBox.class,
      CGPS.class, CHomeMatic.class, CIPort.class, CIRMan.class, CIRTrans.class,
      CIViewer.class, CItems.class, CJeeLabs.class, CK8055.class,
      CLEDMatrix.class, CLGTV.class, CLIRC.class, CNcid.class, COWFS.class,
      COWW.class, COnkyo.class, COpenTherm.class, CPLCBUS.class, CPioneer.class,
      CPlugwise.class, CPwrCtrl.class, CRFXComRX.class, CRFXComTRX.class,
      CRFXComTX.class, CRFXComxPL.class, CSMS.class, CSharpTV.class,
      CSmartMeter.class, CSqueezeServer.class, CTelnetServer.class,
      CTemp08.class, CTimerDelay.class, CTimerOnOff.class, CUPS.class,
      CVISCA.class, CWebServer.class, CWeeder.class, CXMLRPC.class,
      CZWave.class, Calendar.module, CallerID.module, CxPL.class, CxPLMsg.class,
      DNS.module, Devices.module, Digitemp.module, DomotiGa.gambas,
      DomotiGaServer.gambas, DomotiGaServer3.gambas, Energy.module,
      EventLoop.module, Events.module, FAbout.class, FActionEditor.class,
      FActionEditor.form, FActionScriptEditor.class, FBarcodes.class,
      FCamera.class, FCaptures.class, FClimate.class, FConditionEditor.class,
      FConstantEditor.class, FDSC.class, FDebug.class, FDeviceEditor.class,
      FEditBwiredDevices.class, FEditCameraDevices.class, FEditCategories.class,
      FEditContacts.class, FEditContacts.form, FEditDictionary.class,
      FEditDictionaryDetail.class, FEditEventThermostatProfiles.class,
      FEditGlobalVars.class, FEditGraphs.class, FEditMacro.class,
      FEditMarkers.class, FEditMenus.class, FEditModulesGroups.class,
      FEditNewsWeather.class, FEditNotify.class, FEditPachubeDevices.class,
      FEditTVChannels.class, FEditTVChannelsDetail.class,
      FEditTVProgramCategories.class, FEditTVProgramCategoriesDetail.class,
      FEmail.class, FEnergy.class, FEventEditor.class, FEventThermostat.class,
      FEvents.class, FFloorplanEditor.class, FFloorplans.class,
      FGraphsPreview.class, FHVAC.class, FHeatingEditor.class, FHome.class,
      FInstallDBWizard.class, FLocations.class, FLogfiles.class, FMain.class,
      FMain.form, FMusic.class, FMusic.form, FNetwork.class, FNews.class,
      FScenarioEditor.class, FScheduleEditor.class, FSecurity.class,
      FSelectDate.class, FSelectImage.class, FServerStats.class,
      FSettingsAsterisk.class, FSettingsAstro.class, FSettingsBluetooth.class,
      FSettingsBwiredMap.class, FSettingsCTX35.class, FSettingsCUL.class,
      FSettingsCallerID.class, FSettingsCamVisca.class, FSettingsCameras.class,
      FSettingsCurrentCost.class, FSettingsDSC.class, FSettingsDenon.class,
      FSettingsDigitemp.class, FSettingsDomotica.class, FSettingsEIB.class,
      FSettingsEZcontrol.class, FSettingsEmail.class, FSettingsFritzBox.class,
      FSettingsGLatitude.class, FSettingsGLatitude.form, FSettingsGMail.class,
      FSettingsGPS.class, FSettingsHDDTemp.class, FSettingsHome.class,
      FSettingsHomeMatic.class, FSettingsIPort.class, FSettingsIRMan.class,
      FSettingsIRTrans.class, FSettingsIViewer.class, FSettingsJeeLabs.class,
      FSettingsK8055.class, FSettingsLEDMatrix.class, FSettingsLGTV.class,
      FSettingsLIRC.class, FSettingsMain.class, FSettingsMySQL.class,
      FSettingsNcid.class, FSettingsOWFS.class, FSettingsOnkyo.class,
      FSettingsOpenTherm.class, FSettingsOww.class, FSettingsPLCBUS.class,
      FSettingsPachube.class, FSettingsPing.class, FSettingsPioneer.class,
      FSettingsPioneer.form, FSettingsPlugwise.class, FSettingsPwrCtrl.class,
      FSettingsRFXComRX.class, FSettingsRFXComTRX.class,
      FSettingsRFXComTX.class, FSettingsRFXComxPL.class, FSettingsRRDTool.class,
      FSettingsSMS.class, FSettingsServerStats.class, FSettingsSharpTV.class,
      FSettingsShell.class, FSettingsSmartMeter.class, FSettingsSound.class,
      FSettingsSqueezeServer.class, FSettingsTVGuide.class,
      FSettingsTelnetServer.class, FSettingsTemp08.class,
      FSettingsTemperaturNu.class, FSettingsThermostat.class,
      FSettingsTwitter.class, FSettingsUPS.class, FSettingsVideoServer.class,
      FSettingsVoiceText.class, FSettingsWeatherBug.class,
      FSettingsWebServer.class, FSettingsWeeder.class, FSettingsX10Cmd.class,
      FSettingsZWave.class, FSettingsxPL.class, FTVGuide.class,
      FTVGuideChannelDetail.class, FTVGuideProgramDetail.class,
      FTVGuideSearchDetail.class, FTextViewer.class, FThermostat.class,
      FToolsBluetoothBrowser.class, FToolsCULCmdr.class,
      FToolsHomeMaticQuickSet.class, FToolsPLCBUSCmdr.class,
      FToolsRFXComCmdr.class, FToolsRFXComCmdr.form, FToolsSerialMon.class,
      FToolsSerialPorts.class, FToolsZWaveCmdr.class, FTriggerEditor.class,
      FWeather.class, GLatitude.module, HDDTemp.module, JSON.module,
      Mail.module, Main.module, Pachube.module, Ping.module, RRDTool.module,
      ScreenFunc.module, ServerStats.module, Shell.module, Sounds.module,
      TVGuide.module, TemperaturNu.module, Thermostat.module, Twitter.module,
      VideoServer.module, VoiceText.module, X10Cmd.module, XMLParser.module,
      domotiga-empty.sql, domotiga.sql: New version 1.0.000, you must upgrade
      your database.Please make a backup of your database and DomotiGa directory
      tree first!Fix bug in RAIN2 total rain value for RFXComTRX, thanks Sol-R
      for reporting.Made x10cmd command database field longer, thanks
      Rawin.Added AV control support for Pioneer receivers, tested with Pioneer
      VSX 1018-AH, thanks BreFa!Correctly enabling input fields of Shell
      settings form, thanks Teus.Check if DomotiGa is started as root and warn
      the user about security risk.Don't save zero usage records to the database
      in Energy module, thanks Teus!Removed Squeezeplayer debug messages.Fixed
      several Squeezeplayer GUI problems.Fixed bug whe controlling AC devices in
      RFXComTRX Commander, thanks Edwin for reporting.Added code to support new
      message responses of latest RFXComTRX firmware. (tested with 49)Added
      support for HomeEasy HE105 and RTS10 thermostats to RFXComTRX, thanks
      Tim!Fixed online caller find code for CallerID module.Rearranged Contact
      Editor layout.Added check for illegal characters in DS names upon saving
      device.Fixed all Copyrights strings.

2012-09-05  alexie

    * DomoZWave.cpp, DomoZWave.h: Enhancement: Updated the Open Z-Wave wrapper
      to improve the logging and restructured the code in the files to make it
      more readable. Also included a procedure to determine the version of the
      wrapper to make future upgrades easier to detect.

2012-08-31  rdnzl

    * udev_rules: Added example udev rules file.

    * CRFXComTX.class, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, FCalendar.class, FControl.class,
      FDeviceEditor.class, FDevices.class, FEditUsers.class,
      FSettingsXMLRPC.class, FSplashScreen.class, Main.module: Corrected
      copyright notices.Added Google Translate API-key support (not functional
      yet)Added user cookie support for encryption, thanks Teus.

2012-08-29  rdnzl

    * DomotiGa.gambas, DomotiGaServer3.gambas, FEditContacts.class: Make looking
      up the contact with phonenumber work.

    * DomotiGa.gambas, DomotiGaServer3.gambas, FEditContacts.class,
      FPhone.class: Only show related contact when double clicking it's row on
      phone page.

    * CRFXComRX.class, CRFXComTX.class, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: Added RFXComTX reconnect tcp socket code when
      failed to write.

    * CFritzBox.class, CIRTrans.class, COpenTherm.class, CRFXComTRX.class,
      CallerID.module, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, Energy.module, FEditUsers.class, FEditUsers.form,
      FMain.class, FMain.form, FSplashScreen.class, Main.module,
      ServerStats.module: Corrected several copyright notices.Update contact
      fields when callerid gets triggered.Encrypt user passwords in database,
      thanks Teus.Provide menu item for users to change their user account.

2012-08-27  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      binaries.

    * Main.module: Disable Google Translate when it requires authentication,
      thanks Teus.

    * CFritzBox.class, CNcid.class: Correctly display minutes in callerid
      messages.

2012-08-24  rdnzl

    * GLatitude.module: Correctly detect missing latitude location fields.

    * FToolsDatabaseAdmin.class: Remember mysql backup path between updates.

    * DomotiGa.gambas, DomotiGaServer3.gambas, FMain.class: Removed the test
      version compare.

2012-08-23  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas,
      FMain.class, FSettingsGUI.class, XMLClient.module: Now DomotiGa in client
      mode checks if the XMLRPC module is enabled upon startup.Also checks if
      the configured service can be reached.And it will check if the server and
      client program versions match.It will report if something is wrong.

    * FMain.class, FSplashScreen.class, HDDTemp.module: Only mail high HDD temps
      once per 30 minutes, report OK temps too, thanks Teus.Don't tweak
      globalvars upon startup in client mode.

2012-08-22  rdnzl

    * FToolsDatabaseAdmin.class: Use minutes and seconds in database backup
      filename.

2012-08-12  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas,
      Main.module: Fixed wrong call in Setup_SmartMeter.

2012-08-12  alexie

    * Main.module: Fixed: iX10CmdType was always set to 0

2012-08-11  alexie

    * Calendar.module, FEvents.class: Fixed: Doubleclick in Event List could be
      unpredictable in gambas2Fixed: Display of Date variable changed in
      gambas3. Make it backwards compatible with DomotiGa

2012-08-10  alexie

    * Main.module: Fixed: The device table also sorts the icon now (Bug #164
      partially implemented).

    * FDevices.class: Fixed: While doubleclicking in Device List, can cause a
      fatal error in gambas3 (and is unpredictable in gambas2)

    * Main.module: Fixed: Setup_Astro used Array instead of String[], Gambas3
      doesn't support this anymore

    * .project: Update: DomotiGa/Server Gambas project versions all set to
      0.1.209 now

2012-08-10  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      binaries.

2012-08-10  alexie

    * FSplashScreen.class, Main.module: Fixed: UDP Broadcast was broken in r942.
      Also if an invalid UDP port (<1 & >65535) is assigned, this will result in
      an error message

    * CZWave.class, FSettingsZWave.class, FSettingsZWave.form, Main.module:
      Z-Wave: Now it is possible to poll listening devices for their values like
      Watt, kWh, etc. Especially handy for GreenWave devices (1-port and 6-port
      are succesfully tested)

2012-08-08  alexie

    * DomoZWave.cpp: Also updated DomoZWave.cpp, part of the r940 fix

2012-08-07  rdnzl

    * domotiga-empty.sql, domotiga.sql: Updated install files.

    * .project, 01208to01209.sql, CCurrentCost.class, CFritzBox.class,
      CIRTrans.class, COpenTherm.class, CPlugwise.class, CRFXComTRX.class,
      CSmartMeter.class, CZWave.class, Calendar.module, CallerID.module,
      Devices.module, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, Energy.module, FCalendar.class,
      FDeviceEditor.class, FDeviceEditor.form, FEditContacts.class,
      FEditContacts.form, FMain.form, FPhone.class, FSplashScreen.class,
      FSplashScreen.form, FTVGuide.class, Main.module, ServerStats.module,
      X10Cmd.module, anslut-module.jpg, chacon-module.jpg, domotiga.apache,
      domotiga.debian, la-crosse-tx-17.jpg, la-crosse-tx-3th.jpg,
      la-crosse-tx-4th.jpg, la-crosse-ws2300.jpg, logrotate.d.domotiga,
      tfa-dostmann-rain-sensor.jpg, tfa-dostmann-ts34c.jpg, viking-02035.jpg,
      viking-02038.jpg: New version 0.1.209, you must upgrade your
      database.Please make a backup of your database and DomotiGa directory tree
      first!Now only init/bind BroadCastEvent socket once, not with every
      message.Fixed clearing of logfile text to save memory (50%) and prevent
      first new line to be deleted if buffer is full.Thanks Alex!Added support
      to RFXComTRX code for following sensors:TFA TS15C (248) temp6Viking 02811
      251 temp7Viking 02038 (250)Viking 02035 (249)LaCrosse WS2300
      (247)RUBiCSONUPM RG700 rain4UPM WDS500 rain5Added those as devicetypes
      too.Added support for Smartmeter energy logging, thanks Nico!Added energy
      db table power_exported.Fixed Error 'Result is not available' at
      'Energy.Log.29Flush debuglog buffers after every write.Fixed
      FindCallerIdOnline, changed URL.Phone numbers in CallerID module with
      length of 4 or shorter are treated as internal numbers,and thus not
      expanded.Expanded Contacts table with extra fields.Only allow 3 false
      login attempts.Added sample config files for apache, debian startup and
      logrotate.Only display e-mail counters if gmail is enabled.Thanks
      Teus!IRTrans socket now reconnects if connection is lost. (needs
      testing)Added poll field to devices table (for ZWave polling)Added poll
      crontab field to ZWave settings table.Display backtrace in error messages
      if DomotiGa aborts.Fixed dim cycle issue for RFXTrx Lighting2 dimmers.
      (needs testing)

2012-08-07  alexie

    * FDeviceEditor.class: Device Editor can give an error if the groupname is
      blank or duplicate

    * Devices.module: Some Z-Wave devices only give 0-99% back, 99% is also "On"
      now

2012-08-06  rdnzl

    * ServerStats.module: Added fix for RRDtool ServerStats when using other
      language, thanks Teus.

2012-08-05  alexie

    * FControl.class: Really fix out of file descriptor error due to empty icon
      strings.

2012-08-05  rdnzl

    * FSettingsXMLRPC.class: Enable save button after changing port number,
      thanks Alex.

    * FControl.class: Fix problems if device status icons are empty, thanks
      Alex.

2012-08-03  rdnzl

    * FDevices.class: Fixed copyright string.

    * COpenTherm.class: Fixed OpenTherm sync clock command, thanks Frank.

    * DomotiGa.gambas, DomotiGaServer3.gambas: Updated binaries.

    * FDevices.class, FDevices.form: Added checkbox to Devices form to display
      hidden devices, hide by default.

2012-08-02  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      binaries.

    * Main.module: Catch errors when displaying broadcast UDP errors.

2012-07-06  rdnzl

    * index.php: Fixed sorting of table contents, thanks Giuseppe.

2012-06-28  rdnzl

    * index.php: Another attempt to fix tab problem.

    * index.php: Made tabs work again, thanks Giuseppe!

    * CRFXComTRX.class, DomotiGaServer.gambas, DomotiGaServer3.gambas,
      Main.module: Added missing SmartMeter code, and corrected version string.

2012-06-26  rdnzl

    * DomotiGa.gambas, DomotiGaServer3.gambas, FSettingsAstro.class,
      FSettingsAstro.form: Changed location settings boxes to valuebox so only
      numbers are valid.

2012-06-24  tickett

    * FToolsRFXComCmdr.form: Removed test buttons.

    * FToolsRFXComCmdr.form: Added missing N housecode for lighting1, and
      corrected spelling for transceiver.

2012-06-20  rdnzl

    * CCurrentCost.class, Devices.module, DomotiGa.gambas,
      DomotiGaServer.gambas, DomotiGaServer3.gambas: Make CurrentCost autodevice
      creation work.

2012-06-15  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas,
      FSettingsX10Cmd.class, FSettingsX10Cmd.form, X10Cmd.module: Added support
      to control CM17a via heyu with X10Cmd module.

2012-06-14  rdnzl

    * FHome.class, FHome.form: Removed strange characters in front of Celsius
      signs on home screen weather.Resize the home screen area correctly.

2012-06-11  rdnzl

    * index.php, json.php: Replaced all left over import_request_variables calls
      with replacement call to support PHP 5.4.0+

2012-06-09  rdnzl

    * CSmartMeter.class, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: Fixed parsing of P1 telegrams. Please test.

    * FDeviceEditor.class: Fix lost change.

    * FDeviceEditor.class: Also delete log data of a deleted device.

2012-06-07  rdnzl

    * DomotiGa.gambas, DomotiGaServer3.gambas, FToolsRFXComCmdr.form,
      compile.sh: Check for gambas install in compile.shGroup protocol buttons
      correctly in RFXComCmdr RX.

2012-06-05  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      binaries.

    * CXMLRPC.class: Set correct return code for XMLRPC updategraph call.

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      binaries.

    * FToolsRFXComCmdr.class: Fixed X10 address format in RFXCommander.

    * device.php, index.php, json.php: Replaced
      'import_request_variables("gp","r_");' which is no longer supported in php
      5.4.0.Thanks JJ.

    * index.php, json.php, settings.php: Replaced
      'import_request_variables("gp","r_");' which is no longer supported in php
      5.4.0.Thanks JJ.

    * domotiga.sql: Added missing thermostat_constant table creation, thanks JJ!

    * FDeviceEditor.class, FEventEditor.class, FEvents.class, FEvents.form: By
      default display all events, you can hide the disabled ones with the
      checkbox now.Only ask to enable device when newly created, same for
      events.Added more sanity checks to insert/move event action code.Fixed a
      few typos, thanks to Alex for all these changes/bugfixes.

2012-06-04  rdnzl

    * CSmartMeter.class: Better debug logging.

    * FSettingsZWave.class: Better settings field enable/disable code.

    * DomotiGa.gambas, DomotiGaServer3.gambas: Updated binaries.

    * FSettingsZWave.class: Enable save button when poll sleeping and update
      network checkboxes are changed.

    * FEvents.class: Fixed bug fix for empty events list.

2012-06-03  rdnzl

    * CSmartMeter.class, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: Changed address of P1Mbus meters from
      P1-MBus<type> to P1-MBus<channel>.

    * .project, 01207to01208.sql, CRFXComTRX.class, CSmartMeter.class,
      CZWave.class, Devices.module, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, FEditMacro.class, FEvents.class, FMain.class,
      FMain.form, FSettingsRFXComTRX.form, FSettingsSmartMeter.class,
      FSettingsSmartMeter.form, Main.module, RRDTool.module, domotiga-empty.sql,
      domotiga.sql: New version 0.1.208, you must upgrade your database.Please
      make a backup of your database and DomotiGa directory tree first!Added
      support for Dutch smart meters based on the NTA8130 protocol (P1).It will
      parse power, and all other MBus connected metering telegrams.See wiki
      Smart Meter page for more info.Fixed bugs related to empty macro lists and
      edit, delete buttons.Fixed bug when double clicking an empty events list,
      thanks Alex!

2012-05-30  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      binaries.

    * RRDTool.module: Fixed wrong color of min values in extended graphs, thanks
      Joost!

    * CZWave.class: Added optional size param to setconfigparam routine.

2012-05-29  rdnzl

    * DomoZWave.cpp, DomoZWave.h: Added support for size value to setconfigparam
      code in OZW wrapper.

    * CRFXComTRX.class: Catch errors in RFXComTRX protocol setup code.

    * .project, 01206to01207.sql, CEIB.class, COpenTherm.class, CZWave.class,
      Devices.module, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, EventLoop.module, FLogfiles.class,
      FSettingsShell.class, FSettingsZWave.class, FSettingsZWave.form,
      FToolsZWaveCmdr.form, FTriggerEditor.form, Main.module, Shell.module,
      cresta-tx320.jpg, domotiga-empty.sql, domotiga.sql,
      duwi-shade-controller.jpg, duwi-switch.jpg, ezmotion-100.jpg: New version
      0.1.207, you must upgrade your database.Please make a backup of your
      database and DomotiGa directory tree first!Shell interface, you can now
      also call scripts for switching.When clicking button of a switchable Shell
      device it will call the script with "On", "Off"Enter 0 as polltime to
      disable polling for values.Added update neighborhood and poll sleeping
      nodes cron settings and functionality to open-zwave.Use cron format to
      specify both.Added some known devicetypes for z-wave.Added Cresta to
      RFXCom device types.Fixed bug in device log with calibrated values.Thanks
      Alex.Use tooltips from crontab field to show format.Made columns of table
      in Z-Wave cmdr resizable.Changed constant names in EIB code to be Gambas3
      proof.Replaced CFlt function with CFloat to be Gambas3 proof.

2012-05-22  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      binaries.

    * CZWave.class, DomoZWave.cpp, DomoZWave.h, FToolsZWaveCmdr.class,
      FToolsZWaveCmdr.form: Open Zwave changes, nodeevents are mapped to
      instance 1, value 1.Added notification types for buttons (for remote
      controls)Added all other notification types to logging.Added call for
      RequestNodeDynamic, can be use to request value updates from events
      asworkaround for meterreports.

    * RRDTool.module: Fixed an RRDTool bug when fetching device id.

2012-05-21  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      binaries.

    * CZWave.class, FToolsZWaveCmdr.class: Correctly disable/enable OZW
      polling.Display device manufacturer and model in ZWave Commander.

2012-05-19  rdnzl

    * CZWave.class, DomoZWave.cpp, DomoZWave.h: Check if HomeId is known before
      calling OZW calls, to prevent crash.Added several node info routines for
      future use, thanks Alex.

    * FSettingsThermostat.class: Validate input before saving settings.

    * FSettingsZWave.class: Validate polltime input before saving settings.

    * DomoZWave.cpp: Only log OZW to file, disable console output.Enable
      detailed logging again.If polltime is set to 0 then disabled polling.
      (needs more work)Made timestamp log output same format as OZW log
      format.Thanks Alex for the suggestions.

    * FEventEditor.class: Display new event actions correctly.

2012-05-18  rdnzl

    * CDSC.class, CHomeMatic.class, COpenTherm.class, CRFXComTRX.class,
      CXMLRPC.class, Devices.module, DomotiGaServer3.gambas, Energy.module,
      Events.module, Main.module, RRDTool.module: Fixed commit of
      DomotiGaServer3 files.

    * 01205to01206.sql, CHomeMatic.class, COpenTherm.class, Devices.module,
      DomoZWave.cpp, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, Events.module, FMain.class, FMain.form,
      FSettingsHomeMatic.class, FSettingsHomeMatic.form,
      FSettingsOpenTherm.class, FSettingsOpenTherm.form,
      FToolsHomeMaticQuickSet.class, FToolsSerialPorts.class,
      FToolsZWaveCmdr.class, Main.module, RRDTool.module, domotiga-empty.sql,
      domotiga.sql: New version 0.1.206, you must upgrade your database.Please
      make a backup of your database and DomotiGa directory tree first!Added
      support for controlling and monitoring your Central Heating through the
      use of an OpenTherm gateway.Read the OpenTherm page on the for more
      information, more to come.Thanks BreFa!Updated HomeMatic code to the
      latest version, these is the changelog:New stack management to avoid
      WAIT's.Temperatures can be controlled through Actions.Detection and
      recovery from failed communication, including retransmission of failed
      commands.Various bugfixes (removal of hardcoded address, debug log
      writes).HomeMatic Module disabled if initial connection unsuccessful.
      Leaving it on allows commands to be sent, which should not be.Changed line
      243 in devices.module to Main.hHM.SendCommand(iDeviceId, "Temperature " &
      sValue).Modified Quickset to be in line with Devices.SetDevice.Modified
      HomeMatic.SendCommand to be in line with Devices.SetDevice."Set
      Temperature" now stored in sValue, rather than sValue3, to be in line with
      Events.RunAction.Rewrite, better stack handling, 4 levels of debug info,
      signal strength in debug.Using auto device create (with minor mod to
      autocreate).Don't disable interface after communication errors.Thanks
      JvdK!Fixed bugs in Event conditions when using < and/or >, thanks
      Alexie!Added RFXComTRX to known interfaces in ToolsSerialPorts
      overview.Added timestamps to OZW logging, thanks Alexie.

2012-04-28  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas,
      Main.module: Don't check for rrdtool command in client mode.

    * CDSC.class: Corrected incorrect named DSC interfaces.

2012-04-27  rdnzl

    * DomoZWave.cpp: Translate command basic value 1 to on in ozw-wrapper, needs
      testing!

    * DomotiGa.gambas, DomotiGaServer3.gambas, FEditGraphs.class, FMain.class:
      Make sure datasource is correctly save in Graph Editor.Delete previous
      graph image before downloading next one.

    * DomotiGa.gambas, DomotiGaServer3.gambas: Update binaries.

    * FActionScriptEditor.form, FDeviceEditor.class, FDeviceEditor.form,
      FEditGlobalVars.class, FEvents.class, FEvents.form, RRDTool.module: Adapt
      row height in event view if action scripts have more lines in them.Display
      more details of various event actions in overview.Globalvar value can be
      one character long now in Globalvar editor.Check if DS names have no
      spaces in them before saving device.

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas,
      Energy.module: Catch errors in Energy module and report them in debug log.

2012-04-26  rdnzl

    * .project, CXMLRPC.class, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, FMain.class, FSettingsGUI.form, XMLClient.module:
      Clients now send an xmlrpc request to the server to update RRDtool graphs.

2012-04-25  rdnzl

    * DomotiGa.gambas, DomotiGaServer3.gambas: Updated binaries.

    * FDeviceEditor.class: Remove errors when using empty database.

    * Devices.module, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, FEventEditor.class, FEventEditor.form: Fixed
      action order in event editor, added scrollbar.

2012-04-24  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      binaries.

    * CHomeMatic.class: Small code cleanup.

    * 01204to01205.sql, CHomeMatic.class, FSettingsHomeMatic.class,
      FSettingsHomeMatic.form, FToolsHomeMaticQuickSet.class,
      FToolsHomeMaticQuickSet.form, domotiga-empty.sql, domotiga.sql: HomeMatic
      patches added, thanks JK.Replaced SLEEP command by WAIT command back
      in.Improved Quickset module (show only enabled devices)Improved HomeMatic
      class.Added stack analyzer, reports every 20 seconds in debuglog.Moved
      reported HMLAN firmware, serial and address to the setup area.This reports
      what the adapter thinks it has, not what we think it has been set to.These
      should be identical or no commands will execute.Corrected address format
      example in database.

    * CDSC.class: Correctly find device type of DSC devices.

    * CRFXComTRX.class, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: Fix address format for decoding RFXtrx Lighting2
      (AC) & Lighting5, thanks Niels.

    * DomotiGa.gambas, DomotiGaServer3.gambas: Updated binaries.

    * FInstallDBWizard.form: Enable option to install empty database in wizard.

2012-04-23  rdnzl

    * domotiga-empty.sql, empty.sql: Changed demo database name.

    * empty.sql: Also removed camera definitions.

    * empty.sql: Provide empty database import.

    * 01204to01205.sql: Don't enable HomeMatic module by default, added default
      values.

2012-04-22  rdnzl

    * domotiga.sql: Fixed database sql errors.

2012-04-21  rdnzl

    * CPlugwise.class, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: Fixed return type in Plugwise code.

    * CXMLRPC.class: Fixed some typos.

    * .hidden, .project, 01204to01205.sql, Astro.module, CDSC.class,
      CFritzBox.class, CHomeMatic.class, CPlugwise.class, CRFXComTRX.class,
      CSqueezeServer.class, CXMLRPC.class, CZWave.class, Devices.module,
      DomoZWave.cpp, DomoZWave.h, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, FEditBwiredDevices.class, FMain.class, FMain.form,
      FMusic.class, FMusic.form, FSettingsDSC.class, FSettingsDSC.form,
      FSettingsHomeMatic.class, FSettingsHomeMatic.form, FSettingsZWave.form,
      FToolsHomeMaticQuickSet.class, FToolsHomeMaticQuickSet.form,
      FToolsZWaveCmdr.class, FToolsZWaveCmdr.form, Main.module,
      VoiceText.module, XMLClient.module, domotiga.sql, green-icon.png,
      red-icon.png: New version 0.1.205, you must upgrade your database.Please
      make a backup of your database and DomotiGa directory tree first!Added
      support for UPM/ESIC WT440/WT450H sensors to RFXComTRX module.Still needs
      some minor changes to the code to be 100% up to date with RFXtrx433
      firmware version 31.Added database fields and first code to support DSC
      IT100 interface, thanks Tradiuz!Renamed 'DSC5401 Interface' to 'DSC
      Interface'.Added missing Fritz!Box reconnect timer init code.Added first
      code for HomeMatic thermostat support (using HMLAN Interface), thanks
      JK!Added player control GUI for SqueezePlayers to Music page, thanks
      Sebastiaan!Updated XMLRPC interface with squeezeplayer methods.Changed
      ZWave polltime for Seconds to mS (open-zwave API changed)Added several
      functions to ZWave commander.Updated open-zwave wrapper to follow latest
      open-zwave API changes. (revision 525)Make sure you delete or rename your
      zwcfg*.xml file (in wrapper directory),otherwise you may get unexpected
      behavior.You also need to remove it when you change poll settings in
      DomotiGa.Fixed bug not updating device values when value was 0, thanks
      JK.Fixed Plugwise CRC calculation for leading zero values, thanks again
      JK!Don't delete globalvar table on save, just truncate it, hopefully more
      stable.Add an hour to sunset/rise if Daylight Saving is enabled, must be
      tested.

2012-04-04  rdnzl

    * CRFXComTRX.class, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas: Fixed bug with case insensitive AC address group
      compare for older Gambas version.Fixed Group On/Off command parsing in
      RFXComTRX class.Thanks ReWind!

2012-03-11  rdnzl

    * CRFXComTRX.class, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, compile.sh: Fixed RFXComTRX Lighting2 address
      decoding.Check your device addresses.

2012-03-04  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas: Updated binaries.

2012-02-27  rdnzl

    * 01202to01203.sql: Added forgotten settings_zwave table changes.

2012-02-26  rdnzl

    * CRFXComTRX.class: Corrected a typo for Impuls sendcommand routine.

    * CRFXComTRX.class, DomotiGa.gambas, DomotiGaServer.gambas,
      FToolsRFXComCmdr.class, FToolsRFXComCmdr.form: Added Harrison curtain
      control support to RFXComTRX.

    * CRFXComTRX.class, DomotiGa.gambas, DomotiGaServer.gambas,
      FToolsRFXComCmdr.class, FToolsRFXComCmdr.form: Added LightwaveRF transmit
      to RFXComTRX code.

    * DomotiGa.gambas, DomotiGaServer.gambas, FSettingsVoiceText.class,
      FSettingsVoiceText.form, VoiceText.module, compile.sh: Added support for
      picotts engine.Added compile script to compile binaries.

    * DomotiGa.gambas, DomotiGaServer.gambas, FDeviceEditor.class: Fixed error
      in DeviceEditor while loading empty device lastchanged field.

    * CRFXComTRX.class: Correctly parse Tamper status for securiy devices.

    * DomoZWave.cpp: Parse basic report messages from poll requests in
      open-zwave wrapper.

    * CRFXComTRX.class: More fixes for security packet decoding.

    * CRFXComTRX.class: Fix for decoding RFXComTRX security packets.

2012-02-25  rdnzl

    * .project, 01203to01204.sql, CIRTrans.class, CNcid.class, CRFXComTRX.class,
      CRFXComxPL.class, CXMLRPC.class, CZWave.class, Calendar.module,
      Devices.module, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, EventLoop.module, Events.module,
      FActionEditor.class, FActionScriptEditor.class, FCalendar.class,
      FCalendar.form, FConditionEditor.class, FConstantEditor.class,
      FDeviceEditor.class, FDeviceEditor.form,
      FEditEventThermostatProfiles.class, FEditGraphs.form, FEditMacro.class,
      FEditMacro.form, FEditMenus.class, FEditMenus.form, FEventEditor.class,
      FEventThermostat.class, FEventThermostat.form, FEvents.class, FHome.class,
      FHome.form, FMain.class, FMain.form, FSettingsMain.class,
      FSettingsMain.form, FSettingsRFXComTRX.class, FSettingsRFXComTRX.form,
      FThermostat.class, FToolsDatabaseAdmin.class, FToolsRFXComCmdr.class,
      FToolsRFXComCmdr.form, FTriggerEditor.class, Main.module, RRDTool.module,
      XMLClient.module, domotiga.sql: New version 0.1.204, you must upgrade your
      database.Please make a backup of your database and DomotiGa directory
      first.Added LogPrefix setting this will be prefixed to server broadcast
      messages.Only needed if you run more than one DomotiGa server on your LAN
      (for development)Added support for the new RFXComTRX Tranceiver, decoding
      of all received protocols is supported.also transmitting of most used
      lighting protocols is implemented, more added later.New devices added: La
      Crosse TX3/4/17, TFA TS34C/Rain/Uv/Wind, Chacon EMW200, Impuls.New
      features build and shared by Francois:It is now possible to enable/disable
      events from an action script.Added a macro editor Events->Edit Macro.A
      macro is a formula used in conditions (and action, but not done yet).One
      can manage these macro's from the new menu entry:The macro are available
      in the condition editor. This helps having readable scripts.Note: you
      cannot use macro inside another macro.Added a calendar editor
      Edit->Calendar.You can select days and the calendar module will
      automatically compute and maintain a globalvarcalled NextPlanning which
      holds the closest next selected day.This global var can then be used for
      some specific events.Two new options added to device editor option tab:One
      is 'repeat state', the current state of the device is sent again each X
      minutes.Useful for non reliable (non bi-directional) devices.Second is
      'reset state' which resets (valueUpdate or setDevice if switchable) the
      stateof a device after X minutes with a given value.Useful for lets say
      PIR devices where you can miss the back to normal signal.Thanks
      Francois!Fixed bug in scenario editor result in error while adding
      scenario.Stop K8055 poll timer while restarting module.

2012-02-24  rdnzl

    * CZWave.class, DomoZWave.cpp, DomoZWave.h, FToolsZWaveCmdr.class,
      FToolsZWaveCmdr.form: Added more open-zwave wrapper debugging.Added
      AddAssociation button to commander.Enable Remove node mode by
      default.Rearranged commander buttons.Added support for ZWave Aeon
      Door/Window sensor (Open/Close, Tamper/Secure, Battery status)

    * FScenarioEditor.class: Fixed error when creating thermostat scenario.

2012-02-20  rdnzl

    * DomoZWave.cpp: Added command class metering to open-zwave wrapper code.

2012-02-16  rdnzl

    * CRFXComxPL.class: Log battery status with capital first letter.

2012-02-15  rdnzl

    * RRDTool.module: Fixed problem with # in devicename, this failed to show
      preview graph in editor.Fixed bug only displaying first graph of a
      category.Fixed bug not showing extended graphs.Convert RRD value when
      value is On/Off, Motion/No Motion, Open/Closed.

2012-02-13  rdnzl

    * stylesheets: Removed unused directory.

    * COPYING, README, actions.png, aibo.gif, asterisk.png, bell.png, bt.png,
      button.gif, car.png, cd.png, change_device.php, change_housemode.php,
      charts.png, climate.png, clock-off.png, clock-on.png, clock-red.png,
      clock.png, close.gif, comment.png, common.js, computer.png,
      conditions.png, config.php.example, contacts.png, control_device.php,
      controller.png, cup.png, database.png, devices.png, domotiga.js,
      door-closed.png, door-open.png, drive-web.png, drive.png, email.png,
      energy.png, events.png, fan-off.gif, fan-on.gif, favicon.ico, film.png,
      fire-off.png, fire-on.png, floorplans, functions.php, gas.gif,
      get_device.php, gps.png, group.png, groups.png, gsm.png, hd.png, heyu.png,
      home.png, htaccess.example, hvac.gif, hygro.png, icons, images, index.php,
      iphone.css, ipod.png, irman.png, json.php, keyboard.png, led-off.png,
      led-on.png, light-dim.png, light-off.png, light-on.png, list.png,
      loading.gif, loading.html, lock-open.png, lock.png, logo.png, logs.png,
      mail-off.png, mail-on.png, maskBG.png, mobile, modules.png, monitor.png,
      motion-off.gif, motion-on.gif, mpd.png, mute.png, new.png, news.png,
      pc-off.gif, pc-on.gif, phone.png, printer-empty.png, printer.png,
      question.png, rain.png, scale.png, schelf2.jpg, schelf4.jpg, security.png,
      serial.png, serialterm.png, settings.png, smoke.png, sms.png, sound.png,
      status-offline.png, status-online.png, stock.png, style.css, stylesheets,
      subModal.css, subModal.js, submodal, sun.png, sunset.png, temp.gif,
      time.png, triggers.png, tux.png, tv.png, ups.gif, user-female.png,
      user-gray.png, user.png, users.png, vars.png, voice.png, webcam.png,
      webserver.png, wifi-off.png, wifi-on.png, wire.png, world.png, x10.gif:
      Added very early example of mobile webclient based on floorplan.Thanks to
      Gino.

2012-02-12  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas: Updated binaries.

    * .project, 01202to01203.sql, AUTHORS, CNcid.class, Devices.module,
      FDeviceEditor.class, FEditGraphs.class, FEditGraphs.form, FEnergy.class,
      FInstallDBWizard.class, FInstallDBWizard.form, FMain.class, FMain.form,
      FSettingsGUI.class, FSettingsGUI.form, FSettingsNcid.class,
      FSettingsNcid.form, FSplashScreen.class, Main.module, README,
      RRDTool.module, domotiga.sql: New version 0.1.203, you must upgrade your
      database.Please make a backup of your database and complete DomotiGa
      directory first.Added support for Ncid callerid, thanks Mike!Regrouped
      callerid modules under callerid menu.Changed support e-mail address in
      several files.Fixed missing device name in graph editor after loading
      graph.Changed RRDtool, it now uses the device id as rrd filename instead
      of device name.Existing RRD files using old names are renamed upon first
      access.Prevents problems when renaming device.Added support to show rrd
      graphs in server/client mode.Set GraphUrl to correct path, and configure
      your webserver so they can be accessed via this url.See wiki
      http://domotiga.nl/projects/domotiga/wiki/Clients#Graphs for config
      example.Start database install wizard when a database is not found. (GUI
      mode only)Don't crash if support or donate menu are chosen on computer
      without internet connection.Don't run Astro module twice on
      startup.Correctly stop Google Latitude timer upon restart of
      module.Corrected setup instructions and directory layout in README file.

2012-02-08  rdnzl

    * DomoZWave.cpp: Added more debug output to open-zwave wrapper.

2012-02-07  rdnzl

    * RRDTool.module: Display group in RRDtool graph not found debug messages.

    * FLogfiles.class: Fixed bug on log devices form, thanks Reno!

    * DomoDroid.apk, DomotiGApp.apk, domodroid, domotigapp, string.xml,
      strings.xml: Renamed DomoDroid to DomotiGApp due to conflict with
      Domogik's android client.

2012-02-06  rdnzl

    * FSettingsMain.class, FSettingsMain.form: Add option of setting the
      logbuffer size from main settings.

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      all binaries.

    * .project: Updated support e-mail address.

    * .project, Bluetooth.module, CFritzBox.class, CJeeLabs.class, CK8055.class,
      COWFS.class, CPlugwise.class, CXMLRPC.class, CZWave.class, Devices.module,
      Events.module, Main.module, Ping.module, Shell.module, X10Cmd.module:
      Updated code from DomotiGaServer.

    * CXMLRPC.class: Added missing update for DomotiGaServer.

    * CXMLRPC.class, CZWave.class, DomoZWave.cpp, DomoZWave.h,
      FToolsZWaveCmdr.class: Made value change notifications from open-zwave
      devices work again, also for non byte values.Added support for ZWave
      Luminance, Temp and Power sensors.Added support for logging battery status
      of ZWave devices.Added support for logging Power usage of Aeon Smart
      modules.Started with coding support for ZWave Thermostats, please send in
      your open-zwave log, so I can complete it!Added device.getstate xmlrpc
      method, requested by Gino.Renamed xmlrpc method zwave.basicreport to
      zwave.setvalue and added support for instances.Enhanced ZWave Commander to
      display more than one device value.

2012-02-02  rdnzl

    * FEditCameraDevices.class, FEditCameraDevices.form: Disable VISCA address
      spinbox for Foscam/Watchbot camera's.

    * FCamera.class, FCamera.form: Added support for switching IO pin high/low
      for Foscam/Watchbot camera's.

    * FCamera.class, FEditCameraDevices.class: Added support for Foscam/Watchbot
      PT cameras.Changed Mplayer labels to VLC in CameraEditor.Fixed
      authentication url for VLC and wget.

2012-02-01  rdnzl

    * CZWave.class: Removed unused external open-zwave library calls.

2012-01-29  rdnzl

    * CXMLRPC.class, CZWave.class, DomoZWave.cpp, DomoZWave.h,
      FToolsZWaveCmdr.class, FToolsZWaveCmdr.form: Added open-zwave wrapper
      support to ZWave module for multi-instance devices like Fibaro FGS221.You
      need to recompile the DomoZWave wrapper too.

2012-01-25  rdnzl

    * CZWave.class, DomoZWave.cpp, DomoZWave.h, FToolsZWaveCmdr.class,
      FToolsZWaveCmdr.form: Added SetConfigParam support for devices to
      open-zwave wrapper and ZWave Cmdr.

    * CZWave.class, DomoZWave.cpp, DomoZWave.h, FToolsZWaveCmdr.class,
      FToolsZWaveCmdr.form: Added support to ZWave in open-zwave mode foradding
      and removing devices, update neighborhood andnetwork status.

    * CFritzBox.class, Devices.module: Added reconnect timer to Fritz!Box
      module.

2012-01-17  rdnzl

    * FEventEditor.class, FEvents.class, FEvents.form: Fixed problem with
      categories in EventEditor.Added Show Disable option in Events view, thanks
      for the patches Francois!

    * Main.module: Write global vars to database every hour.

2012-01-16  rdnzl

    * FMain.class: Don't close timers and program handles before the user has
      confirmed this.

    * CZWave.class: Enlarge ZWave receive loop value to ensure all packets are
      read.This busy loop function has to be rewritten to more event based.Don't
      send a ZWave ACK response as answer on a ACK packet.

    * Events.module, FToolsZWaveCmdr.form: Make ZWave devices visual selectable
      in commander.

2012-01-08  rdnzl

    * CXMLRPC.class, Devices.module, Events.module, FActionEditor.class,
      FEventEditor.class, XMLClient.module: Fixed Run Now buttons in Action- and
      EventEditor, they work also in client mode.

    * Devices.module: Fixed error texts for FindInterface routine.

2012-01-07  rdnzl

    * CItems.class: Fixed out of bounds bug, raised limit from 100 to 255 items.

    * FControl.class, X10Cmd.module: Display slider on Control page for X10
      devices with extended x10 set.Display +/- bright/dim buttons if not
      set.Added Dim/Bright and PreDim support to X10Cmd module, needs testing.

2012-01-05  rdnzl

    * CZWave.class: Disable Z-Wave polling if polltime is 0.

    * CZWave.class, DomoZWave.cpp, DomoZWave.h, FSettingsZWave.class,
      FSettingsZWave.form, Main.module: Made polltime setting work for Z-Wave
      module in open-zwave mode.You have to recompile you open-zwave wrapper
      library.Added more debug messages for Z-Wave module in open-zwave mode.

2012-01-04  rdnzl

    * Ping.module, Shell.module: Better error checking.

    * Devices.module: Better error checking.

    * CPlugwise.class: Better error checking.

    * COWFS.class: Better error checking.

    * CK8055.class: Better error checking.

    * Bluetooth.module: Better error checking.

2012-01-02  rdnzl

    * Main.module: Removed duplicate IP setup call.

    * FToolsX10Cmdr.class: Removed debug message.

2012-01-01  rdnzl

    * CJeeLabs.class, FCamera.class, FCamera.form: Catch parse errors in JeeLabs
      module.

2011-12-30  rdnzl

    * CRFXComRX.class, CTimer.class, FControl.class: Cleanup code.Check if
      database connection is active for Control page.

    * Bluetooth.module, FDevices.class: Removed user column from Devices
      form.Removed hardcoded 'user is home' log message from Bluetooth
      module.You can now use events for that.

2011-12-29  rdnzl

    * FHome.class, FHome.form, Main.module, XMLParser.module: Added refesh
      checkbox to Home page.Enhanced logging of XMLParser.

    * FCamera.class, FCamera.form: Display the URL of the selected camera too.

    * FMain.class: Disable Bluetooth browser and RFXCom Cmdr if interfaces are
      disabled.

    * Bluetooth.module: Enhanced Bluetooth parsing and logging.Fixed problem
      with bogus scan output.

    * .project: Updated .project file for Gambas3.

    * AVControl.module, Astro.module, Bluetooth.module, Bwired.module,
      CAsterisk.class, CCTX35.class, CCUL.class, CCurrentCost.class, CDSC.class,
      CDenon.class, CDomotica.class, CEIB.class, CEZcontrol.class,
      CFritzBox.class, CGPS.class, CIPort.class, CIRMan.class, CIRTrans.class,
      CIViewer.class, CJeeLabs.class, CK8055.class, CLEDMatrix.class,
      CLGTV.class, CLIRC.class, COWFS.class, COWW.class, COnkyo.class,
      CPLCBUS.class, CPlugwise.class, CPwrCtrl.class, CRFXComRX.class,
      CRFXComTX.class, CRFXComxPL.class, CSMS.class, CSharpTV.class,
      CSqueezeServer.class, CTelnetServer.class, CTemp08.class,
      CTimerDelay.class, CTimerOnOff.class, CUPS.class, CVISCA.class,
      CWebServer.class, CWeeder.class, CXMLRPC.class, CZWave.class,
      CallerID.module, CxPL.class, CxPLMsg.class, DNS.module, Devices.module,
      Digitemp.module, Energy.module, EventLoop.module, Events.module,
      GLatitude.module, HDDTemp.module, JSON.module, Mail.module, Main.module,
      Pachube.module, Ping.module, RRDTool.module, ServerStats.module,
      Shell.module, Sounds.module, TVGuide.module, TemperaturNu.module,
      Thermostat.module, Twitter.module, VideoServer.module, VoiceText.module,
      X10Cmd.module: Updated DomotiGaServer3 files.

    * .project, 01201to01202.sql, COWFS.class, CRFXComRX.class, CRFXComTX.class,
      CRFXComxPL.class, DNS.module, Devices.module, DomotiGa.gambas,
      DomotiGaServer.gambas, DomotiGaServer3.gambas, FControl.class,
      FDebug.class, FDeviceEditor.class, FSettingsRFXComTX.class,
      FSettingsRFXComTX.form, FToolsRFXComCmdr.class, FToolsRFXComCmdr.form,
      FToolsX10Cmdr.class, Main.module, dallas-ds18b20.jpg, dallas-ds2406.jpg,
      domotiga.sql, marmitek-kr18.jpg, marmitek-kr22.jpg: New version 0.1.202,
      you must upgrade your database.Please make a backup of your database and
      DomotiGa directory first.Removed AC address settings for RFXComTX, you can
      now specify the full address in Device Editor.Your AC devices now need
      another address format specified.Fixed AC/HEEU code for RFXComTX.Renamed
      HE devicetype to HEUK.Fixed RFXComxPL Dim command decoding for AC
      devices.Re-enabled DNS code, please make sure you run at least Gambas2
      revision 4279!Display correct Dim slider for HE/AC devices on Control
      page.Stop refresh timer of Debug page upon close.Display correct address
      format for AC and HE devices in Device Editor.Enhanced RFXCom Commander
      with AC and HEEU test functions.Added KAKU again to supported protocols
      for JeeLabs interface.Do not warn user of disabled device if hide and
      ignore option is checked in Device EditorRead real output value for OWFS
      Dual I/O switch. (one channel fixed, need coding)Fixed bug in X10
      Commander for RFXCom Transmitter.Fixed address and value decoding of
      OWL119/ELEC2 packet for RFXComRX.Changed groups an inside sensor should
      belong to to get on the Home page.It's now 'Inside', 'Temperature' and
      'Humidity'.For Outside sensor it's 'Outside', 'Temperature' and
      'Humidity'.Added device types for new OWFS devices, DS2406, DS2413 and
      DS2450.Added RFXComRX support for Marmitek KR18, thanks Reno!Made type
      field of interface table longer.

2011-12-08  rdnzl

    * CCUL.class: Only send data to CUL interfaces when connected/active.When
      setting a FS20 DoorBell to On from DomotiGa set it to Off again after a
      second.

    * CCUL.class: Code cleanup.Toggle FS20 Bell Button device to Off after 1
      second On.

    * FConditionEditor.class: Same.

    * FActionScriptEditor.class: Added SetGlobalVar action to Condition editor.

    * Events.module: If Event action timer is already running for a certain
      event, don't stop but restart it.

    * CJeeLabs.class: Code cleanup.

2011-12-06  rdnzl

    * FHome.class, FHome.form, Main.module: Fixed problems with House and Audio
      mode.

    * CCUL.class, Thermostat.module: Fixed bug regarding initializing CUL
      interface.

    * CXMLRPC.class, Events.module, FMain.class, Main.module: Removed GUI calls
      from XMLRPC and event code.

    * Main.module: Remove client code.

    * CXMLRPC.class, Events.module, Main.module: Removed GUI calls from XMLRPC
      and GUI code.

2011-12-05  rdnzl

    * FMain.class, Main.module: Update Main window statusbar information after
      every globalvar update.

    * FEditEventThermostatProfiles.class, FEditEventThermostatProfiles.form,
      FEditGlobalVars.class, FEditGlobalVars.form, FEventThermostat.class,
      FEventThermostat.form, FHome.class, FHome.form, FMain.class, FMain.form,
      FSettingsHome.class, FThermostat.form, Thermostat.module: Added a
      GlobalVar editor.Added Francois's thermostat code.This thermostat is event
      driven, wiki will be updated with howto.

    * CRFXComRX.class: Really fix Digitemp error management temperature.Made
      FirstByte variable public.

    * CRFXComRX.class, Digitemp.module: Really

2011-12-04  rdnzl

    * FFloorplanEditor.class, FFloorplanEditor.form, FMain.class,
      FSettingsRFXComTX.class: Made FloorPlan Editor window resizable, so bigger
      pictures can be used.

    * Main.module, Thermostat.module, XMLClient.module: Update globalvars in
      client mode too, via XMLRPC method.Made thermostat compares case
      insensitive.Added code to delete globalvar.

    * FEvents.class: Added Enabled column to Events list.

    * Events.module: Made condition checks less case sensitive.Refresh status
      panel after globalvars updates.

    * CXMLRPC.class: Added XMLRPC methods for thermostat control, API has
      version 0.11 now.

2011-11-29  rdnzl

    * CRFXComTX.class, CRFXComxPL.class, FToolsRFXComCmdr.class,
      FToolsRFXComCmdr.form: Fixed bug in parsing group addresses.Fixed some
      RFXComTX AC Cmdr issues.

    * CLEDMatrix.class: Fixed error in LEDMatrix display from event actions,
      thanks David!

    * CCUL.class, CTimer.class, CTimerDelay.class, CTimerOnOff.class,
      Events.module: Added On/Off-For-Timer support for CUL FS20 devices so
      device status keeps uptodate.Fixed bugs in event action timer delays.Fixed
      bug in calculation of CUL FS20 On/Off-For-Timer duration.

    * CLEDMatrix.class: Fixed bug in optional params.

    * FSplashScreen.class: Changed error message.

2011-11-28  rdnzl

    * Digitemp.module, FFloorplans.class: Ignore error temp value for Digitemp
      sensors, thanks Reno.Reverse transparent change Floorplan, will need to
      fix this with a balloon image for example.

2011-11-26  rdnzl

    * FEditModulesGroups.class: Fixed bug in floorplan edit.

    * FWeather.class: Added error check on Weather moon image.

    * Astro.module, FMain.class: Added error check on icons path.

    * Astro.module, Main.module: Added error catch code for astro calculations.

    * DomotiGa.gambas, DomotiGaServer.gambas: Updated binaries.

    * X10Cmd.module: Added command queue to X10Cmd module, please test.

    * FFloorplans.class: Made floorplan icon values transparant. Image itself is
      on todo list.

    * CCUL.class: Fixed parsing of negative temp values for CUL S300TH sensors.

2011-11-21  rdnzl

    * CXMLRPC.class: Fixed XMLRPC device.list method, now it returns all
      devices, thanks Jaren!

2011-11-14  rdnzl

    * DomoDroid.apk, DomotiDroid.apk: Renamed Android binary.

    * change_housemode.php, functions.php: Added more checks for non array
      argument in xmlrpc_is_fault().

    * change_device.php: Added check for non array argument in
      xmlrpc_is_fault().

    * banner-1.png, banner-2.png, banner-3.png, chat_bubbles_aqua_l.png,
      chat_bubbles_aqua_r.png, chat_bubbles_clear_l.png,
      chat_bubbles_clear_r.png, chat_bubbles_graphite_l.png,
      chat_bubbles_graphite_r.png, chat_bubbles_lemon_l.png,
      chat_bubbles_lemon_r.png, chat_bubbles_lime_l.png,
      chat_bubbles_lime_r.png, chat_bubbles_orange_l.png,
      chat_bubbles_orange_r.png, chat_bubbles_pink_l.png,
      chat_bubbles_pink_r.png, chat_bubbles_purple_l.png,
      chat_bubbles_purple_r.png, iphoneuikitlogo.png, minid-profile.png,
      profile-user.png, standard-img.png: Removed unused iPhone client images.

    * FSettingsWebserver.class, FSettingsWebserver.form: Removed duplicate
      files.

2011-11-13  rdnzl

    * COPYING, README, change_device.php, change_housemode.php: Added missing
      iPhone client files.

    * domodroid, domotidroid: Renamed directory.

    * .classpath, .project, .settings, AboutActivity.class, AboutActivity.java,
      AndroidManifest.xml, Base64Coder.class, Base64Coder.java, Device.class,
      Device.java, DeviceAdapter.class, DeviceAdapter.java,
      DeviceListActivity$1.class, DeviceListActivity$2.class,
      DeviceListActivity$3$1.class, DeviceListActivity$3.class,
      DeviceListActivity$4.class, DeviceListActivity$5.class,
      DeviceListActivity.class, DeviceListActivity.java, DomotiDroid.apk,
      IXMLRPCSerializer.class, IXMLRPCSerializer.java, ImageActivity.class,
      ImageActivity.java, MethodCall.class, MethodCall.java,
      ParameterActivity.class, ParameterActivity.java, R$attr.class,
      R$drawable.class, R$id.class, R$layout.class, R$menu.class,
      R$string.class, R.class, R.java, Settings.class, Settings.java, Tag.class,
      Tag.java, WebImage.class, WebImage.java, XMLRPC.class, XMLRPC.java,
      XMLRPCClient.class, XMLRPCClient.java, XMLRPCCommon.class,
      XMLRPCCommon.java, XMLRPCException.class, XMLRPCException.java,
      XMLRPCFault.class, XMLRPCFault.java, XMLRPCSerializable.class,
      XMLRPCSerializable.java, XMLRPCSerializer.class, XMLRPCSerializer.java,
      XMLRPCServer.class, XMLRPCServer.java, about.xml, adapter, android,
      assets, bin, classes, classes.dex, com, data, default_off.png,
      default_on.png, devices_list.xml, devices_list_listview.xml, domotidroid,
      domotiga, drawable-hdpi, drawable-ldpi, drawable-mdpi, fire_off.png,
      fire_on.png, gen, ic_menu_refresh.png, icon.png, image.xml, layout,
      light_off.png, light_on.png, menu, menu.xml, org,
      org.eclipse.jdt.core.prefs, parameters.xml, proguard.cfg,
      project.properties, res, resources.ap_, src, string.xml, strings.xml,
      thermometre.png, tools, values, values-fr, wifi_off.png, wifi_on.png,
      xmlrpc: Added simple Android client, coded by Reno, thanks!

    * backButton.png, banner-1.png, banner-2.png, bgHeader.png, bgMetal.png,
      bglight.png, blackbg.png, blueButton.png, camera-roll.png,
      chat_bubbles_aqua_l.png, chat_bubbles_clear_l.png,
      chat_bubbles_graphite_l.png, chat_bubbles_graphite_r.png,
      chat_bubbles_lemon_l.png, chat_bubbles_lemon_r.png,
      chat_bubbles_lime_l.png, chat_bubbles_lime_r.png,
      chat_bubbles_orange_l.png, chat_bubbles_orange_r.png,
      chat_bubbles_pink_l.png, chat_bubbles_pink_r.png,
      chat_bubbles_purple_l.png, chat_bubbles_purple_r.png, chevron.png,
      chevron_b.png, chevron_dg.png, chevron_w.png, device.php, favicon.ico,
      grayButton.png, greenButton.png, index.php, iphoneuikitlogo.png,
      list-icon-1.png, list-icon-2.png, list-icon-3.png, list-icon-4.png,
      logo-iphone.png, logo.png, profile-user.png, redButton.png,
      standard-img.png, toolButton.png, whiteButton.png: Added icons for iPhone
      client.

    * COWFS.class: Added support for DS2438, DS2406, DS2414, DS2450 devices to
      OWFS code.Thanks David!

2011-11-12  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas: Updated binaries to latest
      revision.

    * CEIB.class: Fixed EIB/KNX EIS5 packet parsing, so receiving temperatures
      should work now.

    * FEditGraphs.class, FEditGraphs.form: Removed spaces from empty edit graphs
      combobox entries.Rearranged edit graph group lists.

    * FEvents.class: Don't display duplicate event categories.Refresh used event
      categories upon page refresh.

    * CXMLRPC.class, actionButton.png, actions.png, aibo.gif, asterisk.png,
      banner-3.png, bell.png, bt.png, button.gif, car.png, cd.png, charts.png,
      chat_bubbles_aqua_r.png, chat_bubbles_clear_r.png, climate.png,
      clock-off.png, clock-on.png, clock-red.png, clock.png, comment.png,
      computer.png, conditions.png, config.php.example, contacts.png,
      controller.png, cup.png, database.png, device.php, devices.png,
      domotiga.js, door-closed.png, door-open.png, drive-web.png, drive.png,
      email.png, energy.png, events.png, fan-off.gif, fan-on.gif, film.png,
      fire-off.png, fire-on.png, functions.php, gas.gif, gps.png, group.png,
      groups.png, gsm.png, hd.png, heyu.png, home.png, htaccess.example,
      hvac.gif, hygro.png, icons, images, index.php, iphone, iphone.css,
      ipod.png, irman.png, json.php, keyboard.png, kitbg.png, led-off.png,
      led-on.png, light-dim.png, light-off.png, light-on.png, list-icon-5.png,
      list.png, lock-open.png, lock.png, logo.png, logs.png, mail-off.png,
      mail-on.png, minid-profile.png, modules.png, monitor.png, motion-off.gif,
      motion-on.gif, mpd.png, mute.png, new.png, news.png, pc-off.gif,
      pc-on.gif, phone.png, printer-empty.png, printer.png, question.png,
      rain.png, scale.png, security.png, serial.png, serialterm.png,
      settings.php, settings.png, smoke.png, sms.png, sound.png,
      status-offline.png, status-online.png, stock.png, stripes.png, style.css,
      stylesheets, sun.png, sunset.png, switch.php, temp.gif, time.png,
      triggers.png, tux.png, tv.png, ups.gif, user-female.png, user-gray.png,
      user.png, users.png, vars.png, voice.png, webcam.png, webserver.png,
      wifi-off.png, wifi-on.png, wire.png, world.png, x10.gif: Fixed xmlrpc
      devicelist method for lastseen info.Added iPhone webclient created by
      Mike, thanks!Added a control view to the standard webclient for switching
      devices, thanks Jaren!Added more device icons to the webclients.

    * FSettingsBwiredMap.class, FSettingsBwiredMap.form: Fixed tab focus order
      for Bwired settings.Display info about URL format.

    * XMLClient.module: Added code from deletion of globalvars when running
      client/server.

    * Shell.module: Also display Shell return value errors without debug
      enabled.

    * HDDTemp.module: Ignore non float values as HDD temperature.

    * FDeviceEditor.class, FNews.class, FThermostat.class: Better XML parse
      error catching.Better set themorstat globalvar call.

    * Events.module: Better Time event code.

    * Devices.module: Better auto device creation, also lastseen and location
      are set to default.Also added lastseen field to event macro's like
      <#device name|lastseen#>

    * DNS.module: Disabled DNS resolve for better stability for now, so you need
      to specify ip addresses everywhere.

    * CXMLRPC.class: Added xmlrpc method for globalvars, version is 0.10 now.

    * CUPS.class: Small UPS string parse changes.

    * CRFXComxPL.class, FToolsSerialPorts.class: Fixed X10 addresses for RFXCom
      xPL interface.Fixed Temp08 module name in SerialPort list.

2011-11-05  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, HDDTemp.module, Main.module: Close
      HDDTemp socket at program close.Rearranged sunset/rise code.

    * FDevices.class: Display device id's larger than 99.

    * FDeviceEditor.class: Only check for duplicate addresses against enabled
      devices.

2011-11-04  rdnzl

    * Bwired.module: Bwired upload module now also accepts HTTP 1.1 100 response
      code.

2011-11-02  rdnzl

    * CCUL.class: Report correct signal strenght for CUL packets.Also display
      received values of S300TH in debug mode.

    * CCUL.class: Correctly parse CUL FHT warning packets.

    * RRDTool.module: Create correct RRDTool update command if value is empty or
      a string.

    * Devices.module: Return correct calibrated value.

    * CRFXComxPL.class: Convert incoming RFXComxPL X10 addresses to the correct
      format.

    * CCUL.class: Ignore CUL FHT hightemp packet if no lowtemp packet is
      received first.

    * Main.module: Removed references to bCULAutoCreate variable.

2011-10-29  rdnzl

    * FDevices.class, FFloorplans.class, FMain.class, FMusic.class,
      FNetwork.class, FNews.class, FPhone.class, FScheduleEditor.class,
      FSecurity.class, FServerStats.class, FSettingsAsterisk.class,
      FSettingsAstro.class, FSettingsBluetooth.class, FSettingsBwiredMap.class,
      FSettingsCTX35.class, FSettingsCUL.class, FSettingsCUL.form,
      FSettingsCallerID.class, FSettingsCamVisca.class, FSettingsCameras.class,
      FSettingsCurrentCost.class, FSettingsDSC.class, FSettingsDenon.class,
      FSettingsDigitemp.class, FSettingsDomotica.class, FSettingsEIB.class,
      FSettingsEZcontrol.class, FSettingsEmail.class, Main.module: Code
      cleanups.Fix bug in icon display on climate page for certain devices,
      thanks Luca!

    * Devices.module: Don't auto create a device if it's type is unknown.

    * CRFXComxPL.class: Added description field to UV1/UV2 xPL decoding.

    * CCUL.class, CRFXComRX.class: Commit correct DomotiGaServer CUL code.Code
      cleanup, formatted rain sensor value.

    * CCUL.class: Removed CUL poll timer.Removed CUL autocreate code, done now
      for all devices.

2011-10-27  rdnzl

    * 2016-dimmer-module.jpg, 2017-appliance-module.jpg,
      2220-crystal-lamp-switch.jpg, 2221-crystal-double-lamp-switch.jpg,
      2224-crystal-appliance-switch.jpg, 2225-crystal-double-appl-switch.jpg,
      2263-micro-dimmer.jpg, 2264-two-load-lamp-module.jpg,
      2267-micro-appliance.jpg, 2268-two-load-appliance-module.jpg,
      2280-pt-single-button.jpg, 2281-pt-double-button-switch.jpg,
      2284-pt-fluorescent-light-switch.jpg,
      2285-pt-double-flu.-light-switch.jpg, 3160he-shutter-control-module.jpg,
      3166-pt-shutter-control-switch.jpg, 4208-metal-double-button.jpg: Added
      missing PLCBUS device icons.

2011-10-26  rdnzl

    * CCUL.class, Devices.module: Added support for CUL S300TH temp/humid
      sensor.

2011-10-25  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      binaries.

    * CRFXComTX.class, FToolsRFXComCmdr.class: Fixed missing RFXComTX AC call,
      and remove optional function calls.

    * DomotiGa.gambas: Updated binary.

    * FFloorplans.class: Fix floorplan error on auto created devices.

    * .project, 01200to01201.sql, Bluetooth.module, CCTX35.class, CCUL.class,
      CDSC.class, CJeeLabs.class, COneWire.class, CPLCBUS.class,
      CPlugwise.class, CPwrCtrl.class, CRFXComRX.class, CRFXComTX.class,
      CRFXComxPL.class, CTelnetServer.class, CTemp08.class, CUPS.class,
      CWebServer.class, CXMLRPC.class, CZWave.class, CxPL.class, CxPLMsg.class,
      DNS.module, Devices.module, Digitemp.module, DomotiGa.gambas,
      DomotiGaServer.gambas, Energy.module, Events.module, FActionEditor.class,
      FActionEditor.form, FActionScriptEditor.class, FActionScriptEditor.form,
      FControl.class, FDeviceEditor.class, FDeviceEditor.form, FDevices.class,
      FEditCategories.class, FEditCategories.form, FEditModulesGroups.class,
      FEditModulesGroups.form, FEventEditor.class, FEventEditor.form,
      FEvents.class, FEvents.form, FHome.class, FLogfiles.class, FMain.class,
      FMain.form, FNetwork.class, FNetwork.form, FSettingsHeyu.class,
      FSettingsHeyu.form, FSettingsMain.class, FSettingsMain.form,
      FSettingsOneWire.class, FSettingsOneWire.form, FSettingsPLCBUS.class,
      FSettingsPLCBUS.form, FSettingsRFXComxPL.class, FSettingsRFXComxPL.form,
      FSettingsShell.class, FSettingsShell.form, FSettingsTelnetServer.class,
      FSettingsTelnetServer.form, FSettingsTemp08.class, FSettingsTemp08.form,
      FSettingsWebServer.class, FSettingsWebServer.form,
      FSettingsWebserver.class, FSettingsWebserver.form, FSettingsX10Cmd.class,
      FSettingsX10Cmd.form, FSettingsxPL.class, FSettingsxPL.form,
      FToolsDatabaseAdmin.class, FToolsRFXComCmdr.class, FToolsRFXComCmdr.form,
      FToolsX10Cmdr.class, FTriggerEditor.class, HDDTemp.module, Heyu.module,
      Main.module, Ping.module, RRDTool.module, Shell.module, X10Cmd.module,
      bluetooth-device.jpg, brennenstuhl-&amp;-quigg.jpg, category.png,
      conrad-fs20-bell-button.jpg, conrad-fs20-dimmer-slider.jpg,
      conrad-fs20-flush-mounted.jpg, conrad-fs20-master-slave-socket.jpg,
      conrad-fs20-wall-transmitter.jpg, conrad-fs20-wireless-remote-s16.jpg,
      conrad-fs20-wireless-remote-s20.jpg, conrad-fs20-wireless-remote-s4.jpg,
      conrad-fs20-wireless-remote-s8.jpg, conrad-s555th.jpg, dallas-ds2405.jpg,
      dallas-ds2423.jpg, dallas-ds2438.jpg, dallas-rain-gauge.jpg,
      digimax-210.jpg, domotiga.sql, elro-ab400.jpg, elro-ab601.jpg,
      elv-em1000-fm.jpg, elv-em1000-gzs.jpg, elv-em1000-hsm.jpg,
      elv-fht80b-thermostat.jpg, elv-fht80tf-sensor.jpg, elv-fht80v-valve.jpg,
      elv-fs20-dimmer-module.jpg, elv-fs20-door-window-sensor.jpg,
      elv-fs20-motion-sensor-piri.jpg, elv-fs20-motion-sensor-piru.jpg,
      elv-fs20-touch-control-tc8.jpg, elv-fs20-wireless-gong-fg.jpg,
      elv-fs20-wireless-signal-sig.jpg, elv-fs20di10.jpg, elv-hms100t.jpg,
      elv-s300th.jpg, fritzbox.jpg, fs20-doorbell-button.jpg,
      homeeasy-he105-heating-control.jpg, koppla.jpg, latitude-location.jpg,
      marmitek-dm10.jpg, marmitek-ms10.jpg, marmitek-sd10.jpg,
      marmitek-sd18.jpg, mertik-maxitrol-gas-fire.jpg, network.png, new.png,
      rfxlan-digital-input.jpg, rfxlan-digital-output.jpg, telnet.png,
      visonic-mct550.jpg, waveman.jpg, wifi-on.png, x10-ninja-robocam.jpg,
      x10-pro-hp564.jpg, xpl.png: New version 0.1.201, you must upgrade your
      database!Backups of devices and devicetype tables are stored in /tmp
      too.Renamed OneWire module to Temp08.Added xPL module to provide support
      for xPL interfaces.Added support for RFXLAN xPL interface.Added
      TelnetServer module to provide MisterHouse's mhsend functionality.Remove
      device calibration and divide options, fields are still there for
      debug.Added Eval correction to device values to replace these values.Check
      your device calibration settings after conversion. (backup is in
      devices.csv)Made devicetypes addressformat field bigger, so more text can
      be added. (backup is in devicetypes.csv)Added Shell interface, run command
      from addressfield and use returned values as device values.Added Event
      categories, see option tab and Event page combobox.Fixed bug in Event
      treeview list when two identical actions where used.Renamed Heyu module to
      X10Cmd and added interface type, so CM15a interface can be used too.Added
      Network device group and Page, where all network related device and graphs
      are shown.Added ACK setting to PLCBUS module.When enabling RFXComxPL check
      if xPL is enabled, warn if not.When enabling Log RRD data is enabled, also
      check if RRDTool is enabled, warn if not.Added event action of type
      'script', including script editor window.Added numerous functions to
      script editor.Added new devicetypes for X10Security, PLCBUS, FS20, FHT,
      will overwrite yours, sorry.From now on all devicetypes added by the user
      will have id > 500, all below are the defaults.Rearranged Setup Interfaces
      menu to make more room.Removed Visonic devicetype, they are all
      X10Security now.Added show disabled checkbox to Event viewer.Try to
      reconnect a RFXComRX socket if closed by peer.Try to reconnect a RFXComTX
      socket if closed by peer.I will update the wiki to explain all new
      functionalty soon.Only use Rnd() as key in QueueCommand code because only
      last eight chars are used anyway.Added X10Cmd interface to
      X10Commander.Removed now() from command queue keys, only use rnd now to
      make them unique.Added reconnect code to RFXComRX and RFXComTX, needs
      testing.Planttalk, voicetext.... removed from eventloop.Fixed bug in
      RFXComTX X10 packet creation for units higher than 8.Added auto device
      creation option and code, disabled by default.Fixed bug on Devices page
      when no device icons were defined.

2011-10-17  rdnzl

    * functions.php, index.php, switch.php: Added simple device switch
      functionality to webclient, thanks Wouter!Needs some more work.

    * Ping.module: Fixed typo.

    * FTVGuide.class: Code cleanup.

    * FScenarioEditor.class, FScheduleEditor.class: Code cleanup.

    * FHeatingEditor.class: Code cleanup.

    * FEditGraphs.class: When saving RRD graphs, check if RRDTool is enabled,
      warn if not.

    * Events.module, FTriggerEditor.form: You can now use */ in cron event
      trigger fields, eg. */10 * * * * means run every 10 minutes.Also ranges
      together with / in same field are implemented, eg. 5-30/5 is every 5 mins
      between 5-30.Fixed bug in range parse code, some didn't fire.

    * CRFXComRX.class, CRFXComTX.class: Cleanup Relay Socket connect log output.

    * CPlugwise.class: Cleanup log output.

    * CCUL.class: Store FHT80 thermostat values in different device value
      fields.Calculate correct FHT measured temperatures from high and low
      byte.Fixed FHT SyncTime value.

    * DNS.module: Disabled async DNS queries, at least they work now.

    * FSettingsK8055.class: Fixed bug in K8055 settings form.

    * FToolsDatabaseAdmin.class: Added host param to admin database backup code,
      so it works in client/server mode too.

    * Events.module: Fixed 'Error while running CheckTimeNowEvents query!' error
      when no triggers are defined.

2011-09-19  rdnzl

    * 01199to01200.sql: Fixed syntax error in upgrade script.

2011-09-06  rdnzl

    * CCUL.class: Only store FHT80 measured temp in value field one, rest in
      second.

    * FSettingsOnkyo.form: Added 9600 baud to Onkyo/Integra settings, now it
      works via serial too.

    * CPLCBUS.class, FToolsPLCBUSCmdr.class, FToolsPLCBUSCmdr.form,
      XMLClient.module: Variuos changes to XMLRPC and Commander routines.

    * CPLCBUS.class, CXMLRPC.class, Events.module, Main.module: Better error
      checking in PLCBUS receiver routine.Made PLCBUS and CUL commander work in
      client/server mode too.Upgraded XMLRPC API version, added new methods.Also
      broadcast log messages in DomotiGa GUI server mode.

    * CXMLRPC.class, FToolsCULCmdr.class, FToolsPLCBUSCmdr.class,
      XMLClient.module: Added XMLRPC calls for PLCBUS and CUL commander.

    * CCUL.class: Added a reconnect timer if CUL socket is closed by peer.

    * CPLCBUS.class: Add Ack variable to PLCBUS class.

    * CCUL.class: Stop poll timer if CUL is disabled.

2011-09-05  rdnzl

    * 01199to01200.sql: Added missing mysql lock table command.

2011-09-04  rdnzl

    * DomotiGaServer3.gambas, FCaptures.class, FCaptures.form,
      FConditionEditor.class, FConditionEditor.form, FConstantEditor.class,
      FConstantEditor.form, FDSC.form, FDebug.form, FEditBwiredDevices.class,
      FEditBwiredDevices.form, FEditCameraDevices.class,
      FEditCameraDevices.form, FEditContacts.class, FEditContacts.form:
      Corrected tab order of controls a on number of forms, thanks Jelle!

    * Main.module: Calculate correct broadcast address for non /24 networks.

2011-09-03  rdnzl

    * CCUL.class: Fixed CUL FHT80 actuator parse code, please check.

    * CCUL.class, CPLCBUS.class, CRFXComRX.class, FToolsPLCBUSCmdr.class,
      FToolsPLCBUSCmdr.form, Main.module: Display CUL FHTid also in decimal.If
      On-For-Timer received, set device value On. Vice versa for Off.Implemented
      a temporary poll timer, to see if CUL device stays connected.PLCBUS
      Commander fixed status poll to use correct command, thanks
      Peter!Implemented status report textbox, to see status, signal and noise
      levels.

    * FDevices.class, Main.module: Also update devicelist in client mode is
      autorefresh is off.Code cleanup in FDevices.

    * FDevices.class, FMain.class: Display correct device status icons, also
      with light/dark.

    * CCUL.class, FDeviceEditor.form, FHeatingEditor.form, FSettingsCUL.form,
      FToolsCULCmdr.class: Fixed tab order of heating and dvice editor, thank
      Jelle.Extra error catch when CUL interface is disconnected.

2011-09-01  rdnzl

    * CRFXComRX.class, DomotiGa.gambas, DomotiGaServer.gambas,
      FDeviceEditor.class, FDeviceEditor.form, Main.module: Device editor tab
      order changed, thanks Jelle.Switch of led for RFXComRX after init.Updated
      binaries.Don't display disabled log entries for disabled modules unless
      main debug is enabled.

    * CCTX35.class, FConditionEditor.class, FControl.class, FToolsCULCmdr.class,
      FToolsCULCmdr.form: Made CTX35 command buffer key more random.Control
      panel dim slider now has 16 steps.Better syntax for example actions
      commands.You can now use CUL Commander to send commands to your CUL
      interface.

    * Devices.module: Allow a virtual device value to be set via event actions.

    * CPLCBUS.class: Make key of queue packet for PLCBUS more random.Added delay
      for PLCBUS H40 command.

    * CCUL.class, Devices.module, FDeviceEditor.class, FDeviceEditor.form,
      FToolsCULCmdr.class, FWeather.class, XMLParser.module: Added CUL basic
      FS20 device control for On/Off/Dim.Added CUL command queueing.Fixed CUL
      FHT SyncTime message parse error.Suppress logging empty CUL log lines.Show
      only devices and interface which supports selected type in device
      editor.Removed leading spaces in WeatherBug forecast texts.Display
      WeatherBug API registration info when URL access is denied.

2011-08-31  rdnzl

    * CCUL.class: Also display decimal address for FHT devices.

    * CCUL.class: Cleaned up log output of FHT decoding.Display log entry if
      socket is closed by CUL device.Formatted actuator value.

    * CCUL.class: Fixed issue with CUL FS20 On value in wrong field.

2011-08-30  rdnzl

    * CCUL.class: Only set CUL's FHTid if it's valid.

    * .project, 01199to01200.sql, CCUL.class, Devices.module,
      FSettingsCUL.class, FSettingsCUL.form, Main.module, domotiga.sql: New
      version 0.1.200, you must upgrade your database!Please make a backup
      first!Added FHTid setting for CUL module.Added more devicetypes to CUL
      interface db entry.

    * CCUL.class: CUL FHT parse changes.

    * CCUL.class: Better CUL FHT decoding.

    * Events.module: Execute command action type gets contents parsed too.Added
      parse template for device id|value.Replace templates with their values in
      text inside event actions:<%global var%> - insert globalvar value<#device
      name|field#> - insert value field number 'field' from device with name
      'device name'<$device id|field$> - insert value field number 'field' from
      device with 'device id'

2011-08-29  rdnzl

    * CCUL.class: Fixed FHT TFK decoding.Display parsing errors in debug
      log.Don't display CR in packet log output.

    * CCUL.class, Devices.module: Changed devices log output.Made FHT FTK
      sensors work in CUL module, needs testing.

    * CCUL.class: Completed decoding of CUL FS20 messages, needs testing.

    * fridgesensor.rrd, harddrivedevsda.rrd, hotwater.rrd, outsidesensor.rrd,
      powerusage.rrd, serverload.rrd, servermemory.rrd: Remove default rrd files
      from repos.

    * CCUL.class: Query and display CUL version string in debug log upon init.

    * CCUL.class: Display CUL FS20 Dim % instead of raw value.Make CUL Cmdr
      Version button work.

2011-08-28  rdnzl

    * .project, DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas:
      Updated binaries.

    * 01198to01199.sql, CCUL.class, domotiga.sql: Made EM1000-* devicetypes more
      generic.

    * 01198to01199.sql, domotiga.sql: Added CUL interface to sql upgrade and
      install script.If your db is already at version 0.1.119 update it
      with:mysql -u root -p domotiga <upgrade/01198to01199.sql

    * 01198to01199.sql: Changed default address.

    * .project, 01198to01199.sql, CCUL.class, CK8055.class, CPLCBUS.class,
      Devices.module, DomotiGa.gambas, DomotiGaServer.gambas,
      DomotiGaServer3.gambas, FMain.class, FMain.form, FSettingsCUL.class,
      FSettingsCUL.form, FToolsCULCmdr.class, FToolsCULCmdr.form, Main.module,
      domotiga.sql: New version 0.1.199, you must upgrade your database!Please
      make a backup first!Added CUL module support, it's not finished yet, FS20
      and EM type msgs are correctly decoded.FHT decoding is not working
      correctly, needs work, address formats can change.

2011-08-24  rdnzl

    * README: Changed contact e-mail address.

2011-08-17  rdnzl

    * CK8055.class: Rewrote K8055 class, now using library calls, thanks Frank!

2011-08-11  rdnzl

    * Devices.module: Fixed sending empty list of batterystatus devices.

2011-08-08  rdnzl

    * domotiga.sql: Fixed sql error 1136 in database dump file.

2011-08-05  rdnzl

    * CPLCBUS.class: Cleanup PLCBUS log output.Display PLCBUS signal and noise
      strength report in log.Removed unused lookup table entries.

    * CCTX35.class, COWFS.class, CPLCBUS.class, Devices.module, Main.module:
      Updated DomotiGaServer3 files too.

    * DomotiGa.gambas, DomotiGaServer.gambas, DomotiGaServer3.gambas: Updated
      the binaries.

    * FMain.class: Ask if user is sure that DomotiGa should be closed in server
      mode.

    * CCTX35.class, COWFS.class, CPLCBUS.class, Devices.module,
      FToolsX10Cmdr.class, Main.module: Some PLCBUS code cleanups.Added DS18B20
      sensor OWFS support for server too.Major CTX35/TI203 code rewrite, it now
      features a command buffer.

2011-08-04  rdnzl

    * CPLCBUS.class: Fixed another bug in PLCBUS database device scan.

    * CPLCBUS.class: Fixed bugs in PLCBUS database device scan and address
      masks.

    * FToolsPLCBUSCmdr.form: Allow housecode L through P and unitcode 12 through
      16.

2011-08-03  rdnzl

    * CJeeLabs.class, COWFS.class, CPLCBUS.class, CRFXComRX.class,
      Devices.module, DomotiGaServer3.gambas, EventLoop.module, Main.module:
      Updated DomotiGaServer3 code too.

    * DomotiGa.gambas, DomotiGaServer.gambas: Updated binaries to latest
      version.

    * .project, 01197to01198.sql, CJeeLabs.class, COWFS.class, CPLCBUS.class,
      CRFXComRX.class, Devices.module, FEvents.class, FSettingsPLCBUS.class,
      FSettingsPLCBUS.form, FToolsPLCBUSCmdr.class, FToolsPLCBUSCmdr.form,
      Main.module, domotiga.sql: New version 0.1.198, you must upgrade your
      database!Please make a backup first!Added PLCBUS setting for housecodes to
      poll.Added timer delays to PLCBUS command queuing.Added scene programming
      functionality to PLCBUSCmdr.Thanks Peter for all the PLCBUS ideas!Added
      KAKU switching to JeeLabs module, you need JLink with RF12 demo
      sketch.Thanks to Andy!Fixed display bug in RFXMeter log output.

2011-08-02  rdnzl

    * CPLCBUS.class: Added command queue to PLCBUS code, and busy timer to wait
      after sending a command.

2011-07-30  rdnzl

    * COWFS.class: Added support to OWFS code for 18B20 1-wire sensors.

    * freeswitch_cdr_import.README, freeswitch_cdr_import.sh, scripts: Added
      FreeSWITCH CDR import script.

2011-07-12  rdnzl

    * FDeviceEditor.form: Give device icons own tab in editor.

    * Devices.module: Small code cleanup.

2011-06-07  rdnzl

    * FHome.class: Correct home screen values according to divide and calibrate
      values, thanks Andy!

2011-05-30  rdnzl

    * EventLoop.module: Remove hardcoded mailbatterystatus call.

2011-05-29  rdnzl

    * Devices.module, DomotiGaServer3.gambas: Added mailbatterystatus changes.

2011-05-28  rdnzl

    * DomotiGaServer3.gambas: Added DomotiGaServer3 binary.

    * .project, AVControl.module, Astro.module, Bluetooth.module, Bwired.module,
      CAsterisk.class, CCTX35.class, CCurrentCost.class, CDSC.class,
      CDenon.class, CDomotica.class, CEIB.class, CEZcontrol.class,
      CFritzBox.class, CGPS.class, CIPort.class, CIRMan.class, CIRTrans.class,
      CIViewer.class, CJeeLabs.class, CK8055.class, CLEDMatrix.class,
      CLGTV.class, CLIRC.class, COWFS.class, COWW.class, COneWire.class,
      COnkyo.class, CPLCBUS.class, CPlugwise.class, CPwrCtrl.class,
      CRFXComRX.class, CRFXComTX.class, CSMS.class, CSharpTV.class,
      CSqueezeServer.class, CTimer.class, CUPS.class, CVISCA.class,
      CWebServer.class, CWeeder.class, CXMLRPC.class, CZWave.class,
      CallerID.module, DNS.module, Devices.module, Digitemp.module,
      Energy.module, EventLoop.module, Events.module, GLatitude.module,
      HDDTemp.module, Heyu.module, JSON.module, Mail.module, Main.module,
      Pachube.module, Ping.module, RRDTool.module, ServerStats.module,
      Sounds.module, TVGuide.module, TemperaturNu.module, Thermostat.module,
      Twitter.module, VideoServer.module, VoiceText.module: Convert latest
      domotiga server code to Gambas3 version.

2011-05-27  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas: Updated binaries to latest build.

2011-05-26  rdnzl

    * Devices.module: Changed battery status header text.

    * Devices.module, EventLoop.module, FConditionEditor.class: Removed hard
      coded mail battery status report from eventloop.You can use an condition
      action now, and select "all" or "empty".

    * .project, 01196to01197.sql, DomotiGa.gambas, DomotiGaServer.gambas,
      FHome.class, FHome.form, FMain.class, FMain.form, FSettingsHome.class,
      FSettingsHome.form, Main.module, domotiga.sql: New version 0.1.197, you
      must upgrade your database!Please make a backup first!Added Renaud's
      configurable home screen code, thanks!

    * domotiga.sql: Increment version number in database install file too.

2011-05-20  rdnzl

    * CPlugwise.class: Retry failed Plugwise command requests, also works with
      2010 firmware, thanks Raimondo!

    * 01195to01196.sql: Fixed type in db upgrade script, thanks Reno!

2011-05-18  rdnzl

    * .project, 01195to01196.sql, CZWave.class, Devices.module, DomotiGa.gambas,
      DomotiGaServer.gambas, Events.module, FActionEditor.class, FMain.class,
      FSettingsPlugwise.form, FTriggerEditor.class, Main.module, RRDTool.module,
      domotiga.sql, en_US.mo, en_US.po: New version 0.1.196, you must upgrade
      your database!Please make a backup first!Added setting for RRDTool RRA
      params.Converted event action and trigger field values to integer type
      instead of text,so running DomotiGa in another language should work
      again.Added some ZWave manufactures.

2011-05-15  rdnzl

    * FEventEditor.class, FEventEditor.form: Added Run Now button to Event
      editor.

    * FActionEditor.class, FActionEditor.form, FEvents.class: Refresh Events
      treeview if in treeview mode.Added Run Now button to Action editor.

    * Events.module: Make runaction routines public.

2011-04-09  rdnzl

    * CZWave.class: Updated manufacturers id's.

    * DomotiGa.gambas, DomotiGaServer.gambas: Updated binaries.

    * CZWave.class: Fix compare.

    * DomotiGa.gambas, DomotiGaServer.gambas: Updated binaries.

    * Digitemp.module: Store all values of a DS2438 sensor.

    * DomotiGa.gambas, DomotiGaServer.gambas: Updated binaries.

    * CRFXComRX.class: RFXSensor supply voltage is displayed correctly now.

    * FSettingsPLCBUS.form: Usercode 0-255.

2011-04-06  rdnzl

    * CPLCBUS.class: Removed test routine call.

    * CPLCBUS.class: Add check for RX_TX_SWITCH bit 2, so PLCBUS RF remotes
      work.

    * FFloorplans.class: Prevent error when floorplans where deleted.

    * CWebServer.class: Add more error checks to the internal webserver code so
      nmap doesn't bash DomotiGa.

2011-04-03  rdnzl

    * domotiga.sql: Added missing thermostat_schedule_entry table to database
      layout.

2011-03-29  rdnzl

    * CRFXComRX.class: Rewrote sendcommand routine.

2011-03-28  rdnzl

    * CXMLRPC.class: Removed empty argument to Object Call.

    * RRDTool.module: Change format string so Gambas3 will run ok too.

    * Main.module: Don't strip last digit of uptime string.

2011-03-24  rdnzl

    * DomoZWave.cpp, Makefile, README: Added fix for missing Log.h include (for
      newer open-zwave revision)Added note how to patch Makefile for 64 Bits
      Linux version.

2011-03-23  rdnzl

    * CXMLRPC.class, RRDTool.module: Create missing rrd databases on startup.

2011-03-18  rdnzl

    * CRFXComRX.class: Fixed out of range bug in displaypacket routine.

2011-03-16  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas: Updated binaries to latest
      revision.

    * Devices.module: Change case insensitive compare so it works with older
      Gambas versions.

2011-03-15  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas: Updated binaries to latest build.

    * Devices.module: Added toggle mode, simply set device value1 to "toggle" to
      do that.

    * FControl.class: Code cleanup.

2011-03-14  rdnzl

    * FMain.class, FMain.form: Made menu toolbar a little bit wider.

    * Thermostat.module: Fixed issue when thermostat heating device is newly
      created.

    * DomoZWave.cpp, README: Fixed bug regarding crash upon reload of open-zwave
      wrapper.

2011-03-13  rdnzl

    * CRFXComTX.class, DomotiGa.gambas, DomotiGaServer.gambas: Fixed syntax
      error in ARC code.

    * CRFXComRX.class: Added channel to address, so more than one CM119 can be
      used.

    * CRFXComTX.class, Main.module: RFXComTX logging now shows transmitter or
      xmitter.

2011-03-12  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas: Updated binaries to latest build.

    * README: Updated README file.

    * DomoZWave.cpp, DomoZWave.h, Makefile, README, domozwave, wrappers: Added
      open-zwave wrapper build by Jaren.Read the README on how to install it.

    * FSettingsZWave.class, FThermostat.class, Thermostat.module: Small code
      cleanups.

2011-03-11  rdnzl

    * CZWave.class: Added enable/disable logging to open-zwave.

    * CXMLRPC.class: XMLRPC version 0.08, added methods needed for
      open-zwave.Added some debugging.

2011-03-10  rdnzl

    * CZWave.class: Added path to store zwcfg in different location.

    * Thermostat.module: Thermostat code correction for a starting edge effect.

    * CZWave.class: Small open-zwave wrapper interface changes.

2011-03-07  rdnzl

    * FEvents.class: Show if triggers, actions and conditions are used or not,
      in expanded views.Thanks Renaud.

    * FMain.class, FScheduleEditor.class, Main.module: Save main window size and
      position, thanks Renaud.

    * CZWave.class: Changed library name, small code cleanups.

    * DomotiGa.gambas, DomotiGaServer.gambas: Updated binaries with latest
      fixes.

    * FHeatingEditor.class, Thermostat.module: Bug fixed for heating
      deletion.Heating didn't start full power when too cold.

    * FSecurity.class: Fixed issue with missing security devices due to resize
      bug, thanks Renaud.

    * CRFXComRX.class: Code cleanup and CM119 changes.

2011-03-06  rdnzl

    * Events.module: Fixed bug in crontime routine if input contained multiple
      x,y values, thanks Sander.

2011-03-05  rdnzl

    * .project, 01194to01195.sql, CZWave.class, DomotiGa.gambas,
      DomotiGaServer.gambas, FActionEditor.class, FConditionEditor.class,
      FConstantEditor.class, FConstantEditor.form, FEventEditor.class,
      FEvents.class, FEvents.form, FHeatingEditor.class, FHeatingEditor.form,
      FMain.class, FMain.form, FScenarioEditor.class, FScenarioEditor.form,
      FScheduleEditor.class, FScheduleEditor.form, FSettingsGUI.form,
      FSettingsThermostat.class, FSettingsThermostat.form, FSettingsZWave.class,
      FSettingsZWave.form, FThermostat.class, FThermostat.form,
      FTriggerEditor.class, Main.module, Thermostat.module, actions.png,
      conditions.png, domotiga.sql, thermostat.png, triggers.png: New version
      0.1.195, you must upgrade your database!Added open-zwave option to ZWave
      module, coded by Jaren.Not complete yet, wrapper code follows.Added
      treeview layout to event viewer, coded by Renaud.Added thermostat
      function, created by Renaud.

    * CXMLRPC.class: Fixed updategraph XMLRPC method for extended graphs, thanks
      Renaud.

    * CEIB.class: Fixed temperature calculation for KNX devices for value's
      higher then 10C

2011-02-21  rdnzl

    * Astro.module: Sunset/rise calculation fixes by dali.

    * CRFXComRX.class: Rollback CM119 address fixes.

2011-02-14  rdnzl

    * CPLCBUS.class: Fixed bug with PLCBUS polling of device higher than address
      8.

    * CRFXComRX.class: Fixed bug in OWL CM119 address decoder, thanks Stephen!

2011-02-08  rdnzl

    * domotiga.sql: Forgot to update the version inside database install file.

    * CRFXComTX.class: Fixed bugs in RFXCom transmitter/mitter X10
      control.Thanks to Francois for reporting the bug!

2011-01-17  rdnzl

    * ServerStats.module: One minute updates again.

    * ServerStats.module: Update Serverstats RRD every 5 minutes.Catch system
      errors.

2011-01-16  rdnzl

    * CRFXComRX.class: Removed unused variable.

2011-01-14  rdnzl

    * CZWave.class: Removed false == operand from ZWave code.

2011-01-13  rdnzl

    * FDeviceEditor.form: Fixed missing house code N, thanks user djo28.

    * Heyu.module: Small code cleanup.

    * Digitemp.module: Replaced SHELL with EXEC.

    * CRFXComTX.class: Major code cleanup.

    * Bluetooth.module: Replaced SHELL with EXEC.

2011-01-12  rdnzl

    * .project, 01193to01194.sql, CRFXComTX.class, CUPS.class, DomotiGa.gambas,
      DomotiGaServer.gambas, FDeviceEditor.class, Main.module, domotiga.sql: New
      version 0.1.194, you must upgrade your database!Don't log an error when
      sending broadcast packet fails to prevent loop and stack overflow.Added
      basic support for RFXmitter interface for protocols X10, KAKU, HomeEasy UK
      and EU, Flamingo, Harrison, Koppla.Please test and report back, maybe
      needs some polishing.Added devicetype and support for MGE UPS.

    * CZWave.class: Fixed wrong checksum check for received ZWave packets.

    * XMLParser.module: Fixed XMLParse code, too many arguments.

2011-01-06  rdnzl

    * CRFXComRX.class, CXMLRPC.class, Devices.module, Events.module,
      FConditionEditor.class, FEvents.class, FSettingsRFXComTX.form,
      FTriggerEditor.class, FTriggerEditor.form, Mail.module, Main.module,
      RRDTool.module, ServerStats.module, Twitter.module, XMLClient.module:
      Fixed bug with deletion command of rrds.Save device values to database
      before event parsing.Added CronTime to multi-trigger.Added baudrate of
      38400 to RFXComTX serial settings.Added return value boolean to tweet and
      e-mail functions.Globalvars are requested by client upon load.And they are
      saved to db on close of clients too (needs testing).Various globalvar
      related xmlrpc methods added.Lists on events page are sorted
      alphabetically now.You can specify multi-trigger type now to add several
      objects to trigger on.Needs work and testing.Thanks to forum user hplus
      for the help, code and ideas!Replace some shell commands in rrdtool code
      to use exec.Same for Serverstats module.Removed On/Off value for Digimax
      devices.Added example actions to condition editor treeview.

2011-01-02  rdnzl

    * EventLoop.module: Added home simulation code, thanks to forum user hhg!

2011-01-01  rdnzl

    * CXMLRPC.class: Display line numbers too with XMLRPC errors.

2010-12-31  rdnzl

    * CCurrentCost.class: Check for CR too in CurrentCost code.

2010-12-30  rdnzl

    * CRFXComTX.class, DomotiGa.gambas, DomotiGaServer.gambas: Fixed RFXComTX
      init bug.

    * CCurrentCost.class: Specify flowcontrol setting in CurrentCost serial
      code.

    * DomotiGa.gambas, DomotiGaServer.gambas: Update binaries with latest fixes.

    * CCurrentCost.class: Use <id> pair as address for CurrentCost device
      instead of fixed value.

    * FSettingsRFXComRX.class, FSettingsRFXComTX.class: Disable Relay Port
      fields if relaying is disabled.

    * domotiga.sql: Changed default RFXCom port numbers for new installs.

    * 01192to01193.sql, domotiga.sql: Fixed wrongly named K8055 port type.

2010-12-29  rdnzl

    * FMain.class: Display database host in windows title bar.

    * .project, 01192to01193.sql, CCTX35.class, CEIB.class, CK8055.class,
      COWFS.class, COWW.class, COww.class, CPLCBUS.class, CRFXComRX.class,
      CRFXComTX.class, Devices.module, DomotiGa.gambas, DomotiGaServer.gambas,
      Events.module, FActionEditor.class, FActionEditor.form,
      FDeviceEditor.class, FEvents.class, FMain.class, FMain.form,
      FSettingsIViewer.class, FSettingsK8055.class, FSettingsK8055.form,
      FSettingsOWFS.class, FSettingsOWFS.form, FSettingsRFXComTX.class,
      FSettingsRFXComTX.form, Heyu.module, Mail.module, Main.module, bell.png,
      digimax-rts10.jpg, domotiga.sql, hvac.gif: New version 0.1.193, you must
      upgrade your database!Database name is now specified with mysql command
      line when upgrading.So no need to set it in the upgrade sql scripts
      anymore.Added RFXMitter setting to RFXComTX, code will follow.Added
      support for OWFS.Removes A10 protocol type from devices and interfaces,
      all is X10.Split up device find routines to fix globalx10 error and
      KNX/EIB problem finding duplicate addresses.Added support for reading
      Digimax thermostat packets to RFXComRX code.Added devicetype Digimax
      RTS10.Added devicetype Dallas DS2401 switch.PLCBUS device status updates
      work now.Still an issue with polling more than one housecode.Added action
      notify-send to display notifications.Install it on Ubuntu with 'apt-get
      install libnotify-bin'.Added support for Velleman K8055 interface, thanks
      to user BreFra!Implented GroupRead to get status from KNX/EIB devices,
      thanks Perry!Display error in log when sending of an e-mail has failed.

2010-12-19  rdnzl

    * Devices.module: Always check for lastseen triggers.

    * Devices.module, FTriggerEditor.form: Added support for triggers on
      lastseen value.

    * CPLCBUS.class: Changed PLCBUS homeunit decode code, thanks vdoucet.

    * CPLCBUS.class: Added support for PLCBUS 1141G+ interface, thanks vdoucet.

2010-12-16  rdnzl

    * Astro.module, CEIB.class: Fixed sunrise/set code, thanks to dali.

2010-12-06  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas: Updated binaries with latest
      bugfixes.

    * Main.module: Fixed bug in updates of sunset/sunrise code, thanks Wouter.

    * CJeeLabs.class: Fix device node id, added Low Battery message.

    * CCurrentCost.class, FSettingsCurrentCost.class, Heyu.module: Fixed missing
      function parameter.Changed copyright notices.

2010-12-05  rdnzl

    * CEIB.class, DomotiGa.gambas, Main.module: Fixes for receiving KNX EIS2
      dimming packets.

    * Devices.module, DomotiGa.gambas, DomotiGaServer.gambas, Events.module,
      FConditionEditor.class: Added support for Device Lastseen and
      Batterystatus fields to condition editor.

    * .project, 01191to01192.sql, Bwired.module, CCTX35.class, CEIB.class,
      CIPort.class, CIViewer.class, CJeeLabs.class, CPlugwise.class,
      CRFXComRX.class, Devices.module, DomotiGa.gambas, DomotiGaServer.gambas,
      FConditionEditor.class, FControl.class, FControl.form, FDebug.class,
      FDeviceEditor.class, FEditBwiredDevices.class, FEditPachubeDevices.class,
      FMain.class, FSettingsBwiredMap.class, FSettingsCTX35.class,
      FSettingsCTX35.form, FSettingsHeyu.class, FSettingsHeyu.form,
      FSettingsJeeLabs.form, FSettingsPachube.class, FSettingsRFXComRX.class,
      FSettingsRFXComRX.form, FSettingsTemperaturNu.class, FTriggerEditor.class,
      Heyu.module, Main.module, Pachube.module, TemperaturNu.module,
      domotiga.sql: New version 0.1.192, you must upgrade your database!Fixed
      Value4 bugs in Pachube and Bwired code, thanks Wouter.Added location
      buttons to Control page.Reorganized Control page buttons layout/code.Added
      JeeLabs interface and JeeNode module database entries.Changed JeeLabs code
      to parse JeeNode sketch output.Support for more sketches will follow,
      thanks Wouter.Added GlobalX10 setting to Heyu, RFXComRX and CTX35 X10
      interfaces.If enabled received X10 packets by this interface will update
      X10 module status from other X10 interfaces.Added code to refresh Control
      page if dim/switch values are received.Added broadcast packet for these
      refresh actions so clients get updated too.Added more error catching to
      Plugwise Float calc.Changed EIB address search format, so dimmers can be
      found.

2010-11-28  rdnzl

    * Astro.module, CEIB.class, DomotiGa.gambas, DomotiGaServer.gambas,
      FControl.class: Fixed parsing of KNX/EIB EIS3, EIS4 and EIS5 message
      types.

2010-11-27  rdnzl

    * CPlugwise.class: Added error check on writing to serial port.

2010-11-26  rdnzl

    * FControl.class, FControl.form: Rearranged Control page so it can contain
      more buttons.

2010-11-25  rdnzl

    * CXMLRPC.class, FDeviceEditor.class, RRDTool.module, XMLClient.module:
      Create RRD database also when in client/server mode.Updated XMLRPC API
      version to 0.07.

2010-11-21  rdnzl

    * CZWave.class: Fixed server mode check.

    * Devices.module, FDeviceEditor.class, FDeviceEditor.form: Added Erase Log
      button to device editor.

2010-11-20  rdnzl

    * RRDTool.module: Use calibrated and divided device values for rrdtool
      updates too.

    * GLatitude.module: Format Google Latitude updated date correctly.

2010-11-18  rdnzl

    * CTimer.class, Devices.module, Events.module, FActionEditor.class,
      FActionEditor.form, FEvents.class: Added delay timer action, needs
      testing.Added checks to see if setdevice and valueupdate actions succeeded
      or not.

2010-11-17  rdnzl

    * CDenon.class: Fixed typo in Denon subroutine call.

    * Devices.module: Added support for switching SharpTV and LGTV on/off via
      device control.

2010-11-15  rdnzl

    * FConditionEditor.class: Added == operator and Format/Rnd functions to
      Condition editor.

2010-11-14  rdnzl

    * 01190to01191.sql, Bwired.module, CIPort.class, CSqueezeServer.class,
      DomotiGa.gambas, DomotiGaServer.gambas, EventLoop.module,
      FDeviceEditor.class, FDeviceEditor.form, FEditMarkers.class,
      FEditMarkers.form, FEditUsers.form, FMain.class, FMain.form,
      FSettingsGLatitude.class, FSettingsGLatitude.form, FSettingsGMail.class,
      FSettingsGMail.form, FTriggerEditor.form, GLatitude.module, JSON.module,
      Main.module, domotiga.sql, gmail.png, latitude.png, markers.png: New
      version 0.1.191, you must upgrade your database!Only save globalvars on
      closing if running as server.Added missing interfaces from last version to
      database.Added support for Google Latitude. See wiki.Fixed device editor
      for new interfaces.Added device type for Google Latitude.Remove duplicated
      sunrise at set messages from log.Some small fixes/cleanups in several
      modules.

    * FHome.class, FSettingsGMail.class, FSettingsGMail.form,
      FSettingsGmail.class, FSettingsGmail.form: Made home page graphs fetching
      async.

2010-11-08  rdnzl

    * 01189to01190.sql, CEIB.class, DomotiGa.gambas, FControl.class,
      domotiga.sql: Fixes for dimming EIB EIS2 devices.

    * EventLoop.module, FTriggerEditor.form: More TimeCron help.Fixed time
      entry.

    * DomotiGa.gambas, DomotiGaServer.gambas: Updated compiled files.

    * CEIB.class, CZWave.class, EventLoop.module, Events.module, FEmail.class,
      Main.module: Moved Cron code to events module.Enabled extensive debug for
      it.Fixed problem with Not Implemented error.Removed EIB debug message.

2010-11-07  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, FSettingsGUI.form: Display correct
      program mode.Updated compiled files.

    * Devices.module: Set device value after EIB command.

    * Events.module: Fixed stupid bug resulting in all conditions returned true.

    * Events.module: Fixed debug output.

    * Events.module: Added possible fix for condition2 id 0 problem.

    * DomotiGa.gambas, DomotiGaServer.gambas, Main.module: Possible fix for
      crontab events not validated sometimes.

2010-11-06  rdnzl

    * CEIB.class: More fixes.

    * CEIB.class: Fixed several KNX/EIB bugs, more testing needed.

    * Events.module: Added condition check debug message.

2010-11-05  rdnzl

    * FSettingsEIB.class: Fixed bug in EIB/KNX TCP port settings code.

    * Events.module: More debug for events.

    * FTriggerEditor.class: Remove leading and trailing spaces from crontab
      entry before saving.

    * Events.module: Added more debug info to events module timecron check.

    * DomotiGa.gambas, FLocations.class: Fixed bug missing DisplayLocation
      routine.

2010-11-04  rdnzl

    * .project, 01189to01190.sql, AVControl.module, CCTX35.class, CDenon.class,
      CEIB.class, CFritzBox.class, CIPort.class, CIRMan.class, CIViewer.class,
      CLGTV.class, COneWire.class, COnkyo.class, CPLCBUS.class, CPlugwise.class,
      CRFXComRX.class, CSharpTV.class, CWeeder.class, CZWave.class,
      Devices.module, DomotiGa.gambas, DomotiGaServer.gambas, Events.module,
      FActionEditor.class, FActionEditor.form, FClimate.class, FClimate.form,
      FConditionEditor.class, FConditionEditor.form, FControl.class, FDSC.class,
      FDebug.class, FDevices.class, FDevices.form, FEnergy.class, FEnergy.form,
      FEventEditor.class, FEventEditor.form, FEvents.class, FFloorplans.class,
      FHVAC.class, FHVAC.form, FHome.class, FLogfiles.class, FMain.class,
      FMain.form, FMusic.class, FMusic.form, FPhone.class, FSecurity.class,
      FServerStats.class, FServerStats.form, FSettingsAsterisk.class,
      FSettingsAstro.class, FSettingsBluetooth.class, FSettingsBwiredMap.class,
      FSettingsCTX35.class, FSettingsCallerID.class, FSettingsCamVisca.class,
      FSettingsCurrentCost.class, FSettingsCurrentCost.form, FSettingsDSC.class,
      FSettingsDenon.class, FSettingsDigitemp.class, FSettingsDomotica.class,
      FSettingsEIB.class, FSettingsEZcontrol.class, FSettingsEmail.class,
      FSettingsFritzBox.class, FSettingsGPS.class, FSettingsGUI.class,
      FSettingsGmail.class, FSettingsHDDTemp.class, FSettingsHeyu.class,
      FSettingsIPort.class, FSettingsIPort.form, FSettingsIRMan.class,
      FSettingsIRTrans.class, FSettingsIViewer.class, FSettingsIViewer.form,
      FSettingsJeeLabs.class, FSettingsLEDMatrix.class, FSettingsLGTV.class,
      FSettingsLGTV.form, FSettingsLIRC.class, FSettingsMain.class,
      FSettingsOneWire.class, FSettingsOnkyo.class, FSettingsOww.class,
      FSettingsPLCBUS.class, FSettingsPachube.class, FSettingsPing.class,
      FSettingsPlugwise.class, FSettingsPwrCtrl.class, FSettingsRFXComRX.class,
      FSettingsRFXComTX.class, FSettingsRRDTool.class, FSettingsSMS.class,
      FSettingsServerStats.class, FSettingsSharpTV.class, FSettingsSharpTV.form,
      FSettingsSound.class, FSettingsSqueezeServer.class,
      FSettingsTVGuide.class, FSettingsTemperaturNu.class,
      FSettingsTwitter.class, FSettingsUPS.class, FSettingsVideoServer.class,
      FSettingsVoiceText.class, FSettingsWeatherBug.class,
      FSettingsWebserver.class, FSettingsWeeder.class, FSettingsXMLRPC.class,
      FSettingsZWave.class, FTriggerEditor.class, FTriggerEditor.form,
      Main.module, RRDTool.module, ServerStats.module, ati-wonder-plus.jpg,
      ati-wonder.jpg, domotiga.conf, domotiga.sql, iviewer.png, philips-tv.jpg,
      rfxsensor-a-d-sensor.jpg, rfxsensor-a-d.jpg, rfxsensor-baro.jpg,
      rfxsensor-humid.jpg: New version 0.1.190, you must upgrade your
      database!Make sure you have a database backup first!Added support for
      control of Sharp TV, thanks Daniel!Added basic support for iPort docks,
      needs more work for playlist mngmt.Added support for control of LG TV.
      Please test if you have one.Added basic support for CommandFusion iViewer
      control, needs work.Now you can use your iPod Touch, iPhone or iPad to
      control DomotiGa devices/events!Enhanced AVControl event actions, it now
      fills listst with known commands.You can also send your own custom
      AVControl commands (cli).More commands for Onkyo added.Better error
      checking in RRDTool module for non number values.Fixed display/refresh
      problem with graphs on pages.Added range input field to graph pages, see
      rrdtool docs for format.Fixed several event module bugs.Changed TimeNow
      event trigger to use CronTab entry format.You need to check your converted
      TimeNow triggers.Removed restriction of 3 actions per event by using an
      action list, thanks to Renaud Visier!Removed incorrect INC boolean
      statements.Changed device and events lists fonts.Added a macro/formula
      editor/wizard for conditions, again thanks to Renaud Visier!You need to
      check/test your converted conditions.Maybe this wizard will also be
      implemented for creating triggers.Made trigger params database field
      length unlimited.Changed Serverstats graphs, need to implemented extended
      grahps in db for this.Changed program mode entry in domotiga.conf file to
      use "client" or "server".Please check/correct your settings.Set Globalvars
      PhoneCall_Incoming and PhoneCall_Outgoing with CallerID info.Better error
      catching in Plugwise code when received packet is not complete.Fixed error
      when phonelist data was unavailable.Fixed RFXSensor values for humid, baro
      and a/d type sensors.Added first two devicetypes to database.Replaced type
      column in events/conditions list with formula column.

2010-11-03  rdnzl

    * CEIB.class, current-cost.jpg: Changed EIB/KNX address parse code.

2010-10-13  rdnzl

    * CRFXComRX.class: Fixed 2 typos in array calls.

2010-10-12  rdnzl

    * CRFXComRX.class: Fixed typo in RFXCom class for RFXSensor baro.

    * CCurrentCost.class, ipod.png: Fix parsing of currentcost output.

2010-10-11  rdnzl

    * CRFXComRX.class: Ignore sensor data if CRC check of Oregon packet has
      failed.

2010-10-09  rdnzl

    * AVControl.module, Events.module, FActionEditor.class, FActionEditor.form,
      FConditionEditor.class, FEventEditor.form, FTriggerEditor.class,
      FTriggerEditor.form: Fixed problems with saving new actions, triggers and
      conditions.Added AVControl action to events.Added event trigger support
      for upcoming CommandFusion iViewer module.Make default event description
      empty.

    * AVControl.module: Add return values to AVControl calls.

2010-10-08  rdnzl

    * Main.module, RRDTool.module: Better bugfix for globalvar error, catch
      errors now.Fixed RRDTool float conversion for server too.

    * CIRTrans.class, CLIRC.class: Code cleanup.

    * Main.module: Possible fix for globalvar errors.

2010-10-07  rdnzl

    * CUPS.class: More debug output.

    * CUPS.class, FHome.class, RRDTool.module, lock-open.png, lock_open.png:
      Correct log message in UPS module.Convert integers correctly for
      RRDGraphs.Make Climate and Energy frames clickable on Home screen.

    * car.png, cd.png, clock-off.png, clock-on.png, clock-red.png, clock.png,
      comment.png, computer.png, cup.png, drive-web.png, film.png, fire-off.png,
      fire-on.png, group.png, keyboard.png, lock.png, lock_open.png,
      monitor.png, printer-empty.png, printer.png, status-offline.png,
      status-online.png, time.png, user-female.png, user-gray.png, user.png,
      wifi-off.png, wifi-on.png: Added some more icons.

2010-10-06  rdnzl

    * FTriggerEditor.class: Removed unneeded code.Check before saving for
      duplicate trigger name.

    * FDebug.class, FDebug.form: Enlarged globalvar list view.

    * FConditionEditor.class: Removed unneeded code.Check before saving for
      duplicate condition name.

    * FActionEditor.class: Removed unneeded code.Check before saving for
      duplicate action name.

    * Main.module: Correctly format error text.Broadcast globalvar changes too
      via UDP.

    * Events.module: Set globalvar before event actions, otherwise old values
      will be used.

    * CSqueezeServer.class: Change log text.

2010-10-05  rdnzl

    * FPhone.class: Display Outgoing and Incoming correctly.

    * CRFXComRX.class: Fixed bug where RFXCom Sensors only worked when debug was
      on.

    * Devices.module, Events.module: Added new events and device code to server
      too.

    * Devices.module, Events.module, FActionEditor.class, FActionEditor.form,
      FConditionEditor.class, FConditionEditor.form, FEventEditor.class,
      FEventEditor.form, FEvents.class, FEvents.form, FTriggerEditor.class,
      FTriggerEditor.form: You can now edit descriptions of actions, triggers
      and conditions.Added event actions display led message, write log entry
      and play sound.Added lists for actions, triggers and conditions on events
      page.You can now insert globalvar and devicevalues into action
      texts.Syntax: <%global var%> and <#device name|field#>.So you can send
      e-mails, sms etc like 'Incoming phonecall from <%Phonecall_Incoming%>!'

    * FClimate.class, FClimate.form, FEnergy.class, FEnergy.form, FHVAC.class,
      FHVAC.form, FSecurity.form, FServerStats.class, Main.module: Added more
      graphs ranges to climate, energy, hvac pages.

    * FEditGraphs.class: Only save graphdata if one is selected.

    * CallerID.module: Cleanup log messages.

    * CFritzBox.class, CSqueezeServer.class: Remove erroneous format commands
      for parseline call.Save last incoming and outgoing phonecall to
      globalvars.PhoneCall_Outgoing and PhoneCall_Incoming so they can be used
      as trigger.

2010-10-03  rdnzl

    * Devices.module: Quit device find routine if interface is not found.

    * CSqueezeServer.class, FDeviceEditor.class: Send listen command to players
      to enable IR receive.Fixed wrong interface name for SqueezeServer.

2010-10-02  rdnzl

    * 01188to01189.sql: Added missing database upgrade file.

    * .project, AVControl.module, Astro.module, CDenon.class, CIRTrans.class,
      CLIRC.class, COnkyo.class, CPwrCtrl.class, CRFXComRX.class,
      CSqueezeServer.class, CXMLRPC.class, Devices.module, DomotiGa.gambas,
      DomotiGaServer.gambas, EventLoop.module, Events.module,
      FActionEditor.class, FActionEditor.form, FClimate.class,
      FDeviceEditor.class, FDeviceEditor.form, FEditGraphs.class,
      FEditGraphs.form, FEnergy.class, FHVAC.class, FLogfiles.class,
      FLogfiles.form, FMain.class, FMain.form, FMusic.class, FMusic.form,
      FPhone.class, FSecurity.class, FSettingsHeyu.class, FSettingsHeyu.form,
      FSettingsIRTrans.class, FSettingsIRTrans.form, FSettingsOnkyo.class,
      FSettingsOnkyo.form, FSettingsPwrCtrl.class, FSettingsPwrCtrl.form,
      FSettingsTwitter.class, FSettingsTwitter.form, FToolsDatabaseAdmin.class,
      FToolsDatabaseAdmin.form, FToolsSerialPorts.class, Heyu.module,
      Main.module, RRDTool.module, Twitter.module, XMLClient.module,
      denon-receiver.jpg, domotiga.sql, onkyo-receiver.jpg,
      pwrctrl-device-3-ports.jpg, pwrctrl-device-8-ports.jpg: New version
      0.1.189, you must upgrade your database!Lots of database changes so make
      sure you have a backup before upgrading.Added Heyu X10 device status
      reading, written by Renaud Visier.This is done by starting heyu's monitor,
      goto settings to enable it.Fixed bug in events module when devices where
      removed.Added support for Onkyo/Integra receiver remote control.Added
      devicetypes for Onkyo and Denon receivers.So you can now switch them
      on/off like appliances.Added Music page to GUI client for control of
      Onkyo, Denon and/or SqueezePlayers (just started)Added music icon and menu
      to extras menu.Added logging of device values for device with Log enabled
      (options page in device editor)Added device options for print log to
      display changes in log, and speak, to speak changes.Deleted IRTrans serial
      settings, since it's not usable (different protocol than TCP)Added support
      for NET-PwrCtrl devices, see wiki for more info, coded by Daniel
      Keller.Added support for receiving IR remote codes from SqueezePlayer
      devices.Added Twitter timestamp option to settings, so messages get a
      timestamp in front of them.Added group tab to graph editor, there are now
      called extended graphs.Extended graphs can now be shown on Climate, Energy
      etc pages, by choosing groups.Merged a lot of code from FEditGraph with
      RRDTool module.Renamed devices graph field to rrd, added new graph field
      (for simple graphs).Created AV Control module, to make a generic framework
      for controlling Audio and Video devices.Added calls for it to xmlrpc
      server, upgraded api version.Fixed some wrong debug output with RFXCom IR
      remote.Correctly resize graph panels for Climate, Energy, HVAC, Server
      stats pages.Sort device editor interfaces combo list alphabetically.Added
      warnings to repair/optimize code in db admin, it rebuilds indexes which
      leads to wrong db links.Added forgotten serialport names to serialport
      monitor.Note: please update your gambas to latest svn version, because of
      recent important bug fixes.

2010-09-28  rdnzl

    * FHome.class: Fixed value notation when using another locale.

    * CCurrentCost.class, music.png: Current Cost used value field 2 now.Added
      menu icon for upcoming audio control page.

2010-09-25  rdnzl

    * FActionEditor.form, FEventEditor.form: Make action type tabstrip work
      better.Enlarge size of event editor combolists.

    * Events.module: Fixed typo.

    * CDenon.class: Don't write debug info in main log.

    * Events.module: Fixed bug in event actions with value1, thanks hhg!.

    * Events.module, FEventEditor.class: Added alot of debug messages to Events
      module.Added message when disabled event is about to be saved.

2010-09-24  rdnzl

    * Twitter.module: Made Twitter module work again, you need to
      installliboauth and bti command, see wiki.

    * FTriggerEditor.class: Fixed bug that always checked = operand in Trigger
      editor when value was string.Now the device combolist in Event editor is
      sorted alphabeticaly.

    * .project, 01187to01188.sql, CDenon.class, CIRTrans.class, CLIRC.class,
      CRFXComRX.class, Events.module, FActionEditor.class, FActionEditor.form,
      FDeviceEditor.class, FMain.class, FMain.form, FSettingsDenon.class,
      FSettingsDenon.form, FSettingsIRTrans.class, FSettingsIRTrans.form,
      FSettingsRFXComRX.class, FSettingsRFXComTX.class, Main.module,
      cdeject.png, controlrepeat.png, domotiga.sql: New version 0.1.188, you
      must upgrade your database!Added IRTrans support for sending and receiving
      IR codes.Added Denon receiver control support, needs a GUI.Settings are
      saved in Globalvars starting with "Denon_".Thanks to Daniel Keller for
      both modules!Changed database field lenght for action params.Added Send
      IRTrans action to Events.Added Send SMS message action to Events.Dropped
      unused triggerstype table from db.Remove polltime code from RFXCom
      settings form.Added field groups to graphs database table.

2010-09-23  rdnzl

    * Events.module, FActionEditor.class, FActionEditor.form, domotiga.sql: You
      can now send SMS messages as event action too.Small fixes to event actions
      table format (prevent truncated messages).

    * CIRMan.class: Make UIR/IRman remote and button debug output consistant
      with LIRC's output.

    * CIRMan.class, CLIRC.class, EventLoop.module, Events.module,
      FActionEditor.class, FActionEditor.form, FConditionEditor.class,
      FEventEditor.class, FMain.class, FSplashScreen.class,
      FTriggerEditor.class, FTriggerEditor.form, Mail.module, Main.module,
      VoiceText.module: UIR/IRMan interface is extended so IR remote codes
      received can generate IRRemote type event triggers.See wiki UIR/IRMan
      section for setup information.Same for LIRC interface IR remote data, see
      wiki how to setup.So finally they can be used in a practical way.Globalvar
      values changes can now be used as event trigger.So IF Dark=TRUE as trigger
      will fire when globalvar Dark value changes.You can use all globalvars
      except 'Seconds', see wiki or Debug page for list.Globalvar values can be
      set as event action, new ones will be created.So you can store as many
      variables as you like, and use them in other events.Fixed several bugs in
      Events module, events of the same type don't trigger other events
      now.Rearranged Events code, so queries are done more efficient now.The db
      table 'triggertypes' is not needed anymore will be dropped at next version
      update.You can now send e-mails as event action.You can send Tweets as
      event action (after I fixed the Twitter module to use oauth that is)And
      you can speak text as event action now.The Events, Action and Trigger
      editors are working much better now, lots of code cleanups.Their combo
      lists are refreshed after adding or deleting of records.Documented trigger
      and action database tables inside Events.module code.Optimized
      SetGlobalVars code, so Hour, Day, Month and Weekday globalvars get set
      every new minute instead of every 250mS ;-)

2010-09-19  rdnzl

    * Events.module: Fixed bugs in Events module for compare booleans, integers
      and floats.

2010-09-18  rdnzl

    * FEditGraphs.class, RRDTool.module: Remove dots from newly created rrd db
      names.Optimized some code.

2010-09-17  rdnzl

    * DomotiGa.gambas: Updated executable to latest version.

    * .project, 01186to01187.sql, CCTX35.class, DomotiGaServer.gambas,
      Events.module, FEditGraphs.class, FEditGraphs.form, FGraphsPreview.class,
      FGraphsPreview.form, FMain.class, FMain.form, Main.module, TVGuide.module,
      domotiga.sql: New version 0.1.187, you must upgrade your database!Added
      automatic database upgrade to server. (-a option)Added cmd line option to
      specify config file to both server and client. (-c option)Supply -h for
      all command line options.Applied CTX35 patch to fix bogus data, made by
      'poegje', thanks!Added the RRDTool Graph Editor written by 'Minus',
      thanks!

2010-09-16  rdnzl

    * .project, 01185to01186.sql, CCurrentCost.class, CDSC.class,
      CEZcontrol.class, Devices.module, Events.module, FControl.class,
      FDeviceEditor.class, FDeviceEditor.form, FMain.class, FMain.form,
      FSettingsCurrentCost.class, FSettingsCurrentCost.form,
      FSettingsEZcontrol.class, FSettingsEZcontrol.form, Main.module,
      current-cost-cc128.jpg, domotiga.sql: New version 0.1.186, you must
      upgrade your database!Added support for Current Cost CC128 power usage
      sensor, thanks to Renaud Visier!Added missing defaults for ServerStats
      settings to database, please check your current settings.Added support for
      EZcontrol T-10 interface, thanks to Daniel Keller for info and
      request!This brings basic support for ELV-FS10, FS20, ELRO AB-400, AB-440,
      AB-601 switches and lots more to DomotiGa.Try to fix bugs in Events module
      (events being triggered twice), need testing.

2010-09-14  rdnzl

    * RRDTool.module: Fixed labelnames for RRDTool graphs, thanks to hhg for
      patch.

2010-09-12  rdnzl

    * .htaccess, Base4.php, Base5.php, Benchmark.php, COPYING, Calendar.php,
      Cart.php, CodeIgniter.php, Common.php, Compat.php, Config.php,
      Controller.php, DB.php, DB_active_rec.php, DB_cache.php, DB_driver.php,
      DB_forge.php, DB_result.php, DB_utility.php, Domotiga.php,
      Domotigarpc.php.old, Email.php, Encrypt.php, Exceptions.php,
      Form_validation.php, Ftp.php, Hooks.php, Image_lib.php, Input.php,
      Jsonrpc.php, Language.php, Loader.php, Log.php, Model.php, Output.php,
      Pagination.php, Parser.php, Profiler.php, README, Router.php,
      Scaffolding.php, Session.php, Sha1.php, Table.php, Trackback.php,
      Typography.php, URI.php, Unit_test.php, Upload.php, User_agent.php,
      Validation.php, Xmlrpc.php, Xmlrpcs.php, Zip.php, add.php, aibo.gif,
      application, array_helper.php, autoload.php, background.jpg, bt.png,
      button.gif, cache, calendar_lang.php, captcha_pi.php, close.gif,
      codeigniter, common.js, compatibility_helper.php, config, config.php,
      constants.php, controllers, cookie_helper.php, database, database.php,
      date_helper.php, date_lang.php, db_lang.php, delete.php,
      directory_helper.php, doctypes.php, domotiga-ci, domotiga.js,
      door-closed.png, door-open.png, downarrow.gif, download_helper.php,
      drive.png, drivers, edit.php, email_helper.php, email_lang.php,
      energy.png, english, error_404.php, error_db.php, error_general.php,
      error_php.php, errors, fan-off.gif, fan-on.gif, favicon.ico,
      file_helper.php, fonts, footer.php, form_helper.php,
      form_validation_lang.php, ftp_lang.php, gas.gif, gps.png, hd.png,
      header.php, helpers, hooks, hooks.php, htaccess.example, html_helper.php,
      hygro.png, icons, images, imglib_lang.php, index.html, index.php,
      inflector_helper.php, js_calendar_pi.php, json.php, language,
      language_helper.php, libraries, light-off.png, light-on.png, loading.gif,
      loading.html, logo.jpg, logo.png, logs, mail-off.png, mail-on.png,
      mainpage.php, maskBG.png, mimes.php, models, motion-off.gif,
      motion-on.gif, mssql, mssql_driver.php, mssql_forge.php, mssql_result.php,
      mssql_utility.php, mute.png, mysql, mysql_driver.php, mysql_forge.php,
      mysql_result.php, mysql_utility.php, mysqli, mysqli_driver.php,
      mysqli_forge.php, mysqli_result.php, mysqli_utility.php, no_data.php,
      number_helper.php, number_lang.php, oci8, oci8_driver.php, oci8_forge.php,
      oci8_result.php, oci8_utility.php, odbc, odbc_driver.php, odbc_forge.php,
      odbc_result.php, odbc_utility.php, path_helper.php, pc-off.gif, pc-on.gif,
      plugins, postgre, postgre_driver.php, postgre_forge.php,
      postgre_result.php, postgre_utility.php, profiler_lang.php, question.png,
      rain.png, routes.php, scaffolding, scaffolding_lang.php, scale.png,
      security_helper.php, settings.php, smiley_helper.php, smileys.php,
      smoke.png, sms.png, sound.png, sqlite, sqlite_driver.php,
      sqlite_forge.php, sqlite_result.php, sqlite_utility.php,
      string_helper.php, style.css, stylesheet.css, subModal.css, subModal.js,
      submodal, sun.png, sunset.png, system, temp.gif, texb.ttf,
      text_helper.php, typography_helper.php, unit_test_lang.php, uparrow.gif,
      upload_lang.php, ups.gif, uri_test.php, url_helper.php, user_agents.php,
      validation_lang.php, view.php, views, welcome_message.php, wire.png,
      xml.php, xml_helper.php: Added Wouter's domotiga-ci framework code based
      on Code Igniter.

2010-09-10  rdnzl

    * COPYING, README, config.php.example, domotiga.js, functions.php,
      htaccess.example, images, index.php, json.php, settings.php, style.css,
      submodal: Cleanup.

    * COPYING, README, config.php.example, domotiga, domotiga.js, functions.php,
      htaccess.example, images, index.php, json.php, settings.php, style.css,
      submodal: Move basic webclient to it's own directory.

    * webclient, webclients: Rename dir so it can be used as directory for more
      webclient examples.

    * CSqueezeServer.class: Prevent hang when wrong SqueezeCenter settings are
      used.

2010-09-09  rdnzl

    * FHome.class: Fix bugs converting to integers for non US languages.

2010-09-06  rdnzl

    * CPlugwise.class: Another fix for Plugwise firmware 2008 issue.

2010-09-05  rdnzl

    * CPlugwise.class: Removed typo.

    * CPlugwise.class: Bug fixes to make old Plugwise firmware working again.

    * Main.module: Enable UDP broadcast again for DomotiGaServer3, you need
      Gambas rev #3130.

2010-08-23  rdnzl

    * startserver3.sh: Added start script for DomotiGaServer3.

    * .project, .src, Astro.module, Bluetooth.module, Bwired.module,
      CAsterisk.class, CCTX35.class, CDSC.class, CDomotica.class, CEIB.class,
      CFritzBox.class, CGPS.class, CIRMan.class, CJeeLabs.class,
      CLEDMatrix.class, CLIRC.class, COneWire.class, COww.class, CPLCBUS.class,
      CPlugwise.class, CRFXComRX.class, CRFXComTX.class, CSMS.class,
      CSqueezeServer.class, CUPS.class, CVISCA.class, CWebServer.class,
      CWeeder.class, CXMLRPC.class, CZWave.class, CallerID.module, DNS.module,
      Devices.module, Digitemp.module, DomotiGaServer3, Energy.module,
      EventLoop.module, Events.module, HDDTemp.module, Heyu.module, Mail.module,
      Main.module, Pachube.module, Ping.module, README, RRDTool.module,
      ServerStats.module, Sounds.module, TVGuide.module, TemperaturNu.module,
      Twitter.module, VideoServer.module, VoiceText.module, domotiga.png: Added
      DomotiGaServer3, DomotiGa's server code ported to Gambas3.Please read the
      README inside this directory.Since this code is very experimental!

    * CPLCBUS.class, Main.module: More verbose UDP broadcast error
      message.Removed PLCBus debug code.Abort processing when PLCBus serial data
      cannot be read.

    * DomotiGa.gambas, DomotiGaServer.gambas: Updated binaries to latest
      version.

    * CPlugwise.class: Better error checking on received data packets.

2010-08-22  rdnzl

    * .project, 01184to01185.sql, CPLCBUS.class, CPlugwise.class,
      Devices.module, FControl.class, FDeviceEditor.class, FMain.class,
      FMain.form, FSettingsPLCBUS.form, FToolsPLCBUSCmdr.class,
      FToolsPLCBUSCmdr.form, Main.module, de.mo, de.po, domotiga.sql, fr.mo,
      fr.po, nl.mo, nl.po, plcbus-appliance-module.jpg, plcbus-lamp-module.jpg:
      New version 0.1.185, you must upgrade your database!Added German
      translation files made by Thomas.Added PLCBUS lamp and appliance support,
      needs testing.Added PLCBUS Commander tool.Changed PLCBUS poll timeout
      setting from msecs to seconds,a value of 0 means disabled (default).

2010-08-16  rdnzl

    * .project, CPlugwise.class, FSettingsPlugwise.class,
      FSettingsPlugwise.form, Main.module: New version 0.1.184, you must upgrade
      your database!Added support for plugwise's new firmware (2009-..-..)Choose
      correct version in DomotiGa's plugwise settings, needs testing and
      feedback.Catch mysql return code for failed automatic database upgrades.

    * 01183to01184.sql, domotiga.sql: Version upgrade because of adding plugwise
      firmware settings.

2010-08-07  rdnzl

    * HDDTemp.module: Catch possible errors while opening HDDTemp socket.

2010-08-06  rdnzl

    * FDeviceEditor.class, FDeviceEditor.form: Display image names for device
      images when none found.Added support for device image searched by device
      name, then module name.

    * FTriggerEditor.class: Code cleanup.

    * FConditionEditor.class, FEventEditor.class, FTriggerEditor.class: Reload
      event editor triggers and conditions combolists after creating new
      ones.Fixed bug which prevented to enable trigger edit buttons.

    * FActionEditor.class: Switch to correct event action tab when opening
      action editor.

    * Events.module, FActionEditor.class, FActionEditor.form: Added event
      execute action support, written by forum user hhg.

    * Events.module: Events code cleanup and bug fixes by Geert-Jan.

    * Events.module: Events code cleanup and bug fixes by Geert-Jan.

    * Main.module: Code cleanups.

    * FSplashScreen.class, Mail.module: Store mail, call and voice counter
      values in database.

    * Mail.module, Main.module: Store mail, call and voice counter values in
      database.Update sunset/rise triggers in events every day.

    * FCamera.class: Remove hide call from camera call. Reported by forum user
      hhg.

    * FMain.form: Resize e-mail count field so it can display more than 10
      e-mails.

2010-06-07  rdnzl

    * Astro.module, CJeeLabs.class, CSqueezeServer.class, Devices.module,
      RRDTool.module: Apply client fixes to server code too.

    * Astro.module: Correct hour format.

    * RRDTool.module: Code cleanup.

    * Devices.module: Code cleanup.

    * CSqueezeServer.class: Report number of albums, tracks and artists.

    * CJeeLabs.class: Catch and report serial read errors.

    * ScreenFunc.module: Code cleanup.

    * RRDTool.module: Output more info if debug is enabled.Round values if no
      rrd counter format is chosen.

    * FWeather.class: Code cleanups.

    * Devices.module: Added lastseen date to batterystatus e-mail.

2010-05-12  rdnzl

    * index.php: PHP xmlrpc_is_fault only accepts an array as argument.

    * functions.php: Replace deprecated PHP split function with explode.

2010-04-24  rdnzl

    * CFritzBox.class: Fixed problem with sip uri's in FritzBox callmonitor.

2010-04-23  rdnzl

    * Main.module: Change close program call when error occurs.Geert-Jan added
      code to update Sunrise and Sunset timers at start of new day.

2010-04-20  rdnzl

    * startserver.sh: Provide tools/startserver.sh a script to compile and start
      DomotiGa server.

    * CRFXComRX.class: Swap value1 and value2 for OWL CM119 device.

    * CXMLRPC.class: Divide and calibrate device values in webclient too if
      needed.

    * FHome.class: Convert temp/humid and energy usage values to a number first
      in Home screen code.

    * Events.module: Geert-Jan fixed event action2 and action3 code.

    * Main.module: Added missing DisplayBool routine to server code.

2010-04-16  rdnzl

    * FHome.class: Catch errors in Home page code.

2010-04-14  rdnzl

    * CRFXComRX.class: Added missing parameters to device update call for RFXCom
      1-wire a/d sensors.

2010-04-13  rdnzl

    * CRFXComRX.class: Changed kW to Watt for OWL CM119 value.

    * CRFXComRX.class: Fixed numerous bugs in OWL CM119 parse code.

    * Ping.module: Better error checking for network ping results.

    * FDeviceEditor.class, FDeviceEditor.form: Fixed bug in device editor
      address parsing code.

2010-03-12  rdnzl

    * plc2026-lamp-module.jpg, plc2027-appliance-module.jpg: Added device icons
      for upcoming plcbus support.

2010-02-22  rdnzl

    * CZWave.class, FEditDictionary.class, Main.module, ScreenFunc.module,
      TVGuide.module, XMLParser.module: Small code cleanups and better use of
      built-in SQL quoting.

    * net5.png, rtl4.png, rtl5.png, rtl7.png, rtl8.png, sbs6.png, veronica.png:
      Added new tv logos.

    * FDeviceEditor.class: Rename RRD file too when a device has been renamed
      during editing.

    * FSplashScreen.class, Main.module: Lookup UDP broadcast addresses at
      startup only.

    * Main.module: Display error if logfiles cannot be opened.

    * TVGuide.module: Fixed quoting problem in SQL query, using safer method
      now.

2010-02-21  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, domotiga.sql: Updated compiled
      executables and database install dump to latest version.

    * .project, 01182to01183.sql, CRFXComRX.class, CSqueezeServer.class,
      FDevices.class, FEditDictionary.class, FEditDictionary.form,
      FEditDictionaryDetail.class, FEditDictionaryDetail.form,
      FEditTVChannels.class, FEditTVChannels.form, FEditTVChannelsDetail.class,
      FEditTVChannelsDetail.form, FEditTVProgramCategories.class,
      FEditTVProgramCategories.form, FEditTVProgramCategoriesDetail.class,
      FEditTVProgramCategoriesDetail.form, FLogfiles.form, FMain.class,
      FMain.form, FPhone.class, FSettingsLEDMatrix.class,
      FSettingsTVGuide.class, FSettingsTVGuide.form, FSettingsWeatherBug.class,
      FSettingsWeatherBug.form, FSplashScreen.class, FTVGuide.class,
      FTVGuide.form, FTVGuideChannelDetail.class, FTVGuideChannelDetail.form,
      FTVGuideProgramDetail.class, FTVGuideProgramDetail.form,
      FTVGuideSearchDetail.class, FTVGuideSearchDetail.form,
      FToolsDatabaseAdmin.class, FToolsDatabaseAdmin.form, FWeather.class,
      FWeather.form, Heyu.module, Main.module, Ping.module, RRDTool.module,
      ScreenFunc.module, TVGuide.module, XMLParser.module: New version 0.1.183,
      you must upgrade your database!Changed the way broadcast addresses are
      determined.Added sorting to Phonelist, needs more optimization for large
      lists.Added weather parsing from WeatherBug, see wiki for
      instructions.Imported Weather page code written by Kris Wauters.Imported
      XMLTV code from Kris Wauters, parsing needs to be separated.Imported TV
      Guide page code written by Kris Wauters.Enabled TV Guide menu item.Special
      thanks to Kris Wauters for donating his Gambas code to me!Added now
      playing function to SqueezePlayer code.

2010-02-20  rdnzl

    * cache, icons, imdb, tv_grab_nl_C.conf: Removed unused tvguide files.

    * E.gif, N.gif, NE.gif, NW.gif, S.gif, SE.gif, SW.gif, W.gif, weather: Added
      wind direction icons for upcoming WeatherBug support.

    * 2be.png, actionnow.png, al-jazeera-eng.png, animalplanet.png, baby_tv.png,
      bbc 1 cl.png, bbchd.png, bib.png, bravahd.png, bvn.png, canvasketnet.png,
      cnbc.png, cnn.png, discovery-channel.png, discovery-hd.png,
      discovery-science.png, discovery-travel-&amp;-living.png, discovery.png,
      dorcel.png, e_entertainment_tv.png, een.png, eenhd.png, espn-america.png,
      espn.png, eurosport-hd.png, eurosport.png, eurosport2.png,
      exqi-culture.png, exqi-plus.png, exqi-sport.png, exqi.png,
      extreme_sports.png, france 24.png, france2.png, france3.png, france4.png,
      france5.png, hallmark.png, halmrk.png, het-gesprek.png, hstryhd.png,
      hustlertv.png, itvhd.png, jetix.png, jim.png, jimjam.png, joefm.png,
      kanaalz.png, man-x.png, mezzo.png, mgm.png, mnm.png, motorstv.png,
      msnbc.png, mtv-dance.png, mtv-hd.png, mtv-hits.png, mtv-music.png,
      mtv-two.png, mtv2.png, mtv_tr.png, nat_geo_wild_black.png, ned 1.png, ned
      2.png, ned 3.png, ned-1-hd.png, ngc-hd.png, ngc.png, nik.png,
      nostalgie-net.png, nostalgie.png, pro7.png, qmusic.png, radio1.png,
      radio2.png, radiocontact.png, rai_uno.png, schlagertv.png, sky-news.png,
      studio100tv.png, studiobrussel.png, tmf.png, toon.png, trace.png, travel
      uk.png, trt_int.png, tv5_monde_europe.png, tvlogos, tvoranje.png, vh1.png,
      vh1classic.png, vijftv.png, vitaliteit.png, vitaya.png, viva.png, vt4.png,
      vtm.png, xxx.png, yacht_and_sail.png, zone_reality.png: Added TV logo
      icons for upcoming TV guide.

2010-02-16  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas: Updated compiled executables to
      latest version.

    * domotiga.sql: Corrected database name.

    * domotiga.sql: Updated database install schema to latest version.

    * HDDTemp.module: Some drives don't report temperature, skip them.

    * CRFXComRX.class: Fixed bug with ProtocolSetup call.Change ATI Wonder key
      from ? to Web.

2010-02-15  rdnzl

    * .project, 01181to01182.sql, Astro.module, Bluetooth.module, CDSC.class,
      CLEDMatrix.class, COneWire.class, CRFXComRX.class, CSqueezeServer.class,
      CUPS.class, CVISCA.class, CWebServer.class, CXMLRPC.class, Energy.module,
      FAbout.class, FBarcodes.class, FCamera.class, FDSC.class,
      FDeviceEditor.class, FHome.class, FMain.class, FMain.form,
      FSettingsLEDMatrix.class, FSettingsLEDMatrix.form, FSettingsRFXComRX.form,
      FSettingsSqueezeServer.class, FSettingsSqueezeServer.form,
      FSettingsTemperaturNu.form, FSettingsTwitter.class, FSplashScreen.class,
      FTextViewer.class, FTextViewer.form, FToolsDatabaseAdmin.class,
      FToolsDatabaseAdmin.form, FToolsRFXComCmdr.class, HDDTemp.module,
      Heyu.module, Mail.module, Main.module, Pachube.module, Ping.module,
      README, RRDTool.module, ServerStats.module, Sounds.module,
      TemperaturNu.module, Twitter.module, VoiceText.module, XMLClient.module,
      config.php.example, functions.php, ledmatrix.png, rfxpwr-module.jpg,
      squeezecenter.png: New version 0.1.182, you must upgrade your
      database!Moved GUI code from DSC class to Main module, so now server
      version is same code as client.Fixed typo on DSC code when checking
      standalone mode.Moved GUI code from VISCA class to Camera module, so now
      server version is same code as client.Added support for displaying texts
      on a LED Matrix of type AM03127, see wiki.Added support for ATI Remote
      Wonder and Wonder+ to RFXCom module.And added device types and icons for
      them.Always send Variable mode command after initializing RFXCom
      receiver.Cleaned up RFXCom code, and optimized IF THEN cases.Changed
      address format of Visionic motion sensor to MOTION[256]S.Added basic
      support for controlling Squeeze Players through Squeeze Server API.Needs
      testing and will be expanded soon.Added player device type and device
      icon.Added support for APC BackUPS 550 UPS, cleanup code, and removed
      limit of 1 UPS.Provided device type and icon, needs testing.Added support
      for automatic database upgrades during startup (GUI client only).Program
      version is now defined in Main module instead if usingGambas
      Application.Version, this was needed for automatic upgrades to
      work.Upgraded XMLRPC API to version 0.05, added method for LED Matrix
      display.Changed the way Home screen searched for Energy device, you need
      to add it tonew groups called Energy and Power.Only display enabled
      Temperature and Humidity sensor on Home screen.Change device type of
      Visonic sensors to Visonic instead of X10Security.Added device type and
      icon for Visonic K980 PIR.Added baudrate of 38400 to RFXComRX settings
      (only use it if 4800 baud doesn't work!)Fixed/added missing SendTweet code
      in Twitter settings window.Made TextViewer code more generic.You can now
      repair and optimize the database from Database admin tool.

    * apc-backups550.jpg, squeeze-player.jpg, visonic-k980.jpg: Added some new
      device icons.

2010-02-07  rdnzl

    * rfxpwr-module.jpg: Removed device icon.

    * rfxpulse-power.jpg, rfxpwr-module.jpg, rfxpwr-power.jpg: Added RFXCom
      device icons.

    * CXMLRPC.class: Updated XMLRPC API version to 0.04.

    * CXMLRPC.class: Added XMLRPC methods for updating RRDTool graphs.

2010-02-05  rdnzl

    * TemperaturNu.module: Code cleanups.

    * Energy.module: Code cleanups.

    * HDDTemp.module: Code cleanups.

    * Pachube.module: Code cleanups.

    * ServerStats.module: Code cleanups.

    * RRDTool.module: Code cleanups.

    * Bluetooth.module: Code cleanups.

    * XMLClient.module: Code cleanups.

    * Twitter.module: Copyright update.

    * VoiceText.module: Code cleanups.

    * Sounds.module: Code cleanups.

    * Ping.module: Code cleanup.

2010-02-04  rdnzl

    * Astro.module: Copyright updated, small code cleanups.

    * Heyu.module: Copyright updated.

    * CEIB.class: Timo fixed bug in EIBD's address encoding.

    * CEIB.class: Timo fixed bug in EIBD's address encoding.

2010-02-01  rdnzl

    * FFloorplans.class: Made a start for interactive floorplans, you can now
      switch devices.

    * CEIB.class, COneWire.class, CUPS.class, FMain.class, Main.module: Better
      serial port read error checking in 1-wire code.Better error checking in
      EIB code.

2010-01-28  rdnzl

    * CRFXComRX.class: Don't parse Oregon WEIGHT1 data if address is zero.

    * Ping.module: Measure Round Trip Time for Network Host Ping device types
      too.

2010-01-26  rdnzl

    * CRFXComRX.class: Fixed ID calculation.Don't parse Visonic data if packet
      is unknown.Optimized Oregon parse routines.Don't calculate channels if
      debug is false.Small layout changes to TH1 debug output.

    * CRFXComRX.class: Don't parse Oregon BWR101,BWR102 data if checksum is
      false.Correct name typos in device not found error.

2010-01-21  rdnzl

    * FDeviceEditor.class, FHome.class: Better error checking.

    * Main.module: Removed hour from name of logfiles.

    * CDSC.class, DomotiGa.gambas, DomotiGaServer.gambas, FDSC.class: Fixed
      wrong code in DSC module.Updated compiled binaries to latest version.

2010-01-20  rdnzl

    * CRFXComRX.class: Fixed missing Visonic sensor code.

    * .project, 01180to01181.sql, Bluetooth.module, CDSC.class, CPLCBUS.class,
      Devices.module, FDeviceEditor.class, FSettingsPLCBUS.class,
      FSettingsPLCBUS.form, Main.module, Ping.module, domotiga.sql: New version
      0.1.181, you must upgrade your database!Timo added virtual device type,
      starting with Security System for DSC.Added 3-Phase setting for
      PLCBUS.Fixed Bluetooth CPU hog bug, network will be scanned in background
      now.Fixed Firstseen date not set for Ping and Bluetooth devices.Fixed Off
      icon status for Security, Climate etc. lists. (was always on)

2010-01-19  rdnzl

    * FDevices.class: Fixed location and last changed columns in devicelist.

2010-01-18  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas: Updated compiled versions to
      latest version.

    * .project, 01179to01180.sql, Bwired.module, FEditBwiredDevices.class,
      FEditPachubeDevices.class, FMain.class, FMain.form,
      FSettingsPachube.class, FSettingsTemperaturNu.class,
      FSettingsTemperaturNu.form, Main.module, TemperaturNu.module,
      domotiga.sql: New version 0.1.180, you must upgrade your database!Daniel
      Lindmark wrote Temperatur.nu a module to publish temperatures.Fixed some
      more Bwired and Pachube value bugs.

    * CZWave.class: Timo added a bunch of known command classes to the Z-Wave
      code.

    * CXMLRPC.class, FSettingsPachube.form, Main.module, Pachube.module,
      index.php: 'Infernix' added automatic feed functionality to Pachube
      module.Read wiki on how to enable/use it.

2010-01-16  rdnzl

    * FEditPachubeDevices.class: Fixed example display code too.

    * Bwired.module, FEditBwiredDevices.class, FSettingsBwiredMap.class: Fixed
      bug where Bwired module didn't work correctly with non-English GUI
      language.You must check/adjust you bwired devices for correct settings.

    * FEditPachubeDevices.class, FSettingsPachube.class, Pachube.module: Fixed
      bug where Pachube didn't work currectly with non-English GUI language.You
      must check/adjust your pachube devices for correct settings.

    * FSettingsGUI.form: Fixed form property.

2010-01-15  rdnzl

    * FAbout.class, FAbout.form, FSplashScreen.class, FSplashScreen.form: Update
      year of copyright notices automatically from now on.

    * EventLoop.module, Main.module: Update clock on virtual DSC LCD
      display.Make sure new logfiles are created when new month starts.

2010-01-14  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, domotiga.sql: Updated binaries and
      database install file to latest version.

    * 01178to01179.sql: Added upgrade script.

    * .project, CDSC.class, CRFXComRX.class, FDeviceEditor.class,
      FEditModulesGroups.form, domotiga.fedora, dumpdevices.sh, tools: New
      version 0.1.179, you must upgrade your database!Changed address format for
      Oregon, X10Security and RFXSensor/Meter devices!This will result in better
      support output, and less change on address conflicts.You can enable RFXCom
      debug to see relation between old and new addressesand update your device
      entries accordingly.Added a lot of Oregon, RFX and other device types to
      the database.You have to check if your devices still have the correct type
      defined.I have supplied a script called tools/dumpdevices.sh, use it
      before updateto get a list of your current devices in the database.Fixed
      wrong total rain cnt value for PCR800.Jerome Rieul fixed bugs for Oregon
      BWR102,BTHR968 and WGR918 sensors.Egon Kastelijn wrote
      tools/domotiga.fedora a system init script for DomotigaServer,read the
      wiki for more info, he also provided Fedora 11/12 install notes.Timo
      updated his DSC class so it can send SMS messages and store security
      datain the database so clients will get updates too.Corrected Interface
      preference in DeviceEditor for Ping, Oregon and X10Security.

    * cent-a-meter.jpg, clipsal-cent-a-meter.jpg, electrisave.jpg,
      marmitek-ds10.jpg, marmitek-kr10.jpg, marmitek-kr21.jpg,
      marmitek-ms90.jpg, marmitek-sh624.jpg, oregon-aw129.jpg, oregon-aw131.jpg,
      oregon-bwr101.jpg, oregon-rgr126.jpg, oregon-rgr682.jpg,
      oregon-thc238.jpg, oregon-thc268.jpg, oregon-thgr228.jpg,
      oregon-thgr328n.jpg, oregon-thn122n.jpg, oregon-thn132n.jpg,
      oregon-uvr128.jpg, rfxsensor-a-d-sensor.jpg, rfxsensor-temp.jpg,
      rfxsensor-voltage.jpg, visonic-mct234.jpg, visonic-mct302.jpg,
      visonic-mct425.jpg: Added several device icons.

    * CFritzBox.class, Main.module, Pachube.module: Changed log message
      output.Sent Phonecall UDP broadcast message on outgoing/incoming calls.

    * FDevices.class: Fixed column filling bug.Optimized SQL queries.

    * FSettingsRFXComRX.class: Fixed Save button enable bug.

    * Pachube.module: Changed log message output.

    * CFritzBox.class, FPhone.class, Main.module: Refresh Phonecall list on
      outgoing/incoming calls.Cleaned up SQL code.

    * Bluetooth.module: Fixed bug with Bluetooth browser and GetRRSI.

2010-01-13  rdnzl

    * FControl.class: Timo fixed bug with Dim slider on Control form.

    * FDevices.class, FDevices.form: Added 'Show disabled' option to Devices
      form.

    * 01177to01178.sql, CSMS.class: Timo added SMS support for Nokia 6300.

2010-01-12  rdnzl

    * functions.php: Fixed bug where device labels where not being displayed if
      device value was 0.

2010-01-06  rdnzl

    * 01177to01178.sql, CRFXComRX.class, domotiga.sql: Added devicetype for
      Oregon WTGR800.Add a second WTGR device with W appended to the address to
      get wind values.

2010-01-05  rdnzl

    * FEventEditor.class: Fixed bug to prevent error when dbl clicking empty
      events grid.

    * Devices.module, Energy.module, FPhone.class, FToolsDatabaseAdmin.class,
      FToolsDatabaseAdmin.form, VideoServer.module: Fixed problems with deleting
      devices, added more options to Database Admin Tools.

2010-01-04  rdnzl

    * Main.module: Added missing Restart_Astro() code.

    * Main.module: Display on-icon when device value is awake or up, display
      dim-icon when dimmed.Don't error when defined icon images don't exist or
      icons are not defined.

    * FFloorplans.class: Also display on-icon when device value is awake or up,
      and dim-icon if dimmed.

    * FDevices.class: Also display on-icon when device value is awake or up.

    * FDeviceEditor.class: Fixed bug giving error when selecting blank
      devicetype.

    * DomotiGa.gambas, DomotiGaServer.gambas: Updated compiled files to latest
      version.

    * FPhone.class: Refresh Phonecalls list better, not to miss new calls.

2010-01-03  rdnzl

    * FCamera.class, FCamera.form: Display camera mplayer command string in
      debug log.Resized Camera form so it fits on a eeepc screen.

    * Main.module: Display line number at which loading of settings failed.

    * README: Updated README for client/server setup.

    * TODO: Updated TODO file.

    * domotiga.sql: Updated domotiga database install file to new version.

    * sony-aibo-ers7.jpg, sony-aibo.jpg: Renamed AIBO device icon.

    * 01177to01178.sql: Corrected settings for PLCBUS in database dump.

    * FSettingsPLCBUS.class, FSettingsPLCBUS.form: Added settings form for
      PLCBUS.

    * FSettingsCameras.class, FSettingsCameras.form: Added settings form for
      Cameras.

2010-01-02  rdnzl

    * .project, 01177to01178.sql, AIBO.module, Bluetooth.module,
      CAsterisk.class, CCTX35.class, CDSC.class, CEIB.class, CFritzBox.class,
      CLIRC.class, COneWire.class, COww.class, CPLCBUS.class, CPlugwise.class,
      CRFXComRX.class, CRFXComTX.class, CUPS.class, CVISCA.class, CZWave.class,
      CallerID.module, Devices.module, FCamera.class, FCamera.form,
      FEditCameraDevices.class, FEditCameraDevices.form, FEditContacts.class,
      FEditContacts.form, FEditMenus.class, FEditMenus.form, FMain.class,
      FMain.form, FPhone.class, FPhone.form, FSettingsAIBO.class,
      FSettingsAIBO.form, FSettingsCTX35.class, FSettingsCallerID.class,
      FSettingsCallerID.form, FSettingsDigitemp.form, FSettingsGmail.form,
      FSettingsJeeLabs.form, FSettingsMain.class, FSettingsPing.class,
      FSettingsPing.form, FToolsSerialPorts.class, Main.module, Ping.module,
      bus.png, labs.png: New version 0.1.178, you must upgrade your
      database!Fixed visual bugs in menu editor and main toolbar menu.Don't
      display year, show full month in status bar instead.Fixed bug not updating
      clock in client.Corrected several 'host not found' error messages.Don't
      stop program if RFXCom TCP/IP data cannot be read.Replaced AIBO module
      with a more generic Ping module.Which displays Up/Down, On/Off,
      Sleep/Awake depending on device type.Added basic serial framework for
      upcoming PLCBUS support, no parsing yet.You can now specify an unlimited
      amount of camera's to view.Added support for Axis Camera PTZ API control
      via HTTP.Added support for viewing internet camera MJPEG streams.You need
      to have mplayer installed for this.Fixed bug where DomotiGa standalone
      hangs after close due to missing BroadcastUDP close call.Fixed leds not
      blinking in Standalone mode.Fixed Midon interface parse problem.Optimized
      Plugwise and Bluetooth code.Added Areacode, countrycode settings for
      CallerID.Added basic reverse name lookup via web.CallerID auto add new
      contacts to database if you want to.Display UDB Broadcast enabled/disabled
      message.Reload main settings too when they have changed.Timo fixed DSC
      wrong checksum variable type.Fixed KNX/EIB interface type
      definition.Better Read event error checking.Replaced Phone listview
      control for gridview, is faster, sort has to be implemented.

2009-12-26  rdnzl

    * .project, 01176to01177.sql, CCTX35.class, CDSC.class, CEIB.class,
      CGPS.class, CJeeLabs.class, CLIRC.class, CRFXComRX.class, CVISCA.class,
      Devices.module, FMain.class, FMain.form, FSettingsJeeLabs.class,
      FSettingsJeeLabs.form, Main.module, domotiga.sql: New version 0.1.177, you
      must upgrade your database!Added basic JeeLabs JeeLink code.Moved Led
      On/Off code to Main.module to share code.Several code cleanups.

2009-12-22  rdnzl

    * Bluetooth.module: Fixed syntax bug in Bluetooth module.

2009-12-17  rdnzl

    * FControl.class: Removed debug messages.

2009-12-09  rdnzl

    * CCTX35.class, CLIRC.class, CZWave.class, FServerStats.class,
      FSettingsBwiredMap.class, FSettingsPachube.class, RRDTool.module,
      ServerStats.module: A number of small code and gui cleanups.

2009-12-08  rdnzl

    * DomotiGa.gambas, DomotiGaServer.gambas, domotiga.sql: Updated compiled
      versions and database dump to latest version.

    * .project, 01175to01176.sql, AIBO.module, Astro.module, Bluetooth.module,
      Bwired.module, CCTX35.class, CEIB.class, CLIRC.class, CRFXComRX.class,
      CZWave.class, DNS.module, Devices.module, Digitemp.module, Energy.module,
      EventLoop.module, FEditModulesGroups.class, HDDTemp.module, Heyu.module,
      Mail.module, Main.module, Pachube.module, RRDTool.module,
      ServerStats.module, Sounds.module, TVGuide.module, Twitter.module,
      VoiceText.module: New version 0.1.176, you must upgrade your database!Fix
      Bwired bug where timer was not started ast start of program.Cleaned
      up/rewrote/optimized AIBO, Digitemp and Bluetooth module among others.Put
      comments between the code.Only generate RRDTool graphs for choosen
      timeframe not all of them (what was I thinking!)Optimized RRDTool and
      ServerStats code a lot.Fixed RFXCom Cent-a-meter and OWL CM119
      support.Added to database DWS Visonic DS10/90/SD90/MCT302/425Added to
      database Motion Visonic MS10/20/90/MCWAdded to database Remote Visonic
      KR10/21/SH624/MCT234/HP564And fixed code to support these.

    * 01175to01176.sql, domotiga.sql: Change type of cent-a-meter devicetype.

    * 01175to01176.sql, CRFXComRX.class, domotiga.sql: New version 0.1.176, you
      must upgrade your database!Added Cent-a-meter devicetype.Fixed
      Cent-a-meter bugs in RFXComRX module.

2009-12-06  rdnzl

    * domotiga.conf: Removed comments from domotica.conf to prevent problems
      loading.

2009-12-05  rdnzl

    * .project, DomotiGa.gambas, DomotiGaServer.gambas, domotiga.sql: Updated
      version in project file.Compiled new binaries.Updated domotiga install
      dump file.

2009-12-04  rdnzl

    * .project, 01174to01175.sql, AIBO.module, Bwired.module, CFritzBox.class,
      CLIRC.class, COww.class, CRFXComRX.class, CVISCA.class, Devices.module,
      Digitemp.module, EventLoop.module, FControl.class,
      FEditPachubeDevices.class, FEditPachubeDevices.form, FLogfiles.class,
      FLogfiles.form, FMain.class, FMain.form, FSettingsAIBO.class,
      FSettingsAIBO.form, FSettingsAsterisk.form, FSettingsBwiredMap.class,
      FSettingsBwiredMap.form, FSettingsEIB.form, FSettingsLIRC.class,
      FSettingsLIRC.form, FSettingsOww.class, FSettingsOww.form,
      FSettingsPachube.class, FSettingsPachube.form, FSettingsXMLRPC.class,
      FSettingsXMLRPC.form, Main.module, Pachube.module, Twitter.module,
      camera.png, domotiga.conf, lirc.png: New version 0.1.175, you must upgrade
      your database!Fixed bug in AIBO module timer.Added pushtime parameter to
      BwiredMap.Added basic LIRC support written by Timo.Added basic One-Wire
      Weather framework written by Timo.Implemented an UDP broadcaster and
      listener, so logs are pushed to the clients.Now you can push your sensor
      data to Pachube.com!Added support for Dallas DS2438 sensor to Digitemp
      module.Display error when settings can not be loaded correctly.Timo fixed
      Control page for EIB/KNX devices.

2009-12-02  rdnzl

    * CRFXComRX.class, Digitemp.module, Main.module: Added Digitemp support for
      Dallas 2423.Correctly catch Oregon data parse errors, continue instead of
      close program.

2009-11-24  rdnzl

    * .project, FCamera.class, FCamera.form: Removed non working v4l2 support
      for Camera, replaced it with embedded mplayer.So you have to install
      mplayer for this to work.

2009-11-23  rdnzl

    * .project, 01173to01174.sql, CEIB.class, Devices.module, Digitemp.module,
      Energy.module, FDeviceEditor.class, domotiga.sql: New version 0.1.174, you
      must upgrade your database!Added missing routine to Device.module needed
      for new CEIB.class.Changed Digitemp.module, you need to change your
      digitemp.conf and devices.Serial IDs are now used as address, DS2423 is
      also supported, read wiki 1-Wire section.More to come if I can get sample
      digitemp output.Fixed but in sql query, Energy logging was broken.

2009-11-21  rdnzl

    * CEIB.class, FDeviceEditor.class, domotiga.sql: Fixed Control page
      refreshing.

    * DomotiGa.desktop, DomotiGa.gambas, DomotiGaServer.desktop,
      DomotiGaServer.gambas, domotiga.gambas, domotiga.sql: Updated compiled
      programs and database install file.

    * 01172to01173.sql, AIBO.module, Astro.module, Bluetooth.module,
      Bwired.module, CAsterisk.class, CCTX35.class, CDSC.class, CDomotica.class,
      CEIB.class, CFritzBox.class, CGPS.class, CIRMan.class, COneWire.class,
      CPlugwise.class, CRFXComRX.class, CRFXComTX.class, CSMS.class, CUPS.class,
      CVISCA.class, CWebServer.class, CWeeder.class, CXMLRPC.class,
      CZWave.class, Devices.module, Digitemp.module, Energy.module,
      EventLoop.module, Events.module, FAbout.class, FActionEditor.class,
      FBarcodes.class, FBarcodes.form, FCamera.class, FCaptures.class,
      FConditionEditor.class, FControl.class, FDSC.class, FDebug.class,
      FDeviceEditor.class, FDevices.class, FEditBwiredDevices.class,
      FEditContacts.class, FEditMenus.class, FEditMenus.form,
      FEditModulesGroups.class, FEditNewsWeather.class, FEditNotify.class,
      FEditUsers.class, FEventEditor.class, FEvents.class, FFloorplans.class,
      FHome.class, FHome.form, FMain.class, FMain.form, FSettingsAIBO.class,
      FSettingsAsterisk.class, FSettingsAstro.class, FSettingsBluetooth.class,
      FSettingsBluetooth.form, FSettingsBwiredMap.class, FSettingsCTX35.class,
      FSettingsCamVisca.class, FSettingsDSC.class, FSettingsDigitemp.class,
      FSettingsDomotica.class, FSettingsEIB.class, FSettingsEmail.class,
      FSettingsFritzBox.class, FSettingsGPS.class, FSettingsGUI.class,
      FSettingsGUI.form, FSettingsGmail.class, FSettingsHDDTemp.class,
      FSettingsHeyu.class, FSettingsIRMan.class, FSettingsMain.class,
      FSettingsMain.form, FSettingsOneWire.class, FSettingsPlugwise.class,
      FSettingsRFXComRX.class, FSettingsRFXComTX.class, FSettingsRRDTool.class,
      FSettingsSMS.class, FSettingsSMS.form, FSettingsServerStats.class,
      FSettingsSound.class, FSettingsTVGuide.class, FSettingsTwitter.class,
      FSettingsUPS.class, FSettingsVideoServer.class, FSettingsVoiceText.class,
      FSettingsWebserver.class, FSettingsWeeder.class, FSettingsXMLRPC.class,
      FSettingsXMLRPC.form, FSettingsZWave.class, FSplashScreen.class,
      FTextViewer.class, FToolsBluetoothBrowser.form, FToolsDatabaseAdmin.class,
      FToolsRFXComCmdr.class, FToolsSerialMon.class, FToolsSerialPorts.class,
      FToolsX10Cmdr.class, FToolsZWaveCmdr.class, FToolsZWaveCmdr.form,
      FTriggerEditor.class, HDDTemp.module, Heyu.module, Mail.module,
      Main.module, RRDTool.module, ServerStats.module, Sounds.module,
      TVGuide.module, Twitter.module, VideoServer.module, VoiceText.module,
      XMLClient.module, domotiga.conf, domotiga.png, en_US.po, fr.po, gsm.png,
      gui.png, light-dim.png, nl.po, tux.png: New version 0.1.173, you must
      upgrade your database!Made more strings translatable.Timo rewrote his
      KNX/EIB class code.Added Client/Server mode to DomotiGa GUI (see
      domotiga.conf)Made XMLRPC enabled by default, so server can be
      controlled.Domotiga GUI is default standalone, change domotica.conf to
      "clientserver".You need Gambas 2.18.0 to be able to use this, because of
      needed bugfix.Added XML Client code to DomotiGa GUI, not all features work
      yet.Thomas added ZBar barcode scanning (with camera) and support for EAN
      8.He also added the German translation.Fixed SMS modem module. (tested
      with Siemens MC35i)Added a lot of XMLRPC methods, updated version, see API
      document on wiki.Fixed bug when you have Outside sensor without Humidity
      on Home screen.Added UDP broadcast parameter to settings.Added simple scan
      mode to Bluetooth module (set threshold to 255 for this)Timo added some
      more functions to webclient's functions.phpFixed bug where buttons on
      Control screen where not erased before refresh.Now Fritzbox phonecalls
      with be announced in main log, together with caller name.Tool menu's for
      unabled interfaces are greyed out.All WAIT commands are replaced by SLEEP
      to prevent event race conditions.Split up client and server settings (see
      GUI menu)Use index instead of text for comboboxes, so they can also be
      translated.Added some more icons.Added 4th menu option, maybe for location
      buttons, not finished yet.

    * .project, AIBO.module, Astro.module, Bluetooth.module, Bwired.module,
      CAsterisk.class, CCTX35.class, CDSC.class, CDomotica.class, CEIB.class,
      CFritzBox.class, CGPS.class, CIRMan.class, COneWire.class,
      CPlugwise.class, CRFXComRX.class, CRFXComTX.class, CSMS.class, CUPS.class,
      CVISCA.class, CWebServer.class, CWeeder.class, CXMLRPC.class,
      CZWave.class, Devices.module, Digitemp.module, Energy.module,
      EventLoop.module, Events.module, HDDTemp.module, Heyu.module, Mail.module,
      Main.module, RRDTool.module, ServerStats.module, Sounds.module,
      TVGuide.module, Twitter.module, VideoServer.module, VoiceText.module,
      domotiga.png, functions.php: You need Gambas 2.18.0 to be able to use this
      code, because of needed bugfix.Made more strings translatable.Timo rewrote
      the KNX/EIB class.Fixed SMS modem module. (tested with Siemens MC35i)Added
      a lot of XMLRPC methods, updated version, see API document on wiki.Fixed
      bug when you have Outside sensor without Humidity on Home screen.Added UDP
      broadcast parameter to settings.Added simple scan mode to Bluetooth module
      (set threshold to 255 for this)Timo added some function to webclient's
      functions.phpNow phonecalls with be announced in main log, together with
      caller name.All WAIT commands are replaced by SLEEP to prevent event race
      conditions.

2009-11-18  rdnzl

    * domotiga-server.conf, domotiga.sql, server-domotiga.conf: Corrected
      default main settings.Renamed config file for server.

    * de.png, domotiga-server.conf: DomotiGaServer has it's own
      domotiga-server.conf now.Added German language icon.

    * domotiga.sql: Enable XMLRPC server by default (needed for
      client/server).Changed default port to 9009.

2009-11-11  rdnzl

    * .directory: Removed unneeded file.

    * .directory, .lang, .project, AIBO.module, Astro.module, Bluetooth.module,
      Bwired.module, CAsterisk.class, CCTX35.class, CDSC.class, CDomotica.class,
      CEIB.class, CFritzBox.class, CGPS.class, CIRMan.class, COneWire.class,
      CPlugwise.class, CRFXComRX.class, CRFXComTX.class, CSMS.class, CUPS.class,
      CVISCA.class, CWebServer.class, CWeeder.class, CXMLRPC.class,
      CZWave.class, DNS.module, Devices.module, Digitemp.module, DomotiGaServer,
      Energy.module, EventLoop.module, Events.module, HDDTemp.module,
      Heyu.module, Mail.module, Main.module, RRDTool.module, ServerStats.module,
      Sounds.module, TVGuide.module, Twitter.module, VideoServer.module,
      VoiceText.module, domotiga.png: Added DomotiGaServer a commandline server
      daemon.The first start of a real client-server setup.

2009-11-03  rdnzl

    * AIBO.module, CZWave.class, Devices.module, Energy.module,
      FLocations.class, FNews.class, FSelectDate.class, FSelectImage.class,
      FWeather.class, Main.module, RRDTool.module: Lookup and update Z-Wave
      device values.Only update Energy usage of enabled devices.Only show
      enabled Weather and Newsfeeds.Apply calibration and divide calculations
      when displaying device values.Only create RRDTool graphs for enabled
      devices.Various code cleanups.

    * CFritzBox.class, FPhone.class, Mail.module, ServerStats.module: Phone list
      column width adjustment.Log sending mail with subject and receiver
      address.Better ServerStats logging.

2009-11-01  rdnzl

    * .project, FSettingsSound.form, FToolsDatabaseAdmin.class,
      FToolsDatabaseAdmin.form, RRDTool.module, Sounds.module: Changed Sounds
      module to use aplay instead of sdl.sound.Recreate ServerStats RRDs after
      deleting all RRD databases.Better RRDTool debug messages.

    * config.php.example, pc-off.gif, pc-on.gif: Add missing device icons to
      webclient structure.

2009-10-29  rdnzl

    * CFritzBox.class, FDeviceEditor.class, FSettingsMain.class: When creating a
      device from an existing one, don't copy it's device values and battery
      status.Fix bug where enabling main debug checkbox didn't enabled save
      button.If clip info is not available store "000000" in database.

    * FToolsZWaveCmdr.class: Disable buttons when Z-Wave interface is not
      enabled.

    * FCamera.form: Fix camera output window definition.

    * CVISCA.class, FCamera.form: Rearranged Camera window layout.Start of code
      cleanup for VISCA class.

    * CFritzBox.class, CRFXComRX.class, FPhone.class, FToolsZWaveCmdr.class,
      HDDTemp.module: Report phone call status in program log.Prevent wrong
      Z-Wave data to abort Z-Wave Commander.Report HDDTemp socket errors to
      program log instead of debug log.Fixed bug parsing Oregon rain gauge data.

2009-10-14  rdnzl

    * domotiga.sql: Fix menu table definition.

2009-10-13  rdnzl

    * CZWave.class, FToolsZWaveCmdr.class, FToolsZWaveCmdr.form: Added Z-Wave
      Sensor Get button to ZWave Commander.

    * CZWave.class, FToolsZWaveCmdr.class, FToolsZWaveCmdr.form: Added Z-Wave
      Meter Get button to ZWave Commander.

2009-10-12  rdnzl

    * FDeviceEditor.class, FDeviceEditor.form: Added more input validation
      checks to the Device Editor.

    * 01171to01172.sql: Fixed KNX/EIB interface settings.

    * domotiga.sql: Fix KNX/EIB interface settings and add missing Z-Wave node
      fields.

    * 01171to01172.sql: Remove language support for menu names, not needed.

    * FEditMenus.class, FEditMenus.form, FMain.class: Now you can edit the menu
      names too.

    * 01171to01172.sql: Added missing Z-Wave node database fields.

2009-10-11  rdnzl

    * domotiga.sql: Updated domotiga.sql to latest version.

    * .project, 01171to01172.sql, Bwired.module, CFritzBox.class,
      CPlugwise.class, CRFXComRX.class, CZWave.class, Devices.module,
      Digitemp.module, FCamera.form, FControl.class, FControl.form, FDSC.class,
      FDeviceEditor.form, FDevices.class, FEditBwiredDevices.class,
      FEditMenus.class, FEditMenus.form, FEvents.class, FMain.class, FMain.form,
      FSettingsBwiredMap.class, FSettingsDigitemp.form, FSettingsEmail.class,
      FSettingsSMS.class, FSettingsSMS.form, FSettingsTwitter.class,
      FSettingsZWave.class, FSettingsZWave.form, FSplashScreen.class,
      FToolsDatabaseAdmin.class, FToolsZWaveCmdr.class, FToolsZWaveCmdr.form,
      Main.module, RRDTool.module, domotiga.gambas, menus.png: New version
      0.1.172, you must upgrade your database!Display program version on
      splashscreen again.Fixed Fritz!Box parse code, announce in/outgoing calls
      in program log.Make menus configurable (see edit menus), was a request for
      a long time.Display scrollbar if a menu contains items that don't fit in
      window.Query for Z-Wave manufacturer and node type. Please report unknown
      id's!Enhanced Z-Wave Commander with more controller info.Changed Control
      page, make it more dynamic when window size changes.Made menu entry for
      DSC Pane, changed it's disabled message.Renamed zwave_devices and
      bwired_devices database table.Disable Send Tweet button if Twitter support
      is disabled.Same for Send Test e-mail, Bwired upload and Send SMS
      buttons.Fixed erasing RRD graphs from database admin tool.Update devices
      table when a device value is updated and AutoRefresh is enabled.Stop
      Z-Wave timer before module is restarted.Fixed typo in Z-Wave node optional
      functionality detection code.Get realtime values from Z-Wave nodes by
      implementing command class basic/basic get.Read supported classes from
      Z-Wave nodes.Done some debug message cleanup in Devices module.Rearranged
      Camera window layout.

2009-10-04  rdnzl

    * FToolsZWaveCmdr.class: Change column name in Z-Wave commander.

    * CZWave.class: Fixed bug/typo in Z-Wave node sleep/listen parse code.

2009-10-03  rdnzl

    * CPlugwise.class: Better error checking in Plugwise code.

    * CZWave.class, FToolsZWaveCmdr.form: Fixed Z-Wave dim bug (max value is
      0x64, not 0xff)

    * FToolsZWaveCmdr.class: Fix bug when Z-Wave controller was disabled.

    * .project, 01170to01171.sql, CCTX35.class, CFritzBox.class, CGPS.class,
      COneWire.class, CPlugwise.class, CRFXComTX.class, CWeeder.class,
      CZWave.class, Devices.module, Energy.module, FControl.class,
      FControl.form, FDeviceEditor.class, FDeviceEditor.form, FDevices.class,
      FHome.form, FMain.class, FMain.form, FNews.class, FPhone.class,
      FSettingsBwiredMap.class, FSettingsTwitter.class, FSettingsZWave.class,
      FSettingsZWave.form, FToolsDatabaseAdmin.class, FToolsDatabaseAdmin.form,
      FToolsRFXComCmdr.class, FToolsSerialPorts.class, FToolsZWaveCmdr.class,
      FToolsZWaveCmdr.form, Main.module, README, TODO, domotiga.gambas,
      domotiga.sql, zwave.png: New version 0.1.171, you must upgrade your
      database!Better error checking for Fritz!Box class.Added database name to
      window title.Use desktop settings for choosing the webbrowser.Added option
      to database admin tool to erase cdr table.Cleaned up RFXCom commander
      code.Corrected typos in error messages.Added support calibration and
      divider values for devices.See Corrections tab in the Device
      editor.Removed the hardcoded ones, so check your values.
      (RFXMeter/Pulse)Fixed interface fields for, AIBO, UPS and HDDTemp.Added
      basic support for Z-Wave devices, please give feedback!Added ZWave
      Commander to Tools menu.

2009-09-18  rdnzl

    * FControl.class, FHome.class: Don't delete the toolbar from Control page
      when refreshing it.Check if energy usage value is valid before building
      Home page dials.

    * 01170to01171.sql: Added X10Security to protocol field of RFXCOm
      interface.Same for 1-Wire to Midon interface.

    * 01170to01171.sql: Added HE to support protocols field of RFXCom interface.

    * 01170to01171.sql: Fixed bug where causing adding RFXPulse, Pwr devices
      giving an error.

2009-09-14  rdnzl

    * .project, 01169to01170.sql, CRFXComTX.class, Devices.module,
      FControl.class, FControl.form, FDeviceEditor.class, FDeviceEditor.form,
      FDevices.class, FMain.class, FMain.form, FSettingsRFXComTX.class,
      FSettingsRFXComTX.form, FTextViewer.class, FTextViewer.form,
      FToolsRFXComCmdr.class, FToolsRFXComCmdr.form, FToolsRFXComSimulate.class,
      FToolsRFXComSimulate.form, FToolsX10Cmdr.class, Main.module,
      aibo-ers7.jpg, asrock.jpg, domotiga.sql, kaku-ac-300.jpg: New version
      0.1.170, you must upgrade your database!Added RFXCom Transmitter support
      for newer KAKU and HE devices (AC), please test!Added Dim level slider to
      Control page for AC type devices, needs more work.Small error message and
      comments change in Devices module.Save device value with Dim 0 as Off, and
      Dim 100 as On.Added enhancements to DeviceEditor to support newer RFXComTX
      protocol.Also added check if selected interface supports selected
      devicetype.Renamed tool RFXCom Simulate to RFXCom Commander.Added AC
      address database field to RFXComTX settings.Added refresh button to
      Control page.Added fix to display Dim icons to Devices page.

2009-09-08  rdnzl

    * domotiga.gambas: Updated pre-compiled binary to latest version.

    * domotiga.sql: Updated install file to latest version.

    * Devices.module, Heyu.module: Now store Heyu device value changes and add
      better debug output.

    * 01167to01168.sql, 01167to1168.sql: Renamed upgrade script.

    * .project, 01168to01169.sql, CRFXComRX.class, CRFXComTX.class,
      Devices.module, FDeviceEditor.class, FDeviceEditor.form,
      FEditModulesGroups.class, FEditModulesGroups.form,
      FSettingsRFXComTX.class, FSettingsRFXComTX.form,
      FToolsRFXComSimulate.class, FToolsRFXComSimulate.form,
      FToolsX10Cmdr.class, Main.module, kaku-par-1000.jpg, sony-aibo-ers-7.jpg,
      sony-aibo-ers7.jpg: New version 0.1.169, you must upgrade your
      database!Code cleanup in RFXComRX.Added RFXCom transmitter support for
      X10, KAKU, ARC, please test.Added Kaku devicetype.Fixed bug where Heyu
      interface had wrong id.Added better error checking to
      Devices.SetDevice().Changed tab order of several forms fields.Added
      protocol enable/disable fields for RFXCom transmitter.Added support for
      transmitter to RFXCom Simulate tool and X10 Cmdr.Make interface handle
      null if interface can't be opened.Made preparations for calibration and
      divider fields for device values.

2009-09-06  rdnzl

    * FDeviceEditor.class: Check for selected interface after editing devices.

    * CRFXComRX.class: Optimized lots of format routines, and fixed bugs inside
      RFXSensor code.

    * domotiga.gambas, domotiga.sql: Updated sql install file to latest
      version.Same for the pre-compiled executable.

    * .icon.png, .project, 01167to1168.sql, 5410041360608.jpg,
      8710400136880.jpg, 8710400190868.jpg, 8710496503986.jpg,
      8713300042435.jpg, 8715700016504.jpg, 8722700208945.jpg, Devices.module,
      Digitemp.module, FBarcodes.class, FBarcodes.form, FCamera.class,
      FControl.class, FDeviceEditor.class, FEditModulesGroups.class,
      FEditModulesGroups.form, FFloorplans.class, FLogfiles.class,
      FLogfiles.form, FMain.class, FMain.form, FSettingsDigitemp.class,
      FSettingsDigitemp.form, FSettingsTwitter.class, FSettingsTwitter.form,
      FTextViewer.class, FTextViewer.form, FToolsRFXComSimulate.class,
      FToolsRFXComSimulate.form, FWeather.class, FWeather.form, Mail.module,
      Main.module, ServerStats.module, Twitter.module, en_US.po, fr.po, nl.po,
      stock: New version 0.1.168, you must upgrade your database!Better device
      query error checks.Added Interface field to device Blacklist
      module.Support for Digitemp 1-wire temperature sensors added.Added product
      images support to Barcode module.Enhanced Barcode user interface.Control
      page will be refeshed after DeviceEditor actions.DeviceEditor has much
      better input validations now.Floorplan image browser points to correct
      path.Added button to Logfile form so you can load the entire logfile in
      viewer.You can now sent a custom Test Tweet from the Twitter setting
      window.Added Transmitter tab to RFXCom tools window.The Weather page now
      displays images defined in weatherfeeds table.Fixed problem with closing
      Plugwise timer.

    * CRFXComRX.class: More debug messages for RFXSensor devices (until bug is
      found).

    * COneWire.class: Better error checking.

2009-09-03  rdnzl

    * CRFXComRX.class: Display correct close message depending on type of
      interface.

2009-08-31  rdnzl

    * Bwired.module: Changed Bwired http post error check, seems the webserver
      changed it's behaviour.

    * FToolsDatabaseAdmin.class, FToolsDatabaseAdmin.form, RRDTool.module: Added
      delete RRD data functions to database admin tool.

    * FToolsSerialPorts.form: Made window taller to accommodate more ports.

    * FSettingsBluetooth.class: Code cleanup.

    * FDebug.class, FDebug.form: Added test button for Emily voice.

    * FSettingsTwitter.class, FSettingsTwitter.form: Made window bigger and
      added View button.

    * FSettingsBwiredMap.class, FSettingsBwiredMap.form: Made window bigger and
      added View button.

2009-08-29  rdnzl

    * Devices.module: Only switch weeder devices when they are enabled.

    * COneWire.class: Strip leading white spaces from device values.

    * FToolsSerialPorts.class: Added Plugwise to list of serial interfaces.

2009-07-23  rdnzl

    * FMain.form: Remove icon linked to root of file menu.

2009-07-19  rdnzl

    * Main.module, domotiga.gambas: Fixed parsing of programs basedir.

2009-07-14  rdnzl

    * TODO: Added TODO items.

2009-07-13  rdnzl

    * TODO: Added TODO list.

2009-07-11  rdnzl

    * FSettingsEIB.class: Fixed typo.

    * CEIB.class: Optimized KNX/EIB parse routines.

    * 01166to01167.sql, domotiga.sql: Updated version inside upgrade file,
      updated domotiga.sql with all upgrade changes.

    * .project, 01166to01167.sql, domotiga.gambas: Update version to 0.1.167.
      You need to update your database.Added new KNX/EIB device types.

    * CEIB.class, Devices.module, FMain.class, FMain.form, FSettingsEIB.class:
      Added KNX/EIB support for EIS3 and EIS4 devices.

2009-07-06  rdnzl

    * CDomotica.class, FMain.class, FMain.form, FSettingsDomotica.class,
      FSettingsDomotica.form, FToolsSerialPorts.class, Main.module: Added
      settings form for coming Domotica support.

2009-07-04  rdnzl

    * FControl.class: Changed dim/brightness.

    * .project, 01165to01166.sql, CEIB.class, Devices.module,
      FDeviceEditor.class, FDeviceEditor.form, FMain.class, FMain.form,
      FSettingsEIB.class, FSettingsEIB.form, Main.module, domotiga.gambas,
      knx.png: Update version to 0.1.166. You need to update your database.Added
      KNX/EIB support (EIS1 and EIS2 devices), thanks Timo.Changed way
      dim/bright works on Control page.

    * FEditNewsWeather.class~, FEditNewsWeather.form~: Deleted temp files.

    * CDSC.class, FEditNewsWeather.class, FEditNewsWeather.class~,
      FEditNewsWeather.form, FEditNewsWeather.form~, FEditNewsfeeds.class,
      FEditNewsfeeds.form, FMain.class, FMain.form: Added DSC lcdtext.Combined
      Newsfeed editor with new Weather and Trafficfeed editor.

2009-06-30  rdnzl

    * CDSC.class: Some DSC LCD text changes.

2009-06-28  rdnzl

    * clipsal-cent-a-meter.jpg, dsc-contact.jpg, dsc-pir.jpg, dsc-smoke.jpg,
      kaku-doorbell.jpg, oregon-aw129.jpg, oregon-aw131.jpg, oregon-rgr126.jpg,
      oregon-rgr918.jpg, oregon-thc138.jpg, oregon-thc218.jpg,
      oregon-thgn122n.jpg, oregon-thgn123n.jpg, oregon-thgr122n.jpg,
      oregon-thgr268.jpg, oregon-thgr918.jpg, oregon-thr138.jpg,
      oregon-thwr800.jpg, oregon-uvn800.jpg, oregon-wgr800.jpg,
      oregon-wgr918.jpg, oregon-wtgr800.jpg, owl-cm113.jpg, owl-cm119.jpg: Added
      more device icons.

    * orgeon-thr128.jpg: Removed wrong device icon.

2009-06-26  rdnzl

    * FEditBlacklist.class, FEditBlacklist.form, FEditFloorsLocations.class,
      FEditFloorsLocations.form, FEditModulesGroups.class,
      FEditModulesGroups.form, FMain.class, FMain.form, bin.png, groups.png:
      Combined Modules, Groups, Etc. settings in one window.

    * CCTX35.class, FAbout.class, FAbout.form, FDSC.class, FHome.class,
      FMain.class, FMain.form, FSettingsCTX35.class, FSettingsDSC.class,
      FSettingsOneWire.class, FSettingsRFXComRX.class, FSettingsRFXComTX.class,
      FSettingsSMS.class, FSettingsSMS.form, HDDTemp.module, Mail.module,
      Main.module, Sounds.module, domotiga.conf, donate.gif, donate.png: Changed
      about menu and window.Clear command string after pressing Enter in DSC
      module.Increased refresh timer of Home screen.Only display leds of enabled
      interfaces.Rename Falcom SMS to SMS Modem.Removed hardcoded basedir, so
      you can install DomotiGa somewhere else now.Removed unused SQLDebug
      variable from code and config.Continue to start program even if sounds
      can't be loaded.Only report e-mail sent when done, give error code when it
      failed.

2009-06-22  rdnzl

    * Bwired.module, EventLoop.module, Twitter.module: Sent same Planttalk quote
      to Twitter and to Speak/Logfile.Increased http timeout of Twitter and
      Bwired client.

2009-06-21  rdnzl

    * FHome.class: Fix bug displaying Outside frame when there is no outside
      sensor defined.

    * CRFXComRX.class: Fixed bug in temp value Oregon TH2 sensors.Report Oregon
      temperatures as °C or °F depending on Temperature Unit setting.

2009-06-20  rdnzl

    * Devices.module: Better device not found log output.

    * CRFXComRX.class: Also log battery status of X10 security devices.

    * FToolsSerialPorts.class: Code cleanup.

    * Main.module: Stop DSC timer when closing program.

    * CCTX35.class, CDSC.class, COneWire.class, CPlugwise.class,
      CRFXComRX.class, CUPS.class, CXMLRPC.class, Devices.module,
      HDDTemp.module: Display device type too if a device is not found.

2009-06-17  rdnzl

    * pc-off.gif, pc-on.gif: Computer icons added.

2009-06-16  rdnzl

    * CGPS.class, CWebServer.class: Code cleanups.

    * Bluetooth.module, CVISCA.class, Devices.module, FCamera.class,
      RRDTool.module: Code cleanups.Added forgotten new device tables to
      InitTable.

    * domotiga.sql: Disable SMS modem by default.

2009-06-14  rdnzl

    * domotiga.gambas: Updated compiled version to 0.1.165.

    * .project, 01164to01165.sql, CRFXCom.class, CRFXComRX.class,
      CRFXComTX.class, Energy.module, FDeviceEditor.class, FDeviceEditor.form,
      FMain.class, FMain.form, FSettingsRFXCom.class, FSettingsRFXCom.form,
      FSettingsRFXComRX.class, FSettingsRFXComRX.form, FSettingsRFXComTX.class,
      FSettingsRFXComTX.form, FToolsRFXComSimulate.class,
      FToolsRFXComSimulate.form, FToolsSerialPorts.class, Main.module,
      domotiga.sql: Version update to 0.1.165. You need to update your
      database.Fixed crontab weekdays bug.You can disable HE-UK and HE-UE now
      with RFXCom tool.Added framework for RFXCom Transmitter support.Added
      support for a bunch of Oregon sensors to RFXCom receiver code. Needs
      testing.Added code for RFXSensor support. Needs testing.Added device icon
      for dimmed status.Added extended code settings for devices.Changed
      device-editor layout.RFXMeter code cleanup.Added KAKU amst-606 and
      awst-8802 support.

    * DNS.module, FDebug.form, FEditModulesGroups.class, FHome.class,
      FHome.form, FSplashScreen.class, FWeather.class, FWeather.form: Debug
      screen layout change.Home screen better error checking.DNS lookups async.

    * Devices.module: Better error checking.

    * kaku-amst-606.jpg, kaku-awst-8802.jpg: Added some KAKU device icons.

    * README: Updated database install notes.

    * CDSC.class, FDSC.class, FDSC.form, FMain.class, FMain.form,
      FSettingsDSC.class, FSettingsDSC.form, powerkeypad.png: Added DSC Security
      Panel, thanks Timo. And added better error checking.

    * CSMS.class, Main.module: Better SMS modem initialization.

2009-06-04  rdnzl

    * FControl.class: Dimable devices can also be switched on/off now.

2009-05-31  rdnzl

    * FDeviceEditor.class, FHome.class, FHome.form, FSettingsHDDTemp.class:
      Fixed HDDTemp enabled setting save.Fixed Home screen Outside and Power
      sensor detection.If a DSC device is created the DSC5401 interface is
      chosen by default.

    * domotiga.sql, user.sql: Fixed domotiga.sql, no need to import all upgrades
      anymore with new install.

2009-05-29  rdnzl

    * Bwired.module: Removed hardcoded website picture.

    * CXMLRPC.class: Changed XMLRPC API version to 0.02

    * Bwired.module, CDSC.class, FEditBwiredDevices.class,
      FEditBwiredDevices.form, FSettingsBwiredMap.class,
      FSettingsBwiredMap.form, FSettingsDSC.class, FSettingsDSC.form,
      FSettingsTwitter.class, FSettingsTwitter.form, Twitter.module, gas.gif,
      twitter.gif: Added new files.

    * .project, 01163to01164.sql, AIBO.module, CGPS.class, CIRMan.class,
      CXMLRPC.class, Devices.module, Energy.module, EventLoop.module,
      Events.module, FHome.class, FMain.class, FMain.form, FPhone.class,
      FSettingsBluetooth.class, FSettingsGmail.form, FToolsSerialPorts.class,
      HDDTemp.module, Mail.module, Main.module, ServerStats.module,
      VideoServer.module, domotiga.gambas: Updated version to 0.1.164 you need
      to load sql upgrade script.AIBO code cleanup.DSC Security Panel support
      added, thanks Timo.NMEA GPS parse routine added, thanks Timo.Bwired XML
      upload support added.Added Program uptime.Only sent battery empty e-mail
      when needed, if enabled and low.Changed sql table name for energy usage.
      (usage was preserved sql keyword)Made http post/get routines async (you
      need gambas 2.13.1 or higher!)Daily Tagline is now a globalvar.Enable save
      button on Bluetooth settings.Rename GMail settings window.HDDTemp and
      ServerStats code cleanup.You can sent Tweets to Twitter now.

2009-05-04  rdnzl

    * CFritzBox.class: Fix EOL parsing.

2009-05-03  rdnzl

    * Events.module: Better error checking.

    * CFritzBox.class:

2009-04-29  rdnzl

    * FDevices.class: Code cleanup.

    * AIBO.module, Bluetooth.module: Better error checking.

2009-04-15  rdnzl

    * domotiga.js: Fix ajax refresh code for IE8.

2009-03-23  rdnzl

    * FSettingsXMLRPC.class: Check for minimal Gambas version.

    * CXMLRPC.class: Continue program even if XML-RPC server fails to start.

    * Main.module: Fix error log strings.

    * functions.php: Fixed charset encoding so celsius label looks ok.

    * dallas-ds18s20.jpg: Replaced Dallas ds18s20 image with better one.

    * index.php: Better error checking to see if php xmlrpc module is installed.

2009-03-22  rdnzl

    * FDeviceEditor.class: Display device module list sorted.

    * oregon-rtgr328n.jpg: Added device icon for Oregon RTGR328N.

    * Devices.module: Devices.Find() now doesn't return deviceid for disabled
      devices anymore.

    * oregon-pcr800.jpg: Added device icon for Oregon PCR800.

    * FDeviceEditor.form: Added mm and mm/hr device labels for rain gauge.

    * functions.php: Fix device status icon if none is set in device editor.

2009-03-21  rdnzl

    * CXMLRPC.class: Fixed api.version method.

    * CXMLRPC.class: Only return non-hidden and enabled devices, add api.version
      method.

2009-03-20  rdnzl

    * COPYING, README, aibo.gif, bt.png, button.gif, close.gif, common.js,
      config.php.example, domotiga.js, door-closed.png, door-open.png,
      downarrow.gif, drive.png, energy.png, fan-off.gif, fan-on.gif,
      favicon.ico, functions.php, gas.gif, gps.png, hd.png, htaccess.example,
      hygro.png, icons, images, index.php, json.php, light-off.png,
      light-on.png, loading.gif, loading.html, logo.png, mail-off.png,
      mail-on.png, maskBG.png, motion-off.gif, motion-on.gif, mute.png,
      question.png, rain.png, scale.png, settings.php, smoke.png, sms.png,
      sound.png, style.css, subModal.css, subModal.js, submodal, sun.png,
      sunset.png, temp.gif, uparrow.gif, ups.gif, webclient, wire.png: Added the
      webclient component.

    * Main.module: Fixed restart of xml-rpc and web server after settings save.

2009-03-19  rdnzl

    * 01162bto01163.sql: Added sql upgrade script for xml-rpc settings.

    * .project, CXMLRPC.class, FMain.class, FMain.form, FSettingsXMLRPC.class,
      FSettingsXMLRPC.form, Main.module, xml.png: Added XML-RPC server
      functionality. Upped version to 0.1.163.

    * CCTX35.class: Fixed serial port settings so TI103 interface works now too.

2009-03-18  rdnzl

    * 01162to01162b.sql: Add missing conditions table.

    * Energy.module: Do a better check on valid sql result.

    * FDeviceEditor.class: Fixed typos in sql save command regarding rrd4
      settings.

2009-03-17  rdnzl

    * FHome.class, FHome.form: Fixed routine for finding RFXPwr module.

    * 01158to01160.sql, 01160to01162.sql, pre01158to01160.sql: Added missing sql
      upgrade scripts.

    * Events.module: Added missing Events module.

2009-03-07  rdnzl

    * CRFXCom.class: Fixed Oregon temperature readings.

2009-03-06  rdnzl

    * CWeeder.class: Changed read serial behaviour.

    * Energy.module: Support for energy debug variable.

    * FToolsRFXComSimulate.class: Changed behaviour.

    * FMain.form: Added menus for event, action and trigger editor.

    * FEvents.class, FEvents.form, FMain.class: Enabled support for events.

    * FSettingsMain.form: Added support for more debug settings.

    * FLogfiles.class, FLogfiles.form, Main.module: Add pause button to logfile
      window.

    * Bluetooth.module, CUPS.class, FDeviceEditor.form, FDevices.class: Added
      support for 4th device value.

    * FSettingsMain.class: Added debug settings for events, devices, energy.

    * .project, AIBO.module, CCTX35.class, COneWire.class, CPlugwise.class,
      CRFXCom.class, Devices.module, FDeviceEditor.class, HDDTemp.module,
      RRDTool.module: Added 4th device value, rrd and label support.

    * FTriggerEditor.class~, FTriggerEditor.form~: Remove temp files.

    * FActionEditor.class, FActionEditor.form, FConditionEditor.class,
      FConditionEditor.form, FEventEditor.class, FEventEditor.form,
      FSettingsWeeder.class, FTriggerEditor.class, FTriggerEditor.class~,
      FTriggerEditor.form, FTriggerEditor.form~: Add event, condition, trigger
      and action editor.

    * FLocations.class, FLocations.form: Minor layout/size fixes.

    * pre01158to01160.sql, upgrade.sql: Renamed upgrade script to new filename
      format.

    * upgrade.sql, upgrade2.sql: Merged database upgrade scripts.

    * FPhone.class: Code cleanup and column renamed from Line to Channel.

    * FHome.class, FHome.form: Added google dials for outside temp and energy
      usage.

    * README, upgrade, upgrade.sql, upgrade2.sql: Created install and upgrade
      directory and updated documentation.

    * domotiga.sql, install, user.sql: Move install related files to install
      directory.

    * Mail.module: Add support for sending camera captures via e-mail.

    * actions.png, conditions.png, event.png, triggers.png: Add menu icons for
      event, condition, action and triggereditor.

    * FSplashScreen.form: Small copyright/layout fix.

    * FSettingsRRDTool.class: Fix close button behaviour.

    * ServerStats.module: Small source layout fix.

    * FClimate.form, FEnergy.form, FFloorplans.form, FHVAC.form, FSecurity.form:
      Small layout fix.

    * FAbout.form: Minor layout change.

    * EventLoop.module: Disable hardcoded events.

    * aibo-ers7.jpg, apc-smartups1000.jpg, bluetooth-device.jpg,
      dallas-ds18s20.jpg, devices, hddtemp-item.jpg, itho-eco-fan.jpg,
      marmitek-ad10.jpg, marmitek-am12.jpg, marmitek-ds90.jpg,
      marmitek-ld11.jpg, marmitek-lm12.jpg, marmitek-lw10g.jpg,
      marmitek-lw11.jpg, marmitek-ms13-m.jpg, marmitek-ms13e-l.jpg,
      marmitek-ms13e-m.jpg, marmitek-sd90.jpg, marmitek-tm13.jpg,
      oregon-bthr918n.jpg, oregon-bthr968.jpg, oregon-bwr102.jpg,
      oregon-gr101.jpg, oregon-thgr228n.jpg, oregon-thgr238n.jpg,
      oregon-thgr810.jpg, oregon-thn132n.jpg, oregon-thr128.jpg,
      oregon-thwr288.jpg, oregon-thx138.jpg, oregon-uv138.jpg,
      orgeon-thr128.jpg, plugwise-circle+.jpg, plugwise-circle.jpg,
      rfxpulse-gas.jpg, rfxpulse-water.jpg, rfxpwr-module.jpg,
      sony-aibo-ers-7.jpg, xanura-sax35.jpg: Add device images.

2009-01-11  rdnzl

    * FFloorplans.class: Now floorplans can display animated gifs too for device
      icons.

    * FControl.class: Fixed icons, get them from domotiga/icons now.

    * FAbout.form: Added 2009 to copyright.

2009-01-06  rdnzl

    * FToolsSerialMon.form: Added missing 4800 baud to serial speed combo.

    * FDeviceEditor.class: Check if device name is unique before adding new
      device.

    * CWeeder.class: Added more error checking for serial data.

    * CCTX35.class: Better error checking when usb cable is pulled.

    * Mail.module: Only report Gmail mails if something changed, fixed signature
      format.

2009-01-04  rdnzl

    * Main.module: Display correct RFXPwr and RFXPulse values in overviews too.

    * FDevices.class: Display correct RFXPwr and RFXPulse values (/100).

    * CRFXCom.class, FToolsRFXComSimulate.class, FToolsRFXComSimulate.form:
      Removed any reference to HomeEasy protocol in RFXCom code on request
      ofBert from RFXCom.

2009-01-02  rdnzl

    * Energy.module: Fixed bug not calculating RFXCom energy usage if *_usage
      tables where empty.

    * FDeviceEditor.class: Added more error checking to fetching tables code.

2008-12-31  rdnzl

    * Main.module: Support for animated gif device status icons added in
      overviews.

    * nl.po: Updated Dutch translations.

    * FDevices.class: Fill lastseen field with never instead of blank.

    * FDeviceEditor.class: Corrected spell errors.

    * Devices.module: Sql keywords in upper case.

    * CUPS.class: Added UPS temperature support.

2008-12-30  rdnzl

    * Energy.module, EventLoop.module, FDevices.class,
      FToolsDatabaseAdmin.class, FToolsDatabaseAdmin.form, Main.module,
      domotiga.sql, upgrade2.sql: Added support for energy usage log of RFXPulse
      water and gas modules.

    * FLocations.class: Fixed scrollview width.

    * FDeviceEditor.form: Rearranged label2 combo list.

    * CRFXCom.class: Try read RFXCom data to prevent error while unplugging
      module.

2008-12-29  rdnzl

    * CRFXCom.class, Main.module: Fixed RFXCom value3 updates and sensor
      overview headers.

2008-12-28  rdnzl

    * Main.module: Display correct status icon in sensor overviews, don't
      display header when no sensors in group found.

    * EventLoop.module: Added Doorbell event trigger.

    * Devices.module: Fix updating Marmitek DS90 value1, wasn't working anymore.

    * FDevices.class: Fix updating devices value fields when cleared manually.

2008-12-24  rdnzl

    * fritz.jpg, plugwise.jpg: Added missing icon files.

    * Devices.module, FMain.form, FSettingsFritzBox.form,
      FSettingsPlugwise.form, door-closed.png, door-open.png, fan.gif,
      light-off.png, mail-off.png, mail-on.png, motion-off.gif, motion-on.gif,
      rain.png, smoke.png, temp.gif: Removed unused icons and added icons for
      Plugwise and Fritzbox.

    * VideoServer.module: Removed unused code.

    * Devices.module: Also show interface name if a device is not found.

2008-12-23  rdnzl

    * CCTX35.class: Corrected Development Status and added Credits.

    * CCTX35.class: Fixed CTX35 read bug.

    * CCTX35.class, Main.module: Added CTX35 read support for ON/OFF thanks
      BWired!

    * FDeviceEditor.class: Use MySQL substitute function.

    * FCaptures.class, Main.module, VideoServer.module: Changed VideoServer to
      use YOICS IP9100 firmware.

2008-12-18  rdnzl

    * CPlugwise.class: Added Plugwise device state query support.

2008-12-16  rdnzl

    * .project, CPlugwise.class, Main.module, RRDTool.module: Fixed missing
      Plugwise variables and RRDTool support for Value3

2008-12-14  rdnzl

    * CFritzBox.class, CPlugwise.class, CRFXCom.class, CUPS.class,
      Devices.module, FDeviceEditor.class, FDeviceEditor.form, FDevices.class,
      FEditModulesGroups.class, FMain.class, FMain.form,
      FSettingsFritzBox.class, FSettingsFritzBox.form, FSettingsPlugwise.class,
      FSettingsPlugwise.form, FToolsRFXComSimulate.class,
      FToolsRFXComSimulate.form, domotiga.sql, en_US.po, upgrade.sql: Added
      RFXCom simulate disable buttonsAdded initial FritzBox call-log
      supportAdded Plugwise device switching and power usage measurement
      supportAdded 3rd value to devices table, editor and overviews

2008-12-04  rdnzl

    * CRFXCom.class, FLogfiles.form, FToolsRFXComSimulate.class,
      FToolsRFXComSimulate.form: Added string to RFXCom debug log.

2008-12-03  rdnzl

    * .icon.png, CIRMan.class, CPlugwise.class, CRFXCom.class,
      FDeviceEditor.form, FMain.class, FMain.form, FToolsRFXComSimulate.class,
      FToolsRFXComSimulate.form, upgrade.sql: Added various Oregon sensors and
      RFXCom simulate tool.

2008-12-02  rdnzl

    * domotiga.sql: Added settings_plugwise table to domotiga.sql dump.

    * CPlugwise.class: Added Plugwise class file.

    * fr.mo, fr.po: Added empty French lang files.

    * .pot, .settings: Removed temp files from svn.

    * #project.pot, AIBO.pot, Astro.pot, Bluetooth.pot, CAsterisk.pot,
      CCTX35.pot, CGPS.pot, CIRMan.pot, CItems.pot, COneWire.pot, CRFXCom.pot,
      CSMS.pot, CUPS.pot, CVISCA.pot, CWebServer.pot, CWeeder.pot, DNS.pot,
      Devices.pot, Energy.pot, EventLoop.pot, FAbout.pot, FBarcodes.pot,
      FCamera.pot, FCaptures.pot, FClimate.pot, FControl.pot, FDebug.pot,
      FDeviceEditor.pot, FDevices.pot, FEditBlacklist.pot, FEditContacts.pot,
      FEditFloorsLocations.pot, FEditModulesGroups.pot, FEditNewsfeeds.pot,
      FEditNotify.pot, FEditUsers.pot, FEmail.pot, FEnergy.pot, FEvents.pot,
      FFloorplanEditor.pot, FFloorplans.pot, FHVAC.pot, FHome.pot,
      FLocations.pot, FLogfiles.pot, FMain.pot, FNews.pot, FPhone.pot,
      FSecurity.pot, FSelectDate.pot, FSelectImage.pot, FServerStats.pot,
      FSettingsAIBO.pot, FSettingsAsterisk.pot, FSettingsAstro.pot,
      FSettingsBluetooth.pot, FSettingsCTX35.pot, FSettingsCamVisca.pot,
      FSettingsEmail.pot, FSettingsGPS.pot, FSettingsGmail.pot,
      FSettingsHDDTemp.pot, FSettingsHeyu.pot, FSettingsIRMan.pot,
      FSettingsMain.pot, FSettingsMySQL.pot, FSettingsOneWire.pot,
      FSettingsRFXCom.pot, FSettingsRRDTool.pot, FSettingsSMS.pot,
      FSettingsServerStats.pot, FSettingsSound.pot, FSettingsTVGuide.pot,
      FSettingsUPS.pot, FSettingsVideoServer.pot, FSettingsVoiceText.pot,
      FSettingsWebserver.pot, FSettingsWeeder.pot, FSplashScreen.pot,
      FTVGuide.pot, FToolsBluetoothBrowser.pot, FToolsDatabaseAdmin.pot,
      FToolsSerialMon.pot, FToolsSerialPorts.pot, FToolsX10Cmdr.pot,
      FWeather.pot, HDDTemp.pot, Heyu.pot, Mail.pot, Main.pot, RRDTool.pot,
      ServerStats.pot, Sounds.pot, TVGuide.pot, VideoServer.pot, VoiceText.pot:
      Removed temp language files.

    * FMain.class, FMain.form, FSettingsPlugwise.class, FSettingsPlugwise.form,
      FToolsSerialMon.form, Main.module, upgrade.sql: Add initial Plugwise code.

    * README: Corrected spell errors.

    * README: Revamped contents and corrected spell errors.

    * DomotiGa.desktop: Reversed changes.

    * .project: Corrected project logo.

    * .gambas: Removed .gambas directory.

    * Main.module: Correctly spell initialize.

    * AIBO.module, Astro.module, Bluetooth.module, CAsterisk.class,
      CCTX35.class, CGPS.class, CIRMan.class, CItems.class, COneWire.class,
      CRFXCom.class, CSMS.class, CUPS.class, CVISCA.class, CWebServer.class,
      CWeeder.class, DNS.module, Devices.module, Energy.module,
      EventLoop.module, FAbout.class, FBarcodes.class, FCamera.class,
      FCaptures.class, FClimate.class, FControl.class, FDebug.class,
      FDeviceEditor.class, FDevices.class, FEditBlacklist.class,
      FEditContacts.class, FEditFloorsLocations.class, FEditModulesGroups.class,
      FEditNewsfeeds.class, FEditNotify.class, FEditUsers.class, FEmail.class,
      FEnergy.class, FEvents.class, FFloorplanEditor.class, FFloorplans.class,
      FHVAC.class, FHome.class, FLocations.class, FLogfiles.class, FNews.class,
      FPhone.class, FSecurity.class, FSelectDate.class, FSelectImage.class,
      FServerStats.class, FSettingsAIBO.class, FSettingsAsterisk.class,
      FSettingsAstro.class, FSettingsBluetooth.class, FSettingsCTX35.class,
      FSettingsCamVisca.class, FSettingsEmail.class, FSettingsGPS.class,
      FSettingsGmail.class, FSettingsHDDTemp.class, FSettingsHeyu.class,
      FSettingsIRMan.class, FSettingsMain.class, FSettingsMySQL.class,
      FSettingsOneWire.class, FSettingsRFXCom.class, FSettingsRRDTool.class,
      FSettingsSMS.class, FSettingsServerStats.class, FSettingsSound.class,
      FSettingsTVGuide.class, FSettingsUPS.class, FSettingsVideoServer.class,
      FSettingsVoiceText.class, FSettingsWebserver.class, FSettingsWeeder.class,
      FSplashScreen.class, FTVGuide.class, FToolsBluetoothBrowser.class,
      FToolsDatabaseAdmin.class, FToolsSerialMon.class, FToolsSerialPorts.class,
      FToolsX10Cmdr.class, FWeather.class, HDDTemp.module, Heyu.module,
      Mail.module, RRDTool.module, ServerStats.module, Sounds.module,
      TVGuide.module, VideoServer.module, VoiceText.module: Changed LICENSE to
      COPYING.

    * COPYING, LICENSE: Renamed LICENSE to COPYING.

    * Main.module: Check for lastseen value.

    * Mail.module: Cleanup e-mail announcements.

    * FServerStats.class: Display other server stats on week, month, year too.

    * FBarcodes.class: Barcode Shoppinglist and Stocklist output cleanup.

    * .project, .settings: Bumped version to 0.1.159 and corrected author's
      e-mail address.

    * DomotiGa.desktop: Display other server stats on week, month, year too.

2008-12-01  rdnzl

    * FDeviceEditor.form: Added labels blank and m3.

    * CWeeder.class: Serial port read changed.

    * CSMS.class: Debug output changed.

    * CVISCA.class: Serial port read changed.

    * CIRMan.class: Serial port read changed.

    * CCTX35.class: Code cleanup.

    * FSettingsSMS.class, FSettingsSMS.form: Fixed settings form for SMS,
      value's for PIN and service center where not saved.

    * FEnergy.class: Fixed Energy Day toggle button.

    * .settings: Cleanup open windows.

    * FToolsSerialMon.class: Deleted unused variables from SerialPort Monitor.

    * HDDTemp.module: Fixed HDDTemp support, didn't work correctly in all
      situations.

    * COneWire.class: Redesigned OneWire Read function, so input get's buffered.

    * CRFXCom.class: Added Oregon BRW101, BWR102 and GR101 initial support

    * domotiga: Removed empty directory.

    * .settings, FToolsSerialMon.class: FToolsSerialMon.class* CLEANUP: Removed
      unused variables.

2008-11-29  riemers

    * #project.pot, .directory, .gambas, .icon.png, .lang, .pot, .project,
      .settings, 1stfloor.jpg, 2ndfloor.jpg, AIBO, AIBO.module, AIBO.pot, ASTRO,
      AUTHORS, Astro.module, Astro.pot, BLUETOOTH, Bluetooth.module,
      Bluetooth.pot, CASTERISK, CAsterisk.class, CAsterisk.pot, CCTX35,
      CCTX35.class, CCTX35.pot, CGPS, CGPS.class, CGPS.pot, CHANGELOG, CIRMAN,
      CIRMan.class, CIRMan.pot, CITEMS, CItems.class, CItems.pot, CONEWIRE,
      COneWire.class, COneWire.pot, CRFXCOM, CRFXCom.class, CRFXCom.pot, CSMS,
      CSMS.class, CSMS.pot, CUPS, CUPS.class, CUPS.pot, CVISCA, CVISCA.class,
      CVISCA.pot, CWEBSERVER, CWEEDER, CWebServer.class, CWebServer.pot,
      CWeeder.class, CWeeder.pot, DEVICES, DNS, DNS.module, DNS.pot,
      Devices.module, Devices.pot, DomotiGa, DomotiGa.desktop, ENERGY,
      EVENTLOOP, Energy.module, Energy.pot, EventLoop.module, EventLoop.pot,
      FABOUT, FAbout.class, FAbout.form, FAbout.pot, FBARCODES, FBarcodes.class,
      FBarcodes.form, FBarcodes.pot, FCAMERA, FCAPTURES, FCLIMATE, FCONTROL,
      FCamera.class, FCamera.form, FCamera.pot, FCaptures.class, FCaptures.form,
      FCaptures.pot, FClimate.class, FClimate.form, FClimate.pot,
      FControl.class, FControl.form, FControl.pot, FDEBUG, FDEVICEEDITOR,
      FDEVICES, FDebug.class, FDebug.form, FDebug.pot, FDeviceEditor.class,
      FDeviceEditor.form, FDeviceEditor.pot, FDevices.class, FDevices.form,
      FDevices.pot, FEDITBLACKLIST, FEDITCONTACTS, FEDITFLOORSLOCATIONS,
      FEDITMODULESGROUPS, FEDITNEWSFEEDS, FEDITNOTIFY, FEDITUSERS, FEMAIL,
      FENERGY, FEVENTS, FEditBlacklist.class, FEditBlacklist.form,
      FEditBlacklist.pot, FEditContacts.class, FEditContacts.form,
      FEditContacts.pot, FEditFloorsLocations.class, FEditFloorsLocations.form,
      FEditFloorsLocations.pot, FEditModulesGroups.class,
      FEditModulesGroups.form, FEditModulesGroups.pot, FEditNewsfeeds.class,
      FEditNewsfeeds.form, FEditNewsfeeds.pot, FEditNotify.class,
      FEditNotify.form, FEditNotify.pot, FEditUsers.class, FEditUsers.form,
      FEditUsers.pot, FEmail.class, FEmail.form, FEmail.pot, FEnergy.class,
      FEnergy.form, FEnergy.pot, FEvents.class, FEvents.form, FEvents.pot,
      FFLOORPLANEDITOR, FFLOORPLANS, FFloorplanEditor.class,
      FFloorplanEditor.form, FFloorplanEditor.pot, FFloorplans.class,
      FFloorplans.form, FFloorplans.pot, FHOME, FHVAC, FHVAC.class, FHVAC.form,
      FHVAC.pot, FHome.class, FHome.form, FHome.pot, FLOCATIONS, FLOGFILES,
      FLocations.class, FLocations.form, FLocations.pot, FLogfiles.class,
      FLogfiles.form, FLogfiles.pot, FMAIN, FMain.class, FMain.form, FMain.pot,
      FNEWS, FNews.class, FNews.form, FNews.pot, FPHONE, FPhone.class,
      FPhone.form, FPhone.pot, FSECURITY, FSELECTDATE, FSELECTIMAGE,
      FSERVERSTATS, FSETTINGSAIBO, FSETTINGSASTERISK, FSETTINGSASTRO,
      FSETTINGSBLUETOOTH, FSETTINGSCAMVISCA, FSETTINGSCTX35, FSETTINGSEMAIL,
      FSETTINGSGMAIL, FSETTINGSGPS, FSETTINGSHDDTEMP, FSETTINGSHEYU,
      FSETTINGSIRMAN, FSETTINGSMAIN, FSETTINGSMYSQL, FSETTINGSONEWIRE,
      FSETTINGSRFXCOM, FSETTINGSRRDTOOL, FSETTINGSSERVERSTATS, FSETTINGSSMS,
      FSETTINGSSOUND, FSETTINGSTVGUIDE, FSETTINGSUPS, FSETTINGSVIDEOSERVER,
      FSETTINGSVOICETEXT, FSETTINGSWEBSERVER, FSETTINGSWEEDER, FSPLASHSCREEN,
      FSecurity.class, FSecurity.form, FSecurity.pot, FSelectDate.class,
      FSelectDate.form, FSelectDate.pot, FSelectImage.class, FSelectImage.form,
      FSelectImage.pot, FServerStats.class, FServerStats.form, FServerStats.pot,
      FSettingsAIBO.class, FSettingsAIBO.form, FSettingsAIBO.pot,
      FSettingsAsterisk.class, FSettingsAsterisk.form, FSettingsAsterisk.pot,
      FSettingsAstro.class, FSettingsAstro.form, FSettingsAstro.pot,
      FSettingsBluetooth.class, FSettingsBluetooth.form, FSettingsBluetooth.pot,
      FSettingsCTX35.class, FSettingsCTX35.form, FSettingsCTX35.pot,
      FSettingsCamVisca.class, FSettingsCamVisca.form, FSettingsCamVisca.pot,
      FSettingsEmail.class, FSettingsEmail.form, FSettingsEmail.pot,
      FSettingsGPS.class, FSettingsGPS.form, FSettingsGPS.pot,
      FSettingsGmail.class, FSettingsGmail.form, FSettingsGmail.pot,
      FSettingsHDDTemp.class, FSettingsHDDTemp.form, FSettingsHDDTemp.pot,
      FSettingsHeyu.class, FSettingsHeyu.form, FSettingsHeyu.pot,
      FSettingsIRMan.class, FSettingsIRMan.form, FSettingsIRMan.pot,
      FSettingsMain.class, FSettingsMain.form, FSettingsMain.pot,
      FSettingsMySQL.class, FSettingsMySQL.form, FSettingsMySQL.pot,
      FSettingsOneWire.class, FSettingsOneWire.form, FSettingsOneWire.pot,
      FSettingsRFXCom.class, FSettingsRFXCom.form, FSettingsRFXCom.pot,
      FSettingsRRDTool.class, FSettingsRRDTool.form, FSettingsRRDTool.pot,
      FSettingsSMS.class, FSettingsSMS.form, FSettingsSMS.pot,
      FSettingsServerStats.class, FSettingsServerStats.form,
      FSettingsServerStats.pot, FSettingsSound.class, FSettingsSound.form,
      FSettingsSound.pot, FSettingsTVGuide.class, FSettingsTVGuide.form,
      FSettingsTVGuide.pot, FSettingsUPS.class, FSettingsUPS.form,
      FSettingsUPS.pot, FSettingsVideoServer.class, FSettingsVideoServer.form,
      FSettingsVideoServer.pot, FSettingsVoiceText.class,
      FSettingsVoiceText.form, FSettingsVoiceText.pot, FSettingsWebserver.class,
      FSettingsWebserver.form, FSettingsWebserver.pot, FSettingsWeeder.class,
      FSettingsWeeder.form, FSettingsWeeder.pot, FSplashScreen.class,
      FSplashScreen.form, FSplashScreen.pot, FTOOLSBLUETOOTHBROWSER,
      FTOOLSDATABASEADMIN, FTOOLSSERIALMON, FTOOLSSERIALPORTS, FTOOLSX10CMDR,
      FTVGUIDE, FTVGuide.class, FTVGuide.form, FTVGuide.pot,
      FToolsBluetoothBrowser.class, FToolsBluetoothBrowser.form,
      FToolsBluetoothBrowser.pot, FToolsDatabaseAdmin.class,
      FToolsDatabaseAdmin.form, FToolsDatabaseAdmin.pot, FToolsSerialMon.class,
      FToolsSerialMon.form, FToolsSerialMon.pot, FToolsSerialPorts.class,
      FToolsSerialPorts.form, FToolsSerialPorts.pot, FToolsX10Cmdr.class,
      FToolsX10Cmdr.form, FToolsX10Cmdr.pot, FWEATHER, FWeather.class,
      FWeather.form, FWeather.pot, HDDTEMP, HDDTemp.module, HDDTemp.pot, HEYU,
      Heyu.module, Heyu.pot, LICENSE, MAIL, MAIN, Mail.module, Mail.pot,
      Main.module, Main.pot, README, RRDTOOL, RRDTool.module, RRDTool.pot,
      SERVERSTATS, SOUNDS, ServerStats.module, ServerStats.pot, Sounds.module,
      Sounds.pot, TVGUIDE, TVGuide.module, TVGuide.pot, VIDEOSERVER, VOICETEXT,
      VideoServer.module, VideoServer.pot, VoiceText.module, VoiceText.pot,
      aibo.gif, asterisk.png, bin.png, bt.png, button.gif, cache, camera.png,
      captures.png, charts.png, click.wav, climate.png, contacts.png,
      control.png, controller.png, database.png, devices.png, domotiga,
      domotiga.conf, domotiga.gambas, domotiga.png, domotiga.sql, donate.gif,
      door-closed.png, door-open.png, drive.png, eeebox.jpg, email.png, en.png,
      en_US.mo, en_US.po, energy.png, events.png, fan-off.gif, fan-on.gif,
      fan.gif, favicon.ico, film.png, floorplan.png, floorplans, fr.png,
      fridgesensor-humid-1d.png, fridgesensor-humid-1h.png,
      fridgesensor-humid-1m.png, fridgesensor-humid-1w.png,
      fridgesensor-humid-1y.png, fridgesensor-temp-1d.png,
      fridgesensor-temp-1h.png, fridgesensor-temp-1m.png,
      fridgesensor-temp-1w.png, fridgesensor-temp-1y.png, fridgesensor.rrd,
      gps.png, graphs, groups.png, harddrivedevsda-temp-1d.png,
      harddrivedevsda-temp-1h.png, harddrivedevsda-temp-1m.png,
      harddrivedevsda-temp-1w.png, harddrivedevsda-temp-1y.png,
      harddrivedevsda.rrd, hd.png, heyu.png, home.png, hotwater-temp-1d.png,
      hotwater-temp-1h.png, hotwater-temp-1m.png, hotwater-temp-1w.png,
      hotwater-temp-1y.png, hotwater.rrd, hvac.gif, hvac.png, icons, images,
      imdb, index.html, irman.png, key.png, led-off.png, led-on.png,
      light-off.png, light-on.png, list.png, locations.png, login.png, logo.png,
      logout.png, logs, logs.png, mail-off.png, mail-on.png, modules.png,
      motion-off.gif, motion-on.gif, mpd.png, mute.png, news.png, nl.mo, nl.png,
      nl.po, notify.png, outsidesensor-humid-1d.png, outsidesensor-humid-1h.png,
      outsidesensor-humid-1m.png, outsidesensor-humid-1w.png,
      outsidesensor-humid-1y.png, outsidesensor-temp-1d.png,
      outsidesensor-temp-1h.png, outsidesensor-temp-1m.png,
      outsidesensor-temp-1w.png, outsidesensor-temp-1y.png, outsidesensor.rrd,
      phone.png, points.png, powerusage-watt-1d.png, powerusage-watt-1h.png,
      powerusage-watt-1m.png, powerusage-watt-1w.png, powerusage-watt-1y.png,
      powerusage.rrd, question.png, rain.png, rrd, rss.png, security.png,
      serial.png, serialterm.png, server-load-1d.png, server-load-1h.png,
      server-load-1m.png, server-load-1w.png, server-load-1y.png,
      server-memory-1d.png, server-memory-1h.png, server-memory-1m.png,
      server-memory-1w.png, server-memory-1y.png, server.jpg, serverload.rrd,
      servermemory.rrd, serverstats.png, settings.png, smoke.png, sms.png,
      sound.png, sounds, stock.png, sun.png, sunset.jpg, sunset.png, system.png,
      temp.gif, trunk, tv.png, tv_grab_nl_C.conf, tvguide, tvguide.png,
      unavail.gif, ups.gif, user.sql, users.png, vars.png, voice.png,
      weather.png, webcam.png, webserver.png, weeder.png, wire.png, world.png,
      www, x10.gif: Domotiga import 0.1.158 including b-bugfix devices

2008-11-26  root

    * branches, tags, trunk: initial import

