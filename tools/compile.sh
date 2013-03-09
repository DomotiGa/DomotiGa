#!/bin/bash
# Compile DomotiGa binaries

hash gbc2 &> /dev/null
if [ $? -eq 1 ]; then
	echo "Gambas2 not found, skipping compile.."
else
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
fi

hash gbc3 &> /dev/null
if [ $? -eq 1 ]; then
	echo "Gambas3 not found, skipping compile.."
else
	if [ -d DomotiGaServer3 ]; then
	  cd DomotiGaServer3
	else
	  cd ../DomotiGaServer3
	fi
	gbc3 -agmt
	gba3 -o `pwd`/../DomotiGaServer3.gambas
	rm -rf .gambas
	cd ..
	chmod +x DomotiGaServer3.gambas
	ls -la DomotiGaServer3.gambas
fi

hash gbc3 &> /dev/null
if [ $? -eq 1 ]; then
	echo "Gambas3 not found, skipping compile.."
else
	if [ -d DomotiGa3 ]; then
	  cd DomotiGa3
	else
	  cd ../DomotiGa3
	fi
	gbc3 -agpmt
	gba3 -o `pwd`/../DomotiGa3.gambas
	rm -rf .gambas
	cd ..
	chmod +x DomotiGa3.gambas
	ls -la DomotiGa3.gambas
fi
