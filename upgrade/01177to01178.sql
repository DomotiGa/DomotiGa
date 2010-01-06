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
-- Table structure for table `settings_plcbus`
--

DROP TABLE IF EXISTS `settings_plcbus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_plcbus` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `serialport` varchar(32) DEFAULT NULL,
  `baudrate` varchar(32) DEFAULT NULL,
  `polltime` int(11) DEFAULT NULL,
  `usercode` varchar(16) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_plcbus`
--

LOCK TABLES `settings_plcbus` WRITE;
/*!40000 ALTER TABLE `settings_plcbus` DISABLE KEYS */;
INSERT INTO `settings_plcbus` VALUES (0,0,'/dev/ttyUSB0','19200',500,'FF',0),(1,0,'/dev/ttyUSB4','19200',500,'FF',0);
/*!40000 ALTER TABLE `settings_plcbus` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `settings_aibo`;
--
-- Table structure for table `settings_ping`
--

DROP TABLE IF EXISTS `settings_ping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_ping` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `polltime` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_ping`
--

LOCK TABLES `settings_ping` WRITE;
/*!40000 ALTER TABLE `settings_ping` DISABLE KEYS */;
INSERT INTO `settings_ping` VALUES (0,0,60,0),(1,-1,300,0);
/*!40000 ALTER TABLE `settings_ping` ENABLE KEYS */;
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
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES (1,'0.1.166'),(2,'0.1.167'),(3,'0.1.168'),(4,'0.1.169'),(5,'0.1.170'),(6,'0.1.171'),(7,'0.1.172'),(8,'0.1.173'),(9,'0.1.174'),(10,'0.1.175'),(11,'0.1.176'),(12,'0.1.177'),(13,'0.1.178');
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
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
  `type` varchar(128) DEFAULT NULL,
  `mode` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interfaces`
--

LOCK TABLES `interfaces` WRITE;
/*!40000 ALTER TABLE `interfaces` DISABLE KEYS */;
INSERT INTO `interfaces` VALUES (1,'RFXCom Receiver','A10 X10 X10Security Oregon KAKU RFXCom HE','Read'),(2,'Xanura CTX35','A10 X10','Read Write'),(3,'Midon TEMP08','1-Wire','Read Write'),(4,'HDDTemp Socket','HDDTemp','Read'),(5,'Ping Socket','Ping','Read'),(6,'UPS Socket','UPS','Read'),(7,'Heyu X10','A10 X10','Write'),(8,'Bluetooth Dongle','Bluetooth','Read Write'),(9,'Weeder I/O Bus','Weeder','Read Write'),(10,'Plugwise Stick','Plugwise','Read Write'),(11,'DSC5401 Interface','DSC','Read Write'),(12,'RFXCom Transmitter','X10 ARC AC RFXCom','Read Write'),(13,'KNX/EIB Interface','KNX/EIB','Read Write'),(14,'Digitemp','1-Wire','Read'),(15,'Z-Wave Controller','Z-Wave','Read Write'),(16,'PLCBUS Interface','PLCBUS','Read Write');
/*!40000 ALTER TABLE `interfaces` ENABLE KEYS */;
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
) ENGINE=MyISAM AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devicetypes`
--

LOCK TABLES `devicetypes` WRITE;
/*!40000 ALTER TABLE `devicetypes` DISABLE KEYS */;
INSERT INTO `devicetypes` VALUES (1,'Marmitek DS90','Door/Window Sensor','X10Security'),(2,'Marmitek LW10G','Lamp Module','X10'),(3,'Marmitek LD11','Dimmer Module','X10'),(4,'Marmitek MS13E M','Motion Sensor','X10'),(5,'Marmitek MS13E L','Light Sensor','X10'),(6,'Xanura SAX35','I/O Actor','A10'),(7,'Oregon THGR238N','Temp/Hygro Sensor','Oregon'),(8,'Oregon UV138','UV Light Sensor','Oregon'),(9,'RFXPwr Module','Power Usage Sensor','RFXCom'),(10,'Marmitek TM13','Wireless Tranceiver','X10'),(11,'HDDTemp Item','Temp Monitor','HDDTemp'),(12,'Oregon THR128','Temp Sensor','Oregon'),(13,'Sony AIBO','Status AIBO','Ping'),(14,'APC SmartUPS1000','Power Supply','UPS'),(15,'Dallas DS18S20','Temp Sensor','1-Wire'),(16,'Dallas Rain Gauge','Rain Gauge','1-Wire'),(17,'Marmitek SD90','Smoke Detector','X10Security'),(18,'Bluetooth Device','Phone','Bluetooth'),(19,'ITHO ECO Fan','Central Ventilation','Weeder'),(20,'RFXPulse Gas','Gas Usage Sensor','RFXCom'),(21,'RFXPulse Water','Water Usage Sensor','RFXCom'),(22,'Oregon BWR102','Digital Bathroom Scale','Oregon'),(23,'Oregon GR101','Digital Bathroom Scale','Oregon'),(24,'Oregon THC138','Temp Sensor','Oregon'),(25,'Oregon THR138','Temp Sensor','Oregon'),(26,'Oregon THGR810','Temp/Hygro Sensor','Oregon'),(27,'Plugwise Circle','Zigbee Appliance Module','Plugwise'),(28,'Plugwise Circle+','Zigbee Appliance Module','Plugwise'),(29,'KAKU Doorbell','Wireless Doorbell','X10'),(30,'Oregon THN132N','Temp Sensor','Oregon'),(31,'Oregon THWR288','Temp Sensor','Oregon'),(32,'Oregon BTHR918N','Baro/Temp/Hygro Sensor','Oregon'),(33,'Oregon BTHR968','Baro/Temp/Hygro Sensor','Oregon'),(34,'Marmitek AD10','Switch Module','X10'),(35,'Marmitek LM12','Lamp Module','X10'),(36,'Marmitek AM12','Appliance Module','X10'),(38,'Oregon PCR800','Rain Gauge','Oregon'),(39,'Oregon RTGR328N','Temp/Hygro/Time Sensor','Oregon'),(40,'DSC PIR','Motion Sensor','DSC'),(41,'DSC Contact','Door/Window Sensor','DSC'),(42,'DSC Smoke','Smoke Detector','DSC'),(43,'KAKU AWST-8802','Wireless Wallswitch Dual','HE'),(44,'KAKU AMST-606','Door/Window Sensor','HE'),(46,'KNX/EIB Dim','EIS 2','KNX/EIB'),(45,'KNX/EIB On/Off','EIS 1','KNX/EIB'),(49,'KNX/EIB Values','EIS 5','KNX/EIB'),(48,'KNX/EIB Date','EIS 4','KNX/EIB'),(47,'KNX/EIB Time','EIS 3','KNX/EIB'),(50,'KNX/EIB Scaling %','EIS 6','KNX/EIB'),(51,'KNX/EIB Motor Drives','EIS 7','KNX/EIB'),(52,'KNX/EIB Forced Control','EIS 8','KNX/EIB'),(53,'KNX/EIB 32bit Float','EIS 9','KNX/EIB'),(54,'KNX/EIB 16bit Int','EIS 10','KNX/EIB'),(55,'KNX/EIB 32bit Int','EIS 11','KNX/EIB'),(56,'KNX/EIB 8bit Int','EIS 14','KNX/EIB'),(57,'KNX/EIB 14byte Text','EIS 15','KNX/EIB'),(58,'Dallas DS2423','4Kbit RAM + Counter','1-Wire'),(59,'KAKU PAR 1000','Appliance Module','ARC'),(60,'KAKU AC-300','Dimmer Module','AC'),(61,'Z-Wave Switch','Binary Switch','Z-Wave'),(62,'Z-Wave Dimmer','Multilevel Switch','Z-Wave'),(63,'Z-Wave D/W Sensor','Door/Window Sensor','Z-Wave'),(64,'Z-Wave PIR Sensor','Motion Sensor','Z-Wave'),(65,'Dallas DS2438','Smart Battery Monitor ','1-Wire'),(66,'Cent-a-meter/OWL','Power Usage Sensor','Oregon'),(67,'Visonic DS10/90/SD90','Door/Window Sensor','X10Security'),(68,'Visonic MCT302/425','Door/Window Sensor','X10Security'),(69,'Visonic MS10/20/90/MCW','Motion Sensor','X10Security'),(70,'Visonic KR10/21/SH624','Security Remote','X10Security'),(71,'Visonic MCT234/HP564','Security Remote','X10Security'),(72,'Network Device','Status On/Off','Ping'),(73,'Network Host','Status Up/Down','Ping'),(74,'Oregon WTGR800','Anemo/Temp/Hygro Sensor','Oregon');
/*!40000 ALTER TABLE `devicetypes` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table `devices_camera`
--

DROP TABLE IF EXISTS `devices_camera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devices_camera` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `cmdoptions` text,
  `viewstring` text,
  `grabstring` text,
  `ptztype` varchar(32) DEFAULT NULL,
  `ptzbaseurl` text,
  `description` varchar(128) DEFAULT NULL,
  `viscaaddress` int(11) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `passwd` varchar(64) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices_camera`
--

LOCK TABLES `devices_camera` WRITE;
/*!40000 ALTER TABLE `devices_camera` DISABLE KEYS */;
INSERT INTO `devices_camera` VALUES (1,'Example Local Video Cam','Video4Linux','tv:// -tv norm=auto:input=1:device=/dev/video0 -quiet','','','Sony VISCA','','Sony E31 on Dazzle s-video port',0,'','',-1),(2,'VideoServer Feed','Fetch Image','','http://192.168.1.70/image.jpg','','','','Channel #0 of IP9100',0,'','',-1),(3,'AXIS Camera','Stream MJPEG','','http://194.218.96.93/mjpg/video.mjpg','','','','Public AXIS Camera Somewhere',0,'','',-1),(14,'Example Local Video Cam 2','Video4Linux','tv:// -tv norm=pal:input=0:device=/dev/video0 -quiet','','','','','Elro wireless camera on Dazzle composite-video port',0,'','',-1),(7,'Public PTZ AXIS Camera','Stream MJPEG','-quiet','http://80.101.217.249:443/mjpg/video.mjpg','','AXIS API','http://80.101.217.249:443/axis-cgi/com/ptz.cgi?','Public PTZ AXIS Camera ;-)',0,'','',-1),(13,'Mobotix M1 Cam','Stream MJPEG','','http://82.79.20.52:40002/cgi-bin/faststream.jpg?.mjpg','','','','Mobotix Video Stream',0,'','',-1);
/*!40000 ALTER TABLE `devices_camera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_callerid`
--

DROP TABLE IF EXISTS `settings_callerid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_callerid` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `countrycode` varchar(16) DEFAULT NULL,
  `areacode` varchar(16) DEFAULT NULL,
  `prefixnational` varchar(16) DEFAULT NULL,
  `prefixinternational` varchar(16) DEFAULT NULL,
  `autocreatecontacts` tinyint(1) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_callerid`
--

LOCK TABLES `settings_callerid` WRITE;
/*!40000 ALTER TABLE `settings_callerid` DISABLE KEYS */;
INSERT INTO `settings_callerid` VALUES (0,0,'31','78','0','00',1,0),(1,-1,'31','78','0','00',-1,0);
/*!40000 ALTER TABLE `settings_callerid` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-01-02 17:16:53
