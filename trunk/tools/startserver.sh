#!/bin/bash
# Compile and start DomotiGa server

if [ -d DomotiGaServer ]; then
  cd DomotiGaServer
else 
  cd ../DomotiGaServer
fi

gbc2 -amg
gbx2
