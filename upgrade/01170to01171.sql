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
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `interfaces`
--

LOCK TABLES `interfaces` WRITE;
/*!40000 ALTER TABLE `interfaces` DISABLE KEYS */;
INSERT INTO `interfaces` VALUES (1,'RFXCom Receiver','A10 X10 Oregon KAKU RFXCom','Read'),(2,'Xanura CTX35','A10 X10','Read Write'),(3,'Midon TEMP08','One-Wire','Read Write'),(4,'HDDTemp Socket','Build-in Module','Read'),(5,'AIBO Socket','Build-in Module','Read'),(6,'UPS Socket','Build-in Module','Read'),(7,'Heyu X10','A10 X10','Write'),(8,'Bluetooth Dongle','Bluetooth','Read Write'),(9,'Weeder I/O Bus','Weeder','Read Write'),(10,'Plugwise Stick','Plugwise','Read Write'),(11,'DSC5401 Interface','DSC','Read Write'),(12,'RFXCom Transmitter','X10 ARC AC RFXCom','Read Write'),(13,'KNX/EIB Interface','KNX EIB','Read Write'),(14,'Digitemp','Digitemp','Read');
/*!40000 ALTER TABLE `interfaces` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-09-18  6:07:59
