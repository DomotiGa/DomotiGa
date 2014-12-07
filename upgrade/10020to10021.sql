--
-- Table structure for table `settings_conradrelayboard`
-- 

DROP TABLE IF EXISTS `settings_conradrelayboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_conradrelayboard` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `serialport` varchar(128) DEFAULT NULL,
  `baudrate` varchar(32) DEFAULT NULL,
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_conradrelayboard`
--

LOCK TABLES `settings_conradrelayboard` WRITE;
/*!40000 ALTER TABLE `settings_conradrelayboard` DISABLE KEYS */;
INSERT INTO `settings_conradrelayboard` VALUES (0,0,'192.168.100.7',23,'tcp','/dev/ttyUSB3',19200,0),(1,0,'192.168.100.7',23,'serial','/dev/ttyUSBD0',19200,0);
/*!40000 ALTER TABLE `settings_conradrelayboard` ENABLE KEYS */;
UNLOCK TABLES;

INSERT INTO plugins (id, interface, protocols, name, type) values (90, 'Conrad 8-Way Relay Board', 'ConradRelayBoard', 'ConradRelayBoard', 'class');

INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (662, 'Conrad Relay', 'Switch', 'ConradRelayBoard', '[1-254]-[1-8]');

--
-- Finally update to 1.0.021
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (66,'1.0.021');
UNLOCK TABLES;
