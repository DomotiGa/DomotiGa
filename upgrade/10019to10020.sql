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
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
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

ALTER TABLE thermostat_schedule CHANGE COLUMN `scenario` `scenario_id` INT(11) UNSIGNED NOT NULL;
ALTER TABLE thermostat_schedule CHANGE COLUMN `heating` `heating_id` INT(11) UNSIGNED NOT NULL;
ALTER TABLE thermostat_schedule_entry CHANGE COLUMN `scenario` `scenario_id` INT(11) UNSIGNED NOT NULL;
ALTER TABLE thermostat_schedule_entry CHANGE COLUMN `heating` `heating_id` INT(11) UNSIGNED NOT NULL;
ALTER TABLE thermostat_schedule_entry CHANGE COLUMN `constant` `constant_id` INT(11) UNSIGNED NOT NULL;

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
ALTER TABLE contacts CHANGE COLUMN `comments` `comments` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
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
ALTER TABLE deviceblacklist DEFAULT CHARACTER SET utf8;
ALTER TABLE deviceblacklist CHANGE COLUMN `address` `address` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE deviceblacklist CHANGE COLUMN `comments` `comments` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices DEFAULT CHARACTER SET utf8;
ALTER TABLE devices CHANGE COLUMN `name` `name` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices CHANGE COLUMN `address` `address` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices CHANGE COLUMN `onicon` `onicon` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices CHANGE COLUMN `officon` `officon` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices CHANGE COLUMN `dimicon` `dimicon` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices CHANGE COLUMN `groups` `groups` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices CHANGE COLUMN `batterystatus` `batterystatus` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices CHANGE COLUMN `comments` `comments` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices CHANGE COLUMN `resetvalue` `resetvalue` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_bwired DEFAULT CHARACTER SET utf8;
ALTER TABLE devices_bwired CHANGE COLUMN `description` `description` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_bwired CHANGE COLUMN `devicename` `devicename` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_bwired CHANGE COLUMN `devicelabel` `devicelabel` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_bwired CHANGE COLUMN `value` `value` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_camera DEFAULT CHARACTER SET utf8;
ALTER TABLE devices_camera CHANGE COLUMN `name` `name` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_camera CHANGE COLUMN `type` `type` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_camera CHANGE COLUMN `cmdoptions` `cmdoptions` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_camera CHANGE COLUMN `viewstring` `viewstring` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_camera CHANGE COLUMN `grabstring` `grabstring` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_camera CHANGE COLUMN `ptzbaseurl` `ptzbaseurl` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_camera CHANGE COLUMN `ptztype` `ptztype` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_camera CHANGE COLUMN `description` `description` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_camera CHANGE COLUMN `username` `username` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_camera CHANGE COLUMN `passwd` `passwd` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_xively DEFAULT CHARACTER SET utf8;
ALTER TABLE devices_xively CHANGE COLUMN `datastreamid` `datastreamid` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_xively CHANGE COLUMN `tags` `tags` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_xively CHANGE COLUMN `devicename` `devicename` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_xively CHANGE COLUMN `devicelabel` `devicelabel` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_xively CHANGE COLUMN `value` `value` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_xively CHANGE COLUMN `units` `units` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devices_xively CHANGE COLUMN `unittype` `unittype` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devicetypes DEFAULT CHARACTER SET utf8;
ALTER TABLE devicetypes CHANGE COLUMN `name` `name` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devicetypes CHANGE COLUMN `description` `description` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devicetypes CHANGE COLUMN `protocol` `protocol` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devicetypes CHANGE COLUMN `addressformat` `addressformat` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devicetypes_homematic DEFAULT CHARACTER SET utf8;
ALTER TABLE devicetypes_homematic CHANGE COLUMN `type` `type` VARCHAR(32) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE devicetypes_homematic CHANGE COLUMN `subtype` `subtype` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devicetypes_homematic CHANGE COLUMN `type_code` `type_code` VARCHAR(4) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devicetypes_homematic CHANGE COLUMN `subtype_code` `subtype_code` VARCHAR(4) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devicetypes_homematic CHANGE COLUMN `commands` `commands` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE devicetypes_homematic CHANGE COLUMN `values` `values` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE dictionary DEFAULT CHARACTER SET utf8;
ALTER TABLE dictionary CHANGE COLUMN `US` `US` VARCHAR(500) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE dictionary CHANGE COLUMN `NL` `NL` VARCHAR(500) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE dictionary CHANGE COLUMN `DE` `DE` VARCHAR(500) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE dictionary CHANGE COLUMN `FR` `FR` VARCHAR(500) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE dictionary CHANGE COLUMN `CreationDate` `CreationDate` VARCHAR(12) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE dictionary CHANGE COLUMN `ModificationDate` `ModificationDate` VARCHAR(12) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE events DEFAULT CHARACTER SET utf8;
ALTER TABLE events CHANGE COLUMN `name` `name` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE events CHANGE COLUMN `operand` `operand` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE events CHANGE COLUMN `reruntype` `reruntype` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE events CHANGE COLUMN `comments` `comments` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE events_actions DEFAULT CHARACTER SET utf8;
ALTER TABLE floors DEFAULT CHARACTER SET utf8;
ALTER TABLE floors CHANGE COLUMN `name` `name` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE floors CHANGE COLUMN `image` `image` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE gas_usage DEFAULT CHARACTER SET utf8;
ALTER TABLE globalvars DEFAULT CHARACTER SET utf8;
ALTER TABLE globalvars CHANGE COLUMN `var` `var` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE globalvars CHANGE COLUMN `value` `value` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE graph_data DEFAULT CHARACTER SET utf8;
ALTER TABLE graph_data CHANGE COLUMN `graph_name` `graph_name` VARCHAR(32) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE graph_data CHANGE COLUMN `graph_line_type` `graph_line_type` VARCHAR(10) CHARACTER SET 'utf8' NOT NULL DEFAULT 'LINE1';
ALTER TABLE graph_data CHANGE COLUMN `graph_rrddsname` `graph_rrddsname` VARCHAR(32) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE graph_data CHANGE COLUMN `graph_operation_operator` `graph_operation_operator` VARCHAR(1) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE graph_data CHANGE COLUMN `graph_devicename` `graph_devicename` VARCHAR(32) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE graphs DEFAULT CHARACTER SET utf8;
ALTER TABLE graphs CHANGE COLUMN `name` `name` VARCHAR(32) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE graphs CHANGE COLUMN `comments` `comments` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE graphs CHANGE COLUMN `graph_title` `graph_title` VARCHAR(32) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE graphs CHANGE COLUMN `grid_type` `grid_type` VARCHAR(32) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE graphs CHANGE COLUMN `groups` `groups` VARCHAR(128) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE graphs CHANGE COLUMN `unit` `unit` VARCHAR(10) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE groups DEFAULT CHARACTER SET utf8;
ALTER TABLE groups CHANGE COLUMN `name` `name` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE locations DEFAULT CHARACTER SET utf8;
ALTER TABLE locations CHANGE COLUMN `name` `name` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE macros DEFAULT CHARACTER SET utf8;
ALTER TABLE macros CHANGE COLUMN `name` `name` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE macros CHANGE COLUMN `formula` `formula` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE markers DEFAULT CHARACTER SET utf8;
ALTER TABLE markers CHANGE COLUMN `name` `name` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE markers CHANGE COLUMN `address` `address` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE menu DEFAULT CHARACTER SET utf8;
ALTER TABLE menu CHANGE COLUMN `name` `name` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE menu CHANGE COLUMN `item` `item` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE menu CHANGE COLUMN `icon` `icon` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE menu_names DEFAULT CHARACTER SET utf8;
ALTER TABLE menu_names CHANGE COLUMN `name` `name` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE newsfeeds DEFAULT CHARACTER SET utf8;
ALTER TABLE newsfeeds CHANGE COLUMN `name` `name` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE newsfeeds CHANGE COLUMN `url` `url` VARCHAR(254) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE newsfeeds CHANGE COLUMN `description` `description` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE notify DEFAULT CHARACTER SET utf8;
ALTER TABLE notify CHANGE COLUMN `keyword` `keyword` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE notifytypes DEFAULT CHARACTER SET utf8;
ALTER TABLE notifytypes CHANGE COLUMN `name` `name` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE plugins DEFAULT CHARACTER SET utf8;
ALTER TABLE plugins CHANGE COLUMN `interface` `interface` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE plugins CHANGE COLUMN `protocols` `protocols` VARCHAR(512) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE plugins CHANGE COLUMN `name` `name` VARCHAR(32) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE plugins CHANGE COLUMN `type` `type` VARCHAR(32) CHARACTER SET 'utf8' NOT NULL DEFAULT 'class';
ALTER TABLE power_exported DEFAULT CHARACTER SET utf8;
ALTER TABLE power_usage DEFAULT CHARACTER SET utf8;
ALTER TABLE remarks_fullmoon DEFAULT CHARACTER SET utf8;
ALTER TABLE remarks_fullmoon CHANGE COLUMN `text` `text` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE remarks_humid DEFAULT CHARACTER SET utf8;
ALTER TABLE remarks_humid CHANGE COLUMN `text` `text` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE remarks_personal DEFAULT CHARACTER SET utf8;
ALTER TABLE remarks_personal CHANGE COLUMN `text` `text` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE remarks_plants DEFAULT CHARACTER SET utf8;
ALTER TABLE remarks_plants CHANGE COLUMN `text` `text` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE remarks_tags DEFAULT CHARACTER SET utf8;
ALTER TABLE remarks_tags CHANGE COLUMN `text` `text` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE remarks_tempbelow5 DEFAULT CHARACTER SET utf8;
ALTER TABLE remarks_tempbelow5 CHANGE COLUMN `text` `text` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE remarks_tempbelowmin5 DEFAULT CHARACTER SET utf8;
ALTER TABLE remarks_tempbelowmin5 CHANGE COLUMN `text` `text` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE scenes DEFAULT CHARACTER SET utf8;
ALTER TABLE scenes CHANGE COLUMN `name` `name` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE scenes CHANGE COLUMN `comments` `comments` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE security DEFAULT CHARACTER SET utf8;
ALTER TABLE security CHANGE COLUMN `lcd_line1` `lcd_line1` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE security CHANGE COLUMN `lcd_line2` `lcd_line2` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE stock DEFAULT CHARACTER SET utf8;
ALTER TABLE stock CHANGE COLUMN `name` `name` VARCHAR(100) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE trafficfeeds DEFAULT CHARACTER SET utf8;
ALTER TABLE trafficfeeds CHANGE COLUMN `name` `name` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE trafficfeeds CHANGE COLUMN `url` `url` VARCHAR(254) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE trafficfeeds CHANGE COLUMN `description` `description` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE triggers DEFAULT CHARACTER SET utf8;
ALTER TABLE triggers CHANGE COLUMN `name` `name` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE triggers CHANGE COLUMN `description` `description` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE triggers CHANGE COLUMN `param1` `param1` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE triggers CHANGE COLUMN `param2` `param2` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE triggers CHANGE COLUMN `param3` `param3` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE triggers CHANGE COLUMN `param4` `param4` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE triggers CHANGE COLUMN `param5` `param5` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE tv_categories DEFAULT CHARACTER SET utf8;
ALTER TABLE tv_categories CHANGE COLUMN `CategoryName` `CategoryName` VARCHAR(50) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_categories CHANGE COLUMN `BackColor` `BackColor` VARCHAR(15) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_categories CHANGE COLUMN `ForeColor` `ForeColor` VARCHAR(15) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_categories CHANGE COLUMN `EXTpreview` `EXTpreview` VARCHAR(5) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_categories CHANGE COLUMN `CreationDate` `CreationDate` VARCHAR(12) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_categories CHANGE COLUMN `ModificationDate` `ModificationDate` VARCHAR(12) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_channels DEFAULT CHARACTER SET utf8;
ALTER TABLE tv_channels CHANGE COLUMN `ChannelName` `ChannelName` VARCHAR(50) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_channels CHANGE COLUMN `ChannelID` `ChannelID` VARCHAR(25) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_channels CHANGE COLUMN `EXTlogo` `EXTlogo` VARCHAR(5) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_channels CHANGE COLUMN `CreationDate` `CreationDate` VARCHAR(12) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_channels CHANGE COLUMN `ModificationDate` `ModificationDate` VARCHAR(12) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_channels CHANGE COLUMN `ChannelOrder` `ChannelOrder` VARCHAR(4) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_programs DEFAULT CHARACTER SET utf8;
ALTER TABLE tv_programs CHANGE COLUMN `ChannelID` `ChannelID` VARCHAR(25) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_programs CHANGE COLUMN `StartPoint` `StartPoint` VARCHAR(12) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_programs CHANGE COLUMN `EndPoint` `EndPoint` VARCHAR(12) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_programs CHANGE COLUMN `ProgramName` `ProgramName` VARCHAR(150) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_programs CHANGE COLUMN `ProgramDescription` `ProgramDescription` VARCHAR(1000) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_programs CHANGE COLUMN `CategoryName` `CategoryName` VARCHAR(50) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_programs CHANGE COLUMN `SubCategoryName` `SubCategoryName` VARCHAR(50) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_programs CHANGE COLUMN `CreationDate` `CreationDate` VARCHAR(12) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_subcategories DEFAULT CHARACTER SET utf8;
ALTER TABLE tv_subcategories CHANGE COLUMN `CategoryID` `CategoryID` VARCHAR(50) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_subcategories CHANGE COLUMN `SubCategoryName` `SubCategoryName` VARCHAR(50) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_subcategories CHANGE COLUMN `CreationDate` `CreationDate` VARCHAR(12) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE tv_subcategories CHANGE COLUMN `ModificationDate` `ModificationDate` VARCHAR(12) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE users DEFAULT CHARACTER SET utf8;
ALTER TABLE users CHANGE COLUMN `username` `username` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE users CHANGE COLUMN `password` `password` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE users CHANGE COLUMN `fullname` `fullname` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE users CHANGE COLUMN `comments` `comments` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE users CHANGE COLUMN `lastlogin` `lastlogin` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE users CHANGE COLUMN `emailaddress` `emailaddress` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE users CHANGE COLUMN `cookie` `cookie` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT '';
ALTER TABLE version DEFAULT CHARACTER SET utf8;
ALTER TABLE version CHANGE COLUMN `db` `db` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE water_usage DEFAULT CHARACTER SET utf8;
ALTER TABLE weatherfeeds DEFAULT CHARACTER SET utf8;
ALTER TABLE weatherfeeds CHANGE COLUMN `name` `name` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE weatherfeeds CHANGE COLUMN `url` `url` VARCHAR(254) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE weatherfeeds CHANGE COLUMN `description` `description` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
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

ALTER TABLE settings_asterisk DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_asterisk CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_asterisk CHANGE COLUMN `user` `user` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_asterisk CHANGE COLUMN `password` `password` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_astro DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_astro CHANGE COLUMN `latitude` `latitude` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_astro CHANGE COLUMN `longitude` `longitude` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_astro CHANGE COLUMN `twilight` `twilight` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_astro CHANGE COLUMN `seasons` `seasons` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_astro CHANGE COLUMN `seasonstarts` `seasonstarts` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_astro CHANGE COLUMN `temperature` `temperature` VARCHAR(6) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_astro CHANGE COLUMN `currency` `currency` VARCHAR(6) CHARACTER SET 'utf8' NULL DEFAULT NULL;
UPDATE settings_astro SET `dst`='0' WHERE `dst`=NULL;
ALTER TABLE settings_astro CHANGE COLUMN `dst` `dst` TINYINT(1) NULL DEFAULT '0';
ALTER TABLE settings_bluetooth DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_bluetooth CHANGE COLUMN `device` `device` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_bwiredmap DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_bwiredmap CHANGE COLUMN `website` `website` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_bwiredmap CHANGE COLUMN `websitepicurl` `websitepicurl` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_bwiredmap CHANGE COLUMN `title` `title` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_bwiredmap CHANGE COLUMN `city` `city` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_bwiredmap CHANGE COLUMN `user` `user` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_bwiredmap CHANGE COLUMN `password` `password` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_bwiredmap CHANGE COLUMN `screenname` `screenname` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_bwiredmap CHANGE COLUMN `gpslat` `gpslat` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_bwiredmap CHANGE COLUMN `gpslong` `gpslong` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_callerid DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_callerid CHANGE COLUMN `countrycode` `countrycode` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_callerid CHANGE COLUMN `areacode` `areacode` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_callerid CHANGE COLUMN `prefixnational` `prefixnational` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_callerid CHANGE COLUMN `prefixinternational` `prefixinternational` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
UPDATE settings_callerid SET `autocreatecontacts`='0' WHERE `autocreatecontacts`=NULL;
ALTER TABLE settings_callerid CHANGE COLUMN `autocreatecontacts` `autocreatecontacts` TINYINT(1) NULL DEFAULT '0';
ALTER TABLE settings_ctx35 DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_ctx35 CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_ctx35 CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
UPDATE settings_ctx35 SET `globalx10`='0' WHERE `globalx10`=NULL;
ALTER TABLE settings_ctx35 CHANGE COLUMN `globalx10` `globalx10` TINYINT(1) NULL DEFAULT '0';
ALTER TABLE settings_cul DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_cul CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_cul CHANGE COLUMN `type` `type` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_cul CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_cul CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_cul CHANGE COLUMN `fhtid` `fhtid` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_cul CHANGE COLUMN `tcpport` `tcpport` INT(11) NULL DEFAULT NULL;
ALTER TABLE settings_currentcost DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_currentcost CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_currentcost CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_denon DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_denon CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_denon CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_denon CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_denon CHANGE COLUMN `type` `type` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_devicediscover DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_devicediscover CHANGE COLUMN `multicasthost` `multicasthost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_digitemp DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_digitemp CHANGE COLUMN `command` `command` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_digitemp CHANGE COLUMN `config` `config` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_dmxplayer DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_dmxplayer CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_dmxplayer CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_dsc DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_dsc CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_dsc CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_dsc CHANGE COLUMN `mastercode` `mastercode` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT '1234';
ALTER TABLE settings_elvmax DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_elvmax CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_email DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_email CHANGE COLUMN `fromaddress` `fromaddress` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_email CHANGE COLUMN `toaddress` `toaddress` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_email CHANGE COLUMN `smtpserver` `smtpserver` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_email CHANGE COLUMN `username` `username` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_email CHANGE COLUMN `password` `password` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
UPDATE settings_email SET `sslenabled`='0' WHERE `sslenabled`=NULL;
ALTER TABLE settings_email CHANGE COLUMN `sslenabled` `sslenabled` TINYINT(1) NULL DEFAULT '0';
ALTER TABLE settings_ezcontrol DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_ezcontrol CHANGE COLUMN `udphost` `udphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_forecastio DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_forecastio CHANGE COLUMN `apikey` `apikey` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_forecastio CHANGE COLUMN `latitude` `latitude` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_forecastio CHANGE COLUMN `longitude` `longitude` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_forecastio CHANGE COLUMN `city` `city` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_fritzbox DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_fritzbox CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_genericio DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_genericio CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_genericio CHANGE COLUMN `type` `type` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_genericio CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_genericio CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_genericio CHANGE COLUMN `regex` `regex` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_genericio CHANGE COLUMN `delimiter` `delimiter` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_gmail DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_gmail CHANGE COLUMN `user` `user` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_gmail CHANGE COLUMN `password` `password` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_gps DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_gps CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_hddtemp DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_hddtemp CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_homematic DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_homematic CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_homematic CHANGE COLUMN `hmid` `hmid` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_homematic CHANGE COLUMN `type` `type` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_iport DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_iport CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_iport CHANGE COLUMN `type` `type` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_iport CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_iport CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_irman DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_irman CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_irtrans DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_irtrans CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_iviewer DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_iviewer CHANGE COLUMN `password` `password` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_jeelabs DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_jeelabs CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_jeelabs CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_jsonrpc DEFAULT CHARACTER SET utf8; 
ALTER TABLE settings_jsonrpc CHANGE COLUMN `sslcertificate` `sslcertificate` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_k8055 DEFAULT CHARACTER SET utf8; 
ALTER TABLE settings_kmtronicudp DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_knx DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_knx CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_ledmatrix DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_ledmatrix CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_lgtv DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_lgtv CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_lgtv CHANGE COLUMN `type` `type` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_lgtv CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_lgtv CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_lirc DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_lirc CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_main DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_main CHANGE COLUMN `startpage` `startpage` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_main CHANGE COLUMN `hometoppanel` `hometoppanel` VARCHAR(256) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_main CHANGE COLUMN `homeleftpanel` `homeleftpanel` VARCHAR(256) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_main CHANGE COLUMN `homerightpanel` `homerightpanel` VARCHAR(256) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_main CHANGE COLUMN `homebottompanel` `homebottompanel` VARCHAR(256) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_main CHANGE COLUMN `logprefix` `logprefix` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
UPDATE settings_main SET `authentication`='0' WHERE `authentication`=NULL;
ALTER TABLE settings_main CHANGE COLUMN `authentication` `authentication` TINYINT(1) NULL DEFAULT '0';
UPDATE settings_main SET `debugevents`='0' WHERE `debugevents`=NULL;
ALTER TABLE settings_main CHANGE COLUMN `debugevents` `debugevents` TINYINT(1) NULL DEFAULT '0';
UPDATE settings_main SET `debugdevices`='0' WHERE `debugdevices`=NULL;
ALTER TABLE settings_main CHANGE COLUMN `debugdevices` `debugdevices` TINYINT(1) NULL DEFAULT '0';
UPDATE settings_main SET `debugenergy`='0' WHERE `debugenergy`=NULL;
ALTER TABLE settings_main CHANGE COLUMN `debugenergy` `debugenergy` TINYINT(1) NULL DEFAULT '0';
UPDATE settings_main SET `debugplugin`='0' WHERE `debugplugin`=NULL;
ALTER TABLE settings_main CHANGE COLUMN `debugplugin` `debugplugin` TINYINT(1) NULL DEFAULT '0';
UPDATE settings_main SET `debugglobalvar`='0' WHERE `debugglobalvar`=NULL;
ALTER TABLE settings_main CHANGE COLUMN `debugglobalvar` `debugglobalvar` TINYINT(1) NULL DEFAULT '0';
UPDATE settings_main SET `autodevicecreate`='0' WHERE `autodevicecreate`=NULL;
ALTER TABLE settings_main CHANGE COLUMN `autodevicecreate` `autodevicecreate` TINYINT(1) NULL DEFAULT '0';
ALTER TABLE settings_meteohub DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_meteohub CHANGE COLUMN `fetchurl` `fetchurl` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_mochad DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_mochad CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
UPDATE settings_mochad SET `globalX10`='0' WHERE `globalX10`=NULL;
ALTER TABLE settings_mochad CHANGE COLUMN `globalX10` `globalX10` TINYINT(1) NULL DEFAULT '0';
ALTER TABLE settings_mqtt DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_mqtt CHANGE COLUMN `tcphost` `tcphost` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_mqtt CHANGE COLUMN `username` `username` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_mqtt CHANGE COLUMN `password` `password` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_mqtt CHANGE COLUMN `pubtopic` `pubtopic` VARCHAR(256) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_mqtt CHANGE COLUMN `subtopic` `subtopic` VARCHAR(256) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_mqtt CHANGE COLUMN `clientname` `clientname` VARCHAR(23) CHARACTER SET 'utf8' NULL DEFAULT 'domotiga';
UPDATE settings_mqtt SET `retain`='0' WHERE `retain`=NULL;
ALTER TABLE settings_mqtt CHANGE COLUMN `retain` `retain` TINYINT(1) NULL DEFAULT '0';
ALTER TABLE settings_mysensors DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_mysensors CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_mysensors CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_mysensors CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_mysensors CHANGE COLUMN `type` `type` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
UPDATE settings_mysensors SET `relayenabled`='0' WHERE `relayenabled`=NULL;
ALTER TABLE settings_mysensors CHANGE COLUMN `relayenabled` `relayenabled` TINYINT(1) NULL DEFAULT '0';
ALTER TABLE settings_ncid DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_ncid CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_nma DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_nma CHANGE COLUMN `apikey` `apikey` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_nma CHANGE COLUMN `application` `application` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_nma CHANGE COLUMN `event` `event` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_omniksol DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_omniksol CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_omniksol CHANGE COLUMN `serial` `serial` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_omniksol CHANGE COLUMN `cron` `cron` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_onkyo DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_onkyo CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_onkyo CHANGE COLUMN `type` `type` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_onkyo CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_onkyo CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_opentherm DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_opentherm CHANGE COLUMN `temperatureoverride` `temperatureoverride` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_opentherm CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_opentherm CHANGE COLUMN `thermostat` `thermostat` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_opentherm CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_opentherm CHANGE COLUMN `type` `type` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_openweathermap DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_openweathermap CHANGE COLUMN `apikey` `apikey` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_openweathermap CHANGE COLUMN `cityid` `cityid` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_openweathermap CHANGE COLUMN `city` `city` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_openzwave DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_openzwave CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_openzwave CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_openzwave CHANGE COLUMN `polltimesleeping` `polltimesleeping` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_openzwave CHANGE COLUMN `polltimelistening` `polltimelistening` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_openzwave CHANGE COLUMN `updateneighbor` `updateneighbor` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_owfs DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_owfs CHANGE COLUMN `basedir` `basedir` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_oww DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_oww CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_oww CHANGE COLUMN `servertype` `servertype` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_p2000 DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_p2000 CHANGE COLUMN `regios` `regios` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_p2000 CHANGE COLUMN `discipline` `discipline` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_p2000 CHANGE COLUMN `filter` `filter` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_xively DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_xively CHANGE COLUMN `apikey` `apikey` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_philipshue DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_philipshue CHANGE COLUMN `username` `username` VARCHAR(44) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_networkdetect DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_pioneer DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_pioneer CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_pioneer CHANGE COLUMN `type` `type` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_pioneer CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_pioneer CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_plcbus DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_plcbus CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_plcbus CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_plcbus CHANGE COLUMN `usercode` `usercode` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_plcbus CHANGE COLUMN `housecodes` `housecodes` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_plugwise DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_plugwise CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_prowl DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_prowl CHANGE COLUMN `apikey` `apikey` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_prowl CHANGE COLUMN `application` `application` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_prowl CHANGE COLUMN `event` `event` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_pushbullet DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_pushbullet CHANGE COLUMN `token` `token` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_pushbullet CHANGE COLUMN `device` `device` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_pushover DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_pushover CHANGE COLUMN `token` `token` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_pushover CHANGE COLUMN `user` `user` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_pushover CHANGE COLUMN `device` `device` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_pvoutput DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_pvoutput CHANGE COLUMN `api` `api` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_pvoutput CHANGE COLUMN `pvoutputid` `pvoutputid` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_pvoutput CHANGE COLUMN `devicevalue` `devicevalue` VARCHAR(8) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE settings_pvoutput CHANGE COLUMN `usagedevicevalue` `usagedevicevalue` VARCHAR(8) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE settings_pvoutput CHANGE COLUMN `tempdevicevalue` `tempdevicevalue` VARCHAR(8) CHARACTER SET 'utf8' NOT NULL;
ALTER TABLE settings_pwrctrl DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_pwrctrl CHANGE COLUMN `userpw` `userpw` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_razberry DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_razberry CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_razberry CHANGE COLUMN `username` `username` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_razberry CHANGE COLUMN `password` `password` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_rfxcomrx DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_rfxcomrx CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_rfxcomrx CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_rfxcomrx CHANGE COLUMN `type` `type` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_rfxcomrx CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_rfxcomtrx DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_rfxcomtrx CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_rfxcomtrx CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_rfxcomtrx CHANGE COLUMN `type` `type` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_rfxcomtrx CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_rfxcomtx DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_rfxcomtx CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_rfxcomtx CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_rfxcomtx CHANGE COLUMN `type` `type` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_rfxcomtx CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_rfxcomxpl DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_rfxcomxpl CHANGE COLUMN `rxaddress` `rxaddress` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_rfxcomxpl CHANGE COLUMN `txaddress` `txaddress` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_rrdtool DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_rrdtool CHANGE COLUMN `rra` `rra` VARCHAR(256) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_serverstats DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_serverstats CHANGE COLUMN `servername` `servername` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_sharptv DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_sharptv CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_sharptv CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_sharptv CHANGE COLUMN `type` `type` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_sharptv CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_shell DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_smartmeter DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_smartmeter CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_smartmeter CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_smartmeter CHANGE COLUMN `type` `type` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_smartmeter CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_smartmeter CHANGE COLUMN `requestline` `requestline` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_smartvisuserver DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_sms DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_sms CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_sms CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_sms CHANGE COLUMN `pin` `pin` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_sms CHANGE COLUMN `servicecentre` `servicecentre` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_sms CHANGE COLUMN `contact` `contact` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_sound DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_squeezeserver DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_squeezeserver CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_telnetserver DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_temp08 DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_temp08 CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_temperaturnu DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_temperaturnu CHANGE COLUMN `city` `city` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_temperaturnu CHANGE COLUMN `apikey` `apikey` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_temperaturnu CHANGE COLUMN `devicevalue` `devicevalue` VARCHAR(8) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_thermostat DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_toon DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_toon CHANGE COLUMN `user` `user` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_toon CHANGE COLUMN `password` `password` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_tvguide DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_tvguide CHANGE COLUMN `xmlgrabcmd` `xmlgrabcmd` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_tvguide CHANGE COLUMN `xmlfile` `xmlfile` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_twitter DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_twitter CHANGE COLUMN `username` `username` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_twitter CHANGE COLUMN `password` `password` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_ups DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_ups CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_velbus DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_velbus CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_velbus CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_velbus CHANGE COLUMN `type` `type` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_velbus CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_videoserver DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_videoserver CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_videoserver CHANGE COLUMN `user` `user` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_videoserver CHANGE COLUMN `password` `password` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_videoserver CHANGE COLUMN `channel1` `channel1` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_videoserver CHANGE COLUMN `channel2` `channel2` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_videoserver CHANGE COLUMN `channel3` `channel3` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_videoserver CHANGE COLUMN `channel4` `channel4` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_viera DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_viera CHANGE COLUMN `tcphost` `tcphost` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_visca DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_visca CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_visca CHANGE COLUMN `baudrate` `baudrate` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_visca CHANGE COLUMN `device` `device` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_visonic DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_visonic CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_visonic CHANGE COLUMN `mastercode` `mastercode` VARCHAR(16) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_voicetext DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_voicetext CHANGE COLUMN `engine` `engine` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_voicetext CHANGE COLUMN `prefixcmd` `prefixcmd` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_voicetext CHANGE COLUMN `voicesmale` `voicesmale` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_voicetext CHANGE COLUMN `voicesfemale` `voicesfemale` VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_weatherunderground DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_weatherunderground CHANGE COLUMN `apikey` `apikey` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_weatherunderground CHANGE COLUMN `city` `city` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_weeder DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_weeder CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_wirelesstags DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_wirelesstags CHANGE COLUMN `user` `user` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_wirelesstags CHANGE COLUMN `password` `password` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_wiringpi DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_x10cmd DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_x10cmd CHANGE COLUMN `command` `command` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_xbmcxpl DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_xbmcxpl CHANGE COLUMN `rxaddress` `rxaddress` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_xbmcxpl CHANGE COLUMN `txaddress` `txaddress` VARCHAR(64) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_xmlrpc DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_xpl DEFAULT CHARACTER SET utf8;
ALTER TABLE settings_youless DEFAULT CHARACTER SET utf8;

--
-- Insert Wireless Tags plugin
--

INSERT INTO plugins (interface, protocols, name) VALUES ("Wirelesstags Interface", "Wirelesstags", "Wirelesstags");

--
-- Added new MQTT devicetype
--

INSERT INTO devicetypes VALUES (669,'MQTT JSON Generic Device','MQTT JSON Generic','MQTT','topic like raw/sensor');

--
-- Add previously unknown ELVMAX Eco Button
--

INSERT INTO devicetypes VALUES (670,'Eco Button','Eco Button','ELVMAX','[xxxxxx]');

--
-- Finally update to 1.0.020
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (65,'1.0.020');
UNLOCK TABLES;
