
--
-- Downgrade from InnoDB to MyISAM
--
ALTER TABLE device_values ENGINE=MyISAM;
ALTER TABLE device_values_log ENGINE=MyISAM;

--
-- Table structure for table `settings_velbus`
--
DROP TABLE IF EXISTS `settings_velbus`;
CREATE TABLE `settings_velbus` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `serialport` varchar(32) DEFAULT NULL,
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `relayenabled` tinyint(1) DEFAULT NULL,
  `relayport` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  `baudrate` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings_velbus`
--
LOCK TABLES `settings_velbus` WRITE;
INSERT INTO `settings_velbus` VALUES (0,0,'/dev/ttyACM0','192.168.1.1',1080,'tcp',0,50000,0,'38400'),(1,0,'/dev/ttyACM0','192.168.1.1',1080,'serial',0,50000,0,'38400');
UNLOCK TABLES;

--
-- Add Velbus interface
--
INSERT INTO interfaces VALUES (53,'Velbus Interface','Velbus','Read Write');

--
-- Add Velbus devicetypes
--
INSERT INTO devicetypes VALUES (334,'VMB4RY','Velbus - 4 channel relay module','Velbus','10|2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(335,'VMB4DC','Velbus - 4 channel dimmer module','Velbus','11|2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(336,'VMB7IN','Velbus - 7 channel input','Velbus','12|2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(337,'VMBGPO','Velbus - OLED touch panel','Velbus','13',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(338,'VMBDME','Velbus - Dimmer module','Velbus','14',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

--
-- Finally update to 1.0.015
--
LOCK TABLES version WRITE;
INSERT INTO version VALUES (60,'1.0.015');
UNLOCK TABLES;

