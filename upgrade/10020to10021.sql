--
-- Update Somfy RFY address format from '0xf12ab 1' to 'F12AB 1'
--

UPDATE devicetypes SET addressformat = 'F12AB 1' WHERE protocol LIKE 'RFY%';

--
-- Make plugins protocols field bigger
--

ALTER TABLE plugins CHANGE COLUMN `protocols` `protocols` VARCHAR(1024) CHARACTER SET 'utf8' NOT NULL;

--
-- Add SelectPlus Chime for RFXTrx
--

UPDATE plugins SET protocols = 'X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubicson RisingSun PhilipsSBC EMW100 BBSB Blyss RollerTrol HastaNew HastaOld A-OKRF01 A-OKAC114 Meiantech ByronSX ByronMP SA30 X10SecDW X10SecMotion X10SecRemote PowerCodeDW PowerCodeMotion PowerCodeAux CodeSecure Energenie Livolo RSL TRC02 MDRemote SF01 RFY RFYEXT Imagintrx WT TRC022 AOKE EuroDomest Smartwares SelectPlus' WHERE id = 35;

INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (307,'SelectPlus Doorbell','Doorbell','SelectPlus','00F4');

--
-- Fix OWW plugin and devicetype
--

UPDATE plugins SET interface = 'OWW Gateway' WHERE id = 70;
UPDATE plugins SET protocols = 'OWW' WHERE id = 70;

INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (320,'OWW Station','OWW Station','OWW','Station');

--
-- Update Z-Wave addressformat examples
--

UPDATE devicetypes SET `addressformat`='1 or 1:2' WHERE `id`='61' AND `addressformat`='1';
UPDATE devicetypes SET `addressformat`='1 or 1:2' WHERE `id`='62' AND `addressformat`='3';
UPDATE devicetypes SET `addressformat`='1 or 1:2' WHERE `id`='63' AND `addressformat`='1';
UPDATE devicetypes SET `addressformat`='1 or 1:2' WHERE `id`='64' AND `addressformat`='2';

--
-- Standardize RaZberry name
--

UPDATE plugins SET `interface`='RaZberry Z-Wave Interface', `name`='RaZberry' WHERE `name`='RaZberry';

--
-- Network interface field
--

ALTER TABLE settings_networkdetect ADD COLUMN interface varchar(16) CHARACTER SET 'utf8' DEFAULT 'eth0' AFTER timeout;

--
-- Add missing GPS plugin
--

INSERT INTO plugins (`id`, `interface`, `name`, `type`) VALUES (94, 'GPS', 'GPS', 'class');

--
-- Add column to settings-main
--

ALTER TABLE settings_main ADD COLUMN logallvalueupdates tinyint(1) NOT NULL DEFAULT '0' AFTER autodevicecreate;

--
-- Set control and valuetypes of value1
--

UPDATE device_values JOIN devices SET device_values.control = True WHERE devices.id = device_values.device_id AND device_values.valuenum = 1 AND devices.switchable IS True;

UPDATE device_values JOIN devices SET device_values.control = True WHERE devices.id = device_values.device_id AND device_values.valuenum = 1 AND devices.dimable IS True;

UPDATE device_values JOIN devices SET device_values.type_id = 1 WHERE devices.id = device_values.device_id AND device_values.valuenum = 1 AND devices.switchable IS True;

UPDATE device_values JOIN devices SET device_values.type_id = 20 WHERE devices.id = device_values.device_id AND device_values.valuenum = 1 AND devices.dimable IS True;


--
-- Finally update to 1.0.021
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (66,'1.0.021');
UNLOCK TABLES;
