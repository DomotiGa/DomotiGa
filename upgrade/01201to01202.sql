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
-- Table structure for table `settings_rfxcomtx`
--

ALTER TABLE settings_rfxcomtx DROP acaddress1;
ALTER TABLE settings_rfxcomtx DROP acaddress2;

--
-- Table structure for table `settings_cul`
--

ALTER TABLE settings_cul DROP autocreate;

--
-- Table structure for table `interfaces`
--

ALTER TABLE interfaces MODIFY type VARCHAR(256); 

--
-- Table contents for table `interfaces`
--

UPDATE interfaces set type='X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison RFXLanIO' where id=33;
UPDATE interfaces set type='X10 X10Security Oregon KAKU RFXCom HEUK ATI Digimax ARC AC HEEU' where id=1;
UPDATE interfaces set type='X10 ARC AC RFXCom X10Security HEEU HEUK Digimax Harrison Koppla Waveman Flamingo KAKU' where id=12;
UPDATE interfaces set type='JeeLabs ARC KAKU' where id=29;

--
-- Table contents for table `devicetypes`
--

UPDATE devicetypes set name='3166 Pt Shutter Control Switch' where id=164;
UPDATE devicetypes set type='HEUK' where id=43;
UPDATE devicetypes set addressformat="'13B5A11 10 or '0x13B5A11 10'" where id=60;
UPDATE devicetypes set addressformat="'13B5A11 10 or '0x13B5A11 10'" where id=43;
UPDATE devicetypes set addressformat="'13B5A11 10 or '0x13B5A11 10'" where id=154;
UPDATE devicetypes set name='Dallas DS2406',description='Dual Addressable Switch',type='1-Wire',addressformat='12D050E7000000FF/Pio.A',onicon='',officon='',dimicon='' where id=217;
INSERT INTO `devicetypes` VALUES (218,'Dallas DS2413','Dual I/O','1-Wire','3AD050E7000000FF/sensed.A','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(219,'Dallas DS2450','Quad A/D','1-Wire','20D050E7000000FF/volt.A','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(220,'Marmitek KR18','Keychain Security Remote','X10Security','REMOTE[256]S','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(221,'Marmitek KR22','Keyfob RF Remote','X10','REMOTE[256]S','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(222,'KAKU Module','KAKU Module','KAKU','A1','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

--
-- Table structure for table `devices`
--

ALTER TABLE devices DROP calibration;
ALTER TABLE devices DROP calibration2;
ALTER TABLE devices DROP calibration3;
ALTER TABLE devices DROP calibration4;
ALTER TABLE devices DROP divider;
ALTER TABLE devices DROP divider2;
ALTER TABLE devices DROP divider3;
ALTER TABLE devices DROP divider4;

--
-- Dumping data for table `version`
--

INSERT INTO `version` VALUES (37,'0.1.202');

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-10-25 16:47:18
