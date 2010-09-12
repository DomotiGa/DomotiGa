<?php

class Settings extends Controller {
    
    function Settings()
    {
	parent::Controller();
	
	$this->load->library('domotiga');
	
	if (!isset($_SESSION['refresh'])) $_SESSION['refresh']=$this->domotiga->defaultrefresh;
	if (isset($_REQUEST['setrefresh'])) $_SESSION['refresh']=$_SESSION['setrefresh'];
    }
    
    function index()
    {
	if (isset($submit)) {
	    echo "<script>window.top.location='index.php?reload=1';</script>";
	    die();
	}
	
	$this->load->view('settings');
    }
}
