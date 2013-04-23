<?php
$datadevices=get_device_list($_SESSION['view']);
// Get list of scenarii
$list_scenarii=get_scenario_list($_SESSION['view']);

// Get list of heating from the enabled scenario
$list_heating=get_heating($_SESSION['view']);
$list=get_event_list($_SESSION['view']);
$monUrl = "http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
$monUrl2 = $_SERVER['REQUEST_URI'];
$monUrl2 = split ("/", $monUrl2);


    $count = current($db->query("SELECT * FROM tiles")->fetch());
    if($count != 0){
        $reponse = $db->query('SELECT ID, tile_name, tile_icon FROM tiles');
    }

	// Ddebug des checkbox 
	
	$monUrl2 = $_SERVER['REQUEST_URI'];
	$monUrl2 = split ("/", $monUrl2);
	$monUrl3 = split ("=", $monUrl2[2]);
	$add2 = split('[?]',$_SERVER['HTTP_REFERER']); 
	$monUrl4=split ("[?]", $monUrl2[2]);
	$addfin = $add2[1]."&".$monUrl4[1];

	if($monUrl3[0] == "index.php?envoi" || $monUrl3[0] == "index.php?envoi2")
	{
		header("Location: index.php?".$addfin);
	}

	//Fin debug checkbox

if(isset($_GET['setscenario'])){
   echo "<h3>Requested to turn ".$_GET['setscenario'].".</h3>";
   $request = xmlrpc_encode_request("thermostat.setscenario",array($_GET['setscenario']) );
   $response = do_xmlrpc($request);
  	$add = split('[?]',$_SERVER['HTTP_REFERER']); 
	header("Location: index.php?".$add[1]);
}

if(isset($_GET['runaction'])){
   echo "<h3>Requested to turn ".$_GET['runaction'].".</h3>";
   $request = xmlrpc_encode_request("events.runactions.web",array($_GET['runaction'] ) );
   $response = do_xmlrpc($request);
$add = split('[?]',$_SERVER['HTTP_REFERER']); 
   header("Location: index.php?".$add[1]);
}

?>
<!-- start of page -->
<tbody>
<h2>DASHBOARD</h2>

<?php
//init
$count_col=0;
echo '<table >';

	if($count != 0){
		// Loop BDD
		while ($donnees = $reponse->fetch())
            	{	
		$id = $donnees['ID'];
			if($count_col == 0){
				echo '<tr id="manos_row" height="100%">';
			}

	
		?>
			<td id="manos_case" width="400" >
			<div align="center" src= "img/tiles/<?php echo $donnees['tile_icon']; ?>.png" id="<?php echo $donnees['tile_name']; ?>" class="portlet">
				<div class="portlet-header" ><h3><img style="float: left;" src= "img/tiles/<?php echo $donnees['tile_icon']; ?>.png" height="50" width="50" ><?php echo $donnees['tile_name']; ?></h3></div>
				

<div class="portlet-content">
<?
    $reponse2 = $db->query('SELECT ID, tile_name, tile_icon, device, heating, event FROM tiles WHERE ID='.$id);
    while ($donnees2 = $reponse2->fetch())
    {	
	$myequipments = $donnees2['device'];
	$name = $donnees2['tile_name'];	
	$icon = $donnees2['tile_icon'];
	$myheatings = $donnees2['heating'];	
	$myevents = $donnees2['event'];			
    }

if( $myequipments == "")
{

} else 
{
	$iddevices = split('[ ]', $myequipments);

		
	
		php?>



		   <table class="table table-hover">
		   <tbody>



		<?
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

					echo "<tr> 
						  <td   width=\"40%\">
							".$item['devicename']."
						  </td> 

						<td width=\"35%\">		
 <button style=\"display: inline-block;\" class=\"btn btn-info\" onclick=\"document.location.href='setdevices.php?name=".$item['devicename']."&action=Bright'\">+</button>
                		<button style=\"display: inline-block;\" class=\"btn btn-info\" onclick=\"document.location.href='setdevices.php?name=".$item['devicename']."&action=Dim'\">-</button></td> 
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
				<div class=\"slider-frame \"><span id=\" ;;\" class=\"slider-button on\">ON</span>
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
			</div></div>
		<?php
		echo '</td>';
			$count_col++;

			if($count_col == 4){
				$count_col=0;
				echo '</tr>';
			}	
		
		}
		$reponse->closeCursor();
	}
?>	
</table>
</tbody>
