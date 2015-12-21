function annuler(id_espece) {
	var my_i = new Array();
	for (var i=0;i<inventaires.length;i++) {
		if( inventaires[i].id_espece != id_espece) {
			my_i.push(inventaires[i]);
		}
	}
	inventaires = my_i;
	actualise_tableau();
}

function terminer() {
	var args = $('#fa').serialize();

	var args_sup = {};
	for (var i=0;i<inventaires.length;i++) {
		args_sup['id_espece_'+i] = inventaires[i].id_espece;
		args_sup['n_mort_'+i] = inventaires[i].nb_mort;
		args_sup['n_vivant_'+i] = inventaires[i].nb_vivant;
		args_sup['indice_q_mort_'+i] = inventaires[i].indice_q_mort;
		args_sup['indice_q_vivant_'+i] = inventaires[i].indice_q_vivant;
		args_sup['commentaire_'+i] = inventaires[i].commentaire;
	}
	url = '?p=enregistre&'+args+'&'+$.param(args_sup);
	document.location.href = url;
	$('#choix_especes').hide();
}

function set_fiche_id_espece(id) {
	set_fiche_id_espece_nom(id, $('#e'+id).html());
}

function set_fiche_id_espece_nom(id,nom) {
	var i;
	for (i=0;i<inventaires.length;i++) {
		if (inventaires[i].id_espece == id) {
			alert('Espèce déjà enregistrée');
			return;
		}
	}
	$('#fiche_nom_espece').html(nom);
	$('#fiche_id_espece').val(id);
	$('#fiche_nb_morts').val('');
	$('#fiche_nb_vivants').val('');
	$('#fiche_commentaire').val('');
	$('#fiche').show();
	$('#tableau').hide();
}

function Inventaire(id_espece,nom,nb_mort,nb_vivant,indice_q_mort,indice_q_vivant,commentaire) {
	this.id_espece = id_espece;
	this.nom = nom;
	
	if (isNaN(nb_mort)) this.nb_mort = 0;
	else this.nb_mort = nb_mort;

	if (isNaN(nb_vivant)) this.nb_vivant = 0;
	else this.nb_vivant = nb_vivant;

	if (isNaN(indice_q_mort)) this.indice_q_mort = 4;
	else this.indice_q_mort = indice_q_mort;

	if (isNaN(indice_q_vivant)) this.indice_q_vivant = 4;
	else this.indice_q_vivant = indice_q_vivant;

	this.commentaire = commentaire;

	this.texte = function () {
		var txt = this.nom+' ';

		if (this.nb_mort > 0)
			txt += this.nb_mort+' mort';

		if (this.nb_mort > 1) txt += 's ';
		else txt += ' ';

		if (this.nb_vivant > 0)
			txt += this.nb_vivant+' vivant';
		if (this.nb_vivant > 1) txt += 's ';
		else txt += ' ';
		return txt;
	}
}

function init_carte(id_map) {
	var styles = [ 'Road', 'Aerial', 'AerialWithLabels', 'collinsBart', 'ordnanceSurvey' ];
	var bing = new ol.layer.Tile({ 
		visible: true,
		preload: Infinity,
		source: new ol.source.BingMaps({
			key: 'Ah-gSVhOCszl1-LJ6d1gs11SXprWx2-BM6GUkUiqcDAmRWEgV2tNQ_1a7M2wJ33t',
			imagerySet: styles[2]
		})
	});
	var vector = new ol.layer.Vector({
		// source: new ol.source.GeoJSON({
		//	url: 'data/geojson/countries.geojson',
		//	projection: 'EPSG:3857'
		// }),
		style: new ol.style.Style({ 
			fill: new ol.style.Fill({ color: 'rgba(255, 255, 255, 0.6)' }),
			stroke: new ol.style.Stroke({ color: '#319FD3', width: 1 }) 
		})
	});
	var view = new ol.View({
		// make sure the view doesn't go beyond the 22 zoom levels of Google Maps
		maxZoom: 19
	});
	var olMapDiv = document.getElementById('olmap');
	carte = new ol.Map({
		layers: [bing],
		target: olMapDiv,
		view: new ol.View({
			center: [-6655.5402445057125, 6709968.258934638],
			zoom: 10
	        })
	});
	carte.on('click', function (e) {
		var zoom = e.map.getView().getZoom();
		if (zoom < 15) {
			$('#statut_zoom_plus').show();
			$('#statut_zoom_ok').hide();
		} else {
			var pt = e.map.getCoordinateFromPixel(e.pixel);
			// marque_point();
			var lonlat = ol.proj.toLonLat(pt, e.map.getView().getProjection());
			console.log(lonlat);
			$('#f_lon').val(lonlat[0]);
			$('#f_lat').val(lonlat[1]);

			$('#statut_click').html("Vous pouvez passer à l'étape C");

			$('#form-instructions').hide();
			$('#form-saisie').show();
		}
	});
	carte.on('moveend', function (e) {
		console.log("zoom end");
		console.log(e);
		var zoom = e.map.getView().getZoom();
		var n = 15 - zoom;
		if (zoom < 15) {
			if (n>1) 
				$('#statut_zoom_info').html('Il reste '+n+' niveaux de zoom a traverser');
			else 
				$('#statut_zoom_info').html('Il reste un dernier niveau de zoom a traverser');
		} else {
			$('#statut_zoom_plus').hide();
			$('#statut_zoom_ok').show();
			$('#statut_zoom_info').html('');
		}

	});
}

function marque_point(p) {
	for (var i=0; i<layer.markers.length; i++)
		layer.removeMarker(layer.markers[i]);
	var width = 32;
	var height = 37;
	var size = new OpenLayers.Size(width, height);
	var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
	var icon = new OpenLayers.Icon('image/panoramic.png', size, offset);
	var marqueur = new OpenLayers.Marker(p, icon);
	layer.addMarker(marqueur);

	return p;
}

function page_accueil_fermer_forms() {
	$('.formulaire').hide();
}

function page_accueil_maj_image() {
	var images = [
		'image/illustration_a.jpg',
		'image/illustration_b.jpg',
		'image/illustration_c.jpg',
		'image/illustration_d.jpg',
		'image/illustration_e.jpg',
		'image/illustration_f.jpg',
		'image/illustration_g.jpg',
		'image/illustration_h.jpg',
		'image/illustration_i.jpg',
		'image/illustration_j.jpg',
		'image/illustration_k.jpg'
	];
	page_accueil_glob_img_pos = (page_accueil_glob_img_pos+1)%images.length;
	var url = "url(\""+images[page_accueil_glob_img_pos]+"\")";
	$('#bloc-a-image').css('background-image', url);
	setTimeout("page_accueil_maj_image()", 8000);
}

var img_fond = 0;
function page_accueil_maj_fond() {
	var images = ['image/banniere_fond_a.jpg','image/banniere_fond_b.jpg','image/banniere_fond_c.jpg'];
	img_fond = (img_fond + 1) % images.length;
	$('#banniere_ar').css('backgroundImage', 'url("'+images[img_fond]+'")');
	setTimeout("page_accueil_maj_fond()", 15000);
}

function __page_accueil_maj_fond() {
	var elems = $('.banniere_fond');
	for (var i=0; i<elems.length; i++) {
		var e = $(elems[i]);
		if (e.hasClass('banniere_fond_visible')) {
			e.removeClass('banniere_fond_visible');
			$(elems[(i+1)%elems.length]).addClass('banniere_fond_visible');
			break;
		}
	}
	setTimeout("page_accueil_maj_fond()", 15000);
}
var page_accueil_glob_img_pos = 0;
var carte;
var layer;
var inventaires = new Array();
var commentaire_observateur = "";

function actualise_tableau() {
	$('#tableau').html('');

	for (var i=0; i<inventaires.length; i++) {
		$('#tableau').append(inventaires[i].texte());
		$('#tableau').append(' <a href="javascript:annuler('+inventaires[i].id_espece+');">(annuler)</a>');
		$('#tableau').append("<br/>");
	}

	$('#tableau').append("<br/><a href=javascript:terminer();>Envoyer vos observations</a><br/>");
	$('#tableau').append("Vous pouvez aussi ajouter une espèce en cliquant dans la liste à gauche");

	$('#fiche').hide();
	$('#tableau').show();
}

function page_accueil_init() {
	page_accueil_maj_fond();
	page_accueil_maj_image();
	carte = init_carte('bloc-b-carte-in');

	$.datepicker.setDefaults($.datepicker.regional['fr']);
	var d = $('#f_date');
	d.datepicker({maxDate: 0});
	d.datepicker("option","fr");
	$('.carousel').carousel();

	$('#fa').submit(function () {
		try {
			var elems = $(this).children("[name]");
			for (var i=0; i<elems.length; i++) {
				switch ($(elems[i]).attr('name')) {
					case 'nom':
					case 'prenom':
					case 'email':
					case 'ville':
					case 'date':
						var v = $(elems[i]).val();
						if (v.length == 0) {
							alert('Le champ '+$(elems[i]).attr('name')+' est obligatoire');
							return false;
						}
						break;
				}
			}
		} catch (e) {
			alert("Une erreur a bloqué l'envoi du formulaire");
			return false;
		}

		$('#choix_especes').show();
		return false;
	});

	$('#ffiche').submit(function () {
		console.log('va enregistrer');
		try {
			var iv = new Inventaire(
				$('#fiche_id_espece').val(),
				$('#fiche_nom_espece').html(),
				$('#fiche_nb_morts').val(),
				$('#fiche_nb_vivants').val(),
				$('#f_niveau_certitude_morts').val(),
				$('#f_niveau_certitude_vivants').val(),
				$('#fiche_commentaire').val()
			);
			console.log(iv);
			if (iv.nb_mort == "" && iv.nb_vivant == "") {
				alert('Effectifs vides');
				return false;
			}
			console.log('ok');
			inventaires.push(iv);
			actualise_tableau();
		} catch (e) {
			alert(e);
			return false;
		}
		return false;
	});
}
