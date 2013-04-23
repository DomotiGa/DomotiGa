<?php 
    $reponse = $db->query('SELECT ID, tile_name FROM tiles');
    
    if(isset($_POST['deletableTilesList'])) 
    {
        $db->query('DELETE FROM tiles WHERE ID='.$_POST['deletableTilesList']);
        header("Location: index.php?page=remove_widget");
    }
?>
<h2>WIDGET MANAGEMENT</h2>
<h3>Remove Widget</h3>
<form Method="POST" Action="index.php?page=remove_widget">
<table style="margin-left:3%;" border="0" cellspacing="0" cellpadding="2">
    <tbody>
        <tr> 
            <td nowrap="" width="27%" class="formulaireText">
                Select widget to remove :
            </td>
            <td style="padding-left:3%;" width="73%">
                <select name = "deletableTilesList">
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
<div class="buttonGroup2">
    <button type="submit" class="btn btn-success">OK</button>
    <button type="reset" class="btn btn-danger">Cancel</button>
</div>
</form>
