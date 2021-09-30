{assign var=params_count value=1}
{if $e.params|@count}
	{assign var=params_count value=$e.params|@count}
{/if}
{assign var="product" value=$products.$k}

{section loop=$params_count name=co}
	<div class="cart-products__item">
		<div class="cart-products__left">
			<div class="cart-product">
				<div class="cart-product__left">
					{assign var="cart_image_width" value=$shop2.my.cart_image_width|default:240}
					{assign var="cart_image_height" value=$shop2.my.cart_image_height|default:240}
						
					<div class="cart-product__image{if !$product.image_filename} no-image{/if}{if $shop2.my.gr_images_size}{if $site.product_settings.images_size=="2"} gr_image_3x4{elseif $site.product_settings.images_size=="3"} gr_image_2x3{elseif $site.product_settings.images_size=="4"} gr_image_4x3{elseif $site.product_settings.images_size=="5"} gr_image_3x2{else} gr_image_1x1{/if}{/if}">
						<a href="{get_seo_url mode="product" alias=$product.alias}">
							{if $product.image_filename}
								<img src="{s3_img width=$cart_image_width height=$cart_image_height src=$product.image_filename method=$shop2.my.s3_img_method}"{if $site.product_settings.images_view} class="gr_image_contain"{/if} alt="{$product.name}" />
							{/if}
						</a>
					</div>
				</div>

				<div class="cart-product__right">
					<div class="cart-details">
						
						<div class="cart-product-name">
							<a {if $product.alias != "#"}href="{get_seo_url mode="product" alias=$product.alias}"{/if}>
								{$product.name}
							</a>
						</div>

						{include file="global:shop2.v2-product-article.tpl"}
						
						{if $gift}
							<div class="cart-product-action"><strong>{#SHOP2_GIFT#}</strong></div>
						{/if}
	
						{assign var="stock_status" value=$product.stock_status}
	
						{if $stock_status == 'not_enough'}
							<div class="cart-product-action">
								<strong>{#SHOP2_PRODUCT_NOT_ENOUGH#|sprintf:$product.amount|htmlspecialchars}</strong>
								<div class="shop2-tooltip" data-tooltip="{#SHOP2_PRODUCT_NOT_ENOUGH_TOOLTIP#|sprintf:$product.amount|htmlspecialchars}"></div>
							</div>
						{elseif $stock_status == 'deleted'}
							{if !$gift}
								<div class="cart-product-action">
									<strong>{#SHOP2_PRODUCT_DELETED#}</strong>
									<div class="shop2-tooltip" data-tooltip="{#SHOP2_PRODUCT_DELETED_TOOLTIP#|htmlspecialchars}"></div>
								</div>
							{/if}
						{/if}
		
						{if $e.discounts_applied|@count}
							<div class="cart-product-action"><strong>{#SHOP2_ACTIONS#}:</strong>
								{foreach from=$e.discounts_applied item=discount name=product_discounts}
									{$discounts.$discount.discount_name}{if !$smarty.foreach.product_discounts.last}, {/if}
									{if $cart.all.$k.promo && $discounts.$discount.discount_kind == 8}
										<span class="discount-promo">({if $cart.all.$k.promo.main}{#SHOP2_PROMO_MAIN_TITLE#}{else}{#SHOP2_PROMO_TITLE#}{/if})</span>
									{/if}
								{/foreach}
							</div>
						{/if}
						
						{if $cart.bonusParams.enabled && $cart.bonusParams.is_accrual && isset($user.user_id) && $product.bonus_value > 0 && !$cart.bonusParams.accrual_mode}
							<div class="bonus-param">
								<span class="bonus-param__title">
									<i>
										<svg class="gr-svg-icon"><use xlink:href="#icon_shop_bonus"></use></svg><svg class="gr-svg-icon gr_small_icon"><use xlink:href=#icon_shop_bonus_small></use>
										</svg></i>Бонус за товар<span>:</span>
								</span>
								<span class="bonus-param__value">{$product.bonus_value}</span>
							</div>
						{/if}

						<div class="clear">&nbsp;</div>

						
					</div>
					
					<div class="cart-params">
						{if $shop2.my.gr_cart_options_more_btn!=""}
							{if $product.meta|@count>0 || $e.params[co]|@count > 0 || $product.vendor_name !=''}
								<div class="cart-params__more">
									<div class="cart-params__more-btn" data-text="{$shop2.my.gr_cart_options_more_btn}">
							            <span>
							            	<ins>
								            	{$shop2.my.gr_cart_options_more_btn}
								            </ins>
								            <i>
									            <svg class="gr-svg-icon">
									                <use xlink:href="#icon_shop_options_down"></use>
									            </svg>
									            <svg class="gr-svg-icon gr_small_icon">
									                <use xlink:href="#icon_shop_options_down_small"></use>
									            </svg>
								            </i>
								        </span>
							        </div>
						        </div>
					        {/if}
				        {/if}
						<div class="cart-params__body">
							<ul class="cart-params__list">
								{if $product.vendor_name !=''}
									<li class="gr_vendor_name">
										<div class="cart-params__item">
											<div class="cart-params__title">{$shop2.my.vendor_alias|default:#SHOP2_VENDOR#}</div>
											<div class="cart-params__value">
												<a href="{get_seo_url uri_prefix=$shop2.uri mode="vendor" alias=$product.vendor_alias}">{$product.vendor_name}</a>
											</div>
										</div>
									</li>
								{/if}
								{foreach from=$product.meta item=op key=kop}
									{if $op}
										{assign var="option" value=$custom_fields.$kop}
										{if $option.in_cart || !isset($option.in_cart)} {* проверка *}

											{if $option.type == 'text' || $option.type == 'int' || $option.type == 'float' || $option.type == 'textarea' || $option.type == 'html'}
												<li class="gr_type_text">
													<div class="cart-params__item">
														<div class="cart-params__title">{$option.name}:</div>
														<div class="cart-params__value">{$op} {$option.unit|default:""}</div>
													</div>
												</li>
											{elseif $option.type == 'checkbox'}
												<li class="gr_type_checkbox">
													<div class="cart-params__item">
														<div class="cart-params__title">{$option.name}:</div>
														<div class="cart-params__value">{if $op == 1}{#SHOP2_YES#}{else}{#SHOP2_NO#}{/if}</div>
													</div>
												</li>
											{elseif $option.type == 'color'}
												<li class="gr_type_color">
													<div class="cart-params__item">
														<div class="cart-params__title">{$option.name}:</div>
														<div class="cart-params__value">
															<ul class="shop2-color-pick">
																<li class="active-color"><span style="background-color: {$op};">&nbsp;</span></li>
															</ul>
														</div>
													</div>
												</li>
											{elseif $option.type == 'select'}
												<li class="gr_type_select">
													<div class="cart-params__item">
														<div class="cart-params__title">{$option.name}:</div>
														<div class="cart-params__value">{$option.options.$op}</div>
													</div>
												</li>
											{elseif $option.type == 'multiselect' && !$option.not_mod}
												<li class="gr_type_multiselect">
													<div class="cart-params__item">
														<div class="cart-params__title">{$option.name}:</div>
														<div class="cart-params__value">
															{foreach from=$op item=o_v  key=o_k name=foo}
																{$option.options.$o_v}{if !$smarty.foreach.foo.last}, {/if}
															{/foreach}
														</div>
													</div>
												</li>
											{elseif $option.type == 'image2'}
												<li class="gr_type_image2">
													<div class="cart-params__item">
														<div class="cart-params__title">{$option.name}:</div>
														<div class="cart-params__value gr_cart_param_img">
															<a href="{$IMAGES_DIR}{$op.filename}">
																{assign var="cart_other_image_width" value=$shop2.my.cart_other_image_width|default:225}
																{assign var="cart_other_image_height" value=$shop2.my.cart_other_image_height|default:225}
																<img src="{s3_img width=$cart_other_image_width height=$cart_other_image_height src=$op.filename method=$shop2.my.s3_img_method}" />
															</a>
														</div>
													</div>
												</li>
											{elseif $option.type == 'file2'}
												<li class="gr_type_file2">
													<div class="cart-params__item">
														<div class="cart-params__title">{$option.name}:</div>
														<div class="cart-params__value">
															<a href="{$FILES_DIR}{$op.filename}" class="file">
																<span>
																	{#SHOP2_DOWNLOAD#}
																	<i>
																		<svg class="gr-svg-icon">
																		    <use xlink:href="#icon_shop_file"></use>
																		</svg>
																		<svg class="gr-svg-icon gr_small_icon">
																		    <use xlink:href="#icon_shop_file_small"></use>
																		</svg>
																	</i>
																</span>
															</a>
														</div>
													</div>
												</li>
											{elseif ($option.type == 'color_ref' || $option.type == 'color2') && !$option.not_mod}
												<li class="gr_type_color_ref">
													<div class="cart-params__item">
														<div class="cart-params__title">{$option.name}:</div>
														<div class="cart-params__value">
															{include file="global:shop2.v2-color-ext.tpl" location="cart"}
														</div>
													</div>
												</li>
											{elseif $option.type == 'coordinates'}
												{if $op.x}
													<li class="gr_type_coordinates">
														<div class="cart-params__item">
															<div class="cart-params__title">{$option.name}:</div>
															<div class="cart-params__value">
																<a href="#" class="shop2-map-link" data-map="{$op|@json_encode|htmlspecialchars}" data-map-type="{$option.map_type|htmlspecialchars}">{$op.title|default:$product.name|htmlspecialchars}</a>
															</div>
														</div>
													</li>
												{/if}
											{/if}
										{/if}
									{/if}
								{/foreach}

								{foreach from=$e.params[co] item=o_v key=o_k}
									{if $o_k!='amount' && $o_v}
										<li class="gr-field-style">
											<div class="cart-params__item">
											    {assign var="option" value=$custom_fields.$o_k}
											    {assign var="parts" value=": "|explode:$o_v}
												{if $option.in_cart || !isset($option.in_cart)} {* проверка *}
												    {*доп. поля с выбором при заказе*}
												    {if $product.cf.$o_k.not_mod}
													    {include file="global:shop2.v2-product-options-not-mod.tpl"}
												    {else}
													    {if $parts|@count == 2 && $option.type == 'color_ref' && $option.not_mod}
														    <div class="cart-params__title">{$parts[0]}: </div>
														    <div class="cart-params__value">
													        	{include file="global:shop2.v2-color-ext.tpl" location="cart" op=$parts[1]}
													    	</div>
													    {else}
													    	<div class="cart-params__title">{$o_v}</div>
													    {/if}
													    <input name="amounts[{$k}][{$smarty.section.co.index}][{$o_k}]" type="hidden" value="{$o_v|htmlspecialchars}" />
												    {/if}
											    {/if}
										    </div>
										</li>
									{/if}
								{/foreach}
							</ul>
						</div>
					</div>
					
				</div>
			</div>
		</div>
		<div class="cart-products__right">
			{if $fix_discount}
				<div class="cart-price{if $show_discount && ($e.price > $e.price_discounted)} cart_old_price{/if}{if $gift} gift_price{/if}">
					{if $e.is_pre_order}
						<div class="cart-price__preorder">
							{$shop2.my.preorder_alias|default:#SHOP2_PREORDER2#}
						</div>
					{else}
						<div class="cart-price__current">
							<ins>{$e.price|price_convert}</ins> <span>{$currency.currency_shortname}</span>
						</div>
					{/if}
					{if $show_discount && ($e.price > $e.price_discounted)}
					    <div class="cart-price__discount">
						10 000{*тест*}<ins>{$e.price_discounted|price_convert:"":"true":"false":"2"}</ins> <span>{$currency.currency_shortname}</span>
						</div>
					{/if}
				</div>
			{else}
				<div class="cart-price{if $gift} gift_price{/if}">
					{if $e.is_pre_order}
						<div class="cart-price__preorder">
							{$shop2.my.preorder_alias|default:#SHOP2_REMOVEP2_PREORDER2#}
						</div>
					{else}
						<div class="cart-price__current">
							<ins>{$e.price|price_convert}</ins> <span>{$currency.currency_shortname}</span>
						</div>
					{/if}
				</div>
			{/if}
			<div class="cart-amount{if $gift} gift_price{/if}">
				{if $gift}
					<div class="cart-price__preorder">{$e.amount}</div>
				{else}
					{assign var="amount_min" value=$product.params.amount_min}
					{if $product.params.amount_min !="" || $product.params.amount_multiplicity !=""}
						{assign var="multiplicity" value=$product.params.amount_multiplicity|default:1}
					{/if}
					{if !$amount_min}{if $multiplicity}{assign var=amount_min value=$multiplicity}{else}{assign var="amount_min" value=$shop2.my.amount_default|default:1}{/if}{/if}
					<div class="cart-product-amount">
						<div class="shop2-product-amount gr_cart_amount">
							<button type="button" class="amount-minus">
								<svg class="gr-svg-icon">
								    <use xlink:href="#icon_shop_minus"></use>
								</svg>
								<svg class="gr-svg-icon gr_small_icon">
								    <use xlink:href="#icon_shop_minus_small"></use>
								</svg>
							</button>
								{assign var="max" value=$product.amount}
								{if ($shop2.product_amount_required == 0 && $product.pre_order == 0) || $product.pre_order == 4}
									{assign var="max" value=0}
								{/if}
								<input {if $shop2.product_amount_required=='1' || $product.buy_mode==1}data-max="{$max}"{/if} data-kind="{$product.kind_id}" name="{if $e.params}amounts[{$k}][{$smarty.section.co.index}][amount]{else}amounts[{$k}]{/if}" type="text" maxlength="4" value="{if $e.params[co].amount}{$e.params[co].amount}{else}{$e.amount}{/if}" data-min="{$amount_min}" data-multiplicity="{$multiplicity}" />
							<button type="button" class="amount-plus">
								<svg class="gr-svg-icon">
								    <use xlink:href="#icon_shop_plus"></use>
								</svg>
								<svg class="gr-svg-icon gr_small_icon">
								    <use xlink:href="#icon_shop_plus_small"></use>
								</svg>
							</button>
						</div>
						{if $multiplicity > 0}
							<div class="amount-min">
								{#FILTER_INT_FROM#|mb_strtolower} {$amount_min} {$product.params.unit}
								{#FILTER_BY#|mb_strtolower} {if $multiplicity}{$multiplicity}{else}1{/if} {$product.params.unit}
							</div>
						{/if}
					</div>
				{/if}
			</div>
			{if $gift}
				<div class="cart-sum{if $gift} gift_price{/if}">0 <span>{$currency.currency_shortname}</span></div>
			{else}
				<div class="cart-sum{if $gift} gift_price{/if}">
					{if $e.is_pre_order}
						<div class="cart-price__preorder">
							{$shop2.my.preorder_alias|default:#SHOP2_PREORDER2#}
						</div>
					{else}
						{if $fix_discount}
							{if $e.custom_params[co].amount}
								{$e.custom_params[co].total|price_convert} <span>{$currency.currency_shortname}</span>
							{else}
								{if count($discounts) > 0}
									{$e.discount_sum|price_convert} <span>{$currency.currency_shortname}</span>
								{else}
									{$e.sum|price_convert} <span>{$currency.currency_shortname}</span>
								{/if}
							{/if}
						{else}
							{if $e.params[co].amount}
								{$e.params[co].amount*$e.price|price_convert} <span>{$currency.currency_shortname}</span>
							{else}
								{if count($discounts) > 0}
									{$e.discount_sum|price_convert} <span>{$currency.currency_shortname}</span>
								{else}
									{$e.sum|price_convert} <span>{$currency.currency_shortname}</span>
								{/if}
							{/if}
						{/if}
					{/if}
				</div>
				<div class="cart-delete">
					{strip}
					<a title="{#SHOP2_REMOVE#}" href="{$shop2.uri}?mode=cart&action=del&kind_id={$k}" data-id="
						{if $e.params}
							{ldelim}'{$k}':{ldelim}
								{foreach from=$e.params[co] item=o_v key=o_k name=foo}
									{if $o_k == 'amount'}
										'amount': '0'
									{else}
										'{$o_k|htmlspecialchars}':'{$o_v|htmlspecialchars}'
									{/if}
									{if !$smarty.foreach.foo.last}, {/if}
								{/foreach}
							{rdelim}{rdelim}
						{else}
							{$k}
						{/if}">
						<span>
							<ins>{$shop2.my.gr_cart_delete_text|default:#SHOP2_REMOVE#}</ins>
							<i>
								<svg class="gr-svg-icon">
								    <use xlink:href="#icon_shop_del_cart"></use>
								</svg>
								<svg class="gr-svg-icon gr_small_icon">
								    <use xlink:href="#icon_shop_del_cart_small"></use>
								</svg>
							</i>
						</span>
					</a>
					{/strip}
				</div>
			{/if}
		</div>
	</div>
{/section}