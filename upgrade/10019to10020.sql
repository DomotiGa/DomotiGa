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

-- ALTER TABLE scenes CHANGE COLUMN `id` `scene_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Add new Smartwares radiator valve devicetype (RFXComTRX433e with firmware >= 233)
--

INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (665,'Smartwares Radiator Valve','Radiator valve 433.92Mhz','Smartwares','0x312abfg 1');

UPDATE plugins SET protocols = 'X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubicson RisingSun PhilipsSBC EMW100 BBSB Blyss RollerTrol HastaNew HastaOld A-OKRF01 A-OKAC114 Meiantech ByronSX ByronMP SA30 X10SecDW X10SecMotion X10SecRemote PowerCodeDW PowerCodeMotion PowerCodeAux CodeSecure Energenie Livolo RSL TRC02 MDRemote SF01 RFY RFYEXT Imagintrx WT TRC022 AOKE EuroDomest Smartwares' WHERE id = 35;

--
-- Added extra index to speed up queries
--

ALTER TABLE device_values_log ADD INDEX device_id (device_id);

--
-- Renamed plugin Ping to Network detect and added arp-scan functionality
--

ALTER TABLE settings_ping RENAME settings_networkdetect;
ALTER TABLE settings_networkdetect ADD COLUMN enable_ping tinyint(1) NOT NULL DEFAULT '0' AFTER polltime;
ALTER TABLE settings_networkdetect ADD COLUMN enable_arpscan tinyint(1) NOT NULL DEFAULT '0' AFTER enable_ping;
ALTER TABLE settings_networkdetect ADD COLUMN timeout int(11) NOT NULL DEFAULT 100 AFTER enable_arpscan;
UPDATE plugins SET interface = 'Network Interface' WHERE id=5;
UPDATE plugins SET protocols = 'Ping Arp-Scan' WHERE id=5;
UPDATE plugins SET name = 'NetworkDetect' WHERE id=5;

INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (666,'Network Device Arp-Scan','Status On/Off','Arp-Scan','192.168.178.1 or e4:ce:8f:20:31:64');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (667,'Network Host Arp-Scan','Status Up/Down','Arp-Scan','192.168.178.1 or e4:ce:8f:20:31:64');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (668,'Mobile Device Arp-Scan','Status Home/Away','Arp-Scan','192.168.178.1 or e4:ce:8f:20:31:64');

--
-- Table structure for table `config_housemode`
--

DROP TABLE IF EXISTS `config_housemode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config_housemode` (
  `housemode_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`housemode_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_housemode`
--

LOCK TABLES `config_housemode` WRITE;
/*!40000 ALTER TABLE `config_housemode` DISABLE KEYS */;
INSERT INTO `config_housemode` VALUES (1,'normal'),(2,'work'),(3,'away'),(4,'vacation');
/*!40000 ALTER TABLE `config_housemode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Update tables to charset utf8
--

ALTER SCHEMA domotiga DEFAULT CHARACTER SET utf8;
ALTER TABLE actions DEFAULT CHARACTER SET utf8;
ALTER TABLE actions CHANGE COLUMN `name` `name` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE actions CHANGE COLUMN `description` `description` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE actions CHANGE COLUMN `param1` `param1` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE actions CHANGE COLUMN `param2` `param2` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE actions CHANGE COLUMN `param3` `param3` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE actions CHANGE COLUMN `param4` `param4` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE actions CHANGE COLUMN `param5` `param5` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE calendar DEFAULT CHARACTER SET utf8;
ALTER TABLE capture_camera0 DEFAULT CHARACTER SET utf8;
ALTER TABLE capture_camera1 DEFAULT CHARACTER SET utf8;
ALTER TABLE capture_camera2 DEFAULT CHARACTER SET utf8;
ALTER TABLE capture_camera3 DEFAULT CHARACTER SET utf8;
ALTER TABLE category DEFAULT CHARACTER SET utf8;
ALTER TABLE category CHANGE COLUMN `name` `name` VARCHAR(100) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE cdr DEFAULT CHARACTER SET utf8;
ALTER TABLE cdr CHANGE COLUMN `clid` `clid` VARCHAR(80) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE cdr CHANGE COLUMN `src` `src` VARCHAR(80) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE cdr CHANGE COLUMN `dst` `dst` VARCHAR(80) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE cdr CHANGE COLUMN `dcontext` `dcontext` VARCHAR(80) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE cdr CHANGE COLUMN `channel` `channel` VARCHAR(80) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE cdr CHANGE COLUMN `dstchannel` `dstchannel` VARCHAR(80) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE cdr CHANGE COLUMN `lastapp` `lastapp` VARCHAR(80) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE cdr CHANGE COLUMN `lastdata` `lastdata` VARCHAR(80) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE cdr CHANGE COLUMN `disposition` `disposition` VARCHAR(45) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE cdr CHANGE COLUMN `accountcode` `accountcode` VARCHAR(20) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE cdr CHANGE COLUMN `userfield` `userfield` VARCHAR(255) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE cdr CHANGE COLUMN `uniqueid` `uniqueid` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE conditions DEFAULT CHARACTER SET utf8;
ALTER TABLE conditions CHANGE COLUMN `name` `name` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE conditions CHANGE COLUMN `description` `description` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE conditions CHANGE COLUMN `formula` `formula` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE contacts DEFAULT CHARACTER SET utf8;
ALTER TABLE contacts CHANGE COLUMN `name` `name` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE contacts CHANGE COLUMN `address` `address` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE contacts CHANGE COLUMN `zipcode` `zipcode` VARCHAR(11) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE contacts CHANGE COLUMN `city` `city` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE contacts CHANGE COLUMN `country` `country` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE contacts CHANGE COLUMN `phoneno` `phoneno` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE contacts CHANGE COLUMN `mobileno` `mobileno` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE contacts CHANGE COLUMN `email` `email` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE contacts CHANGE COLUMN `cidphone` `cidphone` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE contacts CHANGE COLUMN `cidmobile` `cidmobile` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE contacts CHANGE COLUMN `firstname` `firstname` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE contacts CHANGE COLUMN `surname` `surname` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE device_values DEFAULT CHARACTER SET utf8;
ALTER TABLE device_values CHANGE COLUMN `value` `value` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE device_values CHANGE COLUMN `correction` `correction` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE device_values CHANGE COLUMN `units` `units` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE device_values CHANGE COLUMN `valuerrddsname` `valuerrddsname` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE device_values CHANGE COLUMN `valuerrdtype` `valuerrdtype` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE device_values CHANGE COLUMN `description` `description` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE device_values_log DEFAULT CHARACTER SET utf8;
ALTER TABLE device_values_log CHANGE COLUMN `value` `value` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE device_valuetypes DEFAULT CHARACTER SET utf8;
ALTER TABLE device_valuetypes CHANGE COLUMN `type` `type` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE device_valuetypes CHANGE COLUMN `units` `units` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE device_valuetypes CHANGE COLUMN `description` `description` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices DEFAULT CHARACTER SET utf8;
ALTER TABLE devices CHANGE COLUMN `name` `name` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices CHANGE COLUMN `address` `address` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices CHANGE COLUMN `onicon` `onicon` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL; 
ALTER TABLE devices CHANGE COLUMN `officon` `officon` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL; 
ALTER TABLE devices CHANGE COLUMN `dimicon` `dimicon` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL; 
ALTER TABLE devices CHANGE COLUMN `groups` `groups` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices CHANGE COLUMN `batterystatus` `batterystatus` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices CHANGE COLUMN `comments` `comments` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE thermostat_constant DEFAULT CHARACTER SET utf8;
ALTER TABLE thermostat_constant CHANGE COLUMN `name` `name` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE thermostat_constant CHANGE COLUMN `description` `description` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE thermostat_heating DEFAULT CHARACTER SET utf8;
ALTER TABLE thermostat_heating CHANGE COLUMN `name` `name` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE thermostat_heating CHANGE COLUMN `description` `description` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE thermostat_scenarii DEFAULT CHARACTER SET utf8;
ALTER TABLE thermostat_scenarii CHANGE COLUMN `name` `name` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE thermostat_scenarii CHANGE COLUMN `description` `description` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE thermostat_schedule DEFAULT CHARACTER SET utf8;
ALTER TABLE thermostat_schedule CHANGE COLUMN `description` `description` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE thermostat_schedule_entry DEFAULT CHARACTER SET utf8;

--
-- Finally update to 1.0.020
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (65,'1.0.020');
UNLOCK TABLES;
