#!/bin/bash
# Compile DomotiGa binaries

if [ -d DomotiGaServer ]; then
  cd DomotiGaServer
else
  cd ../DomotiGaServer
fi
gbc2 -agm
gba2 -o `pwd`/../DomotiGaServer.gambas
rm -rf .gambas
cd ..
chmod +x DomotiGaServer.gambas
ls -la DomotiGaServer.gambas

if [ -d DomotiGa ]; then
  cd DomotiGa
else
  cd ../DomotiGa
fi
gbc2 -agmp
gba2 -o `pwd`/../DomotiGa.gambas
rm -rf .gambas
cd ..
chmod +x DomotiGa.gambas
ls -la DomotiGa.gambas
