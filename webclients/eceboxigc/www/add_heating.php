<? 
$monUrl = "http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
$monUrl2 = $_SERVER['REQUEST_URI'];
$monUrl2 = split ("/", $monUrl2);

    $count = current($db->query("SELECT ID FROM extra_tabs")->fetch());
    if($count != 0){
        $reponse = $db->query('SELECT heatings FROM extra_tabs WHERE ID = '.$_GET['id']);
    }
    while ($donnees = $reponse->fetch())
    {
	$myheatings = $donnees['heatings'];			
    }
     $reponse->closeCursor();


echo "<h2>".$_GET['name']."<button id=\"buttonBack\" onclick=\"document.location.href='index.php?page=tabs&name=".$_GET['name']."&id=".$_GET['id']."'\" style=\"float: right;\" class=\"btn btn-info\">Back...</button> <h4 style=\"float: right;\" id=\"popBack\" class=\"hidePop\">Back to previous page</h4></h2>";


// Get list of scenarii
$list_scenarii=get_scenario_list($_SESSION['view']);

// Get list of heating from the enabled scenario
$list_heating=get_heating($_SESSION['view']);
php?>

<h3>Adding Thermostats</h3>
<form Action="<? echo $monUrl2[2]; ?>s">
 <input type="hidden" name="envoi" value="yes">
		<table class="table table-hover">
		    <thead>
			<tr>
			    <th>Select</th>
			    <th>Name</th>
			    <th>Description</th>
			    <th>Enabled</th>
			</tr>
		    </thead>
		    <tbody>


<?php
  foreach($list_scenarii AS $thermostat) {
		if ($thermostat['namethermo']==$list_heating[0]['nameheating']) {
		echo "<tr> 
						<td >
						<input type=\"checkbox\" name=\"options[]\" value=\"".$thermostat['idthermo']."\">
						  </td> 	
		<td> ".$thermostat['namethermo']." </td> 
		<td> ".$thermostat['descriptionthermo']." </td>
		<td>
			<div class=\"toggle\" > 
				<div class=\"slider-frame \"><span id=\" ;;\" class=\"slider-button on\">ON</span>
				</div>
			</div>
		</td>
		</tr> ";
		} else {
		echo "<tr> 
						<td >
						<input type=\"checkbox\" name=\"options[]\" value=\"".$thermostat['idthermo']."\">
						  </td> 	
		<td> ".$thermostat['namethermo']." </td> 
		<td> ".$thermostat['descriptionthermo']." </td>
		<td>
			<div class=\"toggle\" > 
				<div class=\"slider-frame \"><span id=\"".$thermostat['namethermo'].";;\" class=\"slider-button off\">OFF</span>
				</div>
			</div>
		</td>
		</tr> ";
		}

   }

php?>

</tbody>
</table> 
        <button class="btn btn-success" type="submit">OK</button>
        <button class="btn btn-danger" type="reset">Cancel</button>

<?php
// Add heating
$envoi = $_GET['envoi'];   
$options = $_GET['options'];     
$options_text = implode(' ',$options);   
$options_text3 = split('[ ]', $options_text);
$myheatings2 = split('[ ]', $myheatings); 

foreach($options_text3 AS $theid)
{
	
	foreach($myheatings2 AS $ids)
	{
		if($ids == $theid)
		{	

			$theid = "";
			
			
		}
	}
	$myheatings = $myheatings." ".$theid;
}

if ($envoi == 'yes') 
{
             
	$req =  $db->prepare('UPDATE extra_tabs SET heatings = (:theheatings) WHERE  extra_tabs.ID ='.$_GET['id']);
        $req->execute(array('theheatings' => $myheatings  ));
}
	

// Remove heating
$envoi2 = $_GET['envoi2'];   		
$options2 = $_GET['options2'];
$options2_text = implode(' ',$options2);
$options2_text = split('[ ]', $options2_text);
$myheatings3 = split('[ ]', $myheatings);

foreach($myheatings3 AS $ids)
{
	foreach($options2_text AS $theid)
	{
		if($theid == $ids)
		{
			$ids = "";
		}
	}
	$myheatings7  = $myheatings7." ".$ids;
}
$myheatings = $myheatings7;

if ($envoi2 == 'no') 
{
	$req =  $db->prepare('UPDATE extra_tabs SET heatings = (:theheatings) WHERE  extra_tabs.ID ='.$_GET['id']);
	$req->execute(array('theheatings' => $myheatings7  ));
}

 ?>


<br>
<h3>Thermostats</h3>
<?
if( $myheatings == "")
{

echo " <h3 style=\"text-align:center;\"> You have no Heatings added. </h3>";
} else 
{
	$idheatings = split('[ ]', $myheatings);
	
		php?>
<form Action="<? echo $monUrl2[2]; ?>">
 <input type="hidden" name="envoi2" value="no">
		<table class="table table-hover">
		    <thead>
			<tr>
			    <th>Select</th>
			    <th>Name</th>
			    <th>Description</th>
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
<td >
						<input type=\"checkbox\" name=\"options2[]\" value=\"".$thermostat['idthermo']."\">
						  </td> 	
		<td> ".$thermostat['namethermo']." </td> 
		<td> ".$thermostat['descriptionthermo']." </td>
		<td>
			<div class=\"toggle\" > 
				<div class=\"slider-frame \"><span id=\"".$thermostat['namethermo'].";;\" class=\"slider-button on\">ON</span>
				</div>
			</div>
		</td>
		</tr> ";
		} else {
$u="debug";
		echo "<tr> 
<td >
						<input type=\"checkbox\" name=\"options2[]\" value=\"".$thermostat['idthermo']."\">
						  </td> 	
		<td> ".$thermostat['namethermo']." </td> 
		<td> ".$thermostat['descriptionthermo']." </td>
		<td>
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
		if ($u != "debug")
		{
			
			$u="bug";
			$myheatings = "";
				$req =  $db->prepare('UPDATE extra_tabs SET heatings = (:theheatings) WHERE  extra_tabs.ID ='.$_GET['id']);
        $req->execute(array('theheatings' => $myheatings  ));
		}

php?>
</tbody>
		</table>  
        <button class="btn btn-danger" type="submit">Remove</button>
<?
}
?>
