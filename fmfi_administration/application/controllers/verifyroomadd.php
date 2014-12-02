<?php
if (! defined('BASEPATH'))
	exit('No direct script access allowed');
session_start();

class VerifyRoomAdd extends CI_Controller {

	function __construct() {
		parent::__construct();
		$this->load->model('room', '', TRUE);
	}

	function floor($floor_id) {
		// This method will have the credentials validation
		$this->load->library('form_validation');
		$this->floor_id = $floor_id;
		
		$this->form_validation->set_rules('type', 'type', 'trim|required|xss_clean');
		$this->form_validation->set_rules('shape_coords', 'shape_coords', 'trim|required|xss_clean');
		$this->form_validation->set_rules('embedded_data', 'embedded_data', 'trim|required|xss_clean');
		$this->form_validation->set_rules('id', 'id', 'trim|required|xss_clean|callback_check_database');
		
		if ($this->form_validation->run() == FALSE) {
			// Field validation failed. User redirected to login page
			$this->load->view('room/add_view');
		} else {
			// Go to private area
			redirect('index.php/roomlist/', 'refresh');
		}
	}

	function check_database($room_id) {
		// Field validation succeeded. Validate against database
		$floor_id = $this->floor_id;
		$type = $this->input->post('type');
		$shape_coords = $this->input->post('shape_coords');
		$embedded_data = $this->input->post('embedded_data');
		// query the database
		$result = $this->room->add($floor_id, $room_id, $type, $shape_coords, $embedded_data);
		
		if ($result) {
			return true;
		} else {
			$this->form_validation->set_message('check_database', 'Zadali nekorektné údaje.');
			return false;
		}
	}

}
?>