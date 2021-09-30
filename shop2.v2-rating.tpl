{if $shop2.comment_settings.allow_rating == 1 || $shop2.comment_settings.allow_rating == 3}

	{if $collections_rating}
		{assign var=product value=$e}
	{/if}
	
	{capture assign="rating"}{strip}
		<div class="tpl-stars{if $product.rating.count==0 && $shop2.my.gr_rating_hide_no_amount} hide{/if}">
			<div class="tpl-rating" style="width: {$product.rating.value*20}%;"></div>
		</div>
	{/strip}{/capture}

	{strip}

		{if $mode == 'product'}
			<div class="tpl-rating-block{if $product.rating.count==0 && $shop2.my.gr_rating_hide_no_amount} hide{/if}">
				<span class="tpl-rating-title">{#SHOP2_RATING#}<ins>:</ins></span>
				{$rating}
				<div class="tpl-rating-votes"><span>{$product.rating.count|default:0|spellcount:#SHOP2_VOTE1#:#SHOP2_VOTE2#:#SHOP2_VOTE3#}</span></div>
			</div>
		{else}
			{$rating}
		{/if}

	{/strip}

	{if $shop2.comment_settings.enable_rating_microdata == 1 && $product.rating.value >= 1}
		<div itemscope itemtype="{$smarty.server.PROTOCOL}://schema.org/Product">
			<meta itemprop="name" content="{$product.name}">
			<meta itemprop="image" content="{$smarty.server.PROTOCOL}://{$site.domain_mask}{s3_img width=$shop2.thumb_width height=$shop2.thumb_height src=$product.image_filename}">
			<link itemprop="url" href="{$smarty.server.PROTOCOL}://{$site.domain_mask}{get_seo_url mode="product" alias=$product.alias}">
			{assign var="l_shop2_no_description" value="SHOP2_NO_DESCRIPTION"|l}
			<meta itemprop="description" content="{$product.note|default:$l_shop2_no_description}">

			<div itemprop="offers" itemscope itemtype="{$smarty.server.PROTOCOL}://schema.org/Offer">
				<meta itemprop="price" content="{$product.price}">
				<meta itemprop="priceCurrency" content="{$currency.currency_symbol}">
			</div>

			<div itemprop="aggregateRating" itemscope itemtype="{$smarty.server.PROTOCOL}://schema.org/AggregateRating">
				<meta itemprop="ratingValue" content="{$product.rating.value|round}">
				<meta itemprop="ratingCount" content="{$product.rating.count}">
				<meta itemprop="bestRating" content="5">
				<meta itemprop="worstRating" content="1">
			</div>
		</div>
	{/if}
{/if}