{if $anketa}

    {if $smarty.post.param.placeholdered_fields  || $smarty.get.param.placeholdered_fields}
    	{assign var=placeholdered_fields value=$placeholdered_fields|default:$smarty.get.param.placeholdered_fields|default:$smarty.post.param.placeholdered_fields}
    {/if}
    {if $smarty.get.param.subtitle || $smarty.post.param.subtitle}
    	{assign var=subtitle value=$anketa.desc|default:$smarty.get.param.subtitle|default:$smarty.post.param.subtitle}
    {/if}
    {if $smarty.get.param.formtitle || $smarty.post.param.formtitle}
    	{assign var=formtitle value=$anketa.desc|default:$smarty.get.param.formtitle|default:$smarty.post.param.formtitle}
    {/if}
    {if $smarty.get.param.hide_title || $smarty.post.param.hide_title}
    	{assign var=hide_title value=$hide_title|default:$smarty.get.param.hide_title|default:$smarty.post.param.hide_title}
    {/if}
    {if $smarty.get.param.product_name || $smarty.post.param.product_name}
    	{assign var=product_name value=$product_name|default:$smarty.get.param.product_name|default:$smarty.post.param.product_name}
    {/if}
    {if $smarty.get.param.product_link || $smarty.post.param.product_link}
    	{assign var=product_link value=$product_link|default:$smarty.get.param.product_link|default:$smarty.post.param.product_link}
    {/if}
	
	{if $smarty.get.param.policy_checkbox || $smarty.post.param.policy_checkbox}
    	{assign var=policy_checkbox value=$policy_checkbox|default:$smarty.get.param.policy_checkbox|default:$smarty.post.param.policy_checkbox}
    {/if}
    
    {if $smarty.get.param.has_span_button || $smarty.post.param.has_span_button}
    	{assign var=has_span_button value=$has_span_button|default:$smarty.get.param.has_span_button|default:$smarty.post.param.has_span_button}
    {/if}
    
    <div class="tpl-anketa" data-api-url="{$anketa.postform_api_uri}" data-api-type="form">
    	{if !$anketa.posted}
	    	{if !$hide_title}
		    	<div class="tpl-anketa__left">
		        	<div class="tpl-anketa__title">{if $formtitle}{$formtitle}{else}{$anketa.name}{/if}</div>
		        	{if $subtitle}<div class="tpl-anketa__subtitle">{$subtitle}</div>{/if}
		        </div>
	        {/if}
        {/if}
        <div class="tpl-anketa__right{if $anketa.posted} tpl-anketa__posted{/if}">
	        {if !$anketa.posted}
	            <form method="post" action="{$page.url}" data-s3-anketa-id="{$anketa.anketa_id}">
	                <input type="hidden" name="param[placeholdered_fields]" value="{$placeholdered_fields}" />
	                <input type="hidden" name="form_id" value="{$anketa.anketa_id}">
	                <input type="hidden" name="subtitle" value="{$anketa.desc}">
	                <input type="hidden" name="param[hide_title]" value="{$hide_title}" />
	                <input type="hidden" name="param[product_name]" value="{$product_name}" />
                	<input type="hidden" name="param[product_link]" value="{$smarty.server.PROTOCOL}://{$product_link}" />
                	<input type="hidden" name="param[policy_checkbox]" value="{$policy_checkbox}" />
                	<input type="hidden" name="param[has_span_button]" value="{$has_span_button}" />
	                <input type="hidden" name="tpl" value="{$use_tpl|default:$smarty.template}">
	                {if $anketa.dictionaries}
		                {foreach from=$anketa.dictionaries item=e name=fee}
		                    {if $e.type_code=="DIV"}
		                    {*============================================================*}
			                    <div class="tpl-field type-title">
			                        <h2>{$e.name}</h2>
								</div>
		                    {elseif $e.type_code=="HTML_BLOCK"}
		                    {*============================================================*}
		                        <div class="tpl-field type-html">{$e.html}</div>
		                    {else}
		                        <div class="tpl-field type-{$e.type_code|lower}{if $e.required==1} field-required{/if}{if $e.error} field-error{/if}{if $smarty.foreach.fee.last && ($e.type_code=="TEXT" || $e.type_code=="EMAIL" || $e.type_code=="PHONE")} last-inline{/if}{if ($anketa.dictionaries|@count==1 && ($e.dictionary_position==0 && ($e.type_code == "TEXT" || $e.type_code == "EMAIL" || $e.type_code == "PHONE"))) || ($anketa.dictionaries|@count==2 && ($anketa.dictionaries.0.type_code=="CHECKBOX" || $anketa.dictionaries.1.type_code=="CHECKBOX") && (($anketa.dictionaries.0.type_code == "EMAIL" || $anketa.dictionaries.1.type_code == "EMAIL") || ($anketa.dictionaries.0.type_code == "PHONE" || $anketa.dictionaries.1.type_code == "PHONE") || ($anketa.dictionaries.0.type_code == "TEXT" || $anketa.dictionaries.1.type_code == "TEXT")))} first-inline{/if}{if $e.type_code=='HIDDEN'} hide{/if}{if $e.alias == 'product_name'} tpl-field__product-name{elseif $e.alias == 'ip'} tpl-field__ip{elseif $e.alias == 'product_link'} tpl-field__product-link{/if}{if $policy_checkbox && $e.type_code=="CHECKBOX"} policy_checkbox{/if}">
		                            {if $e.name && $e.type_code!="CHECKBOX" && (!$placeholdered_fields || $e.type_code=="UPLOAD" || $e.type_code=="SELECT" || $e.type_code=="MULTI_SELECT" || $e.type_code=="MULTI_CHECKBOX" || $e.type_code=="RADIO_GROUP" || $e.type_code=="CALENDAR_INTERVAL")}
		                                <div class="field-title">{$e.name}:{if $e.required==1} <span class="field-required-mark">*</span>{/if}</div>
		                            {/if}
		                            
		                            {if $e.error}
		                                <div class="error-message">{$e.error}</div>
		                            {/if}
		                            <div class="field-value">
		                                {if $e.type_code=="TEXT" || $e.type_code=="EMAIL" || $e.type_code=="PHONE"}
		                                {*============================================================*}
		                                    <input type="text" 
		                                    	{if $e.required==1} required {/if} 
			                                    size="{$e.size}" 
			                                    maxlength="{$e.maxlength}" 
			                                    value="{$e.value|htmlspecialchars}" 
			                                    name="d[{$e.dictionary_position}]"{if $placeholdered_fields} 
			                                    placeholder="{$e.name}{if $e.required==1} *{/if}"{/if} 
		                                    />
		                                {elseif $e.type_code=="HIDDEN"}
										{*============================================================*}
											<input type="hidden"
												{if $e.required==1} required {/if} 
			                                    size="{$e.size}" 
			                                    maxlength="{$e.maxlength}" 
			                                    value="{if $e.alias == 'product_name'}{$product_name}{elseif $e.alias == 'ip'}{$smarty.server.HTTP_X_REAL_IP}{elseif $e.alias == 'product_link'}{$smarty.server.PROTOCOL}://{$product_link}{else}{$e.value|htmlspecialchars}{/if}" 
			                                    {if $e.alias == 'product_name'}class="tpl-anketa__product-name"{elseif $e.alias == 'ip'}class="tpl-anketa__ip"{elseif $e.alias == 'product_link'}class="tpl-anketa__product-link"{/if}
			                                    name="d[{$e.dictionary_position}]" 
		                                    />
		                                {elseif $e.type_code=="TEXTAREA"}
		                                {*============================================================*}
		                                    <textarea 
		                                    	{if $e.required==1} required {/if} 
			                                    cols="{$e.cols}" 
			                                    rows="{$e.rows}" 
			                                    name="d[{$e.dictionary_position}]"{if $placeholdered_fields} 
			                                    placeholder="{$e.name}{if $e.required==1} *{/if}"{/if}>{$e.value|htmlspecialchars}</textarea>
		                                {elseif $e.type_code=="SELECT" || $e.type_code=="MULTI_SELECT"}
		                                {*============================================================*}
		                                	{if $e.type_code!="MULTI_SELECT"}<label class="gr-select-wrapper">{/if}
		                                    <select size="{$e.size}" 
		                                    	{if $e.required==1} required {/if} 
			                                    name="d[{$e.dictionary_position}]{if $e.type_code=="MULTI_SELECT"}[]{/if}"{if $e.type_code=="MULTI_SELECT"} 
			                                    multiple="multiple"{/if}>
		                                        <option value="">{#ANKETA_USER_NOT_SELECTED#}</option>
		                                        {foreach from=$e.options item=option}
		                                            <option{if $option.selected==true} selected="selected"{/if} value="{$option.name}">{$option.name}</option>
		                                        {/foreach}
		                                    </select>
		                                    {if $e.type_code!="MULTI_SELECT"}</label>{/if}
		                                {elseif $e.type_code=="CHECKBOX" || $e.type_code=="MULTI_CHECKBOX" || $e.type_code=="RADIO_GROUP"}
		                                {*============================================================*}
		                                    <ul>
		                                        {if $e.type_code=="CHECKBOX"}
		                                            <li>
	                                            		
	                                            		<label>
	                                            			<input 
	                                            				{if $e.required==1} required {/if} 
			                                            		type="checkbox"{if $e.value==$e.name|strip_tags || $e.alias == "checked"} 
			                                            		checked="checked"{/if} 
			                                            		value="#ON#" 
			                                            		name="d[{$e.dictionary_position}]" 
		                                            		/>
	                                            			<span>{$e.name}</span>
	                                            		</label>
		                                        	</li>
		                                        {else}
		                                            {foreach from=$e.options item=option}
		                                                <li>
	                                                		
		                                                	<label 
		                                                		>
		                                                		<input 
		                                                			{if $e.required==1 && $e.type_code=="RADIO_GROUP"} required {/if} 
	                                                				type="{if $e.type_code=="RADIO_GROUP"}radio{else}checkbox{/if}"{if $option.selected==true} 
			                                                		checked="checked"{/if} 
			                                                		value="{$option.name}" 
			                                                		name="d[{$e.dictionary_position}][]" 
			                                                	/>
		                                                		<span>{$option.name}</span>
		                                            		</label>
		                                        		</li>
		                                            {/foreach}
		                                        {/if}
		                                    </ul>
		                                {elseif $e.type_code=="CALENDAR"}
		                                {*============================================================*}{assign var=has_callendar value=1}
		                                    <span>
		                                    	<input type="text" size="15" readonly="readonly" 
			                                    	value="{$e.value|escape}" 
			                                    	name="d[{$e.dictionary_position}]" 
			                                    	id="d[{$e.dictionary_position}]" 
			                                    	class="datepickerInit"{if $placeholdered_fields} 
			                                    	placeholder="{$e.name}{if $e.required==1} *{/if}"{/if} 
		                                    	/>
		                                	</span>
		                                {elseif $e.type_code=="CALENDAR_INTERVAL"}
		                                {*============================================================*}{assign var=has_callendar value=1}
		                                    <label class="calendar-label calendar-from">
		                                        {if !$placeholdered_fields}
		                                        	{$e.label_from|default:#ANKETA_CALENDAR_INVERVAL_FROM#}
		                                        {/if}
		                                        <input type="text" size="7" readonly="readonly" 
			                                        value="{$e.value|regex_replace:"/^(d+.d+.d+)[^~]+/":"1"}" 
			                                        id="d[{$e.dictionary_position}][0]" 
			                                        class="datepicker-interval input-from"{if $placeholdered_fields} 
			                                        placeholder="{$e.label_from|default:#ANKETA_CALENDAR_INVERVAL_FROM#}{if $e.required==1} *{/if}"{/if} 
		                                        />
		                                    </label>
		                                    <label class="calendar-label calendar-to disabled">
		                                        {if !$placeholdered_fields}{$e.label_to|default:#ANKETA_CALENDAR_INVERVAL_TO#}{/if}
		                                        <input type="text" size="7" readonly="readonly" 
			                                        value="{$e.value|regex_replace:"/[^~]+?(d+.d+.d+)$/":"1"}" 
			                                        id="d[{$e.dictionary_position}][1]" 
			                                        class="datepicker-interval input-to"{if $placeholdered_fields} 
			                                        placeholder="{$e.label_to|default:#ANKETA_CALENDAR_INVERVAL_TO#}{if $e.required==1} *{/if}"{/if} 
		                                        />
		                                    </label>
		                                    <input data-test="{$e.value}" class="datepicker-interval-result" type="hidden" 
			                                    value="{$e.value|escape}" 
			                                    name="d[{$e.dictionary_position}]" 
			                                    id="d[{$e.dictionary_position}]" 
		                                    />
		                                    <div class="field-note">{#BOTH_FIELD_REQUIRED#}</div>
		                                {elseif $e.type_code=="UPLOAD"}
		                                {*============================================================*}
			                                {if !$_upload_css_attached}
			                                    {assign var="_upload_css_attached" value="1"}
			                                	<link type="text/css" rel="stylesheet" href="/shared/s3/swfupload/default.css" />
			                                    <script type="text/javascript" src="/shared/s3/plupload/plupload.all.pack.js"></script>
			                                {/if}
			                                {if $e.uploaded}
			                                    <div class="upload-progress">
			                                        {foreach from=$e.uploaded item=upload}
			                                            <div class="progressWrapper">
			                                                <div class="progressContainer">
			                                                    <div class="progressName">{$upload.filename}</div>
			                                                    <div class="progressBarStatus">{#UPLOADED#}...</div>
			                                                    <div class="progressBarComplete"></div>
			                                                </div>
			                                            </div>
			                                        {/foreach}
			                                        <input type="hidden" name="d[{$e.dictionary_position}]" value="{$e.uploaded_str|escape}" />
			                                    </div>
			                                {else}
			                                	{assign var=unique_key value=$rand|default:1|rand:1000}
			                                    <script type="text/javascript">
			                                        $(function(){ldelim}
				                                        var JS_FORM_REQUIRED_FIELD = '{#BOARD_FILL_REQUIRED_FIELDS#}';
				                                        newSWFU({$unique_key}, {if $e.required==1}true{else}false{/if}, {$e.count}, "{$e.upload_url}", "{$e.upload_field}", "{$e.maxsize} MB", "{$e.filetypes.1}", "{$e.filetypes.0}", "{$e.buttontitle}");
			                                        {rdelim});
			                                    </script>
			                                    <div class="upload-progress" id="fsUploadProgress{$unique_key}"></div>
			                                    <div class="upload-button">
			                                    	<span id="spanButtonPlaceHolder{$unique_key}"></span>
			                                    	{if $e.count}<span class="upload-count">{#NO_MORE#}: {$e.count}</span>{/if}
			                                	</div>
			                                	<input type="hidden" name="d[{$e.dictionary_position}]" id="hidUploadField{$unique_key}" value="" />
			                                {/if}
		                                {/if}{*==========================КОНЕЦ==================================*}
		                                
		                                {if $e.note!=""}
		                                	<div class="field-note">
		                                		{$e.note}
		                            		</div>
		                            	{/if}
		                            </div>
		                        </div>
		                    {/if}
		                {/foreach}
	
	        		{/if}
	        		
	                {if $anketa.captcha}
	                    <div class="tpl-field tpl-field-captcha field-required{if $anketa.captcha_error} field-error{/if}">
	                        {if $anketa.captcha_error}<div class="error-message">{#WRONG_CAPTCHA_ERROR#}</div>{/if}
	                        <div class="field-value">
	                            {captcha name="_cn"}
	                        </div>
	                    </div>
	                {/if}
	
	                <div class="tpl-field tpl-field-button">
	                    <button type="submit" class="tpl-form-button">{if $has_span_button}<span>{/if}{$anketa.submit_name}{if $has_span_button}</span>{/if}</button>
	                </div>
	
	            </form>
	            
	        	{if $has_callendar}<script type="text/javascript" src="/shared/misc/calendar.gen.js"></script>{/if}
	        	
	        {else}
	            <div class="tpl-anketa-success-note">{$anketa.success_note}</div>
	        {/if}
        </div>
    </div>
{/if}