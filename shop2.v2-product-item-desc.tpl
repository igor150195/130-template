{assign var="collections_to_tabs" value=$shop2.my.collections_to_tabs}
{if !$collections_to_tabs}
	{assign var="collections_to_tabs" value=","|explode:""}
{/if}

{capture assign="kinds"}{strip}
	{foreach from=$product.kinds item=e}
		{if $e.kind_id != $product.kind_id}
			{assign var=gr_collections_item value=$shop2.my.gr_collections_item|default:'global:shop2.v2-product-item-collections.tpl'}
			{include file=$gr_collections_item show_params=1 buy=$shop2.my.buy_kind mod_block=true}
		{/if}
	{/foreach}
{/strip}{/capture}

{capture assign="params"}{strip}
	{include file="global:shop2.v2-product-params.tpl" e=$product}
{/strip}{/capture}

{capture assign="shop2_tabs"}{strip}

	{assign var="active_found" value=0}
	{assign var="active_found_2" value=0}

	{if $product.body}
		<li {if !$active_found}class="active-tab r-tabs-state-active"{assign var="active_found" value=1}{/if}>
			<a href="#shop2-tabs-2">
				<span>
					{$shop2.my.description|default:#SHOP2_DESCRIPTION#}
					<i>
						<svg class="gr-svg-icon tabs_down">
						    <use xlink:href="#icon_shop_tabs_down"></use>
						</svg>
						<svg class="gr-svg-icon tabs_up">
						    <use xlink:href="#icon_shop_tabs_up"></use>
						</svg>
					</i>
				</span>
			</a>
		</li>
	{/if}

	{if $params && !$shop2.my.hide_params}
		<li {if !$active_found}class="active-tab r-tabs-state-active"{assign var="active_found" value=1}{/if}>
			<a href="#shop2-tabs-1">
				<span>
					{$shop2.my.params|default:#SHOP2_OPTIONS#}
					<i>
						<svg class="gr-svg-icon tabs_down">
						    <use xlink:href="#icon_shop_tabs_down"></use>
						</svg>
						<svg class="gr-svg-icon tabs_up">
						    <use xlink:href="#icon_shop_tabs_up"></use>
						</svg>
					</i>
				</span>
			</a>
		</li>
	{/if}

	{if $kinds && !$shop2.my.hide_kinds}
		<li {if !$active_found}class="active-tab r-tabs-state-active"{assign var="active_found" value=1}{/if}>
			<a href="#shop2-tabs-3">
				<span>
					{$shop2.my.modification|default:#SHOP2_MODIFICATIONS#}
					<i>
						<svg class="gr-svg-icon tabs_down">
						    <use xlink:href="#icon_shop_tabs_down"></use>
						</svg>
						<svg class="gr-svg-icon tabs_up">
						    <use xlink:href="#icon_shop_tabs_up"></use>
						</svg>
					</i>
				</span>
			</a>
		</li>
	{/if}

	{foreach from=$collections item=collection key=k}
		{if $collections.$k|@count>0 && in_array($k, $collections_to_tabs)}
			<li {if !$active_found}class="active-tab r-tabs-state-active"{assign var="active_found" value=1}{/if}>
				<a href="#shop2-tabs-{$k}">
					<span>
						{if $k == 'accessory'}
							{$shop2.my.accessory|default:#SHOP2_ACCESSORIES#}
						{elseif $k == 'recommend'}
							{$shop2.my.recommend|default:#SHOP2_RECOMMENDED#}
						{elseif $k == 'kit'}
							{$shop2.my.kit|default:#SHOP2_KIT#}
						{elseif $k == 'similar'}
							{$shop2.my.similar|default:#SHOP2_SIMILAR#}
						{/if}
						<i>
							<svg class="gr-svg-icon tabs_down">
							    <use xlink:href="#icon_shop_tabs_down"></use>
							</svg>
							<svg class="gr-svg-icon tabs_up">
							    <use xlink:href="#icon_shop_tabs_up"></use>
							</svg>
						</i>
					</span>
				</a>
			</li>
		{/if}
	{/foreach}
	
	{if $shop2.comment_settings.turned_on && !$shop2.my.gr_comments_out}
		<li {if !$active_found}class="active-tab r-tabs-state-active"{assign var="active_found" value=1}{/if}>
	        <a href="#shop2-tabs-01">
	        	<span>
	        		{$shop2.my.gr_comments_header|default:#SHOP2_REVIEWS#}{if $product.comments.items} {foreach from=$product.comments.items item=e name=foo}{if $smarty.foreach.foo.last}<ins class="rev-counter">{if !$shop2.my.gr_tabs_unwrapped}({/if}{$smarty.foreach.foo.iteration}{if !$shop2.my.gr_tabs_unwrapped}){/if}</ins>{/if}{/foreach}{/if}
	        		<i>
	        			<svg class="gr-svg-icon tabs_down">
						    <use xlink:href="#icon_shop_tabs_down"></use>
						</svg>
						<svg class="gr-svg-icon tabs_up">
						    <use xlink:href="#icon_shop_tabs_up"></use>
						</svg>
	        		</i>
	        	</span>
	        </a>
	    </li>
    {/if}
	
	{assign var="shop2_descs" value=''}
	{foreach from=$meta name=foo item=option key=k}
		{assign var="index" value=$smarty.foreach.foo.index+10}
		{assign var="e" value=$product.large_meta.$k}
		{if $e && $option.type == 'html' && $option.in_params}
				
				{if !$shop2.my.gr_no_responsive_tabs}
					<li {if !$active_found}class="active-tab r-tabs-state-active"{/if}>
						<a href="#shop2-tabs-{$index}">
							<span>
								{$option.name}
								<i>
									<svg class="gr-svg-icon tabs_down">
									    <use xlink:href="#icon_shop_tabs_down"></use>
									</svg>
									<svg class="gr-svg-icon tabs_up">
									    <use xlink:href="#icon_shop_tabs_up"></use>
									</svg>
								</i>
							</span>
						</a>
					</li>

					{capture assign="shop2_desc"}
						{if $shop2.my.gr_responsive_tabs_2}
							<div class="r-tabs-accordion-title{if !$active_found_2 && !$active_found} r-tabs-state-active{assign var="active_found_2" value=1}{/if}">
								<a href="#shop2-tabs-{$index}">
									<span>
									{$option.name}
										<i>
											<svg class="gr-svg-icon tabs_down">
											    <use xlink:href="#icon_shop_tabs_down"></use>
											</svg>
											<svg class="gr-svg-icon tabs_up">
											    <use xlink:href="#icon_shop_tabs_up"></use>
											</svg>
										</i>
									</span>
								</a>
							</div>
						{/if}
						<div class="desc-area html_block {if !$active_found}active-area r-tabs-state-active{/if}" id="shop2-tabs-{$index}">
							{$e}
						</div>
					{/capture}
				{/if}

				{if $shop2.my.gr_no_responsive_tabs}
					{capture assign="shop2_desc"}
						<div class="shop-product-data__desc-item html_tab">
							<div class="shop-product-data__desc-title">
								{$option.name}
							</div>
							<div class="desc-area html_block {if !$active_found}active-area r-tabs-state-active{/if}" id="shop2-tabs-{$index}">
								{$e}
							</div>
						</div>
					{/capture}
				{/if}
			
			{assign var="shop2_descs" value=$shop2_descs|cat:$shop2_desc}

			{if !$active_found}
				{assign var="active_found" value=1}
			{/if}
			{if !$active_found_2 && !$active_found}
				{assign var="active_found_2" value=1}
			{/if}
		{/if}
	{/foreach}

{/strip}{/capture}

{if !$shop2.my.hide_tabs && $shop2_tabs}
	<div {if !$shop2.my.gr_no_responsive_tabs}id="product-tabs" {/if}class="shop-product-data{if $shop2.my.gr_no_responsive_tabs} no_tabs{/if}">
		{if !$shop2.my.hide_tabs && $shop2_tabs}
			{if !$shop2.my.gr_no_responsive_tabs}
				<ul class="shop-product-data__nav">
					{$shop2_tabs}
				</ul>
			{/if}

			{assign var="active_found" value=0}
			{assign var="active_found_2" value=0}
			<div class="shop-product-data__desc">

				{if $product.body!=""}
					{if $shop2.my.gr_no_responsive_tabs}
						<div class="shop-product-data__desc-item html_tab">
							<div class="shop-product-data__desc-title">
								{$shop2.my.description|default:#SHOP2_DESCRIPTION#}
							</div>
					{/if}
							{if $product.body}
								{if $shop2.my.gr_responsive_tabs_2}
									<div class="r-tabs-accordion-title{if !$active_found_2 && !$active_found} r-tabs-state-active{assign var="active_found_2" value=1}{/if}">
										<a href="#shop2-tabs-2">
											<span>
											{$shop2.my.description|default:#SHOP2_DESCRIPTION#}
												<i>
													<svg class="gr-svg-icon tabs_down">
													    <use xlink:href="#icon_shop_tabs_down"></use>
													</svg>
													<svg class="gr-svg-icon tabs_up">
													    <use xlink:href="#icon_shop_tabs_up"></use>
													</svg>
												</i>
											</span>
										</a>
									</div>
								{/if}
								<div class="desc-area html_block {if !$active_found}active-area r-tabs-state-active{assign var="active_found" value=1}{/if}" id="shop2-tabs-2">
									{$product.body}
								</div>
							{/if}
					{if $shop2.my.gr_no_responsive_tabs}
						</div>
					{/if}
				{/if}
				
				{if $params && !$shop2.my.hide_params}
					{if $shop2.my.gr_no_responsive_tabs}
						<div class="shop-product-data__desc-item params_tab">
							<div class="shop-product-data__desc-title">
								{$shop2.my.params|default:#SHOP2_OPTIONS#}
							</div>
					{/if}
							{if $shop2.my.gr_responsive_tabs_2}
								<div class="r-tabs-accordion-title{if !$active_found_2 && !$active_found} r-tabs-state-active{assign var="active_found_2" value=1}{/if}">
									<a href="#shop2-tabs-1">
										<span>
										{$shop2.my.params|default:#SHOP2_OPTIONS#}
											<i>
												<svg class="gr-svg-icon tabs_down">
												    <use xlink:href="#icon_shop_tabs_down"></use>
												</svg>
												<svg class="gr-svg-icon tabs_up">
												    <use xlink:href="#icon_shop_tabs_up"></use>
												</svg>
											</i>
										</span>
									</a>
								</div>
							{/if}
							<div class="desc-area params_block {if !$active_found}active-area r-tabs-state-active{assign var="active_found" value=1}{/if}" id="shop2-tabs-1">
								{$params}
							</div>
					{if $shop2.my.gr_no_responsive_tabs}
						</div>
					{/if}
				{/if}
				
				{if $kinds && !$shop2.my.hide_kinds}
					{if $shop2.my.gr_no_responsive_tabs}
						<div class="shop-product-data__desc-item  mod_tab">
							<div class="shop-product-data__desc-title">
								{$shop2.my.modification|default:#SHOP2_MODIFICATIONS#}
							</div>
					{/if}
							{if $shop2.my.gr_responsive_tabs_2}
								<div class="r-tabs-accordion-title{if !$active_found_2 && !$active_found} r-tabs-state-active{assign var="active_found_2" value=1}{/if}">
									<a href="#shop2-tabs-3">
										<span>
										{$shop2.my.modification|default:#SHOP2_MODIFICATIONS#}
											<i>
												<svg class="gr-svg-icon tabs_down">
												    <use xlink:href="#icon_shop_tabs_down"></use>
												</svg>
												<svg class="gr-svg-icon tabs_up">
												    <use xlink:href="#icon_shop_tabs_up"></use>
												</svg>
											</i>
										</span>
									</a>
								</div>
							{/if}
							<div class="desc-area mods_block {if !$active_found}active-area r-tabs-state-active{assign var="active_found" value=1}{/if}" id="shop2-tabs-3">
								<div class="kinds-block">
									<div class="kinds-block__items">
										{$kinds}
									</div>
								</div><!-- Group Products -->
							</div>
					{if $shop2.my.gr_no_responsive_tabs}
						</div>
					{/if}
				{/if}
				
				
				{foreach from=$collections item=collection key=k}
					{if $collections.$k|@count>0 && in_array($k, $collections_to_tabs)}
						{if $shop2.my.gr_no_responsive_tabs}
							<div class="shop-product-data__desc-item collections_tab">
								<div class="shop-product-data__desc-title">
									<div class="shop-product-data__desc-title">
										<span>
											{if $k == 'accessory'}
												{$shop2.my.accessory|default:#SHOP2_ACCESSORIES#}
											{elseif $k == 'recommend'}
												{$shop2.my.recommend|default:#SHOP2_RECOMMENDED#}
											{elseif $k == 'kit'}
												{$shop2.my.kit|default:#SHOP2_KIT#}
											{elseif $k == 'similar'}
												{$shop2.my.similar|default:#SHOP2_SIMILAR#}
											{/if}
										</span>
									</div>
								</div>
						{/if}
								{if $shop2.my.gr_responsive_tabs_2}
									<div class="r-tabs-accordion-title{if !$active_found_2 && !$active_found} r-tabs-state-active{assign var="active_found_2" value=1}{/if}">
										<a href="#shop2-tabs-{$k}">
											<span>
												{if $k == 'accessory'}
													{$shop2.my.accessory|default:#SHOP2_ACCESSORIES#}
												{elseif $k == 'recommend'}
													{$shop2.my.recommend|default:#SHOP2_RECOMMENDED#}
												{elseif $k == 'kit'}
													{$shop2.my.kit|default:#SHOP2_KIT#}
												{elseif $k == 'similar'}
													{$shop2.my.similar|default:#SHOP2_SIMILAR#}
												{/if}
												<i>
													<svg class="gr-svg-icon tabs_down">
													    <use xlink:href="#icon_shop_tabs_down"></use>
													</svg>
													<svg class="gr-svg-icon tabs_up">
													    <use xlink:href="#icon_shop_tabs_up"></use>
													</svg>
												</i>
											</span>
										</a>
									</div>
								{/if}	
								<div class="desc-area mods_block {if !$active_found}active-area r-tabs-state-active{assign var="active_found" value=1}{/if}" id="shop2-tabs-{$k}">
									
									<div class="kinds-block">
										<div class="kinds-block__items">
											{foreach from=$collections.$k item=e}
												{assign var=gr_collections_item value=$shop2.my.gr_collections_item|default:'global:shop2.v2-product-item-collections.tpl'}
												{include file=$gr_collections_item e=$collection_products.$e buy=$shop2.my.buy_mod}
											{/foreach}
										</div>
									</div>
								</div>
								
						{if $shop2.my.gr_no_responsive_tabs}
							</div>
						{/if}
					{/if}
				{/foreach}
				
				{if $shop2.comment_settings.turned_on && !$shop2.my.gr_comments_out}
					{if $shop2.my.gr_no_responsive_tabs}
						<div class="shop-product-data__desc-item comments_tab">
							<div class="shop-product-data__desc-title">
								{$shop2.my.gr_comments_header|default:#SHOP2_REVIEWS#}
							</div>
					{/if}
						{if $shop2.my.gr_responsive_tabs_2}
							<div class="r-tabs-accordion-title{if !$active_found_2 && !$active_found} r-tabs-state-active{assign var="active_found_2" value=1}{/if}">
								<a href="#shop2-tabs-01">
									<span>
									{$shop2.my.gr_comments_header|default:#SHOP2_REVIEWS#}{if $product.comments.items} {foreach from=$product.comments.items item=e name=foo}{if $smarty.foreach.foo.last}<ins class="rev-counter">{if !$shop2.my.gr_tabs_unwrapped}({/if}{$smarty.foreach.foo.iteration}{if !$shop2.my.gr_tabs_unwrapped}){/if}</ins>{/if}{/foreach}{/if}
										<i>
											<svg class="gr-svg-icon tabs_down">
											    <use xlink:href="#icon_shop_tabs_down"></use>
											</svg>
											<svg class="gr-svg-icon tabs_up">
											    <use xlink:href="#icon_shop_tabs_up"></use>
											</svg>
										</i>
									</span>
								</a>
							</div>
						{/if}
						<div class="desc-area comments_block {if !$active_found}active-area r-tabs-state-active{assign var="active_found" value=1}{/if}" id="shop2-tabs-01">
		                    {assign var=gr_comments_block value=$shop2.my.gr_comments_block|default:'global:shop2.v2-comments.tpl'}
							{include file=$gr_comments_block comments=$product.comments.items form=$product.comments.fields comments_success=$product.comments.comments_success}
		                </div>
		            {if $shop2.my.gr_no_responsive_tabs}
						</div>
					{/if}
                {/if}

                {$shop2_descs}

			</div><!-- Product Desc -->
		{/if}
	</div>
{/if}