-- MySQL dump 10.11
--
-- Host: localhost    Database: domotiga
-- ------------------------------------------------------
-- Server version	5.0.75-0ubuntu10.2

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

DROP TABLE IF EXISTS `zwave_devices`;
ALTER TABLE bwired_devices RENAME devices_bwired;

--
-- Table structure for table `devices_zwave`
--

DROP TABLE IF EXISTS `devices_zwave`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `devices_zwave` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `nodeid` int(11) default NULL,
  `typebasic` int(11) default NULL,
  `typegeneric` int(11) default NULL,
  `typespecific` int(11) default NULL,
  `capabilities` int(11) default NULL,
  `security` int(11) default NULL,
  `sleeping` tinyint(1) default NULL,
  `value` varchar(32) default NULL,
  `manufacturer` varchar(64) default NULL,
  `model` varchar(64) default NULL,
  `version` varchar(32) default NULL,
  `neighbor` varchar(32) default NULL,
  `speed` varchar(32) default NULL,
  `classes` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `settings_zwave`
--

DROP TABLE IF EXISTS `settings_zwave`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_zwave` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `serialport` varchar(32) default NULL,
  `baudrate` varchar(32) default NULL,
  `reloadnodes` tinyint(1) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_zwave`
--

LOCK TABLES `settings_zwave` WRITE;
/*!40000 ALTER TABLE `settings_zwave` DISABLE KEYS */;
INSERT INTO `settings_zwave` VALUES (0,0,'/dev/ttyUSB4','115200',0,0),(1,0,'/dev/ttyUSB10','115200',0,0);
/*!40000 ALTER TABLE `settings_zwave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `version` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `db` varchar(16) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES (1,'0.1.166'),(2,'0.1.167'),(3,'0.1.168'),(4,'0.1.169'),(5,'0.1.170'),(6,'0.1.171'),(7,'0.1.172');
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--
DROP TABLE IF EXISTS `menu`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `menu` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(32) default NULL,
  `item` varchar(32) default NULL,
  `menu` int(11) default NULL,
  `position` int(11) default NULL,
  `icon` varchar(32) default NULL,
  `enabled` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'Home','FHome',1,1,'home.png',1),(2,'Control','FControl',1,2,'control.png',1),(3,'Floorplan','FFloorplans',1,6,'floorplan.png',1),(4,'Locations','FLocations',1,4,'locations.png',0),(5,'Climate','FClimate',1,5,'climate.png',1),(6,'Security','FSecurity',1,6,'security.png',1),(7,'HVAC','FHVAC',1,7,'hvac.png',1),(8,'Energy','FEnergy',1,8,'energy.png',1),(9,'Logfiles','FLogfiles',1,9,'logs.png',1),(10,'Phone','FPhone',1,1,'phone.png',1),(11,'Captures','FCaptures',2,2,'captures.png',1),(12,'Barcodes','FBarcodes',2,3,'stock.png',1),(13,'Camera','FCamera',2,4,'camera.png',1),(14,'Weather','FWeather',2,5,'weather.png',1),(15,'e-mail','FEmail',2,6,'email.png',0),(16,'News','FNews',2,7,'news.png',1),(17,'TV Guide','FTVGuide',2,8,'tvguide.png',0),(18,'Debug','FDebug',3,1,'system.png',1),(19,'Statistics','FServerStats',3,2,'serverstats.png',1),(20,'Events','FEvents',3,3,'events.png',1),(21,'Devices','FDevices',1,2,'devices.png',1),(22,'DSC Panel','FDSC',2,10,'security.png',1);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_names`
--

DROP TABLE IF EXISTS `menu_names`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `menu_names` (
  `id` int(11) NOT NULL,
  `name` varchar(32) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `menu_names`
--

LOCK TABLES `menu_names` WRITE;
/*!40000 ALTER TABLE `menu_names` DISABLE KEYS */;
INSERT INTO `menu_names` VALUES (1,'Main'),(2,'Extra'),(3,'System');
/*!40000 ALTER TABLE `menu_names` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-10-11 18:17:55
