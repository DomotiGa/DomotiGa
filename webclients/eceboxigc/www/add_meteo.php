<?

// Get list of devices
$datadevices=get_device_list($_SESSION['view']);
$monUrl = "http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
$monUrl2 = $_SERVER['REQUEST_URI'];
$monUrl2 = split ("/", $monUrl2);

php?>

<script>

function loadPage(param) {
self.location.href=document.location+"&kind="+param;
}

function loadPage2(param) {
self.location.href=document.location+"&choice="+param;
}

function loadPage3(param) {
self.location.href=document.location+"&sensor="+param;
}
</script>

<?

if($_GET['kind'] == "group")
{
	$kind = "Groups";
} else if($_GET['kind'] == "location")
{
$kind = "Locations";
} else if($_GET['kind'] == "floor")
{
$kind = "Floors";
} else if($_GET['kind'] == "type")
{
$kind = "Types";
}else if($_GET['kind'] == "")
{
$kind = ""; 
}
          

php?>


<? echo "<h2>".$_GET['name']."<button id=\"buttonBack\" onclick=\"document.location.href='index.php?page=tabs&name=".$_GET['name']."&id=".$_GET['id']."'\" style=\"float: right;\" class=\"btn btn-info\">Back...</button> <h4 style=\"float: right;\" id=\"popBack\" class=\"hidePop\">Back to previous page</h4></h2>";
php?>


<h3>Choose type of Weather Sensor to change</h3>

<form Method="POST" Action="<?php echo $monUrl[2];?>">
    <table style="margin-left:3%;" border="0" cellspacing="0" cellpadding="2">
        <tbody>
            <tr> 
                <td nowrap="" width="27%" class="formulaireText">
                    Sensor :
                </td>
                <td style="padding-left:3%;" width="73%">
                    <select id="weatherSensor"  name="sensor" onchange="loadPage3(this.value);">
<?
		echo "<option value = \" \" SELECTED> </option>";
		if($_GET['sensor'] == "thermo")
		{
                       echo "<option value = \"thermo\" SELECTED>Temperature</option>";
		} else echo "<option value = \"thermo\">Temperature</option>";
		if($_GET['sensor'] == "anemo")
		{
                       echo "<option value = \"anemo\" SELECTED>Wind</option>";
		} else echo "<option value = \"anemo\">Wind</option>";
		if($_GET['sensor'] == "baro")
		{
                       echo "<option value = \"baro\" SELECTED>Barometer</option>";
		} else echo "<option value = \"baro\">Barometer</option>";
		if($_GET['sensor'] == "hygro")
		{
                       echo "<option value = \"hygro\" SELECTED>Humidity</option>";
		} else echo "<option value = \"hygro\">Humidity</option>";
php?>
                    </select>
                </td>
	</tr>
	</tbody>
	</table>
</form>


<!-- Chosen sensors ------------------------------------------------------------>
<h3>Select a filter</h3>

<form Method="POST" Action="<?php echo $monUrl[2];?>">
    <table style="margin-left:3%;" border="0" cellspacing="0" cellpadding="2">
        <tbody>
            <tr> 
                <td nowrap="" width="27%" class="formulaireText">
                    Filter :
                </td>
                <td style="padding-left:3%;" width="73%">
                    <select id="kindDevice"  name="kind" onchange="loadPage(this.value);">
<?
		echo "<option value = \" \" SELECTED> </option>";
		if($_GET['kind'] == "group")
		{
                       echo "<option value = \"group\" SELECTED>Groups</option>";
		} else echo "<option value = \"group\">Groups</option>";
		if($_GET['kind'] == "location")
		{
                       echo "<option value = \"location\" SELECTED>Locations</option>";
		} else echo "<option value = \"location\">Locations</option>";
		if($_GET['kind'] == "floor")
		{
                       echo "<option value = \"floor\" SELECTED>Floors</option>";
		} else echo "<option value = \"floor\">Floors</option>";
		if($_GET['kind'] == "type")
		{
                       echo "<option value = \"type\" SELECTED>Types</option>";
		} else echo "<option value = \"type\">Types</option>";
php?>
                    </select>
                </td>
	</tr>
<? if($_GET['kind'] != "")
{ php?>      <tr> 
		<td nowrap="" width="27%" class="formulaireText">
                    <?php echo $kind; ?> :
                </td>
                <td style="padding-left:3%;" width="73%">
                    <select id="choiceDevice" name="choice" onchange="loadPage2(this.value);">
<?
if($_GET['choice'] == "")
{
	
	echo "<option value =\" \" SELECTED> </option>";

} else
{
	$choice = str_replace("%20", " ", $_GET['choice']);
	echo "<option value = \"".$_GET['choice']."\" SELECTED>".$choice."</option>";
}
if($_GET['kind'] == "group")
{
                       
// Parsing of groups
foreach($datadevices AS $item) 
{

		
	if ($item['devicegroup'] != "")
	{
		
		$group = split('[|.-]', $item['devicegroup']);
		
	}
	foreach($group AS $result)
	{
		$array[]=$result;
	}
}

// End parsing array

// Filter duplicates
$array3[] = "init";

foreach($array AS $value) 
{

	foreach($array3 AS $value3) 
	{
		if ($value == $value3)
		{
			$h++;
			
		}
	}
	if( $h == 0)
	{
		$array3[]=$value;
	}
	$h=0;
	


}
foreach($array3 AS $value3) 
{
	
	if($value3 != "init" && $value3 != "")
	{
$value4 = str_replace(" ", "%20", $value3);
	echo "<option value = \"".$value4."\">".$value3."</option>";
	}
}
}
if($_GET['kind'] == "location")
{
                
// Filter duplicates
$loc3[] = "init";

foreach($datadevices AS $item) 
{
	if (	$item['devicelocation'] != "")
	{
	$loc2[]=$item['devicelocation'];
	}
}

foreach($loc2 AS $value2) 
{

	foreach($loc3 AS $value3) 
	{
		if ($value2 == $value3)
		{
			$h++;
			
		}
	}
	if( $h == 0)
	{
		$loc3[]=$value2;
	}
	$h=0;
	


}
foreach($loc3 AS $value3) 
{
	if($value3 != "init" && $value3 != "")
	{
$value4 = str_replace(" ", "%20", $value3);
	echo " <option value = \"".$value4."\">".$value3."</option>";
	}
}
}
if($_GET['kind'] == "floor")
 {

// Filter duplicates
$floor3[] = "init";

foreach($datadevices AS $item) 
{
	if ($item['devicefloorname'] != "")
	{
	$floor2[]=$item['devicefloorname'];
	}
}

foreach($floor2 AS $value2) 
{

	foreach($floor3 AS $value3) 
	{
		if ($value2 == $value3)
		{
			$h++;
			
		}
	}
	if( $h == 0)
	{
		$floor3[]=$value2;
	}
	$h=0;
	


}
foreach($floor3 AS $value3) 
{
	if($value3 != "init" && $value3 != "")
	{
$value4 = str_replace(" ", "%20", $value3);
	echo "<option value = \"".$value4."\">".$value3."</option>";
	}
}
}
if($_GET['kind'] == "type")
{
	echo "<option value = \"switches\">Switches</option>";
	echo "<option value = \"dimmers\">Dimmers</option>";
	echo "<option value = \"sensors\">Sensors</option>";
}

php?>
        
                    </select>
                </td>
</tr>
<? } php?>
            
        </tbody>
    </table>
</form>

<?

if( $_GET['kind'] != "" && $_GET['choice'] != "")
{
	echo "<h3>Select a value to use</h3>
<div id=\"tabs2\">
  <ul>
    <li><a href=\"#tabs-2\">Sensors</a></li>
  </ul>
<form Action=\"".$monUrl2[2]."\">
 <input type=\"hidden\" name=\"envoi\" value=\"yes\">
<div id=\"tabs-2\">
    <table class=\"table table-hover\">
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
    <tbody>";
$k=0;
if($_GET['kind'] == "group")
{
	foreach($datadevices AS $item) 
	{

		// Parsing of groups
		if ($item['devicegroup'] != "")
		{
		
			$group = split('[|.-]', $item['devicegroup']);
		
		}
		$item['devicegroup'] = str_replace("|", "  ", $item['devicegroup']);
		
		foreach($group AS $value)
		{
			$pos = strpos($value, $_GET['choice']);
			if ($pos !== false)
			{ 
				if ($item['switchable'] == "" & $item['dimable'] == "")
				{ 
					$k=$k+1;
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
				 	 <td >
<input type=\"radio\" name=\"options\" value=\"".$item['id']."v1\">
							".$item['devicevalue']."
					 </td>
				 	 <td >
<input type=\"radio\" name=\"options\" value=\"".$item['id']."v2\">
							".$item['devicevalue2']."
					 </td>
				 	 <td >
<input type=\"radio\" name=\"options\" value=\"".$item['id']."v3\">
							".$item['devicevalue3']."
					 </td>
				 	 <td >
<input type=\"radio\" name=\"options\" value=\"".$item['id']."v4\">
							".$item['devicevalue4']."
					 </td>
				     </tr>";	
				}

			}
	       }
	}

				if ($k == 0 )
				{
					echo "</tbody></table><h3 style=\"text-align:center;\"> You do not have a Sensor in this Group. </h3>";
					$k = 0;
				}
}

if($_GET['kind'] == "location")
{
	foreach($datadevices AS $item) 
	{

		$item['devicegroup'] = str_replace("|", "  ", $item['devicegroup']);

		if ($item['devicelocation'] == $_GET['choice'])
		{ 
			if ($item['switchable'] == "" & $item['dimable'] == "")
			{ 
					$k=$k+1;
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
				 	 <td >
<input type=\"radio\" name=\"options\" value=\"".$item['id']."v1\">
							".$item['devicevalue']."
					 </td>
				 	 <td >
<input type=\"radio\" name=\"options\" value=\"".$item['id']."v2\">
							".$item['devicevalue2']."
					 </td>
				 	 <td >
<input type=\"radio\" name=\"options\" value=\"".$item['id']."v3\">
							".$item['devicevalue3']."
					 </td>
				 	 <td >
<input type=\"radio\" name=\"options\" value=\"".$item['id']."v4\">
							".$item['devicevalue4']."
					 </td>
				     </tr>";
			}


		}
	   
	}

				if ($k == 0 )
				{
					echo "</tbody></table><h3 style=\"text-align:center;\"> You do not have a Sensor on this Location. </h3>";
					$k = 0;
				}
}
if($_GET['kind'] == "floor")
{
	foreach($datadevices AS $item) 
	{
		
		$item['devicegroup'] = str_replace("|", "  ", $item['devicegroup']);

		if ($item['devicefloorname'] == $_GET['choice'])
		{ 
			if ($item['switchable'] == "" & $item['dimable'] == "")
			{ 
					$k=$k+1;
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
				 	 <td >
<input type=\"radio\" name=\"options\" value=\"".$item['id']."v1\">
							".$item['devicevalue']."
					 </td>
				 	 <td >
<input type=\"radio\" name=\"options\" value=\"".$item['id']."v2\">
							".$item['devicevalue2']."
					 </td>
				 	 <td >
<input type=\"radio\" name=\"options\" value=\"".$item['id']."v3\">
							".$item['devicevalue3']."
					 </td>
				 	 <td >
<input type=\"radio\" name=\"options\" value=\"".$item['id']."v4\">
							".$item['devicevalue4']."
					 </td>
				     </tr>";	
			}

		}
	}

	if ($k == 0 )
	{
		echo "</tbody></table><h3 style=\"text-align:center;\"> You do not have a Sensor on this Floor. </h3>";
		$k = 0;
	}
}
if($_GET['kind'] == "type")
{
	foreach($datadevices AS $item) 
	{
		$item['devicegroup'] = str_replace("|", "  ", $item['devicegroup']);

		if ("sensors" == $_GET['choice'])
		{ 
			if ($item['dimable'] == "" && $item['switchable'] == "")
			{ 
					$k=$k+1;
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
				 	 <td >
<input type=\"radio\" name=\"options\" value=\"".$item['id']."v1\">
							".$item['devicevalue']."
					 </td>
				 	 <td >
<input type=\"radio\" name=\"options\" value=\"".$item['id']."v2\">
							".$item['devicevalue2']."
					 </td>
				 	 <td >
<input type=\"radio\" name=\"options\" value=\"".$item['id']."v3\">
							".$item['devicevalue3']."
					 </td>
				 	 <td >
<input type=\"radio\" name=\"options\" value=\"".$item['id']."v4\">
							".$item['devicevalue4']."
					 </td>
				     </tr>";	
			} 

		}
	   
	}

				if ($k == 0 )
				{
					echo "</tbody></table><h3 style=\"text-align:center;\"> No Sensors found. </h3>";
					$k = 0;
				}
}


php?>

</tbody>
</table>
</div>
        <button class="btn btn-success" type="submit">OK</button>
        <button class="btn btn-danger" type="reset">Cancel</button>
</form>
</div>



<?
}
php?>
<br>

<?php
// Adding devices
$envoi = $_GET['envoi'];   
$option = $_GET['options'];     
$sensor = $_GET['sensor'];  


if ($envoi == 'yes') 
{	
	if ($sensor == "baro") 
	{	
		$req =  $db->prepare('UPDATE extra_tabs SET weather_baro = (:theequipments) WHERE  extra_tabs.ID ='.$_GET['id']);
        	$req->execute(array('theequipments' => $option  ));		
	}
	if ($sensor == "thermo") 
	{	
		$req =  $db->prepare('UPDATE extra_tabs SET weather_temp = (:theequipments) WHERE  extra_tabs.ID ='.$_GET['id']);
        	$req->execute(array('theequipments' => $option  ));		
	}
	if ($sensor == "hygro") 
	{	
		$req =  $db->prepare('UPDATE extra_tabs SET weather_hygro = (:theequipments) WHERE  extra_tabs.ID ='.$_GET['id']);
       		$req->execute(array('theequipments' => $option  ));		
	}
	if ($sensor == "anemo") 
	{	
		$req =  $db->prepare('UPDATE extra_tabs SET weather_wind = (:theequipments) WHERE  extra_tabs.ID ='.$_GET['id']);
    	   	$req->execute(array('theequipments' => $option  ));		
	}

}
	
// Remove devices
$envoi2 = $_GET['envoi2'];   		
$options2 = $_GET['options2'];
$val = "";

if ($envoi2 == 'no') 
{	
	
	if ($options2 == "baro") 
	{	
		$req =  $db->prepare('UPDATE extra_tabs SET weather_baro = (:theequipments) WHERE  extra_tabs.ID ='.$_GET['id']);
        	$req->execute(array('theequipments' => $val  ));		
	}
	if ($options2 == "thermo") 
	{	

		$req =  $db->prepare('UPDATE extra_tabs SET weather_temp = (:theequipments) WHERE  extra_tabs.ID ='.$_GET['id']);
        	$req->execute(array('theequipments' => $val  ));		
	}
	if ($options2 == "hygro") 
	{	
		$req =  $db->prepare('UPDATE extra_tabs SET weather_hygro = (:theequipments) WHERE  extra_tabs.ID ='.$_GET['id']);
       		$req->execute(array('theequipments' => $val  ));		
	}
	if ($options2 == "anemo") 
	{	
		$req =  $db->prepare('UPDATE extra_tabs SET weather_wind = (:theequipments) WHERE  extra_tabs.ID ='.$_GET['id']);
    	   	$req->execute(array('theequipments' => $val  ));		
	}

}

 ?>
<!-- ----------------------------------------------------------- Meteo devices --------------------------------------------- -->
<h3>Weather Sensors</h3>
<?
  $endreponse = $db->query('SELECT weather_baro, weather_temp, weather_hydro, weather_wind FROM extra_tabs WHERE ID = '.$_GET['id']);

    while ($donnees = $endreponse->fetch())
    {
	$pressure = $donnees['weather_baro'];
$temperature = $donnees['weather_temp'];
$hydro = $donnees['weather_hydro'];
$wind = $donnees['weather_wind'];			
    }
     $endreponse->closeCursor();

$getpressure = split('[v]', $pressure);
$gettemperature = split('[v]', $temperature);
$gethydro = split('[v]', $hydro);
$getwind = split('[v]', $wind);

?>
<form Action="<? echo $monUrl2[2]; ?>">
 <input type="hidden" name="envoi2" value="no">

<?


foreach($datadevices AS $item)
{
	if($temperature != "")
	{
		if($item['id'] == $gettemperature[0])
		{
			
		?>
		    <div class="widget widgetShift" style="text-align:center;">
			<h3 class="center"> <input type="radio" name="options2" value="thermo"> Temperature</h3>
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
			<h3 class="center"><input type="radio" name="options2" value="anemo"> Wind </h3>
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
			<h3 class="center"><input type="radio" name="options2" value="baro"> Baro</h3>
			 <div class = "barometer" ></div>
			<p> Pressure :</p>
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
			<h3 class="center"><input type="radio" name="options2" value="hygro"> Humidity </h3>
			 <div class = "hydrology" ></div>
			<p> Humidity :</p>
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

if( $hydro != "" || $pressure != "" || $wind != ""|| $temperature != "")
{
?>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

    <button class="btn btn-danger" type="submit">Remove</button>

<?
}
?>
