--
-- Table structure for table `settings_pluginfoo`
--

DROP TABLE IF EXISTS `settings_pluginfoo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_pluginfoo` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `serialport` varchar(128) DEFAULT NULL,
  `baudrate` varchar(32) DEFAULT NULL,
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  `relayenabled` tinyint(1) DEFAULT NULL,
  `relayport` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_pluginfoo`
--

LOCK TABLES `settings_pluginfoo` WRITE;
/*!40000 ALTER TABLE `settings_pluginfoo` DISABLE KEYS */;
INSERT INTO `settings_pluginfoo` VALUES (0,0,'192.168.100.7',10001,'serial','/dev/ttyACM1','38400',0,-1,10020),(1,0,'192.168.100.7',10001,'serial','/dev/ttyACM1','38400',0,-1,10020);
/*!40000 ALTER TABLE `settings_pluginfoo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Data for table plugins
--

LOCK TABLES plugins WRITE;
/*!40000 ALTER TABLE plugins DISABLE KEYS */;
INSERT INTO plugins VALUES  (XX,'PluginFoo Interface','FooProt','FooProt','class');
/*!40000 ALTER TABLE plugins ENABLE KEYS */;
UNLOCK TABLES;

--
-- Data for table devicetypes
--

LOCK TABLES devicetypes WRITE;
/*!40000 ALTER TABLE devicetypes DISABLE KEYS */;
INSERT INTO `devicetypes` VALUES (XX,'PluginFoo Device','Temp Sensor','FooProt','temp 0x701');
/*!40000 ALTER TABLE devicetypes ENABLE KEYS */;
UNLOCK TABLES;
