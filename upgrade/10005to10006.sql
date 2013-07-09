DROP TABLE IF EXISTS settings_kmtronicudp;

CREATE TABLE settings_kmtronicudp (
id int(11) NOT NULL,
enabled tinyint(1) DEFAULT NULL,
udpport int(11) DEFAULT NULL,
polltime int(11) DEFAULT NULL,
debug tinyint(1) DEFAULT NULL,
PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES settings_kmtronicudp WRITE;

INSERT INTO settings_kmtronicudp VALUES (0,0,12345,10,0),(1,0,12345,10,0);

UNLOCK TABLES;

INSERT INTO interfaces VALUES (47,'KMTronicUDP Interface','KMTronicUDP','Read Write');

INSERT INTO devicetypes VALUES (297,'Plugwise Switch','Zigbee Wall Switch','Plugwise','000D6F000021811A:01','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (298,'KMTronic DINo Input','Digital Input','KMTronicUDP','192.168.178.11:IN01-IN04','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (299,'KMTronic DINo Relay','Relais Output','KMTronicUDP','192.168.178.11:OUT01-OUT04','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

ALTER TABLE settings_ctx35 MODIFY serialport varchar(128);
ALTER TABLE settings_cul MODIFY serialport varchar(128);
ALTER TABLE settings_currentcost MODIFY serialport varchar(128);
ALTER TABLE settings_denon MODIFY serialport varchar(128);
ALTER TABLE settings_domotica MODIFY serialport varchar(128);
ALTER TABLE settings_dsc MODIFY serialport varchar(128);
ALTER TABLE settings_gps MODIFY serialport varchar(128);
ALTER TABLE settings_iport MODIFY serialport varchar(128);
ALTER TABLE settings_irman MODIFY serialport varchar(128);
ALTER TABLE settings_jeelabs MODIFY serialport varchar(128);
ALTER TABLE settings_ledmatrix MODIFY serialport varchar(128);
ALTER TABLE settings_lgtv MODIFY serialport varchar(128);
ALTER TABLE settings_nta8130 MODIFY serialport varchar(128);
ALTER TABLE settings_onkyo MODIFY serialport varchar(128);
ALTER TABLE settings_opentherm MODIFY serialport varchar(128);
ALTER TABLE settings_pioneer MODIFY serialport varchar(128);
ALTER TABLE settings_plcbus MODIFY serialport varchar(128);
ALTER TABLE settings_plugwise MODIFY serialport varchar(128);
ALTER TABLE settings_rfxcomrx MODIFY serialport varchar(128);
ALTER TABLE settings_rfxcomtrx MODIFY serialport varchar(128);
ALTER TABLE settings_rfxcomtx MODIFY serialport varchar(128);
ALTER TABLE settings_sharptv MODIFY serialport varchar(128);
ALTER TABLE settings_sms MODIFY serialport varchar(128);
ALTER TABLE settings_temp08 MODIFY serialport varchar(128);
ALTER TABLE settings_visca MODIFY serialport varchar(128);
ALTER TABLE settings_weeder MODIFY serialport varchar(128);
ALTER TABLE settings_visonic MODIFY serialport varchar(128);
ALTER TABLE settings_zwave MODIFY serialport varchar(128);

LOCK TABLES version WRITE;
INSERT INTO version VALUES (51,'1.0.006');
UNLOCK TABLES;

