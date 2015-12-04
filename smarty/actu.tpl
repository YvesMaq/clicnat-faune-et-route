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
<div id="globcont" style="min-width: 1000px;">
	<div class="bloc-haut" style="min-width: 1000px;">
		<div id="banniere_ar">
			<div id="banniere" class="banniere">
				<ul>{include file="menu.tpl"}</ul>
			</div>
			<div class="banniere_fond banniere_fond_visible" style="background-image: url('image/banniere_fond_a.jpg');"></div>
			<div class="banniere_fond" style="background-image: url('image/banniere_fond_b.jpg');"></div>
			<div class="banniere_fond" style="background-image: url('image/banniere_fond_c.jpg');"></div>
		</div>
	</div>
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
</div>
{literal}
<!-- Piwik -->
<script type="text/javascript">
var pkBaseURL = (("https:" == document.location.protocol) ? "https://stats.picardie-nature.org/" : "http://stats.picardie-nature.org/");
document.write(unescape("%3Cscript src='" + pkBaseURL + "piwik.js' type='text/javascript'%3E%3C/script%3E"));
</script><script type="text/javascript">
try {
var piwikTracker = Piwik.getTracker(pkBaseURL + "piwik.php", 7);
piwikTracker.trackPageView();
piwikTracker.enableLinkTracking();
} catch( err ) {}
</script><noscript><p><img src="http://stats.picardie-nature.org/piwik.php?idsite=7" style="border:0" alt="" /></p></noscript>
<!-- End Piwik Tracking Code -->
{/literal}
</body>
</html>
