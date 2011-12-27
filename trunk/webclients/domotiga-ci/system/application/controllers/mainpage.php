<?php

class Mainpage extends Controller {

	function Mainpage()
	{
		parent::Controller();	
	}
	
	function index()
	{
	    $this->load->helper('url');
	    $this->load->library('domotiga');
	    $data = array();
	    $data['data'] = $this->domotiga->get_device_list("main");
	    $data['debug'] = $this->domotiga->debug;
	    $data['debugtab'] = $this->domotiga->debugtab;
	    $data['status'] = $this->domotiga->get_status();
	    $data['sortord'] = $this->session->userdata('sortord');
	    $data['sortkey'] = $this->session->userdata('sortkey');

	    $this->load->view('mainpage', $data);
	}
}

/* End of file mainpage.php */
/* Location: ./system/application/controllers/mainpage.php */