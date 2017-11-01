<div class="header navbar navbar-inverse navbar-fixed-top">
	<!-- BEGIN TOP NAVIGATION BAR -->
	<div class="header-inner">
		<!-- BEGIN LOGO -->
		<a class="navbar-brand" href="/">
		<img src={"images/logo-comuni.png"|ezdesign} height="50" alt="logo" />
		</a>
		<!-- END LOGO -->

 {if $pagedata.top_menu}
		            {include uri='design:page_topmenu.tpl'}
        		{/if}





		<!-- BEGIN RESPONSIVE MENU TOGGLER -->
		<a href="javascript:;" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
		<img src={"assets/img/menu-toggler.png"|ezdesign} alt=""/>
		</a>
		<!-- END RESPONSIVE MENU TOGGLER -->
		<!-- BEGIN TOP NAVIGATION MENU -->
		<ul class="nav navbar-nav pull-right">
			<!-- BEGIN NOTIFICATION DROPDOWN -->
			<!-- BEGIN USER LOGIN DROPDOWN -->
			
			
		{if $current_user.is_logged_in}
			<li class="dropdown user">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
				
				<span class="username">
					{$user.name|wash}
				</span>
				<i class="fa fa-angle-down"></i>
				</a>
				<ul class="dropdown-menu">
					<li>
						<a href={"user/profile"|ezurl}><i class="fa fa-user"></i> My Profile</a>
					</li>
					
					<li>
						<a href="javascript:;" id="trigger_fullscreen"><i class="fa fa-move"></i> Full Screen</a>
					</li>
					<li>
						<a href={"user/password"|ezurl}><i class="fa fa-lock"></i> Cambia password</a>
					</li>
					<li>
						<a href={"user/logout"|ezurl}><i class="fa fa-key"></i> Log Out</a>
					</li>
				</ul>
			</li>
		{/if}
			<!-- END USER LOGIN DROPDOWN -->
		</ul>
		<!-- END TOP NAVIGATION MENU -->
	</div>
	<!-- END TOP NAVIGATION BAR -->
</div>
<!-- END HEADER -->








