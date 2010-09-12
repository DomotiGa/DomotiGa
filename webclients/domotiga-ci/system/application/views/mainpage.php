<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="images/favicon.ico" />
<link rel="stylesheet" type="text/css" href="submodal/subModal.css" />
<script type="text/javascript" src="submodal/common.js"></script>
<script type="text/javascript" src="submodal/subModal.js"></script>
<script type="text/javascript" src="domotiga.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript" language="Javascript">
function start(view,timer) {
   startajax(view);
   setInterval("startajax('"+view+"')",timer)
   clock();
}
</script>
<script type="text/javascript" language="Javascript">
$(document).ready(function(){
	$("#program_version").load("<?=site_url()."/json/get_version/"?>");
});
</script>
<title>DomotiGa</title>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<?php
echo "<body ".($_SESSION['refresh']!=0 ? "onload=\"start('".$_SESSION['view']."',".$_SESSION['refresh'].")\"" : "").">\n";
// Wrap
echo "<div id='wrap'>\n";
// Title
echo "<div id='header'>\n";
echo "<h1><a href='index.php/reload/1'><img src='images/logo.png' alt='logo'></img></a></h1><br/>\n";
echo "<div id='boxright'>\n";

// Status
echo "<p>\n";
//echo "House Mode: <span class='inline house' id='house_mode'>".$status['house_mode']."</span>&nbsp;&nbsp;&nbsp;\n";
echo "Version: <span class='inline version' id='program_version'>unknown</span>\n";
echo "</p>\n";

// Settings
echo "<p><a class='submodal-600-520' href='index.php/settings'>Settings</a></p>\n";
echo "</div>\n";
echo "</div>\n";
// Title End

// Tabs
echo "<div id='navcontainer'>\n";
echo "<ul id='navlist'>\n";
echo "<li><a ".($_SESSION['view']=="main" ? "id='current'" : "")." href='?setview=main'>Devices</a></li>\n";
echo "<li><a ".($_SESSION['view']=="control" ? "id='current'" : "")."href='?setview=control'>Control</a></li>\n";
if ($debugtab) {
   echo "<li><a ".($debug==1 ? "id='current'" : "")."href='?setview=main&amp;debug=1'>Debug</a></li>\n";
}
echo "</ul>\n";
echo "</div>\n";
echo "<div class ='container'>\n";

if ($_SESSION['view']=="main") {

   // Header
   $uparr="<img src='images/uparrow.gif' height='8' width='5' alt='Descending' />";
   $downarr="<img src='images/downarrow.gif' height='8' width='5' alt='Ascending' />";

   echo "<div class='headcol' style='width:25px;'><a href='?setsortkey=deviceicon&amp;setsortord=".($sortord=="asc" ? "desc" : "asc")."'>&nbsp;S</a>&nbsp;".($sortkey=="deviceicon" ? ($sortord=="asc" ? "$downarr" : "$uparr") :"")."</div>\n";
   echo "<div class='headcol' style='width:171px;'><a href='?setsortkey=devicename&amp;setsortord=".($sortord=="asc" ? "desc" : "asc")."'>Device</a>&nbsp;".($sortkey=="devicename" ? ($sortord=="asc" ? "$downarr" : "$uparr") :"")."</div>\n";
   echo "<div class='headcol' style='width:112px;'><a href='?setsortkey=devicelocation&amp;setsortord=".($sortord=="asc" ? "desc" : "asc")."'>Location</a>&nbsp;".($sortkey=="devicelocation" ? ($sortord=="asc" ? "$downarr" : "$uparr") :"")."</div>\n";
   echo "<div class='headcol' style='width:101px;'><a href='?setsortkey=devicevalue&amp;setsortord=".($sortord=="asc" ? "desc" : "asc")."'>Value1</a>&nbsp;".($sortkey=="devicevalue" ? ($sortord=="asc" ? "$downarr" : "$uparr") :"")."</div>\n";
   echo "<div class='headcol' style='width:101px;'><a href='?setsortkey=devicevalue2&amp;setsortord=".($sortord=="asc" ? "desc" : "asc")."'>Value2</a>&nbsp;".($sortkey=="devicevalue2" ? ($sortord=="asc" ? "$downarr" : "$uparr") :"")."</div>\n";
   echo "<div class='headcol' style='width:101px;'><a href='?setsortkey=devicevalue3&amp;setsortord=".($sortord=="asc" ? "desc" : "asc")."'>Value3</a>&nbsp;".($sortkey=="devicevalue3" ? ($sortord=="asc" ? "$downarr" : "$uparr") :"")."</div>\n";
   echo "<div class='headcol' style='width:100px;'><a href='?setsortkey=devicevalue4&amp;setsortord=".($sortord=="asc" ? "desc" : "asc")."'>Value4</a>&nbsp;".($sortkey=="devicevalue4" ? ($sortord=="asc" ? "$downarr" : "$uparr") :"")."</div>\n";
   echo "<div class='headcollast' style='width:241px;'><a href='?setsortkey=devicelastseen&amp;setsortord=".($sortord=="asc" ? "desc" : "asc")."'>Last Seen</a>&nbsp;".($sortkey=="devicelastseen" ? ($sortord=="asc" ? "$downarr" : "$uparr") :"")."</div>\n";
   // End of header

   echo "<div class='spacer'></div>\n";

   if ($debug==1) {
      echo "<br><pre>";
      echo htmlspecialchars(var_dump($data));
      echo "</pre>";
   }

   // List devices
   $totcount=0;
   $thisrow="row1";
   foreach($data AS $item) {
      echo "<div class='$thisrow'>\n";
      echo "<div class='imgcol' style='width:20px;' id='i".$item['id']."deviceicon'>&nbsp;".$item['deviceicon']."</div>\n";
      echo "<div class='datacol' style='width:170px;' id='i".$item['id']."devicename'>&nbsp;".$item['devicename']."</div>\n";
      echo "<div class='datacol' style='width:110px;' id='i".$item['id']."devicelocation'>&nbsp;".$item['devicelocation']."</div>\n";
      echo "<div class='datacol' style='width:100px;' id='i".$item['id']."devicevalue'>&nbsp;".$item['devicevalue']."</div>\n";
      echo "<div class='datacol' style='width:100px;' id='i".$item['id']."devicevalue2'>&nbsp;".$item['devicevalue2']."</div>\n";
      echo "<div class='datacol' style='width:100px;' id='i".$item['id']."devicevalue3'>&nbsp;".$item['devicevalue3']."</div>\n";
      echo "<div class='datacol' style='width:100px;' id='i".$item['id']."devicevalue4'>&nbsp;".$item['devicevalue4']."</div>\n";
      echo "<div class='datacollast' style='width:190px;' id='i".$item['id']."devicelastseen'>&nbsp;".$item['devicelastseen']."</div>\n";
      echo "<div class='spacer'></div>\n";
      echo "</div>\n"; // End of thisrow div
      if ($thisrow=="row1") {$thisrow="row2";} else {$thisrow="row1";}
   }

   // Display message if no devices are found
   if (!$data) {
      echo "<div class='row1'>\n";
      echo "<div class='namecol' align='center'><p>&nbsp;</p>No devices to display!<p>&nbsp;</p></div>\n";
      echo "</div>\n";
   }
}

//if ($_SESSION['view']=="control") {

//}

echo "</div>\n"; // End of container div

// Bottom tab
echo "<div class='bottomtab'>";
echo "<div class='bottomline'>";
echo "Mode: <span class='mode' id='mute_mode'>".$status['mute_mode']."</span>&nbsp;<span class='mode' id='house_mode'>".$status['house_mode']."</span>&nbsp;\n";
echo "<span class='imgstat'><img src='images/icons/sun.png' height='16' width='16' alt='Sunrise' />&nbsp;</span><span class='mode' id='data_sunrise'>".$status['data_sunrise']."&nbsp;<span class='imgstat'><img src='images/icons/sunset.png' height='16' width='16' alt='Sunset' /></span></span>&nbsp;<span class='mode' id='data_sunset'>".$status['data_sunset']."</span>&nbsp;\n";
echo "<span class='msgs' id='data_newmails'>".$status['data_newmails']."</span>&nbsp;e-mails&nbsp;&nbsp;<span class='msgs' id='data_newcalls'>".$status['data_newcalls']."</span>&nbsp;calls\n";
echo "<span class='msgs' id='data_newvoicemails'>".$status['data_newvoicemails']."</span>&nbsp;voicemails <div class='clockspan' id='digitalclock'></div></div></div>";

// Footer
echo "<div align='center' class='smalltext'>Page created in ".$this->benchmark->elapsed_time()." secs.  ";
echo "<a href='http://domotiga.nl' target='_blank'>DomotiGa V".$status['program_version']."</a> - by Ron Klinkien 2008-2010.</div>\n";
?>
</div>
</body>
</html>
