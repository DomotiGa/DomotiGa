ALTER TABLE settings_youless DROP fetchurl;

UPDATE `interfaces` SET type='X10 X10Sec' WHERE id=44;

--
-- Table structure for table `settings_pvoutput`
--

DROP TABLE IF EXISTS `settings_pvoutput`;
CREATE TABLE `settings_pvoutput` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `api` varchar(64) DEFAULT NULL,
  `pvoutputid` varchar(64) DEFAULT NULL,
  `pushtime` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  `deviceid` int(11) NOT NULL,
  `devicevalue` varchar(8) NOT NULL,
  `usagedeviceid` int(11) NOT NULL,
  `usagedevicevalue` varchar(8) NOT NULL,
  `tempdeviceid` int(11) NOT NULL,
  `tempdevicevalue` varchar(8) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings_pvoutput`
--

LOCK TABLES `settings_pvoutput` WRITE;
INSERT INTO `settings_pvoutput` VALUES (0,0,'YOURPVOUTPUTAPI',12345,5,0,0,'value',0,'value',0,'value'),(1,0,'YOURPVOUTPUTAPI',12345,5,0,0,'value',0,'value',0,'value');
UNLOCK TABLES;

--
-- Table structure for table 'settings_omniksol'
--

DROP TABLE IF EXISTS `settings_omniksol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_omniksol` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `polltime` int(11) DEFAULT NULL,
  `autosearch` tinyint(1) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `settings_omniksol` VALUES (0,0,300,0,0),(1,0,300,0,0);

INSERT INTO `interfaces` VALUES (45,'Omniksol Interface','Omniksol','Read');

INSERT INTO `devicetypes` VALUES (286,'Omniksol Inverter','Solar Inverter','Omniksol','192.168.1.20:SERIALNO','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

LOCK TABLES `version` WRITE;
INSERT INTO `version` VALUES (49,'1.0.004');
UNLOCK TABLES;
