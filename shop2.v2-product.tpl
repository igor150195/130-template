{assign var="show_price" value=0}
{if !(!$user && $shop2.my.hide_prices_non_reg)}
    {assign var="show_price" value=1}
{/if}

{assign var="show_price_on_request" value=0}
{if $shop2.my.price_on_request && $product.buy_mode == 1 || ($shop2.price_on_request && $product.price == 0)}
    {assign var="show_price_on_request" value=1}
{/if}

{if $product.price_old}
    {assign var="discount" value=$discounts[$product.discounts_applied.0]}
{/if}

{if $smarty.get.product_preview}

	{include file="global:shop2.v2-product-preview.tpl"}
	
	
{elseif $smarty.get.products_only && !$smarty.get.product_preview}

	{include file="global:shop2.v2-product-quick-view.tpl"}
	
{else}

	<div class="card-page">
	    <div class="card-page__top">
	        
	        {if $shop2.next_prev_link && !$shop2.fallback_mode}
	            <div class="card-nav">
	            <!--noindex-->
	                <a rel="nofollow" class="card-nav__btn" href="{get_seo_url uri_prefix=$shop2.uri uri_postfix="prev" mode="product" alias=$product.alias}">
	                    <span>
	                        {$shop2.my.gr_product_nav_prev|default:#SHOP2_PRODUCT_PREV#}
	                        <i>
	                        	<svg class="gr-svg-icon">
		                            <use xlink:href="#icon_shop_card_prev"></use>
		                        </svg>
		                        <svg class="gr-svg-icon gr_small_icon">
		                            <use xlink:href="#icon_shop_card_prev_small"></use>
		                        </svg>
	                        </i>
	                    </span>
	                </a>
	            <!--/noindex-->
	            <!--noindex-->
	                <a rel="nofollow" class="card-nav__btn" href="{get_seo_url uri_prefix=$shop2.uri uri_postfix="next" mode="product" alias=$product.alias}">
	                    <span>
	                        {$shop2.my.gr_product_nav_next|default:#SHOP2_PRODUCT_NEXT#}
	                        <i>
	                        	<svg class="gr-svg-icon">
		                            <use xlink:href="#icon_shop_card_next"></use>
		                        </svg>
		                        <svg class="gr-svg-icon gr_small_icon">
		                            <use xlink:href="#icon_shop_card_next_small"></use>
		                        </svg>
	                        </i>
	                    </span>
	                </a>
	            <!--/noindex-->
	            </div>
	        {/if}
	
	        <form
	            method="post"
	            action="{$shop2.uri}?mode=cart&amp;action=add"
	            accept-charset="utf-8"
	            class="shop2-product">
	
	            <input type="hidden" name="kind_id" value="{$product.kind_id}"/>
	            <input type="hidden" name="product_id" value="{$product.product_id}"/>
	            <input type="hidden" name="meta" value='{$product.meta|@json_encode|escape}'/>
	    
	            <div class="shop2-product__left">
	                <div class="card-slider{if !$product.params.images} card_slider_no_thumbs{/if}">
	                    <div class="card-slider__body">
	                        {if $product.new || $product.special || $product.flags || $discount.discount_type == "percent"}
	                            <div class="product-flags">
	                                {if $product.new || $product.special}
	                                    <div class="product-flags__left">
	                                        {if $product.new}<div class="product-flags__item new_item"><span>{$shop2.my.new_alias|default:'New'}</span></div>{/if}
	                                        {if $product.special}<div class="product-flags__item spec_item"><span>{$shop2.my.special_alias|default:'Sale'}</span></div>{/if}
	                                    </div>
	                                {/if}
	                                {if $product.flags || $discount.discount_type == "percent"}
	                                    <div class="product-flags__right">
	                                        {foreach from=$product.flags item=flag_id key=k name=foo}
	                                            {assign var=flag value=$product_flag.$flag_id}
	                                            {assign var=spec value=$product.special}
	                                            {assign var=new value=$product.new}
	                                            {if $smarty.foreach.foo.iteration <= 3}
	                                                {if $flag.flag_id != '1' && $flag.flag_id != '2' && $flag.name}
	                                                    <div class="product-flags__item custom_item">
	                                                        <span style="background: {$flag.color};" data-custom-bg="{$flag.color}">{$flag.name}</span>
	                                                    </div>
	                                                {/if}
	                                            {/if}
	                                        {/foreach}
	                                        {if $discount.discount_type == "percent"}
											    <div class="product-flags__item action_item">
											        <span>-{$discount.value}%</span>
											    </div>
											{/if}
	                                    </div>
	                                {/if}
	                            </div>
	                        {/if} <!-- .product-flags -->
	                        
	                        {assign var=card_image_width value=$shop2.my.card_image_width|default:'750'}
	                        {assign var=card_image_height value=$shop2.my.card_image_height|default:'750'}
	
	                        <div class="card-slider__items{if !$product.params.images} card_slider_no_thumbs{/if}">
	                            <div class="card-slider__items-slider">
	                                <div class="card-slider__item">
	                                    <div class="card-slider__image{if !$product.image_filename} no-image{/if}{if $shop2.my.gr_images_size}{if $site.product_settings.images_size=="2"} gr_image_3x4{elseif $site.product_settings.images_size=="3"} gr_image_2x3{elseif $site.product_settings.images_size=="4"} gr_image_4x3{elseif $site.product_settings.images_size=="5"} gr_image_3x2{else} gr_image_1x1{/if}{/if}">
	                                        {if $product.image_filename}
	                                            <a href="{s3_img src=$product.image_filename}" class="gr-image-zoom">
                                                	<img src="{s3_img width=$card_image_width height=$card_image_height src=$product.image_filename method=$shop2.my.s3_img_method}" {if $site.product_settings.images_view} class="gr_image_contain"{/if} alt="{$product.name|htmlspecialchars}" title="{$product.name|htmlspecialchars}" />
	                                            </a>
	                                        {/if}
	                                    </div>
	                                </div>
	                                {if $product.params.images}
	                                    {foreach from=$product.params.images item=img key=k}
	                                        <div class="card-slider__item">
	                                            <div class="card-slider__image{if $shop2.my.gr_images_size}{if $site.product_settings.images_size=="2"} gr_image_3x4{elseif $site.product_settings.images_size=="3"} gr_image_2x3{elseif $site.product_settings.images_size=="4"} gr_image_4x3{elseif $site.product_settings.images_size=="5"} gr_image_3x2{else} gr_image_1x1{/if}{/if}">
	                                                <a href="{s3_img src=$img.filename}" class="gr-image-zoom">
	                                                	{if $shop2.my.gr_product_lazy_img}
	                                                		<img src="/g/spacer.gif" data-src="{s3_img width=$card_image_width height=$card_image_height src=$img.filename method=$shop2.my.s3_img_method}" class="{if $site.product_settings.images_view}gr_image_contain {/if}tns-lazy-img" alt="{$product.name|htmlspecialchars}" title="{$product.name|htmlspecialchars}" />
	                                                	{else}
	                                                    	<img src="{s3_img width=$card_image_width height=$card_image_height src=$img.filename method=$shop2.my.s3_img_method}" {if $site.product_settings.images_view} class="gr_image_contain"{/if} alt="{$product.name|htmlspecialchars}" title="{$product.name|htmlspecialchars}" />
	                                                    {/if}
	                                                </a>
	                                            </div>
	                                        </div>
	                                    {/foreach}
	                                {/if}
	                            </div>
	                        </div>
	                        
	                        {assign var=card_small_image_width value=$shop2.my.card_small_image_width|default:'120'}
	                        {assign var=card_small_image_height value=$shop2.my.card_small_image_height|default:'120'}
	                        
	                        {if $product.params.images}
	                            <div class="card-slider__thumbs">
	                                <div class="card-slider__thumbs-slider">
	                                    <div class="card-slider__thumb">
	                                        <div class="card-slider__thumb-img{if !$product.image_filename} no-image{/if}{if $shop2.my.gr_images_size}{if $site.product_settings.images_size=="2"} gr_image_3x4{elseif $site.product_settings.images_size=="3"} gr_image_2x3{elseif $site.product_settings.images_size=="4"} gr_image_4x3{elseif $site.product_settings.images_size=="5"} gr_image_3x2{else} gr_image_1x1{/if}{/if}">
	                                            {if $product.image_filename}
	                                                <a href="javascript:void(0);">
	                                                    <img src="{s3_img width=$card_small_image_width height=$card_small_image_height src=$product.image_filename method=$shop2.my.s3_img_method}" {if $site.product_settings.images_view} class="gr_image_contain"{/if} alt="{$product.name|htmlspecialchars}" title="{$product.name|htmlspecialchars}" />
	                                                </a>
	                                            {/if}
	                                        </div>
	                                    </div>
	                                    {foreach from=$product.params.images item=img key=k}
	                                        <div class="card-slider__thumb">
	                                            <div class="card-slider__thumb-img{if $shop2.my.gr_images_size}{if $site.product_settings.images_size=="2"} gr_image_3x4{elseif $site.product_settings.images_size=="3"} gr_image_2x3{elseif $site.product_settings.images_size=="4"} gr_image_4x3{elseif $site.product_settings.images_size=="5"} gr_image_3x2{else} gr_image_1x1{/if}{/if}">
	                                                <a href="javascript:void(0);">
	                                                    <img src="{s3_img width=$card_small_image_width height=$card_small_image_height src=$img.filename method=$shop2.my.s3_img_method}" {if $site.product_settings.images_view} class="gr_image_contain"{/if} title="{$product.name|htmlspecialchars}" alt="{$product.name|htmlspecialchars}" />
	                                                </a>
	                                            </div>
	                                        </div>
	                                    {/foreach}
	                                </div>
	                            </div>
	                        {/if}
	                    </div>
	                </div> <!-- .card-slider -->
	            </div>
	            <div class="shop2-product__right">
	                <div class="shop2-product-additional">
	                    <div class="shop2-product-additional__left">
	                        {if $shop2.my.gr_product_h1_in_block}
	                            <div class="gr-product-name">
	                                <h1>{$h1|default:$page.h1|default:$page.name}</h1>
	                            </div>
	                        {/if}
	                        <div class="shop2-product-additional__top">
	                            {include file="global:shop2.v2-product-article.tpl"}
	                            {include file="global:shop2.v2-rating.tpl"}
	                            {if !$shop2.my.hide_vendor_name && $product.vendor_name !='' && $shop2.my.gr_thumbs_vendor}
	                                <div class="gr-vendor-block">
	                                    <a href="{get_seo_url uri_prefix=$shop2.uri mode="vendor" alias=$product.vendor_alias}">{$product.vendor_name}</a>
	                                </div>
	                            {/if}
	                        </div>
	                        {if $product.note}
	                            <div class="gr-product-anonce">
	                                {$product.note|nl2br}
	                            </div>
	                        {/if}
	                        {include file="global:shop2.v2-product-options.tpl"}
	                    </div>
	                    <div class="shop2-product-additional__right">
	                        {include file="global:shop2.v2-product-actions.tpl"}
	                        <div class="form-additional{if !$shop2.json.compare} form_additional_no_compare{/if}">
	                        	<div class="form-additional__top">
		                        	{if $shop2.my.gr_amount_flag}
										{if $product.buy_mode==1}
										    <div class="gr-amount-flag no_amount">
										    	{if $shop2.my.amount_flag_icon}
													<i>
														<svg class="gr-svg-icon">
														    <use xlink:href="#icon_shop_not_available"></use>
														</svg>
														<svg class="gr-svg-icon gr_small_icon">
														    <use xlink:href="#icon_shop_not_available_small"></use>
														</svg>
													</i>
												{/if}
										    	<span>{$shop2.my.gr_no_amount|default:'Нет в наличии'}</span>
										    </div>
										{elseif $product.buy_mode==2 || $product.buy_mode==3}
										    <div class="gr-amount-flag pre_order">
										    	{if $shop2.my.amount_flag_icon}
													<i>
														<svg class="gr-svg-icon">
														    <use xlink:href="#icon_shop_pre_order"></use>
														</svg>
														<svg class="gr-svg-icon gr_small_icon">
														    <use xlink:href="#icon_shop_pre_order_small"></use>
														</svg>
													</i>
												{/if}
										    	<span>{$shop2.my.gr_has_amount_pre|default:'Предзаказ'}</span>
										    </div>
										{else}
										    <div class="gr-amount-flag has_amount">
										    	{if $shop2.my.amount_flag_icon}
													<i>
														<svg class="gr-svg-icon">
														    <use xlink:href="#icon_shop_available"></use>
														</svg>
														<svg class="gr-svg-icon gr_small_icon">
														    <use xlink:href="#icon_shop_available_small"></use>
														</svg>
													</i>
												{/if}
										    	<span>{$shop2.my.gr_has_amount|default:'В наличии'}{if $product.amount>0} <ins>{$product.amount}</ins>{/if}</span>
										    </div>
										{/if}
									{/if}
		                            {if $show_price}
		                                <div class="product-price">
		                                    {if !$show_price_on_request}
		                                        {include file="global:shop2.v2-product-price-old.tpl"}
		                                    {/if}
		                                    {include file="global:shop2.v2-product-price.tpl" obj=$product}
		                                </div>
		                            {/if}
	                            </div>
	                            {if $show_price}
	                                <div class="form-additional__btns">
	                                	{if $shop2.my.gr_info_form}
				                            {if $product.buy_mode==1}
					                            {if !empty($product_info_form.my_form.dictionaries)}
					                                <div class="buy-one-click buy_one_click product_info_form{if $site.product_settings.mode_catalog} buy_one_click_action{/if}" 
					                                	data-remodal-target="buy-one-click"
					                                	data-product-link="{$smarty.server.PROTOCOL}://{$smarty.server.HTTP_HOST}{get_seo_url uri_prefix=$shop2.uri mode="product" alias=$product.alias}" 
							                        	data-product-name="{$h1|default:$page.h1|default:$page.name}"
					                                    data-api-url="{if $shop2.my.gr_one_click_placeholder}{$product_info_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=1&param[product_name]={$product.name}{else}{$product_info_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=0&param[product_name]={$product.name}{/if}">
					                                    {$shop2.my.product_info_form|default:'Узнать о появлении'}
					                                </div>
					                            {/if}
					                        {else}
					                        	{include file="global:shop2.v2-amount-btn.tpl" class="product-amount"}
			                                    {if !$show_price_on_request}
			                                        {include file="global:shop2.v2-buy-btn.tpl" type=3}
			                                    {/if}
				                            {/if}
	                                	{else}
		                                    {include file="global:shop2.v2-amount-btn.tpl" class="product-amount"}
		                                    {if !$show_price_on_request}
		                                        {include file="global:shop2.v2-buy-btn.tpl" type=3}
		                                    {/if}
	                                    {/if}
	                                    <div class="clear">&nbsp;</div>
	                                </div>
	                            {/if}
	                            {if $shop2.my.gr_info_form}
	                            	{if $product.buy_mode!=1}
	                            		{if !empty($one_click_form.my_form.dictionaries)}
			                                <div class="buy-one-click buy_one_click{if $site.product_settings.mode_catalog} buy_one_click_action{/if}" 
			                                	data-remodal-target="buy-one-click"
			                                	data-product-link="{$smarty.server.PROTOCOL}://{$smarty.server.HTTP_HOST}{get_seo_url uri_prefix=$shop2.uri mode="product" alias=$product.alias}" 
					                        	data-product-name="{$h1|default:$page.h1|default:$page.name}"
			                                    data-api-url="{if $shop2.my.gr_one_click_placeholder}{$one_click_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=1&param[product_name]={$product.name}{else}{$one_click_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=0&param[product_name]={$product.name}{/if}">
			                                    {$shop2.my.gr_one_click_btn|default:'Купить в 1 клик'}
			                                </div>
			                            {/if}
	                            	{/if}
                            	{else}
	                            	{if !empty($one_click_form.my_form.dictionaries)}
		                                <div class="buy-one-click buy_one_click{if $site.product_settings.mode_catalog} buy_one_click_action{/if}" 
		                                	data-remodal-target="buy-one-click"
		                                	data-product-link="{$smarty.server.PROTOCOL}://{$smarty.server.HTTP_HOST}{get_seo_url uri_prefix=$shop2.uri mode="product" alias=$product.alias}" 
				                        	data-product-name="{$h1|default:$page.h1|default:$page.name}"
		                                    data-api-url="{if $shop2.my.gr_one_click_placeholder}{$one_click_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=1&param[product_name]={$product.name}{else}{$one_click_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=0&param[product_name]={$product.name}{/if}">
		                                    {$shop2.my.gr_one_click_btn|default:'Купить в 1 клик'}
		                                </div>
		                            {/if}
	                            {/if}
				            	
	                            {include file="global:shop2.v2-product-compare-btn.tpl"}
	                            {if $shop2.my.gr_favorite}
									{include file="global:shop2.v2-favorite.tpl" data=$product}
								{/if}
								
								{if $product.meta.gr_samovyvoz_besplatno!='' || $product.meta.gr_besplatnaa_dostavka!=''}
						            <div class="order-info-block">
						            	{if $product.meta.gr_samovyvoz_besplatno!=''}
							            	<div class="order-info-block__item gr_samovyvoz_besplatno">
							            		<div class="order-info-block__item-body">
								            		<div class="order-info-block__title">
								            			<span>
								            				<ins>{$meta.gr_samovyvoz_besplatno.name}</ins>
								            				<i>
																<svg class="gr-svg-icon gr_small_icon">
																	 <use xlink:href="#icon_shop_delivery_info_small"></use>
																</svg>
															</i>
								            			</span>
								            		</div>
								            		<div class="order-info-block__popup">
								            			<div class="order-info-block__close">
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
								            			<div class="order-info-block__subtitle">{$meta.gr_samovyvoz_besplatno.name}</div>
								            			<div class="order-info-block__desc">{$product.meta.gr_samovyvoz_besplatno}</div>
								            		</div>
							            		</div>
							            	</div>
						            	{/if}
						            	{if $product.meta.gr_besplatnaa_dostavka!=''}
							            	<div class="order-info-block__item gr_besplatnaa_dostavka">
							            		<div class="order-info-block__item-body">
								            		<div class="order-info-block__title">
								            			<span>
								            				<ins>{$meta.gr_besplatnaa_dostavka.name}</ins>
								            				<i>
								            					<svg class="gr-svg-icon gr_small_icon">
																	 <use xlink:href="#icon_shop_info2_small"></use>
																</svg>
								            				</i>
								            			</span>
								            		</div>
								            		<div class="order-info-block__popup">
								            			<div class="order-info-block__close">
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
								            			<div class="order-info-block__subtitle">{$meta.gr_besplatnaa_dostavka.name}</div>
								            			<div class="order-info-block__desc">{$product.meta.gr_besplatnaa_dostavka}</div>
								            		</div>
							            		</div>
							            	</div>
						            	{/if}
						            </div>
					            {/if}
								
	                            {if !$shop2.my.hide_share}
	                                <div class="shop-product-share">
	                                    <div class="shop-product-share__title">{$shop2.my.gr_product_share_title|default:#GR_SHOP2_SHARE#}</div>
	                                    <div class="shop-product-share__body">
	                                    	{if $shop2.my.gr_product_share_lazy}
		                                    	<noscript id="product-yashare-noscript">
			                                        <script src="https://yastatic.net/es5-shims/0.0.2/es5-shims.min.js"></script>
			                                        <script src="https://yastatic.net/share2/share.js"></script>
		                                        </noscript>
	                                        {else}
	                                        	<script src="https://yastatic.net/es5-shims/0.0.2/es5-shims.min.js"></script>
		                                        <script src="https://yastatic.net/share2/share.js"></script>
	                                        {/if}
	                                        <div class="ya-share2" data-services="vkontakte,facebook,odnoklassniki,twitter,viber,whatsapp,telegram"></div>
	                                    </div>
	                                </div> <!-- .shop-product-share -->
	                            {/if}
	                            
	                            {if $shop2.my.gr_product_print}
	                            <div class="gr-shop-print">
						            <div class="gr-shop-print__btn">
						            	<a href="{$smarty.server.PROTOCOL}://{$site.domain_mask}/{$product.alias}?print=1&products_only=1" target="_blank">
							            	<span>
							            		<ins>{#SHOP2_PRINT#}</ins>
								            	<i>
													<svg class="gr-svg-icon">
													    <use xlink:href="#icon_shop_print"></use>
													</svg>
													<svg class="gr-svg-icon gr_small_icon">
													    <use xlink:href="#icon_shop_print_small"></use>
													</svg>
												</i>
								            </span>
							            </a>
						            </div>
					            </div>
	                            {/if}
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </form ><!-- .shop2-product -->
	    </div>
	    
	    <div class="card-page__bottom">
	        
	        {assign var=gr_product_item_desc value=$shop2.my.gr_product_item_desc|default:'global:shop2.v2-product-item-desc.tpl'}
	        {include file=$gr_product_item_desc}
	        
	        {if $shop2.my.gr_comments_out}
	            {assign var=gr_comments_block value=$shop2.my.gr_comments_block|default:'global:shop2.v2-comments.tpl'}
	            {include file=$gr_comments_block comments=$product.comments.items form=$product.comments.fields comments_success=$product.comments.comments_success}
	        {/if}
	        
	        {if $tags_full}
	            <div class="shop-product-tags">
	                <div class="shop-product-tags__title"><span>{$shop2.my.gr_product_tags_title|default:#SHOP2_TAGS#}</span></div>
	                <div class="shop-product-tags__items">
	                    {foreach from=$tags_full item=e key=k name=foo}
	                        <a href="/{$e.url}" class="shop-product-tags__item">
	                            <span>
	                                {$e.tag|htmlspecialchars}
	                                <i>
		                                <svg class="gr-svg-icon">
		                                    <use xlink:href="#icon_shop_tag_arr"></use>
		                                </svg>
		                                <svg class="gr-svg-icon gr_small_icon">
		                                    <use xlink:href="#icon_shop_tag_arr_small"></use>
		                                </svg>
	                                </i>
	                            </span>
	                        </a>
	                    {/foreach}
	                </div>
	            </div>
	        {/if}
	        
	        {include file="global:shop2.v2-product-in-folders.tpl"}
	        
	        {assign var=gr_collections_blocks value=$shop2.my.gr_collections_blocks|default:'global:shop2.v2-product-item-collections-blocks.tpl'}
	        {include file=$gr_collections_blocks}
	        
	        {if !empty($one_click_form.my_form.dictionaries)}
	            <div class="remodal" data-remodal-id="buy-one-click" role="dialog" data-remodal-options="hashTracking: false">
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
	            </div>
	        {/if}
	        
	        {if $site.additional_work.schema_org && $shop2.my.gr_schema_org}
				<div itemscope itemtype="{$smarty.server.PROTOCOL}://schema.org/Product" style="display: none;">
					<meta itemprop="sku" content="{$product.product_id}" />
					<meta itemprop="name" content="{$product.name}">
					{if $product.vendor_name}<meta itemprop="brand" content="{$product.vendor_name}">{/if}
					{if $product.image_filename}<meta itemprop="image" content="{$smarty.server.PROTOCOL}://{$site.domain_mask}{s3_img width=$card_image_width height=$card_image_height src=$product.image_filename method=$shop2.my.s3_img_method}">{/if}
					{assign var="l_shop2_no_description" value="SHOP2_NO_DESCRIPTION"|l}
					<meta itemprop="description" content="{$product.note|default:$l_shop2_no_description}">
			
					<div itemprop="offers" itemscope itemtype="{$smarty.server.PROTOCOL}://schema.org/Offer">
						<meta itemprop="price" content="{$product.price}">
						<meta itemprop="priceCurrency" content="{$currency.currency_symbol}">
						{if $product.buy_mode==1}
							<link itemprop="availability" href="http://schema.org/OutOfStock"/>
						{else}
							<link itemprop="availability" href="http://schema.org/InStock"/>
						{/if}
						<link itemprop="url" href="{$smarty.server.PROTOCOL}://{$site.domain_mask}{get_seo_url mode="product" alias=$product.alias}">
					</div>
					{if $product.rating.value >= 1}
						<div itemprop="aggregateRating" itemscope itemtype="{$smarty.server.PROTOCOL}://schema.org/AggregateRating">
							<meta itemprop="ratingValue" content="{$product.rating.value|round}">
							<meta itemprop="ratingCount" content="{$product.rating.count}">
							<meta itemprop="bestRating" content="5">
							<meta itemprop="worstRating" content="1">
						</div> 
					{/if}
				</div>
			{/if}
	    </div>
	</div>
	
	{if $card_blocks|@count>0}
		<div class="card-blocks">
			{foreach from=$card_blocks item=e}
				{if $e.type == 1}
					{if !$e.hide_block && (!empty($e.blocks) || $e.title)}
						<div class="card-block card-block-1">
							<div class="card-block-1__inner">
								{if $e.title}<div class="card-block-1__header">{$e.title}</div>{/if}
								{if !empty($e.blocks)}
									<div class="card-block-1__items">
										{foreach from=$e.blocks item=j}
											<div class="card-block-1__item">
												{if $j.image.filename || $j.image.svg_body}
													<div class="card-block-1__icon">
														{if $j.image.svg_body}
															{$j.image.svg_body|htmlspecialchars_decode}
														{else}
															{if $shop2.my.gr_images_lazy_load}
															    <img src="/g/spacer.gif" data-src="{s3_img width=72 height=72 method=c src=$j.image.filename}" class="gr_images_lazy_load" alt="{$j.title}" title="{$j.title}" />
															{else}
																<img src="{s3_img width=72 height=72 method=c src=$j.image.filename}" alt="{$j.title}" title="{$j.title}" />
															{/if}
														{/if}
													</div>
												{/if}
												{if $j.title || $j.text}
													<div class="card-block-1__text">
														{if $j.title}<div class="card-block-1__title"{if !$j.image.filename} style="margin-top: 0;"{/if}>{$j.title}</div>{/if}
														{if $j.text}<div class="card-block-1__desc"{if !$j.image.filename && !$j.title} style="margin-top: 0;"{/if}>{$j.text}</div>{/if}
													</div>
												{/if}
											</div>
										{/foreach}
									</div>
								{/if}
							</div>
						</div>
					{/if}
				{elseif $e.type == 2}
					{if !$e.hide_block && (!empty($e.blocks) || $e.title)}
						<div class="card-block card-block-2">
							<div class="card-block-2__inner">
								{if $e.title}<div class="card-block-2__header">{$e.title}</div>{/if}
								{if !empty($e.blocks)}
									<div class="card-block-2__items">
										{foreach from=$e.blocks item=j key=card_block_2_key}
											<div class="card-block-2__item">
												<div class="card-block-2__num">{$card_block_2_key+1}</div>
												<div class="card-block-2__text">
													{if $j.title}<div class="card-block-2__title">{$j.title}</div>{/if}
													{if $j.text}<div class="card-block-2__desc">{$j.text}</div>{/if}
												</div>
											</div>
										{/foreach}
									</div>
								{/if}
							</div>
						</div>
					{/if}
				{elseif $e.type == 3}
					{if !$e.hide_block && (!empty($e.blocks) || $e.title)}
						<div class="card-block card-block-3">
							<div class="card-block-3__inner">
								{if $e.title}<div class="card-block-3__header">{$e.title}</div>{/if}
								{if !empty($e.blocks)}
									<div class="card-block-3__items">
										{foreach from=$e.blocks item=j}
											<div class="card-block-3__item">
												{if $j.image.filename}
													<div class="card-block-3__pic">
														{if $shop2.my.gr_images_lazy_load}
														    <img src="/g/spacer.gif" data-src="{s3_img width=220 height=220 method=c src=$j.image.filename}" class="gr_images_lazy_load" alt="{$j.title}" title="{$j.title}" />
														{else}
															<img src="{s3_img width=220 height=220 method=c src=$j.image.filename}" alt="{$j.title}" title="{$j.title}" />
														{/if}
													</div>
												{/if}
												<div class="card-block-3__text"{if !$j.image.filename} style="width: 100%;"{/if}>
													{if $j.title}<div class="card-block-3__title">{$j.title}</div>{/if}
													{if $j.text}<div class="card-block-3__desc">{$j.text}</div>{/if}
												</div>
											</div>
										{/foreach}
									</div>
								{/if}
							</div>
						</div>
					{/if}
				{/if}
			{/foreach}
		</div>
	{/if}
	
{/if}