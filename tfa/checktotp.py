#! /user/bin/env python
# coding: utf-!

import pyotp

#totp = pyotp.TOTP('1234567890')
#totp.at()
totp = pyotp.TOTP('GEZDGNBVGY3TQOJQGEZDGNBVGY3TQOJQ')
print (totp.now())
