<h3 class="page-title"><i class="fa fa-folder-open fa-1x"></i> {$node.name}</h3>

{attribute_view_gui attribute=$node.data_map.description}


<h3>Informazioni</h3>
<div class="row">

<div class="col-md-3">
	


<div class="dashboard-stat red">
	<div class="visual">
		<i class="fa fa-area-chart"></i>
	</div>
	<div class="details">
		<div class="number">Particelle</div>
		<div class="desc">
		{def $nodea = array()}
		{foreach $node.data_map.area.content.relation_list as $part}
			{set $nodea = fetch('content', 'node', hash('node_id', $part.node_id))}
			<a href={$nodea.url_alias|ezurl}>{$nodea.name}</a><br/>
		{/foreach}
		</div>
	</div>
	
</div>
</div>


<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
<div class="dashboard-stat red">
	<div class="visual">
		<i class="fa fa-home"></i>
	</div>
	<div class="details">
		<div class="number">P.m.</div>
		<div class="desc">{attribute_view_gui attribute=$node.data_map.pm}</div>
	</div>
	
</div>
</div> 

<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
<div class="dashboard-stat red">
	<div class="visual">
		<i class="fa fa-building"></i>
	</div>
	<div class="details">
		<div class="number">C.c.</div>
		<div class="desc">{attribute_view_gui attribute=$node.data_map.cc}</div>
	</div>
	
</div>
</div> 




<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
<div class="dashboard-stat red">
	<div class="visual">
		<i class="fa fa-user"></i>
	</div>
	<div class="details">
		<div class="number">Richiedenti</div>
		<div class="desc">{attribute_view_gui attribute=$node.data_map.actors}</div>
	</div>
	
</div>
					
  </div>   

                                                               
                                                                          
                                                                          



</div>


<div class="portlet box red">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-sitemap"></i>Documenti
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
								'class_filter_array', array('file','folder'),
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





