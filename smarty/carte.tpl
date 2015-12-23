{include file="__entete.tpl"}
	<div class="row">
		<div class="col-lg-11">
			<div id="carte2"></div>
		</div>
		<div class="col-lg-1 text-center">
			<img src="image/icones/mammifere.png">
			<br/>
			Mammifères

			<img src="image/icones/oiseau.png">
			Oiseaux
			
			<img src="image/icones/amphibien.png">
			Amphibiens
			et Reptiles
		</div>
	</div>
	{include file="__footer.tpl"}
	{literal}
	<script>
		$(document).ready(function () {
			// {/literal}
			page_carte_init("{$install}");
			// {literal}
		});
	</script>{/literal}
	</body>
</html>

