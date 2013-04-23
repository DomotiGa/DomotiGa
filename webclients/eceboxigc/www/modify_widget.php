<?php
    // Fetch id widget to change
    $id = $_COOKIE["tile"];

$datadevices=get_device_list($_SESSION['view']);

// Get list of scenarii
$list_scenarii=get_scenario_list($_SESSION['view']);

// Get list of heating from the enabled scenario
$list_heating=get_heating($_SESSION['view']);
$list=get_event_list($_SESSION['view']);
$monUrl = "http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
$monUrl2 = $_SERVER['REQUEST_URI'];
$monUrl2 = split ("/", $monUrl2);

    $reponse = $db->query('SELECT ID, tile_name, tile_icon, device, heating, event FROM tiles WHERE ID='.$id);
    while ($donnees = $reponse->fetch())
    {
	$myequipments = $donnees['device'];
	$name = $donnees['tile_name'];	
	$icon = $donnees['tile_icon'];
	$myheatings = $donnees['heating'];
	$myevents = $donnees['event'];
    }
   
    // Update values
    if(isset($_POST['libelle'])) 
    {
        if ($_POST['libelle'] != ""){
            $req = $db->prepare('UPDATE tiles SET tile_name=:tile_name, tile_icon=:tile_icon WHERE ID='.$id);
            $req->execute(array(
                'tile_name' => $_POST['libelle'],
                'tile_icon' => $_POST['imgList']
            ));
            /*$warning = "<div class=\"alert alert-success\">Widget was changed successfully.</div>";*/
            header("Location: index.php?page=modify_widget");
        }
        else if($_POST['libelle'] == ""){
            $warning = "<div class=\"alert alert-error\">Error changing the widget: field was empty.</div>";
        }
    }

echo "<div >
	<h2>WIDGET MANAGEMENT
	<button id=\"buttontuileEvent\" onclick=\"document.location.href='index.php?page=add_tile_events&name=".$name."&id=".$id."'\" style=\"float: right;\" class=\"btn btn-info\">Events...</button>
<button id=\"buttontuileEquipment\" onclick=\"document.location.href='index.php?page=add_tile_devices&name=".$name."&id=".$id."'\" style=\"float: right;\" class=\"btn btn-info\">Devices...</button>
      <button id=\"buttontuileHeating\" onclick=\"document.location.href='index.php?page=add_tile_heatings&name=".$name."&id=".$id."'\" style=\"float: right;\" class=\"btn btn-info\">Heatings...</button>";	 
?>

 <h4 style="float: right;" id="poptuileEvent" class="hidePop">Select events to link with</h4>
 <h4 style="float: right;" id="poptuileHeating" class="hidePop">Select heatings to link with</h4>
 <h4 style="float: right;" id="poptuileEquipment" class="hidePop">Select devices to link with</h4>
    </div>


<h3>Changing widget <i><?php echo $name; ?></i></h3>
<?= $warning ?>
<form Method="POST" Action="index.php?page=modify_widget">
    <table style="margin-left:3%;" border="0" cellspacing="0" cellpadding="2">
        <tbody>
            <tr> 
                <td nowrap="" width="27%" class="formulaireText">
                    Name of widget :<br><i>max 15 characters</i>
                </td>
                <td style="padding-left:3%;" width="73%"><input type="text" value="<?php echo $name; ?>" name="libelle" size="50"></td>
            </tr>
            <tr> 
                <td nowrap="" width="27%" class="formulaireText">
                    Image :
                </td>
                <td style="padding-left:3%;" width="73%">
                    <select id="imgListTiles" name="imgList">
                        <option <?php if($icon == "sun" ) echo "selected" ?> value = "sun">Sun</option>
                        <option <?php if($icon == "wind" ) echo "selected" ?> value = "wind">Wind</option>
                        <option <?php if($icon == "barometer" ) echo "selected" ?> value = "barometer">Barometer</option>
                        <option <?php if($icon == "hydrology" ) echo "selected" ?> value = "hydrology">Humidity</option>
                        <option <?php if($icon == "empty" ) echo "selected" ?> value = "empty">Other</option>
                    </select>
                </td>
            </tr>
            <tr> 
                <td nowrap="" width="27%" class="formulaireText">
                    Preview : 
                </td>
                <td style="padding-left:3%;" width="73%">
                    <img id="imgPrev" src= "img/tiles/<?php echo $icon; ?>.png"/>
                </td>
            </tr>
        </tbody>
    </table>

    <div class="buttonGroup2">
        <button class="btn btn-success" type="submit" >OK</button>
        <button class="btn btn-danger" type="reset" >Cancel</button>
    </div>
</form>


<br><br>
<!-- ----------------------------------------------------------- Elements Added --------------------------------------------- -->
<h3>Elements Added</h3>
<?
if( $myequipments == "")
{

} else 
{
	$iddevices = split('[ ]', $myequipments);

		php?>

		   <table class="table table-hover">
		   <thead>
		       <tr>
			   <th>Name</th>
		           <th>Dim</th>
			<th>Switch</th>
			</tr>
		   </thead>
		   <tbody>

		<?
$u = "bug";
foreach($iddevices AS $iddevice)
	{
		$myID = split('[v]', $iddevice);
		foreach($datadevices AS $item) 
		{

			if($myID[0] == $item['id'])
			{

				$item['devicegroup'] = str_replace("|", "  ", $item['devicegroup']);
				if ($item['switchable'] == "T")
				{ 
					if ($item['devicevalue'] == "On" || $item['devicevalue'] == "on")
					{
$u="debug";
						echo "<tr> 
							  <td   width=\"50%\">
									".$item['devicename']."
							  </td> 
 							<td width=\"25%\"> </td>
							  <td   width=\"25%\" class=\"toggle\" >
									<div class=\"slider-frame \"><span id=\"".$item['devicename']."\" class=\"slider-button on\">ON</span>
			
								</div>
							  </td>
						      </tr>";
					} else
					{
$u="debug";

						echo "<tr> 
						  <td   width=\"50%\">
								".$item['devicename']."
						  </td> <tdwidth=\"25%\"> </td>

						  <td class=\"toggle\"   width=\"25%\">
								<div class=\"slider-frame \"><span id=\"".$item['devicename']."\" class=\"slider-button off\">OFF</span>
			
							</div>
						  </td>
					      </tr>";
					}
				} else if ($item['dimable'] == "T")
				{
$u="debug";
					echo "<tr> 
						  <td   width=\"50%\">
							".$item['devicename']."
						  </td> 

						<td width=\"25%\">		
 <button style=\"display: inline-block;\" class=\"btn btn-info\" onclick=\"document.location.href='set_device.php?name=".$item['devicename']."&action=Bright'\">+</button>
                		<button style=\"display: inline-block;\" class=\"btn btn-info\" onclick=\"document.location.href='set_device.php?name=".$item['devicename']."&action=Dim'\">-</button></td> 
			  <td class=\"toggle\" width=\"25%\">
			
				
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

		<table class="table table-hover">
		    <thead>
			<tr>

			    <th>Name</th>
			    <th>Value </th>

			</tr>
		    </thead>
		    <tbody>
		<?
foreach($iddevices AS $iddevice)
	{
		$myID = split('[v]', $iddevice);
		foreach($datadevices AS $item) 
		{
			if($myID[0] == $item['id'])
			{
				$item['devicegroup'] = str_replace("|", " ", $item['devicegroup']);
				if ($item['switchable'] == "" & $item['dimable'] == "")
				{ 
					if ($item['rrdsensors'] == "T")
					{

						echo "<tr> 
							<td   width=\"75%\"><a data-geo=\"data-geo\">
									".$item['devicename']."</a>
							</td> 
									 	 <td   width=\"25%\">";
					if($myID[1] == 1)
					{
						echo $item['devicevalue'];
					}
					if($myID[1] == 2)
					{
						echo $item['devicevalue2'];
					}
					if($myID[1] == 3)
					{
						echo $item['devicevalue3'];
					}
					if($myID[1] == 4)
					{
						echo $item['devicevalue4'];
					}

							 echo "</td>
						      </tr>";
					} else
					{

						echo "<tr>
							<td   width=\"75%\">
									".$item['devicename']."
							</td> 
						 	 <td   width=\"25%\">";
					if($myID[1] == 1)
					{
						echo $item['devicevalue'];
					}
					if($myID[1] == 2)
					{
						echo $item['devicevalue2'];
					}
					if($myID[1] == 3)
					{
						echo $item['devicevalue3'];
					}
					if($myID[1] == 4)
					{
						echo $item['devicevalue4'];
					}

							 echo "</td>
						      </tr>";
					}
				}
			}
		}
}

		php?>
		</tbody>
		</table>  

<?
	

}
php?>
   <?
if( $myheatings == "")
{


} else 
{
	$idheatings = split('[ ]', $myheatings);
	
		php?>
		<table class="table table-hover">
		    <thead>
			<tr>
			    <th>Name</th>
			    <th>Enabled</th>

			</tr>
		    </thead>
		    <tbody>


<?php
$u = "bug";
foreach($idheatings AS $idheating)
{
  foreach($list_scenarii AS $thermostat) {
		if($idheating == $thermostat['idthermo'])
		{
		if ($thermostat['namethermo']==$list_heating[0]['nameheating']) {
$u="debug";
		echo "<tr> 
	
		<td width=\"75%\"> ".$thermostat['namethermo']." </td> 
		<td width=\"25%\">
			<div class=\"toggle\" > 
				<div class=\"slider-frame \"><span id=\"".$thermostat['namethermo'].";;\" class=\"slider-button on\">ON</span>
				</div>
			</div>
		</td>
		</tr> ";
		} else {
$u="debug";
		echo "<tr> 
	
		<td width=\"75%\"> ".$thermostat['namethermo']." </td> 
		<td width=\"25%\">
			<div class=\"toggle\" > 
				<div class=\"slider-frame \"><span id=\"".$thermostat['namethermo'].";;\" class=\"slider-button off\">OFF</span>
				</div>
			</div>
		</td>
		</tr> ";
		}

}
		

}
   }


php?>
</tbody>
		</table>  


<?
	

}
   

?>
<?
if( $myevents == "")
{


} else 
{
	$idevents = split('[ ]', $myevents);
	
		php?>

			<table class="table table-hover">
			    <thead>
				<tr>
				    <th>Run</th>
				    <th>Name</th>
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
	  <td width=\"5%\"> <a href='".$monUrl2[2]."&runaction=".$event['id']."'> <img src=\"img/playicon.png\" alt=\"img/playicon.png\"/> </img> </a> </td> 
	  <td width=\"70%\"> ".$event['eventname']." </td> 

	  <td width=\"25%\" class=\"toggle\">

			<div class=\"slider-frame \"><span id=\"".$event['id']."\" class=\"slider-button on\">ON</span>
			</div>
	  </td>

      </tr>";

     } else {

	      	      echo "<tr> 
	  <td width=\"5%\"> <a href='".$monUrl2[2]."&runaction=".$event['id']."'> <img src=\"img/playicon.png\" alt=\"img/playicon.png\"/> </img> </a> </td> 

	  <td width=\"70%\"> ".$event['eventname']." </td> 

	  <td class=\"toggle\" width=\"25%\">

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
?>
