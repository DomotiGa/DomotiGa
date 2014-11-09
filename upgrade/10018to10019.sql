
--
-- Database Engine changes 
--

ALTER TABLE macros ENGINE = MyISAM; 
ALTER TABLE temperature_profile ENGINE = MyISAM; 
ALTER TABLE thermostat ENGINE = MyISAM; 

--
-- Table structure for table `device_valuetypes`
--

DROP TABLE IF EXISTS `device_valuetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_valuetypes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(16) DEFAULT NULL,
  `units` varchar(16) DEFAULT NULL,
  `description` varchar(32) DEFAULT NULL,
  `control` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1000 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_valuetypes`
--

LOCK TABLES `device_valuetypes` WRITE;
/*!40000 ALTER TABLE `device_valuetypes` DISABLE KEYS */;
INSERT INTO `device_valuetypes` VALUES (1,'switch','','Switch On/Off',-1),(2,'temp','°C','Temperature Celsius',0),(3,'humid','%','Humidity Sensor',0),(4,'luminance','','Luminance',0),(5,'windspeed','','Wind Speed',0),(6,'winddirection','','Wind Direction',0),(7,'winddescription','','Wind Description',0),(8,'windavgspeed','','Wind Average Speed',0),(9,'weight','Kg','Weight',0),(10,'uv','','UltraViolet',0),(11,'rainrate','','Rain Rate',0),(12,'raintotal','','Rain Total',0),(13,'remote','','Remote',0),(14,'security','','Door Window Open/Closed',0),(15,'tamper','','Tamper',0),(16,'blinds','','Blinds Up/Down',-1),(17,'energykwh','KwH','Energy KwH',0),(18,'powerwatt','Watt','Power Watt',0),(19,'chime','','Chime',0),(20,'dimmer','','Dimmer 0..100',-1),(21,'setpoint','°C','Thermostat Setpoint Celsius',-1),(22,'setpointf','°F','Thermostat Setpoint Fahrenheit',-1),(23,'tempf','°C','Temperature Fahrenheit',0),(24,'dimmer_rgb','','RGB Dimmer',-1),(25,'dimmer_luminance','','Luminance Dimmer',-1),(26,'volt','V','Voltage',0),(27,'baro','','Barometric',0),(28,'current','A','Current Amp',0),(29,'gasusage','m3','Gas Usage',0),(30,'gastotal','m3','Gas Total',0),(31,'waterusage','m3','Water Usage',0),(32,'watertotal','m3','Water Total',0),(33,'pir','','PIR Motion/No Motion',0),(34,'date','','Date',0),(35,'time','','Time',0),(36,'datetime',NULL,'Date and Time',0),(37,'counter',NULL,'Counter Value',0),(38,'comfort',NULL,'Comfort Description eg \'Dry\'',0),(39,'cost','€','Cost in Euro',0),(40,'costdollar','$','Cost in Dollar',0),(41,'latitude','°','Latitude of location',0),(42,'longitude','°','Longitude of location',0),(43,'accuracy','Mtr','Accuracy of location',0);
/*!40000 ALTER TABLE `device_valuetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Finally update to 1.0.019
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (64,'1.0.019');
UNLOCK TABLES;
