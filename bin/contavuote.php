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

$script = eZScript::instance( array( 'description' => ( "COMUNI- SCRIPT ESPORTAZIONE STATISTICHE PRATICHE\n\n" .
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
                                array( 'node' => 'parent node_id (COMUNE)' ),
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
$cli->output( 'Elenco pratica;vuota: '. $parent_node->attribute( 'name' ) );


$user = eZUser::fetchByName( 'admin' );
if ( !$user )
{
    
    $user = eZUser::currentUser();
}

$pratiche = kcomuniFunctionCollection::getPratiche($parent_node);

foreach ($pratiche as $pratica) {
if ($pratica->childrenCount()==0) {
	
	echo $pratica->attribute("name").";0\n";
	}

 else {
	echo $pratica->attribute("name").";1\n";
	
	
	}
}	




$script->shutdown();

?>

