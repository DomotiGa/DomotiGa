
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
-- Add Energenie5 protocol
--
UPDATE plugins SET protocols = 'X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubicson RisingSun PhilipsSBC EMW100 BBSB Blyss BlindsT0 BlindsT1 BlindsT2 BlindsT3 BlindsT4 BlindsT5 BlindsT6 BlindsT7 BlindsT8 BlindsT9 BlindsT10 Meiantech ByronSX ByronMP SA30 X10SecDW X10SecMotion X10SecRemote PowerCodeDW PowerCodeMotion PowerCodeAux CodeSecure Energenie Livolo RSL TRC02 MDRemote SF01 RFY RFYEXT Imagintrx WT TRC022 AOKE EuroDomest Smartwares SelectPlus IT Avantek PT2262 Energenie5' WHERE id = 35;

--
-- Add Devices
--
DELETE FROM devicetypes WHERE id=731;

INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (731, 'Etekcity','Etekcity ZAP 5LX Sockets','Energenie5','A01');

-- Add new field to devices for multi value dim devices
CALL Upgrade_DropColumnIfExist("devices", "multivaluedim");
ALTER TABLE devices ADD multivaluedim tinyint(1) DEFAULT 0 NOT NULL AFTER dimable;

--
-- Table structure for table `favorites`
--
DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favorites` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `objectid` bigint(20) unsigned NOT NULL,
  `objecttype` bigint(20) unsigned NOT NULL,
  `displayorder` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

ALTER TABLE `favorites` ADD INDEX `displayorder` (displayorder);

--
-- Finally update to 1.0.026
--

DELETE FROM version WHERE db='1.0.026';

LOCK TABLES version WRITE;
INSERT INTO version VALUES (71,'1.0.026');
UNLOCK TABLES;
