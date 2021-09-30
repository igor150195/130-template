{assign var="stripeClass" value="even"}
{capture assign="c_vendor"}{strip}
	{if !$shop2.my.hide_vendor_in_list || $mode == 'product'}

		{if $product.vendor_name}
			<div class="option-item even vendor_option_item">
				<div class="option-item__inner">
					<div class="option-title">{$shop2.my.vendor_alias|default:#SHOP2_VENDOR#}</div>
					<div class="option-body">
						{if !$shop2.my.hide_vendor_name}
							<a href="{get_seo_url uri_prefix=$shop2.uri mode="vendor" alias=$product.vendor_alias}">{$product.vendor_name}</a>
						{/if}
						
						{if $product.vendor_filename && $shop2.my.show_vendor_image}
							<div class="shop2-vendor">
								<a href="{get_seo_url uri_prefix=$shop2.uri mode="vendor" alias=$product.vendor_alias}">
									{assign var="width" value=$shop2.my.vendor_image_width|default:80}
									{assign var="height" value=$shop2.my.vendor_image_height|default:40}
									<img src="{s3_img src=$product.vendor_filename width=$width height=$height method="r"}" alt="{$product.vendor_name}" />
								</a>
							</div>
						{/if}
					</div>
				</div>
			</div>
		{/if}

	{/if}
{/strip}{/capture}

{capture assign="c_dimensions"}{strip}
	{if $shop2.my.show_dimensions_in_list}

		{if $product.length}
			{assign var="stripeClass" value="odd"}
			<div class="option-item odd">
				<div class="option-item__inner">
					<div class="option-title">{#SHOP2_PRODUCT_LENGTH#}</div>
					<div class="option-body">
						{$product.length}
					</div>
				</div>
			</div>
		{/if}

		{if $product.width}
			{assign var="stripeClass" value="even"}
			<div class="option-item even">
				<div class="option-item__inner">
					<div class="option-title">{#SHOP2_PRODUCT_WIDTH#}</div>
					<div class="option-body">
						{$product.width}
					</div>
				</div>
			</div>
		{/if}

		{if $product.height}
			<div class="option-item odd">
				<div class="option-item__inner">
					{assign var="stripeClass" value="odd"}
					<div class="option-title">{#SHOP2_PRODUCT_HEIGHT#}</div>
					<div class="option-body">
						{$product.height}
					</div>
				</div>
			</div>
		{/if}

	{/if}
{/strip}{/capture}

{if $shop2.my.hide_options_in_list && $mode != 'product'}
	
	{*не показываем параметры в списке, но мультиселекты с not_mod там должны быть - чтобы параметр добавлялся в корзину*}
	{if $product_refs[$product.product_id] && $meta}
		{foreach from=$product_refs[$product.product_id] item=o_values key=o_name}
			{assign var="option" value=$meta.$o_name}
			{if $option.in_card}
				{if $option.type == 'multiselect'}
					{assign var="values" value=$product.meta[$o_name]}
					{if $values}
						{assign var="all_values" value=$meta.$o_name.options}
						{if $option.not_mod}
							{foreach from=$values item=value key=k name=foo}
								{if $smarty.foreach.foo.first}
									<input type="hidden" name="{$o_name}" class="additional-cart-params" value="{$option.name|escape}: {$all_values.$value}">
								{/if}
							{/foreach}
						{/if}
					{/if}
				{/if}
			{/if}
		{/foreach}
	{/if}

	{if $c_vendor}
		<div class="shop2-product-options">{$c_vendor}</div>
	{/if}

{else} {*-----------------------------------------------------------------------------------------*}

	
	{capture assign="c_options"}{strip}
		{if !$shop2.my.gr_thumbs_vendor}
			{$c_vendor}
		{/if}

		{$c_dimensions}

		{if $product_refs[$product.product_id] && $meta}
			{foreach from=$product_refs[$product.product_id] item=o_values key=o_name}
				{assign var="option" value=$meta.$o_name}
				
				{if $option.code!='gr_samovyvoz_besplatno' && $option.code!='gr_besplatnaa_dostavka'}

					{if $option.type != 'html' && (($mode == 'product' && $option.in_detail) || ($mode != 'product' && $option.in_list))}
					{*if $option.type != 'html' && (($mode == 'product' && $option.in_detail) || ($mode != 'product' && $product.cf.$o_name.in_list)) актуальная проверка - эта, верхняя для локального сервака*}
					<div class="option-item{if $option.type == 'color' || $option.type == 'image2' || $option.type == 'color2' || $option.type == 'color_ref'} gr_color_option{/if} {if $stripeClass == "even"}{cycle values="odd,even"}{else}{cycle values="even,odd"}{/if}{if $option.type == 'color'} gr_type_color{elseif $option.type == 'image2'} gr_type_texture{elseif $option.type == 'select'} gr_type_select{/if}" data-option-type="{$option.type}">
							<div class="option-item__inner">
								{if $option.type == 'color'}
					
									{* цвет ------------------------------- *}
									{if $o_values}
										
											<div class="option-title">{$option.name}</div>
											<div class="option-body">
												<ul class="shop2-color-pick">
													{foreach from=$o_values item=o_kinds key=o_color}
														<li data-kinds="{','|implode:$o_kinds}" data-name="{$o_name}" data-value="{$o_color|escape}" class="{if $o_color==$product.meta[$o_name]}active-color{/if} shop2-cf">
															<span style="background-color: {$o_color};">&nbsp;</span>
														</li>
													{/foreach}
												</ul>
											</div>
										
									{/if}
									{* /----------------------------------- *}
								
								{elseif $option.type=='select'}
	
									{* список ----------------------------- *}
									{if $o_values}
										{assign var="all_values" value=$meta.$o_name.options}
										{assign var="value" value=$product.meta[$o_name]}
										{if $o_values|@count == 1}
											{* одно значение *}
											{*assign var="kind_id" value=$o_values.$value.0}
											{if $kind_id == $product.kind_id && $value*}
											{if $value}
												
													<div class="option-title">{$option.name}</div>
													<div class="option-body">{$all_values.$value}</div>
												
											{/if}
											{* /------------ *}
										{else}
											{* больше *}
											
												<div class="option-title">{$option.name}</div>
												<div class="option-body gr-field-style">
													<label class="gr-select-wrapper">
														<select name="cf_{$o_name}" class="shop2-cf small-field">
															{foreach from=$o_values item=o_kinds key=o_value}
																<option  value="{$o_value}" data-name="{$o_name}" data-value="{$o_value}" data-kinds="{','|implode:$o_kinds}" {if $value==$o_value}selected="selected"{/if}>{$all_values.$o_value}</option>
															{/foreach}
														</select>
													</label>
												</div>
											
											{* /------------ *}
										{/if}
									{/if}
									{* /----------------------------------- *}
	
								{elseif $option.type == 'multiselect'}
	
									{* мультиселект --------------------------- *}
									{assign var="values" value=$product.meta[$o_name]}
									{if $values}
										{assign var="all_values" value=$meta.$o_name.options}
										
											<div class="option-title">{$option.name}</div>
											<div class="option-body">
												{if $option.not_mod}
													{* без модификаций *}
														{if $values|@count == 1}
															{foreach from=$values item=value key=k name=foo}
																{$all_values.$value}
															{/foreach}
														{else}
															<label class="gr-select-wrapper">
																<select name="{$o_name}" class="additional-cart-params small-field">
																	{foreach from=$values item=value key=k name=foo}
																	<option value="{$option.name|escape}: {$all_values.$value|escape}">{$all_values.$value}</option>
																	{/foreach}
																</select>
															</label>										
														{/if}
													{* /-------------- *}
												{else}
													{foreach from=$values item=value key=k name=foo}
														{$all_values.$value}
														{if !$smarty.foreach.foo.last}, {/if}
													{/foreach}
												{/if}
											</div>
										
										{/if}
									{* /----------------------------------- *}
	
								{elseif $option.type == 'file2'}
	
									{* файл ------------------------------- *}
									{assign var="filename" value=$product.meta[$o_name].filename}
									{if $filename}
								
										<div class="option-title">{$option.name}</div>
										<div class="option-body">
											<a href="{$FILES_DIR}{$filename}" class="file">
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
										</div>
								
									{/if}
									{* /----------------------------------- *}
	
								{elseif $option.type == 'image2'}
	
									{* картинка --------------------------- *}
									{capture assign="images"}{strip}
										{foreach from=$o_values item=o_kinds key=o_value}
											{if $o_value && $cf_images.$o_value}
												<li data-kinds="{','|implode:$o_kinds}" data-name="{$o_name}" data-value="{$o_value|escape}" class="{if $o_value == $product.meta[$o_name].image_id}active-texture{/if} shop2-cf">
													<img src="{s3_img width=225 height=225 src=$cf_images.$o_value method=$shop2.my.s3_img_method}" alt="{$option.name}" />
												</li>
											{/if}
										{/foreach}
									{/strip}{/capture}
									
									{if $images}
									
										<div class="option-title">{$option.name}</div>
										<div class="option-body">
											<ul class="shop2-texture-pick">
												{$images}
											</ul>
										</div>
									
									{/if}
									{* /----------------------------------- *}
	
								{elseif $option.type == 'textarea'}
	
									{* текст --------------------------- *}
									{assign var="text" value=$product.meta[$o_name]}
									{if $text || $text === '0'}
									
										<div class="option-title">{$option.name}</div>
										<div class="option-body">
											{$text}
										</div>
									
									{/if}
									{* /----------------------------------- *}
	
								{elseif $option.type == 'checkbox'}
	
									{* галочка --------------------------- *}
									{assign var="checked" value=$product.meta[$o_name]}
									{if $checked}
										<div class="option-title">{$option.name}</div>
										<div class="option-body">
											{if $checked}{#SHOP2_YES#}{else}{#SHOP2_NO#}{/if}
										</div>
									{/if}
									{* /----------------------------------- *}
	
								{elseif $option.type == 'text' || $option.type=='int' || $option.type=='float'}
									
									{* строка или число ------------------ *}
									{if $product.meta[$o_name] || $product.meta[$o_name] === '0'}
										
											<div class="option-title">{$option.name}</div>
											<div class="option-body">{$product.meta[$o_name]} {$option.unit}</div>
										
									{/if}
									{* /---------------------------------- *}
	
								{elseif $option.type == 'color_ref' || $option.type == 'color2'}
									
									{assign var="values" value=$product.meta[$o_name]}
	
									{if $values|@count}
										<div class="option-title">{$option.name}</div>
										<div class="option-body">
											{include file="global:shop2.v2-color-ext.tpl" location="product"}
										</div>
									{/if}
	
								{elseif $option.type == 'coordinates'}
	
									{assign var="coords" value=$product.meta[$o_name]}
	
									{if $coords.x}
										<div class="option-title">{$option.name}</div>
										<div class="option-body">
											<a href="#" class="shop2-map-link" data-map="{$coords|@json_encode|htmlspecialchars}" data-map-type="{$option.map_type|htmlspecialchars}">{$coords.title|default:$product.name|htmlspecialchars}</a>
										</div>
									{/if}
	
								{/if}
							</div>
						</div>
					{/if}
				
				{/if}
				
			{/foreach}
		{/if}
	{/strip}{/capture}
	
	{if $c_options}
		<div class="gr-product-options">
			{if $shop2.my.gr_options_block_title!=""}
				<div class="gr-product-options__title">{$shop2.my.gr_options_block_title}</div>
			{/if}
			<div class="gr-options-container">
				<div class="shop2-product-options">
					{$c_options}
				</div>
			</div>
			{if $shop2.my.gr_options_more_btn!=""}
				<div class="gr-options-more">
					<div class="gr-options-more__btn" data-text="{$shop2.my.gr_options_more_btn}">
			            <span>
			            	<ins>
				            	{$shop2.my.gr_options_more_btn}
				            </ins>
				            <i>
				            	<svg class="gr-svg-icon">
					                <use xlink:href="#icon_shop_options_down"></use>
					            </svg>
					            <svg class="gr-svg-icon gr_small_icon">
					                <use xlink:href="#icon_shop_options_down_small"></use>
					            </svg>
				            </i>
				        </span>
			        </div>
		        </div>
	        {/if}
	        {if $shop2.my.gr_product_options_more_btn!="" && $mode=='product'}
				<div class="gr-product-options-more">
					<div class="gr-product-options-more__btn" data-text="{$shop2.my.gr_product_options_more_btn}">
			            <span>
			            	<ins>
				            	{$shop2.my.gr_product_options_more_btn}
				            </ins>
				            <i>
				            	<svg class="gr-svg-icon">
					                <use xlink:href="#icon_shop_options_down"></use>
					            </svg>
					            <svg class="gr-svg-icon gr_small_icon">
					                <use xlink:href="#icon_shop_options_down_small"></use>
					            </svg>
				            </i>
				        </span>
			        </div>
		        </div>
	        {/if}
        </div>
	{/if}

{/if}