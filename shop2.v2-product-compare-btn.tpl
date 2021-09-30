{if $shop2.json.compare}

	{if isset($compare[$product.kind_id])}
		<div class="product-compare product-compare-added">
			<label class="gr-compare-checkbox">
				{if $shop2.my.gr_compare_icons}
					<svg class="gr-svg-icon">
					    <use xlink:href="#icon_shop_compare_added"></use>
					</svg>
					<svg class="gr-svg-icon gr_small_icon">
					    <use xlink:href="#icon_shop_compare_added_small"></use>
					</svg>
				{/if}
				<input type="checkbox" value="{$product.kind_id}" checked="true" autocomplete="off" />
			</label>
			<a class="link-reset custom-underlined-link" href="{get_seo_url uri_prefix=$shop2.uri mode="compare"}" target="_blank"{if $shop2.my.gr_popup_compare} data-remodal-target="compare-preview-popup"{/if}>{$shop2.my.gr_compare|default:'Cравнить'}&nbsp;<span>{$compare|@count}</span></a>
			{if $shop2.my.gr_compare_tooltip_added!=""}
				<span class="product-compare-tooltip">{$shop2.my.gr_compare_tooltip_added}</span>
			{/if}
		</div>
	{else}
		<div class="product-compare">
			<label class="gr-compare-plus">
				{if $shop2.my.gr_compare_icons}
					<svg class="gr-svg-icon">
						<use xlink:href="#icon_shop_compare_add"></use>
					</svg>
					<svg class="gr-svg-icon gr_small_icon">
						<use xlink:href="#icon_shop_compare_add_small"></use>
					</svg>
				{/if}
				<input type="checkbox" value="{$product.kind_id}"/>
				{$shop2.my.gr_compare_add|default:'К сравнению'}
			</label>
			{if $shop2.my.gr_compare_tooltip!=""}
				<span class="product-compare-tooltip">{$shop2.my.gr_compare_tooltip}</span>
			{/if}
		</div>
	{/if}
	
{/if}