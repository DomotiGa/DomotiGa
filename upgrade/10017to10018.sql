--
-- Correct description of some KNX devicetypes.
--

UPDATE devicetypes SET name = 'KNX DPT 5.003 Angle (0..360°)' WHERE id = 429;
UPDATE devicetypes SET name = 'KNX DPT 5.006 Tariff (0..254)' WHERE id = 432;

--
-- Delete old KNX/EIB devicetype
--

DELETE FROM devicetypes WHERE id = 56;

--
-- Rename devicetypes type field to protocol.
--

ALTER TABLE devicetypes CHANGE COLUMN type protocol varchar(32);

--
-- Remove unused default devicetypes fields, they need to be linked to devicevalues not devicetypes.
--
ALTER TABLE devicetypes DROP onicon;
ALTER TABLE devicetypes DROP dimicon;
ALTER TABLE devicetypes DROP officon;
ALTER TABLE devicetypes DROP label;
ALTER TABLE devicetypes DROP label2;
ALTER TABLE devicetypes DROP label3;
ALTER TABLE devicetypes DROP label4;
ALTER TABLE devicetypes DROP switchable;
ALTER TABLE devicetypes DROP dimable;
ALTER TABLE devicetypes DROP extcode;

--
-- Set correct charset for tv_channels to prevent import collation errors
--

DROP TABLE IF EXISTS `tv_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tv_channels` (
  `RecID` int(11) NOT NULL AUTO_INCREMENT,
  `ChannelName` varchar(50) NOT NULL,
  `ChannelID` varchar(25) NOT NULL,
  `BLOBlogo` longblob NOT NULL,
  `EXTlogo` varchar(5) NOT NULL,
  `CreationDate` char(12) NOT NULL,
  `ModificationDate` char(12) NOT NULL,
  `FK_Users` int(1) NOT NULL,
  `IsUpdated` tinyint(4) NOT NULL,
  `IsUsed` int(11) NOT NULL,
  `ChannelOrder` char(4) NOT NULL,
  PRIMARY KEY (`RecID`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Add column to users table if not already exists
--

DROP PROCEDURE IF EXISTS sp_addcolumn;
DELIMITER //
CREATE PROCEDURE sp_addcolumn()
BEGIN
  IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE column_name = 'cookie' AND table_name = 'users') THEN
    ALTER TABLE users ADD COLUMN cookie varchar(64) DEFAULT '';
  END IF;
END//

DELIMITER ;
CALL sp_addcolumn;

--
-- Rename some events column names to be more clear
--

ALTER TABLE events CHANGE COLUMN `trigger1` `trigger_id` int(11) NOT NULL DEFAULT '0';
ALTER TABLE events CHANGE COLUMN `condition1` `condition1_id` int(11) NOT NULL DEFAULT '0';
ALTER TABLE events CHANGE COLUMN `condition2` `condition2_id` int(11) NOT NULL DEFAULT '0';
ALTER TABLE events CHANGE COLUMN `category` `category_id` int(11) NOT NULL DEFAULT '0';

--
-- Add forgotten FritzBox plugin entry
--

INSERT INTO plugins VALUES (88,'FritzBox Interface','FritzBox','FritzBox','class');

--
-- Rename some devices column names to be more clear
--

ALTER TABLE devices CHANGE COLUMN `location` `location_id` int(11) NOT NULL DEFAULT '0';
ALTER TABLE devices CHANGE COLUMN `interface` `interface_id` int(11) NOT NULL DEFAULT '0';
ALTER TABLE devices CHANGE COLUMN `instance` `instance_id` int(11) NOT NULL DEFAULT '1';
ALTER TABLE devices CHANGE COLUMN `floorplan` `floorplan_id` int(11) NOT NULL DEFAULT '0';

--
-- Rename Pachube related tables to Xively
--

RENAME TABLE settings_pachube to settings_xively;
RENAME TABLE devices_pachube to devices_xively;
ALTER TABLE devices_xively DROP devicelabelshort;
UPDATE plugins SET interface = 'Xively', name = 'Xively' WHERE id = 72;

--
-- Finally update to 1.0.018
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (63,'1.0.018');
UNLOCK TABLES;
