-- MySQL dump 10.11
--
-- Host: localhost    Database: domotiga
-- ------------------------------------------------------
-- Server version	5.0.51a-3ubuntu5.4

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
-- Table structure for table `settings_dsc`
--

DROP TABLE IF EXISTS `settings_dsc`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_dsc` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `serialport` varchar(32) default NULL,
  `baudrate` int(11) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_dsc`
--

LOCK TABLES `settings_dsc` WRITE;
/*!40000 ALTER TABLE `settings_dsc` DISABLE KEYS */;
INSERT INTO `settings_dsc` VALUES (0,0,'/dev/ttyS0',9600,0),(1,0,'/dev/ttyS0',9600,0);
/*!40000 ALTER TABLE `settings_dsc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_bwiredmap`
--

DROP TABLE IF EXISTS `settings_bwiredmap`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_bwiredmap` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `website` varchar(64) default NULL,
  `websitepicurl` varchar(64) default NULL,
  `title` varchar(64) default NULL,
  `city` varchar(64) default NULL,
  `user` varchar(64) default NULL,
  `password` varchar(64) default NULL,
  `screenname` varchar(64) default NULL,
  `gpslat` varchar(64) default NULL,
  `gpslong` varchar(64) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_bwiredmap`
--

LOCK TABLES `settings_bwiredmap` WRITE;
/*!40000 ALTER TABLE `settings_bwiredmap` DISABLE KEYS */;
INSERT INTO `settings_bwiredmap` VALUES (0,0,'http://www.domotiga.nl',NULL,'DomotiGa User','Sliedrecht','LoginUser','LoginPassword',NULL,NULL,NULL,0),(1,0,'www.domotiga.nl',NULL,'DomotiGa User','Earth','LoginUser','LoginPassword','ScreenName','51.8','4.75',0);
/*!40000 ALTER TABLE `settings_bwiredmap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_twitter`
--

DROP TABLE IF EXISTS `settings_twitter`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_twitter` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `username` varchar(64) default NULL,
  `password` varchar(64) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_twitter`
--

LOCK TABLES `settings_twitter` WRITE;
/*!40000 ALTER TABLE `settings_twitter` DISABLE KEYS */;
INSERT INTO `settings_twitter` VALUES (0,0,'twitteraccount','password',0),(1,0,'twitteraccount','password',0);
/*!40000 ALTER TABLE `settings_twitter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `interfaces`
--

LOCK TABLES `interfaces` WRITE;
/*!40000 ALTER TABLE `interfaces` DISABLE KEYS */;
INSERT INTO `interfaces` VALUES (11,'DSC5401 Interface','DSC','Read Write');
/*!40000 ALTER TABLE `interfaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bwired_devices`
--

DROP TABLE IF EXISTS `bwired_devices`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `bwired_devices` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `description` varchar(64) default NULL,
  `devicename` varchar(32) default NULL,
  `deviceid` int(11) default NULL,
  `devicelabel` varchar(16) default NULL,
  `value` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;


--
-- Table structure change for table `_usage`
--
ALTER TABLE `power_usage` CHANGE `usage` `consumption` bigint(20) default NULL;
ALTER TABLE `gas_usage` CHANGE `usage` `consumption` bigint(20) default NULL;
ALTER TABLE `water_usage` CHANGE `usage` `consumption` bigint(20) default NULL;

--
-- Table structure for table `devicetypes`
--

DROP TABLE IF EXISTS `devicetypes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `devicetypes` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(32) default NULL,
  `description` varchar(32) default NULL,
  `type` varchar(32) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `devicetypes`
--

LOCK TABLES `devicetypes` WRITE;
/*!40000 ALTER TABLE `devicetypes` DISABLE KEYS */;
INSERT INTO `devicetypes` VALUES (1,'Marmitek DS90','Door/Window Sensor','X10Security'),(2,'Marmitek LW10G','Lamp Module','X10'),(3,'Marmitek LD11','Dimmer Module','X10'),(4,'Marmitek MS13E M','Motion Sensor','X10'),(5,'Marmitek MS13E L','Light Sensor','X10'),(6,'Xanura SAX35','I/O Actor','A10'),(7,'Oregon THGR238N','Temp/Hygro Sensor','Oregon'),(8,'Oregon UV138','UV Light Sensor','Oregon'),(9,'RFXPwr Module','Power Usage Sensor','RFXCom'),(10,'Marmitek TM13','Wireless Tranceiver','X10'),(11,'HDDTemp Item','Temp Monitor','HDDTemp'),(12,'Oregon THR128','Temp Sensor','Oregon'),(13,'Sony AIBO ERS-7 ','Robot Dog','AIBO'),(14,'APC SmartUPS1000','Power Supply','UPS'),(15,'Dallas DS18S20','Temp Sensor','1-Wire'),(16,'Dallas Rain Gauge','Rain Gauge','1-Wire'),(17,'Marmitek SD90','Smoke Detector','X10Security'),(18,'Bluetooth Device','Phone','Bluetooth'),(19,'ITHO ECO Fan','Central Ventilation','Weeder'),(20,'RFXPulse Gas','Gas Usage Sensor','RFXCom'),(21,'RFXPulse Water','Water Usage Sensor','RFXCom'),(22,'Oregon BWR102','Digital Bathroom Scale','Oregon'),(23,'Oregon GR101','Digital Bathroom Scale','Oregon'),(24,'Oregon THR128','Temp Sensor','Oregon'),(25,'Oregon THx138','Temp Sensor','Oregon'),(26,'Oregon THGR810','Temp/Hygro Sensor','Oregon'),(27,'Plugwise Circle','Zigbee Appliance Module','Plugwise'),(28,'Plugwise Circle+','Zigbee Appliance Module','Plugwise'),(29,'KAKU Doorbell','Wireless Doorbell','X10'),(30,'Oregon THN132N','Temp Sensor','Oregon'),(31,'Oregon THWR288','Temp Sensor','Oregon'),(32,'Oregon BTHR918N','Baro/Temp/Hygro Sensor','Oregon'),(33,'Oregon BTHR968','Baro/Temp/Hygro Sensor','Oregon'),(34,'Marmitek AD10','Switch Module','X10'),(35,'Marmitek LM12','Lamp Module','X10'),(36,'Marmitek AM12','Appliance Module','X10'),(38,'Oregon PCR800','Rain Gauge','Oregon'),(39,'Oregon RTGR328N','Temp/Hygro/Time Sensor','Oregon'),(40,'DSC PIR','Motion Sensor','DSC'),(41,'DSC Contact','Door/Window Sensor','DSC'),(42,'DSC Smoke','Smoke Detector','DSC');
/*!40000 ALTER TABLE `devicetypes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-05-29  7:26:49
