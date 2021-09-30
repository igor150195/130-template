{if $product.folders && $shop2.my.show_sections}

    {capture assign="product_folders"}{strip}
        {foreach from=$product.folders item=e key=k name=foo}
            {if $e._level}
                <a href="{get_seo_url uri_prefix=$shop2.uri mode="folder" alias=$e.alias}" class="shop-product-folders__item">
                    <span>
                        {$e.folder_name}
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
            {/if}
        {/foreach}
    {/strip}{/capture}
    
    {if !empty($product_folders)}
    	<div class="shop-product-folders">
			<div class="shop-product-folders__title"><span>{$shop2.my.located_in_sections_alias|default:#SHOP2_LOCATED_IN_SECTIONS#}</span></div>
			<div class="shop-product-folders__items">{$product_folders}</div>
        </div>
    {/if}

{/if}