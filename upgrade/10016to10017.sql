--
-- Missing devicetypes for KNX.EIB
--
INSERT INTO `devicetypes` VALUES (378,'KNX/EIB Access Control','EIS 12','KNX/EIB','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (379,'KNX/EIB ASCII Char','EIS 13','KNX/EIB','0/1/2','','','',-1,-1,0,0,0,0,0);
UPDATE devicetypes SET addressformat = '0/1/2|1/2/3' WHERE id=52;
UPDATE devicetypes SET addressformat = '0/1/2 or 0/1/2|1/2/3' WHERE id=46;

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
ALTER TABLE plugins CHANGE COLUMN type protocols varchar(512) NOT NULL;
ALTER TABLE plugins ADD COLUMN type varchar(32) NOT NULL DEFAULT 'class' AFTER name;
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
INSERT INTO plugins VALUES (60,'Asterisk','','Asterisk','class');
INSERT INTO plugins VALUES (61,'BwiredMap','','BwiredMap','class');
INSERT INTO plugins VALUES (62,'DeviceDiscover','','DeviceDiscover','class');
INSERT INTO plugins VALUES (63,'GMail','','GMail','class');
INSERT INTO plugins VALUES (64,'IRMan','','IRMan','class');
INSERT INTO plugins VALUES (65,'IRTrans','','IRTrans','class');
INSERT INTO plugins VALUES (66,'IViewer','','IViewer','class');
INSERT INTO plugins VALUES (67,'JSONRPC','','JSONRPC','class');
INSERT INTO plugins VALUES (68,'Ncid','','Ncid','class');
INSERT INTO plugins VALUES (69,'NMA','','NMA','class');
INSERT INTO plugins VALUES (70,'OWW','','OWW','class');
INSERT INTO plugins VALUES (71,'P2000','','P2000','class');
INSERT INTO plugins VALUES (72,'Pachube','','Pachube','class');
INSERT INTO plugins VALUES (73,'Prowl','','Prowl','class');
INSERT INTO plugins VALUES (74,'PVoutput','','PVoutput','class');
INSERT INTO plugins VALUES (75,'Pushover','','Pushover','class');
INSERT INTO plugins VALUES (76,'Pushbullet','','Pushbullet','class');
INSERT INTO plugins VALUES (77,'SmartVISUServer','','SmartVISUServer','class');
INSERT INTO plugins VALUES (78,'SMS','','SMS','class');
INSERT INTO plugins VALUES (79,'TelnetServer','','TelnetServer','class');
INSERT INTO plugins VALUES (80,'TemperaturNu','','TemperaturNu','class');
INSERT INTO plugins VALUES (81,'Twitter','','Twitter','class');
INSERT INTO plugins VALUES (82,'VISCA','','VISCA','class');
INSERT INTO plugins VALUES (83,'WeatherUG','','WeatherUG','class');

UPDATE plugins SET type = 'virtual' WHERE id=17;
UPDATE plugins SET type = 'module' WHERE id=40;
UPDATE plugins SET type = 'module' WHERE id=45;
UPDATE plugins SET type = 'module' WHERE id=34;
UPDATE plugins SET type = 'module' WHERE id=33;
UPDATE plugins SET type = 'module' WHERE id=52;

--
-- Added temp10 and th12 sensor for RFXComTRX
--
INSERT INTO `devicetypes` VALUES (380,'TFA Dostmann Temp Sensor','Temp Sensor','TFA','temp10 0x121','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (381,'Imagintronix Soil Sensor','Soil Sensor','Imagintrx','th12 0x1','','','',-1,-1,0,0,0,0,0);
UPDATE plugins SET protocols = 'X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubicson RisingSun PhilipsSBC EMW100 BBSB Blyss RollerTrol HastaNew HastaOld A-OKRF01 A-OKAC114 Meiantech ByronSX SA30 X10SecDW X10SecMotion X10SecRemote PowerCodeDW PowerCodeMotion PowerCodeAux CodeSecure Energenie Livolo RSL TRC02 MDRemote SF01 RFY RFYEXT Imagin' WHERE id = 35;

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

--
-- Insert new WiringPi devicetypes
--
INSERT INTO `devicetypes` VALUES (374,'RaspberryPi I/O','RaspberryPi I/O','WiringPi','<pin>','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (375,'WiringPi I/O','WiringPi I/O','WiringPi','<wiringpi>:<baseaddr>:<i2caddr>|<pin>','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (376,'WiringPi I/O Inverted','WiringPi I/O Inverted','WiringPi','<wiringpi>:<baseaddr>:<i2caddr>|<pin>','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (377,'RaspberryPi I/O Inverted','RaspberryPi I/O Inverted','WiringPi','<pin>','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (382,'WiringPi ADC','WiringPi ADC','WiringPi','<wiringpi>:<baseaddr>:<i2caddr>|<pin>','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (383,'WiringPi DAC','WiringPi DAC','WiringPi','<wiringpi>:<baseaddr>:<i2caddr>|<pin>','','','',-1,-1,0,0,0,0,0);

--
-- Insert new Toon devicetypes
--
INSERT INTO `devicetypes` VALUES (384,'Toon Stekker','Wall Plug','Toon','<Name>','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (385,'Toon All On/Off Stekkers','All On/Off Wall Plugs','Toon','Toon','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

--
-- Cleanup the OpenZWave/RaZberry devicetypes
--
UPDATE devices SET module=64 WHERE module=63;
UPDATE devices SET module=64 WHERE module=304;
UPDATE devices SET module=64 WHERE module=305;
UPDATE devices SET module=64 WHERE module=306;
UPDATE devices SET module=64 WHERE module=307;
UPDATE devices SET module=64 WHERE module=308;
UPDATE devices SET module=64 WHERE module=310;
UPDATE devices SET module=64 WHERE module=312;
UPDATE devices SET module=64 WHERE module=313;
UPDATE devices SET module=64 WHERE module=314;
UPDATE devices SET module=64 WHERE module=316;
UPDATE devices SET module=64 WHERE module=317;
UPDATE devices SET module=64 WHERE module=318;
UPDATE devices SET module=64 WHERE module=323;
UPDATE devices SET module=64 WHERE module=324;
UPDATE devices SET module=61 WHERE module=244;
UPDATE devices SET module=61 WHERE module=319;
UPDATE devices SET module=61 WHERE module=320;
UPDATE devices SET module=61 WHERE module=325;
UPDATE devices SET module=61 WHERE module=326;
UPDATE devices SET module=61 WHERE module=327;
UPDATE devices SET module=61 WHERE module=328;
UPDATE devices SET module=61 WHERE module=330;
UPDATE devices SET module=61 WHERE module=331;
UPDATE devices SET module=62 WHERE module=322;
UPDATE devices SET module=62 WHERE module=329;
UPDATE devices SET module=62 WHERE module=332;
UPDATE devices SET module=242 WHERE module=333;
UPDATE devices SET module=304 WHERE module=311;
UPDATE devices SET module=304 WHERE module=315;
UPDATE devices SET module=305 WHERE module=321;
UPDATE devicetypes SET name='Z-Wave Controller', description='Controller', addressformat='1' WHERE id=63;
UPDATE devicetypes SET name='Z-Wave Sensor', description='Sensor' WHERE id=64;
UPDATE devicetypes SET name='Z-Wave Entry Control', description='Entry Control' WHERE id=309;
UPDATE devicetypes SET name='Z-Wave Generic', description='Generic' WHERE id=304;
UPDATE devicetypes SET name='Z-Wave Motor Control', description='Motor Control' WHERE id=305;
UPDATE devicetypes SET name='Z-Wave Remote Switch', description='Remote Switch' WHERE id=306;
DELETE FROM devicetypes WHERE id=244;
DELETE FROM devicetypes WHERE id=307;
DELETE FROM devicetypes WHERE id=308;
DELETE FROM devicetypes WHERE id=310;
DELETE FROM devicetypes WHERE id=311;
DELETE FROM devicetypes WHERE id=312;
DELETE FROM devicetypes WHERE id=313;
DELETE FROM devicetypes WHERE id=314;
DELETE FROM devicetypes WHERE id=315;
DELETE FROM devicetypes WHERE id=316;
DELETE FROM devicetypes WHERE id=317;
DELETE FROM devicetypes WHERE id=318;
DELETE FROM devicetypes WHERE id=319;
DELETE FROM devicetypes WHERE id=320;
DELETE FROM devicetypes WHERE id=321;
DELETE FROM devicetypes WHERE id=322;
DELETE FROM devicetypes WHERE id=323;
DELETE FROM devicetypes WHERE id=324;
DELETE FROM devicetypes WHERE id=325;
DELETE FROM devicetypes WHERE id=326;
DELETE FROM devicetypes WHERE id=327;
DELETE FROM devicetypes WHERE id=328;
DELETE FROM devicetypes WHERE id=329;
DELETE FROM devicetypes WHERE id=330;
DELETE FROM devicetypes WHERE id=331;
DELETE FROM devicetypes WHERE id=332;
DELETE FROM devicetypes WHERE id=333;

--
-- Virtual WeatherUnderground device
--
INSERT INTO `devicetypes` VALUES (141,'WeatherUnderground','WeatherUnderground','Virtual','WeatherUnderground','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

--
-- Finally update to 1.0.017
--
LOCK TABLES version WRITE;
INSERT INTO version VALUES (62,'1.0.017');
UNLOCK TABLES;
