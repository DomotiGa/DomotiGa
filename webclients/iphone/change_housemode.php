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
$mode=$_GET["mode"];
$mute=$_GET["mute"];

if (isset($mute)) {
  if ($mute == "true") {
    $response = do_jsonrpc("housemode.set", array("mute" => true));
  } else if ( $mute == "false" )  {
    $response = do_jsonrpc("housemode.set", array("mute" => false));
  }
}

if (isset($mode)) {
  $response = do_jsonrpc("housemode.set", array("mode" => $mode));
}
header('Location: index.php'); 
?>
