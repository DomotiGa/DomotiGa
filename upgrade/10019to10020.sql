ALTER TABLE settings_rrdtool ADD COLUMN width int(11) NOT NULL DEFAULT '785' AFTER debug;
ALTER TABLE settings_rrdtool ADD COLUMN height int(11) NOT NULL DEFAULT '120' AFTER width;

--
-- Finally update to 1.0.020
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (65,'1.0.020');
UNLOCK TABLES;
