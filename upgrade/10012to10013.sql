
--
-- Update trigger device lastseen 
--
UPDATE `triggers` SET `param2` = null, `param3` = null, `param4` = null WHERE `type` = 8;

--
-- Update settings_main table
--
UPDATE `settings_main` SET `debugplugin`=0 WHERE `debugplugin`=NULL;
UPDATE `settings_main` SET `debugglobalvar`=0 WHERE `debugglobalvar`=NULL;
UPDATE `settings_main` SET `autodevicecreate`=0 WHERE `autodevicecreate`=NULL;


--
-- Drop unused table
-- 
DROP TABLE IF EXISTS `settings_webserver`;


--
-- Cleanup Dev_*_Value to Dev_*_Value1
--
UPDATE triggers SET Param2 = REPLACE(Param2, "_Value","_Value1") WHERE type = 3;
UPDATE triggers SET Param2 = REPLACE(Param2, "_Value12","_Value2") WHERE type = 3;
UPDATE triggers SET Param2 = REPLACE(Param2, "_Value13","_Value3") WHERE type = 3;
UPDATE triggers SET Param2 = REPLACE(Param2, "_Value14","_Value4") WHERE type = 3;

UPDATE triggers SET Param1 = REPLACE(Param1, "_Value","_Value1") WHERE type = 6;
UPDATE triggers SET Param1 = REPLACE(Param1, "_Value12","_Value2") WHERE type = 6;
UPDATE triggers SET Param1 = REPLACE(Param1, "_Value13","_Value3") WHERE type = 6;
UPDATE triggers SET Param1 = REPLACE(Param1, "_Value14","_Value4") WHERE type = 6;

UPDATE conditions SET formula= REPLACE(formula, "_Value","_Value1");
UPDATE conditions SET formula= REPLACE(formula, "_Value12","_Value2");
UPDATE conditions SET formula= REPLACE(formula, "_Value13","_Value3");
UPDATE conditions SET formula= REPLACE(formula, "_Value14","_Value4");

UPDATE macros SET formula= REPLACE(formula, "_Value","_Value1");
UPDATE macros SET formula= REPLACE(formula, "_Value12","_Value2");
UPDATE macros SET formula= REPLACE(formula, "_Value13","_Value3");
UPDATE macros SET formula= REPLACE(formula, "_Value14","_Value4");

UPDATE actions SET param1 = REPLACE(param1, "_Value","_Value1") WHERE type = 15;
UPDATE actions SET param1 = REPLACE(param1, "_Value12","_Value2") WHERE type = 15;
UPDATE actions SET param1 = REPLACE(param1, "_Value13","_Value3") WHERE type = 15;
UPDATE actions SET param1 = REPLACE(param1, "_Value14","_Value4") WHERE type = 15;



--
-- Upgrade to inodb
--
ALTER TABLE actions ENGINE=InnoDB;
ALTER TABLE calendar ENGINE=InnoDB;
ALTER TABLE capture_camera0 ENGINE=InnoDB;
ALTER TABLE capture_camera1 ENGINE=InnoDB;
ALTER TABLE capture_camera2 ENGINE=InnoDB;
ALTER TABLE capture_camera3 ENGINE=InnoDB;
ALTER TABLE category ENGINE=InnoDB;
ALTER TABLE cdr ENGINE=InnoDB;
ALTER TABLE conditions ENGINE=InnoDB;
ALTER TABLE contacts ENGINE=InnoDB;
ALTER TABLE deviceblacklist ENGINE=InnoDB;
ALTER TABLE devices ENGINE=InnoDB;
ALTER TABLE devices_bwired ENGINE=InnoDB;
ALTER TABLE devices_camera ENGINE=InnoDB;
ALTER TABLE devices_log ENGINE=InnoDB;
ALTER TABLE devices_pachube ENGINE=InnoDB;
ALTER TABLE devices_zwave ENGINE=InnoDB;
ALTER TABLE devicetypes ENGINE=InnoDB;
ALTER TABLE devicetypes_homematic ENGINE=InnoDB;
ALTER TABLE dictionary ENGINE=InnoDB;
ALTER TABLE events ENGINE=InnoDB;
ALTER TABLE events_actions ENGINE=InnoDB;
ALTER TABLE floors ENGINE=InnoDB;
ALTER TABLE gas_usage ENGINE=InnoDB;
ALTER TABLE globalvars ENGINE=InnoDB;
ALTER TABLE graph_data ENGINE=InnoDB;
ALTER TABLE graphs ENGINE=InnoDB;
ALTER TABLE groups ENGINE=InnoDB;
ALTER TABLE interfaces ENGINE=InnoDB;
ALTER TABLE locations ENGINE=InnoDB;
ALTER TABLE macros ENGINE=InnoDB;
ALTER TABLE markers ENGINE=InnoDB;
ALTER TABLE menu ENGINE=InnoDB;
ALTER TABLE menu_names ENGINE=InnoDB;
ALTER TABLE newsfeeds ENGINE=InnoDB;
ALTER TABLE notify ENGINE=InnoDB;
ALTER TABLE notifytypes ENGINE=InnoDB;
ALTER TABLE power_exported ENGINE=InnoDB;
ALTER TABLE power_usage ENGINE=InnoDB;
ALTER TABLE remarks_fullmoon ENGINE=InnoDB;
ALTER TABLE remarks_humid ENGINE=InnoDB;
ALTER TABLE remarks_personal ENGINE=InnoDB;
ALTER TABLE remarks_plants ENGINE=InnoDB;
ALTER TABLE remarks_tags ENGINE=InnoDB;
ALTER TABLE remarks_tempbelow5 ENGINE=InnoDB;
ALTER TABLE remarks_tempbelowmin5 ENGINE=InnoDB;
ALTER TABLE scenes ENGINE=InnoDB;
ALTER TABLE security ENGINE=InnoDB;
ALTER TABLE settings_asterisk ENGINE=InnoDB;
ALTER TABLE settings_astro ENGINE=InnoDB;
ALTER TABLE settings_bluetooth ENGINE=InnoDB;
ALTER TABLE settings_bwiredmap ENGINE=InnoDB;
ALTER TABLE settings_callerid ENGINE=InnoDB;
ALTER TABLE settings_ctx35 ENGINE=InnoDB;
ALTER TABLE settings_cul ENGINE=InnoDB;
ALTER TABLE settings_currentcost ENGINE=InnoDB;
ALTER TABLE settings_denon ENGINE=InnoDB;
ALTER TABLE settings_digitemp ENGINE=InnoDB;
ALTER TABLE settings_dmxplayer ENGINE=InnoDB;
ALTER TABLE settings_domotica ENGINE=InnoDB;
ALTER TABLE settings_dsc ENGINE=InnoDB;
ALTER TABLE settings_eib ENGINE=InnoDB;
ALTER TABLE settings_elvmax ENGINE=InnoDB;
ALTER TABLE settings_email ENGINE=InnoDB;
ALTER TABLE settings_ezcontrol ENGINE=InnoDB;
ALTER TABLE settings_fritzbox ENGINE=InnoDB;
ALTER TABLE settings_genericio ENGINE=InnoDB;
ALTER TABLE settings_gmail ENGINE=InnoDB;
ALTER TABLE settings_gps ENGINE=InnoDB;
ALTER TABLE settings_hddtemp ENGINE=InnoDB;
ALTER TABLE settings_homematic ENGINE=InnoDB;
ALTER TABLE settings_iport ENGINE=InnoDB;
ALTER TABLE settings_irman ENGINE=InnoDB;
ALTER TABLE settings_irtrans ENGINE=InnoDB;
ALTER TABLE settings_iviewer ENGINE=InnoDB;
ALTER TABLE settings_jeelabs ENGINE=InnoDB;
ALTER TABLE settings_jsonrpc ENGINE=InnoDB;
ALTER TABLE settings_k8055 ENGINE=InnoDB;
ALTER TABLE settings_kmtronicudp ENGINE=InnoDB;
ALTER TABLE settings_ledmatrix ENGINE=InnoDB;
ALTER TABLE settings_lgtv ENGINE=InnoDB;
ALTER TABLE settings_lirc ENGINE=InnoDB;
ALTER TABLE settings_main ENGINE=InnoDB;
ALTER TABLE settings_meteohub ENGINE=InnoDB;
ALTER TABLE settings_mochad ENGINE=InnoDB;
ALTER TABLE settings_mqtt ENGINE=InnoDB;
ALTER TABLE settings_ncid ENGINE=InnoDB;
ALTER TABLE settings_nma ENGINE=InnoDB;
ALTER TABLE settings_omniksol ENGINE=InnoDB;
ALTER TABLE settings_onkyo ENGINE=InnoDB;
ALTER TABLE settings_opentherm ENGINE=InnoDB;
ALTER TABLE settings_openzwave ENGINE=InnoDB;
ALTER TABLE settings_owfs ENGINE=InnoDB;
ALTER TABLE settings_oww ENGINE=InnoDB;
ALTER TABLE settings_p2000 ENGINE=InnoDB;
ALTER TABLE settings_pachube ENGINE=InnoDB;
ALTER TABLE settings_ping ENGINE=InnoDB;
ALTER TABLE settings_pioneer ENGINE=InnoDB;
ALTER TABLE settings_plcbus ENGINE=InnoDB;
ALTER TABLE settings_plugwise ENGINE=InnoDB;
ALTER TABLE settings_prowl ENGINE=InnoDB;
ALTER TABLE settings_pushover ENGINE=InnoDB;
ALTER TABLE settings_pvoutput ENGINE=InnoDB;
ALTER TABLE settings_pwrctrl ENGINE=InnoDB;
ALTER TABLE settings_razberry ENGINE=InnoDB;
ALTER TABLE settings_rfxcomrx ENGINE=InnoDB;
ALTER TABLE settings_rfxcomtrx ENGINE=InnoDB;
ALTER TABLE settings_rfxcomtx ENGINE=InnoDB;
ALTER TABLE settings_rfxcomxpl ENGINE=InnoDB;
ALTER TABLE settings_rrdtool ENGINE=InnoDB;
ALTER TABLE settings_serverstats ENGINE=InnoDB;
ALTER TABLE settings_sharptv ENGINE=InnoDB;
ALTER TABLE settings_shell ENGINE=InnoDB;
ALTER TABLE settings_smartmeter ENGINE=InnoDB;
ALTER TABLE settings_smartvisuserver ENGINE=InnoDB;
ALTER TABLE settings_sms ENGINE=InnoDB;
ALTER TABLE settings_sound ENGINE=InnoDB;
ALTER TABLE settings_squeezeserver ENGINE=InnoDB;
ALTER TABLE settings_telnetserver ENGINE=InnoDB;
ALTER TABLE settings_temp08 ENGINE=InnoDB;
ALTER TABLE settings_temperaturnu ENGINE=InnoDB;
ALTER TABLE settings_thermostat ENGINE=InnoDB;
ALTER TABLE settings_tvguide ENGINE=InnoDB;
ALTER TABLE settings_twitter ENGINE=InnoDB;
ALTER TABLE settings_ups ENGINE=InnoDB;
ALTER TABLE settings_videoserver ENGINE=InnoDB;
ALTER TABLE settings_visca ENGINE=InnoDB;
ALTER TABLE settings_visonic ENGINE=InnoDB;
ALTER TABLE settings_voicetext ENGINE=InnoDB;
ALTER TABLE settings_weatherbug ENGINE=InnoDB;
ALTER TABLE settings_weatherug ENGINE=InnoDB;
ALTER TABLE settings_weeder ENGINE=InnoDB;
ALTER TABLE settings_x10cmd ENGINE=InnoDB;
ALTER TABLE settings_xbmcxpl ENGINE=InnoDB;
ALTER TABLE settings_xmlrpc ENGINE=InnoDB;
ALTER TABLE settings_xpl ENGINE=InnoDB;
ALTER TABLE settings_youless ENGINE=InnoDB;
ALTER TABLE stock ENGINE=InnoDB;
ALTER TABLE thermostat_constant ENGINE=InnoDB;
ALTER TABLE thermostat_heating ENGINE=InnoDB;
ALTER TABLE thermostat_scenarii ENGINE=InnoDB;
ALTER TABLE thermostat_schedule ENGINE=InnoDB;
ALTER TABLE thermostat_schedule_entry ENGINE=InnoDB;
ALTER TABLE trafficfeeds ENGINE=InnoDB;
ALTER TABLE triggers ENGINE=InnoDB;
ALTER TABLE tv_categories ENGINE=InnoDB;
ALTER TABLE tv_channels ENGINE=InnoDB;
ALTER TABLE tv_programs ENGINE=InnoDB;
ALTER TABLE tv_subcategories ENGINE=InnoDB;
ALTER TABLE users ENGINE=InnoDB;
ALTER TABLE version ENGINE=InnoDB;
ALTER TABLE water_usage ENGINE=InnoDB;
ALTER TABLE weather ENGINE=InnoDB;
ALTER TABLE weatherfeeds ENGINE=InnoDB;


--
-- Regenerate device values table
--

DROP TABLE IF EXISTS `device_values`;

CREATE TABLE `device_values` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `deviceid` int(11) unsigned NOT NULL,
  `valuenum` int(11) unsigned NOT NULL,
  `value` text,
  `correction` text,
  `units` varchar(32) DEFAULT NULL,
  `log` tinyint(1) DEFAULT '0',
  `logdisplay` tinyint(1) DEFAULT '0',
  `logspeak` tinyint(1) DEFAULT '0',
  `rrd` tinyint(1) DEFAULT '0',
  `graph` tinyint(1) DEFAULT '0',
  `valuerrddsname` varchar(32) DEFAULT NULL,
  `valuerrdtype` varchar(32) DEFAULT NULL,
  `lastchanged` datetime DEFAULT NULL,
  `lastseen` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO device_values (deviceid, value, correction, units,
lastseen, log, rrd, graph, valuerrddsname, valuerrdtype, lastchanged, valuenum, logdisplay, logspeak)
select id, value, correction, label, lastseen, log, rrd, graph,
valuerrddsname, valuerrdtype, lastchanged, 1, logdisplay, logspeak from
devices;

INSERT INTO device_values (deviceid, value, correction, units,
lastseen, log, rrd, graph, valuerrddsname, valuerrdtype, lastchanged, valuenum, logdisplay, logspeak)
select id, value2, correction2, label2, lastseen, log, rrd, graph,
value2rrddsname, value2rrdtype, lastchanged, 2, logdisplay, logspeak
from devices;

INSERT INTO device_values (deviceid, value, correction, units,
lastseen, log, rrd, graph, valuerrddsname, valuerrdtype, lastchanged, valuenum, logdisplay, logspeak)
select id, value3, correction3, label3, lastseen, log, rrd, graph,
value3rrddsname, value3rrdtype, lastchanged, 3, logdisplay, logspeak
from devices;

INSERT INTO device_values (deviceid, value, correction, units,
lastseen, log, rrd, graph, valuerrddsname, valuerrdtype, lastchanged, valuenum, logdisplay, logspeak)
select id, value4, correction4, label4, lastseen, log, rrd, graph,
value4rrddsname, value4rrdtype, lastchanged, 4, logdisplay, logspeak
from devices;

ALTER TABLE devices DROP COLUMN value;
ALTER TABLE devices DROP COLUMN value2;
ALTER TABLE devices DROP COLUMN value3;
ALTER TABLE devices DROP COLUMN value4;
ALTER TABLE devices DROP COLUMN correction;
ALTER TABLE devices DROP COLUMN correction2;
ALTER TABLE devices DROP COLUMN correction3;
ALTER TABLE devices DROP COLUMN correction4;
ALTER TABLE devices DROP COLUMN label;
ALTER TABLE devices DROP COLUMN label2;
ALTER TABLE devices DROP COLUMN label3;
ALTER TABLE devices DROP COLUMN label4;
ALTER TABLE devices DROP COLUMN log;
ALTER TABLE devices DROP COLUMN logdisplay;
ALTER TABLE devices DROP COLUMN logspeak;
ALTER TABLE devices DROP COLUMN rrd;
ALTER TABLE devices DROP COLUMN graph;
ALTER TABLE devices DROP COLUMN valuerrddsname;
ALTER TABLE devices DROP COLUMN value2rrddsname;
ALTER TABLE devices DROP COLUMN value3rrddsname;
ALTER TABLE devices DROP COLUMN value4rrddsname;
ALTER TABLE devices DROP COLUMN valuerrdtype;
ALTER TABLE devices DROP COLUMN value2rrdtype;
ALTER TABLE devices DROP COLUMN value3rrdtype;
ALTER TABLE devices DROP COLUMN value4rrdtype;


--
-- Change device value logging
--
DROP TABLE IF EXISTS `device_values_log`;
CREATE TABLE `device_values_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` int(11) unsigned NOT NULL,
  `valuenum` int(11) unsigned NOT NULL,
  `value` text,
  `lastchanged` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO device_values_log (device_id, valuenum, value, lastchanged)
select deviceid, 1, value, lastchanged
from devices_log where value IS NOT NULL and value != '';

INSERT INTO device_values_log (device_id, valuenum, value, lastchanged)
select deviceid, 2, value2, lastchanged
from devices_log where value2 IS NOT NULL and value2 != '';

INSERT INTO device_values_log (device_id, valuenum, value, lastchanged)
select deviceid, 3, value3, lastchanged
from devices_log where value3 IS NOT NULL and value3 != '';

INSERT INTO device_values_log (device_id, valuenum, value, lastchanged)
select deviceid, 4, value4, lastchanged
from devices_log where value4 IS NOT NULL and value4 != '';

DROP TABLE IF EXISTS `devices_log`;


--
-- Add menu for new device values table
--
INSERT INTO menu VALUES ( 26, 'Device values','FDeviceValues', 1, 10, 'devices.png',1);



--
-- Table structure for table `settings_arduino`
--

DROP TABLE IF EXISTS `settings_arduino`;
CREATE TABLE `settings_arduino` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `serialport` varchar(32) DEFAULT NULL,
  `baudrate` varchar(32) DEFAULT NULL,
  `polltime` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO interfaces VALUES (52,'Arduino Interface','Arduino','Read Write');

LOCK TABLES `settings_arduino` WRITE;
/*!40000 ALTER TABLE `settings_arduino` DISABLE KEYS */;
INSERT INTO `settings_arduino` VALUES (0,0,'/dev/ttyarduino',9600,10,0),(1,0,'/dev/ttyarduino',9600,10,0);
UNLOCK TABLES;


--
-- Finally update to 1.0.013
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (58,'1.0.013');
UNLOCK TABLES;

