
--
-- Update the default settings to be in sync with the initial settings
--

UPDATE `settings_k8055` SET `enabled`=0 WHERE `id`='0';

UPDATE `settings_plugwise` SET `enabled`=0 WHERE `id`='0';

UPDATE `settings_plcbus` SET `ack`=0 WHERE `ack`=NULL;

--
-- Add device_values table
--

DROP TABLE IF EXISTS `device_values`;

CREATE TABLE `device_values` (
`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
`deviceid` bigint(20) unsigned NOT NULL,
`valuenum` bigint(20) unsigned NOT NULL,
`value` text,
`correction` text,
`units` varchar(32) DEFAULT NULL,
`lastseen` datetime DEFAULT NULL,
`log` tinyint(1) DEFAULT NULL,
`rrd` tinyint(1) DEFAULT NULL,
`graph` tinyint(1) DEFAULT NULL,
`valuerrddsname` varchar(32) DEFAULT NULL,
`valuerrdtype` varchar(32) DEFAULT NULL,
`switchable` tinyint(1) DEFAULT NULL,
`dimable` tinyint(1) DEFAULT NULL,
`lastchanged` datetime DEFAULT NULL,
INDEX deviceindex (deviceid),
FOREIGN KEY (deviceid) REFERENCES devices(id)
ON DELETE CASCADE
ON UPDATE CASCADE,
PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO device_values (deviceid, value, correction, units,
lastseen, log, rrd, graph, valuerrddsname, valuerrdtype, switchable,
dimable, lastchanged, valuenum)
select id, value, correction, label, lastseen, log, rrd, graph,
valuerrddsname, valuerrdtype, switchable, dimable, lastchanged, 1 from
devices;

INSERT INTO device_values (deviceid, value, correction, units,
lastseen, log, rrd, graph, valuerrddsname, valuerrdtype, switchable,
dimable, lastchanged, valuenum)
select id, value2, correction2, label2, lastseen, log, rrd, graph,
value2rrddsname, value2rrdtype, switchable, dimable, lastchanged, 2
from devices;

INSERT INTO device_values (deviceid, value, correction, units,
lastseen, log, rrd, graph, valuerrddsname, valuerrdtype, switchable,
dimable, lastchanged, valuenum)
select id, value3, correction3, label3, lastseen, log, rrd, graph,
value3rrddsname, value3rrdtype, switchable, dimable, lastchanged, 3
from devices;

INSERT INTO device_values (deviceid, value, correction, units,
lastseen, log, rrd, graph, valuerrddsname, valuerrdtype, switchable,
dimable, lastchanged, valuenum)
select id, value4, correction4, label4, lastseen, log, rrd, graph,
value4rrddsname, value4rrdtype, switchable, dimable, lastchanged, 4
from devices;


--
-- Finally update to 1.0.011
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (56,'1.0.011');
UNLOCK TABLES;

