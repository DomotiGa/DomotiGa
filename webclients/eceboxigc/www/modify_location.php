<?php
    // Get location to change
    $id = $_COOKIE["locat"];
 
    $reponse = $db->query('SELECT ID, locat_name, locat_icon FROM locat WHERE ID='.$id);
    $donnees = $reponse->fetch();
   
    // Update values
    if(isset($_POST['libelle'])) 
    {
        if ($_POST['libelle'] != ""){
            $req = $db->prepare('UPDATE locat SET locat_name=:locat_name, locat_icon=:locat_icon WHERE ID='.$id);
            $req->execute(array(
                'locat_name' => $_POST['libelle'],
                'locat_icon' => $_POST['imgList']
            ));
            /*$warning = "<div class=\"alert alert-success\"> Changed location successfully. </div>";*/
            header("Location: index.php?page=modify_location");
        }
        else if($_POST['libelle'] == ""){
            $warnin  = "<div class=\"alert alert-error\"> Error changing the tab: field was empty. </div>";
        }
    }
?>
<h2>GESTION DES TUILES</h2>
<h3>Modification de la tuile <i><?php echo $donnees['locat_name']; ?></i></h3>
<?= $warning ?>
<form Method="POST" Action="index.php?page=modify_location">
    <table style="margin-left:3%;" border="0" cellspacing="0" cellpadding="2">
        <tbody>
            <tr> 
                <td nowrap="" width="27%" class="formulaireText">
                    Nom de la tuile :<br><i>limité à 15 caractères</i>
                </td>
                <td style="padding-left:3%;" width="73%"><input type="text" value="<?php echo $donnees['locat_name']; ?>" name="libelle" size="50"></td>
            </tr>
            <tr> 
                <td nowrap="" width="27%" class="formulaireText">
                    Image :
                </td>
                <td style="padding-left:3%;" width="73%">
                    <select id="imgListLocation" name="imgList">
                        <option <?php if($donnees['locat_icon'] == "sun" ) echo "selected" ?> value = "sun">Soleil</option>
                        <option <?php if($donnees['locat_icon'] == "wind" ) echo "selected" ?> value = "wind">Vent</option>
                        <option <?php if($donnees['locat_icon'] == "barometer" ) echo "selected" ?> value = "barometer">Baromètre</option>
                        <option <?php if($donnees['locat_icon'] == "hydrology" ) echo "selected" ?> value = "hydrology">Hydrologie</option>
                    </select>
                </td>
            </tr>
            <tr> 
                <td nowrap="" width="27%" class="formulaireText">
                    Prévisualisation : 
                </td>
                <td style="padding-left:3%;" width="73%">
                    <img id="imgPrev" src= "img/tiles/<?php echo $donnees['locat_icon']; ?>.png"/>
                </td>
            </tr>
        </tbody>
    </table>
    <br>
    <div style="height: 35px;">
        <button type="button" id="buttonEquipment" style="margin-left:3%;float: left;" class="btn btn-info">Equipements...</button>
        <div id="popEquipment" class="hidePop">Selectionner les équipements à lui associer</div>
    </div>
    <div class="buttonGroup2">
        <button class="btn btn-success" type="submit" >OK</button>
        <button class="btn btn-danger" type="reset" >Cancel</button>
    </div>
</form>
