DROP TABLE IF EXISTS settings_prowl;

CREATE TABLE settings_prowl (
  id int(11) NOT NULL,
  enabled tinyint(1) DEFAULT NULL,
  apikey varchar(64) DEFAULT NULL,
  application varchar(32) DEFAULT NULL,
  event varchar(32) DEFAULT NULL,
  debug tinyint(1) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES settings_prowl WRITE;
INSERT INTO settings_prowl VALUES
(0,0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890ABC','DomotiGa','Msg',0),(1,0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890ABC','DomotiGa','Msg',0);
UNLOCK TABLES;

DROP TABLE IF EXISTS settings_nma;

CREATE TABLE settings_nma (
  id int(11) NOT NULL,
  enabled tinyint(1) DEFAULT NULL,
  apikey varchar(64) DEFAULT NULL,
  application varchar(32) DEFAULT NULL,
  event varchar(32) DEFAULT NULL,
  debug tinyint(1) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES settings_nma WRITE;
INSERT INTO settings_nma VALUES
(0,0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890ABCDEFGHIJK','DomotiGa','Msg',0),(1,0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890ABCDEFGHIJK','DomotiGa','Msg',0);
UNLOCK TABLES;

DROP TABLE IF EXISTS settings_pushover;

CREATE TABLE settings_pushover (
  id int(11) NOT NULL,
  enabled tinyint(1) DEFAULT NULL,
  token varchar(64) DEFAULT NULL,
  user varchar(64) DEFAULT NULL,
  device varchar(64) DEFAULT NULL,
  debug tinyint(1) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES settings_pushover WRITE;
INSERT INTO settings_pushover VALUES
(0,0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234','ABCDEFGHIJKLMNOPQRSTUVWXYZ1234','',0),(1,0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234','ABCDEFGHIJKLMNOPQRSTUVWXYZ1234','',0);
UNLOCK TABLES;

CREATE TABLE `scenes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `enabled` tinyint(1) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `log` tinyint(1) DEFAULT NULL,
  `firstrun` datetime DEFAULT NULL,
  `lastrun` datetime DEFAULT NULL,
  `comments` text,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

CREATE TABLE `scenes_actions` (
  `scene` bigint(20) NOT NULL,
  `action` int(11) NOT NULL,
  `order` int(11) NOT NULL,
  PRIMARY KEY (`scene`,`order`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

UPDATE interfaces SET type = "X10 X10Security" WHERE name = 'Mochad Interface';
UPDATE interfaces SET name = "RFXCom Transceiver" WHERE id = 35;

DROP TABLE IF EXISTS `settings_weatherug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_weatherug` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `apikey` varchar(128) DEFAULT NULL,
  `city` varchar(128) DEFAULT NULL,
  `polltime` int(11) DEFAULT NULL,
  `debug` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `settings_weatherug` WRITE;
/*!40000 ALTER TABLE `settings_weatherug` DISABLE KEYS */;
INSERT INTO `settings_weatherug` VALUES (0,0,'API1234567890','Dordrecht',300,0),(1,0,'API1234567890','Dordrecht',300,0);
/*!40000 ALTER TABLE `settings_weatherug` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS settings_p2000;

CREATE TABLE settings_p2000 (
  id int(11) NOT NULL,
  enabled tinyint(1) DEFAULT NULL,
  regios varchar(64) DEFAULT NULL,
  messages int(11) DEFAULT NULL,
  discipline varchar(64) DEFAULT NULL,
  filter varchar(64) DEFAULT NULL,
  georange int(11) DEFAULT NULL,
  fetchimage tinyint(1) DEFAULT NULL,
  maplink tinyint(1) DEFAULT NULL,
  polltime int(11) DEFAULT NULL,
  debug tinyint(1) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES settings_p2000 WRITE;
INSERT INTO settings_p2000 VALUES
(0,0,'18',5,'0','A1',500,0,0,300,0),(1,0,'18',5,'0','A1',500,0,0,300,0);
UNLOCK TABLES;

ALTER TABLE settings_email ADD COLUMN sslenabled tinyint(1) DEFAULT NULL AFTER smtpport;
ALTER TABLE settings_email ADD COLUMN username varchar(32) DEFAULT NULL AFTER sslenabled;
ALTER TABLE settings_email ADD COLUMN password varchar(32) DEFAULT NULL AFTER username;

LOCK TABLES version WRITE;
INSERT INTO version VALUES (52,'1.0.007');
UNLOCK TABLES;

