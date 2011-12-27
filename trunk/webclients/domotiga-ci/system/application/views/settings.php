<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="images/favicon.ico" />
<title>DomotiGa</title>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body >
<div class='modal'>
<form method='post' action='index.php/settings'>
<h3>Settings</h3>
<p>&nbsp;</p>
<p><label for='setrefresh'>Refresh interval:</label>
<select name='setrefresh' id='setrefresh'>
<?php foreach (array(0=>"Off",2000=>"2 secs",5000=>"5 secs",10000=>"10 secs",20000=>"20 secs",30000=>"30 secs",60000=>"1 min",300000=>"5 mins",60000=>"10 mins") as $ms=>$txt) {
   echo "<option value=$ms ".($_SESSION['refresh']==$ms ? "selected" : "").">$txt</option>\n";
} ?>
</select>
</p>
<p>&nbsp;</p>
<p><input type='submit' onclick=\"parent.window.location='index.php';\" value='Cancel' />&nbsp;<input type='submit' name='submit' value='Save' /></p>
</form>
</div>
</body>
</html>
