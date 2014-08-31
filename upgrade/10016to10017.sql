--
-- Table structure for table `settings_weatherbug`
--
DROP TABLE IF EXISTS `settings_weatherbug`;

--
-- Remove OpenZWave devices table (not used anymore)
--
DROP TABLE IF EXISTS devices_zwave;

--
-- Remove Weather table, info stored in virtualdevice
--
DROP TABLE IF EXISTS weather;

--
-- Table structure for table `settings_devicediscover`
--
DROP TABLE IF EXISTS `settings_devicediscover`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_devicediscover` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `multicasthost` varchar(32) DEFAULT NULL,
  `multicastport` int(11) NOT NULL DEFAULT '0',
  `listenonly` tinyint(1) NOT NULL DEFAULT '0',
  `broadcastinterval` int(11) NOT NULL DEFAULT '0',
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings_devicediscover`
--
/*!40101 SET character_set_client = @saved_cs_client */;
LOCK TABLES `settings_devicediscover` WRITE;
/*!40000 ALTER TABLE `settings_devicediscover` DISABLE KEYS */;
INSERT INTO `settings_devicediscover` VALUES (0,0,'239.255.255.250',1900,0,60,0),(1,1,'239.255.255.250',1900,0,60,0);
/*!40000 ALTER TABLE `settings_devicediscover` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_philipshue`
--
DROP TABLE IF EXISTS `settings_philipshue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_philipshue` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `username` varchar(44) DEFAULT NULL,
  `polltime` int(11) NOT NULL DEFAULT '10',
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1

--
-- Dumping data for table `settings_philipshue`
--
/*!40101 SET character_set_client = @saved_cs_client */;
LOCK TABLES `settings_philipshue` WRITE;
/*!40000 ALTER TABLE `settings_philipshue` DISABLE KEYS */;
INSERT INTO `settings_philipshue` VALUES (0,0,null,10,0),(1,0,null,10,0);
/*!40000 ALTER TABLE `settings_philipshue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table interfaces
--
LOCK TABLES interfaces WRITE;
/*!40000 ALTER TABLE interfaces DISABLE KEYS */;
INSERT INTO interfaces VALUES  (58,'Philips Hue Interface','PhilipsHue','Read Write');
/*!40000 ALTER TABLE interfaces ENABLE KEYS */;
UNLOCK TABLES;


INSERT INTO `devicetypes` VALUES (373,'Philips Hue light bulb','Light','PhilipsHue','1','','','',-1,-1,0,0,0,0,0);

--
-- Finally update to 1.0.017
--
LOCK TABLES version WRITE;
INSERT INTO version VALUES (62,'1.0.017');
UNLOCK TABLES;

