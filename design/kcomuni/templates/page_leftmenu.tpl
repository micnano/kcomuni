
	<!-- BEGIN EMPTY PAGE SIDEBAR -->
	<div class="page-sidebar-wrapper">
		<div class="page-sidebar navbar-collapse collapse">
			<!-- BEGIN SIDEBAR MENU -->
			<ul class="page-sidebar-menu">
				<li class="sidebar-toggler-wrapper">
					<!-- BEGIN SIDEBAR TOGGLER BUTTON -->
					<div class="sidebar-toggler hidden-phone">
					</div>
					<!-- BEGIN SIDEBAR TOGGLER BUTTON -->
				</li>
				{if $current_node.depth|ge(2)}
				<li class="sidebar-search-wrapper">
					<!-- BEGIN RESPONSIVE QUICK SEARCH FORM -->
					<form class="sidebar-search" action="/content/search" method="GET">
						{if $current_node.path.[2].node_id}
						<input type="hidden" name="PathId" value="{$current_node.path.[2].node_id}"/>						
						{elseif $current_node.path.[1].node_id}
						<input type="hidden" name="PathId" value="{$current_node.path.[1].node_id}"/>
						{else}
						<input type="hidden" name="PathId" value="{$current_node.node_id}"/>
						{/if}
						<div class="form-container">
							<div class="input-box">
								<a href="javascript:;" class="remove"></a>
								<input type="text" name="SearchText" placeholder="Cerca"/>
								<input type="button" class="submit" value=" "/>
							</div>
						</div>
					</form>
					<!-- END RESPONSIVE QUICK SEARCH FORM -->
				</li>
				{/if}
			<li class="active">
				<a href="javascript:;">
					<i class="fa fa-home"></i>
					<span class="title">
						Comuni
					</span>
					<span class="arrow open">
					</span>
					</a>
						{include uri=concat('design:menu/', $pagedata.left_menu, '.tpl')}
				
			</li>
		
		</ul>
	</div>
</div>
	<!-- END EMPTY PAGE SIDEBAR -->

