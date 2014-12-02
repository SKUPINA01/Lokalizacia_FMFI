<?php
if ($buildings) {
	foreach ( $buildings as $building ) {
		echo "<div id='container'>\n";
		echo "<h2>$building->id</h2>\n";
		$this->data['cur_building'] = $building;
		$this->data['floors'] = $this->building->getFloors($building->id);
		$this->load->view('roomlist/floors', $this->data);
		echo "</div>\n";
	}
} else {
	echo "<p>Nie sú dostupné žiadne budovy.</p>\n";
}
?>