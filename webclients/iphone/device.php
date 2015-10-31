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
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
<script type="text/javascript" src="domotiga.js"></script>
<title>DomotiGa</title>
<link rel="stylesheet" href="stylesheets/iphone.css" />
       <style>
               .ui-widget-content {
                       background:none;
                       border:1px solid #AAAAAA;
                       color:#222222; }
               .ui-corner-all {
                       -moz-border-radius:11px 11px 11px 11px;
                       -webkit-border-radius:11px; }
       </style>
<?php
// Get list of devices
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

if (is_array($data)) {
   $sortkey="devicename";
   usort($data,'sort_matches_asc');
} else {
   $data=array();
}

// Get list of switchable devices
$datas=get_device_listtype("switch");
if (!is_array($datas))
{
   $datas=array();
}

// Get list of dimmable devices
$datad=get_device_listtype("dim");
if (!is_array($datad))
{
   $datad=array();
}

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
   foreach ($datad AS $itemd) {
      if ($item['id'] == $itemd['id']) {
        echo "div#optionpanel".$item['id']." {\n";
        echo "background: url(images/blackbg.png) top left repeat-x;\n";
        echo "text-align: center;\n";
        //echo "padding: 20px 10px 15px 10px;\n";
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
   function dim_light(dLocation,dName,dValue) {
      var actionUrl = "change_device.php?location="+dLocation+"&device="+dName+"&value=";
      if ( dValue == "0" ) { actionUrl += "Off" } else if ( dValue == "100" ) { actionUrl += "On" } else { actionUrl += "Dim "+dValue };
      $.ajax({
        url: actionUrl,
        success: function () {
          window.location.href = "device.php?location="+dLocation;
        }
      })
   }

   function setpoint(dLocation,dName,dValue) {
      var actionUrlsetpoint = "change_device.php?location="+dLocation+"&device="+dName+"&value=";
      if ( dValue.indexOf('.') == -1) { actionUrlsetpoint += "SP "+dValue+".0" } else { actionUrlsetpoint += "SP "+dValue };
      $.ajax({
        url: actionUrlsetpoint,
        success: function () {
          window.location.href = "device.php?location="+dLocation;
        }
      })
   }
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
if ( $locations ) {
  echo "<a href=\"locations.php\" class=\"nav\" id=\"backButton\">Locations</a>\n";
} else {
  echo "<a href=\"index.php\" class=\"nav\" id=\"backButton\">Home</a>\n";
}
echo "</div>\n";
echo "<ul>\n";
foreach ($data AS $item) {
   echo "<li";	
   foreach ($datas AS $items) {	
      if ($item['id'] == $items['id']) { echo " class=\"arrow\"><a href=\"#\" onclick=\"showhide('optionpanel".$item['id']."');\"";}
   }
   foreach ($datad AS $itemd) {
      if ($item['id'] == $itemd['id']) { echo " class=\"arrow\"><a href=\"#\" onclick=\"showhide('optionpanel".$item['id']."');\"";}
   }
   echo "><small>".$item['devicevalue1']."</small>".$item['deviceicon'].$item['devicename']."</a></li>\n";
}
echo "</ul>\n";
?>
<p><strong>Best enjoyed on a real iPhone</strong><br />This iPhone UI Framework kit is licenced under GNU Affero General Public License (<a href="http://www.gnu.org/licenses/agpl.html">GNU AGPL 3</a>)</p>
<?php
foreach ($data AS $item) {
   foreach ($datas AS $items) {	
      if ($item['id'] == $items['id']) { 
         echo "<div id=\"optionpanel".$item['id']."\" style=\"display: none\">\n";
         echo "<p><a class=\"green button\" href=\"change_device.php?location=".$item['devicelocation']."&device=".$item['id']."&value=On\">On</a> <a href=\"change_device.php?location=".$item['devicelocation']."&device=".$item['id']."&value=Off\" class=\"red button\">Off</a><a href=\"#\" class=\"black button\" onclick=\"showhide('optionpanel".$item['id']."');\">Cancel</a></p>  \n";
	 echo "</div>\n";
      }
   }
    foreach ($datad AS $itemd) {
        if ($item['id'] == $itemd['id']) {
            if (substr($itemd['devicevalue1'],0,3) == "Dim" || $itemd['devicevalue1'] == "" || $itemd['devicevalue1'] == "Off" || $itemd['devicevalue1'] == "On"){
                preg_match_all('!\d+!', $itemd['devicevalue1'], $dimlevel); $dimlevel=implode($dimlevel[0]);
                echo "<div id=\"optionpanel".$item['id']."\" style=\"display: none\">\n";
                if ($itemd['devicevalue1'] == ""){ $dimlevel = "0"; };
                if ($itemd['devicevalue1'] == "Off"){ $dimlevel = "0"; };
                if ($itemd['devicevalue1'] == "On"){ $dimlevel = "100"; };
                echo "<p><a class=\"green button\" href=\"change_device.php?location=".$item['devicelocation']."&device=".$item['id']."&value=On\">On</a></p>";
                echo "<p><a class=\"red button\" href=\"change_device.php?location=".$item['devicelocation']."&device=".$item['id']."&value=Off\">Off</a></p>";
                // Slider to Set Dim
                echo "<p><a id=\"dimmer".$item['id']."\" class=\"button slider\" style=\"width: 94%; height: 20px; margin-left: 3%;\">".$dimlevel."</a></p>\n";
                echo "<p><a class=\"white button\" onclick=\"dim_light('".$item['devicelocation']."', '".$item['id']."', $('#dimmer".$item['id']."').text())\">Ok</a></p>";
                echo "<p><a href=\"#\" class=\"black button\" onclick=\"showhide('optionpanel".$item['id']."');\">Cancel</a></p>  \n";
                echo "</div>\n";
            }
            if (substr($itemd['devicevalue1'],0,2) == "SP"){
                preg_match_all('!\d+\.*\d+!', $itemd['devicevalue1'], $dimlevel);
                $dimlevel=implode($dimlevel[0]);
                echo "<div id=\"optionpanel".$item['id']."\" style=\"display: none\">\n";
                // Slider to Set Setpoint
                echo "<p><a id=\"dimmer".$item['id']."\" class=\"button sliderSP\" style=\"width: 94%; height: 30px; margin-left: 3%;\">".$dimlevel."</a></p>\n";
                echo "<p><a class=\"green button\" onclick=\"setpoint('".$item['devicelocation']."', '".$item['id']."', $('#dimmer".$item['id']."').text())\">Set</a></p>";
                echo "<p><a href=\"#\" class=\"black button\" onclick=\"showhide('optionpanel".$item['id']."');\">Cancel</a></p>  \n";
                echo "</div>\n";
            }
        }
   }
}
?>
<script>
       $(function() {
               // set up event converters
               document.addEventListener("touchstart", touchHandler, false);
               document.addEventListener("touchmove", touchHandler, false);
               document.addEventListener("touchend", touchHandler, false);
               document.addEventListener("touchcancel", touchHandler, false);
               $( ".slider" ).each(function() {
                       var value = parseInt( $( this ).text(), 10 );
                       $( this ).empty().slider({
                               value: value,
                               orientation: "horizontal",
                               min: 0,
                               max: 100,
                               step: 5,
                               slide: function(event, ui) {
                                       m_val = ui.value;
                                       if (m_val < 0) {
                                               m_val = 0;
                                               $(this).slider({ value: 0 });
                                       }
                                       $(this).find("a:first").text(m_val);
                               }
                       });
               });

               $( ".sliderSP" ).each(function() {
                       var value = parseInt( $( this ).text(), 10 );
                       $( this ).empty().slider({
                               value: value,
                               orientation: "horizontal",
                               min: 4,
                               max: 28,
                               step: .5,
                               slide: function(event, ui) {
                                       m_val = ui.value;
                                       if (m_val < 4) {
                                               m_val = 4;
                                               $(this).slider({ value: 4 });
                                       }
                                       $(this).find("a:first").text(m_val);
                               }
                       });
               });

               //$("#amount").val(':' + $(".slider").slider("value"));
               $('.ui-slider-handle').height(40);

               /*
               $(".ui-slider-handle").click(function(event) {
                       //alert(event);
                       event.preventDefault();
               });
               */
       });
       // simulation of events
       function touchHandler(event) {
               var touches = event.changedTouches,
                       first = touches[0],
                       type = "";
               switch(event.type) {
                       // Commented out due to a scrolling bug.
                       // case "touchstart": type = "mousedown"; break;
                       // case "touchmove" : type="mousemove"; event.preventDefault(); break;
                       // case "touchend"  : type="mouseup"; break;
                       default: return;
               }
               var simulatedEvent = document.createEvent("MouseEvent");
               simulatedEvent.initMouseEvent(type, true, true, window, 1, first.screenX, first.screenY, first.clientX, first.clientY, false, false, false, false, 0, null);
               first.target.dispatchEvent(simulatedEvent);
       }

</script>
</body>
</html>
