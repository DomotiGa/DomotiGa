--
-- Set control and valuetypes of value1
--

UPDATE device_values JOIN devices SET device_values.control = True WHERE devices.id = device_values.device_id AND device_values.valuenum = 1 AND devices.switchable IS True;
UPDATE device_values JOIN devices SET device_values.control = True WHERE devices.id = device_values.device_id AND device_values.valuenum = 1 AND devices.dimable IS True;
UPDATE device_values JOIN devices SET device_values.type_id = 1 WHERE devices.id = device_values.device_id AND device_values.valuenum = 1 AND devices.switchable IS True;
UPDATE device_values JOIN devices SET device_values.type_id = 20 WHERE devices.id = device_values.device_id AND device_values.valuenum = 1 AND devices.dimable IS True;


--
-- Fix 10020 to 10021 upgrade problem
--
DELETE FROM plugins WHERE id=94;
DELETE FROM plugins WHERE id=95;

INSERT INTO plugins (`id`, `interface`, `name`, `type`) VALUES (94, 'GPS', 'GPS', 'class');
INSERT INTO plugins (`id`, `interface`, `protocols`, `name`, `type`) values (95,'Buienradar','','Buienradar','class');

--
-- extend serialport field length
--

ALTER TABLE settings_arduino CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;
ALTER TABLE settings_velbus CHANGE COLUMN `serialport` `serialport` VARCHAR(128) CHARACTER SET 'utf8' NULL DEFAULT NULL;

--
-- Finally update to 1.0.023
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (68,'1.0.023');
UNLOCK TABLES;
