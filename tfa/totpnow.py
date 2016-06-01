#! /user/bin/env python
# coding: utf-!

## This program gets the two factor authentication value for the current time. It needs one argument the secret.
## Time should be in sync with world time. Max deviation = 5 minutes.

import pyotp
import sys

## set secret manually - for debugging
#totp = pyotp.TOTP('GEZDGNBVGY3TQOJQGEZDGNBVGY3TQOJQ')
totp = pyotp.TOTP(str(sys.argv[1]))
## debug: print used secret (argument 1 on command line)
#print ('argument list:', str(sys.argv[1]))
## print output
print (totp.now())
