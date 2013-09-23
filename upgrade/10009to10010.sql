--
-- Update thermostat_schedule_entry to remove NULL values as secondary attribute
--

UPDATE `thermostat_schedule_entry` SET `secondary`='0' WHERE `secondary`= NULL;

--
-- Modify the thermostat_schedule_entry to include the "secondary" column in the primary key
--

ALTER TABLE `thermostat_schedule_entry`
CHANGE COLUMN `secondary` `secondary` TINYINT(1) NOT NULL ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`scenario`, `heating`, `day`, `time`, `secondary`);

--
-- Update thermostat_heating to initialize secondary to a valid value
--

UPDATE `thermostat_heating` SET `secondary`='0' WHERE `secondary`= NULL;

--
-- Table structure for table 'settings_genericio'
--
DROP TABLE IF EXISTS `settings_genericio`;
CREATE TABLE `settings_genericio` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `serialport` varchar(128) DEFAULT NULL,
  `baudrate` varchar(32) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  `regex` varchar(128) DEFAULT NULL,
  `delimiter` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO `settings_genericio` VALUES (0,0,'192.168.100.7',10001,'serial','/dev/ttyUSB2','115200',0,'^.*?[=]',','),(1,0,'192.168.100.7',10001,'serial','/dev/ttyUSB2','115200',0,'^.*?[=]',',');

--
-- Table structure for table 'settings_mqtt'
--

DROP TABLE IF EXISTS `settings_mqtt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_mqtt` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `tcphost` varchar(64) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `pubtopic` varchar(256) DEFAULT NULL,
  `subtopic` varchar(256) DEFAULT NULL,
  `heartbeat` int(11) DEFAULT NULL,
  `retain` tinyint(1) DEFAULT NULL,
  `qos` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO `settings_mqtt` VALUES (0,0,'localhost',1883,'domotiga','broker','domotiga','raw',30,0,0,0),(1,0,'localhost',1883,'domotiga','broker','domotiga','raw',30,0,0,0);

--
-- Table structure for table 'settings_razberry'
--
DROP TABLE IF EXISTS `settings_razberry`;
CREATE TABLE `settings_razberry` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `polltime` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO `settings_razberry` VALUES (0,0,'192.168.100.5',8083,'','',2,0),(1,0,'192.168.100.5',8083,'','',2,0);

INSERT INTO interfaces VALUES (49,'GenericIO Interface','GenericIO','Read Write');
INSERT INTO interfaces VALUES (50,'MQTT Interface','MQTT','Read Write');
INSERT INTO interfaces VALUES (51,'RaZBerry Z-Wave Interface','Z-Wave','Read Write');

INSERT INTO devicetypes VALUES (301,'GenericIO Module','GenericIO Module','GenericIO','|R1=|R2=|R3=|R4=|',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (302,'MQTTitude Client','MQTTitude Client','MQTT','topic like raw/location/ron','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (303,'MQTT Generic Device','MQTT Generic','MQTT','topic like raw/sensor','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

UPDATE devicetypes SET name ='Z-Wave Door Lock', description = 'Door Lock', addressformat = '1 or 1:2' WHERE id = 242;
UPDATE devicetypes SET name ='Z-Wave Shade Controller', description = 'Shade Controller', addressformat = '1 or 1:2' WHERE id = 244;
UPDATE devicetypes SET name ='Z-Wave Thermostat', description = 'Thermostat', addressformat = '1 or 1:2' WHERE id = 243;

INSERT INTO devicetypes VALUES (304,'Z-Wave Temperature Sensor','Temperature Sensor','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (305,'Z-Wave Humidity Sensor','Humidity Sensor','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (306,'Z-Wave 4-in-1 Sensor' ,'PIR, Light, Temp and Humid','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (307,'Z-Wave Luminance Sensor','Light Sensor','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (308,'Z-Wave Power Sensor','Power Sensor','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (309,'Z-Wave Tag Reader','Tag Reader','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (310,'Z-Wave 3-in-1 Sensor','PIR, Light and Temp','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (311,'Z-Wave Siren','Alarm Siren','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (312,'Z-Wave Flood Sensor','Flood Sensor','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (313,'Z-Wave Smoke Detector','Smoke Detector','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (314,'Z-Wave Universal Binary Sensor','Binary Sensor','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (315,'Z-Wave Doorbell','Doorbell','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (316,'Z-Wave Temp and Input Sensor','Temp and Dry Input','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (317,'Z-Wave Temp and Flood Sensor','Temp and Flood Sensor','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (318,'Z-Wave Data Logger for E-Meters','Data Logger','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (319,'Z-Wave Switch Powermeter','Switch with Power Meter','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (320,'Z-Wave Smart Energy Switch','Smart Energy Switch','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (321,'Z-Wave Smart Energy Motor Control','Smart Energy Motor Control','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (322,'Z-Wave Smart Energy Dimmer','Smart Energy Dimmer','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (323,'Z-Wave Clamp Power Meter 2 CL','Power Meter 2 Clamps','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (324,'Z-Wave Clamp Power Meter 3 CL','Power Meter 3 Clamps','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (325,'Z-Wave Dual Relay Module','Dual Relay Module','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (326,'Z-Wave Single Relay Module','Single Relay Module','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (327,'Z-Wave Dual Wall Switch','Dual Wall Switch','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (328,'Z-Wave Single Wall Switch','Single Wall Switch','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (329,'Z-Wave RGB Controller','RGB Controller','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (330,'Z-Wave Temp Humid Sensor','Temp and Humid Sensor','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (331,'Z-Wave Plugin Switch','Plugin Switch','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (332,'Z-Wave Plugin Dimmer','Plugin Dimmer','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (333,'Z-Wave Door Lock','Door Lock','Z-Wave','1 or 1:2','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

--
-- Enlarge devicename field
--

ALTER TABLE `devices` MODIFY `name` varchar(64);

--
-- Add datatype column to the globalvar to be able to detect string, integer, boolean, etc
--

ALTER TABLE `globalvars` ADD COLUMN `datatype` smallint(6) NULL DEFAULT NULL AFTER `value`;

--
-- Enlarge username and password fields
--

ALTER TABLE settings_asterisk MODIFY user varchar(64);
ALTER TABLE settings_asterisk MODIFY password varchar(64);

ALTER TABLE settings_email MODIFY username varchar(64);
ALTER TABLE settings_email MODIFY password varchar(64);

ALTER TABLE settings_mqtt MODIFY username varchar(64);
ALTER TABLE settings_mqtt MODIFY password varchar(64);

ALTER TABLE settings_videoserver MODIFY user varchar(64);
ALTER TABLE settings_videoserver MODIFY password varchar(64);

ALTER TABLE settings_iviewer MODIFY password varchar(64);

ALTER TABLE users MODIFY username varchar(64);

LOCK TABLES version WRITE;
INSERT INTO version VALUES (55,'1.0.010');
UNLOCK TABLES;
