<h3 class="page-title"><i class="fa fa-university fa-1x"></i> {$node.name}</h3>


  <div class="portlet box blue">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-reorder"></i>Archivio
							</div>
							<div class="tools">
								<a href="javascript:;" class="collapse"></a>
							</div>
						</div>
						<div class="portlet-body">

<div class="row mix-grid">

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

{def $category = ""
     $curcategory= ""
	$categoryarray= array()
     $categoryname = ""
	$attribute=array()}
<div class="mix-grid">


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
													
												<h5>{$child.data_map.file.content.mime_type|mimetype_icon( 'normal', $child.name|wash )} {$child.data_map.file.content.original_filename|wash}</h5>

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
												</div>

												{/if}

												{if $child.class_identifier|eq('image')}
													
					<img class="img-responsive" src="/{$child.data_map.image.content.['imagelarge'].full_path}" alt="{$child.name|wash}"/>									
					
												
<div class="mix-details">
	<h4>{$child.name|wash}</a></h4>												
													<a class="mix-link" href="/{$child.data_map.image.content.['original'].full_path}"><i class="fa fa-download"></i></a>
													<a class="mix-preview2 fancybox-button" href="/{$child.data_map.image.content.['original'].full_path}" title="{$child.name|wash}" data-rel="fancybox-button"><i class="fa fa-search"></i></a>
												</div>

												{/if}


										
										</div>

							{/foreach}
		
									</div>

										
										
				{/if}



</div>





						</div>
	</div>







 <div class="portlet box blue">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-reorder"></i>Scadenze dei prossimi 60 giorni
							</div>
							<div class="tools">
								<a href="javascript:;" class="collapse"></a>
							</div>
						</div>
						<div class="portlet-body">

{def $time = currentdate()|sum(5184000)}
{def $docs = fetch('content', 'tree', hash('parent_node_id', $node.node_id, 'class_filter_type', 'include', 'class_filter_array', array('file'), 'attribute_filter', array(array(310, '=', '1'), array(311, '<=', $time)) ))}
{if $docs}
<table class="table table-striped table-bordered table-advance table-hover">
								<thead>
								<tr>
									<th>
										<i class="fa fa-folder"></i> Percorso
									</th>
									<th class="hidden-xs">
										<i class="fa fa-file"></i> File
									</th>
									<th>
										<i class="fa fa-calendar"></i> Data scadenza
									</th>
									<th>
									</th>
								</tr>
								</thead>
								<tbody>
{foreach $docs as $doc}

								<tr>
									
									<td class="hidden-xs">
										<ul class="page-breadcrumb breadcrumb">
<li><i class="fa fa-home"></i></li>
{section loop=$doc.path}
{if $:item.depth|gt(1)}
        {if $:item.url}
<li>
            <a class="path" href={cond( and( $:use_urlalias, is_set( $:item.url_alias ) ), $:item.url_alias,
                                        $:item.url )|ezurl}>{$:item.name|shorten( 35 )|wash}</a>
<i class="fa fa-angle-right"></i>
</li>
        {else}
            {$:item.name|wash}
        {/if}
{/if}
    
    {/section}


</ul>
									</td>
<td class="highlight">

<ul class="page-breadcrumb breadcrumb">
<li>
										<a href="{concat( 'content/download/', $doc.data_map.file.contentobject_id, '/', $doc.data_map.file.id,'/version/', $doc.data_map.file.version , '/file/', $doc.data_map.file.content.original_filename|urlencode )|ezurl( 'no' )}">{$doc.name|wash()}</a>

</li>
</ul>
									</td>
									<td>
<ul class="page-breadcrumb breadcrumb">
<li>
										{$doc.data_map.expirydate.content.timestamp|datetime('custom', '%d %F %Y')}
		
</li>
</ul>							</td>
									
								</tr>


{/foreach}
								
								</tbody>
								</table>

{/if}



						</div>
</div>


