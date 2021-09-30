{if $shop2.my.price_on_request && $obj.buy_mode == 1 || ($shop2.price_on_request && $obj.price == 0)}
	{if $shop2.view == "list" && $mode != "product"}
		<div class="price-current price_on_request"><strong>{$shop2.text_price_on_request|default:#SHOP2_ON_REQUEST#|l}</strong></div>
	{else}
		<div class="price-current price_on_request"><strong>{$shop2.text_price_on_request|default:#SHOP2_PRICE_ON_REQUEST#|l}</strong></div>
	{/if}
{elseif $shop2.view == "list" && $mode != "product"}
	{if $shop2.my.gr_show_price_in_pricelist}
		<div class="price-current">
			<strong>{$obj.price|price_convert}</strong> 
			<span>{$shop2.currency_shortname}</span>
			{if $shop2.my.show_product_unit && $obj.params.unit}
				<span class="gr-params-unit"><ins>/</ins> {$obj.params.unit}</span>
			{/if}
		</div>
	{else}
		<div class="price-current"><strong>{$obj.price|price_convert}</strong></div>
	{/if}
{else}
	<div class="price-current">
		<strong>{$obj.price|price_convert}</strong>
		<span>{$shop2.currency_shortname}</span>
		{if $shop2.my.show_product_unit && $obj.params.unit}
			<span class="gr-params-unit"><ins>/</ins> {$obj.params.unit}</span>
		{/if}
	</div>
{/if}