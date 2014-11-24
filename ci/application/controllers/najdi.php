<?php

if ( ! defined('BASEPATH')) exit('access allowed');

class Najdi extends CI_Controller {
	
	function miestnost($miestnost) {
		//helper('url') handluje base_url() vo view
		$this->load->helper('url');
		$this->load->model('Mapa');
		
		$data['title'] = 'Vyhľadávanie miestnosti '.$miestnost;
		$data['miestnost'] = $miestnost;
		
		$data['uzly'] = $this->Mapa->najdi_miestnost($miestnost);
		
		$this->load->view('najdi_miestnost',$data);
	}
}
?>