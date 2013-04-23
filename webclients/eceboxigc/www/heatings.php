<?php

// Get list of scenarii
$list_scenarii=get_scenario_list($_SESSION['view']);

// Get list of heating from the enabled scenario
$list_heating=get_heating($_SESSION['view']);

// Get list of all heating from all the scenario
$list_all_heating=get_all_heating($_SESSION['view']);

// Get list of all heating
   foreach($list_scenarii AS $scenario) {
	$list_heatings[$scenario['idthermo']] = get_scenario_heating($_SESSION['view'],$scenario['idthermo']);
}

if(isset($_GET['setscenario'])){
   echo "<h3>Requested to turn ".$_GET['setscenario'].".</h3>";
   $request = xmlrpc_encode_request("thermostat.setscenario",array($_GET['setscenario']) );
   $response = do_xmlrpc($request);
  	$add = split('[?]',$_SERVER['HTTP_REFERER']); 
	header("Location: index.php?".$add[1]);
}

if(isset($_GET['derogateheating'])){
	if ($_GET['commande']=='plus'){
		$request = xmlrpc_encode_request("thermostat.derogateheating",array($_GET['derogateheating'],$_GET['idheating'],'+')) ;
		$response = do_xmlrpc($request);
	} else {
		echo "<h3>Requested to turn ".$_GET['commande'].$_GET['derogateheating'].".</h3>";
		$request = xmlrpc_encode_request("thermostat.derogateheating",array($_GET['derogateheating'],$_GET['idheating'],'-')) ;
		$response = do_xmlrpc($request);
	}
   $add = split('[?]',$_SERVER['HTTP_REFERER']); 
	header("Location: index.php?".$add[1]);
}

php?>

<h2>CONTROL HEATING SCENARIO</h2>
<!--
<div id="radioheating">
<input type="radio" id="radio1" name="radio" /><label for="radio1">Choice 1</label>
<input type="radio" id="radio2" name="radio" checked="checked" /><label for="radio2">Choice 2</label>
<input type="radio" id="radio6" name="radio" /><label for="radio6">Choice 3</label>
</div>

<h3>List of heating scenarios</h3>
		<table class="table table-hover">
		    <thead>
			<tr>
			    <th>Name</th>
			    <th>Description</th>
			    <th>Enabled</th>
			</tr>
		    </thead>
<tbody>-->

<?php
echo "<div id=\"radioheating\">";

if ($list_heating[1]['nameheating']=="") {
	echo "<input type=\"radio\" id=\"radio0\" name=\"radio\" checked=\"checked\" onclick=\"document.location.href='index.php?page=heatings&setscenario='\" /><label for=\"radio0\">Off</label>";
} else {
	echo "<input type=\"radio\" id=\"radio0\" name=\"radio\"  onclick=\"document.location.href='index.php?page=heatings&setscenario='\" /><label for=\"radio0\">Off</label>";
}

foreach($list_scenarii AS $thermostat) {
		if ($thermostat['namethermo']==$list_heating[0]['nameheating']) {
		echo "
		<input type=\"radio\" id=\"radio".$thermostat['idthermo']."\" name=\"radio\" checked=\"checked\" /><label for=\"radio".$thermostat['idthermo']."\">".$thermostat['namethermo']."</label>
		";
		} else {
		echo "<input type=\"radio\" id=\"radio".$thermostat['idthermo']."\" name=\"radio\" onclick=\"document.location.href='index.php?page=heatings&setscenario=".$thermostat['namethermo']."'\" /><label for=\"radio".$thermostat['idthermo']."\">".$thermostat['namethermo']."</label>";
		}

   }
echo "</div>";

/*
  foreach($list_scenarii AS $thermostat) {
		if (($thermostat['namethermo']==$list_heating[0]['nameheating'])&&($list_heating[0]['nameheating']!="")) {
		echo "<tr> 	
		<td> ".$thermostat['namethermo']." </td> 
		<td> ".$thermostat['descriptionthermo']." </td>
		<td>
			<div class=\"toggle\" > 
				<div class=\"slider-frame \"><span onclick=\"document.location.href='index.php?page=heatings&setscenario='\" class=\"slider-button on\">ON</span>
				</div>
			</div>
		</td>
		</tr> ";
		} else {
		echo "<tr> 	
		<td> ".$thermostat['namethermo']." </td> 
		<td> ".$thermostat['descriptionthermo']." </td>
		<td>
			<div class=\"toggle\" > 
				<div class=\"slider-frame \"><span onclick=\"document.location.href='index.php?page=heatings&setscenario=".$thermostat['namethermo']."'\" class=\"slider-button off\">OFF</span>
				</div>
			</div>
		</td>
		</tr> ";
		}

   }*/

php?>

</tbody>
</table> 
	
<?php
	$index = 0;
	
	if ($list_heating[1] != "") {
		echo "
			<table class=\"table table-hover\">
		    <thead>
			<tr>
			    <th>Name</th>
			    <th>Current Temperature</th>
			    <th>Requested Temperature</th>
			</tr>
		    </thead>
		    <tbody>

		" ;
	
		foreach($list_heating AS $heating) {
			$index++;
			if ($index>1) {
				echo 
				"<a>
					<tr>
						<td> ".$heating['nameheating']." </td>
						<td>".$heating['currtempheating']."°C  </td>
					 	<td>".$heating['reqtempheating']."°C </td>
						<td>
			      				<button type= button style=\"display: inline-block ;\" class=\"btn btn-info\" onclick=\"document.location.href='index.php?page=heatings&derogateheating=".$list_heating[0]['idheating']."&idheating=".$heating['idheating']."&commande=plus'\">+</button>
    				<button style=\"display: inline-block ;\" class=\"btn btn-info\" onclick=\"document.location.href='index.php?page=heatings&derogateheating=".$list_heating[0]['idheating']."&idheating=".$heating['idheating']."&commande='\">-</button>
						</td>
					</tr>
				</a>";
			}
		}
	} else if ($list_heating[0]['nameheating']!="") {
			echo "<p>No heating available for this scenario.</p>";
		}

php?>


</tbody>
</table> 

<h2>HEATINGS</h2>

<div id="menuheating">
<?php
foreach($list_scenarii AS $scenario) {
	echo "
	<ul class=\"iconlist\">
        	<li class= \"arrow \">
			<h3>".$scenario['namethermo']."</h3>
		</li>
	</ul>";


echo "<div class=\"submenu\">";
echo "<table class=\"table table-hover\">
				    <thead>
					<tr>
					    <th>Name</th>
					    <th>Current Temperature</th>
					    <th>Reqeuested Temperature</th>
					</tr>
				    </thead>
				    <tbody>";
	foreach($list_heatings[$scenario['idthermo']] AS $heating) {
			echo 
			"<a>
				<tr>
					<td> ".$heating['nameheating']." </td>
					<td>".$heating['currtempheating']."°C  </td>
				 	<td>".$heating['reqtempheating']."°C </td>
				</tr>
			</a>";
			
	}
echo "</tbody> </table>";
echo "</div>";
	
}
php?>
</div>
