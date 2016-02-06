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
-- Extend serialport field length
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
-- Update Visonic settings
--

ALTER TABLE settings_visonic ADD COLUMN `downloadcode` VARCHAR(16) NULL DEFAULT '5650'  AFTER `mastercode`;

--
-- Update Visonic device addresses
--

UPDATE devicetypes SET `addressformat`='Z01' WHERE `id`='289';
UPDATE devicetypes SET `addressformat`='Z01' WHERE `id`='291';
UPDATE devicetypes SET `addressformat`='Z01' WHERE `id`='293';

--
-- Extend plugin protocol field lenght
--
ALTER TABLE plugins CHANGE COLUMN `protocols` `protocols` VARCHAR(1024) CHARACTER SET 'utf8' NOT NULL;

--
-- Add Blinds1 support to rfxcom tranceiver plugin
--
UPDATE plugins SET protocols = 'X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubicson RisingSun PhilipsSBC EMW100 BBSB Blyss BlindsT0 BlindsT1 BlindsT2 BlindsT3 BlindsT4 BlindsT5 BlindsT6 BlindsT7 BlindsT8 BlindsT9 BlindsT10 Meiantech ByronSX ByronMP SA30 X10SecDW X10SecMotion X10SecRemote PowerCodeDW PowerCodeMotion PowerCodeAux CodeSecure Energenie Livolo RSL TRC02 MDRemote SF01 RFY RFYEXT Imagintrx WT TRC022 AOKE EuroDomest Smartwares SelectPlus' WHERE id = 35;

--
-- Finally update to 1.0.023
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (68,'1.0.023');
UNLOCK TABLES;
