-- MySQL dump 10.13  Distrib 5.1.37, for debian-linux-gnu (i486)
--
-- Host: localhost    Database: domotiga
-- ------------------------------------------------------
-- Server version	5.1.37-1ubuntu5

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

USE domotiga;

--
-- Table structure for table `settings_bwiredmap`
--

DROP TABLE IF EXISTS `settings_bwiredmap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_bwiredmap` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `website` varchar(64) DEFAULT NULL,
  `websitepicurl` varchar(64) DEFAULT NULL,
  `title` varchar(64) DEFAULT NULL,
  `city` varchar(64) DEFAULT NULL,
  `user` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `screenname` varchar(64) DEFAULT NULL,
  `gpslat` varchar(64) DEFAULT NULL,
  `gpslong` varchar(64) DEFAULT NULL,
  `pushtime` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_bwiredmap`
--

LOCK TABLES `settings_bwiredmap` WRITE;
/*!40000 ALTER TABLE `settings_bwiredmap` DISABLE KEYS */;
INSERT INTO `settings_bwiredmap` VALUES (0,0,'http://www.domotiga.nl',NULL,'DomotiGa User','Dordrecht','LoginUser','LoginPassword',NULL,NULL,NULL,60,0),(1,0,'www.domotiga.nl',NULL,'DomotiGa User','Dordrecht','Login','Password',NULL,'51.8','4.75',60,0);
/*!40000 ALTER TABLE `settings_bwiredmap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_lirc`
--

DROP TABLE IF EXISTS `settings_lirc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_lirc` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_lirc`
--

LOCK TABLES `settings_lirc` WRITE;
/*!40000 ALTER TABLE `settings_lirc` DISABLE KEYS */;
INSERT INTO `settings_lirc` VALUES (0,0,'localhost',8765,0),(1,0,'localhost',8765,-1);
/*!40000 ALTER TABLE `settings_lirc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_oww`
--

DROP TABLE IF EXISTS `settings_oww`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_oww` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `servertype` varchar(32) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_oww`
--

LOCK TABLES `settings_oww` WRITE;
/*!40000 ALTER TABLE `settings_oww` DISABLE KEYS */;
INSERT INTO `settings_oww` VALUES (0,0,'192.168.1.65',8891,'Oww text-format',1),(1,0,'192.168.1.65',8888,'Henriksen WServer TCP',-1);
/*!40000 ALTER TABLE `settings_oww` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_pachube`
--

DROP TABLE IF EXISTS `settings_pachube`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_pachube` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `feed` int(11) DEFAULT NULL,
  `apikey` varchar(128) DEFAULT NULL,
  `pushtime` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_pachube`
--

LOCK TABLES `settings_pachube` WRITE;
/*!40000 ALTER TABLE `settings_pachube` DISABLE KEYS */;
INSERT INTO `settings_pachube` VALUES (0,0,1234,NULL,15,0),(1,0,3711,NULL,10,-1);
/*!40000 ALTER TABLE `settings_pachube` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `db` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES (1,'0.1.166'),(2,'0.1.167'),(3,'0.1.168'),(4,'0.1.169'),(5,'0.1.170'),(6,'0.1.171'),(7,'0.1.172'),(8,'0.1.173'),(9,'0.1.174'),(10,'0.1.175');
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devicetypes`
--

DROP TABLE IF EXISTS `devicetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devicetypes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `description` varchar(32) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devicetypes`
--

LOCK TABLES `devicetypes` WRITE;
/*!40000 ALTER TABLE `devicetypes` DISABLE KEYS */;
INSERT INTO `devicetypes` VALUES (1,'Marmitek DS90','Door/Window Sensor','X10Security'),(2,'Marmitek LW10G','Lamp Module','X10'),(3,'Marmitek LD11','Dimmer Module','X10'),(4,'Marmitek MS13E M','Motion Sensor','X10'),(5,'Marmitek MS13E L','Light Sensor','X10'),(6,'Xanura SAX35','I/O Actor','A10'),(7,'Oregon THGR238N','Temp/Hygro Sensor','Oregon'),(8,'Oregon UV138','UV Light Sensor','Oregon'),(9,'RFXPwr Module','Power Usage Sensor','RFXCom'),(10,'Marmitek TM13','Wireless Tranceiver','X10'),(11,'HDDTemp Item','Temp Monitor','HDDTemp'),(12,'Oregon THR128','Temp Sensor','Oregon'),(13,'Sony AIBO ERS7 ','Robot Dog','AIBO'),(14,'APC SmartUPS1000','Power Supply','UPS'),(15,'Dallas DS18S20','Temp Sensor','1-Wire'),(16,'Dallas Rain Gauge','Rain Gauge','1-Wire'),(17,'Marmitek SD90','Smoke Detector','X10Security'),(18,'Bluetooth Device','Phone','Bluetooth'),(19,'ITHO ECO Fan','Central Ventilation','Weeder'),(20,'RFXPulse Gas','Gas Usage Sensor','RFXCom'),(21,'RFXPulse Water','Water Usage Sensor','RFXCom'),(22,'Oregon BWR102','Digital Bathroom Scale','Oregon'),(23,'Oregon GR101','Digital Bathroom Scale','Oregon'),(24,'Oregon THC138','Temp Sensor','Oregon'),(25,'Oregon THR138','Temp Sensor','Oregon'),(26,'Oregon THGR810','Temp/Hygro Sensor','Oregon'),(27,'Plugwise Circle','Zigbee Appliance Module','Plugwise'),(28,'Plugwise Circle+','Zigbee Appliance Module','Plugwise'),(29,'KAKU Doorbell','Wireless Doorbell','X10'),(30,'Oregon THN132N','Temp Sensor','Oregon'),(31,'Oregon THWR288','Temp Sensor','Oregon'),(32,'Oregon BTHR918N','Baro/Temp/Hygro Sensor','Oregon'),(33,'Oregon BTHR968','Baro/Temp/Hygro Sensor','Oregon'),(34,'Marmitek AD10','Switch Module','X10'),(35,'Marmitek LM12','Lamp Module','X10'),(36,'Marmitek AM12','Appliance Module','X10'),(38,'Oregon PCR800','Rain Gauge','Oregon'),(39,'Oregon RTGR328N','Temp/Hygro/Time Sensor','Oregon'),(40,'DSC PIR','Motion Sensor','DSC'),(41,'DSC Contact','Door/Window Sensor','DSC'),(42,'DSC Smoke','Smoke Detector','DSC'),(43,'KAKU AWST-8802','Wireless Wallswitch Dual','HE'),(44,'KAKU AMST-606','Door/Window Sensor','HE'),(46,'KNX/EIB Dim','EIS 2','KNX/EIB'),(45,'KNX/EIB On/Off','EIS 1','KNX/EIB'),(49,'KNX/EIB Values','EIS 5','KNX/EIB'),(48,'KNX/EIB Date','EIS 4','KNX/EIB'),(47,'KNX/EIB Time','EIS 3','KNX/EIB'),(50,'KNX/EIB Scaling %','EIS 6','KNX/EIB'),(51,'KNX/EIB Motor Drives','EIS 7','KNX/EIB'),(52,'KNX/EIB Forced Control','EIS 8','KNX/EIB'),(53,'KNX/EIB 32bit Float','EIS 9','KNX/EIB'),(54,'KNX/EIB 16bit Int','EIS 10','KNX/EIB'),(55,'KNX/EIB 32bit Int','EIS 11','KNX/EIB'),(56,'KNX/EIB 8bit Int','EIS 14','KNX/EIB'),(57,'KNX/EIB 14byte Text','EIS 15','KNX/EIB'),(58,'Dallas DS2423','4Kbit RAM + Counter','1-Wire'),(59,'KAKU PAR 1000','Appliance Module','ARC'),(60,'KAKU AC-300','Dimmer Module','AC'),(61,'Z-Wave Switch','Binary Switch','Z-Wave'),(62,'Z-Wave Dimmer','Multilevel Switch','Z-Wave'),(63,'Z-Wave D/W Sensor','Door/Window Sensor','Z-Wave'),(64,'Z-Wave PIR Sensor','Motion Sensor','Z-Wave'),(65,'Dallas DS2438','Smart Battery Monitor','1-Wire');
/*!40000 ALTER TABLE `devicetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devices_pachube`
--

DROP TABLE IF EXISTS `devices_pachube`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devices_pachube` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `datastreamid` varchar(8) DEFAULT NULL,
  `tags` varchar(32) DEFAULT NULL,
  `devicename` varchar(32) DEFAULT NULL,
  `deviceid` int(11) DEFAULT NULL,
  `devicelabel` varchar(16) DEFAULT NULL,
  `devicelabelshort` varchar(8) DEFAULT NULL,
  `units` varchar(32) DEFAULT NULL,
  `unittype` varchar(16) DEFAULT NULL,
  `value` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-12-04 19:23:13
