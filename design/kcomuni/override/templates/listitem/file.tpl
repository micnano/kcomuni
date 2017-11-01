{* File - Line view *}



<div class="search-classic">
								

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

<li><a href="http://flex.kine.coop/php/simple_document.php?subfolder=&doc={$node.data_map.file.content.filename}" target="_blank">{$node.data_map.file.content.original_filename}</a>{$node.data_map.file.content.filesize|si( byte )}</li>
</ul>

									
								</div>
