<?

// Get list of devices
$datadevices=get_device_list($_SESSION['view']);
$sTime = "1h";

// Get list of event
$list=get_event_list($_SESSION['view']);

// Get list of scenarii
$list_scenarii=get_scenario_list($_SESSION['view']);

// Get list of heating from the enabled scenario
$list_heating=get_heating($_SESSION['view']);

//Get list of all heating
$monUrl = "http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
$monUrl2 = $_SERVER['REQUEST_URI'];
$monUrl2 = split ("/", $monUrl2);

   foreach($list_scenarii AS $scenario) {
	
	$list_heatings[$scenario['idthermo']] = get_scenario_heating($_SESSION['view'],$scenario['idthermo']);
	
}

if(isset($_GET['updategraph'])){

   $sTime = $_GET['updategraph'];

}

if(isset($_POST['textbox'])){

   $sTime = $_POST['textbox'];

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

if(isset($_GET['runaction'])){
   echo "<h3>Requested to turn ".$_GET['runaction'].".</h3>";
   $request = xmlrpc_encode_request("events.runactions",array($_GET['runaction'] ) );
   $response = do_xmlrpc($request);
$add = split('[?]',$_SERVER['HTTP_REFERER']); 
   header("Location: index.php?".$add[1]);
}


  $endreponse = $db->query('SELECT weather_baro, weather_temp, weather_hydro, weather_wind FROM extra_tabs WHERE ID = '.$_GET['id']);

    while ($donnees = $endreponse->fetch())
    {
	$pressure = $donnees['weather_baro'];
	$temperature = $donnees['weather_temp'];
	$hydro = $donnees['weather_hydro'];
	$wind = $donnees['weather_wind'];
    }
     $endreponse->closeCursor();

    $count = current($db->query("SELECT ID FROM extra_tabs")->fetch());
    if($count != 0){
        $reponse = $db->query('SELECT weather_baro, weather_temp, weather_hydro, weather_wind, devices, events, heatings, one, two, three, four, five, graphs FROM extra_tabs WHERE ID = '.$_GET['id']);
    }
    while ($donnees = $reponse->fetch())
    {
	$myequipments = $donnees['devices'];
	$myevents = $donnees['events'];	
	$myheatings = $donnees['heatings'];
	$pressure = $donnees['weather_baro'];
	$temperature = $donnees['weather_temp'];
	$hydro = $donnees['weather_hydro'];
	$wind = $donnees['weather_wind'];
	$position[] = $donnees['one'];
	$position[] = $donnees['two'];
	$position[] = $donnees['three'];
	$position[] = $donnees['four'];
	$position[] = $donnees['five'];
	$mygraphs = $donnees['graphs'];				
    }
     $reponse->closeCursor();

echo "<div >
	<h2> ".$_GET['name']."
      <button id=\"buttonMeteo\" onclick=\"document.location.href='index.php?page=add_meteo&name=".$_GET['name']."&id=".$_GET['id']."'\" style=\"float: right;\" class=\"btn btn-info\">Weather...</button>	
      <button id=\"buttonGraphs\" onclick=\"document.location.href='index.php?page=add_graph&name=".$_GET['name']."&id=".$_GET['id']."'\" style=\"float: right;\" class=\"btn btn-info\">Graphs...</button>	
	<button id=\"buttonEvent\" onclick=\"document.location.href='index.php?page=add_event&name=".$_GET['name']."&id=".$_GET['id']."'\" style=\"float: right;\" class=\"btn btn-info\">Events...</button>
<button id=\"buttonEquipment\" onclick=\"document.location.href='index.php?page=add_device&name=".$_GET['name']."&id=".$_GET['id']."'\" style=\"float: right;\" class=\"btn btn-info\">Devices...</button>
      <button id=\"buttonHeating\" onclick=\"document.location.href='index.php?page=add_heating&name=".$_GET['name']."&id=".$_GET['id']."'\" style=\"float: right;\" class=\"btn btn-info\">Heatings...</button>		 

 <h4 style=\"float: right;\" id=\"popMeteo\" class=\"hidePop\">Select weather to link with</h4>
 <h4 style=\"float: right;\" id=\"popGraphs\" class=\"hidePop\">Select graphs to link with</h4>
 <h4 style=\"float: right;\" id=\"popEvent\" class=\"hidePop\">Select events to link with</h4>
 <h4 style=\"float: right;\" id=\"popHeating\" class=\"hidePop\">Select thermostats to link with</h4>  	
 <h4 style=\"float: right;\" id=\"popEquipment\" class=\"hidePop\">Select devices to link with</h4></h2>
    </div>";
php?>
<?
    if($myequipments == "" && $myevents == "" && $myheatings == "" && $temperature == "" && $hydro == "" && $wind == "" && $pressure == "" && $mygraphs == "")
    {
	echo "<br><br><br><h3 style=\"text-align:center;\">This tab is still empty!<h3><br>";
    }

foreach($position AS $pos)
{
	switch($pos)
	{
		case "weather" :
// -------------- METEO -------------------------------------------------------
if( $temperature != "" || $hydro != "" || $wind != "" || $pressure != "")
{
	echo "<h2>LOCAL WEATHER</h2>";
$getpressure = split('[v]', $pressure);
$gettemperature = split('[v]', $temperature);
$gethydro = split('[v]', $hydro);
$getwind = split('[v]', $wind);

foreach($datadevices AS $item)
{
	if($temperature != "")
	{

		if($item['id'] == $gettemperature[0])
		{
			
		?>
		    <div class="widget widgetShift" style="text-align:center;">
			<h3 class="center">Temperature</h3>
			 <div class = "sun" ></div>
			<p> Outside :</p>
			<h1>
				<?php 
					if($gettemperature[1] == 1)
					{
						echo $item['devicevalue'];
					}
					if($gettemperature[1] == 2)
					{
						echo $item['devicevalue2'];
					}
					if($gettemperature[1] == 3)
					{
						echo $item['devicevalue3'];
					}
					if($gettemperature[1] == 4)
					{
						echo $item['devicevalue4'];
					}

				?>
			</h1>
			</div>
		<?
		}
	} 
	if($wind != "")
	{

		if($item['id'] == $getwind[0])
		{
			
		?>
		    <div class="widget widgetShift" style="text-align:center;">
			<h3 class="center">Wind</h3>
			 <div class = "wind" ></div>
			<p> Speed :</p>
			<h1>
				<?php 
					if($getwind[1] == 1)
					{
						echo $item['devicevalue'];
					}
					if($getwind[1] == 2)
					{
						echo $item['devicevalue2'];
					}
					if($getwind[1] == 3)
					{
						echo $item['devicevalue3'];
					}
					if($getwind[1] == 4)
					{
						echo $item['devicevalue4'];
					}

				?>
			</h1>
			</div>
		<?
		}
	}
	if($pressure != "")
	{

		if($item['id'] == $getpressure[0])
		{
			
		?>
		    <div class="widget widgetShift" style="text-align:center;">
			<h3 class="center">Pressure</h3>
			 <div class = "barometer" ></div>
			<p> Pression atmosphérique :</p>
			<h1>
				<?php 
					if($getpressure[1] == 1)
					{
						echo $item['devicevalue'];
					}
					if($getpressure[1] == 2)
					{
						echo $item['devicevalue2'];
					}
					if($getpressure[1] == 3)
					{
						echo $item['devicevalue3'];
					}
					if($getpressure[1] == 4)
					{
						echo $item['devicevalue4'];
					}

				?>
			</h1>
			</div>
		<?
		}
	}
	if($hydro != "")
	{

		if($item['id'] == $gethydro[0])
		{
			
		?>
		    <div class="widget widgetShift" style="text-align:center;">
			<h3 class="center">Humidity</h3>
			 <div class = "hydrology" ></div>
			<p> Humidité :</p>
			<h1>
				<?php 
					if($gethydro[1] == 1)
					{
						echo $item['devicevalue'];
					}
					if($gethydro[1] == 2)
					{
						echo $item['devicevalue2'];
					}
					if($gethydro[1] == 3)
					{
						echo $item['devicevalue3'];
					}
					if($gethydro[1] == 4)
					{
						echo $item['devicevalue4'];
					}

				?>
			</h1>
			</div>
		<?
		}
	}
}

echo "<br>";
echo "<br>";
echo "<br>";
echo "<br>";
echo "<br>";
echo "<br>";
echo "<br>";
echo "<br>";
echo "<br>";
echo "<br>";
echo "<br>";
echo "<br>";
} 
break;

		case "event" :
// -------------- EVENTS -------------------------------------------------------          
if( $myevents != "")
{

	$idevents = split('[ ]', $myevents);
	
		php?>
<br>
<h2>EVENTS</h2>
			<table class="table table-hover">
			    <thead>
				<tr>
				    <th>Run</th>
				    <th>Name</th>
				    <th>Description</th>
				    <th>Last Run</th>
				    <th>Enabled</th>

				</tr>
			    </thead>
			    <tbody>

		<?
foreach($idevents AS $idevent)
{
	foreach($list AS $event) {
		if($idevent == $event['id'])
		{
      if ($event['enabled']=="True") {	

	      echo "<tr> 
	  <td> <a href='".$monUrl2[2]."&runaction=".$event['id']."'> <img src=\"img/playicon.png\" alt=\"img/playicon.png\"/> </img> </a> </td> 
	  <td> ".$event['eventname']." </td> 
	  <td> ".$event['description']." </td> 
	  <td> ".$event['lastrun']." </td> 

	  <td class=\"toggle\">

			<div class=\"slider-frame \"><span id=\"".$event['id']."\" class=\"slider-button on\">ON</span>
			</div>
	  </td>

      </tr>";

     } else {
	      	      echo "<tr> 
	  <td> <a href='".$monUrl2[2]."&runaction=".$event['id']."'> <img src=\"img/playicon.png\" alt=\"img/playicon.png\"/> </img> </a> </td> 
	  <td> ".$event['eventname']." </td> 
	  <td> ".$event['description']." </td> 
	  <td> ".$event['lastrun']." </td> 

	  <td class=\"toggle\">

			<div class=\"slider-frame \"><span id=\"".$event['id']."\" class=\"slider-button off\">OFF</span>
			</div>

	  </td>

      </tr>";
     }	
}	
   }
}
php?>

		</tbody>
		</table>  

<?
	

}
   
break;
?>




<?
		case "heating" :
// -------------- HEATINGS -------------------------------------------------------
if( $myheatings != "")
{

$idheatings = split('[ ]', $myheatings);
	
		php?>
<br>
<h2>THERMOSTATS</h2>
<?php
echo "<div id=\"radioheating\">";

if ($list_heating[1]['nameheating']=="") {
	echo "<input type=\"radio\" id=\"radio0\" name=\"radio\" checked=\"checked\" onclick=\"document.location.href='".$monUrl2[2]."&setscenario='\" /><label for=\"radio0\">Off</label>";
} else {
	echo "<input type=\"radio\" id=\"radio0\" name=\"radio\"  onclick=\"document.location.href='".$monUrl2[2]."&setscenario='\" /><label for=\"radio0\">Off</label>";
}
foreach($idheatings AS $idheating)
{
foreach($list_scenarii AS $thermostat) {
if($idheating == $thermostat['idthermo'])
{
		if ($thermostat['namethermo']==$list_heating[0]['nameheating']) {
		echo "
		<input type=\"radio\" id=\"radio".$thermostat['idthermo']."\" name=\"radio\" checked=\"checked\" /><label for=\"radio".$thermostat['idthermo']."\">".$thermostat['namethermo']."</label>
		";
		} else {
		echo "<input type=\"radio\" id=\"radio".$thermostat['idthermo']."\" name=\"radio\" onclick=\"document.location.href='".$monUrl2[2]."&setscenario=".$thermostat['namethermo']."'\" /><label for=\"radio".$thermostat['idthermo']."\">".$thermostat['namethermo']."</label>";
		}
}
   }
   }
echo "</div>";

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
			    <th>Measured Temperature</th>
			    <th>Desired Temperature</th>

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
			      				<button type= button style=\"display: inline-block ;\" class=\"btn btn-info\" onclick=\"document.location.href='".$monUrl2[2]."&derogateheating=".$list_heating[0]['idheating']."&idheating=".$heating['idheating']."&commande=plus'\">+</button>	
			      				<button style=\"display: inline-block ;\" class=\"btn btn-info\" onclick=\"document.location.href='".$monUrl2[2]."&derogateheating=".$list_heating[0]['idheating']."&idheating=".$heating['idheating']."&commande='\">-</button>	
						</td>
					</tr>
				</a>";
			}
		}
	} else if ($list_heating[0]['nameheating']!="") {
			echo "<p>No heating available for the selected scenario.</p>";
		}

php?>


</tbody>
</table> 




<?
	

}
   
break;
?>

<?
			case "equipment" :
// -------------- DEVICES -------------------------------------------------------
if( $myequipments != "")
{
	$iddevices = split('[ ]', $myequipments);
	
		php?>
<br>
<h2>DEVICES</h2>
		<div id="tabs">
		 <ul>
		   <li><a href="#tabs-1"><span>Actuator</span></a></li>
		   <li><a href="#tabs-2"><span>Sensor</span></a></li>
		 </ul>
		 <div id="tabs-1">
		   <table class="table table-hover">
		   <thead>
		       <tr>
			   <th>Name</th>
			   <th>Group</th>
			   <th>Location</th>
			   <th>Floor</th>
			   <th>Model</th>
            		<th>Dim</th>
			<th>Switch</th>
			</tr>
		   </thead>
		   <tbody>



		<?
foreach($iddevices AS $iddevice)
	{
		foreach($datadevices AS $item) 
		{
			if($iddevice == $item['id'])
			{

				$item['devicegroup'] = str_replace("|", "  ", $item['devicegroup']);
				if ($item['switchable'] == "T")
				{ 
					if ($item['devicevalue'] == "On" || $item['devicevalue'] == "on")
					{
						echo "<tr> 
							  <td >
									".$item['devicename']."
							  </td> 
							  <td >
									".$item['devicegroup']."
							  </td> 
							  <td >
									".$item['devicelocation']."
							  </td> 
							  <td >
									".$item['devicefloorname']."
							  </td> 
							  <td >
									".$item['devicetype']."
							  </td> <td> </td>
							  <td class=\"toggle\" >
									<div class=\"slider-frame \"><span id=\"".$item['devicename']."\" class=\"slider-button on\">ON</span>
			
								</div>
							  </td>
						      </tr>";
					} else
					{

						echo "<tr> 
						  <td >
								".$item['devicename']."
						  </td> 
						  <td >
								".$item['devicegroup']."
						  </td> 
						  <td >
								".$item['devicelocation']."
						  </td> 
						  <td >
								".$item['devicefloorname']."
						  </td> 
						  <td >
								".$item['devicetype']."
						  </td> <td> </td>
						  <td class=\"toggle\" >
								<div class=\"slider-frame \"><span id=\"".$item['devicename']."\" class=\"slider-button off\">OFF</span>
			
							</div>
						  </td>
					      </tr>";
					}
				} else if ($item['dimable'] == "T")
				{
					echo "<tr> 
						  <td >
							".$item['devicename']."
						  </td> 
						  <td >
							".$item['devicegroup']."
						  </td> 
						  <td >
							".$item['devicelocation']."
						  </td> 
						  <td >
							".$item['devicefloorname']."
						  </td> 
						  <td >
							".$item['devicetype']."
						  </td> 
						<td>		
 <button style=\"display: inline-block;\" class=\"btn btn-info\" onclick=\"document.location.href='set_device.php?name=".$item['devicename']."&action=Bright'\">+</button>
                		<button style=\"display: inline-block;\" class=\"btn btn-info\" onclick=\"document.location.href='set_device.php?name=".$item['devicename']."&action=Dim'\">-</button></td> 
			  <td class=\"toggle\" >
			
				
				<div class=\"slider-frame \"><span id=\"".$item['devicename']."\" class=\"slider-button off\">OFF</span></div>
				
			  </td>
					      </tr>";
				}
			}
		}
}
		php?>
		</tbody>
		</table>  
		  </div>
		  <div id="tabs-2">
		<table class="table table-hover">
		    <thead>
			<tr>
			    <th>Name</th>
			    <th>Group</th>
			    <th>Location</th>
			    <th>Floor</th>
			    <th>Model</th>
			    <th>Value </th>
			    <th>Value 2</th>
			    <th>Value 3</th>
			    <th>Value 4</th>
			</tr>
		    </thead>
		    <tbody>
		<?
foreach($iddevices AS $iddevice)
	{
		foreach($datadevices AS $item) 
		{
			if($iddevice == $item['id'])
			{
				$item['devicegroup'] = str_replace("|", " ", $item['devicegroup']);
				if ($item['switchable'] == "" & $item['dimable'] == "")
				{ 
					if ($item['rrdsensors'] == "T")
					{
						echo "<tr> 
							<td ><a data-geo=\"data-geo\">
									".$item['devicename']."</a>
							</td> 
							<td  >
									".$item['devicegroup']."
							</td> 
							<td >
									".$item['devicelocation']."
							</td> 
							<td>
									".$item['devicefloorname']."
							</td> 
							<td >
									".$item['devicetype']."
							</td> 
					_SERVER['HTTP_HOST']	 	 <td >
									".$item['devicevalue']."
							 </td>
						 	 <td >
									".$item['devicevalue2']."
							 </td>
						 	 <td >
									".$item['devicevalue3']."
							 </td>
						 	 <td >
									".$item['devicevalue4']."
							 </td>
						     </tr>";
					} else
					{
						echo "<tr>
							<td >
									".$item['devicename']."
							</td> 
							<td >
									".$item['devicegroup']."
							</td> 
							<td >
									".$item['devicelocation']."
							</td> 
							<td >
									".$item['devicefloorname']."
							</td> 
							<td>
									".$item['devicetype']."
							</td> 
						 	 <td >
									".$item['devicevalue']."
							 </td>
						 	 <td >
									".$item['devicevalue2']."
							 </td>
						 	 <td >
									".$item['devicevalue3']."
							 </td>
						 	 <td >
									".$item['devicevalue4']."
							 </td>
						      </tr>";
					}
				}
			}
		}
}

		php?>
		</tbody>
		</table>  
		 </div>
		</div>
<?
	
}
break;
?>

<?
			case "graph" :
// -------------- GRAPHIQUES -------------------------------------------------------
if( $mygraphs != "")
{

echo "<h2>GRAPHS</h2>";

echo "	<form Method=\"POST\"> <div id=\"radiograph\">";

$aTime = array("1h","2h","1d","2d","1w","2w","1m","1y");

foreach ($aTime AS $Time) 
{
	if ($Time == $sTime)
	{
		echo "<input type=\"radio\" id=\"".$Time."\" name=\"radio\" checked =\"checked\" onclick=\"document.location.href='".$monUrl2[2]."&updategraph=".$Time."'\" /><label for=\"".$Time."\">".$Time."</label>";
	} else
	{
		echo "<input type=\"radio\" id=\"".$Time."\" name=\"radio\" onclick=\"document.location.href='".$monUrl2[2]."&updategraph=".$Time."'\" /><label for=\"".$Time."\">".$Time."</label>";
	}
}


	echo 	"&nbsp;  
		<input type=\"text\" id=\"textbox\" name=\"textbox\" placeholder=\"".$sTime."\" style=\"height:40px;\" size =15 />
		&nbsp; 	
		<button type=\"submit\">Valider</button>

	</div></form>";



echo 
"<form Action=".$monUrl2[2].">
 <input type=\"hidden\" name=\"envoi2\" value=\"no\">
			<table class=\"table table-hover\">
			    <thead>
				<tr>
				    <th>Graphs </th>
				</tr>
			    </thead>
			    <tbody>";




  $endreponse = $db->query('SELECT graphs FROM extra_tabs WHERE ID = '.$_GET['id']);

    while ($donnees = $endreponse->fetch())
    {
	$list_graphs = $donnees['graphs'];			
    }
     $endreponse->closeCursor();


$list_graphs = split('[;;]', $list_graphs);
$index =0;

foreach ($list_graphs AS $graph) 
{
	$list_graphs2 = split('[v]', $graph);

	foreach ($datadevices AS $device)
	{ 
		if ( $device['id']==$list_graphs2[0])
		{ 
			$request = xmlrpc_encode_request("rrdtool.updategraph",array($device['id'],$sTime));
			$response = do_xmlrpc($request);

			if ($list_graphs2[1]==1){			

				echo "	<tr><td >
					<img src=\"http://".$_SERVER['HTTP_HOST']."/graphs/".$list_graphs2[0]."-".$device['valuerrdname']."-".$sTime.".png\"/>
					</td>
					</tr>";
			}
			if ($list_graphs2[1]==2){			

				echo "	<tr><td >
					<img src=\"http://".$_SERVER['HTTP_HOST']."/graphs/".$list_graphs2[0]."-".$device['value2rrdname']."-".$sTime.".png\"/>
					</td>
					</tr>";
			}
			if ($list_graphs2[1]==3){			


				echo "	<tr><td >
					<img src=\"http://".$_SERVER['HTTP_HOST']."/graphs/".$list_graphs2[0]."-".$device['value3rrdname']."-".$sTime.".png\"/>
					</td>
					</tr>";
			}
			if ($list_graphs2[1]==4){			

				echo "	<tr><td >
					<img src=\"http://".$_SERVER['HTTP_HOST']."/graphs/".$list_graphs2[0]."-".$device['value4rrdname']."-".$sTime.".png\"/>
					</td>
					</tr>";
			}

		}
	}
}


?>

		</tbody>
		</table>  

<?php

}
			break;

}

}

php?>
