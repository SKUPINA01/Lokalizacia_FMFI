<?php
if ($floors) {
	$base_url = base_url();
	foreach ( $floors as $floor ) {
		echo "<div id='container'>\n";
		echo "<h3>$floor->level. poschodie <a href='$base_url/index.php/room/add/$floor->id/'>(pridať miestnosť)</a></h3>\n";
		$this->data['rooms'] = $this->building->getRooms($floor->id);
		$this->load->view('roomlist/rooms', $this->data);
		echo "</div>\n";
	}
} else {
	echo "<p>Budova neobsahuje žiadne poschodia.</p>\n";
}
?>