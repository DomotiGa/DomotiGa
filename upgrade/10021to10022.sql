--
-- Set control and valuetypes of value1
--

UPDATE device_values JOIN devices SET device_values.control = True WHERE devices.id = device_values.device_id AND device_values.valuenum = 1 AND devices.switchable IS True;

UPDATE device_values JOIN devices SET device_values.control = True WHERE devices.id = device_values.device_id AND device_values.valuenum = 1 AND devices.dimable IS True;

UPDATE device_values JOIN devices SET device_values.type_id = 1 WHERE devices.id = device_values.device_id AND device_values.valuenum = 1 AND devices.switchable IS True;

UPDATE device_values JOIN devices SET device_values.type_id = 20 WHERE devices.id = device_values.device_id AND device_values.valuenum = 1 AND devices.dimable IS True;


--
-- Finally update to 1.0.022
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (67,'1.0.022');
UNLOCK TABLES;
