{assign var=pre_amount value=$shop2_cart.total_pre_order|default:0}
{assign var=sum_amount value=$pre_amount+$shop2_cart.total_amount|default:0}

<div id="shop2-cart-preview">
	<a href="{get_seo_url mode='cart' uri_prefix=$shop2.uri}" class="gr-cart-preview-link{if $sum_amount>0} active{/if}{if $mode=='cart' || $mode=='order'} pointer_events_none{/if}">
		{if $shop2.my.gr_cart_preview_icons}
			<span class="gr-cart-preview-body">
		{/if}
				{if $shop2.my.gr_cart_preview_text}
					<ins class="gr-cart-preview-title">{#SHOP2_CART#}</ins>
				{/if}
				<span class="gr-cart-total-amount">{$sum_amount}</span>
				<span class="gr-cart-total-sum" data-total-price="{$shop2_cart.total_sum|default:'0'|price_convert}"><ins>{$shop2_cart.total_sum|default:'0'|price_convert}</ins> <span>{$shop2.currency_shortname}</span></span>
				{if $shop2.my.gr_cart_preview_icons}
					<i>
						<svg class="gr-svg-icon">
						    <use xlink:href="#icon_shop_cart"></use>
						</svg>
						<svg class="gr-svg-icon gr_small_icon">
						    <use xlink:href="#icon_shop_cart_small"></use>
						</svg>
					</i>
				{/if}
		{if $shop2.my.gr_cart_preview_icons}
			</span>
		{/if}
	</a>
</div><!-- Cart Preview -->