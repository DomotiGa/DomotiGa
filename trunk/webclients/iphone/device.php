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
<?php
// Get list of devices
$data=get_device_list();
if (is_array($data)) {
   $sortkey="devicename";
   usort($data,'sort_matches_asc');
} else {
   $data=array();
}
// Get list of devices switchable
$datas=get_device_listswitch();
echo "<style type=\"text/css\">\n";
foreach ($data AS $item) {
   foreach ($datas AS $items) {	
      if ($item['id'] == $items['id']) { 
	echo "div#optionpanel".$item['id']." {\n";
	echo "background: url(images/blackbg.png) top left repeat-x;\n";
        echo "text-align: center;\n";
	echo "padding: 20px 10px 15px 10px;\n";
	echo "position: absolute;\n";
	echo "left: 0;\n";
	echo "right: 0;\n";
	echo "bottom: 0;\n}\n";
      }
   } 	
}
echo "</style>\n";
?>
<link rel="apple-touch-icon" href="images/favicon.ico" />
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
echo "<body id=\"plastic\">\n";

echo "<div id='header'>\n";
echo "<h1>Devices</h1>\n";
echo "<a href=\"index.php\" class=\"nav\" id=\"backButton\">Home</a>\n";
echo "</div>\n";

echo "<ul>\n";
foreach ($data AS $item) {
   echo "<li";	
   foreach ($datas AS $items) {	
      if ($item['id'] == $items['id']) { echo " class=\"arrow\"><a href=\"#\" onclick=\"showhide('optionpanel".$item['id']."');\"";}} 	
      echo "><small>".$item['devicevalue']."</small>".$item['deviceicon'].$item['devicename']."</a></li>\n";
   }
echo "</ul>\n";
?>
<p><strong>Best enjoyed on a real iPhone</strong><br />This iPhone UI Framework kit is licenced under GNU Affero General Public License (<a href="http://www.gnu.org/licenses/agpl.html">GNU AGPL 3</a>)</p>
<?php
foreach ($data AS $item) {
   foreach ($datas AS $items) {	
      if ($item['id'] == $items['id']) { 
         echo "<div id=\"optionpanel".$item['id']."\" style=\"display: none\">\n";
	 echo "<p><a class=\"white button\" href=\"change_device.php?device=".$item['devicename']."&value=On\">On</a> <a href=\"change_device.php?device=".$item['devicename']."&value=off\" class=\"red button\">Off</a><a href=\"#\" class=\"black button\" onclick=\"showhide('optionpanel".$item['id']."');\">Cancel</a></p>  \n";
	 echo "</div>\n";
      }
   } 	
}
?>
</body>
</html>
