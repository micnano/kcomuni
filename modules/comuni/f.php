<?php


$http = eZHTTPTool::instance();
$module = $Params['Module'];
$action = $Params['action'];

$object = false;

$User =  &eZUser::currentUser();
$UserObjectID = $User->attribute('contentobject_id');


	switch($action) {
		case "download":
			$items = $http->postVariable("idtodownload");
			
			$storage = kcomuniFunctionCollection::getStorageDir();
			$zipname = urlencode(date("ymdHi").".zip"); 
			$zip = new ZipArchive();
			if($zip->open($storage.$zipname, ZIPARCHIVE::CREATE) !== false) {
				
				foreach ($items as $item){
					$object = eZContentObject::fetch($item);
					$map = $object->dataMap();
					$file = $map["file"]->content();
					$filename = $file->attribute("original_filename");
					$zip->addFile($file->filePath(),$filename);
					
				
				
				
				
				}
				
					$zip->close();
					header("Pragma: public");
					header("Expires: 0");
					header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
					header("Cache-Control: public");
					header("Content-Description: File Transfer");
					header("Content-type: application/octet-stream");
					header("Content-Disposition: attachment; filename=\"".$zipname."\"");
					header("Content-Transfer-Encoding: binary");
					header("Content-Length: ".filesize($storage.$zipname));
					ob_end_flush();
					@readfile($storage.$zipname);
					unlink($storage.$zipname);
					
			}
				
					
					
				
				
				eZExecution::cleanExit();
		break;
		
		}


?>
