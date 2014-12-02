<?php
session_start();
if (! defined('BASEPATH'))
	exit('No direct script access allowed');

class Room extends CI_Controller {

	function __construct() {
		parent::__construct();
	}

	function add($floor) {
		if (isset($this->session->userdata['logged_in'])) {
			$this->load->helper(array(
					'form'));
			$this->data['floor'] = $floor;
			$this->load->view('room/add_view');
		} else {
			redirect('index.php/login', 'refresh');
		}
	}

}

?>