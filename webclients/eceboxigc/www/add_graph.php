<?
// Get list of devices
$datadevices=get_device_list($_SESSION['view']);
$sTime = "1h";

$monUrl = "http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
$monUrl2 = $_SERVER['REQUEST_URI'];
$monUrl2 = split ("/", $monUrl2);

    $count = current($db->query("SELECT ID FROM extra_tabs")->fetch());
    if($count != 0){
        $reponse = $db->query('SELECT graphs FROM extra_tabs WHERE ID = '.$_GET['id']);
    }
    while ($donnees = $reponse->fetch())
    {
	$mygraphs = $donnees['graphs'];	
		
    }
     $reponse->closeCursor();


if(isset($_GET['updategraph'])){

   $sTime = $_GET['updategraph'];

}

if(isset($_POST['textbox'])){

   $sTime = $_POST['textbox'];

}

php?>

<script>

function loadPage(param) {
self.location.href=document.location+"&kind="+param;
}

function loadPage2(param) {
self.location.href=document.location+"&choice="+param;
}

function loadPage3(param) {
self.location.href=document.location+"&sensor="+param;
}
</script>

<?

if($_GET['kind'] == "group")
{
	$kind = "Groups";
} else if($_GET['kind'] == "location")
{
$kind = "Locations";
} else if($_GET['kind'] == "floor")
{
$kind = "Floors";
} else if($_GET['kind'] == "type")
{
$kind = "Types";
}else if($_GET['kind'] == "")
{
$kind = ""; 
}


// Title          
echo "<h2>".$_GET['name']."<button id=\"buttonBack\" onclick=\"document.location.href='index.php?page=tabs&name=".$_GET['name']."&id=".$_GET['id']."'\" style=\"float: right;\" class=\"btn btn-info\">Back...</button> <h4 style=\"float: right;\" id=\"popBack\" class=\"hidePop\">Back to previous page</h4></h2>";

php?>

<h3>Adding Graphs</h3>
<form Method="POST" Action="<?php echo $monUrl[2];?>">
    <table style="margin-left:3%;" border="0" cellspacing="0" cellpadding="2">
        <tbody>
            <tr> 
                <td nowrap="" width="27%" class="formulaireText">
                    Filter :
                </td>
                <td style="padding-left:3%;" width="73%">
                    <select id="kindDevice"  name="kind" onchange="loadPage(this.value);">
<?
		echo "<option value = \" \" SELECTED> </option>";
		if($_GET['kind'] == "group")
		{
                       echo "<option value = \"group\" SELECTED>Groups</option>";
		} else echo "<option value = \"group\">Groups</option>";
		if($_GET['kind'] == "location")
		{
                       echo "<option value = \"location\" SELECTED>Locations</option>";
		} else echo "<option value = \"location\">Locations</option>";
		if($_GET['kind'] == "floor")
		{
                       echo "<option value = \"floor\" SELECTED>Floors</option>";
		} else echo "<option value = \"floor\">Floors</option>";
		if($_GET['kind'] == "type")
		{
                       echo "<option value = \"type\" SELECTED>Types</option>";
		} else echo "<option value = \"type\">Types</option>";
php?>
                    </select>
                </td>
	</tr>
<? if($_GET['kind'] != "")
{ php?>      <tr> 
		<td nowrap="" width="27%" class="formulaireText">
                    <?php echo $kind; ?> :
                </td>
                <td style="padding-left:3%;" width="73%">
                    <select id="choiceDevice" name="choice" onchange="loadPage2(this.value);">
<?
if($_GET['choice'] == "")
{
	
	echo "<option value =\" \" SELECTED> </option>";

} else
{
	$choice = str_replace("%20", " ", $_GET['choice']);
	echo "<option value = \"".$_GET['choice']."\" SELECTED>".$choice."</option>";
}
if($_GET['kind'] == "group")
{
                       
// Parsing of groups
foreach($datadevices AS $item) 
{

		
	if ($item['devicegroup'] != "")
	{
		
		$group = split('[|.-]', $item['devicegroup']);
		
	}
	foreach($group AS $result)
	{
		$array[]=$result;
	}
}

// End parsings array

// Start search duplicates
$array3[] = "init";

foreach($array AS $value) 
{

	foreach($array3 AS $value3) 
	{
		if ($value == $value3)
		{
			$h++;
			
		}
	}
	if( $h == 0)
	{
		$array3[]=$value;
	}
	$h=0;

}
foreach($array3 AS $value3) 
{
	
	if($value3 != "init" && $value3 != "")
	{
$value4 = str_replace(" ", "%20", $value3);
	echo "<option value = \"".$value4."\">".$value3."</option>";
	}
}
}
if($_GET['kind'] == "location")
{
                
// Filter duplicates
$loc3[] = "init";

foreach($datadevices AS $item) 
{
	if (	$item['devicelocation'] != "")
	{
	$loc2[]=$item['devicelocation'];
	}
}

foreach($loc2 AS $value2) 
{

	foreach($loc3 AS $value3) 
	{
		if ($value2 == $value3)
		{
			$h++;
			
		}
	}
	if( $h == 0)
	{
		$loc3[]=$value2;
	}
	$h=0;
	


}
foreach($loc3 AS $value3) 
{
	if($value3 != "init" && $value3 != "")
	{
	$value4 = str_replace(" ", "%20", $value3);
	echo " <option value = \"".$value4."\">".$value3."</option>";
	}
}
}
if($_GET['kind'] == "floor")
{
// Filter duplicates
$floor3[] = "init";

foreach($datadevices AS $item) 
{
	if ($item['devicefloorname'] != "")
	{
	$floor2[]=$item['devicefloorname'];
	}
}

foreach($floor2 AS $value2) 
{

	foreach($floor3 AS $value3) 
	{
		if ($value2 == $value3)
		{
			$h++;
			
		}
	}
	if( $h == 0)
	{
		$floor3[]=$value2;
	}
	$h=0;

}
foreach($floor3 AS $value3) 
{
	if($value3 != "init" && $value3 != "")
	{
$value4 = str_replace(" ", "%20", $value3);
	echo "<option value = \"".$value4."\">".$value3."</option>";
	}
}
}
if($_GET['kind'] == "type")
{
	echo "<option value = \"switches\">Switches</option>";
	echo "<option value = \"dimmers\">Dimmers</option>";
	echo "<option value = \"sensors\">Sensors</option>";
}

php?>
        
                    </select>
                </td>
</tr>
<? } php?>

            
            
        </tbody>
    </table>
</form>

<?

if( $_GET['kind'] != "" && $_GET['choice'] != "")
{
	echo "<h3>Select a value to add</h3>
<div id=\"tabs2\">
  <ul>
    <li><a href=\"#tabs-2\">Sensors</a></li>
  </ul>
<form Action=\"".$monUrl2[2]."\">
 <input type=\"hidden\" name=\"envoi\" value=\"yes\">
<div id=\"tabs-2\">
    <table class=\"table table-hover\">
    <thead>
        <tr>
            <th>Name</th>
            <th>Groups</th>
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

		// Parsing of groups
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
					if ($item['rrd'] == "T" && $item['graph'] == "T")
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
						</td> ";
						if ($item['valuerrdtype']!="")
						{
							echo " <td >
			<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."v1\">
										".$item['devicevalue']."
								 </td>";
						} else 
						{
							echo " <td >
			<input type=\"checkbox\" disabled=\"disabled\" name=\"options[]\" value=\"".$item['id']."v1\">
										".$item['devicevalue']."
								 </td>";
						}
						if ($item['value2rrdtype']!="")
						{
							 echo " <td>
			<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."v2\">
										".$item['devicevalue2']."
								 </td>";
						} else 
						{
							echo " <td>
			<input type=\"checkbox\" disabled=\"disabled\" name=\"options[]\" value=\"".$item['id']."v2\">
										".$item['devicevalue2']."
								 </td>";
						}
						if ($item['value3rrdtype']!="")
						{
							echo " <td >
			<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."v3\">
										".$item['devicevalue3']."
								 </td>";
						} else 
						{
							echo " <td >
			<input type=\"checkbox\" disabled=\"disabled\" name=\"options[]\" value=\"".$item['id']."v3\">
										".$item['devicevalue3']."
								 </td>";
						}
						if ($item['value4rrdtype']!="")
						{
							 echo " <td >
			<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."v4\">
										".$item['devicevalue4']."
								 </td>";
						} else 
						{
							echo " <td >
			<input type=\"checkbox\" disabled=\"disabled\" name=\"options[]\" value=\"".$item['id']."v4\">
										".$item['devicevalue4']."
								 </td>";
						}
						 echo " </tr>";	
					}	
				}

			}
	       }
	}

				if ($k == 0 )
				{
					echo "</tbody></table><h3 style=\"text-align:center;\"> You do not have Sensors in this Group. </h3>";
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
					if ($item['rrd'] == "T" && $item['graph'] == "T")
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
						</td> ";
						if ($item['valuerrdtype']!="")
						{
							echo " <td >
			<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."v1\">
										".$item['devicevalue']."
								 </td>";
						} else 
						{
							echo " <td >
			<input type=\"checkbox\" disabled=\"disabled\" name=\"options[]\" value=\"".$item['id']."v1\">
										".$item['devicevalue']."
								 </td>";
						}
						if ($item['value2rrdtype']!="")
						{
							 echo " <td>
			<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."v2\">
										".$item['devicevalue2']."
								 </td>";
						} else 
						{
							echo " <td>
			<input type=\"checkbox\" disabled=\"disabled\" name=\"options[]\" value=\"".$item['id']."v2\">
										".$item['devicevalue2']."
								 </td>";
						}
						if ($item['value3rrdtype']!="")
						{
							echo " <td >
			<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."v3\">
										".$item['devicevalue3']."
								 </td>";
						} else 
						{
							echo " <td >
			<input type=\"checkbox\" disabled=\"disabled\" name=\"options[]\" value=\"".$item['id']."v3\">
										".$item['devicevalue3']."
								 </td>";
						}
						if ($item['value4rrdtype']!="")
						{
							 echo " <td >
			<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."v4\">
										".$item['devicevalue4']."
								 </td>";
						} else 
						{
							echo " <td >
			<input type=\"checkbox\" disabled=\"disabled\" name=\"options[]\" value=\"".$item['id']."v4\">
										".$item['devicevalue4']."
								 </td>";
						}
						 echo " </tr>";	
					}
			}


		}
	   
	}

				if ($k == 0 )
				{
					echo "</tbody></table><h3 style=\"text-align:center;\"> You do not have a Device in this Location. </h3>";
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
					if ($item['rrd'] == "T" && $item['graph'] == "T")
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
						</td> ";
						if ($item['valuerrdtype']!="")
						{
							echo " <td >
			<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."v1\">
										".$item['devicevalue']."
								 </td>";
						} else 
						{
							echo " <td >
			<input type=\"checkbox\" disabled=\"disabled\" name=\"options[]\" value=\"".$item['id']."v1\">
										".$item['devicevalue']."
								 </td>";
						}
						if ($item['value2rrdtype']!="")
						{
							 echo " <td>
			<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."v2\">
										".$item['devicevalue2']."
								 </td>";
						} else 
						{
							echo " <td>
			<input type=\"checkbox\" disabled=\"disabled\" name=\"options[]\" value=\"".$item['id']."v2\">
										".$item['devicevalue2']."
								 </td>";
						}
						if ($item['value3rrdtype']!="")
						{
							echo " <td >
			<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."v3\">
										".$item['devicevalue3']."
								 </td>";
						} else 
						{
							echo " <td >
			<input type=\"checkbox\" disabled=\"disabled\" name=\"options[]\" value=\"".$item['id']."v3\">
										".$item['devicevalue3']."
								 </td>";
						}
						if ($item['value4rrdtype']!="")
						{
							 echo " <td >
			<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."v4\">
										".$item['devicevalue4']."
								 </td>";
						} else 
						{
							echo " <td >
			<input type=\"checkbox\" disabled=\"disabled\" name=\"options[]\" value=\"".$item['id']."v4\">
										".$item['devicevalue4']."
								 </td>";
						}
						 echo " </tr>";	
					}	
			}

		}
	}

	if ($k == 0 )
	{
		echo "</tbody></table><h3 style=\"text-align:center;\"> You do not have a Sensor on this Floor. </h3>";
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
					if ($item['rrd'] == "T" && $item['graph'] == "T")
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
						</td> ";
						if ($item['valuerrdtype']!="")
						{
							echo " <td >
			<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."v1\">
										".$item['devicevalue']."
								 </td>";
						} else 
						{
							echo " <td >
			<input type=\"checkbox\" disabled=\"disabled\" name=\"options[]\" value=\"".$item['id']."v1\">
										".$item['devicevalue']."
								 </td>";
						}
						if ($item['value2rrdtype']!="")
						{
							 echo " <td>
			<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."v2\">
										".$item['devicevalue2']."
								 </td>";
						} else 
						{
							echo " <td>
			<input type=\"checkbox\" disabled=\"disabled\" name=\"options[]\" value=\"".$item['id']."v2\">
										".$item['devicevalue2']."
								 </td>";
						}
						if ($item['value3rrdtype']!="")
						{
							echo " <td >
			<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."v3\">
										".$item['devicevalue3']."
								 </td>";
						} else 
						{
							echo " <td >
			<input type=\"checkbox\" disabled=\"disabled\" name=\"options[]\" value=\"".$item['id']."v3\">
										".$item['devicevalue3']."
								 </td>";
						}
						if ($item['value4rrdtype']!="")
						{
							 echo " <td >
			<input type=\"checkbox\" name=\"options[]\" value=\"".$item['id']."v4\">
										".$item['devicevalue4']."
								 </td>";
						} else 
						{
							echo " <td >
			<input type=\"checkbox\" disabled=\"disabled\" name=\"options[]\" value=\"".$item['id']."v4\">
										".$item['devicevalue4']."
								 </td>";
						}
						 echo " </tr>";	
					}	
			} 

		}
	   
	}

				if ($k == 0 )
				{
					echo "</tbody></table><h3 style=\"text-align:center;\"> No Devices found. </h3>";
					$k = 0;
				}
}


php?>

</tbody>
</table>
</div>
        <button class="btn btn-success" type="submit">OK</button>
        <button class="btn btn-danger" type="reset">Cancel</button>
</form>
</div>

<?
}
php?>

<!------------------------------------------------------------- Graphs ----------------------------------------------->
<?php

echo "<h3>Graphs - ".$sTime."</h3>";
echo "	<form Method=\"POST\"> <div id=\"radiograph\">";
$aTime = array("1h","2h","1d","2d","1w","2w","1m","1y");

foreach ($aTime AS $Time) 
{
	if ($Time == $sTime)
	{
		echo "<input type=\"radio\" id=\"".$Time."\" name=\"radio\" checked =\"checked\" onclick=\"document.location.href='".$monUrl2[2]."&updategraph=".$Time."'\" /><label for=\"".$Time."\">".$Time."</label>";
	} else
	{
		echo "<input type=\"radio\" id=\"".$Time."\" name=\"radio\" onclick=\"document.location.href='".$monUrl2[2]."&updategraph=".$Time."'\" /><label for=\"".$Time."\">".$Time."</label>";
	}
}


	echo 	"&nbsp;  
		<input type=\"text\" id=\"textbox\" name=\"textbox\" placeholder=\"".$sTime."\" style=\"height:40px;\" size =15 />
		&nbsp; 	
		<button type=\"submit\">OK</button>

	</div></form>";

echo 
"<form Action=".$monUrl2[2].">
 <input type=\"hidden\" name=\"envoi2\" value=\"no\">
			<table class=\"table table-hover\">
			    <thead>
				<tr>
				    <th>Select</th>
				    <th>Name</th>
				    <th>Value</th>
				    <th>Graph</th>
				</tr>
			    </thead>
			    <tbody>";

  $endreponse = $db->query('SELECT graphs FROM extra_tabs WHERE ID = '.$_GET['id']);

    while ($donnees = $endreponse->fetch())
    {
	$list_graphs = $donnees['graphs'];			
    }
     $endreponse->closeCursor();


$list_graphs = split('[;;]', $list_graphs);
$index =0;

foreach ($list_graphs AS $graph) 
{
	$list_graphs2 = split('[v]', $graph);

	foreach ($datadevices AS $device)
	{ 
		if ( $device['id']==$list_graphs2[0])
		{ 
			$request = xmlrpc_encode_request("rrdtool.updategraph",array($device['id'],$sTime));
			$response = do_xmlrpc($request);

			if ($list_graphs2[1]==1){			
				echo " 	<tr>

					<td>
					<input type=\"checkbox\" name=\"optionsSup[]\" value=\"".$device['id']."v1\">
					</td>
				
					<td >
								".$device['devicename']."
					</td> 
  
					<td >
								".$device['valuerrdname']."
					</td>";

				echo "	<td >
					<img src=\"http://".$_SERVER['HTTP_HOST']."/graphs/".$list_graphs2[0]."-".$device['valuerrdname']."-".$sTime.".png\"/>
					</td>
					</tr>";
			}
			if ($list_graphs2[1]==2){			
				echo " 	<tr>

					<td>
					<input type=\"checkbox\" name=\"optionsSup[]\" value=\"".$device['id']."v2\">
					</td>
					
					<td >
								".$device['devicename']."
					</td> 
  
					<td >
								".$device['value2rrdname']."
					</td>";

				echo "	<td >
					<img src=\"http://".$_SERVER['HTTP_HOST']."/graphs/".$list_graphs2[0]."-".$device['value2rrdname']."-".$sTime.".png\"/>
					</td>
					</tr>";
			}
			if ($list_graphs2[1]==3){			
				echo " 	<tr>

					<td>
					<input type=\"checkbox\" name=\"optionsSup[]\" value=\"".$device['id']."v3\">
					</td>
					
					<td >
								".$device['devicename']."
					</td> 
  
					<td >
								".$device['value3rrdname']."
					</td>";

				echo "	<td >
					<img src=\"http://".$_SERVER['HTTP_HOST']."/graphs/".$list_graphs2[0]."-".$device['value3rrdname']."-".$sTime.".png\"/>
					</td>
					</tr>";
			}
			if ($list_graphs2[1]==4){			
				echo " 	<tr>

					<td>
					<input type=\"checkbox\" name=\"optionsSup[]\" value=\"".$device['id']."v4\">
					</td>
					
					<td >
								".$device['devicename']."
					</td> 
  
					<td >
								".$device['value4rrdname']."
					</td>";

				echo "	<td >
					<img src=\"http://".$_SERVER['HTTP_HOST']."/graphs/".$list_graphs2[0]."-".$device['value4rrdname']."-".$sTime.".png\"/>
					</td>
					</tr>";
			}

		}
	}
}


?>

		</tbody>
		</table>  

        <button class="btn btn-danger" type="submit">Remove</button>
<?php

// Add
if ($_GET['envoi']=='yes') {
	$aOption = array();
	$aGraph = array();
	$aOption = split(";;",implode(';;',$_GET['options']));
	$aGraph = split (";;",$mygraphs);

	foreach ($aOption AS $sOption) {
	
		$index=0;
		foreach ($aGraph AS $sGraph)
		{
			if ($sOption == $sGraph) 
			{
				$index = 0;
			} else
			{
				$index++;
			}

		}

		if (count($aGraph)==$index)
		{
			if ($mygraphs == "")
			{
			$mygraphs = $sOption;
			} else 
			{
			$mygraphs = $mygraphs.";;".$sOption;
			}
		}
	}


	
	$req =  $db->prepare('UPDATE extra_tabs SET graphs = (:thegraphs) WHERE  extra_tabs.ID ='.$_GET['id']);
        $req->execute(array('thegraphs' => $mygraphs  ));

	$add = split('[?]',$_SERVER['HTTP_REFERER']); 
   	header("Location: index.php?".$add[1]);
}

// Remove
if ($_GET['envoi2']=='no')
{
	$aOption = array();
	$aGraph = array();
	$aOption = split(";;",implode(';;',$_GET['optionsSup']));
	$aGraph = split (";;",$mygraphs);


	foreach ($aOption AS $sOption) {
		echo "<br>".$sOption."<br>";

		$mygraphs = str_replace($sOption,"",$mygraphs);
		$mygraphs = str_replace(";;;;",";;",$mygraphs);
		echo $mygraphs."<br><br>";
	}

	echo " Send : ".$mygraphs."<br>";
	
	$req =  $db->prepare('UPDATE extra_tabs SET graphs = (:thegraphs) WHERE  extra_tabs.ID ='.$_GET['id']);
        $req->execute(array('thegraphs' => $mygraphs  ));

	$add = split('[?]',$_SERVER['HTTP_REFERER']); 
   	header("Location: index.php?".$add[1]);
}

?>	
