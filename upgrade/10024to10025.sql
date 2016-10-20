--
-- Add Lighting4 PT2262 protocol
--
UPDATE plugins SET protocols = 'X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubicson RisingSun PhilipsSBC EMW100 BBSB Blyss BlindsT0 BlindsT1 BlindsT2 BlindsT3 BlindsT4 BlindsT5 BlindsT6 BlindsT7 BlindsT8 BlindsT9 BlindsT10 Meiantech ByronSX ByronMP SA30 X10SecDW X10SecMotion X10SecRemote PowerCodeDW PowerCodeMotion PowerCodeAux CodeSecure Energenie Livolo RSL TRC02 MDRemote SF01 RFY RFYEXT Imagintrx WT TRC022 AOKE EuroDomest Smartwares SelectPlus IT Avantek PT2262' WHERE id = 35;

--
-- Add Lighting4 devicetypes
--
DELETE FROM devicetypes WHERE id=321;
DELETE FROM devicetypes WHERE id=322;

INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (321, 'PIR Sensor', 'PIR', 'PT2262', '1F5170');
INSERT INTO devicetypes (id, name, description, protocol, addressformat) VALUES (322, 'Door Window Sensor', 'Door Window Sensor', 'PT2262', '1F5170');

--
-- Finally update to 1.0.025
--

DELETE FROM version WHERE db='1.0.025';

LOCK TABLES version WRITE;
INSERT INTO version VALUES (70,'1.0.025');
UNLOCK TABLES;
