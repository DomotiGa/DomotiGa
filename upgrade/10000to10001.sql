--
-- Table structure for table 'settings_zwave'
--

ALTER TABLE settings_zwave MODIFY serialport varchar(128);

INSERT INTO `devicetypes` VALUES (259,'xPL media.basic','Player Control','media.basic','[id]','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (260,'xPL media.mptrnspt','Player Status','media.mptrnsp','[id]','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (261,'xPL media.mpmedia','Media Status','media.mpmedia','[id]','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (262,'xPL osd.basic','On Screen Display','osd.basic','[id]','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

INSERT INTO `interfaces` VALUES (40,'XBMC xPL Interface','media.basic media.mptrnsp media.mpmedia osd.basic','Read Write');

--
-- Table structure for table 'settings_xbmcxpl'
--

DROP TABLE IF EXISTS `settings_xbmcxpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_xbmcxpl` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `rxaddress` varchar(64) DEFAULT NULL,
  `txaddress` varchar(64) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `settings_xbmcxpl` VALUES (0,0,'parasit-xbmc.ubuntu','parasit-xbmc.ubuntu',0),(1,0,'parasit-xbmc.ubuntu','parasit-xbmc.ubuntu',0);

UPDATE `interfaces` SET type='X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubicson RisingSun PhilipsSBC EMW100 BBSB' WHERE id='35';

UPDATE `interfaces` SET name='OpenTherm Gateway' WHERE id='37';

UPDATE `devicetypes` SET addressformat='<Device> <Unit>' WHERE id='230';

INSERT INTO `interfaces` VALUES (41,'Meteohub Interface','Meteohub','Read');

INSERT INTO `devicetypes` VALUES (263,'Meteohub Temp Sensor','Temp Sensor','Meteohub','t[0-39]','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (264,'Meteohub Temp/Hygro Sensor','Temp/Hygro Sensor','Meteohub','th[0-39]','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (265,'Meteohub Temp/Hygro/Baro Sensor','Temp/Hygro/Baro Sensor','Meteohub','thb[0-19]','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (266,'Meteohub Wind Sensor','Wind Sensor','Meteohub','wind[0-19]','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (267,'Meteohub Rain Sensor','Rain Sensor','Meteohub','rain[0-19]','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (268,'Meteohub Solar Sensor','Solar Sensor','Meteohub','sol[0-19]','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (269,'Meteohub UV Sensor','UV Sensor','Meteohub','uv[0-19]','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

INSERT INTO `devicetypes` VALUES (270,'Cube Lan-Gateway','Gateway to all MAX! Devices','ELVMAX','[xxxxxx]','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(271,'Door/Window Sensor','Door/Window Sensor','ELVMAX','[xxxxxx]','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(272,'Wall Thermostat','Thermostat','ELVMAX','[xxxxxx]','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(273,'Radiator Thermostat','Thermostat','ELVMAX','[xxxxxx]','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

INSERT INTO `devicetypes` VALUES (274,'OWL CM180','Power Usage Sensor','Oregon','ELEC3[256] or \'elec3 0x701\'','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(275,'Philips SBC SP370','Switch Module','PhilipsSBC','A05','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(276,'Philips SBC SP375','Dimmer Module','PhilipsSBC','A05','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(277,'RisingSun Module','Appliance Module','RisingSun','A03','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(278,'Everflourish EMW100','Module','EMW100','<Device> <Unit>','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(279,'ByeByeStandBy','Appliance Module','BBSB','<Device> <Unit>','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

INSERT INTO `devicetypes` VALUES (280,'Dallas DS2408','8-Channel Addressable Switch','1-Wire','29D050E7000000FF/Pio.0-7','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

INSERT INTO `interfaces` VALUES (42,'ELV MAX! Interface','ELVMAX','Read Write');

--
-- Table structure for table `settings_elvmax`
--

DROP TABLE IF EXISTS `settings_elvmax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_elvmax` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `settings_elvmax` VALUES (0,0,'192.168.99.17',62910,0),(1,-1,'192.168.99.17',62910,-1);

--
-- Table structure for table 'settings_mqtt'
--

DROP TABLE IF EXISTS `settings_mqtt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_mqtt` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `tcphost` varchar(64) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `username` varchar(32) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `pubtopic` varchar(256) DEFAULT NULL,
  `subtopic` varchar(256) DEFAULT NULL,
  `heartbeat` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `settings_mqtt` VALUES (0,0,'localhost',1883,'domotiga','broker','domotiga','raw',30,0),(1,0,'localhost',1883,'domotiga','broker','domotiga','raw',30,0);

--
-- Table structure for table 'settings_meteohub'
--

DROP TABLE IF EXISTS `settings_meteohub`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_meteohub` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `fetchurl` varchar(128) DEFAULT NULL,
  `polltime` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `settings_meteohub` VALUES (0,0,'http://myhub.com/meteolog.cgi?mode=data',300,0),(1,0,'http://myhub.com/meteolog.cgi?mode=data',300,0);

LOCK TABLES `version` WRITE;
INSERT INTO `version` VALUES (46,'1.0.001');
UNLOCK TABLES;
