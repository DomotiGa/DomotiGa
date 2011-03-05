-- MySQL dump 10.13  Distrib 5.1.41, for debian-linux-gnu (i486)
--
-- Host: localhost    Database: domotiga
-- ------------------------------------------------------
-- Server version	5.1.41-3ubuntu12.8

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
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES (1,'0.1.166'),(2,'0.1.167'),(3,'0.1.168'),(4,'0.1.169'),(5,'0.1.170'),(6,'0.1.171'),(7,'0.1.172'),(8,'0.1.173'),(9,'0.1.174'),(10,'0.1.175'),(11,'0.1.176'),(12,'0.1.177'),(13,'0.1.178'),(14,'0.1.179'),(15,'0.1.180'),(16,'0.1.181'),(17,'0.1.182'),(18,'0.1.183'),(19,'0.1.184'),(20,'0.1.185'),(21,'0.1.186'),(22,'0.1.187'),(23,'0.1.188'),(24,'0.1.189'),(25,'0.1.190'),(26,'0.1.191'),(27,'0.1.192'),(28,'0.1.193'),(29,'0.1.194'),(30,'0.1.195');
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_zwave`
--

ALTER TABLE settings_zwave ADD useozw tinyint(1);

--
-- Dumping data for table `settings_zwave`
--

UPDATE settings_zwave SET useozw = 0; 

CREATE TABLE IF NOT EXISTS `settings_thermostat` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `polltime` int DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO `settings_thermostat` (`id`, `enabled`, `polltime`, `debug`) VALUES
(0, 0, 120, 0);
INSERT INTO `settings_thermostat` (`id`, `enabled`, `polltime`, `debug`) VALUES
(1, 0, 120, 0);

INSERT INTO `domotiga`.`menu` (`id`, `name`, `item`, `menu`, `position`, `icon`, `enabled`) VALUES ('26', 'Thermostat', 'FThermostat', '1', '10', 'thermostat.png', '1');

CREATE TABLE IF NOT EXISTS `thermostat_scenarii` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO `thermostat_scenarii` (`id`, `name`, `description`) VALUES (1, 'Normal day', ''), (2, 'Vacation', '') ,(3, 'Work day', '') ;

INSERT INTO globalvars (var, value) VALUES ('Thermostat_Mode', 'Normal day');

CREATE TABLE IF NOT EXISTS `thermostat_constant` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `value` decimal(6, 2) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `color` INT NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO `thermostat_constant` (`id`, `name`, `value`, `description`, `color`) VALUES
(1, 'day', 19.4, '', 0), (2, 'night', 16.3, '', 0) ;

CREATE TABLE IF NOT EXISTS `thermostat_heating` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `sensor` bigint(20) unsigned NOT NULL ,
  `device` bigint(20) unsigned NULL ,
  `deviceInverted` tinyint(1) NULL ,
  `deviceLatency` int unsigned NULL ,
  `deviceOffsetBottom` FLOAT unsigned NULL ,
  `deviceOffsetTop` FLOAT unsigned NULL ,
  `regulator` bigint(20) unsigned NULL ,
  `regulatorInverted` tinyint(1) NULL ,
  `regulatorOffsetBottom` FLOAT unsigned NULL ,
  `regulatorOffsetTop` FLOAT unsigned NULL ,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `thermostat_schedule` (
  `scenario` bigint(20) unsigned NOT NULL ,
  `heating` bigint(20) unsigned NOT NULL ,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`scenario`, `heating`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `thermostat_schedule_entry` (
  `scenario` bigint(20) unsigned NOT NULL ,
  `heating` bigint(20) unsigned NOT NULL ,
  `day` int unsigned NULL ,
  `time` TIME NULL ,
  `constant` bigint(20) NOT NULL ,
  PRIMARY KEY (`scenario`, `heating`, `day`, `time`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-01-12 14:56:48
-- MySQL dump 10.13  Distrib 5.1.49, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: domotiga
-- ------------------------------------------------------
-- Server version	5.1.49-1ubuntu8.1

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
