INSERT INTO `devicetypes` VALUES (285,'Meiantech Module','Security Sensor','Meiantech','x10sec B45211','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

INSERT INTO `interfaces` VALUES (44,'Mochad Interface','X10','Read Write');

--
-- Table structure for table `settings_mochad`
--

DROP TABLE IF EXISTS `settings_mochad`;
CREATE TABLE `settings_mochad` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `globalX10` tinyint(1) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings_mochad`
--

LOCK TABLES `settings_mochad` WRITE;
INSERT INTO `settings_mochad` VALUES (0,0,'127.0.0.1',1990,0,0),(1,0,'192.168.1.23',1099,0,-1);
UNLOCK TABLES;

ALTER TABLE settings_plugwise DROP firmware;

ALTER TABLE settings_zwave DROP useozw;

--
-- Table structure for table `settings_opentherm`
--

DROP TABLE IF EXISTS `settings_opentherm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = latin1 */;
CREATE TABLE `settings_opentherm` (
  `id` int(11) NOT NULL,
  `temperatureoverride` varchar(32) DEFAULT NULL,
  `syncclock` tinyint(1) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `serialport` varchar(32) DEFAULT NULL,
  `polltime` int(11) DEFAULT NULL,
  `thermostat` varchar(32) DEFAULT NULL,
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `relayenabled` tinyint(1) DEFAULT NULL,
  `relayport` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_opentherm`
--

LOCK TABLES `settings_opentherm` WRITE;
/*!40000 ALTER TABLE `settings_opentherm` DISABLE KEYS */;
INSERT INTO `settings_opentherm` VALUES (0,'',0,0,'/dev/ttyUSB0',5,'Other','192.168.1.10',1080,'tcp',0,50000,0),(1,'Temporarily',0,0,'/dev/ttyUSB0',5,'Other','192.168.1.10',1080,'serial',0,50000,0);

--
-- Table structure for table `settings_smartvisu`
--

DROP TABLE IF EXISTS `settings_smartvisu`;
CREATE TABLE `settings_smartvisu` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings_smartvisu`
--

LOCK TABLES `settings_smartvisu` WRITE;
INSERT INTO `settings_smartvisu` VALUES (0,0,2121,0),(1,0,2121,0);
UNLOCK TABLES;

LOCK TABLES `version` WRITE;
INSERT INTO `version` VALUES (48,'1.0.003');
UNLOCK TABLES;
