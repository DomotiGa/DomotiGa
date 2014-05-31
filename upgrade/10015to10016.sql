
--
-- Add new protocols to RFXtrx interface
--
UPDATE interfaces SET type = 'X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubicson RisingSun PhilipsSBC EMW100 BBSB Blyss RollerTrol HastaNew HastaOld A-OKRF01 A-OKAC114 Meiantech ByronSX SA30 X10SecDW X10SecMotion X10SecRemote PowerCodeDW PowerCodeMotion PowerCodeAux CodeSecure Energenie Livolo RSL TRC02 MDRemote SF01 RFY RFYEXT' WHERE id=35;

INSERT INTO `devicetypes` VALUES (366,'Somfy Blind','Blind Remote','RFY','0xf12ab 1','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (367,'Somfy Blind Ext','Blind Remote Ext','RFYEXT','0xf12ab 1','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

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

