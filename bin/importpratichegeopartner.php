#!/usr/bin/env php
<?php
/**
 * File containing the importarchivio.php
 *
 * @copyright Copyright (C) 1999-2013 Michele Paoli
 * @license http://www.gnu.org/licenses/gpl-2.0.txt GNU General Public License v2
 * @version  0.001
 */

require_once 'autoload.php';
$datadir = "extension/kcomuni/bin/data/";



$cli = eZCLI::instance();

$script = eZScript::instance( array( 'description' => ( "ADEP - SCRIPT IMPORTAZIONE STRUTTURA\n\n" .
                                                        "\n" .
                                                        "\n" .
                                                        "\n" .
                                                        "\n" .
                                                        "" ),
                                     'use-session' => false,
                                     'use-modules' => true,
                                     'use-extensions' => true ) );

$script->startup();

$options = $script->getOptions( "[class:][creator:][storage-dir:][node:]",
                                "[node1][:file]",
                                array( 'node' => 'parent node_id to upload object under',
                                       'file' => 'file to read CSV data from',
                                       'class' => 'class identifier to create objects',
                                       'creator' => 'user id of imported objects creator',
                                       'storage-dir' => 'path to directory which will be added to the path of CSV elements' ),
                                false,
                                array( 'user' => true ));



$script->initialize();


if ( $options['node'] )
{
    $ParentNodeId = $options['node'];
}
else
{
    
    $cli->error( "Nessun nodo specificato" );
    $script->shutdown( 1 );
	
}




$parent_node = eZContentObjectTreeNode::fetch( $ParentNodeId );
$cli->output( date("d/m/Y HH:ii"));
$cli->output( 'Allineamento archivio comune - Importazione pratiche: '. $parent_node->attribute( 'name' ) );
/*
if ( count( $options['arguments'] ) < 2 )
{
    $cli->error( "Need a parent node to place object under and file to read data from" );
    $script->shutdown( 1 );
}
*/

$user = eZUser::fetchByName( 'admin' );
if ( !$user )
{
    
    $user = eZUser::currentUser();
}


eZUser::setCurrentlyLoggedInUser( $user, 14 );




$db = eZDB::instance();
$db->begin();

$dati= $db->arrayQuery("SELECT * FROM `Atti` GROUP BY `NumAtto1`,`NumAtto2`,`Descrizione` ORDER BY `NumAtto2` ASC");

$db->commit();
$pID=214531;
$cID=214524;



foreach ($dati as $entry) {	
	$pratica =  $entry["NumAtto2"]."-".$entry["NumAtto1"];
	if(!empty($entry["NumAtto1Kine"])) $pratica =  $entry["NumAtto1Kine"];
	$anno = intval($entry["NumAtto2"]);
	$numatto = $entry["NumAtto1"];
	if ($anno ==0) {
		$aarr = explode("-",$pratica);
		$anno = intval(preg_replace('/\D/', '', $aarr[0] ));
		$numatto = $aarr[0];
	}
	if ($anno >0 && $anno < 2100) { 	
	$titolo = $entry["desclavori"];
	$cc = getComune($entry["ComCat"]);
	$indirizzo = $entry["Localita"];
	$protocollo = $entry["Protocollo"];
	$pmm = $entry["PorzMat"];
	$richarr = $db->arrayQuery("SELECT Cognome, Nome, cfpi FROM `Atti` WHERE NumAtto1 = '".$entry["NumAtto1"]."' AND NumAtto2 = '".$entry["NumAtto2"]."' AND Descrizione = '".addslashes($entry["Descrizione"])."' GROUP BY Cognome,Nome");
	$db->commit();
	$richiedenti = '';
	foreach($richarr as $key => $richiedente) {
		$richiedenti .= $richiedente['Cognome']." ".$richiedente['Nome'];
		if (!empty($richiedente['cfpi'])) $richiedenti .= " - ".$richiedente['cfpi'];
		if ((sizeof($richarr)-1)>$key) $richiedenti .= ",";
	}
	
	$richarr = $db->arrayQuery("SELECT DISTINCT(particella) FROM `Atti` WHERE EdFond = 'E' AND NumAtto1 = '".$entry["NumAtto1"]."' AND NumAtto2 = '".$entry["NumAtto2"]."' AND Descrizione = '".addslashes($entry["Descrizione"])."'");
	$ped = '';
foreach($richarr as $key => $richiedente) {
		$ped .= $richiedente['particella'];
		if ((sizeof($richarr)-1)>$key) $ped  .= ",";
	}
	$db->commit();
	$richarr = $db->arrayQuery("SELECT DISTINCT(particella) FROM `Atti` WHERE EdFond = 'F' AND NumAtto1 = '".$entry["NumAtto1"]."' AND NumAtto2 = '".$entry["NumAtto2"]."' AND Descrizione = '".addslashes($entry["Descrizione"])."'");
	$pf = '';
foreach($richarr as $key => $richiedente) {
		$pf .= $richiedente['particella'];
		if ((sizeof($richarr)-1)>$key) $pf  .= ",";
	}
	$db->commit();
	$richarr = $db->arrayQuery("SELECT DISTINCT(particella) FROM `Atti` WHERE EdFond = 'M' AND NumAtto1 = '".$entry["NumAtto1"]."' AND NumAtto2 = '".$entry["NumAtto2"]."' AND Descrizione = '".addslashes($entry["Descrizione"])."'");
	$pm = '';
foreach($richarr as $key => $richiedente) {
		$pm .= $richiedente['particella'];
		if ((sizeof($richarr)-1)>$key) $pm  .= ",";
	}
	
$db->commit();
   

		$ricarr=explode(",",$richiedenti);
		
		
		
		
		$nomi= array();
		$conc=array();
		$part=array();
		foreach ($ricarr as $ric) {
			$conc[] = kcomuniFunctionCollection::checkperson(trim($ric),$cID);			
					
		}
		
		if (!empty($ped)) {
			$pedarr=explode(",",$ped);
			$tipo = "P.ed.";
			foreach ($pedarr as $ric) {
				$part[] = kcomuniFunctionCollection::checkpart(trim($ric),$pID,$cc,$tipo);					
			}
		}

		if (!empty($pf)) {
			$pf=explode(",",$pf);
			$tipo = "P.f.";
			foreach ($pf as $ric) {
				$part[] = kcomuniFunctionCollection::checkpart(trim($ric),$pID,$cc,$tipo);					
			}
		}
		
		if (!empty($pm)) {
			$pf=explode(",",$pm);
			$tipo = "P.M.";
			foreach ($pf as $ric) {
				$part[] = kcomuniFunctionCollection::checkpart(trim($ric),$pID,$cc,$tipo);					
			}
		}

		$params= array();
		$params['ClassFilterType'] = "include";
 			$params['SortBy'] = array('published', false);
 			$params['ClassFilterArray'] = array('pratica');
			$params['AttributeFilter'] = array( 
				array('pratica/number', '=', $entry["NumAtto1"] ),
				array('pratica/year', '=', $entry["NumAtto2"] ),
				array('pratica/tipo', '=', $entry["Descrizione"] ) );
			$Node = eZContentObjectTreeNode::fetch($ParentNodeId);
			$actors = $Node->subTree($params);
			if(sizeof($actors)==0) { 		
				
				$params= array();
				$params['class_identifier'] = "pratica";
				$params['section_id'] = 1;
				$params['creator_id'] = 14;
				$params['parent_node_id'] = $ParentNodeId;
				$attributesData = array() ;
				$attributesData['name'] =  $pratica;
				$attributesData['year'] =  $anno;
				$attributesData['description'] =  $titolo;
				$attributesData['tipo'] =  $entry["Descrizione"];
				$attributesData['number'] =  $numatto;
				$attributesData['numberc'] =  intval(preg_replace('/\D/', '', $numatto));
				$attributesData['cc'] =  $cc;
				$attributesData['address'] =  $indirizzo;
				$attributesData['protocollo'] =  $protocollo;
				$attributesData['area'] =  implode("-",$part);
				$attributesData['actors'] =  implode("-",$conc);
				$attributesData['pm'] =  $pmm;
				$params['attributes'] = $attributesData;
				
				$contentObject = eZContentFunctions::createAndPublishObject($params);
			}	else {
			
				if(sizeof($actors)==1) { 
					$object = $actors[0]->object();
					$attributesData = array() ;
					$attributesData['name'] =  $pratica;
					$attributesData['year'] =  $anno;
					$attributesData['description'] =  $titolo;
					$attributesData['tipo'] =  $entry["Descrizione"];
					$attributesData['number'] =  $numatto;
					$attributesData['numberc'] =  intval(preg_replace('/\D/', '', $numatto));
					$attributesData['cc'] =  $cc;
					$attributesData['address'] =  $indirizzo;
					$attributesData['protocollo'] =  $protocollo;
					$attributesData['area'] =  implode("-",$part);
					$attributesData['actors'] =  implode("-",$conc);
					$attributesData['pm'] =  $pmm;
					$params['attributes'] = $attributesData;
					
					eZContentFunctions::updateAndPublishObject( $object, $params );
				}
				
				if(sizeof($actors)>1) {
					echo $actors[0]->attribute("name")." doppia";
					}
			
			
			}


}



}



        
	 






$script->shutdown();




function getComune($code) {
	switch($code) {
	case "301":
		return "Ragoli I";
	break;
	
	case "39":
		return "Bosentino";
	break;
	
	case "242":
		return "Montagne";
	break;
	
	case "294":
		return "Preore";
	break;
	
	case "295":
		return "Presson";
	break;
	
	case "296":
		return "Prezzo";
	break;
	
	case "302":
		return "Ragoli II";
	break;
	
	case "359":
		return "Spera I";
	break;
	
		
	default:
	return "";
	break;
	
	}

}






?>
