--
-- Renamed duplicate devicetype
--
UPDATE devicetypes SET name = 'Z-Wave Secure Pad' WHERE id=242;
UPDATE devicetypes SET description = 'Secure Pad' WHERE id=242;

--
-- Alter field length for Xively channel
--

ALTER TABLE devices_pachube MODIFY datastreamid varchar(64);

--
-- Dumping data for table interfaces
--
LOCK TABLES interfaces WRITE;
/*!40000 ALTER TABLE interfaces DISABLE KEYS */;
INSERT INTO interfaces VALUES  (58,'Philips Hue Interface','PhilipsHue','Read Write');
INSERT INTO interfaces VALUES  (59,'WiringPi Interface','WiringPi','Read Write');
/*!40000 ALTER TABLE interfaces ENABLE KEYS */;
UNLOCK TABLES;

--
-- Convert interfaces table for dynamic setdevice via plugin call
--
RENAME TABLE interfaces to plugins;
ALTER TABLE plugins CHANGE COLUMN name interface varchar(32);
ALTER TABLE plugins CHANGE COLUMN mode name varchar(32) NOT NULL;
UPDATE plugins SET name = 'RFXComRX' WHERE id=1;
UPDATE plugins SET name = 'CTX35' WHERE id=2;
UPDATE plugins SET name = 'Temp08' WHERE id=3;
UPDATE plugins SET name = 'HDDTemp' WHERE id=4;
UPDATE plugins SET name = 'Ping' WHERE id=5;
UPDATE plugins SET name = 'UPS' WHERE id=6;
UPDATE plugins SET name = 'X10Cmd' WHERE id=7;
UPDATE plugins SET name = 'Bluetooth' WHERE id=8;
UPDATE plugins SET name = 'Weeder' WHERE id=9;
UPDATE plugins SET name = 'Plugwise' WHERE id=10;
UPDATE plugins SET name = 'DSC' WHERE id=11;
UPDATE plugins SET name = 'RFXComTX' WHERE id=12;
UPDATE plugins SET name = 'EIB' WHERE id=13;
UPDATE plugins SET name = 'Digitemp' WHERE id=14;
UPDATE plugins SET name = 'OpenZwave' WHERE id=15;
UPDATE plugins SET name = 'PLCBUS' WHERE id=16;
UPDATE plugins SET name = 'Virtual' WHERE id=17;
UPDATE plugins SET name = 'SqueezeServer' WHERE id=18;
UPDATE plugins SET name = 'CurrentCost' WHERE id=19;
UPDATE plugins SET name = 'EZcontrol' WHERE id=20;
UPDATE plugins SET name = 'LIRC' WHERE id=21;
UPDATE plugins SET name = 'PwrCtrl' WHERE id=22;
UPDATE plugins SET name = 'Denon' WHERE id=23;
UPDATE plugins SET name = 'Onkyo' WHERE id=24;
UPDATE plugins SET name = 'SharpTV' WHERE id=25;
UPDATE plugins SET name = 'LGTV' WHERE id=26;
UPDATE plugins SET name = 'IPort' WHERE id=27;
UPDATE plugins SET name = 'JeeLabs' WHERE id=29;
UPDATE plugins SET name = 'K8055' WHERE id=30;
UPDATE plugins SET name = 'OWFS' WHERE id=31;
UPDATE plugins SET name = 'CUL' WHERE id=32;
UPDATE plugins SET name = 'RFXComxPL' WHERE id=33;
UPDATE plugins SET name = 'Shell' WHERE id=34;
UPDATE plugins SET name = 'RFXComTRX' WHERE id=35;
UPDATE plugins SET name = 'HomeMatic' WHERE id=36;
UPDATE plugins SET name = 'OpenTherm' WHERE id=37;
UPDATE plugins SET name = 'SmartMeter' WHERE id=38;
UPDATE plugins SET name = 'Pioneer' WHERE id=39;
UPDATE plugins SET name = 'XBMCxPL' WHERE id=40;
UPDATE plugins SET name = 'Meteohub' WHERE id=41;
UPDATE plugins SET name = 'ELVMAX' WHERE id=42;
UPDATE plugins SET name = 'YouLess' WHERE id=43;
UPDATE plugins SET name = 'Mochad' WHERE id=44;
UPDATE plugins SET name = 'Omniksol' WHERE id=45;
UPDATE plugins SET name = 'Visonic' WHERE id=46;
UPDATE plugins SET name = 'KMTronicUDP' WHERE id=47;
UPDATE plugins SET name = 'DMXPlayer' WHERE id=48;
UPDATE plugins SET name = 'GenericIO' WHERE id=49;
UPDATE plugins SET name = 'MQTT' WHERE id=50;
UPDATE plugins SET name = 'RazBerry' WHERE id=51;
UPDATE plugins SET name = 'Arduino' WHERE id=52;
UPDATE plugins SET name = 'Velbus' WHERE id=53;
UPDATE plugins SET name = 'Viera' WHERE id=54;
UPDATE plugins SET name = 'Toon' WHERE id=55;
UPDATE plugins SET name = 'Jerome' WHERE id=56;
UPDATE plugins SET name = 'Wirelesstags' WHERE id=57;
UPDATE plugins SET name = 'PhilipsHue' WHERE id=58;
UPDATE plugins SET name = 'WiringPi' WHERE id=59;
ALTER TABLE plugins CHANGE COLUMN type protocols varchar(512) NOT NULL;
ALTER TABLE plugins ADD COLUMN type varchar(32) NOT NULL DEFAULT 'class' AFTER name;
INSERT INTO plugins VALUES  (60,'Asterisk','','Asterisk','class');
INSERT INTO plugins VALUES  (61,'BwiredMap','','BwiredMap','class');
INSERT INTO plugins VALUES  (62,'DeviceDiscover','','DeviceDiscover','class');
INSERT INTO plugins VALUES  (63,'GMail','','GMail','class');
INSERT INTO plugins VALUES  (64,'IRMan','','IRMan','class');
INSERT INTO plugins VALUES  (65,'IRTrans','','IRTrans','class');
INSERT INTO plugins VALUES  (66,'IViewer','','IViewer','class');
INSERT INTO plugins VALUES  (67,'JSONRPC','','JSONRPC','class');
INSERT INTO plugins VALUES  (68,'Ncid','','Ncid','class');
INSERT INTO plugins VALUES  (69,'NMA','','NMA','class');
INSERT INTO plugins VALUES  (70,'OWW','','OWW','class');
INSERT INTO plugins VALUES  (71,'P2000','','P2000','class');
INSERT INTO plugins VALUES  (72,'Pachube','','Pachube','class');
INSERT INTO plugins VALUES  (73,'Prowl','','Prowl','class');
INSERT INTO plugins VALUES  (74,'PVoutput','','PVoutput','class');
INSERT INTO plugins VALUES  (75,'Pushover','','Pushover','class');
INSERT INTO plugins VALUES  (76,'Pushbullet','','Pushbullet','class');
INSERT INTO plugins VALUES  (77,'SmartVISUServer','','SmartVISUServer','class');
INSERT INTO plugins VALUES  (78,'SMS','','SMS','class');
INSERT INTO plugins VALUES  (79,'TelnetServer','','TelnetServer','class');
INSERT INTO plugins VALUES  (80,'TemperaturNu','','TemperaturNu','class');
INSERT INTO plugins VALUES  (81,'Twitter','','Twitter','class');
INSERT INTO plugins VALUES  (82,'VISCA','','VISCA','class');
INSERT INTO plugins VALUES  (83,'WeatherUG','','WeatherUG','class');

UPDATE plugins SET type = 'virtual' WHERE id=17;
UPDATE plugins SET type = 'module' WHERE id=40;
UPDATE plugins SET type = 'module' WHERE id=45;
UPDATE plugins SET type = 'module' WHERE id=34;
UPDATE plugins SET type = 'module' WHERE id=33;
UPDATE plugins SET type = 'module' WHERE id=52;

--
-- Remove structure for settings_domotica
--
DROP TABLE IF EXISTS settings_domotica;

--
-- Table structure for settings_wiringpi
--
DROP TABLE IF EXISTS settings_wiringpi;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE settings_wiringpi (
  id int(11) NOT NULL,
  enabled tinyint(1) NOT NULL DEFAULT '0',
  polltime int(11) NOT NULL DEFAULT '10',
  debug tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings_wiringpi`
--
/*!40101 SET character_set_client = @saved_cs_client */;
LOCK TABLES settings_wiringpi WRITE;
/*!40000 ALTER TABLE `settings_wiringpi` DISABLE KEYS */;
INSERT INTO settings_wiringpi VALUES
(0,0,10,0),(1,0,10,0);
/*!40000 ALTER TABLE `settings_wiringpi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for settings_pushbullet
--
DROP TABLE IF EXISTS settings_pushbullet;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE settings_pushbullet (
  id int(11) NOT NULL,
  enabled tinyint(1) NOT NULL DEFAULT '0',
  token varchar(64) DEFAULT NULL,
  device varchar(64) DEFAULT NULL,
  debug tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings_pushbullet`
--
/*!40101 SET character_set_client = @saved_cs_client */;
LOCK TABLES settings_pushbullet WRITE;
/*!40000 ALTER TABLE `settings_pushbullet` DISABLE KEYS */;
INSERT INTO settings_pushbullet VALUES
(0,0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234','',0),(1,0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234','',0);
/*!40000 ALTER TABLE `settings_pushbullet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_weatherbug`
--
DROP TABLE IF EXISTS `settings_weatherbug`;

--
-- Remove OpenZWave devices table (not used anymore)
--
DROP TABLE IF EXISTS devices_zwave;

--
-- Remove Weather table, info stored in virtualdevice
--
DROP TABLE IF EXISTS weather;

--
-- Table structure for table `settings_devicediscover`
--
DROP TABLE IF EXISTS `settings_devicediscover`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_devicediscover` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `multicasthost` varchar(32) DEFAULT NULL,
  `multicastport` int(11) NOT NULL DEFAULT '0',
  `listenonly` tinyint(1) NOT NULL DEFAULT '0',
  `broadcastinterval` int(11) NOT NULL DEFAULT '0',
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings_devicediscover`
--
/*!40101 SET character_set_client = @saved_cs_client */;
LOCK TABLES `settings_devicediscover` WRITE;
/*!40000 ALTER TABLE `settings_devicediscover` DISABLE KEYS */;
INSERT INTO `settings_devicediscover` VALUES (0,0,'239.255.255.250',1900,0,60,0),(1,0,'239.255.255.250',1900,0,60,0);
/*!40000 ALTER TABLE `settings_devicediscover` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_philipshue`
--
DROP TABLE IF EXISTS `settings_philipshue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_philipshue` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `username` varchar(44) DEFAULT NULL,
  `polltime` int(11) NOT NULL DEFAULT '10',
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings_philipshue`
--
/*!40101 SET character_set_client = @saved_cs_client */;
LOCK TABLES `settings_philipshue` WRITE;
/*!40000 ALTER TABLE `settings_philipshue` DISABLE KEYS */;
INSERT INTO `settings_philipshue` VALUES (0,0,null,10,0),(1,0,null,10,0);
/*!40000 ALTER TABLE `settings_philipshue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert new devicetypes
--
INSERT INTO `devicetypes` VALUES (373,'Philips Hue Light Bulb','Light','PhilipsHue','1','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (374,'RaspberryPi I/O','RaspberryPi I/O','WiringPi','<pin>','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (375,'WiringPi I/O','WiringPi I/O','WiringPi','<wiringpi>:<baseaddr>:<i2caddr>|<pin>','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (376,'WiringPi I/O Inverted','WiringPi I/O Inverted','WiringPi','<wiringpi>:<baseaddr>:<i2caddr>|<pin>','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (377,'RaspberryPi I/O Inverted','RaspberryPi I/O Inverted','WiringPi','<pin>','','','',-1,-1,0,0,0,0,0);

--
-- Finally update to 1.0.017
--
LOCK TABLES version WRITE;
INSERT INTO version VALUES (62,'1.0.017');
UNLOCK TABLES;
