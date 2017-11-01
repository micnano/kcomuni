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




$cli = eZCLI::instance();

$script = eZScript::instance( array( 'description' => ( "COMUNI- SCRIPT DI CANCELLAZIONE PRATICHE SENZA DOCUMENTI\n\n" .
                                                        "\n" .
                                                        "\n" .
                                                        "\n" .
                                                        "\n" .
                                                        "" ),
                                     'use-session' => false,
                                     'use-modules' => true,
                                     'use-extensions' => true ) );

$script->startup();

$options = $script->getOptions( "[node:]",
                                "",
                                array( 'node' => 'parent node_id (COMUNE)'),
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
$cli->output( 'Elimino pratiche vuote archivio: '. $parent_node->attribute( 'name' ) );
/*
if ( count( $options['arguments'] ) < 2 )
{
    $cli->error( "Need a parent node to place object under and file to read data from" );
    $script->shutdown( 1 );
}
*/

$user = eZUser::fetchByName( 'admin' );
$userID = $user->attribute( 'contentobject_id' );
eZUser::setCurrentlyLoggedInUser( $user, $userID );
if ( !$user )
{
    
    $user = eZUser::currentUser();
}

$nodeID = $options['arguments'][0];



include_once( 'kernel/classes/datatypes/ezuser/ezuser.php' );




$pratiche = kcomuniFunctionCollection::getFilteredItems($parent_node,"pratica", array('pratica/vuota', '=', 1));


foreach ($pratiche as $pratica) {

	eZContentObjectTreeNode::removeSubtrees( array( $pratica->attribute( 'main_node_id' ) ), false );
	
}



$script->shutdown();

?>
