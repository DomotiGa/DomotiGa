--
-- Update GlobalVar system variables with the "right" datatype
--

UPDATE `globalvars` SET `datatype`=9 WHERE `var`='Program_Start';
UPDATE `globalvars` SET `datatype`=4 WHERE `var`='Second';
UPDATE `globalvars` SET `datatype`=4 WHERE `var`='Minute';
UPDATE `globalvars` SET `datatype`=9 WHERE `var`='Program_Uptime';
UPDATE `globalvars` SET `datatype`=4 WHERE `var`='Hour';
UPDATE `globalvars` SET `datatype`=4 WHERE `var`='Day';
UPDATE `globalvars` SET `datatype`=4 WHERE `var`='Month';
UPDATE `globalvars` SET `datatype`=4 WHERE `var`='Weekday';
UPDATE `globalvars` SET `datatype`=9 WHERE `var`='Time_Of_Day';
UPDATE `globalvars` SET `datatype`=4 WHERE `var`='Year';
UPDATE `globalvars` SET `datatype`=9 WHERE `var`='Sunrise';
UPDATE `globalvars` SET `datatype`=9 WHERE `var`='Sunrise_Twilight';
UPDATE `globalvars` SET `datatype`=9 WHERE `var`='Sunset';
UPDATE `globalvars` SET `datatype`=9 WHERE `var`='Sunset_Twilight';
UPDATE `globalvars` SET `datatype`=9 WHERE `var`='Season';
UPDATE `globalvars` SET `datatype`=9 WHERE `var`='Tagline';
UPDATE `globalvars` SET `datatype`=1 WHERE `var`='Weekend';
UPDATE `globalvars` SET `datatype`=1 WHERE `var`='Dark';
UPDATE `globalvars` SET `datatype`=9 WHERE `var`='House_Mode';
UPDATE `globalvars` SET `datatype`=1 WHERE `var`='Mute';


--
-- Update mqtt default topic 
--
UPDATE `settings_mqtt` SET `subtopic`='raw/#' WHERE `id`='0';


--
-- Add location id to scenes
--
ALTER TABLE `scenes` ADD `location_id` int(11);


--
-- Table structure for table `settings_jsonrpc`
--

DROP TABLE IF EXISTS `settings_jsonrpc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_jsonrpc` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `httpport` int(11) DEFAULT NULL,
  `maxconn` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `auth` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_jsonrpc`
--

LOCK TABLES `settings_jsonrpc` WRITE;
/*!40000 ALTER TABLE `settings_jsonrpc` DISABLE KEYS */;
INSERT INTO `settings_jsonrpc` VALUES (0,-1,9090,10,0,0,0),(1,-1,9090,10,0,0,0);
/*!40000 ALTER TABLE `settings_jsonrpc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Finally update to 1.0.012
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (57,'1.0.012');
UNLOCK TABLES;

