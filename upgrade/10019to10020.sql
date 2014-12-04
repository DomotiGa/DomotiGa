--
-- IPX800 
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
  `pool` int(11) DEFAULT NULL,
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `settings_ipx800` WRITE;
/*!40000 ALTER TABLE `settings_ipx800` DISABLE KEYS */;
INSERT INTO `settings_ipx800` VALUES (0,0,'192.168.100.7',9870,'','',0,-1),(1,0,'10.20.99.134',9870,'','',0,-1)
/*!40000 ALTER TABLE `settings_ipx800` ENABLE KEYS */;
UNLOCK TABLES;

insert into plugins (id, interface, protocols, name, type) values (89, 'Ipx800 Interface', 'Ipx800', 'Ipx800', 'class');

insert into devicetypes (id, name, description, protocol, addressformat) values (316, 'Ipx800 Output', 'Ipx800 Output', 'Ipx800', 'Output|01');
insert into devicetypes (id, name, description, protocol, addressformat) values (317, 'Ipx800 Input', 'Ipx800 Input', 'Ipx800', 'Input|01');
insert into devicetypes (id, name, description, protocol, addressformat) values (318, 'Ipx800 Analogic', 'Ipx800 Analogic Input', 'Ipx800', 'Analogic|01');
insert into devicetypes (id, name, description, protocol, addressformat) values (319, 'Ipx800 Count', 'Ipx800 Count', 'Ipx800', 'Count|01');


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
-- Finally update to 1.0.020
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (65,'1.0.020');
UNLOCK TABLES;
