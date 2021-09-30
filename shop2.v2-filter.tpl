{assign var="after" value=0}
{if isset($smarty.get.s) || isset($smarty.get.search_text)}
    {assign var="after" value=1}
{/if}

{if $shop2.products || $after}

    {assign var="hide_in_filter" value=$shop2.my.hide_in_filter}
    {if !$hide_in_filter}
        {assign var="hide_in_filter" value=","|explode:""}
    {/if}

    {assign var="min_count_in_select" value=$shop2.my.min_count_in_select|default:99999}
    {if $shop2.my.list_in_select}
        {assign var="min_count_in_select" value=99999}
    {/if}

    {assign var="show_price" value=0}
    {if !(!$user && $shop2.my.hide_prices_non_reg)}
        {assign var="show_price" value=1}
    {/if}

    {assign var=facets_empty_class value='empty-val'}
    {if $shop2.my.facets_empty_class}
        {assign var=facets_empty_class value=$shop2.my.facets_empty_class}
    {/if}

    {assign var="has_params" value=false}

    {if !$shop2.fallback_mode}

        {capture assign="filter"}
            <div class="shop2-filter__items">
                {if !in_array("price", $hide_in_filter) && $show_price}
                    {assign var="has_params" value=true}
                    <div class="shop2-filter__item gr-field-style">
                        <div class="shop2-filter__title active">
                            <span>
                                {#SHOP2_PRICE#}<ins>:</ins> {$currency.currency_shortname}
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
                            <label class="input-from">
                                <span class="input-from__title">{#SHOP2_FROM#}<ins>:</ins></span>
                                <input {if $shop2.my.gr_filter_placeholders && !$site.reg.se.facets}placeholder="{#SHOP2_FROM#}" {/if}class="shop2-input-float{if $shop2.my.gr_filter_range_slider} range-input{/if}" type="text" value="{$smarty.get.s.price.min|htmlspecialchars}" name="s[price][min]"{include file="global:shop2.v2-facets-data.tpl" field_name="price" key="min" empty_class=$facets_empty_class placeholder=true}
                                data-range_min="{$shop2.my.gr_filter_range_min|default:'0'}"
                                />
                                
                            </label>
                            <label class="input-to">
                                <span class="input-to__title">{#SHOP2_TO#}<ins>:</ins></span>
                                <input {if $shop2.my.gr_filter_placeholders && !$site.reg.se.facets}placeholder="{#SHOP2_TO#}" {/if}class="shop2-input-float{if $shop2.my.gr_filter_range_slider} range-input{/if}" type="text" value="{$smarty.get.s.price.max|htmlspecialchars}" name="s[price][max]"{include file="global:shop2.v2-facets-data.tpl" field_name="price" key="max" empty_class=$facets_empty_class placeholder=true}
                                data-range_max="{$shop2.my.gr_filter_range_max|default:'200000'}"
                                />
                                
                            </label>
                            {if $shop2.my.gr_filter_range_slider}
                                <div class="input_range_slider"></div>
                            {/if}
                        </div>
                    </div>
                {/if}

                {if $folder.vendors && !in_array("vendors", $hide_in_filter)}
                    {assign var="has_params" value=true}
                    <div class="shop2-filter__item gr-field-style">
                        <div class="shop2-filter__title">
                            <span>
                                {$shop2.my.vendor_alias|default:#SHOP2_VENDOR#}<ins>:</ins>
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
                            
                            {if $folder.vendors|@count > $min_count_in_select}
	                            <label class="gr-select-wrapper">
	                                <select name="s[vendor_id]">
	                                    <option value="">{#SHOP2_ALL#}</option>
	                                    {foreach from=$folder.vendors item=e key=k}
	                                        <option {if in_array($e.vendor_id, $smarty.get.s.vendor_id)}selected="selected"{/if} value="{$e.vendor_id}"{include file="global:shop2.v2-facets-data.tpl" field_name="vendor_id" key=$e.vendor_id is_empty_disabled=true}>{$e.name}</option>
	                                    {/foreach}
	                                </select>
                                </label>
                            {else}
                                <div class="shop2-filter__params">
                                    {foreach from=$folder.vendors item=e key=k}
                                        <div class="shop2-filter__checkbox">
                                            <a href="#" data-name="s[vendor_id][]" data-value="{$e.vendor_id}" class="param-val{if in_array($e.vendor_id, $smarty.get.s.vendor_id)} active-val{/if}{include file="global:shop2.v2-facets-data.tpl" field_name="vendor_id" key=$e.vendor_id empty_class=$facets_empty_class empty_class_inset=true}">
                                                {$e.name}
                                            </a>
                                        </div>
                                    {/foreach}
                                </div>
                                {assign var=gr_max_count value=$shop2.my.gr_filter_max_count|default:'5'}
                                {if $folder.vendors|@count>$gr_max_count}
                                    {assign var=vendors_amount value=$folder.vendors|@count}
                                    {assign var=vendors_total value=$vendors_amount-$gr_max_count}
                                    <div class="gr-filter-more">
                                        <span class="gr-filter-more__btn" data-text="{$shop2.my.gr_filter_select_btn|default:'Показать еще'}" data-fields-total="{$vendors_total}"><span class="gr-filter-more__text">{$shop2.my.gr_filter_select_btn|default:'Показать еще'}</span><span class="gr-filter-more__amount"> {$vendors_total}</span></span>
                                    </div>
                                {/if}
                            {/if}
                           
                        </div>
                    </div>
                {/if}

                {if $mode == 'main'}
                    {include file="global:shop2.v2-filter-fields.tpl" fields=$shop2.global_params}
                {/if}
                {include file="global:shop2.v2-filter-fields.tpl" fields=$filter_fields}
                
                {foreach from=$product_flag item=flag}
                    {if ($flag.flag_id == 2 && !in_array("special", $hide_in_filter)) || ($flag.flag_id == 1 && !in_array("new", $hide_in_filter)) || ($flag.flag_id != '1' && $flag.flag_id != '2')}
                        <div class="shop2-filter__item type-select gr-field-style">
                            <div class="shop2-filter__title">
                                <span>
                                    {$flag.name|replace:'&nbsp;':' '}<ins>:</ins>
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
                            {assign var=flag_key value=$flag.flag_id}
                            <div class="shop2-filter__body">
                            	<label class="gr-select-wrapper">
	                                <select name="s[flags][{$flag.flag_id}]">
	                                    <option value=""{if $smarty.get.s.flags.$flag_key == ''} selected="selected"{/if}>{#SHOP2_ALL#}</option>
	                                    <option value="1"{if $smarty.get.s.flags.$flag_key == '1'} selected="selected"{/if}>{#SHOP2_YES#}</option>
	                                    <option value="0"{if $smarty.get.s.flags.$flag_key == '0'} selected="selected"{/if}>{#SHOP2_NO#}</option>
	                                </select>
                                </label>
                            </div>
                        </div>
                    {/if}
                {/foreach}

                {if $shop2.my.show_amount_filter}
                    {assign var="has_params" value=true}
                    <div class="shop2-filter__item gr-field-style">
                        <div class="shop2-filter__title">
                            <span>
                                {#SHOP2_AVAILABLE#}<ins>:</ins>
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
                            {assign var="active" value=0}
                            {if $smarty.get.s.amount.min == 1 || ( $smarty.get.s.amount.min == 0 && isset($smarty.get.s.amount.min) )}
                                {assign var="active" value=1}
                            {/if}
                            <div class="shop2-filter__checkbox">
                                <a href="#" data-name="s[amount][min]" data-value="1" class="param-val{if $active} active-val{/if}">{#SHOP2_YES#}</a>
                            </div>

                            {assign var="active" value=0}
                            {if ( $smarty.get.s.amount.max == 0 && isset($smarty.get.s.amount.max) ) || ( $smarty.get.s.amount.min == 0 && isset($smarty.get.s.amount.min) ) }
                                {assign var="active" value=1}
                            {/if}
                        </div>
                    </div>
                {/if}

            </div>
        {/capture}
        
        {if !$nofilterfavorite}
	        {if ($has_params || $page.has_filter_params) && !$gr_sorting_no_filter}
	            {if $shop2.my.gr_filter_remodal}
	                <div class="remodal" data-remodal-id="filter-popup" role="dialog" data-remodal-options="hashTracking: false">
	                    <button data-remodal-action="close" class="remodal-close-btn">
	                        <span>
	                            {$shop2.my.gr_remodal_close|default:'Закрыть'}
	                            <i>
		                            <svg class="gr-svg-icon gr_big_icon">
		                                <use xlink:href="#icon_shop_close"></use>
		                            </svg>
		                            <svg class="gr-svg-icon">
		                                <use xlink:href="#icon_shop_close_small"></use>
		                            </svg>
		                            <svg class="gr-svg-icon gr_small_icon">
		                                <use xlink:href="#icon_shop_close_mini"></use>
		                            </svg>
	                            </i>
	                        </span>
	                    </button>
	            {/if}
	            <div class="filter-block">
	                <div class="filter-block__inner">
	                    <form action="#" class="shop2-filter">
	                        <a id="shop2-filter"></a>
	                        <div class="shop2-filter__header">
	                            {$shop2.my.gr_filter_header|default:"Фильтр"}
	                        </div>
	
	                        {$filter}
	
	                        <div class="shop2-filter__add">
	                            {if !$shop2.my.gr_filter_go_result}
	                                <div class="shop2-filter-result">
	                                    <div class="shop2-filter-result__title">
	                                        {$shop2.my.gr_filter_found|default:'Найдено'}
	                                    </div>
	                                    <div id="filter-result" class="result">
	                                        {if !$after}0{else}{$found|default:0}{/if}
	                                    </div>
	                                </div>
	                            {/if}
	                            
	                            <div class="shop2-filter-btns">
	                                <a href="#" class="shop2-filter-go gr_filter_go">
	                                    <span>{$shop2.my.gr_filter_go_text|default:#SHOP2_SHOW#}</span>
	                                    {if $shop2.my.gr_filter_go_result}
	                                        <span id="filter-result" class="result">
	                                            {if !$after}0{else}{$found|default:0}{/if}
	                                        </span>
	                                    {/if}
	                                </a>
	                                <a href="{$SCRIPT_NAME}" class="shop2-filter-reset gr_filter_reset">
	                                    <span>
	                                        {$shop2.my.gr_filter_reset_text|default:#SHOP2_RESET_FILTER#}
	                                        <i>
		                                        <svg class="gr-svg-icon">
		                                            <use xlink:href="#icon_shop_refresh"></use>
		                                        </svg>
		                                        <svg class="gr-svg-icon gr_small_icon">
		                                            <use xlink:href="#icon_shop_refresh"></use>
		                                        </svg>
	                                        </i>
	                                    </span>
	                                </a>
	                            </div>
	                        </div>
	                    </form >
	                </div>
	            </div><!-- .filter-block --> 
	            {if $shop2.my.gr_filter_remodal}
	                </div> <!-- .filter-popup -->
	            {/if}
	        {/if}
        {/if}
        
        {if !$gr_only_filter}
            {if $shop2.products}
            
                {assign var="sort_by" value=$smarty.get.s.sort_by}
                {if $sort_by != $sort_by|regex_replace:"/name desc/":""}
                    {assign var="sort_name_desc" value=1}
                {/if}
                {if $sort_by != $sort_by|regex_replace:"/name asc/":""}
                    {assign var="sort_name_asc" value=1}
                {/if}
                {if $sort_by != $sort_by|regex_replace:"/price desc/":""}
                    {assign var="sort_price_desc" value=1}
                {/if}
                {if $sort_by != $sort_by|regex_replace:"/price asc/":""}
                    {assign var="sort_price_asc" value=1}
                {/if}
                {if $sort_by != $sort_by|regex_replace:"/amount desc/":""}
                    {assign var="sort_amount_desc" value=1}
                {/if}
                {if $sort_by != $sort_by|regex_replace:"/amount asc/":""}
                    {assign var="sort_amount_asc" value=1}
                {/if}
                {if $sort_by != $sort_by|regex_replace:"/rating desc/":""}
                    {assign var="sort_rating_desc" value=1}
                {/if}
                {if $sort_by != $sort_by|regex_replace:"/rating asc/":""}
                    {assign var="sort_rating_asc" value=1}
                {/if}

                <div class="sorting-panel">
                    <div class="sorting-panel__body">
                        {if $shop2.my.gr_filter_remodal_btn!=""}
                        	{if !$shop2.my.gr_filter_unwrap_sorting}
	                            <div class="sorting-panel__btn-wrap">
	                        {/if}
                                <div class="filter-popup-btn filter_popup_btn" data-remodal-target="filter-popup">
                                    <span>
                                        {$shop2.my.gr_filter_remodal_btn}
                                        <i>
	                                        <svg class="gr-svg-icon">
	                                            <use xlink:href="#icon_shop_filter"></use>
	                                        </svg>
	                                        <svg class="gr-svg-icon gr_small_icon">
	                                            <use xlink:href="#icon_shop_filter_small"></use>
	                                        </svg>
                                        </i>
                                    </span>
                                </div>
                            {if !$shop2.my.gr_filter_unwrap_sorting}
	                            </div>
	                        {/if}
                        {/if}
						
						{if !$shop2.my.gr_filter_unwrap_sorting}
                            <div class="sorting-panel__add-wrap">
                        {/if}
                            {if $shop2.my.gr_sorting_popup}
                                <div class="sorting-wrap">
                                    <div class="sorting-button sorting_button"{if $shop2.my.gr_sorting_remodal} data-remodal-target="sorting-remodal"{/if}>
                                        <span>
                                            {if $sort_price_asc}
                                                {$shop2.my.gr_sorting_by_price_asc|default:'Цена - возрастание'}
                                            {elseif $sort_price_desc}
                                                {$shop2.my.gr_sorting_by_price_desc|default:'Цена - убывание'}
                                            {elseif $sort_name_asc}
                                                {$shop2.my.gr_sorting_by_name_asc|default:'Название - А-Я'}
                                            {elseif $sort_name_desc}
                                                {$shop2.my.gr_sorting_by_name_desc|default:'Название - Я-А'}
                                            {elseif $sort_amount_asc}
                                                {$shop2.my.gr_sorting_by_amount_asc|default:'Наличие - возрастание'}
                                            {elseif $sort_amount_desc}
                                                {$shop2.my.gr_sorting_by_amount_desc|default:'Наличие - убывание'}
                                            {elseif $sort_rating_asc}
                                                {$shop2.my.gr_sorting_by_rating_asc|default:'Популярность - возрастание'}
                                            {elseif $sort_rating_desc}
                                                {$shop2.my.gr_sorting_by_rating_desc|default:'Популярность - убывание'}
                                            {else}
                                                {$shop2.my.gr_sorting_title|default:'Сортировать'}
                                            {/if}
                                            <i>
	                                            <svg class="gr-svg-icon">
	                                                <use xlink:href="#icon_shop_sort"></use>
	                                            </svg>
	                                            <svg class="gr-svg-icon gr_small_icon">
	                                                <use xlink:href="#icon_shop_sort_mobile"></use>
	                                            </svg>
                                            </i>
                                        </span>
                                    </div>
                                    {if $shop2.my.gr_sorting_remodal}
                                        <div class="remodal" data-remodal-id="sorting-remodal" role="dialog" data-remodal-options="hashTracking: false">
                                            <button data-remodal-action="close" class="remodal-close-btn">
                                                <span>
                                                    {$shop2.my.gr_remodal_close|default:'Закрыть'}
                                                    <i>
	                                                    <svg class="gr-svg-icon gr_big_icon">
	                                                        <use xlink:href="#icon_shop_close"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_close_small"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_close_mini"></use>
	                                                    </svg>
                                                    </i>
                                                </span>
                                            </button>
                                    {/if}
                                    <div class="sorting-block sorting{if $sort_price_asc || $sort_price_desc || $sort_name_asc || $sort_name_desc || $sort_amount_asc || $sort_amount_desc || $sort_rating_asc || $sort_rating_desc} active-sorting{/if}">
                                        <div class="sorting-block__title">
                                        	<span>
	                                            <ins>{$shop2.my.gr_sorting_title|default:'Сортировать'}</ins>
	                                            <i>
		                                            <svg class="gr-svg-icon">
		                                                <use xlink:href="#icon_shop_sort"></use>
		                                            </svg>
		                                            <svg class="gr-svg-icon gr_small_icon">
		                                                <use xlink:href="#icon_shop_sort_mobile"></use>
		                                            </svg>
	                                            </i>
                                            </span>
                                        </div>
                                        <div class="sorting-block__items">
                                            <div class="sorting-block__item{if $sort_price_desc} active{/if}">
                                                <a href="#" class="sort-param sort-param-desc{if $sort_price_desc} active{/if}" data-name="price">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_desc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_price_desc|default:'Цена - убывание'}
                                                </a>
                                            </div>
                                            <div class="sorting-block__item{if $sort_price_asc} active{/if}">
                                                <a href="#" class="sort-param sort-param-asc{if $sort_price_asc} active{/if}" data-name="price">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_asc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_price_asc|default:'Цена - возрастание'}
                                                </a>
                                            </div>
                                            <div class="sorting-block__item{if $sort_name_desc} active{/if}">
                                                <a href="#" class="sort-param sort-param-desc{if $sort_name_desc} active{/if}" data-name="name">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_desc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_name_desc|default:'Название - Я-А'}
                                                </a>
                                            </div>
                                            <div class="sorting-block__item{if $sort_name_asc} active{/if}">
                                                <a href="#" class="sort-param sort-param-asc{if $sort_name_asc} active{/if}" data-name="name">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_asc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_name_asc|default:'Название - А-Я'}
                                                </a>
                                            </div>
                                            {if $shop2.my.show_amount_sort}
                                                <div class="sorting-block__item{if $sort_amount_desc} active{/if}">
                                                    <a href="#" class="sort-param sort-param-desc{if $sort_amount_desc} active{/if}" data-name="amount">
                                                        <i>
                                                        	<svg class="gr-svg-icon">
	                                                            <use xlink:href="#icon_shop_sort_desc"></use>
	                                                        </svg>
	                                                        <svg class="gr-svg-icon gr_small_icon">
	                                                            <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                        </svg>
                                                        </i>
                                                        {$shop2.my.gr_sorting_by_amount_desc|default:'Наличие - убывание'}
                                                    </a>
                                                </div>
                                                <div class="sorting-block__item{if $sort_amount_asc} active{/if}">
                                                    <a href="#" class="sort-param sort-param-asc{if $sort_amount_asc} active{/if}" data-name="amount">
                                                        <i>
                                                        	<svg class="gr-svg-icon">
	                                                            <use xlink:href="#icon_shop_sort_asc"></use>
	                                                        </svg>
	                                                        <svg class="gr-svg-icon gr_small_icon">
	                                                            <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                        </svg>
                                                        </i>
                                                        {$shop2.my.gr_sorting_by_amount_asc|default:'Наличие - возрастание'}
                                                    </a>
                                                </div>
                                            {/if}
                                            {if $shop2.my.show_rating_sort}
                                                <div class="sorting-block__item{if $sort_rating_desc} active{/if}">
                                                    <a href="#" class="sort-param sort-param-desc{if $sort_rating_desc} active{/if}" data-name="rating">
                                                        <i>
                                                        	<svg class="gr-svg-icon">
	                                                            <use xlink:href="#icon_shop_sort_desc"></use>
	                                                        </svg>
	                                                        <svg class="gr-svg-icon gr_small_icon">
	                                                            <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                        </svg>
                                                        </i>
                                                        {$shop2.my.gr_sorting_by_rating_desc|default:'Популярность - убывание'}
                                                    </a>
                                                </div>
                                                <div class="sorting-block__item{if $sort_rating_asc} active{/if}">
                                                    <a href="#" class="sort-param sort-param-asc{if $sort_rating_asc} active{/if}" data-name="rating">
                                                        <i>
                                                        	<svg class="gr-svg-icon">
	                                                            <use xlink:href="#icon_shop_sort_asc"></use>
	                                                        </svg>
	                                                        <svg class="gr-svg-icon gr_small_icon">
	                                                            <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                        </svg>
                                                        </i>
                                                        {$shop2.my.gr_sorting_by_rating_asc|default:'Популярность - возрастание'}
                                                    </a>
                                                </div>
                                            {/if}
                                            {if $sort_price_asc || $sort_price_desc || $sort_name_asc || $sort_name_desc || $sort_amount_asc || $sort_amount_desc || $sort_rating_asc || $sort_rating_desc} 
                                                <div class="sorting-block__item">
                                                    <a href="#" class="sort-reset {if !$sort_price_asc && !$sort_price_desc && !$sort_name_asc && !$sort_name_desc && !$sort_amount_asc && !$sort_amount_desc && !$sort_rating_asc && !$sort_rating_desc}active{/if}">
                                                        {$shop2.my.gr_sorting_item_default|default:'По умолчанию'}
                                                    </a>
                                                </div>
                                            {/if}
                                        </div>
                                    </div>
                                    {if $shop2.my.gr_sorting_remodal}
                                        </div>
                                    {/if}
                                </div>
                            {else}
                                <div class="sorting-block sorting{if $sort_price_asc || $sort_price_desc || $sort_name_asc || $sort_name_desc || $sort_amount_asc || $sort_amount_desc || $sort_rating_asc || $sort_rating_desc} active-sorting{/if}">
                                    <div class="sorting-block__body">
                                        <div class="sorting-block__result">
                                            <div class="sorting-block__result-title">
                                                {$shop2.my.gr_sorting_title|default:'Сортировать'}
                                            </div>
                                            {if !$sort_price_asc && !$sort_price_desc && !$sort_name_asc && !$sort_name_desc && !$sort_amount_asc && !$sort_amount_desc && !$sort_rating_asc && !$sort_rating_desc}
                                                <span class="no-sorting">{$shop2.my.gr_sorting_default|default:'По умолчанию'}</span>
                                            {/if}
                                            {if $sort_price_asc}
                                                <span class="sort-param-asc{if $sort_price_asc} active{/if}">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_asc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_price_asc|default:'Цена - возрастание'}
                                                </span>
                                            {elseif $sort_price_desc}
                                                <span class="sort-param-desc{if $sort_price_desc} active{/if}">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_desc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_price_desc|default:'Цена - убывание'}
                                                </span>
                                            {elseif $sort_name_asc}
                                                <span class="sort-param-asc{if $sort_name_asc} active{/if}">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_asc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_name_asc|default:'Название - А-Я'}
                                                </span>
                                            {elseif $sort_name_desc}
                                                <span class="sort-param-desc{if $sort_name_desc} active{/if}">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_desc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_name_desc|default:'Название - Я-А'}
                                                </span>
                                            {elseif $sort_amount_asc}
                                                <span class="sort-param-asc{if $sort_amount_asc} active{/if}">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_asc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_amount_asc|default:'Наличие - возрастание'}
                                                </span>
                                            {elseif $sort_amount_desc}
                                                <span class="sort-param-desc{if $sort_amount_desc} active{/if}">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_desc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_amount_desc|default:'Наличие - убывание'}
                                                </span>
                                            {elseif $sort_rating_asc}
                                                <span class="sort-param-asc{if $sort_rating_asc} active{/if}">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_asc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_rating_asc|default:'Популярность - возрастание'}
                                                </span>
                                            {elseif $sort_rating_desc}
                                                <span class="sort-param-desc{if $sort_rating_desc} active{/if}">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_desc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_rating_desc|default:'Популярность - убывание'}
                                                </span>
                                            {/if}
                                            <i>
                                            	<svg class="gr-svg-icon">
	                                                <use xlink:href="#icon_shop_sort"></use>
	                                            </svg>
	                                            <svg class="gr-svg-icon gr_small_icon">
	                                                <use xlink:href="#icon_shop_sort_mobile"></use>
	                                            </svg>
                                            </i>
                                        </div>
                                        <div class="sorting-block__items">
                                            <div class="sorting-block__item{if $sort_price_desc} active{/if}">
                                                <a href="#" class="sort-param sort-param-desc{if $sort_price_desc} active{/if}" data-name="price">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_desc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_price_desc|default:'Цена - убывание'}
                                                </a>
                                            </div>
                                            <div class="sorting-block__item{if $sort_price_asc} active{/if}">
                                                <a href="#" class="sort-param sort-param-asc{if $sort_price_asc} active{/if}" data-name="price">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_asc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_price_asc|default:'Цена - возрастание'}
                                                </a>
                                            </div>
                                            <div class="sorting-block__item{if $sort_name_desc} active{/if}">
                                                <a href="#" class="sort-param sort-param-desc{if $sort_name_desc} active{/if}" data-name="name">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_desc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_name_desc|default:'Название - Я-А'}
                                                </a>
                                            </div>
                                            <div class="sorting-block__item{if $sort_name_asc} active{/if}">
                                                <a href="#" class="sort-param sort-param-asc{if $sort_name_asc} active{/if}" data-name="name">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_asc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_name_asc|default:'Название - А-Я'}
                                                </a>
                                            </div>
                                            {if $shop2.my.show_amount_sort}
                                                <div class="sorting-block__item{if $sort_amount_desc} active{/if}">
                                                    <a href="#" class="sort-param sort-param-desc{if $sort_amount_desc} active{/if}" data-name="amount">
                                                        <i>
                                                        	<svg class="gr-svg-icon">
	                                                            <use xlink:href="#icon_shop_sort_desc"></use>
	                                                        </svg>
	                                                        <svg class="gr-svg-icon gr_small_icon">
	                                                            <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                        </svg>
                                                        </i>
                                                        {$shop2.my.gr_sorting_by_amount_desc|default:'Наличие - убывание'}
                                                    </a>
                                                </div>
                                                <div class="sorting-block__item{if $sort_amount_asc} active{/if}">
                                                    <a href="#" class="sort-param sort-param-asc{if $sort_amount_asc} active{/if}" data-name="amount">
                                                        <i>
                                                        	<svg class="gr-svg-icon">
	                                                            <use xlink:href="#icon_shop_sort_asc"></use>
	                                                        </svg>
	                                                        <svg class="gr-svg-icon gr_small_icon">
	                                                            <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                        </svg>
                                                        </i>
                                                        {$shop2.my.gr_sorting_by_amount_asc|default:'Наличие - возрастание'}
                                                    </a>
                                                </div>
                                            {/if}
                                            {if $shop2.my.show_rating_sort}
                                                <div class="sorting-block__item{if $sort_rating_desc} active{/if}">
                                                    <a href="#" class="sort-param sort-param-desc{if $sort_rating_desc} active{/if}" data-name="rating">
                                                        <i>
                                                        	<svg class="gr-svg-icon">
	                                                            <use xlink:href="#icon_shop_sort_desc"></use>
	                                                        </svg>
	                                                        <svg class="gr-svg-icon gr_small_icon">
	                                                            <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                        </svg>
                                                        </i>
                                                        {$shop2.my.gr_sorting_by_rating_desc|default:'Популярность - убывание'}
                                                    </a>
                                                </div>
                                                <div class="sorting-block__item{if $sort_rating_asc} active{/if}">
                                                    <a href="#" class="sort-param sort-param-asc{if $sort_rating_asc} active{/if}" data-name="rating">
                                                        <i>
                                                        	<svg class="gr-svg-icon">
	                                                            <use xlink:href="#icon_shop_sort_asc"></use>
	                                                        </svg>
	                                                        <svg class="gr-svg-icon gr_small_icon">
	                                                            <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                        </svg>
                                                        </i>
                                                        {$shop2.my.gr_sorting_by_rating_asc|default:'Популярность - возрастание'}
                                                    </a>
                                                </div>
                                            {/if}
                                            {if $sort_price_asc || $sort_price_desc || $sort_name_asc || $sort_name_desc || $sort_amount_asc || $sort_amount_desc || $sort_rating_asc || $sort_rating_desc} 
                                                <div class="sorting-block__item">
                                                    <a href="#" class="sort-reset {if !$sort_price_asc && !$sort_price_desc && !$sort_name_asc && !$sort_name_desc && !$sort_amount_asc && !$sort_amount_desc && !$sort_rating_asc && !$sort_rating_desc}active{/if}">
                                                        {$shop2.my.gr_sorting_item_default|default:'По умолчанию'}
                                                    </a>
                                                </div>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            {/if}
                            
                            <div class="shop-view">
                                <div class="shop-view__inner">
                                    <div class="shop-view__btn">&nbsp;</div>
                                    <div class="shop-view__body">
                                        <a href="#" title="{#SHOP2_THUMBS#}" data-value="thumbs" class="shop-view__item thumbs {if ($smarty.cookies.views && $smarty.cookies.views == 'thumbs') || (!$smarty.cookies.views && $shop2.view=='thumbs')} active-view{/if}">
                                            <svg class="gr-svg-icon">
                                                <use xlink:href="#icon_shop_thumbs"></use>
                                            </svg>
                                            <svg class="gr-svg-icon gr_small_icon">
                                                <use xlink:href="#icon_shop_thumbs_small"></use>
                                            </svg>
                                        </a>
                                        <a href="#" title="{#SHOP2_LIST#}" data-value="simple" class="shop-view__item simple {if ($smarty.cookies.views && $smarty.cookies.views == 'simple') || (!$smarty.cookies.views && $shop2.view=='simple')} active-view{/if}">
                                            <svg class="gr-svg-icon">
                                                <use xlink:href="#icon_shop_simple"></use>
                                            </svg>
                                            <svg class="gr-svg-icon gr_small_icon">
                                                <use xlink:href="#icon_shop_simple_small"></use>
                                            </svg>
                                        </a>
                                        <a href="#" title="{#SHOP2_PRICE_LIST#}" data-value="list" class="shop-view__item pricelist {if ($smarty.cookies.views && $smarty.cookies.views == 'list') || (!$smarty.cookies.views && $shop2.view=='list')} active-view{/if}">
                                            <svg class="gr-svg-icon">
                                                <use xlink:href="#icon_shop_pricelist"></use>
                                            </svg>
                                            <svg class="gr-svg-icon gr_small_icon">
                                                <use xlink:href="#icon_shop_pricelist_small"></use>
                                            </svg>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        {if !$shop2.my.gr_filter_unwrap_sorting}
                            </div>
                        {/if}
                    </div>
                </div>

            {elseif $smarty.get.s || $smarty.get.search_text}
            
                {assign var="sort_by" value=$smarty.get.s.sort_by}
                {if $sort_by != $sort_by|regex_replace:"/name desc/":""}
                    {assign var="sort_name_desc" value=1}
                {/if}
                {if $sort_by != $sort_by|regex_replace:"/name asc/":""}
                    {assign var="sort_name_asc" value=1}
                {/if}
                {if $sort_by != $sort_by|regex_replace:"/price desc/":""}
                    {assign var="sort_price_desc" value=1}
                {/if}
                {if $sort_by != $sort_by|regex_replace:"/price asc/":""}
                    {assign var="sort_price_asc" value=1}
                {/if}
                {if $sort_by != $sort_by|regex_replace:"/amount desc/":""}
                    {assign var="sort_amount_desc" value=1}
                {/if}
                {if $sort_by != $sort_by|regex_replace:"/amount asc/":""}
                    {assign var="sort_amount_asc" value=1}
                {/if}
                {if $sort_by != $sort_by|regex_replace:"/rating desc/":""}
                    {assign var="sort_rating_desc" value=1}
                {/if}
                {if $sort_by != $sort_by|regex_replace:"/rating asc/":""}
                    {assign var="sort_rating_asc" value=1}
                {/if}

                <div class="sorting-panel">
                    <div class="sorting-panel__body">
                        {if $shop2.my.gr_filter_remodal_btn!=""}
                            {if !$shop2.my.gr_filter_unwrap_sorting}
	                            <div class="sorting-panel__btn-wrap">
	                        {/if}
                                <div class="filter-popup-btn filter_popup_btn" data-remodal-target="filter-popup">
                                    <span>
                                        {$shop2.my.gr_filter_remodal_btn}
                                        <i>
                                        	<svg class="gr-svg-icon">
	                                            <use xlink:href="#icon_shop_filter"></use>
	                                        </svg>
	                                        <svg class="gr-svg-icon gr_small_icon">
	                                            <use xlink:href="#icon_shop_filter_small"></use>
	                                        </svg>
                                        </i>
                                    </span>
                                </div>
                            {if !$shop2.my.gr_filter_unwrap_sorting}
	                            </div>
	                        {/if}
                        {/if}
                        
                        {if !$shop2.my.gr_filter_unwrap_sorting}
                            <div class="sorting-panel__add-wrap">
                        {/if}
                            {if $shop2.my.gr_sorting_popup}
                                <div class="sorting-wrap">
                                    <div class="sorting-button sorting_button"{if $shop2.my.gr_sorting_remodal} data-remodal-target="sorting-remodal"{/if}>
                                        <span>
                                            {$shop2.my.gr_sorting_title|default:'Сортировать'}
                                            <i>
                                            	<svg class="gr-svg-icon">
	                                                <use xlink:href="#icon_shop_sort"></use>
	                                            </svg>
	                                            <svg class="gr-svg-icon gr_small_icon">
	                                                <use xlink:href="#icon_shop_sort_mobile"></use>
	                                            </svg>
                                            </i>
                                        </span>
                                    </div>
                                    {if $shop2.my.gr_sorting_remodal}
                                        <div class="remodal" data-remodal-id="sorting-remodal" role="dialog" data-remodal-options="hashTracking: false">
                                            <button data-remodal-action="close" class="remodal-close-btn">
                                                <span>
                                                    {$shop2.my.gr_remodal_close|default:'Закрыть'}
                                                    <i>
                                                    	<svg class="gr-svg-icon gr_big_icon">
	                                                        <use xlink:href="#icon_shop_close"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_close_small"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_close_mini"></use>
	                                                    </svg>
                                                    </i>
                                                </span>
                                            </button>
                                    {/if}
                                    <div class="sorting-block sorting{if $sort_price_asc || $sort_price_desc || $sort_name_asc || $sort_name_desc || $sort_amount_asc || $sort_amount_desc || $sort_rating_asc || $sort_rating_desc} active-sorting{/if}">
                                        <div class="sorting-block__title">
                                        	<span>
	                                            <ins>{$shop2.my.gr_sorting_title|default:'Сортировать'}</ins>
	                                            <i>
	                                            	<svg class="gr-svg-icon">
		                                                <use xlink:href="#icon_shop_sort"></use>
		                                            </svg>
		                                            <svg class="gr-svg-icon gr_small_icon">
		                                                <use xlink:href="#icon_shop_sort_mobile"></use>
		                                            </svg>
	                                            </i>
                                            </span>
                                        </div>
                                        <div class="sorting-block__items">
                                            <div class="sorting-block__item{if $sort_price_desc} active{/if}">
                                                <a href="#" class="sort-param sort-param-desc{if $sort_price_desc} active{/if}" data-name="price">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_desc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_price_desc|default:'Цена - убывание'}
                                                </a>
                                            </div>
                                            <div class="sorting-block__item{if $sort_price_asc} active{/if}">
                                                <a href="#" class="sort-param sort-param-asc{if $sort_price_asc} active{/if}" data-name="price">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_asc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_price_asc|default:'Цена - возрастание'}
                                                </a>
                                            </div>
                                            <div class="sorting-block__item{if $sort_name_desc} active{/if}">
                                                <a href="#" class="sort-param sort-param-desc{if $sort_name_desc} active{/if}" data-name="name">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_desc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_name_desc|default:'Название - Я-А'}
                                                </a>
                                            </div>
                                            <div class="sorting-block__item{if $sort_name_asc} active{/if}">
                                                <a href="#" class="sort-param sort-param-asc{if $sort_name_asc} active{/if}" data-name="name">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_asc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_name_asc|default:'Название - А-Я'}
                                                </a>
                                            </div>
                                            {if $shop2.my.show_amount_sort}
                                                <div class="sorting-block__item{if $sort_amount_desc} active{/if}">
                                                    <a href="#" class="sort-param sort-param-desc{if $sort_amount_desc} active{/if}" data-name="amount">
                                                        <i>
                                                        	<svg class="gr-svg-icon">
	                                                            <use xlink:href="#icon_shop_sort_desc"></use>
	                                                        </svg>
	                                                        <svg class="gr-svg-icon gr_small_icon">
	                                                            <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                        </svg>
                                                        </i>
                                                        {$shop2.my.gr_sorting_by_amount_desc|default:'Наличие - убывание'}
                                                    </a>
                                                </div>
                                                <div class="sorting-block__item{if $sort_amount_asc} active{/if}">
                                                    <a href="#" class="sort-param sort-param-asc{if $sort_amount_asc} active{/if}" data-name="amount">
                                                        <i>
                                                        	<svg class="gr-svg-icon">
	                                                            <use xlink:href="#icon_shop_sort_asc"></use>
	                                                        </svg>
	                                                        <svg class="gr-svg-icon gr_small_icon">
	                                                            <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                        </svg>
                                                        </i>
                                                        {$shop2.my.gr_sorting_by_amount_asc|default:'Наличие - возрастание'}
                                                    </a>
                                                </div>
                                            {/if}
                                            {if $shop2.my.show_rating_sort}
                                                <div class="sorting-block__item{if $sort_rating_desc} active{/if}">
                                                    <a href="#" class="sort-param sort-param-desc{if $sort_rating_desc} active{/if}" data-name="rating">
                                                        <i>
                                                        	<svg class="gr-svg-icon">
	                                                            <use xlink:href="#icon_shop_sort_desc"></use>
	                                                        </svg>
	                                                        <svg class="gr-svg-icon gr_small_icon">
	                                                            <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                        </svg>
                                                        </i>
                                                        {$shop2.my.gr_sorting_by_rating_desc|default:'Популярность - убывание'}
                                                    </a>
                                                </div>
                                                <div class="sorting-block__item{if $sort_rating_asc} active{/if}">
                                                    <a href="#" class="sort-param sort-param-asc{if $sort_rating_asc} active{/if}" data-name="rating">
                                                        <i>
                                                        	<svg class="gr-svg-icon">
	                                                            <use xlink:href="#icon_shop_sort_asc"></use>
	                                                        </svg>
	                                                        <svg class="gr-svg-icon gr_small_icon">
	                                                            <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                        </svg>
                                                        </i>
                                                        {$shop2.my.gr_sorting_by_rating_asc|default:'Популярность - возрастание'}
                                                    </a>
                                                </div>
                                            {/if}
                                            {if $sort_price_asc || $sort_price_desc || $sort_name_asc || $sort_name_desc || $sort_amount_asc || $sort_amount_desc || $sort_rating_asc || $sort_rating_desc} 
                                                <div class="sorting-block__item">
                                                    <a href="#" class="sort-reset {if !$sort_price_asc && !$sort_price_desc && !$sort_name_asc && !$sort_name_desc && !$sort_amount_asc && !$sort_amount_desc && !$sort_rating_asc && !$sort_rating_desc}active{/if}">
                                                        {$shop2.my.gr_sorting_item_default|default:'По умолчанию'}
                                                    </a>
                                                </div>
                                            {/if}
                                        </div>
                                    </div>
                                    {if $shop2.my.gr_sorting_remodal}
                                        </div>
                                    {/if}
                                </div>
                            {else}
                                <div class="sorting-block sorting{if $sort_price_asc || $sort_price_desc || $sort_name_asc || $sort_name_desc || $sort_amount_asc || $sort_amount_desc || $sort_rating_asc || $sort_rating_desc} active-sorting{/if}">
                                    <div class="sorting-block__body">
                                        <div class="sorting-block__result">
                                            <div class="sorting-block__result-title">
                                                {$shop2.my.gr_sorting_title|default:'Сортировать'}
                                            </div>
                                            {if !$sort_price_asc && !$sort_price_desc && !$sort_name_asc && !$sort_name_desc && !$sort_amount_asc && !$sort_amount_desc && !$sort_rating_asc && !$sort_rating_desc}
                                                <span class="no-sorting">{$shop2.my.gr_sorting_default|default:'По умолчанию'}</span>
                                            {/if}
                                            {if $sort_price_asc}
                                                <span class="sort-param-asc{if $sort_price_asc} active{/if}">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_asc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_price_asc|default:'Цена - возрастание'}
                                                </span>
                                            {elseif $sort_price_desc}
                                                <span class="sort-param-desc{if $sort_price_desc} active{/if}">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_desc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_price_desc|default:'Цена - убывание'}
                                                </span>
                                            {elseif $sort_name_asc}
                                                <span class="sort-param-asc{if $sort_name_asc} active{/if}">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_asc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_name_asc|default:'Название - А-Я'}
                                                </span>
                                            {elseif $sort_name_desc}
                                                <span class="sort-param-desc{if $sort_name_desc} active{/if}">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_desc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_name_desc|default:'Название - Я-А'}
                                                </span>
                                            {elseif $sort_amount_asc}
                                                <span class="sort-param-asc{if $sort_amount_asc} active{/if}">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_asc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_amount_asc|default:'Наличие - возрастание'}
                                                </span>
                                            {elseif $sort_amount_desc}
                                                <span class="sort-param-desc{if $sort_amount_desc} active{/if}">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_desc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_amount_desc|default:'Наличие - убывание'}
                                                </span>
                                            {elseif $sort_rating_asc}
                                                <span class="sort-param-asc{if $sort_rating_asc} active{/if}">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_asc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_rating_asc|default:'Популярность - возрастание'}
                                                </span>
                                            {elseif $sort_rating_desc}
                                                <span class="sort-param-desc{if $sort_rating_desc} active{/if}">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_desc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_rating_desc|default:'Популярность - убывание'}
                                                </span>
                                            {/if}
                                            <i>
                                            	<svg class="gr-svg-icon">
	                                                <use xlink:href="#icon_shop_sort"></use>
	                                            </svg>
	                                            <svg class="gr-svg-icon gr_small_icon">
	                                                <use xlink:href="#icon_shop_sort_mobile"></use>
	                                            </svg>
                                            </i>
                                        </div>
                                        <div class="sorting-block__items">
                                            <div class="sorting-block__item{if $sort_price_desc} active{/if}">
                                                <a href="#" class="sort-param sort-param-desc{if $sort_price_desc} active{/if}" data-name="price">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_desc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_price_desc|default:'Цена - убывание'}
                                                </a>
                                            </div>
                                            <div class="sorting-block__item{if $sort_price_asc} active{/if}">
                                                <a href="#" class="sort-param sort-param-asc{if $sort_price_asc} active{/if}" data-name="price">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_asc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_price_asc|default:'Цена - возрастание'}
                                                </a>
                                            </div>
                                            <div class="sorting-block__item{if $sort_name_desc} active{/if}">
                                                <a href="#" class="sort-param sort-param-desc{if $sort_name_desc} active{/if}" data-name="name">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_desc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_name_desc|default:'Название - Я-А'}
                                                </a>
                                            </div>
                                            <div class="sorting-block__item{if $sort_name_asc} active{/if}">
                                                <a href="#" class="sort-param sort-param-asc{if $sort_name_asc} active{/if}" data-name="name">
                                                    <i>
                                                    	<svg class="gr-svg-icon">
	                                                        <use xlink:href="#icon_shop_sort_asc"></use>
	                                                    </svg>
	                                                    <svg class="gr-svg-icon gr_small_icon">
	                                                        <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                    </svg>
                                                    </i>
                                                    {$shop2.my.gr_sorting_by_name_asc|default:'Название - А-Я'}
                                                </a>
                                            </div>
                                            {if $shop2.my.show_amount_sort}
                                                <div class="sorting-block__item{if $sort_amount_desc} active{/if}">
                                                    <a href="#" class="sort-param sort-param-desc{if $sort_amount_desc} active{/if}" data-name="amount">
                                                        <i>
                                                        	<svg class="gr-svg-icon">
	                                                            <use xlink:href="#icon_shop_sort_desc"></use>
	                                                        </svg>
	                                                        <svg class="gr-svg-icon gr_small_icon">
	                                                            <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                        </svg>
                                                        </i>
                                                        {$shop2.my.gr_sorting_by_amount_desc|default:'Наличие - убывание'}
                                                    </a>
                                                </div>
                                                <div class="sorting-block__item{if $sort_amount_asc} active{/if}">
                                                    <a href="#" class="sort-param sort-param-asc{if $sort_amount_asc} active{/if}" data-name="amount">
                                                        <i>
                                                        	<svg class="gr-svg-icon">
	                                                            <use xlink:href="#icon_shop_sort_asc"></use>
	                                                        </svg>
	                                                        <svg class="gr-svg-icon gr_small_icon">
	                                                            <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                        </svg>
                                                        </i>
                                                        {$shop2.my.gr_sorting_by_amount_asc|default:'Наличие - возрастание'}
                                                    </a>
                                                </div>
                                            {/if}
                                            {if $shop2.my.show_rating_sort}
                                                <div class="sorting-block__item{if $sort_rating_desc} active{/if}">
                                                    <a href="#" class="sort-param sort-param-desc{if $sort_rating_desc} active{/if}" data-name="rating">
                                                        <i>
                                                        	<svg class="gr-svg-icon">
	                                                            <use xlink:href="#icon_shop_sort_desc"></use>
	                                                        </svg>
	                                                        <svg class="gr-svg-icon gr_small_icon">
	                                                            <use xlink:href="#icon_shop_sort_desc_small"></use>
	                                                        </svg>
                                                        </i>
                                                        {$shop2.my.gr_sorting_by_rating_desc|default:'Популярность - убывание'}
                                                    </a>
                                                </div>
                                                <div class="sorting-block__item{if $sort_rating_asc} active{/if}">
                                                    <a href="#" class="sort-param sort-param-asc{if $sort_rating_asc} active{/if}" data-name="rating">
                                                        <i>
                                                        	<svg class="gr-svg-icon">
	                                                            <use xlink:href="#icon_shop_sort_asc"></use>
	                                                        </svg>
	                                                        <svg class="gr-svg-icon gr_small_icon">
	                                                            <use xlink:href="#icon_shop_sort_asc_small"></use>
	                                                        </svg>
                                                        </i>
                                                        {$shop2.my.gr_sorting_by_rating_asc|default:'Популярность - возрастание'}
                                                    </a>
                                                </div>
                                            {/if}
                                            {if $sort_price_asc || $sort_price_desc || $sort_name_asc || $sort_name_desc || $sort_amount_asc || $sort_amount_desc || $sort_rating_asc || $sort_rating_desc} 
                                                <div class="sorting-block__item">
                                                    <a href="#" class="sort-reset {if !$sort_price_asc && !$sort_price_desc && !$sort_name_asc && !$sort_name_desc && !$sort_amount_asc && !$sort_amount_desc && !$sort_rating_asc && !$sort_rating_desc}active{/if}">
                                                        {$shop2.my.gr_sorting_item_default|default:'По умолчанию'}
                                                    </a>
                                                </div>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            {/if}
                            
                            <div class="shop-view">
                                <div class="shop-view__inner">
                                    <div class="shop-view__btn">&nbsp;</div>
                                    <div class="shop-view__body">
                                        <a href="#" title="{#SHOP2_THUMBS#}" data-value="thumbs" class="shop-view__item thumbs {if ($smarty.cookies.views && $smarty.cookies.views == 'thumbs') || (!$smarty.cookies.views && $shop2.view=='thumbs')} active-view{/if}">
                                            <svg class="gr-svg-icon">
                                                <use xlink:href="#icon_shop_thumbs"></use>
                                            </svg>
                                            <svg class="gr-svg-icon gr_small_icon">
                                                <use xlink:href="#icon_shop_thumbs_small"></use>
                                            </svg>
                                        </a>
                                        <a href="#" title="{#SHOP2_LIST#}" data-value="simple" class="shop-view__item simple {if ($smarty.cookies.views && $smarty.cookies.views == 'simple') || (!$smarty.cookies.views && $shop2.view=='simple')} active-view{/if}">
                                            <svg class="gr-svg-icon">
                                                <use xlink:href="#icon_shop_simple"></use>
                                            </svg>
                                            <svg class="gr-svg-icon gr_small_icon">
                                                <use xlink:href="#icon_shop_simple_small"></use>
                                            </svg>
                                        </a>
                                        <a href="#" title="{#SHOP2_PRICE_LIST#}" data-value="list" class="shop-view__item pricelist {if ($smarty.cookies.views && $smarty.cookies.views == 'list') || (!$smarty.cookies.views && $shop2.view=='list')} active-view{/if}">
                                            <svg class="gr-svg-icon">
                                                <use xlink:href="#icon_shop_pricelist"></use>
                                            </svg>
                                            <svg class="gr-svg-icon gr_small_icon">
                                                <use xlink:href="#icon_shop_pricelist_small"></use>
                                            </svg>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        {if !$shop2.my.gr_filter_unwrap_sorting}
                            </div>
                        {/if}
                    </div>
                </div>

                <div class="shop2-warning">
                    <h2>{#SHOP2_NO_MATCHING_REQUEST#}</h2>
                </div>

            {/if}
        {/if}

    {/if}
{/if}