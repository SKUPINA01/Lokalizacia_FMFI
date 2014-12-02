<?php
$this->data['title'] = 'Pridanie miestnosti';
$this->load->view('header_view', $this->data);
$base_url = base_url();
echo "<a href='" . $base_url . "index.php/login/logout/' style='position: relative; float: right;' >[odhlásiť sa]</a><br>\n";

echo validation_errors();
echo form_open('index.php/verifyroomadd/floor/' . $this->data['floor']);
?>

<label for="id">ID: </label>
<input type="text" size="80" id="id" name="id"
	value="<?php echo set_value('id'); ?>" />
<br>
<label for="type">Typ: </label>
<input type="text" size="80" id="type" name="type"
	value="<?php echo set_value('type'); ?>" />
<br>
<label for="shape_coords">Súradnice: </label>
<input type="text" size="80" id="shape_coords" name="shape_coords"
	value="<?php echo set_value('shape_coords'); ?>" />
<br>
<label for="embedded_data">Info: </label>
<textarea id="embedded_data" name="embedded_data" cols="80"
	maxlength="4000"><?php echo set_value('embedded_data'); ?></textarea>
<input type="submit" id="submit" name="submit" value="Pridať" />
</form>

<?php $this->load->view('footer_view'); ?>
