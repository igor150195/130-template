{if $shop2.json.favorite_products == 1}
<div class="gr-favorite-btn-wrapper{if $favorite_location} {$favorite_location}{/if}{if $mode=='favorites'} favorites_mode{/if}">
    <label class="gr-favorite-btn{if $data.is_favorite} active{/if}">
        <span class="gr-favorite-btn__icon">
            <i class="gr-favorite-btn__add">
                <svg class="gr-svg-icon">
                    <use xlink:href="#icon_shop_favorite_add"></use>
                </svg>
                <svg class="gr-svg-icon gr_small_icon">
                    <use xlink:href="#icon_shop_favorite_add_small"></use>
                </svg>
            </i>
            <i class="gr-favorite-btn__added">
                <svg class="gr-svg-icon">
                    <use xlink:href="#icon_shop_favorite_added"></use>
                </svg>
                <svg class="gr-svg-icon gr_small_icon">
                    <use xlink:href="#icon_shop_favorite_added_small"></use>
                </svg>
            </i>
        </span>
        {if $data.is_favorite}
            <a href="{if $mode=='favorites'}javascript:void(0);{else}{get_seo_url mode='favorites' uri_prefix=$shop2.uri}{/if}" class="gr-favorite-btn__link">
                <ins>{if $mode=='favorites'}{#SHOP2_REMOVE#}{else}{#FORUM_FAVORITES#}{/if}</ins><span class="gr-favorite-btn__count">{$shop2.favorite_count}</span>
            </a>
        {else}
            <span class="gr-favorite-btn__text">В избранное</span>
        {/if}
    </label>
</div>
{/if}