<?php
    $count = current($db->query("SELECT ID FROM extra_tabs")->fetch());
    $reponse = $db->query('SELECT ID, tab_name FROM extra_tabs');
    
    if(isset($_POST['libelle'])) 
    {		
	// Add the new tab to the DB
            if ($_POST['libelle'] != ""){
		$one = "weather";
		$two = "event";
		$three = "heating";
		$four = "equipment";
		$five = "graph";

                $req = $db->prepare('INSERT INTO extra_tabs(tab_name, tab_icon, one, two, three, four, five) VALUES(:tab_name, :tab_icon, :one, :two, :three, :four, :five)');
                $req->execute(array(
                    'tab_name' => $_POST['libelle'],
                    'tab_icon' => $_POST['imgList'], 
		    'one' => $one, 
		    'two' => $two, 
		    'three' => $three, 
	            'four' => $four, 
		    'five' => $five
                ));
		

		// Go to new tab
		$reponse2 = $db->query('SELECT ID FROM extra_tabs WHERE tab_name ='.$_POST['libelle']);

		    while ($donnees = $reponse->fetch())
		    {
			$myID = $donnees['ID'];			
		    }
		     $reponse->closeCursor();
			$myID = $myID+1;
              

		header("Location: index.php?page=tabs&name=".$_POST['libelle']."&id=".$myID);
            }
            else if($_POST['libelle'] == ""){
		// Error Message
                $warning = "<div class=\"alert alert-error\">Error adding tab: name is empty.</div>";
            }
    }
?>
<h2>TAB MANAGEMENT</h2>
<h3>Add</h3>
<?= $warning ?>
<form Method="POST" Action="index.php?page=add_tab">
    <table style="margin-left:3%;" border="0" cellspacing="0" cellpadding="2">
        <tbody>
            <tr> 
                <td nowrap="" width="27%" class="formulaireText">
                    Name :<br><i>max 15 characters</i>
                </td>
                <td style="padding-left:3%;" width="73%"><input type="text" value="" name="libelle" size="50"></td>
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
                    <img id="imgPrev" src= "img/tabs/camera.png"/>
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

<?php 
    if($count != 0){
?>
<br><br><br><br>
<hr>
<h3>Change</h3>
<form Method="POST" Action="index.php?page=modify_tab">
    <table style="margin-left:3%;" border="0" cellspacing="0" cellpadding="2">
        <tbody>
            <tr> 
                <td nowrap="" width="27%" class="formulaireText">
                    Select tab to change :
                </td>
                <td style="padding-left:3%;" width="73%">
                    <select id="tabsList" name="tabsList">
                        <option selected></option>
                        <?php
                            while ($donnees = $reponse->fetch())
                            {
                        ?>
                        <option value = "<?php echo $donnees['ID']; ?>"><?php echo $donnees['tab_name']; ?></option>
                        <?php
                            }
                            $reponse->closeCursor();
                        ?>
                    </select>
                </td>
            </tr>
        </tbody>
    </table>
    <div id="hiddenbuttonT" class="buttonGroup2" style="display:none;">
        <button class="btn btn-success" type="submit" >OK</button>
        <button class="btn btn-danger" type="reset">Cancel</button>
    </div>
</form>
<?php
    }
?>
