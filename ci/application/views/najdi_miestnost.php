<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title><?php echo $title;?></title>
</head>

<body>
	<header>
		<h1 style="color: red;"><?php echo $miestnost; ?></h1>
	</header>
	<section id="content">
		<h3>Zoznam uzlov:</h3>
		<li>
			<?php // IF *******************************************************
				foreach ($uzly as $uzol) {
			?>
 			<strong><?php echo $uzol->id; ?></strong><br>
    		Info: <?php echo $uzol->id; ?><br>
    		Typ: <?php
    			echo ($uzol->typ != null
    					? $uzol->typ
    					: 'null'); ?><br>
    		Súradnice: <?php
   				echo ($uzol->suradnice != null
   						? $uzol->suradnice
   						: 'null'); ?><br>
		</li><br>
			<?php
				} // END IF ***************************************************
			?>
	</section>
	<br>
	<br>
	<br>
	<br>
	<br>
	<footer> Vytvorila <strong>SKUPINA01</strong> </footer>
</body>
</html>