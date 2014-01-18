
--
-- Downgrade from InnoDB to MyISAM
--
ALTER TABLE device_values ENGINE=MyISAM;
ALTER TABLE device_values_log ENGINE=MyISAM;

--
-- Finally update to 1.0.015
--
LOCK TABLES version WRITE;
INSERT INTO version VALUES (60,'1.0.015');
UNLOCK TABLES;

