
--
-- Modify existing Velbus modules description
--

UPDATE devicetypes SET description='4 channel relay module' WHERE id=334;
UPDATE devicetypes SET description='4 channel dimmer module' WHERE id=335;
UPDATE devicetypes SET description='7 channel input' WHERE id=336;
UPDATE devicetypes SET description='OLED touch panel' WHERE id=337;
UPDATE devicetypes SET description='Dimmer module' WHERE id=338;
UPDATE devicetypes SET description='4 channel relay module ' WHERE id=663;
UPDATE devicetypes SET description='2 channel blind module' WHERE id=664;
UPDATE devicetypes SET description='4 channel relay module' WHERE id=671;
UPDATE devicetypes SET description='8 channel pushbutton mo' WHERE id=674;

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
DELETE FROM devicetypes WHERE id=720;

INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (711, 'VMBDMI', 'dimmer for resistive or inductive load', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (712, 'VMBPIRC', 'Ceiling PIR detector module', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (713, 'VMBPIRO', 'Outdoor motion, twilight and temperature sensor', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (714, 'VMB8PBU', '8-channel push-button module', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (715, 'VMB6PBN', 'Push-button interface for 6-/4-fold niko push-buttons', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (716, 'VMBGP2', 'two touch buttons module', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (717, 'VMBGP4', 'four touch buttons module', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (718, 'VMBGPOD', 'Touch panel with Oled display', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (719, 'VMBGP1', 'one touch buttons module', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (720, 'Osram LIGHTIFY Plug','Osram LIGHTIFY Plug','PhilipsHue','\'1\', \'6\' or \'19\'');

--
-- Finally update to 1.0.024
--

DELETE FROM version WHERE db='1.0.024';

LOCK TABLES version WRITE;
INSERT INTO version VALUES (69,'1.0.024');
UNLOCK TABLES;

