<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr">
<head>
	<title>Clicnat - Points Noirs</title>
	<link href="http://deco.picardie-nature.org/jquery/css/redmond/jquery-ui-1.8.2.custom.css" media="all" rel="stylesheet" type="text/css" />
	<link href="pointsnoirs.css" media="all" rel="stylesheet" type="text/css"/>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
</head>
<body>
<script src="https://ssl.picardie-nature.org/statique/jquery/jquery-1.11.2.min.js"></script>
<script src="https://ssl.picardie-nature.org/statique/jquery-ui-1.11.4/jquery-ui.min.js"></script>
<script src="https://ssl.picardie-nature.org/statique/OpenLayers-3.11.2/ol.js"></script>
<script src="https://ssl.picardie-nature.org/statique/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
<style>
{literal}
.bloc-actu a {
	color:black;
}
.bloc-actu  {
	margin: 10px;
	clear:both;
}
.bloc-actu-suite {
	text-align:right;
}
.bloc-actu-suite a {
	color: blue;
}
{/literal}
</style>
<div style="clear:both;">
	{foreach from=$msgs item=msg}
		<p>{$msg}</p>
	{/foreach}
</div>
<div class="container" style="width: 1000px; margin-left:auto; margin-right: auto;">
	{include file="__entete.tpl"}
	<div class="pn_main" style="clear:both;">
		<div style="height:4px;"></div>
		<h1>Actualités sur les continuités écologiques en Picardie</h1>
		<div id="bloc-a">
			<div class="bloc-actu">
			{foreach from=$actus item=actu}	
				<h1><a href="{$actu->lien}">{$actu->titre}</a></h1>
				<p><a href="{$actu->lien}">{$actu->description}</a></p>
				<div class="bloc-actu-suite"><a href="{$actu->lien}">lire l'article complet</a></div>
			{/foreach}
			</div>
		</div>
	</div>
	{include file="__footer.tpl"}
	
</div>
</body>
</html>
