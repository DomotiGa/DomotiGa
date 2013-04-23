<?php 
	$monUrl2 = $_SERVER['REQUEST_URI'];
	$monUrl2 = split("[/]", $monUrl2);

	// Start session
	session_start(); 
	ob_start();
	include "init.php";

	// Get/set page
	if(isset($_GET['page']))
	{
		$page = $_GET['page'];
	}        
	else
	{
		$page = "home";
	}

        // Connect to database
        try
        {
		$db = new PDO("mysql:host=$db_host;dbname=$db_name", $db_username, $db_password);
        }
        catch (Exception $e)
        {
                die('Error : ' . $e->getMessage());
        }

	$count = current($db->query("SELECT ID FROM extra_tabs")->fetch());

	if(isset($_GET['init']) && $count == 0) 
	{	
		$name = "HEATING";
		$icon = "hvac";
		$one = "weather";
		$two = "event";
		$three = "heating";
		$four = "equipment";
		$five = "graph";
		$req = $db->prepare('INSERT INTO extra_tabs(tab_name, tab_icon, one, two, three, four, five) VALUES(:tab_name, :tab_icon, :one, :two, :three, :four, :five)');
                $req->execute(array('tab_name' => $name,'tab_icon' => $icon, 
		    'one' => $one, 
		    'two' => $two, 
		    'three' => $three, 
	            'four' => $four, 
		    'five' => $five));
		$name = "EVENTS";
		$icon = "events";
		$one = "weather";
		$two = "event";
		$three = "heating";
		$four = "equipment";
		$five = "graph";
		$req = $db->prepare('INSERT INTO extra_tabs(tab_name, tab_icon, one, two, three, four, five) VALUES(:tab_name, :tab_icon, :one, :two, :three, :four, :five)');
                $req->execute(array('tab_name' => $name,'tab_icon' => $icon, 
		    'one' => $one, 
		    'two' => $two, 
		    'three' => $three, 
	            'four' => $four, 
		    'five' => $five));
		$name = "DEVICES";
		$icon = "devices";
		$one = "weather";
		$two = "event";
		$three = "heating";
		$four = "equipment";
		$five = "graph";
		$req = $db->prepare('INSERT INTO extra_tabs(tab_name, tab_icon, one, two, three, four, five) VALUES(:tab_name, :tab_icon, :one, :two, :three, :four, :five)');
                $req->execute(array('tab_name' => $name,'tab_icon' => $icon, 
		    'one' => $one, 
		    'two' => $two, 
		    'three' => $three, 
	            'four' => $four, 
		    'five' => $five));
		$count = current($db->query("SELECT ID FROM extra_tabs")->fetch());
    		$reponse = $db->query('SELECT ID, tab_name FROM extra_tabs');

		// Get list of event
		$list=get_event_list($_SESSION['view']);

		// Get list of scenarii
		$list_scenarii=get_scenario_list($_SESSION['view']);
		$datadevices=get_device_list($_SESSION['view']);

		    while ($donnees = $reponse->fetch())
		    {
			$myID[] = $donnees['ID'];			
		    }
		     $reponse->closeCursor();

  		 foreach($list AS $event) {
		$myevents = $myevents." ".$event['id'];
		}
 		foreach($list_scenarii AS $thermostat) {
		$myheatings = $myheatings." ".$thermostat['idthermo'];
		}
		foreach($datadevices AS $items) {
		$myequipments = $myequipments." ".$items['id'];
		}

		$req =  $db->prepare('UPDATE extra_tabs SET events = (:theevents) WHERE  extra_tabs.ID = '.$myID[1]);
		$req->execute(array('theevents' => $myevents  ));
		$req =  $db->prepare('UPDATE extra_tabs SET heatings = (:theheatings) WHERE  extra_tabs.ID = '.$myID[0] );
		$req->execute(array('theheatings' => $myheatings  ));
		$req =  $db->prepare('UPDATE extra_tabs SET devices = (:theequipments) WHERE  extra_tabs.ID = '.$myID[2] );
		$req->execute(array('theequipments' => $myequipments  ));
	}
?>
<!DOCTYPE html>
<html>
    <head>
        <title>ECEbox IGC</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/template.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/jquery-ui.css"> 
        <link rel="shortcut icon" type="image/png" href="img/favicon.png"/>
        <script src="lib/jquery-1.8.3.js"></script>
        <script src="lib/jquery-ui-1.9.2.js"></script>
        <script>
            $(function() {
                $("#menu2").accordion( {collapsible: true, active: false, autoHeight: false });
                $("#menuheating").accordion( {collapsible: true, active: false, autoHeight: false });
                $("#weatherBox").draggable({ containment: "#allWidgets", scroll: false, grid: [ 20,20 ] });
                $("#heatingBox").draggable({ containment: "#allWidgets", scroll: false, grid: [ 20,20 ] });
                $("#eventBox").draggable({ containment: "#allWidgets", scroll: false, grid: [ 20,20 ] });
		$("#tabs").tabs( {collapsible: true });
		$("#tabs2").tabs( {collapsible: true });
		$("#radioheating").buttonset();
		$("#radiograph").buttonset();
		$( ".portlet" ).addClass( "ui-widget ui-widget-content ui-helper-clearfix ui-corner-all" )
		.find( ".portlet-header" )
		.addClass( "ui-widget-header ui-corner-all" )
		.prepend( "<span class='ui-icon ui-icon-minusthick'></span>")
		.end()
		.find( ".portlet-content" );
		$( ".portlet-header .ui-icon" ).click(function() {
		$( this ).toggleClass( "ui-icon-minusthick" ).toggleClass( "ui-icon-plusthick" );
		$( this ).parents( ".portlet:first" ).find( ".portlet-content" ).toggle();
		});
		$( ".column" ).disableSelection();
            });
        </script>
    </head>
    <body>
        <header>
            <?php include("inc/header.php"); ?>
        </header>
        <div class="page">
            <section>
                <?php 
                    $monUrl = "http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']; 
                    if(substr_count($monUrl,"filters") > 0 ){
                        include("inc/sidebarfilter.php"); 
                    }
                    else{
                        include("inc/sidebar.php");
                    }
                ?>
                <article>
                    <div class="content">
                        <?php include($page.".php"); ?>
                    </div>
                </article>
            </section>
            <?php
                if(substr_count($monUrl,"home") > 0 || substr($monUrl,strlen($monUrl)-10,10)== "$monUrl2[1]/" ){   
            ?>
            <div class="buttonGroup">
                <button style="display: inline-block;" class="btn btn-info" onclick="document.location.href='index.php?page=add_widget'">+</button>
                <?php 
                    $count = current($db->query("SELECT * FROM tiles")->fetch());
                    if($count != 0){ 
                ?>
                <button style="display: inline-block;" class="btn btn-info" onclick="document.location.href='index.php?page=remove_widget'">-</button>
                <?php } ?>
            </div>
            <?php
                }
            ?>
            
        </div>
        <footer>
                <?php include("inc/footer.php"); ?>
        </footer>
    </body>
    <script src="lib/general.js"></script>
</html>
<?php ob_end_flush(); ?>
