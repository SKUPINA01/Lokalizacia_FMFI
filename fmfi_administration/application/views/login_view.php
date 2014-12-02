<?php
$this->data['title'] = 'Prihlásenie';
$this->load->view('header_view', $this->data);

echo validation_errors();
echo form_open('index.php/verifylogin/');
?>

	<label for="id">Meno: </label>
	<input type="text" size="80" id="id" name="id" value="<?php echo set_value('id'); ?>" /><br>
	<label for="password">Heslo: </label>
	<input type="password" size="80" id="password" name="password" /><br>
	<input type="submit" id="submit" name="submit" value="Prihlás" />
</form>

<?php $this->load->view('footer_view'); ?>
