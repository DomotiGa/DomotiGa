<?php

// DomotiGa - an open source home automation program
// Copyright(C) 2008-2012 Ron Klinkien

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
include "config.php";
include "functions.php";
extract($_REQUEST, EXTR_PREFIX_ALL|EXTR_REFS, 'r_');
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta id="viewport" name="viewport" content="width=320, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<link rel="shortcut icon" href="images/favicon.ico" />
<script type="text/javascript" src="domotiga.js"></script>
<title>DomotiGa</title>
<link rel="stylesheet" href="stylesheets/iphone.css" />
<?php
// Get list of locations
$data=get_location_list();
if (is_array($data)) {
	$data = array_unique($data);
	sort($data);
} else {
   $data=array();
}

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
echo "<h1>Locations</h1>\n";
echo "<a href=\"index.php\" class=\"nav\" id=\"backButton\">Home</a>\n";
echo "<a href=\"device.php\" class=\"nav Action\">Devices</a>\n";
echo "</div>\n";

echo "<ul>\n";
foreach ($data AS $item) {
	if (!empty($item)) {
		echo "<li class=\"arrow\"><a href=\"device.php?location=".$item."\">".$item."</a></li>\n";
	};
}
echo "</ul>\n";
?>
<p><strong>Best enjoyed on a real iPhone</strong><br />This iPhone UI Framework kit is licenced under GNU Affero General Public License (<a href="http://www.gnu.org/licenses/agpl.html">GNU AGPL 3</a>)</p>
</body>
</html>
