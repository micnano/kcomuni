

<div class="col-md-2 mix">
											<div class="mix-inner">
											{$node.name}
												
											</div>



<div class="row">




{if $node.object.can_edit}
<div class="col-md-2 col-sm-3">
<form method="post" action={"content/action/"|ezurl}>
<div class="form-container">
<button type="submit" class="btn ic-button" title="sposta">
<i class="fa fa-edit fa-lg"></i>							</button>
						
						<input type="hidden" name="EditButton" value="EditButton" />
						
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


<div class="clearfix"></div>
</div>
<br/>
</div>

