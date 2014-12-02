<?php

class Administrator extends CI_Model {

	function login($id, $password) {
		$sql = '';
		$sql .= 'SELECT * ';
		$sql .= 'FROM `administrator` ';
		$sql .= "WHERE `id` = ? AND `password` = MD5( ? ); ";
		
		$query = $this->db->query($sql, array( $id, $password ));
		
		if ($query->num_rows() == 1) {
			return $query->result();
		} else {
			return false;
		}
	}

}
?>