<?php 
    $reponse = $db->query('SELECT ID, tab_name FROM extra_tabs');
    
    if(isset($_POST['deletableTabList'])) 
    {
        $db->query('DELETE FROM extra_tabs WHERE ID='.$_POST['deletableTabList']);
        header("Location: index.php?page=remove_tab");
    }
?>
<h2>TAB MANAGEMENT</h2>
<h3>Remove Tab</h3>
<form Method="POST" Action="index.php?page=remove_tab">
<table style="margin-left:3%;" border="0" cellspacing="0" cellpadding="2">
    <tbody>
        <tr> 
            <td nowrap="" width="27%" class="formulaireText">
                Select tab to remove :
            </td>
            <td style="padding-left:3%;" width="73%">
                <select name="deletableTabList">
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
<div class="buttonGroup2">
    <button type="submit" class="btn btn-success">OK</button>
    <button type="reset" class="btn btn-danger">Cancel</button>
</div>
</form>
