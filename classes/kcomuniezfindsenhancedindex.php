<?php
class kcomuniEzfindEnhancedIndex implements ezfIndexPlugin
{
     /**
      * The modify method gets the current content object AND the list of
      * Solr Docs (for each available language version).
      *
      *
      * @param eZContentObject $contentObect
      * @param array $docList
      */
      public function modify(eZContentObject $contentObect, &$docList)
      {
            $contentNode = $contentObect->attribute('main_node');
				
            $parentNode = $contentNode->attribute('parent');
            if ($parentNode instanceof eZContentObjectTreeNode)
            {
                  $parentObject = $parentNode->attribute('object');
                  $parentVersion = $parentObject->currentVersion();
                  $availableLanguages = $parentVersion->translationList( false, false );
                  foreach ($availableLanguages as $languageCode)
                  {
                          $docList[$languageCode]->addField('extra_parent_node_name_t',  $parentObject->name( false, $languageCode ) );
                          
                  }
            }
            $doindex = false;
				if ($parentNode->attribute("class_identifier") == "pratica") {
					$doindex = true;				
				
				} else {  
				
				$parent = $parentNode;				         
				
					for ($i=1;$i<=3;$i++) {
						$parent = $parent->attribute('parent');
						if ($parent->attribute("class_identifier") == "pratica") {
							$doindex = true;
							$parentNode = $parent;
						}
					
					}
				
				}
				
				if ($doindex===true) {
						$parentVersion = $parentNode->attribute("object")->currentVersion();				
				      $map = $parentVersion->dataMap();
				      $availableLanguages = $parentVersion->translationList( false, false );
				      $particelle = array();
				      $concessionari = array();
				      foreach ($map["area"]->content()["relation_list"] as $particella) {
								$partobject = eZContentObject::fetch($particella["contentobject_id"]);
								$particelle[]=	$partobject->attribute("name");	      
				      }
				      
						foreach ($map["actors"]->content()["relation_list"] as $actor) {
								$partobject = eZContentObject::fetch($actor["contentobject_id"]);
								$concessionari[]=	$partobject->attribute("name");	      
				      }
				      $numero = $map["number"]->content();
				      $anno = $map["year"]->content();
				      $tipoatto = $map["tipo"]->content();
				      $protocollo = $map["protocollo"]->content();
						foreach ($availableLanguages as $languageCode)
                  {
                  	$docList[$languageCode]->addField('extra_pratica_name___ms',  $parentNode->attribute("object")->name( false, $languageCode ) );
                  	$docList[$languageCode]->addField('extra_pratica_numero___ms',  $numero );
							$docList[$languageCode]->addField('extra_pratica_anno___ms',  $anno );
							$docList[$languageCode]->addField('extra_pratica_tipo___ms',  $tipoatto );
							$docList[$languageCode]->addField('extra_pratica_protocollo___ms',  $protocollo );
							$docList[$languageCode]->addField('extra_pratica_particelle___ms',  $particelle );
							$docList[$languageCode]->addField('extra_pratica_concessionari___ms',  $concessionari );
                  }
				
				
				}
            
            
       }
}
?>
