<?php 
    $count = current($db->query("SELECT ID FROM tiles")->fetch());
    $reponse = $db->query('SELECT ID, tile_name FROM tiles');

    if(isset($_POST['libelle'])) 
    {
            if ($_POST['libelle'] != ""){
                $req = $db->prepare('INSERT INTO tiles(tile_name, tile_icon) VALUES(:tile_name, :tile_icon)');
                $req->execute(array(
                    'tile_name' => $_POST['libelle'],
                    'tile_icon' => $_POST['imgList']
                ));
                header("Location: index.php?page=add_widget");
            }
            else if($_POST['libelle'] == ""){
                $warning = "<div class=\"alert alert-error\">Error adding widget: field is empty.</div>";
            }
    }
?>
<h2>WIDGET MANAGEMENT</h2>
<h3>Add</h3>
<?= $warning ?>
<form Method="POST" Action="index.php?page=add_widget">
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
                    <select id="imgListTiles" name="imgList">
                        <option value = "sun">Sun</option>
                        <option value = "wind">Wind</option>
                        <option value = "barometer">Barometer</option>
                        <option value = "hydrology">Humidity</option>
                        <option value = "empty">Other</option>
                    </select>
                </td>
            </tr>
            <tr> 
                <td nowrap="" width="27%" class="formulaireText">
                    Preview : 
                </td>
                <td style="padding-left:3%;" width="73%">
                    <img id="imgPrev" src= "img/tiles/sun.png"/>
                </td>
            </tr>
        </tbody>
    </table>
    <br>

    <div class="buttonGroup2">
        <button class="btn btn-success" type="submit" >OK</button>
        <button class="btn btn-danger" type="reset" >Cancel</button>
    </div>
</form>
<?php 
    if($count != 0){
?>
<br><br><br><br>
<hr>
<h3>Change</h3>
<form Method="POST" Action="index.php?page=modify_widget">
    <table style="margin-left:3%;" border="0" cellspacing="0" cellpadding="2">
        <tbody>
            <tr> 
                <td nowrap="" width="27%" class="formulaireText">
                    Select widget to change :
                </td>
                <td style="padding-left:3%;" width="73%">
                    <select id="tilesList" name="tilesList">
                        <option selected></option>
                        <?php
                            while ($donnees = $reponse->fetch())
                            {
                        ?>
                        <option value = "<?php echo $donnees['ID']; ?>"><?php echo $donnees['tile_name']; ?></option>
                        <?php
                            }
                            $reponse->closeCursor();
                        ?>
                    </select>
                </td>
            </tr>
        </tbody>
    </table>
    <div id="hiddenbuttonW" class="buttonGroup2" style="display:none;">
        <button class="btn btn-success" type="submit">OK</button>
        <button class="btn btn-danger" type="reset">Cancel</button>
    </div>
</form>
<?php
    }
?>
