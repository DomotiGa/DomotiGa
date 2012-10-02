
INSERT INTO `devicetypes` VALUES (258,'Pioneer Receiver','AV Receiver','Pioneer','1 (Main), 2 (Zone 2)','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `interfaces` VALUES (39,'Pioneer Interface','Pioneer','Read Write');

--
-- Table structure for table 'contacts'
--

ALTER TABLE contacts ALTER COLUMN callnr SET DEFAULT 0;

--
-- Table structure for table 'settings_pioneer'
--

DROP TABLE IF EXISTS `settings_pioneer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_pioneer` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `serialport` varchar(32) DEFAULT NULL,
  `baudrate` varchar(32) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `settings_pioneer` VALUES (0,0,'192.168.100.7',23,'serial','/dev/ttyUSB8','9600',0),(1,0,'192.168.100.7',23,'serial','/dev/ttyUSB8','9600',0);

ALTER TABLE `settings_x10cmd` MODIFY command VARCHAR(128);

LOCK TABLES `version` WRITE;
INSERT INTO `version` VALUES (45,'1.0.000');
UNLOCK TABLES;

