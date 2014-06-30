
--
-- Add new protocols to RFXtrx interface
--
UPDATE interfaces SET type = 'X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubicson RisingSun PhilipsSBC EMW100 BBSB Blyss RollerTrol HastaNew HastaOld A-OKRF01 A-OKAC114 Meiantech ByronSX SA30 X10SecDW X10SecMotion X10SecRemote PowerCodeDW PowerCodeMotion PowerCodeAux CodeSecure Energenie Livolo RSL TRC02 MDRemote SF01 RFY RFYEXT' WHERE id=35;

INSERT INTO `devicetypes` VALUES (366,'Somfy Blind','Blind Remote','RFY','0xf12ab 1','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (367,'Somfy Blind Ext','Blind Remote Ext','RFYEXT','0xf12ab 1','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (368,'Motion sensor','Motion Sensor','Wirelesstags','xxxxxxxxxx','','','',0,0,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (369,'Water Soil Moisture sensor','Water Sensor','Wirelesstags','xxxxxxxxxx','','','',0,0,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (370,'Reed sensor','Reed Sensor','Wirelesstags','xxxxxxxxxx','','','',0,0,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (371,'PIR Sensor Tag','PIR Sensor','Wirelesstags','xxxxxxxxxx','','','',0,0,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (372,'KumoStat Sensor','Thermostat','Wirelesstags','xxxxxxxxxx','','','',0,0,0,0,0,0,0);

--
-- Table structure for table settings_wirelesstags--
DROP TABLE IF EXISTS settings_wirelesstags;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE settings_wirelesstags (
  id int(11) NOT NULL,
  enabled tinyint(1) NOT NULL DEFAULT '0',
  polltime int(11) NOT NULL DEFAULT '0',
  user varchar(64) DEFAULT NULL,
  password varchar(64) DEFAULT NULL,
  debug tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1

--
-- Dumping data for table settings_wirelesstags--

LOCK TABLES settings_wirelesstags WRITE;
/*!40000 ALTER TABLE settings_wirelesstags DISABLE KEYS */;
INSERT INTO settings_wirelesstags VALUES
(0,0,300,'wirelesstagslogin','wirelesstagspassword',0),(1,-1,300,'username@domain.com','password',-1);
/*!40000 ALTER TABLE settings_wirelesstags ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;


--
-- Only use numbers above 1000, if an user adds its own devicetype. Else it can cause a conflict with new standard devices
--
--ALTER TABLE `devicetypes` AUTO_INCREMENT = 1000;

--
-- Update Boolean '1' to '-1'
--
UPDATE devices SET enabled = '-1' WHERE enabled=1;

--
-- Finally update to 1.0.016
--
LOCK TABLES version WRITE;
INSERT INTO version VALUES (61,'1.0.016');
UNLOCK TABLES;

