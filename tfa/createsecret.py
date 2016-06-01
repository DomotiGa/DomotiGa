#! /user/bin/env python
# coding: utf-!

# This program creates a two factor authentication secret of 16 char.

import pyotp

## print output
print (pyotp.random_base32())
