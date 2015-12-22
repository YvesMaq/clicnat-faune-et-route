<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr">
<head>
	<title>Clicnat - Points Noirs</title>
	<link href="http://deco.picardie-nature.org/jquery/css/redmond/jquery-ui-1.8.2.custom.css" media="all" rel="stylesheet" type="text/css" />
	<link href="pointsnoirs.css" media="all" rel="stylesheet" type="text/css"/>
	{if $usedatatable}
	<link href="http://deco.picardie-nature.org/datatables/media/css/demo_table.css" media="all" rel="stylesheet" type="text/css"/>
	{/if}
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
</head>
<body>
{foreach from=$jslibs item=jslib}
<script src="{$jslib}" language="javascript"></script>
{/foreach}
<div class="container" style="width: 1000px; margin-left:auto; margin-right: auto;">
	{include file="__entete.tpl"}
	<div class="pn_main" style="clear:both;">
	<form enctype="multipart/form-data" action="?p=complements" method="post">
		<input type="hidden" value="1" name="a"/>
		<h1>Compléments d'observations</h1>
		<h1>Observateurs</h1>
		Si vous souhaitez associer d'autres personnes à cette observation, indiquez leur nom :<br/>
		<textarea name="observateurs_supplementaires" style="width:100%; height: 100px;"></textarea>
		<div style="height:20px;"></div>
		<h1>Photos</h1>
		{foreach from=$obs->get_citations() item=c}
		<div>
			{$c->get_espece()} <input type="file" name="image_{$c->id_citation}" />
		</div>
		{/foreach}
		<input type="submit" value="Envoyer"/>
	</form>
	</div>
	{include file="__footer.tpl"}
	{literal}
	<script>$(document).ready(function () { page_complements_init();});</script>{/literal}
	</div>

</body>
</html>
