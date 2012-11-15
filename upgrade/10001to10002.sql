
UPDATE devicetypes SET addressformat="A01" WHERE id=2;
UPDATE devicetypes SET addressformat="A01" WHERE id=3;
UPDATE devicetypes SET addressformat="A01" WHERE id=4;
UPDATE devicetypes SET addressformat="A01" WHERE id=5;
UPDATE devicetypes SET addressformat="A01" WHERE id=10;
UPDATE devicetypes SET addressformat="A01" WHERE id=34;
UPDATE devicetypes SET addressformat="A01" WHERE id=35;
UPDATE devicetypes SET addressformat="A01" WHERE id=36;
UPDATE devicetypes SET addressformat="A01" WHERE id=59;
UPDATE devicetypes SET addressformat="A01" WHERE id=151;
UPDATE devicetypes SET addressformat="A01" WHERE id=152;
UPDATE devicetypes SET addressformat="A01" WHERE id=153;
UPDATE devicetypes SET addressformat="A01" WHERE id=150;
UPDATE devicetypes SET addressformat="A01" WHERE id=229;
UPDATE devicetypes SET addressformat="A01" WHERE id=151;
UPDATE devicetypes SET addressformat="A01" WHERE id=228;

UPDATE devicetypes SET addressformat="00aaff 1" WHERE id=230;
UPDATE devicetypes SET addressformat="A01" WHERE id=277;
UPDATE devicetypes SET addressformat="00aaff 1" WHERE id=279;

ALTER TABLE interfaces MODIFY type varchar(512);

UPDATE interfaces SET type = 'X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubicson RisingSun PhilipsSBC EMW100 BBSB Blyss RollerTrol HastaNew HastaOld A-OKRF01 A-OKAC114 Meiantech' WHERE id=35;

--
-- Table structure for table 'settings_youless'
--

DROP TABLE IF EXISTS `settings_youless`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_youless` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `fetchurl` varchar(128) DEFAULT NULL,
  `polltime` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `settings_youless` VALUES (0,0,'http://myyouless.com/a?f=j',300,0),(1,0,'http://myyouless.com/a?f=j',300,0);

INSERT INTO `devicetypes` VALUES (281,'YouLess LS110','Energy Usage Sensor','YouLess','1','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `interfaces` VALUES (43,'YouLess Interface','YouLess','Read');

INSERT INTO `devicetypes` VALUES (282,'Blyss Switch Module','Switch Module','Blyss','00FF A1','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (283,'Blyss Dimmer Module','Dimmer Module','Blyss','00FF A1','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (284,'Blyss Shutter Module','Shutter Module','Blyss','00FF A1','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

LOCK TABLES `version` WRITE;
INSERT INTO `version` VALUES (47,'1.0.002');
UNLOCK TABLES;
