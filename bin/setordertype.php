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
$datadir = "extension/impianti/bin/data/";



$cli = eZCLI::instance();
$db = eZDB::instance();
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
$db = eZDB::instance();
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
$cli->output( 'Elimino pratiche archivio: '. $parent_node->attribute( 'name' ) );
/*
if ( count( $options['arguments'] ) < 2 )
{
    $cli->error( "Need a parent node to place object under and file to read data from" );
    $script->shutdown( 1 );
}
*/
include_once( 'kernel/classes/datatypes/ezuser/ezuser.php' );
$user = eZUser::fetchByName( 'admin' );
$userID = $user->attribute( 'contentobject_id' );
eZUser::setCurrentlyLoggedInUser( $user, $userID );
if ( !$user )
{
    
    $user = eZUser::currentUser();
}

$nodeID = $options['arguments'][0];








$pratiche = kcomuniFunctionCollection::getItems($parent_node,"pratica");


foreach ($pratiche as $pratica) {

	$db->query("UPDATE ezcontentobject_tree SET sort_field=8 WHERE node_id=".$pratica->attribute("node_id"));
}



$script->shutdown();

?>
