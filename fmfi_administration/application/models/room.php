<?php

class Room extends CI_Model {

	function __construct() {
		parent::__construct();
	}

	function add($floor_id, $room_id, $shape_coords = '', $embedded_data = '') {
// 		if (! _insert_point($room_id)) {
// 			return false;
// 		}
 		return true;
// 		if (! _insert_point_location($floor_id, $room_id)) {
// 			return false;
// 		}
// 		return _insert_room($room_id, $shape_coords, $embedded_data);
	}

	function _get_room($id) {
		$sql = '';
		$sql .= 'SELECT * ';
		$sql .= 'FROM `room` ';
		$sql .= 'WHERE `id` = ?; ';
		
		$query = $this->db->query($sql, array(
				$id));
		if ($query->num_rows() > 0) {
			return $query->result();
		} else {
			return false;
		}
	}

	function _insert_point($id) {
		$sql = '';
		$sql .= 'INSERT INTO `point` ';
		$sql .= '(`id`, `x`, `y`) VALUES ';
		$sql .= '(  ? ,  0 ,  0 ); ';
		echo $sql;
		$query = $this->db->query($sql, array(
				$id));
		return $query->affected_rows() > 0;
	}

	function _insert_point_location($floor_id, $point_id) {
		$sql = '';
		$sql .= 'INSERT INTO `point_location` ';
		$sql .= '(`floor_id`, `point_id`) VALUES ';
		$sql .= '(     ?    ,      ?    ); ';
		$query = $this->db->query($sql, array(
				$floor_id,
				$room_id));
		return $query->affected_rows() > 0;
	}

	function _insert_room($id, $shape_coords, $embedded_data) {
		$sql = '';
		$sql .= 'INSERT INTO `room` ';
		$sql .= '(`id`, `shape_coords`, `embedded_data`) VALUES ';
		$sql .= '(  ? ,        ?      ,        ?       ); ';
		$query = $this->db->query($sql, array(
				$id,
				$shape_coords,
				$embedded_data));
		return $query->affected_rows() > 0;
	}

}

?>