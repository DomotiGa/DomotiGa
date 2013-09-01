--
-- Table structure for table `settings_dmxplayer`
--

DROP TABLE IF EXISTS `settings_dmxplayer`;
CREATE TABLE IF NOT EXISTS `settings_dmxplayer` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `serialport` varchar(128) DEFAULT NULL,
  `baudrate` varchar(32) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings_dmxplayer`
--

INSERT INTO `settings_dmxplayer` (`id`, `enabled`, `serialport`, `baudrate`, `debug`) VALUES
(0, 0, '/dev/ttyS1', '38400', 0),
(1, 0, '/dev/ttyS1', '38400', 0);

INSERT INTO interfaces VALUES (48,'DMXPlayer Interface','DMX','Read Write');

INSERT INTO devicetypes VALUES (300,'DMXPlayer Module','DMXPlayer','DMX','010','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

--
-- Table structure for table `weather`
--

DROP TABLE IF EXISTS `weather`;
/*yer Interface','DMX','Read Write')!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weather` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `observation_epoch` varchar(32) DEFAULT NULL,
  `wind_dir` varchar(16) DEFAULT NULL,
  `temp` varchar(16) DEFAULT NULL,
  `icon` varchar(16) DEFAULT NULL,
  `relative_humidity` varchar(16) DEFAULT NULL,
  `pressure` varchar(16) DEFAULT NULL,
  `heat_index` varchar(16) DEFAULT NULL,
  `windchill` varchar(16) DEFAULT NULL,
  `dewpoint` varchar(16) DEFAULT NULL,
  `wind_degrees` varchar(16) DEFAULT NULL,
  `wind_gust` varchar(16) DEFAULT NULL,
  `visibility` varchar(16) DEFAULT NULL,
  `precip_1hr` varchar(16) DEFAULT NULL,
  `precip_today` varchar(16) DEFAULT NULL,
  `percentilluminated` varchar(16) DEFAULT NULL,
  `ageofmoon` varchar(16) DEFAULT NULL,
  `weather` varchar(128) DEFAULT NULL,
  `wind` varchar(64) DEFAULT NULL,
  `time` varchar(32) DEFAULT NULL,
  `city` varchar(64) DEFAULT NULL,
  `country` varchar(32) DEFAULT NULL,
  `uv` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weather`
--

LOCK TABLES `weather` WRITE;
/*!40000 ALTER TABLE `weather` DISABLE KEYS */;
INSERT INTO `weather` VALUES (0,'1377852724','WSW','22.1',' cloudy','72%','1019','NA','NA','17','247',';;','3.5',' 2','2','32','24','Overcast',';;',NULL,'Dordrecht','Netherlands', '5');
/*!40000 ALTER TABLE `weather` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES version WRITE;
INSERT INTO version VALUES (54,'1.0.009');
UNLOCK TABLES;

