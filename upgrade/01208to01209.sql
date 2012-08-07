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
-- Dumping data for table 'devicetypes'
--

INSERT INTO `devicetypes` VALUES (247,'La Crosse WS2300','Weather Station','LaCrosse','\'temp8 0x123\' or \'wind6 0x123\' or \'hum2 0x123\'','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (248,'TS15C','Temp Sensor','TFA','\'temp6 0x123\'','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (249,'Viking 02035','Temp Sensor','Viking','\'th9 0x123\'','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (250,'Viking 02038','Temp/Hygro Sensor','Viking','\'th9 0x123\'','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (251,'Viking 02811','Temp Sensor','Viking','\'temp7 0x123\'','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (252,'RUBiCSON','Temp Sensor','Rubicson','\'temp9 0x123\'','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (253,'UPM RG700','Rain Gauge','UPM','\'rain4 0x123\'','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (254,'UPM WDS500','Wind Sensor','UPM','\'wind5 0x123\'','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (255,'P1 Meter Power Exported','Utility Meter','NTA8130','P1-PowerDelivered','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (256,'P1 Meter Gas Usage','Utility Meter','NTA8130','P1-MBus1-4','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (257,'P1 Meter Water Usage','Utility Meter','NTA8130','P1-MBus1-4','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

UPDATE `interfaces` SET type='X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubiscon' WHERE id='35';

UPDATE `devicetypes` SET name='P1 Meter Power Usage' WHERE id=246;
UPDATE `devicetypes` SET addressformat='P1-PowerUsed' WHERE id=246;

--
-- Table structure for table 'settings_zwave'
--

ALTER TABLE `settings_zwave` ADD COLUMN `enablepolllistening` tinyint(1) DEFAULT NULL AFTER enablepollsleeping;
ALTER TABLE `settings_zwave` ADD COLUMN `polltimelistening` varchar(16) DEFAULT NULL AFTER enablepolllistening;

--
-- Table structure for table 'devices'
--

ALTER TABLE `devices` ADD COLUMN `poll` tinyint(1) DEFAULT NULL AFTER resetvalue;

--
-- Table structure for table 'contacts'
--

ALTER TABLE `contacts` ADD COLUMN `firstname` varchar(32) DEFAULT NULL AFTER comments;
ALTER TABLE `contacts` ADD COLUMN `surname` varchar(32) DEFAULT NULL AFTER firstname;
ALTER TABLE `contacts` ADD COLUMN `callnr` int(11) DEFAULT NULL AFTER surname;
ALTER TABLE `contacts` ADD COLUMN `type` int(11) DEFAULT NULL AFTER callnr;
ALTER TABLE `contacts` ADD COLUMN `firstseen` datetime DEFAULT NULL AFTER type;
ALTER TABLE `contacts` ADD COLUMN `lastseen` datetime DEFAULT NULL AFTER firstseen;

DROP TABLE IF EXISTS `power_exported`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `power_exported` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `counter` bigint(20) DEFAULT NULL,
  `stamp` datetime DEFAULT NULL,
  `consumption` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table 'version'
--

LOCK TABLES `version` WRITE;
INSERT INTO `version` VALUES (44,'0.1.209');
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-05-31 13:15:26
