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
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `db` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES (1,'0.1.166'),(2,'0.1.167'),(3,'0.1.168'),(4,'0.1.169'),(5,'0.1.170'),(6,'0.1.171'),(7,'0.1.172'),(8,'0.1.173'),(9,'0.1.174'),(10,'0.1.175'),(11,'0.1.176'),(12,'0.1.177'),(13,'0.1.178'),(14,'0.1.179'),(15,'0.1.180'),(16,'0.1.181'),(17,'0.1.182'),(18,'0.1.183'),(19,'0.1.184'),(20,'0.1.185'),(21,'0.1.186'),(22,'0.1.187'),(23,'0.1.188'),(24,'0.1.189'),(25,'0.1.190'),(26,'0.1.191'),(27,'0.1.192'),(28,'0.1.193'),(29,'0.1.194'),(30,'0.1.195'),(31,'0.1.196'),(32,'0.1.197'),(33,'0.1.198'),(34,'0.1.199'),(35,'0.1.200'),(36,'0.1.201');
/*!40000 ALTER TABLE `version` ENABLE KEYS */;

--
-- Table structure for table `settings_shell`
--

DROP TABLE IF EXISTS `settings_shell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_shell` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `polltime` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_shell`
--

LOCK TABLES `settings_shell` WRITE;
/*!40000 ALTER TABLE `settings_shell` DISABLE KEYS */;
INSERT INTO `settings_shell` VALUES (0,0,300,0),(1,0,300,0);
/*!40000 ALTER TABLE `settings_shell` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_x10cmd`;
--

DROP TABLE IF EXISTS `settings_heyu`;
DROP TABLE IF EXISTS `settings_x10cmd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_x10cmd` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `command` varchar(32) DEFAULT NULL,
  `monitor` tinyint(1) DEFAULT NULL,
  `globalx10` tinyint(1) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_x10cmd`
--

LOCK TABLES `settings_x10cmd` WRITE;
/*!40000 ALTER TABLE `settings_x10cmd` DISABLE KEYS */;
INSERT INTO `settings_x10cmd` VALUES (0,0,'/usr/local/bin/heyu',0,0,0,0),(1,0,'/usr/local/bin/heyu',0,0,0,0);
/*!40000 ALTER TABLE `settings_x10cmd` ENABLE KEYS */;
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
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interfaces`
--

LOCK TABLES `interfaces` WRITE;
/*!40000 ALTER TABLE `interfaces` DISABLE KEYS */;
INSERT INTO `interfaces` VALUES (1,'RFXCom Receiver','X10 X10Security Oregon KAKU RFXCom HE ATI Digimax','Read'),(2,'Xanura CTX35','X10','Read Write'),(3,'Midon TEMP08','1-Wire','Read Write'),(4,'HDDTemp Socket','HDDTemp','Read'),(5,'Ping Socket','Ping','Read'),(6,'UPS Socket','UPS','Read'),(7,'X10Cmd Interface','X10','Write'),(8,'Bluetooth Dongle','Bluetooth','Read'),(9,'Weeder I/O Bus','Weeder','Read Write'),(10,'Plugwise Stick','Plugwise','Read Write'),(11,'DSC5401 Interface','DSC','Read Write'),(12,'RFXCom Transmitter','X10 ARC AC RFXCom X10Security HEEU Digimax Harrison Koppla Waveman Flamingo','Read Write'),(13,'KNX/EIB Interface','KNX/EIB','Read Write'),(14,'Digitemp','1-Wire','Read'),(15,'Z-Wave Controller','Z-Wave','Read Write'),(16,'PLCBUS Interface','PLCBUS','Read Write'),(17,'Virtual Interface','Virtual','Read Write'),(18,'SqueezeServer Interface','Squeeze','Read Write'),(19,'Current Cost Receiver','CurrentCost','Read'),(20,'EZcontrol T10 Interface','T10-Preset FS10 FS20 RS200 AB400 AB601 IT REV BS-QU MARMI OA-FM KO-FC RS862','Write'),(21,'LIRC Interface','LIRC','Read'),(22,'PwrCtrl Interface','PwrCtrl','Read Write'),(23,'Denon Interface','Denon','Read Write'),(24,'Onkyo Interface','Onkyo','Read Write'),(25,'SharpTV Interface','SharpTV','Read Write'),(26,'LGTV Interface','LGTV','Read Write'),(27,'iPort Interface','iPort','Read Write'),(28,'Google Latitude','GLatitude','Read'),(29,'JeeLabs Interface','JeeLabs','Read Write'),(30,'Velleman K8055','K8055','Read Write'),(31,'OWFS Interface','1-Wire','Read Write'),(32,'CUL Interface','FS20 EM1000 FHT S300 HMS','Read Write'),(33,'RFXCom xPL','X10 X10Security Oregon KAKU RFXCom HE ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison RFXLanIO','Read Write'),(34,'Shell Interface','Shell','Read');
/*!40000 ALTER TABLE `interfaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_plcbus`
--

ALTER TABLE `settings_plcbus` ADD COLUMN `ack` tinyint(1) default NULL AFTER housecodes;

--
-- Table structure for table `settings_main`
--

ALTER TABLE `settings_main` ADD COLUMN `autodevicecreate` tinyint(1) default NULL AFTER homebottompanel;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Lighting'),(2,'Holiday'),(3,'Security'),(4,'E-mail'),(6,'Nightly'),(5,'Daytime'),(7,'Audio'),(8,'Video'),(9,'System');
UNLOCK TABLES;

ALTER TABLE `events` ADD COLUMN `category` int(11) default NULL AFTER reruntype;

--
-- Table structure for table `settings_rfxcomxpl`
--

DROP TABLE IF EXISTS `settings_rfxcomxpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_rfxcomxpl` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `rxaddress` varchar(64) DEFAULT NULL,
  `txaddress` varchar(64) DEFAULT NULL,
  `oldaddrfmt` tinyint(1) DEFAULT NULL,
  `globalx10` tinyint(1) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_rfxcomxpl`
--

LOCK TABLES `settings_rfxcomxpl` WRITE;
/*!40000 ALTER TABLE `settings_rfxcomxpl` DISABLE KEYS */;
INSERT INTO `settings_rfxcomxpl` VALUES (0,0,'rfxcom-lan.0004a31543ab','rfxcom-lan.0004a31543ab',0,0,0),(1,0,'rfxcom-lan.0004a31543ac','rfxcom-lan.0004a31543ac',0,0,0);
/*!40000 ALTER TABLE `settings_rfxcomxpl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_xpl`
--
--
-- Table structure for table `settings_xpl`
--

DROP TABLE IF EXISTS `settings_xpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_xpl` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `heartbeat` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_xpl`
--

LOCK TABLES `settings_xpl` WRITE;
/*!40000 ALTER TABLE `settings_xpl` DISABLE KEYS */;
INSERT INTO `settings_xpl` VALUES (0,0,5,0),(1,0,5,0);
/*!40000 ALTER TABLE `settings_xpl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_telnetserver`
--

DROP TABLE IF EXISTS `settings_telnetserver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_telnetserver` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `telnetport` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_telnetserver`
--

LOCK TABLES `settings_telnetserver` WRITE;
/*!40000 ALTER TABLE `settings_telnetserver` DISABLE KEYS */;
INSERT INTO `settings_telnetserver` VALUES (0,1,8082,0),(1,0,8082,0);
/*!40000 ALTER TABLE `settings_telnetserver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Data for table `menu`
--

INSERT INTO menu VALUES(0,'Network','FNetwork',2,1,'network.png',1);

--
-- Data for table `groups`
--

INSERT INTO groups VALUES (0,'Network');

--
-- Data for table `users`
--

INSERT INTO users VALUES(0,'mhsend','','mhsend user',0,'user for telnetserver','','');

--
-- Renaming table `settings_onewire`
--

ALTER TABLE settings_onewire RENAME settings_temp08;

--
-- Converting table `devices`
--

-- SELECT * FROM `devices` INTO OUTFILE '/tmp/devices.csv'
-- FIELDS TERMINATED BY ',' ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n';

ALTER TABLE `devices` ADD COLUMN `correction` text AFTER calibration4;
ALTER TABLE `devices` ADD COLUMN `correction2` text AFTER correction;
ALTER TABLE `devices` ADD COLUMN `correction3` text AFTER correction2;
ALTER TABLE `devices` ADD COLUMN `correction4` text AFTER correction3;

UPDATE `devices` SET `divider`=1 WHERE `divider`=0;
UPDATE `devices` SET `divider2`=1 WHERE `divider2`=0;
UPDATE `devices` SET `divider3`=1 WHERE `divider3`=0;
UPDATE `devices` SET `divider4`=1 WHERE `divider4`=0;

UPDATE `devices` SET `correction`=concat( 'Value/', divider) WHERE `divider`!=1;
UPDATE `devices` SET `correction2`=concat( 'Value2/', divider2) WHERE `divider2`!=1;
UPDATE `devices` SET `correction3`=concat( 'Value3/', divider3) WHERE `divider3`!=1;
UPDATE `devices` SET `correction4`=concat( 'Value4/', divider4) WHERE `divider4`!=1;

UPDATE `devices` SET `correction`=concat( '(',correction,')', '+', calibration) WHERE `calibration`<>0 AND `correction`!="" AND LEFT(`calibration`, 1)!='-';
UPDATE `devices` SET `correction`=concat( '(',correction,')', calibration) WHERE `calibration`<>0 AND `correction`!="" AND LEFT(`calibration`, 1)='-';

UPDATE `devices` SET `correction2`=concat( '(',correction2,')', '+', calibration2) WHERE `calibration2`<>0 AND `correction2`!="" AND LEFT(`calibration2`, 1)!='-';
UPDATE `devices` SET `correction2`=concat( '(',correction2,')', calibration2) WHERE `calibration2`<>0 AND `correction2`!="" AND LEFT(`calibration2`, 1)='-';

UPDATE `devices` SET `correction3`=concat( '(',correction3,')', '+', calibration3) WHERE `calibration3`<>0 AND `correction3`!="" AND LEFT(`calibration3`, 1)!='-';
UPDATE `devices` SET `correction3`=concat( '(',correction3,')', calibration3) WHERE `calibration3`<>0 AND `correction3`!="" AND LEFT(`calibration3`, 1)='-';

UPDATE `devices` SET `correction4`=concat( '(',correction4,')', '+', calibration4) WHERE `calibration4`<>0 AND `correction4`!="" AND LEFT(`calibration4`, 1)!='-';
UPDATE `devices` SET `correction4`=concat( '(',correction4,')', calibration4) WHERE `calibration4`<>0 AND `correction4`!="" AND LEFT(`calibration4`, 1)='-';

UPDATE `devices` SET `correction`=concat( 'Value+', calibration) WHERE `calibration`!=0 AND `correction`=0 AND LEFT(`calibration`, 1)!='-';
UPDATE `devices` SET `correction`=concat( 'Value', calibration) WHERE `calibration`!=0 AND `correction`=0 AND LEFT(`calibration`, 1)='-';

UPDATE `devices` SET `correction2`=concat( 'Value2+', calibration2) WHERE `calibration2`!=0 AND `correction2`=0 AND LEFT(`calibration2`, 1)!='-';
UPDATE `devices` SET `correction2`=concat( 'Value2', calibration2) WHERE `calibration2`!=0 AND `correction2`=0 AND LEFT(`calibration2`, 1)='-';

UPDATE `devices` SET `correction3`=concat( 'Value3+', calibration3) WHERE `calibration3`!=0 AND `correction3`=0 AND LEFT(`calibration3`, 1)!='-';
UPDATE `devices` SET `correction3`=concat( 'Value3', calibration3) WHERE `calibration3`!=0 AND `correction3`=0 AND LEFT(`calibration3`, 1)='-';

UPDATE `devices` SET `correction4`=concat( 'Value4+', calibration4) WHERE `calibration4`!=0 AND `correction4`=0 AND LEFT(`calibration4`, 1)!='-';
UPDATE `devices` SET `correction4`=concat( 'Value4', calibration4) WHERE `calibration4`!=0 AND `correction4`=0 AND LEFT(`calibration4`, 1)='-';

--
-- Table structure for table `devicetypes`
--

-- SELECT * FROM `devicetypes` INTO OUTFILE '/tmp/devicetypes.csv'
-- FIELDS TERMINATED BY ',' ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n';

DROP TABLE IF EXISTS `devicetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devicetypes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `description` varchar(32) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `addressformat` varchar(128) DEFAULT NULL,
  `onicon` varchar(32) DEFAULT NULL,
  `officon` varchar(32) DEFAULT NULL,
  `dimicon` varchar(32) DEFAULT NULL,
  `switchable` tinyint(1) DEFAULT NULL,
  `dimable` tinyint(1) DEFAULT NULL,
  `extcode` tinyint(1) DEFAULT NULL,
  `label` int(11) DEFAULT NULL,
  `label2` int(11) DEFAULT NULL,
  `label3` int(11) DEFAULT NULL,
  `label4` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=500 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devicetypes`
--

LOCK TABLES `devicetypes` WRITE;
/*!40000 ALTER TABLE `devicetypes` DISABLE KEYS */;
INSERT INTO `devicetypes` VALUES (1,'Marmitek DS90','Door/Window Sensor','X10Security','DWS[256]S or \'dws 0xb62bc6\'','motion-on.gif','motion-off.gif','',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'Marmitek LW10G','Lamp Module','X10','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(3,'Marmitek LD11','Dimmer Module','X10','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(4,'Marmitek MS13E M','Motion Sensor','X10','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(5,'Marmitek MS13E L','Light Sensor','X10','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(6,'Xanura SAX35','I/O Actor','X10','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(7,'Oregon THGR238N','Temp/Hygro Sensor','Oregon','TH1[256] or \'th1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(8,'Oregon UV138','UV Light Sensor','Oregon','UV1[256] or \'uv1 0xf600\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(9,'RFXPwr Power','Power Usage Sensor','RFXCom','RFXMETER[256]M or \'rfxmeter 0xf0\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(10,'Marmitek TM13','Wireless Tranceiver','X10','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(11,'HDDTemp Item','Temp Monitor','HDDTemp','/dev/sda',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(12,'Oregon THR128','Temp Sensor','Oregon','TEMP1[256] or \'temp1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(13,'Sony AIBO','Status AIBO','Ping','192.168.1.10',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(14,'APC SmartUPS1000','SmartUPS','UPS','smartups1000',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(15,'Dallas DS18S20','Temp Sensor','1-Wire','1049023A01080011',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(16,'Dallas Rain Gauge','Rain Gauge','1-Wire','1D3AB905000000DB',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(17,'Marmitek SD90','Smoke Detector','X10Security','DWS[256]S or \'dws 0xb62bc6\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(18,'Bluetooth Device','Phone','Bluetooth','00:1C:22:39:9D:31',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(19,'ITHO ECO Fan','Central Ventilation','Weeder','A',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(20,'RFXPulse Gas','Gas Usage Sensor','RFXCom','RFXMETER[256]M or \'rfxmeter 0xf0\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(21,'RFXPulse Water','Water Usage Sensor','RFXCom','RFXMETER[256]M or \'rfxmeter 0xf0\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(22,'Oregon BWR102','Digital Bathroom Scale','Oregon','WEIGHT1[1] or \'weight1 0x1\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(23,'Oregon GR101','Digital Bathroom Scale','Oregon','WEIGHT2[1] or \'weight2 0x01\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(24,'Oregon THC138','Temp Sensor','Oregon','TEMP1[256] or \'temp1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(25,'Oregon THR138','Temp Sensor','Oregon','TEMP1[256] or \'temp1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(26,'Oregon THGR810','Temp/Hygro Sensor','Oregon','TH2[256] or \'th2 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(27,'Plugwise Circle','Zigbee Appliance Module','Plugwise','000D6F000021811A',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(28,'Plugwise Circle+','Zigbee Appliance Module','Plugwise','000D6F000021811A',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(29,'KAKU Chime','Wireless Doorbell','X10','C1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(30,'Oregon THN132N','Temp Sensor','Oregon','TEMP2[256] or \'temp2 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(31,'Oregon THWR288','Temp Sensor','Oregon','TEMP2[256] or \'temp2 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(32,'Oregon BTHR918N','Baro/Temp/Hygro Sensor','Oregon','THB1[256] or \'thb1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(33,'Oregon BTHR968','Baro/Temp/Hygro Sensor','Oregon','THB2[256] or \'thb2 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(34,'Marmitek AD10','Switch Module','X10','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(35,'Marmitek LM12','Lamp Module','X10','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(36,'Marmitek AM12','Appliance Module','X10','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(37,'Oregon WGR918','Anemo Meter','Oregon','WIND3[256] or \'wind3 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(38,'Oregon PCR800','Rain Gauge','Oregon','RAIN2[256] or \'rain2 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(39,'Oregon RTGR328N','Temp/Hygro/Time Sensor','Oregon','TH3[256] & DT1[256] or \'th3 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(40,'DSC PIR','Motion Sensor','DSC','Living',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(41,'DSC Contact','Door/Window Sensor','DSC','Backdoor',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(42,'DSC Smoke','Smoke Detector','DSC','Kitchen',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(43,'HE Module','HE Module','HE','013B5A11 or \'0x013B5A11 10\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(44,'3160HE Shutter Control Module','Crystal Shutter Control Module','PLCBUS','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(45,'KNX/EIB Dim','EIS 2','KNX/EIB','0/1/2|0/1/3|0/1/4',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(46,'KNX/EIB On/Off','EIS 1','KNX/EIB','0/1/2',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(47,'KNX/EIB Values','EIS 5','KNX/EIB','0/1/2',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(48,'KNX/EIB Date','EIS 4','KNX/EIB','0/1/2',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(49,'KNX/EIB Time','EIS 3','KNX/EIB','0/1/2',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(50,'KNX/EIB Scaling %','EIS 6','KNX/EIB','0/1/2',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(51,'KNX/EIB Motor Drives','EIS 7','KNX/EIB','0/1/2',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(52,'KNX/EIB Forced Control','EIS 8','KNX/EIB','0/1/2',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(53,'KNX/EIB 32bit Float','EIS 9','KNX/EIB','0/1/2',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(54,'KNX/EIB 16bit Int','EIS 10','KNX/EIB','0/1/2',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(55,'KNX/EIB 32bit Int','EIS 11','KNX/EIB','0/1/2',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(56,'KNX/EIB 8bit Int','EIS 14','KNX/EIB','0/1/2',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(57,'KNX/EIB 14byte Text','EIS 15','KNX/EIB','0/1/2',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(58,'Dallas DS2423','4Kbit RAM + Counter','1-Wire','1D3AB905000000DB',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(59,'ARC Module','ARC Module','ARC','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(60,'AC Module','AC Module','AC','013B5A11 or \'0x013B5A11 10\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(61,'Z-Wave Switch','Binary Switch','Z-Wave','1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(62,'Z-Wave Dimmer','Multilevel Switch','Z-Wave','3',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(63,'Z-Wave D/W Sensor','Door/Window Sensor','Z-Wave','4',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(64,'Z-Wave PIR Sensor','Motion Sensor','Z-Wave','2',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(65,'Dallas DS2438','Smart Battery Monitor ','1-Wire','26D050E7000000FF',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(66,'Cent-a-Meter','Power Usage Sensor','Oregon','ELEC1[256] or \'elec1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(67,'Marmitek DS10','Door/Window Sensor','X10Security','DWS[256]S or \'dws 0xb62bc6\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(68,'Visonic MCT302','Door/Window Sensor','X10Security','DWS[1DD9AE]S or \'dws 0xf0f1aa\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(69,'Marmitek MS90','Motion Sensor','X10Security','MOTION[256]S or \'motion 0xb62bc6\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(70,'Marmitek KR10','Keychain Security Remote','X10Security','REMOTE[256]S or \'remote 0xb62cc6\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(71,'Visonic MCT234','Security Remote KeyFob','X10Security','REMOTE[256]S or \'remote 0xf0f1aa\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(72,'Network Device','Status On/Off','Ping','192.168.1.10',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(73,'Network Host','Status Up/Down','Ping','192.168.1.10',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(74,'Oregon WTGR800','Anemo/Temp/Hygro Sensor','Oregon','TH5[256] & WIND1[256] or \'th5 0x701\' & \'wind1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(75,'Oregon BWR101','Digital Bathroom Scale','Oregon','WEIGHT1[1] or \'weight1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(76,'OWL CM113','Power Usage Sensor','Oregon','ELEC1[256] or \'elec1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(77,'Electrisave','Power Usage Sensor','Oregon','ELEC1[256] or \'elec1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(78,'OWL CM119','Power Usage Sensor','Oregon','ELEC2[256] or \'elec2 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(79,'Oregon THC238','Temp Sensor Remote','Oregon','TEMP2[256] or \'temp2 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(80,'Oregon THC268','Temp Sensor Remote','Oregon','TEMP2[256] or \'temp2 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(81,'Oregon THN122N','Temp Sensor','Oregon','TEMP2[256] or \'temp2 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(82,'Oregon AW129','BBQ Thermometer','Oregon','TEMP2[256] or \'temp2 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(83,'Oregon AW131','BBQ Thermometer','Oregon','TEMP2[256] or \'temp2 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(84,'Oregon THWR800','Temp Sensor Floating','Oregon','TEMP3[256] or \'temp3 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(85,'Oregon RTHN318','Temp Sensor Outdoor','Oregon','TEMP4[256] or \'temp4 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(86,'Oregon THGN122N','Temp/Hygro Sensor','Oregon','TH1[256] or \'th1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(87,'Oregon THGN123N','Temp/Hygro Sensor','Oregon','TH1[256] or \'th1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(88,'Oregon THGR122N','Temp/Hygro Sensor','Oregon','TH1[256] or \'th1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(89,'Oregon THGR228N','Temp/Hygro Sensor','Oregon','TH1[256] or \'th1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(90,'Oregon THGR328N','Temp/Hygro Sensor','Oregon','TH1[256] or \'th1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(91,'Oregon THGR268','Temp/Hygro Sensor','Oregon','TH1[256] or \'th1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(92,'Oregon THGR918','Temp/Hygro Sensor Outdoor','Oregon','TH6[256] or \'th6 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(93,'Oregon THGR228','Temp/Hygro Sensor Outdoor','Oregon','TH6[256] or \'th6 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(94,'Oregon RGR126','Rain Gauge','Oregon','RAIN1[256] or \'rain1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(95,'Oregon RGR682','Rain Gauge','Oregon','RAIN1[256] or \'rain1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(96,'Oregon RGR918','Rain Gauge','Oregon','RAIN1[256] or \'rain1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(97,'Oregon WGR800','Anemo Meter','Oregon','WIND2[256] or \'wind2 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(98,'Oregon UVR128','UV Light Sensor','Oregon','UV1[256] or \'uv1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(99,'Oregon UVN800','UV Light Sensor','Oregon','UV2[256] or \'uv2 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(100,'RFXSensor Temp','Temp Sensor','RFXCom','RFXSENSOR[256]T or \'rfxsensor 0xf0\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(101,'RFXSensor A/D','A/D Sensor','RFXCom','RFXSENSOR[256]Z or \'rfxsensor 0xf0\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(102,'RFXSensor Voltage','Supply Voltage (Internal)','RFXCom','RFXSENSOR[256]V or \'rfxsensor 0xf0\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(103,'Marmitek SH624','Security Remote','X10Security','REMOTE[256]S or \'remote 0xb62cc6\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(104,'Marmitek KR21','Keychain Security Remote','X10Security','REMOTE[256]S or \'remote 0xb62cc6\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(105,'Visonic MCT302','Door/Window Sensor','X10Security','DWS[1DD9AE]S or \'dws 0xf0f1aa\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(106,'Visonic MCT425','Smoke Detector','X10Security','REMOTE[256]S or \'remote 0xf0f1aa\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(107,'Audio System','Audio System Status','Virtual','audiosystem',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(108,'Security System','Security System Status','Virtual','securitysystem',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(109,'Video System','Video System Status','Virtual','videosystem',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(110,'RFXPulse Power','Power Usage Sensor','RFXCom','RFXMETER[256]M or \'rfxmeter 0xf0\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(111,'Visonic K980','Motion Sensor','X10Security','MOTION[256]S or \'motion 0xf0f1aa\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(112,'Squeeze Player','Audio Player','Squeeze','00:00:00:00:00:01',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(113,'ATI Wonder','Remote Control','ATI','ATI[256]C',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(114,'ATI Wonder Plus','Remote Control','ATI','ATIPLUS[256]C',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(115,'APC BackUPS550','BackUPS','UPS','backups550',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(116,'2016 Dimmer Module','Lamp Module','PLCBUS','A1','','','',0,0,0,NULL,NULL,NULL,NULL),(117,'2017 Appliance Module','Appliance Module','PLCBUS','A1','','','',0,0,0,NULL,NULL,NULL,NULL),(118,'Universal Remote','Remote Control','LIRC','denon',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(119,'ELV FS10','Lamp/Appliance Module','FS10','hc|0|address|repeat',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(120,'ELV FS20 Dimmer Module','Dimmer Module','FS20','hc|hc2|addr|repeat|arg or \'552900\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(121,'SLG RS200','Appliance Module','RS200','hc|0|address|repeat',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(122,'ELRO AB400','Appliance Module','AB400','hc|0|address|repeat',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(123,'ELRO AB601','Appliance Module','AB601','hc|0|address|repeat',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(124,'Intertechno / Düwi','Appliance Module','IT','hc|hc2|address|repeat',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(125,'REV Ritter','Appliance Module','REV','hc|0|address|repeat',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(126,'Brennenstuhl & Quigg','Appliance Module','BS-QU','hc|0|address|repeat',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(127,'Kopp F.C.','Appliance Module','KO-FC','hc|0|address|repeat',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(128,'Marmitek TM13','Wireless Tranceiver','MARMI','hc|0|address|repeat',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(129,'InScenio OASE FM-Master','Appliance Module','OA-FM','hc|0|address|repeat',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(130,'Europe Supplies Ltd. RS862','Appliance Module','RS862','hc|0|address|repeat',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(131,'Current Cost CC128','Power Usage Sensor','CurrentCost','1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(132,'T10 Preset Device','Lamp/Appliance Module','T10-Preset','12',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(133,'Denon Receiver','AV Receiver','Denon','fixed',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(134,'Onkyo Receiver','AV Receiver','Onkyo','fixed',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(135,'PwrCtrl Device 3 Ports','NET-PwrCtrl','PwrCtrl','192.168.100.2|3',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(136,'PwrCtrl Device 8 Ports','NET-PwrCtrl','PwrCtrl','192.168.100.2|3',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(137,'Sharp TV','TV','SharpTV','fixed',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(138,'LG TV','TV','LGTV','fixed',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(139,'RFXSensor Baro','Barometric Sensor','RFXCom','RFXSENSOR[256]Z or \'rfxsensor 0xf0\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(140,'RFXSensor Humid','Humidity Sensor','RFXCom','RFXSENSOR[256]Z or \'rfxsensor 0xf0\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(141,'Latitude Location','Location Device','GLatitude','-724328323322342424',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(142,'Rooms JeeNode','Rooms JeeNode','JeeLabs','x',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(143,'Meter JeeNode','Meter JeeNode','JeeLabs','x',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(144,'Digimax RTS10','Thermostat','RTS10','DIGIMAX[44321]',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(145,'Dallas DS2405','Addressable Switch','1-Wire','05393730000000',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(146,'K8055 Digital Out','Digital Output port','K8055','DO1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(147,'K8055 Digital In','Digital Input port','K8055','DI1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(148,'K8055 Analog Out','Analog Output port','K8055','AO1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(149,'K8055 Analog In','Analog Input port','K8055','AI1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(150,'Harrison Curtain Module','Harrison Module','Harrison','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(151,'Koppla Module','Appliance Module','Koppla','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(152,'Waveman','Waveman Module','Waveman','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(153,'Flamingo Module','Flamingo Module','Flamingo','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(154,'HomeEasy EU','HomeEasy EU Module','HEEU','',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(155,'MGE Protection Center 657','MGE','UPS','mgeups',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(156,'ELV FHT80TF Sensor','Door/Window Sensor','FHT','12A214',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(157,'ELV FHT80B Thermostat','Thermostat Unit','FHT','1251',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(158,'ELV FHT80V Valve','Radiator Valve','FHT','1231',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(159,'PLCBUS Scene','Scene Address','PLCBUS','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(160,'Status Device','Generic Status Device','Virtual','name',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(161,'2267 Micro Appliance','Appliance Micro Module','PLCBUS','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(162,'2263 Micro Dimmer','Micro Dimmer Module','PLCBUS','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(163,'4208 Metal Double Button','Double Button Wall Switch','PLCBUS','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(164,'2224 Wall Switch','Crystal Wall Switch','PLCBUS','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(165,'2280 PT Single Button','PT Single Button Wall Switch','PLCBUS','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(166,'ELV EM1000-WZ','Power Usage Sensor','EM1000','01',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(167,'ELV EM1000-GZS','Gas Usage Sensor','EM1000','01',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(168,'ELV EM1000-HSM','Power Usage Module','EM1000','01',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(169,'ELV EM1000-FM','Power Usage Plug','EM1000','01',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(170,'Conrad S555TH','Temp/Hygro Sensor','S300','1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(171,'ELV HMS100T','Temp/Hygro Sensor','HMS','1234',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(172,'Shell Value Device','Get values from cmd','Shell','/usr/local/bin/script.sh',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(173,'ELV S300TH','Temp/Hygro Sensor','S300','1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(174,'Chacon Avidsen NEXA','Smoke Detector','X10Security','smoke 0x0f121',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(175,'Visonic MCT550','Water Sensor','X10Security','dws 0xf0f1aa',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(176,'Marmitek MS10','Motion Sensor','X10Security','MOTION[256]S or \'motion 0xb62bc6\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(177,'Marmitek SD18','Smoke Detector','X10Security','DWS[256]S or \'dws 0xb62bc6\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(178,'X10-Pro HP564','Keychain Security Remote','X10Security','REMOTE[256]S or \'remote 0xb62cc6\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(179,'Marmitek DM10','Motion Sensor','X10Security','MOTION[256]S or \'motion 0xb62bc6\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(180,'Digimax 210','Thermostat','Digimax','DIGIMAX[44321] or \'digimax 0xfa10\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(181,'2224 Crystal Appliance Switch','Crystal Appliance Switch','PLCBUS','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(182,'2220 Crystal Lamp Switch','Crystal Wall Switch','PLCBUS','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(183,'2221 Crystal Double Lamp Switch','Crystal Double Lamp Switch','PLCBUS','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(184,'2225 Crystal Double Appl Switch','Crystal Double Appl Switch','PLCBUS','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(185,'2264 Two-Load Lamp Module','Two-Load Lamp Module','PLCBUS','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(186,'2268 Two-Load Appliance Module','Two-Load Appliance Module','PLCBUS','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(187,'2281 PT Double Button Switch','PT Double Button Wall Switch','PLCBUS','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(188,'2284 PT Fluorescent Light Switch','PT Fluorescent Light Switch','PLCBUS','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(189,'2285 PT Double Flu. Light Switch','PT Double Flu. Light Switch','PLCBUS','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(190,'3366 Curtain Module','Curtain Module','PLCBUS','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(191,'RFXLAN Digital Output','Digital Output Port','RFXLanIO','io1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(192,'RFXLAN Digital Input','Digital Input Port','RFXLanIO','io1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(193,'Mertik Maxitrol Gas Fire','Gas Fire','Mertik','0x1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(194,'X10 Ninja Robocam','Camera Remote Control','Ninja','A',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(195,'HomeEasy HE105 Heating Control','Heating Controller','HE105','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(196,'Digimax RTS10','Thermostat','RTS10','A1',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(197,'Conrad FS20 Bell Button','Bell Button','FS20','552900',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(198,'Conrad FS20 Wireless Remote S4','Wireless Remote','FS20','552900',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(199,'Conrad FS20 Master Slave Socket','Master Slave Socket','FS20','522900',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(200,'Conrad FS20 Wireless Remote S8','Wireless Remote','FS20','522900',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(201,'Conrad FS20 Wall Transmitter','Wall Transmitter','FS20','552900',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(202,'Conrad FS20 Wireless Remote S16','Wireless Remote','FS20','522600',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(203,'Conrad FS20 Dimmer Slider','Dimmer Slider','FS20','522690',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(204,'Conrad FS20 Wireless Remote S20','Wireless Remote','FS20','533290',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(205,'Conrad FS20 Flush Mounted','Flush Mounted Module','FS20','522490',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(206,'ELV FS20 Touch Control TC8','Touch Control','FS20','553290',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(207,'ELV FS20 Motion Sensor PIRI','Motion Sensor','FS20','532290',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(208,'ELV FS20 Motion Sensor PIRU','Motion Sensor','FS20','553291',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(209,'ELV FS20 Door Window Sensor','Door/Window Sensor','FS20','553121',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(210,'ELV FS20 Applicance Module','Applicance Module','FS20','hc|hc2|addr|repeat|arg or \'552900\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(211,'ELV FS20 Wireless Gong FG','Wireless Gong','FS20','553211',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(212,'ELV FS20 Wireless Signal SIG','Wireless Signal','FS20','553121',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(213,'Dallas DS18B20','Temp Sensor','1-Wire','1049023A01080011',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(214,'Oregon THR128','Temp Sensor','Oregon','TEMP1[256] or \'temp1 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(215,'Oregon THGR328','Temp/Hygro Sensor','Oregon','TH4[256] or \'th4 0x701\'',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(216,'Unknown Device','Unknown device type','Unknown','*',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL),(217,'','','','','bell.png','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
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

-- Dump completed on 2011-10-25 16:47:18
