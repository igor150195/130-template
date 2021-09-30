{if !$data}
	{assign var="data" value=$custom_fields}
{/if}

{if $data}
	{foreach from=$data name=foo item=e key=k}
		{if $e.in_search}

			{capture assign="field"}
				{if $e.type == 'textarea' || $e.type == 'text' || $e.type == 'int' || $e.type == 'float'}
					
					<div class="search-rows__row gr-field-style{if $e.range} float_row{/if}">
						{assign var="cls" value=""}
						
						{if $e.type == 'int' || $e._sph_type == 'int'}
							{assign var="cls" value="shop2-input-int"}
						{elseif $e.type == 'float' || $e._sph_type == 'float'}
							{assign var="cls" value="shop2-input-float"}
						{/if}

						{if $e.range}
							<div class="row-title field-title">
								<span>
									{$e.name}{if $e.unit} ({$e.unit}){/if}<ins>:</ins>
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
									<input placeholder="{$e.range_min}" name="s[{$e._sph_name}][min]" type="text" size="5" class="small {$cls}" value="{$smarty.get.s[$e._sph_name].min|escape|default:''}" />
								</label>
								<label class="input-to">
									<span class="input-to__title">{#SHOP2_TO#}<ins>:</ins></span>
									<input placeholder="{$e.range_max}" name="s[{$e._sph_name}][max]" type="text" size="5" class="small {$cls}" value="{$smarty.get.s[$e._sph_name].max|escape|default:''}" />
								</label>
							</div>
						{else}
							<div class="row-title field-title">
								<span>
									{$e.name}{if $e.unit} ({$e.unit}){/if}<ins>:</ins>
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
								<input type="text" name="s[{$e._sph_name}]" size="20" {if $cls}class="{$cls}"{/if} value="{$smarty.get.s[$e._sph_name]|escape|default:''}" />
							</div>
						{/if}
					</div>

				{elseif $e.type == 'select' || $e.type == 'multiselect'}
					
					{assign var="count" value=$e.options|@count}
				
					<div class="search-rows__row shop2-search-selects gr-field-style">
						<div class="row-title field-title">
							<span>
								{$e.name}<ins>:</ins>
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
								{foreach from=$e.options item=i key=j name=selects_foo}
									{assign var="index" value=$smarty.foreach.selects_foo.index}
									<li data-name="s[{$e._sph_name}][{$index}]" data-value="{$j}">
										<label>
											<input type="checkbox" name="s[{$e._sph_name}][{$index}]" value="{$j|escape}" {if $smarty.get.s[$e._sph_name][$index] == $j}checked="checked"{/if}>
											<span>{$i}</span>
										</label>
									</li>
								{/foreach}
							</ul>
							{assign var=gr_max_count value=$shop2.my.gr_filter_max_count|default:'5'}
                            {if $count>$gr_max_count}
                            	{assign var=selects_total value=$count-$gr_max_count}
								<div class="gr-filter-more">
									<span class="gr-filter-more__btn" data-text="{$shop2.my.gr_filter_select_btn|default:'Показать еще'}" data-fields-total="{$selects_total}"><span class="gr-filter-more__text">{$shop2.my.gr_filter_select_btn|default:'Показать еще'}</span><span class="gr-filter-more__amount"> {$selects_total}</span></span>
								</div>
							{/if}
						</div>
					</div>
				{elseif $e.type == 'checkbox'}
					<div class="search-rows__row gr-field-style checkbox_row">
						<div class="tpl-field type-checkbox">
							<ul>
								<li data-name="s[{$e._sph_name}][]" data-value="1">
									<label>
										<input type="checkbox" name="s[{$e._sph_name}][]" value="1" {if $smarty.get.s[$e._sph_name]}checked="checked"{/if}> <span>{$e.name}</span>
									</label>
								</li>
							</ul>
						</div>
					</div>
				{elseif $e.type == 'color_ref'}
					<div class="search-rows__row gr-field-style">
						<div class="row-title field-title">
							<span>
								{$e.name}<ins>:</ins>
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
							{include file="global:shop2.v2-color-ext.tpl" location="search"}
						</div>
					</div>
				{/if}
			{/capture}

			{$field}

		{/if}
	{/foreach}
{/if}