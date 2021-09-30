{strip} {*не должно быть пробелов вокруг стрипа - будут появляться вкладки*}
	{if $from == 'metatags'}
		{foreach from=$product.kinds item=knd}
			{if $knd.is_master}
				{if $knd.kind_id != $product.kind_id}
					{foreach from=$product.meta item=o_value key=o_name}
						{assign var="option" value=$meta.$o_name}
						{if $o_value!=$knd.meta.$o_name && $option.type != 'color' && $option.type != 'textarea' && $option.type != 'image2' && $option.type != 'file2'}
							{if $prev == 1}, {/if}
							{assign var="prev" value=1}
							{$option.name}{" "}
							{if $option.type == 'text' || $option.type == 'int' || $option.type == 'float'}
								{$o_value} {$option.unit}
							{elseif $option.type == 'checkbox'}
								{if $o_value == 1}{#SHOP2_YES#}{else}{#SHOP2_NO#}{/if}
							{elseif $option.type == 'select'}
								{$option.options.$o_value}
							{elseif $option.type == 'multiselect'}
								{assign var="delimiter" value=', '}
								{if $option.not_mod==1}
									{assign var="delimiter" value=' / '}
								{/if}
								{foreach from=$o_value item=ee key=kk name=foo}{$option.options.$ee}{if !$smarty.foreach.foo.last}{$delimiter}{/if}{/foreach}
							{elseif $option.type == 'color_ref' || $option.type == 'color2'}
								{if is_array($o_value)}
									{foreach from=$o_value item=val}
										{assign var="value" value=$option.options.$val}
										{if $value.text}
											{$value.text}
										{else}
											{foreach from=$value item=ee name=fooo}
												{$ee.text}{if !$smarty.foreach.fooo.last},{$s}{/if}
											{/foreach}
										{/if}
									{/foreach}
								{else}
									{assign var="value" value=$option.options.$o_value}
									{if $value.text}
										{$value.text}
									{else}
										{foreach from=$value item=ee name=fooo}
											{$ee.text}{if !$smarty.foreach.fooo.last},{$s}{/if}
										{/foreach}
									{/if}
								{/if}
							{/if}
						{/if}
					{/foreach}
				{/if}
			{/if}
		{/foreach}
	{else}

		{assign var="pr" value=$e}
		{if !$e.product_id}
			{assign var="pr" value=$product}
		{/if}

		{if $pr.kind_id == $product.kind_id}
			{assign var="isParams" value=1}
		{else}
			{assign var="isParams" value=0}
		{/if}

		{capture assign="params"}{strip}
			{foreach from=$meta item=option key=o_name}
				{assign var="o_value" value=$pr.meta.$o_name}
				
				{if $option && ($o_value || $o_value === '0')  && $option.in_params}
					
					{capture assign="param"}{strip}
						{if $option.type == 'text' || $option.type == 'int' || $option.type == 'float'}
							{$o_value} {$option.unit}
						{elseif $option.type == 'checkbox'}
							{if $o_value == 1}{#SHOP2_YES#}{else}{#SHOP2_NO#}{/if}
						{elseif $option.type == 'color'}
							<ul class="shop2-color-pick">
								<li class="active-color"><span style="background-color: {$o_value};">&nbsp;</span></li>
							</ul>
						{elseif $option.type == 'textarea'}
							{$o_value|nl2br}
						{elseif $option.type == 'select'}
							{$option.options.$o_value}
						{elseif $option.type == 'multiselect'}
							{assign var="delimiter" value=', '}
							{if $option.not_mod==1}
								{assign var="delimiter" value=' / '}
							{/if}
							{foreach from=$o_value item=ee key=kk name=foo}{$option.options.$ee}{if !$smarty.foreach.foo.last}{$delimiter}{/if}{/foreach}
						{elseif $option.type == 'image2'}
							{if $cf_images[$o_value.image_id]}
								<ul class="shop2-texture-pick">
									<li class="active-texture"><img src="{s3_img width=225 height=225 src=$o_value.filename method=$shop2.my.s3_img_method}" alt="{$option.name}" /></li>
								</ul>
							{/if}
						{elseif $option.type == 'file2'}
							<a href="{$FILES_DIR}{$o_value.filename}" class="file">
								<span>
									{#SHOP2_DOWNLOAD#}
									<i>
										<svg class="gr-svg-icon">
										    <use xlink:href="#icon_shop_file"></use>
										</svg>
										<svg class="gr-svg-icon gr_small_icon">
										    <use xlink:href="#icon_shop_file_small"></use>
										</svg>
									</i>
								</span>
							</a>
						{elseif $option.type == 'color_ref' || $option.type == 'color2'}
							{include file="global:shop2.v2-color-ext.tpl" location="params"}
						{elseif $option.type == 'coordinates'}
							{if $o_value.x}
								<a href="#" class="shop2-map-link" data-map="{$o_value|@json_encode|htmlspecialchars}" data-map-type="{$option.map_type|htmlspecialchars}">{$o_value.title|default:$pr.name|htmlspecialchars}</a>
							{/if}
						{/if}
					{/strip}{/capture}

					{if $param}
						{capture assign="param"}{strip}
							<div class="param-item{if $option.type == 'color' || $option.type == 'image2' || $option.type == 'color2' || $option.type == 'color_ref'} gr_color_option{/if} {cycle values="odd,even"}{if $option.type == 'color'} gr_type_color{elseif $option.type == 'image2'} gr_type_texture{/if}" data-option-type="{$option.type}">
								<div class="param-item__inner">
									<div class="param-title">{$option.name}</div>
									<div class="param-body">{$param}</div>
								</div>
							</div>
						{/strip}{/capture}
					
						{if $unique_values}
							{if $product.meta.$o_name!=$pr.meta.$o_name && $meta.$o_name.type!="html"}
								{$param}
							{/if}
						{else}
							{$param}
						{/if}

					{/if}

				{/if}
			{/foreach}
		{/strip}{/capture}

		{if $params}
			<div class="shop2-product-params">
				{$params}
			</div>
		{/if}
	{/if}
{/strip}