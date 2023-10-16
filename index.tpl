<!doctype html>
<html lang="{$site.lang}">
<head>
<meta charset="utf-8">
<meta name="robots" content="{if $page.noindex==2}noindex,follow{elseif $page.noindex==3}index,nofollow{elseif $page.noindex}none{else}all{/if}">
<title>{$page.title|strip_tags}</title>
<meta name="description" content="{$page.description|escape}">
<meta name="keywords" content="{$page.keywords|escape}">
<meta name="SKYPE_TOOLBAR" content="SKYPE_TOOLBAR_PARSER_COMPATIBLE">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no">
<meta http-equiv="x-rim-auto-match" content="none">

{if $site.site_type_id == 19 && !preg_match("/Chrome-Lighthouse/i", $smarty.server.HTTP_USER_AGENT)}
	<script type="text/javascript" src="/g/templates/shop2/files/js/gr_configurator.js" id="configurator_json" data-site-id="{$site.site_id}">{$smarty.get|@json_encode}</script>
{/if}

<link rel="preload" href="/g/libs/jquery/2.2.4/jquery-2.2.4.min.js" as="script">
<script src="/g/libs/jquery/2.2.4/jquery-2.2.4.min.js" charset="utf-8"></script>

<!-- common js -->
{include file="global:init.tpl"}
<!-- common js -->

<!-- shop init -->
{include file="global:shop2.v2-init.tpl" shop2_disable_scripts=true shop2_enable_min_js=true css=true}
<!-- shop init -->

{if $shop2.my.gr_local_theme}
	{if $site.site_type_id == 19 && !preg_match("/Chrome-Lighthouse/i", $smarty.server.HTTP_USER_AGENT)} 
	    <script>document.write('<link rel="stylesheet" href="images/themes/theme0' + (localStorage.getItem('s3-themeswitcher-index') || {$shop2.my.gr_selected_theme|default:0}) + '/colors.css" id="s3-themeswitcher-link" data-root="images/" data-type="colors.css">');</script>
	{/if}
{else}
	{if $site.site_type_id == 19 && !preg_match("/Chrome-Lighthouse/i", $smarty.server.HTTP_USER_AGENT)} 
	    <script>document.write('<link rel="stylesheet" href="images/themes/theme0' + (localStorage.getItem('s3-themeswitcher-index') || {$shop2.my.gr_selected_theme|default:0}) + '/colors.css" id="s3-themeswitcher-link" data-root="images/" data-type="colors.css">');</script>
	{/if}
{/if}

{if $site.additional_work.open_graph} 
	{assign var=meta_logo_width value=$site.header_block.logo_width|strip_tags|regex_replace:"/[^\d]/":""|default:90}
	{assign var=meta_logo_height value="-"}
	{if $mode == 'main'}
	    <meta property="og:image" content="{$smarty.server.PROTOCOL}://{$smarty.server.HTTP_HOST}{s3_img width=$meta_logo_width height=$meta_logo_height method=c src=$site.header_block.site_logo.filename}"/>
	    <meta property="og:type" content="website" />
	    <meta property="og:title" content="{$page.title|strip_tags}"/>
	    <meta property="og:description" content="{$page.description|escape}"/>
	    <meta property="og:url" content="{$smarty.server.PROTOCOL}://{$smarty.server.HTTP_HOST}{$smarty.server.SCRIPT_URL}"/>
	{elseif $mode == "product"}
	    <meta property="og:image" content="{s3_img src=$product.image_filename}"/>
	    <meta property="og:type" content="website" />
	    <meta property="og:title" content="{$product.name|default:$h1|default:$page.name}"/>
	    <meta property="og:description" content="{$page.description|escape}"/>
	    <meta property="og:url" content="{$smarty.server.PROTOCOL}://{$smarty.server.HTTP_HOST}{$smarty.server.SCRIPT_URL}"/>
	{elseif $mode == 'folder'}
		<meta property="og:image" content="{$smarty.server.PROTOCOL}://{$smarty.server.HTTP_HOST}{s3_img width=$meta_logo_width height=$meta_logo_height method=c src=$site.header_block.site_logo.filename}"/>
	    <meta property="og:type" content="website" />
	    <meta property="og:title" content="{$folder.folder_name}"/>
	    <meta property="og:description" content="{$page.description|escape}"/>
	    <meta property="og:url" content="{$smarty.server.PROTOCOL}://{$smarty.server.HTTP_HOST}{$smarty.server.SCRIPT_URL}"/>
	{else}
	    <meta property="og:image" content="{$smarty.server.PROTOCOL}://{$smarty.server.HTTP_HOST}{s3_img width=$meta_logo_width height=$meta_logo_height method=c src=$site.header_block.site_logo.filename}"/>
	    <meta property="og:type" content="website" />
	    <meta property="og:title" content="{$h1|default:$page.h1|default:$page.name}"/>
	    <meta property="og:description" content="{$page.description|escape}"/>
	    <meta property="og:url" content="{$smarty.server.PROTOCOL}://{$smarty.server.HTTP_HOST}{$smarty.server.SCRIPT_URL}"/>
	{/if}
{/if}

{$head_user_code.body}

{include file="global:header.custom.assets.tpl"}

</head>

<body class="site">

	{include file="site-variables.tpl"}

	{if isset($smarty.get.icons)}
		{include file="sprite-icons.tpl"}
	{/if}
	
	<div class="site__wrapper">

		{include file="local_site_header.tpl"}

		{if $mode=='main' && $page.plugin_id == '16'} 
			{if strpos($smarty.server.DOCUMENT_URI, '/p/') === false} 
				 {*Проверка для скрытия блоков после перехода по пагинации на главной магазина*}
		   {/if}
		 {/if}

		<div class="site-container">
			<div class="site-container__inner">

				{if isset($smarty.get.styles)}
					{include file="styles.tpl"}
				{/if}

				<main class="site-main block_padding{if $mode=='main' && $shop2_main_blocks}{if $site.product_settings.main_colums==1} product_columns_2{elseif $site.product_settings.main_colums==2} product_columns_3{elseif $site.product_settings.main_colums==3} product_columns_4{elseif $site.product_settings.main_colums==4} product_columns_5{elseif $site.product_settings.main_colums==5} product_columns_6{else} product_columns_4{/if}{else}{if $site.product_settings.thumb_columns==1} product_columns_2{elseif $site.product_settings.thumb_columns==2} product_columns_3{elseif $site.product_settings.thumb_columns==3} product_columns_4{elseif $site.product_settings.thumb_columns==4} product_columns_5{elseif $site.product_settings.thumb_columns==5} product_columns_6{else} product_columns_4{/if}{/if}">
					<div class="site-main__inner block_width">

						{if !isset($smarty.get.styles)}
							{* {include file="global:pagepath-2.2.130.tpl" path_separator="<span class='site-path__separator'>/</span>" class="site-path"} *}
							<div class="site-path">
								<a href="#">Главная</a><span class="site-path__separator">/</span><a href="#">Категория товаров 1</a><span class="site-path__separator">/</span>Примерный товар номер #10
							</div>

							<h1>{$h1|default:$page.h1|default:$page.name}</h1>
							<h2>Заголовок интернет-магазина</h2>
							<h3>Заголовок интернет-магазина</h3>
							<h4>Заголовок интернет-магазина</h4>
							<h5>Заголовок интернет-магазина</h5>
							<h6>Заголовок интернет-магазина</h6>


							{tpl.body}
						{/if}

						<link href="images/css/theme.scss.css" rel="preload" as="style">
						<link href="/g/templates/shop2/2.130.2/default/css/shop2_less.css" rel="preload" as="style">

						<link rel="stylesheet" href="/g/templates/shop2/2.130.2/default/css/shop2_less.css">
						<link rel="stylesheet" href="images/css/theme.scss.css">

						<link rel="preload" href="images/themes/theme{$site.theme|default:0}/colors.css" as="style">
						<link rel="stylesheet" href="images/themes/theme{$site.theme|default:0}/colors.css">

						<link rel="preload" as="style" href="/g/templates/shop2/2.130.2/default/global/css/global_styles.css">
						<link rel="stylesheet" href="/g/templates/shop2/2.130.2/default/global/css/global_styles.css">


						{if isset($smarty.get.shop)}
							{include file="shop-elements.tpl"}
						{/if}
	
					</div>
				</main> <!-- .site-main -->
 				
			</div>
		</div> <!-- .site-container -->

		<div class="remodal" data-remodal-id="search-form" role="dialog" data-remodal-options="hashTracking: false">
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
		{include file="global:shop2.v2-search-form.tpl"}
    </div>
    
    <div class="remodal" data-remodal-id="login-form" role="dialog" data-remodal-options="hashTracking: false">
        <button data-remodal-action="close" class="remodal-close-btn">
            <span>
                {$shop2.my.gr_remodal_close|default:'Закрыть'}
                <svg class="gr-svg-icon gr_big_icon">
                    <use xlink:href="#icon_shop_close"></use>
                </svg>
                <svg class="gr-svg-icon">
                    <use xlink:href="#icon_shop_close_small"></use>
                </svg>
                <svg class="gr-svg-icon gr_small_icon">
                    <use xlink:href="#icon_shop_close_mini"></use>
                </svg>
            </span>
        </button>
		{include file="global:shop2.v2-login.tpl"}
    </div>

		{include file="local_site_footer.tpl"}

	</div> <!-- .site__wrapper -->

	{include file="icons-site-sprite.tpl"}
	{include file="icons-shop-sprite.tpl"}
	
	
	{if !$site.additional_work.quick_view && !$smarty.cookies.pro_1703 && !$smarty.cookies.gr_full_version}
		{literal}
			<style>.quick-view-trigger {display: none !important;}</style>
		{/literal}
	{/if}

	{*if !$site.additional_work.gr_favorites && !$smarty.cookies.pro_1943 && !$smarty.cookies.gr_full_version}
		{literal}
			<style>.gr-favorite-btn-wrapper, .shop-panel-favorite {display: none !important;}</style>
		{/literal}
	{/if*}
	
	{if $site.product_settings.images_tone}
		{literal}
			<style>:root {--gr_product_img_overlay: transparent !important;}</style>
		{/literal}
	{/if}

	<style>
		:root {ldelim}
			--font1: 'Roboto', sans-serif; --font2: 'Inter', sans-serif;
			{* --font1: 'Montserrat', sans-serif;--font2: 'Montserrat Alternates', sans-serif; *}
		{rdelim}
	</style>

	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
	{* <link href="https://fonts.googleapis.com/css2?family=Montserrat+Alternates:wght@300;400;500;600;700&family=Montserrat:wght@300;400;500;700&display=swap" rel="stylesheet"> *}

	{literal}
		<style>
			@font-face {
				font-family: 'icomoon';
				src:  url('images/fonts/icomoon.ttf') format('truetype');
				font-weight: normal;
				font-style: normal;
				font-display: swap;
			}
		</style>
	{/literal}

	{if $site.additional_work.magnifier || $smarty.cookies.pro_1700 || $smarty.cookies.gr_full_version}
		<script src="/g/libs/jquery-zoom/1.7.21/js/jquery.zoom.min.js"></script>
	{/if}
	{if $site.additional_work.quick_view || $smarty.cookies.pro_1703 || $smarty.cookies.gr_full_version}
		<script src="/g/templates/shop2/2.130.2/default-3/js/quick_view_popup.js"></script>
	{/if}
	{if ($site.additional_work.quick_cart || $smarty.cookies.pro_1709 || $smarty.cookies.gr_full_version) && !$shop2.white_cabinet}
		<script src="/g/templates/shop2/2.130.2/default-2/js/cart_preview_popup.js"></script>
	{/if}
	
	{if $site.additional_work.product_preview_popup || $smarty.cookies.pro_1711 || $smarty.cookies.gr_full_version}
		<script src="/g/templates/shop2/2.130.2/default-2/js/product_preview_popup.js"></script>
	{/if}
	{if $shop2.json.compare}
		<script src="/g/templates/shop2/2.130.2/default-2/js/compare_preview_popup.js"></script>
	{/if}
	{if (($site.additional_work.quick_view || $smarty.cookies.pro_1703) || ($site.additional_work.product_preview_popup || $smarty.cookies.pro_1711) || $smarty.cookies.gr_full_version)}
		<script src="/g/libs/jquery-popover/0.0.5/jquery.popover.js"></script>
	{/if}

	{if $shop2.json.favorite_products == 1}
		<script src="/g/libs/jquery-cookie/1.4.0/jquery.cookie.js"></script>
		<script src="/g/templates/shop2/2.130.2/default-2/js/shop_favorite.js"></script>
	
		<script>
			let is_user = {if isset($user.user_id)}true{else}false{/if};
			window._s3Lang.ADD_TO_FAVORITE = '{#ADD_TO_FAVORITE#}';
			window._s3Lang.FORUM_FAVORITES = '{#FORUM_FAVORITES#}';
			// Данные для всплывающего окна
		</script>
	{/if}
	
	{if $shop2.json.compare}
		<script>
			var gr_compare_kind_id = {ldelim}{rdelim};
			{foreach from=$compare item=e key=k}
				gr_compare_kind_id['{$e.kind_id}'] = true;
			{/foreach}
		</script>
	{/if}
	
	<script src="https://polyfill.io/v3/polyfill.min.js?features=IntersectionObserver"></script>

	<script src="images/js/plugins.js" charset="utf-8"></script>
	<script src="images/js/shop_main.js" charset="utf-8"></script>

	{if $site.additional_work.search_smart || $smarty.cookies.pro_1696 || $smarty.cookies.gr_full_version}
		<script src="/g/templates/shop2/2.130.2/default-2/js/smart_search.js"></script>
		<script src="/g/templates/shop2/2.130.2/default-2/js/m.smart_search.js"></script>
	{/if}
	
	{if $site.additional_work.timer_top || $smarty.cookies.pro_1701 || $smarty.cookies.gr_full_version}
		<script src="/g/templates/shop2/2.130.2/default-2/js/top_timer.js"></script>
	{/if}
	{if $site.additional_work.popup_timer || $smarty.cookies.pro_1704 || $smarty.cookies.gr_full_version}
		<script src="/g/templates/shop2/2.130.2/default-2/js/special_timer_popup.js"></script>
	{/if}
	
	
	{if $body_user_code.body}
		<div id="body_user_code">
		    {$body_user_code.body}
		</div>
	{/if}
	
	{include file="global:bottom.custom.assets.tpl"}
</body>
<!-- ID -->
</html>