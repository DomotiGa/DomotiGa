
--
-- Finally update to 1.0.025
--

DELETE FROM version WHERE db='1.0.025';

LOCK TABLES version WRITE;
INSERT INTO version VALUES (70,'1.0.025');
UNLOCK TABLES;
