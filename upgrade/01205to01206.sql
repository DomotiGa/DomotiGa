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
-- Table structure for table `settings_opentherm`
--

DROP TABLE IF EXISTS `settings_opentherm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_opentherm` (
  `id` int(11) NOT NULL,
  `temperatureoverride` varchar(32) DEFAULT NULL,
  `syncclock` tinyint(1) DEFAULT NULL,
  `outsidesensor` tinyint(1) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `serialport` varchar(32) DEFAULT NULL,
  `polltime` int(11) DEFAULT NULL,
  `thermostat` varchar(32) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_opentherm`
--

LOCK TABLES `settings_opentherm` WRITE;
/*!40000 ALTER TABLE `settings_opentherm` DISABLE KEYS */;
INSERT INTO `settings_opentherm` VALUES (0,'',0,0,0,'/dev/ttyUSB0',5,'Other',0),(1,'Temporarily',0,0,0,'/dev/ttyUSB0',5,'Other',0);
/*!40000 ALTER TABLE `settings_opentherm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `devicetypes`
--

INSERT INTO `devicetypes` VALUES (237,'OpenTherm Thermostat','OpenTherm Thermostat','OpenTherm','Thermostat','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (238,'OpenTherm Burner','OpenTherm Burner','OpenTherm','Burner','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (239,'OpenTherm Boiler','OpenTherm Boiler','OpenTherm','Boiler','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (240,'OpenTherm Central Heating','OpenTherm Central Heating','OpenTherm','CentralHeating','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (241,'OpenTherm Outside Temperature','OpenTherm Outside Temperature','OpenTherm','Outside','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

UPDATE devicetypes set addressformat="F1F1F1" WHERE id=234;

--
-- Dumping data for table `interfaces`
--

LOCK TABLES `interfaces` WRITE;
INSERT INTO `interfaces` VALUES (37,'OpenTherm gateway','OpenTherm','Read Write');
UNLOCK TABLES;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
INSERT INTO `version` VALUES (41,'0.1.206');
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
