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

$script = eZScript::instance( array( 'description' => ( "ADEP - SCRIPT CREAZIONE MINIATURE\n\n" .
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
echo "Ok";

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

foreach ($nodeList as $FileAtt) {
    $attributes = $FileAtt->dataMap();
    $attributeimage = $attributes['preview'];
    if (!$attributeimage->hasContent()) {
	    $attributefilemime = $attributes['file']->content()->mimeTypePart();
	    $cli->output( 'Elaboro documento : '. $FileAtt->attribute('name')." ".$attributes['file']->content()->mimeTypeCategory()."/".$attributefilemime);
	    if ($attributefilemime == "pdf") {
	    	
	            $filepath = $attributes['file']->content()->Filename;
	            $ini = eZINI::instance( "site.ini" );
	            $varFolder = $ini->variable( "FileSettings", "VarDir" );
	            $stFolder = $varFolder."/storage/original/".$attributes['file']->content()->mimeTypeCategory()."/";
	            exec ("convert -resize 1800X1500 $stFolder$filepath"."[0] ".$datadir."image.jpg");
	            $params = array();
	            $params['storage_dir'] = $datadir;
	            
	            $attributeList = array( 'preview' => 'image.jpg');
	            $params['attributes'] = $attributeList;
	            $result = eZContentFunctions::updateAndPublishObject( $FileAtt->object(), $params );
	            
	           
	    }
	            
	        
    }
    
    
    
    }






$script->shutdown();

?>
