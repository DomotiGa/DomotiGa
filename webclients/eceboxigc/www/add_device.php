<?
// Get list of devices
$datadevices=get_device_list($_SESSION['view']);

// Get current URL
$monUrl = "http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
$monUrl2 = $_SERVER['REQUEST_URI'];
$monUrl2 = split ("/", $monUrl2);

// Get devices from the DB of the tab
    $count = current($db->query("SELECT ID FROM extra_tabs")->fetch());
    if($count != 0){
        $reponse = $db->query('SELECT devices FROM extra_tabs WHERE ID = '.$_GET['id']);
    }
    while ($donnees = $reponse->fetch())
    {
	$myequipments = $donnees['devices'];			
    }
     $reponse->closeCursor();

php?>

<script>

// Javascript function for submit button
function loadPage(param) {
self.location.href=document.location+"&kind="+param;
}

function loadPage2(param) {
self.location.href=document.location+"&choice="+param;
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
          
// Title and back button
php?>
<? echo "<h2>".$_GET['name']."      <button id=\"buttonBack\" onclick=\"document.location.href='index.php?page=tabs&name=".$_GET['name']."&id=".$_GET['id']."'\" style=\"float: right;\" class=\"btn btn-info\">Back...</button> <h4 style=\"float: right;\" id=\"popBack\" class=\"hidePop\">Back to previous page</h4></h2>";
php?>


<!--  --------------------------- Add devices ---------------->
<h3>Adding Devices</h3>

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

<!-------------------------------- Second choice --------------------------------------------------->
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

// ------------------------------ Display only the groups -------------------------------------

if($_GET['kind'] == "group")
{
                       
// Parsing the groups
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

// ------------------------------ Display the locations -------------------------------------
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

// ------------------------------ Display the floors -------------------------------------

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
// ------------------------------ Display the type (switchable, dimable, sensors) -------------------------------------
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
// ------------------------------ Display the desired switchable and dimable devices of the user -------------------------------------
if( $_GET['kind'] != "" && $_GET['choice'] != "")
{
	echo "<h3>Select device to add</h3>
<div id=\"tabs2\">
  <ul>
    <li><a href=\"#tabs-1\">Actuators</a></li>
    <li><a href=\"#tabs-2\">Sensors</a></li>
  </ul>
<form Action=\"".$monUrl2[2]."\">
 <input type=\"hidden\" name=\"envoi\" value=\"yes\">
  <div id=\"tabs-1\">
    <table class=\"table table-hover\">
    <thead>
        <tr>
	    <th>Select</th>
            <th>Name</th>
            <th>Group</th>
            <th>Location</th>
            <th>Floor</th>
            <th>Model</th>
            <th>Dim</th>
	<th>Switch</th>

        </tr>
    </thead>
    <tbody>";
$h=0;
// Display the group
if($_GET['kind'] == "group")
{
	foreach($datadevices AS $item) 
	{
		
		// Parsing groups
		if ($item['devicegroup'] != "")
		{
			$group = split('[|.-]', $item['devicegroup']);
		}
		
		$item['devicegroup'] = str_replace("|", "  ", $item['devicegroup']);
		
		foreach($group AS $value)
		{
			
			$pos = strpos($value, $_GET['choice']);
			// Check if the device is in the group
			if ($pos !== false)
			{ 
				if ($item['switchable'] == "T")
				{ 
					$h=$h+1;
					if ($item['devicevalue'] == "On" || $item['devicevalue'] == "on")
					{
						
					// Display the checkbox and the toggle
					echo "<tr> 
						<td >
						<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."\">
						  </td> 						  
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
						<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."\">
						  </td> 	
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
					$h=$h+1;
					echo "<tr> 
						<td >
						<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."\">
						  </td> 	
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

	if ($h == 0)
	{
		echo " </tbody></table> <h3 style=\"text-align:center;\"> You do not have an Actuator in this Group. </h3>";
		$h = 0;
	}
}
// Display the choosen location
if($_GET['kind'] == "location")
{
	foreach($datadevices AS $item) 
	{
		$item['devicegroup'] = str_replace("|", "  ", $item['devicegroup']);
		// Check if the device is in this location
		if ($item['devicelocation'] == $_GET['choice'])
		{ 
			if ($item['switchable'] == "T")
			{ 
				$h=$h+1;
				if ($item['devicevalue'] == "On" || $item['devicevalue'] == "on")
				{
					
					echo "<tr> 
						<td >
						<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."\">
						  </td> 	

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
						<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."\">
						  </td> 	
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
				$h=$h+1;
				echo "<tr> 
						<td >
						<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."\">
						  </td> 	
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

	if ($h == 0)
	{
		echo "</tbody></table><h3 style=\"text-align:center;\"> You do not have an Actuator in this Location. </h3>";
		$h = 0;
	}
}

// Display device on the choosen floor
if($_GET['kind'] == "floor")
{
	foreach($datadevices AS $item) 
	{

		$item['devicegroup'] = str_replace("|", "  ", $item['devicegroup']);
		// Check if the device is on this floor
		if ($item['devicefloorname'] == $_GET['choice'])
		{ 
			if ($item['switchable'] == "T")
			{ 
				$h=$h+1;
				if ($item['devicevalue'] == "On" || $item['devicevalue'] == "on")
				{
					echo "<tr> 
						<td >
						<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."\">
						  </td> 	
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
						<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."\">
						  </td> 	
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
				$h=$h+1;
				echo "<tr> 
						<td >
						<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."\">
						  </td> 	
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

	if ($h == 0)
	{
		echo "</tbody></table><h3 style=\"text-align:center;\"> You do not have an Actuator on this Floor. </h3>";
		$h = 0;
	}
}
// Diplay the choosen type
if($_GET['kind'] == "type")
{
	foreach($datadevices AS $item) 
	{

		$item['devicegroup'] = str_replace("|", "  ", $item['devicegroup']);
		// Check if the device is switchable
		if ("switches" == $_GET['choice'])
		{ 
			if ($item['switchable'] == "T")
			{ 
				$h=$h+1;
				if ($item['devicevalue'] == "On" || $item['devicevalue'] == "on")
				{
					echo "<tr> 
						<td >
						<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."\">
						  </td> 	
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
							 
								<div class=\"slider-frame \" ><span id=\"".$item['devicename']."\" class=\"slider-button on\">ON</span>
								</div>
							
						  </td>
					      </tr>";
				} else
				{
						echo "<tr> 
						<td >
						<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."\">
						  </td> 	
						  <td  vertical-align: middle>
								".$item['devicename']."
						  </td> 
						  <td vertical-align: middle>
								".$item['devicegroup']."
						  </td> 
						  <td vertical-align: middle>
								".$item['devicelocation']."
						  </td> 
						  <td vertical-align: middle>
								".$item['devicefloorname']."
						  </td> 
						  <td vertical-align: middle>
								".$item['devicetype']."
						  </td> <td> </td>
						  <td class=\"toggle\" >
								<div class=\"slider-frame \" ><span id=\"".$item['devicename']."\" class=\"slider-button off\">OFF</span>
								
							</div>
						  </td>
					      </tr>";
				}
			} 

		// Check if the device is dimable
		} else if ("dimmers" == $_GET['choice'])
		{ 
			
			if ($item['dimable'] == "T")
			{ 
				$h=$h+1;

					echo "<tr> 
						<td >
						<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."\">
						  </td> 	
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
				if ($h == 0 && $j == 0)
				{
					echo "</tbody></table><h3 style=\"text-align:center;\"> No Actuators found. </h3>";
					$h = 0;
					$j = 1;
				}
	   

}	
$j=0;
// ------------------------------ Display the desired sensors -------------------------------------
echo "  
</tbody>
</table>
</div>
<div id=\"tabs-2\">
    <table class=\"table table-hover\">
    <thead>
        <tr>
	    <th>Select</th>
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

		// Parsing des groupes
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
						<td >
						<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."\">
						  </td> 	
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
						<td >
						<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."\">
						  </td> 	
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

				if ($k == 0 )
				{
					echo "</tbody></table><h3 style=\"text-align:center;\"> You do not have a Sensor in this Location. </h3>";
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
						<td >
						<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."\">
						  </td> 	
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
						<td >
						<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."\">
						  </td> 	
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
<!-- Submit the choice of the user --------->
        <button class="btn btn-success" type="submit">OK</button>
        <button class="btn btn-danger" type="reset">Cancel</button>
</form>
</div>



<?
}

php?>
<br>

<?php
// Add new device to the right tab in the database
$envoi = $_GET['envoi'];   
$options = $_GET['options'];     
$options_text = implode(' ',$options);   
$options_text3 = split('[ ]', $options_text);
$myequipments2 = split('[ ]', $myequipments); 

// Check if the device is already inside
foreach($options_text3 AS $theid)
{
	
	foreach($myequipments2 AS $ids)
	{
		if($ids == $theid)
		{	

			$theid = "";
			
			
		}
	}
	$myequipments = $myequipments." ".$theid;
}

if ($envoi == 'yes') 
{
             
	$req =  $db->prepare('UPDATE extra_tabs SET devices = (:theequipments) WHERE  extra_tabs.ID ='.$_GET['id']);
        $req->execute(array('theequipments' => $myequipments  ));
}
	

// Delete a device from the database
$envoi2 = $_GET['envoi2'];   		
$options2 = $_GET['options2'];
$options2_text = implode(' ',$options2);
$options2_text = split('[ ]', $options2_text);
$myequipments3 = split('[ ]', $myequipments);

// If the device is found, we replace it by nothing
foreach($myequipments3 AS $ids)
{
	foreach($options2_text AS $theid)
	{
		if($theid == $ids)
		{
			$ids = "";
		}
	}
	$myequipments7  = $myequipments7." ".$ids;
}
$myequipments = $myequipments7;

if ($envoi2 == 'no') 
{
	$req =  $db->prepare('UPDATE extra_tabs SET devices = (:theequipments) WHERE  extra_tabs.ID ='.$_GET['id']);
	$req->execute(array('theequipments' => $myequipments7  ));
}

 ?>

<!-- ----------------------------------------------------------- Device already add in the tab --------------------------------------------- -->
<h3>Devices</h3>
<?
if( $myequipments == "")
{
echo " <h3 style=\"text-align:center;\"> You have not added any Devices. </h3>";
} else 
{
	$iddevices = split('[ ]', $myequipments);
	
		php?>
		<div id="tabs">
		 <ul>	<!-- Seperate in two tab -->
		   <li><a href="#tabs-1"><span>Actuator</span></a></li>
		   <li><a href="#tabs-2"><span>Sensor</span></a></li>
		 </ul>
<form Action="<? echo $monUrl2[2]; ?>">
 <input type="hidden" name="envoi2" value="no">
		 <div id="tabs-1">
		   <table class="table table-hover">
		   <thead>
		       <tr>
			<th>Select</th>
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
$u = "bug";
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
$u="debug";
						echo "<tr> 
						<td >
						<input type=\"checkbox\" name=\"options2[]\" value=\"".$item['id']."\">
						  </td> 
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
$u="debug";

						echo "<tr> 
						<td >
						<input type=\"checkbox\" name=\"options2[]\" value=\"".$item['id']."\">
						  </td> 
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
$u="debug";
					echo "<tr> 
						<td >
						<input type=\"checkbox\" name=\"options2[]\" value=\"".$item['id']."\">
						  </td> 
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
$u="debug";
						echo "<tr> 
						<td >
						<input type=\"checkbox\" name=\"options2[]\" value=\"".$item['id']."\">
						  </td> 
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
$u="debug";
						echo "<tr>
						<td >
						<input type=\"checkbox\" name=\"options2[]\" value=\"".$item['id']."\">
						  </td> 
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
		if ($u != "debug")
		{
			
			$u="bug";
			$myequipments = "";
	$req =  $db->prepare('UPDATE extra_tabs SET devices = (:theequipments) WHERE  extra_tabs.ID ='.$_GET['id']);
        $req->execute(array('theequipments' => $myequipments  ));
		}


		php?>
		</tbody>
		</table>  
		 </div>
        <button class="btn btn-danger" type="submit">Remove</button>

</form>
		</div>
<?
	

}
php?>
