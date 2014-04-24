

--
-- Only use numbers above 1000, if an user adds its own devicetype. Else it can cause a conflict with new standard devices
--
--ALTER TABLE `devicetypes` AUTO_INCREMENT = 1000;

--
-- Update Boolean '1' to '-1'
--
UPDATE devices SET enabled = '-1' WHERE enabled=1;

--
-- Finally update to 1.0.016
--
LOCK TABLES version WRITE;
INSERT INTO version VALUES (61,'1.0.016');
UNLOCK TABLES;

