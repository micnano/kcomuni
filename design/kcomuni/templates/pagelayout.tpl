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
{cache-block keys=array($view_parameters.tipo)}

{cache-block keys=array( $module_result.uri, $basket_is_empty, $current_user.contentobject_id, $extra_cache_key )}
{def $pagestyle        = $pagedata.css_classes
     $locales          = fetch( 'content', 'translation_list' )
     $current_node_id  = $pagedata.node_id
     $current_node = fetch('content','node', hash('node_id', $current_node_id))}

<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<meta name="MobileOptimized" content="320">

{include uri='design:page_head.tpl'}
{include uri='design:page_head_style.tpl'}
{include uri='design:page_head_script.tpl'}


</head>
<body  class="page-header-fixed">



<!-- Complete page area: START -->



    {if and( is_set( $pagedata.persistent_variable.extra_template_list ),
             $pagedata.persistent_variable.extra_template_list|count() )}
    {foreach $pagedata.persistent_variable.extra_template_list as $extra_template}
        {include uri=concat('design:extra/', $extra_template)}
    {/foreach}
    {/if}

    <!-- Header area: START -->
    {include uri='design:page_header.tpl'}
    <!-- Header area: END -->

    {cache-block keys=array( $module_result.uri, $user_hash, $extra_cache_key )}


        <!-- Top menu area: START -->
        <!-- Top menu area: END -->

        <!-- Path area: START -->
        {*if $pagedata.show_path}
            {include uri='design:page_toppath.tpl'}
        {/if*}
        <!-- Path area: END -->


    <!-- Toolbar area: START -->

    <!-- Toolbar area: END -->

    <!-- Columns area: START -->
<div class="clearfix">
</div>
<!-- BEGIN CONTAINER -->
<div class="page-container">
            <!-- Side menu area: START -->
          
                {include uri='design:page_leftmenu.tpl'}
        
            <!-- Side menu area: END -->

<div class="page-content-wrapper">
		<div class="page-content">

     {if $pagedata.show_path}
      
<div class="row">
				<div class="col-md-12">
{include uri="design:page_toppath.tpl"}
					
					<!-- END PAGE TITLE & BREADCRUMB-->
				</div>
</div>
{/if}
{/cache-block}

    {/cache-block}
    {/cache-block}



<div class="row">
				<div class="col-md-12">
            <!-- Main area: START -->
            {include uri='design:page_mainarea.tpl'}
            <!-- Main area: END -->
            {cache-block keys=array( $module_result.uri, $user_hash, $access_type.name, $extra_cache_key )}



            <!-- Extra area: START -->
            {if $pagedata.extra_menu}
                {include uri='design:page_extramenu.tpl'}
            {/if}
		</div>
</div>

</div>
            <!-- Extra area: END -->

    <!-- Columns area: END -->

    <!-- Footer area: START -->
    {include uri='design:page_footer.tpl'}
    <!-- Footer area: END -->

</div>
<!-- Complete page area: END -->

<!-- Footer script area: START -->
{include uri='design:page_footer_script.tpl'}
<!-- Footer script area: END -->

{/cache-block}

{* This comment will be replaced with actual debug report (if debug is on). *}
<!--DEBUG_REPORT-->
</body>
</html>
