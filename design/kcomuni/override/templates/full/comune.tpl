<h3 class="page-title"><i class="fa fa-home fa-1x"></i> {$node.name}</h3>

{def $page_limit = 24
                     $classes = ezini( 'MenuContentSettings', 'ExtraIdentifierList', 'menu.ini' )
                     $children = array()
                     $children_count = ''}
                     {if $view_parameters.tipo}
					 {set $children_count=fetch_alias( 'children_count', hash( 'parent_node_id', $node.node_id,
                                                                          'class_filter_type', 'include',
                                                                          'class_filter_array', array('pratica' ),
                                                                          'attribute_filter', array(array('pratica/tipo', '=', $view_parameters.tipo), array('pratica/vuota', '<', 1))
                                                                           ))}
                     {else}
                     {set $children_count=fetch_alias( 'children_count', hash( 'parent_node_id', $node.node_id,
                                                                          'class_filter_type', 'include',
                                                                          'class_filter_array', array('pratica' ),
                                                                          'attribute_filter', array(array('pratica/vuota', '<', 1))
                                                                           ))}
                     
                     {/if}


<div class="portlet box red">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-sitemap"></i>Pratiche {if $view_parameters.tipo} - {$view_parameters.tipo} ({$children_count}) {/if}
							</div>
							<div class="tools">
							
							
{if $node.object.can_remove}

<div class="mix-preview">
<div class="form">
<form method="post" name="DeleteNode{$node.object.id}" action={"/content/action"|ezurl} class="form-horizontal">


<input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
<input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
<input type="hidden" name="MoveToTrash" value="0" />
<input type="hidden" name="ActionRemove" value="{'Remove'|i18n('design/standard/node/view')}" />



<button type="submit" class="btn red form-control-inline"><i class="fa fa-trash-o"></i></button>

</form>	</div>
</div>										

{/if}
{if $child.object.can_edit}
<div class="mix-bottom2">
<div class="form">
<form method="post" name="EditNode{$node.object.id}" action={"/content/action"|ezurl} class="form-horizontal">


<input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
<input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
<input type="hidden" name="EditButton" value="{'Edit'|i18n('design/standard/node/view')}" />



<button type="submit" class="btn red form-control-inline"><i class="fa fa-edit"></i></button>

</form>	</div>
</div>	

{/if}
							
							
								<a href="javascript:;" class="collapse"></a>
							</div>
						</div>
						<div class="portlet-body">

					 
                             {if  $children_count}                                            
                                                                          
                                                                          
                 <div class="row mix-grid">

 {if $view_parameters.tipo}
 {foreach fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
								'offset', $view_parameters.offset,
								'sort_by', array(
									array('attribute', false(), 'pratica/year'),
									array('attribute', false(), 'pratica/numberc'),
									array('attribute', false(), 'pratica/number')),
								'class_filter_type', 'include',
								'class_filter_array', array('pratica'),
								'attribute_filter', array(array('pratica/tipo', '=', $view_parameters.tipo),array('pratica/vuota', '<', 1)),
                                                                          
								'limit', $page_limit ) ) as $child }
								
								
								
								{node_view_gui view=line content_node=$child}
								
								
								
								
								
							{/foreach}
 {else}
			{foreach fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
								'offset', $view_parameters.offset,
								'sort_by', array(
									array('attribute', false(), 'pratica/year'),
									array('attribute', false(), 'pratica/numberc'),
									array('attribute', false(), 'pratica/number')),
								'class_filter_type', 'include',
								'class_filter_array', array('pratica'),
								'attribute_filter', array(array('pratica/vuota', '<', 1)),
								'limit', $page_limit ) ) as $child }
								
								
								
								{node_view_gui view=line content_node=$child}
								
								
								
								
								
							{/foreach}
{/if}							
		
									</div>
								




                        
                    {/if}
            

                {include name=navigator
                         uri='design:navigator/google.tpl'
                         page_uri=$node.url_alias
                         item_count=$children_count
                         view_parameters=$view_parameters
                         item_limit=$page_limit}
                                                       
                                                                          
                                                                          
                                                                          
                                                                          
                                                                          



						</div>
						
</div>




