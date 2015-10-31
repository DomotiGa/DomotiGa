--
-- Set control and valuetypes of value1
--

UPDATE device_values JOIN devices SET device_values.control = True WHERE devices.id = device_values.device_id AND device_values.valuenum = 1 AND devices.switchable IS True;
UPDATE device_values JOIN devices SET device_values.control = True WHERE devices.id = device_values.device_id AND device_values.valuenum = 1 AND devices.dimable IS True;
UPDATE device_values JOIN devices SET device_values.type_id = 1 WHERE devices.id = device_values.device_id AND device_values.valuenum = 1 AND devices.switchable IS True;
UPDATE device_values JOIN devices SET device_values.type_id = 20 WHERE devices.id = device_values.device_id AND device_values.valuenum = 1 AND devices.dimable IS True;

--
-- Add VMB4RYLD for Velbus
--
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (671,'VMB4RYLD','Velbus - 4 Channel relay module','Velbus','13|2');

--
-- Add Visonic PowerMax/Master Panel
--
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (672,'Visonic PowerMax','PowerMax Panel','Visonic','Panel');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (673,'Visonic PowerMaster','PowerMaster Panel','Visonic','Panel');

--
-- Modify settings_jsonrpc
--
ALTER TABLE settings_jsonrpc DROP COLUMN `sslcertificate` , DROP COLUMN `httpsenabled` , DROP COLUMN `httpenabled` , DROP COLUMN `httpsport`;
ALTER TABLE settings_jsonrpc ADD COLUMN `sslenabled` TINYINT(1) NOT NULL DEFAULT '0'  AFTER `debug` ;

--
-- Modify settings_visonic
--
ALTER TABLE settings_visonic ADD COLUMN `autosynctime` TINYINT(1) NOT NULL DEFAULT '1'  AFTER `mastercode`;
ALTER TABLE settings_visonic ADD COLUMN `forcestandardmode` TINYINT(1) NOT NULL DEFAULT '0'  AFTER `autosynctime`;
ALTER TABLE settings_visonic ADD COLUMN `motiontimeout` INT(11) DEFAULT '30'  AFTER `forcestandardmode`;
ALTER TABLE settings_visonic ADD COLUMN `sensorarmstatus` INT(11) DEFAULT '0'  AFTER `motiontimeout`;

--
-- Add settings_buienradar
--
CREATE TABLE `settings_buienradar` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `urlbuienradar` varchar(128) DEFAULT NULL,
  `latitude` varchar(32) DEFAULT NULL,
  `longitude` varchar(32) DEFAULT NULL,
  `city` varchar(128) DEFAULT NULL,
  `polltime` int(11) DEFAULT NULL,
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  `outputprecision` int(11) DEFAULT NULL,
  `output` varchar(32) DEFAULT NULL,
  `devmaxvalue` int(11) DEFAULT NULL,
  `devtimevalue` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `settings_buienradar` WRITE;
INSERT INTO `settings_buienradar` VALUES (0, 0, 'http://gps.buienradar.nl/getrr.php', '51.2194475', '4.4024643', 'Antwerpen', 300, 0, 3, 'integer 0-255', 4, 4),(1, 0, 'http://gps.buienradar.nl/getrr.php', '51.2194475', '4.4024643', 'Antwerpen', 300, 0, 3, 'integer 0-255', 4, 4);
UNLOCK TABLES;

--
-- Fix 10020 to 10021 upgrade problem
--
DELETE FROM plugins WHERE id=94;

INSERT INTO plugins (`id`, `interface`, `name`, `type`) VALUES (94, 'GPS', 'GPS', 'class');
INSERT INTO plugins (`id`, `interface`, `protocols`, `name`, `type`) values (95,'Buienradar','','Buienradar','class');


--
-- Table structure for table `sslcertificate`
--
CREATE TABLE `sslcertificate` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `certificate` varchar(128) NOT NULL DEFAULT '',
  `private` varchar(128) NOT NULL DEFAULT '',
  `client` varchar(128) NOT NULL DEFAULT '',
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
>>>>>>> beta

--
-- Finally update to 1.0.022
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (67,'1.0.022');
UNLOCK TABLES;
