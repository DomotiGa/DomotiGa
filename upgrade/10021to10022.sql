--
-- Add VMB4RYLD for Velbus
--
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (671,'VMB4RYLD','Velbus - 4 Channel relay module','Velbus','13|2');

INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (672,'Visonic PowerMax','PowerMax Panel','Visonic','Panel');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (673,'Visonic PowerMaster','PowerMaster Panel','Visonic','Panel');

--
-- Modify settings_jsonrpc
--
ALTER TABLE settings_jsonrpc DROP COLUMN `sslcertificate` , DROP COLUMN `httpsenabled` , DROP COLUMN `httpenabled` , DROP COLUMN `httpsport`;
ALTER TABLE settings_jsonrpc ADD COLUMN `sslenabled` TINYINT(1) NOT NULL DEFAULT '0'  AFTER `debug` ;

--
-- Finally update to 1.0.022
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (67,'1.0.022');
UNLOCK TABLES;
