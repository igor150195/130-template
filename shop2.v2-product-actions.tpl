{if $collections_actions}
	{assign var=product value=$e}
{/if}

{if $product.discounts_applicable|@count>0 && !$hide_discount_label}
	<div class="shop2-product-actions">
		<dl>
			{foreach from=$product.discounts_applicable name=foo item=e key=k}
				{assign var="discount" value=$discounts.$e}
				
				{if $discount.discount_kind == 8 && $shop2.my.gr_promo_actions}
				
					<dt class="promo-action">
						<span class="promo-action__name">
							<ins class="get-promo-link"
								data-cmd="getPromoProducts"
								data-ver-id="{$shop2.ver_id}"
								data-kind-id="{$product.kind_id}" 
								data-discount-id="{$discount.discount_id}" 
								data-is-main="{$product.promo.main}"
								data-hash="{$api.getPromoProducts}">{$discount.discount_name|htmlspecialchars}</ins>
						</span>
						{if $discount.discount_descr}
							<span class="promo-action__text">{$discount.discount_descr|htmlspecialchars_decode}</span>
						{/if}
					</dt>
					
				{else}
				
					<dt {if $discount.gift_id}class="gift-action"{/if}>
						<span class="icon-action">
							{if $discount.gift_id}
								<svg class="gr-svg-icon">
								    <use xlink:href="#icon_shop_gift"></use>
								</svg>
								<svg class="gr-svg-icon gr_small_icon">
								    <use xlink:href=#icon_shop_gift_small></use>
								</svg>
							{else}
								<svg class="gr-svg-icon">
								    <use xlink:href=#icon_shop_sale></use>
								</svg>
								<svg class="gr-svg-icon gr_small_icon">
								    <use xlink:href=#icon_shop_sale_small></use>
								</svg>
							{/if}
						</span>
						<span class="name-action">{$discount.discount_name|htmlspecialchars}</span>
					</dt>
					<dd>
						<div class="name-action{if !$discount.discount_descr} no_desc_action{/if}">{$discount.discount_name|htmlspecialchars}</div>
						<div class="desc-action">
							{$discount.discount_descr|htmlspecialchars_decode}
						</div>
						<div class="close-desc-action">
							<svg class="gr-svg-icon gr_big_icon">
							    <use xlink:href="#icon_shop_close"></use>
							</svg>
							<svg class="gr-svg-icon">
							    <use xlink:href="#icon_shop_close_small"></use>
							</svg>
							<svg class="gr-svg-icon gr_small_icon">
							    <use xlink:href="#icon_shop_close_mini"></use>
							</svg>
						</div>
					</dd>
				
				{/if}
			{/foreach}
		</dl>
	</div>
{/if}

{if $bonus.enabled && $bonus.is_accrual && isset($user.user_id) && $product.bonus_value > 0 && !$hide_discount_label}
	<div class="shop2-product-actions bonus-action">
		<dl>
			<dt class="gift-action">
				<span class="icon-action bonus-icon">
					<svg class="gr-svg-icon">
					    <use xlink:href="#icon_shop_bonus"></use>
					</svg>
					<svg class="gr-svg-icon gr_small_icon">
					    <use xlink:href=#icon_shop_bonus_small></use>
					</svg>
				</span>
				<span class="name-action bonus-name"><span class="bonus-value">{$product.bonus_value|spellcount:'бонус':'бонуса':'бонусов'}</span></span>
			</dt>
			<dd>
				<div class="name-action bonus-name">{$bonus.bonus_name}</div>
				<div class="desc-action">
					{$bonus.bonus_descr}
				</div>
				<div class="close-desc-action">
					<svg class="gr-svg-icon gr_big_icon">
					    <use xlink:href="#icon_shop_close"></use>
					</svg>
					<svg class="gr-svg-icon">
					    <use xlink:href="#icon_shop_close_small"></use>
					</svg>
					<svg class="gr-svg-icon gr_small_icon">
					    <use xlink:href="#icon_shop_close_mini"></use>
					</svg>
				</div>
			</dd>
		</dl>
	</div>
{/if}