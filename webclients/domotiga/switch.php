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

session_start();
$execstart=$start=microtime(true);
include "functions.php";
include "config.php";

if (isset($_REQUEST['On'])) {
   set_device(urldecode($_REQUEST['id']), 'On');
   echo "<script>window.top.location='index.php?reload=1';</script>";
   die();
}
if (isset($_REQUEST['Off'])) {
   set_device(urldecode($_REQUEST['id']), 'Off');
   echo "<script>window.top.location='index.php?reload=1';</script>";
   die();
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="images/favicon.ico" />
<title>DomotiGa</title>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body >
<div class='modal'>
<?php
echo "<form method='post' action='switch.php'>\n";
echo "<h3>Switch</h3>";
echo "<p>&nbsp;</p>";
echo "<p><input type='hidden' name='id' value='".$_REQUEST['id']."' />\n";
echo "<p><input type='submit' name='On' value='On' />&nbsp;<input type='submit' name='Off' value='Off' /></p>\n";
echo "</form>\n";
?>
</div>
</body>
</html>
