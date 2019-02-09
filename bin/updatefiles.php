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
$ParentNodeId=60;


$cli = eZCLI::instance();

$script = eZScript::instance( array( 'description' => ( "ADEP - SCRIPT REINDEX FILES\n\n" .
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
$cli->output( 'Creazione anteprime pdf: '. $parent_node->attribute( 'name' ) );

$params = array(
 'ClassFilterType' => 'include',
 'ClassFilterArray' => array( 'file') ); 

$nodeList =$parent_node->subTree($params);


/*
if ( count( $options['arguments'] ) < 2 )
{
    $cli->error( "Need a parent node to place object under and file to read data from" );
    $script->shutdown( 1 );
}
*/

$user = eZUser::fetchByName( 'admin' );


foreach ($nodeList as $FileAtt) {
	$cli->output( 'Verifico documento : '. $FileAtt->attribute('name'));

	            $params = array();
	            $attributeList = array( 'name' => $FileAtt->attribute('name'));
	            $params['attributes'] = $attributeList;
	            eZContentFunctions::updateAndPublishObject( $FileAtt->object(), $params );
	            
	           
	    }
	            







$script->shutdown();

?>
