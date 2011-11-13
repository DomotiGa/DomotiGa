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
$housemode=$_GET["housemode"];

if ($housemode == "mute") {
   $request = xmlrpc_encode_request("set.mutemode",true);
   $response = do_xmlrpc($request);
   if (xmlrpc_is_fault($response)) {
     trigger_error("xmlrpc: $response[faultString] ($response[faultCode])");}
} else if ( $housemode == "unmute" )  {
   $request = xmlrpc_encode_request("set.mutemode",false);
   $response = do_xmlrpc($request);
   if (xmlrpc_is_fault($response)) {
     trigger_error("xmlrpc: $response[faultString] ($response[faultCode])");}
} else if ( $housemode == "normal" )  {
   $request = xmlrpc_encode_request("set.housemode",$housemode);
   $response = do_xmlrpc($request);
   if (xmlrpc_is_fault($response)) {
     trigger_error("xmlrpc: $response[faultString] ($response[faultCode])");}
} else if ( $housemode == "work" )  {
   $request = xmlrpc_encode_request("set.housemode",$housemode);
   $response = do_xmlrpc($request);
   if (xmlrpc_is_fault($response)) {
     trigger_error("xmlrpc: $response[faultString] ($response[faultCode])");}
} else if ( $housemode == "away" )  {
   $request = xmlrpc_encode_request("set.housemode",$housemode);
   $response = do_xmlrpc($request);
   if (xmlrpc_is_fault($response)) {
     trigger_error("xmlrpc: $response[faultString] ($response[faultCode])");}
} else if ( $housemode == "vacation" )  {
   $request = xmlrpc_encode_request("set.housemode",$housemode);
   $response = do_xmlrpc($request);
   if (xmlrpc_is_fault($response)) {
     trigger_error("xmlrpc: $response[faultString] ($response[faultCode])");}
}
header('Location: index.php'); 
?>
