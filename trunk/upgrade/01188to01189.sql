-- MySQL dump 10.13  Distrib 5.1.41, for debian-linux-gnu (i486)
--
-- Host: localhost    Database: domotiga
-- ------------------------------------------------------
-- Server version	5.1.41-3ubuntu12.6

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
-- Table structure for table `devices`
--

ALTER TABLE `devices` CHANGE `graph` `rrd` tinyint(1) DEFAULT NULL;
ALTER TABLE `devices` ADD COLUMN `graph` tinyint(1) DEFAULT NULL AFTER rrd;
ALTER TABLE `devices` ADD COLUMN `logdisplay` tinyint(1) DEFAULT NULL AFTER log;
ALTER TABLE `devices` ADD COLUMN `logspeak` tinyint(1) DEFAULT NULL AFTER logdisplay;

--
-- Table structure for table `settings_onkyo`
--

DROP TABLE IF EXISTS `settings_onkyo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_onkyo` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `serialport` varchar(32) DEFAULT NULL,
  `baudrate` varchar(32) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_onkyo`
--

LOCK TABLES `settings_onkyo` WRITE;
/*!40000 ALTER TABLE `settings_onkyo` DISABLE KEYS */;
INSERT INTO `settings_onkyo` VALUES (0,0,'192.168.100.66',60128,'tcp','/dev/ttyUSB3','9600',0),(1,0,'192.168.100.67',60128,'serial','/dev/ttyUSBD0','9600',0);
/*!40000 ALTER TABLE `settings_onkyo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;


DROP TABLE IF EXISTS `devices_log`;
CREATE TABLE `devices_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceid` bigint(11) NOT NULL,
  `value` varchar(32) NOT NULL,
  `value2` varchar(32) DEFAULT NULL,
  `value3` varchar(32) DEFAULT NULL,
  `value4` varchar(32) DEFAULT NULL,
  `lastchanged` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `devicesid_date` (`deviceid`,`lastchanged`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `settings_heyu`
--

DROP TABLE IF EXISTS `settings_heyu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_heyu` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `command` varchar(32) DEFAULT NULL,
  `monitor` tinyint(1) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_heyu`
--

LOCK TABLES `settings_heyu` WRITE;
/*!40000 ALTER TABLE `settings_heyu` DISABLE KEYS */;
INSERT INTO `settings_heyu` VALUES (0,0,'/usr/local/bin/heyu',0,0),(1,0,'/usr/local/bin/heyu',0,0);
/*!40000 ALTER TABLE `settings_heyu` ENABLE KEYS */;
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
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interfaces`
--

LOCK TABLES `interfaces` WRITE;
/*!40000 ALTER TABLE `interfaces` DISABLE KEYS */;
INSERT INTO `interfaces` VALUES (1,'RFXCom Receiver','A10 X10 X10Security Oregon KAKU RFXCom HE Visonic ATI','Read'),(2,'Xanura CTX35','A10 X10','Read Write'),(3,'Midon TEMP08','1-Wire','Read Write'),(4,'HDDTemp Socket','HDDTemp','Read'),(5,'Ping Socket','Ping','Read'),(6,'UPS Socket','UPS','Read'),(7,'Heyu X10','A10 X10','Write'),(8,'Bluetooth Dongle','Bluetooth','Read'),(9,'Weeder I/O Bus','Weeder','Read Write'),(10,'Plugwise Stick','Plugwise','Read Write'),(11,'DSC5401 Interface','DSC','Read Write'),(12,'RFXCom Transmitter','X10 ARC AC RFXCom Visonic','Read Write'),(13,'KNX/EIB Interface','KNX/EIB','Read Write'),(14,'Digitemp','1-Wire','Read'),(15,'Z-Wave Controller','Z-Wave','Read Write'),(16,'PLCBUS Interface','PLCBUS','Read Write'),(17,'Virtual Interface','Virtual','Read Write'),(18,'SqueezeServer Socket','Squeeze','Read Write'),(19,'Current Cost Receiver','CurrentCost','Read'),(20,'EZcontrol T10 Interface','T10-Preset FS10 FS20 RS200 AB400 AB601 IT REV BS-QU MARMI OA-FM KO-FC RS862','Write'),(21,'LIRC Interface','LIRC','Read'),(22,'PwrCtrl Interface','PwrCtrl','Read Write'),(23,'Denon Interface','Denon','Read Write'),(24,'Onkyo Interface','Onkyo','Read Write');
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
  `addressformat` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=137 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devicetypes`
--

LOCK TABLES `devicetypes` WRITE;
/*!40000 ALTER TABLE `devicetypes` DISABLE KEYS */;
INSERT INTO `devicetypes` VALUES (1,'Marmitek DS90','Door/Window Sensor','X10Security','DWS[256]S'),(2,'Marmitek LW10G','Lamp Module','X10','A1'),(3,'Marmitek LD11','Dimmer Module','X10','A1'),(4,'Marmitek MS13E M','Motion Sensor','X10','A1'),(5,'Marmitek MS13E L','Light Sensor','X10','A1'),(6,'Xanura SAX35','I/O Actor','A10','A1'),(7,'Oregon THGR238N','Temp/Hygro Sensor','Oregon','TH1[256]'),(8,'Oregon UV138','UV Light Sensor','Oregon','UV1[256]'),(9,'RFXPwr Power','Power Usage Sensor','RFXCom','RFXMETER[256]M'),(10,'Marmitek TM13','Wireless Tranceiver','X10','A1'),(11,'HDDTemp Item','Temp Monitor','HDDTemp','/dev/sda'),(12,'Oregon THR128','Temp Sensor','Oregon','TEMP1[256]'),(13,'Sony AIBO','Status AIBO','Ping','192.168.1.10'),(14,'APC SmartUPS1000','Power Supply','UPS','smartups1000'),(15,'Dallas DS18S20','Temp Sensor','1-Wire','1049023A01080011'),(16,'Dallas Rain Gauge','Rain Gauge','1-Wire','1D3AB905000000DB'),(17,'Marmitek SD90','Smoke Detector','X10Security','DWS[256]S'),(18,'Bluetooth Device','Phone','Bluetooth','00:1C:22:39:9D:31'),(19,'ITHO ECO Fan','Central Ventilation','Weeder','A'),(20,'RFXPulse Gas','Gas Usage Sensor','RFXCom','RFXMETER[256]M'),(21,'RFXPulse Water','Water Usage Sensor','RFXCom','RFXMETER[256]M'),(22,'Oregon BWR102','Digital Bathroom Scale','Oregon','WEIGHT1[1]'),(23,'Oregon GR101','Digital Bathroom Scale','Oregon','WEIGHT2[1]'),(24,'Oregon THC138','Temp Sensor','Oregon','TEMP1[256]'),(25,'Oregon THR138','Temp Sensor','Oregon','TEMP1[256]'),(26,'Oregon THGR810','Temp/Hygro Sensor','Oregon','TH2[256]'),(27,'Plugwise Circle','Zigbee Appliance Module','Plugwise','000D6F000021811A'),(28,'Plugwise Circle+','Zigbee Appliance Module','Plugwise','000D6F000021811A'),(29,'KAKU Chime','Wireless Doorbell','X10','C1'),(30,'Oregon THN132N','Temp Sensor','Oregon','TEMP2[256]'),(31,'Oregon THWR288','Temp Sensor','Oregon','TEMP2[256]'),(32,'Oregon BTHR918N','Baro/Temp/Hygro Sensor','Oregon','THB1[256]'),(33,'Oregon BTHR968','Baro/Temp/Hygro Sensor','Oregon','THB2[256]'),(34,'Marmitek AD10','Switch Module','X10','A1'),(35,'Marmitek LM12','Lamp Module','X10','A1'),(36,'Marmitek AM12','Appliance Module','X10','A1'),(37,'Oregon WGR918','Anemo Meter','Oregon','WIND3[256]'),(38,'Oregon PCR800','Rain Gauge','Oregon','RAIN2[256]'),(39,'Oregon RTGR328N','Temp/Hygro/Time Sensor','Oregon','TH3[256] & DT1[256]'),(40,'DSC PIR','Motion Sensor','DSC','Living'),(41,'DSC Contact','Door/Window Sensor','DSC','Backdoor'),(42,'DSC Smoke','Smoke Detector','DSC','Kitchen'),(43,'KAKU AWST-8802','Wireless Wallswitch Dual','HE','013B5A11'),(44,'KAKU AMST-606','Door/Window Sensor','HE','013B5A11'),(45,'KNX/EIB Dim','EIS 2','KNX/EIB','0/1/2'),(46,'KNX/EIB On/Off','EIS 1','KNX/EIB','0/1/2'),(47,'KNX/EIB Values','EIS 5','KNX/EIB','0/1/2'),(48,'KNX/EIB Date','EIS 4','KNX/EIB','0/1/2'),(49,'KNX/EIB Time','EIS 3','KNX/EIB','0/1/2'),(50,'KNX/EIB Scaling %','EIS 6','KNX/EIB','0/1/2'),(51,'KNX/EIB Motor Drives','EIS 7','KNX/EIB','0/1/2'),(52,'KNX/EIB Forced Control','EIS 8','KNX/EIB','0/1/2'),(53,'KNX/EIB 32bit Float','EIS 9','KNX/EIB','0/1/2'),(54,'KNX/EIB 16bit Int','EIS 10','KNX/EIB','0/1/2'),(55,'KNX/EIB 32bit Int','EIS 11','KNX/EIB','0/1/2'),(56,'KNX/EIB 8bit Int','EIS 14','KNX/EIB','0/1/2'),(57,'KNX/EIB 14byte Text','EIS 15','KNX/EIB','0/1/2'),(58,'Dallas DS2423','4Kbit RAM + Counter','1-Wire','1D3AB905000000DB'),(59,'KAKU PAR 1000','Appliance Module','ARC','A1'),(60,'KAKU AC-300','Dimmer Module','AC','A1'),(61,'Z-Wave Switch','Binary Switch','Z-Wave','1'),(62,'Z-Wave Dimmer','Multilevel Switch','Z-Wave','3'),(63,'Z-Wave D/W Sensor','Door/Window Sensor','Z-Wave','4'),(64,'Z-Wave PIR Sensor','Motion Sensor','Z-Wave','2'),(65,'Dallas DS2438','Smart Battery Monitor ','1-Wire','26D050E7000000FF'),(66,'Cent-a-Meter','Power Usage Sensor','Oregon','ELEC1[256]'),(67,'Marmitek DS10','Door/Window Sensor','X10Security','DWS[256]S'),(68,'Visonic MCT302','Door/Window Sensor','Visonic','REMOTE[256]S'),(69,'Marmitek MS90','Motion Sensor','X10Security','MOTION[256]S'),(70,'Marmitek KR10','Keychain Security Remote','X10Security','REMOTE[256]S'),(71,'Visonic MCT234','Security Remote KeyFob','Visonic','REMOTE[256]S'),(72,'Network Device','Status On/Off','Ping','192.168.1.10'),(73,'Network Host','Status Up/Down','Ping','192.168.1.10'),(74,'Oregon WTGR800','Anemo/Temp/Hygro Sensor','Oregon','TH5[256] & WIND1[256]'),(75,'Oregon BWR101','Digital Bathroom Scale','Oregon','WEIGHT1[1]'),(76,'OWL CM113','Power Usage Sensor','Oregon','ELEC1[256]'),(77,'Electrisave','Power Usage Sensor','Oregon','ELEC1[256]'),(78,'OWL CM119','Power Usage Sensor','Oregon','ELEC1[256]'),(79,'Oregon THC238','Temp Sensor Remote','Oregon','TEMP2[256]'),(80,'Oregon THC268','Temp Sensor Remote','Oregon','TEMP2[256]'),(81,'Oregon THN122N','Temp Sensor','Oregon','TEMP2[256]'),(82,'Oregon AW129','BBQ Thermometer','Oregon','TEMP2[256]'),(83,'Oregon AW131','BBQ Thermometer','Oregon','TEMP2[256]'),(84,'Oregon THWR800','Temp Sensor Floating','Oregon','TEMP3[256]'),(85,'Oregon RTHN318','Temp Sensor Outdoor','Oregon','TEMP4[256]'),(86,'Oregon THGN122N','Temp/Hygro Sensor','Oregon','TH1[256]'),(87,'Oregon THGN123N','Temp/Hygro Sensor','Oregon','TH1[256]'),(88,'Oregon THGR122N','Temp/Hygro Sensor','Oregon','TH1[256]'),(89,'Oregon THGR228N','Temp/Hygro Sensor','Oregon','TH1[256]'),(90,'Oregon THGR328N','Temp/Hygro Sensor','Oregon','TH1[256]'),(91,'Oregon THGR268','Temp/Hygro Sensor','Oregon','TH1[256]'),(92,'Oregon THGR918','Temp/Hygro Sensor Outdoor','Oregon','TH6[256]'),(93,'Oregon THGR228','Temp/Hygro Sensor Outdoor','Oregon','TH6[256]'),(94,'Oregon RGR126','Rain Gauge','Oregon','RAIN1[256]'),(95,'Oregon RGR682','Rain Gauge','Oregon','RAIN1[256]'),(96,'Oregon RGR918','Rain Gauge','Oregon','RAIN1[256]'),(97,'Oregon WGR800','Anemo Meter','Oregon','WIND2[256]'),(98,'Oregon UVR128','UV Light Sensor','Oregon','UV1[256]'),(99,'Oregon UVN800','UV Light Sensor','Oregon','UV2[256]'),(100,'RFXSensor Temp','Temp Sensor','RFXCom','RFXSENSOR[256]T'),(101,'RFXSensor A/D Sensor','A/D Sensor','RFXCom','RFXSENSOR[256]Z'),(102,'RFXSensor Voltage','Supply Voltage (Internal)','RFXCom','RFXSENSOR[256]V'),(103,'Marmitek SH624','Security Remote','X10Security','REMOTE[256]S'),(104,'Marmitek KR21','Keychain Security Remote','X10Security','REMOTE[256]S'),(105,'Visonic HP564','Security Remote KeyFob','Visonic','REMOTE[256]S'),(106,'Visonic MCT425','Smoke Detector','Visonic','REMOTE[256]S'),(107,'Audio System','Audio System Status','Virtual','audiosystem'),(108,'Security System','Security System Status','Virtual','securitysystem'),(109,'Video System','Video System Status','Virtual','videosystem'),(110,'RFXPulse Power','Power Usage Sensor','RFXCom','RFXMETER[256]M'),(111,'Visonic K980','Motion Sensor','Visonic','MOTION[256]S'),(112,'Squeeze Player','Audio Player','Squeeze','00:00:00:00:00:01'),(113,'ATI Wonder','Remote Control','ATI','ATI[256]C'),(114,'ATI Wonder Plus','Remote Control','ATI','ATIPLUS[256]C'),(115,'APC BackUPS550','Power Supply','UPS','backups550'),(116,'PLCBUS Lamp Module','Lamp Module','PLCBUS','A01'),(117,'PLCBUS Appliance Module','Appliance Module','PLCBUS','A01'),(118,'Universal Remote','Remote Control','LIRC','denon'),(119,'ELV FS10','Lamp/Appliance Module','FS10','hc|0|address|repeat'),(120,'ELV FS20','Lamp/Appliance Module','FS20','hc|hc2|addr|repeat|arg'),(121,'SLG RS200','Appliance Module','RS200','hc|0|address|repeat'),(122,'ELRO AB400','Appliance Module','AB400','hc|0|address|repeat'),(123,'ELRO AB601','Appliance Module','AB601','hc|0|address|repeat'),(124,'Intertechno / Düwi','Appliance Module','IT','hc|hc2|address|repeat'),(125,'REV Ritter','Appliance Module','REV','hc|0|address|repeat'),(126,'Brennenstuhl & Quigg','Appliance Module','BS-QU','hc|0|address|repeat'),(127,'Kopp F.C.','Appliance Module','KO-FC','hc|0|address|repeat'),(128,'Marmitek TM13','Wireless Tranceiver','MARMI','hc|0|address|repeat'),(129,'InScenio OASE FM-Master','Appliance Module','OA-FM','hc|0|address|repeat'),(130,'Europe Supplies Ltd. RS862','Appliance Module','RS862','hc|0|address|repeat'),(131,'Current Cost CC128','Power Usage Sensor','CurrentCost','1'),(132,'T10 Preset Device','Lamp/Appliance Module','T10-Preset','12'),(133,'Denon Receiver','Denon Receiver','Denon','fixed'),(134,'Onkyo Receiver','Onkyo Receiver','Onkyo','fixed'),(135,'PwrCtrl Device 3 Ports','NET-PwrCtrl','PwrCtrl','192.168.100.2|3'),(136,'PwrCtrl Device 8 Ports','NET-PwrCtrl','PwrCtrl','192.168.100.2|3');
/*!40000 ALTER TABLE `devicetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_pwrctrl`
--

DROP TABLE IF EXISTS `settings_pwrctrl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_pwrctrl` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `udpread` int(11) DEFAULT NULL,
  `udpsend` int(11) DEFAULT NULL,
  `userpw` varchar(32) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_pwrctrl`
--

LOCK TABLES `settings_pwrctrl` WRITE;
/*!40000 ALTER TABLE `settings_pwrctrl` DISABLE KEYS */;
INSERT INTO `settings_pwrctrl` VALUES (0,0,7077,75,'userpw',0),(1,0,7077,75,'user1user',0);
/*!40000 ALTER TABLE `settings_pwrctrl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_irtrans`
--

DROP TABLE IF EXISTS `settings_irtrans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_irtrans` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_irtrans`
--

LOCK TABLES `settings_irtrans` WRITE;
/*!40000 ALTER TABLE `settings_irtrans` DISABLE KEYS */;
INSERT INTO `settings_irtrans` VALUES (0,0,'192.168.100.7',21000,0),(1,0,'192.168.100.7',21000,0);
/*!40000 ALTER TABLE `settings_irtrans` ENABLE KEYS */;
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
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES (1,'0.1.166'),(2,'0.1.167'),(3,'0.1.168'),(4,'0.1.169'),(5,'0.1.170'),(6,'0.1.171'),(7,'0.1.172'),(8,'0.1.173'),(9,'0.1.174'),(10,'0.1.175'),(11,'0.1.176'),(12,'0.1.177'),(13,'0.1.178'),(14,'0.1.179'),(15,'0.1.180'),(16,'0.1.181'),(17,'0.1.182'),(18,'0.1.183'),(19,'0.1.184'),(20,'0.1.185'),(21,'0.1.186'),(22,'0.1.187'),(23,'0.1.188'),(24,'0.1.189');
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Table structure for table `settings_twitter`
--

DROP TABLE IF EXISTS `settings_twitter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_twitter` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `sendtimestamp` tinyint(1) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_twitter`
--

LOCK TABLES `settings_twitter` WRITE;
/*!40000 ALTER TABLE `settings_twitter` DISABLE KEYS */;
INSERT INTO `settings_twitter` VALUES (0,0,'twitteraccount','password',0,0),(1,0,'twitteraccount','password',0,0);
/*!40000 ALTER TABLE `settings_twitter` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `item` varchar(32) DEFAULT NULL,
  `menu` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `icon` varchar(32) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'Home','FHome',1,1,'home.png',1),(2,'Control','FControl',1,2,'control.png',1),(3,'Floorplan','FFloorplans',1,6,'floorplan.png',1),(4,'Locations','FLocations',1,4,'locations.png',0),(5,'Climate','FClimate',1,5,'climate.png',1),(6,'Security','FSecurity',1,6,'security.png',1),(7,'HVAC','FHVAC',2,7,'hvac.png',1),(8,'Energy','FEnergy',1,8,'energy.png',1),(9,'Logfiles','FLogfiles',1,9,'logs.png',1),(10,'Phone','FPhone',1,1,'phone.png',1),(11,'Captures','FCaptures',2,2,'captures.png',1),(12,'Barcodes','FBarcodes',2,3,'stock.png',1),(13,'Camera','FCamera',2,4,'camera.png',1),(14,'Weather','FWeather',1,2,'weather.png',1),(15,'e-mail','FEmail',2,6,'email.png',0),(16,'News','FNews',2,7,'news.png',1),(17,'TV Guide','FTVGuide',2,2,'tvguide.png',1),(18,'Debug','FDebug',3,1,'system.png',1),(19,'Statistics','FServerStats',3,2,'serverstats.png',1),(20,'Events','FEvents',1,3,'events.png',1),(21,'Devices','FDevices',1,2,'devices.png',1),(22,'DSC Panel','FDSC',2,10,'security.png',1),(23,'Kitchen','Kitchen',4,1,'kitchen.png',1),(24,'Bathroom','Bathroom',4,2,'bathroom.png',1),(25,'Music','FMusic',2,1,'music.png',1);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-10-02 16:36:12
