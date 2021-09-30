{assign var="pr" value=$product}
{if $collection_list_item}
	{assign var="pr" value=$collection_list_item}
{/if}
{assign var=amount_min value=$pr.params.amount_min}
{if $pr.params.amount_min !="" || $pr.params.amount_multiplicity !=""}
	{assign var=multiplicity value=$pr.params.amount_multiplicity|default:1}
{/if}

{if !$amount_min}
	{if $multiplicity}
		{assign var=amount_min value=$multiplicity}
	{else}
		{assign var=amount_min value=$shop2.my.amount_default|default:1}
	{/if}
{/if}

{if $pr.amount < 1 && $pr.amount != 0}
	{assign var=amount_min value=$shop2.my.amount_default|default:$pr.amount}
{/if}

{if !$shop2.my.mode_catalog}
	<div class="{$class}{if $pr.buy_mode == 1 && $shop2.my.enable_disabled_class} shop2-product-amount-disabled{/if}">
		{if !$hideCaption}
			<div class="amount-title">{$shop2.my.gr_amount_btn_title|default:#SHOP2_AMOUNT#}<span>:</span></div>
		{/if}
		{if $pr.buy_mode == 1}
			<div class="shop2-product-amount disabled">
				<button type="button" disabled="disabled">
					<svg class="gr-svg-icon">
					    <use xlink:href="#icon_shop_minus"></use>
					</svg>
					<svg class="gr-svg-icon gr_small_icon">
					    <use xlink:href="#icon_shop_minus_small"></use>
					</svg>
				</button>
				<input type="text" maxlength="4" disabled="disabled" value="{$amount_min}" />
				<button type="button" disabled="disabled">
					<svg class="gr-svg-icon">
					    <use xlink:href="#icon_shop_plus"></use>
					</svg>
					<svg class="gr-svg-icon gr_small_icon">
					    <use xlink:href="#icon_shop_plus_small"></use>
					</svg>
				</button>
			</div>
		{else}
			{if $shop2.my.gr_amount_min_top}
				<div class="amount-min">
					от 2 по 2 шт.
				</div> {*ТЕСТОВОЕ УДАЛИТЬ ПРИ ЗАЛИВКЕ*}
				{if ($amount_min != 0 || $multiplicity != 0) && ($pr.params.amount_min || $pr.params.amount_multiplicity)}
					<div class="amount-min">
						{#FILTER_INT_FROM#|mb_strtolower} {$amount_min} {$pr.params.unit}
						{#FILTER_BY#|mb_strtolower} {if $multiplicity}{$multiplicity}{else}{if $pr.amount < 1 && $pr.amount != 0}{$pr.amount}{else}1{/if}{/if} {$pr.params.unit}
					</div>
				{/if}
			{/if}
			<div class="shop2-product-amount">
				<button type="button" class="amount-minus">
					<svg class="gr-svg-icon">
					    <use xlink:href="#icon_shop_minus"></use>
					</svg>
					<svg class="gr-svg-icon gr_small_icon">
					    <use xlink:href="#icon_shop_minus_small"></use>
					</svg>
				</button>
				<input type="text" name="amount" {if $shop2.product_amount_required=='1' || $pr.buy_mode==1}data-max="{$pr.amount}"{/if} data-kind="{$pr.kind_id}" data-min="{$amount_min}" data-multiplicity="{$multiplicity}" maxlength="4" value="{$amount_min}" />
				<button type="button" class="amount-plus">
					<svg class="gr-svg-icon">
					    <use xlink:href="#icon_shop_plus"></use>
					</svg>
					<svg class="gr-svg-icon gr_small_icon">
					    <use xlink:href="#icon_shop_plus_small"></use>
					</svg>
				</button>
			</div>
			{if !$shop2.my.gr_amount_min_top}
				{if ($amount_min != 0 || $multiplicity != 0) && ($pr.params.amount_min || $pr.params.amount_multiplicity)}
					<div class="amount-min">
						{#FILTER_INT_FROM#|mb_strtolower} {$amount_min} {$pr.params.unit}
						{#FILTER_BY#|mb_strtolower} {if $multiplicity}{$multiplicity}{else}{if $pr.amount < 1 && $pr.amount != 0}{$pr.amount}{else}1{/if}{/if} {$pr.params.unit}
					</div>
				{/if}
				<div class="amount-min">
					от 2 по 2 шт.
				</div> {*ТЕСТОВОЕ УДАЛИТЬ ПРИ ЗАЛИВКЕ*}
			{/if}
		{/if}
	</div>
{/if}