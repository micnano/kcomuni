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

$script = eZScript::instance( array( 'description' => ( "COMUNI- SCRIPT DOCUMENTI DA REMOTO\n\n" .
                                                        "\n" .
                                                        "\n" .
                                                        "\n" .
                                                        "\n" .
                                                        "" ),
                                     'use-session' => false,
                                     'use-modules' => true,
                                     'use-extensions' => true ) );

$script->startup();

$options = $script->getOptions( "[class:][creator:][storage-dir:][node:][host:][user:][password:][remote-dir:]",
                                "",
                                array( 'node' => 'parent node_id to upload object under',
                                       'storage-dir' => 'path to directory which will be added to the path of CSV elements',
                                	   'host' => 'Remote sftp host',
                                	   'user' => 'Remote user',
                                	   'password' => 'Remote password',
                                	   'remote-dir' => 'Remote data path with final slash /'
								),
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
$cli->output( date("d/m/Y HH:ii"));
$cli->output( 'Caricamento documentazione da remoto: '. $parent_node->attribute( 'name' ) );
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



if ( $options['host'] )
{
	$remoteHost = $options['host'];
}
else
{

	$cli->error( "Nessun host specificato" );
	$script->shutdown( 1 );

}

if ( $options['user'] )
{
	$remoteUser = $options['user'];
}
else
{

	$cli->error( "Nome utente remoto non specificato" );
	$script->shutdown( 1 );

}

if ( $options['password'] )
{
	$remotePassword= $options['password'];
}
else
{

	$cli->error( "Password remota non specificata" );
	$script->shutdown( 1 );

}

if ( $options['remote-dir'] )
{
	$remotePath= $options['remote-dir'];
}
else
{

	$cli->error( "Password remota non specificata" );
	$script->shutdown( 1 );

}



$pratiche = kcomuniFunctionCollection::getPratiche($parent_node);

foreach ($pratiche as $pratica) {
	echo "Elaboro ".$pratica->attribute("name");
	
	
	if ($pratica->childrenCount()==0) {
		
		
		$similars = kcomuniFunctionCollection::getFilteredItems($parent_node,'pratica',array('pratica/name' ,'=', $pratica->attribute("name") ));
		if (sizeof($similars)> 1) {
			echo " cancello perchè doppia \n";
			eZContentObjectTreeNode::removeSubtrees( array( $pratica->attribute( 'main_node_id' ) ), false );
			continue;
			
		}
		
		echo " vuota \n";
		exec("sshpass -p \"".$remotePassword."\" scp -r '".$remoteUser."@".$remoteHost.":".$remotePath.$pratica->attribute("name")."' '".$storageDir.$pratica->attribute("name")."'");
		if (!is_dir($storageDir.$pratica->attribute("name"))) {
			exec("sshpass -p \"".$remotePassword."\" scp -r '".$remoteUser."@".$remoteHost.":".$remotePath.$pratica->attribute("name")."' '".$storageDir.$pratica->attribute("name")."'");
		}
		
		
		if (is_dir($storageDir.$pratica->attribute("name"))) {
				
			echo " presente sul server \n";
						
							
						
		
			




	$cartelle=kcomuniFunctionCollection::getFolders($pratica->attribute("name"),$storageDir);
	foreach ($cartelle as $cart) {
	 			$params= array();
				$params['class_identifier'] = "folder";
				$params['section_id'] = 1;
				$params['creator_id'] = $user->ContentObjectID;
				$params['parent_node_id'] = $pratica->attribute("node_id");
				$attributesData = array() ;
				$attributesData['name'] =  $cart[0];
				$params['attributes'] = $attributesData;
				$contentObject = eZContentFunctions::createAndPublishObject($params);
				$contentObjectId = $contentObject->attribute( 'id' );
				$files = kcomuniFunctionCollection::getFiles($storageDir.$pratica->attribute("name")."/".$cart[0]);
 				$db->query("UPDATE ezcontentobject_tree SET priority=".$files[0][1]." WHERE contentobject_id=$contentObjectId");
 				
 				
 				
 					foreach ($files as $file) {
 							$result = array( 'errors' => array() );
							if (strpos($file[0],'.pdf') !== false || strpos($file[0],'.PDF') !== false) {
								$imagename=str_replace(".PDF",".jpg",str_replace(".pdf",".jpg",$file[0]));
								exec ("convert -density 72 ".escapeshellarg($storageDir.$pratica->attribute("name")."/".$cart[0]."/".$file[0]."[0]")." ".escapeshellarg($storageDir.$pratica->attribute("name")."/".$cart[0]."/".$imagename));
								
							} else {
								$imagename=NULL;	
							}
							$params= array();
							$params['class_identifier'] = "file";
							$params['section_id'] = 1;
							$params['creator_id'] = $user->ContentObjectID;
							$params['parent_node_id'] = $contentObject->mainNodeID();
							$params['storage_dir'] = $storageDir.$pratica->attribute("name")."/".$cart[0]."/";
							$attributesData = array() ;
							$attributesData['name'] =  str_replace(".pdf","",$file[0]);
							$attributesData['file'] =  $file[0];
							$attributesData['preview'] =  $imagename;
							$params['attributes'] = $attributesData;
							$contentObjectF = eZContentFunctions::createAndPublishObject($params);
							$contentObjectId=$contentObjectF->ID;
							$db->query("UPDATE ezcontentobject_tree SET priority=$file[1] WHERE contentobject_id=$contentObjectId");
							if (strpos($file[0],'.pdf') !== false || strpos($file[0],'.PDF') !== false) {
									exec("rm ".escapeshellarg($storageDir.$pratica->attribute("name")."/".$cart[0]."/".$imagename));
							}
							

							
 					}
					$files = NULL;
 				
 				
	}


	$files = kcomuniFunctionCollection::getFiles($storageDir.$pratica->attribute("name"));
 				
 					foreach ($files as $file) {
							$contentObjectF=NULL;
							$contentObjectId=NULL;
 							$result = array( 'errors' => array() );
							if (strpos($file[0],'.pdf') !== false || strpos($file[0],'.PDF') !== false) {
								$imagename=preg_replace('/\\.[^.\\s]{3,4}$/', '.jpg', $file[0]);
								exec ("convert -density 72 ".escapeshellarg($storageDir.$pratica->attribute("name")."/".$file[0]."[0]")." ".escapeshellarg($storageDir.$pratica->attribute("name")."/".$imagename));
								
							} else {
								$imagename=NULL;	
							}
							$params= array();
							$params['class_identifier'] = "file";
							$params['section_id'] = 1;
							$params['creator_id'] = $user->ContentObjectID;
							$params['parent_node_id'] = $pratica->attribute("node_id");
							$params['storage_dir'] = $storageDir.$pratica->attribute("name")."/";
							$attributesData = array() ;
							$attributesData['name'] =  str_replace(".pdf","",$file[0]);
							$attributesData['file'] =  $file[0];
							$attributesData['preview'] =  $imagename;
							$params['attributes'] = $attributesData;
							$contentObjectF = eZContentFunctions::createAndPublishObject($params);
							$contentObjectId=$contentObjectF->ID;
							$db->query("UPDATE ezcontentobject_tree SET priority=$file[1] WHERE contentobject_id=$contentObjectId");
							if (is_file($storageDir.$pratica->attribute("name")."/".$imagename)) {
									unlink($storageDir.$pratica->attribute("name")."/".$imagename);
							}
							

							
 					}
 					


			exec("rm -r ".escapeshellarg($storageDir.$pratica->attribute("name")));
		}  else {
			
			echo " non esiste sul server\n ";
		}
} else {
			
			echo " piena non la elaboro\n ";
		}	



}



$script->shutdown();

?>
