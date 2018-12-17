
--
-- Add Devices
--
DELETE FROM devicetypes WHERE id=731;

INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (731, 'Etekcity','Etekcity ZAP 5LX Sockets','Energenie5','A01')

--
-- Finally update to 1.0.026
--

DELETE FROM version WHERE db='1.0.026';

LOCK TABLES version WRITE;
INSERT INTO version VALUES (70,'1.0.026');
UNLOCK TABLES;
