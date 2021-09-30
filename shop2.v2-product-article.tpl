{if !$shop2.my.hide_article}

	{if $collections_article}
		{assign var=product value=$e}
	{/if}

	{assign var="cls" value="product-article"}
	{if $mode == 'cart'}
		{assign var="cls" value="cart-product-article"}
	{elseif $mode == 'product'}
		{assign var="cls" value="shop2-product-article"}
	{/if}

	{capture assign="article"}
		<div class="{$cls}"><span>{#SHOP2_ARTICLE#}:</span> {$product.article|default:#SHOP2_NO#}</div>
	{/capture}

	{if $shop2.my.hide_article_if_blank && !$product.article}
		{assign var="article" value=""}
	{/if}

	{if $shop2.view == 'list'}
		{if $shop2.my.pricelist_article_in_column}
			{if $is_column}
				<div class="td column-article">
					{$product.article|default:#SHOP2_NO#}
				</div>
			{/if}
		{else}
			{if !$is_column}
				{$article}
			{/if}
		{/if}
	{else}
		{$article}
	{/if}
{/if}