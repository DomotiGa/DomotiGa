================================================================================

  DomotiGa - Open Source Home Automation for Linux
  Copyright (C) Ron Klinkien, The Netherlands.

================================================================================

DISCLAIMER:
DomotiGa comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law.

Make sure you have read the license file called COPYING, or the programs About window contents.
If you do not agree with it please remove this program from your computer.

How to get DomotiGa up and running:

Login as the user you want to run DomotiGa as.
Unpack this archive, I guess you already did...

Move or copy it to your home directory. (no root!)
Check permissions/ownership of the directories tvguide, rrd and logs, they need to be writeable by the user.

So you have for example:
/home/ron/domotiga

Inside you will find this:

README               - you are reading it now
CHANGELOG            - notes about changes between versions
COPYING              - the GPL license
AUTHORS              - the author(s)
TODO                 - things to do

<dir> DomotiGa3      - the Gambas3 source code for client/standalone
<dir> DomotiGaServer3- the Gambas3 source code for server
<dir> rrd            - rrd databases and graphs are stored here
<dir> logs           - this is where DomotiGa stores it's logfiles
<dir> icons          - icons used for devices
<dir> install        - files needed for fresh database install
       domotiga.sql  - example database layout and contents
       domotiga-empty.sql  - empty database layout and contents
<dir> floorplans     - store your floorplan images here
<dir> tvguide        - directory for xml tvguide related files
<dir> upgrade        - files needed for upgrading the database
<dir> sounds         - sounds to play
<dir> tools          - stores startup scripts and other tooling
<dir> wrappers       - 3rd party library wrappers
<dir> webclients     - web and smartphone clients

Domotiga3.gambas      - a precompiled executable for client/standalone
DomotigaServer3.gambas- a precompiled executable for server
domotiga.conf.default        - default config file for client/standalone
server-domotiga.conf.default - default config file for server
(rest of the settings are stored inside the database)

You need a working Gambas environment, either runtime, or development.
Gambas should be version 3.5.2 or higher.
Preferably the latest revision available from svn.

Look on the website http://domotiga.nl for an how-to describing the installation.

Next step, you need to setup an MySQL database for Domotiga.
The version you have now does this for you when you start it.

Note: if you want to change the default db user and/or password,
you have to edit install/domotiga.sql and domotiga.conf too.

If you already have an older version of DomotiGa running, just make
sure you have copied over latest code and the upgrade directory.
And it will upgrade the database automatically upon start.

You have a few choices on how you want the basics to run:

* Standalone
You can have a standlone GUI (DomotiGa) as server and only client.
(apart from any webclients)
You do this by setting the Mode to 'server' in the config file.
This is the default and will talk to all enabled hardware.

* GUI client(s) and CLI server
You can run the DomotiGaServer as server to talk to the hardware and DomotiGa as
clients, you have to change the Mode parameter in domotiga.conf from
server to client.

* GUI client(s) and GUI server
You can use the standalone version as server, but with more DomotiGa instances as clients.
So you configure on with server as Mode parameter, and the others as client, make sure the mysql host, xmlrpc and udp broadcast settings are set correctly for this.

Create shortcut on Desktop

Right click on desktop and create laucher or goto menu editor
(in Preferences on Ubuntu)

New item
Name: DomotiGa
Command: /home/<youruser>/domotiga/Domotiga3.gambas
Icon: /home/<youruser>/domotiga/icons/logo.png

If you want to change/look at the source code, start the Gambas's IDE
by clicking the icon, or by typing gambas2 inside a terminal window.

Then select open project and browse to ~/domotiga/DomotiGa3

If you want to start DomotiGa from within editor click on the run icon
to start DomotiGa.

If Authentication is enabled (menu Setup->Main) you can login with:

User: admin
Password: admin
Can create, edit and view.

User: user
Password: user
Can only view.

You can add or change user logins under menu Edit->Users

================================================================================

NOTES:
I repeat; You should not run DomotiGa as 'root'!
It's too much of a security risk.
Use a normal user account with limited privileges.

But make sure that your user account has enough permissions to read
from/write to your serial ports and run commands needed for DomotiGa,
like for example; hcitool (bluetooth) and rrdtool (for graphing) etc.

Add the user to the group 'dialout' for serial port access if not already done.
All hardware and software modules are disabled by default, goto the
Setup menu to configure and enable them.

Read the documentation on the website for more information.

If things don't work correctly enable debug information for this module and
examine the debug log.

================================================================================

If you want to have suppport for your home automation hardware, you can donate  a sample, lend it to me, or send me the specs and I see what I can do. ;-)

Thanks to the guys at www.domoticaforum.eu, www.rfxcom.com and www.ezhome.nl!

HAVE FUN NOW!

Regards,
Ron Klinkien aka RDNZL

support@domotiga.nl
Dordrecht, The Netherlands
