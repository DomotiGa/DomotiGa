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
-- Dumping data for table `devicetypes`
--

INSERT INTO `devicetypes` VALUES (246,'P1 Meter','Utility Meter','NTA8130','P1-MBus1-4, P1-PowerUsed, P1-PowerDelivered','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

--
-- Dumping data for table `interfaces`
--

INSERT INTO `interfaces` VALUES (38,'SmartMeter Interface','NTA8130','Read');

--
-- Table structure for table `settings_nta8130`
--

DROP TABLE IF EXISTS `settings_nta8130`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_nta8130` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `serialport` varchar(32) DEFAULT NULL,
  `baudrate` varchar(32) DEFAULT NULL,
  `databits` int(11) DEFAULT NULL,
  `stopbits` int(11) DEFAULT NULL,
  `parity` int(11) DEFAULT NULL,
  `requestline` varchar(32) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_nta8130`
--

LOCK TABLES `settings_nta8130` WRITE;
/*!40000 ALTER TABLE `settings_nta8130` DISABLE KEYS */;
INSERT INTO `settings_nta8130` VALUES (0,0,'192.168.100.7',10002,'serial','/dev/ttyUSB7','9600',7,1,1,'',0),(1,0,'192.168.100.7',10002,'serial','/dev/ttyUSB5','9600',7,1,1,'',1);
/*!40000 ALTER TABLE `settings_nta8130` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
INSERT INTO `version` VALUES (43,'0.1.208');
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-05-31 13:15:26
