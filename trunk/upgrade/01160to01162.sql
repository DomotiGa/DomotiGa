-- MySQL dump 10.11
--
-- Host: localhost    Database: domotiga
-- ------------------------------------------------------
-- Server version	5.0.51a-3ubuntu5.4

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
-- Table structure for table `devices`
--

ALTER TABLE `devices` ADD COLUMN `value4` varchar(32) default NULL AFTER value3;
ALTER TABLE `devices` ADD COLUMN `label4` varchar(32) default NULL AFTER label3;
ALTER TABLE `devices` ADD COLUMN `value4rrddsname` varchar(32) default NULL AFTER value3rrddsname;
ALTER TABLE `devices` ADD COLUMN `value4rrdtype` varchar(32) default NULL AFTER value3rrdtype;

/*!40000 ALTER TABLE `devices` ENABLE KEYS */;

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `events` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `enabled` tinyint(1) default NULL,
  `name` varchar(64) default NULL,
  `log` tinyint(1) default NULL,
  `firstrun` datetime default NULL,
  `lastrun` datetime default NULL,
  `comments` text,
  `trigger1` int(11) default NULL,
  `condition1` int(11) default NULL,
  `operand` varchar(16) default NULL,
  `condition2` int(11) default NULL,
  `action1` int(11) default NULL,
  `action2` int(11) default NULL,
  `action3` int(11) default NULL,
  `rerunenabled` tinyint(1) default NULL,
  `rerunvalue` int(11) default NULL,
  `reruntype` varchar(16) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;
INSERT INTO `events` VALUES (1,0,'Frontdoor Light On',-1,'2009-01-06 17:30:00','2009-03-05 17:15:00','Switch frontdoor light on at dawn',1,0,'',0,1,0,0,0,0,'gb.Second'),(2,0,'Frontdoor Light Off',-1,'2009-01-05 22:17:00','2009-03-06 08:00:00','Switch frontdoor light off at sunset',2,0,'',0,2,0,0,0,0,'gb.Second'),(3,0,'Kitchen Light On when Movement Detected',-1,'2009-01-18 22:15:54','2009-03-05 20:24:16','Switch kitchen light on when someone enters it',4,0,'',0,3,0,0,0,15,'gb.Hour'),(4,0,'Kitchen Light Off if No Movement',-1,'2009-01-18 22:37:47','2009-03-05 20:25:16','Switch kitchen light off when no movement is detected',5,0,'',0,5,0,0,0,0,'gb.Second'),(5,0,'Ventilate Bathroom if Showering',-1,'2009-01-29 18:38:54','2009-02-05 19:33:23','Switch fan to speed 3 if bathroom is moist',3,0,'',0,6,0,0,-1,1,'gb.Hour'),(6,0,'Switch Ventilation to Normal',-1,'2009-01-30 16:53:24','2009-03-06 09:02:04','Switch fan back to normal speed',6,0,'',0,7,0,0,0,0,'gb.Second');
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `triggers` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(64) default NULL,
  `type` int(11) default NULL,
  `description` text,
  `param1` varchar(32) default NULL,
  `param2` varchar(32) default NULL,
  `param3` varchar(32) default NULL,
  `param4` varchar(32) default NULL,
  `param5` varchar(32) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;
INSERT INTO `triggers` VALUES (1,'Time is SunSet',1,'Test description.','17','15','','',''),(2,'Time is SunRise',1,NULL,'08','00','','',''),(3,'Bathroom is Humid',3,NULL,'9','Value2','>','60',''),(4,'Movement in Kitchen is Detected',3,NULL,'17','Value','=','Motion',''),(5,'No Movement in Kitchen is Detected',3,NULL,'17','Value','=','No Motion',''),(6,'Bathroom Humidity is Normal',3,NULL,'9','Value3','=','Normal',''),(7,'Movement Outside Detected',3,NULL,'38','Value','=','Motion',''),(8,'Outside No Movement Detected',3,NULL,'38','Value','=','No Motion',''),(9,'Test Time trigger',1,NULL,'03','01','','','');
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `triggertypes` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(64) default NULL,
  `tab` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;
INSERT INTO `triggertypes` VALUES (1,'Time Now',0),(2,'Variable',1),(3,'Device Status',2);
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `actions` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(64) default NULL,
  `type` int(11) default NULL,
  `description` text,
  `param1` varchar(32) default NULL,
  `param2` varchar(32) default NULL,
  `param3` varchar(32) default NULL,
  `param4` varchar(32) default NULL,
  `param5` varchar(32) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;
INSERT INTO `actions` VALUES (1,'Switch Porch Light On',1,NULL,'1','Value1','On','',''),(2,'Switch Porch Light Off',1,NULL,'1','Value1','Off','',''),(3,'Switch Kitchen Light On',1,NULL,'44','Value1','On','',''),(6,'Set Ventilation to High Speed',1,NULL,'29','Value1','3','',''),(5,'Switch Kitchen Light Off',1,NULL,'44','Value1','Off','',''),(7,'Set Ventilation to Normal Speed',1,NULL,'29','Value1','1','','');
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `actiontypes` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(32) default NULL,
  `tab` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `conditiontypes` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(64) default NULL,
  `tab` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;
INSERT INTO `conditiontypes` VALUES (1,'Time Now',0),(2,'Variable',1),(3,'Device Status',2);

--
-- Table structure for table `settings_main`
--

DROP TABLE IF EXISTS `settings_main`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings_main` (
  `id` int(11) NOT NULL,
  `sleeptime` int(11) default NULL,
  `flushtime` int(11) default NULL,
  `debug` tinyint(1) default NULL,
  `logbuffer` int(11) default NULL,
  `authentication` tinyint(1) default NULL,
  `startpage` varchar(32) default NULL,
  `debugevents` tinyint(1) default NULL,
  `debugdevices` tinyint(1) default NULL,
  `debugenergy` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings_main`
--

LOCK TABLES `settings_main` WRITE;
/*!40000 ALTER TABLE `settings_main` DISABLE KEYS */;
INSERT INTO `settings_main` VALUES (0,250,5000,0,15000,1,'Home',NULL,NULL,NULL),(1,250,10000,0,15000,0,'FHome',0,0,0);
/*!40000 ALTER TABLE `settings_main` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-03-06 15:26:29
