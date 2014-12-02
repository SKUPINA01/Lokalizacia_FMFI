<?php
if ($rooms) {
	foreach ( $rooms as $room ) {
		$base_url = base_url();
		echo "<div id='container'>\n";
		echo "<h4>$room->id <a href='$base_url/index.php/room/update/$room->id/'>(upraviť miestnosť)</a></h4>\n";
		echo "Súradnice: $room->shape_coords<br>\n";
		echo "Info: $room->embedded_data<br>\n";
		echo "<a href='$base_url/index.php/room/delete/$room->id/'>vymazať miestnosť</a><br>";
		echo "</div>\n";
	}
} else {
	echo "<p>Na tomto poschodí nie sú žiadne miestnosti.</p>\n";
}
?>