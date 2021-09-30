{assign var="hide_in_search" value=$shop2.my.hide_in_search}
{if !$hide_in_search}
	{assign var="hide_in_search" value=","|explode:""}
{/if}

{assign var="show_price" value=0}
{if !(!$user && $shop2.my.hide_prices_non_reg)}
	{assign var="show_price" value=1}
{/if}

<div class="shop2-block search-form">
	<div class="search-form__inner">
		<div class="search-form__header">{$shop2.my.gr_search_form_title|default:'Поиск'}</div>
		<div class="search-rows">
			<form class="search-rows__form" action="{get_seo_url uri_prefix=$shop2.uri mode="search"}" enctype="multipart/form-data">
				<input type="hidden" name="sort_by" value="{$sort_by|htmlspecialchars|default:''}"/>
				
				{if !in_array("price", $hide_in_search) && $show_price}
					<div class="search-rows__row gr-field-style float_row price_row">
						<div class="row-title field-title active">
							<span>
								{#SHOP2_PRICE#} ({$shop2.currency_shortname})<ins>:</ins>
								<span class="row-title__icon row_title_icon">
                                    <svg class="gr-svg-icon gr_filter_plus">
                                        <use xlink:href="#icon_shop_filter_plus"></use>
                                    </svg>
                                    <svg class="gr-svg-icon gr_filter_minus">
                                        <use xlink:href="#icon_shop_filter_minus"></use>
                                    </svg>
                                </span>
							</span>
						</div>
						<div class="row-body">
							<label class="input-from">
								<span class="input-from__title">{#SHOP2_FROM#}<ins>:</ins></span>
								<input name="s[price][min]" type="text" size="5" class="small" value="{$search_params.price.min|escape|default:''}" {if !$shop2.my.gr_search_form_range_slider}placeholder="{#SHOP2_FROM#}"{/if} data-range_min="{$shop2.my.gr_search_form_range_min|default:'0'}" oninput="this.value = this.value.replace (/\D/, '')"/>
							</label>
							<label class="input-to">
								<span class="input-to__title">{#SHOP2_TO#}<ins>:</ins></span>
								<input name="s[price][max]" type="text" size="5" class="small" value="{$search_params.price.max|escape|default:''}" {if !$shop2.my.gr_search_form_range_slider}placeholder="{#SHOP2_TO#}"{/if} data-range_max="{$shop2.my.gr_search_form_range_max|default:'200000'}" oninput="this.value = this.value.replace (/\D/, '')"/>
							</label>
							{if $shop2.my.gr_search_form_range_slider}
                                <div class="input_range_slider"></div>
                            {/if}
						</div>
					</div>
				{/if}

				{if !in_array("name", $hide_in_search)}
					<div class="search-rows__row gr-field-style">
						<div class="row-title field-title">
							<span>
								{#SHOP2_PRODUCT_NAME#}<ins>:</ins>
								<span class="row-title__icon row_title_icon">
                                    <svg class="gr-svg-icon gr_filter_plus">
                                        <use xlink:href="#icon_shop_filter_plus"></use>
                                    </svg>
                                    <svg class="gr-svg-icon gr_filter_minus">
                                        <use xlink:href="#icon_shop_filter_minus"></use>
                                    </svg>
                                </span>
							</span>
						</div>
						<div class="row-body">
							<input type="text" name="s[name]" size="20" id="shop2-name" value="{$search_params.name|escape}" />
						</div>
					</div>
				{/if}

				{if !in_array("article", $hide_in_search) && !$shop2.my.hide_article}
					<div class="search-rows__row gr-field-style">
						<div class="row-title field-title">
							<span>
								{#SHOP2_ARTICLE#}<ins>:</ins>
								<span class="row-title__icon row_title_icon">
                                    <svg class="gr-svg-icon gr_filter_plus">
                                        <use xlink:href="#icon_shop_filter_plus"></use>
                                    </svg>
                                    <svg class="gr-svg-icon gr_filter_minus">
                                        <use xlink:href="#icon_shop_filter_minus"></use>
                                    </svg>
                                </span>
							</span>
						</div>
						<div class="row-body">
							<input type="text" name="s[article]" id="shop2-article" value="{$search_params.article|escape}" />
						</div>
					</div>
				{/if}

				{if !in_array("text", $hide_in_search)}
					<div class="search-rows__row gr-field-style">
						<div class="row-title field-title">
							<span>
								{#SHOP2_TEXT#}<ins>:</ins>
								<span class="row-title__icon row_title_icon">
                                    <svg class="gr-svg-icon gr_filter_plus">
                                        <use xlink:href="#icon_shop_filter_plus"></use>
                                    </svg>
                                    <svg class="gr-svg-icon gr_filter_minus">
                                        <use xlink:href="#icon_shop_filter_minus"></use>
                                    </svg>
                                </span>
							</span>
						</div>
						<div class="row-body">
							<input type="text" name="search_text" size="20" id="shop2-text"  value="{$search_text|escape}" />
						</div>
					</div>
				{/if}

				
				{if $folders_shared && !in_array("folders", $hide_in_search)}
					<div class="search-rows__row gr-field-style">
						<div class="row-title field-title">
							<span>
								{#SHOP2_SELECT_FOLDER#}<ins>:</ins>
								<span class="row-title__icon row_title_icon">
                                    <svg class="gr-svg-icon gr_filter_plus">
                                        <use xlink:href="#icon_shop_filter_plus"></use>
                                    </svg>
                                    <svg class="gr-svg-icon gr_filter_minus">
                                        <use xlink:href="#icon_shop_filter_minus"></use>
                                    </svg>
                                </span>
							</span>
						</div>
						<div class="row-body">
							<label class="gr-select-wrapper">
								<select name="s[folder_id]" id="s[folder_id]">
									<option value="">{#SHOP2_ALL#}</option>
									{foreach from=$folders_shared item=e key=k}
										{if $e._left>1}
											<option value="{$e.folder_id}" {if $search_params.folder_ids[0] == $e.folder_id || $search_params.folder_id == $e.folder_id}selected="selected"{/if}>
												{section name=foo loop=`$e._level-1`}&raquo;{/section} {$e.folder_name}
											</option>
										{/if}
									{/foreach}
								</select>
							</label>
						</div>
					</div>

					<div id="shop2_search_custom_fields"></div>
				{/if}
			
				{if $shop2.global_params && !in_array("globals", $hide_in_search)}
					<div id="shop2_search_global_fields">
						{include file="global:shop2.v2-search-form-custom-fields.tpl" data=$shop2.global_params}
					</div>
				{/if}
				
				{if $vendors_shared && !in_array("vendors", $hide_in_search)}
					<div class="search-rows__row shop2-search-vendors gr-field-style">
						<div class="row-title field-title">
							<span>
								{#SHOP2_VENDOR#}<ins>:</ins>
								<span class="row-title__icon row_title_icon">
                                    <svg class="gr-svg-icon gr_filter_plus">
                                        <use xlink:href="#icon_shop_filter_plus"></use>
                                    </svg>
                                    <svg class="gr-svg-icon gr_filter_minus">
                                        <use xlink:href="#icon_shop_filter_minus"></use>
                                    </svg>
                                </span>
							</span>
						</div>
						<div class="row-body tpl-field type-checkbox">
							<ul>
								{foreach from=$vendors_shared item=e name=vendors_foo}
									{assign var="index" value=$smarty.foreach.vendors_foo.index}
									<li data-name="s[vendor_id][{$index}]" data-value="{$e.vendor_id}">
										<label>
											<input type="checkbox" name="s[vendor_id][{$index}]" value="{$e.vendor_id}" {if $search_params.vendor_id[$index] == $e.vendor_id}checked="checked"{/if}>
											<span>{$e.name}</span>
										</label>
									</li>
								{/foreach}
							</ul>
							{assign var=gr_max_count value=$shop2.my.gr_filter_max_count|default:'5'}
							{if $vendors_shared|@count>$gr_max_count}
							    {assign var=vendors_amount value=$vendors_shared|@count}
							    {assign var=vendors_total value=$vendors_amount-$gr_max_count}
							    <div class="gr-filter-more">
							        <span class="gr-filter-more__btn" data-text="{$shop2.my.gr_filter_select_btn|default:'Показать еще'}" data-fields-total="{$vendors_total}"><span class="gr-filter-more__text">{$shop2.my.gr_filter_select_btn|default:'Показать еще'}</span><span class="gr-filter-more__amount"> {$vendors_total}</span></span>
							    </div>
							{/if}
						</div>
					</div>
				{/if}

				{foreach from=$product_flag item=flag}
					{if ($flag.flag_id == 2 && !in_array("special", $hide_in_search)) || ($flag.flag_id == 1 && !in_array("new", $hide_in_search)) || ($flag.flag_id != '1' && $flag.flag_id != '2')}
					    <div class="search-rows__row gr-field-style">
					        <div class="row-title field-title">
					        	<span>
					        		{$flag.name}<ins>:</ins>
					        		<span class="row-title__icon row_title_icon">
	                                    <svg class="gr-svg-icon gr_filter_plus">
	                                        <use xlink:href="#icon_shop_filter_plus"></use>
	                                    </svg>
	                                    <svg class="gr-svg-icon gr_filter_minus">
	                                        <use xlink:href="#icon_shop_filter_minus"></use>
	                                    </svg>
	                                </span>
					        	</span>
					        </div>
					        <div class="row-body">
					            {assign var=flag_key value=$flag.flag_id}
					            <label class="gr-select-wrapper">
						            <select name="s[flags][{$flag.flag_id}]">
							            <option value=""{if $search_params.flags.$flag_key === ''} selected="selected"{/if}>{#SHOP2_ALL#}</option>
							            <option value="1"{if $search_params.flags.$flag_key === '1'} selected="selected"{/if}>{#SHOP2_YES#}</option>
							            <option value="0"{if $search_params.flags.$flag_key === '0'} selected="selected"{/if}>{#SHOP2_NO#}</option>
							        </select>
						        </label>
					        </div>
					    </div>
			    	{/if}
				{/foreach}

				{if !in_array("per_page", $hide_in_search)}
					<div class="search-rows__row gr-field-style">
						<div class="row-title field-title">
							<span>
								{#SHOP2_RESULTS_PER_PAGE#}<ins>:</ins>
								<span class="row-title__icon row_title_icon">
                                    <svg class="gr-svg-icon gr_filter_plus">
                                        <use xlink:href="#icon_shop_filter_plus"></use>
                                    </svg>
                                    <svg class="gr-svg-icon gr_filter_minus">
                                        <use xlink:href="#icon_shop_filter_minus"></use>
                                    </svg>
                                </span>
							</span>
						</div>
						<div class="row-body">
							<label class="gr-select-wrapper">
								<select name="s[products_per_page]">
									{assign var="cur_v" value=$search_params.products_per_page|default:$shop2.products_per_page}
									{section name=foo start=5 loop=100 step=15}
										{assign var="v" value=$smarty.section.foo.index}
										<option value="{$v|escape}"{if $v == $cur_v} selected="selected"{/if}>{$v}</option>
									{/section}
								</select>
							</label>
						</div>
					</div>
				{/if}

				<div class="search-rows__btn">
					<button type="submit" class="search-btn search_btn">
						<span>{$shop2.my.gr_search_form_btn|default:'Поиск'}</span>
					</button>
				</div>
			</form >
		</div>
	</div>
</div><!-- Search Form -->