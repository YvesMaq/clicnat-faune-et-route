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
<script src="pointsnoirs.js"></script>
<div style="clear:both;">
	{foreach from=$msgs item=msg}
		<p>{$msg}</p>
	{/foreach}
</div>
<div>
	<div id="choix_especes" style="display:none;">
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
		<div id="fiche" style="display:none;">
			<form id="ffiche">
				<input type="hidden" name="fiche_id_espece" id="fiche_id_espece"/>
				Espèce : <span id="fiche_nom_espece"></span><br/>
				Nombre d'individus morts <br/>
				<input type="text" size="3" id="fiche_nb_morts"> <br/>
				Niveau de certitude dans l'identification des animaux morts<br/>
				<select id="f_niveau_certitude_morts">
					<option value="4">Très fort</option>
					<option value="3">Fort</option>
					<option value="2">Moyen</option>
					<option value="1">Faible</option>
				</select><br/>
				Nombres d'individus vivants :<br/> <input type="text" size="3" id="fiche_nb_vivants"><br/>
				Niveau de certitude dans l'identification des animaux vivants<br/> 
				<select id="f_niveau_certitude_vivants">
					<option value="4">Très fort</option>
					<option value="3">Fort</option>
					<option value="2">Moyen</option>
					<option value="1">Faible</option>
				</select><br/><br/>
				Commentaire sur l'observation :
				<textarea cols="40" rows="4" id="fiche_commentaire"></textarea>
				<input type="submit" value="Ajouter"/>
			</form>
		</div>
		<div id="tableau">
			<br/>Pour ajouter une espèce cliquez sur son nom.
		</div>
	</div>
</div>


<div class="container" style="width: 1000px; margin-left:auto; margin-right: auto;">
	<div class="row">
		<div class="col-lg-12">
			<div id="banniere_ar">
				<div id="banniere" class="banniere">
					<ul>{include file="menu.tpl"}</ul>
				</div>
			</div>
			
		</div>
	</div>
	{if $msg_ok}<div id="ok" style="font-size: 16px;color:green;text-align:center;">Observation enregistrée, Merci !</div>{/if}
	<div class="row">
		<div class="col-lg-4">
			<div style="height: 30px;"></div>
			<div id="bloc-img" class="carousel slide" data-ride="carousel">
				<div class="carousel-inner">
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
				</div>
			</div>
		</div>
		<div class="col-lg-8">
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
					<p id="statut_zoom_ok" style="display:none;">Vous pouvez passer a l'étape B</p>
					<p><b>B</b> Cliquer sur le lieu précis de l'observation.</p>
					<p id="statut_click"></p>
					<p><b>C</b> Compléter et envoyer le formulaire.</p>
				</div>
				<div id="form-saisie" style="display:none;">
					<h1>Informations</h1>
					<form id="fa">
						<input type="hidden" name="lat" id="f_lat"/>
						<input type="hidden" name="lon" id="f_lon"/>
						Nom <br/>
						<input type="text" name="nom" id="f_nom" value="{$sess_nom}"/><br/>
						Prénom <br/>
						<input type="text" name="prenom" id="f_prenom" value="{$sess_prenom}"/><br/>
						<br/>
						Structure <br/>
						<input type="text" name="structure" id="f_structure" value="{$sess_structure}"/><br/>
						<br/>
						Adresse <br/>
						<textarea name="adresse" cols="30" rows="3" id="f_adresse"/>{$sess_adresse}</textarea><br/>
						<br/>
						Code postal<br/>
						<input type="text" name="code_postal" value="{$sess_code_postal}"/><br/>
						Ville<br/>
						<input type="text" name="ville" value="{$sess_ville}"/><br/>
						Téléphone <br/>
						<input type="text" name="tel" id="f_tel" value="{$sess_tel}" /><br/>
						Email <br/>
						<input type="text" name="email" id="f_mail" value="{$sess_email}"/><br/>
						<br/>
						<input type="checkbox" value="1" name="diff_ok" id="f_diff_ok" {if $sess_diff_ok == "1"}checked{/if}/>
						<label for="f_diff_ok">J'accepte que mon nom apparaisse sur la carte de répartition des points noirs.</label><br/>
						<input type="checkbox" value="1" name="particip_ok" id="f_particip_ok" {if $sess_particip_ok == "1"}checked{/if}/>
						<label for="f_particip_ok">Je souhaiterais participer à des actions de protection près de chez moi</label><br/>
						<br/>
						Date d'observation<br/>
						<input type="text" name="date" id="f_date" size="10"/><br/><br/>
						Heure de l'observation<br/>
						<input type="text" size="2" maxlength=2" name="heure_h" if="f_heure_h"/>h<input type="text" size="2" maxlength=2" name="heure_m" id="f_heure_m"/><br/><br/>
						<input type="submit" value="Continuer"/>
					</form>
				</div>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12" style="text-align:center;">
			{include file=pied.tpl}
		</div>
	</div>
</div>
{literal}
<script>$(document).ready(function () { page_accueil_init();});</script>
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
