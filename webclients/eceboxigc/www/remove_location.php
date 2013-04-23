<?php 
    $reponse = $db->query('SELECT ID, locat_name FROM locat');
    
    if(isset($_POST['deletelocat'])) 
    {
        $db->query('DELETE FROM locat WHERE ID='.$_POST['deletelocat']);
        header("Location: index.php?page=remove_location");
    }
?>
<h2>LOCATION MANAGEMENT</h2>
<h3>Remove</h3>
<form Method="POST" Action="index.php?page=remove_location">
<table style="margin-left:3%;" border="0" cellspacing="0" cellpadding="2">
    <tbody>
        <tr> 
            <td nowrap="" width="27%" class="formulaireText">
                Select location to remove :
            </td>
            <td style="padding-left:3%;" width="73%">
                <select name = "deletelocat">
                    <?php
                        while ($donnees = $reponse->fetch())
                        {
                    ?>
                    <option value = "<?php echo $donnees['ID']; ?>"><?php echo $donnees['locat_name']; ?></option>
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
