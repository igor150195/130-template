{if $pages > 1}
	{assign var="limit" value=$limit|default:3}

	{assign var=p value=$smarty.get.p|default:""}

	{if $p === "" && $invert_pages}
		{assign var=p value=$pages-1}
	{/if}

	{assign var=url value=$smarty.server.REQUEST_URI|regex_replace:"/\/p\/\d+/":''}
	{assign var=url value=$url|regex_replace:"/\?p=\d+&/":"?"}
	{assign var=url value=$url|regex_replace:"/[?&]p=\d+/":""}

	{assign var=get value=$url|regex_replace:"/^(.+)\?/":""}

	{if $get == $url}
		{assign var=get value=""}
	{/if}

	{assign var=uri value=$url|regex_replace:"/\?(.+)$/":""}
	{assign var=uri value=$uri|regex_replace:"/\/$/":""}

	{if $not_seo}
		{assign var=dot value="?p="}
		
		{if $not_seo_promo}
			{assign var=dot value="/?p="}
		{/if}

		{if $get && $get != "/"}
			{assign var=get value="&`$get`"}
		{/if}

	{elseif $uri == ''}

		{assign var=dot value=$page.url_page|cat:"/p/"}
		{if $get && $get != "/"}
			{assign var=get value="?`$get`"}
		{/if}

	{else}

		{assign var=dot value="/p/"}
		{if $get && $get != "/"}
			{assign var=get value="?`$get`"}
		{/if}

	{/if}

	{assign var=get value=$get|htmlspecialchars}

	{if $site.trailing_slash == 'add' && !$not_seo}
		{assign var=get value="/"|cat:$get}
	{/if}
	
	{if $site.trailing_slash == 'any'}
		{if $mode == 'main'}
			{if preg_match("/\/$/", $shop2.uri)}
				{assign var=get value="/"|cat:$get}
			{/if}
		{elseif $mode=='search'}
			{assign var=get value=$get}
		{elseif preg_match("/\/$/", $fulluri)}
			{assign var=get value="/"|cat:$get}
		{/if}
	{/if}

	{capture assign="prev"}{strip}
		{if $p > 1}
			{$uri}{$dot}{$p-1}{$get}
		{else}
			{$url}
		{/if}
	{/strip}{/capture}


	{capture assign="next"}{strip}
		{$uri}{$dot}{$p+1}{$get}
	{/strip}{/capture}

	{assign var="delta" value=$limit/2|floor}
	{assign var="start" value=$p-$delta}
	{assign var="end" value=$p+$delta}

	{if $start < 0}
		{assign var="start" value=0}
		{assign var="end" value=$limit-1}
	{/if}

	{if $end >= $pages}
		{assign var="end" value=$pages}
		{assign var="start" value=$pages-$limit}
	{/if}

	{if $start < 0}
		{assign var="start" value=0}
	{/if}
	
	{if $shop2.my.lazy_load_subpages && $site.additional_work.pagelist_lazy_load  || ($smarty.cookies.pro_1699 || $smarty.cookies.gr_full_version)}
		<div class="lazy-pagelist">
			<div class="lazy-pagelist__body">
				{if $p != $pages - 1 && ((!$shop2_main_blocks && $mode=='main') || $mode=='search' || $mode=='vendor' || $mode=='tag' || ($mode=='folder' && $page.plugin_id=='16'))}
					<div class="lazy-pagelist-btn lazy_pagelist_btn">
						<span>
							{$shop2.my.gr_pagelist_more_btn|default:'Показать еще'}
							<i>
								<svg class="gr-svg-icon">
								    <use xlink:href="#icon_shop_lazy_btn"></use>
								</svg>
								<svg class="gr-svg-icon gr_small_icon">
								    <use xlink:href="#icon_shop_lazy_btn_small"></use>
								</svg>
							</i>
						</span>
					</div>
				{/if}
				{* start: {$start}, end: {$end}, pages: {$pages}, p: {$p} *}
				<div class="shop-pagelist">
					<ul class="shop-pagelist__body">
						
						<li class="page-prev{if !$p && $p == 0} not_active{/if}">
							<a href="{$prev}">
								<span>
									{$shop2.my.gr_pagelist_prev_text|default:'Пред.'}
									<i>
										<svg class="gr-svg-icon">
										    <use xlink:href="#icon_shop_pagelist_prev"></use>
										</svg>
										<svg class="gr-svg-icon gr_small_icon">
										    <use xlink:href="#icon_shop_pagelist_prev_small"></use>
										</svg>
									</i>
								</span>
							</a>
						</li>
			
						{if $start > 0}
							<li class="page-num page_first">
								<a href="{$url}">
									1
									<i>
										<svg class="gr-svg-icon">
										    <use xlink:href="#icon_shop_pagelist_first"></use>
										</svg>
										<svg class="gr-svg-icon gr_small_icon">
										    <use xlink:href="#icon_shop_pagelist_first_small"></use>
										</svg>
									</i>
								</a>
							</li>
							<li class="page-dots dots_prev">
								<span>
									<svg class="gr-svg-icon">
									    <use xlink:href="#icon_shop_pagelist_dots"></use>
									</svg>
									<svg class="gr-svg-icon gr_small_icon">
									    <use xlink:href="#icon_shop_pagelist_dots_small"></use>
									</svg>	
								</span>
							</li>
						{/if}
			
						{section name=i loop=$pages start=$start max=$end-$start+1}
							{assign var="index" value=$smarty.section.i.index}
							{if $index==$p}
								<li class="page-num active-num"><span>{$index+1}</span></li>
							{else}
								<li class="page-num"><a href="{if $index > 0}{$uri}{$dot}{$index}{$get}{else}{$url}{/if}">{$index+1}</a></li>
							{/if}
						{/section}
						
						{if $end < $pages - 1}
							<li class="page-dots dots_next">
								<span>
									<svg class="gr-svg-icon">
									    <use xlink:href="#icon_shop_pagelist_dots"></use>
									</svg>
									<svg class="gr-svg-icon gr_small_icon">
									    <use xlink:href="#icon_shop_pagelist_dots_small"></use>
									</svg>	
								</span>
							</li>
							<li class="page-num page_last">
								<a href="{$uri}{$dot}{$pages-1}{$get}">
									{$pages}
									<i>
										<svg class="gr-svg-icon">
										    <use xlink:href="#icon_shop_pagelist_last"></use>
										</svg>
										<svg class="gr-svg-icon gr_small_icon">
										    <use xlink:href="#icon_shop_pagelist_last_small"></use>
										</svg>
									</i>
								</a>
							</li>
						{/if}
			
						<li class="page-next{if $p == $pages - 1} not_active{/if}">
							<a href="{$next}">
								<span>
									{$shop2.my.gr_pagelist_next_text|default:'След.'}
									<i>
										<svg class="gr-svg-icon">
										    <use xlink:href="#icon_shop_pagelist_next"></use>
										</svg>
										<svg class="gr-svg-icon gr_small_icon">
										    <use xlink:href="#icon_shop_pagelist_next_small"></use>
										</svg>
									</i>
								</span>
							</a>
						</li>
			
					</ul>
				</div>
			</div>
		</div>
	{else}
		{* start: {$start}, end: {$end}, pages: {$pages}, p: {$p} *}
		<div class="shop-pagelist">
			<ul class="shop-pagelist__body">
				
				<li class="page-prev{if !$p && $p == 0} not_active{/if}">
					<a href="{$prev}">
						<span>
							{$shop2.my.gr_pagelist_prev_text|default:'Пред.'}
							<i>
								<svg class="gr-svg-icon">
								    <use xlink:href="#icon_shop_pagelist_prev"></use>
								</svg>
								<svg class="gr-svg-icon gr_small_icon">
								    <use xlink:href="#icon_shop_pagelist_prev_small"></use>
								</svg>
							</i>
						</span>
					</a>
				</li>
	
				{if $start > 0}
					<li class="page-num page_first">
						<a href="{$url}">
							1
							<i>
								<svg class="gr-svg-icon">
								    <use xlink:href="#icon_shop_pagelist_first"></use>
								</svg>
								<svg class="gr-svg-icon gr_small_icon">
								    <use xlink:href="#icon_shop_pagelist_first_small"></use>
								</svg>
							</i>
						</a>
					</li>
					<li class="page-dots dots_prev">
						<span>
							<svg class="gr-svg-icon">
							    <use xlink:href="#icon_shop_pagelist_dots"></use>
							</svg>
							<svg class="gr-svg-icon gr_small_icon">
							    <use xlink:href="#icon_shop_pagelist_dots_small"></use>
							</svg>	
						</span>
					</li>
				{/if}
	
				{section name=i loop=$pages start=$start max=$end-$start+1}
					{assign var="index" value=$smarty.section.i.index}
					{if $index==$p}
						<li class="page-num active-num"><span>{$index+1}</span></li>
					{else}
						<li class="page-num"><a href="{if $index > 0}{$uri}{$dot}{$index}{$get}{else}{$url}{/if}">{$index+1}</a></li>
					{/if}
				{/section}
				
				{if $end < $pages - 1}
					<li class="page-dots dots_next">
						<span>
							<svg class="gr-svg-icon">
							    <use xlink:href="#icon_shop_pagelist_dots"></use>
							</svg>
							<svg class="gr-svg-icon gr_small_icon">
							    <use xlink:href="#icon_shop_pagelist_dots_small"></use>
							</svg>	
						</span>
					</li>
					<li class="page-num page_last">
						<a href="{$uri}{$dot}{$pages-1}{$get}">
							{$pages}
							<i>
								<svg class="gr-svg-icon">
								    <use xlink:href="#icon_shop_pagelist_last"></use>
								</svg>
								<svg class="gr-svg-icon gr_small_icon">
								    <use xlink:href="#icon_shop_pagelist_last_small"></use>
								</svg>
							</i>
						</a>
					</li>
				{/if}
	
				<li class="page-next{if $p == $pages - 1} not_active{/if}">
					<a href="{$next}">
						<span>
							{$shop2.my.gr_pagelist_next_text|default:'След.'}
							<i>
								<svg class="gr-svg-icon">
								    <use xlink:href="#icon_shop_pagelist_next"></use>
								</svg>
								<svg class="gr-svg-icon gr_small_icon">
								    <use xlink:href="#icon_shop_pagelist_next_small"></use>
								</svg>
							</i>
						</span>
					</a>
				</li>
	
			</ul>
		</div>
	{/if}

{/if}