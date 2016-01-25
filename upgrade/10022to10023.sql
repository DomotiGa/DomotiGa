--
-- Delete duplicate Wirelesstags Plugin
--

DELETE FROM plugins WHERE id=93;

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
