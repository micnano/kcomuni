
<form action={"/content/search/"|ezurl} method="get" class="form-inline">
<h3 class="page-title">
				<i class="fa fa-search fa-1x"></i> Cerca</h3>
							<div class="row search-form-default">
									<div class="col-md-12">
										
											<div class="input-group">
												<div class="input-cont">
												
													<input type="text" placeholder="Cerca..." class="form-control"  name="SearchText" id="Search" value="{$search_text|wash}"/>
												</div>
												<span class="input-group-btn">
<input class="hidden" name="SearchButton" value="SearchButton" />
{if ezhttp_hasvariable( 'PathId', 'get' )}
<input type="hidden" name="PathId" value="{ezhttp( 'PathId', 'post' )}"/>
{/if}
													<button type="submit" class="btn red">
													Cerca &nbsp; <i class="m-icon-swapright m-icon-white"></i>
													</button>
												</span>
											</div>
										
									</div>
								</div>		
</form>

