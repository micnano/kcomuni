<?php
/**
 * File containing the importarchivio.php
 *
 * @copyright Copyright (C) 1999-2013 Michele Paoli
 * @license http://www.gnu.org/licenses/gpl-2.0.txt GNU General Public License v2
 * @version  0.001
 */

require_once 'autoload.php';
$datadir = "extension/impianti/bin/data/";



$cli = eZCLI::instance();

$script = eZScript::instance( array( 'description' => ( "COMUNI- SCRIPT IMPORTAZIONE STRUTTURA\n\n" .
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
                                "[node1][file]",
                                array( 'node' => 'parent node_id to upload object under',
                                       'file' => 'file to read CSV data from',
                                       'class' => 'class identifier to create objects',
                                       'creator' => 'user id of imported objects creator',
                                       'storage-dir' => 'path to directory which will be added to the path of CSV elements' ),
                                false,
                                array( 'user' => true ));



$script->initialize();
$currentUser = eZUser::fetch( 14 );
eZUser::setCurrentlyLoggedInUser( $currentUser, 14 );
$db = eZDB::instance();
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
$cli->output( date("d/m/Y H:i"));
$cli->output( 'Aggiornamento pratiche vuote: '. $parent_node->attribute( 'name' ) );
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






$pratiche = kcomuniFunctionCollection::getPratiche($parent_node);

foreach ($pratiche as $pratica) {
if ($pratica->childrenCount()==0) {
	
	$params= array();
	$attributesData = array() ;
	$attributesData['vuota'] = 1;
	$params['attributes'] = $attributesData;
	$contentObject = eZContentFunctions::updateAndPublishObject($pratica->object(),$params);
	}

 else {
	$map = $pratica->dataMap();
	$vuota = $map["vuota"]->content();
		if ($vuota == 1) {
		$params= array();
		$attributesData = array() ;
		$attributesData['vuota'] = 0;
		$params['attributes'] = $attributesData;
		$contentObject = eZContentFunctions::updateAndPublishObject($pratica->object(),$params);
		}
	
	}
}	




$script->shutdown();

?>

