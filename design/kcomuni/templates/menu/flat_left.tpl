{def $left_menu_depth = $pagedata.current_menu|eq('LeftOnly')|choose( 1, 0 )
     $left_menu_root_url = cond( $pagedata.path_array[$left_menu_depth].url_alias, $pagedata.path_array[$left_menu_depth].url_alias, $requested_uri_string )}



{if ne( $pagedata.class_identifier, 'wiki_page' )}
    {def $root_node=fetch( 'content', 'node', hash( 'node_id', $pagedata.path_array[0].node_id ) )
         $left_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
                                                            'sort_by', $root_node.sort_array,
                                                            'load_data_map', false(),
                                                            'class_filter_type', 'include',
                                                            'class_filter_array', ezini( 'MenuContentSettings', 'LeftIdentifierList', 'menu.ini' ) ) )
         $left_menu_items_count = $left_menu_items|count()
         $li_class = array()
         $a_class = array() 
         $current_node_in_path_2 = first_set( $pagedata.path_array[$left_menu_depth|inc].node_id,  0 )
         $current_node_in_path_3 = first_set( $pagedata.path_array[$left_menu_depth|sum(2)].node_id,  0 )}

    {if $left_menu_items_count}
        <ul class="sub-menu">
        {foreach $left_menu_items as $key => $item}
            {set $a_class = cond($current_node_in_path_2|eq($item.node_id), array("selected"), array())
                 $li_class = cond( $key|eq(0), array("firstli"), array() )}

            {if $left_menu_items_count|eq( $key|inc )}
                {set $li_class = $li_class|append("lastli")}
            {/if}
            {if $item.node_id|eq( $current_node_id )}
                {set $a_class = $a_class|append("current")}
            {/if}

	    {if $pagedata.path_array[1].node_id|eq($item.node_id)}
		{set $li_class = $li_class|append("active")}

	    {/if}
            {if eq( $item.class_identifier, 'link')}
                <li{if $li_class} class="{$li_class|implode(" ")}"{/if}><div class="second_level_menu"><a {if eq( $ui_context, 'browse' )}href={concat("content/browse/", $item.node_id)|ezurl}{else}href={$item.data_map.location.content|ezurl}{if and( is_set( $item.data_map.open_in_new_window ), $item.data_map.open_in_new_window.data_int )} target="_blank"{/if}{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if} title="{$item.data_map.location.data_text|wash}" class="menu-item-link" rel={$item.url_alias|ezurl}>{if $item.data_map.location.data_text}{$item.data_map.location.data_text|wash()}{else}{$item.name|wash()}{/if}</a></div>
            {else}
                <li{if $li_class} class="{$li_class|implode(" ")}"{/if}><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $item.node_id)|ezurl}{else}{$item.url_alias|ezurl}{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if}>{$item.name|wash()}</a>
            {/if}
			
            {if eq( $current_node.node_id, $item.node_id )}
                {def $baseURI= $current_node.url_alias}
			
			
			{def $itemst = fetch(ezfind, search, hash( 'query', '', 'subtree_array', array( $current_node.node_id ), 'facet', array( hash( 'field','pratica/tipo', 'limit', 50, 'sort', 'alpha'  ) )))}
			  
			  
			  {def $search_extras=$itemst['SearchExtras']}
			 {def $facetData=$search_extras.['facet_fields'].[0].['countList']}
			
				<ul class="sub-menu">
				
                  {foreach $facetData as $key2 => $facetCount}
                 {if and($key2|ne('P.f.'),$key2|ne('P.ed.'),$key2|ne('P.M.'),$key2|ne(''))}
                     <li {if $key2|eq($module_result.view_parameters.tipo)} class="active"{/if}>
                              <a {if $key2|eq($module_result.view_parameters.tipo)} class="current"{/if} href={concat( $baseURI, '/(tipo)/',$key2)|ezurl}>{$key2|trim('"')|wash} {*({$facetData.countList[$key2]})*}</a>
                      </li>
                   {/if}
                  {/foreach}
                  {undef $facetData}
			
				</ul>
            {/if}
            </li>
        {/foreach}
        </ul>
    {/if}
    {undef $root_node $left_menu_items $left_menu_items_count $a_class $li_class $current_node_in_path_2 $current_node_in_path_3}
{else}

    <div class="contentstructure">
    {def $current_node         = fetch( content, node, hash( node_id, $current_node_id ) )
         $chapter_container    = fetch( content, node, hash( node_id, $current_node.path_array[$left_menu_depth|inc] ) )
         $class_filter         = ezini( 'TreeMenu', 'ShowClasses', 'contentstructuremenu.ini' )
         $depth                = is_set( $current_node.path_array[$left_menu_depth|sum(2)] )|choose( $left_menu_depth|sum(3), 0 )
         $node_to_unfold       = is_set( $current_node.path_array[$left_menu_depth|sum(2)] )|choose(0 , $current_node.path_array[$left_menu_depth|sum(2)] )
         $contentStructureTree = content_structure_tree( $chapter_container.node_id, $class_filter, $depth, 0, 'false', false(), $node_to_unfold )}

    {include uri='design:simplified_treemenu/show_simplified_menu.tpl' contentStructureTree=$contentStructureTree is_root_node=true() skip_self_node=true() current_node_id=$current_node_id unfold_node=$node_to_unfold chapter_level=0}

    {undef $current_node $chapter_container $class_filter $depth $node_to_unfold $contentStructureTree}
    </div>
{/if}

{undef $left_menu_root_url $left_menu_depth}
