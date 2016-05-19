
--
-- Add Velbus modules
--

DELETE FROM devicetypes WHERE id=711;
DELETE FROM devicetypes WHERE id=712;
DELETE FROM devicetypes WHERE id=713;
DELETE FROM devicetypes WHERE id=714;
DELETE FROM devicetypes WHERE id=715;
DELETE FROM devicetypes WHERE id=716;
DELETE FROM devicetypes WHERE id=717;
DELETE FROM devicetypes WHERE id=718;
DELETE FROM devicetypes WHERE id=719;

INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (711, 'VMBDMI', 'Velbus - dimmer for resistive or inductive load', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (712, 'VMBPIRC', 'Velbus - Ceiling PIR detector module', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (713, 'VMBPIRO', 'Velbus - Outdoor motion, twilight and temperature sensor', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (714, 'VMB8PBU', 'Velbus - 8-channel push-button module', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (715, 'VMB6PBN', 'Velbus - Push-button interface for 6-/4-fold niko push-buttons', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (716, 'VMBGP2', 'Velbus - two touch buttons module', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (717, 'VMBGP4', 'Velbus - four touch buttons module', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (718, 'VMBGPOD', 'Velbus - Touch panel with Oled display', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (719, 'VMBGP1', 'Velbus - one touch buttons module', 'Velbus', '\'02\', \'05\' or \'12\'');

--
-- Finally update to 1.0.024
--

DELETE FROM version WHERE db='1.0.024';

LOCK TABLES version WRITE;
INSERT INTO version VALUES (69,'1.0.024');
UNLOCK TABLES;

