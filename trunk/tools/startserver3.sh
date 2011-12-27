#!/bin/bash
# Compile and start DomotiGa server

if [ -d DomotiGaServer3 ]; then
  cd DomotiGaServer3
else 
  cd ../DomotiGaServer3
fi

gbc3 -amg
gbx3
