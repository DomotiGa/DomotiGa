<?php

// DomotiGa - an open source home automation program
// Copyright (C) Ron Klinkien, The Netherlands.

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

include "config.php";
include "functions.php";
$device=$_GET["device"];
$value=$_GET["value"];

if ( $locations ) {
   if(!isset($_GET["location"])) {
      $location="*";
   } else {
      $location=$_GET["location"];
   };
   $data=get_device_list($location);
} else {
   $data=get_device_list("*");
};

$response = do_jsonrpc("device.set", array("device_id" => intval($device), "value" => $value));

if ( $locations ) {
   header('Location: device.php?location='.$location);
} else {
   header('Location: device.php');
}
?>
