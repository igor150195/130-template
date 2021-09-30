{if $location == 'product'}

	{if !$option.multi}
		
		{assign var="count" value=$o_values|@count}
		{assign var="all_values" value=$option.options}
		{assign var="value" value=$product.meta[$o_name]}

		{if $count == 1 || $option.render_type == 'color'}

			<ul class="shop2-color-ext-list">
				{foreach from=$o_values item=o_kinds key=o_value}
					{assign var="val" value=$all_values.$o_value}
					<li data-kinds="{','|implode:$o_kinds}" data-name="{$o_name}" data-value="{$o_value|escape}" style="{if $cf_images[$val.image.image_id]}background-image: url({s3_img src=$cf_images[$val.image.image_id] width=36 height=36 method="c"}){else}background-color:{$val.code}{/if}" {if $o_value == $value || in_array($o_value, $value)}class="shop2-color-ext-selected"{/if}>
						<span></span>
						<div>
							{if $cf_images[$val.image.image_id]}
								<img src="{s3_img src=$cf_images[$val.image.image_id] width=96 height=96 method="r"}" alt="">
							{else}
								<img src="/g/spacer.gif" style="background: {$val.code};" width="96" height="96" alt="">
							{/if}

							{$val.text}
						</div>
					</li>
				{/foreach}
			</ul>

		{else}

			<div class="shop2-color-ext-select">
				<i></i>
				<ul class="shop2-color-ext-options">
					{foreach from=$o_values item=o_kinds key=o_value}
						{assign var="val" value=$all_values.$o_value}
						<li data-kinds="{','|implode:$o_kinds}" data-name="{$o_name}" data-value="{$o_value|escape}" {if $o_value == $value || in_array($o_value, $value)}class="shop2-color-ext-selected"{/if}>
							<span style="{if $cf_images[$val.image.image_id]}background-image: url({s3_img src=$cf_images[$val.image.image_id] width=36 height=36 method="c"}){else}background-color:{$val.code}{/if}"><em></em></span>
							<div>{$val.text}</div>
							<ins></ins>
						</li>
					{/foreach}
				</ul>
			</div>

		{/if}

	{else}

		{assign var="values" value=$product.meta[$option.code]}
		{assign var="count" value=$values|@count}

		{if !$option.not_mod}

			<ul class="shop2-color-ext-multi">
				{foreach from=$values item=e key=k name=foo}
					{assign var="index" value=$smarty.foreach.foo.index}
					{assign var="val" value=$option.options[$e]}

					{if $index < 7}
						<li style="{if $cf_images[$val.image.image_id]}background-image:url({s3_img src=$cf_images[$val.image.image_id] width=96 height=96 method="c"}){else}background-color: {$val.code}{/if}">
							{if $index == 0}
								<ul>
									{foreach from=$values item=ee key=kk}
										{assign var="val2" value=$option.options[$ee]}
										<li>
											<span style="{if $cf_images[$val2.image.image_id]}background-image:url({s3_img src=$cf_images[$val2.image.image_id] width=96 height=96 method="c"}){else}background-color:{$val2.code}{/if}"></span>
											<div>{$val2.text}</div>
										</li>
									{/foreach}
								</ul>
							{elseif $index == 6}
								<ins></ins>
							{/if}
						</li>
					{/if}

				{/foreach}
			</ul>

		{else}

			{if $count == 1 || $option.render_type == 'color'}

				<ul class="shop2-color-ext-list">
					{foreach from=$values item=e key=k name=foo}
						{assign var="index" value=$smarty.foreach.foo.index}
						{assign var="val" value=$option.options[$e]}
						<li data-value="{$option.name}: {$e}" style="{if $cf_images[$val.image.image_id]}background-image: url({s3_img src=$cf_images[$val.image.image_id] width=36 height=36 method="c"}){else}background-color:{$val.code}{/if}" {if $index == 0}class="shop2-color-ext-selected"{/if}>
							<span></span>
							<div>
								{if $cf_images[$val.image.image_id]}
									<img src="{s3_img src=$cf_images[$val.image.image_id] width=96 height=96 method="r"}" alt="">
								{else}
									<img src="/g/spacer.gif" style="background: {$val.code};" width="96" height="96" alt="">
								{/if}

								{$val.text}
							</div>
							{if $index == 0}
								<input type="hidden" class="additional-cart-params" value="{$option.name|htmlspecialchars}: {$e}" name="{$option.code}">
							{/if}
						</li>
					{/foreach}
				</ul>

			{else}

				<div class="shop2-color-ext-select">
					<i></i>
					<ul class="shop2-color-ext-options">
						{foreach from=$values item=e key=k name=foo}
							{assign var="index" value=$smarty.foreach.foo.index}
							{assign var="val" value=$option.options[$e]}

							<li data-value="{$option.name}: {$e}" {if $index == 0}class="shop2-color-ext-selected"{/if}>
								<span style="{if $cf_images[$val.image.image_id]}background-image: url({s3_img src=$cf_images[$val.image.image_id] width=36 height=36 method="c"}){else}background-color:{$val.code}{/if}"><em></em></span>
								<div>{$val.text}</div>
								<ins></ins>
							</li>

							{if $index == 0}
								{capture assign="selected"}{strip}
									{$option.name|htmlspecialchars}: {$e}
								{/strip}{/capture}
							{/if}
						{/foreach}
					</ul>
					<input type="hidden" class="additional-cart-params" value="{$selected}" name="{$option.code}">
				</div>

			{/if}

		{/if}

	{/if}

{elseif $location == 'search'}

	<div class="shop-search-color-select">
		<ul class="shop-search-colors">
			{foreach from=$e.options item=val key=key name=foo_search}
				{assign var="index" value=$smarty.foreach.foo_search.index}
				<li data-name="s[{$e._sph_name}]" data-value="{$key}" {if $smarty.get.s[$e._sph_name][$index] == $key}class="shop2-color-ext-selected"{/if}>
					<input type="hidden" name="s[{$e._sph_name}][{$index}]" value="{$smarty.get.s[$e._sph_name][$index]}">
					<div class="shop-search-color-icon" style="{if $cf_images[$val.image.image_id]}background-image: url({s3_img src=$cf_images[$val.image.image_id] width=36 height=36 method="c"}){else}background-color:{$val.code}{/if}"><em></em></div>
					<div class="shop-search-color-title">{$val.text}</div>
				</li>
			{/foreach}
		</ul>
	</div>

{elseif $location == 'filter'}

	{assign var="n" value=$param.options|@count}
	
	<div class="shop2-color-ext-popup">
		<ul class="shop2-color-ext-list">
			{foreach from=$param.options item=val key=key name=foo}
				{assign var="index" value=$smarty.foreach.foo.index}
				<li class="shop2-color-ext-list__item{if $smarty.get.s[$param._sph_name][$index] == $key} shop2-color-ext-selected{/if}" data-name="s[{$param._sph_name}][{$index}]" data-value="{$key}" {include file="global:shop2.v2-facets-data.tpl" aggs=$aggs.cf field_name=$param._sph_name key=$key empty_class=$facets_empty_class is_empty_disabled=true}>
					<div class="filter-color-add">
						<ins class="filter-color-icon" style="{if $cf_images[$val.image.image_id]}background-image: url({s3_img src=$cf_images[$val.image.image_id] width=90 height=90 method="c"}){else}background-color:{$val.code}{/if}"></ins>
						<ins class="filter-color-subtitle">{$val.text}</ins>
					</div>
				</li>
			{/foreach}
		</ul>
		{if $shop2.my.gr_filter_color_btn}
			{assign var=gr_max_count value=$shop2.my.gr_filter_max_count|default:'5'}
	        {if $param.options|@count>$gr_max_count}
	            {assign var=colors_amount value=$param.options|@count}
	            {assign var=colors_total value=$colors_amount-$gr_max_count}
				<div class="gr-filter-more">
		            <span class="gr-filter-more__btn" data-text="{$shop2.my.gr_filter_select_btn|default:'Показать еще'}" data-fields-total="{$colors_total}">
		            	<span class="gr-filter-more__text">{$shop2.my.gr_filter_select_btn|default:'Показать еще'}</span>
		            	<span class="gr-filter-more__amount"> {$colors_total}</span>
		            </span>
		        </div>
	        {/if}
        {/if}
	</div>

{elseif $location == 'params' || $location == 'cart' || $location == 'compare'}
	
	{if $location == 'cart'}
		{assign var="o_value" value=$op}
	{/if}

	{if is_array($o_value)}

		{if $o_value|@count>1}
			
			<ul class="shop2-color-ext-multi">
				{foreach from=$o_value item=e key=k name=foo}
					{assign var="index" value=$smarty.foreach.foo.index}
					
					{if $index < 7}
						{assign var="val" value=$option.options[$e]}
						<li style="{if $cf_images[$val.image.image_id]}background-image:url({s3_img src=$cf_images[$val.image.image_id] width=96 height=96 method="c"}){else}background-color: {$val.code}{/if}">
							{if $index == 0}
								<ul>
									{foreach from=$o_value item=ee key=kk}
										{assign var="val2" value=$option.options[$ee]}
										<li>
											<span style="{if $cf_images[$val2.image.image_id]}background-image:url({s3_img src=$cf_images[$val2.image.image_id] width=96 height=96 method="c"}){else}background-color:{$val2.code}{/if}"></span>
											<div>{$val2.text}</div>
										</li>
									{/foreach}
								</ul>
							{elseif $index == 6}
								<ins></ins>
							{/if}
						</li>
					{/if}

				{/foreach}
			</ul>

		{else}

			<ul class="shop2-color-ext-list">
				{foreach from=$o_value item=e key=key name=foo}
					{assign var="val" value=$option.options[$e]}
					<li  style="{if $cf_images[$val.image.image_id]}background-image: url({s3_img src=$cf_images[$val.image.image_id] width=32 height=32 method="c"}){else}background-color:{$val.code}{/if}" class="shop2-color-ext-selected">
						<div>
							{if $cf_images[$val.image.image_id]}
								<img src="{s3_img src=$cf_images[$val.image.image_id] width=96 height=96 method="r"}" alt="">
							{else}
								<img src="/g/spacer.gif" style="background: {$val.code};" width="96" height="96" alt="">
							{/if}

							{$val.text}
						</div>
					</li>
				{/foreach}
			</ul>
			
		{/if}

	{else}
		{assign var="val" value=$option.options[$o_value]}

		<ul class="shop2-color-ext-list">
			<li style="{if $cf_images[$val.image.image_id]}background-image: url({s3_img src=$cf_images[$val.image.image_id] width=32 height=32 method="c"}){else}background-color:{$val.code}{/if}" class="shop2-color-ext-selected">
				<div>
					{if $cf_images[$val.image.image_id]}
						<img src="{s3_img src=$cf_images[$val.image.image_id] width=96 height=96 method="r"}" alt="">
					{else}
						<img src="/g/spacer.gif" style="background: {$val.code};" width="96" height="96" alt="">
					{/if}

					{$val.text}
				</div>
			</li>
		</ul>

	{/if}

{/if}