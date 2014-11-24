<?php

class Mapa extends CI_Model {

	function __construct() {
		parent::__construct();
	}
	
	
	function najdi_miestnost($miestnost) {
		
		$sql = '';
		$sql .= 'SELECT podlazie ';
		$sql .= 'FROM na_podlazi ';
		$sql .= 'WHERE uzol = ? ';
		
		$query = $this->db->query($sql, array($miestnost));
		if ($query->num_rows() < 1) {
			return null;
		}
		foreach ($query->result() as $row) {
			$podlazie = $row->podlazie;
			break;
		}
		
		$sql = '';
		$sql .= 'SELECT * ';
		$sql .= 'FROM uzol ';
		$sql .= 'WHERE id IN ( ';
		$sql .= '    SELECT uzol ';
		$sql .= '    FROM na_podlazi ';
		$sql .= '    WHERE podlazie = ? ) ';
		
		return $this->db->query($sql, array($podlazie))->result();
	}
	
}

?>