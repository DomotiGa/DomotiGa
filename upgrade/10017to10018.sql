
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
