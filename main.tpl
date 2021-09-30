{if $smarty.get.products_only == 1}
	
	{include file="global:shop2.v2-product-list.tpl"}
	{include file="global:shop2.v2-pagelist.tpl"}

{else}

	{if isset($shop2_main_block) && !isset($smarty.get.p)}
	    {$shop2_main_block.body}
	{/if}

	{if $shop2_main_blocks}
	    {assign var=gr_main_blocks_version value=$shop2.my.gr_main_blocks_version|default:'global:shop2.v2-main-blocks.tpl'}
		{include file=$gr_main_blocks_version}
	{else}
	
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
	{/if}

	{if isset($shop2_main_block2) && !isset($smarty.get.p)}
	    {$shop2_main_block2.body}
	{/if}

{/if}