

<div class="col-md-2 mix">
											<div class="mix-inner">
												{if $node.data_map.preview.has_content}
											<a class="fancybox-button" data-rel="fancybox-button" href="/{$node.data_map.preview.content['original'].full_path}">	<img class="img-responsive" src="/{$node.data_map.preview.content.[medium].full_path}" alt=""></a>
 {/if}
												
											</div>



<div class="row">
{if $node.data_map.file.content.mime_type|eq("application/pdf")}
<div class="col-md-3 col-sm-4">
<a href="http://flex.kine.coop/php/simple_document.php?subfolder=&doc={$node.data_map.file.content.filename}{if $q}&q={$q|wash()}{/if}" target="_blank">
<i class="fa fa-html5 fa-lg"></i>
</a>
</div>

{/if}

{def $attribute = $node.data_map.file}
<div class="col-md-3 col-sm-4">
<a href={concat( 'content/download/', $attribute.contentobject_id, '/', $attribute.id,'/version/', $attribute.version , '/file/', $attribute.content.original_filename|urlencode )|ezurl} target="_blank">
<i class="fa fa-download fa-lg"></i>
</a>
</div>
<div class="clearfix"></div>
</div>
<br/>
</div>

