-- MySQL dump 10.13  Distrib 5.1.54, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: domotiga
-- ------------------------------------------------------
-- Server version	5.1.54-1ubuntu4

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `calendar`
--

DROP TABLE IF EXISTS `calendar`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `calendar` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `date` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `macros`
--

DROP TABLE IF EXISTS `macros`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `macros` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(64) default NULL,
  `formula` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `settings_mpd`
--

DROP TABLE IF EXISTS `settings_mpd`;

--
-- Table structure for table `settings_main`
--

ALTER TABLE `settings_main` ADD COLUMN `logprefix` varchar(16) DEFAULT NULL AFTER autodevicecreate;

--
-- Table structure for table `devices`
--

ALTER TABLE `devices` ADD COLUMN `repeatstate` tinyint(1) default NULL AFTER lastchanged;
ALTER TABLE `devices` ADD COLUMN `repeatperiod` int(11) default NULL AFTER repeatstate;
ALTER TABLE `devices` ADD COLUMN `reset` tinyint(1) default NULL AFTER repeatperiod;
ALTER TABLE `devices` ADD COLUMN `resetperiod` int(11) default NULL AFTER reset;
ALTER TABLE `devices` ADD COLUMN `resetvalue` text AFTER resetperiod;
ALTER TABLE devices DROP user;

--
-- Dumping data for table `users`
--

DELETE FROM users WHERE id=0;
INSERT INTO users (username,password,fullname,admin) VALUES('mhsend','','mhsend user',0);

--
-- Dumping data for table `devicetypes`
--

INSERT INTO `devicetypes` VALUES (223,'La Crosse TX-3TH','Temp/Hygro Sensor','LaCrosse','\'temp5 0x123\' or \'hum1 0x123\'','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (224,'La Crosse TX-4TH','Temp/Hygro Sensor','LaCrosse','\'temp5 0x123\' or \'hum1 0x123\'','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (225,'La Crosse TX-17','Temp Sensor','LaCrosse','temp5 0x123','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (226,'TFA Dostmann TS34C','Temp Sensor','TFA','th7 0x123','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (227,'Chacon Module','Appliance Module','EMW200','A1','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (228,'Anslut Module','Appliance Module','Anslut','A1','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (229,'Impuls Module','Appliance Module','Impuls','A1','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (230,'Lightwave Module','Appliance Module','LightwaveRF','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (231,'TFA Dostmann Rain Sensor','Rain Sensor','TFA','rain3 0x123','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (232,'TFA Dostmann UV Sensor','UV Sensor','TFA','uv3 0x123','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (233,'TFA Dostmann Wind Sensor','Anemo Meter','TFA','wind4 0x121','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

--
-- Table structure for table `settings_rfxcomtrx`
--

DROP TABLE IF EXISTS `settings_rfxcomtrx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_rfxcomtrx` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `serialport` varchar(32) DEFAULT NULL,
  `baudrate` varchar(32) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  `relayenabled` tinyint(1) DEFAULT NULL,
  `relayport` int(11) DEFAULT NULL,
  `globalx10` tinyint(1) DEFAULT NULL,
  `oldaddrfmt` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_rfxcomtrx`
--

LOCK TABLES `settings_rfxcomtrx` WRITE;
/*!40000 ALTER TABLE `settings_rfxcomtrx` DISABLE KEYS */;
INSERT INTO `settings_rfxcomtrx` VALUES (0,0,'192.168.100.7',10001,'tcp','/dev/ttyACM1','38400',0,0,10011,0,0),(1,0,'192.168.100.7',10001,'serial','/dev/ttyACM1','38400',-1,-1,10011,0,0);
/*!40000 ALTER TABLE `settings_rfxcomtrx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interfaces`
--

DROP TABLE IF EXISTS `interfaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interfaces` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `type` varchar(256) DEFAULT NULL,
  `mode` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

INSERT INTO `version` VALUES (39,'0.1.204');

--
-- Dumping data for table `interfaces`
--

LOCK TABLES `interfaces` WRITE;
/*!40000 ALTER TABLE `interfaces` DISABLE KEYS */;
INSERT INTO `interfaces` VALUES (1,'RFXCom Receiver','X10 X10Security Oregon KAKU RFXCom HEUK ATI Digimax ARC AC HEEU','Read'),(2,'Xanura CTX35','X10','Read Write'),(3,'Midon TEMP08','1-Wire','Read Write'),(4,'HDDTemp Socket','HDDTemp','Read'),(5,'Ping Socket','Ping','Read'),(6,'UPS Socket','UPS','Read'),(7,'X10Cmd Interface','X10','Write'),(8,'Bluetooth Dongle','Bluetooth','Read'),(9,'Weeder I/O Bus','Weeder','Read Write'),(10,'Plugwise Stick','Plugwise','Read Write'),(11,'DSC5401 Interface','DSC','Read Write'),(12,'RFXCom Transmitter','X10 ARC AC RFXCom X10Security HEEU HEUK Digimax Harrison Koppla Waveman Flamingo KAKU','Read Write'),(13,'KNX/EIB Interface','KNX/EIB','Read Write'),(14,'Digitemp','1-Wire','Read'),(15,'Z-Wave Controller','Z-Wave','Read Write'),(16,'PLCBUS Interface','PLCBUS','Read Write'),(17,'Virtual Interface','Virtual','Read Write'),(18,'SqueezeServer Interface','Squeeze','Read Write'),(19,'Current Cost Receiver','CurrentCost','Read'),(20,'EZcontrol T10 Interface','T10-Preset FS10 FS20 RS200 AB400 AB601 IT REV BS-QU MARMI OA-FM KO-FC RS862','Write'),(21,'LIRC Interface','LIRC','Read'),(22,'PwrCtrl Interface','PwrCtrl','Read Write'),(23,'Denon Interface','Denon','Read Write'),(24,'Onkyo Interface','Onkyo','Read Write'),(25,'SharpTV Interface','SharpTV','Read Write'),(26,'LGTV Interface','LGTV','Read Write'),(27,'iPort Interface','iPort','Read Write'),(28,'Google Latitude','GLatitude','Read'),(29,'JeeLabs Interface','JeeLabs ARC KAKU','Read Write'),(30,'Velleman K8055','K8055','Read Write'),(31,'OWFS Interface','1-Wire','Read Write'),(32,'CUL Interface','FS20 EM1000 FHT S300 HMS','Read Write'),(33,'RFXCom xPL','X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison RFXLanIO','Read Write'),(34,'Shell Interface','Shell','Read'),(35,'RFXCom Tranceiver','X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse','Read Write');
/*!40000 ALTER TABLE `interfaces` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-01-19 12:37:50
