<form method="post" class="tpl-form tpl-auth clear-self" action="{get_seo_url uri_prefix=$user_settings.link mode="login"}" method="post">
	{if !$site.settings.sef_url}<input type="hidden" name="mode" value="login" />{/if}
	
	<div class="tpl-left">
		<div class="tpl-field">
			{if !$shop2.my.gr_auth_placeholder}
				<div class="field-title">{#USER_ENTER_YOUR#} {if $user_settings.login_field == 'login'}{#SHOP2_LOGIN#}{else}e-mail{/if}:</div>
			{/if}
			<div class="field-value">
				<input {if $shop2.my.gr_auth_placeholder}placeholder="{#USER_ENTER_YOUR#} {if $user_settings.login_field == 'login'}{#SHOP2_LOGIN#}{else}e-mail{/if}{if !$shop2.my.gr_comments_only_field_placeholder}:{/if}"{/if} type="text" class="auth-login" name="login" value="{$email}" />
			</div>
		</div>

		<div class="tpl-field">
			{if !$shop2.my.gr_auth_placeholder}
				<div class="field-title">{#SHOP2_ENTER_PASSWORD#}:</div>
			{/if}
			<div class="field-value">
				<input {if $shop2.my.gr_auth_placeholder}placeholder="{#SHOP2_ENTER_PASSWORD#}{if !$shop2.my.gr_comments_only_field_placeholder}:{/if}"{/if} type="password" class="auth-password" name="password" />
			</div>
		</div>

		<div class="tpl-field tpl-auth-checkbox">
			<label>
				<input class="gr-authorization-checkbox" type="checkbox" name="password" onclick="this.value=(this.value=='0'?'1':'0');" value="0" name="remember" />
				{#SHOP2_LOG_IN_REMEMBER#}
			</label>
		</div>

		<div class="tpl-btns">
			<button type="submit">{#SHOP2_LOG_IN#}</button>
			{if $user_settings.registration_opened}
				<a href="{get_seo_url uri_prefix=$user_settings.link mode="register"}">{#SHOP2_REGISTRATION#}</a>
			{/if}
		</div>
		
	</div>

	<div class="tpl-right">
		<div class="tpl-field-text">
			{#SHOP2_IF_REGISTER_BUT_FORGOT_PASSWORD_MESSAGE#}
		</div>
		
		<div class="tpl-field">
			<a href="{get_seo_url uri_prefix=$user_settings.link mode="forgot_password"}">
				{#SHOP2_RECOVER_PASSWORD#}
			</a>
		</div>
	</div>
</form>