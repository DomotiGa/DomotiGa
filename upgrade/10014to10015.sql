
--
-- Downgrade from InnoDB to MyISAM
--
ALTER TABLE device_values ENGINE=MyISAM;
ALTER TABLE device_values_log ENGINE=MyISAM;

--
-- Initialize columns with as NOT NULL
--
ALTER TABLE `actions` CHANGE COLUMN `type` `type` INT(11) NOT NULL DEFAULT '0';

ALTER TABLE events CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE events CHANGE COLUMN `log` `log` TINYINT(1) NOT NULL DEFAULT '0';
ALTER TABLE events CHANGE COLUMN `trigger1` `trigger1` int(11) NOT NULL DEFAULT '0';
ALTER TABLE events CHANGE COLUMN `condition1` `condition1` int(11) NOT NULL DEFAULT '0';
ALTER TABLE events CHANGE COLUMN `condition2` `condition2` int(11) NOT NULL DEFAULT '0';
ALTER TABLE events CHANGE COLUMN `rerunenabled` `rerunenabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE events CHANGE COLUMN `rerunvalue` `rerunvalue` int(11) NOT NULL DEFAULT '0';
ALTER TABLE events CHANGE COLUMN `category` `category` int(11) NOT NULL DEFAULT '0';

ALTER TABLE device_values CHANGE COLUMN `log` `log` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE device_values CHANGE COLUMN `logdisplay` `logdisplay` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE device_values CHANGE COLUMN `logspeak` `logspeak` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE device_values CHANGE COLUMN `rrd` `rrd` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE device_values CHANGE COLUMN `graph` `graph` tinyint(1) NOT NULL DEFAULT '0';

ALTER TABLE devices CHANGE COLUMN `instance` `instance` int(11) NOT NULL DEFAULT '1';
ALTER TABLE devices CHANGE COLUMN `module` `module` int(11) NOT NULL DEFAULT '0';
ALTER TABLE devices CHANGE COLUMN `location` `location` int(11) NOT NULL DEFAULT '0';
ALTER TABLE devices CHANGE COLUMN `interface` `interface` int(11) NOT NULL DEFAULT '0';
ALTER TABLE devices CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE devices CHANGE COLUMN `hide` `hide` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE devices CHANGE COLUMN `tampered` `tampered` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE devices CHANGE COLUMN `switchable` `switchable` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE devices CHANGE COLUMN `dimable` `dimable` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE devices CHANGE COLUMN `extcode` `extcode` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE devices CHANGE COLUMN `x` `x` int(11) NOT NULL DEFAULT '0';
ALTER TABLE devices CHANGE COLUMN `y` `y` int(11) NOT NULL DEFAULT '0';
ALTER TABLE devices CHANGE COLUMN `floorplan` `floorplan` int(11) NOT NULL DEFAULT '0';
ALTER TABLE devices CHANGE COLUMN `repeatstate` `repeatstate` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE devices CHANGE COLUMN `repeatperiod` `repeatperiod` int(11) NOT NULL DEFAULT '0';
ALTER TABLE devices CHANGE COLUMN `reset` `reset` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE devices CHANGE COLUMN `resetperiod` `resetperiod` int(11) NOT NULL DEFAULT '0';
ALTER TABLE devices CHANGE COLUMN `poll` `poll` tinyint(1) NOT NULL DEFAULT '0';

ALTER TABLE devices_camera CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE graphs CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE menu CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE newsfeeds CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE scenes CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE trafficfeeds CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE weatherfeeds CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';

ALTER TABLE contacts CHANGE COLUMN `holidaycard` `holidaycard` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE contacts CHANGE COLUMN `type` `type` int(11) NOT NULL DEFAULT '0'; 

ALTER TABLE settings_arduino CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_arduino CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_asterisk CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_asterisk CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_astro CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_bluetooth CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_bluetooth CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_bwiredmap CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_bwiredmap CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_callerid CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_callerid CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_ctx35 CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_ctx35 CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_cul CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_cul CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_currentcost CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_currentcost CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_denon CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_denon CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_digitemp CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_digitemp CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_dmxplayer CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_dmxplayer CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_domotica CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_domotica CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_dsc CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_dsc CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_dsc CHANGE COLUMN `type` `type` int(11) NOT NULL DEFAULT '0';
ALTER TABLE settings_eib CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_eib CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_elvmax CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_elvmax CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_email CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_email CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_ezcontrol CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_ezcontrol CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_fritzbox CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_fritzbox CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_genericio CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_genericio CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_gmail CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_gmail CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_gps CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_gps CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_hddtemp CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_hddtemp CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_homematic CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_homematic CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_iport CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_iport CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_irman CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_irman CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_irtrans CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_irtrans CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_iviewer CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_iviewer CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_jeelabs CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_jeelabs CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_jsonrpc CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_jsonrpc CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_k8055 CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_k8055 CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_kmtronicudp CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_kmtronicudp CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_ledmatrix CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_ledmatrix CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_lgtv CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_lgtv CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_lirc CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_lirc CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_main CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_meteohub CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_meteohub CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_mochad CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_mochad CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_mqtt CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_mqtt CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_ncid CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_ncid CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_nma CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_nma CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_omniksol CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_omniksol CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_onkyo CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_onkyo CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_opentherm CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_opentherm CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_openzwave CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_openzwave CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_owfs CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_owfs CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_oww CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_oww CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_p2000 CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_p2000 CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_pachube CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_pachube CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_ping CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_ping CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_pioneer CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_pioneer CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_plcbus CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_plcbus CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_plugwise CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_plugwise CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_prowl CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_prowl CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_pushover CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_pushover CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_pvoutput CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_pvoutput CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_pwrctrl CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_pwrctrl CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_razberry CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_razberry CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_rfxcomrx CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_rfxcomrx CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_rfxcomtrx CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_rfxcomtrx CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_rfxcomtx CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_rfxcomtx CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_rfxcomxpl CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_rfxcomxpl CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_rrdtool CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_rrdtool CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_serverstats CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_serverstats CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_sharptv CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_sharptv CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_shell CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_shell CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_smartmeter CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_smartmeter CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_smartvisuserver CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_smartvisuserver CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_sms CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_sms CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_sound CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_sound CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_squeezeserver CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_squeezeserver CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_telnetserver CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_telnetserver CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_temp08 CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_temp08 CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_temperaturnu CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_temperaturnu CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_thermostat CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_thermostat CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_tvguide CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_tvguide CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_twitter CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_twitter CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_ups CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_ups CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_videoserver CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_videoserver CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_visca CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_visca CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_visonic CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_visonic CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_voicetext CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_voicetext CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_weatherbug CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_weatherbug CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_weatherug CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_weatherug CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_weeder CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_weeder CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_x10cmd CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_x10cmd CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_xbmcxpl CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_xbmcxpl CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_xmlrpc CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_xmlrpc CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_xpl CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_xpl CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_youless CHANGE COLUMN `enabled` `enabled` tinyint(1) NOT NULL DEFAULT '0';
ALTER TABLE settings_youless CHANGE COLUMN `debug` `debug` tinyint(1) NOT NULL DEFAULT '0';

--
-- Table structure for table `settings_velbus`
--
DROP TABLE IF EXISTS `settings_velbus`;
CREATE TABLE `settings_velbus` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `serialport` varchar(32) DEFAULT NULL,
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) NOT NULL DEFAULT '0',
  `type` varchar(32) DEFAULT NULL,
  `relayenabled` tinyint(1) NOT NULL DEFAULT '0',
  `relayport` int(11) NOT NULL DEFAULT '0',
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  `baudrate` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings_velbus`
--
LOCK TABLES `settings_velbus` WRITE;
INSERT INTO `settings_velbus` VALUES (0,0,'/dev/ttyACM0','192.168.1.1',1080,'tcp',0,50000,0,'38400'),(1,0,'/dev/ttyACM0','192.168.1.1',1080,'serial',0,50000,0,'38400');
UNLOCK TABLES;

--
-- Table structure for table `settings_viera`
--
DROP TABLE IF EXISTS `settings_viera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_viera` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) NOT NULL DEFAULT '0',
  `refresh` int(11) NOT NULL DEFAULT '0',
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings_viera`
--
/*!40101 SET character_set_client = @saved_cs_client */;
LOCK TABLES `settings_viera` WRITE;
/*!40000 ALTER TABLE `settings_viera` DISABLE KEYS */;
INSERT INTO `settings_viera` VALUES (0,0,'127.0.0.1',55000,30,0),(1,0,'127.0.0.1',55000,30,0);
/*!40000 ALTER TABLE `settings_viera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Add Velbus interface
--
LOCK TABLES `interfaces` WRITE;
INSERT INTO interfaces VALUES (53,'Velbus Interface','Velbus','Read Write');
UNLOCK TABLES;

--
-- Add Viera interface
--
LOCK TABLES `interfaces` WRITE;
/*!40000 ALTER TABLE `interfaces` DISABLE KEYS */;
INSERT INTO `interfaces` VALUES (54,'Viera Interface', 'Viera','Read Write');
/*!40000 ALTER TABLE `interfaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Add Velbus devicetypes
--
LOCK TABLES `devicetypes` WRITE;
/*!40000 ALTER TABLE `devicetypes` DISABLE KEYS */;
INSERT INTO devicetypes VALUES (334,'VMB4RY','Velbus - 4 channel relay module','Velbus','10|2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(335,'VMB4DC','Velbus - 4 channel dimmer module','Velbus','11|2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(336,'VMB7IN','Velbus - 7 channel input','Velbus','12|2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(337,'VMBGPO','Velbus - OLED touch panel','Velbus','13',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(338,'VMBDME','Velbus - Dimmer module','Velbus','14',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

--
-- New devicetypes for RFXtrx plugin
--
INSERT INTO devicetypes VALUES (340,'Alecto SA-30','Smoke Detector','SA30','C9F300','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (341,'Byron SX Doorbell','Doorbell','ByronSX','00F4','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (342,'Byron SX PIR','PIR','ByronSX','00F4','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (343,'Byron SX Door/Window','Door/Window Sensor','ByronSX','00F4','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (344,'Energenie ENER010','Quad Power Socket','Energenie','A01','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

INSERT INTO devicetypes VALUES (345,'Livolo Touch Dimmer','Dimmer Module','Livolo','010203 or 0x010203','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (346,'Livolo Touch Switch 1Gang','Appliance Module 1Gang','Livolo','010203 or 0x010203','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (347,'Livolo Touch Switch 3Gang','Appliance Module 3Gang','Livolo','010203 or 0x010203','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (348,'RGB Module','Applicance Module','TRC02','010203 or 0x010203','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (349,'MDRemote LED Dimmer','Dimmer Module','MDREMOTE','010203 or 0x010203','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (350,'Conrad RSL Dimmer','Dimmer Module','RSL','010203 or 0x010203','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (351,'Conrad RSL Appl Module','Applicance Module','RSL','010203 or 0x010203','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (352,'Conrad RSL Switch','Switch Module','RSL','010203 or 0x010203','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (353,'RUBiCSON/IW008T/TX95','Temp/Hygro Sensor','Rubicson','th10 0x123','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (354,'EW109','Temp/Hygro Sensor','Rubicson','th11 0x123','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (355,'Siemens SF01 Fan','Fan','SF01','0x001234','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
UNLOCK TABLES;

UPDATE interfaces SET type = 'X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubicson RisingSun PhilipsSBC EMW100 BBSB Blyss RollerTrol HastaNew HastaOld A-OKRF01 A-OKAC114 Meiantech ByronSX SA30 X10SecDW X10SecMotion X10SecRemote PowerCodeDW PowerCodeMotion PowerCodeAux CodeSecure Energenie Livolo RSL TRC02 MDRemote SF01' WHERE id=35;

UPDATE interfaces SET type = 'X10 X10Security Oregon KAKU RFXCom HEUK ATI Digimax ARC AC HEEU X10SecDW X10SecMotion X10SecRemote' WHERE id=1;
UPDATE interfaces SET type = 'X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison RFXLanIO X10SecDW X10SecMotion X10SecRemote' WHERE id=33;

--
-- Split X10Security up into different types for RFXTrx transmit
--
UPDATE devicetypes SET type = 'X10SecDW' WHERE id=1;
UPDATE devicetypes SET type = 'X10SecDW' WHERE id=67;
UPDATE devicetypes SET type = 'X10SecDW' WHERE id=68;
UPDATE devicetypes SET type = 'X10SecDW' WHERE id=105;

UPDATE devicetypes SET type = 'X10SecMotion' WHERE id=69;
UPDATE devicetypes SET type = 'X10SecMotion' WHERE id=111;
UPDATE devicetypes SET type = 'X10SecMotion' WHERE id=176;
UPDATE devicetypes SET type = 'X10SecMotion' WHERE id=179;

UPDATE devicetypes SET type = 'X10SecRemote' WHERE id=70;
UPDATE devicetypes SET type = 'X10SecRemote' WHERE id=71;
UPDATE devicetypes SET type = 'X10SecRemote' WHERE id=103;
UPDATE devicetypes SET type = 'X10SecRemote' WHERE id=104;
UPDATE devicetypes SET type = 'X10SecRemote' WHERE id=178;
UPDATE devicetypes SET type = 'X10SecRemote' WHERE id=220;

UPDATE devicetypes SET type = 'KD101' WHERE id=174;
UPDATE devicetypes SET name = 'Chacon Avidsen NEXA Flamingo' WHERE id=174;
UPDATE devicetypes SET description = 'Smoke Detector' WHERE id=293;

--
-- Add Viera devicetype
--
INSERT INTO `devicetypes` VALUES (339,'Viera','Viera TV Plugin','Viera','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

--
-- Table structure for table `settings_toon`
--

DROP TABLE IF EXISTS `settings_toon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_toon` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `polltime` int(11) NOT NULL DEFAULT '0',
  `user` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_toon`
--

LOCK TABLES `settings_toon` WRITE;
/*!40000 ALTER TABLE `settings_toon` DISABLE KEYS */;
INSERT INTO `settings_toon` VALUES (0,0,300,'toonlogin','toonpassword',0),(1,0,300,'toonlogin','toonpassword',0);
/*!40000 ALTER TABLE `settings_toon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Add Toon interface
--
LOCK TABLES `interfaces` WRITE;
/*!40000 ALTER TABLE `interfaces` DISABLE KEYS */;
INSERT INTO `interfaces` VALUES (55,'Toon Interface', 'Toon','Read Write');
/*!40000 ALTER TABLE `interfaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Add Toon devicetypes
--

INSERT INTO `devicetypes` VALUES (356,'Toon Thermostat','Thermostat Status','Toon','Thermostat','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (357,'Toon Power Usage','Power Usage','Toon','PowerUsage','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (358,'Toon Power Produced','Power Produced','Toon','PowerProdced','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (359,'Toon Gas Usage','Gas Usage','Toon','GasUsage','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (360,'Toon Schedule','Schedule Status','Toon','Schedule','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

--
-- Add Jerome Ethernet interface
--
LOCK TABLES `interfaces` WRITE;
/*!40000 ALTER TABLE `interfaces` DISABLE KEYS */;
INSERT INTO `interfaces` VALUES (56,'Jerome Ethernet Module', 'KernelChip','Read Write');
/*!40000 ALTER TABLE `interfaces` ENABLE KEYS */;
UNLOCK TABLES;

INSERT INTO `devicetypes` VALUES (361,'Ethernet IO Port Input','IO Port Input','KernelChip','I1-22','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (362,'Ethernet IO Port Output','IO Port Output','KernelChip','O1-22','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (363,'Ethernet Counter Port','Pulse Counter Port','KernelChip','INT1-4','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (364,'Ethernet ADC Port','Analog Port','KernelChip','ADC1-4','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (365,'Ethernet PWM Port','PWM Port','KernelChip','PWM','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

--
-- Table structure for table `settings_jerome`
--

DROP TABLE IF EXISTS `settings_jerome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_jerome` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) NOT NULL DEFAULT '0',
  `username` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `polltime` int(11) NOT NULL DEFAULT '0',
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_jerome`
--

LOCK TABLES `settings_jerome` WRITE;
/*!40000 ALTER TABLE `settings_jerome` DISABLE KEYS */;
INSERT INTO `settings_jerome` VALUES (0,0,'192.168.100.5',2424,'username','password',60,0),(1,0,'192.168.100.5',2424,'username','password',60,0);
/*!40000 ALTER TABLE `settings_jerome` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Add extra fields to device_values
--
ALTER TABLE device_values ADD COLUMN `description` varchar(32) DEFAULT NULL AFTER `lastseen`;
ALTER TABLE device_values ADD COLUMN `type` int(11) NOT NULL DEFAULT '0' AFTER `description`;

--
-- Finally update to 1.0.015
--
LOCK TABLES version WRITE;
INSERT INTO version VALUES (60,'1.0.015');
UNLOCK TABLES;

