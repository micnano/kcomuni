{* Folder - Full view *}
{set scope=global persistent_variable=hash('left_menu', 'flat_left',
                                           'extra_menu', false())}

{def $rss_export = fetch( 'rss', 'export_by_node', hash( 'node_id', $node.node_id ) )}


<h3 class="page-title">
				<i class="fa fa-folder fa-1x"></i> {attribute_view_gui attribute=$node.data_map.name}
					</h3>

 



            {if $node.object.data_map.description.has_content}
                <div class="attribute-long">
                    {attribute_view_gui attribute=$node.data_map.description}
                </div>
            {/if}

              

            {if $node.object.data_map.show_children.data_int}
                {def $page_limit = 50
                     $classes = ezini( 'MenuContentSettings', 'ExtraIdentifierList', 'menu.ini' )
                     $children = array()
                     $children_count = ''}

                {if le( $node.depth, '3')}
                    {set $classes = $classes|merge( ezini( 'ChildrenNodeList', 'ExcludedClasses', 'content.ini' ) )}
                {/if}


                {set $children_count=fetch_alias( 'children_count', hash( 'parent_node_id', $node.node_id,
                                                                          'class_filter_type', 'exclude',
                                                                          'class_filter_array', $classes ) )}

                
                    {if $children_count}
<div class="tabbable tabbable-custom boxless">
						<ul class="nav nav-tabs">
							<li class="active">
								<a href="#tab_1" data-toggle="tab">Contenuto</a>
							</li>
</ul>
						<div class="tab-content">
							<div class="tab-pane active" id="tab_1">
<div class="margin-top-10">



			<div class="row mix-grid">


			{foreach fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
								'offset', $view_parameters.offset,
								'sort_by', $node.sort_array,
								'class_filter_type', 'exclude',
								'class_filter_array', $classes,
								'limit', $page_limit ) ) as $child }

			{if $child.class_identifier|eq('folder')}
				{set $curcategory = "fa-folder" 
					$categoryname = "Cartelle"} 
			{elseif $child.class_identifier|eq('image')}                          
				{set $curcategory = "fa-picture-o"
					$categoryname = "Immagini"}
			{else}
				{set $curcategory = "fa-file"
					$categoryname = "Files"}
			{/if}

										<div class="col-md-3 col-sm-4 mix {$categoryname}">
											
												 {if $child.class_identifier|eq('file')}

{if $child.object.data_map.preview.has_content}
												<a class="fancybox-button" href="http://flex.kine.coop/php/simple_document.php?subfolder=&doc={$child.data_map.file.content.filename}" title="{$child.name|wash}" target="_blank" data-rel="fancybox-button"><img class="img-responsive" src="/{$child.data_map.preview.content.['imagelarge'].full_path}" alt="{$child.name|wash}"/></a>
	
												<h5 class="preview-title">{$child.data_map.file.content.mime_type|mimetype_icon( 'normal', $child.name|wash )} {$child.data_map.file.content.original_filename|wash}</h5>
{else}
<h5>{$child.data_map.file.content.mime_type|mimetype_icon( 'normal', $child.name|wash )} <a class="fancybox-button" href="http://flex.kine.coop/php/simple_document.php?subfolder=&doc={$child.data_map.file.content.filename}" title="{$child.name|wash}" target="_blank" data-rel="fancybox-button">{$child.data_map.file.content.original_filename|wash}</a></h5>



{/if}
<div class="mix-details1">
	{set $attribute = $child.data_map.file}												
													<a class="mix-link" href={concat("content/download/",$attribute.contentobject_id,"/",$attribute.id,"/file/",$attribute.content.original_filename)|ezurl} title="Scarica"><i class="fa fa-download"></i></a>
{if $child.object.can_remove}

<div class="mix-preview">
<div class="form">
<form method="post" name="DeleteNode{$child.object.id}" action={"/content/action"|ezurl} class="form-horizontal">


<input type="hidden" name="ContentObjectID" value="{$child.object.id}" />
<input type="hidden" name="ContentNodeID" value="{$child.node_id}" />
<input type="hidden" name="MoveToTrash" value="0" />
<input type="hidden" name="ActionRemove" value="{'Remove'|i18n('design/standard/node/view')}" />



<button type="submit" class="btn red form-control-inline"><i class="fa fa-trash-o"></i></button>

</form>	</div>
</div>										

{/if}
{if $child.object.can_edit}
<div class="mix-bottom2">
<div class="form">
<form method="post" name="EditNode{$child.object.id}" action={"/content/action"|ezurl} class="form-horizontal">


<input type="hidden" name="ContentObjectID" value="{$child.object.id}" />
<input type="hidden" name="ContentNodeID" value="{$child.node_id}" />
<input type="hidden" name="EditButton" value="{'Edit'|i18n('design/standard/node/view')}" />



<button type="submit" class="btn red form-control-inline"><i class="fa fa-edit"></i></button>

</form>	</div>
</div>	

{/if}

{if $child.object.data_map.preview.has_content}

<a class="mix-bottom fancybox-button" href="http://flex.kine.coop/php/simple_document.php?subfolder=&doc={$child.data_map.file.content.filename}" title="{$child.name|wash}" target="_blank" data-rel="fancybox-button"><i class="fa fa-search"></i></a>
{/if}


												</div>

												


												{/if}


												{if $child.class_identifier|eq('folder')}
													
												<h4><i class="fa fa-folder"></i> <a href={$child.url_alias|ezurl()}>{$child.name|wash}</a></h4>
												
<div class="mix-details1">	
	<a class="mix-link" href={$child.url_alias|ezurl} title="Esplora"><i class="fa fa-search"></i></a>
{if $child.object.can_remove}

<div class="mix-preview">
<div class="form">
<form method="post" name="DeleteNode{$child.object.id}" action={"/content/action"|ezurl} class="form-horizontal">


<input type="hidden" name="ContentObjectID" value="{$child.object.id}" />
<input type="hidden" name="ContentNodeID" value="{$child.node_id}" />
<input type="hidden" name="MoveToTrash" value="0" />
<input type="hidden" name="ActionRemove" value="{'Remove'|i18n('design/standard/node/view')}" />



<button type="submit" class="btn red form-control-inline"><i class="fa fa-trash-o"></i></button>

</form>	</div>
</div>										

{/if}

{if $child.object.can_edit}
<div class="mix-bottom2">
<div class="form">
<form method="post" name="EditNode{$child.object.id}" action={"/content/action"|ezurl} class="form-horizontal">


<input type="hidden" name="ContentObjectID" value="{$child.object.id}" />
<input type="hidden" name="ContentNodeID" value="{$child.node_id}" />
<input type="hidden" name="EditButton" value="{'Edit'|i18n('design/standard/node/view')}" />



<button type="submit" class="btn red form-control-inline"><i class="fa fa-edit"></i></button>

</form>	</div>
</div>	

{/if}




												</div>

												{/if}

												{if $child.class_identifier|eq('image')}
													
					<img class="img-responsive" src="/{$child.data_map.image.content.['imagelarge'].full_path}" alt="{$child.name|wash}"/>									
					
												
<div class="mix-details">
	<h4>{$child.name|wash}</a></h4>												
													<a class="mix-link" href="/{$child.data_map.image.content.['original'].full_path}"><i class="fa fa-download"></i></a>
													<a class="mix-preview2 fancybox-button" target="_blank" href="http://flex.kine.coop/php/simple_document.php?subfolder=&doc={$child.data_map.file.content.filename}" title="{$child.name|wash}" data-rel="fancybox-button"><i class="fa fa-search"></i></a>
												</div>

												{/if}


											</div>
										

							{/foreach}
		
									</div>
								




                        
                    {/if}
            

                {include name=navigator
                         uri='design:navigator/google.tpl'
                         page_uri=$node.url_alias
                         item_count=$children_count
                         view_parameters=$view_parameters
                         item_limit=$page_limit}

            {/if}
      </div></div></div></div>
        
