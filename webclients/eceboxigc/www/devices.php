<?
// Get list of devices
$datadevices=get_device_list($_SESSION['view']);

php?>

<h2>DEVICES</h2>
<div id="tabs">
  <ul>
    <li><a href="#tabs-1"><span>Actuators</span></a></li>
    <li><a href="#tabs-2"><span>Sensors</span></a></li>
  </ul>
  <div id="tabs-1">
    <table class="table table-hover">
    <thead>
        <tr>
            <th>Name</th>
            <th>Groups</th>
            <th>Location</th>
            <th>Floor</th>
            <th>Model</th>
            <th>Dim</th>
	<th>Switch</th>
        </tr>
    </thead>
    <tbody>

<?
   foreach($datadevices AS $item) 
{

$item['devicegroup'] = str_replace("|", "  ", $item['devicegroup']);
	if ($item['switchable'] == "T")
	{ 
		if ($item['devicevalue'] == "On" || $item['devicevalue'] == "on")
		{
			echo "<tr> 
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
<td></td>
				  <td class=\"toggle\" >
						<div class=\"slider-frame \"><span id=\"".$item['devicename']."\" class=\"slider-button on\">ON</span>
			
					</div>
				  </td>
			      </tr>";
		} else
		{

			echo "<tr> 
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
<td> </td>
			  <td class=\"toggle\" >
					<div class=\"slider-frame \"><span id=\"".$item['devicename']."\" class=\"slider-button off\">OFF</span>
			
				</div>
			  </td>
		      </tr>";
		}
	} else if ($item['dimable'] == "T")
	{
		echo "<tr> 
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
   foreach($datadevices AS $item) {
$item['devicegroup'] = str_replace("|", " ", $item['devicegroup']);
if ($item['switchable'] == "" & $item['dimable'] == "")
{ 
if ($item['rrdsensors'] == "T")
{
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
echo "<tr>
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

php?>
    </tbody>
</table>  

  </div>
</div>

