--
-- Fix 10020 to 10021 upgrade problem
--
DELETE FROM plugins WHERE id=94;
DELETE FROM plugins WHERE id=95;

INSERT INTO plugins (`id`, `interface`, `name`, `type`) VALUES (94, 'GPS', 'GPS', 'class');
INSERT INTO plugins (`id`, `interface`, `protocols`, `name`, `type`) values (95,'Buienradar','','Buienradar','class');

--
-- Table structure for table `settings_modbus`
--

DROP TABLE IF EXISTS `settings_modbus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_modbus` (
  `id` int(11) NOT NULL,
  `modbustype` varchar(32) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `serialport` varchar(128) DEFAULT NULL,
  `baudrate` varchar(32) DEFAULT NULL,
  `stopbits` int(8) DEFAULT NULL,
  `databits` int(8) DEFAULT NULL,
  `parity` int(8) DEFAULT NULL,
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  `polltime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_modbus`
--

LOCK TABLES `settings_modbus` WRITE;
/*!40000 ALTER TABLE `settings_modbus` DISABLE KEYS */;
INSERT INTO `settings_modbus` VALUES (0,'rtu',0,'192.168.100.7',502,'serial','/dev/ttyUSB0','9600',1,8,0,-1,300),(1,'rtu',0,'192.168.100.7',502,'serial','/dev/ttyUSB0','9600',1,8,0,-1,300);
/*!40000 ALTER TABLE `settings_modbus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Add Modbus to Table `plugin`
--

INSERT INTO plugins (`id`, `interface`, `name`, `protocols`, `type`) VALUES (96, 'Modbus Interface', 'Modbus', 'Modbus', 'class');

--
-- Add Modbus devicetypes
--

INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (672, 'Read Holding Register 16-bit Unsigned', '03 16-bit Unsigned', 'Modbus', '2:10'),(673,'Read Holding Register 16-bit Signed','03 16-bit Signed','Modbus','1:0'),(674, 'Read Holding Register 16-bit ASCII', '03 16-bit ASCII', 'Modbus', '2:10'),(675,'Read Holding Register 16-bit On/Off','03 16-bit On/Off','Modbus','1:0');

INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (676, 'Read Holding Register 32-bit Unsigned', '03 32-bit Unsigned', 'Modbus', '2:10'),(677,'Read Holding Register 32-bit Signed','03 32-bit Signed','Modbus','1:0'),(678, 'Read Holding Register 32-bit ASCII', '03 32-bit ASCII', 'Modbus', '2:10'),(679,'Read Holding Register 32-bit IEEE','03 32-bit IEEE','Modbus','1:0');

--
-- Table structure for table `settings_enocean`
--

DROP TABLE IF EXISTS `settings_enocean`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_enocean` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `type` varchar(32) DEFAULT NULL,
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `serialport` varchar(128) DEFAULT NULL,
  `baudrate` varchar(32) DEFAULT NULL,
  `relayenabled` tinyint(1) DEFAULT NULL,
  `relayport` int(11) DEFAULT NULL,
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_enocean`
--

LOCK TABLES `settings_enocean` WRITE;
/*!40000 ALTER TABLE `settings_enocean` DISABLE KEYS */;
INSERT INTO `settings_enocean` VALUES (0,0,'serial','192.168.100.7',5003,'/dev/serial/by-id/usb-EnOcean_GmbH_EnOcean_USB_300_DB_FTWYONRS-if00-port0','57600',0,10004,-1),(1,0,'serial','192.168.100.7',5003,'/dev/serial/by-id/usb-EnOcean_GmbH_EnOcean_USB_300_DB_FTWYONRS-if00-port0','57600',0,10004,-1);
/*!40000 ALTER TABLE `settings_enocean` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Add EnOcean to Table `plugins`
--

INSERT INTO plugins (`id`, `interface`, `name`, `protocols`, `type`) VALUE (97,'EnOcean Interface','EnOcean','EnOcean','class');

--
-- Add EnOcean devicetypes
--
-- Not defined yet 

--
-- Table structure for table `settings_caddx`
--

DROP TABLE IF EXISTS `settings_caddx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_caddx` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `serialport` varchar(128) DEFAULT NULL,
  `baudrate` int(11) DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `mastercode` varchar(16) DEFAULT '1234',
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_caddx`
--

LOCK TABLES `settings_caddx` WRITE;
/*!40000 ALTER TABLE `settings_dsc` DISABLE KEYS */;
INSERT INTO `settings_caddx` VALUES (0,0,'/dev/ttyS0',9600,0,'1234',0),(1,0,'/dev/ttyS0',9600,0,'1234',0);
/*!40000 ALTER TABLE `settings_dsc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Add Caddx to Table `plugins`
--

INSERT INTO plugins (`id`, `interface`, `name`, `protocols`, `type`) VALUE (98,'Caddx Interface','Caddx','Caddx','class');

--
-- Finally update to 1.0.022
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (67,'1.0.022');
UNLOCK TABLES;
--
-- Finally update to 1.0.023
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (68,'1.0.023');
UNLOCK TABLES;
