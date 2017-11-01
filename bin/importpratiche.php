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

$script = eZScript::instance( array( 'description' => ( "KCOMUNI - SCRIPT IMPORTAZIONE PRATICHE\n\n" .
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

$nodeID = $options['arguments'][0];
$inputFileName = $options['arguments'][1];

if ( $options['storage-dir'] )
{
    $storageDir = $options['storage-dir'];
}
else
{
    
    $cli->error( "Nessuna directory specificata" );
    $script->shutdown( 1 );
	
}

$csvLineLength = 1000;


if (is_file($datadir."integrazioniDaone.csv")) {

if (($handle = fopen($datadir."integrazioniDaone.csv", "r")) !== FALSE) {

$cID=49018;
$pID=49017;
	

    while (($data = fgetcsv($handle,$csvLineLenght,'||','"')) !== FALSE) {
		
		$pratica = trim($data[0]);
		$anno = trim($data[1]);
		$richiedenti = trim($data[2]);
		$titolo = trim($data[3]);
		$cc = trim($data[4]);
		$pm = trim($data[5]);
		$ped = trim($data[6]);
		$pf = trim($data[7]);
		$indirizzo = trim($data[8]);
		$note = trim($data[9]);

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

		
		$params= array();
				$params['class_identifier'] = "pratica";
				$params['section_id'] = 1;
				$params['creator_id'] = eZUser::currentUser()->ContentObjectID;
				$params['parent_node_id'] = $ParentNodeId;
				$attributesData = array() ;
				$attributesData['name'] =  $pratica;
				$attributesData['year'] =  $anno;
				$attributesData['description'] =  $titolo;
				$attributesData['cc'] =  $cc;
				$attributesData['address'] =  $indirizzo;
				$attributesData['note'] =  $note;
				$attributesData['area'] =  implode("-",$part);
				$attributesData['actors'] =  implode("-",$conc);
				$attributesData['pm'] =  $pm;
				$params['attributes'] = $attributesData;
				$contentObject = eZContentFunctions::createAndPublishObject($params);
		






}



        
	
    }
 fclose($handle);
}






$script->shutdown();

?>
