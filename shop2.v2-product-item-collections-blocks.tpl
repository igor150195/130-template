{assign var="collections_to_tabs" value=$shop2.my.collections_to_tabs}
{if !$collections_to_tabs}
	{assign var="collections_to_tabs" value=","|explode:""}
{/if}

<div class="collections">
	<div class="collections__inner">
		{foreach from=$collections item=collection key=k}
			<div class="kinds-block collections_block{if $shop2.my.gr_collections_columns_class}{if $site.product_settings.collection_columns==1} kind_columns_2{elseif $site.product_settings.collection_columns==2} kind_columns_3{elseif $site.product_settings.collection_columns==3} kind_columns_4{elseif $site.product_settings.collection_columns==4} kind_columns_5{elseif $site.product_settings.collection_columns==5} kind_columns_6{else} kind_columns_4{/if}{/if}{if $shop2.my.gr_collections_lazy} {$shop2.my.gr_collections_lazy_class|default:'gr_lazy_load_block'}{/if}"{if $shop2.my.gr_collections_lazy} data-func="{$shop2.my.gr_collections_func|default:'kindsBlock'}"{/if}>
				{if $collections.$k|@count>0 && !in_array($k, $collections_to_tabs)}
					<div class="kinds-block__title">
						<span>
							{if $k == 'accessory'}
								{$shop2.my.accessory|default:#SHOP2_ACCESSORIES#}
							{elseif $k == 'recommend'}
								{$shop2.my.recommend|default:#SHOP2_RECOMMENDED#}
							{elseif $k == 'kit'}
								{$shop2.my.kit|default:#SHOP2_KIT#}
							{elseif $k == 'similar'}
								{$shop2.my.similar|default:#SHOP2_SIMILAR#}
							{/if}
						</span>
					</div>
					<div class="kinds-block__items kinds_slider"{if $shop2.my.gr_sliders_autoplay} data-autoplay="{$site.product_settings.shop_sliders_autoplay|default:0}"{/if} data-kind-items="{if $site.product_settings.collection_columns==1}2{elseif $site.product_settings.collection_columns==2}3{elseif $site.product_settings.collection_columns==3}4{elseif $site.product_settings.collection_columns==4}5{elseif $site.product_settings.collection_columns==5}6{else}4{/if}">
						{foreach from=$collections.$k item=e}
							{assign var=gr_collections_item value=$shop2.my.gr_collections_item|default:'global:shop2.v2-product-item-collections.tpl'}
							{include file=$gr_collections_item show_params=$shop2.my.gr_collections_params|default:false e=$collection_products.$e buy=$shop2.my.buy_mod}
						{/foreach}
					</div>
				{/if}
			</div>
		{/foreach}
	</div>
</div>