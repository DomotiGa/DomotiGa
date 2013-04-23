<?php
    $count = current($db->query("SELECT ID FROM extra_tabs")->fetch());
    if($count != 0){
        $reponse = $db->query('SELECT tab_name, tab_icon, ID FROM extra_tabs');
    }
?>
<aside id="sidebar"> 
    <div id="menu">
         <ul id="menuUL" class="iconlist">
            <?php
                if($count != 0){
                    while ($donnees = $reponse->fetch())
                    {
            ?>
<li class="<?php echo $donnees['tab_icon']; ?>" onclick="document.location.href='index.php?page=tabs&name=<? echo $donnees['tab_name']; ?>&id=<? echo $donnees['ID']; ?>'"><h3><?php echo $donnees['tab_name']; ?></h3></li>
            <?php
                    }
                    $reponse->closeCursor();
                }
            ?>
        </ul>
    </div>
    <div class="buttonGroup">
        <button style="display: inline-block;" class="btn btn-info" onclick="document.location.href='index.php?page=add_tab'">+</button>
    <?php if($count == 0){?>
                <button style="display: inline-block;" class="btn btn-info" onclick="document.location.href='index.php?page=home&init=ok'">INIT</button>
   <?php }?>
        <?php if($count != 0){ ?>
        <button style="display: inline-block;" class="btn btn-info" onclick="document.location.href='index.php?page=remove_tab'">-</button>
        <?php } ?>
    </div>
</aside>
