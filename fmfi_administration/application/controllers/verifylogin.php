<?php
if (! defined('BASEPATH'))
	exit('No direct script access allowed');

class VerifyLogin extends CI_Controller {

	function __construct() {
		parent::__construct();
		$this->load->model('administrator', '', TRUE);
	}

	function index() {
		// This method will have the credentials validation
		$this->load->library('form_validation');
		
		$this->form_validation->set_rules('id', 'id', 'trim|required|xss_clean');
		$this->form_validation->set_rules('password', 'password', 'trim|required|xss_clean|callback_check_database');
		
		if ($this->form_validation->run() == FALSE) {
			// Field validation failed. User redirected to login page
			$this->load->view('login_view');
		} else {
			// Go to private area
			redirect('index.php/roomlist/index/', 'refresh');
		}
	}

	function check_database($password) {
		// Field validation succeeded. Validate against database
		$id = $this->input->post('id');
		
		// query the database
		$result = $this->administrator->login($id, $password);
		
		if ($result) {
			$sess_array = array();
			foreach ( $result as $row ) {
				$sess_array = array(
						'id' => $row->id);
				$this->session->set_userdata('logged_in', $sess_array);
			}
			return true;
		} else {
			$this->form_validation->set_message('check_database', 'Nesprávne meno alebo heslo.');
			return false;
		}
	}

}
?>