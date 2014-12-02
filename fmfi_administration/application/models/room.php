<?php

class Room extends CI_Model {

	function __construct() {
		parent::__construct();
	}

	function add($floor_id, $room_id, $type = '', $shape_coords = '', $embedded_data = '') {
		if (! $this->_insert_point($room_id)) {
			return false;
		}
		if (! $this->_insert_point_location($floor_id, $room_id)) {
			return false;
		}
		return $this->_insert_room($room_id, $type, $shape_coords, $embedded_data);
	}

	function _insert_point($id) {
		$sql = '';
		$sql .= 'INSERT INTO `point` ';
		$sql .= '(`id`, `x`, `y`) VALUES ';
		$sql .= '(  ? ,  0 ,  0 ); ';
		echo $sql;
		$query = $this->db->query($sql, array(
				$id));
		return $this->db->affected_rows() > 0;
	}

	function _insert_point_location($floor_id, $point_id) {
		$sql = '';
		$sql .= 'INSERT INTO `point_location` ';
		$sql .= '(`floor_id`, `point_id`) VALUES ';
		$sql .= '(     ?    ,      ?    ); ';
		$query = $this->db->query($sql, array(
				$floor_id,
				$point_id));
		return $this->db->affected_rows() > 0;
	}

	function _insert_room($id, $type, $shape_coords, $embedded_data) {
		$sql = '';
		$sql .= 'INSERT INTO `room` ';
		$sql .= '(`id`, `type`, `shape_coords`, `embedded_data`) VALUES ';
		$sql .= '(  ? ,    ?  ,        ?      ,        ?       ); ';
		$query = $this->db->query($sql, array(
				$id,
				$type,
				$shape_coords,
				$embedded_data));
		return $this->db->affected_rows() > 0;
	}

// 	function _get_room($id) {
// 		$sql = '';
// 		$sql .= 'SELECT * ';
// 		$sql .= 'FROM `room` ';
// 		$sql .= 'WHERE `id` = ?; ';
		
// 		$query = $this->db->query($sql, array(
// 				$id));
// 		if ($query->num_rows() > 0) {
// 			return $query->result();
// 		} else {
// 			return false;
// 		}
// 	}

}

?>