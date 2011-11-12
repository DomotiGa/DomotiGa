<?php

// DomotiGa - an open source home automation program
// Copyright(C) 2008-2011 Ron Klinkien

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General PUBLIC License for more details.

// You should have received a copy of the GNU General PUBLIC License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

$execstart=$start=microtime(true);
session_start();
$configfile = 'config.php';
if (file_exists($configfile)) {
   include "config.php";
} else {
   echo "<h3>Check contents of config.php.example first, then rename it to config.php!</h3>";
   exit;
}
if (!extension_loaded('xmlrpc')) {
   echo "<h3>PHP xmlrpc module is not found, check your apache/php server setup!</h3>";
   exit;
}
include "functions.php";
import_request_variables("gp","r_");

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta id="viewport" name="viewport" content="width=320; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
<link rel="shortcut icon" href="images/favicon.ico" />
<script type="text/javascript" src="domotiga.js"></script>
<title>DomotiGa</title>
<link rel="stylesheet" href="stylesheets/iphone.css" />
<link rel="apple-touch-icon" href="images/apple-touch-icon.png" />
	<script language="javascript"> 
	<!--
	var state = 'none';

	function showhide(layer_ref) {

	if (state == 'block') { 
	state = 'none'; 
	} 
	else { 
	state = 'block'; 
	} 
	if (document.getElementById &&!document.all) { 
	hza = document.getElementById(layer_ref); 
	hza.style.display = state; 
	} 
	} 
	//--> 
	</script>
<script type="text/javascript" charset="utf-8">
	window.onload = function() {
	  setTimeout(function(){window.scrollTo(0, 1);}, 100);
	}
</script>
</head>
<?php
echo "<body>\n";

// Title
echo "<div id='header'>\n";
echo "<h1>DomotiGa</h1>\n";
echo "<a href=\"device.php\" class=\"nav Action\">Devices</a>\n";
echo "</div>\n";
// Status
$status=get_status();
echo "<ul>\n";	

echo "	<li><small>".$status['house_mode']."</small> <a href=\"#\" onclick=\"showhide('optionpanel');\">House Mode</a></li>\n";
echo "	<li><small>".$status['mute_mode']."</small> <a href=\"change_housemode.php?housemode=";
if ($status['mute_mode'] == "<img src='images/icons/sound.png' height='16' width='16' alt='icon' />") {
	echo "mute";
	} else {
	echo "unmute";
	}
echo "\">Sound Mode</a></li>\n";
echo "</ul>\n";
echo "<ul class=\"individual\">\n";	
echo "<li><small><img src='images/icons/sun.png' height='16' width='16' alt='Sunrise' ></small>".$status['data_sunrise']."</li>\n";
echo "<li><small><img src='images/icons/sunset.png' height='16' width='16' alt='Sunset'></small>".$status['data_sunset']."</li>\n";
echo "</ul>\n";

echo "<ul>\n";
echo "	<li><small>".$status['data_newmails']."</small>E-mails</li>\n";
echo "	<li><small>".$status['data_newcalls']."</small>Calls</li>\n";
echo "	<li><small>".$status['data_newvoicemails']."</small>Voicemails</li>\n";
echo "</ul>\n";

?>
<p><strong>Best enjoyed on a real iPhone</strong><br />This iPhone UI Framework kit is licenced under GNU Affero General Public License (<a href="http://www.gnu.org/licenses/agpl.html">GNU AGPL 3</a>)</p>

<div id="optionpanel" style="display: none">
	
<p><a class="white button" href="change_housemode.php?housemode=normal">Normal</a> <a href="change_housemode.php?housemode=work" class="white button">Work</a> <a href="change_housemode.php?housemode=away" class="white button">Away</a> <a href="change_housemode.php?housemode=vacation" class="white button">Vacation</a> <a href="#" class="black button" onclick="showhide('optionpanel');">Cancel</a></p> 

</div>
</body>
</html>
