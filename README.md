DomotiGa - Open Source Home Automation for Linux
================================================

Thank you for your interest in DomotiGa!
DomotiGa is Home Automation software for Linux written in [Gambas Basic](http://gambas.sourceforge.net/en/main.html), an excellent programming language and IDE for Linux.

DomotiGa has grown over the years from a tool to monitor sensors with via RFXCom interface, but nowadays you can use it to read and log data from all kind of interfaces, let it detect motion and schedule lights or appliances at certain times.
Or get events triggered by actions of other hardware and/or software modules, called 'plugins'.
Sending push messages via Twitter, Pushbullet, Pushover and NMA are also possible.

DomotiGa supports a long and growing [list](https://domotiga.nl/projects/domotiga/wiki/Modules) of various plugins to support for example the versatile RFXComTRX transceiver, a Razberry board on your Pi or the AEON Labs Open-Zwave dongle, Smartmeter P1 port, Plugwise dongle and more...

DIRECTORY STRUCTURE
-------------------

```
README.md        you are reading it now
CHANGELOG        contains a [link](https://domotiga.nl/projects/domotiga/wiki/changelog) where to find changes between versions
COPYING          the GPL license
AUTHORS          the author(s)
TODO             things to do

DomotiGa3/       the Gambas3 source code for client/standalone
DomotiGaServer3/ the Gambas3 source code for server
rrd/             rrd databases and graphs are stored here
logs/            this is where DomotiGa stores it's logfiles
icons/           icons used for devices
install/         files needed for fresh database install
	domotiga.sql        example database layout and contents
	domotiga-empty.sql  empty database layout and contents
floorplans/      store your floorplan images here
tvguide/         directory for xml tvguide related files
upgrade/         files needed for upgrading the database
sounds/          sounds to play
tools/           stores startup scripts and other tooling
wrappers/        3rd party library wrappers
webclients       web and smartphone clients
```

REQUIREMENTS
------------

Depends on which setup U want to use (see below) you want to use, but minimum is Gambas 3.6.0 for the server/client GUI.
To use one of the web clients you need to install a webserver like nginx or Apache, with PHP.

CLIENTS AND SERVER
------------------

You have a few choices on how you want DomotiGa to setup:

* Standalone
You can have a standlone GUI (DomotiGa3) as server and client.
You do this by setting the Mode to 'server' in the config file.
This is the default and will talk to all enabled hardware.
You need server hardware with XWindows installed with a monitor or working VNC setup.

* GUI client(s) and CLI server
You can run the DomotiGaServer3 as server to talk to the hardware and DomotiGa3 as
clients, you have to change the Mode parameter in domotiga.conf from
server to client on the machines you run DomotiGa3 on.

* GUI client(s) and GUI server
You can use the standalone version as server, but with more DomotiGa instances as clients.
So you configure on with server as Mode parameter, and the others as client, make sure the mysql host, xmlrpc and udp broadcast settings are set correctly for this.

* Web client(s)
On low performance hardware is often better to only run the CLI server (DomotiGaServer3)
Together with nginx or Apache as webserver and DomotiYii as the webclient.

DomotiYii is still under development, so if it doesn't do what you want right now, give us a poke!

HARDWARE
--------

Gambas and thus DomotiGa can run on a variety of server hardware, read more info [here](https://domotiga.nl/projects/domotiga/wiki/DomotiGa_Server_Hardware)
Popular are the Cubieboard 2 or Cubietruck (with SSD), for a very small/test setup the Rasberry Pi can just handle it.

INSTALL DOCUMENTATION
---------------------

You can find all information on our website [domotiga.nl](https://domotiga.nl)

A draft version of the [User Guide](https://domotiga.nl/attachments/download/1167/DomotiGa-Manual-2014-January.pdf) is also available.

Some more reading material:

[Introduction](https://domotiga.nl/projects/domotiga/wiki/DomotiGa_Introduction)

[How to Start](https://domotiga.nl/projects/domotiga/wiki/DomotiGa_How_To_Start)

[Installation](https://domotiga.nl/projects/domotiga/wiki/DomotiGa_Installation)

SCREENSHOTS
-----------

https://domotiga.nl/projects/domotiga/wiki/DomotiGa_Screenshots

LICENSE
-------

DomotiGa is released under the GNU GPL V3 License [Full Text Version](http://domotiga.nl/projects/domotiga/repository/revisions/master/entry/COPYING).

Copyright (C) Ron Klinkien, The Netherlands.

DISCLAIMER
----------

DomotiGa comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law.

Make sure you have read the license file called COPYING, or the programs About window contents.
If you do not agree with it please remove this program from your computer.

DEBUGGING
---------

If things don't work correctly enable debug information for the part or plugin you have trouble with and
examine the debug log.

You can post your issues or ask questions on the [forum](https://domotiga.nl/projects/domotiga/boards), open a [bug report](https://domotiga.nl/projects/domotiga/issues) or just send me a message via the [Contact form](https://domotiga.nl/contact) on the site.

DEVELOPMENT
-----------

If you have written some code, or want to help make DomotiGa better, please contact us, or fork this project and submit a Pull Request on GitHub.
Gambas is a great (and free) programming language and it comes with a very nice IDE to develop with.
If your not familiar with Gambas visit the [website](http://gambas.sourceforge.net) and/or [wiki](http://gambaswiki.org) for more information.

DONATE
------

If you want to have suppport for your home automation hardware, you can donate a sample, lend it to me, or send me the specs and I see what I can do. ;-)
You can also use [PayPal](https://domotiga.nl/#Donate-to-DomotiGa) if you like the project.

Thanks to the guys at www.domoticaforum.eu, www.rfxcom.com, www.ezhome.nl and www.domotica-shop.nl!


HAVE FUN NOW!

Regards,
Ron Klinkien aka RDNZL
support@domotiga.nl
Dordrecht, The Netherlands
