--
-- Table structure for table `settings_conrad8relay`
-- 

DROP TABLE IF EXISTS `settings_conrad8relay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_conrad8relay` (
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
-- Dumping data for table `settings_conrad8relay`
--

LOCK TABLES `settings_conrad8relay` WRITE;
/*!40000 ALTER TABLE `settings_conrad8relay` DISABLE KEYS */;
INSERT INTO `settings_conrad8relay` VALUES (0,0,'192.168.100.7',23,'tcp','/dev/ttyUSB3',19200,0),(1,0,'192.168.100.7',23,'serial','/dev/ttyUSBD0',19200,0);
/*!40000 ALTER TABLE `settings_conrad8relay` ENABLE KEYS */;
UNLOCK TABLES;

INSERT INTO plugins (id, interface, protocols, name, type) values (90, 'Conrad 8-Relay Interface', 'Conrad8Relay', 'Conrad8Relay', 'class');

INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (662, 'Conrad Relay', 'Switch', 'Conrad8Relay', '[1-254]-[1-8]'),(663,'VMB4RYNO','Velbus - 4 channel relay module with normal open contacts','Velbus','11|2'),(664,'VMB2BLE','Velbus - 2 channel blind module','Velbus','12|1');

--
-- Add fields to mqtt settings
--

ALTER TABLE settings_mqtt ADD COLUMN enablepublish tinyint(1) NOT NULL DEFAULT '0' AFTER clientname;
ALTER TABLE settings_mqtt ADD COLUMN enablesubscribe tinyint(11) NOT NULL DEFAULT '0' AFTER enablepublish;

--
-- Table structure for table `settings_broadcastudp`
--

DROP TABLE IF EXISTS `settings_broadcastudp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_broadcastudp` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `udpport` int(11) DEFAULT NULL,
  `targetip` varchar(32) DEFAULT NULL,
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_broadcastudp`
--

LOCK TABLES `settings_broadcastudp` WRITE;
/*!40000 ALTER TABLE `settings_broadcastudp` DISABLE KEYS */;
INSERT INTO `settings_broadcastudp` VALUES (0,0,19009,'',0),(1,1,19009,'',0);
/*!40000 ALTER TABLE `settings_broadcastudp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_ipx800`
-- 

DROP TABLE IF EXISTS `settings_ipx800`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_ipx800` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `username` varchar(32) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `poll` int(11) DEFAULT NULL,
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_ipx800`
--

LOCK TABLES `settings_ipx800` WRITE;
/*!40000 ALTER TABLE `settings_ipx800` DISABLE KEYS */;
INSERT INTO `settings_ipx800` VALUES (0,0,'192.168.100.7',9870,'','',0,-1),(1,0,'10.20.99.134',9870,'','',0,-1);
/*!40000 ALTER TABLE `settings_ipx800` ENABLE KEYS */;
UNLOCK TABLES;

INSERT INTO plugins (id, interface, protocols, name, type) values (89, 'Ipx800 Interface', 'Ipx800', 'Ipx800', 'class');

INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (316, 'Ipx800 Output', 'Ipx800 Output', 'Ipx800', 'Output|01');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (317, 'Ipx800 Input', 'Ipx800 Input', 'Ipx800', 'Input|01');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (318, 'Ipx800 Analogic', 'Ipx800 Analogic Input', 'Ipx800', 'Analogic|01');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (319, 'Ipx800 Count', 'Ipx800 Count', 'Ipx800', 'Count|01');

--
-- Delete old procedure
--

DROP PROCEDURE IF EXISTS sp_addcolumn;

--
-- Add fields to rrdtool settings
--

ALTER TABLE settings_rrdtool ADD COLUMN width int(11) NOT NULL DEFAULT '785' AFTER debug;
ALTER TABLE settings_rrdtool ADD COLUMN height int(11) NOT NULL DEFAULT '120' AFTER width;

--
-- Move XML-RPC to plugin
--

INSERT INTO plugins (id, interface, protocols, name, type) values (91, 'XMLRPC', '', 'XMLRPC', 'class');

--
-- Move VideoServer to plugin
--

INSERT INTO plugins (id, interface, protocols, name, type) values (92, 'VideoServer', '', 'VideoServer', 'class');

--
-- Add SSL support to JSON-RPC
--

ALTER TABLE settings_jsonrpc ADD COLUMN `httpsport` INT(11) NOT NULL DEFAULT '0' AFTER `debug`, ADD COLUMN `httpenabled` TINYINT(1) NOT NULL DEFAULT '-1' AFTER `httpsport`, ADD COLUMN `httpsenabled` TINYINT(1) NOT NULL DEFAULT '0' AFTER `httpenabled`, ADD COLUMN `sslcertificate` VARCHAR(128) NULL DEFAULT NULL AFTER `httpsenabled`;

UPDATE settings_jsonrpc SET sslcertificate = 'server.pm';
ALTER TABLE settings_jsonrpc MODIFY COLUMN `httpport` int(11) NOT NULL DEFAULT '0';
ALTER TABLE settings_jsonrpc MODIFY COLUMN `maxconn` int(11) NOT NULL DEFAULT '0';

--
-- Update thermostat ids
--

ALTER TABLE thermostat_scenarii CHANGE COLUMN `id` `scenario_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE thermostat_heating CHANGE COLUMN `id` `heating_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE thermostat_constant CHANGE COLUMN `id` `constant_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE thermostat_schedule CHANGE COLUMN `scenario` `scenario_id` INT(11) UNSIGNED NOT NULL;
ALTER TABLE thermostat_schedule CHANGE COLUMN `heating` `heating_id` INT(11) UNSIGNED NOT NULL;
ALTER TABLE thermostat_schedule_entry CHANGE COLUMN `scenario` `scenario_id` INT(11) UNSIGNED NOT NULL;
ALTER TABLE thermostat_schedule_entry CHANGE COLUMN `heating` `heating_id` INT(11) UNSIGNED NOT NULL;
ALTER TABLE thermostat_schedule_entry CHANGE COLUMN `constant` `constant_id` INT(11) UNSIGNED NOT NULL;

--
-- Update scene ids
--

ALTER TABLE scenes CHANGE COLUMN `id` `scene_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Add new Smartwares radiator valve devicetype (RFXComTRX433e with firmware >= 233)
--

INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (665,'Smartwares Radiator Valve','Radiator valve 433.92Mhz','Smartwares','0x312abfg 1');

UPDATE plugins SET protocols = 'X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubicson RisingSun PhilipsSBC EMW100 BBSB Blyss RollerTrol HastaNew HastaOld A-OKRF01 A-OKAC114 Meiantech ByronSX ByronMP SA30 X10SecDW X10SecMotion X10SecRemote PowerCodeDW PowerCodeMotion PowerCodeAux CodeSecure Energenie Livolo RSL TRC02 MDRemote SF01 RFY RFYEXT Imagintrx WT TRC022 AOKE EuroDomest Smartwares' WHERE id = 35;

--
-- Finally update to 1.0.020
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (65,'1.0.020');
UNLOCK TABLES;
