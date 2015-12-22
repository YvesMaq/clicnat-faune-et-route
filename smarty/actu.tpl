{include file="__entete.tpl"}
	<div class="pn_main col-xs-12">
		<div style="height:4px;"></div>
		<h1>Actualités sur les continuités écologiques en Picardie</h1>
		<section id="bloc-a">
			<div class="bloc-actu row list-group">
			{foreach from=$actus item=actu}	
			<article class="col-xs-12 list-group-item">
				<h2 class="list-group-item-heading"><a href="{$actu->lien}">{$actu->titre}</a></h1>
				<div class="bloc-actu-pre list-group-item-text row"><a href="{$actu->lien}" class="texte-contenu">{$actu->description}</a></div>
				<div class="bloc-actu-suite  row"><a href="{$actu->lien}" class="btn btn-info">lire l'article complet</a></div>
			</article>
			{/foreach}
			</div>
		</section>
	</div>
	{include file="__footer.tpl"}
		{literal}
<script>$(document).ready(function () { page_actu_init();});</script>{/literal}
</div>
</body>
</html>
