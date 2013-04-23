<? 
$monUrl = "http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
$monUrl2 = $_SERVER['REQUEST_URI'];
$monUrl2 = split ("/", $monUrl2);

    $count = current($db->query("SELECT ID FROM tiles")->fetch());
    if($count != 0){
        $reponse = $db->query('SELECT event, counts FROM tiles WHERE ID = '.$_GET['id']);
    }
    while ($donnees = $reponse->fetch())
    {
	$myevents = $donnees['event'];
	$nbtuile = $donnees['counts'];
    }
     $reponse->closeCursor();


echo "<h2>".$_GET['name']."<button id=\"buttonBack\" onclick=\"document.location.href='index.php?page=modify_widget'\" style=\"float: right;\" class=\"btn btn-info\">Back...</button> <h4 style=\"float: right;\" id=\"popBack\" class=\"hidePop\">Back to previous page</h4></h2>";
php?>

<h3>Add Event</h3>
<?

// Get list of events
$list=get_event_list($_SESSION['view']);

if(isset($_GET['runaction'])){
   echo "<h3>Requested to turn ".$_GET['runaction'].".</h3>";
   $request = xmlrpc_encode_request("events.runactions",array($_GET['runaction'] ) );
   $response = do_xmlrpc($request);
   header("Location: index.php?page=events");
}

?>
<form Action="<? echo $monUrl2[2]; ?>">
 <input type="hidden" name="envoi" value="yes">
<table class="table table-hover">
    <thead>
        <tr>
            <th>Select</th>
            <th>Name</th>
            <th>Description</th>
            <th>Last Run</th>
            <th>Enabled</th>
        </tr>
    </thead>
    <tbody>

<?php
   // List events

   foreach($list AS $event) {
      if ($event['enabled']=="True") {	

	      echo "<tr> 
		<td >
		<input type=\"radio\" name=\"options[]\" value=\"".$event['id']."\">
		  </td> 
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
				<td >
			<input type=\"radio\" name=\"options[]\" value=\"".$event['id']."\">
		  </td> 
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

?>
    </tbody>
</table>  
        <button class="btn btn-success" type="submit">OK</button>
        <button class="btn btn-danger" type="reset">Cancel</button>
</form>
<?php
// Add events
$envoi = $_GET['envoi'];   
$options = $_GET['options'];     
$options_text = implode(' ',$options);   
$options_text3 = split('[ ]', $options_text);
$myevents2 = split('[ ]', $myevents); 

foreach($options_text3 AS $theid)
{
	
	foreach($myevents2 AS $ids)
	{
		if($ids == $theid)
		{	

			$theid = "";
			
		}
	}
	$myevents8 = $myevents." ".$theid;
}

if ($envoi == 'yes') 
{
	if($nbtuile < 3)
	{
		if($myevents8 != $myevents." ")
		{$nbtuile = $nbtuile + 1;}
		$req =  $db->prepare('UPDATE tiles SET event = (:theeventstuile) WHERE  tiles.ID ='.$_GET['id']);
		$req->execute(array('theeventstuile' => $myevents8  ));
		$req =  $db->prepare('UPDATE tiles SET counts = (:nbtuile) WHERE  tiles.ID ='.$_GET['id']);
		$req->execute(array('nbtuile' => $nbtuile  ));
	} else echo "The maximum number of elements has already been added";
}
$myevents = $myevents8;	

// Remove events
$envoi2 = $_GET['envoi2'];   		
$options2 = $_GET['options2'];
$options2_text = implode(' ',$options2);
$options2_text = split('[ ]', $options2_text);
$myevents3 = split('[ ]', $myevents);

foreach($myevents3 AS $ids)
{
	foreach($options2_text AS $theid)
	{
		if($theid == $ids)
		{
			$ids = "";
		}
	}
	$myevents7  = $myevents7." ".$ids;
}
$myevents = $myevents7;

if ($envoi2 == 'no') 
{
	$nbtuile = $nbtuile - 1;
	$req =  $db->prepare('UPDATE tiles SET event = (:theeventstuile) WHERE  tiles.ID ='.$_GET['id']);
	$req->execute(array('theeventstuile' => $myevents7  ));
		$req =  $db->prepare('UPDATE tiles SET counts = (:nbtuile) WHERE  tiles.ID ='.$_GET['id']);
		$req->execute(array('nbtuile' => $nbtuile  ));
}

 ?>
<br>
<h3>Added Events</h3>
<?
if( $myevents == "")
{

echo " <h3 style=\"text-align:center;\"> You have not added any Events yet. </h3>";
} else 
{
	$idevents = split('[ ]', $myevents);
	
		php?>
<form Action="<? echo $monUrl2[2]; ?>">
 <input type="hidden" name="envoi2" value="no">
			<table class="table table-hover">
			    <thead>
				<tr>
				    <th>Select</th>
				    <th>Name</th>
				    <th>Description</th>
				    <th>Last Run</th>
				    <th>Enabled</th>
				</tr>
			    </thead>
			    <tbody>
		<?
$u = "bug";
foreach($idevents AS $idevent)
{
	foreach($list AS $event) {
		if($idevent == $event['id'])
		{
      if ($event['enabled']=="True") {	
$u="debug";

	      echo "<tr> 
<td >
		<input type=\"radio\" name=\"options2[]\" value=\"".$event['id']."\">
		  </td> 
	  <td> ".$event['eventname']." </td> 
	  <td> ".$event['description']." </td> 
	  <td> ".$event['lastrun']." </td> 

	  <td class=\"toggle\">

			<div class=\"slider-frame \"><span id=\"".$event['id']."\" class=\"slider-button on\">ON</span>
			</div>
	  </td>

      </tr>";

     } else {
$u="debug";
	      	      echo "<tr> 
<td >
		<input type=\"radio\" name=\"options2[]\" value=\"".$event['id']."\">
		  </td> 
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

		if ($u != "debug")
		{
			
			$u="bug";
			$myevents7 = "";
	$req =  $db->prepare('UPDATE tiles SET event = (:theeventstuile) WHERE  tiles.ID ='.$_GET['id']);
	$req->execute(array('theeventstuile' => $myevents7  ));
		}
php?>

		</tbody>
		</table>  
        <button class="btn btn-danger" type="submit">Remove</button>

<?
	
}
   
?>
