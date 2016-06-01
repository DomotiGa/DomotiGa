#! /user/bin/env python
# coding: utf-!

## This program verifies the two factor authentication code given in arg2 for secret arg1


import pyotp
import sys

## set secret manually - for debugging
#totp = pyotp.TOTP('GEZDGNBVGY3TQOJQGEZDGNBVGY3TQOJQ')
totp = pyotp.TOTP(str(sys.argv[1]))
## debug: print used secret (argument 1 on command line) and pring tfa code
#print ('argument list:', str(sys.argv[1]), str(sys.argv[2]))
## verify tfa and print output: true or false
print (totp.verify(str(sys.argv[2])))
