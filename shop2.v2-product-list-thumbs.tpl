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

<form method="post" action="{$shop2.uri}?mode=cart&amp;action=add" accept-charset="utf-8" class="shop2-product-item product-item">
    
    <input type="hidden" name="kind_id" value="{$product.kind_id}" />
    <input type="hidden" name="product_id" value="{$product.product_id}" />
    <input type="hidden" name="meta" value="{$product.meta|@json_encode|escape}" />

    <div class="product-item__inner">

        <div class="product-item__top">
            {assign var=gr_thumbs_width value=$shop2.my.gr_thumbs_width|default:'450'}
            {assign var=gr_thumbs_height value=$shop2.my.gr_thumbs_height|default:'450'}

            <div class="gr-product-image{if !$product.image_filename} no-image{/if}{if $shop2.my.gr_images_size}{if $site.product_settings.images_size=="2" || $smarty.get.gr_images_size == "2"} gr_image_3x4{elseif $site.product_settings.images_size=="3" || $smarty.get.gr_images_size == "3"} gr_image_2x3{elseif $site.product_settings.images_size=="4" || $smarty.get.gr_images_size == "4"} gr_image_4x3{elseif $site.product_settings.images_size=="5" || $smarty.get.gr_images_size == "5"} gr_image_3x2{else} gr_image_1x1{/if}{/if}">
                <a href="{get_seo_url uri_prefix=$shop2.uri mode="product" alias=$product.alias}">
                    {if $product.image_filename}
                        {if $shop2.my.gr_images_lazy_load}
                            <img src="/g/spacer.gif" data-src="{s3_img width=$gr_thumbs_width height=$gr_thumbs_height src=$product.image_filename method=$shop2.my.s3_img_method}" class="gr_images_lazy_load{if $site.product_settings.images_view || $smarty.get.gr_images_view == '1'} gr_image_contain{/if}" alt="{$product.name|htmlspecialchars}" title="{$product.name|htmlspecialchars}" />
                        {else}
                            <img src="{s3_img width=$gr_thumbs_width height=$gr_thumbs_height src=$product.image_filename method=$shop2.my.s3_img_method}"{if $site.product_settings.images_view || $smarty.get.gr_images_view == '1'} class="gr_image_contain"{/if} alt="{$product.name|htmlspecialchars}" title="{$product.name|htmlspecialchars}" />
                        {/if}
                    {/if}
                </a>
                {if $shop2.my.gr_product_quick_view}
                    <div class="quick-view-trigger" data-url="{get_seo_url uri_prefix=$shop2.uri mode="product" alias=$product.alias}">
                        <span>
                            {$shop2.my.gr_product_quick_view_text|default:#GR_PRODUCT_QUICK_VIEW#}
                            <i>
                            	<svg class="gr-svg-icon">
	                                <use xlink:href="#icon_shop_preview"></use>
	                            </svg>
	                            <svg class="gr-svg-icon gr_small_icon">
	                                <use xlink:href="#icon_shop_preview_small"></use>
	                            </svg>
                            </i>
                        </span>
                    </div>
                {/if}
            </div>
            {if $product.new || $product.special || $product.flags || $discount.discount_type == "percent"}
                <div class="product-flags">
                    <div class="product-flags__left">
                        {if $product.new}<div class="product-flags__item new_item"><span>{$shop2.my.new_alias|default:'New'}</span></div>{/if}
                        {if $product.special}<div class="product-flags__item spec_item"><span>{$shop2.my.special_alias|default:'Sale'}</span></div>{/if}
                    </div>
                    {if $product.flags || $discount.discount_type == "percent"}
                        <div class="product-flags__right">
                            {foreach from=$product.flags item=flag_id key=k name=foo}
                                {assign var=flag value=$product_flag.$flag_id}
                                {assign var=spec value=$product.special}
                                {assign var=new value=$product.new}
                                {if $smarty.foreach.foo.iteration <= 3}
                                    {if $flag.flag_id != '1' && $flag.flag_id != '2'}
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
            {/if}
        </div>


        <div class="product-item__bottom">
            <div class="product-item__bottom-left">
                
                <div class="gr-product-name">
                    <a href="{get_seo_url uri_prefix=$shop2.uri mode="product" alias=$product.alias}">{$product.name}</a>
                </div>

                {if !$shop2.my.hide_vendor_name && $product.vendor_name !='' && $shop2.my.gr_thumbs_vendor}
                    <div class="gr-vendor-block">
                        <a href="{get_seo_url uri_prefix=$shop2.uri mode="vendor" alias=$product.vendor_alias}">{$product.vendor_name}</a>
                    </div>
                {/if}

                {include file="global:shop2.v2-rating.tpl"}

                {include file="global:shop2.v2-product-article.tpl"}

                {if $product.note}
                    <div class="gr-product-anonce">
                        {$product.note|nl2br}
                    </div>
                {/if}

                {if $show_price}
                    {include file="global:shop2.v2-product-actions.tpl"}
                {/if}

                {include file="global:shop2.v2-product-options.tpl" meta=$meta}
            </div>

            <div class="product-item__bottom-right">
            	
                <div class="product-additional{if !$show_price_on_request && $product.buy_mode == 1} price_on_request{/if}">
                    <div class="product-additional__top">
                        {if $show_price}
                            <div class="product-additional__top-left">
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
                                <div class="product-price">
                                    {if !$show_price_on_request}
                                        {include file="global:shop2.v2-product-price-old.tpl"}
                                    {/if}
                                    {include file="global:shop2.v2-product-price.tpl" obj=$product}
                                </div>
                            </div>
                        {/if}
                        <div class="product-additional__top-right">
                        	<div class="product-item-btns">
                        		{if $shop2.my.gr_info_form}
                        			{if $product.buy_mode!=1}
	                        			{include file="global:shop2.v2-amount-btn.tpl" class="product-amount"}
			                            {if !$show_price_on_request}
			                                {include file="global:shop2.v2-buy-btn.tpl" type=2}
			                            {/if}
		                            {/if}
		                            
		                            {if $product.buy_mode==1}
				                		<div class="buy-one-click buy_one_click product_info_form{if $site.product_settings.mode_catalog || $smarty.get.gr_mode_catalog == '1'} buy_one_click_action{/if}" 
				                        	data-remodal-target="buy-one-click"
				                        	data-product-link="{$smarty.server.PROTOCOL}://{$smarty.server.HTTP_HOST}{get_seo_url uri_prefix=$shop2.uri mode="product" alias=$product.alias}" 
				                        	data-product-name="{$product.name}"
				                            data-api-url="{if $shop2.my.gr_one_click_placeholder}{$product_info_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=1{else}{$product_info_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=0{/if}">
				                            {$shop2.my.gr_product_info_form|default:'Узнать о появлении'}
				                        </div>
			                       	{/if}
                        		{else}
		                            {include file="global:shop2.v2-amount-btn.tpl" class="product-amount"}
		                            {if !$show_price_on_request}
		                                {include file="global:shop2.v2-buy-btn.tpl" type=2}
		                            {/if}
	                            {/if}
	                            <div class="clear">&nbsp;</div>
                            </div>
                        </div>
                    </div>
                    <div class="product-additional__bottom">
                    	{if !$hide_gr_thumbs_one_click}
	                    	{if $shop2.my.gr_info_form}
	                    		{if $shop2.my.gr_thumbs_one_click && $product.buy_mode!=1}
		                            <div class="buy-one-click buy_one_click{if $site.product_settings.mode_catalog || $smarty.get.gr_mode_catalog == '1'} buy_one_click_action{/if}" 
		                            	data-remodal-target="buy-one-click"
		                            	data-product-link="{$smarty.server.PROTOCOL}://{$smarty.server.HTTP_HOST}{get_seo_url uri_prefix=$shop2.uri mode="product" alias=$product.alias}" 
			                        	data-product-name="{$product.name}"
		                                data-api-url="{if $shop2.my.gr_one_click_placeholder}{$one_click_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=1{else}{$one_click_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=0{/if}">
		                                {$shop2.my.gr_one_click_btn|default:'Купить в один клик'}
		                            </div>
		                        {/if}
	                    	{else}
		                        {if $shop2.my.gr_thumbs_one_click}
		                            <div class="buy-one-click buy_one_click{if $site.product_settings.mode_catalog || $smarty.get.gr_mode_catalog == '1'} buy_one_click_action{/if}" 
		                            	data-remodal-target="buy-one-click"
		                            	data-product-link="{$smarty.server.PROTOCOL}://{$smarty.server.HTTP_HOST}{get_seo_url uri_prefix=$shop2.uri mode="product" alias=$product.alias}" 
			                        	data-product-name="{$product.name}"
		                                data-api-url="{if $shop2.my.gr_one_click_placeholder}{$one_click_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=1{else}{$one_click_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=0{/if}">
		                                {$shop2.my.gr_one_click_btn|default:'Купить в один клик'}
		                            </div>
		                        {/if}
	                        {/if}
                        {/if}
                        
                        {if $shop2.my.gr_favorite}
                        	<div class="product-additional__add">
                        {/if}
                        	{include file="global:shop2.v2-product-compare-btn.tpl"}
                        {if $shop2.my.gr_favorite}
								{include file="global:shop2.v2-favorite.tpl" data=$product}
							</div>
						{/if}
                    </div>
                </div>

            </div>
        </div>
        
        {if $site.additional_work.schema_org && $shop2.my.gr_schema_org}
	        <div itemscope itemtype="{$smarty.server.PROTOCOL}://schema.org/Product" style="display: none;">
				<meta itemprop="sku" content="{$product.product_id}" />
				<meta itemprop="name" content="{$product.name}">
				{if $product.vendor_name}<meta itemprop="brand" content="{$product.vendor_name}">{/if}
				{if $product.image_filename}<meta itemprop="image" content="{$smarty.server.PROTOCOL}://{$site.domain_mask}{s3_img width=$gr_thumbs_width height=$gr_thumbs_height src=$product.image_filename method=$shop2.my.s3_img_method}">{/if}
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
    
</form >