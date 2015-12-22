{include file="__entete.tpl"}
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
	{include file="__footer.tpl"}
	{literal}
	<script>$(document).ready(function () { page_complements_init();});</script>{/literal}
	</div>

</body>
</html>
