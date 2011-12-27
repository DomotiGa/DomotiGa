<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/**
 * CodeIgniter
 *
 * An open source application development framework for PHP 4.3.2 or newer
 *
 * @package		CodeIgniter
 * @author		ExpressionEngine Dev Team
 * @copyright	        Copyright (c) 2008 - 2009, EllisLab, Inc.
 * @license		http://codeigniter.com/user_guide/license.html
 * @link		http://codeigniter.com
 * @since		Version 1.0
 * @filesource
 */

// ------------------------------------------------------------------------

/**
 * Domotiga request handler class
 *
 * @package		CodeIgniter
 * @subpackage	        Libraries
 * @category	        Domotiga
 * @author		Wouter Wolkers
 * @link		http://www.domotiga.nl/
 */
class CI_Domotiga {
    
    var $debugtab			= FALSE; 	// Debugging on or off
    
    var $client;
    var $method;
    var $data;
    var $message			= '';
    var $error				= '';  		// Error string for request
    var $result;
    var $response			= array();  // Response from remote server
    var $rpc_connect;
    var $sortkey                        = "devicename";
    var $debug                          = TRUE;
    var $CI;
    var $defaultrefresh                 = 5000;
    
    
    
    //-------------------------------------
    //  VALUES THAT MULTIPLE CLASSES NEED
    //-------------------------------------
    
    function CI_Domotiga ()
    {
	$this->CI =& get_instance();
	$this->CI->load->library(array('xmlrpc', 'session'));
//	$this->CI->xmlrpc->set_debug(TRUE);
//	$this->CI->output->enable_profiler(TRUE);
	
	$this->CI->xmlrpc->server('http://localhost/', 9009);
	
	 // Sorting
	 // cannot use isset here, need to check against NULL
	 // see http://forums.devshed.com/php-development-5/can-t-use-method-return-value-in-write-context-291882.html
	if ($this->CI->session->userdata('sortkey') !== NULL)
	    $this->CI->session->set_userdata('sortkey', "devicename");
	if (isset($_REQUEST['setsortkey']))
	  $this->CI->session->set_userdata('sortkey', $_REQUEST['setsortkey']);
	if ($this->CI->session->userdata('sortord') !== NULL)
	  $this->CI->session->set_userdata('sortord', 'asc');
	if (isset($_REQUEST['setsortord'])) 
	  $this->CI->session->set_userdata('sortord', $_REQUEST['setsortord']);
	
	// Session variables for current view
	if (!isset($_SESSION['view'])) $_SESSION['view']="main";
	if (isset($_REQUEST['setview'])) $_SESSION['view']=$_REQUEST['setview'];
	if (isset($_REQUEST['reload'])) unset($_SESSION['lastget']);
	if (!isset($_SESSION['refresh'])) $_SESSION['refresh']=5000;
	if (!isset($_REQUEST['debug'])) $this->debug=0;
    }
    
    
    //-------------------------------------
    //  Initialize Prefs
    //-------------------------------------
    
    //	function initialize($config = array())
    //	{
    //	}
    // END
    function do_xmlrpc($request) {
	$this->CI->xmlrpc->method($request);

	if ( ! $this->CI->xmlrpc->send_request())
	{
	    echo $this->CI->xmlrpc->display_error() . "\n";
	    echo $request . "\n";
	    die ("<h2>Cannot connect to the DomotiGa server!</h2>");
	}
	return $this->CI->xmlrpc->display_response();
    }
    
    // Get device list
    function get_device_list($view) {
	$response = $this->do_xmlrpc("device.list");
	
	if (xmlrpc_is_fault($response)) {
	    trigger_error("xmlrpc: $response[faultString] ($response[faultCode])");
	} else {
	    $index=0;
	    foreach($response AS $item) {
		list( $retarr[$index]['id'], $retarr[$index]['deviceicon'], $retarr[$index]['devicename'], $retarr[$index]['devicelocation'], $retarr[$index]['devicevalue'], $retarr[$index]['devicelabel'], $retarr[$index]['devicevalue2'], $retarr[$index]['devicelabel2'], $retarr[$index]['devicevalue3'], $retarr[$index]['devicelabel3'], $retarr[$index]['devicevalue4'], $retarr[$index]['devicelabel4'], $retarr[$index]['devicelastseen']) = explode (';;', $item);
		if ($retarr[$index]['deviceicon']) { $retarr[$index]['deviceicon'] = "<img src='images/icons/".$retarr[$index]['deviceicon']."' height='16' width='16' alt='icon' />"; } else { $retarr[$index]['deviceicon'] = ""; }
		if (strlen($retarr[$index]['devicevalue']) && $retarr[$index]['devicelabel']) { $retarr[$index]['devicevalue'] = $retarr[$index]['devicevalue']. " ".$retarr[$index]['devicelabel']; }
		if (strlen($retarr[$index]['devicevalue2']) && $retarr[$index]['devicelabel2']) { $retarr[$index]['devicevalue2'] = $retarr[$index]['devicevalue2']. " ".$retarr[$index]['devicelabel2']; }
		if (strlen($retarr[$index]['devicevalue3']) && $retarr[$index]['devicelabel3']) { $retarr[$index]['devicevalue3'] = $retarr[$index]['devicevalue3']. " ".$retarr[$index]['devicelabel3']; }
		if (strlen($retarr[$index]['devicevalue4']) && $retarr[$index]['devicelabel4']) { $retarr[$index]['devicevalue4'] = $retarr[$index]['devicevalue4']. " ".$retarr[$index]['devicelabel4']; }
		$index++;
	    }
	    // Sort the list
	    if (is_array($retarr)) {
		   if (strtolower($this->CI->session->userdata('sortord')=="asc")) {
//		       $sortkey=$_SESSION['sortkey'];
		       usort($retarr,array("CI_Domotiga", "sort_matches_asc"));
		   } else {
//		       $sortkey=$_SESSION['sortkey'];
		       usort($retarr,array("CI_Domotiga", "sort_matches_desc"));
		   }
	    }
	    
	    if (isset($retarr)) {
		return $retarr;
	    } else {
		return FALSE;
	    }
	}
    }
    
    // Get status
    function get_status() {
	// modes
	$retarr['house_mode'] = $this->do_xmlrpc("mode.get_housemode");
	$retarr['mute_mode'] = $this->do_xmlrpc("mode.get_mutemode");
	if ($retarr['mute_mode']) { $retarr['mute_mode'] ="<img src='images/icons/mute.png' height='16' width='16' alt='icon' />"; }
	else { $retarr['mute_mode'] ="<img src='images/icons/sound.png' height='16' width='16' alt='icon' />"; }
	
	// domotiga version
	$retarr['program_version'] = $this->do_xmlrpc("system.program_version");

	// sun moon data
	$response = $this->do_xmlrpc("data.sunmoon");
	$retarr['data_sunset'] = $response[1];
	$retarr['data_sunrise'] = $response[0];
	
	// new messages
	$response = $this->do_xmlrpc("data.newmessages");
	$retarr['data_newmails'] = $response[0];
	$retarr['data_newcalls'] = $response[1];
	$retarr['data_newvoicemails'] = $response[2];
	
	return $retarr;
    }
    
    // Get version
    function get_version() {
	return $this->do_xmlrpc("system.program_version");
    }


    // Function to sort second key in array (ascending)
    function sort_matches_asc($left,$right) {
	if(strtolower($left["$this->sortkey"])==strtolower($right["$this->sortkey"])) return 0;
	return strtolower($left["$this->sortkey"]) < strtolower($right["$this->sortkey"]) ? -1 : 1 ;
    }
    
    // Function to sort second key in array (descending)
    function sort_matches_desc($left,$right) {
	if(strtolower($left["$this->sortkey"])==strtolower($right["$this->sortkey"])) return 0;
	return strtolower($left["$this->sortkey"]) > strtolower($right["$this->sortkey"]) ? -1 : 1 ;
    }
    
    // Get graphs
    function get_graph() {
	// modes
	$retarr['house_mode'] = $this->do_xmlrpc("mode.get_housemode");
	$retarr['mute_mode'] = $this->do_xmlrpc("mode.get_mutemode");
	if ($retarr['mute_mode']) { $retarr['mute_mode'] ="<img src='images/icons/mute.png' height='16' width='16' alt='icon' />"; }
	else { $retarr['mute_mode'] ="<img src='images/icons/sound.png' height='16' width='16' alt='icon' />"; }
	
	// domotiga version
	$retarr['program_version'] = $this->do_xmlrpc("system.program_version");
	
	// sun moon data
	$response = $this->do_xmlrpc("data.sunmoon");
	$retarr['data_sunset'] = $response[1];
	$retarr['data_sunrise'] = $response[0];
	
	// new messages
	$response = $this->do_xmlrpc("data.newmessages");
	$retarr['data_newmails'] = $response[0];
	$retarr['data_newcalls'] = $response[1];
	$retarr['data_newvoicemails'] = $response[2];
	
	return $retarr;
    }
    
} // END Domotiga Class

?>
