<?php

// DomotiGa - an open source home automation program
// Copyright(C) 2008-2009 Ron Klinkien

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

function do_xmlrpc($request) {
   global $rpc_connect;
   $context = stream_context_create(array('http' => array('method' => "POST",'header' =>"Content-Type: text/xml",'content' => $request)));
   if ($file = @file_get_contents($rpc_connect, false, $context)) {
      $file=str_replace("i8","double",$file);
      return xmlrpc_decode($file, "UTF-8");
   } else {
      die ("<h2>Cannot connect to the DomotiGa server!</h2>");
   }
}

// Get device list
function get_device_list($view) {
   $request = xmlrpc_encode_request("device.list",null);
   $response = do_xmlrpc($request);

   if (xmlrpc_is_fault($response)) {
       trigger_error("xmlrpc: $response[faultString] ($response[faultCode])");
   } else {
      $index=0;
      foreach($response AS $item) {
         list( $retarr[$index]['id'], $retarr[$index]['deviceicon'], $retarr[$index]['devicename'], $retarr[$index]['devicelocation'], $retarr[$index]['devicevalue'], $retarr[$index]['devicelabel'], $retarr[$index]['devicevalue2'], $retarr[$index]['devicelabel2'], $retarr[$index]['devicevalue3'], $retarr[$index]['devicelabel3'], $retarr[$index]['devicevalue4'], $retarr[$index]['devicelabel4'], $retarr[$index]['devicelastseen']) = split (';;', $item);
         if ($retarr[$index]['deviceicon']) { $retarr[$index]['deviceicon'] = "<img src='images/icons/".$retarr[$index]['deviceicon']."' height='16' width='16' alt='icon' />"; } else { $retarr[$index]['deviceicon'] = ""; }
         if (strlen($retarr[$index]['devicevalue']) && $retarr[$index]['devicelabel']) { $retarr[$index]['devicevalue'] = $retarr[$index]['devicevalue']. " ".$retarr[$index]['devicelabel']; }
         if (strlen($retarr[$index]['devicevalue2']) && $retarr[$index]['devicelabel2']) { $retarr[$index]['devicevalue2'] = $retarr[$index]['devicevalue2']. " ".$retarr[$index]['devicelabel2']; }
         if (strlen($retarr[$index]['devicevalue3']) && $retarr[$index]['devicelabel3']) { $retarr[$index]['devicevalue3'] = $retarr[$index]['devicevalue3']. " ".$retarr[$index]['devicelabel3']; }
         if (strlen($retarr[$index]['devicevalue4']) && $retarr[$index]['devicelabel4']) { $retarr[$index]['devicevalue4'] = $retarr[$index]['devicevalue4']. " ".$retarr[$index]['devicelabel4']; }
         $index++;
      }
      if (isset($retarr)) {
         return $retarr;
      } else {
         return FALSE;
      }
   }
}

// Get status
function get_status() {
   // modes
   $retarr['house_mode'] = do_xmlrpc(xmlrpc_encode_request("mode.get_housemode",null));
   $retarr['mute_mode'] = do_xmlrpc(xmlrpc_encode_request("mode.get_mutemode",null));
   if ($retarr['mute_mode']) { $retarr['mute_mode'] ="<img src='images/icons/mute.png' height='16' width='16' alt='icon' />"; }
   else { $retarr['mute_mode'] ="<img src='images/icons/sound.png' height='16' width='16' alt='icon' />"; }

   // domotiga version
   $retarr['program_version'] = do_xmlrpc(xmlrpc_encode_request("system.program_version",null));

   // sun moon data
   $response = do_xmlrpc(xmlrpc_encode_request("data.sunmoon",null));
   $retarr['data_sunset'] = $response[1];
   $retarr['data_sunrise'] = $response[0];

   // new messages
   $response = do_xmlrpc(xmlrpc_encode_request("data.newmessages",null));
   $retarr['data_newmails'] = $response[0];
   $retarr['data_newcalls'] = $response[1];
   $retarr['data_newvoicemails'] = $response[2];

   // test
   $response = do_xmlrpc(xmlrpc_encode_request("setup.restart","Main"));
   $retarr['test'] = $response[0];

   return $retarr;
}

// Function to sort second key in array (ascending)
function sort_matches_asc($left,$right) {
   global $sortkey;
   if(strtolower($left["$sortkey"])==strtolower($right["$sortkey"])) return 0;
   return strtolower($left["$sortkey"]) < strtolower($right["$sortkey"]) ? -1 : 1 ;
}

// Function to sort second key in array (descending)
function sort_matches_desc($left,$right) {
   global $sortkey;
   if(strtolower($left["$sortkey"])==strtolower($right["$sortkey"])) return 0;
   return strtolower($left["$sortkey"]) > strtolower($right["$sortkey"]) ? -1 : 1 ;
}
?>
