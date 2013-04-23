<?php
include "config.php";

$idTemp = "c";
if(isset($_POST['idOnEarth']))
{
	$idOnEarth = $_POST['idOnEarth']; 
}
else
{
	$idOnEarth = $weatherID;
}
$dom = DomDocument::load('http://weather.yahooapis.com/forecastrss?w='.$idOnEarth.'&u='.$idTemp);
$xpath = new DomXPath($dom);

// Get country
$datalocation = $xpath->query('//yweather:location');

foreach ($datalocation as $dl) {
  
	$ville = $dl->getAttribute('city');
	$pays = $dl->getAttribute('country');
}

// Get units
$dataunits = $xpath->query('//yweather:units');
foreach ($dataunits as $du) {
   
if ($du->getAttribute('pressure') == 'mb')
{
	$unitPression = 'hPa';

}else $unitPression = $du->getAttribute('pressure');

$unitTemp = $du->getAttribute('temperature');
$unitDistance = $du->getAttribute('distance');
$unitVitesse = $du->getAttribute('speed');

}

// Get wind info
$datawind = $xpath->query('//yweather:wind');
foreach ($datawind as $dw) {

	$vitesseVent = $dw->getAttribute('speed');
	$directionVent = $dw->getAttribute('direction');
}

// Get air info
$dataair = $xpath->query('//yweather:atmosphere');
foreach ($dataair as $da) {

	$humidite = $da->getAttribute('humidity');
	$visibilite = $da->getAttribute('visibility');
	$pression = $da->getAttribute('pressure');
	$rising = $da->getAttribute('rising');
}


// Get sun info
$datasun = $xpath->query('//yweather:astronomy');
foreach ($datasun as $ds) {

	$sunRise = $ds->getAttribute('sunrise');
	$sunSet = $ds->getAttribute('sunset');
}

// Get condition
$datacondition = $xpath->query('//yweather:condition');
foreach ($datacondition as $dc) {

	$prevision = $dc->getAttribute('text');
	$temperature = $dc->getAttribute('temp');
	$date = $dc->getAttribute('date');
	$code = $dc->getAttribute('code');
}

// Get high low values
$forecasts = $xpath->query('//yweather:forecast');
$index = 0;
foreach ($forecasts as $f) {

	$string = $f->getAttribute('low');
	$string1 = $f->getAttribute('high');

	$array[0][$index] = $string;
	$array[1][$index] = $string1;
	
	$index++;

}

// Get image from code
if ($code == 36 || $code == 32)	$imgMeteo = "sunny";
else if ($code == 34) $imgMeteo = "cloudy";
else if ($code == 29) $imgMeteo = "cloudy1night";
else if ($code == 30) $imgMeteo = "cloudy3";
else if ($code == 28 || $code == 44) $imgMeteo = "cloudy4";
else if ($code == 27) $imgMeteo = "cloudy4night";
else if ($code == 23 || $code == 24 || $code == 25) $imgMeteo = "cloudy5";
else if ($code == 20 || $code == 22) $imgMeteo = "fog";
else if ($code == 17) $imgMeteo = "hail";
else if ($code == 19 || $code == 21) $imgMeteo = "mist";
else if ($code == 26) $imgMeteo = "overcast";
else if ($code == 8 || $code == 9) $imgMeteo = "shower1";
else if ($code == 11) $imgMeteo = "shower2";
else if ($code == 12) $imgMeteo = "shower3";
else if ($code == 5 || $code == 6 || $code == 7 || $code == 10 || $code == 18 || $code == 35) $imgMeteo = "sleet";
else if ($code == 13) $imgMeteo = "snow1";
else if ($code == 15) $imgMeteo = "snow2";
else if ($code == 14) $imgMeteo = "snow3";
else if ($code == 16 || $code == 42) $imgMeteo = "snow4";
else if ($code == 41 || $code == 43) $imgMeteo = "snow5";
else if ($code == 31) $imgMeteo = "sunnynight";
else if ($code == 2) $imgMeteo = "storm1";
else if ($code == 4 || $code == 1 || $code == 37) $imgMeteo = "storm2";
else if ($code == 3 || $code == 0 || $code == 38 || $code == 39) $imgMeteo = "storm3";
else if ($code == 3200) $imgMeteo = "dunno";
	
?>

<h2>LOCAL WEATHER</h2>
<table style="margin-left:3%;" border="0" cellspacing="0" cellpadding="2">
    <tbody>
        <tr> 
            <td nowrap="" width="27%" class="formulaireText">
                Sunrise :
            </td>
            <td style="padding-left:3%;" width="73%">
		<?php echo $sunRise; ?>
	</td>
	<td nowrap="">
                <?php echo "Country : " . $pays . "  City : ".$ville; ?>
        </tr>
        <tr> 
            <td nowrap="" width="27%" class="formulaireText">
                Sunset :
            </td>
            <td style="padding-left:3%;" width="73%">
		<?php echo $sunSet; ?>
	</td>
        </tr>	
	<tr nowrap="" width="27%" class="formulaireText">
                <?php echo $date; ?>
            </tr>
	<tr >
		<form action="index.php?page=weather" method="post">
		<p align = "right">
    			<input type="text" name="idOnEarth" />
    			<input type="submit" value="Fetch" />
		</p>
	</tr>	
</form>
    </tbody>
</table>
<table style="margin-right:3%;" border="0" cellspacing="0" cellpadding="2">
    <tbody>
        <tr> 
            <td nowrap="" width="27%" class="formulaireText">
            </td>  
        </tr>
    </tbody>
</table>
<h3>Weather Forecast</h3>
<table style="margin-left:3%;" border="0" cellspacing="0" cellpadding="0">
    <tbody>
        <tr> 
            <td nowrap="">
                <h4>Today :</h4>
            </td>
            <td width="60%"></td>
            <td nowrap="">
                <h4>Tomorrow :</h4>
            </td>
            <td></td>
        </tr>
        <tr> 
            <td nowrap="">
                Low Temperature :
            </td>
            <td ><?php echo $array[0][0]; ?></td>
            <td nowrap="">
                Low Temperature :
            </td>
            <td><?php echo $array[0][1]; ?></td>
        </tr>
        <tr> 
            <td nowrap="">
                High Temperature :
            </td>
            <td><?php echo $array[1][0]; ?></td>
            <td nowrap="">
                High Temperature :
            </td>
            <td><?php echo $array[1][1]; ?></td>
        </tr>
    </tbody>
</table>
<div id="WeatherPWidgets">
    <div class="widget widgetShift">
        <h3 class="center">Temperature</h3>
	 <div class = "<? echo $imgMeteo; ?>" ></div>
	<p> Outdoor Temp :</p>
        <h1>
		<?php echo $temperature.' °'.$unitTemp;?>
	</h1>
	</div>
    <div class="widget widgetShift">
        <h3 class="center">Wind</h3>
        <div class="wind"></div>
        <p> Speed :</p>
        <h1>
		<?php echo $vitesseVent.' '.$unitVitesse;?></h1>
    </div>
    <br>
    <div class="widget widgetShift">
        <h3 class="center">Barometer</h3>
        <div class="barometer"></div>
        <p>  Pressure :</p>
        <h1>
		<?php echo $pression.' '.$unitPression;?>
	</h1>
    </div>
    <div class="widget widgetShift">
        <h3 class="center">Humidity</h3>
        <div class="hydrology"></div>
        <p>Outdoor Humidity :</p>
        <h1>
		<?php echo $humidite.'%';?>
	</h1>
    </div>
</div>
