{capture assign="params"}{strip}
    {foreach from=$fields item=param}
        {if $param._sph_filter}
            {assign var="name" value=$param.name|regex_replace:"/\s/":"&nbsp;"}

            {if $param.type == 'int' || $param.type == 'float'}
				<div class="shop2-filter__item gr-field-style">
					<div class="shop2-filter__title">
						<span>
							{$name|replace:'&nbsp;':' '}<ins>:</ins> {if $param.unit}{$param.unit}{/if}
							<span class="shop2-filter__title-icon filter_title_icon">
								<svg class="gr-svg-icon gr_filter_plus">
								    <use xlink:href="#icon_shop_filter_plus"></use>
								</svg>
								<svg class="gr-svg-icon gr_filter_minus">
								    <use xlink:href="#icon_shop_filter_minus"></use>
								</svg>
							</span>
						</span>
					</div>
					<div class="shop2-filter__body">
                        {assign var="class" value='shop2-input-float'}
                        {if $param.type == 'int'}
                            {assign var="class" value='shop2-input-int'}
                        {/if}

                        {if $param.range}
							<label class="input-from">
								<span class="input-from__title">{#SHOP2_FROM#}<ins>:</ins></span>
								<input {if !$shop2.my.gr_filter_disable_range_placeholder && !$shop2.my.gr_filter_placeholders}placeholder="{$param.range_min}" {/if}{if $shop2.my.gr_filter_placeholders}placeholder="{#SHOP2_FROM#}" {/if}class="{$class}" type="text" value="{$smarty.get.s[$param._sph_name].min|htmlspecialchars}" name="s[{$param._sph_name}][min]"{include file="global:shop2.v2-facets-data.tpl" aggs=$aggs.cf field_name=$param._sph_name key="min" empty_class=$facets_empty_class  placeholder=true} />
							</label>
							<label class="input-to">
								<span class="input-to__title">{#SHOP2_TO#}<ins>:</ins></span>
								<input {if !$shop2.my.gr_filter_disable_range_placeholder && !$shop2.my.gr_filter_placeholders}placeholder="{$param.range_max}" {/if}{if $shop2.my.gr_filter_placeholders}placeholder="{#SHOP2_TO#}" {/if}class="{$class}" type="text" value="{$smarty.get.s[$param._sph_name].max|htmlspecialchars}" name="s[{$param._sph_name}][max]"{include file="global:shop2.v2-facets-data.tpl" aggs=$aggs.cf field_name=$param._sph_name key="max" empty_class=$facets_empty_class  placeholder=true} />
							</label>
                        {else}
							<label>
								<input class="{$class}" type="text" value="{$smarty.get.s[$param._sph_name]|htmlspecialchars}" name="s[{$param._sph_name}]" />
							</label>
                        {/if}

					</div>
				</div>

            {elseif $param.type == 'checkbox'}
				<div class="shop2-filter__item gr-field-style">
					<div class="shop2-filter__title">
						<span>
							{$name|replace:'&nbsp;':' '}<ins>:</ins>
							<span class="shop2-filter__title-icon filter_title_icon">
								<svg class="gr-svg-icon gr_filter_plus">
								    <use xlink:href="#icon_shop_filter_plus"></use>
								</svg>
								<svg class="gr-svg-icon gr_filter_minus">
								    <use xlink:href="#icon_shop_filter_minus"></use>
								</svg>
							</span>
						</span>
					</div>
					<div class="shop2-filter__body">
						<div class="shop2-filter__checkbox">
							<a href="#" data-name="s[{$param._sph_name}][1]" data-value="1" class="param-val{if $smarty.get.s[$param._sph_name].1==1} active-val{/if} {include file="global:shop2.v2-facets-data.tpl" aggs=$aggs.cf field_name=$param._sph_name key=1 empty_class=$facets_empty_class empty_class_inset=true}">{#SHOP2_YES#}</a>
                        </div>
                      
					</div>
				</div>

            {elseif $param.type == 'multiselect' || $param.type == 'select'}

                {assign var="count" value=$param.options|@count}

                {if $count}
                    {if $count > $min_count_in_select}
						<div class="shop2-filter__item type-select gr-field-style">
							<div class="shop2-filter__title">
								<span>
									{$name|replace:'&nbsp;':' '}<ins>:</ins>
									<span class="shop2-filter__title-icon filter_title_icon">
										<svg class="gr-svg-icon gr_filter_plus">
										    <use xlink:href="#icon_shop_filter_plus"></use>
										</svg>
										<svg class="gr-svg-icon gr_filter_minus">
										    <use xlink:href="#icon_shop_filter_minus"></use>
										</svg>
									</span>
								</span>
							</div>
							<div class="shop2-filter__body">
								<label class="gr-select-wrapper">
									<select name="s[{$param._sph_name}]">
										<option value="">{#SHOP2_ALL#}</option>
	                                    {foreach from=$param.options item=option key=k}
											<option {if $smarty.get.s[$param._sph_name]==$k}selected="selected"{/if} value="{$k}"{include file="global:shop2.v2-facets-data.tpl" aggs=$aggs.cf field_name=$param._sph_name key=$k empty_class=$facets_empty_class is_empty_disabled=true}>{$option}</option>
	                                    {/foreach}
									</select>
								</label>
							</div>
						</div>
                    {else}
						<div class="shop2-filter__item gr-field-style">
							<div class="shop2-filter__title">
								<span>
									{$name|replace:'&nbsp;':' '}<ins>:</ins>
									<span class="shop2-filter__title-icon filter_title_icon">
										<svg class="gr-svg-icon gr_filter_plus">
										    <use xlink:href="#icon_shop_filter_plus"></use>
										</svg>
										<svg class="gr-svg-icon gr_filter_minus">
										    <use xlink:href="#icon_shop_filter_minus"></use>
										</svg>
									</span>
								</span>
							</div>
							<div class="shop2-filter__body">
								<div class="shop2-filter__params">
	                                {foreach from=$param.options name=foo item=option key=k}
	                                    {assign var="index" value=$smarty.foreach.foo.index}
	                                    <div class="shop2-filter__checkbox">
											<a href="#" data-name="s[{$param._sph_name}][]" data-value="{$k}" class="param-val{if in_array($k, $smarty.get.s[$param._sph_name])} active-val{/if} {include file="global:shop2.v2-facets-data.tpl" aggs=$aggs.cf field_name=$param._sph_name key=$k empty_class=$facets_empty_class empty_class_inset=true}">
		                                        {$option}
											</a>
				                        </div>
	                                {/foreach}
                                </div>
                                {assign var=gr_max_count value=$shop2.my.gr_filter_max_count|default:'5'}
                                {if $count>$gr_max_count}
                                	{assign var=selects_total value=$count-$gr_max_count}
									<div class="gr-filter-more">
										<span class="gr-filter-more__btn" data-text="{$shop2.my.gr_filter_select_btn|default:'Показать еще'}" data-fields-total="{$selects_total}"><span class="gr-filter-more__text">{$shop2.my.gr_filter_select_btn|default:'Показать еще'}</span><span class="gr-filter-more__amount"> {$selects_total}</span></span>
									</div>
								{/if}
							</div>
						</div>
						
                    {/if}
                {/if}

            {elseif $param.type == 'color_ref'}

				<div class="shop2-filter__item gr-field-style">
					<div class="shop2-filter__title">
						<span>
							{$name|replace:'&nbsp;':' '}<ins>:</ins>
							<span class="shop2-filter__title-icon filter_title_icon">
								<svg class="gr-svg-icon gr_filter_plus">
								    <use xlink:href="#icon_shop_filter_plus"></use>
								</svg>
								<svg class="gr-svg-icon gr_filter_minus">
								    <use xlink:href="#icon_shop_filter_minus"></use>
								</svg>
							</span>
						</span>
					</div>
					<div class="shop2-filter__body">
                        {include file="global:shop2.v2-color-ext.tpl" location="filter"}
					</div>
				</div>

            {/if}
        {/if}
    {/foreach}
{/strip}{/capture}

{if $params && !in_array("params", $hide_in_filter)}
    {assign var="has_params" value=true}
    {assign_hash var='page.has_filter_params' value=1}
    {$params}
{/if}