
--
-- Finally update to 1.0.022
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (67,'1.0.022');
UNLOCK TABLES;

--
-- Add VMB4RYLD for Velbus
--
INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (671,'VMB4RYLD','Velbus - 4 Channel relay module','Velbus','13|2');
