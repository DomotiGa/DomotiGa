-- MySQL dump 10.11
--
-- Host: localhost    Database: domotiga
-- ------------------------------------------------------
-- Server version	5.0.51a-3ubuntu5.3

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
-- Current Database: `domotiga`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `domotiga` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `domotiga`;

--
-- Table structure for table `capture_camera0`
--

DROP TABLE IF EXISTS `capture_camera0`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `capture_camera0` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `stamp` datetime default NULL,
  `image` longblob,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `capture_camera0`
--

LOCK TABLES `capture_camera0` WRITE;
/*!40000 ALTER TABLE `capture_camera0` DISABLE KEYS */;
INSERT INTO `capture_camera0` VALUES (1,'2008-11-05 12:42:30',''),(2,'2008-11-13 16:55:05',''),(3,'2008-11-13 16:57:06',''),(4,'2008-11-13 17:16:06',''),(5,'2008-11-13 17:25:05',''),(6,'2008-11-13 19:30:17',''),(7,'2008-11-13 19:30:20',''),(8,'2008-11-13 19:30:22',''),(9,'2008-11-13 19:30:25',''),(10,'2008-11-13 19:30:27',''),(11,'2008-11-14 00:21:06',''),(12,'2008-11-14 09:33:06',''),(13,'2008-11-14 13:30:07',''),(14,'2008-11-15 13:38:29',''),(15,'2008-11-15 13:46:29','');
/*!40000 ALTER TABLE `capture_camera0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `capture_camera1`
--

DROP TABLE IF EXISTS `capture_camera1`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `capture_camera1` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `stamp` datetime default NULL,
  `image` longblob,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `capture_camera1`
--

LOCK TABLES `capture_camera1` WRITE;
/*!40000 ALTER TABLE `capture_camera1` DISABLE KEYS */;
/*!40000 ALTER TABLE `capture_camera1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `capture_camera2`
--

DROP TABLE IF EXISTS `capture_camera2`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `capture_camera2` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `stamp` datetime default NULL,
  `image` longblob,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `capture_camera2`
--

LOCK TABLES `capture_camera2` WRITE;
/*!40000 ALTER TABLE `capture_camera2` DISABLE KEYS */;
/*!40000 ALTER TABLE `capture_camera2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `capture_camera3`
--

DROP TABLE IF EXISTS `capture_camera3`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `capture_camera3` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `stamp` datetime default NULL,
  `image` longblob,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `capture_camera3`
--

LOCK TABLES `capture_camera3` WRITE;
/*!40000 ALTER TABLE `capture_camera3` DISABLE KEYS */;
/*!40000 ALTER TABLE `capture_camera3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `category` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(100) NOT NULL default 'unknown',
  `target` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Milch',1);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cdr`
--

DROP TABLE IF EXISTS `cdr`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cdr` (
  `calldate` datetime NOT NULL default '0000-00-00 00:00:00',
  `clid` varchar(80) default NULL,
  `src` varchar(80) default NULL,
  `dst` varchar(80) default NULL,
  `dcontext` varchar(80) default NULL,
  `channel` varchar(80) default NULL,
  `dstchannel` varchar(80) default NULL,
  `lastapp` varchar(80) default NULL,
  `lastdata` varchar(80) default NULL,
  `duration` int(11) NOT NULL default '0',
  `billsec` int(11) NOT NULL default '0',
  `disposition` varchar(45) default NULL,
  `amaflags` int(11) NOT NULL default '0',
  `accountcode` varchar(20) default NULL,
  `userfield` varchar(255) default NULL,
  `uniqueid` varchar(32) default NULL,
  `id` bigint(20) unsigned NOT NULL auto_increment,
  PRIMARY KEY  (`id`),
  KEY `calldate` (`calldate`),
  KEY `dst` (`dst`),
  KEY `accountcode` (`accountcode`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `cdr`
--

LOCK TABLES `cdr` WRITE;
/*!40000 ALTER TABLE `cdr` DISABLE KEYS */;
INSERT INTO `cdr` VALUES ('2008-09-03 16:31:05','0123401234','0123401234','s','incoming','Zap/3-1','Zap/1-1','Dial','Zap/1',92,0,'NO ANSWER',3,'',NULL,NULL,5),('2008-09-03 18:59:54','0123401234','0123401234','s','incoming','Zap/3-1','Zap/1-1','Dial','Zap/1',772,753,'ANSWERED',3,'',NULL,NULL,11),('2008-09-30 20:49:55','0000000000','0000000000','s','incoming','Zap/3-1','Zap/1-1','Dial','Zap/1',31,0,'NO ANSWER',3,'',NULL,NULL,38);
/*!40000 ALTER TABLE `cdr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `contacts` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(32) default NULL,
  `address` varchar(32) default NULL,
  `zipcode` varchar(11) default NULL,
  `city` varchar(32) default NULL,
  `country` varchar(32) default NULL,
  `phoneno` varchar(32) default NULL,
  `mobileno` varchar(32) default NULL,
  `email` varchar(32) default NULL,
  `cidphone` varchar(32) default NULL,
  `cidmobile` varchar(32) default NULL,
  `birthday` datetime default NULL,
  `holidaycard` tinyint(1) default NULL,
  `comments` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES (1,'Ron Klinkien','','1234AB','Sliedrecht','The Netherlands','0123401234','','cyberjunkynl@gmail.com','Author','','1966-09-15 00:00:00',1,'I have to Donate some to this guy!');
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deviceblacklist`
--

DROP TABLE IF EXISTS `deviceblacklist`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `deviceblacklist` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `address` varchar(64) default NULL,
  `comments` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `deviceblacklist`
--

LOCK TABLES `deviceblacklist` WRITE;
/*!40000 ALTER TABLE `deviceblacklist` DISABLE KEYS */;
INSERT INTO `deviceblacklist` VALUES (1,'/dev/sg0','Unknown hddtool device');
/*!40000 ALTER TABLE `deviceblacklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `devices` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(32) default NULL,
  `address` varchar(64) default NULL,
  `user` int(11) default NULL,
  `module` int(11) default NULL,
  `location` int(11) default NULL,
  `value` varchar(32) default NULL,
  `value2` varchar(32) default NULL,
  `label` varchar(32) default NULL,
  `label2` varchar(32) default NULL,
  `onicon` varchar(32) default NULL,
  `officon` varchar(32) default NULL,
  `interface` int(11) default NULL,
  `firstseen` datetime default NULL,
  `lastseen` datetime default NULL,
  `enabled` tinyint(1) default NULL,
  `hide` tinyint(1) default NULL,
  `log` tinyint(1) default NULL,
  `groups` varchar(128) default NULL,
  `graph` tinyint(1) default NULL,
  `batterystatus` varchar(32) default NULL,
  `tampered` tinyint(1) default NULL,
  `comments` text,
  `valuerrddsname` varchar(32) default NULL,
  `value2rrddsname` varchar(32) default NULL,
  `valuerrdtype` varchar(32) default NULL,
  `value2rrdtype` varchar(32) default NULL,
  `switchable` tinyint(1) default NULL,
  `dimable` tinyint(1) default NULL,
  `x` int(11) default NULL,
  `y` int(11) default NULL,
  `floorplan` int(11) default NULL,
  `lastchanged` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
INSERT INTO `devices` VALUES (1,'Porch Light','O01',0,10,6,'On','','','','light-on.png','light-off.png',2,'2008-09-06 13:56:53','2008-11-16 18:00:00',1,0,1,'|All Lights|Outside|',0,'',NULL,'','','','','',1,0,72,121,2,'2008-11-16 18:00:00'),(2,'Power Usage','00F0',0,9,13,'4314711','520','','Wh','energy.png','energy.png',1,'2008-08-31 22:39:31','2008-11-17 22:52:32',-1,0,0,'|Energy|',-1,'',NULL,'Measures power usage.','','watt','','GAUGE',0,0,0,0,1,'2008-11-17 22:52:32'),(3,'Laundryroom Light','E04',0,2,11,'Off','','','','light-on.png','light-off.png',2,'2008-08-26 23:12:16','2008-10-16 20:04:51',-1,0,-1,'|All Lights|',0,'',NULL,'None','','','','',-1,0,0,0,1,NULL),(4,'Hobbyroom Light','E03',0,2,12,'Off','','','','light-on.png','light-off.png',2,'2008-08-26 22:20:11','2008-10-16 20:04:52',-1,0,-1,'|All Lights|',0,'',NULL,'None','','','','',0,-1,259,182,3,NULL),(5,'UV Sensor','32',0,8,8,'11','Dangerous','Level','','sun.png','sun.png',1,'2008-08-27 00:19:48','2008-11-17 22:50:29',-1,0,-1,'|Outside|',0,'low',NULL,' Battery replaced at 2008-11-11 20:45:52 ','','','','',0,0,0,0,1,'2008-11-16 22:14:36'),(6,'Livingroom Sensor','47',0,7,2,'21.1','48','°C','%','temp.gif','temp.gif',1,'2008-07-31 13:35:50','2008-11-17 22:52:28',-1,0,0,'|Climate|Humidity|Temperature|',0,'',NULL,'','','','','',0,0,217,194,2,'2008-11-17 22:30:36'),(7,'Serverroom Sensor','CE',0,7,10,'23.1','46','°C','%','temp.gif','temp.gif',1,'2008-07-31 13:36:13','2008-11-17 22:52:21',-1,0,0,'|Climate|Humidity|Temperature|',0,'',NULL,'','','','','',0,0,0,0,1,'2008-11-17 22:30:15'),(8,'Bedroom Sensor','E6',0,7,9,'21.7','56','°C','%','temp.gif','temp.gif',1,'2008-07-31 13:35:54','2008-11-17 22:52:36',-1,0,0,'|Climate|Humidity|Temperature|',0,'',NULL,'','','','','',0,0,132,140,3,'2008-11-17 22:29:51'),(9,'Bathroom Sensor','68',0,7,3,'18.6','70','°C','%','temp.gif','temp.gif',1,'2008-07-31 13:36:06','2008-11-17 22:52:42',-1,0,0,'|Climate|Humidity|Temperature|',0,'',NULL,'','','','','',0,0,0,0,1,'2008-11-17 22:29:57'),(10,'Fridge Sensor','05',0,7,7,'7.4','61','°C','%','temp.gif','temp.gif',1,'2008-09-10 10:47:29','2008-11-17 22:52:14',-1,0,0,'|Climate|Humidity|Temperature|',-1,'',NULL,'','temp','humid','GAUGE','GAUGE',0,0,0,0,1,'2008-11-17 22:52:14'),(11,'Outside Sensor','0A',0,7,8,'6.7','85','°C','%','temp.gif','temp.gif',1,'2008-09-09 16:00:58','2008-11-17 22:52:34',-1,0,0,'|Climate|Humidity|Outside|Temperature|',-1,'',NULL,'','temp','humid','GAUGE','GAUGE',0,0,0,0,1,'2008-11-17 22:52:34'),(12,'Doorbell','D01',NULL,6,6,'','','','','button.gif','button.gif',2,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,0,0,'|Doors|',0,'',NULL,'http://www.waakzaamwonen.nl/catalog/pdf/sax35.pdf',NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,NULL),(13,'Harddrive /dev/sda','/dev/sda',0,11,10,'38','','°C','','hd.png','hd.png',4,'2008-09-06 14:01:08','2008-11-17 23:15:57',-1,0,-1,'|Server|',-1,'',NULL,'','temp','','GAUGE','',0,0,122,125,6,'2008-11-17 22:29:37'),(14,'Neighbour Sensor1','10',0,7,15,'13.9','56','°C','%','question.png','question.png',1,'2008-09-15 20:17:43','0000-00-00 00:00:00',1,1,0,'|',0,'low',NULL,'Neighbours device','','','','',0,0,0,0,1,NULL),(15,'Neighbour Sensor2','02',NULL,12,15,'0','','°C','','question.png','question.png',1,'2008-09-15 21:39:17','0000-00-00 00:00:00',1,1,0,'|',0,'low',NULL,'Neighbours device','','','','',0,0,0,0,1,NULL),(16,'Rakker','192.168.100.4',0,13,2,'Sleeping','','','','aibo.gif','aibo.gif',5,'2008-09-06 14:01:07','2008-11-15 16:15:20',-1,0,-1,'|',0,'',NULL,'','','','','',0,0,0,0,1,NULL),(17,'SmartUPS','smartups1000',0,14,10,'Online','224.9','','Volt','ups.gif','ups.gif',6,'2008-09-07 19:55:53','2008-11-13 14:55:17',-1,0,-1,'|Server|',0,'',NULL,'','','','','',0,0,0,0,1,'2008-11-13 14:55:17'),(18,'Kitchen Motion Sensor','M01',0,4,7,'Motion','','','','motion-on.gif','motion-off.gif',1,'2008-08-23 23:34:19','2008-11-06 18:24:15',-1,0,-1,'|Motion|Security|',0,'',NULL,'','','','','',0,0,115,62,2,'2008-11-06 18:23:56'),(19,'Serverroom Temp','4D0000004FC78A26',0,15,10,'25.18','','°C','','temp.gif','temp.gif',3,'2008-08-26 14:37:29','2008-11-17 22:34:29',-1,0,0,'|Server|',0,'',NULL,'','','','','',0,0,0,0,1,'2008-11-17 22:33:29'),(20,'Rainfall Sensor','',NULL,16,8,'','','mm','','rain.png','rain.png',3,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,0,0,'|Outside|',0,'',NULL,'','','','','',0,0,0,0,1,NULL),(21,'Smoke Detector','C0CF54',0,17,5,'Idle','','','','smoke.png','smoke.png',1,'0000-00-00 00:00:00','0000-00-00 00:00:00',-1,0,-1,'|',0,'',NULL,'','','','','',0,0,0,0,1,NULL),(22,'Mailbox Sensor','323D34',0,1,6,'Open','Secure','','','mail-on.png','mail-off.png',1,'2008-09-03 20:27:09','2008-11-17 15:48:18',-1,0,-1,'|',0,'',NULL,'','','','','',0,0,0,0,1,NULL),(23,'Front Door Sensor','D2DDD4',0,1,6,'Closed','Secure','','','door-open.png','door-closed.png',1,'2008-09-03 20:11:50','2008-11-17 15:48:17',-1,0,-1,'|Doors|Security|',0,'',NULL,'','','','','',0,0,0,0,1,NULL),(24,'Kitchen Light Sensor','M02',0,5,7,'Light','','','','motion-on.gif','motion-off.gif',1,'2008-08-26 19:47:49','2008-11-06 18:23:50',-1,0,-1,'|Motion|',0,'',NULL,'','','','','',0,0,229,94,2,'2008-11-06 18:23:50'),(25,'Hot Water','150008013A024910',0,15,17,'24.25','','°C','','temp.gif','temp.gif',3,'2008-09-08 16:02:43','2008-11-15 13:46:31',-1,0,-1,'|HVAC|',-1,'',NULL,'','temp','','GAUGE','',0,0,0,0,1,'2008-11-15 13:46:31'),(26,'Heating Output','7A0008014A6BC310',0,15,17,'62.68','','°C','','temp.gif','temp.gif',3,'2008-09-08 16:02:44','2008-11-17 22:33:31',-1,0,0,'|HVAC|',0,'',NULL,'','','','','',0,0,0,0,1,'2008-11-17 22:33:31'),(27,'Toilet Motion Sensor','M03',0,4,4,'No Motion','','','','motion-on.gif','motion-off.gif',1,'2008-08-29 19:37:49','2008-11-16 21:30:17',-1,0,-1,'|Motion|Security|',0,'',NULL,'','','','','',0,0,0,0,1,'2008-11-16 21:30:17'),(28,'Toilet Light Sensor','M04',0,5,4,'Dark','','','','motion-on.gif','motion-off.gif',1,'2008-08-29 19:40:57','2008-11-16 21:29:31',-1,0,-1,'|',0,'',NULL,'','','','','',0,0,0,0,1,'2008-11-16 21:29:31'),(29,'My Phone','00:12:D1:A8:B6:20',2,18,16,'','NotReach','','','bt.png','bt.png',8,'0000-00-00 00:00:00','2008-11-15 16:20:20',-1,0,-1,'|Proximity|',0,'',NULL,'','','','','',0,0,0,0,1,NULL),(30,'House Ventilation','A',0,19,7,'','','Speed','','fan-on.gif','fan-off.gif',9,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,0,0,'|HVAC|',0,'',NULL,'','','','','',0,0,0,0,1,NULL);
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `devicetypes`
--

LOCK TABLES `devicetypes` WRITE;
/*!40000 ALTER TABLE `devicetypes` DISABLE KEYS */;
INSERT INTO `devicetypes` VALUES (1,'Marmitek DS90','Door/Window Sensor','X10Security'),(2,'Marmitek LW10G','Lamp Module','X10'),(3,'Marmitek LD11','Lamp Module','X10'),(4,'Marmitek MS13E M','Motion Sensor','X10'),(5,'Marmitek MS13E L','Light Sensor','X10'),(6,'Xanura SAX35','I/O Actor','A10'),(7,'Oregon THGR238N','Temp/Hygro Sensor','Oregon'),(8,'Oregon UV138','UV Light Sensor','Oregon'),(9,'RFXPwr Module','Power Usage Sensor','RFXCom'),(10,'HWG TM751','Wireless Tranceiver','X10'),(11,'HDDTemp Item','Temp Monitor','HDDTemp'),(12,'Oregon THR128','Temp Sensor','Oregon'),(13,'Sony AIBO ERS-7 ','Robot Dog','AIBO'),(14,'APC SmartUPS1000','Power Supply','UPS'),(15,'Dallas DS18S20','Temp Sensor','1-Wire'),(16,'Dallas Rain Gauge','Rain Gauge','1-Wire'),(17,'Marmitek SD90','Smoke Detector','X10Security'),(18,'HP iPAQ 514','Phone','Bluetooth'),(19,'ITHO Fan on WTSSR','Central Ventilation','Weeder');
/*!40000 ALTER TABLE `devicetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `floors`
--

DROP TABLE IF EXISTS `floors`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `floors` (
  `floor` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(32) default NULL,
  `image` varchar(32) default NULL,
  PRIMARY KEY  (`floor`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `floors`
--

LOCK TABLES `floors` WRITE;
/*!40000 ALTER TABLE `floors` DISABLE KEYS */;
INSERT INTO `floors` VALUES (1,'',''),(2,'1st Floor','1stfloor.jpg'),(3,'2nd Floor','2ndfloor.jpg'),(4,'3rd Floor',NULL),(6,'Asus eee-box','eeebox.jpg');
/*!40000 ALTER TABLE `floors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalvars`
--

DROP TABLE IF EXISTS `globalvars`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `globalvars` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `var` varchar(64) default NULL,
  `value` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `globalvars`
--

LOCK TABLES `globalvars` WRITE;
/*!40000 ALTER TABLE `globalvars` DISABLE KEYS */;
INSERT INTO `globalvars` VALUES (1,'Second','15'),(2,'Minute','16'),(3,'Hour','23'),(4,'Day','17'),(5,'Month','11'),(6,'Weekday','1'),(7,'Time_Of_Day','evening'),(8,'Year','2008'),(9,'Sunrise','8:50'),(10,'Sunset','17:24'),(11,'Sunrise_Twilight','8:11'),(12,'Sunset_Twilight','18:03'),(13,'Season','fall'),(14,'House_Mode','normal'),(15,'Mode_Set','auto'),(16,'Last_User','admin'),(17,'Mute','T'),(18,'Dark','T'),(19,'Weekend','');
/*!40000 ALTER TABLE `globalvars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `groups` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(32) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'Outside'),(2,'Temperature'),(3,'Humidity'),(4,'Doors'),(5,'Windows'),(6,'All Lights'),(7,'All Units'),(8,'Energy'),(9,'Server'),(10,'Motion'),(12,'HVAC'),(14,'Proximity'),(15,'Climate'),(16,'Security');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interfaces`
--

DROP TABLE IF EXISTS `interfaces`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `interfaces` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(32) default NULL,
  `type` varchar(32) default NULL,
  `mode` varchar(32) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `interfaces`
--

LOCK TABLES `interfaces` WRITE;
/*!40000 ALTER TABLE `interfaces` DISABLE KEYS */;
INSERT INTO `interfaces` VALUES (1,'RFXCom Receiver','A10 X10 Oregon KAKU','Read'),(2,'Xanura CTX35','A10 X10','Read Write'),(3,'Midon TEMP08','One-Wire','Read Write'),(4,'HDDTemp Socket','Build-in Module','Read'),(5,'AIBO Socket','Build-in Module','Read'),(6,'UPS Socket','Build-in Module','Read'),(7,'Heyu X10','A10 X10','Write'),(8,'Bluetooth Dongle','Bluetooth','Read Write'),(9,'Weeder I/O Bus','Weeder','Read Write');
/*!40000 ALTER TABLE `interfaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `locations` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(32) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,''),(2,'Livingroom'),(3,'Bathroom'),(4,'Toilet'),(5,'Hallway'),(6,'Frontdoor'),(7,'Kitchen'),(8,'Garden'),(9,'Master Bedroom'),(10,'Serverroom'),(11,'Laundryroom'),(12,'Hobbyroom'),(13,'MeterCabinet'),(15,'Neighbours'),(16,'Mobile'),(17,'Boiler');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newsfeeds`
--

DROP TABLE IF EXISTS `newsfeeds`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `newsfeeds` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(32) default NULL,
  `url` varchar(64) default NULL,
  `description` text,
  `enabled` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `newsfeeds`
--

LOCK TABLES `newsfeeds` WRITE;
/*!40000 ALTER TABLE `newsfeeds` DISABLE KEYS */;
INSERT INTO `newsfeeds` VALUES (1,'Slashdot','http://rss.slashdot.org/Slashdot/slashdot','News for Nerds. Stuff that Matters.',1),(2,'Tweakers','http://gathering.tweakers.net/rss/list_activetopics','Gathering of Tweakers.',1);
/*!40000 ALTER TABLE `newsfeeds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notify`
--

DROP TABLE IF EXISTS `notify`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `notify` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `keyword` varchar(64) default NULL,
  `type` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `notify`
--

LOCK TABLES `notify` WRITE;
/*!40000 ALTER TABLE `notify` DISABLE KEYS */;
INSERT INTO `notify` VALUES (1,'Frank Zappa',5),(3,'Indonesia',6),(4,'A15',8),(5,'Sliedrecht',7),(7,'Tom Hanks',4);
/*!40000 ALTER TABLE `notify` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifytypes`
--

DROP TABLE IF EXISTS `notifytypes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `notifytypes` (
  `type` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(32) default NULL,
  PRIMARY KEY  (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `notifytypes`
--

LOCK TABLES `notifytypes` WRITE;
/*!40000 ALTER TABLE `notifytypes` DISABLE KEYS */;
INSERT INTO `notifytypes` VALUES (1,'e-mail'),(2,'newsfeed'),(3,'tv program'),(4,'movie'),(5,'music'),(6,'earthquake'),(7,'weather'),(8,'traffic');
/*!40000 ALTER TABLE `notifytypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `power_usage`
--

DROP TABLE IF EXISTS `power_usage`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `power_usage` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `counter` bigint(20) default NULL,
  `stamp` datetime default NULL,
  `watt` bigint(20) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2346 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `power_usage`
--

LOCK TABLES `power_usage` WRITE;
/*!40000 ALTER TABLE `power_usage` DISABLE KEYS */;
INSERT INTO `power_usage` VALUES (1,4213752,'2008-11-05 13:35:00',0),(2,4213772,'2008-11-05 13:40:00',20),(3,4213965,'2008-11-05 14:25:00',193),(4,4214017,'2008-11-05 14:30:00',52),(5,4214152,'2008-11-05 14:45:00',135),(6,4214754,'2008-11-05 17:05:00',602),(7,4214775,'2008-11-05 17:10:00',21),(8,4214793,'2008-11-05 17:15:00',18),(9,4214814,'2008-11-05 17:20:00',21),(10,4214835,'2008-11-05 17:25:00',21),(11,4214852,'2008-11-05 17:30:00',17),(12,4214873,'2008-11-05 17:45:00',21),(13,4214935,'2008-11-05 17:50:00',62),(14,4214956,'2008-11-05 17:55:00',21),(15,4214977,'2008-11-05 18:00:00',21),(16,4214999,'2008-11-05 18:05:00',22),(17,4215018,'2008-11-05 18:10:00',19),(18,4215040,'2008-11-05 18:15:00',22),(19,4215151,'2008-11-05 18:20:00',111),(20,4215170,'2008-11-05 18:25:00',19),(21,4215191,'2008-11-05 18:30:00',21),(22,4215212,'2008-11-05 18:35:00',21),(23,4215236,'2008-11-05 18:40:00',24),(24,4215430,'2008-11-05 18:45:00',194),(25,4215614,'2008-11-05 18:50:00',184),(26,4215893,'2008-11-05 18:55:00',279),(27,4215954,'2008-11-05 19:00:00',61),(28,4216061,'2008-11-05 19:05:00',107),(29,4216217,'2008-11-05 19:10:00',156),(30,4216347,'2008-11-05 19:15:00',130),(31,4216403,'2008-11-05 19:20:00',56),(32,4216465,'2008-11-05 19:25:00',62),(33,4216527,'2008-11-05 19:30:00',62),(34,4216582,'2008-11-05 19:35:00',55),(35,4216637,'2008-11-05 19:40:00',55),(36,4217164,'2008-11-05 21:05:00',527),(37,4217190,'2008-11-05 21:10:00',26),(38,4217248,'2008-11-05 21:20:00',58),(39,4217304,'2008-11-05 21:30:00',56),(40,4217333,'2008-11-05 21:35:00',29),(41,4217534,'2008-11-05 22:45:00',201),(42,4218030,'2008-11-05 23:15:00',496),(43,4218069,'2008-11-05 23:20:00',39),(44,4219038,'2008-11-05 23:45:00',969),(45,4219074,'2008-11-05 23:50:00',36),(46,4219107,'2008-11-05 23:55:00',33),(47,4219125,'2008-11-06 00:10:00',18),(48,4220078,'2008-11-06 00:40:00',953),(49,4220107,'2008-11-06 00:45:00',29),(50,4220127,'2008-11-06 00:50:00',20),(51,4220198,'2008-11-06 01:05:00',71),(52,4220223,'2008-11-06 01:10:00',25),(53,4220251,'2008-11-06 01:15:00',28),(54,4220278,'2008-11-06 01:20:00',27),(55,4220303,'2008-11-06 01:25:00',25),(56,4220325,'2008-11-06 01:30:00',22),(57,4220347,'2008-11-06 01:35:00',22),(58,4220368,'2008-11-06 01:40:00',21),(59,4220387,'2008-11-06 01:45:00',19),(60,4220408,'2008-11-06 01:50:00',21),(61,4220430,'2008-11-06 01:55:00',22),(62,4220451,'2008-11-06 02:00:00',21),(63,4220470,'2008-11-06 02:05:00',19),(64,4220492,'2008-11-06 02:10:00',22),(65,4220513,'2008-11-06 02:15:00',21),(66,4220532,'2008-11-06 02:20:00',19),(67,4220554,'2008-11-06 02:25:00',22),(68,4220658,'2008-11-06 02:30:00',104),(69,4220679,'2008-11-06 02:35:00',21),(70,4220698,'2008-11-06 02:40:00',19),(71,4220720,'2008-11-06 02:45:00',22),(72,4220741,'2008-11-06 02:50:00',21),(73,4220762,'2008-11-06 02:55:00',21),(74,4220781,'2008-11-06 03:00:00',19),(75,4220802,'2008-11-06 03:05:00',21),(76,4220824,'2008-11-06 03:10:00',22),(77,4220847,'2008-11-06 03:15:00',23),(78,4220875,'2008-11-06 03:20:00',28),(79,4220898,'2008-11-06 03:25:00',23),(80,4220931,'2008-11-06 03:30:00',33),(81,4220955,'2008-11-06 03:35:00',24),(82,4220980,'2008-11-06 03:40:00',25),(83,4221001,'2008-11-06 03:45:00',21),(84,4221018,'2008-11-06 03:50:00',17),(85,4221041,'2008-11-06 03:55:00',23),(86,4221063,'2008-11-06 04:00:00',22),(87,4221084,'2008-11-06 04:05:00',21),(88,4221103,'2008-11-06 04:10:00',19),(89,4221124,'2008-11-06 04:15:00',21),(90,4221146,'2008-11-06 04:20:00',22),(91,4221167,'2008-11-06 04:25:00',21),(92,4221186,'2008-11-06 04:30:00',19),(93,4221207,'2008-11-06 04:35:00',21),(94,4221229,'2008-11-06 04:40:00',22),(95,4221248,'2008-11-06 04:45:00',19),(96,4221269,'2008-11-06 04:50:00',21),(97,4221291,'2008-11-06 04:55:00',22),(98,4221312,'2008-11-06 05:00:00',21),(99,4221331,'2008-11-06 05:05:00',19),(100,4221352,'2008-11-06 05:10:00',21),(101,4221373,'2008-11-06 05:15:00',21),(102,4221394,'2008-11-06 05:20:00',21),(103,4221414,'2008-11-06 05:25:00',20),(104,4221441,'2008-11-06 05:30:00',27),(105,4221467,'2008-11-06 05:35:00',26),(106,4221494,'2008-11-06 05:40:00',27),(107,4221522,'2008-11-06 05:45:00',28),(108,4221549,'2008-11-06 05:50:00',27),(109,4221571,'2008-11-06 05:55:00',22),(110,4221588,'2008-11-06 06:00:00',17),(111,4221611,'2008-11-06 06:05:00',23),(112,4221632,'2008-11-06 06:10:00',21),(113,4221711,'2008-11-06 06:15:00',79),(114,4221764,'2008-11-06 06:20:00',53),(115,4221783,'2008-11-06 06:25:00',19),(116,4221807,'2008-11-06 06:30:00',24),(117,4221826,'2008-11-06 06:35:00',19),(118,4221847,'2008-11-06 06:40:00',21),(119,4221868,'2008-11-06 06:45:00',21),(120,4221889,'2008-11-06 06:50:00',21),(121,4221908,'2008-11-06 06:55:00',19),(122,4221930,'2008-11-06 07:00:00',22),(123,4221952,'2008-11-06 07:05:00',22),(124,4221973,'2008-11-06 07:10:00',21),(125,4221996,'2008-11-06 07:15:00',23),(126,4222019,'2008-11-06 07:20:00',23),(127,4222043,'2008-11-06 07:25:00',24),(128,4222077,'2008-11-06 07:30:00',34),(129,4222113,'2008-11-06 07:35:00',36),(130,4222140,'2008-11-06 07:40:00',27),(131,4222169,'2008-11-06 07:45:00',29),(132,4222194,'2008-11-06 07:50:00',25),(133,4222218,'2008-11-06 07:55:00',24),(134,4222248,'2008-11-06 08:00:00',30),(135,4222272,'2008-11-06 08:05:00',24),(136,4222293,'2008-11-06 08:10:00',21),(137,4222314,'2008-11-06 08:15:00',21),(138,4222335,'2008-11-06 08:20:00',21),(139,4222354,'2008-11-06 08:25:00',19),(140,4222375,'2008-11-06 08:30:00',21),(141,4222396,'2008-11-06 08:35:00',21),(142,4222444,'2008-11-06 08:55:00',48),(143,4222495,'2008-11-06 09:00:00',51),(144,4222516,'2008-11-06 09:05:00',21),(145,4222657,'2008-11-06 09:40:00',141),(146,4222678,'2008-11-06 09:45:00',21),(147,4222698,'2008-11-06 09:50:00',20),(148,4222717,'2008-11-06 09:55:00',19),(149,4222742,'2008-11-06 10:00:00',25),(150,4222772,'2008-11-06 10:05:00',30),(151,4222799,'2008-11-06 10:10:00',27),(152,4222823,'2008-11-06 10:15:00',24),(153,4222847,'2008-11-06 10:20:00',24),(154,4222957,'2008-11-06 10:25:00',110),(155,4222975,'2008-11-06 10:30:00',18),(156,4222996,'2008-11-06 10:35:00',21),(157,4223017,'2008-11-06 10:40:00',21),(158,4223037,'2008-11-06 10:45:00',20),(159,4223056,'2008-11-06 10:50:00',19),(160,4223077,'2008-11-06 10:55:00',21),(161,4223097,'2008-11-06 11:00:00',20),(162,4223118,'2008-11-06 11:05:00',21),(163,4223137,'2008-11-06 11:10:00',19),(164,4223157,'2008-11-06 11:15:00',20),(165,4223178,'2008-11-06 11:20:00',21),(166,4223196,'2008-11-06 11:25:00',18),(167,4223217,'2008-11-06 11:30:00',21),(168,4223238,'2008-11-06 11:35:00',21),(169,4223258,'2008-11-06 11:40:00',20),(170,4223277,'2008-11-06 11:45:00',19),(171,4223297,'2008-11-06 11:50:00',20),(172,4223318,'2008-11-06 11:55:00',21),(173,4223339,'2008-11-06 12:00:00',21),(174,4223357,'2008-11-06 12:05:00',18),(175,4223378,'2008-11-06 12:10:00',21),(176,4223406,'2008-11-06 12:15:00',28),(177,4223431,'2008-11-06 12:20:00',25),(178,4223459,'2008-11-06 12:25:00',28),(179,4223485,'2008-11-06 12:30:00',26),(180,4223512,'2008-11-06 12:35:00',27),(181,4223531,'2008-11-06 12:40:00',19),(182,4223552,'2008-11-06 12:45:00',21),(183,4223573,'2008-11-06 12:50:00',21),(184,4223594,'2008-11-06 12:55:00',21),(185,4223612,'2008-11-06 13:00:00',18),(186,4223633,'2008-11-06 13:05:00',21),(187,4223637,'2008-11-06 13:10:00',4),(188,4223673,'2008-11-06 13:15:00',36),(189,4223693,'2008-11-06 13:20:00',20),(190,4223714,'2008-11-06 13:25:00',21),(191,4223733,'2008-11-06 13:30:00',19),(192,4223758,'2008-11-06 13:35:00',25),(193,4223924,'2008-11-06 13:40:00',166),(194,4224122,'2008-11-06 13:45:00',198),(195,4224303,'2008-11-06 13:50:00',181),(196,4224502,'2008-11-06 14:00:00',199),(197,4224902,'2008-11-06 14:15:00',400),(198,4225001,'2008-11-06 14:30:00',99),(199,4225050,'2008-11-06 14:35:00',49),(200,4225444,'2008-11-06 15:05:00',394),(201,4225477,'2008-11-06 15:10:00',33),(202,4225588,'2008-11-06 15:30:00',111),(203,4225615,'2008-11-06 15:35:00',27),(204,4225637,'2008-11-06 15:40:00',22),(205,4225667,'2008-11-06 15:45:00',30),(206,4225699,'2008-11-06 15:50:00',32),(207,4225988,'2008-11-06 16:35:00',289),(208,4226112,'2008-11-06 17:00:00',124),(209,4226138,'2008-11-06 17:05:00',26),(210,4226160,'2008-11-06 17:10:00',22),(211,4226181,'2008-11-06 17:15:00',21),(212,4226202,'2008-11-06 17:20:00',21),(213,4226222,'2008-11-06 17:25:00',20),(214,4226241,'2008-11-06 17:30:00',19),(215,4226261,'2008-11-06 17:35:00',20),(216,4226287,'2008-11-06 17:50:00',26),(217,4226340,'2008-11-06 17:55:00',53),(218,4226361,'2008-11-06 18:00:00',21),(219,4226380,'2008-11-06 18:05:00',19),(220,4226401,'2008-11-06 18:10:00',21),(221,4226422,'2008-11-06 18:15:00',21),(222,4226443,'2008-11-06 18:20:00',21),(223,4226590,'2008-11-06 18:25:00',147),(224,4226760,'2008-11-06 18:30:00',170),(225,4226950,'2008-11-06 18:35:00',190),(226,4227104,'2008-11-06 18:40:00',154),(227,4227433,'2008-11-06 18:55:00',329),(228,4227572,'2008-11-06 19:00:00',139),(229,4227640,'2008-11-06 19:05:00',68),(230,4227707,'2008-11-06 19:10:00',67),(231,4227774,'2008-11-06 19:15:00',67),(232,4227834,'2008-11-06 19:20:00',60),(233,4227912,'2008-11-06 19:25:00',78),(234,4227990,'2008-11-06 19:30:00',78),(235,4228056,'2008-11-06 19:35:00',66),(236,4228123,'2008-11-06 19:40:00',67),(237,4228186,'2008-11-06 19:45:00',63),(238,4228244,'2008-11-06 19:50:00',58),(239,4228291,'2008-11-06 19:55:00',47),(240,4228344,'2008-11-06 20:00:00',53),(241,4228375,'2008-11-06 20:05:00',31),(242,4228396,'2008-11-06 20:10:00',21),(243,4228413,'2008-11-06 20:15:00',17),(244,4228436,'2008-11-06 20:20:00',23),(245,4228457,'2008-11-06 20:25:00',21),(246,4228476,'2008-11-06 20:30:00',19),(247,4228497,'2008-11-06 20:35:00',21),(248,4228518,'2008-11-06 20:40:00',21),(249,4228539,'2008-11-06 20:45:00',21),(250,4228558,'2008-11-06 20:50:00',19),(251,4228577,'2008-11-06 20:55:00',19),(252,4228601,'2008-11-06 21:00:00',24),(253,4228622,'2008-11-06 21:05:00',21),(254,4228641,'2008-11-06 21:10:00',19),(255,4228668,'2008-11-06 21:15:00',27),(256,4228696,'2008-11-06 21:20:00',28),(257,4228721,'2008-11-06 21:25:00',25),(258,4228749,'2008-11-06 21:30:00',28),(259,4228776,'2008-11-06 21:35:00',27),(260,4228798,'2008-11-06 21:40:00',22),(261,4228817,'2008-11-06 21:45:00',19),(262,4228838,'2008-11-06 21:50:00',21),(263,4228860,'2008-11-06 21:55:00',22),(264,4228881,'2008-11-06 22:00:00',21),(265,4228900,'2008-11-06 22:05:00',19),(266,4228922,'2008-11-06 22:10:00',22),(267,4228943,'2008-11-06 22:15:00',21),(268,4228962,'2008-11-06 22:20:00',19),(269,4228981,'2008-11-06 22:25:00',19),(270,4229005,'2008-11-06 22:30:00',24),(271,4229026,'2008-11-06 22:35:00',21),(272,4229046,'2008-11-06 22:40:00',20),(273,4229067,'2008-11-06 22:45:00',21),(274,4229172,'2008-11-06 22:50:00',105),(275,4229191,'2008-11-06 22:55:00',19),(276,4229212,'2008-11-06 23:00:00',21),(277,4229234,'2008-11-06 23:05:00',22),(278,4229253,'2008-11-06 23:10:00',19),(279,4229274,'2008-11-06 23:15:00',21),(280,4229295,'2008-11-06 23:20:00',21),(281,4229316,'2008-11-06 23:25:00',21),(282,4229342,'2008-11-06 23:30:00',26),(283,4229368,'2008-11-06 23:35:00',26),(284,4229396,'2008-11-06 23:40:00',28),(285,4229423,'2008-11-06 23:45:00',27),(286,4229455,'2008-11-06 23:50:00',32),(287,4229484,'2008-11-06 23:55:00',29),(288,4229513,'2008-11-07 00:00:00',29),(289,4229616,'2008-11-07 00:20:00',103),(290,4229742,'2008-11-07 00:40:00',126),(291,4229881,'2008-11-07 01:05:00',139),(292,4229911,'2008-11-07 01:10:00',30),(293,4229940,'2008-11-07 01:15:00',29),(294,4229969,'2008-11-07 01:20:00',29),(295,4229996,'2008-11-07 01:25:00',27),(296,4230025,'2008-11-07 01:30:00',29),(297,4230051,'2008-11-07 01:35:00',26),(298,4230070,'2008-11-07 01:40:00',19),(299,4230091,'2008-11-07 01:45:00',21),(300,4230119,'2008-11-07 01:50:00',28),(301,4230148,'2008-11-07 01:55:00',29),(302,4230173,'2008-11-07 02:00:00',25),(303,4230201,'2008-11-07 02:05:00',28),(304,4230228,'2008-11-07 02:10:00',27),(305,4230250,'2008-11-07 02:15:00',22),(306,4230270,'2008-11-07 02:20:00',20),(307,4230291,'2008-11-07 02:25:00',21),(308,4230313,'2008-11-07 02:30:00',22),(309,4230414,'2008-11-07 02:35:00',101),(310,4230436,'2008-11-07 02:40:00',22),(311,4230457,'2008-11-07 02:45:00',21),(312,4230479,'2008-11-07 02:50:00',22),(313,4230498,'2008-11-07 02:55:00',19),(314,4230520,'2008-11-07 03:00:00',22),(315,4230541,'2008-11-07 03:05:00',21),(316,4230563,'2008-11-07 03:10:00',22),(317,4230582,'2008-11-07 03:15:00',19),(318,4230603,'2008-11-07 03:20:00',21),(319,4230625,'2008-11-07 03:25:00',22),(320,4230644,'2008-11-07 03:30:00',19),(321,4230666,'2008-11-07 03:35:00',22),(322,4230687,'2008-11-07 03:40:00',21),(323,4230709,'2008-11-07 03:45:00',22),(324,4230726,'2008-11-07 03:50:00',17),(325,4230750,'2008-11-07 03:55:00',24),(326,4230771,'2008-11-07 04:00:00',21),(327,4230790,'2008-11-07 04:05:00',19),(328,4230818,'2008-11-07 04:10:00',28),(329,4230844,'2008-11-07 04:15:00',26),(330,4230872,'2008-11-07 04:20:00',28),(331,4230899,'2008-11-07 04:25:00',27),(332,4230927,'2008-11-07 04:30:00',28),(333,4230948,'2008-11-07 04:35:00',21),(334,4230971,'2008-11-07 04:40:00',23),(335,4230984,'2008-11-07 04:45:00',13),(336,4231012,'2008-11-07 04:50:00',28),(337,4231034,'2008-11-07 04:55:00',22),(338,4231053,'2008-11-07 05:00:00',19),(339,4231075,'2008-11-07 05:05:00',22),(340,4231096,'2008-11-07 05:10:00',21),(341,4231114,'2008-11-07 05:15:00',18),(342,4231137,'2008-11-07 05:20:00',23),(343,4231159,'2008-11-07 05:25:00',22),(344,4231180,'2008-11-07 05:30:00',21),(345,4231200,'2008-11-07 05:35:00',20),(346,4231221,'2008-11-07 05:40:00',21),(347,4231242,'2008-11-07 05:45:00',21),(348,4231262,'2008-11-07 05:50:00',20),(349,4231283,'2008-11-07 05:55:00',21),(350,4231304,'2008-11-07 06:00:00',21),(351,4231326,'2008-11-07 06:05:00',22),(352,4231347,'2008-11-07 06:10:00',21),(353,4231424,'2008-11-07 06:15:00',77),(354,4231470,'2008-11-07 06:20:00',46),(355,4231491,'2008-11-07 06:25:00',21),(356,4231514,'2008-11-07 06:30:00',23),(357,4231543,'2008-11-07 06:35:00',29),(358,4231570,'2008-11-07 06:40:00',27),(359,4231598,'2008-11-07 06:45:00',28),(360,4231622,'2008-11-07 06:50:00',24),(361,4231647,'2008-11-07 06:55:00',25),(362,4231669,'2008-11-07 07:00:00',22),(363,4231691,'2008-11-07 07:05:00',22),(364,4231712,'2008-11-07 07:10:00',21),(365,4231735,'2008-11-07 07:15:00',23),(366,4231758,'2008-11-07 07:20:00',23),(367,4231779,'2008-11-07 07:25:00',21),(368,4231800,'2008-11-07 07:30:00',21),(369,4231821,'2008-11-07 07:35:00',21),(370,4231842,'2008-11-07 07:40:00',21),(371,4231861,'2008-11-07 07:45:00',19),(372,4231881,'2008-11-07 07:50:00',20),(373,4231902,'2008-11-07 07:55:00',21),(374,4231923,'2008-11-07 08:00:00',21),(375,4231942,'2008-11-07 08:05:00',19),(376,4231963,'2008-11-07 08:10:00',21),(377,4231985,'2008-11-07 08:15:00',22),(378,4232004,'2008-11-07 08:20:00',19),(379,4232026,'2008-11-07 08:25:00',22),(380,4232048,'2008-11-07 08:30:00',22),(381,4232069,'2008-11-07 08:35:00',21),(382,4232087,'2008-11-07 08:40:00',18),(383,4232108,'2008-11-07 08:45:00',21),(384,4232129,'2008-11-07 08:50:00',21),(385,4232157,'2008-11-07 08:55:00',28),(386,4232182,'2008-11-07 09:00:00',25),(387,4232213,'2008-11-07 09:05:00',31),(388,4232242,'2008-11-07 09:10:00',29),(389,4232280,'2008-11-07 09:15:00',38),(390,4232312,'2008-11-07 09:20:00',32),(391,4232337,'2008-11-07 09:25:00',25),(392,4232373,'2008-11-07 09:30:00',36),(393,4232406,'2008-11-07 09:35:00',33),(394,4232442,'2008-11-07 09:40:00',36),(395,4232479,'2008-11-07 09:45:00',37),(396,4232513,'2008-11-07 09:50:00',34),(397,4232657,'2008-11-07 09:55:00',144),(398,4232714,'2008-11-07 10:00:00',57),(399,4232755,'2008-11-07 10:05:00',41),(400,4232787,'2008-11-07 10:10:00',32),(401,4232808,'2008-11-07 10:15:00',21),(402,4232829,'2008-11-07 10:20:00',21),(403,4232849,'2008-11-07 10:25:00',20),(404,4232868,'2008-11-07 10:30:00',19),(405,4232888,'2008-11-07 10:35:00',20),(406,4232909,'2008-11-07 10:40:00',21),(407,4232927,'2008-11-07 10:45:00',18),(408,4232948,'2008-11-07 10:50:00',21),(409,4232969,'2008-11-07 10:55:00',21),(410,4232989,'2008-11-07 11:00:00',20),(411,4233008,'2008-11-07 11:05:00',19),(412,4233028,'2008-11-07 11:10:00',20),(413,4233054,'2008-11-07 11:15:00',26),(414,4233082,'2008-11-07 11:20:00',28),(415,4233106,'2008-11-07 11:25:00',24),(416,4233133,'2008-11-07 11:30:00',27),(417,4233160,'2008-11-07 11:35:00',27),(418,4233180,'2008-11-07 11:40:00',20),(419,4233198,'2008-11-07 11:45:00',18),(420,4233221,'2008-11-07 11:50:00',23),(421,4233241,'2008-11-07 11:55:00',20),(422,4233257,'2008-11-07 12:00:00',16),(423,4233280,'2008-11-07 12:05:00',23),(424,4233301,'2008-11-07 12:10:00',21),(425,4233319,'2008-11-07 12:15:00',18),(426,4233340,'2008-11-07 12:20:00',21),(427,4233361,'2008-11-07 12:25:00',21),(428,4233381,'2008-11-07 12:30:00',20),(429,4233400,'2008-11-07 12:35:00',19),(430,4233421,'2008-11-07 12:40:00',21),(431,4233442,'2008-11-07 12:45:00',21),(432,4233462,'2008-11-07 12:50:00',20),(433,4233481,'2008-11-07 12:55:00',19),(434,4233502,'2008-11-07 13:00:00',21),(435,4233523,'2008-11-07 13:05:00',21),(436,4233541,'2008-11-07 13:10:00',18),(437,4233562,'2008-11-07 13:15:00',21),(438,4233583,'2008-11-07 13:20:00',21),(439,4233603,'2008-11-07 13:25:00',20),(440,4233622,'2008-11-07 13:30:00',19),(441,4233647,'2008-11-07 13:35:00',25),(442,4233677,'2008-11-07 13:40:00',30),(443,4233702,'2008-11-07 13:45:00',25),(444,4233746,'2008-11-07 13:50:00',44),(445,4233841,'2008-11-07 13:55:00',95),(446,4233863,'2008-11-07 14:00:00',22),(447,4233881,'2008-11-07 14:05:00',18),(448,4233902,'2008-11-07 14:10:00',21),(449,4233923,'2008-11-07 14:15:00',21),(450,4233943,'2008-11-07 14:20:00',20),(451,4233962,'2008-11-07 14:25:00',19),(452,4233983,'2008-11-07 14:30:00',21),(453,4234004,'2008-11-07 14:35:00',21),(454,4234022,'2008-11-07 14:40:00',18),(455,4234043,'2008-11-07 14:45:00',21),(456,4234064,'2008-11-07 14:50:00',21),(457,4234083,'2008-11-07 14:55:00',19),(458,4234104,'2008-11-07 15:00:00',21),(459,4234333,'2008-11-07 15:55:00',229),(460,4234388,'2008-11-07 16:05:00',55),(461,4234413,'2008-11-07 16:10:00',25),(462,4234440,'2008-11-07 16:15:00',27),(463,4234462,'2008-11-07 16:20:00',22),(464,4234482,'2008-11-07 16:25:00',20),(465,4234501,'2008-11-07 16:30:00',19),(466,4234522,'2008-11-07 16:35:00',21),(467,4234564,'2008-11-07 16:45:00',42),(468,4234582,'2008-11-07 16:50:00',18),(469,4234603,'2008-11-07 16:55:00',21),(470,4234624,'2008-11-07 17:00:00',21),(471,4234642,'2008-11-07 17:05:00',18),(472,4234663,'2008-11-07 17:10:00',21),(473,4234743,'2008-11-07 17:30:00',80),(474,4234764,'2008-11-07 17:35:00',21),(475,4234783,'2008-11-07 17:40:00',19),(476,4234895,'2008-11-07 17:45:00',112),(477,4234916,'2008-11-07 17:50:00',21),(478,4234937,'2008-11-07 17:55:00',21),(479,4234955,'2008-11-07 18:00:00',18),(480,4234977,'2008-11-07 18:05:00',22),(481,4234998,'2008-11-07 18:10:00',21),(482,4235026,'2008-11-07 18:15:00',28),(483,4235051,'2008-11-07 18:20:00',25),(484,4235079,'2008-11-07 18:25:00',28),(485,4235114,'2008-11-07 18:30:00',35),(486,4235175,'2008-11-07 18:35:00',61),(487,4235276,'2008-11-07 18:40:00',101),(488,4235332,'2008-11-07 18:45:00',56),(489,4235388,'2008-11-07 18:50:00',56),(490,4235452,'2008-11-07 18:55:00',64),(491,4235502,'2008-11-07 19:00:00',50),(492,4235551,'2008-11-07 19:05:00',49),(493,4235609,'2008-11-07 19:10:00',58),(494,4235653,'2008-11-07 19:15:00',44),(495,4235699,'2008-11-07 19:20:00',46),(496,4235755,'2008-11-07 19:25:00',56),(497,4235797,'2008-11-07 19:30:00',42),(498,4235825,'2008-11-07 19:35:00',28),(499,4235846,'2008-11-07 19:40:00',21),(500,4235867,'2008-11-07 19:45:00',21),(501,4235886,'2008-11-07 19:50:00',19),(502,4235908,'2008-11-07 19:55:00',22),(503,4235929,'2008-11-07 20:00:00',21),(504,4235950,'2008-11-07 20:05:00',21),(505,4235969,'2008-11-07 20:10:00',19),(506,4235988,'2008-11-07 20:15:00',19),(507,4236017,'2008-11-07 20:20:00',29),(508,4236043,'2008-11-07 20:25:00',26),(509,4236070,'2008-11-07 20:30:00',27),(510,4236098,'2008-11-07 20:35:00',28),(511,4236122,'2008-11-07 20:40:00',24),(512,4236146,'2008-11-07 20:45:00',24),(513,4236167,'2008-11-07 20:50:00',21),(514,4236189,'2008-11-07 20:55:00',22),(515,4236208,'2008-11-07 21:00:00',19),(516,4236229,'2008-11-07 21:05:00',21),(517,4236251,'2008-11-07 21:10:00',22),(518,4236272,'2008-11-07 21:15:00',21),(519,4236291,'2008-11-07 21:20:00',19),(520,4236313,'2008-11-07 21:25:00',22),(521,4236334,'2008-11-07 21:30:00',21),(522,4236355,'2008-11-07 21:35:00',21),(523,4236375,'2008-11-07 21:40:00',20),(524,4236465,'2008-11-07 21:45:00',90),(525,4236501,'2008-11-07 21:50:00',36),(526,4236520,'2008-11-07 21:55:00',19),(527,4236542,'2008-11-07 22:00:00',22),(528,4236563,'2008-11-07 22:05:00',21),(529,4236585,'2008-11-07 22:10:00',22),(530,4236604,'2008-11-07 22:15:00',19),(531,4236625,'2008-11-07 22:20:00',21),(532,4236647,'2008-11-07 22:25:00',22),(533,4236668,'2008-11-07 22:30:00',21),(534,4236691,'2008-11-07 22:35:00',23),(535,4236720,'2008-11-07 22:40:00',29),(536,4236748,'2008-11-07 22:45:00',28),(537,4236773,'2008-11-07 22:50:00',25),(538,4236801,'2008-11-07 22:55:00',28),(539,4236826,'2008-11-07 23:00:00',25),(540,4236847,'2008-11-07 23:05:00',21),(541,4236866,'2008-11-07 23:10:00',19),(542,4236888,'2008-11-07 23:15:00',22),(543,4236909,'2008-11-07 23:20:00',21),(544,4236931,'2008-11-07 23:25:00',22),(545,4236946,'2008-11-07 23:30:00',15),(546,4236972,'2008-11-07 23:35:00',26),(547,4236993,'2008-11-07 23:40:00',21),(548,4237012,'2008-11-07 23:45:00',19),(549,4237034,'2008-11-07 23:50:00',22),(550,4237055,'2008-11-07 23:55:00',21),(551,4237077,'2008-11-08 00:00:00',22),(552,4237096,'2008-11-08 00:05:00',19),(553,4237117,'2008-11-08 00:10:00',21),(554,4237139,'2008-11-08 00:15:00',22),(555,4237158,'2008-11-08 00:20:00',19),(556,4237180,'2008-11-08 00:25:00',22),(557,4237201,'2008-11-08 00:30:00',21),(558,4237223,'2008-11-08 00:35:00',22),(559,4237242,'2008-11-08 00:40:00',19),(560,4237263,'2008-11-08 00:45:00',21),(561,4237285,'2008-11-08 00:50:00',22),(562,4237309,'2008-11-08 00:55:00',24),(563,4237335,'2008-11-08 01:00:00',26),(564,4237364,'2008-11-08 01:05:00',29),(565,4237391,'2008-11-08 01:10:00',27),(566,4237416,'2008-11-08 01:15:00',25),(567,4237442,'2008-11-08 01:20:00',26),(568,4237463,'2008-11-08 01:25:00',21),(569,4237563,'2008-11-08 01:30:00',100),(570,4237589,'2008-11-08 01:35:00',26),(571,4237606,'2008-11-08 01:40:00',17),(572,4237632,'2008-11-08 01:45:00',26),(573,4237653,'2008-11-08 01:50:00',21),(574,4237673,'2008-11-08 01:55:00',20),(575,4237695,'2008-11-08 02:00:00',22),(576,4237716,'2008-11-08 02:05:00',21),(577,4237733,'2008-11-08 02:10:00',17),(578,4237757,'2008-11-08 02:15:00',24),(579,4237778,'2008-11-08 02:20:00',21),(580,4237800,'2008-11-08 02:25:00',22),(581,4237819,'2008-11-08 02:30:00',19),(582,4237841,'2008-11-08 02:35:00',22),(583,4237862,'2008-11-08 02:40:00',21),(584,4237883,'2008-11-08 02:45:00',21),(585,4237903,'2008-11-08 02:50:00',20),(586,4237924,'2008-11-08 02:55:00',21),(587,4237946,'2008-11-08 03:00:00',22),(588,4237965,'2008-11-08 03:05:00',19),(589,4237986,'2008-11-08 03:10:00',21),(590,4238008,'2008-11-08 03:15:00',22),(591,4238036,'2008-11-08 03:20:00',28),(592,4238062,'2008-11-08 03:25:00',26),(593,4238087,'2008-11-08 03:30:00',25),(594,4238117,'2008-11-08 03:35:00',30),(595,4238142,'2008-11-08 03:40:00',25),(596,4238162,'2008-11-08 03:45:00',20),(597,4238186,'2008-11-08 03:50:00',24),(598,4238208,'2008-11-08 03:55:00',22),(599,4238227,'2008-11-08 04:00:00',19),(600,4238248,'2008-11-08 04:05:00',21),(601,4238270,'2008-11-08 04:10:00',22),(602,4238291,'2008-11-08 04:15:00',21),(603,4238311,'2008-11-08 04:20:00',20),(604,4238332,'2008-11-08 04:25:00',21),(605,4238354,'2008-11-08 04:30:00',22),(606,4238373,'2008-11-08 04:35:00',19),(607,4238394,'2008-11-08 04:40:00',21),(608,4238416,'2008-11-08 04:45:00',22),(609,4238438,'2008-11-08 04:50:00',22),(610,4238457,'2008-11-08 04:55:00',19),(611,4238478,'2008-11-08 05:00:00',21),(612,4238500,'2008-11-08 05:05:00',22),(613,4238519,'2008-11-08 05:10:00',19),(614,4238549,'2008-11-08 05:15:00',30),(615,4238647,'2008-11-08 05:20:00',98),(616,4238668,'2008-11-08 05:25:00',21),(617,4238688,'2008-11-08 05:30:00',20),(618,4238709,'2008-11-08 05:35:00',21),(619,4238732,'2008-11-08 05:40:00',23),(620,4238761,'2008-11-08 05:45:00',29),(621,4238786,'2008-11-08 05:50:00',25),(622,4238814,'2008-11-08 05:55:00',28),(623,4238842,'2008-11-08 06:00:00',28),(624,4238866,'2008-11-08 06:05:00',24),(625,4238888,'2008-11-08 06:10:00',22),(626,4238909,'2008-11-08 06:15:00',21),(627,4238928,'2008-11-08 06:20:00',19),(628,4238950,'2008-11-08 06:25:00',22),(629,4238972,'2008-11-08 06:30:00',22),(630,4238993,'2008-11-08 06:35:00',21),(631,4239011,'2008-11-08 06:40:00',18),(632,4239032,'2008-11-08 06:45:00',21),(633,4239053,'2008-11-08 06:50:00',21),(634,4239074,'2008-11-08 06:55:00',21),(635,4239093,'2008-11-08 07:00:00',19),(636,4239114,'2008-11-08 07:05:00',21),(637,4239134,'2008-11-08 07:10:00',20),(638,4239153,'2008-11-08 07:15:00',19),(639,4239174,'2008-11-08 07:20:00',21),(640,4239195,'2008-11-08 07:25:00',21),(641,4239215,'2008-11-08 07:30:00',20),(642,4239234,'2008-11-08 07:35:00',19),(643,4239255,'2008-11-08 07:40:00',21),(644,4239278,'2008-11-08 07:45:00',23),(645,4239300,'2008-11-08 07:50:00',22),(646,4239319,'2008-11-08 07:55:00',19),(647,4239340,'2008-11-08 08:00:00',21),(648,4239361,'2008-11-08 08:05:00',21),(649,4239387,'2008-11-08 08:10:00',26),(650,4239415,'2008-11-08 08:15:00',28),(651,4239442,'2008-11-08 08:20:00',27),(652,4239469,'2008-11-08 08:25:00',27),(653,4239492,'2008-11-08 08:30:00',23),(654,4239513,'2008-11-08 08:35:00',21),(655,4239534,'2008-11-08 08:40:00',21),(656,4239554,'2008-11-08 08:45:00',20),(657,4239573,'2008-11-08 08:50:00',19),(658,4239594,'2008-11-08 08:55:00',21),(659,4239698,'2008-11-08 09:00:00',104),(660,4239717,'2008-11-08 09:05:00',19),(661,4239738,'2008-11-08 09:10:00',21),(662,4239759,'2008-11-08 09:15:00',21),(663,4239781,'2008-11-08 09:20:00',22),(664,4239801,'2008-11-08 09:25:00',20),(665,4239824,'2008-11-08 09:30:00',23),(666,4239847,'2008-11-08 09:35:00',23),(667,4239868,'2008-11-08 09:40:00',21),(668,4239891,'2008-11-08 09:45:00',23),(669,4239914,'2008-11-08 09:50:00',23),(670,4239937,'2008-11-08 09:55:00',23),(671,4239958,'2008-11-08 10:00:00',21),(672,4239981,'2008-11-08 10:05:00',23),(673,4240005,'2008-11-08 10:10:00',24),(674,4240028,'2008-11-08 10:15:00',23),(675,4240049,'2008-11-08 10:20:00',21),(676,4240073,'2008-11-08 10:25:00',24),(677,4240096,'2008-11-08 10:30:00',23),(678,4240124,'2008-11-08 10:35:00',28),(679,4240155,'2008-11-08 10:40:00',31),(680,4240184,'2008-11-08 10:45:00',29),(681,4240214,'2008-11-08 10:50:00',30),(682,4240240,'2008-11-08 10:55:00',26),(683,4240264,'2008-11-08 11:00:00',24),(684,4240284,'2008-11-08 11:05:00',20),(685,4240303,'2008-11-08 11:10:00',19),(686,4240324,'2008-11-08 11:15:00',21),(687,4240345,'2008-11-08 11:20:00',21),(688,4240366,'2008-11-08 11:25:00',21),(689,4240382,'2008-11-08 11:30:00',16),(690,4240405,'2008-11-08 11:35:00',23),(691,4240426,'2008-11-08 11:40:00',21),(692,4240447,'2008-11-08 11:45:00',21),(693,4240466,'2008-11-08 11:50:00',19),(694,4240486,'2008-11-08 11:55:00',20),(695,4240507,'2008-11-08 12:00:00',21),(696,4240526,'2008-11-08 12:05:00',19),(697,4240547,'2008-11-08 12:10:00',21),(698,4240568,'2008-11-08 12:15:00',21),(699,4240589,'2008-11-08 12:20:00',21),(700,4240608,'2008-11-08 12:25:00',19),(701,4240629,'2008-11-08 12:30:00',21),(702,4240649,'2008-11-08 12:35:00',20),(703,4240725,'2008-11-08 12:40:00',76),(704,4240860,'2008-11-08 12:45:00',135),(705,4240902,'2008-11-08 12:50:00',42),(706,4240950,'2008-11-08 12:55:00',48),(707,4240996,'2008-11-08 13:00:00',46),(708,4241041,'2008-11-08 13:05:00',45),(709,4241095,'2008-11-08 13:10:00',54),(710,4241143,'2008-11-08 13:15:00',48),(711,4241184,'2008-11-08 13:20:00',41),(712,4241227,'2008-11-08 13:25:00',43),(713,4241272,'2008-11-08 13:30:00',45),(714,4241310,'2008-11-08 13:35:00',38),(715,4241364,'2008-11-08 13:40:00',54),(716,4241413,'2008-11-08 13:45:14',49),(717,4242398,'2008-11-08 15:40:00',985),(718,4242442,'2008-11-08 15:45:00',44),(719,4242486,'2008-11-08 15:50:00',44),(720,4242525,'2008-11-08 15:55:00',39),(721,4242569,'2008-11-08 16:00:00',44),(722,4242613,'2008-11-08 16:05:00',44),(723,4242656,'2008-11-08 16:10:00',43),(724,4242694,'2008-11-08 16:15:00',38),(725,4242736,'2008-11-08 16:20:00',42),(726,4242779,'2008-11-08 16:25:00',43),(727,4242881,'2008-11-08 16:30:00',102),(728,4242937,'2008-11-08 16:35:00',56),(729,4242960,'2008-11-08 16:40:00',23),(730,4242981,'2008-11-08 16:45:00',21),(731,4243002,'2008-11-08 16:50:00',21),(732,4243020,'2008-11-08 16:55:00',18),(733,4243041,'2008-11-08 17:00:00',21),(734,4243062,'2008-11-08 17:05:00',21),(735,4243081,'2008-11-08 17:10:00',19),(736,4243099,'2008-11-08 17:15:00',18),(737,4243122,'2008-11-08 17:20:00',23),(738,4243143,'2008-11-08 17:25:00',21),(739,4243167,'2008-11-08 17:30:00',24),(740,4243194,'2008-11-08 17:35:00',27),(741,4243221,'2008-11-08 17:40:00',27),(742,4243246,'2008-11-08 17:45:00',25),(743,4243272,'2008-11-08 17:50:00',26),(744,4243294,'2008-11-08 17:55:00',22),(745,4243315,'2008-11-08 18:00:00',21),(746,4243334,'2008-11-08 18:05:00',19),(747,4243354,'2008-11-08 18:10:00',20),(748,4243377,'2008-11-08 18:15:00',23),(749,4243396,'2008-11-08 18:20:00',19),(750,4243418,'2008-11-08 18:25:00',22),(751,4243439,'2008-11-08 18:30:00',21),(752,4243460,'2008-11-08 18:35:00',21),(753,4243480,'2008-11-08 18:40:00',20),(754,4243501,'2008-11-08 18:45:00',21),(755,4243523,'2008-11-08 18:50:00',22),(756,4243544,'2008-11-08 18:55:00',21),(757,4243563,'2008-11-08 19:00:00',19),(758,4243585,'2008-11-08 19:05:00',22),(759,4243606,'2008-11-08 19:10:00',21),(760,4243623,'2008-11-08 19:15:00',17),(761,4243647,'2008-11-08 19:20:00',24),(762,4243668,'2008-11-08 19:25:00',21),(763,4243690,'2008-11-08 19:30:00',22),(764,4243709,'2008-11-08 19:35:00',19),(765,4243731,'2008-11-08 19:40:00',22),(766,4243752,'2008-11-08 19:45:00',21),(767,4243777,'2008-11-08 19:50:00',25),(768,4243803,'2008-11-08 19:55:00',26),(769,4243831,'2008-11-08 20:00:00',28),(770,4243859,'2008-11-08 20:05:00',28),(771,4243884,'2008-11-08 20:10:00',25),(772,4243951,'2008-11-08 20:15:00',67),(773,4244014,'2008-11-08 20:20:00',63),(774,4244036,'2008-11-08 20:25:00',22),(775,4244055,'2008-11-08 20:30:00',19),(776,4244077,'2008-11-08 20:35:00',22),(777,4244098,'2008-11-08 20:40:00',21),(778,4244119,'2008-11-08 20:45:00',21),(779,4244139,'2008-11-08 20:50:00',20),(780,4244160,'2008-11-08 20:55:00',21),(781,4244182,'2008-11-08 21:00:00',22),(782,4244201,'2008-11-08 21:05:00',19),(783,4244222,'2008-11-08 21:10:00',21),(784,4244244,'2008-11-08 21:15:00',22),(785,4244265,'2008-11-08 21:20:00',21),(786,4244284,'2008-11-08 21:25:00',19),(787,4244306,'2008-11-08 21:30:00',22),(788,4244327,'2008-11-08 21:35:00',21),(789,4244347,'2008-11-08 21:40:00',20),(790,4244368,'2008-11-08 21:45:00',21),(791,4244387,'2008-11-08 21:50:00',19),(792,4244411,'2008-11-08 21:55:00',24),(793,4244431,'2008-11-08 22:00:00',20),(794,4244452,'2008-11-08 22:05:00',21),(795,4244474,'2008-11-08 22:10:00',22),(796,4244501,'2008-11-08 22:15:00',27),(797,4244526,'2008-11-08 22:20:00',25),(798,4244552,'2008-11-08 22:25:00',26),(799,4244582,'2008-11-08 22:30:00',30),(800,4244607,'2008-11-08 22:35:00',25),(801,4244631,'2008-11-08 22:40:00',24),(802,4244652,'2008-11-08 22:45:00',21),(803,4244674,'2008-11-08 22:50:00',22),(804,4244693,'2008-11-08 22:55:00',19),(805,4244715,'2008-11-08 23:00:00',22),(806,4244736,'2008-11-08 23:05:00',21),(807,4244755,'2008-11-08 23:10:00',19),(808,4244777,'2008-11-08 23:15:00',22),(809,4244798,'2008-11-08 23:20:00',21),(810,4244819,'2008-11-08 23:25:00',21),(811,4244838,'2008-11-08 23:30:00',19),(812,4244860,'2008-11-08 23:35:00',22),(813,4244881,'2008-11-08 23:40:00',21),(814,4244902,'2008-11-08 23:45:00',21),(815,4244921,'2008-11-08 23:50:00',19),(816,4244943,'2008-11-08 23:55:00',22),(817,4245049,'2008-11-09 00:00:00',106),(818,4245068,'2008-11-09 00:05:00',19),(819,4245089,'2008-11-09 00:10:00',21),(820,4245111,'2008-11-09 00:15:00',22),(821,4245132,'2008-11-09 00:20:00',21),(822,4245151,'2008-11-09 00:25:00',19),(823,4245173,'2008-11-09 00:30:00',22),(824,4245194,'2008-11-09 00:35:00',21),(825,4245222,'2008-11-09 00:40:00',28),(826,4245248,'2008-11-09 00:45:00',26),(827,4245276,'2008-11-09 00:50:00',28),(828,4245303,'2008-11-09 00:55:00',27),(829,4245328,'2008-11-09 01:00:00',25),(830,4245351,'2008-11-09 01:05:00',23),(831,4245372,'2008-11-09 01:10:00',21),(832,4245394,'2008-11-09 01:15:00',22),(833,4245413,'2008-11-09 01:20:00',19),(834,4245434,'2008-11-09 01:25:00',21),(835,4245456,'2008-11-09 01:30:00',22),(836,4245475,'2008-11-09 01:35:00',19),(837,4245497,'2008-11-09 01:40:00',22),(838,4245518,'2008-11-09 01:45:00',21),(839,4245540,'2008-11-09 01:50:00',22),(840,4245559,'2008-11-09 01:55:00',19),(841,4245581,'2008-11-09 02:00:00',22),(842,4245603,'2008-11-09 02:05:00',22),(843,4245624,'2008-11-09 02:10:00',21),(844,4245644,'2008-11-09 02:15:00',20),(845,4245663,'2008-11-09 02:20:00',19),(846,4245687,'2008-11-09 02:25:00',24),(847,4245706,'2008-11-09 02:30:00',19),(848,4245728,'2008-11-09 02:35:00',22),(849,4245749,'2008-11-09 02:40:00',21),(850,4245771,'2008-11-09 02:45:00',22),(851,4245790,'2008-11-09 02:50:00',19),(852,4245814,'2008-11-09 02:55:00',24),(853,4245837,'2008-11-09 03:00:00',23),(854,4245862,'2008-11-09 03:05:00',25),(855,4245891,'2008-11-09 03:10:00',29),(856,4245919,'2008-11-09 03:15:00',28),(857,4245947,'2008-11-09 03:20:00',28),(858,4245971,'2008-11-09 03:25:00',24),(859,4245993,'2008-11-09 03:30:00',22),(860,4246015,'2008-11-09 03:35:00',22),(861,4246036,'2008-11-09 03:40:00',21),(862,4246108,'2008-11-09 03:45:00',72),(863,4246170,'2008-11-09 03:50:00',62),(864,4246192,'2008-11-09 03:55:00',22),(865,4246211,'2008-11-09 04:00:00',19),(866,4246233,'2008-11-09 04:05:00',22),(867,4246254,'2008-11-09 04:10:00',21),(868,4246275,'2008-11-09 04:15:00',21),(869,4246293,'2008-11-09 04:20:00',18),(870,4246316,'2008-11-09 04:25:00',23),(871,4246337,'2008-11-09 04:30:00',21),(872,4246359,'2008-11-09 04:35:00',22),(873,4246378,'2008-11-09 04:40:00',19),(874,4246398,'2008-11-09 04:45:00',20),(875,4246421,'2008-11-09 04:50:00',23),(876,4246440,'2008-11-09 04:55:00',19),(877,4246462,'2008-11-09 05:00:00',22),(878,4246483,'2008-11-09 05:05:00',21),(879,4246505,'2008-11-09 05:10:00',22),(880,4246524,'2008-11-09 05:15:00',19),(881,4246545,'2008-11-09 05:20:00',21),(882,4246567,'2008-11-09 05:25:00',22),(883,4246591,'2008-11-09 05:30:00',24),(884,4246620,'2008-11-09 05:35:00',29),(885,4246648,'2008-11-09 05:40:00',28),(886,4246676,'2008-11-09 05:45:00',28),(887,4246700,'2008-11-09 05:50:00',24),(888,4246723,'2008-11-09 05:55:00',23),(889,4246745,'2008-11-09 06:00:00',22),(890,4246766,'2008-11-09 06:05:00',21),(891,4246785,'2008-11-09 06:10:00',19),(892,4246807,'2008-11-09 06:15:00',22),(893,4246828,'2008-11-09 06:20:00',21),(894,4246847,'2008-11-09 06:25:00',19),(895,4246869,'2008-11-09 06:30:00',22),(896,4246890,'2008-11-09 06:35:00',21),(897,4246909,'2008-11-09 06:40:00',19),(898,4246929,'2008-11-09 06:45:00',20),(899,4246950,'2008-11-09 06:50:00',21),(900,4246969,'2008-11-09 06:55:00',19),(901,4246990,'2008-11-09 07:00:00',21),(902,4247011,'2008-11-09 07:05:00',21),(903,4247029,'2008-11-09 07:10:00',18),(904,4247052,'2008-11-09 07:15:00',23),(905,4247071,'2008-11-09 07:20:00',19),(906,4247091,'2008-11-09 07:25:00',20),(907,4247112,'2008-11-09 07:30:00',21),(908,4247133,'2008-11-09 07:35:00',21),(909,4247152,'2008-11-09 07:40:00',19),(910,4247172,'2008-11-09 07:45:00',20),(911,4247193,'2008-11-09 07:50:00',21),(912,4247298,'2008-11-09 07:55:00',105),(913,4247326,'2008-11-09 08:00:00',28),(914,4247354,'2008-11-09 08:05:00',28),(915,4247381,'2008-11-09 08:10:00',27),(916,4247405,'2008-11-09 08:15:00',24),(917,4247429,'2008-11-09 08:20:00',24),(918,4247450,'2008-11-09 08:25:00',21),(919,4247469,'2008-11-09 08:30:00',19),(920,4247490,'2008-11-09 08:35:00',21),(921,4247510,'2008-11-09 08:40:00',20),(922,4247531,'2008-11-09 08:45:00',21),(923,4247550,'2008-11-09 08:50:00',19),(924,4247571,'2008-11-09 08:55:00',21),(925,4247592,'2008-11-09 09:00:00',21),(926,4247613,'2008-11-09 09:05:00',21),(927,4247632,'2008-11-09 09:10:00',19),(928,4247654,'2008-11-09 09:15:00',22),(929,4247673,'2008-11-09 09:20:00',19),(930,4247695,'2008-11-09 09:25:00',22),(931,4247718,'2008-11-09 09:30:00',23),(932,4247741,'2008-11-09 09:35:00',23),(933,4247762,'2008-11-09 09:40:00',21),(934,4247786,'2008-11-09 09:45:00',24),(935,4247807,'2008-11-09 09:50:00',21),(936,4247832,'2008-11-09 09:55:00',25),(937,4247853,'2008-11-09 10:00:00',21),(938,4247876,'2008-11-09 10:05:00',23),(939,4247897,'2008-11-09 10:10:00',21),(940,4247923,'2008-11-09 10:15:00',26),(941,4247942,'2008-11-09 10:20:00',19),(942,4247976,'2008-11-09 10:25:00',34),(943,4248006,'2008-11-09 10:30:00',30),(944,4248036,'2008-11-09 10:35:00',30),(945,4248062,'2008-11-09 10:40:00',26),(946,4248090,'2008-11-09 10:45:00',28),(947,4248114,'2008-11-09 10:50:00',24),(948,4248135,'2008-11-09 10:55:00',21),(949,4248158,'2008-11-09 11:00:00',23),(950,4248179,'2008-11-09 11:05:00',21),(951,4248199,'2008-11-09 11:10:00',20),(952,4248218,'2008-11-09 11:15:00',19),(953,4248239,'2008-11-09 11:20:00',21),(954,4248259,'2008-11-09 11:25:00',20),(955,4248278,'2008-11-09 11:30:00',19),(956,4248312,'2008-11-09 11:35:00',34),(957,4248403,'2008-11-09 11:40:00',91),(958,4248424,'2008-11-09 11:45:00',21),(959,4248443,'2008-11-09 11:50:00',19),(960,4248463,'2008-11-09 11:55:00',20),(961,4249768,'2008-11-10 19:45:00',1305),(962,4249768,'2008-11-10 19:50:00',0),(963,4249768,'2008-11-10 19:55:00',0),(964,4249768,'2008-11-10 20:00:00',0),(965,4249768,'2008-11-10 20:05:00',0),(966,4249768,'2008-11-10 20:10:00',0),(967,4262320,'2008-11-11 00:05:00',12552),(968,4262349,'2008-11-11 00:10:00',29),(969,4262461,'2008-11-11 00:30:00',112),(970,4262490,'2008-11-11 00:35:00',29),(971,4262516,'2008-11-11 00:40:00',26),(972,4262544,'2008-11-11 00:45:00',28),(973,4262573,'2008-11-11 00:50:00',29),(974,4262602,'2008-11-11 00:55:00',29),(975,4262628,'2008-11-11 01:00:00',26),(976,4262657,'2008-11-11 01:05:00',29),(977,4262686,'2008-11-11 01:10:00',29),(978,4262715,'2008-11-11 01:15:00',29),(979,4262741,'2008-11-11 01:20:00',26),(980,4262773,'2008-11-11 01:25:00',32),(981,4262809,'2008-11-11 01:30:00',36),(982,4262841,'2008-11-11 01:35:00',32),(983,4262876,'2008-11-11 01:40:00',35),(984,4262911,'2008-11-11 01:45:00',35),(985,4262943,'2008-11-11 01:50:00',32),(986,4262969,'2008-11-11 01:55:00',26),(987,4262998,'2008-11-11 02:00:00',29),(988,4263026,'2008-11-11 02:05:00',28),(989,4263062,'2008-11-11 02:10:00',36),(990,4263087,'2008-11-11 02:15:02',25),(991,4263114,'2008-11-11 02:20:02',27),(992,4263157,'2008-11-11 02:30:00',43),(993,4263165,'2008-11-11 02:35:00',8),(994,4263165,'2008-11-11 02:40:00',0),(995,4263165,'2008-11-11 02:45:00',0),(996,4263165,'2008-11-11 02:50:00',0),(997,4263165,'2008-11-11 02:55:00',0),(998,4263165,'2008-11-11 03:00:00',0),(999,4263165,'2008-11-11 03:05:00',0),(1000,4263165,'2008-11-11 03:10:00',0),(1001,4263427,'2008-11-11 03:15:00',262),(1002,4263448,'2008-11-11 03:20:00',21),(1003,4263469,'2008-11-11 03:25:00',21),(1004,4263489,'2008-11-11 03:30:00',20),(1005,4263513,'2008-11-11 03:35:00',24),(1006,4263544,'2008-11-11 03:40:00',31),(1007,4263569,'2008-11-11 03:45:00',25),(1008,4263596,'2008-11-11 03:50:00',27),(1009,4263623,'2008-11-11 03:55:00',27),(1010,4263646,'2008-11-11 04:00:00',23),(1011,4263663,'2008-11-11 04:05:00',17),(1012,4263686,'2008-11-11 04:10:00',23),(1013,4263708,'2008-11-11 04:15:00',22),(1014,4263729,'2008-11-11 04:20:00',21),(1015,4263748,'2008-11-11 04:25:00',19),(1016,4263769,'2008-11-11 04:30:00',21),(1017,4263790,'2008-11-11 04:35:00',21),(1018,4263812,'2008-11-11 04:40:00',22),(1019,4263831,'2008-11-11 04:45:00',19),(1020,4263852,'2008-11-11 04:50:00',21),(1021,4263873,'2008-11-11 04:55:00',21),(1022,4263892,'2008-11-11 05:00:00',19),(1023,4263913,'2008-11-11 05:05:00',21),(1024,4263934,'2008-11-11 05:10:00',21),(1025,4263956,'2008-11-11 05:15:00',22),(1026,4263975,'2008-11-11 05:20:00',19),(1027,4263996,'2008-11-11 05:25:00',21),(1028,4264017,'2008-11-11 05:30:00',21),(1029,4264038,'2008-11-11 05:35:00',21),(1030,4264057,'2008-11-11 05:40:00',19),(1031,4264083,'2008-11-11 05:45:00',26),(1032,4264111,'2008-11-11 05:50:00',28),(1033,4264134,'2008-11-11 05:55:00',23),(1034,4264164,'2008-11-11 06:00:00',30),(1035,4264191,'2008-11-11 06:05:00',27),(1036,4264215,'2008-11-11 06:10:00',24),(1037,4264232,'2008-11-11 06:15:00',17),(1038,4264256,'2008-11-11 06:20:00',24),(1039,4264277,'2008-11-11 06:25:00',21),(1040,4264297,'2008-11-11 06:30:00',20),(1041,4264318,'2008-11-11 06:35:00',21),(1042,4264337,'2008-11-11 06:40:00',19),(1043,4264361,'2008-11-11 06:45:00',24),(1044,4264380,'2008-11-11 06:50:00',19),(1045,4264399,'2008-11-11 06:55:00',19),(1046,4264509,'2008-11-11 07:00:00',110),(1047,4264531,'2008-11-11 07:05:00',22),(1048,4264550,'2008-11-11 07:10:00',19),(1049,4264573,'2008-11-11 07:15:00',23),(1050,4264599,'2008-11-11 07:20:00',26),(1051,4264637,'2008-11-11 07:25:00',38),(1052,4264667,'2008-11-11 07:30:00',30),(1053,4264696,'2008-11-11 07:35:00',29),(1054,4264727,'2008-11-11 07:40:00',31),(1055,4264750,'2008-11-11 07:45:00',23),(1056,4264768,'2008-11-11 07:50:00',18),(1057,4264787,'2008-11-11 07:55:00',19),(1058,4264817,'2008-11-11 08:00:00',30),(1059,4264842,'2008-11-11 08:05:00',25),(1060,4264869,'2008-11-11 08:10:00',27),(1061,4264896,'2008-11-11 08:15:00',27),(1062,4264922,'2008-11-11 08:20:00',26),(1063,4264941,'2008-11-11 08:25:00',19),(1064,4264962,'2008-11-11 08:30:00',21),(1065,4264982,'2008-11-11 08:35:00',20),(1066,4265003,'2008-11-11 08:40:00',21),(1067,4265022,'2008-11-11 08:45:00',19),(1068,4265042,'2008-11-11 08:50:00',20),(1069,4265063,'2008-11-11 08:55:00',21),(1070,4265082,'2008-11-11 09:00:00',19),(1071,4265103,'2008-11-11 09:05:00',21),(1072,4265123,'2008-11-11 09:10:00',20),(1073,4265144,'2008-11-11 09:15:00',21),(1074,4265163,'2008-11-11 09:20:00',19),(1075,4265183,'2008-11-11 09:25:00',20),(1076,4265204,'2008-11-11 09:30:00',21),(1077,4265225,'2008-11-11 09:35:00',21),(1078,4265243,'2008-11-11 09:40:00',18),(1079,4265264,'2008-11-11 09:45:00',21),(1080,4265285,'2008-11-11 09:50:00',21),(1081,4265303,'2008-11-11 09:55:00',18),(1082,4265324,'2008-11-11 10:00:00',21),(1083,4265345,'2008-11-11 10:05:00',21),(1084,4265366,'2008-11-11 10:10:00',21),(1085,4265392,'2008-11-11 10:15:00',26),(1086,4265419,'2008-11-11 10:20:00',27),(1087,4265446,'2008-11-11 10:25:00',27),(1088,4265473,'2008-11-11 10:30:00',27),(1089,4265497,'2008-11-11 10:35:00',24),(1090,4265507,'2008-11-11 10:40:13',10),(1091,4265538,'2008-11-11 10:45:00',31),(1092,4265556,'2008-11-11 10:50:00',18),(1093,4265662,'2008-11-11 10:55:00',106),(1094,4265682,'2008-11-11 11:00:00',20),(1095,4265703,'2008-11-11 11:05:00',21),(1096,4265722,'2008-11-11 11:10:00',19),(1097,4265742,'2008-11-11 11:15:00',20),(1098,4265763,'2008-11-11 11:20:00',21),(1099,4265784,'2008-11-11 11:25:00',21),(1100,4265802,'2008-11-11 11:30:00',18),(1101,4265823,'2008-11-11 11:35:00',21),(1102,4265843,'2008-11-11 11:40:00',20),(1103,4265862,'2008-11-11 11:45:00',19),(1104,4265880,'2008-11-11 11:50:00',18),(1105,4265903,'2008-11-11 11:55:00',23),(1106,4265924,'2008-11-11 12:00:00',21),(1107,4265942,'2008-11-11 12:05:00',18),(1108,4265963,'2008-11-11 12:10:00',21),(1109,4265984,'2008-11-11 12:15:00',21),(1110,4266002,'2008-11-11 12:20:00',18),(1111,4266024,'2008-11-11 12:25:00',22),(1112,4266053,'2008-11-11 12:30:00',29),(1113,4266080,'2008-11-11 12:35:00',27),(1114,4266104,'2008-11-11 12:40:00',24),(1115,4266131,'2008-11-11 12:45:00',27),(1116,4266157,'2008-11-11 12:50:00',26),(1117,4266181,'2008-11-11 12:55:00',24),(1118,4266210,'2008-11-11 13:00:00',29),(1119,4266396,'2008-11-11 13:05:00',186),(1120,4266561,'2008-11-11 13:10:00',165),(1121,4266647,'2008-11-11 13:15:00',86),(1122,4266673,'2008-11-11 13:20:00',26),(1123,4266700,'2008-11-11 13:25:00',27),(1124,4266894,'2008-11-11 13:30:00',194),(1125,4266958,'2008-11-11 13:35:00',64),(1126,4266990,'2008-11-11 13:40:00',32),(1127,4267028,'2008-11-11 13:45:00',38),(1128,4267059,'2008-11-11 13:50:00',31),(1129,4267096,'2008-11-11 13:55:00',37),(1130,4267140,'2008-11-11 14:00:00',44),(1131,4267167,'2008-11-11 14:05:00',27),(1132,4267196,'2008-11-11 14:10:00',29),(1133,4267222,'2008-11-11 14:15:00',26),(1134,4267252,'2008-11-11 14:20:00',30),(1135,4267286,'2008-11-11 14:25:00',34),(1136,4267316,'2008-11-11 14:30:00',30),(1137,4267356,'2008-11-11 14:35:00',40),(1138,4267393,'2008-11-11 14:40:00',37),(1139,4267441,'2008-11-11 14:45:00',48),(1140,4267471,'2008-11-11 14:50:00',30),(1141,4267513,'2008-11-11 14:55:00',42),(1142,4267576,'2008-11-11 15:00:00',63),(1143,4267622,'2008-11-11 15:05:00',46),(1144,4267666,'2008-11-11 15:10:00',44),(1145,4267694,'2008-11-11 15:15:00',28),(1146,4267720,'2008-11-11 15:20:00',26),(1147,4267739,'2008-11-11 15:25:00',19),(1148,4267851,'2008-11-11 15:30:00',112),(1149,4267871,'2008-11-11 15:35:00',20),(1150,4267892,'2008-11-11 15:40:00',21),(1151,4267911,'2008-11-11 15:45:00',19),(1152,4267932,'2008-11-11 15:50:00',21),(1153,4267953,'2008-11-11 15:55:00',21),(1154,4267973,'2008-11-11 16:00:00',20),(1155,4267992,'2008-11-11 16:05:00',19),(1156,4268013,'2008-11-11 16:10:00',21),(1157,4268030,'2008-11-11 16:15:00',17),(1158,4268053,'2008-11-11 16:20:00',23),(1159,4268072,'2008-11-11 16:25:00',19),(1160,4268095,'2008-11-11 16:30:00',23),(1161,4268116,'2008-11-11 16:35:00',21),(1162,4268132,'2008-11-11 16:40:00',16),(1163,4268155,'2008-11-11 16:45:00',23),(1164,4268176,'2008-11-11 16:50:00',21),(1165,4268202,'2008-11-11 16:55:00',26),(1166,4268227,'2008-11-11 17:00:00',25),(1167,4268254,'2008-11-11 17:05:00',27),(1168,4268281,'2008-11-11 17:10:00',27),(1169,4268305,'2008-11-11 17:15:00',24),(1170,4268328,'2008-11-11 17:20:00',23),(1171,4268348,'2008-11-11 17:25:00',20),(1172,4268369,'2008-11-11 17:30:00',21),(1173,4268388,'2008-11-11 17:35:00',19),(1174,4268408,'2008-11-11 17:40:00',20),(1175,4268429,'2008-11-11 17:45:00',21),(1176,4268450,'2008-11-11 17:50:00',21),(1177,4268468,'2008-11-11 17:55:00',18),(1178,4268489,'2008-11-11 18:00:00',21),(1179,4268508,'2008-11-11 18:05:00',19),(1180,4268530,'2008-11-11 18:10:00',22),(1181,4268551,'2008-11-11 18:15:00',21),(1182,4268572,'2008-11-11 18:20:00',21),(1183,4268597,'2008-11-11 18:25:00',25),(1184,4268709,'2008-11-11 18:35:00',112),(1185,4268770,'2008-11-11 18:40:00',61),(1186,4269130,'2008-11-11 19:00:00',360),(1187,4269197,'2008-11-11 19:05:00',67),(1188,4269277,'2008-11-11 19:10:00',80),(1189,4269358,'2008-11-11 19:15:00',81),(1190,4269437,'2008-11-11 19:20:00',79),(1191,4269504,'2008-11-11 19:25:00',67),(1192,4269570,'2008-11-11 19:30:00',66),(1193,4269627,'2008-11-11 19:35:00',57),(1194,4269699,'2008-11-11 19:40:00',72),(1195,4269756,'2008-11-11 19:45:00',57),(1196,4269809,'2008-11-11 19:50:00',53),(1197,4269880,'2008-11-11 19:55:00',71),(1198,4269986,'2008-11-11 20:00:00',106),(1199,4270090,'2008-11-11 20:05:00',104),(1200,4270391,'2008-11-11 20:10:00',301),(1201,4270691,'2008-11-11 20:15:00',300),(1202,4270956,'2008-11-11 20:20:00',265),(1203,4271018,'2008-11-11 20:25:00',62),(1204,4271071,'2008-11-11 20:30:00',53),(1205,4271121,'2008-11-11 20:35:00',50),(1206,4271197,'2008-11-11 20:40:00',76),(1207,4271344,'2008-11-11 20:45:00',147),(1208,4271644,'2008-11-11 20:50:00',300),(1209,4271942,'2008-11-11 20:55:00',298),(1210,4272071,'2008-11-11 21:00:00',129),(1211,4272119,'2008-11-11 21:05:00',48),(1212,4272222,'2008-11-11 21:15:00',103),(1213,4272319,'2008-11-11 21:30:00',97),(1214,4272345,'2008-11-11 21:35:00',26),(1215,4272374,'2008-11-11 21:40:00',29),(1216,4272404,'2008-11-11 21:45:00',30),(1217,4272433,'2008-11-11 21:50:00',29),(1218,4272460,'2008-11-11 21:55:00',27),(1219,4272574,'2008-11-11 22:15:00',114),(1220,4272641,'2008-11-11 22:25:00',67),(1221,4272745,'2008-11-11 22:40:00',104),(1222,4272780,'2008-11-11 22:45:00',35),(1223,4272806,'2008-11-11 22:50:00',26),(1224,4272835,'2008-11-11 22:55:00',29),(1225,4272951,'2008-11-11 23:00:00',116),(1226,4272980,'2008-11-11 23:05:00',29),(1227,4273006,'2008-11-11 23:10:00',26),(1228,4273035,'2008-11-11 23:15:00',29),(1229,4273065,'2008-11-11 23:20:00',30),(1230,4273091,'2008-11-11 23:25:00',26),(1231,4273120,'2008-11-11 23:30:00',29),(1232,4273149,'2008-11-11 23:35:00',29),(1233,4273178,'2008-11-11 23:40:00',29),(1234,4273205,'2008-11-11 23:45:00',27),(1235,4273211,'2008-11-11 23:50:05',6),(1236,4273263,'2008-11-11 23:55:00',52),(1237,4273293,'2008-11-12 00:00:00',30),(1238,4273320,'2008-11-12 00:05:00',27),(1239,4273349,'2008-11-12 00:10:00',29),(1240,4273386,'2008-11-12 00:15:00',37),(1241,4273454,'2008-11-12 00:25:00',68),(1242,4273486,'2008-11-12 00:30:00',32),(1243,4273637,'2008-11-12 00:55:00',151),(1244,4273725,'2008-11-12 01:10:00',88),(1245,4273750,'2008-11-12 01:15:00',25),(1246,4273771,'2008-11-12 01:20:00',21),(1247,4273793,'2008-11-12 01:25:00',22),(1248,4273814,'2008-11-12 01:30:00',21),(1249,4273833,'2008-11-12 01:35:00',19),(1250,4273855,'2008-11-12 01:40:00',22),(1251,4273877,'2008-11-12 01:45:00',22),(1252,4273898,'2008-11-12 01:50:00',21),(1253,4273918,'2008-11-12 01:55:00',20),(1254,4273937,'2008-11-12 02:00:00',19),(1255,4273961,'2008-11-12 02:05:00',24),(1256,4273983,'2008-11-12 02:10:00',22),(1257,4274012,'2008-11-12 02:15:00',29),(1258,4274040,'2008-11-12 02:20:00',28),(1259,4274068,'2008-11-12 02:25:00',28),(1260,4274093,'2008-11-12 02:30:00',25),(1261,4274118,'2008-11-12 02:35:00',25),(1262,4274140,'2008-11-12 02:40:00',22),(1263,4274159,'2008-11-12 02:45:00',19),(1264,4274181,'2008-11-12 02:50:00',22),(1265,4274292,'2008-11-12 02:55:00',111),(1266,4274314,'2008-11-12 03:00:00',22),(1267,4274333,'2008-11-12 03:05:00',19),(1268,4274355,'2008-11-12 03:10:00',22),(1269,4274376,'2008-11-12 03:15:00',21),(1270,4274398,'2008-11-12 03:20:00',22),(1271,4274417,'2008-11-12 03:25:00',19),(1272,4274439,'2008-11-12 03:30:00',22),(1273,4274460,'2008-11-12 03:35:00',21),(1274,4274480,'2008-11-12 03:40:00',20),(1275,4274501,'2008-11-12 03:45:00',21),(1276,4274523,'2008-11-12 03:50:00',22),(1277,4274544,'2008-11-12 03:55:00',21),(1278,4274564,'2008-11-12 04:00:00',20),(1279,4274583,'2008-11-12 04:05:00',19),(1280,4274607,'2008-11-12 04:10:00',24),(1281,4274634,'2008-11-12 04:15:00',27),(1282,4274657,'2008-11-12 04:20:00',23),(1283,4274688,'2008-11-12 04:25:00',31),(1284,4274716,'2008-11-12 04:30:00',28),(1285,4274740,'2008-11-12 04:35:00',24),(1286,4274764,'2008-11-12 04:40:00',24),(1287,4274786,'2008-11-12 04:45:00',22),(1288,4274807,'2008-11-12 04:50:00',21),(1289,4274827,'2008-11-12 04:55:00',20),(1290,4274848,'2008-11-12 05:00:00',21),(1291,4274868,'2008-11-12 05:05:00',20),(1292,4274892,'2008-11-12 05:10:00',24),(1293,4274911,'2008-11-12 05:15:00',19),(1294,4274933,'2008-11-12 05:20:00',22),(1295,4274954,'2008-11-12 05:25:00',21),(1296,4274973,'2008-11-12 05:30:00',19),(1297,4274995,'2008-11-12 05:35:00',22),(1298,4275016,'2008-11-12 05:40:00',21),(1299,4275038,'2008-11-12 05:45:00',22),(1300,4275058,'2008-11-12 05:50:00',20),(1301,4275078,'2008-11-12 05:55:00',20),(1302,4275102,'2008-11-12 06:00:00',24),(1303,4275122,'2008-11-12 06:05:00',20),(1304,4275145,'2008-11-12 06:10:00',23),(1305,4275169,'2008-11-12 06:15:00',24),(1306,4275193,'2008-11-12 06:20:00',24),(1307,4275222,'2008-11-12 06:25:00',29),(1308,4275253,'2008-11-12 06:30:00',31),(1309,4275294,'2008-11-12 06:35:00',41),(1310,4275337,'2008-11-12 06:40:00',43),(1311,4275370,'2008-11-12 06:45:00',33),(1312,4275397,'2008-11-12 06:50:00',27),(1313,4275453,'2008-11-12 06:55:00',56),(1314,4275531,'2008-11-12 07:00:00',78),(1315,4275552,'2008-11-12 07:05:00',21),(1316,4275573,'2008-11-12 07:10:00',21),(1317,4275594,'2008-11-12 07:15:00',21),(1318,4275613,'2008-11-12 07:20:00',19),(1319,4275634,'2008-11-12 07:25:00',21),(1320,4275655,'2008-11-12 07:30:00',21),(1321,4275676,'2008-11-12 07:35:00',21),(1322,4275695,'2008-11-12 07:40:00',19),(1323,4275716,'2008-11-12 07:45:00',21),(1324,4275737,'2008-11-12 07:50:00',21),(1325,4275753,'2008-11-12 07:55:00',16),(1326,4275776,'2008-11-12 08:00:00',23),(1327,4275797,'2008-11-12 08:05:00',21),(1328,4275818,'2008-11-12 08:10:00',21),(1329,4275837,'2008-11-12 08:15:00',19),(1330,4275858,'2008-11-12 08:20:00',21),(1331,4275879,'2008-11-12 08:25:00',21),(1332,4275900,'2008-11-12 08:30:00',21),(1333,4275924,'2008-11-12 08:35:00',24),(1334,4275950,'2008-11-12 08:40:00',26),(1335,4275977,'2008-11-12 08:45:00',27),(1336,4276004,'2008-11-12 08:50:00',27),(1337,4276031,'2008-11-12 08:55:00',27),(1338,4276053,'2008-11-12 09:00:00',22),(1339,4276074,'2008-11-12 09:05:00',21),(1340,4276093,'2008-11-12 09:10:00',19),(1341,4276114,'2008-11-12 09:15:00',21),(1342,4276135,'2008-11-12 09:20:00',21),(1343,4276154,'2008-11-12 09:25:00',19),(1344,4276175,'2008-11-12 09:30:00',21),(1345,4276196,'2008-11-12 09:35:00',21),(1346,4276217,'2008-11-12 09:40:00',21),(1347,4276236,'2008-11-12 09:45:00',19),(1348,4276240,'2008-11-12 09:50:00',4),(1349,4276278,'2008-11-12 09:55:00',38),(1350,4276297,'2008-11-12 10:00:00',19),(1351,4276317,'2008-11-12 10:05:00',20),(1352,4276338,'2008-11-12 10:10:00',21),(1353,4276359,'2008-11-12 10:15:00',21),(1354,4276378,'2008-11-12 10:20:00',19),(1355,4276399,'2008-11-12 10:25:00',21),(1356,4276420,'2008-11-12 10:30:00',21),(1357,4276441,'2008-11-12 10:35:00',21),(1358,4276458,'2008-11-12 10:40:00',17),(1359,4276482,'2008-11-12 10:45:00',24),(1360,4276533,'2008-11-12 10:50:00',51),(1361,4276621,'2008-11-12 10:55:00',88),(1362,4276645,'2008-11-12 11:00:00',24),(1363,4276672,'2008-11-12 11:05:00',27),(1364,4276698,'2008-11-12 11:10:00',26),(1365,4276717,'2008-11-12 11:15:00',19),(1366,4276737,'2008-11-12 11:20:00',20),(1367,4276758,'2008-11-12 11:25:00',21),(1368,4276779,'2008-11-12 11:30:00',21),(1369,4276798,'2008-11-12 11:35:00',19),(1370,4276817,'2008-11-12 11:40:00',19),(1371,4276840,'2008-11-12 11:45:00',23),(1372,4276861,'2008-11-12 11:50:00',21),(1373,4276879,'2008-11-12 11:55:00',18),(1374,4276900,'2008-11-12 12:00:00',21),(1375,4276921,'2008-11-12 12:05:00',21),(1376,4276938,'2008-11-12 12:10:00',17),(1377,4276961,'2008-11-12 12:15:00',23),(1378,4276982,'2008-11-12 12:20:00',21),(1379,4277003,'2008-11-12 12:25:00',21),(1380,4277022,'2008-11-12 12:30:00',19),(1381,4277041,'2008-11-12 12:35:00',19),(1382,4277065,'2008-11-12 12:40:00',24),(1383,4277086,'2008-11-12 12:45:00',21),(1384,4277105,'2008-11-12 12:50:00',19),(1385,4277126,'2008-11-12 12:55:00',21),(1386,4277151,'2008-11-12 13:00:00',25),(1387,4277176,'2008-11-12 13:05:00',25),(1388,4277204,'2008-11-12 13:10:00',28),(1389,4277231,'2008-11-12 13:15:00',27),(1390,4277258,'2008-11-12 13:20:00',27),(1391,4277280,'2008-11-12 13:25:00',22),(1392,4277297,'2008-11-12 13:30:00',17),(1393,4277322,'2008-11-12 13:35:00',25),(1394,4277343,'2008-11-12 13:40:00',21),(1395,4277361,'2008-11-12 13:45:00',18),(1396,4277382,'2008-11-12 13:50:00',21),(1397,4277403,'2008-11-12 13:55:00',21),(1398,4277422,'2008-11-12 14:00:00',19),(1399,4277443,'2008-11-12 14:05:00',21),(1400,4277464,'2008-11-12 14:10:00',21),(1401,4277485,'2008-11-12 14:15:00',21),(1402,4277504,'2008-11-12 14:20:00',19),(1403,4277525,'2008-11-12 14:25:00',21),(1404,4277546,'2008-11-12 14:30:00',21),(1405,4277567,'2008-11-12 14:35:00',21),(1406,4277669,'2008-11-12 14:40:00',102),(1407,4277688,'2008-11-12 14:45:00',19),(1408,4277711,'2008-11-12 14:50:00',23),(1409,4277730,'2008-11-12 14:55:00',19),(1410,4277751,'2008-11-12 15:00:00',21),(1411,4277772,'2008-11-12 15:05:00',21),(1412,4277793,'2008-11-12 15:10:00',21),(1413,4277815,'2008-11-12 15:15:00',22),(1414,4277844,'2008-11-12 15:20:00',29),(1415,4277872,'2008-11-12 15:25:00',28),(1416,4277899,'2008-11-12 15:30:00',27),(1417,4277923,'2008-11-12 15:35:00',24),(1418,4277948,'2008-11-12 15:40:00',25),(1419,4277969,'2008-11-12 15:45:00',21),(1420,4277988,'2008-11-12 15:50:00',19),(1421,4278009,'2008-11-12 15:55:00',21),(1422,4278030,'2008-11-12 16:00:00',21),(1423,4278051,'2008-11-12 16:05:00',21),(1424,4278070,'2008-11-12 16:10:00',19),(1425,4278091,'2008-11-12 16:15:00',21),(1426,4278112,'2008-11-12 16:20:00',21),(1427,4278134,'2008-11-12 16:25:00',22),(1428,4278157,'2008-11-12 16:30:00',23),(1429,4278194,'2008-11-12 16:35:00',37),(1430,4278225,'2008-11-12 16:40:00',31),(1431,4278258,'2008-11-12 16:45:00',33),(1432,4278328,'2008-11-12 16:50:00',70),(1433,4278402,'2008-11-12 16:55:00',74),(1434,4278446,'2008-11-12 17:00:00',44),(1435,4278481,'2008-11-12 17:05:00',35),(1436,4278528,'2008-11-12 17:10:00',47),(1437,4278572,'2008-11-12 17:15:00',44),(1438,4278615,'2008-11-12 17:20:00',43),(1439,4278749,'2008-11-12 17:25:00',134),(1440,4278821,'2008-11-12 17:30:00',72),(1441,4278892,'2008-11-12 17:35:00',71),(1442,4278957,'2008-11-12 17:40:00',65),(1443,4279074,'2008-11-12 17:45:00',117),(1444,4279134,'2008-11-12 17:50:00',60),(1445,4279191,'2008-11-12 17:55:00',57),(1446,4279238,'2008-11-12 18:00:00',47),(1447,4279295,'2008-11-12 18:05:00',57),(1448,4279345,'2008-11-12 18:10:00',50),(1449,4279455,'2008-11-12 18:20:00',110),(1450,4279593,'2008-11-12 18:25:00',138),(1451,4279678,'2008-11-12 18:35:00',85),(1452,4279759,'2008-11-12 18:40:00',81),(1453,4279815,'2008-11-12 18:45:00',56),(1454,4279885,'2008-11-12 18:50:00',70),(1455,4281299,'2008-11-12 20:55:00',1414),(1456,4281450,'2008-11-12 21:30:00',151),(1457,4281584,'2008-11-12 21:35:00',134),(1458,4281622,'2008-11-12 21:40:00',38),(1459,4281659,'2008-11-12 21:45:00',37),(1460,4281705,'2008-11-12 21:50:00',46),(1461,4281746,'2008-11-12 21:55:00',41),(1462,4281777,'2008-11-12 22:00:00',31),(1463,4281849,'2008-11-12 22:10:00',72),(1464,4281899,'2008-11-12 22:15:00',50),(1465,4282042,'2008-11-12 22:20:00',143),(1466,4282103,'2008-11-12 22:25:00',61),(1467,4282163,'2008-11-12 22:30:00',60),(1468,4282218,'2008-11-12 22:35:00',55),(1469,4282278,'2008-11-12 22:40:00',60),(1470,4282338,'2008-11-12 22:45:00',60),(1471,4282399,'2008-11-12 22:50:00',61),(1472,4282449,'2008-11-12 22:55:00',50),(1473,4282453,'2008-11-12 23:10:00',4),(1474,4282548,'2008-11-12 23:25:00',95),(1475,4282737,'2008-11-12 23:40:00',189),(1476,4282773,'2008-11-12 23:45:00',36),(1477,4282801,'2008-11-12 23:50:00',28),(1478,4282838,'2008-11-12 23:55:00',37),(1479,4282868,'2008-11-13 00:00:00',30),(1480,4282892,'2008-11-13 00:05:00',24),(1481,4282926,'2008-11-13 00:10:00',34),(1482,4282956,'2008-11-13 00:15:00',30),(1483,4282986,'2008-11-13 00:20:00',30),(1484,4283013,'2008-11-13 00:25:00',27),(1485,4283044,'2008-11-13 00:30:00',31),(1486,4283073,'2008-11-13 00:35:00',29),(1487,4283103,'2008-11-13 00:40:00',30),(1488,4283161,'2008-11-13 00:50:00',58),(1489,4283191,'2008-11-13 00:55:00',30),(1490,4283219,'2008-11-13 01:00:00',28),(1491,4283244,'2008-11-13 01:05:00',25),(1492,4283267,'2008-11-13 01:10:00',23),(1493,4283289,'2008-11-13 01:15:00',22),(1494,4283309,'2008-11-13 01:20:00',20),(1495,4283332,'2008-11-13 01:25:00',23),(1496,4283354,'2008-11-13 01:30:00',22),(1497,4283383,'2008-11-13 01:35:00',29),(1498,4283409,'2008-11-13 01:40:00',26),(1499,4283438,'2008-11-13 01:45:00',29),(1500,4283467,'2008-11-13 01:50:00',29),(1501,4283492,'2008-11-13 01:55:00',25),(1502,4283517,'2008-11-13 02:00:00',25),(1503,4283539,'2008-11-13 02:05:00',22),(1504,4283562,'2008-11-13 02:10:00',23),(1505,4283665,'2008-11-13 02:15:00',103),(1506,4283687,'2008-11-13 02:20:00',22),(1507,4283710,'2008-11-13 02:25:00',23),(1508,4283732,'2008-11-13 02:30:00',22),(1509,4283752,'2008-11-13 02:35:00',20),(1510,4283775,'2008-11-13 02:40:00',23),(1511,4283797,'2008-11-13 02:45:00',22),(1512,4283818,'2008-11-13 02:50:00',21),(1513,4283838,'2008-11-13 02:55:00',20),(1514,4283862,'2008-11-13 03:00:00',24),(1515,4283885,'2008-11-13 03:05:00',23),(1516,4283905,'2008-11-13 03:10:00',20),(1517,4283928,'2008-11-13 03:15:00',23),(1518,4283950,'2008-11-13 03:20:00',22),(1519,4283970,'2008-11-13 03:25:00',20),(1520,4283993,'2008-11-13 03:30:00',23),(1521,4284015,'2008-11-13 03:35:00',22),(1522,4284039,'2008-11-13 03:40:00',24),(1523,4284066,'2008-11-13 03:45:00',27),(1524,4284096,'2008-11-13 03:50:00',30),(1525,4284125,'2008-11-13 03:55:00',29),(1526,4284153,'2008-11-13 04:00:00',28),(1527,4284179,'2008-11-13 04:05:00',26),(1528,4284201,'2008-11-13 04:10:00',22),(1529,4284224,'2008-11-13 04:15:00',23),(1530,4284244,'2008-11-13 04:20:00',20),(1531,4284267,'2008-11-13 04:25:00',23),(1532,4284289,'2008-11-13 04:30:00',22),(1533,4284312,'2008-11-13 04:35:00',23),(1534,4284332,'2008-11-13 04:40:00',20),(1535,4284355,'2008-11-13 04:45:00',23),(1536,4284377,'2008-11-13 04:50:00',22),(1537,4284400,'2008-11-13 04:55:00',23),(1538,4284420,'2008-11-13 05:00:00',20),(1539,4284443,'2008-11-13 05:05:00',23),(1540,4284465,'2008-11-13 05:10:00',22),(1541,4284486,'2008-11-13 05:15:00',21),(1542,4284508,'2008-11-13 05:20:00',22),(1543,4284531,'2008-11-13 05:25:00',23),(1544,4284553,'2008-11-13 05:30:00',22),(1545,4284573,'2008-11-13 05:35:00',20),(1546,4284596,'2008-11-13 05:40:00',23),(1547,4284618,'2008-11-13 05:45:00',22),(1548,4284641,'2008-11-13 05:50:00',23),(1549,4284668,'2008-11-13 05:55:00',27),(1550,4284749,'2008-11-13 06:00:00',81),(1551,4284810,'2008-11-13 06:05:00',61),(1552,4284833,'2008-11-13 06:10:00',23),(1553,4284864,'2008-11-13 06:15:00',31),(1554,4284888,'2008-11-13 06:20:00',24),(1555,4284910,'2008-11-13 06:25:00',22),(1556,4284931,'2008-11-13 06:30:00',21),(1557,4284953,'2008-11-13 06:35:00',22),(1558,4284974,'2008-11-13 06:40:00',21),(1559,4284996,'2008-11-13 06:45:00',22),(1560,4285016,'2008-11-13 06:50:00',20),(1561,4285039,'2008-11-13 06:55:00',23),(1562,4285061,'2008-11-13 07:00:00',22),(1563,4285081,'2008-11-13 07:05:00',20),(1564,4285104,'2008-11-13 07:10:00',23),(1565,4285128,'2008-11-13 07:15:00',24),(1566,4285152,'2008-11-13 07:20:00',24),(1567,4285174,'2008-11-13 07:25:00',22),(1568,4285198,'2008-11-13 07:30:00',24),(1569,4285222,'2008-11-13 07:35:00',24),(1570,4285247,'2008-11-13 07:40:00',25),(1571,4285275,'2008-11-13 07:45:00',28),(1572,4285305,'2008-11-13 07:50:20',30),(1573,4285336,'2008-11-13 07:55:00',31),(1574,4285353,'2008-11-13 08:00:00',17),(1575,4285380,'2008-11-13 08:05:00',27),(1576,4285410,'2008-11-13 08:10:00',30),(1577,4285438,'2008-11-13 08:15:00',28),(1578,4285464,'2008-11-13 08:20:00',26),(1579,4285491,'2008-11-13 08:25:00',27),(1580,4285518,'2008-11-13 08:30:00',27),(1581,4285539,'2008-11-13 08:35:00',21),(1582,4285559,'2008-11-13 08:40:00',20),(1583,4285581,'2008-11-13 08:45:00',22),(1584,4285603,'2008-11-13 08:50:00',22),(1585,4285623,'2008-11-13 08:55:00',20),(1586,4285644,'2008-11-13 09:00:00',21),(1587,4285666,'2008-11-13 09:05:00',22),(1588,4285688,'2008-11-13 09:10:00',22),(1589,4285708,'2008-11-13 09:15:00',20),(1590,4285730,'2008-11-13 09:20:00',22),(1591,4285751,'2008-11-13 09:25:00',21),(1592,4285771,'2008-11-13 09:30:00',20),(1593,4285793,'2008-11-13 09:35:00',22),(1594,4285815,'2008-11-13 09:40:00',22),(1595,4285896,'2008-11-13 09:45:00',81),(1596,4285943,'2008-11-13 09:50:00',47),(1597,4285963,'2008-11-13 09:55:00',20),(1598,4286009,'2008-11-13 10:05:00',46),(1599,4286029,'2008-11-13 10:10:00',20),(1600,4286050,'2008-11-13 10:15:00',21),(1601,4286074,'2008-11-13 10:20:00',24),(1602,4286129,'2008-11-13 10:30:00',55),(1603,4286157,'2008-11-13 10:35:00',28),(1604,4286210,'2008-11-13 10:45:00',53),(1605,4286231,'2008-11-13 10:50:00',21),(1606,4286253,'2008-11-13 10:55:00',22),(1607,4286275,'2008-11-13 11:00:00',22),(1608,4286295,'2008-11-13 11:05:00',20),(1609,4286316,'2008-11-13 11:10:00',21),(1610,4286338,'2008-11-13 11:15:00',22),(1611,4286358,'2008-11-13 11:20:00',20),(1612,4286380,'2008-11-13 11:25:00',22),(1613,4286401,'2008-11-13 11:30:00',21),(1614,4286423,'2008-11-13 11:35:00',22),(1615,4286443,'2008-11-13 11:40:00',20),(1616,4286465,'2008-11-13 11:45:00',22),(1617,4286486,'2008-11-13 11:50:00',21),(1618,4286508,'2008-11-13 11:55:00',22),(1619,4286528,'2008-11-13 12:00:00',20),(1620,4286550,'2008-11-13 12:05:00',22),(1621,4286657,'2008-11-13 12:10:00',107),(1622,4286691,'2008-11-13 12:15:00',34),(1623,4286729,'2008-11-13 12:20:00',38),(1624,4286763,'2008-11-13 12:25:00',34),(1625,4286808,'2008-11-13 12:30:00',45),(1626,4286849,'2008-11-13 12:35:00',41),(1627,4286893,'2008-11-13 12:40:00',44),(1628,4286936,'2008-11-13 12:45:00',43),(1629,4287009,'2008-11-13 12:50:00',73),(1630,4287096,'2008-11-13 12:55:00',87),(1631,4287142,'2008-11-13 13:00:00',46),(1632,4287187,'2008-11-13 13:05:00',45),(1633,4287228,'2008-11-13 13:10:00',41),(1634,4287272,'2008-11-13 13:15:00',44),(1635,4287317,'2008-11-13 13:20:00',45),(1636,4287362,'2008-11-13 13:25:00',45),(1637,4287402,'2008-11-13 13:30:00',40),(1638,4287441,'2008-11-13 13:35:00',39),(1639,4287487,'2008-11-13 13:40:00',46),(1640,4287597,'2008-11-13 13:45:00',110),(1641,4287655,'2008-11-13 13:50:00',58),(1642,4287698,'2008-11-13 13:55:00',43),(1643,4287744,'2008-11-13 14:00:00',46),(1644,4287781,'2008-11-13 14:05:00',37),(1645,4287825,'2008-11-13 14:10:00',44),(1646,4287869,'2008-11-13 14:15:00',44),(1647,4287912,'2008-11-13 14:20:00',43),(1648,4287947,'2008-11-13 14:25:00',35),(1649,4287987,'2008-11-13 14:30:00',40),(1650,4288027,'2008-11-13 14:35:00',40),(1651,4288062,'2008-11-13 14:40:00',35),(1652,4288107,'2008-11-13 14:45:00',45),(1653,4288153,'2008-11-13 14:50:00',46),(1654,4288197,'2008-11-13 14:55:00',44),(1655,4288245,'2008-11-13 15:00:00',48),(1656,4288288,'2008-11-13 15:05:00',43),(1657,4288331,'2008-11-13 15:10:00',43),(1658,4288890,'2008-11-13 16:25:00',559),(1659,4288996,'2008-11-13 16:45:00',106),(1660,4289006,'2008-11-13 16:50:00',10),(1661,4289050,'2008-11-13 16:55:00',44),(1662,4289079,'2008-11-13 17:00:00',29),(1663,4289106,'2008-11-13 17:05:00',27),(1664,4289128,'2008-11-13 17:10:00',22),(1665,4289149,'2008-11-13 17:15:00',21),(1666,4289168,'2008-11-13 17:20:00',19),(1667,4289186,'2008-11-13 17:25:00',18),(1668,4289221,'2008-11-13 17:30:00',35),(1669,4289277,'2008-11-13 17:35:00',56),(1670,4289335,'2008-11-13 17:40:00',58),(1671,4289380,'2008-11-13 17:45:00',45),(1672,4289489,'2008-11-13 17:50:00',109),(1673,4289599,'2008-11-13 17:55:00',110),(1674,4289648,'2008-11-13 18:00:00',49),(1675,4289692,'2008-11-13 18:05:00',44),(1676,4289742,'2008-11-13 18:10:00',50),(1677,4289792,'2008-11-13 18:15:00',50),(1678,4289837,'2008-11-13 18:20:00',45),(1679,4289883,'2008-11-13 18:25:00',46),(1680,4289917,'2008-11-13 18:30:00',34),(1681,4289956,'2008-11-13 18:35:00',39),(1682,4289999,'2008-11-13 18:40:00',43),(1683,4290042,'2008-11-13 18:45:00',43),(1684,4290090,'2008-11-13 18:50:00',48),(1685,4290137,'2008-11-13 18:55:00',47),(1686,4290176,'2008-11-13 19:00:00',39),(1687,4290219,'2008-11-13 19:05:00',43),(1688,4290261,'2008-11-13 19:10:00',42),(1689,4290297,'2008-11-13 19:15:00',36),(1690,4290351,'2008-11-13 19:20:00',54),(1691,4290409,'2008-11-13 19:25:00',58),(1692,4290415,'2008-11-13 19:30:15',6),(1693,4290518,'2008-11-13 19:35:00',103),(1694,4290577,'2008-11-13 19:40:00',59),(1695,4290629,'2008-11-13 19:45:00',52),(1696,4290694,'2008-11-13 19:50:00',65),(1697,4290736,'2008-11-13 19:55:00',42),(1698,4290756,'2008-11-13 20:00:00',20),(1699,4290769,'2008-11-13 20:05:00',13),(1700,4290782,'2008-11-13 20:10:00',13),(1701,4290795,'2008-11-13 20:15:00',13),(1702,4290808,'2008-11-13 20:20:00',13),(1703,4290821,'2008-11-13 20:25:00',13),(1704,4290832,'2008-11-13 20:30:00',11),(1705,4290844,'2008-11-13 20:35:00',12),(1706,4290858,'2008-11-13 20:40:00',14),(1707,4290871,'2008-11-13 20:45:00',13),(1708,4290889,'2008-11-13 20:50:00',18),(1709,4290909,'2008-11-13 20:55:00',20),(1710,4290929,'2008-11-13 21:00:00',20),(1711,4290946,'2008-11-13 21:05:00',17),(1712,4290963,'2008-11-13 21:10:00',17),(1713,4290979,'2008-11-13 21:15:00',16),(1714,4290993,'2008-11-13 21:20:00',14),(1715,4291005,'2008-11-13 21:25:00',12),(1716,4291018,'2008-11-13 21:30:00',13),(1717,4291031,'2008-11-13 21:35:00',13),(1718,4291043,'2008-11-13 21:40:00',12),(1719,4291056,'2008-11-13 21:45:00',13),(1720,4291068,'2008-11-13 21:50:00',12),(1721,4291148,'2008-11-13 21:55:00',80),(1722,4291183,'2008-11-13 22:00:00',35),(1723,4291196,'2008-11-13 22:05:00',13),(1724,4291209,'2008-11-13 22:10:00',13),(1725,4291221,'2008-11-13 22:15:00',12),(1726,4291233,'2008-11-13 22:20:00',12),(1727,4291246,'2008-11-13 22:25:00',13),(1728,4291259,'2008-11-13 22:30:00',13),(1729,4291271,'2008-11-13 22:35:00',12),(1730,4291284,'2008-11-13 22:40:00',13),(1731,4291297,'2008-11-13 22:45:00',13),(1732,4291309,'2008-11-13 22:50:00',12),(1733,4291323,'2008-11-13 22:55:00',14),(1734,4291344,'2008-11-13 23:00:00',21),(1735,4291363,'2008-11-13 23:05:00',19),(1736,4291382,'2008-11-13 23:10:00',19),(1737,4291399,'2008-11-13 23:15:00',17),(1738,4291417,'2008-11-13 23:20:00',18),(1739,4291429,'2008-11-13 23:25:00',12),(1740,4291442,'2008-11-13 23:30:00',13),(1741,4291455,'2008-11-13 23:35:00',13),(1742,4291468,'2008-11-13 23:40:00',13),(1743,4291481,'2008-11-13 23:45:00',13),(1744,4291492,'2008-11-13 23:50:00',11),(1745,4291504,'2008-11-13 23:55:00',12),(1746,4291518,'2008-11-14 00:00:00',14),(1747,4291530,'2008-11-14 00:05:00',12),(1748,4291543,'2008-11-14 00:10:00',13),(1749,4291556,'2008-11-14 00:15:00',13),(1750,4291569,'2008-11-14 00:20:00',13),(1751,4291580,'2008-11-14 00:25:00',11),(1752,4291593,'2008-11-14 00:30:00',13),(1753,4291606,'2008-11-14 00:35:00',13),(1754,4291619,'2008-11-14 00:40:00',13),(1755,4291631,'2008-11-14 00:45:00',12),(1756,4291644,'2008-11-14 00:50:00',13),(1757,4291657,'2008-11-14 00:55:00',13),(1758,4291669,'2008-11-14 01:00:00',12),(1759,4291682,'2008-11-14 01:05:00',13),(1760,4291702,'2008-11-14 01:10:00',20),(1761,4291722,'2008-11-14 01:15:00',20),(1762,4291740,'2008-11-14 01:20:00',18),(1763,4291759,'2008-11-14 01:25:00',19),(1764,4291778,'2008-11-14 01:30:00',19),(1765,4291792,'2008-11-14 01:35:00',14),(1766,4291805,'2008-11-14 01:40:00',13),(1767,4291818,'2008-11-14 01:45:00',13),(1768,4291831,'2008-11-14 01:50:00',13),(1769,4291843,'2008-11-14 01:55:00',12),(1770,4291876,'2008-11-14 02:00:00',33),(1771,4291953,'2008-11-14 02:05:00',77),(1772,4291968,'2008-11-14 02:10:00',15),(1773,4291979,'2008-11-14 02:15:00',11),(1774,4291992,'2008-11-14 02:20:00',13),(1775,4292005,'2008-11-14 02:25:00',13),(1776,4292017,'2008-11-14 02:30:00',12),(1777,4292030,'2008-11-14 02:35:00',13),(1778,4292043,'2008-11-14 02:40:00',13),(1779,4292056,'2008-11-14 02:45:00',13),(1780,4292068,'2008-11-14 02:50:00',12),(1781,4292081,'2008-11-14 02:55:00',13),(1782,4292094,'2008-11-14 03:00:00',13),(1783,4292104,'2008-11-14 03:05:00',10),(1784,4292118,'2008-11-14 03:10:00',14),(1785,4292131,'2008-11-14 03:15:00',13),(1786,4292144,'2008-11-14 03:20:00',13),(1787,4292162,'2008-11-14 03:25:00',18),(1788,4292182,'2008-11-14 03:30:00',20),(1789,4292202,'2008-11-14 03:35:00',20),(1790,4292219,'2008-11-14 03:40:00',17),(1791,4292238,'2008-11-14 03:45:00',19),(1792,4292253,'2008-11-14 03:50:00',15),(1793,4292266,'2008-11-14 03:55:00',13),(1794,4292278,'2008-11-14 04:00:00',12),(1795,4292291,'2008-11-14 04:05:00',13),(1796,4292304,'2008-11-14 04:10:00',13),(1797,4292317,'2008-11-14 04:15:00',13),(1798,4292329,'2008-11-14 04:20:00',12),(1799,4292342,'2008-11-14 04:25:00',13),(1800,4292355,'2008-11-14 04:30:00',13),(1801,4292367,'2008-11-14 04:35:00',12),(1802,4292380,'2008-11-14 04:40:00',13),(1803,4292393,'2008-11-14 04:45:00',13),(1804,4292406,'2008-11-14 04:50:00',13),(1805,4292418,'2008-11-14 04:55:00',12),(1806,4292431,'2008-11-14 05:00:00',13),(1807,4292444,'2008-11-14 05:05:00',13),(1808,4292456,'2008-11-14 05:10:00',12),(1809,4292469,'2008-11-14 05:15:00',13),(1810,4292482,'2008-11-14 05:20:00',13),(1811,4292495,'2008-11-14 05:25:00',13),(1812,4292506,'2008-11-14 05:30:00',11),(1813,4292519,'2008-11-14 05:35:00',13),(1814,4292536,'2008-11-14 05:40:00',17),(1815,4292554,'2008-11-14 05:45:00',18),(1816,4292574,'2008-11-14 05:50:00',20),(1817,4292652,'2008-11-14 05:55:00',78),(1818,4292695,'2008-11-14 06:00:00',43),(1819,4292710,'2008-11-14 06:05:00',15),(1820,4292723,'2008-11-14 06:10:00',13),(1821,4292736,'2008-11-14 06:15:00',13),(1822,4292749,'2008-11-14 06:20:00',13),(1823,4292761,'2008-11-14 06:25:00',12),(1824,4292774,'2008-11-14 06:30:00',13),(1825,4292787,'2008-11-14 06:35:00',13),(1826,4292799,'2008-11-14 06:40:00',12),(1827,4292812,'2008-11-14 06:45:00',13),(1828,4292824,'2008-11-14 06:50:00',12),(1829,4292838,'2008-11-14 06:55:00',14),(1830,4292851,'2008-11-14 07:00:00',13),(1831,4292864,'2008-11-14 07:05:00',13),(1832,4292878,'2008-11-14 07:10:00',14),(1833,4292894,'2008-11-14 07:15:00',16),(1834,4292907,'2008-11-14 07:20:00',13),(1835,4292923,'2008-11-14 07:25:00',16),(1836,4292939,'2008-11-14 07:30:00',16),(1837,4292953,'2008-11-14 07:35:00',14),(1838,4292968,'2008-11-14 07:40:00',15),(1839,4292983,'2008-11-14 07:45:00',15),(1840,4292999,'2008-11-14 07:50:00',16),(1841,4293013,'2008-11-14 07:55:00',14),(1842,4293032,'2008-11-14 08:00:00',19),(1843,4293054,'2008-11-14 08:05:00',22),(1844,4293076,'2008-11-14 08:10:00',22),(1845,4293096,'2008-11-14 08:15:00',20),(1846,4293117,'2008-11-14 08:20:00',21),(1847,4293138,'2008-11-14 08:25:00',21),(1848,4293152,'2008-11-14 08:30:00',14),(1849,4293168,'2008-11-14 08:35:00',16),(1850,4293183,'2008-11-14 08:40:00',15),(1851,4293199,'2008-11-14 08:45:00',16),(1852,4293211,'2008-11-14 08:50:00',12),(1853,4293223,'2008-11-14 08:55:00',12),(1854,4293236,'2008-11-14 09:00:00',13),(1855,4293249,'2008-11-14 09:05:00',13),(1856,4293261,'2008-11-14 09:10:00',12),(1857,4293274,'2008-11-14 09:15:00',13),(1858,4293287,'2008-11-14 09:20:00',13),(1859,4293298,'2008-11-14 09:25:00',11),(1860,4293311,'2008-11-14 09:30:00',13),(1861,4293324,'2008-11-14 09:35:00',13),(1862,4293427,'2008-11-14 09:40:00',103),(1863,4293907,'2008-11-14 12:45:19',480),(1864,4293907,'2008-11-14 12:45:43',0),(1865,4294039,'2008-11-14 13:30:00',132),(1866,4294080,'2008-11-14 13:35:00',41),(1867,4294111,'2008-11-14 13:40:00',31),(1868,4294189,'2008-11-14 13:45:00',78),(1869,4294202,'2008-11-14 13:50:00',13),(1870,4294215,'2008-11-14 13:55:00',13),(1871,4294226,'2008-11-14 14:00:00',11),(1872,4294239,'2008-11-14 14:05:00',13),(1873,4294252,'2008-11-14 14:10:00',13),(1874,4294264,'2008-11-14 14:15:00',12),(1875,4294276,'2008-11-14 14:20:00',12),(1876,4294289,'2008-11-14 14:25:00',13),(1877,4294302,'2008-11-14 14:30:00',13),(1878,4294314,'2008-11-14 14:35:00',12),(1879,4294327,'2008-11-14 14:40:00',13),(1880,4294339,'2008-11-14 14:45:00',12),(1881,4294353,'2008-11-14 14:50:00',14),(1882,4294874,'2008-11-14 17:30:00',521),(1883,4294894,'2008-11-14 17:35:00',20),(1884,4294912,'2008-11-14 17:40:00',18),(1885,4294931,'2008-11-14 17:45:00',19),(1886,4294950,'2008-11-14 17:50:00',19),(1887,4294968,'2008-11-14 17:55:00',18),(1888,4294981,'2008-11-14 18:00:00',13),(1889,4294994,'2008-11-14 18:05:00',13),(1890,4295007,'2008-11-14 18:10:00',13),(1891,4295018,'2008-11-14 18:15:00',11),(1892,4295031,'2008-11-14 18:20:00',13),(1893,4295044,'2008-11-14 18:25:00',13),(1894,4295057,'2008-11-14 18:30:00',13),(1895,4295069,'2008-11-14 18:35:00',12),(1896,4295082,'2008-11-14 18:40:00',13),(1897,4295094,'2008-11-14 18:45:00',12),(1898,4295106,'2008-11-14 18:50:00',12),(1899,4295119,'2008-11-14 18:55:00',13),(1900,4295132,'2008-11-14 19:00:00',13),(1901,4295144,'2008-11-14 19:05:00',12),(1902,4295156,'2008-11-14 19:10:00',12),(1903,4295169,'2008-11-14 19:15:00',13),(1904,4295182,'2008-11-14 19:20:00',13),(1905,4295194,'2008-11-14 19:25:00',12),(1906,4295206,'2008-11-14 19:30:00',12),(1907,4295219,'2008-11-14 19:35:00',13),(1908,4295232,'2008-11-14 19:40:00',13),(1909,4295243,'2008-11-14 19:45:00',11),(1910,4295256,'2008-11-14 19:50:00',13),(1911,4295273,'2008-11-14 19:55:00',17),(1912,4295294,'2008-11-14 20:00:00',21),(1913,4295312,'2008-11-14 20:05:00',18),(1914,4295331,'2008-11-14 20:10:00',19),(1915,4295350,'2008-11-14 20:15:00',19),(1916,4295369,'2008-11-14 20:20:00',19),(1917,4295382,'2008-11-14 20:25:00',13),(1918,4295395,'2008-11-14 20:30:00',13),(1919,4295408,'2008-11-14 20:35:00',13),(1920,4295419,'2008-11-14 20:40:00',11),(1921,4295432,'2008-11-14 20:45:00',13),(1922,4295445,'2008-11-14 20:50:00',13),(1923,4295457,'2008-11-14 20:55:00',12),(1924,4295469,'2008-11-14 21:00:00',12),(1925,4295482,'2008-11-14 21:05:00',13),(1926,4295493,'2008-11-14 21:10:00',11),(1927,4295595,'2008-11-14 21:15:00',102),(1928,4295606,'2008-11-14 21:20:00',11),(1929,4295619,'2008-11-14 21:25:00',13),(1930,4295632,'2008-11-14 21:30:00',13),(1931,4295644,'2008-11-14 21:35:00',12),(1932,4295657,'2008-11-14 21:40:00',13),(1933,4295669,'2008-11-14 21:45:00',12),(1934,4295682,'2008-11-14 21:50:00',13),(1935,4295694,'2008-11-14 21:55:00',12),(1936,4295707,'2008-11-14 22:00:00',13),(1937,4295719,'2008-11-14 22:05:00',12),(1938,4295733,'2008-11-14 22:10:00',14),(1939,4295744,'2008-11-14 22:15:00',11),(1940,4295757,'2008-11-14 22:20:00',13),(1941,4295776,'2008-11-14 22:25:00',19),(1942,4295794,'2008-11-14 22:30:00',18),(1943,4295814,'2008-11-14 22:35:00',20),(1944,4295833,'2008-11-14 22:40:00',19),(1945,4295852,'2008-11-14 22:45:00',19),(1946,4295867,'2008-11-14 22:50:00',15),(1947,4295880,'2008-11-14 22:55:00',13),(1948,4295893,'2008-11-14 23:00:00',13),(1949,4295905,'2008-11-14 23:05:00',12),(1950,4295918,'2008-11-14 23:10:00',13),(1951,4295929,'2008-11-14 23:15:00',11),(1952,4295943,'2008-11-14 23:20:00',14),(1953,4295955,'2008-11-14 23:25:00',12),(1954,4295967,'2008-11-14 23:30:00',12),(1955,4295981,'2008-11-14 23:35:00',14),(1956,4298674,'2008-11-15 12:45:00',2693),(1957,4298710,'2008-11-15 12:50:00',36),(1958,4298743,'2008-11-15 12:55:00',33),(1959,4298774,'2008-11-15 13:00:00',31),(1960,4298807,'2008-11-15 13:05:00',33),(1961,4298848,'2008-11-15 13:10:00',41),(1962,4298888,'2008-11-15 13:15:00',40),(1963,4298925,'2008-11-15 13:20:00',37),(1964,4299052,'2008-11-15 13:25:00',127),(1965,4299235,'2008-11-15 13:50:00',183),(1966,4299842,'2008-11-15 15:05:00',607),(1967,4299947,'2008-11-15 15:20:00',105),(1968,4299993,'2008-11-15 15:25:00',46),(1969,4300046,'2008-11-15 15:30:00',53),(1970,4300097,'2008-11-15 15:35:00',51),(1971,4300148,'2008-11-15 15:40:00',51),(1972,4300195,'2008-11-15 15:45:00',47),(1973,4300245,'2008-11-15 15:50:00',50),(1974,4300269,'2008-11-15 15:55:00',24),(1975,4300292,'2008-11-15 16:00:00',23),(1976,4300315,'2008-11-15 16:05:00',23),(1977,4300338,'2008-11-15 16:10:00',23),(1978,4300361,'2008-11-15 16:15:00',23),(1979,4300381,'2008-11-15 16:20:00',20),(1980,4300449,'2008-11-15 16:35:00',68),(1981,4300913,'2008-11-15 17:50:00',464),(1982,4300937,'2008-11-15 17:55:00',24),(1983,4300954,'2008-11-15 18:00:00',17),(1984,4300968,'2008-11-15 18:05:00',14),(1985,4300984,'2008-11-15 18:10:00',16),(1986,4301002,'2008-11-15 18:15:00',18),(1987,4301019,'2008-11-15 18:20:00',17),(1988,4301036,'2008-11-15 18:25:00',17),(1989,4301050,'2008-11-15 18:30:00',14),(1990,4301068,'2008-11-15 18:35:00',18),(1991,4301086,'2008-11-15 18:40:00',18),(1992,4301102,'2008-11-15 18:45:00',16),(1993,4301120,'2008-11-15 18:50:00',18),(1994,4301138,'2008-11-15 18:55:00',18),(1995,4301156,'2008-11-15 19:00:00',18),(1996,4301172,'2008-11-15 19:05:00',16),(1997,4301190,'2008-11-15 19:10:00',18),(1998,4301207,'2008-11-15 19:15:00',17),(1999,4301221,'2008-11-15 19:20:00',14),(2000,4301236,'2008-11-15 19:25:00',15),(2001,4301252,'2008-11-15 19:30:00',16),(2002,4301280,'2008-11-15 19:35:00',28),(2003,4301306,'2008-11-15 19:40:00',26),(2004,4301328,'2008-11-15 19:45:00',22),(2005,4301351,'2008-11-15 19:50:00',23),(2006,4301371,'2008-11-15 19:55:00',20),(2007,4301386,'2008-11-15 20:00:00',15),(2008,4301404,'2008-11-15 20:05:00',18),(2009,4301422,'2008-11-15 20:10:00',18),(2010,4301440,'2008-11-15 20:15:00',18),(2011,4301456,'2008-11-15 20:20:00',16),(2012,4301474,'2008-11-15 20:25:00',18),(2013,4301492,'2008-11-15 20:30:00',18),(2014,4301509,'2008-11-15 20:35:00',17),(2015,4301522,'2008-11-15 20:40:00',13),(2016,4301534,'2008-11-15 20:45:00',12),(2017,4301547,'2008-11-15 20:50:00',13),(2018,4301564,'2008-11-15 20:55:00',17),(2019,4301582,'2008-11-15 21:00:00',18),(2020,4301598,'2008-11-15 21:05:00',16),(2021,4301617,'2008-11-15 21:10:00',19),(2022,4301634,'2008-11-15 21:15:00',17),(2023,4301650,'2008-11-15 21:20:00',16),(2024,4301667,'2008-11-15 21:25:00',17),(2025,4301684,'2008-11-15 21:30:00',17),(2026,4301703,'2008-11-15 21:35:00',19),(2027,4301730,'2008-11-15 21:40:00',27),(2028,4301754,'2008-11-15 21:45:00',24),(2029,4301773,'2008-11-15 21:50:00',19),(2030,4301790,'2008-11-15 21:55:00',17),(2031,4301821,'2008-11-15 22:00:00',31),(2032,4301912,'2008-11-15 22:05:00',91),(2033,4301924,'2008-11-15 22:10:00',12),(2034,4301937,'2008-11-15 22:15:00',13),(2035,4301949,'2008-11-15 22:20:00',12),(2036,4301962,'2008-11-15 22:25:00',13),(2037,4301974,'2008-11-15 22:30:00',12),(2038,4301987,'2008-11-15 22:35:00',13),(2039,4302000,'2008-11-15 22:40:00',13),(2040,4302013,'2008-11-15 22:45:00',13),(2041,4302025,'2008-11-15 22:50:00',12),(2042,4302038,'2008-11-15 22:55:00',13),(2043,4302051,'2008-11-15 23:00:00',13),(2044,4302063,'2008-11-15 23:05:00',12),(2045,4302076,'2008-11-15 23:10:00',13),(2046,4302088,'2008-11-15 23:15:00',12),(2047,4302101,'2008-11-15 23:20:00',13),(2048,4302113,'2008-11-15 23:25:00',12),(2049,4302126,'2008-11-15 23:30:00',13),(2050,4302139,'2008-11-15 23:35:00',13),(2051,4302159,'2008-11-15 23:40:00',20),(2052,4302177,'2008-11-15 23:45:00',18),(2053,4302196,'2008-11-15 23:50:00',19),(2054,4302216,'2008-11-15 23:55:00',20),(2055,4302233,'2008-11-16 00:00:00',17),(2056,4302249,'2008-11-16 00:05:00',16),(2057,4302262,'2008-11-16 00:10:00',13),(2058,4302274,'2008-11-16 00:15:00',12),(2059,4302287,'2008-11-16 00:20:00',13),(2060,4302300,'2008-11-16 00:25:00',13),(2061,4302313,'2008-11-16 00:30:00',13),(2062,4302326,'2008-11-16 00:35:00',13),(2063,4302338,'2008-11-16 00:40:00',12),(2064,4302351,'2008-11-16 00:45:00',13),(2065,4302364,'2008-11-16 00:50:00',13),(2066,4302376,'2008-11-16 00:55:00',12),(2067,4302389,'2008-11-16 01:00:00',13),(2068,4302402,'2008-11-16 01:05:00',13),(2069,4302415,'2008-11-16 01:10:00',13),(2070,4302427,'2008-11-16 01:15:00',12),(2071,4302438,'2008-11-16 01:20:00',11),(2072,4302453,'2008-11-16 01:25:00',15),(2073,4302466,'2008-11-16 01:30:00',13),(2074,4302478,'2008-11-16 01:35:00',12),(2075,4302491,'2008-11-16 01:40:00',13),(2076,4302507,'2008-11-16 01:45:00',16),(2077,4302523,'2008-11-16 01:50:00',16),(2078,4302543,'2008-11-16 01:55:00',20),(2079,4302565,'2008-11-16 02:00:00',22),(2080,4302584,'2008-11-16 02:05:00',19),(2081,4302601,'2008-11-16 02:10:00',17),(2082,4302613,'2008-11-16 02:15:00',12),(2083,4302715,'2008-11-16 02:20:00',102),(2084,4302728,'2008-11-16 02:25:00',13),(2085,4302738,'2008-11-16 02:30:00',10),(2086,4302753,'2008-11-16 02:35:00',15),(2087,4302766,'2008-11-16 02:40:00',13),(2088,4302777,'2008-11-16 02:45:00',11),(2089,4302790,'2008-11-16 02:50:00',13),(2090,4302803,'2008-11-16 02:55:00',13),(2091,4302816,'2008-11-16 03:00:00',13),(2092,4302828,'2008-11-16 03:05:00',12),(2093,4302840,'2008-11-16 03:10:00',12),(2094,4302853,'2008-11-16 03:15:00',13),(2095,4302866,'2008-11-16 03:20:00',13),(2096,4302878,'2008-11-16 03:25:00',12),(2097,4302891,'2008-11-16 03:30:00',13),(2098,4302904,'2008-11-16 03:35:00',13),(2099,4302915,'2008-11-16 03:40:00',11),(2100,4302928,'2008-11-16 03:45:00',13),(2101,4302941,'2008-11-16 03:50:00',13),(2102,4302955,'2008-11-16 03:55:00',14),(2103,4302974,'2008-11-16 04:00:00',19),(2104,4302994,'2008-11-16 04:05:00',20),(2105,4303013,'2008-11-16 04:10:00',19),(2106,4303032,'2008-11-16 04:15:00',19),(2107,4303049,'2008-11-16 04:20:00',17),(2108,4303063,'2008-11-16 04:25:00',14),(2109,4303076,'2008-11-16 04:30:00',13),(2110,4303089,'2008-11-16 04:35:00',13),(2111,4303100,'2008-11-16 04:40:00',11),(2112,4303114,'2008-11-16 04:45:00',14),(2113,4303127,'2008-11-16 04:50:00',13),(2114,4303138,'2008-11-16 04:55:00',11),(2115,4303151,'2008-11-16 05:00:00',13),(2116,4303164,'2008-11-16 05:05:00',13),(2117,4303177,'2008-11-16 05:10:00',13),(2118,4303189,'2008-11-16 05:15:00',12),(2119,4303202,'2008-11-16 05:20:00',13),(2120,4303215,'2008-11-16 05:25:00',13),(2121,4303228,'2008-11-16 05:30:00',13),(2122,4303240,'2008-11-16 05:35:00',12),(2123,4303252,'2008-11-16 05:40:00',12),(2124,4303264,'2008-11-16 05:45:00',12),(2125,4303277,'2008-11-16 05:50:00',13),(2126,4303290,'2008-11-16 05:55:00',13),(2127,4303303,'2008-11-16 06:00:00',13),(2128,4303316,'2008-11-16 06:05:00',13),(2129,4303330,'2008-11-16 06:10:00',14),(2130,4303351,'2008-11-16 06:15:00',21),(2131,4303369,'2008-11-16 06:20:00',18),(2132,4303474,'2008-11-16 06:25:00',105),(2133,4303493,'2008-11-16 06:30:00',19),(2134,4303511,'2008-11-16 06:35:00',18),(2135,4303523,'2008-11-16 06:40:00',12),(2136,4303535,'2008-11-16 06:45:00',12),(2137,4303547,'2008-11-16 06:50:00',12),(2138,4303560,'2008-11-16 06:55:00',13),(2139,4303573,'2008-11-16 07:00:00',13),(2140,4303585,'2008-11-16 07:05:00',12),(2141,4303599,'2008-11-16 07:10:00',14),(2142,4303614,'2008-11-16 07:15:00',15),(2143,4303627,'2008-11-16 07:20:00',13),(2144,4303642,'2008-11-16 07:25:00',15),(2145,4303657,'2008-11-16 07:30:00',15),(2146,4303671,'2008-11-16 07:35:00',14),(2147,4303683,'2008-11-16 07:40:00',12),(2148,4303698,'2008-11-16 07:45:00',15),(2149,4303713,'2008-11-16 07:50:00',15),(2150,4303728,'2008-11-16 07:55:00',15),(2151,4303747,'2008-11-16 08:00:00',19),(2152,4303762,'2008-11-16 08:05:00',15),(2153,4303776,'2008-11-16 08:10:00',14),(2154,4303790,'2008-11-16 08:15:00',14),(2155,4303805,'2008-11-16 08:20:00',15),(2156,4303822,'2008-11-16 08:25:00',17),(2157,4303844,'2008-11-16 08:30:00',22),(2158,4303864,'2008-11-16 08:35:00',20),(2159,4303883,'2008-11-16 08:40:00',19),(2160,4303905,'2008-11-16 08:45:00',22),(2161,4303923,'2008-11-16 08:50:00',18),(2162,4303935,'2008-11-16 08:55:00',12),(2163,4303947,'2008-11-16 09:00:00',12),(2164,4303959,'2008-11-16 09:05:00',12),(2165,4303969,'2008-11-16 09:10:00',10),(2166,4303983,'2008-11-16 09:15:00',14),(2167,4303995,'2008-11-16 09:20:00',12),(2168,4304007,'2008-11-16 09:25:00',12),(2169,4304018,'2008-11-16 09:30:00',11),(2170,4304030,'2008-11-16 09:35:00',12),(2171,4304043,'2008-11-16 09:40:00',13),(2172,4304054,'2008-11-16 09:45:00',11),(2173,4304066,'2008-11-16 09:50:00',12),(2174,4304078,'2008-11-16 09:55:00',12),(2175,4304090,'2008-11-16 10:00:00',12),(2176,4304101,'2008-11-16 10:05:00',11),(2177,4304113,'2008-11-16 10:10:00',12),(2178,4304125,'2008-11-16 10:15:00',12),(2179,4304171,'2008-11-16 10:20:00',46),(2180,4304235,'2008-11-16 10:25:00',64),(2181,4304247,'2008-11-16 10:30:00',12),(2182,4304259,'2008-11-16 10:35:00',12),(2183,4304270,'2008-11-16 10:40:00',11),(2184,4304288,'2008-11-16 10:45:00',18),(2185,4304308,'2008-11-16 10:50:00',20),(2186,4304327,'2008-11-16 10:55:00',19),(2187,4304343,'2008-11-16 11:00:00',16),(2188,4304362,'2008-11-16 11:05:00',19),(2189,4304378,'2008-11-16 11:10:00',16),(2190,4304387,'2008-11-16 11:15:00',9),(2191,4304401,'2008-11-16 11:20:00',14),(2192,4304413,'2008-11-16 11:25:00',12),(2193,4304425,'2008-11-16 11:30:00',12),(2194,4304436,'2008-11-16 11:35:00',11),(2195,4304449,'2008-11-16 11:40:00',13),(2196,4304461,'2008-11-16 11:45:00',12),(2197,4304473,'2008-11-16 11:50:00',12),(2198,4304484,'2008-11-16 11:55:00',11),(2199,4304497,'2008-11-16 12:00:00',13),(2200,4304509,'2008-11-16 12:05:00',12),(2201,4304521,'2008-11-16 12:10:00',12),(2202,4304532,'2008-11-16 12:15:00',11),(2203,4304545,'2008-11-16 12:20:00',13),(2204,4304557,'2008-11-16 12:25:00',12),(2205,4304568,'2008-11-16 12:30:00',11),(2206,4304580,'2008-11-16 12:35:00',12),(2207,4304592,'2008-11-16 12:40:00',12),(2208,4304605,'2008-11-16 12:45:00',13),(2209,4304614,'2008-11-16 12:50:00',9),(2210,4304628,'2008-11-16 12:55:00',14),(2211,4304643,'2008-11-16 13:00:00',15),(2212,4304661,'2008-11-16 13:05:00',18),(2213,4304680,'2008-11-16 13:10:00',19),(2214,4304699,'2008-11-16 13:15:00',19),(2215,4304717,'2008-11-16 13:20:00',18),(2216,4304733,'2008-11-16 13:25:00',16),(2217,4304746,'2008-11-16 13:30:00',13),(2218,4304759,'2008-11-16 13:35:00',13),(2219,4304771,'2008-11-16 13:40:00',12),(2220,4304782,'2008-11-16 13:45:00',11),(2221,4304795,'2008-11-16 13:50:00',13),(2222,4304807,'2008-11-16 13:55:00',12),(2223,4304818,'2008-11-16 14:00:00',11),(2224,4304831,'2008-11-16 14:05:00',13),(2225,4304843,'2008-11-16 14:10:00',12),(2226,4304855,'2008-11-16 14:15:00',12),(2227,4304880,'2008-11-16 14:20:00',25),(2228,4304964,'2008-11-16 14:25:00',84),(2229,4304977,'2008-11-16 14:30:00',13),(2230,4304988,'2008-11-16 14:35:00',11),(2231,4305000,'2008-11-16 14:40:00',12),(2232,4305013,'2008-11-16 14:45:00',13),(2233,4305025,'2008-11-16 14:50:00',12),(2234,4305037,'2008-11-16 14:55:00',12),(2235,4305049,'2008-11-16 15:00:00',12),(2236,4305061,'2008-11-16 15:05:00',12),(2237,4305074,'2008-11-16 15:10:00',13),(2238,4305085,'2008-11-16 15:15:00',11),(2239,4305105,'2008-11-16 15:20:00',20),(2240,4305123,'2008-11-16 15:25:00',18),(2241,4305142,'2008-11-16 15:30:00',19),(2242,4305160,'2008-11-16 15:35:00',18),(2243,4305179,'2008-11-16 15:40:00',19),(2244,4305193,'2008-11-16 15:45:00',14),(2245,4305205,'2008-11-16 15:50:00',12),(2246,4305217,'2008-11-16 15:55:00',12),(2247,4305228,'2008-11-16 16:00:00',11),(2248,4305242,'2008-11-16 16:05:00',14),(2249,4305253,'2008-11-16 16:10:00',11),(2250,4305266,'2008-11-16 16:15:00',13),(2251,4305278,'2008-11-16 16:20:00',12),(2252,4305289,'2008-11-16 16:25:00',11),(2253,4305302,'2008-11-16 16:30:00',13),(2254,4305314,'2008-11-16 16:35:00',12),(2255,4305327,'2008-11-16 16:40:00',13),(2256,4305338,'2008-11-16 16:45:00',11),(2257,4305349,'2008-11-16 16:50:00',11),(2258,4305362,'2008-11-16 16:55:00',13),(2259,4305375,'2008-11-16 17:00:00',13),(2260,4305386,'2008-11-16 17:05:00',11),(2261,4305398,'2008-11-16 17:10:00',12),(2262,4305410,'2008-11-16 17:15:00',12),(2263,4305420,'2008-11-16 17:20:00',10),(2264,4305434,'2008-11-16 17:25:00',14),(2265,4305446,'2008-11-16 17:30:00',12),(2266,4305462,'2008-11-16 17:35:00',16),(2267,4305480,'2008-11-16 17:40:00',18),(2268,4305499,'2008-11-16 17:45:00',19),(2269,4305517,'2008-11-16 17:50:00',18),(2270,4305532,'2008-11-16 17:55:00',15),(2271,4305552,'2008-11-16 18:00:00',20),(2272,4305564,'2008-11-16 18:05:00',12),(2273,4305577,'2008-11-16 18:10:00',13),(2274,4305673,'2008-11-16 18:15:00',96),(2275,4305686,'2008-11-16 18:20:00',13),(2276,4305699,'2008-11-16 18:25:00',13),(2277,4305712,'2008-11-16 18:30:00',13),(2278,4305723,'2008-11-16 18:35:00',11),(2279,4305736,'2008-11-16 18:40:00',13),(2280,4305749,'2008-11-16 18:45:00',13),(2281,4305761,'2008-11-16 18:50:00',12),(2282,4305774,'2008-11-16 18:55:00',13),(2283,4305787,'2008-11-16 19:00:00',13),(2284,4305799,'2008-11-16 19:05:00',12),(2285,4305812,'2008-11-16 19:10:00',13),(2286,4305825,'2008-11-16 19:15:00',13),(2287,4305838,'2008-11-16 19:20:00',13),(2288,4305865,'2008-11-16 19:25:00',27),(2289,4305958,'2008-11-16 19:30:00',93),(2290,4306148,'2008-11-16 19:35:00',190),(2291,4306348,'2008-11-16 19:40:00',200),(2292,4306527,'2008-11-16 19:45:00',179),(2293,4306606,'2008-11-16 19:50:00',79),(2294,4306662,'2008-11-16 19:55:00',56),(2295,4306721,'2008-11-16 20:00:00',59),(2296,4306776,'2008-11-16 20:05:00',55),(2297,4306839,'2008-11-16 20:10:00',63),(2298,4306896,'2008-11-16 20:15:00',57),(2299,4306929,'2008-11-16 20:20:00',33),(2300,4307014,'2008-11-16 20:25:00',85),(2301,4307042,'2008-11-16 20:30:00',28),(2302,4307077,'2008-11-16 20:35:00',35),(2303,4307109,'2008-11-16 20:40:00',32),(2304,4307145,'2008-11-16 20:45:00',36),(2305,4307177,'2008-11-16 20:50:00',32),(2306,4307217,'2008-11-16 20:55:00',40),(2307,4307246,'2008-11-16 21:00:00',29),(2308,4307281,'2008-11-16 21:05:00',35),(2309,4307318,'2008-11-16 21:10:00',37),(2310,4307354,'2008-11-16 21:15:00',36),(2311,4307409,'2008-11-16 21:20:00',55),(2312,4307438,'2008-11-16 21:25:00',29),(2313,4307464,'2008-11-16 21:30:00',26),(2314,4307587,'2008-11-16 21:35:00',123),(2315,4307767,'2008-11-16 21:40:00',180),(2316,4307949,'2008-11-16 21:45:00',182),(2317,4308040,'2008-11-16 21:50:00',91),(2318,4308083,'2008-11-16 21:55:00',43),(2319,4308123,'2008-11-16 22:00:00',40),(2320,4308157,'2008-11-16 22:05:00',34),(2321,4308184,'2008-11-16 22:10:00',27),(2322,4308306,'2008-11-16 22:15:00',122),(2323,4308340,'2008-11-16 22:20:00',34),(2324,4308367,'2008-11-16 22:25:00',27),(2325,4308397,'2008-11-16 22:30:00',30),(2326,4308424,'2008-11-16 22:35:00',27),(2327,4308453,'2008-11-16 22:40:00',29),(2328,4308481,'2008-11-16 22:45:00',28),(2329,4308513,'2008-11-16 22:50:00',32),(2330,4308552,'2008-11-16 22:55:00',39),(2331,4308579,'2008-11-16 23:00:00',27),(2332,4308598,'2008-11-16 23:05:00',19),(2333,4308618,'2008-11-16 23:10:00',20),(2334,4311838,'2008-11-17 15:40:00',3220),(2335,4311856,'2008-11-17 15:45:00',18),(2336,4311869,'2008-11-17 15:50:00',13),(2337,4311881,'2008-11-17 15:55:00',12),(2338,4311892,'2008-11-17 16:00:00',11),(2339,4311904,'2008-11-17 16:05:00',12),(2340,4311917,'2008-11-17 16:10:00',13),(2341,4311928,'2008-11-17 16:15:00',11),(2342,4311941,'2008-11-17 16:20:00',13),(2343,4314600,'2008-11-17 22:30:00',2659),(2344,4314623,'2008-11-17 22:35:00',23),(2345,4314675,'2008-11-17 22:45:00',52);
/*!40000 ALTER TABLE `power_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remarks_fullmoon`
--

DROP TABLE IF EXISTS `remarks_fullmoon`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `remarks_fullmoon` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `text` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `remarks_fullmoon`
--

LOCK TABLES `remarks_fullmoon` WRITE;
/*!40000 ALTER TABLE `remarks_fullmoon` DISABLE KEYS */;
INSERT INTO `remarks_fullmoon` VALUES (1,'Hide your children.'),(2,'I wouldn\'t go outside if I were you.'),(3,'My, what nice teeth you have tonight.'),(4,'Kind of creepy.'),(5,'Thank goodness Michel Jackson is retired.'),(6,'Lets go snipe hunting.');
/*!40000 ALTER TABLE `remarks_fullmoon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remarks_humid`
--

DROP TABLE IF EXISTS `remarks_humid`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `remarks_humid` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `text` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `remarks_humid`
--

LOCK TABLES `remarks_humid` WRITE;
/*!40000 ALTER TABLE `remarks_humid` DISABLE KEYS */;
INSERT INTO `remarks_humid` VALUES (1,'The rain of pain falls mainly on the plane!'),(2,'Yuck.'),(3,'Kind of wet eh?'),(4,'Slicker weather.'),(5,'I get the umbrella.'),(6,'Scuba gear required.'),(7,'Humid is doomid.'),(8,'Bet its wet.'),(9,'Wet smet.'),(10,'No need for a shower today.'),(11,'Wet as a cows toung.'),(12,'Rain in spain is a pain to sang.'),(13,'Non purple rain.'),(14,'Wet you get.'),(15,'Wet you bet.'),(16,'Bet you wet.'),(17,'Rain gear required.'),(18,'Protect the chips.'),(19,'Drier than a steam room.'),(20,'Wetter than the outback.'),(21,'Kind of humid.'),(22,'Humid enough you don\'t have to lick stamps.'),(23,'Must be raining.');
/*!40000 ALTER TABLE `remarks_humid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remarks_personal`
--

DROP TABLE IF EXISTS `remarks_personal`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `remarks_personal` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `text` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `remarks_personal`
--

LOCK TABLES `remarks_personal` WRITE;
/*!40000 ALTER TABLE `remarks_personal` DISABLE KEYS */;
INSERT INTO `remarks_personal` VALUES (1,'Are you getting fat? Where did those love handles come from?'),(2,'Your so stupid you got locked in a bathroom and peed your pants.'),(3,'Your so stupid you got locked in the grocery store and starved to death.'),(4,'Your so stupid it takes you 2 hours to watch 60 minutes.'),(5,'Your so stupid it takes you a half an hour to make minute rice.'),(6,'Your so stupid you bought a solar powered flashlight.'),(7,'Your so stupid you thought Taco Bell was a Mexican Phone Company.'),(8,'Your so stupid you bought hamburger helper thinking it came with another person.'),(9,'Your so stupid you sold your car for gas money.'),(10,'Your so stupid you thought cheerios were dough nut seeds.'),(11,'Your so stupid you fell up the stairs.'),(12,'Your so stupid you tried to steel a free sample.'),(13,'Your so stupid you can make your eyes twinkle by shining a light in your ear.'),(14,'Your so ugly you make blind kids cry.'),(15,'Your butt is so big, your taller when you sit down.'),(16,'Your so old you fart dust.'),(17,'Your so skinny you can look through a key hole with both eyes'),(18,'Your so old you took your drivers test on a dinosaur.'),(19,'Your so old the key on Ben franklins kite is the key to your apartment.'),(20,'Your so old you used to baby-sit Yoda.'),(21,'You wuss, you hit like a gnome!'),(22,'Did you just cut the cheese?'),(23,'What, you call that music? I could do better with a Sound Blaster Pro!'),(24,'What is wrong with your head? Oh, that\'s your hair? Eww!'),(25,'You\'ll be living in a van down by the river!'),(26,'You could get a job in politics.'),(27,'I could wear an I Mac case and look better than you in those clothes!'),(28,'Looks like you woke up on the wrong side of your bed today.'),(29,'Can I recomend a new hair stylist?  How about John Luke Pick ard.'),(30,'Did you forget to shower last month?'),(31,'I always wondered what ugly ment.'),(32,'Sorry, I didn\'t mean to be mean.  Its just, you look so awful.'),(33,'Does your face hurt?  Its killing me.'),(34,'My calculator could whip your computer'),(35,'Please don\'t hurt me, O great one!'),(36,'You are way better than your brother.'),(37,'Do you want a burrito? They are good!'),(38,'Your father loves you so much he will give you money to type lame remarks like this if you want.'),(39,'Yeah, you know what I\'m saying.'),(40,'You are the master of all.'),(41,'My, you look mighty fine today.'),(42,'Did I ever tell you how much I admire your left ear?'),(43,'Your hair styleing looks very stylish today.'),(44,'Nice looking outfit you have on.');
/*!40000 ALTER TABLE `remarks_personal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remarks_plants`
--

DROP TABLE IF EXISTS `remarks_plants`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `remarks_plants` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `text` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `remarks_plants`
--

LOCK TABLES `remarks_plants` WRITE;
/*!40000 ALTER TABLE `remarks_plants` DISABLE KEYS */;
INSERT INTO `remarks_plants` VALUES (1,'If you don\'t give us water, we will have to suck it out of a cute little bunny rabbit.'),(2,'Hey, desert madmen have water and they\'re only level 12!'),(3,'You can buy water for only one silver with a crude stein. Or is that too much to ask?'),(4,'Plants auction, \"Want to buy water! Will pay well! Gimme a tell.\"'),(5,'If you have enough for your toilets, surely you have enough for us!'),(6,'We all need water, except for Bob. We want him to die.'),(7,'If you don\'t water us, we will sic our coconut on you! He\'s evil, I tells ya!'),(8,'Of course, we could just cut our coconut up for milk. No! I didn\'t mean it coconut! Nooooooo! Put the feathered headdress and spears down!'),(9,'Give us water or our throats will become so dry we\'ll talk like Harry Kissinger and revert to the Ursula voice!'),(10,'Feed us or we will go on strike.'),(11,'We want water.  We must have water.   Water is good.'),(12,'You had better feed us water.  We know where you live.'),(13,'Feed us water or we will suck it out of you while you sleep.'),(14,'Pour Fa vor Senior.   Agua en la pot.  Muchas gracious.'),(15,'Give us water or we will become carnivores.'),(16,'Let\'s make a deal.  You give us water and we will give you oxygen.'),(17,'If we don\'t get water soon, we will die and become brown, ugly, works of art, and who needs more works of art around here?'),(18,'You don\'t want to get houseplants mad.  Can you spell Carbon Di-oxide?'),(19,'You should pay us a little more respect.  We were here first you know.'),(20,'If you don\'t water us, I\'ll invite my Uncle Venus over.  He is a man eating plant and he is usually really hungry.'),(21,'Please give us water.  We promise that we won\'t squirt it all over like last time.'),(22,'Water, we need water.  We are so dry, we are about to spontaneously combust!'),(23,'Whats wrong, is the sink busted again?  Or maybe it is the watering pot this time.  You always have some excuse.  Sheez!'),(24,'Paaaaaaaaaaaaaaaaaaa leeeeeeeeeeeeeeeeeeeezzzzzzzzz!  Just a little water!  I know you have it.  I\'ve seen you drink it.  '),(25,'Come on!  Water is not that hard to find.  Just grab a couple of oxygen molecules and squish them together with some of those hydrogen dudes.'),(26,'Water, please, any kind of water will do.  Except the yellow kind.'),(27,'Heres a deal for you:  You give us water, and we will not eat your children.'),(28,'Water, Koolaid, Orange Juice, Beer, Coffie, we don\'t care.  Please give us something!'),(29,'Pretty please, with a little oxygen on top.  Give us water and we won\'t bug you again ... till next week.');
/*!40000 ALTER TABLE `remarks_plants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remarks_tags`
--

DROP TABLE IF EXISTS `remarks_tags`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `remarks_tags` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `text` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1144 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `remarks_tags`
--

LOCK TABLES `remarks_tags` WRITE;
/*!40000 ALTER TABLE `remarks_tags` DISABLE KEYS */;
INSERT INTO `remarks_tags` VALUES (1,'No decorations necessary.'),(2,'Dulce bellum inexpertis.'),(3,'JUST ROOTIN\' AROUND.'),(4,'Common sense isn\'t.'),(5,'C\'est la vie.'),(6,'I\'m in shape ... round\'s a shape isn\'t it?'),(7,'((wrong && wrong) != right) '),(8,'Quoth the Raven, \"Eat My Shorts.\"'),(9,'\"Said the fly, \"Let us flee.\" Said the flea \"Let us fly.\"'),(10,'Diplomacy is saying \"nice doggy\" until you find a rock. '),(11,'I just steal \'em, I don\'t explain \'em.'),(12,'Just My Opinion (But I\'m Right!)'),(13,'Wanna giggle? Try (EDITOR=EDLIN !) in anything.'),(14,'Backup not found: (P) Panic (Any Other Key) Panic.'),(15,'Youth + confidence + myopia = naivete.'),(16,'Press <CTRL>-<ALT>-<DEL> to continue ... '),(17,'Buy a 486-33 you can reboot faster..'),(18,'An appeaser feeds a crocodile, hoping to be eaten last.'),(19,'Success is just a matter of luck.  Ask any failure.'),(20,'Irony: Giving father a billfold for Christmas.'),(21,'Every politician has a price, some hold bargain sales.'),(22,'The world is a beautiful book, for those who can read it.'),(23,'A person in a passion rides a mad horse.'),(24,'Hard work has a future payoff.  Laziness pays off now.'),(25,'Celery raw develops a jaw. But stewed, is quietly chewed'),(26,'Where there is a stink feces there is the odor of being.'),(27,'A yawn is a silent shout.'),(28,'\"A newspaper is a collection of half-injustices\"'),(29,'If this is a battle, then you have already lost.'),(30,'\"Every why hath a wherefore.\"'),(31,'An optimist is a guy without much experience... '),(32,'Life is not a spectacle or a feast, it is a predicament.'),(33,'A person is a lion in his own cause.'),(34,'Today has been a long year!!!!!!!!!!'),(35,'Any certainty is a delusion.'),(36,'\"Beulah, peel me a grape.\" '),(37,'I sighed as a lover, I obeyed as a child.'),(38,'Every crowd has a silver lining.'),(39,'Old MacDonald had a computer with EIA I/O.'),(40,'Dammit Jim, I\'m a doctor, not a tagline writer.'),(41,'Strange but not a stranger...'),(42,'He bellows like a cow standing on her tit.'),(43,'Good luck is a lazy man\'s estimate of a worker\'s success.'),(44,'Fiddle: Friction of a horse\'s tail on a cat\'s entrails.'),(45,'In this world a man must either be anvil or hammer.'),(46,'When you see a snake, never mind where he came from.'),(47,'Better to marry a man who loves you than one you love.'),(48,'Some men without a god are like fish without bicycles.'),(49,'A person without a navel lives within all of us.'),(50,'The trouble with a kitten is that, eventually it\'s a cat.'),(51,'To avoid seeing a fool, break your mirror.'),(52,'\"Woman must be a genius to create a good husband.\" Balzac'),(53,'The wife of a careless man is almost a widow.'),(54,'The mouse with a single hole is quickly caught by the cat'),(55,'I am not a dictator.  It\'s just I have a grumpy face.'),(56,'Misfortunes always enter a door left open for them.'),(57,'\"Too much of a good thing is wonderful.\" <Mae West> '),(58,'Self-made man: A horrible example of unskilled labor.'),(59,'COFFEE.COM not found: A)dd more, R)eheat F)reak out.'),(60,'The more known about people, the more to admire in dogs.'),(61,'The worst thing about censorship is . '),(62,'I never rise above the noise and confusion...'),(63,'Prosperity makes friends, adversity tries them.'),(64,'The best defense against logic is stupidity.'),(65,'The arrogance of age must submit to be taught by youth.'),(66,'Time goes? No.  Alas time stays, we go.'),(67,'When everyone thinks alike, then everyone is stupid.'),(68,'When all think alike, then no one is thinking.'),(69,'As for me, all I know is that I know nothing.'),(70,'Manuals out, after all possible keystrokes have failed.'),(71,'\"May you live all the days of your life.\" Swift'),(72,'Waiting to overcome all objections, results in nothing.'),(73,'Overestimation: Thinking that all your geese are swans.'),(74,'Be suspicious of all native-born Esperanto speakers.'),(75,'No answer is also an answer.'),(76,'Round numbers are always false.'),(77,'Friendships are not always preserved in alcohol.'),(78,'Our future is always uncertain our end is always too near'),(79,'A farmer is always going to be rich next year.'),(80,'God heals, but always someone else wants a fee.'),(81,'One who is always in a stew generally goes to pot.'),(82,'The wrong way always seems the more reasonable.'),(83,'Bureaucracy: That place always in need of a laxative.'),(84,'Sysoping, not just an adventure, sometimes it\'s emesis.'),(85,'A hen is an egg\'s way of making another egg.'),(86,'I am not an animal!  I am ... well, not an animal. '),(87,'If this were an actual tagline, it might be funny.'),(88,'If this were an actual tagline, it _might_ be funny.'),(89,'O Oysters come and walk with us, the Walrus did beseech.'),(90,'Surly to bed, and surly to rise.'),(91,'Take two crows and caw me in the morning'),(92,'\"Help! I\'ve fallen and can\'t get up.\" A. Tree'),(93,'Beware! I\'m armed and have suffered from PMS all my life.'),(94,'Wisdom of many and the wit of a half.'),(95,'Man loves little and often, woman much and rarely.'),(96,'Some nonsense now and then is relished by the wisest men'),(97,'Take egotism out, and you castrate the benefactors.'),(98,'Words, words, words.  And no place to put them all!'),(99,'There are no answers at best a few possibly good guesses.'),(100,'When you find anything that works, it usually fails.'),(101,'Adam ate the apple, and our teeth still ache.'),(102,'Pedestrian: The most approachable chap in the world.'),(103,'Shhhhhh.....the topic cops are coming'),(104,'Words and ideas are what change our world.'),(105,'Actions from sanity are not necessarily from feeling.'),(106,'Silly rabbit, tricks are for hookers!'),(107,'\"All humans things are subject to decay.\"'),(108,'The only realities are the atoms and empty space.'),(109,'Silly Wabbit, QWKs are for kids. '),(110,'\"But once you are real, you can\'t become unreal again.\" '),(111,'\"Men, in general, are but great great children\" Napoleon'),(112,'Noble deeds that are concealed are most esteemed.'),(113,'I am not arguing with you, I\'m telling you.'),(114,'Window-screen: An arrangement for keeping flies in.'),(115,'*FLASH* Energizer Bunny arrested, charged with battery.'),(116,'Architecture is the art of how to waste space.'),(117,'A nose in artificial manure is not studying nature.'),(118,'Actions are neither as good nor as evil as impulses.'),(119,'\"With our judgements as our watches, none go just alike.\"'),(120,'No one does as much harm as one going about doing good.'),(121,'I\'m as innocent as a new-laid egg.'),(122,'Sharper than an asp\'s tooth to have a thankless child.'),(123,'All reality is aspect dependent.'),(124,'Today, take an astronaut to launch.'),(125,'The best blood at times gets into fools and mosquitoes.'),(126,'Hasten to laugh at everything lest you be obliged to weep'),(127,'Childish Game: One at which your spouse beats you.'),(128,'Please don\'t yell at me.  I\'m new at this. '),(129,'\"We must laugh at man, to avoid crying for him\" Napoleon'),(130,'Sandwich: An faulty attempt to make both ends meat.'),(131,'That\'s a smug aura of respectability you see in a mirror?'),(132,'Genealogy: tracing us back to the same brother and sister'),(133,'Memoirs are the backstairs of history.'),(134,'Since GOD spelled backwards is DOG, is my poodle Satan? '),(135,'Modesty is good bait when fishing for praise.'),(136,'You tell \'em, Bald Head, You\'re smooth.'),(137,'You tell \'em Banana, You\'ve been skinned.'),(138,'You tell \'em Bank, You\'re safe.'),(139,'Look out for barking dogs that bite.'),(140,'A good dog barks when told.'),(141,'This door is baroque; please call Bach later.'),(142,'I may not be perfect, but I am all I got!'),(143,'Most allies must be watched just like the enemy.'),(144,'Caution:  Breathing may be hazardous to your health.'),(145,'Things could only be worse in Cleveland.'),(146,'Every child should be given the desire to learn.'),(147,'You tell \'em Bean, He\'s stringing you.'),(148,'A thing of beauty is in the eye of the beholder.'),(149,'Save trees, eat  beavers. '),(150,'No person ever became wicked all at once.'),(151,'History repeats itself because nobody listens'),(152,'Envy is thin because it bites but never eats.'),(153,'Misery brings strange bedfellows.'),(154,'They who drink beer will think beer.'),(155,'Where do honey bees go potty?  At a BP station naturally.'),(156,'The woman cries before the wedding; the man afterward.'),(157,'Honesty: Fear of being caught.'),(158,'It\'s hard to believe it, but some teens are humans.'),(159,'A liar isn\'t believed even when he speaks the truth.'),(160,'Beware of true believers you may be duped by a false god.'),(161,'Some thoughts are best guillotined before actions result.'),(162,'Sex isn\'t the best nor the worst thing in the world.'),(163,'We\'re off doing beta, the wonderful beta of oooz'),(164,'Old age is better than the alternative.'),(165,'Is wetter REALLY better?'),(166,'Monologue: A conversation between realtor and prospect.'),(167,'Don\'t use a big word where a diminutive one will suffice.'),(168,'If you can\'t bite, don\'t show your teeth.'),(169,'ZMODEM has bigger bits, softer blocks, and tighter ASCII.'),(170,'When no wind blows, even the weather vane has character.'),(171,'We are in bondage to the law so that we may be free.'),(172,'If it ain\'t borken, don\'t fix it.'),(173,'Boys will be boys, and so will a lot of middle-aged men.'),(174,'Fat heads, lean brains.'),(175,'You tell \'em Brake, You\'ve got the drag.'),(176,'Please!  Do not break character! '),(177,'The only heavy breathing I ever hear is after aerobics.'),(178,'Engraving is, in brief terms, the art of scratch.'),(179,'Politics: Passing the buck or passing the doe.'),(180,'An actor without buck teeth can play the Easter Bunny.'),(181,'That\'s not a bug, that\'s a feature.'),(182,'We ask advice but we mean approbation.'),(183,'Love thy neighbor, but keep the hedge in tact.'),(184,'I\'m incredibly jealous, but still glad for you.'),(185,'I\'m terribly sorry, but I\'m afraid you\'re just a mirage. '),(186,'Time is precious, but truth is more so.'),(187,'Marriage, a romance but the hero dies in the 1st chapter.'),(188,'OK, I\'m weird! But I\'m saving up to become eccentric.'),(189,'You tell \'em Butcher, You\'ve got a lot of tongue.'),(190,'Hm..what\'s this red button foº½¯°·¼NO CARRIER'),(191,'Bad officials: elected by good citizens who fail to vote.'),(192,'<<< Tagline deleted by Natl Endowment for the Arts >>>'),(193,'The mind grows by what it feeds upon.'),(194,'Birds are trapped by their feet, people by their tongues.'),(195,'This tagline stolen by Silly Little Mail Reader!'),(196,'You tell \'em cabbage, You\'ve got the head.'),(197,'You tell \'em calendar, You\'ve got lots of dates.'),(198,'It\'s okay to call someone stupid; just don\'t prove it.'),(199,'Only the stupidest calves chose their own butcher.'),(200,'Even the blind can see money.'),(201,'Of course I can cook, but I never do it on the first date'),(202,'A thick head can do as much damage as a hard heart.'),(203,'A red nose can be the result of sunshine or moonshine.'),(204,'Few of us can stand prosperity -- someone else\'s.'),(205,'Genius: One who can do anything except earn a living.'),(206,'By trying we can learn to endure another\'s adversity.'),(207,'A good tree cannot bring forth evil fruit.'),(208,'Without fingers you cannot even thumb your nose.'),(209,'\"Oh captain! my captain! our fearful trip is done.\" WW'),(210,'Collector: Person few care to see but ask to call again.'),(211,'If you don\'t care where you are, then you can\'t get lost.'),(212,'Judge not a carpenter on how fast chips fly.'),(213,'A jug is carried under your coat for a dishonest reason.'),(214,'You tell \'em Cashier, I\'m a poor teller.'),(215,'To the old cat, the tender mouse.'),(216,'You tell \'em Cat, That\'s what you\'re fur.'),(217,'Gotta run, the cat\'s caught in the printer.'),(218,'If one cannot catch a bird of paradise, grab a wet hen.'),(219,'The highest bidder catches the most politicians.'),(220,'You tell \'em Cemetery, You are so grave.'),(221,'Adventure is the champagne of life.'),(222,'Getting a second chance is never a certainty.'),(223,'Everything changes except change itself.'),(224,'When in doubt; Cheat !'),(225,'\"Man\'s the bad child of the universe.\" Oppenheim'),(226,'HELP! Protect America\'s children, soil, and water today.'),(227,'You tell \'em Chloroform, You can put them to sleep.'),(228,'Jury: A group chosen to decide who has the best lawyer.'),(229,'You tell \'em Church Bell, I told you.'),(230,'You tell \'em Cigarette, You\'re lit up.'),(231,'The devil can cite Scripture for his purpose.'),(232,'To be too clever is to be stupid.'),(233,'Choose heaven for climate, hell for society.'),(234,'You tell \'em Clock, You\'ve got the time.'),(235,'Unable to locate Coffee -- Operator Halted!'),(236,'It was so cold, I almost got married.'),(237,'Save the whales. Collect the whole set.'),(238,'When the bad combine, the good must associate.'),(239,'The World: A comedy for thinkers; a tragedy for feelers.'),(240,'The world is coming to an end!'),(241,'Don\'t steal.....Politicians hate competition.'),(242,'Born crying, live complaining, die disappointed.'),(243,'Whatever is well conceived can be well expressed.'),(244,'Reality: Only a concept and the home of the brave.'),(245,'Only hey can conquer who believe they can.'),(246,'Nothing is ever constant, unless it is dead. '),(247,'We have resumed control...we have resumed control...'),(248,'It\'s a poor cook who cannot lick his own fingers.'),(249,'A sleeping fox counts hens in his dreams.'),(250,'Pants: Trousers\' country cousins.'),(251,'Many would be cowards if they had courage enough.'),(252,'Society prepares the crime; the criminal commits it.'),(253,'Straight trees have crooked roots.'),(254,'A good rooster crows in any hen house.'),(255,'What youth deemed crystal, age finds was dew.'),(256,'You tell \'em Cucumber, I\'ve been pickled.'),(257,'No medicine can cure a vulgar person.'),(258,'It\'s easier to curse the candle than light the darkness.'),(259,'You tell \'em Custard Pie, You\'ve got the crust.'),(260,'Other times, other customs.'),(261,'Cynicism is intellectual dandyism.'),(262,'Clever father, clever daughter; clever mother, clever son'),(263,'Today is a day for making firm decisions!!!!!  Or is it?'),(264,'Each day a day goes by.'),(265,'I\'ve had BETA days ... and nights!!!'),(266,'Happy couple: A deaf husband and a blind wife.'),(267,'Skeptics are seldom deceived.'),(268,'Let no good deed go unpunished.'),(269,'There is no defense except stupidity against a new idea.'),(270,'Fishing is a delusion surrounded by liars in old clothes.'),(271,'Living: The best demonstration of victory over mortality.'),(272,'You tell \'em Dentist, You\'ve got the pull.'),(273,'You tell \'em Dictionary, You\'re full of information.'),(274,'\"Old soldiers never die, they just fade away..\"'),(275,'Old musicians never die, they just decompose.'),(276,'Not everything more difficult is more meritorious.'),(277,'A gentleman can disagree without being disagreeable.'),(278,'America was not discovered by Americans, shame on them.'),(279,'Talking is another disease of age.'),(280,'On a clear disk you can seek forever.'),(281,'I had a dislocated funny bone, <OUCH> but it\'s better now'),(282,'Detour: The roughest distance between two points.'),(283,'Those without heads do not need hats.'),(284,'How many times do you need to be tolled anyway? '),(285,'It\'s 11:56 pm. Do you know where your modem is?'),(286,'Those who can, Do. Those who can\'t, Criticize.'),(287,'You tell \'em Doctor, You\'ve got the patience.'),(288,'Raising your voice does not reinforce your argument.'),(289,'Dachshund: Half a dog high by a dog and a half long.'),(290,'Even a noseless dog can stink.'),(291,'An inch of dog is better than a mile of pedigree.'),(292,'You tell \'em Dough, You\'re well bred.'),(293,'When we can\'t dream the time for death has arrived.'),(294,'America is a dream to most of the world.'),(295,'Camels have wet dreams too.'),(296,'Only in your dreams are you really free.'),(297,'Time is the dressmaker specializing in alterations.'),(298,'What soberness conceals, drunkenness reveals.'),(299,'Users: Keep them dry and don\'t feed them after midnight.'),(300,'And God said: E = «mvý - Zeý/r ...and there *WAS* light!'),(301,'\"Earth was not earth before her sons appeared.\"'),(302,'Character is much easier kept than recovered.'),(303,'If you don\'t eat garlic, they\'ll never smell it on you.'),(304,'Cats, proof that eating and sleeping isn\'t all bad.'),(305,'Dan Quayle: the EDLIN of Vice-Presidents.'),(306,'Scrute the inscrutable;  eff the ineffable.'),(307,'Every hard-boiled egg is yellow inside.'),(308,'Apology is only egotism wrong side out.'),(309,'You tell \'em Electricity, You can shock \'em.'),(310,'Silence is more eloquent at times than words.'),(311,'Outside noisy, inside empty.'),(312,'Madre que consiente engorda una serpiente.'),(313,'This fellow\'s wise enough to play the fool.'),(314,'Adult: One old enough to know better.'),(315,'Excess is never enough.'),(316,'You tell \'em Envelope, You\'re well posted.'),(317,'The cautious seldom err.'),(318,'The child had every toy his father wanted.'),(319,'Communication.. without it, everyone\'s a mushroom.'),(320,'I can resist everything except temptation.'),(321,'I can resist everything/anything except temptation.'),(322,'PCs are OK except when you use them as bowling balls.'),(323,'Stupidity is no excuse for not thinking.'),(324,'Assassination is the extreme form of censorship.'),(325,'Poker Face: The face that launched a thousand chips.'),(326,'If you don\'t fall down, you\'re not trying!'),(327,'The ripest fruit falls first..'),(328,'\"Modesty died when false modesty was born.\" Mark Twain'),(329,'A great many family trees were started by grafting.'),(330,'The greatest of faults is to be conscious of none.'),(331,'Both of his feet are firmly planted in the air.'),(332,'Bachelor: Plays the field until the field comes in.'),(333,'His face was filled with broken commandments.'),(334,'Don\'t knock President Fillmore; he kept us out of VietNam'),(335,'Notice: All incoming fire has the right of way.'),(336,'To live now, first come to terms with your past.'),(337,'God made the first garden, Cain the first city.'),(338,'Ivo Andric - Yugoslavia\'s First Nobel Laureate.'),(339,'Learning makes people fit company for themselves.'),(340,'Where are those flashbacks they promised me?'),(341,'\"Don\'t worry, I\'m fluent in weirdo\"'),(342,'\"Oh could I fly, I\'d fly with thee ...\"'),(343,'Seek not to follow footsteps but what they sought.'),(344,'Words are not food, though sometimes we must eat them.'),(345,'Meetings are indispensable for not doing anything.'),(346,'SHIN - A device for finding furniture in the dark.'),(347,'Nickel: Once good for getting the wrong number with.'),(348,'Solution Series: Works for Windows, Publisher and Money'),(349,'A fool searches for a greater fool to find admiration.'),(350,'Are you waiting for your prey?'),(351,'What are friends for? - R.M. Nixon'),(352,'Wait!  That\'s the FORBIDDEN dance! '),(353,'You aren\'t here forever, Enjoy each day as a miracle.'),(354,'Life is lived forwards, but understood backwards.'),(355,'Swell-head: Nature\'s frantic effort to fill a vacuum.'),(356,'\"A book, a friend, a song, a glass, a chaste loving lass\"'),(357,'A pest: A friend in need.'),(358,'Young gorillas are friendly, but they soon learn.'),(359,'Mischief all comes from too much opening of the mouth.'),(360,'Genealogy. Tracing descent from someone who didn\'t.'),(361,'Cats are like furry dilettanti, or the reverse? '),(362,'You tell \'em Gambler, You\'ve got winning ways.'),(363,'Security is a game but the final goal is never reached.'),(364,'The thing most generally raised on land is taxes.'),(365,'Everyone is a genius at least once a year.'),(366,'Criminal: One who gets caught.'),(367,'Even a philosopher gets upset with a toothache.'),(368,'Monotheism is a gift from the gods!'),(369,'Angling: The name given to fishing by non-fishermen.'),(370,'Remember................. Wherever you go, there you are.'),(371,'Mosquito: Designed by God to make flies seem better.'),(372,'Those whom the gods love grow young.'),(373,'\"I thank whatever gods may be for my unconquerable soul.\"'),(374,'Against stupidity, the Gods themselves, contend in vain !'),(375,'A pitcher that goes to a well too often is broken first.'),(376,'As I was going up the stair, I met a man who wasn\'t there'),(377,'You tell \'em Goldfish, You\'ve been around the globe.'),(378,'Obesity: A surplus gone to waist.'),(379,'This is a good day to let down old friends who need help.'),(380,'Women take to good hearted men. Also from.'),(381,'Hero-worship: Idol gossip.'),(382,'No person should govern another without their permission.'),(383,'Misteaching: Telling one\'s grandmother how to suck eggs.'),(384,'Dancing with a grass widow brings on hay fever.'),(385,'Always do right: Gratify some and astonish the rest.'),(386,'Epitaph on a gravestone: Cheerio, see you soon.'),(387,'Many foxes grow gray, but few grow good.'),(388,'\"Life has a great deal up its sleeve.\" '),(389,'Greed is good, greed works.'),(390,'Make two grins grow where there was only a grouch before.'),(391,'Today I have grown taller from walking with the trees.'),(392,'I wish Adam had died with all his ribs in his body.'),(393,'If youth only had a chance or old age any brains.'),(394,'Well begun is half done.'),(395,'A big enough hammer fixes anything'),(396,'Use your enemy\'s hand to catch a snake.'),(397,'Politics: The glad hand and the marble heart.'),(398,'Many kiss the hand that they wish cut off.'),(399,'Money can\'t buy happiness, but allows a choice of misery.'),(400,'Freedom is a hard-bought thing - A gift no man can give.'),(401,'A miser is hard to live with, but makes a fine ancestor. '),(402,'A miser is hard to live with, but makes a fine ancestor. '),(403,'Old birds are hard to pluck.'),(404,'That\'s right, try hard to be good at the game of life.'),(405,'You tell \'em Hard-Boiled Egg, You\'re hard to beat.'),(406,'Back Up My Hard Drive? I Can\'t Find The Reverse Switch! '),(407,'Carelessness does more harm than a want of knowledge.'),(408,'A KGB keyboard has no <ESC> key!'),(409,'Even the lion has to protect himself against flies.'),(410,'The Caldecott Tunnel has less traffic than that vagina.'),(411,'Friend: Anyone who has the same enemies you have.'),(412,'How much memory have you got?  One brain, one memory.'),(413,'Some settling may have occurred in shipping. '),(414,'Thousands of journeys have a start but no end.'),(415,'Drop your carrier...We have you surrounded! '),(416,'Sir Lancelot, you have chain mail in Knight\'s Conf'),(417,'Only the rich have distant relatives.'),(418,'Teaching: Appearing to have known your subject forever.'),(419,'Do well, you hear it never. Do ill, hear it forever.'),(420,'\"Shake off your heavy trance! And leap into a dance.\"'),(421,'A little truth helps the lie go down.'),(422,'What we have here is a failure to communicate.'),(423,'So crowded in here, I must go outside to change my mind!'),(424,'If I were here more often, I wouldn\'t be gone so much.'),(425,'Evil is a hill.  We stand on ours, speak about others.'),(426,'To a dog his owner is Napoleon; hence their popularity.'),(427,'It\'s only a hobby ... only a hobby ... only a.'),(428,'Fiction: It can\'t hold a scandal to biography.'),(429,'Charity begins at home, and mostly ends where it begins.'),(430,'Fishing rod: a hook at one end, a fool at the other.'),(431,'You tell \'em Horse, You carry a tale.'),(432,'If wishes were horses, beggars would ride.'),(433,'Tact is knowing how far to go in going too far.'),(434,'To be a human without passion is to be dead.'),(435,'You tell \'em Hunter, I\'m game.'),(436,'The truth doesn\'t hurt unless it ought to.'),(437,'Fear not, for I have given you authority '),(438,'To the Caliph I am dirt, but to dirt, I am Caliph.'),(439,'\"Frankly my dear, I don\'t give a download!\" -Rhett Sysop'),(440,'If I die, I forgive you, if I recover, we shall see.'),(441,'Not now ... I have to go mow the laundry.'),(442,'As long as I live, I shall be, myself, no other, just me.'),(443,'Trust me, would I lie to you..... TWICE?'),(444,'To whom should I go to for some self-help?'),(445,'Shut up, or I\'ll nail your other foot to the floor.'),(446,'\"I\'m so bored, I\'m starting to miss my husband.\"'),(447,'I think that I\'m the friendliest guy in my zipcode.'),(448,'--T-A+G-L-I+N-E--+M-E-A+S-U-R+I-N-G+--G-A+U-G-E--.'),(449,'It works better if you plug it in *AND THEN* turn it on.'),(450,'Youngsters remember anything if it happened or not.'),(451,'It works better if you plug it in where it should be.'),(452,'Is it progress if a cannibal uses a knife and fork?'),(453,'The greater the ignorance the greater the dogmatism.'),(454,'Power is an illusion; only stupidity is real.'),(455,'Planned parenthood --- the impossible dream.'),(456,'We all live in a yellow subroutine.'),(457,'One who is in peril thinks with their legs.'),(458,'Blessings never come in pairs; misfortunes never alone.'),(459,'It is hereditary in my family to have no children.'),(460,'What is learned in youth is understood in age.'),(461,'ROM wasn\'t built in a day.'),(462,'He who falls in love with himself will have no rivals.'),(463,'Don\'t hate yourself in the morning - sleep till noon.'),(464,'Do not sleep in a eucalyptus tree tonight.'),(465,'There\'s no skeletons in my closet! '),(466,'A jerk present in a group indicates a jerk in charge.'),(467,'When uncertain, or in doubt, run in circles and scream.'),(468,'\"A Robin redbreast in a cage puts all heaven in a rage.\"'),(469,'Instinct is intelligence incapable of self-consciousness.'),(470,'Corruption. The most infallible symptom of liberty.'),(471,'Human Being: An ingenious assembly of portable plumbing.'),(472,'Tact is the intelligence of the heart.'),(473,'Worry is the interest paid on trouble in advance.'),(474,'All rivers run into the sea, yet the sea is not full.'),(475,'Travel important today;  IRS men arrive tomorrow.'),(476,'A learned fool is more foolish than an ignorant fool.'),(477,'At 19, everything is possible; tomorrow looks friendly.'),(478,'The greatest fault is to be conscious of none.'),(479,'When all else is lost, the future still remains.'),(480,'Living on earth is better than loafing around Hades.'),(481,'The worst hatred is that of relatives.'),(482,'One person\'s <grin> is another\'s <groan>.'),(483,'To tolerate everything is to teach nothing.'),(484,'The greatest cunning is to have none at all.'),(485,'Talking of bulls is not like being in the bull ring.'),(486,'The shortest answer is doing.'),(487,'A good memory is one trained to forget the trivial.'),(488,'The only certainty is that nothing is certain.'),(489,'Hi.  My name is Rover, I\'ll paint your car yellow free.'),(490,'A belly button is for salt when you eat celery in bed.'),(491,'Society like air, is necessary but not complete for life.'),(492,'The best armor is to keep out of range.'),(493,'Too often justice is incidental to law and order.'),(494,'Not to know is bad, but not to wish to know is worse.'),(495,'The best doctor is the one you run for and can\'t find.'),(496,'Non-fiction often is more unrealistic than fiction.'),(497,'The trodden path is the safest.'),(498,'Rebellion to tyrants is obedience to God.'),(499,'An accommodating vice is better than an obstinate virtue.'),(500,'Firmness in politics is called obstinacy in a donkey.'),(501,'Learning without thought is labor lost.'),(502,'A good scare is better than good advice.'),(503,'A leap year is never a good sheep year.'),(504,'A lawyer\'s opinion is worth nothing unless paid for.'),(505,'A hen tomorrow is more valuable than an egg today.'),(506,'A leap year is never a good sheep year.'),(507,'To do nothing is in every person\'s power.'),(508,'Unless to thought is added will, Apollo is an imbecile.'),(509,'Acting without thinking is like shooting without aiming.'),(510,'The living world is a continuum in each and every aspect.'),(511,'A verbal contract isn\'t worth the paper its written on'),(512,'If you find it, it is always in the last place you look.'),(513,'Love your enemies -- it makes them so damned mad.'),(514,'What good does it do an ass to be called a lion?'),(515,'I finally got it all together, but forgot where I put it'),(516,'Good printers do it without wrinkling the sheets.'),(517,'Money is round, it rolls away.'),(518,'Your sin, was it of omission, commission, or emission?'),(519,'I don\'t want it now, I want it RIGHT now!'),(520,'\"To live long, it is necessary to live slowly.\" Cicero'),(521,'Difficult? I wish it had been impossible!'),(522,'Yield to temptation; It may not pass your way again.'),(523,'Spaghetti code = job security.'),(524,'There is no joy in Mudville, mighty Casey has struck out.'),(525,'The Day of Judgement is approaching, or it is not.'),(526,'You tell \'em June, And don\'t July.'),(527,'My reality check just bounced.'),(528,'What the heck just happened here? '),(529,'Poker: It\'s darkest just before you\'ve drawn.'),(530,'Santa\'s elves are just a bunch of subordinate Clauses.'),(531,'Nobody can be just like me. Even I have trouble.'),(532,'Retreat hell! We\'re just fighting in another direction.'),(533,'Humpty Dumpty DOS - Just a shell of himself.'),(534,'Little boats should keep near the shore.'),(535,'DANGER! Human at keyboard! '),(536,'Drink! for you know not whence you came, nor why...'),(537,'To live well, know the difference between good and evil.'),(538,'Psychic Con: You know where and when '),(539,'Drink! for you know not why you go, nor where...'),(540,'A child prodigy knows not to bother with it.'),(541,'To climb a ladder, you begin with the first rung.'),(542,'Tact: Recalling a lady\'s birthday but forgetting her age.'),(543,'No wonder can last more than three days.'),(544,'Consistency is the last refuge of the unimaginative.'),(545,'\"Our first and last love is -- self-love.\" Bovee'),(546,'Happiness is no laughing matter.'),(547,'Custom is the law of fools.'),(548,'He is no lawyer who cannot take two sides. '),(549,'A hen who lays an egg cackles as if it was an asteroid.'),(550,'Philosophy: A route leading from nowhere to nothing.'),(551,'One lie always leads to another.'),(552,'I\'d give my left arm to be ambidextrous '),(553,'ATTENTION ..............Elvis has left the echo.'),(554,'\"And God said, Let there be light: and there was light.\"'),(555,'Beware when God lets loose a thinker on this planet.'),(556,'The tree of liberty is watered with the blood of tyrants.'),(557,'A beard signifies lice, not brains.'),(558,'Art is a lie that makes us realize the truth.'),(559,'\"What is a lie but the truth in masquerade.\" Byron'),(560,'All your future lies beneath your hat.'),(561,'A well-written life is as rare as a well-spent one.'),(562,'That concept looks like a chicken in a windstorm.'),(563,'Nobody can be like me. Even I have trouble doing so.'),(564,'Network management is like trying to herd cats... '),(565,'Things are more like they used to be than they are now.'),(566,'The earth is like a tiny grain of sand, only heavier'),(567,'The world is like a cactus except the pricks are inside.'),(568,'Stupidity has no limits, genius does.'),(569,'Let\'s have a little fun, let\'s do a pun.'),(570,'Better to understand little than misunderstand a lot.'),(571,'Think much, speak little, and write less.'),(572,'I\'d like to live like a poor person with lots of money.'),(573,'I want to live with a synonym girl... '),(574,'God dislikes money -- look who he gives it to.'),(575,'Civilized people need love for full sexual satisfaction.'),(576,'It\'s love, it\'s love that makes the world go round.'),(577,'Everyone as they loveth, some people kiss cows.'),(578,'Usually insane; in lucid moments merely stupid.'),(579,'It is bad luck to be superstitious.'),(580,'Diplomacy: The patriotic lying for one\'s country.'),(581,'We are as made by God us, and often a great deal worse. '),(582,'If you can\'t make it work, make a statistic of it.'),(583,'When you can\'t make it GOOD, make it BIG!'),(584,'Two writes don\'t make a novel!'),(585,'Silver and gold make even pigs seem clean.'),(586,'The wildest colts make the best steeds.'),(587,'Too many pages make a tome.'),(588,'Money: A mint makes it first and we try to make it last.'),(589,'Bigamist: One who makes the same mistake twice.'),(590,'Behind every successful man stands a surprised MIL.'),(591,'A truly wise man never plays leapfrog with a moose.'),(592,'\"A man\'s a man for a\' that!\" Burns'),(593,'A worthless wise man always charms the rabble.'),(594,'Man\'s inhumanity to man makes countless thousands mourn.'),(595,'You tell \'em Manicurist, I\'ve been trimmed.'),(596,'He has too many lice to feel an itch.'),(597,'\"Every woman should marry -- and no man.\" Disraeli'),(598,'\"All clowns are masked, all personae flow from choices\"'),(599,'Fame: Chiefly a matter of dying at the right moment.'),(600,'Does it really matter which cola I drink?'),(601,'What a day may bring, a day may take away.'),(602,'Scotty! Hurry! Beam me uragg^*úþœ NO CARRIER'),(603,'Do you like me for my brain, or my BAUD?'),(604,'Never agree with me, it shakes my self confidence.'),(605,'Where you\'ve been means much less than where you\'re going'),(606,'Blessed are the meek, for they make great scapegoats.'),(607,'\"Love -- a grave mental disease.\"  Plato'),(608,'\"Maytag\" is my middle name; I\'m an agitator.'),(609,'To keep your milk sweet, leave it in the cow.'),(610,'Theater: Holding a mirror up to a keyhole.'),(611,'To understand other\'s miseries, look at their pleasures.'),(612,'Man is the missing link between apes and human beings.'),(613,'Computers don\'t make mistakes, but foolish people do.'),(614,'Flattery is counterfeit money, circulated by vanity.'),(615,'You tell \'em Moon, You\'re out all night.'),(616,'\"Everything\'s got a moral if only you can find it.\" '),(617,'What fools these morals be!'),(618,'There\'s always 1 more SOB than you counted on'),(619,'The wise learn more from fools than fools from the wise.'),(620,'Cow\'s breath attracts mosquitoes and tsetse flies!'),(621,'He is the most sensible looking man talking nonsense.'),(622,'Leisure is the mother of philosophy.'),(623,'Russian Express Card motto: Don\'t leave home!'),(624,'You tell \'em Mountain, I\'m only a bluff.'),(625,'An elephant: A mouse built to government specifications.'),(626,'Honey in the mouth and knives in the heart.'),(627,'Civilization is a movement, it is a voyage not a harbor.'),(628,'You must know much before you know how little you know.'),(629,'You learn as much by writing as you do by reading.'),(630,'If you throw mud,  you will have dirty hands.'),(631,'None but a mule denies his family.'),(632,'Mister!  Here\'s your mule! '),(633,'Rap is to music as Etch-A-Sketch is to art. '),(634,'With foxes we must play the fox.'),(635,'Philosophic enjoyment = mutual  misunderstanding.'),(636,'I may have my faults, but being wrong ain\'t one of them.'),(637,'I haven\'t lost my mind..It must be backed-up somewhere.'),(638,'I use windows...on my car, on my house, but not on my...'),(639,'If you want my advice, pay me!'),(640,'hAS ANYONE SEEN MY cAPSLOCK KEY?'),(641,'Ethics is not necessarily the handmaiden of theology.'),(642,'Children have more need of models than of critics.'),(643,'What this country needs is a good five-cent nickel.'),(644,'Remember, the end never justifies the meanness.'),(645,'The sun is never the worse for shining on a dunghill.'),(646,'Women and elephants never forget real or supposed injury.'),(647,'\"Women and elephants never forget.\" Parker'),(648,'Just got a new car for my wife... Great trade... '),(649,'\"God said, \"Let Newton be!\" and all was light.\" Pope'),(650,'Homo sum; humani nihil a me alienum puto.'),(651,'An atheist has no invisible means of support.'),(652,'Beauty faded has no second spring.'),(653,'Judicial reform is no sport for the short-winded.'),(654,'Where there is no shame, there is no honor.'),(655,'En boca cerrada no entran moscas.'),(656,'Easy as pie, no fuss, no muss, no crust....'),(657,'Dios tarda pero no olvida.'),(658,'When we are not sure, we are alive.'),(659,'The past is not what it will be.'),(660,'The cinema is not a slice of life but a piece of cake.'),(661,'Closed eyes are not always sleeping. '),(662,'The future is not what it used to be.'),(663,'The consumer is not a moron, it is your spouse.'),(664,'Incorrigible punster -- do not incorrige!'),(665,'\"The law hath not been dead, though it hath slept.\" Shake'),(666,'The city is not a concrete jungle.  It is a human zoo.'),(667,'Education which is not modern, faces the organic fate.'),(668,'A crappie is not a sunfish found in a toilet.'),(669,'Honesty pays, but not enough for some.'),(670,'It\'s nobody\'s business, not even mine.'),(671,'A mother is not a dust rag.'),(672,'A bigot will not reason, a fool cannot, a slave dare not.'),(673,'Art is vision not expression.'),(674,'One crow will not peck out another crow\'s eyes.'),(675,'All things change, nothing is extinguished.'),(676,'A hole is nothing, but you can break your neck in it.'),(677,'Man: There is nothing more miserable and more arrogant.'),(678,'God gives the nuts, but He does not crack them.'),(679,'Penguin: The headwaiter of the Antarctic.'),(680,'This open hand of desire wants everything.'),(681,'Vulgarity: The conduct of others.'),(682,'Oh well, half of one, six dozen of the other. '),(683,'In the country of the blind, the one-eyed man is king.'),(684,'A living example of Artificial Intelligence.'),(685,'Graveyards are full of the indispensable.'),(686,'Shake, a man of note, wrote so many things to quote.'),(687,'.... a deluge of words and drop of sense.'),(688,'The only winner of the War of 1812 was Tchaikovsky.'),(689,'A male rite of passage: Writing your name in the snow.'),(690,'Often the test of courage is not to die but to live.'),(691,'The eventual supremacy of reason should be accepted.'),(692,'Admiration: Polite recognition of self-reflection.'),(693,'Psychoceramics: The study of crackpots.'),(694,'Solve the problems of the world: Vote anarchist.'),(695,'Rainforest: a scarcity of animals a plethora of tourists.'),(696,'Endocannibalism: The result of a really hungry cannibal.'),(697,'\"The first sigh of love is the last of wisdom.\" Bret'),(698,'Every valuable idea offends someone.'),(699,'Lean books are often larded with the fat of others\' works'),(700,'Blond Mating Call:  Oh, I\'m so drunk [giggle]!!'),(701,'If you\'re too old to learn, you were born so.'),(702,'Marriages are based on believing you won the arguments.'),(703,'Since life goes on - you might as well get on with it.'),(704,'The Devil falls on account of his gravity.'),(705,'If God lived on earth, people would break his windows.'),(706,'Knowledge rests not on truth alone, but upon error also.'),(707,'The truth is one thing that nobody will believe.'),(708,'All for one; one for all; ME above all!'),(709,'An ass thinks one thing, his rider another.'),(710,'\"Let\'s win this one and go home.\" - George A. Custer '),(711,'An agreeable person: One who agrees with you.'),(712,'Life is an onion and one peels it crying.'),(713,'Don\'t shoot! I\'m only the Casio player! '),(714,'Everybody is ignorant, only on different subjects.'),(715,'This tagline is only for the living.'),(716,'He is not only dull within, but causes dullness without.'),(717,'Many receive advice, only the wise profit by it.'),(718,'People are the only creatures with the power of laughter.'),(719,'America'),(720,'Marriage is the only adventure open to the cowardly.'),(721,'You tell \'em Operator, You\'ve got their number.'),(722,'Drama in her opinion is knowing how to fill a sweater.'),(723,'Radical: Anyone whose opinion differs from ours.'),(724,'Beware of the opinion of someone without any facts.'),(725,'Ever wonder why Oprah spelled backwards is Harpo?'),(726,'Lunatic asylum: where optimism most flourishes.'),(727,'Either he\'s dead or my watch has stopped.'),(728,'Adam\'s Rib: The original bone of contention.'),(729,'Shame is an ornament to the young, a disgrace to the old.'),(730,'The best way out of a difficulty is through it.'),(731,'When puns are outlawed only outlaws will have puns'),(732,'\"The only victory over love is flight.\"  Napoleon'),(733,'I can\'t be overdrawn, I still have checks! '),(734,'You tell \'em Owl, You\'re wise.'),(735,'We make our own fortunes and call them our fate.'),(736,'Quien da el pan impone la ley.'),(737,'Love truth but pardon error.'),(738,'Chance makes our parents, but choice makes our friends.'),(739,'Hello, I am part number ³ºÞº³º³Û³ºÝ³ºÝ³³.'),(740,'Confirmation of the past is often the greatest surprise.'),(741,'Tips: Wages we pay other people\'s hired help.'),(742,'Mountains culminate in peaks, and nations in people.'),(743,'All words are pegs on which to hang ideas.'),(744,'All words are pegs on which to hang ideas.'),(745,'Guns don\'t kill people, off-line readers do.'),(746,'Of all the people I have met, you are certainly one'),(747,'Whenever Possible, Put People On Hold '),(748,'Sinner: A stupid person who gets found out.'),(749,'Strength of mind: Person who can eat one salted peanut.'),(750,'No sense being pessimistic.  It wouldn\'t work anyway. '),(751,'You tell \'em Piano, You\'re upright and square.'),(752,'Hollywood is like Picasso\'s bathroom.'),(753,'\"Man is a piece of the universe made alive.\" Emerson'),(754,'Whoso diggeth a pit shall fall therein.'),(755,'Restaurant: An eating place that does not sell drugs.'),(756,'Art is either plagiarism or revolution.'),(757,'Originality is undetected plagiarism.'),(758,'You tell \'em playing cards, You know the joker.'),(759,'Reader not found, please notify tagline.'),(760,'It is double pleasure to deceive the deceiver.'),(761,'\"A pound of pluck is worth a ton of luck.\"  Garfield'),(762,'*NOW* is a point in time that is already gone.'),(763,'That was a pointing device? My cat thought it was dinner.'),(764,'Bedfellows make strange politicians.'),(765,'The purification of politics is an iridescent dream. '),(766,'Ambition destroys its possessor.'),(767,'Never underestimate the power of human stupidity.'),(768,'Keyboard not connected, press <F1> to continue.'),(769,'I do not pretend to know what the ignorant are sure of.'),(770,'A ounce of pretension = a pound of manure!'),(771,'You tell \'em Printer, I\'m not your type.'),(772,'As lacking in privacy as a goldfish.'),(773,'Morality is a private and costly luxury.'),(774,'College: Guarantee the quality of the product or return.'),(775,'Assumption #1: Dan Quayle is smarter than broccoli.'),(776,'Dime de lo que blasonas, y te dire de lo quwe careces.'),(777,'Fax me no questions, I\'ll Fax you no lies!'),(778,'\"Heaven has no rage like love to hatred turned.\" Congreve'),(779,'You tell \'em Railroad, It\'s not along my line.'),(780,'Sailors curse the rain that farmers prayed for in vain.'),(781,'f u cn rd ths, u cn gt a gd jb n cmptr prgmmng '),(782,'I used to read books.  Now I read .qwk files. '),(783,'Prejudice is the reason of fools. Voltaire.'),(784,'Praise: What you receive when you are no longer alive.'),(785,'We are all related...relatively speaking '),(786,'Computers can never replace human stupidity.'),(787,'Art does not reproduce the visible; it makes visible.'),(788,'Disease is the retribution of an outraged nature.'),(789,'Actions are usually right, but the reasons seldom are.'),(790,'To know the road ahead, ask those coming back.'),(791,'Doubt is the root of education, not faith.'),(792,'Once uttered, words run faster than the horses i bet on.'),(793,'Ostrich: He often runs so fast he leaves himself behind.'),(794,'Carasvemos, corazones no sabemos.'),(795,'Self-sacrifice: to sacrifice others without blushing.'),(796,'Art for art\'s sake is a philosophy of the well-fed.'),(797,'Nobody shoots at Santa Claus.'),(798,'Stulti timent fortunam sapientes ferunit.'),(799,'Being able to say NO is the root to reclaiming your life.'),(800,'If three people say you are an ass, put on a bridle.'),(801,'Today is the scene of the accident.'),(802,'Iron sharpens iron; scholar, the scholar.'),(803,'Art is I; Science is We.'),(804,'Sub omni lapide scorpio dormit.'),(805,'\"Beam me aboard, Scotty.\" \"Sure. Will a 2x10 do?\"'),(806,'Quien con perros se acuesta con pulgas se levanta.'),(807,'Put on your seatbelt. I\'m gonna try something new. '),(808,'All sentences that seem true should be questioned.'),(809,'A wise person sees as much as ought, not as much can.'),(810,'He is a self-made man, and worships his creator.'),(811,'\"Everyone lives by selling something.\" - R.L. Stevenson '),(812,'You tell \'em September Morn, No one has anything on you.'),(813,'How do I set my Laser Printer to \"Stun\"?'),(814,'Boot & ye shall see. Replace & all will be made clear.'),(815,'Let art alone. She\'s got enough guys sleeping with her.'),(816,'He is a sheep in sheep\'s clothing.'),(817,'You tell \'em Shoemaker, You know awl.'),(818,'You realize how short a month when you pay alimony.'),(819,'God gave burdens shoulders also.'),(820,'Si jeunesse savoit, si vieillesse pouvoit.'),(821,'Movement To Ban Silly Tag Lines; Send Donations to:'),(822,'You tell \'em Simon, I\'ll Legree.'),(823,'It is a sin peculiar to people to hate their victims.'),(824,'Angels can fly since they take themselves lightly.'),(825,'Money is the sinews of both love and war.'),(826,'Of all thirty-six alternatives, running away is best.'),(827,'If the family skeleton must remain, make it dance.'),(828,'There is a skeleton in every old house.'),(829,'Doctrine is the skin of truth set up and stuffed.'),(830,'Never trust a skinny cook. '),(831,'You tell \'em Skyscraper, You have more than one story.'),(832,'Nothing is so smiple that it can\'t get screwed up.'),(833,'Don\'t be a snob. Never lie when truth is more profitable.'),(834,'Old age isn\'t so bad when you consider the alternative.'),(835,'My mind ain\'t so open that anything can crawl right in. '),(836,'Subway: A place so crowded even men can\'t all get seats.'),(837,'Why are there so many gnarly limbs on my family tree? '),(838,'if you want someone to keep a secret, keep it yourself.'),(839,'Teamwork gives you someone else to blame.'),(840,'Nature, like people sometimes weeps for gladness.'),(841,'The deeper the sorrow, the less tongue hath it.'),(842,'It\'s a poor sort of memory that only works backwards.'),(843,'You may be Southern -- but you\'re no Comfort.'),(844,'Computers also eliminate spare time.'),(845,'She devotes her spare time to neglecting duties.'),(846,'Wit is the spice of conversation, not the food.'),(847,'Army food: The spoils of war.'),(848,'A word '),(849,'All wiyht.  Rho sritched mg kegtops awound?'),(850,'43% of all statistics are totally worthless !!!'),(851,'Isn\'t there a statute of limitations on stupidity?'),(852,'DANGER DANGER Computer store ahead...hide wallet.'),(853,'A true diplomat struts sitting down.'),(854,'I can\'t be stupid, I completed third grade!'),(855,'I may be stupid, but that still makes me smarter than you'),(856,'Ignorance is temporary; stupid is forever.'),(857,'The race from stupidity is to the driven, not the swift.'),(858,'Malice is merely stupidity raised to a higher power.'),(859,'You tell \'em Submarine, I can\'t seaplane.'),(860,'Earth: A solid substance, much desired by the seasick.'),(861,'There is no such thing as bravery; only degrees of fear.'),(862,'Your sweet words suck the morning dew off the honeysuckle'),(863,'I would have suffered a lot more if understood.'),(864,'\"And when fate summons monarchs must obey;\"'),(865,'A day without sunshine is like night.'),(866,'Error reading FAT Table...Try Skinny one ? (Y/N)'),(867,'Let\'s see your tagline hunting permit, sir.'),(868,'To steal this tagline press <CTL> <ALT> <DEL> now. '),(869,'Not a real tagline, but an incredible soy substitute.'),(870,'The UARTs won\'t take this speed, Captain.'),(871,'Stick to your talent and the cows will be well tended.'),(872,'You tell \'em teacher, You\'ve got the class.'),(873,'Dew is the tears which the stars weep.'),(874,'\"No, I didn\'t.\" - Teddy Kennedy'),(875,'Only I can tell where my own shoe pinches me.'),(876,'Any fool can tell the truth, it takes sense to lie well.'),(877,'A person never tells you anything until contradicted.'),(878,'Enough research will tend to support your theory. '),(879,'\"A lie is terminological inexactitude.\" Churchill'),(880,'Sysoping: More fun than being beaten with a sledgehammer.'),(881,'Actions speak louder than words -- but not so often.'),(882,'I\'m more humble than you are!'),(883,'Prevention is better than cure.'),(884,'Blood is thicker than water, and much more tastier.'),(885,'Software, hardware, -- is that you talking Sigmund?'),(886,'SYSOP: The guy that is laughing at your typing!'),(887,'Been there, done that, got the T-shirt.'),(888,'Committee: A body that keeps minutes and wastes hours.'),(889,'A thief believes that everybody steals.'),(890,'Only the hand that erases can write the true thing.'),(891,'Prune: A plum that has seen better days.'),(892,'Dan Quayle thinks that Cheerios are donut seeds.'),(893,'It\'s a tragedy that no man become like their mothers.'),(894,'Echo: Only thing that cheats some out of the last word.'),(895,'You can\'t do that. It\'s been digitally cursed. '),(896,'Th-th-th-that\'s all, folks!'),(897,'\"Logic is logic. That\'s all I say.\" Holmes'),(898,'Hot air sometimes thaws out a cold reception.'),(899,'Indiscriminate study bloats the mind.'),(900,'Hmmm, When is the last time the Tooth Fairy visited you?'),(901,'Every person is the architect of their own fortune.'),(902,'The young know the rules, the old know the exceptions.'),(903,'(A)bort, (R)etry, (S)mack the @#$&*~ thing!'),(904,'It runs in the blood like wooden legs.'),(905,'Feather by feather the goose is plucked.'),(906,'A bachelor enjoys the chase but doesn\'t eat the game.'),(907,'The fish in the sea are as good as the fish removed.'),(908,'A bird in the hand\'s better than one overhead.'),(909,'Ancient custom has the force of law.'),(910,'Bastard toadflax: not the result nearsighted horny toads.'),(911,'A pain in the butt may be a friend in need.'),(912,'A bird in the bush can\'t make a mess in your hand.'),(913,'The pen is the tongue of the mind.'),(914,'\"Look at all the Indians!\" - General Custer'),(915,'Good taste is the flower of good sense.'),(916,'Applied emotion is the key to success with happiness.'),(917,'A book is the only immortality.'),(918,'So dumb: Chewing the stick, not sucking the lollipop.'),(919,'The hole and the patch should be commensurate.'),(920,'A teetotaller makes the worst drunkard.'),(921,'TV advertising is the rattling inside a swill bucket.'),(922,'We have met the enemy, and he\'s all yours!'),(923,'The proof is the phylogeny of plant-animal interactions.'),(924,'\"Forgotten men at the bottom of the economic pyramid\" FDR'),(925,'If I save the whales, where do I keep them?'),(926,'The footprint of the owner is the best manure.'),(927,'A statesman shears the sheep; the politician skins them.'),(928,'\"Fountains mingle with the river, rivers with the ocean.\"'),(929,'Live so that the family parrot can live afterwards.'),(930,'Celery farmers play the stalk market.'),(931,'To live in the hearts we leave behind, is not to die.'),(932,'Parents: One of the hardships of a minor\'s life.'),(933,'I only wrote the thing, I don\'t have to understand it!'),(934,'Biography: One of the terrors of death.'),(935,'Hospitals: Places where the run down wind up.'),(936,'\"The welfare of the people is the chief law.\"  Cicero'),(937,'Yeah, but what\'s the speed of DARK? '),(938,'A vote on the tally sheet is worth two in the box.'),(939,'No one test the depth of a river with both feet.'),(940,'I have seen the future and it is now the past.'),(941,'Forget RTFM - Call The Author At Home! (@ 23:45)'),(942,'Every person constructs their own bed of nails.'),(943,'Where law ends, there tyranny begins.'),(944,'Where\'s there\'s smoke, there\'s toast. '),(945,'I think ... therefore I am overqualified.'),(946,'Mistrust first impulses, they are always good.'),(947,'Blessed our young they will inherit our national debt.'),(948,'\"How wise are they that are but fools in love!\" Cooke'),(949,'Unbelief in one thing springs = blind belief in another.'),(950,'Postscript: The only thing of interest in some letters.'),(951,'there are three things that come next, uh four... '),(952,'Nobody notices when things go right, I\'m always noticed. '),(953,'Nobody notices when things go right, and I\'m noticed. '),(954,'Facts are stubborn things.'),(955,'No one can think clearly with clenched fists.'),(956,'The characters in this message are recyclable'),(957,'That was then, this is now.'),(958,'May we kiss those we please, and please those we kiss.'),(959,'He says a thousand pleasant things, but never \"Adieu.\"'),(960,'Hollywood: A trip through a sewer in a glass bottom boat.'),(961,'Put off procrastinating till a later time.'),(962,'Yawn: The only time some men get to open their mouths.'),(963,'Mr. Bullfrog says: Time is fun when you\'re having flies. '),(964,'The longer the title, the less important the job.'),(965,'It is easier to catch flies with honey than with vinegar.'),(966,'It is easy to propose impossible remedies.'),(967,'If worst comes to worst, you *CAN* turn most things off.'),(968,'It is easier to admire hard work if you don\'t do it.'),(969,'Modem.... A deterrent to phone solicitors. '),(970,'It is meaningless to speak of domesticating a child.'),(971,'It is dangerous to confuse children with angels.'),(972,'Uh, yeah...I MEANT to do that!'),(973,'A noisy exhaust to some almost amounts to a mating call.'),(974,'Every person gets to heaven in their own way.'),(975,'When you go to the market, use your eyes, not your ears.'),(976,'Women\'s clothes: Go to extremes, seldom to extremities.'),(977,'It is hard to believe that even his friends like him.'),(978,'Never lean forward to push an invisible object.'),(979,'Luxury: Costs $7.69 to make and $20.00 to market.'),(980,'Everyone IS entitled to my opinion.'),(981,'Dogmatism: Puppyism come to its full growth.'),(982,'Cleanliness is next to \"clean-limbed,\" in the dictionary.'),(983,'Everyone is entitled to my opinion.'),(984,'What garlic is to salad, insanity is to art.'),(985,'Press any key to continue or any other key to quit.'),(986,'It is better to know useless things than to know nothing.'),(987,'If people listened to themselves, they would shut up.'),(988,'It is better to know nothing than to know what ain\'t so.'),(989,'The only way to get rid of a temptation is to yield to it'),(990,'The only way to judge the future is by knowing the past.'),(991,'We hired you to baby sit. You cooked and ate them BOTH? '),(992,'\'Tis the season to be punny......'),(993,'If you want to hide your face, walk naked.'),(994,'Flattery: Cologne water, to smell but not swallow.'),(995,'Are we supposed to be having fun yet? '),(996,'Here I run, to steal the secret of the sun.'),(997,'Is it OK to yell \'MOVIE\' in a crowded firehouse? '),(998,'A person slow to anger is better than the mighty.'),(999,'Maybe it\'s right to be nervous now... '),(1000,'If you try to be too sharp, you will cut yourself.'),(1001,'The best way to save face is to keep the lower part shut.'),(1002,'It takes two to make a bargain.'),(1003,'What grammar is to speech, logic is to reason.'),(1004,'Stupid: Being unable to find your own butt in the dark.'),(1005,'Here today, dawn tomorrow.'),(1006,'Bubble, Bubble..Am I too late to jump the ship ??'),(1007,'You cannot be too careful in the choice of your enemies.'),(1008,'\"Men know life too early, women too late\" Wilde'),(1009,'He who talks too much commits a sin.'),(1010,'Seeing is believing, Touching is convincing..'),(1011,'The first step towards philosophy is incredulity.'),(1012,'Life is a tragedy for feelers and a comedy for thinkers.'),(1013,'If it isn\'t true, at least it is a happy invention.'),(1014,'Legal Marijuana needs true glaucoma patients. '),(1015,'The course of true anything never does run smooth.'),(1016,'What is the True meaning of DOS?'),(1017,'Without love and trust all you can be in life is alone.'),(1018,'In God we trust; all others must pay cash.'),(1019,'Autobiography: Unrivalled telling truth about others.'),(1020,'America is a tune.  It must be sung together.'),(1021,'You can\'t step twice in the same river.'),(1022,'When choosing between two evils, select the newer one.'),(1023,'Hypocrisy is the type of homage vice pays to virtue.'),(1024,'This tagline is umop apisdn.'),(1025,'She has been under more drunken sailors than a head.'),(1026,'With consequences,  the unexpected always predominate.'),(1027,'Sculptor: A poor unfortunate who makes faces and busts.'),(1028,'Always remember you\'re unique - just like everyone else.'),(1029,'Reality.Sys corrupted -- Reboot Universe (Y/N)?'),(1030,'Anybody can win, unless there is a second entry.'),(1031,'Talk is cheap, until you hire a lawyer.'),(1032,'It\'s not over until the FAT table sings'),(1033,'We NEVER grow up, we just get older, and older, and ...'),(1034,'Hey! Don\'t pick up that pho×¯»’á‰½ÃÒç  NO CARRIER '),(1035,'Contraceptives: to be used on all conceivable occasions.'),(1036,'*  <|-)  User is Chinese.'),(1037,'*  :-*   User just ate something sour.'),(1038,'What results from using spot remover on your dog Spot?'),(1039,'A father is usually a banker provided by nature.'),(1040,'This tagline no verb.'),(1041,'Se non e vero, e molto ben trovato.'),(1042,'Seriousness is the very next step to being dull.'),(1043,'Two of perfect virtue: one dead, the other yet unborn.'),(1044,'No wanna work.  Wanna bang on keyboard. '),(1045,'Do I even WANT ancestors? Some found I wish I could lose.'),(1046,'The fewer our wants, the more we resemble the gods.'),(1047,'The bird of war is not the eagle but the stork.'),(1048,'Oh, pardon me, was that *your* culture? So sorry.'),(1049,'Oh that?  It was playing leap frog with a unicorn.'),(1050,'\"To love her was a liberal education.\" Steele'),(1051,'WARNING... drinking tap water may kill your thirst!'),(1052,'Everyone meets their Waterloo at last.'),(1053,'Hug: A roundabout way of expressing affection.'),(1054,'Hick: Looks both ways before crossing a one-way street.'),(1055,'The world, as we know it, has come to an end!!'),(1056,'Madam, an error, we did a hysterectomy on your husband'),(1057,'We\'re lost, but we\'re making good time.'),(1058,'Illustrate your Sermons! Wear \"far side\" ties. '),(1059,'My Hard Disk went on a diet and lost it\'s FAT'),(1060,'What if there were no hypothetical situations?'),(1061,'To excel at what you do, you must love doing it.'),(1062,'Used Car: Not what it is jacked up to be.'),(1063,'MacIntosh:Computer with training wheels you can\'t remove.'),(1064,'How time flies, when you are in a heap of problems..'),(1065,'Wear old clothes when you fight for truth and liberty.'),(1066,'Public opinion flourishes where there are no ideas.'),(1067,'Wedding: A funeral where you smell your own flowers.'),(1068,'A conclusion is where you got tired of thinking.'),(1069,'You always swat where he\'s not, or if he is aha! a spot.'),(1070,'Resort: A place where the tired grow more tired.'),(1071,'Laundry: A place where clothes are mangled.'),(1072,'Gnaw the bone which has fallen to thy lot.'),(1073,'Think hard now!  Which one is Shinola?'),(1074,'Never trust anyone who speaks well of everyone.'),(1075,'Yes-men: Fellows who hang around the man nobody noes.'),(1076,'Creditor: A man who has a longer memory than a debtor.'),(1077,'\"They also serve who only stand and wait.\"'),(1078,'Hobo: A person who builds palaces and lives in shacks.'),(1079,'They are slaves who fear to speak for the fallen & weak.'),(1080,'Bore: A person who talks when you wish him to listen.'),(1081,'Golfer: A person who hits and tells.'),(1082,'Honest Politician: One who stays bought.'),(1083,'No generalization is wholly true, not even this one.'),(1084,'Religious people are wicked, how would they be without?'),(1085,'Cities, like cats, will reveal themselves at night.'),(1086,'Faint hearts never win in love nor sell life insurance.'),(1087,'From listening comes wisdom, from speaking, repentance.'),(1088,'Many possess the wisdom of many and only the wit of one.'),(1089,'Adversity makes people wise but not rich.'),(1090,'Some are weather-wise, some are otherwise.'),(1091,'How dieth the wise man? As the fool.'),(1092,'\"But, if ye wish her gratefu\' prayer, Gie her a haggis!\"'),(1093,'Think carefully before wishing, it might just come true.'),(1094,'I\'m a hero with coward\'s legs.'),(1095,'(A)bort (R)etry (I)nfluence with large hammer.'),(1096,'Repartee: An insult with a suit and tie on.'),(1097,'The only argument with the wind is to put on a coat.'),(1098,'Tabloid: A newspaper with a permanent crime wave.'),(1099,'Kibitzer: A person with an interferiority complex.'),(1100,'\"You spotted snakes with double tongue... be not seen.\"'),(1101,'Memories keep the wolf of insignificance from the door.'),(1102,'\"Man, born of woman is of few days; full of trouble.\" Job'),(1103,'Think and you won\'t sink.'),(1104,'Please! Take my word for it.'),(1105,'Software independent: Won\'t work with ANY software.'),(1106,'Minds, like parachutes, work only when open.'),(1107,'Shareware it only works if you pay.'),(1108,'It\'s better the world wonder why you *AREN\'T* President.'),(1109,'What is the world to a man when his wife is a widow?'),(1110,'\"Men die and worms eat them - but not for love\"  Shake'),(1111,'Some cures are worse than the disease.'),(1112,'If it\'s not worth doing, it\'s not worth doing well.'),(1113,'A hangover  the wrath of grapes '),(1114,'Biography should be written by an acute enemy.'),(1115,'Abandon all hope, ye who press ÄÄÙ here '),(1116,'All hope abandon, ye who enter messages here.'),(1117,'Dollars cannot buy yesterday.'),(1118,'Do well and you will have no need for ancestors.'),(1119,'The hard disk you save may be your own.'),(1120,'At all ages you are certain you still have another year.'),(1121,'A gun gives you the body, not the bird.'),(1122,'I be nibble, you be quick, he jumped over the Joystick.'),(1123,'If at first you don\'t succeed; Blame everyone else'),(1124,'If at first you don\'t succeed, skydiving is not for you.'),(1125,'If at first you doubt, doubt again.'),(1126,'It\'s what inside you, not the outside that counts.'),(1127,'If at first you don\'t succeed: Blame everyone else.'),(1128,'Simple rule: If you don\'t treat me right, shame on you.'),(1129,'If at first you doubt, doubt again, and again ...'),(1130,'Youthful figure: What you get when asking a woman\'s age.'),(1131,'Hotel: A place you give good dollars for bad quarters.'),(1132,'If I were you, who\'d be me?'),(1133,'No matter where you go, there you are.'),(1134,'It is when you take for yourself that you truly take.'),(1135,'Synonym: A word you use when you can\'t spell the other.'),(1136,'Spring makes everything young again except humans.'),(1137,'You can close your eyes to reality but not to memories.'),(1138,'A penny for your thoughts; $20 to act it out.'),(1139,'Without my ignorance, your knowledge would be meaningless'),(1140,'You can\'t eat your friends and have them too.'),(1141,'Be nice on your way up, you\'ll meet on the way down.'),(1142,'Middle age: When your age starts to show at your middle.'),(1143,'Before advising \"Be yourself!\" reassess his character.');
/*!40000 ALTER TABLE `remarks_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remarks_tempbelow5`
--

DROP TABLE IF EXISTS `remarks_tempbelow5`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `remarks_tempbelow5` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `text` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `remarks_tempbelow5`
--

LOCK TABLES `remarks_tempbelow5` WRITE;
/*!40000 ALTER TABLE `remarks_tempbelow5` DISABLE KEYS */;
INSERT INTO `remarks_tempbelow5` VALUES (1,'It\'s a bit nippy out, mate.'),(2,'This is nothing. Try talking to Eliza, SHE is cold!'),(3,'And school isn\'t even canceled. Bah!'),(4,'The brocolli is dying! Bwahahahaha!'),(5,'Take me down to the Paradise City where it isn\'t so cold!'),(6,'You could freeze an Altoid in this weather.'),(7,'Watch out for vicious snow men!'),(8,'You know, if you get cold enough, your snot will freeze solid in your nose.'),(9,'Warm enough for to go swiming.'),(10,'Snowball weather.'),(11,'Anyone up for a game of cricket?'),(12,'I think I just saw a snowman making a run for it.'),(13,'My, isn\'t that nippy.'),(14,'It is cold.'),(15,'OK, I will make a lame remark.');
/*!40000 ALTER TABLE `remarks_tempbelow5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remarks_tempbelowmin5`
--

DROP TABLE IF EXISTS `remarks_tempbelowmin5`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `remarks_tempbelowmin5` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `text` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `remarks_tempbelowmin5`
--

LOCK TABLES `remarks_tempbelowmin5` WRITE;
/*!40000 ALTER TABLE `remarks_tempbelowmin5` DISABLE KEYS */;
INSERT INTO `remarks_tempbelowmin5` VALUES (1,'Bur.'),(2,'Ya, you betcha. Oop nort, it was real cold, ya darn tootin!'),(3,'In Antarctica, the penguins are breeding.'),(4,'If you were a chocolate egg outside right now, you would be dark chocolate.'),(5,'I dare you to go outside with no shirt on and stay there for two minutes!'),(6,'I think hell has frozen over now, better watch out for a demon ice skating contest.'),(7,'Santa only lives in the North Pole because it was too cold here!'),(8,'It\'s not co co co cold!'),(9,'Put another log on the fire.'),(10,'Warm up the hot chocolate.'),(11,'Go hammer a nail with a bananna.'),(12,'Anyone for a game of tennis?'),(13,'That is cold enough to freeze a rock.'),(14,'Any colder and I am moving to Florida.'),(15,'Thats nothing.  When I was an diode, it was 0 degress kelvin.'),(16,'That is so cold, Zack might even stop sking!');
/*!40000 ALTER TABLE `remarks_tempbelowmin5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_aibo`
--

DROP TABLE IF EXISTS `settings_aibo`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_aibo` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `polltime` int(11) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_aibo`
--

LOCK TABLES `settings_aibo` WRITE;
/*!40000 ALTER TABLE `settings_aibo` DISABLE KEYS */;
INSERT INTO `settings_aibo` VALUES (0,0,60,0),(1,0,600,0);
/*!40000 ALTER TABLE `settings_aibo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_asterisk`
--

DROP TABLE IF EXISTS `settings_asterisk`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_asterisk` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `tcphost` varchar(32) default NULL,
  `tcpport` int(11) default NULL,
  `polltime` int(11) default NULL,
  `user` varchar(32) default NULL,
  `password` varchar(32) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_asterisk`
--

LOCK TABLES `settings_asterisk` WRITE;
/*!40000 ALTER TABLE `settings_asterisk` DISABLE KEYS */;
INSERT INTO `settings_asterisk` VALUES (0,0,'localhost',5038,300,'asterisk','secret',0),(1,0,'192.168.100.2',5038,300,'asterisk','password',0);
/*!40000 ALTER TABLE `settings_asterisk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_astro`
--

DROP TABLE IF EXISTS `settings_astro`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_astro` (
  `id` int(11) NOT NULL,
  `latitude` varchar(32) default NULL,
  `longitude` varchar(32) default NULL,
  `timezone` int(11) default NULL,
  `twilight` varchar(32) default NULL,
  `seasons` varchar(32) default NULL,
  `seasonstarts` varchar(32) default NULL,
  `debug` tinyint(1) default NULL,
  `temperature` varchar(6) default NULL,
  `currency` varchar(6) default NULL,
  `dst` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_astro`
--

LOCK TABLES `settings_astro` WRITE;
/*!40000 ALTER TABLE `settings_astro` DISABLE KEYS */;
INSERT INTO `settings_astro` VALUES (0,'52.8167','-5.7667',2,'civil','winter,spring,summer,fall','20,20,21,22',0,'°C','€',1),(1,'52.8167','-5.7667',1,'civil','winter,spring,summer,fall','20,20,21,22',0,'°C','€',0);
/*!40000 ALTER TABLE `settings_astro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_bluetooth`
--

DROP TABLE IF EXISTS `settings_bluetooth`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_bluetooth` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `device` varchar(32) default NULL,
  `threshold` int(11) default NULL,
  `polltime` int(11) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_bluetooth`
--

LOCK TABLES `settings_bluetooth` WRITE;
/*!40000 ALTER TABLE `settings_bluetooth` DISABLE KEYS */;
INSERT INTO `settings_bluetooth` VALUES (0,0,'hci0',30,120,0),(1,0,'hci0',-20,300,0);
/*!40000 ALTER TABLE `settings_bluetooth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_ctx35`
--

DROP TABLE IF EXISTS `settings_ctx35`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_ctx35` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `serialport` varchar(32) default NULL,
  `baudrate` varchar(32) default NULL,
  `polltime` int(11) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_ctx35`
--

LOCK TABLES `settings_ctx35` WRITE;
/*!40000 ALTER TABLE `settings_ctx35` DISABLE KEYS */;
INSERT INTO `settings_ctx35` VALUES (0,0,'/dev/ttyUSB0','19200',500,0),(1,0,'/dev/ttyUSB0','19200',500,0);
/*!40000 ALTER TABLE `settings_ctx35` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_email`
--

DROP TABLE IF EXISTS `settings_email`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_email` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `fromaddress` varchar(32) default NULL,
  `toaddress` varchar(32) default NULL,
  `smtpserver` varchar(32) default NULL,
  `smtpport` int(11) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_email`
--

LOCK TABLES `settings_email` WRITE;
/*!40000 ALTER TABLE `settings_email` DISABLE KEYS */;
INSERT INTO `settings_email` VALUES (0,0,'domotiga@somedomain.com','admin@somedomain.com','localhost',25,0),(1,0,'domotiga@yourdomain.com','to@yourdomain.com','yoursmarthost',25,0);
/*!40000 ALTER TABLE `settings_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_gmail`
--

DROP TABLE IF EXISTS `settings_gmail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_gmail` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `user` varchar(64) default NULL,
  `password` varchar(64) default NULL,
  `polltime` int(11) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_gmail`
--

LOCK TABLES `settings_gmail` WRITE;
/*!40000 ALTER TABLE `settings_gmail` DISABLE KEYS */;
INSERT INTO `settings_gmail` VALUES (0,0,'gmailuser','password',120,1),(1,0,'user@gmail.com','test',60,0);
/*!40000 ALTER TABLE `settings_gmail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_gps`
--

DROP TABLE IF EXISTS `settings_gps`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_gps` (
  `id` int(11) NOT NULL,
  `polltime` int(11) default NULL,
  `enabled` tinyint(1) default NULL,
  `serialport` varchar(32) default NULL,
  `baudrate` int(11) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_gps`
--

LOCK TABLES `settings_gps` WRITE;
/*!40000 ALTER TABLE `settings_gps` DISABLE KEYS */;
INSERT INTO `settings_gps` VALUES (0,300,0,'/dev/ttyUSB7',38400,0),(1,300,0,'/dev/ttyUSB7',38400,0);
/*!40000 ALTER TABLE `settings_gps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_hddtemp`
--

DROP TABLE IF EXISTS `settings_hddtemp`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_hddtemp` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `tcphost` varchar(32) default NULL,
  `tcpport` int(11) default NULL,
  `polltime` int(11) default NULL,
  `threshold` int(11) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_hddtemp`
--

LOCK TABLES `settings_hddtemp` WRITE;
/*!40000 ALTER TABLE `settings_hddtemp` DISABLE KEYS */;
INSERT INTO `settings_hddtemp` VALUES (0,0,'localhost',7634,600,60,0),(1,127,'localhost',7634,300,40,0);
/*!40000 ALTER TABLE `settings_hddtemp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_heyu`
--

DROP TABLE IF EXISTS `settings_heyu`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_heyu` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `command` varchar(32) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_heyu`
--

LOCK TABLES `settings_heyu` WRITE;
/*!40000 ALTER TABLE `settings_heyu` DISABLE KEYS */;
INSERT INTO `settings_heyu` VALUES (0,0,'/usr/local/bin/heyu',0),(1,0,'/usr/local/bin/heyu',0);
/*!40000 ALTER TABLE `settings_heyu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_irman`
--

DROP TABLE IF EXISTS `settings_irman`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_irman` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `serialport` varchar(32) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_irman`
--

LOCK TABLES `settings_irman` WRITE;
/*!40000 ALTER TABLE `settings_irman` DISABLE KEYS */;
INSERT INTO `settings_irman` VALUES (0,0,'/dev/ttyUSB2',0),(1,0,'/dev/ttyUSB2',0);
/*!40000 ALTER TABLE `settings_irman` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `settings_plugwise`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_plugwise` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `serialport` varchar(32) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_plugwise`
--

LOCK TABLES `settings_plugwise` WRITE;
/*!40000 ALTER TABLE `settings_plugwise` DISABLE KEYS */;
INSERT INTO `settings_plugwise` VALUES (0,1,'/dev/ttyUSB8',1),(1,0,'/dev/ttyUSB9',0);
/*!40000 ALTER TABLE `settings_plugwise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_main`
--

DROP TABLE IF EXISTS `settings_main`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_main` (
  `id` int(11) NOT NULL,
  `sleeptime` int(11) default NULL,
  `flushtime` int(11) default NULL,
  `debug` tinyint(1) default NULL,
  `logbuffer` int(11) default NULL,
  `authentication` tinyint(1) default NULL,
  `startpage` varchar(32) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_main`
--

LOCK TABLES `settings_main` WRITE;
/*!40000 ALTER TABLE `settings_main` DISABLE KEYS */;
INSERT INTO `settings_main` VALUES (0,250,5000,0,15000,1,'Home'),(1,250,10000,0,15000,0,'FHome');
/*!40000 ALTER TABLE `settings_main` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_mpd`
--

DROP TABLE IF EXISTS `settings_mpd`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_mpd` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `tcphost` varchar(32) default NULL,
  `tcpport` int(11) default NULL,
  `autoconnect` tinyint(1) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_mpd`
--

LOCK TABLES `settings_mpd` WRITE;
/*!40000 ALTER TABLE `settings_mpd` DISABLE KEYS */;
INSERT INTO `settings_mpd` VALUES (0,0,'192.168.100.2',6600,0,0),(1,0,'192.168.100.2',6600,-1,0);
/*!40000 ALTER TABLE `settings_mpd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_onewire`
--

DROP TABLE IF EXISTS `settings_onewire`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_onewire` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `serialport` varchar(32) default NULL,
  `baudrate` int(11) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_onewire`
--

LOCK TABLES `settings_onewire` WRITE;
/*!40000 ALTER TABLE `settings_onewire` DISABLE KEYS */;
INSERT INTO `settings_onewire` VALUES (0,0,'/dev/ttyUSB4',9600,0),(1,0,'/dev/ttyUSB4',9600,0);
/*!40000 ALTER TABLE `settings_onewire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_rfxcom`
--

DROP TABLE IF EXISTS `settings_rfxcom`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_rfxcom` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `tcphost` varchar(32) default NULL,
  `tcpport` int(11) default NULL,
  `type` varchar(32) default NULL,
  `serialport` varchar(32) default NULL,
  `baudrate` varchar(32) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_rfxcom`
--

LOCK TABLES `settings_rfxcom` WRITE;
/*!40000 ALTER TABLE `settings_rfxcom` DISABLE KEYS */;
INSERT INTO `settings_rfxcom` VALUES (0,0,'192.168.100.7',5557,'tcp','/dev/ttyUSB3','38400',0),(1,0,'192.168.100.7',5557,'serial','/dev/ttyUSB3','4800',0);
/*!40000 ALTER TABLE `settings_rfxcom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_rrdtool`
--

DROP TABLE IF EXISTS `settings_rrdtool`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_rrdtool` (
  `id` int(11) NOT NULL,
  `polltime` int(11) default NULL,
  `enabled` tinyint(1) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_rrdtool`
--

LOCK TABLES `settings_rrdtool` WRITE;
/*!40000 ALTER TABLE `settings_rrdtool` DISABLE KEYS */;
INSERT INTO `settings_rrdtool` VALUES (0,600,0,0),(1,300,0,0);
/*!40000 ALTER TABLE `settings_rrdtool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_serverstats`
--

DROP TABLE IF EXISTS `settings_serverstats`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_serverstats` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `enabled` tinyint(1) default NULL,
  `servername` varchar(32) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_serverstats`
--

LOCK TABLES `settings_serverstats` WRITE;
/*!40000 ALTER TABLE `settings_serverstats` DISABLE KEYS */;
INSERT INTO `settings_serverstats` VALUES (1,-1,'DomotiGa Server',0),(2,1,'cyberjunky.nl',1);
/*!40000 ALTER TABLE `settings_serverstats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_sms`
--

DROP TABLE IF EXISTS `settings_sms`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_sms` (
  `id` int(11) NOT NULL,
  `polltime` int(11) default NULL,
  `enabled` tinyint(1) default NULL,
  `serialport` varchar(32) default NULL,
  `baudrate` varchar(32) default NULL,
  `pin` varchar(32) default NULL,
  `servicecentre` varchar(32) default NULL,
  `contact` varchar(32) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_sms`
--

LOCK TABLES `settings_sms` WRITE;
/*!40000 ALTER TABLE `settings_sms` DISABLE KEYS */;
INSERT INTO `settings_sms` VALUES (0,120,0,'/dev/ttyUSB6','38400','3363','+31653131313','+31612341234',0),(1,120,0,'/dev/ttyUSB6','38400','1234','+31613131314','+31612341234',0);
/*!40000 ALTER TABLE `settings_sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_sound`
--

DROP TABLE IF EXISTS `settings_sound`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_sound` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `debug` tinyint(1) default NULL,
  `volume` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_sound`
--

LOCK TABLES `settings_sound` WRITE;
/*!40000 ALTER TABLE `settings_sound` DISABLE KEYS */;
INSERT INTO `settings_sound` VALUES (0,0,0,100),(1,0,0,0);
/*!40000 ALTER TABLE `settings_sound` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_tvguide`
--

DROP TABLE IF EXISTS `settings_tvguide`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_tvguide` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `grabcmd` varchar(128) default NULL,
  `grabconf` varchar(128) default NULL,
  `grabdays` int(11) default NULL,
  `usecache` tinyint(1) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_tvguide`
--

LOCK TABLES `settings_tvguide` WRITE;
/*!40000 ALTER TABLE `settings_tvguide` DISABLE KEYS */;
INSERT INTO `settings_tvguide` VALUES (0,0,'tv_grab_nl_C','tv_grab_nl_C.conf',7,1,0),(1,0,'tv_grab_nl_C','tv_grab_nl_C.conf',3,-1,0);
/*!40000 ALTER TABLE `settings_tvguide` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_ups`
--

DROP TABLE IF EXISTS `settings_ups`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_ups` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `tcphost` varchar(32) default NULL,
  `tcpport` int(11) default NULL,
  `polltime` int(11) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_ups`
--

LOCK TABLES `settings_ups` WRITE;
/*!40000 ALTER TABLE `settings_ups` DISABLE KEYS */;
INSERT INTO `settings_ups` VALUES (0,0,'localhost',3493,3000,0),(1,0,'192.168.100.2',3493,300,0);
/*!40000 ALTER TABLE `settings_ups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_videoserver`
--

DROP TABLE IF EXISTS `settings_videoserver`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_videoserver` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `tcphost` varchar(32) default NULL,
  `tcpport` int(11) default NULL,
  `user` varchar(32) default NULL,
  `password` varchar(32) default NULL,
  `channel1` varchar(32) default NULL,
  `channel2` varchar(32) default NULL,
  `channel3` varchar(32) default NULL,
  `channel4` varchar(32) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_videoserver`
--

LOCK TABLES `settings_videoserver` WRITE;
/*!40000 ALTER TABLE `settings_videoserver` DISABLE KEYS */;
INSERT INTO `settings_videoserver` VALUES (0,0,'192.168.100.8',NULL,NULL,NULL,'Camera Backyard','Camera Frontdoor',NULL,NULL,0),(1,0,'192.168.100.8',80,'','','Backyard','Frontdoor','','',0);
/*!40000 ALTER TABLE `settings_videoserver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_visca`
--

DROP TABLE IF EXISTS `settings_visca`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_visca` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `serialport` varchar(32) default NULL,
  `baudrate` varchar(32) default NULL,
  `cameraaddress` int(11) default NULL,
  `debug` tinyint(1) default NULL,
  `device` varchar(32) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_visca`
--

LOCK TABLES `settings_visca` WRITE;
/*!40000 ALTER TABLE `settings_visca` DISABLE KEYS */;
INSERT INTO `settings_visca` VALUES (0,0,'/dev/ttyUSB5','9600',1,0,'/dev/video0'),(1,0,'/dev/ttyUSB5','9600',1,0,'/dev/video0');
/*!40000 ALTER TABLE `settings_visca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_voicetext`
--

DROP TABLE IF EXISTS `settings_voicetext`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_voicetext` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `engine` varchar(32) default NULL,
  `prefixcmd` varchar(32) default NULL,
  `voicesmale` varchar(32) default NULL,
  `voicesfemale` varchar(32) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_voicetext`
--

LOCK TABLES `settings_voicetext` WRITE;
/*!40000 ALTER TABLE `settings_voicetext` DISABLE KEYS */;
INSERT INTO `settings_voicetext` VALUES (0,0,'cepstral','padsp','david','allison,diane',0),(1,0,'cepstral','/usr/bin/padsp','','linda,emily',0);
/*!40000 ALTER TABLE `settings_voicetext` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_webserver`
--

DROP TABLE IF EXISTS `settings_webserver`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_webserver` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `docroot` varchar(32) default NULL,
  `httpport` int(11) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_webserver`
--

LOCK TABLES `settings_webserver` WRITE;
/*!40000 ALTER TABLE `settings_webserver` DISABLE KEYS */;
INSERT INTO `settings_webserver` VALUES (0,1,'~/domotiga/www',8001,0),(1,-1,'~/domotiga/www',8001,0);
/*!40000 ALTER TABLE `settings_webserver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_weeder`
--

DROP TABLE IF EXISTS `settings_weeder`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_weeder` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) default NULL,
  `serialport` varchar(32) default NULL,
  `debug` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_weeder`
--

LOCK TABLES `settings_weeder` WRITE;
/*!40000 ALTER TABLE `settings_weeder` DISABLE KEYS */;
INSERT INTO `settings_weeder` VALUES (0,0,'/dev/ttyUSB1',1),(1,0,'/dev/ttyUSB1',0);
/*!40000 ALTER TABLE `settings_weeder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `stock` (
  `ean` bigint(20) NOT NULL default '0',
  `name` varchar(100) NOT NULL default '',
  `quantity` int(11) NOT NULL default '0',
  `category` int(11) NOT NULL default '0',
  `stockid` bigint(20) unsigned NOT NULL auto_increment,
  `target` int(11) NOT NULL default '0',
  `price` double NOT NULL default '0',
  PRIMARY KEY  (`stockid`),
  UNIQUE KEY `eanid` (`ean`),
  KEY `nameid` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (8710400190868,'Biologische Pindakaas AH',7,0,1,0,0),(8710400136880,'Bloemenhoning AH',1,0,2,0,0),(8710496503986,'De Ruijter Chocoladehagel Puur',1,0,3,0,0),(8722700208945,'Knorr Chicken Tonight Sate',2,0,4,3,6.9),(8713300042435,'Dubbel Frisss Appel en Perzik',4,0,5,0,0),(8717644239766,'OMO Waspoeder Wit',1,0,6,1,0),(8715700016504,'Heinz Tomaten Ketchup',1,0,7,0,0),(8710406212885,'Belegen Geraspte Kaas Super de Boer',1,0,8,12,1.2),(8710243922381,'Maaslander Plakjes Komijn Kaas',1,0,9,0,0),(8711000194645,'Senseo Mocca Gourmet Pads 36 stuks',2,0,10,6,3.05),(5410041360608,'Liga Milk Break Melk - Aardbei',1,0,11,2,3.95),(8710408108056,'Penne Pasta 500gr C1000',1,0,13,1,0);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tvchannels`
--

DROP TABLE IF EXISTS `tvchannels`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `tvchannels` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(64) default NULL,
  `callsign` varchar(32) default NULL,
  `icon` varchar(64) default NULL,
  `channum` int(11) default NULL,
  `description` text,
  `enabled` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `tvchannels`
--

LOCK TABLES `tvchannels` WRITE;
/*!40000 ALTER TABLE `tvchannels` DISABLE KEYS */;
/*!40000 ALTER TABLE `tvchannels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `username` varchar(32) default NULL,
  `password` varchar(64) default NULL,
  `fullname` varchar(32) default NULL,
  `admin` tinyint(1) default NULL,
  `comments` text,
  `lastlogin` varchar(32) default NULL,
  `emailaddress` varchar(32) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','admin','Admin',1,'','2008-11-06 14:12:13','admin@mydomain.com'),(2,'user','user','User',0,'','2008-11-06 14:10:21','user@mydomain.com'),(3,'rakker','','AIBO Rakker',0,'','','aibo@mydomain.com');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2008-11-19 10:29:59
