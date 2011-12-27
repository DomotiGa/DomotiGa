#!/bin/sh
# Script to dump the most important DomotiGa device info (not all)
# to cli in csv format.

# DomotiGa - an open source home automation program.
# Copyright(C) 2008-2010 Ron Klinkien.

mysql -udomouser -pkung-fu domotiga -B -e "SELECT devices.id,devices.name,address,module,devicetypes.name AS devicetypename,interface, interfaces.name AS interfacename,location,locations.name AS locationname,value,label,value2,label2,value3,label3,value4,label4,calibration,divider,calibration2,divider2,calibration3,divider3,calibration4,divider4,onicon,dimicon,officon,firstseen,lastseen,lastchanged,enabled,hide,log,groups,batterystatus,comments FROM devices LEFT JOIN interfaces ON interfaces.id = devices.interface LEFT JOIN devicetypes ON devicetypes.id = devices.module LEFT JOIN locations ON devices.location = locations.id ORDER BY devices.id;" | sed 's/\t/","/g;s/^/"/;s/$/"/;s/\n//g' 
