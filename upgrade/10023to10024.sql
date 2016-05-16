
--
-- Add Velbus modules
--

DELETE FROM devicetypes WHERE id=711;
DELETE FROM devicetypes WHERE id=712;

INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (711, 'VMBDMI', 'Velbus - dimmer for resistive or inductive load', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (712, 'VMBPIRC', 'Velbus - Ceiling PIR detector module', 'Velbus', '\'02\', \'05\' or \'12\'');

--
-- Finally update to 1.0.024
--

DELETE FROM version WHERE db='1.0.024';

LOCK TABLES version WRITE;
INSERT INTO version VALUES (69,'1.0.024');
UNLOCK TABLES;

