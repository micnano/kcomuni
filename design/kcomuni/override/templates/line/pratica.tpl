{def $childs = fetch('content', 'list', hash('parent_node_id', $node.node_id, 'class_filter_type', 'include', 'sort_by', array('priority', true()), 'class_filter_array', array('file'), 'limit', 1))}

<div class="col-md-2 mix">
											<div class="mix-inner">
												

												

{if $childs.[0].data_map.preview.has_content}
<a class="fancybox-button" data-rel="fancybox-button" href="/{$childs.[0].data_map.preview.content.['original'].full_path}"><img class="img-responsive" src="/{$childs.[0].data_map.preview.content.['medium'].full_path}" alt=""></a>
{else}
<a href={$node.url_alias|ezurl()}><img class="img-responsive" src={"images/faldone.jpg"|ezdesign} alt=""> </a>

{/if}



<div class="clearfix"></div>
												
											</div>
<a href={$node.url_alias|ezurl()}>{$node.name|wash}</a>
										</div>

