<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="{$site.http_equiv.Content-language|wash}"><!--<![endif]-->
<head>
{def $basket_is_empty   = cond( $current_user.is_logged_in, fetch( shop, basket ).is_empty, 1 )
     $user_hash         = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}

{include uri='design:page_head_displaystyles.tpl'}

{if is_set( $extra_cache_key )|not}
    {def $extra_cache_key = ''}
{/if}

{def $pagedata        = ezpagedata()
     

	$inner_column_size = $pagedata.inner_column_size
     $outer_column_size = $pagedata.outer_column_size}


{cache-block keys=array( $module_result.uri, $basket_is_empty, $current_user.contentobject_id, $extra_cache_key )}
{def $pagestyle        = $pagedata.css_classes
     $locales          = fetch( 'content', 'translation_list' )
     $current_node_id  = $pagedata.node_id}

<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<meta name="MobileOptimized" content="320">

{include uri='design:page_head.tpl'}
{include uri='design:page_head_style.tpl'}
<link href={"assets/css/pages/login.css"|ezdesign} rel="stylesheet" type="text/css"/>

</head>
<body class="login">



<!-- Complete page area: START -->


    {if and( is_set( $pagedata.persistent_variable.extra_template_list ),
             $pagedata.persistent_variable.extra_template_list|count() )}
    {foreach $pagedata.persistent_variable.extra_template_list as $extra_template}
        {include uri=concat('design:extra/', $extra_template)}
    {/foreach}
    {/if}

    <!-- Header area: START -->
  
    <!-- Header area: END -->

    {cache-block keys=array( $module_result.uri, $user_hash, $extra_cache_key )}

   

        <!-- Path area: END -->
   

    <!-- Toolbar area: START -->

    <!-- Toolbar area: END -->

    <!-- Columns area: START -->

            <!-- Side menu area: START -->
<div class="logo">
	<img src={"images/logo-comuni.png"|ezdesign} height="60" alt=""/>
</div>
<!-- END LOGO -->
<!-- BEGIN LOGIN -->
<div class="content">
	<!-- BEGIN LOGIN FORM -->
	<form method="post" class="login-form" action={"/user/login/"|ezurl} name="loginform">
		<h3 class="form-title">Entra nell'area di gestione</h3>
		{if $User:warning.bad_login}
<div class="warning">
<h4>{"Could not login"|i18n("design/ezdemo/user/login")}</h4>
<ul>
    <li>{"A valid username and password is required to login."|i18n("design/ezdemo/user/login")}</li>
</ul>
</div>
{else}

{if $site_access.allowed|not}
<div class="warning">
<h4>{"Access not allowed"|i18n("design/ezdemo/user/login")}</h4>
<ul>
    <li>{"You are not allowed to access %1."|i18n("design/ezdemo/user/login",,array($site_access.name))}</li>
</ul>
</div>
{/if}

{/if}
		<div class="alert alert-danger display-hide">
			<button class="close" data-close="alert"></button>
			<span>
				 Inserisci nome utente e password
			</span>
		</div>
		<div class="form-group">
			<!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
			<label class="control-label visible-ie8 visible-ie9">Nome utente</label>
			<div class="input-icon">
				<i class="fa fa-user"></i>
				<input class="form-control placeholder-no-fix" type="text" autocomplete="off" placeholder="Nome utente"  name="Login"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label visible-ie8 visible-ie9">Password</label>
			<div class="input-icon">
				<i class="fa fa-lock"></i>
				<input class="form-control placeholder-no-fix" type="password" autocomplete="off" placeholder="Password"name="Password"/>
			</div>
		</div>
		<div class="form-actions">
			<input type="hidden" name="LoginButton" value="LoginButton"/>
			<button type="submit" class="btn green pull-right">
			Login <i class="m-icon-swapright m-icon-white"></i>
			</button>
		</div>
		
	</form>
</div>
	<!-- END LOGIN FORM -->
    {/cache-block}
    {/cache-block}
            
            <!-- Main area: END -->
            {cache-block keys=array( $module_result.uri, $user_hash, $access_type.name, $extra_cache_key )}

           

    <!-- Columns area: END -->
<div class="copyright">
	 Powered by <a href="http://ez.no/ezpublish" title="eZ Publish&#8482; CMS Open Source Web Content Management">eZ Publish&#8482; CMS Open Source Web Content Management</a>.
</div>
    <!-- Footer area: START -->
   
    <!-- Footer area: END -->


<!-- Complete page area: END -->

<!-- Footer script area: START -->
{include uri='design:page_footer_script.tpl'}
<!-- Footer script area: END -->

{/cache-block}

{* This comment will be replaced with actual debug report (if debug is on). *}
<!--DEBUG_REPORT-->
</body>
</html>
