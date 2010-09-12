<?php

class Xml extends Controller {
    
    function index()
    {
	$this->load->library('xmlrpc');
	
	$this->xmlrpc->server('http://localhost/', 9009);
	$this->xmlrpc->method('rrdtool.listgraphs');
	
	$request = array('server');
	$this->xmlrpc->request($request);

	if ( ! $this->xmlrpc->send_request())
	{
	    echo $this->xmlrpc->display_error();
	}
	else
	{
	    echo '<pre>';
	    print_r($this->xmlrpc->display_response());
	    echo '</pre>';
	}
    }
}
?>
