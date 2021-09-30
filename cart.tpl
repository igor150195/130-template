{assign var="hide_auth_form" value=$shop2.json.hide_auth_form}

{include file="global:shop2.order-repeat.tpl"}

{if !$cart.cart}
	<p>{#SHOP2_CART_IS_EMPTY#}<br><br><a class="shop2-btn" href="{$shop2.uri}">{#SHOP2_GO_MAIN#}</a></p>
{else}
	
	{if $smarty.get.products_only}
	
		{assign var=pre_amount value=$shop2_cart.total_pre_order|default:0}
		{assign var=sum_amount value=$pre_amount+$shop2_cart.total_amount|default:0}

		<div class="cart-popup">
			<div class="cart-popup__title">
				<ins>{#SHOP2_CART#}</ins>
				<span>{$sum_amount}</span>
			</div>
			<div class="cart-popup__top">
				<form action="{$shop2.uri}?mode=cart&action=up" id="shop2-cart">
					{if $cart.discounts.subtotal != 0 || $cart.discounts.total != 0}
						{assign var="show_discount" value=1}
					{else}
						{assign var="show_discount" value=0}
					{/if}
					<div class="cart-products shop2-cart-table">
						<div class="cart-products__body">
							
							{foreach from=$cart.cart item=e key=k}
								{include file="global:shop2.v2-cart-popup-product.tpl" fix_discount=1 show_discount=$show_discount}
							{/foreach}
							
							{foreach from=$cart.gifts item=e key=k}
								{include file="global:shop2.v2-cart-popup-product.tpl" gift=1 fix_discount=1 show_discount=$show_discount}
							{/foreach}
							
						</div>
					</div>
				</form>
				
				<div class="cart-update hide">
					<a href="javascript:void(0);" class="cart-update__btn shop2-cart-update">
						<span class="cart-update__title">{$shop2.my.gr_cart_total_title}</span>
						<span class="cart-update__recalc">{#SHOP2_RECALCULATE#}</span>
					</a>
				</div>
			</div>
			<div class="cart-popup__bottom">
				<div class="cart-popup__bottom-body">
					<div class="cart-popup__cleanup">
						<a href="{$shop2.uri}?mode=cart&action=cleanup">
							<span>
								<ins>{#SHOP2_CLEAR_CART#}</ins>
								<i>
									<svg class="gr-svg-icon">
										<use xlink:href="#icon_shop_del"></use>
									</svg>
									<svg class="gr-svg-icon gr_small_icon">
										<use xlink:href="#icon_shop_del_small"></use>
									</svg>
								</i>
							</span>
						</a>
					</div>
					<div class="cart-popup__total">
						<div class="cart-popup__total-title">
							{#SHOP2_TOTAL#}<span>:</span>
						</div>
						<div class="cart-popup__total-price" data-total-price="{$cart.totals.total|price_convert}">
							{$cart.totals.total|price_convert} <span>{$currency.currency_shortname}</span>
						</div>
					</div>
				</div>
				<div class="cart-popup__btns">
					<a href="{get_seo_url mode='cart' uri_prefix=$shop2.uri}" class="gr-cart-btn gr_cart_btn"><span>{$shop2.my.gr_cart_preview_cart_btn|default:#SHOP2_GO_TO_CART#}</span></a>
					{if !$shop2.json.order_in_one_page_new}
			        	<a href="{$shop2.uri}?mode=order" class="gr-order-one-page gr_order_one_page">
				            <span>{$shop2.my.gr_cart_preview_order|default:#SHOP2_CHECKOUT#}</span>
				        </a>
			        {else}
				        <a href="{get_seo_url mode='cart' uri_prefix=$shop2.uri}" class="gr-order-one-page gr_order_one_page">
				            <span>{$shop2.my.gr_cart_preview_order|default:#SHOP2_CHECKOUT#}</span>
				        </a>
			        {/if}
				</div>
			</div>
		</div>

	{else}

		{if $cart.totals.total < $shop2.json.order_min_cost}
			<div class="shop2-warning">
				<h2>{#SHOP2_MINIMUM_ORDER_AMOUNT#} - {$shop2.json.order_min_cost|price_convert} {$shop2.currency_shortname}</h2>
			</div>
		{/if}
	
		{include file="global:shop2.v2-order-errors.tpl"}
		
		{assign var=pre_amount value=$shop2_cart.total_pre_order|default:0}
		{assign var=sum_amount value=$pre_amount+$shop2_cart.total_amount|default:0}
	
		<div class="cart-page">
			<div class="cart-page__top">
				<div class="cart-page__left">
					<form action="{$shop2.uri}?mode=cart&action=up" id="shop2-cart" data-cart-amount="{$sum_amount}">
						<div class="shop2-cart-table">
							<div class="shop2-cart-table__btns">
								{if $shop2.my.gr_cart_calculate_left}
									<div class="shop2-cart-update{if $show_recalculate_button} show{/if}">
										<a href="#" class="shop2-cart-update">{#SHOP2_RECALCULATE#}</a>
									</div>
								{/if}
								<div class="shop2-cart-table__cleanup">
									<a href="{$shop2.uri}?mode=cart&action=cleanup">
										<span>
											<ins>{#SHOP2_CLEAR_CART#}</ins>
											<i>
												<svg class="gr-svg-icon">
													<use xlink:href="#icon_shop_del"></use>
												</svg>
												<svg class="gr-svg-icon gr_small_icon">
													<use xlink:href="#icon_shop_del_small"></use>
												</svg>
											</i>
										</span>
									</a>
								</div>
							</div>
							{if $cart.discounts.subtotal != 0 || $cart.discounts.total != 0}
								{assign var="show_discount" value=1}
							{else}
								{assign var="show_discount" value=0}
							{/if}
							{if $shop2.my.gr_cart_titles}
								<div class="shop2-cart-table__heading">
									<div class="shop2-cart-table__heading-left">
										<div class="shop2-cart-table__heading-item">{#SHOP2_PRODUCT#}</div>
									</div>
									<div class="shop2-cart-table__heading-right">
										<div class="shop2-cart-table__heading-item">{#SHOP2_PRICE#}</div>
										<div class="shop2-cart-table__heading-item">{#SHOP2_QTY#}</div>
										<div class="shop2-cart-table__heading-item">{#SHOP2_SUM#}</div>
									</div>
								</div>
							{/if}
							<div class="cart-products">
								{foreach from=$cart.cart item=e key=k}
									{include file="global:shop2.v2-cart-product.tpl" fix_discount=1 show_discount=$show_discount}
								{/foreach}
								{foreach from=$cart.gifts item=e key=k}
									{include file="global:shop2.v2-cart-product.tpl" gift=1 fix_discount=1 show_discount=$show_discount}
								{/foreach}
							</div>
						</div>
					</form>
				</div>
				<div class="cart-page__right">
					{if $shop2.my.gr_cart_coupon_toggle || $shop2.my.gr_cart_coupon_remodal}
						<div class="coupon-additional">
							<div class="coupon-additional__title">{$shop2.my.gr_cart_coupon_title|default:#SHOP2_CUPON#}</div>
							<div class="coupon-additional__btn"{if $shop2.my.gr_cart_coupon_remodal} data-remodal-target="coupon-remodal"{/if}>
								<span>{$shop2.my.gr_coupon_popup_btn|default:'Добавить купон'}</span>
							</div>
						</div>
					{/if}
					{if $shop2.my.gr_cart_coupon_remodal}
	                    <div class="remodal" data-remodal-id="coupon-remodal" role="dialog" data-remodal-options="hashTracking: false">
	                        <button data-remodal-action="close" class="remodal-close-btn">
	                            <span>
	                            	{$shop2.my.gr_remodal_close|default:'Закрыть'}
	                            	<i>
	                            		<svg class="gr-svg-icon gr_big_icon">
										    <use xlink:href="#icon_shop_close"></use>
										</svg>
										<svg class="gr-svg-icon">
										    <use xlink:href="#icon_shop_close_small"></use>
										</svg>
										<svg class="gr-svg-icon gr_small_icon">
										    <use xlink:href="#icon_shop_close_mini"></use>
										</svg>
	                            	</i>
	                            </span>
	                        </button>
	                {/if}
						<div class="shop-coupon">
							<div class="shop-coupon__inner">
								<div class="shop-coupon__title">{$shop2.my.gr_cart_coupon_title|default:#SHOP2_CUPON#}</div>
								<div class="shop-coupon__body">
									<div class="gr-field-style">
										{if $shop2.my.gr_cart_coupon_label!=""}<label class="field-title" for="coupon">{$shop2.my.gr_cart_coupon_label}</label>{/if}
										<input {if $shop2.my.gr_cart_coupon_placeholder!=""}placeholder="{$shop2.my.gr_cart_coupon_placeholder}" {/if}type="text" id="coupon" value="" />
									</div>
									<button class="coupon-btn"><span>{#SHOP2_APPLY#}</span></button>
								</div>
							</div>
							{if $coupons_arr}
							    <div class="coupon-id">
						            <div class="coupon-id__title">{$shop2.my.gr_cart_used_title|default:#SHOP2_USED#}<ins>:</ins></div>
						            <div class="coupon-id__body">
							            {foreach from=$coupons_arr key=k item=e}
							                <span class="coupon-code
							                    {if $e.err || $e.id<=0} error{/if}">{$k|escape}
							                    {if $e.err}({$e.err|localize}){elseif $e.id<=0}({#SHOP2_WRONG#}){/if}
							                </span>
							                <a href="#" data-code="{$k|escape}" class="coupon-delete">
							                	<svg class="gr-svg-icon gr_big_icon">
												    <use xlink:href="#icon_shop_close"></use>
												</svg>
												<svg class="gr-svg-icon">
												    <use xlink:href="#icon_shop_close_small"></use>
												</svg>
												<svg class="gr-svg-icon gr_small_icon">
												    <use xlink:href="#icon_shop_close_mini"></use>
												</svg>
							                </a>
							            {/foreach}
						            </div>
							    </div>
							{elseif $coupons}
							    <div class="coupon-id">
						            <div class="coupon-id__title">{$shop2.my.gr_cart_used_title|default:#SHOP2_USED#}<ins>:</ins></div>
						            <div class="coupon-id__body">
							            {foreach from=$coupons key=k item=e}
							                <span class="coupon-code {if $e<=0} error{/if}">{$k|escape} {if $e<=0}({#SHOP2_WRONG#}){/if}</span>
							                <a href="#" data-code="{$k|escape}" class="coupon-delete">
							                	<svg class="gr-svg-icon gr_big_icon">
												    <use xlink:href="#icon_shop_close"></use>
												</svg>
												<svg class="gr-svg-icon">
												    <use xlink:href="#icon_shop_close_small"></use>
												</svg>
												<svg class="gr-svg-icon gr_small_icon">
												    <use xlink:href="#icon_shop_close_mini"></use>
												</svg>
							                </a>
							            {/foreach}
						            </div>
							    </div>
							{/if}
						</div>
					{if $shop2.my.gr_cart_coupon_remodal}
						</div>
					{/if}
	
					<div class="cart-total">
						{if $shop2.my.gr_cart_total_title!=""}
							<div class="cart-total__header">{$shop2.my.gr_cart_total_title}</div>
						{/if}
						
						<div class="cart-total__items">
							<div class="cart-total__item">
								<div class="cart-total__title">{#SHOP2_SUM#}<span>:</span></div>
								<div class="cart-total__body">{$cart.totals.discount_subtotal|price_convert} <span>{$currency.currency_shortname}</span></div>
							</div>
	
							{assign var="cpn" value=""}
							{capture assign="dsc"}{strip}
								{foreach from=$cart.details item=e name=foo}
									{assign var="discount" value=$discounts[$e.discount_id]}
									{if !$discount.is_coupon}
										{$discount.discount_descr}
									{else}
										{assign var="cpn" value=$cpn|cat:$discount.discount_descr}
									{/if}
								{/foreach}
							{/strip}{/capture}
							
							{if $cart.totals.sum_discount_order}
								<div class="cart-total__item discount_item">
									<div class="cart-total__title">{strip}
	
											{if $dsc}
												<span class="question">
													{if $shop2.my.gr_cart_question}
														<svg class="gr-svg-icon gr_small_icon"><use xlink:href="#icon_shop_info_small"></use></svg>
													{else}
														<img src="/g/shop2v2/default/images/question-price.png" alt="" />
													{/if} {#SHOP2_DISCOUNT2#}<span>:</span>
												</span>
												<div class="shop2-product-discount-desc">
													{$dsc}
												</div>
											{else}
												{#SHOP2_DISCOUNT2#}<span>:</span>
											{/if}
	
										{/strip}</div>
									<div class="cart-total__body">-{$cart.totals.sum_discount_order|price_convert} <span>{$currency.currency_shortname}</span></div>
								</div>
							{/if}
	
							{if ($has_coupons || $coupons) && $cart.totals.sum_discount_coupon|price_convert>0}
								<div class="cart-total__coupon-block">
									<div class="cart-total__item">
										<div class="cart-total__title">{strip}
			
												{if $cpn}
													<span class="question">
													{if $shop2.my.gr_cart_question}
														<svg class="gr-svg-icon gr_small_icon"><use xlink:href="#icon_shop_info_small"></use></svg>
													{else}
														<img src="/g/shop2v2/default/images/question-price.png" alt="" />
													{/if} {#SHOP2_COUPON_DISCOUNT#}<span>:</span>
													</span>
													<div class="shop2-product-discount-desc">
														{$cpn}
													</div>
												{else}
													{#SHOP2_COUPON_DISCOUNT#}<span>:</span>
												{/if}
			
											{/strip}</div>
										<div class="cart-total__body">-{$cart.totals.sum_discount_coupon|price_convert} <span>{$currency.currency_shortname}</span></div>
									</div>
								</div>
							{/if}
							
							{if $cart.bonusParams.enabled && $cart.bonusParams.is_using && isset($user.user_id) && $cart.totals.sum_discount_bonus|price_convert>0}{*Bonus*}
								<div class="cart-total__item bonus_item">
									<div  class="cart-total__title">{strip}
							
									{if $cart.bonusParams.bonus_descr}
										<span class="question">
										<svg class="gr-svg-icon gr_small_icon"><use xlink:href="#icon_shop_info_small"></use></svg> {'#SHOP2_BONUS_DISCOUNT#'|l}<span>:</span>
										</span>
										<div class="shop2-product-discount-desc">
											{$cart.bonusParams.bonus_descr}
										</div>
									{else}
										{'#SHOP2_BONUS_DISCOUNT#'|l}:
									{/if}
							
									{/strip}</div>
									<div  class="cart-total__body">
										<div class="user-bonus-introduced">
											-{$cart.totals.sum_discount_bonus|price_convert} <span>{$currency.currency_shortname}</span>
										</div>
									</div>
								</div>
							{/if}{*Bonus*}
							
							{if $cart.tax.name}
								<div class="cart-total__item">
									<div class="cart-total__title">{#SHOP2_INCLUDING_VAT#|sprintf:$cart.tax.name} {$cart.tax.percent}%<span>:</span></div>
									<div class="cart-total__body">{$cart.tax.value|price_convert} <span>{$currency.currency_shortname}</span></div>
								</div>
							{/if}
	
							<div class="cart-total__item last_item">
								<div class="cart-total__title">{#SHOP2_TOTAL#}<span>:</span></div>
								<div class="cart-total__body" data-total-price="{$cart.totals.total|price_convert}">{$cart.totals.total|price_convert} <span>{$currency.currency_shortname}</span></div>
							</div>
						</div>
						
						{if $cart.bonusParams.enabled && $cart.bonusParams.is_using && isset($user.user_id) && $user.bonus_sum|regex_replace:'/[.,]\d+/':'' > 0}
							<div class="cart-bonuses">
								<div class="cart-bonuses__title tpl-field type-checkbox">
									<ul>
										<li>
											<label>
				                    			<input 
				                            		type="checkbox"{if $cart.bonusParams.enabled && $cart.bonusParams.is_using && isset($user.user_id) && $cart.totals.sum_discount_bonus|price_convert>0} 
				                            		checked="checked"{/if} 
				                            		name="cart_bonuses_check" 
				                        		/>
												<span>Списать из <strong><ins class="bonus-amount" data-bonus-amount="{$user.bonus_sum|regex_replace:'/[.,]\d+/':''}">{$user.bonus_sum|regex_replace:'/[.,]\d+/':''|spellcount:'бонус':'бонуса':'бонусов'}</ins></strong></span>
				                    		</label>
			                    		</li>
		                    		</ul>
								</div>
								
								<div class="cart-bonuses__container{if $cart.bonusParams.enabled && $cart.bonusParams.is_using && isset($user.user_id) && $cart.totals.sum_discount_bonus|price_convert>0} show_bonuses{/if}">
									<div class="cart-bonuses__header">Максимальная сумма для оплаты бонусами: <span>{$cart.bonusParams.allowed_value}</span>{if $cart.bonusParams.allowed_type == "percent"}% от суммы заказа{else} <ins>{$currency.currency_shortname}</ins>{/if}</div>
									<div class="cart-bonuses__body">
										<div class="cart-bonuses__left gr-field-style">
											<label class="field-title" for="bonus-points">{#SHOP2_BONUS_NAME_ON_SITE#|l}:</label>
											<label>
												<input type="number" id="bonus-points" title="" value="{if $cart.bonusParams.enabled && $cart.bonusParams.is_using && isset($user.user_id) && $cart.totals.sum_discount_bonus|price_convert>0}{$cart.totals.sum_discount_bonus|price_convert}{/if}" />
											</label>
										</div>
										<div class="cart-bonuses__right">
											<button type="button" class="bonus-apply shop2-btn">{#SHOP2_APPLY#|l}</button>
											<button type="button" class="bonus-delete shop2-btn">{#DELETE#|l}</button>
										</div>
									</div>
								</div>
							</div>
						{/if}
	
						<div class="cart-total__btns{if !(($hide_auth_form || isset($user.user_id)) && !$order_in_one_page) && !(($shop2.my.gr_cart_auth_remodal && !$hide_auth_form && !isset($user.user_id)) && !$order_in_one_page)} no_btns{/if}">
							{if !$shop2.my.gr_cart_calculate_left}
								<div class="shop2-cart-update{if $show_recalculate_button} show{/if}">
									<a href="#" class="shop2-cart-update"><span>{#SHOP2_RECALCULATE#}</span></a>
								</div>
							{/if}
							{if ($hide_auth_form || isset($user.user_id)) && !$order_in_one_page}
								<a href="{$shop2.uri}?mode=order" class="cart-total-order-checkout cart_total_order_checkout">
									<span>{#SHOP2_CHECKOUT#}</sp
								an></a>
							{/if}
							{if ($shop2.my.gr_cart_auth_remodal && !$hide_auth_form && !isset($user.user_id)) && !$order_in_one_page}
								<div class="cart-total-checkout cart_total_checkout" data-remodal-target="cart-auth-remodal">
									<span>{#SHOP2_CHECKOUT#}</span>
								</div>
							{/if}
						</div>
						{if $cart.bonusParams.enabled && $cart.bonusParams.is_accrual && isset($user.user_id) && $cart.totals.sum_bonus|price_convert>0}{*Bonus*}
							<div class="cart-total__bonuses">
									<strong><i><svg class="gr-svg-icon"><use xlink:href="#icon_shop_bonus"></use></svg><svg class="gr-svg-icon gr_small_icon"><use xlink:href=#icon_shop_bonus_small></use>
											</svg></i><span>+</span>{$cart.totals.sum_bonus|price_convert|spellcount:'бонус':'бонуса':'бонусов'}</strong>
									<ins>за покупку</ins>
							</div>
						{/if}
					</div>
					
					{if !$order_in_one_page && !isset($user.user_id)}
						{if $shop2.my.gr_cart_auth_remodal}
							<div class="remodal" data-remodal-id="cart-auth-remodal" role="dialog" data-remodal-options="hashTracking: false">
		                        <button data-remodal-action="close" class="remodal-close-btn">
		                            <span>
		                            	{$shop2.my.gr_remodal_close|default:'Закрыть'}
		                            	<i>
		                            		<svg class="gr-svg-icon gr_big_icon">
											    <use xlink:href="#icon_shop_close"></use>
											</svg>
											<svg class="gr-svg-icon">
											    <use xlink:href="#icon_shop_close_small"></use>
											</svg>
											<svg class="gr-svg-icon gr_small_icon">
											    <use xlink:href="#icon_shop_close_mini"></use>
											</svg>
		                            	</i>
		                            </span>
		                        </button>
						{/if}
							<form method="post" action="{$user_settings.link}" class="form-registration">
								<div class="form-registration__title">{$shop2.my.gr_cart_form_registration_title|default:#SHOP2_CHECKOUT#}</div>
								<input type="hidden" name="mode" value="login" />
								<div class="tpl-field">
									{if !$shop2.my.gr_cart_reg_placeholder}
										<label class="field-title" for="reg-login">{#SHOP2_LOGIN#}<span>:</span></label>
									{/if}
									<label class="field-value">
										<input {if $shop2.my.gr_cart_reg_placeholder}placeholder="{#SHOP2_LOGIN#}" {/if}type="text" id="reg-login" value="" name="login" />
									</label>
								</div>
								<div class="tpl-field">
									{if !$shop2.my.gr_cart_reg_placeholder}
										<label class="field-title" for="reg-password">{#SHOP2_PASSWORD#}<span>:</span></label>
									{/if}
									<label class="field-value">
										<input {if $shop2.my.gr_cart_reg_placeholder}placeholder="{#SHOP2_PASSWORD#}" {/if}type="password" id="reg-password" value="" name="password" />
									</label>
								</div>
								<button class="form-registration__btn form_registration_btn" type="submit">
									<span>{#SHOP2_LOG_IN_PLACE_ORDER#}</span>
								</button>
							</form>
							{if $user_settings.social_params}
								<div class="shop2v2-cart-soc-block">
									{include file="global:block.g-social.tpl"}
								</div>
							{/if}
						{if $shop2.my.gr_cart_auth_remodal}
							</div>
						{/if}
						<div class="cart-registration">
							{if $shop2.my.gr_cart_registration_title!=""}
								<div class="cart-registration__title">{$shop2.my.gr_cart_registration_title}</div>
							{/if}
							<div class="cart-registration__text">
								{#SHOP2_FOR_DISCOUNTS_REGISTER1#} <a href="{get_seo_url mode=register uri_prefix=$user_settings.link}">{#SHOP2_FOR_DISCOUNTS_REGISTER2#}</a>
							</div>
							<div class="cart-registration__btns">
								{if !$order_in_one_page}
									<div class="cart-registration__btn">
										<a href="{$shop2.uri}?mode=order" class="cart-registration-btn">
											<span>{#SHOP2_BUY_WITHOUT_REGISTRATION#}</span>
										</a>
									</div>
								{/if}
							</div>
						</div>
					{/if}
					
					{if !$hide_auth_form && isset($user.user_id) && $user.email && $shop2.my.gr_cart_info_in_total}
						<div class="shop2-info">
							{#SHOP2_YOU_LOGGED_AS#|sprintf:$user.email}
						</div>
					{/if}
	
				</div>
			</div>
			<div class="cart-page__bottom">
				
			{include file="db:test-cart-delivery.tpl"} {*ТЕСТОВОЕ УДАЛИТЬ ПРИ ЗАЛИВКЕ*}

				{if !$hide_auth_form}
					{if isset($user.user_id)}
						{if $user.email && !$shop2.my.gr_cart_info_in_total}
							<div class="shop2-cart-registration">
								<div class="shop2-info">
									{#SHOP2_YOU_LOGGED_AS#|sprintf:$user.email}
								</div>
							</div>
						{/if}
					{else}
	
						{if $order_in_one_page}
							<div class="shop2-cart-auth">
								<div class="shop2-cart-auth__row">
									{capture assign="__tmp"}{get_seo_url mode=register uri_prefix=$user_settings.link}{/capture}
									{#SHOP2_AUTH_REGISTRATION#|sprintf:$__tmp}
								</div>
								<div class="shop2-cart-auth__row">
									{#SHOP2_AUTH_WITH2#}
								</div>
	
								<form class="shop2-cart-auth__form js-shop2-cart-auth__form" method="post" action="{$user_settings.link}">
									<input type="hidden" name="mode" value="login" />
									<div class="gr-field-style login_field">
										<div class="field-title">{#SHOP2_LOGIN#}<span>:</span></div>
										<input type="text" name="login" />
									</div>
									<div class="gr-field-style password_field">
										<div class="field-title">{#SHOP2_PASSWORD#}<span>:</span></div>
										<input type="text" name="password" />
									</div>
									<button class="shop2-cart-auth__btn" type="submit">
										<span>{#SHOP2_LOG_IN_PLACE_ORDER#}</span>
									</button>
	
									{if $user_settings.social_params}
										<div class="shop2v2-cart-soc-block">
											{include file="global:block.g-social.tpl"}
										</div>
									{/if}
								</form>
	
								<div class="shop2-cart-auth__row shop2-cart-auth__row--top-offset">
									{#SHOP2_AUTH_WITHOUT#}
								</div>
							</div>
						{/if}
	
					{/if}
				{/if}
				
				{if $shop2.json.order_note!=""}
					<div class="shop-cart-text">
						{$shop2.json.order_note}
					</div>
				{/if}
	
				{if $order_in_one_page}
					{if $cart.totals.total >= $shop2.json.order_min_cost}
						{include file="global:shop2.v2-cart.order.tpl" deligate_delivery=$site.reg.module.deligate}
					{/if}
				{/if}
			</div>
		</div>
	{/if}
{/if}