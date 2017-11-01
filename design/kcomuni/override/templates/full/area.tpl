<h3 class="page-title"><i class="fa fa-user fa-1x"></i> {$node.name}</h3>








<div class="portlet box red">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-sitemap"></i>Pratiche correlate
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
					 {set $children_count=fetch('content', 'reverse_related_objects_count',  hash('object_id', $node.object.id, 'attribute_identifier', 'pratica/area'))}
                             {if  $children_count}                                            
                                                                          
                                                                          
                 <div class="row mix-grid">
					{def $num=0}

			{foreach fetch('content', 'reverse_related_objects',  hash('object_id', $node.object.id, 'attribute_identifier', 'pratica/area', 'sort_by', array('name',false()))) as $child }
								
								{set $num=$num|inc(1)}
								
								{node_view_gui view=line content_node=$child.main_node}
								
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





