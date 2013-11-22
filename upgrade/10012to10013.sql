
--
-- Update trigger device lastseen 
--
UPDATE `triggers` SET `param2` = null, `param3` = null, `param4` = null WHERE `type` = 8;


--
-- Finally update to 1.0.013
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (58,'1.0.013');
UNLOCK TABLES;

