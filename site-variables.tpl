{if $site.custom_settings.enable_custom_settings}
	<script>
		var gr_root_styles  = document.createElement('style');
		
		gr_root_styles.innerHTML = ':root {ldelim}' +
			{if $site.custom_settings.primary}'--Primary: {$site.custom_settings.primary};' + {/if}
			{if $site.custom_settings.primary}'--Primary_1:' + grConvertHex('{$site.custom_settings.primary}', 0.1) + ';' + {/if}
			{if $site.custom_settings.primary}'--Primary_2:' + grConvertHex('{$site.custom_settings.primary}', 0.2) + ';' + {/if}
			{if $site.custom_settings.primary}'--Primary_4:' + grConvertHex('{$site.custom_settings.primary}', 0.4) + ';' + {/if}
			{if $site.custom_settings.primary}'--Primary_6:' + grConvertHex('{$site.custom_settings.primary}', 0.6) + ';' + {/if}
			{if $site.custom_settings.accent}'--Accent: {$site.custom_settings.accent};' + {/if}
			{if $site.custom_settings.accent}'--Accent_1:' + grConvertHex('{$site.custom_settings.accent}', 0.1) + ';' + {/if}
			{if $site.custom_settings.accent}'--Accent_2:' + grConvertHex('{$site.custom_settings.accent}', 0.2) + ';' + {/if}
			{if $site.custom_settings.accent}'--Accent_4:' + grConvertHex('{$site.custom_settings.accent}', 0.4) + ';' + {/if}
			{if $site.custom_settings.accent}'--Accent_5:' + grConvertHex('{$site.custom_settings.accent}', 0.5) + ';' + {/if}
			{if $site.gr_settings.dark_mode=="1" || !isset($site.gr_settings.dark_mode)}
				{if $site.custom_settings.gr_bg}'--gr_bg: {$site.custom_settings.gr_bg};' + {/if}
				{if $site.custom_settings.on_gr_bg_bg}'--on_gr_bg_bg: {$site.custom_settings.on_gr_bg_bg};' + {/if}
				{if $site.custom_settings.gr_bg_foot}'--gr_bg_foot: {$site.custom_settings.gr_bg_foot};' + {/if}
			{/if}
		'{rdelim}';
		document.body.insertAdjacentElement('afterend', gr_root_styles);
	
		function grConvertHex(hexCode, opacity){ldelim}
		    var hex = hexCode.replace('#','');
	
		    if (hex.length === 3) {ldelim}
		        hex = hex[0] + hex[0] + hex[1] + hex[1] + hex[2] + hex[2];
		    {rdelim}
	
		    var r = parseInt(hex.substring(0,2), 16),
		        g = parseInt(hex.substring(2,4), 16),
		        b = parseInt(hex.substring(4,6), 16);
	
		    return 'rgba('+r+','+g+','+b+','+opacity+')';
		{rdelim}; {* Конвертация hex в rgba *}
	</script>
{/if}