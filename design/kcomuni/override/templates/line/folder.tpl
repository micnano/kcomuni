{def $childs = fetch('content', 'list', hash('parent_node_id', $node.node_id, 'class_filter_type', 'include', 'sort_by', array('priority', true()), 'class_filter_array', array('file'), 'limit', 1))}

<div class="col-md-2 col-sm-4 mix">
											<div class="mix-inner">
												{if $childs}
											<a class="fancybox-button" data-rel="fancybox-button" href="/{$childs.[0].data_map.preview.content.['original'].full_path}">	<img class="img-responsive" src="/{$childs.[0].data_map.preview.content.[medium].full_path}" alt=""></a>
 {/if}
												
											</div>
<a href={$node.url_alias|ezurl()} style="color:#FF0000"><i class="fa fa-folder fa-1x"></i> {$node.name|wash}</a>
										</div>

