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

<h2>EVENTS</h2>
<h3>   </h3>
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

<?php
   // List events
   foreach($list AS $event) {
      if ($event['enabled']=="True") {	

	      echo "<tr> 
	  <td> <a href='index.php?page=events&runaction=".$event['id']."'> <img src=\"img/playicon.png\" alt=\"img/playicon.png\"/> </img> </a> </td> 
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
	  <td> <a href='index.php?page=events&runaction=".$event['id']."'> <img src=\"img/playicon.png\" alt=\"img/playicon.png\"/> </img> </a> </td> 
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
