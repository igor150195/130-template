{assign var="show_price" value=0}
{if !(!$user && $shop2.my.hide_prices_non_reg)}
	{assign var="show_price" value=1}
{/if}

{assign var="show_price_on_request" value=0}
{if $shop2.my.price_on_request && $e.buy_mode == 1 || ($shop2.price_on_request && $e.price == 0)}
    {assign var="show_price_on_request" value=1}
{/if}

{assign var="amount_min" value=$e.params.amount_min}
{assign var="multiplicity" value=$e.params.amount_multiplicity|default:1}
{if !$amount_min}{if $multiplicity}{assign var=amount_min value=$multiplicity}{else}{assign var="amount_min" value=$shop2.my.amount_default|default:1}{/if}{/if}

{if $e.price_old}
    {assign var="discount" value=$discounts[$e.discounts_applied.0]}
{/if}

<div class="kind-item">
	{if $buy}
		<form method="post" action="{$shop2.uri}?mode=cart&amp;action=add" accept-charset="utf-8" class="kind-item__form">
			<input type="hidden" name="kind_id" value="{$e.kind_id}" />
			<input type="hidden" name="product_id" value="{$e.product_id}" />
			<input type="hidden" name="meta" value="{$e.meta|@json_encode|escape}" />
			{if !$shop2.my.gr_collections_amount}
				<input type="hidden" name="amount" value="{$amount_min}" />
			{/if}
	{/if}
			<div class="kind-item__inner">
				<div class="kind-item__top">
					
					{assign var=collections_mod_width value=$shop2.my.collections_mod_width|default:'600'}
					{assign var=collections_mod_height value=$shop2.my.collections_mod_height|default:'600'}
					
					{assign var=collections_image_width value=$shop2.my.collections_image_width|default:'600'}
					{assign var=collections_image_height value=$shop2.my.collections_image_height|default:'600'}
					
					<div class="kind-image{if !$e.image_filename} no-image{/if}{if $shop2.my.gr_images_size}{if $site.product_settings.images_size=="2"} gr_image_3x4{elseif $site.product_settings.images_size=="3"} gr_image_2x3{elseif $site.product_settings.images_size=="4"} gr_image_4x3{elseif $site.product_settings.images_size=="5"} gr_image_3x2{else} gr_image_1x1{/if}{/if}">
						{if $shop2.my.gr_images_lazy_load}
							{if $mod_block}
								<a href="{get_seo_url mode="product" alias=$e.alias}">
									{if $e.image_filename}
										<img src="/g/spacer.gif" data-src="{s3_img width=$collections_mod_width height=$collections_mod_height src=$e.image_filename method=$shop2.my.s3_img_method}" class="gr_images_lazy_load{if $site.product_settings.images_view} gr_image_contain{/if}" alt="{$e.name}" title="{$e.name}"/>
									{/if}
								</a>
							{else}
								<a href="{get_seo_url mode="product" alias=$e.alias}">
									{if $e.image_filename}
										<img src="/g/spacer.gif" data-src="{s3_img width=$collections_image_width height=$collections_image_height src=$e.image_filename method=$shop2.my.s3_img_method}" class="gr_images_lazy_load{if $site.product_settings.images_view} gr_image_contain{/if}" alt="{$e.name}" title="{$e.name}"/>
									{/if}
								</a>
							{/if}
						{else}
							{if $mod_block}
								<a href="{get_seo_url mode="product" alias=$e.alias}">
									{if $e.image_filename}
										<img src="{s3_img width=$collections_mod_width height=$collections_mod_height src=$e.image_filename method=$shop2.my.s3_img_method}"{if $site.product_settings.images_view} class="gr_image_contain"{/if} alt="{$e.name}" title="{$e.name}"/>
									{/if}
								</a>
							{else}
								<a href="{get_seo_url mode="product" alias=$e.alias}">
									{if $e.image_filename}
										<img src="{s3_img width=$collections_image_width height=$collections_image_height src=$e.image_filename method=$shop2.my.s3_img_method}"{if $site.product_settings.images_view} class="gr_image_contain"{/if} alt="{$e.name}" title="{$e.name}"/>
									{/if}
								</a>
							{/if}
						{/if}

						{if $shop2.my.gr_product_quick_view}
		                    <div class="quick-view-trigger" data-url="{get_seo_url mode="product" alias=$e.alias}">
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
						
						{if $e.new || $e.special || $e.flags || $discount.discount_type == "percent"}
					        <div class="product-flags">
					            <div class="product-flags__left">
					                {if $e.new}<div class="product-flags__item new_item"><span>{$shop2.my.new_alias|default:'New'}</span></div>{/if}
					                {if $e.special}<div class="product-flags__item spec_item"><span>{$shop2.my.special_alias|default:'Sale'}</span></div>{/if}
					            </div>
					            {if $e.flags || $discount.discount_type == "percent"}
					                <div class="product-flags__right">
					                    {foreach from=$e.flags item=flag_id key=k name=foo}
					                        {assign var=flag value=$product_flag.$flag_id}
					                        {assign var=spec value=$e.special}
					                        {assign var=new value=$e.new}
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
					
					<div class="kind-name">
						<a href="{get_seo_url mode="product" alias=$e.alias}">{$e.name}</a>
					</div>

					{if !$shop2.my.hide_vendor_name && $e.vendor_name !='' && $shop2.my.gr_collections_vendor}
		                <div class="kind-vendor">
		                    <a href="{get_seo_url uri_prefix=$shop2.uri mode="vendor" alias=$e.vendor_alias}">{$e.vendor_name}</a>
		                </div>
		            {/if}

					{include file="global:shop2.v2-rating.tpl" collections_rating=true}

                    {include file="global:shop2.v2-product-article.tpl" collections_article=true}

					{if $e.note}
                        <div class="gr-product-anonce">
                            {$e.note|nl2br}
                        </div>
                    {/if}

                    {include file="global:shop2.v2-product-actions.tpl" collections_actions=true}
		            
					{if $show_params}
						{include file="global:shop2.v2-product-params.tpl" unique_values=$shop2.my.unique_values}
					{/if}
				</div>
				<div class="kind-item__bottom">
					<div class="kind-additional">
						<div class="kind-additional__top">
							{if $shop2.my.gr_amount_flag}
								{if $e.buy_mode==1}
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
								{elseif $e.buy_mode==2 || $e.buy_mode==3}
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
								    	<span>{$shop2.my.gr_has_amount|default:'В наличии'}{if $e.amount>0} <ins>{$e.amount}</ins>{/if}</span>
							    	</div>
								{/if}
							{/if}
							{if $show_price}
								<div class="kind-price">
									{if !$show_price_on_request}
										{include file="global:shop2.v2-product-price-old.tpl"}
									{/if}
									{include file="global:shop2.v2-product-price.tpl" obj=$e}
								</div>
							{/if}
						</div>
						<div class="kind-additional__btns">
							<div class="kind-additional__btns-inner">
								{if $shop2.my.gr_info_form}
									{if $e.buy_mode!=1}
										{if $shop2.my.gr_collections_amount}
											{include file="global:shop2.v2-amount-btn.tpl" collection_list_item=$e class="product-amount"}
										{/if}
										{if $buy && !$show_price_on_request}
											{include file="global:shop2.v2-buy-btn.tpl" type=2 collection_list_item=$e}
										{/if}
									{/if}
		                            
		                            {if $e.buy_mode==1}
				                		<div class="buy-one-click buy_one_click product_info_form{if $site.product_settings.mode_catalog || $smarty.get.gr_mode_catalog == '1'} buy_one_click_action{/if}" 
				                        	data-remodal-target="buy-one-click"
				                        	data-product-link="{$smarty.server.PROTOCOL}://{$smarty.server.HTTP_HOST}{get_seo_url mode="product" alias=$e.alias}" 
				                        	data-product-name="{$e.name}"
				                            data-api-url="{if $shop2.my.gr_one_click_placeholder}{$product_info_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=1{else}{$product_info_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=0{/if}">
				                            {$shop2.my.gr_product_info_form|default:'Узнать о появлении'}
				                        </div>
			                       	{/if}
								{else}
									{if $shop2.my.gr_collections_amount}
										{include file="global:shop2.v2-amount-btn.tpl" collection_list_item=$e class="product-amount"}
									{/if}
									{if $buy && !$show_price_on_request}
										{include file="global:shop2.v2-buy-btn.tpl" type=2 collection_list_item=$e}
									{/if}
								{/if}
								<div class="clear">&nbsp;</div>
							</div>
						</div>
						{if $shop2.my.gr_info_form}
							{if $shop2.my.gr_collections_one_click && $e.buy_mode!=1}
	                            <div class="buy-one-click buy_one_click{if $site.product_settings.mode_catalog} buy_one_click_action{/if}"
	                            	data-remodal-target="buy-one-click"
	                            	data-product-link="{$smarty.server.PROTOCOL}://{$smarty.server.HTTP_HOST}{get_seo_url mode="product" alias=$e.alias}" 
		                        	data-product-name="{$e.name}"
	                                data-api-url="{if $shop2.my.gr_one_click_placeholder}{$one_click_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=1{else}{$one_click_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=0{/if}">
	                                {$shop2.my.gr_one_click_btn|default:'Купить в 1 клик'}
	                            </div>
	                        {/if}
						{else}
							{if $shop2.my.gr_collections_one_click}
	                            <div class="buy-one-click buy_one_click{if $site.product_settings.mode_catalog} buy_one_click_action{/if}"
	                            	data-remodal-target="buy-one-click"
	                            	data-product-link="{$smarty.server.PROTOCOL}://{$smarty.server.HTTP_HOST}{get_seo_url mode="product" alias=$e.alias}" 
		                        	data-product-name="{$e.name}"
	                                data-api-url="{if $shop2.my.gr_one_click_placeholder}{$one_click_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=1{else}{$one_click_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=0{/if}">
	                                {$shop2.my.gr_one_click_btn|default:'Купить в 1 клик'}
	                            </div>
	                        {/if}
                        {/if}
                        {if $shop2.my.gr_favorite}
                        	<div class="kind-additional__add">
                        {/if}
							{if $shop2.my.gr_collections_compare}
								{include file="global:shop2.v2-product-compare-btn.tpl" product=$e}
							{/if}
						{if $shop2.my.gr_favorite}
								{include file="global:shop2.v2-favorite.tpl" data=$e}
							</div>
						{/if}
					</div>
				</div>
			</div>
	{if $buy}
		</form >
	{/if}
</div>