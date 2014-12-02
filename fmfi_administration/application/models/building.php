<?php

class Building extends CI_Model {

	function __construct() {
		parent::__construct();
	}

	function getAll() {
		$sql = '';
		$sql .= 'SELECT * ';
		$sql .= 'FROM `building`; ';
		
		$query = $this->db->query($sql);
		if ($query->num_rows() > 0) {
			return $query->result();
		} else {
			return false;
		}
	}

	function getFloors($building_id) {
		$sql = '';
		$sql .= 'SELECT * ';
		$sql .= 'FROM `floor` ';
		$sql .= 'WHERE `id` IN ( ';
		$sql .= '    SELECT `floor_id` ';
		$sql .= '    FROM `floor_location` ';
		$sql .= '    WHERE `building_id` = ? ); ';
		
		$query = $this->db->query($sql, array(
				$building_id));
		if ($query->num_rows() > 0) {
			return $query->result();
		} else {
			return false;
		}
	}
	
	function getRooms($floor_id) {
		$sql = '';
		$sql .= 'SELECT * ';
		$sql .= 'FROM `room` ';
		$sql .= 'WHERE `id` IN ( ';
		$sql .= '    SELECT `point_id` ';
		$sql .= '    FROM `point_location` ';
		$sql .= '    WHERE `floor_id` = ? ); ';
	
		$query = $this->db->query($sql, array(
				$floor_id));
		if ($query->num_rows() > 0) {
			return $query->result();
		} else {
			return false;
		}
	}

}

?>