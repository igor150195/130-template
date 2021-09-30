{if $e.kind_id}
	{assign var="obj" value=$e}
{else}
	{assign var="obj" value=$product}
{/if}

{if $obj.price_old}
	{assign var="discount" value=$discounts[$obj.discounts_applied.0]}
	
	<div class="price-old {if $discount.discount_descr}question{/if}"><span>
		<strong>{$obj.price_old|price_convert}</strong>
		{if $shop2.my.gr_show_price_in_pricelist}
			<span>{$shop2.currency_shortname}</span>
		{else}
			{if $shop2.view != 'list'}
				<span>{$shop2.currency_shortname}</span>
			{/if}
		{/if}
	</span></div>

	{if $discount.discount_descr}
		<div class="shop2-product-discount-desc">
			{$discount.discount_descr}
		</div>
	{/if}
{/if}