{strip}
    {if !$page.main||($mode && $mode!="main")}
    {assign var=folder_num value=2}
    <div {if $schema_org}itemscope="" itemtype="http://schema.org/BreadcrumbList"{/if}{if $class} class="{$class}"{/if}>
        {if $span}
            {capture assign=delimiter_left}{section loop=$span name=sp}<span>{/section}{/capture}
            {capture assign=delimiter_right}{section loop=$span name=sp}</span>{/section}{/capture}
        {/if}
        {if !$path_separator}{assign var=path_separator value=" \ "}{/if}
    
        {if $hide_page}{assign var=hide_page value=","|explode:$hide_page}{/if}
        
        {if $schema_org}
            <span itemscope="" itemprop="itemListElement" itemtype="http://schema.org/ListItem"><a itemprop="item" href="/"{if $rel_nofollow} rel="nofollow"{/if}><span itemprop="name">{$delimiter_left}{#MAIN_PAGE#}{$delimiter_right}</span><meta itemprop="position" content="1"></a></span>
           {else}
               <a href="/"{if $rel_nofollow} rel="nofollow"{/if}>{$delimiter_left}{#MAIN_PAGE#}{$delimiter_right}</a>
           {/if}
        {foreach from=$page.path item=e key=k}
            {if !($page.main&&($mode||$news_post)) && ($e.page_id!=$site.page_id) && ($e.url!="/") && !in_array($e.page_id, $hide_page)}
                {$path_separator}
                {if !$page.url || $e.page_id==$page.page_id&&(!($mode||$news_post)||$mode=='album_list'||$mode=='main'||$mode=='default' || ($mode=="archive" && !$article_lenta) || ($mode=="index" && $page.plugin_name=='gallery') || ($mode=="index" && $page.plugin_name == 'board') || ($shop && $mode=='index') || ($mode=="index" && $page.plugin_name == 'fast_pay'))}
                    {$delimiter_left}
                    {if $allow_tags}
                        {$e.name|htmlspecialchars_decode}
                    {else}
                        {$e.name|htmlspecialchars_decode|strip_tags}
                    {/if}
                    {$delimiter_right}
                {else}
                    {if $e.url == $shop2.uri}
                        {assign var=folder_num value=3}
                    {/if}
                    {if $schema_org}
                        <span itemscope="" itemprop="itemListElement" itemtype="http://schema.org/ListItem"><a itemprop="item" href="{$e.url}"{if $rel_nofollow} rel="nofollow"{/if}><span itemprop="name">{$delimiter_left}{if $allow_tags}{$e.name|htmlspecialchars_decode}{else}{$e.name|htmlspecialchars_decode|strip_tags}{/if}{$delimiter_right}</span><meta itemprop="position" content="{$k+2}"></a></span>
                    {else}
                        <a href="{$e.url}"{if $rel_nofollow} rel="nofollow"{/if}>{$delimiter_left}{if $allow_tags}{$e.name|htmlspecialchars_decode}{else}{$e.name|htmlspecialchars_decode|strip_tags}{/if}{$delimiter_right}</a>
                    {/if}
                {/if}
            {/if}
            {*** gallery ***}
            {if $mode=='photo'}
                {$path_separator}
                {$delimiter_left}
                {if $allow_tags}
                    {$page.title|htmlspecialchars_decode}
                {else}
                    {$page.title|htmlspecialchars_decode|strip_tags}
                {/if}
                {$delimiter_right}
            {/if}
            {*** gallery ***}
        {/foreach}
    
        {*** shop ***}
        {if $shop&&($folder||$product)&&$page.plugin_id!="16"}
            {foreach from=$shop.path item=e name=folder}
                {if !in_array($e.folder_id, $hide_page)}
                    {$path_separator}
                    {if $folder&&$smarty.foreach.folder.last}
                        {$delimiter_left}{if $allow_tags}{$e.folder_name|htmlspecialchars_decode}{else}{$e.folder_name|htmlspecialchars_decode|strip_tags}{/if}{$delimiter_right}
                    {else}
                        <a href="{if $site.settings.sef_url}{get_seo_url mode="folder" alias=$e.alias}{else}{$e.page_url}?mode=folder&folder_id={$e.folder_id}{/if}">{$delimiter_left}{if $allow_tags}{$e.folder_name|htmlspecialchars_decode}{else}{$e.folder_name|htmlspecialchars_decode|strip_tags}{/if}{$delimiter_right}</a>
                    {/if}
                {/if}
                
            {/foreach}
            {if $product}
                {$path_separator}{$delimiter_left}{if $allow_tags}{$product.product_name|htmlspecialchars_decode}{else}{$product.product_name|htmlspecialchars_decode|strip_tags}{/if}{$delimiter_right}
            {/if}
        {elseif $shop&&$mode=="cart"&&$page.plugin_id!="16"}
            {$path_separator}{$delimiter_left}{#SHOP_CART#}{$delimiter_right}
        {elseif $shop&&$mode=="search"&&$page.plugin_id!="16"}
            {$path_separator}{$delimiter_left}Поиск{$delimiter_right}
        {elseif $shop&&$mode=="order"&&$page.plugin_id!="16"}
            {$path_separator}{$delimiter_left}Оформить заказ{$delimiter_right}
        {elseif $shop&&$mode=="vendor"&&$page.plugin_id!="16"}
            {$path_separator}{$delimiter_left}{$vendor.vendor_name}{$delimiter_right}
        {elseif $shop&&$mode=="vendors"&&$page.plugin_id!="16"}
            {$path_separator}{$delimiter_left}Производители{$delimiter_right}
        {elseif $shop&&$mode=="special-products"&&$page.plugin_id!="16"}
            {$path_separator}{$delimiter_left}Спецпредложения{$delimiter_right}
        {elseif $shop&&$mode=="new-products"&&$page.plugin_id!="16"}
            {$path_separator}{$delimiter_left}Новинки{$delimiter_right}
        {elseif $shop&&$mode=="user-order"&&$page.plugin_id!="16"}
              {$path_separator}{$delimiter_left}{#SHOP2_YOUR_ORDERS#}{$delimiter_right}
        {elseif $image.gallery_image_name != "" && $page.plugin_id == 2}
          {$path_separator}{$delimiter_left}{$image.gallery_image_name}{$delimiter_right}
        {/if}
    
        {*** foto album ***}
        {if $mode=='album'}
            {$path_separator}
            {if $album.path}
                {foreach from=$album.path item=e}
                    {if !in_array($e.album_id, $hide_page)}
                    <a href="{if $site.settings.sef_url}{get_seo_url mode="album" alias=$e.url}{else}{$page.url}?mode=album&album_id={$e.album_id}{/if}"{if $rel_nofollow} rel="nofollow"{/if}>{$delimiter_left}{if $allow_tags}{$e.name|htmlspecialchars_decode}{else}{$e.name|htmlspecialchars_decode|strip_tags}{/if}{$delimiter_right}</a>
                    {$path_separator}
                    {/if}
                {/foreach}
            {/if}
    
            {$delimiter_left}
            {if $allow_tags}
                {$album.name|htmlspecialchars_decode}
            {else}
                {$album.name|htmlspecialchars_decode|strip_tags}
            {/if}
            {$delimiter_right}
        {/if}
    
        {*** news ***}
        {if $news_post}
            {$path_separator}{$delimiter_left}{if $allow_tags}{$news_post.title|htmlspecialchars_decode}{else}{$news_post.title|htmlspecialchars_decode|strip_tags}{/if}{$delimiter_right}
        {/if}
    
        {*** article ***}
        {if $article_category}
            {foreach from=$article_category.path item=e name=article_folder}
                {if !in_array($e.folder_id, $hide_page)}
                    {$path_separator}
                    {if $folder&&$smarty.foreach.article_folder.last}
                        {$delimiter_left}{if $allow_tags}{$e.folder_name|htmlspecialchars_decode}{else}{$e.folder_name|htmlspecialchars_decode|strip_tags}{/if}{$delimiter_right}
                    {else}
                        <a href="{if $site.settings.sef_url}{get_seo_url mode=folder alias=$e.alias}{else}{$page.url}?mode=folder&folder_id={$e.folder_id}{/if}"{if $rel_nofollow} rel="nofollow"{/if}>{$delimiter_left}{if $allow_tags}{$e.folder_name|htmlspecialchars_decode}{else}{$e.folder_name|htmlspecialchars_decode|strip_tags}{/if}{$delimiter_right}</a>
                    {/if}
                {/if}
            {/foreach}
        {/if}
        {if $article_post && $page.plugin_id!="23"}
            {$path_separator}{$delimiter_left}{if $allow_tags}{$article_post.title|htmlspecialchars_decode}{else}{$article_post.title|htmlspecialchars_decode|strip_tags}{/if}{$delimiter_right}
        {/if}
        {*** article2 ***}
        {if $article_lenta}
    
            {foreach from=$article_lenta.path item=e name=article_folder}
                 {if !in_array($e.folder_id, $hide_page)}
                       {$path_separator}
                    {if $folder&&$smarty.foreach.article_folder.last}
                        {$delimiter_left}{if $allow_tags}{$e.folder_name|htmlspecialchars_decode}{else}{$e.folder_name|htmlspecialchars_decode|strip_tags}{/if}{$delimiter_right}
                    {else}
                        <a href="{if $site.settings.sef_url}{get_seo_url mode=folder alias=$e.alias}{else}{$page.url}?mode=folder&folder_id={$e.folder_id}{/if}"{if $rel_nofollow} rel="nofollow"{/if}>{$delimiter_left}{if $allow_tags}{$e.folder_name|htmlspecialchars_decode}{else}{$e.folder_name|htmlspecialchars_decode|strip_tags}{/if}{$delimiter_right}</a>
                    {/if}
                {/if}
            {/foreach}
            
             {if $mode=='archive'}
                {$path_separator}{$delimiter_left}{#ARCHIVE#}{$delimiter_right}
            {elseif $mode=='offered'}
                {$path_separator}{$delimiter_left}{#OFFERED_ARTICLE#}{$delimiter_right}
            {elseif $mode=='search_archive'}
                 {$path_separator}{$delimiter_left}{#SEARCH_ARCHIVE#}{$delimiter_right}
            {elseif $mode=='date'}
                {if isset($smarty.get.date)}
                    {assign var=date value=$smarty.get.date }
                {/if}
                {$path_separator}{$delimiter_left}{$date}{$delimiter_right}
            {elseif $mode=='search'}
                {$path_separator}{$delimiter_left}{#SHOP2_SEARCH#}{$delimiter_right}
            {/if}
            {if $article_post}
                {$path_separator}{$delimiter_left}{if $allow_tags}{$article_post.title|htmlspecialchars_decode}{else}{$article_post.title|htmlspecialchars_decode|strip_tags}{/if}{$delimiter_right}
            {/if}
        {/if}
        {*** users_page ***}
        {if $page.url==$user_settings.link}
            {if $mode=='login'}
                {$path_separator}{$delimiter_left}{#PAGEPATH_USER_AUTHORIZATION#}{$delimiter_right}
            {elseif $mode=='activation'}
                {$path_separator}{$delimiter_left}{#PAGEPATH_USER_CONFIRM#}{$delimiter_right}
            {elseif $mode=='moderate'}
                {$path_separator}{$delimiter_left}{#PAGEPATH_MODERATION#}{$delimiter_right}
            {elseif $mode=='forgot_password'}
                {$path_separator}{$delimiter_left}{#PAGEPATH_PASSWORD#}{$delimiter_right}
            {elseif $mode=='register'}
                {$path_separator}{$delimiter_left}{#PAGEPATH_REGISTER#}{$delimiter_right}
            {elseif $mode=='change_password'}
                {$path_separator}{$delimiter_left}{#USER_CHANGE_PASSWORD#}{$delimiter_right}
            {elseif $mode=='settings'}
                {$path_separator}{$delimiter_left}{#SHOP2_PERSONAL_DATA#}{$delimiter_right}
            {elseif $mode=='activationemail'}
                {$path_separator}{$delimiter_left}{#USER_ACTIVATE_EMAIL#}{$delimiter_right}
            {elseif $mode=='unionuser'}
                {$path_separator}{$delimiter_left}{#USER_UNION_ACCAUNTS#}{$delimiter_right}
            {elseif $mode=='agreement'}
                {$path_separator}{$delimiter_left}{#USER_PERSONAL_DATA_TAB_NAME#}{$delimiter_right}
            {elseif $mode=='home'}
                {$path_separator}{$delimiter_left}{#SHOP2_MY_ACCOUNT#}{$delimiter_right}
            {elseif $mode=='user'}
                {$path_separator}{$delimiter_left}{#PAGEPATH_PROFILE#}{$delimiter_right}
            {/if}
        {/if}
    
        {*** vote ***}
        {if $page.plugin_id=="8" && $vote.question}{$path_separator}{$delimiter_left}{if $allow_tags}{$vote.question|htmlspecialchars_decode}{else}{$vote.question|htmlspecialchars_decode|strip_tags}{/if}{$delimiter_right}{/if}
    
        {*** shop2 ***}
        {if $page.plugin_id=="16"}
            {if ($folder||$product)&&$mode!="search"}
                {assign var=path_folders_count value=$shop2.path|@count}
                {if $path_folders_count > 5}<span class="shop2-path-show-folders" style="cursor: pointer;">{$path_separator}...</span><span class="shop2-path-hidden-folders" style="display: none;">{/if}
                {foreach from=$shop2.path item=e name=folder key=k}
    
                    {if !in_array($e.folder_id, $hide_page)}
                        {$path_separator}
                        {if $folder&&$smarty.foreach.folder.last&&$mode == "folder"}
                            {$delimiter_left}{if $allow_tags}{$e.folder_name|htmlspecialchars_decode}{else}{$e.folder_name|htmlspecialchars_decode|strip_tags}{/if}{$delimiter_right}
                        {else}
                            {if $schema_org}
                                <span itemscope="" itemprop="itemListElement" itemtype="http://schema.org/ListItem"><a itemprop="item" href="{get_seo_url mode="folder" alias=$e.alias}"{if $rel_nofollow} rel="nofollow"{/if}><span itemprop="name">{$delimiter_left}{if $allow_tags}{$e.folder_name|htmlspecialchars_decode}{else}{$e.folder_name|htmlspecialchars_decode|strip_tags}{/if}{$delimiter_right}</span><meta itemprop="position" content="{$k+$folder_num}"></a></span>
                               {else}
                                <a href="{get_seo_url mode="folder" alias=$e.alias}"{if $rel_nofollow} rel="nofollow"{/if}>{$delimiter_left}{if $allow_tags}{$e.folder_name|htmlspecialchars_decode}{else}{$e.folder_name|htmlspecialchars_decode|strip_tags}{/if}{$delimiter_right}</a>
                               {/if}
                        {/if}
                    {/if}
                {if $path_folders_count > 5 && $k == $path_folders_count-5}</span>{/if}{/foreach}
                {if $product && $shop2 && $mode == 'product'}
                    {$path_separator}{$delimiter_left}{if $allow_tags}{$product.name|htmlspecialchars_decode}{else}{$product.name|htmlspecialchars_decode|strip_tags}{/if}{$delimiter_right}
                {/if}
            {elseif $shop2&&$mode=="cart"}
                {$path_separator}{$delimiter_left}{#SHOP2_CART#}{$delimiter_right}
            {elseif $shop2&&$mode=="vendor"}
                {$path_separator}{$delimiter_left}{$vendor.name}{$delimiter_right}
            {elseif $shop2&&$mode=="vendors"}
                {$path_separator}{$delimiter_left}{#SHOP2_VENDORS2#}{$delimiter_right}
            {elseif $shop2&&$mode=="order"}
                {$path_separator}{$delimiter_left}{#SHOP2_ORDER#}{$delimiter_right}
            {elseif $shop2&&$mode=="search"}
                {$path_separator}{$delimiter_left}{#SHOP2_SEARCH#}{$delimiter_right}
    {*         {elseif $shop2&&$mode=="tag"}
                {$path_separator}{$delimiter_left}{$tag|htmlspecialchars}{$delimiter_right} *}
            {elseif $shop2&&$mode=="orders"}
                {if $order}
                    {$path_separator}{$delimiter_left}{#SHOP2_YOUR_ORDER#}{$delimiter_right}
                {else}
                    {$path_separator}{$delimiter_left}{#SHOP2_YOUR_ORDERS#}{$delimiter_right}
                {/if}
            {/if}
        {/if}
        
        {if $mode == "tag"}
            {$path_separator}{$delimiter_left}{$tag|htmlspecialchars}{$delimiter_right}
        {/if}
    
    </div>
    {/if}
    {/strip}