{assign var="cfield_type" value=$custom_fields.$o_k.type}
{assign var="cfield_code" value=$custom_fields.$o_k.code}
{if $cfield_type == "multiselect"}
    <div class="cart-params__title">{$custom_fields.$o_k.name}</div>
    <div class="cart-params__value">
    	<label class="gr-select-wrapper">
		    <select name="amounts[{$product.kind_id}][{$smarty.section.co.index}][{$o_k}]" class="param-value additional-cart-params">
		    {foreach from=$product.meta.$o_k item=opt}
		    <option
		            value="{$option.name}: {$custom_fields.$o_k.options.$opt}"
		            {if $e.custom_params[$smarty.section.co.index].fields.$o_k.item_id == $opt} selected{/if}
		    >
		    {$custom_fields.$o_k.options.$opt}
		    </option>
		    {/foreach}
		    </select>
	    </label>
    </div>
{elseif $cfield_type == "color_ref"}
    <div class="cart-params__title">{$custom_fields.$o_k.name}</div>
    {assign var="values" value=$product.meta[$option.code]}
    <div class="cart-params__value">
	    <div class="shop2-color-ext-select">
	        <i></i>
	        <ul class="shop2-color-ext-options">
	            {foreach from=$values item=v name=foo}
	            {assign var="index" value=$smarty.foreach.foo.index}
	            {assign var="val" value=$option.options[$v]}
	            <li data-value="{$option.name|escape}: {$v}" class="param-value{if $e.custom_params[$smarty.section.co.index].fields.$o_k.item_id == $v} shop2-color-ext-selected{/if}">
	                <span style="{if $cf_images[$val.image.image_id]}background-image: url({s3_img src=$cf_images[$val.image.image_id] width=80 height=80 method="c"}){else}background-color:{$val.code}{/if}"><em></em></span>
	                <div>{$val.text}</div>
	                <ins></ins>
	            </li>
	            {if $e.custom_params[$smarty.section.co.index].fields.$o_k.item_id == $v}
	            {capture assign="selected"}{strip}
	            {$option.name|htmlspecialchars}: {$v}
	            {/strip}{/capture}
	            {/if}
	            {/foreach}
	        </ul>
	        <input type="hidden" class="additional-cart-params" value="{$selected}" name="amounts[{$product.kind_id}][{$smarty.section.co.index}][{$o_k}]">
	    </div>
    </div>
{/if}