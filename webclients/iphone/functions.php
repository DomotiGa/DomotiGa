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

// Do the JSON-RPC and error handling
function do_jsonrpc($method, $params) {
  global $rpc_connect;

  // Build up the JSON-RPC request, add the other headers
  if ($params == null) {
    $request = array("jsonrpc" => "2.0", "method" => $method, "id" => 1);
  } else {
    $request = array("jsonrpc" => "2.0", "method" => $method, "params" => $params, "id" => 1);
  }

  $ch = curl_init($rpc_connect);
  curl_setopt($ch, CURLOPT_POST, 1);
  curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json'));
  curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($request));
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  $context = curl_exec($ch);

  if ( curl_error($ch) == "" ) {
    $status = curl_getinfo($ch, CURLINFO_HTTP_CODE);

    if ( $status != 200 ) {
      curl_close($ch);
      die ("<h2>DomotiGa JSON-RPC returned HTTP Code=$status, expected=200</h2>");
    }

    curl_close($ch);

    $response = json_decode($context, true);

//    if (isset($response->result)) {
      return $response['result'];
//    } else {
//      die ("<h2>DomotiGa JSON-RPC didn't return a result, no devices present?</h2>");
//    }
  } else {
    curl_close($ch);
    die ("<h2>Cannot connect to the DomotiGa server!</h2>");
  }
}

// get location list
function get_location_list() {

  $response = do_jsonrpc("device.list", null);

  $index=0;
  foreach($response AS $item) {

    $retarr[$index] = $item['locationname'];
    $index++;
  }

  if (isset($retarr)) {
    return $retarr;
  } else {
    return FALSE;
  }

}

// Get device list
function get_device_list($location) {

  $response = do_jsonrpc("device.list", array("list" => "enabled"));

  $index=0;
  foreach($response AS $item) {

    $retarr[$index]['id'] = $item['device_id'];
    $retarr[$index]['deviceicon'] = $item['icon'];
    $retarr[$index]['devicename'] = $item['name'];
    $retarr[$index]['devicelocation'] = $item['locationname'];
    $retarr[$index]['devicelastseen'] = $item['lastseen'];
    $retarr[$index]['dimmable'] = $item['dimable'];
    $retarr[$index]['switchable'] = $item['switchable'];

    if ( $location != "*" ) {
      if ($retarr[$index]['devicelocation'] != $location) {
        unset($retarr[$index]);
        continue;
      }
    };

    foreach($item['values'] AS $value) {
      $retarr[$index]['devicevalue' . $value['valuenum']] = $value['value'];
      $retarr[$index]['devicelabel' . $value['valuenum']] = $value['units'];
    }

    if ($retarr[$index]['deviceicon']) {
      $retarr[$index]['deviceicon'] = "<img src='images/icons/".$retarr[$index]['deviceicon']."' height='16' width='16' alt='icon' />";
    } else {
      $retarr[$index]['deviceicon'] = "";
    }
    if (strlen($retarr[$index]['devicevalue1']) && $retarr[$index]['devicelabel1']) {
      $retarr[$index]['devicevalue1'] = $retarr[$index]['devicevalue1']. " ".$retarr[$index]['devicelabel1'];
    }

    $index++;
  }

  if (isset($retarr)) {
    return $retarr;
  } else {
    return FALSE;
  }
}

// Get device list, switch or dim
function get_device_listtype($type) {

  $response = do_jsonrpc("device.list", array("list" => "enabled+$type"));

  $index=0;
  foreach($response AS $item) {

    $retarr[$index]['id'] = $item['device_id'];
    $retarr[$index]['deviceicon'] = $item['icon'];
    $retarr[$index]['devicename'] = $item['name'];
    if ($retarr[$index]['deviceicon']) {
      $retarr[$index]['deviceicon'] = "<img src='images/icons/".$retarr[$index]['deviceicon']."' height='16' width='16' alt='icon' />";
    } else {
      $retarr[$index]['deviceicon'] = "";
    }

    foreach($item['values'] AS $value) {
      $retarr[$index]['devicevalue' . $value['valuenum']] = $value['value'];
      $retarr[$index]['devicelabel' . $value['valuenum']] = $value['units'];
    }

    if (strlen($retarr[$index]['devicevalue1']) && $retarr[$index]['devicelabel1']) {
      $retarr[$index]['devicevalue1'] = $retarr[$index]['devicevalue1']. " ".$retarr[$index]['devicelabel1'];
    }

    $index++;
  }

  if (isset($retarr)) {
    return $retarr;
  } else {
    return FALSE;
  }

}

// Get status
function get_status() {

   // modes
   $housemode = do_jsonrpc("housemode.get", null);
   $retarr['house_mode'] = $housemode['mode'];
   $retarr['mute_mode'] = $housemode['mute'];
   if ($retarr['mute_mode']) { $retarr['mute_mode'] ="<img src='images/icons/mute.png' height='16' width='16' alt='icon' />"; }
   else { $retarr['mute_mode'] ="<img src='images/icons/sound.png' height='16' width='16' alt='icon' />"; }

   // domotiga version
   $retarr['program_version'] = do_jsonrpc("domotiga.version", null);

   // sun moon data
   $astro = do_jsonrpc("astro.get", null);
   $retarr['data_sunset'] = $astro['sunset'];
   $retarr['data_sunrise'] = $astro['sunrise'];

   // new messages
   $newmessage = do_jsonrpc("data.newmessage", null);
   $retarr['data_newmails'] = $newmessage['email'];
   $retarr['data_newcalls'] = $newmessage['call'];
   $retarr['data_newvoicemails'] = $newmessage['voicemail'];

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
