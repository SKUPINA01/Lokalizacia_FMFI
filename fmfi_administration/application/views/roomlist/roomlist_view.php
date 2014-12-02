<?php
$this->data['title'] = 'BUDOVY';
$this->load->view('header_view', $this->data);

$base_url = base_url();
echo "<a href='".$base_url."index.php/login/logout/' style='position: relative; float: right;' >[odhlásiť sa]</a><br>\n";

$this->data['buildings'] = $this->building->getAll();
$this->load->view('roomlist/buildings', $this->data);

$this->load->view('footer_view');
?>
