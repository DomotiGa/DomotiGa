DROP TABLE IF EXISTS settings_visonic;

CREATE TABLE settings_visonic (
id int(11) NOT NULL,
enabled tinyint(1) DEFAULT NULL,
serialport varchar(32) DEFAULT NULL,
type int(11) DEFAULT '0',
mastercode varchar(16) DEFAULT '1234',
debug tinyint(1) DEFAULT NULL,
PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES settings_visonic WRITE;

INSERT INTO settings_visonic VALUES (0,0,'/dev/ttyUSB0',0,'1234',0),(1,0,'/dev/ttyUSB6',0,'1234',0);

UNLOCK TABLES;

INSERT INTO interfaces VALUES (46,'Visonic Interface','Visonic','Read Write');

INSERT INTO devicetypes VALUES (287,'Visonic Keypad','keypad','Visonic','XXXXXXXXX','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (288,'Visonic Keyfob','Keyfob','Visonic','XXXXXXXXX','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (289,'Visonic PIR','Motion detector','Visonic','XXXXXXXXX','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (290,'Visonic Shock Detector','Shock detector','Visonic','XXXXXXXXX','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (291,'Visonic Door/Window Contact','Door/Window sensor','Visonic','XXXXXXXXX','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (292,'Visonic Universal transmitter','Universal transmitter','Visonic','XXXXXXXXX','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (293,'Visonic Smoke detector','Smoke detector','Visonic','XXXXXXXXX','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (294,'Visonic Gas detector','Gas detector','Visonic','XXXXXXXXX','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (295,'Visonic Flood detector','Flood detector','Visonic','XXXXXXXXX','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (296,'Visonic Temperature detector','Temperature detector','Visonic','XXXXXXXXX','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

LOCK TABLES version WRITE;
INSERT INTO version VALUES (50,'1.0.005');
UNLOCK TABLES;
