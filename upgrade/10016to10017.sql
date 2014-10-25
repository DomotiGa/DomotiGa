--
-- Introduce much higher auto_increment value for devicetypes, renumber manually created ones, if any.
--

ALTER TABLE devicetypes AUTO_INCREMENT=2500;
UPDATE devicetypes SET id = id+2000 WHERE id >= 500 AND id <2500;
UPDATE devices SET module = module+2000 WHERE module >= 500 AND module <2500;

--
-- Rename device_values type field
--

ALTER TABLE device_values CHANGE COLUMN `type` `type_id` int(11) NOT NULL DEFAULT '0';

--
-- Correct name of old MQTTitude client
--

UPDATE devicetypes SET name = 'MQTT Owntracks Client', description = 'MQTT Owntracks Client' WHERE id = 302;

--
-- Delete old KNX device types
--

DELETE FROM devicetypes WHERE id = 46;
DELETE FROM devicetypes WHERE id = 45;
DELETE FROM devicetypes WHERE id = 47;
DELETE FROM devicetypes WHERE id = 48;
DELETE FROM devicetypes WHERE id = 49;
DELETE FROM devicetypes WHERE id = 50;
DELETE FROM devicetypes WHERE id = 51;
DELETE FROM devicetypes WHERE id = 52;
DELETE FROM devicetypes WHERE id = 53;
DELETE FROM devicetypes WHERE id = 54;
DELETE FROM devicetypes WHERE id = 55;
DELETE FROM devicetypes WHERE id = 57;
DELETE FROM devicetypes WHERE id = 378;
DELETE FROM devicetypes WHERE id = 379;

--
-- Insert KNX device type replacements
--

INSERT INTO `devicetypes` VALUES (46,'KNX DPT 1.001 Switch','DPT 1.001','KNX','0/1/2[|1/2/3]','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (45,'KNX Dimming Actuator Basic','KNX Device Dimmer','KNX','0/1/2|0/1/3|0/1/4[|0/1/5]','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (51,'KNX Sunblind Actuator Basic','KNX Device Blinds','KNX','0/1/2|0/1/3[|0/1/5]','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (378,'KNX DPT 15.000 Access Data','DPT 15.000','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (379,'KNX DPT 4.001 Character (ASCII)','DPT 4.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (57,'KNX DPT 16.000 Character String (ASCII)','DPT 16.000','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (49,'KNX DPT 10.001 Time of Day','DPT 10.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (48,'KNX DPT 11.001 Date','DPT 11.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (47,'KNX DPT 9.xxx 2-Byte Floating Point','DPT 9.xxx','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (52,'KNX DPT 2.xxx 1-Bit Priority','DPT 2.xxx','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (53,'KNX DPT 14.xxx 4-Byte Floating Point','DPT 14.xxx','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (54,'KNX DPT 7.xxx 16-Bit Unsigned (0..65535)','DPT 7.xxx','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (55,'KNX DPT 12.001 Counter (Pulses)','DPT 12.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (50,'KNX DPT 5.xxx Relative Value (0..100%)','DPT 5.xxx','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);

--
-- Add all other defined KNX datapoints from Datapoint Standard v1.07.00 AS
--

INSERT INTO `devicetypes` VALUES (391,'KNX DPT 1.002 Boolean','DPT 1.002','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (392,'KNX DPT 1.003 Enable','DPT 1.003','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (393,'KNX DPT 1.004 Ramp','DPT 1.004','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (394,'KNX DPT 1.005 Alarm','DPT 1.005','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (395,'KNX DPT 1.006 BinaryValue','DPT 1.006','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (396,'KNX DPT 1.007 Step','DPT 1.007','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (397,'KNX DPT 1.008 Up/Down','DPT 1.008','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (398,'KNX DPT 1.009 Open/Close','DPT 1.009','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (399,'KNX DPT 1.010 Start/Stop','DPT 1.010','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (400,'KNX DPT 1.011 State','DPT 1.011','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (401,'KNX DPT 1.012 Invert','DPT 1.012','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (402,'KNX DPT 1.013 Dim Set Style','DPT 1.013','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (403,'KNX DPT 1.014 Input Source','DPT 1.014','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (404,'KNX DPT 1.015 Reset','DPT 1.015','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (405,'KNX DPT 1.016 Acknowledge','DPT 1.016','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (406,'KNX DPT 1.017 Trigger','DPT 1.017','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (407,'KNX DPT 1.018 Occupancy','DPT 1.018','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (408,'KNX DPT 1.019 Window/Door','DPT 1.019','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (409,'KNX DPT 1.021 Logical Function','DPT 1.021','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (410,'KNX DPT 1.022 Scene AB','DPT 1.022','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (411,'KNX DPT 1.023 Shutter/Blinds Mode','DPT 1.023','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (412,'KNX DPT 1.100 Heat/Cool','DPT 1.100','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (413,'KNX DPT 2.001 Switch Priority','DPT 2.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (414,'KNX DPT 2.002 Bool Priority','DPT 2.002','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (415,'KNX DPT 2.003 Enable Priority','DPT 2.003','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (416,'KNX DPT 2.004 Ramp Priority','DPT 2.004','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (417,'KNX DPT 2.005 Alarm Priority','DPT 2.005','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (418,'KNX DPT 2.006 BinaryValue Priority','DPT 2.006','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (419,'KNX DPT 2.007 Step Priority','DPT 2.007','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (420,'KNX DPT 2.008 Direction1 Priority','DPT 2.008','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (421,'KNX DPT 2.009 Direction2 Priority','DPT 2.009','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (422,'KNX DPT 2.010 Start Priority','DPT 2.010','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (423,'KNX DPT 2.011 State Priority','DPT 2.011','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (424,'KNX DPT 2.012 Invert Priority','DPT 2.012','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (425,'KNX DPT 3.007 Control Dimming','DPT 3.007','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (426,'KNX DPT 3.008 Control Blinds','DPT 3.008','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (427,'KNX DPT 4.002 Character (ISO 8859-1)','DPT 4.002','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (428,'KNX DPT 5.001 Percentage (0..100%)','DPT 5.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (429,'KNX DPT 5.003 Angle (Degrees)','DPT 5.002','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (430,'KNX DPT 5.004 Percentage (0..255%)','DPT 5.004','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (431,'KNX DPT 5.005 Ratio (0..255)','DPT 5.005','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (432,'KNX DPT 5.006 Tariff (0..255)','DPT 5.006','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (433,'KNX DPT 5.010 Counter Pulses (0..255)','DPT 5.010','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (434,'KNX DPT 6.001 Percentage (-128..127%)','DPT 6.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (435,'KNX DPT 6.010 Counter Pulses (-128..127)','DPT 6.003','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (436,'KNX DPT 6.020 Status with Mode','DPT 6.004','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (437,'KNX DPT 7.001 Pulses (0..100%)','DPT 7.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (438,'KNX DPT 7.002 Time (mS)','DPT 7.002','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (439,'KNX DPT 7.003 Time (10 mS)','DPT 7.003','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (440,'KNX DPT 7.004 Time (100 mS)','DPT 7.004','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (441,'KNX DPT 7.005 Time (Sec)','DPT 7.005','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (442,'KNX DPT 7.006 Time (Min)','DPT 7.006','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (443,'KNX DPT 7.007 Time (Hour)','DPT 7.007','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (444,'KNX DPT 7.010 Property Data Type','DPT 7.010','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (445,'KNX DPT 7.011 Length (mm)','DPT 7.011','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (446,'KNX DPT 7.012 Current (mA)','DPT 7.012','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (448,'KNX DPT 7.013 Brightness (lux)','DPT 7.013','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (449,'KNX DPT 8.001 Pulse Difference','DPT 8.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (450,'KNX DPT 8.002 Time Lag (mS)','DPT 8.002','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (451,'KNX DPT 8.003 Time Lag (10 mS)','DPT 8.003','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (452,'KNX DPT 8.004 Time Lag (100 mS)','DPT 8.004','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (453,'KNX DPT 8.005 Time Lag (Sec)','DPT 8.005','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (454,'KNX DPT 8.006 Time Lag (Min)','DPT 8.006','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (455,'KNX DPT 8.007 Time Lag (Hour)','DPT 8.007','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (456,'KNX DPT 8.010 Percentage Diff. (%)','DPT 8.010','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (457,'KNX DPT 8.011 Rotation Angle (°)','DPT 8.011','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (458,'KNX DPT 9.001 Temperatue (°C)','DPT 9.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (459,'KNX DPT 9.002 Temperature Diff. (K)','DPT 9.002','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (460,'KNX DPT 9.003 Kelvin/Hour (K/h)','DPT 9.003','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (461,'KNX DPT 9.004 Lux (Lux','DPT 9.004','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (462,'KNX DPT 9.005 Speed (Mtr/Sec)','DPT 9.005','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (463,'KNX DPT 9.006 Pressure (Pa)','DPT 9.006','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (464,'KNX DPT 9.007 Percentage (%)','DPT 9.007','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (465,'KNX DPT 9.008 Air Quality (ppm)','DPT 9.008','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (466,'KNX DPT 9.010 Time (Sec)','DPT 9.010','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (467,'KNX DPT 9.011 Time (mS)','DPT 9.011','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (468,'KNX DPT 9.020 Voltage (mV)','DPT 9.020','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (469,'KNX DPT 9.021 Current (mA)','DPT 9.021','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (470,'KNX DPT 9.022 Power Density (W/m²)','DPT 9.022','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (471,'KNX DPT 9.023 Kelvin/Percent (K/%)','DPT 9.023','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (472,'KNX DPT 9.024 Power (kW)','DPT 9.024','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (473,'KNX DPT 9.025 Volume Flow (l/h)','DPT 9.025','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (474,'KNX DPT 9.026 Rain Amount (l/m²)','DPT 9.026','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (475,'KNX DPT 9.027 Temperature (°F)','DPT 9.027','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (476,'KNX DPT 9.028 Wind Speed (km/h)','DPT 9.028','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (477,'KNX DPT 13.001 Counter (Pulses)','DPT 13.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (478,'KNX DPT 13.002 Flow Rate (m³/h)','DPT 13.002','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (479,'KNX DPT 13.010 Active Energy (Wh)','DPT 13.010','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (480,'KNX DPT 13.011 Apparant Energy (VAh)','DPT 13.011','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (481,'KNX DPT 13.012 Reactive Energy (VARh)','DPT 13.012','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (482,'KNX DPT 13.013 Active Energy (kWh)','DPT 13.013','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (483,'KNX DPT 13.014 Apparant Energy (kVAh)','DPT 13.014','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (484,'KNX DPT 13.015 Reactive Energy (kVARh)','DPT 13.015','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (485,'KNX DPT 13.100 Time Lag (Sec)','DPT 13.020','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (486,'KNX DPT 14.000 Acceleration (m/s²)','DPT 14.000','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (487,'KNX DPT 14.001 Angular Acceleration (rad/s²)','DPT 14.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (488,'KNX DPT 14.002 Activation Energy (J/mol)','DPT 14.002','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (489,'KNX DPT 14.003 Radioactive Energy (1/s','DPT 14.003','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (490,'KNX DPT 14.004 Amount of Substance (mol)','DPT 14.004','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (491,'KNX DPT 14.005 Amplitude','DPT 14.005','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (492,'KNX DPT 14.006 Angle (radiant)','DPT 14.006','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (493,'KNX DPT 14.007 Angle (degree)','DPT 14.007','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (494,'KNX DPT 14.008 Angular Momentum (Js)','DPT 14.008','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (495,'KNX DPT 14.009 Angular Velocity (rad/s)','DPT 14.009','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (496,'KNX DPT 14.010 Area (m*m)','DPT 14.010','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (497,'KNX DPT 14.011 Capacitance (F)','DPT 14.011','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (498,'KNX DPT 14.012 Flux Density (C/m²)','DPT 14.012','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (499,'KNX DPT 14.013 Charge Density (C/m³)','DPT 14.013','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (500,'KNX DPT 14.014 Compressibility (m²/N)','DPT 14.014','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (501,'KNX DPT 14.015 Conductance (l/h)','DPT 14.015','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (502,'KNX DPT 14.016 Conductivity (S/m)','DPT 14.016','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (503,'KNX DPT 14.017 Density (kg/m³)','DPT 14.017','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (504,'KNX DPT 14.018 Electric Charge (C)','DPT 14.018','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (505,'KNX DPT 14.019 Electric Current(A)','DPT 14.019','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (506,'KNX DPT 14.020 Electric Current Density (A/m²)','DPT 14.020','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (507,'KNX DPT 14.021 Electric Dipole Moment (Cm)','DPT 14.021','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (508,'KNX DPT 14.022 Electric Displacement (C/m²)','DPT 14.022','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (509,'KNX DPT 14.023 Electric Field Strenght (V/m)','DPT 14.023','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (510,'KNX DPT 14.024 Electric Flux (C)','DPT 14.024','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (511,'KNX DPT 14.025 Electric Flux Density','DPT 14.025','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (512,'KNX DPT 14.026 Electric Polarization (C/m²)','DPT 14.026','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (513,'KNX DPT 14.027 Electric Potential (V)','DPT 14.027','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (514,'KNX DPT 14.028 Electric Potential  Diff. (V)','DPT 14.028','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (515,'KNX DPT 14.029 Electromagnetic Moment (Am²)','DPT 14.029','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (516,'KNX DPT 14.030 Electromotive Force (V)','DPT 14.030','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (517,'KNX DPT 14.031 Energy (J)','DPT 14.031','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (518,'KNX DPT 14.032 Force (N)','DPT 14.032','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (519,'KNX DPT 14.033 Frequency (Hz)','DPT 14.033','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (520,'KNX DPT 14.034 Angular Frequency (rad/s)','DPT 14.034','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (521,'KNX DPT 14.035 Heat Capacity (J/K)','DPT 14.035','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (522,'KNX DPT 14.036 Heat Flow Rate (W)','DPT 14.036','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (523,'KNX DPT 14.037 Heat Quantity','DPT 14.037','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (524,'KNX DPT 14.038 Impedance (Ohm)','DPT 14.038','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (525,'KNX DPT 14.039 Length (m)','DPT 14.039','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (526,'KNX DPT 14.040 Light Quantity (J)','DPT 14.040','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (527,'KNX DPT 14.041 Luminance (cd/m²)','DPT 14.041','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (528,'KNX DPT 14.042 Luminous Flux (lm)','DPT 14.042','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (529,'KNX DPT 14.043 Luminous Intensity (cd)','DPT 14.043','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (530,'KNX DPT 14.044 Magnetic Field Strength (A/m)','DPT 14.044','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (531,'KNX DPT 14.045 Magnetic Flux (lm)','DPT 14.045','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (532,'KNX DPT 14.046 Magnetic Flux Density (T)','DPT 14.046','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (533,'KNX DPT 14.047 Magnetic Moment (Am²)','DPT 14.047','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (534,'KNX DPT 14.048 Magnetic Polarisation (T)','DPT 14.048','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (535,'KNX DPT 14.049 Magnetisation (A/m)','DPT 14.049','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (536,'KNX DPT 14.050 Magnetomotive Force (A)','DPT 14.050','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (537,'KNX DPT 14.051 Mass (Kg)','DPT 14.051','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (538,'KNX DPT 14.052 Mass Flux (Kg/s)','DPT 14.052','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (539,'KNX DPT 14.053 Momentum (N/s)','DPT 14.053','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (540,'KNX DPT 14.054 Phase Angle (rad)','DPT 14.054','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (541,'KNX DPT 14.055 Phase Angle (°)','DPT 14.055','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (542,'KNX DPT 14.056 Power (W)','DPT 14.056','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (543,'KNX DPT 14.057 Power Factor (Cos Phi)','DPT 14.057','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (544,'KNX DPT 14.058 Pressure (Pa)','DPT 14.058','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (545,'KNX DPT 14.059 Reactance (Ohm)','DPT 14.059','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (546,'KNX DPT 14.060 Resistance (Ohm)','DPT 14.060','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (547,'KNX DPT 14.061 Resistivity (Ohmm)','DPT 14.061','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (548,'KNX DPT 14.062 Self Inductance (H)','DPT 14.062','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (549,'KNX DPT 14.063 Solid Angle (sr)','DPT 14.063','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (550,'KNX DPT 14.064 Sound Intensity (W/m²)','DPT 14.064','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (551,'KNX DPT 14.065 Speed (m/s)','DPT 14.065','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (552,'KNX DPT 14.066 Stress (Pa)','DPT 14.066','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (553,'KNX DPT 14.067 Surface Tension (N/m)','DPT 14.067','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (554,'KNX DPT 14.068 Temperature (°C)','DPT 14.068','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (555,'KNX DPT 14.069 Temperature Absolute (°C)','DPT 14.069','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (556,'KNX DPT 14.070 Temperature Diff. (K)','DPT 14.070','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (557,'KNX DPT 14.071 Thermal Capacity (J/K)','DPT 14.071','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (558,'KNX DPT 14.072 Thermal Conductivity (W/mK)','DPT 14.072','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (559,'KNX DPT 14.073 Thermoelectric Power (V/K)','DPT 14.073','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (560,'KNX DPT 14.074 Time (Sec)','DPT 14.074','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (561,'KNX DPT 14.075 Torque (Nm)','DPT 14.075','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (562,'KNX DPT 14.076 Volume (m³)','DPT 14.076','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (563,'KNX DPT 14.077 Volume Flux (m³/s)','DPT 14.077','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (564,'KNX DPT 14.078 Weight (N)','DPT 14.078','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (565,'KNX DPT 14.079 Work (J)','DPT 14.079','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (566,'KNX DPT 16.001 Character String (ISO 8859-1)','DPT 16.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (567,'KNX DPT 17.001 Scene Number','DPT 17.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (568,'KNX DPT 18.001 Scene Control','DPT 18.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (569,'KNX DPT 19.001 Date and Time','DPT 19.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (570,'KNX DPT 20.001 SCLO Mode','DPT 20.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (571,'KNX DPT 20.002 Building Mode','DPT 20.002','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (572,'KNX DPT 20.003 Occupy Mode','DPT 20.003','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (573,'KNX DPT 20.004 Priority','DPT 20.004','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (574,'KNX DPT 20.005 Light Appl. Mode','DPT 20.005','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (575,'KNX DPT 20.006 Application Area','DPT 20.006','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (576,'KNX DPT 20.007 Alarm Class Type','DPT 20.007','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (577,'KNX DPT 20.008 PSU Mode','DPT 20.008','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (578,'KNX DPT 20.011 System Error Class','DPT 20.011','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (579,'KNX DPT 20.012 HVAC Error Class','DPT 20.012','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (580,'KNX DPT 20.013 Time Delay','DPT 20.013','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (581,'KNX DPT 20.014 Wind Force Scale (0..12)','DPT 20.014','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (582,'KNX DPT 20.017 Sensor Mode','DPT 20.017','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (583,'KNX DPT 20.020 Actuactor Connect Type','DPT 20.020','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (584,'KNX DPT 20.100 Fuel Type','DPT 20.100','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (585,'KNX DPT 20.101 Burner Type','DPT 20.101','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (586,'KNX DPT 20.102 HVAC Mode','DPT 20.102','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (587,'KNX DPT 20.103 DHW Mode','DPT 20.103','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (588,'KNX DPT 20.104 Load Priority','DPT 20.104','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (589,'KNX DPT 20.105 HVAC Control Mode','DPT 20.105','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (590,'KNX DPT 20.106 HVAC Emergency Mode','DPT 20.106','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (591,'KNX DPT 20.107 Changeover Mode','DPT 20.107','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (592,'KNX DPT 20.108 Valve Mode','DPT 20.108','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (593,'KNX DPT 20.109 Damper Mode','DPT 20.109','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (594,'KNX DPT 20.110 Heater Mode','DPT 20.110','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (595,'KNX DPT 20.111 Fan Mode','DPT 20.111','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (596,'KNX DPT 20.112 Master/Slave Mode','DPT 20.112','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (597,'KNX DPT 20.113 Status Room Setpoint','DPT 20.113','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (598,'KNX DPT 20.120 ADA Type','DPT 20.120','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (599,'KNX DPT 20.121 Backup Mode','DPT 20.121','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (600,'KNX DPT 20.122 Start Synchronization','DPT 20.122','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (601,'KNX DPT 20.600 Behavior Lock/Unlock','DPT 20.600','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (602,'KNX DPT 20.601 Behavior Bus Power Up/Down','DPT 20.601','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (603,'KNX DPT 20.602 DALI Fade Time','DPT 20.602','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (604,'KNX DPT 20.603 Blinking Mode','DPT 20.603','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (605,'KNX DPT 20.604 Light Control Mode','DPT 20.604','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (606,'KNX DPT 20.605 Switch PB Model','DPT 20.605','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (607,'KNX DPT 20.606 Switch PB Action','DPT 20.606','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (608,'KNX DPT 20.607 Dim PB Model','DPT 20.607','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (609,'KNX DPT 20.608 Switch On Mode','DPT 20.608','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (610,'KNX DPT 20.609 Load Type Set','DPT 20.609','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (611,'KNX DPT 20.610 Load Type Detection','DPT 20.610','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (612,'KNX DPT 20.801 SAB Except Behavior','DPT 20.801','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (613,'KNX DPT 20.802 SAB Behavior Lock/Unlock','DPT 20.802','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (614,'KNX DPT 20.803 SSSB Mode','DPT 20.803','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (615,'KNX DPT 20.804 Blinds Control Mode','DPT 20.804','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (616,'KNX DPT 20.1000 Communication Mode','DPT 20.1000','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (617,'KNX DPT 20.1001 Additional Info Types','DPT 20.1001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (618,'KNX DPT 20.1002 RF Mode Select','DPT 20.1002','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (619,'KNX DPT 20.1003 RF Filter Select','DPT 20.1003','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (620,'KNX DPT 21.001 General Status','DPT 21.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (621,'KNX DPT 21.002 Device Control','DPT 21.002','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (622,'KNX DPT 21.100 Forcing Signal','DPT 21.100','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (623,'KNX DPT 21.101 Forcing Signal Cool','DPT 21.101','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (624,'KNX DPT 21.102 Room Heating Cntrl. Status','DPT 21.102','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (625,'KNX DPT 21.103 Solar DHW Cntrl. Status','DPT 21.103','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (626,'KNX DPT 21.104 Fuel Type Set','DPT 21.104','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (627,'KNX DPT 21.105 Room Cooling Cntrl. Status','DPT 21.105','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (628,'KNX DPT 21.106 Ventilation Cntrl. Status','DPT 21.106','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (629,'KNX DPT 21.601 Lighting Actuator Error Info','DPT 21.601','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (630,'KNX DPT 21.1000 RF Communication Mode Info','DPT 21.1000','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (631,'KNX DPT 21.1001 RF Filter Mode Info','DPT 21.1001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (632,'KNX DPT 21.1010 Channel Activation 8','DPT 21.1010','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (633,'KNX DPT 22.100 DHW Controller Status','DPT 22.100','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (634,'KNX DPT 22.101 RHCC Status','DPT 22.101','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (635,'KNX DPT 22.1000 Media','DPT 22.1000','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (636,'KNX DPT 22.1010 Channel Activation 16','DPT 22.1010','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (637,'KNX DPT 23.001 On/Off Action','DPT 23.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (638,'KNX DPT 23.002 Alarm Reaction','DPT 23.002','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (639,'KNX DPT 23.003 Up/Down Action','DPT 23.003','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (640,'KNX DPT 23.102 HVAC Push Button Action','DPT 23.102','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (641,'KNX DPT 25.1000 Busy/Nack Repetitions','DPT 25.1000','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (642,'KNX DPT 26.001 Scene Information','DPT 26.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (643,'KNX DPT 27.001 Bit-Combined Info On/Off','DPT 27.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (644,'KNX DPT 29.010 Active Energy (Wh)','DPT 29.010','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (645,'KNX DPT 29.011 Apparant Energy (VAh)','DPT 29.011','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (646,'KNX DPT 29.012 Reactive Energy (VARh)','DPT 29.012','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (647,'KNX DPT 30.1010 Channel Activation 24','DPT 30.1010','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (648,'KNX DPT 217.001 DPT Version','DPT 217.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (649,'KNX DPT 219.001 Alarm Info','DPT 219.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (650,'KNX DPT 222.100 Room Temp. Setpoint','DPT 222.100','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (651,'KNX DPT 222.101 Room Temp. Setpoint Shift','DPT 222.101','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (652,'KNX DPT 229.001 Metering Value (Val,Enco,Cmd)','DPT 229.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (653,'KNX DPT 230.1000 MBus Address','DPT 230.1000','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (654,'KNX DPT 232.600 Colour RGB 3x(0..255)','DPT 232.600','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (655,'KNX DPT 234.001 Language Code (ASCII)','DPT 234.001','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (656,'KNX DPT 237.600 DALI Control Gear Diag.','DPT 237.600','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (657,'KNX DPT 238.600 DALI Diagnostics','DPT 238.600','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (658,'KNX DPT 240.800 Combined Position','DPT 240.800','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (659,'KNX DPT 241.800 Status SAB','DPT 241.800','KNX','0/1/2','','','',-1,-1,0,0,0,0,0);

--
-- Add fields to device_values
--

ALTER TABLE device_values ADD COLUMN feedback tinyint(1) NOT NULL DEFAULT '0' AFTER type_id;
ALTER TABLE device_values ADD COLUMN control tinyint(1) NOT NULL DEFAULT '0' AFTER feedback;

--
-- Alter field length for Xively channel
--

ALTER TABLE devices_pachube MODIFY datastreamid varchar(64);

--
-- Dumping data for table interfaces
--

LOCK TABLES interfaces WRITE;
/*!40000 ALTER TABLE interfaces DISABLE KEYS */;
INSERT INTO interfaces VALUES  (58,'Philips Hue Interface','PhilipsHue','Read Write');
INSERT INTO interfaces VALUES  (59,'WiringPi Interface','WiringPi','Read Write');
/*!40000 ALTER TABLE interfaces ENABLE KEYS */;
UNLOCK TABLES;

--
-- Convert interfaces table for dynamic setdevice via plugin call
--

RENAME TABLE interfaces to plugins;
ALTER TABLE plugins CHANGE COLUMN name interface varchar(32);
ALTER TABLE plugins CHANGE COLUMN mode name varchar(32) NOT NULL;
ALTER TABLE plugins CHANGE COLUMN type protocols varchar(512) NOT NULL;
ALTER TABLE plugins ADD COLUMN type varchar(32) NOT NULL DEFAULT 'class' AFTER name;
UPDATE plugins SET name = 'RFXComRX' WHERE id=1;
UPDATE plugins SET name = 'CTX35' WHERE id=2;
UPDATE plugins SET name = 'Temp08' WHERE id=3;
UPDATE plugins SET name = 'HDDTemp' WHERE id=4;
UPDATE plugins SET name = 'Ping' WHERE id=5;
UPDATE plugins SET name = 'UPS' WHERE id=6;
UPDATE plugins SET name = 'X10Cmd' WHERE id=7;
UPDATE plugins SET name = 'Bluetooth' WHERE id=8;
UPDATE plugins SET name = 'Weeder' WHERE id=9;
UPDATE plugins SET name = 'Plugwise' WHERE id=10;
UPDATE plugins SET name = 'DSC' WHERE id=11;
UPDATE plugins SET name = 'RFXComTX' WHERE id=12;
UPDATE plugins SET name = 'KNX' WHERE id=13;
UPDATE plugins SET name = 'Digitemp' WHERE id=14;
UPDATE plugins SET name = 'OpenZwave' WHERE id=15;
UPDATE plugins SET name = 'PLCBUS' WHERE id=16;
UPDATE plugins SET name = 'Virtual' WHERE id=17;
UPDATE plugins SET name = 'SqueezeServer' WHERE id=18;
UPDATE plugins SET name = 'CurrentCost' WHERE id=19;
UPDATE plugins SET name = 'EZcontrol' WHERE id=20;
UPDATE plugins SET name = 'LIRC' WHERE id=21;
UPDATE plugins SET name = 'PwrCtrl' WHERE id=22;
UPDATE plugins SET name = 'Denon' WHERE id=23;
UPDATE plugins SET name = 'Onkyo' WHERE id=24;
UPDATE plugins SET name = 'SharpTV' WHERE id=25;
UPDATE plugins SET name = 'LGTV' WHERE id=26;
UPDATE plugins SET name = 'IPort' WHERE id=27;
UPDATE plugins SET name = 'JeeLabs' WHERE id=29;
UPDATE plugins SET name = 'K8055' WHERE id=30;
UPDATE plugins SET name = 'OWFS' WHERE id=31;
UPDATE plugins SET name = 'CUL' WHERE id=32;
UPDATE plugins SET name = 'RFXComxPL' WHERE id=33;
UPDATE plugins SET name = 'Shell' WHERE id=34;
UPDATE plugins SET name = 'RFXComTRX' WHERE id=35;
UPDATE plugins SET name = 'HomeMatic' WHERE id=36;
UPDATE plugins SET name = 'OpenTherm' WHERE id=37;
UPDATE plugins SET name = 'SmartMeter' WHERE id=38;
UPDATE plugins SET name = 'Pioneer' WHERE id=39;
UPDATE plugins SET name = 'XBMCxPL' WHERE id=40;
UPDATE plugins SET name = 'Meteohub' WHERE id=41;
UPDATE plugins SET name = 'ELVMAX' WHERE id=42;
UPDATE plugins SET name = 'YouLess' WHERE id=43;
UPDATE plugins SET name = 'Mochad' WHERE id=44;
UPDATE plugins SET name = 'Omniksol' WHERE id=45;
UPDATE plugins SET name = 'Visonic' WHERE id=46;
UPDATE plugins SET name = 'KMTronicUDP' WHERE id=47;
UPDATE plugins SET name = 'DMXPlayer' WHERE id=48;
UPDATE plugins SET name = 'GenericIO' WHERE id=49;
UPDATE plugins SET name = 'MQTT' WHERE id=50;
UPDATE plugins SET name = 'RazBerry' WHERE id=51;
UPDATE plugins SET name = 'Arduino' WHERE id=52;
UPDATE plugins SET name = 'Velbus' WHERE id=53;
UPDATE plugins SET name = 'Viera' WHERE id=54;
UPDATE plugins SET name = 'Toon' WHERE id=55;
UPDATE plugins SET name = 'Jerome' WHERE id=56;
UPDATE plugins SET name = 'Wirelesstags' WHERE id=57;
UPDATE plugins SET name = 'PhilipsHue' WHERE id=58;
UPDATE plugins SET name = 'WiringPi' WHERE id=59;
INSERT INTO plugins VALUES (60,'Asterisk','','Asterisk','class');
INSERT INTO plugins VALUES (61,'BwiredMap','','BwiredMap','class');
INSERT INTO plugins VALUES (62,'DeviceDiscover','','DeviceDiscover','class');
INSERT INTO plugins VALUES (63,'GMail','','GMail','class');
INSERT INTO plugins VALUES (64,'IRMan','','IRMan','class');
INSERT INTO plugins VALUES (65,'IRTrans','','IRTrans','class');
INSERT INTO plugins VALUES (66,'IViewer','','IViewer','class');
INSERT INTO plugins VALUES (67,'JSONRPC','','JSONRPC','class');
INSERT INTO plugins VALUES (68,'Ncid','','Ncid','class');
INSERT INTO plugins VALUES (69,'NMA','','NMA','class');
INSERT INTO plugins VALUES (70,'OWW','','OWW','class');
INSERT INTO plugins VALUES (71,'P2000','','P2000','class');
INSERT INTO plugins VALUES (72,'Pachube','','Pachube','class');
INSERT INTO plugins VALUES (73,'Prowl','','Prowl','class');
INSERT INTO plugins VALUES (74,'PVoutput','','PVoutput','class');
INSERT INTO plugins VALUES (75,'Pushover','','Pushover','class');
INSERT INTO plugins VALUES (76,'Pushbullet','','Pushbullet','class');
INSERT INTO plugins VALUES (77,'SmartVISUServer','','SmartVISUServer','class');
INSERT INTO plugins VALUES (78,'SMS','','SMS','class');
INSERT INTO plugins VALUES (79,'TelnetServer','','TelnetServer','class');
INSERT INTO plugins VALUES (80,'TemperaturNu','','TemperaturNu','class');
INSERT INTO plugins VALUES (81,'Twitter','','Twitter','class');
INSERT INTO plugins VALUES (82,'VISCA','','VISCA','class');
INSERT INTO plugins VALUES (83,'WeatherUnderground','','WeatherUnderground','class');
INSERT INTO plugins VALUES (84,'OpenWeatherMap','','OpenWeatherMap','class');
INSERT INTO plugins VALUES (85,'ForecastIo','','ForecastIo','class');
INSERT INTO plugins VALUES (86,'TVGuide','','TVGuide','class');
INSERT INTO plugins VALUES (87,'MySensors Interface','MySensors','MySensors','class');

UPDATE plugins SET type = 'virtual' WHERE id=17;
UPDATE plugins SET type = 'module' WHERE id=40;
UPDATE plugins SET type = 'module' WHERE id=45;
UPDATE plugins SET type = 'module' WHERE id=34;
UPDATE plugins SET type = 'module' WHERE id=33;
UPDATE plugins SET type = 'module' WHERE id=52;

--
-- Add missing KD101 protocol to RFXComTRX interface
--

UPDATE plugins SET protocols = 'X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubicson RisingSun PhilipsSBC EMW100 BBSB Blyss RollerTrol HastaNew HastaOld A-OKRF01 A-OKAC114 Meiantech ByronSX ByronMP SA30 X10SecDW X10SecMotion X10SecRemote PowerCodeDW PowerCodeMotion PowerCodeAux CodeSecure Energenie Livolo RSL TRC02 MDRemote SF01 RFY RFYEXT Imagintrx WT TRC022 AOKE Eurodomest KD101' WHERE id = 35;

--
-- Rename KNX/EIB plugin/protocol to KNX
--

UPDATE plugins SET protocols = 'KNX' WHERE id=13;
UPDATE plugins SET interface = 'KNX Interface' WHERE id=13;

--
-- Rename KNX settings table
--

RENAME TABLE settings_eib TO settings_knx;

--
-- Added temp10, temp11, th12 sensor and more for RFXComTRX
--

INSERT INTO `devicetypes` VALUES (380,'TFA Dostmann Temp Sensor','Temp Sensor','TFA','temp10 0x121','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (381,'Imagintronix Soil Sensor','Soil Sensor','Imagintrx','th12 0x1','','','',-1,-1,0,0,0,0,0);
UPDATE plugins SET protocols = 'X10 X10Security Oregon KAKU RFXCom AC HEUK ATI Digimax Mertik Ninja Flamingo Waveman HEEU ARC HE105 Koppla RTS10 Harrison Anslut Impuls AB400 EMW200 LightwaveRF TFA LaCrosse UPM Cresta Viking Rubicson RisingSun PhilipsSBC EMW100 BBSB Blyss RollerTrol HastaNew HastaOld A-OKRF01 A-OKAC114 Meiantech ByronSX ByronMP SA30 X10SecDW X10SecMotion X10SecRemote PowerCodeDW PowerCodeMotion PowerCodeAux CodeSecure Energenie Livolo RSL TRC02 MDRemote SF01 RFY RFYEXT Imagintrx WT TRC022 AOKE EuroDomest' WHERE id = 35;
INSERT INTO devicetypes VALUES (386,'Byron MP Doorbell','Doorbell','ByronMP','00F4','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (387,'WT Swimming Pool Temp Sensor','Temp Sensor','WT','temp11 0x112','','','',-1,-1,0,0,0,0,0);
INSERT INTO devicetypes VALUES (388,'RGB Module','Applicance Module','TRC022','010203 or 0x010203','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (389,'Aoke Relay','Relay Module','Aoke','010203 or 0x010203','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (390,'Eurodomest Module','Appliance Module','Eurodomest','010203 or 0x010203','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO devicetypes VALUES (315,'MySensors Node','Generic MySensors Node','MySensors','<node-id>','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
--
-- Remove structure for settings_domotica
--

DROP TABLE IF EXISTS settings_domotica;

--
-- Table structure for settings_wiringpi
--

DROP TABLE IF EXISTS settings_wiringpi;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE settings_wiringpi (
  id int(11) NOT NULL,
  enabled tinyint(1) NOT NULL DEFAULT '0',
  polltime int(11) NOT NULL DEFAULT '10',
  debug tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings_wiringpi`
--

/*!40101 SET character_set_client = @saved_cs_client */;
LOCK TABLES settings_wiringpi WRITE;
/*!40000 ALTER TABLE `settings_wiringpi` DISABLE KEYS */;
INSERT INTO settings_wiringpi VALUES
(0,0,10,0),(1,0,10,0);
/*!40000 ALTER TABLE `settings_wiringpi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for settings_pushbullet
--

DROP TABLE IF EXISTS settings_pushbullet;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE settings_pushbullet (
  id int(11) NOT NULL,
  enabled tinyint(1) NOT NULL DEFAULT '0',
  token varchar(64) DEFAULT NULL,
  device varchar(64) DEFAULT NULL,
  debug tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings_pushbullet`
--

/*!40101 SET character_set_client = @saved_cs_client */;
LOCK TABLES settings_pushbullet WRITE;
/*!40000 ALTER TABLE `settings_pushbullet` DISABLE KEYS */;
INSERT INTO settings_pushbullet VALUES
(0,0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234','',0),(1,0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234','',0);
/*!40000 ALTER TABLE `settings_pushbullet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_weatherbug`
--

DROP TABLE IF EXISTS `settings_weatherbug`;

--
-- Remove OpenZWave devices table (not used anymore)
--

DROP TABLE IF EXISTS devices_zwave;

--
-- Remove Weather table, info stored in virtualdevice
--

DROP TABLE IF EXISTS weather;

--
-- Table structure for table `settings_devicediscover`
--

DROP TABLE IF EXISTS `settings_devicediscover`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_devicediscover` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `multicasthost` varchar(32) DEFAULT NULL,
  `multicastport` int(11) NOT NULL DEFAULT '0',
  `listenonly` tinyint(1) NOT NULL DEFAULT '0',
  `broadcastinterval` int(11) NOT NULL DEFAULT '0',
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings_devicediscover`
--

/*!40101 SET character_set_client = @saved_cs_client */;
LOCK TABLES `settings_devicediscover` WRITE;
/*!40000 ALTER TABLE `settings_devicediscover` DISABLE KEYS */;
INSERT INTO `settings_devicediscover` VALUES (0,0,'239.255.255.250',1900,0,60,0),(1,0,'239.255.255.250',1900,0,60,0);
/*!40000 ALTER TABLE `settings_devicediscover` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_philipshue`
--

DROP TABLE IF EXISTS `settings_philipshue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_philipshue` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `username` varchar(44) DEFAULT NULL,
  `polltime` int(11) NOT NULL DEFAULT '10',
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings_philipshue`
--

/*!40101 SET character_set_client = @saved_cs_client */;
LOCK TABLES `settings_philipshue` WRITE;
/*!40000 ALTER TABLE `settings_philipshue` DISABLE KEYS */;
INSERT INTO `settings_philipshue` VALUES (0,0,null,10,0),(1,0,null,10,0);
/*!40000 ALTER TABLE `settings_philipshue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert new devicetypes
--

INSERT INTO `devicetypes` VALUES (373,'Philips Hue Light','Light','PhilipsHue','1','','','',0,-1,0,NULL,NULL,NULL,NULL);

--
-- Insert new WiringPi devicetypes
--

INSERT INTO `devicetypes` VALUES (374,'RaspberryPi I/O','RaspberryPi I/O','WiringPi','<pin>','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (375,'WiringPi I/O','WiringPi I/O','WiringPi','<wiringpi>:<baseaddr>:<i2caddr>|<pin>','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (376,'WiringPi I/O Inverted','WiringPi I/O Inverted','WiringPi','<wiringpi>:<baseaddr>:<i2caddr>|<pin>','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (377,'RaspberryPi I/O Inverted','RaspberryPi I/O Inverted','WiringPi','<pin>','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (382,'WiringPi ADC','WiringPi ADC','WiringPi','<wiringpi>:<baseaddr>:<i2caddr>|<pin>','','','',-1,-1,0,0,0,0,0);
INSERT INTO `devicetypes` VALUES (383,'WiringPi DAC','WiringPi DAC','WiringPi','<wiringpi>:<baseaddr>:<i2caddr>|<pin>','','','',-1,-1,0,0,0,0,0);

--
-- Insert new Toon devicetypes
--

INSERT INTO `devicetypes` VALUES (384,'Toon Stekker','Wall Plug','Toon','<DevUuid>','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (385,'Toon All On/Off Stekkers','All On/Off Wall Plugs','Toon','Toon','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

--
-- Cleanup the OpenZWave/RaZberry devicetypes
--

UPDATE devices SET module=64 WHERE module=63;
UPDATE devices SET module=64 WHERE module=304;
UPDATE devices SET module=64 WHERE module=305;
UPDATE devices SET module=64 WHERE module=306;
UPDATE devices SET module=64 WHERE module=307;
UPDATE devices SET module=64 WHERE module=308;
UPDATE devices SET module=64 WHERE module=310;
UPDATE devices SET module=64 WHERE module=312;
UPDATE devices SET module=64 WHERE module=313;
UPDATE devices SET module=64 WHERE module=314;
UPDATE devices SET module=64 WHERE module=316;
UPDATE devices SET module=64 WHERE module=317;
UPDATE devices SET module=64 WHERE module=318;
UPDATE devices SET module=64 WHERE module=323;
UPDATE devices SET module=64 WHERE module=324;
UPDATE devices SET module=61 WHERE module=244;
UPDATE devices SET module=61 WHERE module=319;
UPDATE devices SET module=61 WHERE module=320;
UPDATE devices SET module=61 WHERE module=325;
UPDATE devices SET module=61 WHERE module=326;
UPDATE devices SET module=61 WHERE module=327;
UPDATE devices SET module=61 WHERE module=328;
UPDATE devices SET module=61 WHERE module=330;
UPDATE devices SET module=61 WHERE module=331;
UPDATE devices SET module=62 WHERE module=322;
UPDATE devices SET module=62 WHERE module=329;
UPDATE devices SET module=62 WHERE module=332;
UPDATE devices SET module=242 WHERE module=333;
UPDATE devices SET module=304 WHERE module=311;
UPDATE devices SET module=304 WHERE module=315;
UPDATE devices SET module=305 WHERE module=321;
UPDATE devicetypes SET name='Z-Wave Controller', description='Controller', addressformat='1' WHERE id=63;
UPDATE devicetypes SET name='Z-Wave Sensor', description='Sensor' WHERE id=64;
UPDATE devicetypes SET name='Z-Wave Entry Control', description='Entry Control' WHERE id=309;
UPDATE devicetypes SET name='Z-Wave Generic', description='Generic' WHERE id=304;
UPDATE devicetypes SET name='Z-Wave Motor Control', description='Motor Control' WHERE id=305;
UPDATE devicetypes SET name='Z-Wave Remote Switch', description='Remote Switch' WHERE id=306;
DELETE FROM devicetypes WHERE id=244;
DELETE FROM devicetypes WHERE id=307;
DELETE FROM devicetypes WHERE id=308;
DELETE FROM devicetypes WHERE id=310;
DELETE FROM devicetypes WHERE id=311;
DELETE FROM devicetypes WHERE id=312;
DELETE FROM devicetypes WHERE id=313;
DELETE FROM devicetypes WHERE id=314;
DELETE FROM devicetypes WHERE id=315;
DELETE FROM devicetypes WHERE id=316;
DELETE FROM devicetypes WHERE id=317;
DELETE FROM devicetypes WHERE id=318;
DELETE FROM devicetypes WHERE id=319;
DELETE FROM devicetypes WHERE id=320;
DELETE FROM devicetypes WHERE id=321;
DELETE FROM devicetypes WHERE id=322;
DELETE FROM devicetypes WHERE id=323;
DELETE FROM devicetypes WHERE id=324;
DELETE FROM devicetypes WHERE id=325;
DELETE FROM devicetypes WHERE id=326;
DELETE FROM devicetypes WHERE id=327;
DELETE FROM devicetypes WHERE id=328;
DELETE FROM devicetypes WHERE id=329;
DELETE FROM devicetypes WHERE id=330;
DELETE FROM devicetypes WHERE id=331;
DELETE FROM devicetypes WHERE id=332;
DELETE FROM devicetypes WHERE id=333;

--
-- Virtual WeatherUnderground device
--

INSERT INTO `devicetypes` VALUES (141,'Weather','Weather Virtual Device','Virtual','WeatherUnderground, OpenWeatherMap, forecast.io','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

--
-- Rename row name 'module' so it matches the table name id it links to.
--

ALTER TABLE devices CHANGE COLUMN module devicetype_id int(11) NOT NULL DEFAULT '0';

--
-- Table structure for table `settings_openweathermap`
--

DROP TABLE IF EXISTS `settings_openweathermap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_openweathermap` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `apikey` varchar(128) DEFAULT NULL,
  `cityid` varchar(32) DEFAULT NULL,
  `city` varchar(128) DEFAULT NULL,
  `polltime` int(11) DEFAULT NULL,
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_openweathermap`
--

LOCK TABLES `settings_openweathermap` WRITE;
/*!40000 ALTER TABLE `settings_openweathermap` DISABLE KEYS */;
INSERT INTO `settings_openweathermap` VALUES (0,0,'API1234567890','0','Dordrecht',300,0),(1,0,'API1234567890','0','Dordrecht',300,0);
/*!40000 ALTER TABLE `settings_openweathermap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_forecastio`
--

DROP TABLE IF EXISTS `settings_forecastio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_forecastio` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `apikey` varchar(128) DEFAULT NULL,
  `latitude` varchar(32) DEFAULT NULL,
  `longitude` varchar(32) DEFAULT NULL,
  `city` varchar(128) DEFAULT NULL,
  `polltime` int(11) DEFAULT NULL,
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_forecastio`
--

LOCK TABLES `settings_forecastio` WRITE;
/*!40000 ALTER TABLE `settings_forecastio` DISABLE KEYS */;
INSERT INTO `settings_forecastio` VALUES (0,0,'API1234567890','0','0','Dordrecht',300,0),(1,0,'API1234567890','0','0','Dordrecht',300,0);
/*!40000 ALTER TABLE `settings_forecastio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_mysensors`
--

DROP TABLE IF EXISTS `settings_mysensors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings_mysensors` (
  `id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `type` varchar(32) DEFAULT NULL,
  `tcphost` varchar(32) DEFAULT NULL,
  `tcpport` int(11) DEFAULT NULL,
  `serialport` varchar(128) DEFAULT NULL,
  `baudrate` varchar(32) DEFAULT NULL,
  `relayenabled` tinyint(1) DEFAULT NULL,
  `relayport` int(11) DEFAULT NULL,
  `useack` tinyint(1) NOT NULL DEFAULT '0',
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_mysensors`
--

LOCK TABLES `settings_mysensors` WRITE;
/*!40000 ALTER TABLE `settings_mysensors` DISABLE KEYS */;
INSERT INTO `settings_mysensors` VALUES (0,0,'serial','192.168.100.7',5003,'/dev/ttyUSB1','115200',0,5004,-1,-1),(1,0,'serial','192.168.100.7',5003,'/dev/ttyUSB1','115200',0,5004,-1,-1);
/*!40000 ALTER TABLE `settings_mysensors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Philips Hue 
--

INSERT INTO `devicetypes` VALUES (308,'Philips Hue Lux Light','Light','PhilipsHue','1','','','',0,-1,0,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (310,'Philips Hue Beyond Light','Light','PhilipsHue','1','','','',0,-1,0,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (311,'Philips Hue Tap','Switch','PhilipsHue','1','','','',0,0,0,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (312,'Philips Hue Friends Bloom LivingColors','Light','PhilipsHue','1','','','',0,-1,0,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (313,'Philips Hue Friends Iris LivingColors','Light','PhilipsHue','1','','','',0,-1,0,NULL,NULL,NULL,NULL);
INSERT INTO `devicetypes` VALUES (314,'Philips Hue Friends LightStrips','Light','PhilipsHue','1','','','',0,-1,0,NULL,NULL,NULL,NULL);

--
-- Update OTGW default port to non-priviledged port
--

LOCK TABLES `settings_opentherm` WRITE;
UPDATE settings_opentherm SET tcpport = 6202 WHERE enabled = 0;
UPDATE settings_opentherm SET relayport = 6203 WHERE relayenabled = 0;
UNLOCK TABLES;

--
-- Change Shell module into a plugin Class
--

UPDATE plugins SET type = 'class' WHERE interface = 'Shell Interface';

--
-- Finally update to 1.0.017
--

LOCK TABLES version WRITE;
INSERT INTO version VALUES (62,'1.0.017');
UNLOCK TABLES;
