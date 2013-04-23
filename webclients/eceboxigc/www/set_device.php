<?
include "init.php";

//echo "<h3>Requested to turn ".$_GET['name'] . ' ' . $_GET['action'].".</h3>";
$request = xmlrpc_encode_request("device.setdevice",array( $_GET['name'], $_GET['action'] ) );
$response = do_xmlrpc($request);
$add = split('[?]',$_SERVER['HTTP_REFERER']);
header("Location: index.php?".$add[1]);

php?>
