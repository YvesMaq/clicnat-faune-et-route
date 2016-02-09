{include file="__entete.tpl"}
	{if $msg_ok}<div id="ok" style="font-size: 16px;color:green;text-align:center;">Observation enregistrée, Merci !</div>{/if}
	<div class="row">
		<div class="col-lg-4">
			<div style="height: 30px;"></div>
			<div id="bloc-img" class="carousel slide" data-ride="carousel">
				<div class="carousel-inner">
				{if $install eq 'picnat'}
					<div class="item active"><img src="image/illustration_a.jpg"/></div>
					<div class="item"><img src="image/illustration_b.jpg"/></div>
					<div class="item"><img src="image/illustration_c.jpg"/></div>
					<div class="item"><img src="image/illustration_d.jpg"/></div>
					<div class="item"><img src="image/illustration_e.jpg"/></div>
					<div class="item"><img src="image/illustration_f.jpg"/></div>
					<div class="item"><img src="image/illustration_g.jpg"/></div>
					<div class="item"><img src="image/illustration_h.jpg"/></div>
					<div class="item"><img src="image/illustration_i.jpg"/></div>
					<div class="item"><img src="image/illustration_j.jpg"/></div>
					<div class="item"><img src="image/illustration_k.jpg"/></div>
				{if}
				{if $install eq 'mayenne'}
					<div class="item active"><img src="image/mayenne/illustration_a.jpg"/></div>
					<div class="item"><img src="image/mayenne/illustration_b.jpg"/></div>
					<div class="item"><img src="image/mayenne/illustration_c.jpg"/></div>
					<div class="item"><img src="image/mayenne/illustration_d.jpg"/></div>
					<div class="item"><img src="image/mayenne/illustration_e.jpg"/></div>
					<div class="item"><img src="image/mayenne/illustration_f.jpg"/></div>
					<div class="item"><img src="image/mayenne/illustration_g.jpg"/></div>
					<div class="item"><img src="image/mayenne/illustration_h.jpg"/></div>
				{/if}
				</div>
			</div>
			<p class="text-center">
				<br/>
				<a href="?p=carte" class="btn btn-primary btn-lg">Voir les observations en base</a>
				<br/>
			</p>
		</div>
		<div class="col-lg-8">
				{if $install eq 'picnat'}
				<h1>La faune sauvage sur les routes de Picardie</h1>
				La faune a des besoins territoriaux vitaux et se déplace entre ces territoires,
				saisonnièrement pour la reproduction comme les amphibiens ou quotidiennement pour
				la recherche de nourriture, de zones de repos... pour les mammifères terrestres.
				Parfois, se déplacer peut devenir un vrai défi...<br/><br/>
				Les voies de déplacement et autres axes de migration de la faune sauvage sont
				souvent entrecoupés par des infrastructures linéaires (routes, voies ferrées, canaux...)
				dont certaines constituent des obstacles quasi infranchissables pour la faune.
				Les animaux se risquent et peuvent y trouver la mort.<br/><br/>
				La présente enquête a pour objectif de recenser ces points de conflit à l'échelle
				de la région Picardie pour identifier les voies de déplacement de la faune et proposer
				lorsqu'il le sera possible des mesures de protection (crapauduc, écuroduc...).<br/><br/>
				Si vous souhaitez des renseignements sur cette enquête, contactez Virginie au 03.62.72.22.57
				ou par mail : virginie.coffinet@picardie-nature.org.
				{/if}
				{if $install eq 'mayenne'}
				<h1>La faune sauvage sur les routes de Mayenne</h1>
				<p>Chaque espèce de la faune a plusieurs territoires vitaux et se déplace entre eux,
				quotidiennement ou saisonnièrement pour la recherche de nourriture, le repos, la
				reproduction... Les routes, qui constituent les voies de déplacement pour l'homme,
				créent souvent des obstacles, parfois infranchissables, à leur déplacement. L'issue
				est souvent fatale pour les animaux. Les collisions avec le grand gibier (sanglier,
				chevreuil, cerf) peuvent aussi être à l'origine d'accidents graves.</p>
				<p>Une étude du réseau formé par des milieux à flore et faune particulièrement riches
				(réservoirs de biodiversité) et des voies de déplacements entre ces milieux 
				(corridors écologiques) est en cours sur Mayenne Communauté.</p>
				<p>Cette enquête, inédite en Mayenne, a pour but de localiser et recenser les points
				de conflit. Ainsi, les voies de déplacements des animaux seront identifiées. Dans 
				un second temps, des mesures de gestion pourront être mises en place, s'il est possible,
				pour limiter les impacts du réseau routier.</p>
				<p>Vous souhaitez nous aider à connaître ces zones de collisions ? Participez en
				transmettant vos observations d'animaux morts ou blessés ou ceux que vous avez réussi
				à éviter. Si vos observations se situent hors Mayenne Communauté, saisissez-les également.
				Ainsi nous pourrons étendre nos actions.</p>
				<p>Si vous souhaitez plus de renseignements sur ce projet, cliquez ici (lien vers page
				TVB de notre site) ou contactez-nous au 02 43 03 79 62 ou par mail à 
				contact@cpie-mayenne.org.</p>
				{/if}
		</div>
	</div>
	<div class="row">
		<div class="col-lg-8">
			<div id="bloc-b-carte-in">
				<div id="olmap" class="fill"></div>
			</div>
		</div>
		<div class="col-lg-4">
				<div id="form-instructions">
					<h1>Instructions</h1>
					<p><b>A</b> Placer la carte sur la zone de l'observation.</p>
					<p id="statut_zoom_plus">Vous devez zoomer plus pour passer au point B,
					vous pouvez utiliser la molette de la souris.</p>
					<p id="statut_zoom_info"></p>
					<div id="statut_zoom_ok" class="alert alert-success" style="display:none;">Vous pouvez passer a l'étape B</div>
					<p><b>B</b> Cliquer sur le lieu précis de l'observation.</p>
					<p id="statut_click"></p>
					<p><b>C</b> Compléter et envoyer le formulaire.</p>
				</div>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12 saisieinfo" style="display:none;">
			<h1>Informations</h1>
		</div>
	</div>
	<div class="row">
		<div id="form-saisie" style="display:none;" class="saisieinfo">
			<form id="fa">
				<div class="col-lg-6">
					<input type="hidden" name="lat" id="f_lat"/>
					<input type="hidden" name="lon" id="f_lon"/>
					
					<label for="f_date">Date d'observation</label><br/>
					<input type="text" name="date" id="f_date" size="10" required="true"/><br/><br/>
					<label for="f_heure_h">Heure de l'observation</label><br/>
					<input type="text" size="2" maxlength="2" name="heure_h" if="f_heure_h"/>h<input type="text" size="2" maxlength="2" name="heure_m" id="f_heure_m"/><br/><br/>

					<label for="f_nom">Nom</label><br/>
					<input type="text" name="nom" id="f_nom" value="{$sess_nom}" required="true"/><br/>

					<label for="f_prenom">Prénom</label><br/>
					<input type="text" name="prenom" id="f_prenom" value="{$sess_prenom}" required="true"/><br/>

					<br/>
					<label for="f_adresse">Adresse</label><br/>
					<textarea name="adresse" cols="30" rows="3" id="f_adresse"/>{$sess_adresse}</textarea><br/>
					<br/>
					<label for="f_code_postal">Code postal</label><br/>
					<input type="text" name="code_postal" id="f_code_postal" value="{$sess_code_postal}"/><br/>

					<label for="f_ville">Ville</label><br/>
					<input type="text" name="ville" id="f_ville" value="{$sess_ville}"/><br/>
				</div>
				<div class="col-lg-6">
					<label for="f_tel">Téléphone</label><br/>
					<input type="text" name="tel" id="f_tel" value="{$sess_tel}" /><br/>

					<label for="f_mail">Email</label><br/>
					<input type="text" name="email" id="f_mail" value="{$sess_email}"/><br/>
					<br/>
					<label for="f_structure">Structure</label> <br/>
					<input type="text" name="structure" id="f_structure" value="{$sess_structure}"/><br/>

					<br/>

					<label for="f_diff_ok">
						<input type="checkbox" value="1" name="diff_ok" id="f_diff_ok" {if $sess_diff_ok == "1"}checked{/if}/>
						J'accepte que mon nom apparaisse sur la carte de répartition des points noirs.
					</label><br/>
					<input type="checkbox" value="1" name="particip_ok" id="f_particip_ok" {if $sess_particip_ok == "1"}checked{/if}/>
					<label for="f_particip_ok">Je souhaiterais participer à des actions de protection près de chez moi</label><br/>
					<br/>
					<input class="btn btn-primary" type="submit" value="Continuer"/>
				</div>
			</form>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12 obsespeces" style="display:none;">
			<h1>Espèce observée</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-4 obsespeces" style="display:none;">
			<div id="groupes">
				Chercher une espèce
				<div class="groupe" id="autres" style="margin-bottom:15px;">
					<input type="text" id="recherche_esp">
					<script>
					//{literal}
					$('#recherche_esp').autocomplete({
						source: '?p=espece_autocomplete2', 
						select: function (event,ui) {
							set_fiche_id_espece_nom(ui.item.value, ui.item.label);
							return false; 
						} 
					});
					//{/literal}
					</script>
				</div>
				ou choisir une espèce
				<div class="groupe groupe_liste" id="batraciens">
					{foreach from=$batraciens item=e}
						<a href='javascript:set_fiche_id_espece({$e->id_espece});' id="e{$e->id_espece}">{$e}</a>
					{/foreach}
				</div>
				<hr/>
				<div class="groupe groupe_liste" id="mammiferes">
					{foreach from=$mammiferes item=e}
						<a href='javascript:set_fiche_id_espece({$e->id_espece});' id="e{$e->id_espece}">{$e}</a>
					{/foreach}
				</div>
				<hr/>
				<div class="groupe groupe_liste" id="oiseaux">
					{foreach from=$oiseaux item=e}
						<a href='javascript:set_fiche_id_espece({$e->id_espece});' id="e{$e->id_espece}">{$e}</a>
					{/foreach}
				</div>
			</div>
		</div>
		<div class="col-lg-4 obsespeces" style="display:none;">
			<div id="fiche">
				<form id="ffiche">
					<input type="hidden" name="fiche_id_espece" id="fiche_id_espece"/>
					<label for="fiche_nom_espece">Espèce :</label> <span id="fiche_nom_espece"></span><br/>
					<label for="fiche_nb_morts">Nombre d'individus morts</label> <br/>
					<input type="text" size="3" id="fiche_nb_morts"> <br/>
					<label for="f_niveau_certitude_morts">Niveau de certitude dans l'identification des animaux morts</label><br/>
					<select id="f_niveau_certitude_morts">
						<option value="4">Très fort</option>
						<option value="3">Fort</option>
						<option value="2">Moyen</option>
						<option value="1">Faible</option>
					</select><br/>
					<label for="fiche_nb_vivants">Nombres d'individus vivants :<br/> <input type="text" size="3" id="fiche_nb_vivants"></label><br/>
					<label for="f_niveau_certitude_vivants">Niveau de certitude dans l'identification des animaux vivants</label><br/> 
					<select id="f_niveau_certitude_vivants">
						<option value="4">Très fort</option>
						<option value="3">Fort</option>
						<option value="2">Moyen</option>
						<option value="1">Faible</option>
					</select><br/><br/>
					<label for="fiche_commentaire">
						Commentaire sur l'observation :
					</label>
					<textarea style="width:100%;" rows="4" id="fiche_commentaire"></textarea>
					<input type="submit" value="Ajouter"/>
				</form>
			</div>
		</div>
		<div class="col-lg-4 obsespeces" style="display:none;">
			Animaux observés
			<div id="tableau">
				<br/>Pour ajouter une espèce cliquez sur son nom.
			</div>
		</div>
	</div>
	{include file="__footer.tpl"}
	{literal}
	<script>
		$(document).ready(function () {
			// {/literal}
			page_accueil_init("{$install}");
			// {literal}
		});
	</script>{/literal}
	</body>
</html>
<!-- {$install} -->
