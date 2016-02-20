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
LOCK TABLES `devicetypes` WRITE;
/*!40000 ALTER TABLE `devicetypes` DISABLE KEYS */;
INSERT INTO `devicetypes` VALUES (674,'VMB8PB','Velbus - 8 channel pushbutton module','Velbus','13|1');
/*!40000 ALTER TABLE `devicetypes` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Extend plugin protocol field lenght
--
ALTER TABLE plugins CHANGE COLUMN `protocols` `protocols` VARCHAR(1024) CHARACTER SET 'utf8' NOT NULL;

--
-- Add Blinds1 support to rfxcom tranceiver plugin
--
UPDATE plugins SET protocols = 'X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubicson RisingSun PhilipsSBC EMW100 BBSB Blyss BlindsT0 BlindsT1 BlindsT2 BlindsT3 BlindsT4 BlindsT5 BlindsT6 BlindsT7 BlindsT8 BlindsT9 BlindsT10 BlindsT11 Meiantech ByronSX ByronMP SA30 X10SecDW X10SecMotion X10SecRemote PowerCodeDW PowerCodeMotion PowerCodeAux CodeSecure Energenie Livolo RSL TRC02 MDRemote SF01 RFY RFYEXT Imagintrx WT TRC022 AOKE EuroDomest Smartwares SelectPlus' WHERE id = 35;

--
-- Add Blinds1 devicetypes
--
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
  `baudrate` varchar(32) DEFAULT NULL,
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_rflink`
--

LOCK TABLES `settings_rflink` WRITE;
/*!40000 ALTER TABLE `settings_rflink` DISABLE KEYS */;
INSERT INTO `settings_rflink` VALUES (0,0,'192.168.1.68',500,'serial','/dev/ttyUSBD0','9600',0),(1,0,'192.168.1.68',500,'serial','/dev/ttyUSBD0','9600',0);
/*!40000 ALTER TABLE `settings_rflink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Finally update to 1.0.023
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (68,'1.0.023');
UNLOCK TABLES;
