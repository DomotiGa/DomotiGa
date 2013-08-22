
--
-- Fix thermostats
--

ALTER TABLE thermostat_schedule_entry ADD COLUMN secondary tinyint(1) DEFAULT NULL AFTER constant;
ALTER TABLE thermostat_heating ADD COLUMN secondary tinyint(1) DEFAULT NULL AFTER regulatorOffsetBottom;

--
-- Remove GLatitude settings
--

DROP TABLE IF EXISTS `settings_glatitude`;

DELETE FROM devices WHERE interface = 28;

DELETE FROM `devicetypes` WHERE `id`='141';

DELETE FROM `interfaces` WHERE `id`='28';

--
-- Update the default settings to be in sync with the initial settings
--

UPDATE `settings_asterisk` SET `tcphost`='192.168.100.2', `password`='password' WHERE `id`='0';

UPDATE `settings_bluetooth` SET `threshold`=-20, `polltime`=300 WHERE `id`='0';

UPDATE `settings_domotica` SET `serialport`='/dev/ttyUSB4' WHERE `id`='0';

UPDATE `settings_dsc` SET `debug`=0 WHERE `id`='0';

UPDATE `settings_eib` SET `debug`=0 WHERE `id`='0';

UPDATE `settings_email` SET `fromaddress`='domotiga@yourdomain.nl', `toaddress`='ron@yourdomain.nl', `smtpserver`='smtp.yourprovider.nl' WHERE `id`='0';

UPDATE `settings_fritzbox` SET `debug`=0 WHERE `id`='0';

UPDATE `settings_gmail` SET `user`='user@gmail.com', `password`='test', `polltime`=60, `debug`=0 WHERE `id`='0';

UPDATE `settings_hddtemp` SET `polltime`=300, `threshold`=40 WHERE `id`='0';

UPDATE `settings_homematic` SET `debug`=0 WHERE `id`='0';

UPDATE `settings_iport` SET `tcphost`='192.168.1.68', `tcpport`=500, `type`='serial', `serialport`='/dev/ttyUSBD0' WHERE `id`='0';

UPDATE `settings_iviewer` SET `tcpport`=5000 WHERE `id`='0';

UPDATE `settings_k8055` SET `debug`=0 WHERE `id`='0';

UPDATE `settings_ledmatrix` SET `serialport`='/dev/ttyUSB9', `color`=3, `speed`=3, `displayid`=1 WHERE `id`='0';

UPDATE `settings_lgtv` SET `tcphost`='192.168.1.68', `tcpport`=500, `type`='serial', `serialport`='/dev/ttyUSBD0', `baudrate`='4800' WHERE `id`='0';

UPDATE `settings_main` SET `flushtime`=10000, `startpage`='FLogfiles', `homebottompanel`='Main log' WHERE `id`='0';

UPDATE `settings_main` SET `flushtime`=10000, `startpage`='FLogfiles', `homebottompanel`='Main log' WHERE `id`='0';

UPDATE `settings_mochad` SET `tcphost`='192.168.1.23', `tcpport`=1099 WHERE `id`='0';

UPDATE `settings_ncid` SET `tcphost`='192.168.200.15' WHERE `id`='0';

UPDATE `settings_nta8130` SET `serialport`='/dev/ttyUSB5' WHERE `id`='0';

UPDATE `settings_onkyo` SET `type`='serial', `serialport`='/dev/ttyUSBD0' WHERE `id`='0';

UPDATE `settings_opentherm` SET `temperatureoverride`='Temporarily', `type`='serial' WHERE `id`='0';

UPDATE `settings_owfs` SET `basedir`='/tmp/1wire', `cached`=-1 WHERE `id`='0';

UPDATE `settings_oww` SET `tcpport`=8888, `debug`=0 WHERE `id`='0';

UPDATE `settings_pachube` SET `feed`=3711, `pushtime`=10 WHERE `id`='0';

UPDATE `settings_ping` SET `polltime`=300 WHERE `id`='0';

UPDATE `settings_plcbus` SET `serialport`='/dev/ttyUSB4', `housecodes`='A,B' WHERE `id`='0';

UPDATE `settings_plugwise` SET `enabled`=0, `debug`=0 WHERE `id`='0';

UPDATE `settings_pwrctrl` SET `userpw`='user1user' WHERE `id`='0';

UPDATE `settings_rfxcomrx` SET `type`='serial', `serialport`='/dev/ttyUSB0', `relayenabled`=-1 WHERE `id`='0';

UPDATE `settings_rfxcomtrx` SET `type`='serial', `relayenabled`=-1 WHERE `id`='0';

UPDATE `settings_rfxcomtx` SET `serialport`='/dev/ttyUSBD8', `disablex10`=0 WHERE `id`='0';

UPDATE `settings_rfxcomxpl` SET `rxaddress`='rfxcom-lan.0004a31543ac', `txaddress`='rfxcom-lan.0004a31543ac' WHERE `id`='0';

UPDATE `settings_serverstats` SET `servername`='DomotiGa Server' WHERE `id`='0';

UPDATE `settings_sharptv` SET `tcphost`='192.168.1.68', `tcpport`=500, `serialport`='/dev/ttyUSBD0', `baudrate`='4800' WHERE `id`='0';

UPDATE `settings_sms` SET `serialport`='/dev/ttyUSB0', `servicecentre`='+31613131314' WHERE `id`='0';

UPDATE `settings_temperaturnu` SET `city`='City' WHERE `id`='0';

UPDATE `settings_ups` SET `tcphost`='192.168.100.2', `polltime`=300 WHERE `id`='0';

UPDATE `settings_voicetext` SET `prefixcmd`='/usr/bin/padsp', `voicesmale`='', `voicesfemale`='linda,emily' WHERE `id`='0';

UPDATE `settings_weeder` SET `debug`=0 WHERE `id`='0';

UPDATE `settings_xmlrpc` SET `enabled`=-1, `maxconn`=10, `broadcastudp`=-1 WHERE `id`='0';

UPDATE `settings_zwave` SET `serialport`='/dev/ttyUSB3' WHERE `id`='0';

--
-- Finally update to 1.0.008
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (53,'1.0.008');
UNLOCK TABLES;

