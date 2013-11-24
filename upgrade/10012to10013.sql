
--
-- Update trigger device lastseen 
--
UPDATE `triggers` SET `param2` = null, `param3` = null, `param4` = null WHERE `type` = 8;

--
-- Update settings_main table
--
UPDATE `settings_main` SET `debugplugin`=0 WHERE `debugplugin`=NULL;
UPDATE `settings_main` SET `debugglobalvar`=0 WHERE `debugglobalvar`=NULL;
UPDATE `settings_main` SET `autodevicecreate`=0 WHERE `autodevicecreate`=NULL;


--
-- Drop unused table
-- 
DROP TABLE IF EXISTS `settings_webserver`;



--
-- Finally update to 1.0.013
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (58,'1.0.013');
UNLOCK TABLES;

