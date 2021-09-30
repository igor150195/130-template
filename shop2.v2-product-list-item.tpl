{if $shop2.view=="thumbs"}
    {include file="global:shop2.v2-product-list-thumbs.tpl" meta=$meta}
{elseif $shop2.view=="simple"}
    {include file="global:shop2.v2-product-list-simple.tpl" meta=$meta}
{else}
    {include file="global:shop2.v2-product-list-price.tpl" meta=$meta}
{/if}

{*assign_hash var='shop2.gr_product_list_thumbs_version' value='global:shop2.v2-product-list-thumbs.tpl'}

{if $shop2.my.gr_product_list_thumbs}
	{assign_hash var='shop2.gr_product_list_thumbs_version' value=$shop2.my.gr_product_list_thumbs}
{/if}
{assign var=gr_thumbs_template_name value="`$shop2.gr_product_list_thumbs_version`"}

{include file=$gr_thumbs_template_name meta=$meta*}