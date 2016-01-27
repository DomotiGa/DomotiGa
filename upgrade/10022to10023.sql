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
-- Add Velbus VMB8PB module
--
LOCK TABLES `devicetypes` WRITE;
/*!40000 ALTER TABLE `devicetypes` DISABLE KEYS */;
INSERT INTO `devicetypes` VALUES (674,'VMB8PB','Velbus - 8 channel pushbutton module','Velbus','13|1');
/*!40000 ALTER TABLE `devicetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Finally update to 1.0.023
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (68,'1.0.023');
UNLOCK TABLES;
