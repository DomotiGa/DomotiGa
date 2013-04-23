<h2>FILTERS</h2>

<?
if($_GET['kind']=="")
{
	echo "<h3><div style=\"text-align:center;\">No filter selected.</div></h3>";
} else
{
	echo "<h3>DEVICES</h3>
<div id=\"tabs2\">
  <ul>
    <li><a href=\"#tabs-1\">Actuators</a></li>
    <li><a href=\"#tabs-2\">Sensors</a></li>
  </ul>
  <div id=\"tabs-1\">
    <table class=\"table table-hover\">
    <thead>
        <tr>
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
			if ($pos !== false)
			{ 
				if ($item['switchable'] == "T")
				{ 
					$h=$h+1;
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
						  </td> <td></td>
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
						  </td> <td></td>
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
		echo " </tbody></table> <h3 style=\"text-align:center;\"> No Actuators found in this group. </h3>";
		$h = 0;
	}
}

if($_GET['kind'] == "location")
{
	foreach($datadevices AS $item) 
	{
		$item['devicegroup'] = str_replace("|", "  ", $item['devicegroup']);

		if ($item['devicelocation'] == $_GET['choice'])
		{ 
			if ($item['switchable'] == "T")
			{ 
				$h=$h+1;
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
						  </td> <td></td>
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
						  </td> <td></td>
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
		echo "</tbody></table><h3 style=\"text-align:center;\"> No Actuators found on this location. </h3>";
		$h = 0;
	}
}

if($_GET['kind'] == "floor")
{
	foreach($datadevices AS $item) 
	{

		$item['devicegroup'] = str_replace("|", "  ", $item['devicegroup']);

		if ($item['devicefloorname'] == $_GET['choice'])
		{ 
			if ($item['switchable'] == "T")
			{ 
				$h=$h+1;
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
						  </td> <td></td>
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
						  </td> <td></td>
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
		echo "</tbody></table><h3 style=\"text-align:center;\"> No Actuators found on this floor. </h3>";
		$h = 0;
	}
}

if($_GET['kind'] == "type")
{
	foreach($datadevices AS $item) 
	{

		$item['devicegroup'] = str_replace("|", "  ", $item['devicegroup']);

		if ("switches" == $_GET['choice'])
		{ 
			if ($item['switchable'] == "T")
			{ 
				$h=$h+1;
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
						  </td> <td></td>
						  <td class=\"toggle\" >
							 
								<div class=\"slider-frame \" ><span id=\"".$item['devicename']."\" class=\"slider-button on\">ON</span>
								</div>
							
						  </td>
					      </tr>";
				} else
				{
						echo "<tr> 
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
						  </td> <td></td>
						  <td class=\"toggle\" >
								<div class=\"slider-frame \" ><span id=\"".$item['devicename']."\" class=\"slider-button off\">OFF</span>
								
							</div>
						  </td>
					      </tr>";
				}
			} 


		} else if ("dimmers" == $_GET['choice'])
		{ 
			
			if ($item['dimable'] == "T")
			{ 
				$h=$h+1;

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

	}
				if ($h == 0 && $j == 0)
				{
					echo "</tbody></table><h3 style=\"text-align:center;\"> No actuators found. </h3>";
					$h = 0;
					$j = 1;
				}
	   
}	
$j=0;
echo "  
</tbody>
</table>
</div>
<div id=\"tabs-2\">
    <table class=\"table table-hover\">
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
					echo "</tbody></table><h3 style=\"text-align:center;\"> No Sensors found in this group. </h3>";
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
					echo "</tbody></table><h3 style=\"text-align:center;\"> No Sensors found on this location. </h3>";
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
		echo "</tbody></table><h3 style=\"text-align:center;\"> No Sensors found on this floor. </h3>";
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

}
php?>

</tbody>
</table>
</div>
</div>
