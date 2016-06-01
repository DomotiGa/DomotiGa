#! /user/bin/env python
# coding: utf-!

## This program creates the provisioning uri for use with QR Code Scanner by google.
## arg 1 = tfa secret
## arg 2 = naming of program (DomotiGa + username) within double quotes
## e.g. python provisioninguri.py CJGOP5PWW2OZDFT3 "Domotiga - myusername"
## gives: otpauth://totp/Domotiga%20-%20myusername?secret=CJGOP5PWW2OZDFT3

import pyotp
import sys

## set secret manually - for debugging
#totp = pyotp.TOTP('GEZDGNBVGY3TQOJQGEZDGNBVGY3TQOJQ')
totp = pyotp.TOTP(str(sys.argv[1]))
## debug: print used secret (argument 1 on command line) and naming of program
#print ('argument list:', str(sys.argv[1]), str(sys.argv[2]))
## print output
print (totp.provisioning_uri(str(sys.argv[2])))
