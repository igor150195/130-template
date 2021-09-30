{if $shop2.json.panel && $mode != 'order' && $mode != 'cart'}

	{assign var="compared" value=$compare|@count}

	<div class="shop2-panel" id="shop2-panel">
		<div class="shop-panel-content">
			
			{if $shop2.json.favorite_products == 1 && $shop2.my.gr_favorite} {* Избранные товары *}
				<div class="shop-panel-favorite">
					<a href="{get_seo_url mode='favorites' uri_prefix=$shop2.uri}" class="shop-panel-favorite__link{if $shop2.favorite_count == 0} shop2-panel-link-disabled{/if}">
						<span>
							<ins>{'FORUM_FAVORITES'|l}</ins>
							<i>
								<svg class="gr-svg-icon">
								    <use xlink:href="#icon_shop_favorite"></use>
								</svg>
								<svg class="gr-svg-icon gr_small_icon">
								    <use xlink:href="#icon_shop_favorite_small"></use>
								</svg>
							</i>
						</span>
						<ins class="shop-panel-favorite__count">{$shop2.favorite_count|default:0}</ins>
					</a>
				</div>
			{/if}
			
			{if $shop2.json.compare}
				<div class="shop-panel-compare">
					<a target="_blank" {if $compared}href="{get_seo_url mode="compare" uri_prefix=$shop2.uri}"{else}class="shop2-panel-link-disabled"{/if}{if $shop2.my.gr_popup_compare} data-remodal-target="compare-preview-popup"{/if}>
						<span>
							<ins>{$shop2.my.gr_panel_compare_title|default:'Сравнение'}</ins>
							<i>
								<svg class="gr-svg-icon">
								    <use xlink:href="#icon_shop_compare"></use>
								</svg>
								<svg class="gr-svg-icon gr_small_icon">
								    <use xlink:href="#icon_shop_compare_small"></use>
								</svg>
							</i>
						</span>
						<ins class="shop2-panel-count{if $compared} not-null{/if}">{$compared}</ins>
					</a>
				</div>
			{/if}
			
			<div class="shop-panel-cart">
				<a {if $shop2_cart.total_amount || $shop2_cart.total_sum || $shop2_cart.total_pre_order}href="{get_seo_url mode='cart' uri_prefix=$shop2.uri}"{else}class="shop2-panel-link-disabled"{/if}>
					<span>
						<ins>{$shop2.my.gr_panel_cart_title|default:'Корзина'}</ins>
						<i>
							<svg class="gr-svg-icon">
							    <use xlink:href="#icon_shop_cart"></use>
							</svg>
							<svg class="gr-svg-icon gr_small_icon">
							    <use xlink:href="#icon_shop_cart_small"></use>
							</svg>
						</i>
					</span>
					<ins class="shop2-panel-count{if $shop2_cart.total_amount || $shop2_cart.total_pre_order} not-null{/if}">{$shop2_cart.total_amount+$shop2_cart.total_pre_order|default:0}</ins>
				</a>
			</div>			
		</div>
	</div>

{/if}