{assign var="pr" value=$product}
{if $collection_list_item}
	{assign var="pr" value=$collection_list_item}
{/if}

{if !$shop2.my.mode_catalog}
	{if $pr.buy_mode == 0} 
		<button class="{if $is_sets} shop2-product-set shop2-btn{else}shop-product-btn type-{$type} buy{/if}" type="submit" data-url="{get_seo_url uri_prefix=$shop2.uri mode="product" alias=$pr.alias}">
			<span>
				{if $is_sets}
					{'ADD'|l}
				{else}
					{$shop2.my.buy_alias|default:#SHOP2_BUY#}
					<i>
						<svg class="gr-svg-icon gr_big_icon">
						    <use xlink:href="#icon_shop_cart_add_big"></use>
						</svg>
						<svg class="gr-svg-icon">
						    <use xlink:href="#icon_shop_cart_add"></use>
						</svg>
						<svg class="gr-svg-icon gr_small_icon">
						    <use xlink:href="#icon_shop_cart_add_small"></use>
						</svg>
					</i>
				{/if}
			</span>
		</button>
	{elseif $pr.buy_mode == 1}
		<button class="{if $is_sets} shop2-product-set shop2-btn{else}shop-product-btn type-{$type}{/if} notavailable" disabled="disabled" type="submit" data-url="{get_seo_url uri_prefix=$shop2.uri mode="product" alias=$pr.alias}">
			<span>
				{$shop2.my.not_available_alias|default:#SHOP2_NOT_AVAILABLE#}
				<i>
					<svg class="gr-svg-icon gr_big_icon">
					    <use xlink:href="#icon_shop_cart_not_big"></use>
					</svg>
					<svg class="gr-svg-icon">
					    <use xlink:href="#icon_shop_cart_not"></use>
					</svg>
					<svg class="gr-svg-icon gr_small_icon">
					    <use xlink:href="#icon_shop_cart_not_small"></use>
					</svg>
				</i>
			</span>
		</button>
	{else}
		<button class="{if $is_sets} shop2-product-set shop2-btn{else}shop-product-btn type-{$type} onrequest{/if}" type="submit" data-url="{get_seo_url uri_prefix=$shop2.uri mode="product" alias=$pr.alias}">
			<span>
				{if $is_sets}
					{'ADD'|l}
				{else}
					{$shop2.my.preorder_alias|default:#SHOP2_PREORDER2#}
					<i>
						<svg class="gr-svg-icon gr_big_icon">
						    <use xlink:href="#icon_shop_onrequest_big"></use>
						</svg>
						<svg class="gr-svg-icon">
						    <use xlink:href="#icon_shop_onrequest"></use>
						</svg>
						<svg class="gr-svg-icon gr_small_icon">
						    <use xlink:href="#icon_shop_onrequest_small"></use>
						</svg>
					</i>
				{/if}
			</span>
		</button>
	{/if}
{/if}

<input type="hidden" value="{$pr.name|htmlspecialchars|escape}" name="product_name" />
<input type="hidden" value="{$smarty.server.PROTOCOL}://{$smarty.server.HTTP_HOST}{get_seo_url uri_prefix=$shop2.uri mode="product" alias=$pr.alias}" name="product_link" />