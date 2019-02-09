

<div class="col-md-2 mix">
											<div class="mix-inner">
												{if $node.data_map.preview.has_content}
											<a class="fancybox-button" data-rel="fancybox-button" href="/{$node.data_map.preview.content['original'].full_path}">	<img class="img-responsive" src="/{$node.data_map.preview.content.[medium].full_path}" alt=""></a>
 {/if}
												
											</div>



<div class="row">
{if $node.data_map.file.content.mime_type|eq("application/pdf")}
<div class="col-md-2 col-sm-3">
<a title="visualizza" href="http://flex.kine.coop/php/simple_document.php?subfolder=&doc={$node.data_map.file.content.filename}{if $q}&q={$q|wash()}{/if}" target="_blank">
<i class="fa fa-html5 fa-lg"></i>
</a>
</div>

{/if}

{def $attribute = $node.data_map.file}
<div class="col-md-2 col-sm-3">
<a title="scarica" href={concat( 'content/download/', $attribute.contentobject_id, '/', $attribute.id,'/version/', $attribute.version , '/file/', $attribute.content.original_filename|urlencode )|ezurl} target="_blank">
<i class="fa fa-download fa-lg"></i>
</a>
</div>
{if $node.object.can_move}
<div class="col-md-2 col-sm-3">
<form method="post" action={"content/action/"|ezurl}>
<div class="form-container">
<button type="submit" class="btn ic-button" title="sposta">
<i class="fa fa-arrow-up fa-lg"></i>							</button>
						
						<input type="hidden" name="MoveNodeButton" value="MoveNodeButton" />
						<input type="hidden" name="TopLevelNode" value="{$node.node_id}">
						<input type="hidden" name="ContentNodeID" value="{$node.node_id}">
						<input type="hidden" name="ContentObjectID" value="{$node.object.id}"></div>
					</form>


</div>
{/if}

{if $node.object.can_remove}
<div class="col-md-2 col-sm-3">
<form method="post" action={"content/action/"|ezurl}>
<div class="form-container">
<button type="submit" class="btn ic-button" title="elimina">
<i class="fa fa-trash fa-lg"></i>							</button>
						
						<input type="hidden" name="ActionRemove" value="ActionRemove" />
						<input type="hidden" name="TopLevelNode" value="{$node.node_id}">
						<input type="hidden" name="ContentNodeID" value="{$node.node_id}">
						<input type="hidden" name="ContentObjectID" value="{$node.object.id}"></div>
					</form>


</div>
{/if}

<div class="col-md-2 col-sm-3">
<input type="checkbox" name="idtodownload[]" class="idtodownload" value="{$node.object.id}" />
</div>

<div class="clearfix"></div>
</div>
<br/>
</div>

