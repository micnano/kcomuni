
<h3 class="page-title"><i class="fa fa-folder-open fa-1x"></i> {$node.name}</h3>

<div class="portlet box red">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-sitemap"></i>Contenuto
							</div>
							<div class="tools">
								<a href="javascript:;" class="collapse"></a>
							</div>
						</div>
						<div class="portlet-body">

					 {def $page_limit = 36
                     $classes = ezini( 'MenuContentSettings', 'ExtraIdentifierList', 'menu.ini' )
                     $children = array()
                     $children_count = ''}
					 {set $children_count=fetch_alias( 'children_count', hash( 'parent_node_id', $node.node_id,
                                                                          'class_filter_type', 'exclude',
                                                                          'class_filter_array', $classes ) )}
                             {if  $children_count}                                            
                                                                          
                                                                          
                 <div class="row mix-grid">

{def $num=0}
			{foreach fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
								'offset', $view_parameters.offset,
								'sort_by', array('priority', true()),
								'class_filter_type', 'include',
								'class_filter_array', array('file','folder','area','actor'),
								'limit', $page_limit ) ) as $child }
								
								{set $num=$num|inc(1)}
								
								{node_view_gui view=line content_node=$child}
								
								{if $num|eq(6)}
								<div class="clearfix"></div>
								{set $num=0}
								{/if}
								
								
								
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
                                                                          
                                                                          
                                                                          
                                                                          
                                                                          



						</div>
						
</div>					




