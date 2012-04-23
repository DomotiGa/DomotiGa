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

INSERT INTO `devicetypes` VALUES (234,'HomeMatic Thermostat','HM_CC_TC','HomeMatic','1','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (235,'UPM/ESIC WT440H/WT450H','Temp/Hygro Sensor','UPM','th8 0x123','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (236,'DSC Partition','Security Partition','DSC','1','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

--
-- Dumping data for table `interfaces`
--

LOCK TABLES `interfaces` WRITE;
UPDATE interfaces set name="DSC Interface" WHERE id=11;
UPDATE interfaces set type="X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM" WHERE id=35;
INSERT INTO `interfaces` VALUES (36,'HomeMatic LAN Adapter','HomeMatic','Read Write');
UNLOCK TABLES;

--
-- Table structure for table `devicetypes_homematic`
--

DROP TABLE IF EXISTS `devicetypes_homematic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devicetypes_homematic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `moduleref` int(11) DEFAULT NULL,
  `type` varchar(32) NOT NULL,
  `subtype` varchar(32) DEFAULT NULL,
  `commands` text,
  `values` text,
  `type_code` varchar(4) DEFAULT NULL,
  `subtype_code` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=83 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devicetypes_homematic`
--

LOCK TABLES `devicetypes_homematic` WRITE;
/*!40000 ALTER TABLE `devicetypes_homematic` DISABLE KEYS */;
INSERT INTO `devicetypes_homematic` VALUES (1,234,'HM_CC_TC','','Temperature,Status Request','Temperature, Humidity,rcv_sig,sent_sig','0039',NULL),(2,NULL,'HM_LC_SW1_PL_OM54',NULL,'none supported','unknown','0001',NULL),(3,NULL,'HM_LC_SW1_SM',NULL,'none supported','unknown','0002',NULL),(4,NULL,'HM_LC_SW4_SM',NULL,'none supported','unknown','0003',NULL),(5,NULL,'HM_LC_SW1_FM',NULL,'none supported','unknown','0004',NULL),(6,NULL,'HM_LC_BL1_FM',NULL,'none supported','unknown','0005',NULL),(7,NULL,'HM_LC_BL1_SM',NULL,'none supported','unknown','0006',NULL),(8,NULL,'KS550',NULL,'none supported','unknown','0007',NULL),(9,NULL,'HM_RC_4',NULL,'none supported','unknown','0008',NULL),(10,NULL,'HM_LC_SW2_FM',NULL,'none supported','unknown','0009',NULL),(11,NULL,'HM_LC_SW2_SM',NULL,'none supported','unknown','000A',NULL),(12,NULL,'HM_WDC7000',NULL,'none supported','unknown','000B',NULL),(13,NULL,'ASH550',NULL,'none supported','unknown','000D',NULL),(14,NULL,'ASH550I',NULL,'none supported','unknown','000E',NULL),(15,NULL,'S550IA',NULL,'none supported','unknown','000F',NULL),(16,NULL,'HM_LC_SW1_PL',NULL,'none supported','unknown','0011',NULL),(17,NULL,'HM_LC_DIM1L_CV',NULL,'none supported','unknown','0012',NULL),(18,NULL,'HM_LC_DIM1L_PL',NULL,'none supported','unknown','0013',NULL),(19,NULL,'HM_LC_SW1_SM_ATMEGA168',NULL,'none supported','unknown','0014',NULL),(20,NULL,'HM_LC_SW4_SM_ATMEGA168',NULL,'none supported','unknown','0015',NULL),(21,NULL,'HM_LC_DIM2L_CV',NULL,'none supported','unknown','0016',NULL),(22,NULL,'CMM',NULL,'none supported','unknown','0018',NULL),(23,NULL,'HM_SEC_KEY',NULL,'none supported','unknown','0019',NULL),(24,NULL,'HM_RC_P1',NULL,'none supported','unknown','001A',NULL),(25,NULL,'HM_RC_SEC3',NULL,'none supported','unknown','001B',NULL),(26,NULL,'HM_RC_SEC3_B',NULL,'none supported','unknown','001C',NULL),(27,NULL,'HM_RC_KEY3',NULL,'none supported','unknown','001D',NULL),(28,NULL,'HM_RC_KEY3_B',NULL,'none supported','unknown','001E',NULL),(29,NULL,'WS888',NULL,'none supported','unknown','0022',NULL),(30,NULL,'HM_SEC_KEY_S',NULL,'none supported','unknown','0026',NULL),(31,NULL,'HM_SEC_KEY_O',NULL,'none supported','unknown','0027',NULL),(32,NULL,'HM_SEC_WIN',NULL,'none supported','unknown','0028',NULL),(33,NULL,'HM_RC_12',NULL,'none supported','unknown','0029',NULL),(34,NULL,'HM_RC_12_B',NULL,'none supported','unknown','002A',NULL),(35,NULL,'HM_LC_SW4_PCB',NULL,'none supported','unknown','002D',NULL),(36,NULL,'HM_LC_DIM2L_SM',NULL,'none supported','unknown','002E',NULL),(37,NULL,'HM_SEC_SC',NULL,'none supported','unknown','002F',NULL),(38,NULL,'HM_SEC_RHS',NULL,'none supported','unknown','0030',NULL),(39,NULL,'HM_PBI_4_FM',NULL,'none supported','unknown','0034',NULL),(40,NULL,'HM_PB_4_WM',NULL,'none supported','unknown','0035',NULL),(41,NULL,'HM_PB_2_WM',NULL,'none supported','unknown','0036',NULL),(42,NULL,'HM_RC_19',NULL,'none supported','unknown','0037',NULL),(43,NULL,'HM_RC_19_B',NULL,'none supported','unknown','0038',NULL),(44,NULL,'HM_CC_TC',NULL,'none supported','unknown','0039',NULL),(45,NULL,'HM_CC_VD',NULL,'none supported','unknown','003A',NULL),(46,NULL,'HM_RC_4_B',NULL,'none supported','unknown','003B',NULL),(47,NULL,'HM_WDS20_TH_O',NULL,'none supported','unknown','003C',NULL),(48,NULL,'HM_WDS10_TH_O',NULL,'none supported','unknown','003D',NULL),(49,NULL,'HM_WDS30_T_O',NULL,'none supported','unknown','003E',NULL),(50,NULL,'HM_WDS40_TH_I',NULL,'none supported','unknown','003F',NULL),(51,NULL,'HM_WDS100_C6_O',NULL,'none supported','unknown','0040',NULL),(52,NULL,'HM_WDC7000',NULL,'none supported','unknown','0041',NULL),(53,NULL,'HM_SEC_SD',NULL,'none supported','unknown','0042',NULL),(54,NULL,'HM_SEC_TIS',NULL,'none supported','unknown','0043',NULL),(55,NULL,'HM_SEN_EP',NULL,'none supported','unknown','0044',NULL),(56,NULL,'HM_SEC_WDS',NULL,'none supported','unknown','0045',NULL),(57,NULL,'HM_SWI_3_FM',NULL,'none supported','unknown','0046',NULL),(58,NULL,'KFM_Display',NULL,'none supported','unknown','0047',NULL),(59,NULL,'IS_WDS_TH_OD_S_R3',NULL,'none supported','unknown','0048',NULL),(60,NULL,'KFM_Sensor',NULL,'none supported','unknown','0049',NULL),(61,NULL,'HM_SEC_MDIR',NULL,'none supported','unknown','004A',NULL),(62,NULL,'HM_Sec_Cen',NULL,'none supported','unknown','004B',NULL),(63,NULL,'HM_RC_12_SW',NULL,'none supported','unknown','004C',NULL),(64,NULL,'HM_RC_19_SW',NULL,'none supported','unknown','004D',NULL),(65,NULL,'HM_LC_DDC1_PCB',NULL,'none supported','unknown','004E',NULL),(66,NULL,'HM_SEN_MDIR_SM',NULL,'none supported','unknown','004F',NULL),(67,NULL,'HM_SEC_SFA_SM',NULL,'none supported','unknown','0050',NULL),(68,NULL,'HM_LC_SW1_PB_FM',NULL,'none supported','unknown','0051',NULL),(69,NULL,'HM_LC_SW2_PB_FM',NULL,'none supported','unknown','0052',NULL),(70,NULL,'HM_LC_BL1_PB_FM',NULL,'none supported','unknown','0053',NULL),(71,NULL,'HM_CC_SCD',NULL,'none supported','unknown','0056',NULL),(72,NULL,'HM_LC_DIM1T_PL',NULL,'none supported','unknown','0057',NULL),(73,NULL,'HM_LC_DIM1T_CV',NULL,'none supported','unknown','0058',NULL),(74,NULL,'HM_LC_DIM1T_FM',NULL,'none supported','unknown','0059',NULL),(75,NULL,'HM_LC_DIM2T_SM',NULL,'none supported','unknown','005A',NULL),(76,NULL,'HM_OU_CF_PL',NULL,'none supported','unknown','005C',NULL),(77,NULL,'HM_SCI_3_FM',NULL,'none supported','unknown','005F',NULL),(78,NULL,'HM_PB_4DIS_WM',NULL,'none supported','unknown','0060',NULL),(79,NULL,'HM_LC_SW4_DR',NULL,'none supported','unknown','0061',NULL),(80,NULL,'HM_LC_SW2_DR',NULL,'none supported','unknown','0062',NULL),(81,NULL,'HM_LC_Sw4_WM',NULL,'none supported','unknown','0066',NULL),(82,NULL,'HM_LC_SW1_PCB',NULL,'none supported','unknown','006C',NULL);
/*!40000 ALTER TABLE `devicetypes_homematic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_dsc`
--

ALTER TABLE `settings_dsc` ADD COLUMN `type` int(11) DEFAULT 0 AFTER baudrate;
ALTER TABLE `settings_dsc` ADD COLUMN `mastercode` varchar(16) DEFAULT '1234' AFTER type;

--
-- Table structure for table `settings_homematic`
--

DROP TABLE IF EXISTS `settings_homematic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_homematic` (
  `id` int(11) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  `tcphost` varchar(32) DEFAULT NULL,
  `hmid` varchar(32) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `model` int(11) DEFAULT NULL,
  `tcpport` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_homematic`
--

LOCK TABLES `settings_homematic` WRITE;
/*!40000 ALTER TABLE `settings_homematic` DISABLE KEYS */;
INSERT INTO `settings_homematic` VALUES (0,0,1,'192.168.1.15','9','tcp',0,1000),(1,0,1,'192.168.1.15','9','tcp',0,1000);
/*!40000 ALTER TABLE `settings_homematic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devicetypes_homematic`
--

DROP TABLE IF EXISTS `devicetypes_homematic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devicetypes_homematic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `moduleref` int(11) DEFAULT NULL,
  `type` varchar(32) NOT NULL,
  `subtype` varchar(32) DEFAULT NULL,
  `commands` text,
  `values` text,
  `type_code` varchar(4) DEFAULT NULL,
  `subtype_code` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=83 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devicetypes_homematic`
--

LOCK TABLES `devicetypes_homematic` WRITE;
/*!40000 ALTER TABLE `devicetypes_homematic` DISABLE KEYS */;
INSERT INTO `devicetypes_homematic` VALUES (1,234,'HM_CC_TC','','Temperature,Status Request','Temperature, Humidity,rcv_sig,sent_sig','0039',NULL),(2,NULL,'HM_LC_SW1_PL_OM54',NULL,'none supported','unknown','0001',NULL),(3,NULL,'HM_LC_SW1_SM',NULL,'none supported','unknown','0002',NULL),(4,NULL,'HM_LC_SW4_SM',NULL,'none supported','unknown','0003',NULL),(5,NULL,'HM_LC_SW1_FM',NULL,'none supported','unknown','0004',NULL),(6,NULL,'HM_LC_BL1_FM',NULL,'none supported','unknown','0005',NULL),(7,NULL,'HM_LC_BL1_SM',NULL,'none supported','unknown','0006',NULL),(8,NULL,'KS550',NULL,'none supported','unknown','0007',NULL),(9,NULL,'HM_RC_4',NULL,'none supported','unknown','0008',NULL),(10,NULL,'HM_LC_SW2_FM',NULL,'none supported','unknown','0009',NULL),(11,NULL,'HM_LC_SW2_SM',NULL,'none supported','unknown','000A',NULL),(12,NULL,'HM_WDC7000',NULL,'none supported','unknown','000B',NULL),(13,NULL,'ASH550',NULL,'none supported','unknown','000D',NULL),(14,NULL,'ASH550I',NULL,'none supported','unknown','000E',NULL),(15,NULL,'S550IA',NULL,'none supported','unknown','000F',NULL),(16,NULL,'HM_LC_SW1_PL',NULL,'none supported','unknown','0011',NULL),(17,NULL,'HM_LC_DIM1L_CV',NULL,'none supported','unknown','0012',NULL),(18,NULL,'HM_LC_DIM1L_PL',NULL,'none supported','unknown','0013',NULL),(19,NULL,'HM_LC_SW1_SM_ATMEGA168',NULL,'none supported','unknown','0014',NULL),(20,NULL,'HM_LC_SW4_SM_ATMEGA168',NULL,'none supported','unknown','0015',NULL),(21,NULL,'HM_LC_DIM2L_CV',NULL,'none supported','unknown','0016',NULL),(22,NULL,'CMM',NULL,'none supported','unknown','0018',NULL),(23,NULL,'HM_SEC_KEY',NULL,'none supported','unknown','0019',NULL),(24,NULL,'HM_RC_P1',NULL,'none supported','unknown','001A',NULL),(25,NULL,'HM_RC_SEC3',NULL,'none supported','unknown','001B',NULL),(26,NULL,'HM_RC_SEC3_B',NULL,'none supported','unknown','001C',NULL),(27,NULL,'HM_RC_KEY3',NULL,'none supported','unknown','001D',NULL),(28,NULL,'HM_RC_KEY3_B',NULL,'none supported','unknown','001E',NULL),(29,NULL,'WS888',NULL,'none supported','unknown','0022',NULL),(30,NULL,'HM_SEC_KEY_S',NULL,'none supported','unknown','0026',NULL),(31,NULL,'HM_SEC_KEY_O',NULL,'none supported','unknown','0027',NULL),(32,NULL,'HM_SEC_WIN',NULL,'none supported','unknown','0028',NULL),(33,NULL,'HM_RC_12',NULL,'none supported','unknown','0029',NULL),(34,NULL,'HM_RC_12_B',NULL,'none supported','unknown','002A',NULL),(35,NULL,'HM_LC_SW4_PCB',NULL,'none supported','unknown','002D',NULL),(36,NULL,'HM_LC_DIM2L_SM',NULL,'none supported','unknown','002E',NULL),(37,NULL,'HM_SEC_SC',NULL,'none supported','unknown','002F',NULL),(38,NULL,'HM_SEC_RHS',NULL,'none supported','unknown','0030',NULL),(39,NULL,'HM_PBI_4_FM',NULL,'none supported','unknown','0034',NULL),(40,NULL,'HM_PB_4_WM',NULL,'none supported','unknown','0035',NULL),(41,NULL,'HM_PB_2_WM',NULL,'none supported','unknown','0036',NULL),(42,NULL,'HM_RC_19',NULL,'none supported','unknown','0037',NULL),(43,NULL,'HM_RC_19_B',NULL,'none supported','unknown','0038',NULL),(44,NULL,'HM_CC_TC',NULL,'none supported','unknown','0039',NULL),(45,NULL,'HM_CC_VD',NULL,'none supported','unknown','003A',NULL),(46,NULL,'HM_RC_4_B',NULL,'none supported','unknown','003B',NULL),(47,NULL,'HM_WDS20_TH_O',NULL,'none supported','unknown','003C',NULL),(48,NULL,'HM_WDS10_TH_O',NULL,'none supported','unknown','003D',NULL),(49,NULL,'HM_WDS30_T_O',NULL,'none supported','unknown','003E',NULL),(50,NULL,'HM_WDS40_TH_I',NULL,'none supported','unknown','003F',NULL),(51,NULL,'HM_WDS100_C6_O',NULL,'none supported','unknown','0040',NULL),(52,NULL,'HM_WDC7000',NULL,'none supported','unknown','0041',NULL),(53,NULL,'HM_SEC_SD',NULL,'none supported','unknown','0042',NULL),(54,NULL,'HM_SEC_TIS',NULL,'none supported','unknown','0043',NULL),(55,NULL,'HM_SEN_EP',NULL,'none supported','unknown','0044',NULL),(56,NULL,'HM_SEC_WDS',NULL,'none supported','unknown','0045',NULL),(57,NULL,'HM_SWI_3_FM',NULL,'none supported','unknown','0046',NULL),(58,NULL,'KFM_Display',NULL,'none supported','unknown','0047',NULL),(59,NULL,'IS_WDS_TH_OD_S_R3',NULL,'none supported','unknown','0048',NULL),(60,NULL,'KFM_Sensor',NULL,'none supported','unknown','0049',NULL),(61,NULL,'HM_SEC_MDIR',NULL,'none supported','unknown','004A',NULL),(62,NULL,'HM_Sec_Cen',NULL,'none supported','unknown','004B',NULL),(63,NULL,'HM_RC_12_SW',NULL,'none supported','unknown','004C',NULL),(64,NULL,'HM_RC_19_SW',NULL,'none supported','unknown','004D',NULL),(65,NULL,'HM_LC_DDC1_PCB',NULL,'none supported','unknown','004E',NULL),(66,NULL,'HM_SEN_MDIR_SM',NULL,'none supported','unknown','004F',NULL),(67,NULL,'HM_SEC_SFA_SM',NULL,'none supported','unknown','0050',NULL),(68,NULL,'HM_LC_SW1_PB_FM',NULL,'none supported','unknown','0051',NULL),(69,NULL,'HM_LC_SW2_PB_FM',NULL,'none supported','unknown','0052',NULL),(70,NULL,'HM_LC_BL1_PB_FM',NULL,'none supported','unknown','0053',NULL),(71,NULL,'HM_CC_SCD',NULL,'none supported','unknown','0056',NULL),(72,NULL,'HM_LC_DIM1T_PL',NULL,'none supported','unknown','0057',NULL),(73,NULL,'HM_LC_DIM1T_CV',NULL,'none supported','unknown','0058',NULL),(74,NULL,'HM_LC_DIM1T_FM',NULL,'none supported','unknown','0059',NULL),(75,NULL,'HM_LC_DIM2T_SM',NULL,'none supported','unknown','005A',NULL),(76,NULL,'HM_OU_CF_PL',NULL,'none supported','unknown','005C',NULL),(77,NULL,'HM_SCI_3_FM',NULL,'none supported','unknown','005F',NULL),(78,NULL,'HM_PB_4DIS_WM',NULL,'none supported','unknown','0060',NULL),(79,NULL,'HM_LC_SW4_DR',NULL,'none supported','unknown','0061',NULL),(80,NULL,'HM_LC_SW2_DR',NULL,'none supported','unknown','0062',NULL),(81,NULL,'HM_LC_Sw4_WM',NULL,'none supported','unknown','0066',NULL),(82,NULL,'HM_LC_SW1_PCB',NULL,'none supported','unknown','006C',NULL);
/*!40000 ALTER TABLE `devicetypes_homematic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
INSERT INTO `version` VALUES (40,'0.1.205');
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-01-19 12:37:50
