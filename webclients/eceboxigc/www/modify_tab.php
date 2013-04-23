<?php
    // Get tab to modify
    $id = $_COOKIE["tab"];
$monUrl = "http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
$monUrl2 = $_SERVER['REQUEST_URI'];
$monUrl2 = split ("/", $monUrl2);


    $reponse3 = $db->query('SELECT ID, tab_name, tab_icon, one, two, three, four, five FROM extra_tabs WHERE ID='.$id);
    while ($donnees2 = $reponse3->fetch())
    {
	$myID = $donnees2['ID'];
$myName = $donnees2['tab_name'];
$myIcon = $donnees2['tab_icon'];
$one =$donnees2['one'];
$two =$donnees2['two'];
$three= $donnees2['three'];
$four=$donnees2['four'];
$five=		$donnees2['five'];	
    }
    $reponse3->closeCursor();
 if( isset($_GET['one'])) { $one = $_GET['one'];}
 if( isset($_GET['two'])) {$two = $_GET['two'];}
 if( isset($_GET['three'])) {$three = $_GET['three'];}
 if( isset($_GET['four'])) {$four = $_GET['four'];}
 if( isset($_GET['five'])) {$five = $_GET['five'];}

    // Update values
    if(isset($_POST['libelle'])) 
    {
        if ($_POST['libelle'] != ""){
            $req = $db->prepare('UPDATE extra_tabs SET tab_name=:tab_name, tab_icon=:tab_icon WHERE ID='.$id);
            $req->execute(array(
                'tab_name' => $_POST['libelle'],
                'tab_icon' => $_POST['imgList']
            ));
            header("Location: index.php?page=modify_tab");
        }
        else if($_POST['libelle'] == ""){
            $warning = "<div class=\"alert alert-error\">Error when changing the tab: field was empty.</div>";
        }
    }

    // Update classes
    if( isset($_GET['envoi'])) 
    {
				$monclassement[] = $one;
				$monclassement[] = $two;
				$monclassement[] = $three;
				$monclassement[] = $four;
				$monclassement[] = $five;
				foreach($monclassement AS $pos)
				{
					foreach($monclassement AS $pos2)
					{
						if($pos == $pos2)
						{
							$itsok = $itsok +1;
						}
					}
				}
				if($itsok == 5)
				{
					     
						    $req = $db->prepare('UPDATE extra_tabs SET one=:one, two=:two, three=:three, four=:four, five=:five WHERE ID='.$id);
						    $req->execute(array(
							'one' => $one,
							'two' => $two,
							'three' => $three,
							'four' => $four,
							'five' => $five
						    ));
				} else {
            $warning2 = "<div class=\"alert alert-error\">Error ordering tab: you have chosen the same data several times.</div>";
				}

     }else if(isset($_GET['envoi'])){
            $warning2 = "<div class=\"alert alert-error\">Error ordering tab: please fill in all fields.</div>";
				}
 
?>
<script>

function loadPage(param) {
self.location.href=document.location+"&one="+param;
}

function loadPage2(param) {
self.location.href=document.location+"&two="+param;
}
function loadPage3(param) {
self.location.href=document.location+"&three="+param;
}
function loadPage4(param) {
self.location.href=document.location+"&four="+param;
}
function loadPage5(param) {
self.location.href=document.location+"&five="+param;
}
</script>

<h2>TAB MANAGEMENT</h2>
<h3>Modifying Tab <i><?php echo $myName; ?></i></h3>
<?= $warning ?>
<form Method="POST" Action="index.php?page=modify_tab">
    <table style="margin-left:3%;" border="0" cellspacing="0" cellpadding="2">
        <tbody>
            <tr> 
                <td nowrap="" width="27%" class="formulaireText">
                    Name :<br><i>max 15 characters</i>
                </td>
                <td style="padding-left:3%;" width="73%"><input type="text" value="<?php echo $myName; ?>" name="libelle" size="50"></td>
            </tr>
            <tr> 
                <td nowrap="" width="27%" class="formulaireText">
                    Image :
                </td>
                <td style="padding-left:3%;" width="73%">
                    <select id="imgListTabs" name="imgList">
                        <option value = "camera">Camera</option>
                        <option value = "captures">Captures</option>
                        <option value = "climate">Climate</option>
                        <option value = "control">Control</option>
                        <option value = "devices">Devices</option>
                        <option value = "email">Email</option>
                        <option value = "energy">Energy</option>
                        <option value = "events">Events</option>
                        <option value = "floorplan">Floorplan</option>
                        <option value = "graphs">Graphs</option>
                        <option value = "home">Home</option>
                        <option value = "hvac">Hvac</option>
                        <option value = "locations">Locations</option>
                        <option value = "logs">Logs</option>
                        <option value = "music">Music</option>
                        <option value = "network">Network</option>
                        <option value = "news">News</option>
                        <option value = "phone">Phone</option>
                        <option value = "security">Security</option>
                        <option value = "stock">Stock</option>
                        <option value = "system">System</option>
                        <option value = "thermostat">Thermostat</option>
                        <option value = "tvguide">TVGuide</option>
                        <option value = "weather">Weather</option>
                    </select>
                </td>
            </tr>
            <tr> 
                <td nowrap="" width="27%" class="formulaireText">
                    Preview : 
                </td>
                <td style="padding-left:3%;" width="73%">
                    <img id="imgPrev" src= "img/tabs/<?php echo $myIcon; ?>.png"/>
                </td>
            </tr>
        </tbody>
    </table>
    <br>
    <div class="buttonGroup2">
        <button class="btn btn-success" type="submit">OK</button>
        <button class="btn btn-danger" type="reset">Cancel</button>
    </div>
</form>

<h3>Order for Tab <i><?php echo $myName; ?></i></h3>
<?= $warning2 ?>
<form Method="POST" Action="index.php?page=modify_tab">
    <table style="margin-left:3%;" border="0" cellspacing="0" cellpadding="2">
        <tbody>
            <tr> <div>
                <td nowrap="" width="27%" class="formulaireText">
                    1 :
                </td>
                <td style="padding-left:3%;" width="73%">
                    <select id="placeone"  name="one" onchange="loadPage(this.value);">
<?
		echo "<option value = \" \" SELECTED> </option>";
		if($one == "event")
		{
                       echo "<option value = \"event\" SELECTED>Events</option>";
		} else echo "<option value = \"event\">Events</option>";
		if($one == "heating")
		{
                       echo "<option value = \"heating\" SELECTED>Heatings</option>";
		} else echo "<option value = \"heating\">Heatings</option>";
		if($one == "graph")
		{
                       echo "<option value = \"graph\" SELECTED>Graphs</option>";
		} else echo "<option value = \"graph\">Graphs</option>";
		if($one == "equipment")
		{
                       echo "<option value = \"equipment\" SELECTED>Devices</option>";
		} else echo "<option value = \"equipment\">Devices</option>";
		if($one == "weather")
		{
                       echo "<option value = \"weather\" SELECTED>Weather</option>";
		} else echo "<option value = \"weather\">Weather</option>";
php?>
                    </select>
                </td></div></tr><div>
                <td nowrap="" width="27%" class="formulaireText">
                    2 :
                </td>
                <td style="padding-left:3%;" width="73%">
                    <select id="placetwo"  name="two" onchange="loadPage2(this.value);">
<?
		echo "<option value = \" \" SELECTED> </option>";
		if($two == "event")
		{
                       echo "<option value = \"event\" SELECTED>Events</option>";
		} else echo "<option value = \"event\">Events</option>";
		if($two == "heating")
		{
                       echo "<option value = \"heating\" SELECTED>Heatings</option>";
		} else echo "<option value = \"heating\">Heatings</option>";
		if($two == "graph")
		{
                       echo "<option value = \"graph\" SELECTED>Graphs</option>";
		} else echo "<option value = \"graph\">Graphs</option>";
		if($two == "equipment")
		{
                       echo "<option value = \"equipment\" SELECTED>Devices</option>";
		} else echo "<option value = \"equipment\">Devices</option>";
		if($two == "weather")
		{
                       echo "<option value = \"weather\" SELECTED>Weather</option>";
		} else echo "<option value = \"weather\">Weather</option>";
php?>
                    </select>
                </td></div></tr><div>
                <td nowrap="" width="27%" class="formulaireText">
                    3 :
                </td>
                <td style="padding-left:3%;" width="73%">
                    <select id="placethree"  name="three" onchange="loadPage3(this.value);">
<?
		echo "<option value = \" \" SELECTED> </option>";
		if($three == "event")
		{
                       echo "<option value = \"event\" SELECTED>Events</option>";
		} else echo "<option value = \"event\">Events</option>";
		if($three == "heating")
		{
                       echo "<option value = \"heating\" SELECTED>Heatings</option>";
		} else echo "<option value = \"heating\">Heatings</option>";
		if($three == "graph")
		{
                       echo "<option value = \"graph\" SELECTED>Graphs</option>";
		} else echo "<option value = \"graph\">Graphs</option>";
		if($three == "equipment")
		{
                       echo "<option value = \"equipment\" SELECTED>Devices</option>";
		} else echo "<option value = \"equipment\">Devices</option>";
		if($three == "weather")
		{
                       echo "<option value = \"weather\" SELECTED>Weather</option>";
		} else echo "<option value = \"weather\">Weather</option>";
php?>
                    </select>
                </td></div></tr><div>
                <td nowrap="" width="27%" class="formulaireText">
                    4 :
                </td>
                <td style="padding-left:3%;" width="73%">
                    <select id="placefour"  name="four" onchange="loadPage4(this.value);">
<?
		echo "<option value = \" \" SELECTED> </option>";
		if($four == "event")
		{
                       echo "<option value = \"event\" SELECTED>Events</option>";
		} else echo "<option value = \"event\">Events</option>";
		if($four == "heating")
		{
                       echo "<option value = \"heating\" SELECTED>Heatings</option>";
		} else echo "<option value = \"heating\">Heatings</option>";
		if($four == "graph")
		{
                       echo "<option value = \"graph\" SELECTED>Graphs</option>";
		} else echo "<option value = \"graph\">Graphs</option>";
		if($four == "equipment")
		{
                       echo "<option value = \"equipment\" SELECTED>Devices</option>";
		} else echo "<option value = \"equipment\">Devices</option>";
		if($four == "weather")
		{
                       echo "<option value = \"weather\" SELECTED>Weather</option>";
		} else echo "<option value = \"weather\">Weather</option>";
php?>
                    </select>
                </td></div></tr><div>
                <td nowrap="" width="27%" class="formulaireText">
                    5 :
                </td>
                <td style="padding-left:3%;" width="73%">
                    <select id="placefive"  name="five" onchange="loadPage5(this.value);">
<?
		echo "<option value = \" \" SELECTED> </option>";
		if($five == "event")
		{
                       echo "<option value = \"event\" SELECTED>Events</option>";
		} else echo "<option value = \"event\">Events</option>";
		if($five == "heating")
		{
                       echo "<option value = \"heating\" SELECTED>Heatings</option>";
		} else echo "<option value = \"heating\">Heatings</option>";
		if($five == "graph")
		{
                       echo "<option value = \"graph\" SELECTED>Graphs</option>";
		} else echo "<option value = \"graph\">Graphs</option>";
		if($five == "equipment")
		{
                       echo "<option value = \"equipment\" SELECTED>Devices</option>";
		} else echo "<option value = \"equipment\">Devices</option>";
		if($five == "weather")
		{
                       echo "<option value = \"weather\" SELECTED>Weather</option>";
		} else echo "<option value = \"weather\">Weather</option>";
php?>
                    </select>
                </td></div>
	</tr>
        </tbody>
    </table>
    <br>
</form>
    <div class="buttonGroup2">
        <button class="btn btn-success" type="submit" onclick="document.location.href='<? echo $monUrl2[2]; ?>&envoi=Yes'">OK</button>
    </div>

