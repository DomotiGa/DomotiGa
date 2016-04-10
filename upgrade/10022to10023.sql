--
-- Delete duplicate Wirelesstags Plugin
--

DELETE FROM plugins WHERE id=93;

--
-- Fix 10020 to 10021 upgrade problem
--

DELETE FROM plugins WHERE id=94;
DELETE FROM plugins WHERE id=95;

INSERT INTO plugins (`id`, `interface`, `name`, `type`) VALUES (94, 'GPS', 'GPS', 'class');
INSERT INTO plugins (`id`, `interface`, `protocols`, `name`, `type`) values (95,'Buienradar','','Buienradar','class');

--
-- Extend serialport field length
--

ALTER TABLE settings_arduino CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_velbus CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;

--
-- Add Velbus VMB8PB module
--

DELETE FROM devicetypes WHERE id=674;

INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (674,'VMB8PB','Velbus - 8 channel pushbutton module','Velbus','13|1');

--
-- Update Visonic settings
--

ALTER TABLE settings_visonic ADD COLUMN `downloadcode` VARCHAR(16) NULL DEFAULT '5650'  AFTER `mastercode`;

--
-- Update Visonic device addresses
--

UPDATE devicetypes SET `addressformat`='Z01' WHERE `id`='289';
UPDATE devicetypes SET `addressformat`='Z01' WHERE `id`='291';
UPDATE devicetypes SET `addressformat`='Z01' WHERE `id`='293';

--
-- Extend plugin protocol field length
--

ALTER TABLE plugins CHANGE COLUMN `protocols` `protocols` VARCHAR(1024) CHARACTER SET 'utf8' NOT NULL;

--
-- Add Blinds1 support to rfxcom tranceiver plugin
--

UPDATE plugins SET protocols = 'X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubicson RisingSun PhilipsSBC EMW100 BBSB Blyss BlindsT0 BlindsT1 BlindsT2 BlindsT3 BlindsT4 BlindsT5 BlindsT6 BlindsT7 BlindsT8 BlindsT9 BlindsT10 BlindsT11 Meiantech ByronSX ByronMP SA30 X10SecDW X10SecMotion X10SecRemote PowerCodeDW PowerCodeMotion PowerCodeAux CodeSecure Energenie Livolo RSL TRC02 MDRemote SF01 RFY RFYEXT Imagintrx WT TRC022 AOKE EuroDomest Smartwares SelectPlus' WHERE id = 35;

--
-- Add Blinds1 devicetypes
--

DELETE FROM devicetypes WHERE id=680;
DELETE FROM devicetypes WHERE id=681;
DELETE FROM devicetypes WHERE id=682;
DELETE FROM devicetypes WHERE id=683;
DELETE FROM devicetypes WHERE id=684;
DELETE FROM devicetypes WHERE id=685;
DELETE FROM devicetypes WHERE id=686;
DELETE FROM devicetypes WHERE id=687;
DELETE FROM devicetypes WHERE id=688;
DELETE FROM devicetypes WHERE id=689;
DELETE FROM devicetypes WHERE id=690;
DELETE FROM devicetypes WHERE id=691;
DELETE FROM devicetypes WHERE id=692;
DELETE FROM devicetypes WHERE id=693;
DELETE FROM devicetypes WHERE id=694;
DELETE FROM devicetypes WHERE id=695;
DELETE FROM devicetypes WHERE id=696;
DELETE FROM devicetypes WHERE id=697;
DELETE FROM devicetypes WHERE id=698;
DELETE FROM devicetypes WHERE id=699;

INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (680,'Bofu Blinds','Blinds Motor','BlindsT0','0x00a1b2 1');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (681,'RollerTrol Blinds','Blinds Motor','BlindsT0','0x00a1b2 1');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (682,'Hasta New Blinds','Blinds Motor','BlindsT0','0x00a1b2 1');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (683,'Hasta Old Blinds','Blinds Motor','BlindsT1','0x00a1b2 1');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (684,'A-OK RF01 Blinds','Blinds Motor','BlindsT2','0x00a1b2');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (685,'A-OK AC114/123 Blinds','Blinds Motor','BlindsT3','0x00a1b2');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (686,'Raex YR1326 Blinds','Blinds Motor','BlindsT4','0x00a1b2');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (687,'Media Mount','Projection Screen','BlindsT5','0x00a1b2');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (688,'DC106 Motor','Blinds Motor','BlindsT6','0x00a1b2c 1');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (689,'Rohrmotor24-RMF','Blinds Motor','BlindsT6','0x00a1b2c 1');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (690,'Yooda Motor','Blinds Motor','BlindsT6','0x00a1b2c 1');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (691,'Dooya Motor','Blinds Motor','BlindsT6','0x00a1b2c 1');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (692,'ESMO Motor','Blinds Motor','BlindsT6','0x00a1b2c 1');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (693,'Brel Motor','Blinds Motor','BlindsT6','0x00a1b2c 1');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (694,'Quitidom Motor','Blinds Motor','BlindsT6','0x00a1b2c 1');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (695,'Forest Curtain','Blinds Motor','BlindsT7','0x00a1b2c 1');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (696,'Chamberlain CS4330CN','Blinds Motor','BlindsT8','0x00a1b2 1');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (697,'Sunpery/BTX Motor','Blinds Motor','BlindsT9','0x00a1b2 1');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (698,'Dolat DLM-1 Motor','Blinds Motor','BlindsT10','0x00a1b2');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (699,'Topstar Motor','Blinds Motor','BlindsT10','0x00a1b2');

--
-- Table structure for table `settings_rflink`
--

DROP TABLE IF EXISTS `settings_rflink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_rflink` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `serialport` varchar(128) DEFAULT NULL,
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_rflink`
--
LOCK TABLES `settings_rflink` WRITE;
/*!40000 ALTER TABLE `settings_rflink` DISABLE KEYS */;
INSERT INTO `settings_rflink` VALUES (0,0,'192.168.1.68',500,'serial','/dev/ttyUSBD0',0),(1,0,'192.168.1.68',500,'serial','/dev/ttyUSBD0',0);
/*!40000 ALTER TABLE `settings_rflink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Add the new RFLink plugin to the database
--

DELETE FROM plugins WHERE id=96;

INSERT INTO plugins (id, interface, protocols, name, type) VALUES (96,'RFLink Interface','AB400 Alectro Auriol Blyss Cresta HEEU Imagintrx Implus KAKU Koppla LaCrosse Mertik NewKAKU Oregon RFLink X10','RFLink','class');

--
-- Add RFLink devices
--

DELETE FROM devicetypes WHERE id=700;
DELETE FROM devicetypes WHERE id=701;
DELETE FROM devicetypes WHERE id=702;
DELETE FROM devicetypes WHERE id=703;
DELETE FROM devicetypes WHERE id=704;
DELETE FROM devicetypes WHERE id=705;

INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (700,'Alectro Device','Alectro RFLink Device','Alectro','alectro 0xa1b2');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (701,'Auriol Device','Auriol RFLink Device','Auriol','auriol 0xa1b2');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (702,'Cresta Device','Cresta RFLink Device','Cresta','auriol 0xa1b2');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (703,'LaCrosse Device','LaCrosse RFLink Device','LaCrosse','lacrosse 0xa1b2');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (704,'NewKAKU Device','NewKAKU RFLink Device','NewKAKU','00cac142 03');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (705,'UPM Device','UPM RFLink Device','UPM','c142');

--
-- Table structure for table `settings_unipi`
--

DROP TABLE IF EXISTS `settings_unipi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_unipi` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `sslenabled` tinyint(1) NOT NULL DEFAULT '0',
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_unipi`
--

LOCK TABLES `settings_unipi` WRITE;
/*!40000 ALTER TABLE `settings_unipi` DISABLE KEYS */;
INSERT INTO `settings_unipi` VALUES (0,0,'192.168.1.68',80,0,0),(1,0,'192.168.1.68',80,0,0);
/*!40000 ALTER TABLE `settings_unipi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Add UniPi default device
--

DELETE FROM devicetypes WHERE id=706;

INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (706,'UniPi','UniPi Device','UniPi','relay 1 or ao 1');

--
-- Add UniPi plugin
--

INSERT INTO plugins (id, interface, protocols, name, type) VALUES (97,'UniPi Interface','UniPi','UniPi','class');

--
-- Rename sslcertificate to sslcertificates
--

RENAME TABLE  `sslcertificate` TO  `sslcertificates`;

--
-- Update sslcertificates
--

ALTER TABLE sslcertificates CHANGE COLUMN `id` `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE sslcertificates CHANGE COLUMN `name` `name` VARCHAR(64) NOT NULL;
ALTER TABLE sslcertificates CHANGE COLUMN `certificate` `certificate` VARCHAR(128) NULL DEFAULT NULL;
ALTER TABLE sslcertificates CHANGE COLUMN `private` `private` VARCHAR(128) NULL DEFAULT NULL;
ALTER TABLE sslcertificates CHANGE COLUMN `client` `client` VARCHAR(128) NULL DEFAULT NULL;

--
-- Add DomotiGa default certificate
--

INSERT INTO sslcertificates (id, name, certificate, private, client, description) VALUES (1,"Default","domotiga-default.pem","","","DomotiGa default certificate");

--
-- Update settings_jsonrpc
--

ALTER TABLE settings_jsonrpc ADD COLUMN `sslcertificate_id` INT(11) NOT NULL DEFAULT '0' AFTER `sslenabled`;

--
-- Delete possible duplicate usernames and add unique index on username
--

DELETE n1 FROM users n1, users n2 WHERE n1.id > n2.id AND n1.username = n2.username;
ALTER TABLE users ADD UNIQUE INDEX `username` (`username` ASC);

--
-- Extended password field for SHA512 support
--
ALTER TABLE users CHANGE COLUMN `password` `password` VARCHAR(128) NULL DEFAULT NULL;

--
-- Remove existing cookies, they are incompatible with SHA256/SHA512
--
UPDATE users SET `cookie`='';

--
-- Add options1 column for special features
--
ALTER TABLE users ADD COLUMN `options1` INT(11) NULL DEFAULT '0' AFTER `cookie`;
UPDATE users SET `options1`=1 WHERE `username` = 'admin';

--
-- Insert Generic RFLink device, then we don't have to add every device (it is unlikely all of them are used)
--

DELETE FROM devicetypes WHERE id=707;

INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (707,'RFLink Generic Device','RFLink Device','RFLink','\'FA500 001b523 D3\' or \'Conrad 123456 1\'');

--
-- Add heartbeat timer to MySensors, and 60 seconds
--

ALTER TABLE settings_mysensors ADD COLUMN `heartbeat` INT(11) NULL DEFAULT '0' AFTER `useack`;

UPDATE settings_mysensors SET `heartbeat`=60;

--
-- Finally update to 1.0.023
--

DELETE FROM version WHERE db='1.0.023';

LOCK TABLES version WRITE;
INSERT INTO version VALUES (68,'1.0.023');
UNLOCK TABLES;

