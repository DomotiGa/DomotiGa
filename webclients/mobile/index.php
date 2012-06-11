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

// Thanks to Gino!

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
extract($_REQUEST, EXTR_PREFIX_ALL|EXTR_REFS, 'r_');
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="images/favicon.ico" />
<link rel="stylesheet" type="text/css" href="submodal/subModal.css" />
<style type="text/css">
.AfbRandon
{
	border: 2px dotted green;
}
.AfbRandoff
{
	border: 2px solid white;
}
#Taglampekap {
	position:absolute;
	width:128px;
	height:128px;
	z-index:1;
	left: 789px;
	top: 327px;
}
#TagLamp_bureau {
	position:absolute;
	width:128px;
	height:128px;
	z-index:2;
	left: 763px;
	top: 1053px;
}
#TagLamp_AL {
	position:absolute;
	width:128px;
	height:128px;
	z-index:3;
	left: 128px;
	top: 869px;
}
#TagLamp_AR {
	position:absolute;
	width:128px;
	height:128px;
	z-index:4;
	left: 770px;
	top: 869px;
}
#TagLamp_VL {
	position:absolute;
	width:128px;
	height:128px;
	z-index:5;
	left: 128px;
	top: 464px;
}
#TagLamp_VR {
	position:absolute;
	width:128px;
	height:128px;
	z-index:6;
	left: 770px;
	top: 464px;
}
#TagLamp_Lister {
	position:absolute;
	width:128px;
	height:128px;
	z-index:7;
	left: 428px;
	top: 464px;
}
#TagAlle_lichten_uit {
	position:absolute;
	width:780px;
	height:89px;
	z-index:8;
	left: 106px;
	top: 1272px;
}
#TagTemperatureInfo {
	position:absolute;
	width:411px;
	height:221px;
	z-index:9;
	left: 309px;
	top: 775px;
}
</style>
<script type="text/javascript" src="submodal/common.js"></script>
<script type="text/javascript" src="submodal/subModal.js"></script>
<script type="text/javascript" src="domotiga.js"></script>
<script type="text/javascript">
window.onload = function() {
	  setTimeout(function(){window.scrollTo(0, 1);}, 1000);
}
</script>
<script type="application/x-javascript"> 
addEventListener("load", function() { 
	setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 
</script>

<script type="text/javascript">
var toggleLampekap;
function UpdateLampekap()
{
toggleLampekap = !toggleLampekap;
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    	var resptxt = xmlhttp.responseText;
    	if (resptxt == "On")
    	{
    		if (toggleLampekap) {document.getElementById("UpdateLampekap").innerHTML="<a href='control_device.php?device=Lampekap&value=toggle'><img class= 'AfbRandon' src='images/icons/light-on.png' width='128' height='128' /></a>";}
    	   if (!toggleLampekap) {document.getElementById("UpdateLampekap").innerHTML="<a href='control_device.php?device=Lampekap&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-on.png' width='128' height='128' /></a>";}
		}
    	else
    	{
    		if (toggleLampekap) {document.getElementById("UpdateLampekap").innerHTML="<a href='control_device.php?device=Lampekap&value=toggle'><img class= 'AfbRandon' src='images/icons/light-off.png' width='128' height='128' /></a>";}
    		if (!toggleLampekap) {document.getElementById("UpdateLampekap").innerHTML="<a href='control_device.php?device=Lampekap&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-off.png' width='128' height='128' /></a>";} 
    	}
    }
  }
xmlhttp.open("GET","get_device.php?device=Lampekap",true);
xmlhttp.send();
}
window.onload = setInterval("UpdateLampekap()",2000);
</script>
<script type="text/javascript">
var toggleLamp_bureau;
function UpdateLamp_bureau()
{
toggleLamp_bureau = !toggleLamp_bureau;
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    	var resptxt = xmlhttp.responseText;
    	if (resptxt == "On")
    	{
    		if (toggleLamp_bureau) {document.getElementById("UpdateLamp_bureau").innerHTML="<a href='control_device.php?device=Lamp bureau&value=toggle'><img class= 'AfbRandon' src='images/icons/light-on.png' width='128' height='128' /></a>";}
    	   if (!toggleLamp_bureau) {document.getElementById("UpdateLamp_bureau").innerHTML="<a href='control_device.php?device=Lamp bureau&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-on.png' width='128' height='128' /></a>";}
		}
    	else
    	{
    		if (toggleLamp_bureau) {document.getElementById("UpdateLamp_bureau").innerHTML="<a href='control_device.php?device=Lamp bureau&value=toggle'><img class= 'AfbRandon' src='images/icons/light-off.png' width='128' height='128' /></a>";}
    		if (!toggleLamp_bureau) {document.getElementById("UpdateLamp_bureau").innerHTML="<a href='control_device.php?device=Lamp bureau&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-off.png' width='128' height='128' /></a>";} 
    	}
    }
  }
xmlhttp.open("GET","get_device.php?device=Lamp bureau",true);
xmlhttp.send();
}
window.onload = setInterval("UpdateLamp_bureau()",2000);
</script>
<script type="text/javascript">
var toggleLamp_AR;
function UpdateLamp_AR()
{
toggleLamp_AR = !toggleLamp_AR;
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    	var resptxt = xmlhttp.responseText;
    	if (resptxt == "On")
    	{
    		if (toggleLamp_AR) {document.getElementById("UpdateLamp_AR").innerHTML="<a href='control_device.php?device=Lamp AR&value=toggle'><img class= 'AfbRandon' src='images/icons/light-on.png' width='128' height='128' /></a>";}
    	   if (!toggleLamp_AR) {document.getElementById("UpdateLamp_AR").innerHTML="<a href='control_device.php?device=Lamp AR&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-on.png' width='128' height='128' /></a>";}
		}
    	else
    	{
    		if (toggleLamp_AR) {document.getElementById("UpdateLamp_AR").innerHTML="<a href='control_device.php?device=Lamp AR&value=toggle'><img class= 'AfbRandon' src='images/icons/light-off.png' width='128' height='128' /></a>";}
    		if (!toggleLamp_AR) {document.getElementById("UpdateLamp_AR").innerHTML="<a href='control_device.php?device=Lamp AR&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-off.png' width='128' height='128' /></a>";} 
    	}
    }
  }
xmlhttp.open("GET","get_device.php?device=Lamp AR",true);
xmlhttp.send();
}
window.onload = setInterval("UpdateLamp_AR()",2000);
</script>
<script type="text/javascript">
var toggleLamp_AL;
function UpdateLamp_AL()
{
toggleLamp_AL = !toggleLamp_AL;
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    	var resptxt = xmlhttp.responseText;
    	if (resptxt == "On")
    	{
    		if (toggleLamp_AL) {document.getElementById("UpdateLamp_AL").innerHTML="<a href='control_device.php?device=Lamp AL&value=toggle'><img class= 'AfbRandon' src='images/icons/light-on.png' width='128' height='128' /></a>";}
    	   if (!toggleLamp_AL) {document.getElementById("UpdateLamp_AL").innerHTML="<a href='control_device.php?device=Lamp AL&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-on.png' width='128' height='128' /></a>";}
		}
    	else
    	{
    		if (toggleLamp_AL) {document.getElementById("UpdateLamp_AL").innerHTML="<a href='control_device.php?device=Lamp AL&value=toggle'><img class= 'AfbRandon' src='images/icons/light-off.png' width='128' height='128' /></a>";}
    		if (!toggleLamp_AL) {document.getElementById("UpdateLamp_AL").innerHTML="<a href='control_device.php?device=Lamp AL&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-off.png' width='128' height='128' /></a>";} 
    	}
    }
  }
xmlhttp.open("GET","get_device.php?device=Lamp AL",true);
xmlhttp.send();
}
window.onload = setInterval("UpdateLamp_AL()",2000);
</script>
<script type="text/javascript">
var toggleLamp_VR;
function UpdateLamp_VR()
{
toggleLamp_VR = !toggleLamp_VR;
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    	var resptxt = xmlhttp.responseText;
    	if (resptxt == "On")
    	{
    		if (toggleLamp_VR) {document.getElementById("UpdateLamp_VR").innerHTML="<a href='control_device.php?device=Lamp VR&value=toggle'><img class= 'AfbRandon' src='images/icons/light-on.png' width='128' height='128' /></a>";}
    	   if (!toggleLamp_VR) {document.getElementById("UpdateLamp_VR").innerHTML="<a href='control_device.php?device=Lamp VR&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-on.png' width='128' height='128' /></a>";}
		}
    	else
    	{
    		if (toggleLamp_VR) {document.getElementById("UpdateLamp_VR").innerHTML="<a href='control_device.php?device=Lamp VR&value=toggle'><img class= 'AfbRandon' src='images/icons/light-off.png' width='128' height='128' /></a>";}
    		if (!toggleLamp_VR) {document.getElementById("UpdateLamp_VR").innerHTML="<a href='control_device.php?device=Lamp VR&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-off.png' width='128' height='128' /></a>";} 
    	}
    }
  }
xmlhttp.open("GET","get_device.php?device=Lamp VR",true);
xmlhttp.send();
}
window.onload = setInterval("UpdateLamp_VR()",2000);
</script>
<script type="text/javascript">
var toggleLamp_VL;
function UpdateLamp_VL()
{
toggleLamp_VL = !toggleLamp_VL;
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    	var resptxt = xmlhttp.responseText;
    	if (resptxt == "On")
    	{
    		if (toggleLamp_VL) {document.getElementById("UpdateLamp_VL").innerHTML="<a href='control_device.php?device=Lamp VL&value=toggle'><img class= 'AfbRandon' src='images/icons/light-on.png' width='128' height='128' /></a>";}
    	   if (!toggleLamp_VL) {document.getElementById("UpdateLamp_VL").innerHTML="<a href='control_device.php?device=Lamp VL&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-on.png' width='128' height='128' /></a>";}
		}
    	else
    	{
    		if (toggleLamp_VR) {document.getElementById("UpdateLamp_VL").innerHTML="<a href='control_device.php?device=Lamp VL&value=toggle'><img class= 'AfbRandon' src='images/icons/light-off.png' width='128' height='128' /></a>";}
    		if (!toggleLamp_VR) {document.getElementById("UpdateLamp_VL").innerHTML="<a href='control_device.php?device=Lamp VL&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-off.png' width='128' height='128' /></a>";} 
    	}
    }
  }
xmlhttp.open("GET","get_device.php?device=Lamp VL",true);
xmlhttp.send();
}
window.onload = setInterval("UpdateLamp_VL()",2000);
</script>
<script type="text/javascript">
var toggleLamp_lister;
function UpdateLamp_lister()
{
toggleLamp_lister = !toggleLamp_lister;
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    	var resptxt = xmlhttp.responseText;
    	if (resptxt == "On")
    	{
    		if (toggleLamp_lister) {document.getElementById("UpdateLamp_lister").innerHTML="<a href='control_device.php?device=Lamp lister&value=toggle'><img class= 'AfbRandon' src='images/icons/light-on.png' width='128' height='128' /></a>";}
    	   if (!toggleLamp_lister) {document.getElementById("UpdateLamp_lister").innerHTML="<a href='control_device.php?device=Lamp lister&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-on.png' width='128' height='128' /></a>";}
		}
    	else
    	{
    		if (toggleLamp_lister) {document.getElementById("UpdateLamp_lister").innerHTML="<a href='control_device.php?device=Lamp lister&value=toggle'><img class= 'AfbRandon' src='images/icons/light-off.png' width='128' height='128' /></a>";}
    		if (!toggleLamp_lister) {document.getElementById("UpdateLamp_lister").innerHTML="<a href='control_device.php?device=Lamp lister&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-off.png' width='128' height='128' /></a>";} 
    	}
    }
  }
xmlhttp.open("GET","get_device.php?device=Lamp lister",true);
xmlhttp.send();
}
window.onload = setInterval("UpdateLamp_lister()",2000);
</script>
<script type="text/javascript">
function UpdateTempHobby()
{
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    	var resptxt = xmlhttp.responseText;
    	document.getElementById("UpdateTempHobby").innerHTML="Temp hobby: " + resptxt;
    }
  }
xmlhttp.open("GET","get_device.php?device=Temp hobby",true);
xmlhttp.send();
}
window.onload = setInterval("UpdateTempHobby()",10000);
</script>
<script type="text/javascript">
function UpdateTempBuiten()
{
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    	var resptxt = xmlhttp.responseText;
    	document.getElementById("UpdateTempBuiten").innerHTML="Temp buiten: " + resptxt;
    }
  }
xmlhttp.open("GET","get_device.php?device=Temp buiten",true);
xmlhttp.send();
}
window.onload = setInterval("UpdateTempBuiten()",10000);
</script>
</head>
<title>DomotiGa</title>
<h1><img src="images/floorplans/schelf4.jpg" width="960" height="1440" alt="" /></h1>
<div id="TagLamp_VR">
<?php
$state = get_devicestate("Lamp VR");
if ($state == "On"){
	echo "<a id='UpdateLamp_VR' href='control_device.php?device=Lamp VR&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-on.png' width='128' height='128' /></a>";
} 
else {
	echo "<a id='UpdateLamp_VR' href='control_device.php?device=Lamp VR&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-off.png' width='128' height='128' /></a>";
}
?>
</div>
<div id="TagLamp_AL">
<?php
$state = get_devicestate("Lamp AL");
if ($state == "On"){
	echo "<a id='UpdateLamp_AL' href='control_device.php?device=Lamp AL&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-on.png' width='128' height='128' /></a>";
} 
else {
	echo "<a id='UpdateLamp_AL' href='control_device.php?device=Lamp AL&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-off.png' width='128' height='128' /></a>";
}
?>
</div>
<div id="TagLamp_AR">
<?php
$state = get_devicestate("Lamp AR");
if ($state == "On"){
	echo "<a id='UpdateLamp_AR' href='control_device.php?device=Lamp AR&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-on.png' width='128' height='128' /></a>";
} 
else {
	echo "<a id='UpdateLamp_AR' href='control_device.php?device=Lamp AR&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-off.png' width='128' height='128' /></a>";
}
?>
</div>
<div id="TagLamp_VL">
  <?php
$state = get_devicestate("Lamp VL");
if ($state == "On"){
	echo "<a id='UpdateLamp_VL' href='control_device.php?device=Lamp VL&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-on.png' width='128' height='128' /></a>";
} 
else {
	echo "<a id='UpdateLamp_VL' href='control_device.php?device=Lamp VL&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-off.png' width='128' height='128' /></a>";
}
?>
</div>
<div id="TagAlle_lichten_uit">
<input type=button onClick="location.href='control_device.php?device=Alle lichten uit&value=On'" value='Alle lichten uit' style="width:780px;height:89px;font-size:400%">
</div>
<div id="TagTemperatureInfo">
<?php
$TempHobby = get_devicestate("Temp hobby");
	echo "<h1 id='UpdateTempHobby'>Temp hobby: ";
	echo $TempHobby;
	echo "</h1>";
$TempBuiten = get_devicestate("Temp buiten");
	echo "<h1 id='UpdateTempBuiten'/>Temp buiten: ";
	echo $TempBuiten;
	echo "</h1>";
?>
</div>
<div id="TagLamp_bureau">
  <?php
$state = get_devicestate("Lamp bureau");
if ($state == "On"){
	echo "<a id='UpdateLamp_bureau' href='control_device.php?device=Lamp bureau&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-on.png' width='128' height='128' /></a>";
} 
else {
	echo "<a id='UpdateLamp_bureau' href='control_device.php?device=Lamp bureau&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-off.png' width='128' height='128' /></a>";
}
?>
</div>
<div id="TagLamp_Lister">
  <?php
$state = get_devicestate("Lamp lister");
if ($state == "On"){
	echo "<a id='UpdateLamp_lister' href='control_device.php?device=Lamp lister&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-on.png' width='128' height='128' /></a>";
} 
else {
	echo "<a id='UpdateLamp_lister' href='control_device.php?device=Lamp lister&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-off.png' width='128' height='128' /></a>";
}
?>
</div>
<div id="Taglampekap">
  <?php
$state = get_devicestate("Lampekap");
if ($state == "On"){
	echo "<a id='UpdateLampekap' href='control_device.php?device=Lampekap&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-on.png' width='128' height='128' /></a>";
} 
else {
	echo "<a id='UpdateLampekap' href='control_device.php?device=Lampekap&value=toggle'><img class= 'AfbRandoff' src='images/icons/light-off.png' width='128' height='128' /></a>";
}
?>
</div>
</body>
</html>
