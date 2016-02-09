{include file="__entete.tpl"}
	<div class="row">
		<div class="col-lg-11">
			<h1>Les observations</h1>
			<div class="well">
				<div id="carte2"></div>
				{if $install == 'picnat'}
					Ces données proviennent d'observations d'animaux vus sur les routes
					(traversant ou victimes de collision) au cours des 3 dernières
					années en Picardie.
					Continuez à alimenter cette carte en saisissant vos observations ! 
					Des secteurs particulièrement accidentogènes pour la faune 
					commencent à apparaitre, la communication avec les services des
					voiries se consolide, et ce grâce à vous.
				{/if}
				{if $install == 'mayenne'}
					Ces données proviennent d'observations d'animaux vus sur les routes 
					(traversant ou victimes de collision) dans le nord de la Mayenne.
					Continuez à alimenter cette carte en saisissant vos observations !
					Les zones de conflit entre la faune et les routes apparaîtront
					grâce à vous. Nous pourrons agir ensuite. 
				{/if}
			</div>
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

