<?
include "init.php";

echo "<h3>Requested to turn ".$_GET['namethermo'].".</h3>";
$request = xmlrpc_encode_request("thermostat.setscenario",array($_GET['namethermo']) );
$response = do_xmlrpc($request);
$add = split('[?]',$_SERVER['HTTP_REFERER']); 
header("Location: index.php?".$add[1]);

php?>
