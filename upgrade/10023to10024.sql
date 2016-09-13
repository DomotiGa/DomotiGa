--
-- Extend devicetypes description field length
--

ALTER TABLE devicetypes CHANGE COLUMN 'description' 'description' VARCHAR(64) NULL DEFAULT NULL;

--
-- Set new Buienradar url
--

UPDATE settings_buienradar SET urlbuienradar = 'http://gadgets.buienradar.nl/data/raintext' WHERE id = 0;
UPDATE settings_buienradar SET urlbuienradar = 'http://gadgets.buienradar.nl/data/raintext' WHERE id = 1;

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
UPDATE devicetypes SET description='8 channel pushbutton module' WHERE id=674;

--
-- Add new devicetypes
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
DELETE FROM devicetypes WHERE id=721;
DELETE FROM devicetypes WHERE id=722;
DELETE FROM devicetypes WHERE id=723;
DELETE FROM devicetypes WHERE id=724;
DELETE FROM devicetypes WHERE id=725;

INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (711, 'VMBDMI', 'Dimmer for resistive or inductive load', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (712, 'VMBPIRC', 'Ceiling PIR detector module', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (713, 'VMBPIRO', 'Outdoor motion, twilight and temperature sensor', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (714, 'VMB8PBU', '8-channel push-button module', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (715, 'VMB6PBN', 'Push-button interface for 6-/4-fold niko push-buttons', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (716, 'VMBGP2', 'Two touch buttons module', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (717, 'VMBGP4', 'Four touch buttons module', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (718, 'VMBGPOD', 'Touch panel with OLED display', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (719, 'VMBGP1', 'One touch buttons module', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (720, 'Osram LIGHTIFY Plug','Osram LIGHTIFY Plug','PhilipsHue','\'1\', \'6\' or \'19\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (721, 'ProMax 75006','ProMax 75006 switch and remote','IT','\'00101c 13\', or \'0x00101c 13\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (722, 'Read Holding Register 64-bit Unsigned', '03 64-bit', 'Modbus', '1F:5170');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (723, 'Read Holding Register 64-bit Unsigned Correction 0.1', '03 64-bit Unsigned, Correction 0.1', 'Modbus', '1F:5170');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (724, 'Read Holding Register 64-bit Unsigned Correction 0.01', '03 64-bit Unsigned, Correction 0.01', 'Modbus', '1F:5170');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (725, 'Read Holding Register 64-bit Unsigned Correction 0.001', '03 64-bit Unsigned, Correction 0.001', 'Modbus', '1F:5170');

--
-- Redo plugin column again, it was missed out in 'domotiga.sql' of 1.0.023
--

ALTER TABLE plugins CHANGE COLUMN 'protocols' 'protocols' VARCHAR(1024) CHARACTER SET 'utf8' NOT NULL;

--
-- Set the RFXComTRX protocols, to fix the 512/1024 issue and add new protocols
--

UPDATE plugins SET protocols = 'X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubicson RisingSun PhilipsSBC EMW100 BBSB Blyss BlindsT0 BlindsT1 BlindsT2 BlindsT3 BlindsT4 BlindsT5 BlindsT6 BlindsT7 BlindsT8 BlindsT9 BlindsT10 Meiantech ByronSX ByronMP SA30 X10SecDW X10SecMotion X10SecRemote PowerCodeDW PowerCodeMotion PowerCodeAux CodeSecure Energenie Livolo RSL TRC02 MDRemote SF01 RFY RFYEXT Imagintrx WT TRC022 AOKE EuroDomest Smartwares SelectPlus IT Avantek' WHERE id = 35;

--
-- Add TFA - Two-Factor-Authentication options
-- feature https://www.domotiga.nl/issues/603 review password and users login
--

ALTER TABLE users ADD 'tfasecret' VARCHAR(16) NULL;
ALTER TABLE users ADD 'tfaenabled' TINYINT(1) NOT NULL DEFAULT '0';

--
-- Add TCP support for the jeelabs module
--

ALTER TABLE settings_jeelabs ADD COLUMN tcphost VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_jeelabs ADD COLUMN tcpport int(11) DEFAULT NULL;
ALTER TABLE settings_jeelabs ADD COLUMN type VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;

--
-- Insert the new default values into settings_jeelabs
--

UPDATE 'settings_jeelabs' SET type='serial', tcphost='192.168.1.1', port=5000;

--
-- Drop 'type' from visonic settings
--

ALTER TABLE settings_visonic DROP type;

--
-- Add TCP support for the visonic module
--

ALTER TABLE settings_visonic ADD COLUMN tcphost VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_visonic ADD COLUMN tcpport int(11) DEFAULT NULL;
ALTER TABLE settings_visonic ADD COLUMN type VARCHAR(32) CHARACTER SET 'utf8' NULL DEFAULT NULL;

--
-- Insert the new default values into settings_visonic
--

UPDATE 'settings_visonic' SET type='serial', tcphost='192.168.1.1', port=5000;

--
-- Update rtu to RTU for modbus RTU/ASCII support
--

UPDATE 'settings_modbus' SET modbustype='RTU' WHERE modbustype='rtu';

--
-- Finally update to 1.0.024
--

DELETE FROM version WHERE db='1.0.024';

LOCK TABLES version WRITE;
INSERT INTO version VALUES (69,'1.0.024');
UNLOCK TABLES;

