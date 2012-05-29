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
-- Table structure for table `settings_zwave`
--

DROP TABLE IF EXISTS `settings_zwave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_zwave` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `serialport` varchar(32) DEFAULT NULL,
  `baudrate` varchar(32) DEFAULT NULL,
  `reloadnodes` tinyint(1) DEFAULT NULL,
  `useozw` tinyint(1) DEFAULT NULL,
  `polltime` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  `polltimesleeping` varchar(16) DEFAULT NULL,
  `enablepollsleeping` int(1) DEFAULT NULL,
  `updateneighbor` varchar(16) DEFAULT NULL,
  `enableupdateneighbor` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_zwave`
--

LOCK TABLES `settings_zwave` WRITE;
/*!40000 ALTER TABLE `settings_zwave` DISABLE KEYS */;
INSERT INTO `settings_zwave` VALUES (0,0,'/dev/ttyUSB4','115200',0,0,0,0,'*/30 * * * *',0,'30 23 * * *',0),(1,0,'/dev/ttyUSB3','115200',0,1,0,1,'*/30 * * * *',0,'30 23 * * *',0);
/*!40000 ALTER TABLE `settings_zwave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `devicetypes`
--

INSERT INTO `devicetypes` VALUES (242,'EZMotion 100','Multilevel Sensor','Z-Wave','3:1','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (243,'Duwi Switch','Binary Switch','Z-Wave','1','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (244,'Duwi Shade Controller','Shade Controller','Z-Wave','2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (245,'Cresta TX320','Temp/Hygro Sensor','Cresta','th7 0x3f0e','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

--
-- Dumping data for table `interfaces`
--
UPDATE `interfaces` SET `mode`='Read Write' WHERE `id`='34';
UPDATE `interfaces` SET `type`='X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta' WHERE `id`='35';
--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
INSERT INTO `version` VALUES (42,'0.1.207');
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-05-18 12:37:50
