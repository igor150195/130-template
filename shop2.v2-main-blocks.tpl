{if $shop2.my.gr_main_blocks_tabs}

	<div class="main-blocks">
		<div class="main-blocks__inner">
			{foreach from=$shop2_main_blocks item=e key=k}
				{if $e.type == 0}
					<div class="main-text">
						{if $e.name}
							<div class="main-text__title">
								<span>{$e.name|htmlspecialchars}</span>
							</div>
						{/if}
				
						{if $e.text_before}
							<div class="main-text__body">
								{$e.text_before}
							</div>
						{/if}
					</div>
				{/if}
			{/foreach}
	
			<div class="main-blocks__tabs">
				<div class="main-blocks__tabs-head">
					<div class="main-blocks__tabs-head-wr">
						{foreach from=$shop2_main_blocks name=main_blocks_foreach item=e key=k}
							{if $e.products}
								{if $e.name}
									<div class="main-blocks__tabs-title{if $smarty.foreach.main_blocks_foreach.iteration==1} active{/if}">
										<span>{$e.name|htmlspecialchars}</span>
									</div>
								{/if}
							{/if}
						{/foreach}
					</div>
				</div>
				<div class="main-blocks__tabs-body">
					{foreach from=$shop2_main_blocks name=main_blocks_foreach item=e key=k}
						{if $e.products}
							<div class="main-blocks__tabs-holder{if $smarty.foreach.main_blocks_foreach.iteration==1} active{/if}">
						
								{if $e.text_before}
									<div class="main-blocks__tabs-holder__before">
										{$e.text_before}
									</div>
								{/if}
								
								<div class="main-blocks__tabs-box{if $shop2.my.gr_main_blocks_lazy} {$shop2.my.gr_main_blocks_lazy_class|default:'gr_lazy_load_block'}{/if}"{if $shop2.my.gr_main_blocks_lazy} data-func="{$shop2.my.gr_main_blocks_func|default:'mainBlocks'}"{/if}>
									{assign var=gr_product_list value=$shop2.my.gr_product_list|default:'global:shop2.v2-product-list.tpl'}
		    						{include file=$gr_product_list data=$e.products meta=$custom_fields product_list_main=$shop2.my.gr_product_list_main wrap_product_item=$shop2.my.gr_product_item_wrap}
								</div>
							
								{if $e.text_after}
									<div class="main-blocks__tabs-holder__after">
										{$e.text_after}
									</div>
								{/if}
								
							</div>
						{/if}
					{/foreach}
				</div>
			</div>
		</div>
	</div>

{else}

	<div class="main-blocks">
		<div class="main-blocks__inner">
			{foreach from=$shop2_main_blocks item=e key=k}
				{if $e.type == 0}
					<div class="main-text main-blocks__item">
						{if $e.name}
							<div class="main-text__title">
								<span>{$e.name|htmlspecialchars}</span>
							</div>
						{/if}
				
						{if $e.text_before}
							<div class="main-text__body">
								{$e.text_before}
							</div>
						{/if}
					</div>
				{else}
					<div class="main-products main-blocks__item{if $shop2.my.gr_main_blocks_lazy} {$shop2.my.gr_main_blocks_lazy_class|default:'gr_lazy_load_block'}{/if}"{if $shop2.my.gr_main_blocks_lazy} data-func="{$shop2.my.gr_main_blocks_func|default:'mainBlocks'}"{/if}>
						{if $e.name}
							<div class="main-products__title">
								<span>{$e.name|htmlspecialchars}</span>
							</div>
						{/if}
						
						{if $e.text_before}
							<div class="main-products__before">
								{$e.text_before}
							</div>
						{/if}
						
						{assign var=gr_product_list value=$shop2.my.gr_product_list|default:'global:shop2.v2-product-list.tpl'}
	    				{include file=$gr_product_list data=$e.products meta=$custom_fields product_list_main=$shop2.my.gr_product_list_main wrap_product_item=$shop2.my.gr_product_item_wrap}
						
						{if $e.text_after}
							<div class="main-products__after">
								{$e.text_after}
							</div>
						{/if}
					</div>
				{/if}
			{/foreach}
		</div>
	</div>
	
{/if}