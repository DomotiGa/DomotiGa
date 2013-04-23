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

function do_xmlrpc($request) {
   global $rpc_connect;
   global $use_curl;

   if ( $use_curl == "yes" ) {
      $ch = curl_init($rpc_connect);
      curl_setopt($ch, CURLOPT_POST, 1);
      curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: text/xml'));
      curl_setopt($ch, CURLOPT_POSTFIELDS, "$request");
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
      $context = curl_exec($ch);
      if ( curl_error($ch) == "" ) {
         curl_close($ch);
         return xmlrpc_decode($context,"UTF-8");
      } else {
         curl_close($ch);
   $add = split('[?]',$_SERVER['HTTP_REFERER']); 
	header("Location: index.php?".$add[1]);
         die ("<h2>Cannot connect to the DomotiGa server!</h2>");

      }
   } else {
      $context = stream_context_create(array('http' => array('method' => "POST",'header' =>"Content-Type: text/xml",'content' => $request)));
      if ($file = @file_get_contents($rpc_connect, false, $context)) {
         $file=str_replace("i8","double",$file);
         return xmlrpc_decode($file, "UTF-8");
      } else {
   $add = split('[?]',$_SERVER['HTTP_REFERER']); 
	header("Location: index.php?".$add[1]);
         die ("<h2>Cannot connect to the DomotiGa server!</h2>");

      }
   }
}

// Get device list : id, Icon, name, group, floorname, floorimage, x, y, type, location, value, label, value2, label2, value3, label3, value4, label4, lastseen, dimable, switchable, batterystatus

function get_device_list($view) {

   $request = xmlrpc_encode_request("device.list.ext",null);
   $response = do_xmlrpc($request);

   if (xmlrpc_is_fault($response)) {
       trigger_error("xmlrpc: $response[faultString] ($response[faultCode])");
   } else {
      $index=0;
      foreach($response AS $item) {
         list( $retarr[$index]['id'], $retarr[$index]['deviceicon'], $retarr[$index]['devicename'], $retarr[$index]['devicegroup'], $retarr[$index]['devicefloorname'], $retarr[$index]['devicefloorimage'], $retarr[$index]['deviceX'], $retarr[$index]['deviceY'], $retarr[$index]['devicetype'], $retarr[$index]['devicelocation'], $retarr[$index]['devicevalue'], $retarr[$index]['devicelabel'], $retarr[$index]['devicevalue2'], $retarr[$index]['devicelabel2'], $retarr[$index]['devicevalue3'], $retarr[$index]['devicelabel3'], $retarr[$index]['devicevalue4'], $retarr[$index]['devicelabel4'], $retarr[$index]['devicelastseen'], $retarr[$index]['dimable'], $retarr[$index]['switchable'],$retarr[$index]['battery'],$retarr[$index]['rrd'],$retarr[$index]['graph'],$retarr[$index]['valuerrdname'],$retarr[$index]['value2rrdname'],$retarr[$index]['value3rrdname'],$retarr[$index]['value4rrdname'],$retarr[$index]['valuerrdtype'],$retarr[$index]['value2rrdtype'],$retarr[$index]['value3rrdtype'],$retarr[$index]['value4rrdtype']) = explode (';;', $item);
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

// Get event list
function get_event_list($view) {
	$request = xmlrpc_encode_request("events.list",null);
   	$response = do_xmlrpc($request);

if (xmlrpc_is_fault($response)) {
       trigger_error("xmlrpc: $response[faultString] ($response[faultCode])");
   } else {
      $index=0;
      foreach($response AS $event) {
         list( $retarr[$index]['id'],$retarr[$index]['enabled'], $retarr[$index]['eventname'],$retarr[$index]['log'],$retarr[$index]['firstrun'], $retarr[$index]['lastrun'],$retarr[$index]['description']) = explode (';;', $event);
         
	 $index++;
      }
      if (isset($retarr)) {
         return $retarr;
      } else {
         return FALSE;
      }
   }
}

// Get Thermostat list : id, name, description
function get_scenario_list($view) {
   $request = xmlrpc_encode_request("thermostat.listscenario",null);
   $response = do_xmlrpc($request);

   if (xmlrpc_is_fault($response)) {
       trigger_error("xmlrpc: $response[faultString] ($response[faultCode])");
   } else {
      $index=0;
      foreach($response AS $thermo) {
         list( $retarr[$index]['idthermo'], $retarr[$index]['namethermo'], $retarr[$index]['descriptionthermo']) = explode (';;', $thermo);
        
         $index++;
      }
      if (isset($retarr)) {
         return $retarr;
      } else {
         return FALSE;
      }
   }

}

// Get current thermostat scenario with it's heating : id, name, currenttemperature, requiretemperature
function get_heating($view) {
   $request = xmlrpc_encode_request("thermostat.getscenario",null);
   $response = do_xmlrpc($request);

   if (xmlrpc_is_fault($response)) {
       trigger_error("xmlrpc: $response[faultString] ($response[faultCode])");
   } else {
      $index=0;
      foreach($response AS $heating) {
         list( $retarr[$index]['idheating'], $retarr[$index]['nameheating'], $retarr[$index]['currtempheating'], $retarr[$index]['reqtempheating']) = explode (';;', $heating);
        
         $index++;
      }
      if (isset($retarr)) {
         return $retarr;
      } else {
         return FALSE;
      }
   }

}

// Get all thermostat scenarios with their heatings : id, name, currenttemperature, requiretemperature
function get_all_heating($view) {
   $request = xmlrpc_encode_request("thermostat.getscenarios",null);
   $response = do_xmlrpc($request);

   if (xmlrpc_is_fault($response)) {
       trigger_error("xmlrpc: $response[faultString] ($response[faultCode])");
   } else {
      $index=0;
      foreach($response AS $allheating) {

         list( $retarr[$index]['idheating'], $retarr[$index]['nameheating'], $retarr[$index]['currtempheating'], $retarr[$index]['reqtempheating']) = explode (';;', $allheating);
        
         $index++;
      }
      if (isset($retarr)) {
         return $retarr;
      } else {
         return FALSE;
      }
   }

}

// Get the heating(s) from one scenario : id, name, currenttemperature, requiretemperature
function get_scenario_heating($view,$idscenario) {
   $request = xmlrpc_encode_request("thermostat.getheating",array($idscenario));
   $response = do_xmlrpc($request);

   if (xmlrpc_is_fault($response)) {
       trigger_error("xmlrpc: $response[faultString] ($response[faultCode])");
   } else {
      $index=0;
      foreach($response AS $allheating) {

         list( $retarr[$index]['idheating'], $retarr[$index]['nameheating'], $retarr[$index]['currtempheating'], $retarr[$index]['reqtempheating']) = explode (';;', $allheating);

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

   return $retarr;
}

function get_location($view){

   $request = xmlrpc_encode_request("location.list",null);
   $response = do_xmlrpc($request);
	
   if (xmlrpc_is_fault($response)) {
       trigger_error("xmlrpc: $response[faultString] ($response[faultCode])");
   } else {
      $index=0;
      foreach($response AS $location) {
         list( $retarr[$index]['idlocation'], $retarr[$index]['namelocation']) = explode (';;', $location);
         $index++;
      }
      if (isset($retarr)) {	
         return $retarr;
      } 
      else {
         return FALSE;
	}
    }
}
?>
