{if !$data}
    {assign var="data" value=$shop2.products}    
{/if}
{if (($mode=='main' && $page.main) || ($page.main && $page.plugin_id != '16')) && $shop2_main_blocks && $shop2.my.gr_main_blocks_ajax}
	{capture assign="products"}
	    {foreach from=$data key=k item=product name=foo}
			<div class="product-item-wrap gr_empty_product" data-main-product-id="{$product.product_id}">
				{if $shop2.my.gr_product_quick_view}
					<div class="shop2-product-item hide">
	                    <div class="quick-view-trigger" data-url="{get_seo_url uri_prefix=$shop2.uri mode="product" alias=$product.alias}"></div>
					</div>
				{/if}
	        </div>
	    {/foreach}
	{/capture}
{else}
	{capture assign="products"}
	    {foreach from=$data key=k item=product name=foo}
	    	{if $wrap_product_item}
	    		<div class="product-item-wrap">
	    	{/if}
	        	{include file="global:shop2.v2-product-list-item.tpl" meta=$custom_fields}
	        {if $wrap_product_item}
	        	</div>
	        {/if}
	    {/foreach}
	{/capture}
{/if}

{if $data}
	
	{if $shop2.my.gr_product_list_titles}
		<div class="product-list-titles{if ($smarty.cookies.views && $smarty.cookies.views != 'list') || (!$smarty.cookies.views && $shop2.view != 'list')} hide{/if}">
			{if $shop2.my.gr_product_list_title}
				<div class="product-list-titles__item">{$shop2.my.gr_prod_list_title|default:'Товар'}</div>
			{/if}
			{if $shop2.my.gr_product_list_params}
				<div class="product-list-titles__item">{$shop2.my.gr_prod_list_params|default:'Параметры'}</div>
			{/if}
			{if $shop2.my.gr_product_list_price}
				<div class="product-list-titles__item">{$shop2.my.gr_prod_list_price|default:'Цена'}</div>
			{/if}
			{if $shop2.my.gr_product_list_amount}
				<div class="product-list-titles__item">{$shop2.my.gr_prod_list_amount|default:'Кол-во'}</div>
			{/if}
			{if $shop2.my.gr_product_list_buy}
				<div class="product-list-titles__item">{$shop2.my.gr_prod_list_buy|default:'Купить'}</div>
			{/if}
		</div>
	{/if}
	
    <div class="product-list{if ($smarty.cookies.views && $smarty.cookies.views == 'thumbs') || (!$smarty.cookies.views && $shop2.view=='thumbs')} thumbs{elseif ($smarty.cookies.views && $smarty.cookies.views == 'simple') || (!$smarty.cookies.views && $shop2.view=='simple')} simple{else} list{/if}{if $product_list_main} main_blocks_list{if $shop2.my.gr_product_columns_class}{if $site.product_settings.main_colums==1} main_columns_2{elseif $site.product_settings.main_colums==2} main_columns_3{elseif $site.product_settings.main_colums==3} main_columns_4{elseif $site.product_settings.main_colums==4} main_columns_5{elseif $site.product_settings.main_colums==5} main_columns_6{else} main_columns_4{/if}{/if}{/if}"
    	{if $shop2.my.gr_sliders_autoplay}
    		data-autoplay="{$site.product_settings.shop_sliders_autoplay|default:0}"
    	{/if}
    	{if $shop2.my.gr_thumbs_one_click}
    		data-popup-form="{if $shop2.my.gr_one_click_placeholder}{$one_click_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=1{else}{$one_click_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=0{/if}"
    		data-info-popup-form="{if $shop2.my.gr_one_click_placeholder}{$product_info_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=1{else}{$product_info_form.my_form.postform_api_uri}&param[tpl]=global:shop2.form.minimal.tpl&param[hide_title]=0&param[placeholdered_fields]=0{/if}"
    	{/if}
    	{if $shop2.my.gr_images_view}
    		data-images-view="{$site.product_settings.images_view|default:0}"
    	{/if}
    	{if $product_list_main}
    		data-main-items="{if $site.product_settings.main_colums==1}2{elseif $site.product_settings.main_colums==2}3{elseif $site.product_settings.main_colums==3}4{elseif $site.product_settings.main_colums==4}5{elseif $site.product_settings.main_colums==5}6{else}4{/if}"
    	{/if}
    	{if $site.product_settings.mode_catalog}
    		data-mode-catalog="{$site.product_settings.mode_catalog|default:0}"
    	{/if}
    	{if $shop2.my.gr_images_size}
    		data-images-size="{$site.product_settings.images_size|default:1}"
    	{/if}>
        {$products}
    </div>

{/if}