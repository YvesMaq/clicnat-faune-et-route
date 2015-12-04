OpenLayers.Control.Click = OpenLayers.Class(OpenLayers.Control, {                
	defaultHandlerOptions: {
		single: true,
		double: false,
		pixelTolerance:false,
		stopSingle: false,
		stopDouble: false
	},

	initialize: function(options) {
		this.handlerOptions = OpenLayers.Util.extend({}, this.defaultHandlerOptions);
		OpenLayers.Control.prototype.initialize.apply(this, arguments); 
		this.handler = new OpenLayers.Handler.Click(this, {click: this.trigger}, this.handlerOptions);
	}, 

	trigger: function(e) {
	    if (this.map.getZoom() >= 14) {
		var pt = e.object.getLonLatFromViewPortPx(e.xy);
		marque_point(pt.clone())
		pt.transform(e.object.projection, e.object.displayProjection);
		$('#f_lon').val(pt.lon);
		$('#f_lat').val(pt.lat);
		$('#statut_click').html("Vous pouvez passer à l'étape C");
		$('#form-instructions').hide();
		$('#form-saisie').show();
	    } else {
		$('#statut_click').html('Vous devez zoomer plus');
	    }
	}
});

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

function on_zoomend(obj) {
	if (this.getZoom() < 15) {
		$('#statut_zoom_plus').show();
		$('#statut_zoom_ok').hide();
		var n = 15 - this.getZoom();
		if (n>1) $('#statut_zoom_info').html('Il reste '+n+' niveaux de zoom a traverser');
		else $('#statut_zoom_info').html('Il reste un dernier niveau de zoom a traverser');
	} else {
		$('#statut_zoom_plus').hide();
		$('#statut_zoom_ok').show();
		$('#statut_zoom_info').html('');
	}
}

function init_carte(id_map) {
	var options = {
		projection: new OpenLayers.Projection('EPSG:900913'),
		displayProjection: new OpenLayers.Projection('EPSG:4326'),
		units: "m",
		numZoomLevel: 18,
		maxResolution: 156543.0339,
		maxExtent: new OpenLayers.Bounds(-20037508, -20037508, 20037508, 20037508.34)
	};
	imap = new OpenLayers.Map(id_map, options);
	imap.addControl(new OpenLayers.Control.LayerSwitcher());
	var ghyb = new OpenLayers.Layer.Google("Google Hybride", {type: google.maps.MapTypeId.HYBRID, numZoomLevels: 20, sphericalMercator: true});
	layer = new OpenLayers.Layer.Markers('Point');
	imap.addLayers([ghyb,layer]);
	var pt = new OpenLayers.LonLat(2.80151, 49.69606);
		
	pt.transform(imap.displayProjection, imap.projection);
	var z = 8;

	imap.setCenter(pt, z);

	imap.events.register('zoomend', null, on_zoomend);

	var click = new OpenLayers.Control.Click();
	imap.addControl(click);
	click.activate();
	return imap;
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

function page_accueil_maj_fond() {
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
