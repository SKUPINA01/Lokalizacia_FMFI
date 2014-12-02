<?php
session_start();
if (! defined('BASEPATH'))
	exit('No direct script access allowed');

class Room extends CI_Controller {

	function __construct() {
		parent::__construct();
	}

	function add($floor) {
		$this->load->helper(array(
				'form'));
		$this->data['floor'] = $floor;
		$this->load->view('room/add_view');
	}
	
	function logout() {
		$this->session->unset_userdata('logged_in');
		session_destroy();
		redirect('index.php/login', 'refresh');
	}

}

?>