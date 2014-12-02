<?php
if (! defined('BASEPATH'))
	exit('No direct script access allowed');
session_start();
// we need to call PHP's session object to access it through CI
class RoomList extends CI_Controller {

	function __construct() {
		parent::__construct();
		$this->load->helper('url');
		$this->load->model('building', '', TRUE);
	}

	function index() {
		if (isset($this->session->userdata['logged_in'])) {
			$this->load->view('roomlist/roomlist_view');
		} else {
			redirect('index.php/login', 'refresh');
		}
	}

}

?>