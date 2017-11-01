<div class="hor-menu hidden-sm hidden-xs">
			<ul class="nav navbar-nav">
{if $module_result.path|count()|ge(2)}
					<li{if $current_node_id|eq($module_result.path.[1].node_id)} class="active"{/if}>{if $current_node_id|eq($module_result.path.[1].node_id)}<span class="selected"></span>{/if}<a href="/">{$module_result.path.[1].text}</a></li>


{def $root_node = fetch( 'content', 'node', hash( 'node_id', $module_result.path.[1].node_id ) )}
{else}		
{def $root_node = arra()}
{/if}       

{def  $top_menu_class_filter = ezini( 'MenuContentSettings', 'TopIdentifierList', 'menu.ini' )
             $top_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
                                                               'sort_by', $root_node.sort_array,
                                                               'class_filter_type', 'include',
                                                               'class_filter_array', $top_menu_class_filter ) )
             $top_menu_items_count = $top_menu_items|count()
             $item_class = array()
              $li_class = array()
		$dataadd=""
		$selspan = ""
		$selicon = ""
		$a_class = array()
             $level_2_items = array()
             $current_node_in_path = first_set($pagedata.path_array[1].node_id, 0  )
             $current_node_in_path_2 = first_set($pagedata.path_array[2].node_id, 0  )
             $current_node_in_path_3 = first_set($pagedata.path_array[3].node_id, 0  )
             $current_node_in_path_4 = first_set($pagedata.path_array[4].node_id, 0  )}

        {if $top_menu_items_count}
           {foreach $top_menu_items as $key => $item}
		   {set $a_class = array()}
                   {set $item_class = array()}
                {if $current_node_in_path|eq($item.node_id)}
                    {set $item_class = array("active")
			
			$selspan = "<span class=\"selected\"></span>"
			
			
                         $level_2_items = fetch( 'content', 'list', hash( 'parent_node_id', $item.node_id,
                                                                          'sort_by', $item.sort_array,
                                                                          'class_filter_type', 'include',
                                                                          'class_filter_array', $top_menu_class_filter ) )}
			
                {/if}
					
				  
				
                
                
                {if $item.node_id|eq( $current_node_id )}
               		 {set $item_class = $item_class|append("active")}
                     
                {/if}
                
                {def $sub_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $item.node_id,
                                                                      'sort_by', $item.sort_array,
                                                                      'load_data_map', false(),
                                                                      'class_filter_type', 'include',
                                                                      'class_filter_array', ezini( 'MenuContentSettings', 'LeftIdentifierList', 'menu.ini' ) ) )
                     $sub_menu_items_count = $sub_menu_items|count}
                {if $sub_menu_items_count}
                	{set $item_class = $item_class|append("dropdown-menu")}
                	{set $a_class = $a_class|append("dropdown-toggle")}
			    
			     
                {/if}
                
                

                {if eq( $item.class_identifier, 'link')}
                    <li id="node_id_{$item.node_id}"{if $item_class} class="{$item_class|implode(" ")}"{/if}><a {if eq( $ui_context, 'browse' )}href={concat("content/browse/", $item.node_id)|ezurl}{else}href={$item.data_map.location.content|ezurl}{if and( is_set( $item.data_map.open_in_new_window ), $item.data_map.open_in_new_window.data_int )} target="_blank"{/if}{/if}{if $pagedata.is_edit} onclick="return false;"{/if} title="{$item.data_map.location.data_text|wash}" {if $a_class} class="{$a_class|implode(" ")}"{/if} rel={$item.url_alias|ezurl}>{if $item.data_map.location.data_text}{$item.data_map.location.data_text|wash()}{else}{$item.name|wash()}{/if}</a>
                {else}
                    <li id="node_id_{$item.node_id}"{if $item_class} class="{$item_class|implode(" ")}"{/if}><a{if $sub_menu_items_count} data-toggle="dropdown" data-hover="dropdown" data-close-others="true"  href="javascript:;"{else}href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $item.node_id)|ezurl}{else}{$item.url_alias|ezurl}{/if}{/if} {if $a_class} class="{$a_class|implode(" ")}"{/if}{if $pagedata.is_edit} onclick="return false;"{/if}>{$item.name|wash()}{if $sub_menu_items_count}<i class=\"fa fa-angle-down\"></i>{/if}</a>
                {/if}
				
				

                {if $sub_menu_items_count}
				
                <ul class="dropdown-menu">
                    {foreach $sub_menu_items as $subkey => $subitem}
												{set $a_class = array()}
												{set $li_class = array()}
                        {set $a_class = cond($current_node_in_path_3|eq($subitem.node_id), array("active"), array())}
                    		{if $sub_menu_items_count|eq( $subkey|inc )}
                        {set $li_class = $li_class|append("lastli")}
                    {/if}
                    {if $subitem.node_id|eq( $current_node_id )}
                        
                    {/if}
                    
                    
                    
                    {def $sub_menu_items2 = fetch( 'content', 'list', hash( 'parent_node_id', $subitem.node_id,
                                                                      'sort_by', $subitem.sort_array,
                                                                      'load_data_map', false(),
                                                                      'class_filter_type', 'include',
                                                                      'class_filter_array', ezini( 'MenuContentSettings', 'LeftIdentifierList', 'menu.ini' ) ) )
                     $sub_menu_items_count2 = $sub_menu_items2|count}

                    {if $sub_menu_items_count2}
                    {set $li_class = $li_class|append("dropdown-submenu")}
			{/if}
                    
                    
                    {if eq( $subitem.class_identifier, 'link')}
                        <li{if $li_class} class="{$li_class|implode(" ")}"{/if}><a {if eq( $ui_context, 'browse' )}href={concat("content/browse/", $subitem.node_id)|ezurl}{else}href={$subitem.data_map.location.content|ezurl}{if and( is_set( $subitem.data_map.open_in_new_window ), $subitem.data_map.open_in_new_window.data_int )} target="_blank"{/if}{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if} title="{$subitem.data_map.location.data_text|wash}" {if $item_class} class="{$item_class|implode(" ")}"{/if} rel={$subitem.url_alias|ezurl}>{if $subitem.data_map.location.data_text}{$subitem.data_map.location.data_text|wash()}{else}{$subitem.name|wash()}{/if}</a>
                    {else}
                        <li class="{if $li_class}{$li_class|implode(" ")} {/if}"><a {if $sub_menu_items_count2} href="javascript:;"{else}href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $subitem.node_id)|ezurl}{else}{$subitem.url_alias|ezurl}{/if}{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if}>{$subitem.name|wash()}{if $sub_menu_items_count}<i class=\"fa fa-angle-down\"></i>{/if}</a>
                    {/if}
                    
                     {if $sub_menu_items_count2}
													
                <ul class="dropdown-menu">
                    {foreach $sub_menu_items2 as $subkey2 => $subitem2}
					{set $a_class = array()}
                       {set $a_class = cond($current_node_in_path_4|eq($subitem2.node_id), array("active"), array())
                         $li_class = cond( $subkey2|eq(0), array("firstli"), array() )}
                    {if $sub_menu_items_count2|eq( $subkey2|inc )}
                        {set $li_class = $li_class|append("lastli")}
                    {/if}
                    {if $subitem2.node_id|eq( $current_node_id )}
                    {set $li_class = $item_class|append("dropdown")}
                	{set $li_class = $item_class|append("submenu")}
                        
                    {/if}
                     
                    {if eq( $subitem2.class_identifier, 'link')}
                        <li{if $li_class} class="{$li_class|implode(" ")}"{/if}><a {if eq( $ui_context, 'browse' )}href={concat("content/browse/", $subitem2.node_id)|ezurl}{else}href={$subitem2.data_map.location.content|ezurl}{if and( is_set( $subitem.data_map.open_in_new_window ), $subitem2.data_map.open_in_new_window.data_int )} target="_blank"{/if}{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if} title="{$subitem2.data_map.location.data_text|wash}" {if $item_class} class="{$item_class|implode(" ")}"{/if} rel={$subitem2.url_alias|ezurl}>{if $subitem2.data_map.location.data_text}{$subitem2.data_map.location.data_text|wash()}{else}{$subitem2.name|wash()}{/if}</a></li>
                    {else}
                        <li{if $li_class} class="{$li_class|implode(" ")}"{/if}><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $subitem2.node_id)|ezurl}{else}{$subitem2.url_alias|ezurl}{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if}>{$subitem2.name|wash()}</a></li>
                    {/if}
                    
                    
                    
                         {/foreach}
                </ul>
                {/if}{undef $sub_menu_item2s $sub_menu_items_count2}
                    </li>
                    
                    {/foreach}
                </ul>
                {/if}
            {undef $sub_menu_items $sub_menu_items_count}
            
				
				
				
				
				
				</li>
				
            {/foreach}
        {/if}
        </ul>
</div>
