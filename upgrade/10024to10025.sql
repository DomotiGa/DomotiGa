
--
-- Add new routine/procedure
--

DROP PROCEDURE IF EXISTS `Upgrade_DropColumnIfExist`;

DELIMITER ;;
CREATE PROCEDURE `Upgrade_DropColumnIfExist`(IN sTableName VARCHAR(100), IN sColumnName VARCHAR(100))
BEGIN

  IF EXISTS(
    SELECT * FROM information_schema.COLUMNS
    WHERE table_name = sTableName AND column_name = sColumnName
    and table_schema ='domotiga'
  ) THEN
    -- ALTER TABLE sTableName DROP COLUMN sColumnName;
    SET @DDL = CONCAT(' ALTER TABLE ', sTableName, ' DROP COLUMN ', sColumnName);
    PREPARE STMT FROM @DDL;
    EXECUTE STMT;
  END IF;
END ;;
DELIMITER ;

--
-- Increase description field, it is too short for MySQL 5.7
--
ALTER TABLE devicetypes CHANGE COLUMN `description` `description` VARCHAR(128) NULL DEFAULT NULL;

--
-- Add Lighting4 PT2262 protocol
--
UPDATE plugins SET protocols = 'X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubicson RisingSun PhilipsSBC EMW100 BBSB Blyss BlindsT0 BlindsT1 BlindsT2 BlindsT3 BlindsT4 BlindsT5 BlindsT6 BlindsT7 BlindsT8 BlindsT9 BlindsT10 Meiantech ByronSX ByronMP SA30 X10SecDW X10SecMotion X10SecRemote PowerCodeDW PowerCodeMotion PowerCodeAux CodeSecure Energenie Livolo RSL TRC02 MDRemote SF01 RFY RFYEXT Imagintrx WT TRC022 AOKE EuroDomest Smartwares SelectPlus IT Avantek PT2262' WHERE id = 35;

--
-- Add Lighting4 devicetypes
--
DELETE FROM devicetypes WHERE id=321;
DELETE FROM devicetypes WHERE id=322;
DELETE FROM devicetypes WHERE id=726;
DELETE FROM devicetypes WHERE id=727;
DELETE FROM devicetypes WHERE id=728;
DELETE FROM devicetypes WHERE id=729;
DELETE FROM devicetypes WHERE id=730;

INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (321, 'PIR Sensor', 'PIR', 'PT2262', '1F5170');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (322, 'Door Window Sensor', 'Door Window Sensor', 'PT2262', '1F5170');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (726, 'VMB1BL', 'Single channel blind control module', 'Velbus', '\'02\', \'05\' or \'12\'');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (727, 'VMB2BL', '2-channel blind control module', 'Velbus', '\'02|1\', \'02|2\' or \'12|2\' <device address|channel>');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (728, 'VMB4PD', 'Lcd command module with 8 functions', 'Velbus', '\'02|1\', \'02|2\' or \'12|2\' <device address|channel>');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (729, 'VMB6IN', '6 channel input', 'Velbus', '\'02|1\', \'02|2\' or \'12|2\' <device address|channel>');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (730, 'VMBGP4PIR','Glass control module with 4 touch buttons module and motion detection', 'Velbus', '\'02\', \'05\' or \'12\''); 
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (731, 'Etekcity','Etekcity ZAP 5LX Sockets','Energenie5','A01')

--
-- Update smart meter default settings to DSMR4 and higher
--
UPDATE settings_smartmeter SET baudrate = '115200', databits = 8, stopbits = 1, parity = 0 WHERE id = 0;

--
-- Add updateinterval column to settings_smartmeter
--
CALL Upgrade_DropColumnIfExist("settings_smartmeter", "updateinterval");
ALTER TABLE settings_smartmeter ADD COLUMN `updateinterval` INT(11) NULL DEFAULT '0'  AFTER `debug`;

--
-- Add sslenabled column to settings_mqtt
--
CALL Upgrade_DropColumnIfExist("settings_mqtt", "sslenabled");
ALTER TABLE settings_mqtt ADD COLUMN `sslenabled` TINYINT(1) NOT NULL DEFAULT '0'  AFTER `enablesubscribe`;
CALL Upgrade_DropColumnIfExist("settings_mqtt", "sslcertificate_id");
ALTER TABLE settings_mqtt ADD COLUMN `sslcertificate_id` INT(11) NOT NULL DEFAULT '0' AFTER `sslenabled`;
CALL Upgrade_DropColumnIfExist("settings_mqtt", "birthlastwill");
ALTER TABLE settings_mqtt ADD COLUMN `birthlastwill` TINYINT(1) NOT NULL DEFAULT '0'  AFTER `sslcertificate_id`;
CALL Upgrade_DropColumnIfExist("settings_mqtt", "sendallvalues");
ALTER TABLE settings_mqtt ADD COLUMN `sendallvalues` TINYINT(1) NOT NULL DEFAULT '0'  AFTER `birthlastwill`;

--
-- Add more space to subscribed topics, enough space for multiple topics if needed
--
ALTER TABLE settings_mqtt CHANGE COLUMN `subtopic` `subtopic` TEXT NULL DEFAULT NULL;

--
-- Fix the '0000-00-00 00:00:00' default value, not allowed by MySQL 5.7
--
ALTER TABLE cdr CHANGE COLUMN `calldate` `calldate` datetime DEFAULT NULL;

--
-- Finally update to 1.0.025
--

DELETE FROM version WHERE db='1.0.025';

LOCK TABLES version WRITE;
INSERT INTO version VALUES (70,'1.0.025');
UNLOCK TABLES;
