<?php
require_once('/etc/baseobs/config.php');

session_start();

define('TITRE_PAGE', "Localisation des points noirs");
define('TITRE_H1', 'Picardie-Nature');
define('TITRE_H2', TITRE_PAGE);
define('SESS', 'POST');

define('FORMAT_DATE_COMPLET', '%A %d %B %Y');
define('FORMAT_DATE_MOISJOUR', '%d %B');

if (!defined('SMARTY_TEMPLATE_POINTSNOIRS'))
	define('SMARTY_TEMPLATE_POINTSNOIRS', '../smarty');

if (!defined('SMARTY_COMPILE_POINTSNOIRS'))
	define('SMARTY_COMPILE_POINTSNOIRS', '/tmp/smarty_pointsnoirs_compile');
if (!define('INSTALL'))
	define('INSTALL','clicnat');
if (!define('CLICNAT_COLLISION_TAG'))
	define('CLICNAT_COLLISION_TAG','71');
if (!define('CLICNAT_POSE_TAG'))
	define('CLICNAT_POSE_TAG','180');


require_once(SMARTY_DIR.'Smarty.class.php');
require_once(OBS_DIR.'utilisateur.php');
require_once(OBS_DIR.'espece.php');
require_once(OBS_DIR.'rss.php');
require_once(OBS_DIR.'smarty.php');
require_once(OBS_DIR.'docs.php');
require_once(DB_INC_PHP);

class PointsNoirs extends clicnat_smarty {
	private $msgs;

	const batraciens = '1,3,1013,16,1015,1014,15,11,1012,1010';
	const mammiferes = '4643,195,837,924,176,1074,1061,920,209,839,935,697';
	const oiseaux = '577,891,586,310,311,864,324';
	const elem_a_enregistrer = 'nom,prenom,structure,adresse,ville,tel,email,diff_ok,particip_ok,code_postal';

	private function sess_store($k, $v) {
		$_SESSION["pointsnoirs_$k"] = $v;
	}

	private function sess_get($k) {
		if (isset($_SESSION["pointsnoirs_$k"]))
			return $_SESSION["pointsnoirs_$k"];
		else
			return '';
	}

	public function __construct($db) {
		$this->db = $db;
		$this->msgs = array();
		$this->template_dir = SMARTY_TEMPLATE_POINTSNOIRS;
		$this->compile_dir = SMARTY_COMPILE_POINTSNOIRS;

		if (!file_exists($this->compile_dir))
			mkdir($this->compile_dir);
	
		if (!array_key_exists('p', $_GET))
			$_GET['p'] = 'accueil';

		if (!array_key_exists('id_utilisateur', $_SESSION))
			$_SESSION['id_utilisateur'] = false;

		switch ($_GET['p']) {
			case 'espece_autocomplete2':
				$this->before_espece_autocomplete2();
				break;
			case 'accueil':
				$this->before_accueil();
				$this->display('accueil.tpl');
				break;
			case 'actu':
				$this->before_actu();
				$this->display('actu.tpl');
				break;
			case 'enregistre':
				$id_utilisateur = get_config()->query_nv('/clicnat/pointsnoirs/id_utilisateur');
				$tag_point_noir = get_config()->query_nv('/clicnat/pointsnoirs/id_tag');
				$tag_mort = get_config()->query_nv('/clicnat/pointsnoirs/id_tag_mort');
				
				$id_espace = bobs_espace_point::insert($this->db, array(
					'id_utilisateur' => $id_utilisateur,
					'reference' => '',
					'nom' => '',
					'x' => $_GET['lon'],
					'y' => $_GET['lat']
				));

				$id_obs = bobs_observation::insert($this->db, array(
					'id_utilisateur' => $id_utilisateur,
					'date_observation' => $_GET['date'],
					'id_espace' => $id_espace,
					'table_espace' => 'espace_point'
				));

				$observation = new bobs_observation($this->db, $id_obs);
				if (!empty($_GET['heure_h']))
					$observation->set_heure($_GET['heure_h'], $_GET['heure_m']);

				if (isset($_GET['diff_ok'])) $_GET['diff_ok'] = false;
				if (isset($_GET['particip_ok'])) $_GET['diff_ok'] = false;

				$comtr2 = "INFORMATIONS DU FORMULAIRE\n\n";
				$comtr2.= "Nom: {$_GET['nom']}\n";
				$comtr2.= "Prenom: {$_GET['prenom']}\n";
				$comtr2.= "Structure: {$_GET['structure']}\n";
				$comtr2.= "Adresse:\n";
				$comtr2.= "{$_GET['adresse']}\n\n";
				$comtr2.= "Ville: {$_GET['ville']}\n";
				$comtr2.= "Tel: {$_GET['tel']}\n";
				$comtr2.= "EMail: {$_GET['email']}\n";
				$comtr2.= "DiffusionNom: {$_GET['diff_ok']}\n";
				$comtr2.= "ParticipOk: {$_GET['particip_ok']}\n";

				$a_enregistrer = explode(',', self::elem_a_enregistrer);
				foreach ($a_enregistrer as $k)
					$this->sess_store($k, $_GET[$k]);
				
				$observation->add_observateur($id_utilisateur);

				for ($x=0;$x<10;$x++) {
					if (array_key_exists("id_espece_$x", $_GET)) {
						if ($_GET["n_vivant_$x"] > 0) {
							$id_citation = $observation->add_citation($_GET["id_espece_$x"]);
							$citation = new bobs_citation($this->db, $id_citation);
							$citation->set_effectif($_GET["n_vivant_$x"]);
							$citation->set_indice_qualite($_GET["indice_q_vivant_$x"]);
							$citation->set_commentaire($_GET["commentaire_0"]);
							$citation->ajoute_tag($tag_point_noir);
							$citation->ajoute_commentaire('info', $id_utilisateur,$comtr2);
						}
						if ($_GET["n_mort_$x"] > 0) {
							$id_citation = $observation->add_citation($_GET["id_espece_$x"]);
							$citation = new bobs_citation($this->db, $id_citation);
							$citation->set_effectif($_GET["n_mort_$x"]);
							$citation->set_indice_qualite($_GET["indice_q_mort_$x"]);
							$citation->set_commentaire($_GET["commentaire_0"]);
							$citation->ajoute_tag($tag_point_noir);
							$citation->ajoute_tag($tag_mort);
							$citation->ajoute_commentaire('info', $id_utilisateur,$comtr2);
						}
					}
				}

				$observation->send();
				header('Location: ?p=complements');
				$_SESSION['id_observation'] = $observation->id_observation;
				exit();
			case 'complements':
				$id_utilisateur = get_config()->query_nv('/clicnat/pointsnoirs/id_utilisateur');
				$observation = get_observation($this->db, $_SESSION['id_observation']);
				if (!isset($_POST['a'])) {
					$this->assign_by_ref('obs', $observation);
					$this->display('complements.tpl');
				} else {
					// enregistrement
					$citations = $observation->get_citations()->ids();

					foreach ($_FILES as $nom => $data) {
						if ($data['error'] != 0) continue;
						if (preg_match('/^image_(\d+)$/',$nom, $m)) {
							echo "$nom\n";
							$citation = get_citation($this->db, $m[1]);
							if (array_search($citation->id_citation, $citations) === false) {
								continue;
							}
							$doc_id = bobs_document::sauve($_FILES[$nom]);
							$image = new bobs_document_image($doc_id);
							$citation->document_associer($doc_id);
						} 	
					}
					if (!empty($_POST['observateurs_supplementaires'])) {
						$observation->ajoute_commentaire('info', $id_utilisateur, $_POST['observateurs_supplementaires']);
					}

					header('Location: ?p=accueil&eok=1');
					exit();
				}
				break;
			case 'geojson' :
				header('Content-type: application/json');
				var_dump($this->geojson());
				return $this->geojson();

			default:
				echo "404";
				exit();
		}
	}

	public function geojson() {
		$tags = get_config()->query_nv('/clicnat/pointsnoirs/id_tag');
		if (INSTALL == 'clicnat'){
			$tags .=  ",".CLICNAT_COLLISION_TAG;
			$tags .= ",".CLICNAT_POSE_TAG;
		}
	$sql ='	SELECT	
		espace_point.id_espace,
		st_x(espace_point.the_geom) as x,
		st_y(espace_point.the_geom) as y,
		citations.id_espece
	FROM
		citations,
		observations,
		citations_tags,
		espace_point
	WHERE
		citations_tags.id_tag in ('.$tags.')
		and citations.id_citation = citations_tags.id_citation
		and citations.id_observation = observations.id_observation
		and observations.id_espace = espace_point.id_espace
		and observations.date_observation > current_date - interval \'3 year\'
		;';

		$geo = [ "type" => "FeatureCollection", "features" => [] ];
		$q = bobs_qm()->query($this->db, 'fer_espaces_l',$sql , []);
		while ($r = bobs_element::fetch($q)) {
			$geo["features"][] = [
					"type" => "Feature",
					"geometry" => [
						"type" => "Point",
						"coordinates" => [(float)$r['x'], (float)$r['y']]
					],
					"properties" => [
						"id_espace" => (int)$r['id_espace'],
						"reseau" => get_espece($this->db,$r['id_espece'])->get_reseau()->id
					]
				];
		}
			return json_encode($geo);
	}

	protected function before_actu() {
		$rss = new clicnat_rss_reader("http://www.picardie-nature.org/spip.php?page=backend&id_rubrique=171");
		$this->assign_by_ref("actus", $rss);
	}

	protected function before_accueil() {
		$a_remettre = explode(',', self::elem_a_enregistrer);

		foreach ($a_remettre as $k) {
			$v = $this->sess_get($k);
			if ($v)
				$this->assign("sess_$k", $v);
		}

		$this->assign_by_ref('batraciens', new clicnat_iterateur_especes($this->db, explode(',', self::batraciens)));
		$this->assign_by_ref('mammiferes', new clicnat_iterateur_especes($this->db, explode(',', self::mammiferes)));
		$this->assign_by_ref('oiseaux', new clicnat_iterateur_especes($this->db, explode(',', self::oiseaux)));
		
		$a_restaurer = explode(self::elem_a_enregistrer, ',');

		if (array_key_exists('formulaire', $_GET))
			$this->assign('formulaire', $_GET);
		else
			$this->assign('formulaire', $_SESSION['id_utilisateur']?'start':'root');
	
		$this->assign('msg_ok', array_key_exists('eok', $_GET));
	}

	const ins_c_requis = "nom,prenom,email,ville";
	public function display($template) {
		$f = implode('/', array($this->template_dir, $template));
		if (!file_exists($f)) throw new Exception('404');
		$this->assign_by_ref('msgs', $this->msgs);
		$this->assign('clegmap', get_config()->query_nv('/clicnat/clegooglemap[@id="pointsnoirs"]'));
		$q_jslibs = array('openlayers','proj4js','jquery','jquery-ui','jquery-ui-datefr');
		$jslibs = array();
		foreach ($q_jslibs as $qlib) {
			$jslibs[] = get_config()->query_nv("/clicnat/jslib[@lib=\"$qlib\"]");
		}
		$this->assign_by_ref('jslibs', $jslibs);
		return parent::display($template);
	}
}

new PointsNoirs($db);
?>
