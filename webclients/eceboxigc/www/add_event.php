<? 
// Get the current url
$monUrl = "http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
$monUrl2 = $_SERVER['REQUEST_URI'];
$monUrl2 = split ("/", $monUrl2);

	// Get the added evebt from the DB
    $count = current($db->query("SELECT ID FROM extra_tabs")->fetch());
    if($count != 0){
        $reponse = $db->query('SELECT events FROM extra_tabs WHERE ID = '.$_GET['id']);
    }
    while ($donnees = $reponse->fetch())
    {
	$myevents = $donnees['events'];			
    }
     $reponse->closeCursor();

// Display title and back button
echo "<h2>".$_GET['name']."<button id=\"buttonBack\" onclick=\"document.location.href='index.php?page=tabs&name=".$_GET['name']."&id=".$_GET['id']."'\" style=\"float: right;\" class=\"btn btn-info\">Back...</button> <h4 style=\"float: right;\" id=\"popBack\" class=\"hidePop\">Back to previous page</h4></h2>";
php?>

<h3>Adding Events</h3>
<?

// Get list of events
$list=get_event_list($_SESSION['view']);

// Send XML Request to run action
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
   // List of events

   foreach($list AS $event) {
      if ($event['enabled']=="True") {	

	      echo "<tr> 
		<td >
		<input type=\"checkbox\" name=\"options[]\" value=\"".$event['id']."\">
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
						<input type=\"checkbox\" name=\"options[]\" value=\"".$event['id']."\">
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
</table>  <!-- Submit button -->
        <button class="btn btn-success" type="submit">OK</button>
        <button class="btn btn-danger" type="reset">Cancel</button>
</form>
<?php
// Add new event to the right tab in the database
$envoi = $_GET['envoi'];   
$options = $_GET['options'];     
$options_text = implode(' ',$options);   
$options_text3 = split('[ ]', $options_text);
$myevents2 = split('[ ]', $myevents); 
// Check if the device is already inside
foreach($options_text3 AS $theid)
{
	
	foreach($myevents2 AS $ids)
	{
		if($ids == $theid)
		{	

			$theid = "";
			
			
		}
	}
	$myevents = $myevents." ".$theid;
}

if ($envoi == 'yes') 
{
             
	$req =  $db->prepare('UPDATE extra_tabs SET events = (:theevents) WHERE  extra_tabs.ID ='.$_GET['id']);
        $req->execute(array('theevents' => $myevents  ));
}
	

// Delete events inside the database
$envoi2 = $_GET['envoi2'];   		
$options2 = $_GET['options2'];
$options2_text = implode(' ',$options2);
$options2_text = split('[ ]', $options2_text);
$myevents3 = split('[ ]', $myevents);
// If the event is inside, we replace it by nothing
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
	$req =  $db->prepare('UPDATE extra_tabs SET events = (:theevents) WHERE  extra_tabs.ID ='.$_GET['id']);
	$req->execute(array('theevents' => $myevents7  ));
}

 ?>
<br>

<!-- Event already add -->
<h3>Events</h3>
<?
if( $myevents == "")
{

echo " <h3 style=\"text-align:center;\"> You have not added any Events. </h3>";
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
						<input type=\"checkbox\" name=\"options2[]\" value=\"".$event['id']."\">
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
						<input type=\"checkbox\" name=\"options2[]\" value=\"".$event['id']."\">
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
	$req =  $db->prepare('UPDATE extra_tabs SET events = (:theevents) WHERE  extra_tabs.ID ='.$_GET['id']);
	$req->execute(array('theevents' => $myevents7  ));
		}
php?>

		</tbody>
		</table>  
        <button class="btn btn-danger" type="submit">Remove</button>

<?
	

}
?>
