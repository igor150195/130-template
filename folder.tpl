{if isset($smarty.get.p)}
	{assign var="pn" value="PAGE_TITLE_PAGES"|cat:$p+1}
{/if}

{if $site.settings.seo_fields}

	{if $page.seo_title}
		{assign_hash var=page.title value="`$page.seo_title` `$pn`"}
	{else}
		{assign_hash var=page.title value="`$folder.folder_name` `$pn`"}
	{/if}

	{if $page.seo_keywords}
		{assign_hash var=page.keywords value="`$page.seo_keywords` `$pn`"}
	{else}
		{assign_hash var=page.keywords value="`$folder.folder_name` `$pn`"}
	{/if}

	{if $page.seo_description}
		{assign_hash var=page.description value="`$page.seo_description` `$pn`"}
	{else}
		{assign_hash var=page.description value="`$folder.folder_name` `$pn`"}
	{/if}

{else}

	{assign_hash var=page.title value="`$folder.folder_name` `$pn`"}
	{assign_hash var=page.keywords value="`$folder.folder_name` `$pn`"}
	{assign_hash var=page.description value="`$folder.folder_name` `$pn`"}

{/if}

{assign var="h1" value=$page.seo_h1|default:$folder.folder_name}

{if $smarty.get.products_only == 1}

	{include file="global:shop2.v2-product-list.tpl"}
	{include file="global:shop2.v2-pagelist.tpl"}

{else}

	{if !isset($smarty.get.p) && $folder.folder_desc}
		<div class="folder-desc-top">
			{$folder.folder_desc}
		</div>
	{/if}
	
	{if $shop2.my.gr_filter_extra_wrapper}
		<div class="filter-extra-wrapper">
			<div class="filter-extra-wrap">
	{/if}
	
	{assign var=gr_filter_version value=$shop2.my.gr_filter_version|default:'global:shop2.v2-filter.tpl'}
	{include file=$gr_filter_version gr_sorting_no_filter=$shop2.my.gr_sorting_no_filter}
	
	{if $shop2.my.gr_filter_extra_wrapper}
			</div>
		</div>
	{/if}

	{include file="global:shop2.v2-product-list.tpl"}
	{include file="global:shop2.v2-pagelist.tpl"}

	{if !isset($smarty.get.p) && $folder.folder_desc2}
		<div class="folder-desc-bottom">
			{$folder.folder_desc2}
		</div>
	{/if}

{/if}