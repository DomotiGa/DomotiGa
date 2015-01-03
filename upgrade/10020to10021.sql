
--
-- Make plugins protocols field bigger
--

ALTER TABLE plugins CHANGE COLUMN `protocols` `protocols` VARCHAR(1024) CHARACTER SET 'utf8' NOT NULL;

--
-- Add SelectPlus Chime for RFXTrx
--

UPDATE plugins SET protocols = 'X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubicson RisingSun PhilipsSBC EMW100 BBSB Blyss RollerTrol HastaNew HastaOld A-OKRF01 A-OKAC114 Meiantech ByronSX ByronMP SA30 X10SecDW X10SecMotion X10SecRemote PowerCodeDW PowerCodeMotion PowerCodeAux CodeSecure Energenie Livolo RSL TRC02 MDRemote SF01 RFY RFYEXT Imagintrx WT TRC022 AOKE EuroDomest Smartwares SelectPlus' WHERE id = 35;

INSERT INTO devicetypes (id, name, description, protocol, addressformat) values (307,'SelectPlus Doorbell','Doorbell','SelectPlus','00F4');

--
-- Finally update to 1.0.021
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (66,'1.0.021');
UNLOCK TABLES;
