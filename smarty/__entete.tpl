<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr">
<head>
	<title>Clicnat - Faune et route</title>
	<link href="https://ssl.picardie-nature.org/statique/jquery-ui-1.11.4/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
	<link href="https://ssl.picardie-nature.org/statique/bootstrap-3.3.4-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
	<link href="https://ssl.picardie-nature.org/statique/bootstrap-3.3.4-dist/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css"/>
	<link href="https://ssl.picardie-nature.org/statique/OpenLayers-3.11.2/ol.css" rel="stylesheet" type="text/css"/>
	<link href="pointsnoirs.css" media="all" rel="stylesheet" type="text/css"/>
	{if $usedatatable}
	<link href="http://deco.picardie-nature.org/datatables/media/css/demo_table.css" media="all" rel="stylesheet" type="text/css"/>
	{/if}
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
</head>
<body>
<script src="https://ssl.picardie-nature.org/statique/jquery/jquery-1.11.2.min.js"></script>
<script src="https://ssl.picardie-nature.org/statique/jquery-ui-1.11.4/jquery-ui.min.js"></script>
<script src="https://ssl.picardie-nature.org/statique/OpenLayers-3.11.2/ol.js"></script>
<script src="https://ssl.picardie-nature.org/statique/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
<script src="https://ssl.picardie-nature.org/statique/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
<script src="pointsnoirs.js"></script>
<script src="datepicker-fr.js"></script>
	{foreach from=$msgs item=msg}
		<p>{$msg}</p>
	{/foreach}
</div>
<div class="container" style="width: 1000px; margin-left:auto; margin-right: auto;">
	<header class="row">
		<div class="col-lg-12">
			<div id="banniere_ar">
				<div id="banniere" class="banniere">
					<ul>{include file="menu.tpl"}</ul>
				</div>
			</div>
			
		</div>
	</header>

