<?php

class Uri_test extends Controller {

	function Uri_test()
	{
		parent::Controller();	
	}
	
	function index()
	{
	    $default = array('name', 'gender', 'location', 'type', 'sort');
	    
	    $array = $this->uri->uri_to_assoc(3, $default);
	    
	    echo $array['name'];
	    print_r($array);
	}
}

/* End of file mainpage.php */
/* Location: ./system/application/controllers/mainpage.php */