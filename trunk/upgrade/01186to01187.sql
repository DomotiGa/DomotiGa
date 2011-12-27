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
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `db` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES (1,'0.1.166'),(2,'0.1.167'),(3,'0.1.168'),(4,'0.1.169'),(5,'0.1.170'),(6,'0.1.171'),(7,'0.1.172'),(8,'0.1.173'),(9,'0.1.174'),(10,'0.1.175'),(11,'0.1.176'),(12,'0.1.177'),(13,'0.1.178'),(14,'0.1.179'),(15,'0.1.180'),(16,'0.1.181'),(17,'0.1.182'),(18,'0.1.183'),(19,'0.1.184'),(20,'0.1.185'),(21,'0.1.186'),(22,'0.1.187');
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graphs`
--

DROP TABLE IF EXISTS `graphs`;

CREATE TABLE IF NOT EXISTS `graphs` (
 `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `comments` varchar(32) DEFAULT NULL,
  `graph_title` varchar(32) NOT NULL,
  `graph_height` int(10) NOT NULL,
  `graph_width` int(10) NOT NULL,
  `color_background` int(11) NOT NULL,
  `color_canvas` int(11) NOT NULL,
  `color_shadea` int(11) NOT NULL,
  `color_shadeb` int(11) NOT NULL,
  `color_font` int(11) NOT NULL,
  `color_grid` int(11) NOT NULL,
  `color_majorgrid` int(11) NOT NULL,
  `color_frame` int(11) NOT NULL,
  `color_axis` int(11) NOT NULL,
  `color_arrow` int(11) NOT NULL,
  `unit` varchar(10) NOT NULL,
  `logarithmic_scale` tinyint(1) NOT NULL DEFAULT '0',
  `date` tinyint(1) NOT NULL,
  `grid_type` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
);

--
-- Table structure for table `graph_data`
--

DROP TABLE IF EXISTS `graph_data`;

CREATE TABLE IF NOT EXISTS `graph_data` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `graph_id` bigint(20) NOT NULL,
  `graph_name` varchar(32) NOT NULL,
  `graph_max` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `graph_min` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `graph_last` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `graph_avg` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `graph_value_max` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `graph_value_avg` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `graph_value_min` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `graph_value_max_color` int(11) NOT NULL,
  `graph_value_avg_color` int(11) NOT NULL,
  `graph_value_min_color` int(11) NOT NULL,
  `graph_line_type` varchar(10) NOT NULL DEFAULT 'LINE1',
  `graph_rrddsname` varchar(32) NOT NULL,
  `graph_color` int(11) NOT NULL DEFAULT '65280',
  `graph_trend` tinyint(1) NOT NULL,
  `graph_trend_value` int(20) NOT NULL,
  `graph_timeshift` tinyint(1) NOT NULL,
  `graph_timeshift_value` int(20) NOT NULL,
  `graph_operation` tinyint(1) NOT NULL,
  `graph_operation_operator` char(1) NOT NULL,
  `graph_operation_value` int(11) NOT NULL,
  `graph_devicename` varchar(32) NOT NULL,
  `ds_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `graph_id` (`graph_id`)
) ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-09-16 19:24:47
