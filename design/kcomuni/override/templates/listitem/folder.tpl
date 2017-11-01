{* Folder - Line view *}



<div class="search-classic">
									<h4><i class="fa fa-folder"></i> <a href={$node.url_alias|ezurl}>{$node.name|wash()}</a></h4>

<ul class="page-breadcrumb breadcrumb">
<li><i class="fa fa-home"></i></li>
{section loop=$node.path}
{if $:item.depth|gt(1)}
        {if $:item.url}
<li>
            <a class="path" href={cond( and( $:use_urlalias, is_set( $:item.url_alias ) ), $:item.url_alias,
                                        $:item.url )|ezurl}>{$:item.name|shorten( 35 )|wash}</a>
<i class="fa fa-angle-right"></i>
</li>
        {else}
            {$:item.name|wash}
        {/if}
{/if}
    
    {/section}

<li><a href={$node.url_alias|ezurl}>{$node.name|wash()}</a></li>
</ul>

									
								</div>
