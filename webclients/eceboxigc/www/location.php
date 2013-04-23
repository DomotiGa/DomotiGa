<?php
// Get list of location and devices
$list_location=get_location($_SESSION['view']);
$list_device=get_device_list($_SESSION['view']);
?>

<h2>LOCATIONS</h2>
<?php
    $count = current($db->query("SELECT * FROM locat")->fetch());
    if($count != 0){
        $reponse = $db->query('SELECT locat_name, locat_icon FROM locat');
    }
?>
            <div class="buttonGroup">
                <button style="display: inline-block;" class="btn btn-info" onclick="document.location.href='index.php?page=add_location'">+</button>
                <?php 
                    $count = current($db->query("SELECT * FROM locat")->fetch());
                    if($count != 0){ 
                ?>
                <button style="display: inline-block;" class="btn btn-info" onclick="document.location.href='index.php?page=remove_location'">-</button>
                <?php } ?>
            </div>
    <?php
        if($count != 0){
            while ($donnees = $reponse->fetch())
            {
    ?>
    <div id="<?php echo $donnees['locat_name']; ?>" class="widget ui-widget-content widgetShift">
        <h3><?php echo $donnees['locat_name']; ?></h3>
        <div class="<?php echo $donnees['locat_icon']; ?>"></div>
    </div>
    <?php
            }
            $reponse->closeCursor();
        }
    ?>

<!--

<style>
.column { width: 328px; float: left; padding-bottom: 100px; }
 .portlet { margin: 0 1em 1em 0; }
.portlet-header { margin: 0.3em; padding-bottom: 4px; padding-left: 0.2em; }
.portlet-header .ui-icon { float: right; }
.portlet-content { padding: 0.4em; }
.ui-sortable-placeholder { border: 1px dotted black; visibility: visible !important; height: 50px !important; }
.ui-sortable-placeholder * { visibility: hidden; }
</style>

<script>
$(function() {
$( ".column" ).sortable({
connectWith: ".column"
});
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
-->
<?php
$index = 5;

foreach($list_location AS $location) {

	if ($location['namelocation']!=""){
		if (($index % 5 == 0)||($index==5)) {
					echo "<div class=\"column\">";
		}
		echo   "<div class=\"portlet\">
			<div class=\"portlet-header\">".$location['namelocation']."</div>
			<div class=\"portlet-content\">";
?>
			    <table class="table table-hover">
			    <thead>
				<tr>
				    <th>Name</th>
				    <th>State</th>
				</tr>
			    </thead>
			    <tbody>
<?php
		foreach($list_device AS $device) {
			if (($device['devicelocation'] == $location['namelocation']) && ($device['switchable']=="T") ) {
				if (!strcasecmp($device['devicevalue'], "On"))
				{
					echo "<tr> 
						<td >".$device['devicename']."</td> 
						<td class=\"toggle\" >
							<div class=\"slider-frame \"><span id=\"".$device['devicename']."\" class=\"slider-button on\">ON</span></div>
						</td>
					</tr>";
				} else
				{
					echo "<tr> 
						<td >".$device['devicename']."</td> 
						<td class=\"toggle\" >
							<div class=\"slider-frame \"><span id=\"".$device['devicename']."\" class=\"slider-button off\">OFF</span></div>
						</td>
					</tr>";
				}
			}
		}
		echo "</tbody></table></div></div>";

		if (($index % 5 == 0)||($index==5)) {
			echo "</div>";
		} 
		
		$index++;
	}
}
?>
