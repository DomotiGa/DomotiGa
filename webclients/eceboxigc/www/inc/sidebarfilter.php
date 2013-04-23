<?
// Get list of devices
$datadevices=get_device_list($_SESSION['view']);
php?>

<aside id="sidebar"> 
    <div id="menu2">
        <ul class="iconlist">
            <li class="arrow"><h3>GROUP</h3></li>
        </ul>
        <div class="submenu">
<?
// Parse groups
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

// End parsing array

// Filter duplicates
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
	echo "  <a onclick=document.location.href=\"index.php?page=filters&kind=group&choice=".$value4."\" target=\"principale\"><h4>".$value3."</h4></a>
                <hr align=\"left\" width=\"100%\"/>";
	}
}
php?>
                
        </div>
        <ul class="iconlist">
            <li class="arrow"><h3>LOCATION</h3></li>
        </ul>
        <div class="submenu">
<?

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
	echo "  <a onclick=document.location.href=\"index.php?page=filters&kind=location&choice=".$value4."\" target=\"principale\"><h4>".$value3."</h4></a>
                <hr align=\"left\" width=\"100%\"/>";
	}
}
php?>
        </div>
        <ul class="iconlist">
            <li class="arrow"><h3>FLOOR</h3></li>
        </ul>
         <div class="submenu">
<?

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
	echo "  <a onclick=document.location.href=\"index.php?page=filters&kind=floor&choice=".$value4."\" target=\"principale\"><h4>".$value3."</h4></a>
                <hr align=\"left\" width=\"100%\"/>";
	}
}
php?>
        </div>
        <ul class="iconlist">
            <li class="arrow"><h3>TYPE</h3></li>
        </ul>
        <div class="submenu">
                <a onclick=document.location.href="index.php?page=filters&kind=type&choice=switches" target="principale"><h4>Switches</h4></a>
                <hr align="left" width="100%"/>
                <a onclick=document.location.href="index.php?page=filters&kind=type&choice=dimmers" target="principale"><h4>Dimmers</h4></a>            			<hr align="left" width="100%"/>
                <a onclick=document.location.href="index.php?page=filters&kind=type&choice=sensors" target="principale"><h4>Sensors</h4></a>
        </div>
    </div>
</aside>
