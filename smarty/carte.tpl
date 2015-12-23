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
	<div class="row">
		<div class="col-lg-11">
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
			Et eodem impetu Domitianum praecipitem per scalas itidem funibus
			constrinxerunt, eosque coniunctos per ampla spatia civitatis acri
			raptavere discursu. iamque artuum et membrorum divulsa conpage
			superscandentes corpora mortuorum ad ultimam truncata deformitatem
			velut exsaturati mox abiecerunt in flumen.
		{/if}
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

