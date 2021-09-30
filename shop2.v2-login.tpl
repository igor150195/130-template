<div class="shop2-block login-form {if $smarty.cookies.login_opened}opened{/if}">
	<div class="login-form__inner">
		<div class="login-form__header">
			{if isset($user.user_id)}
				{$shop2.my.gr_login_form_header_login|default:#USER_PERSONAL_CABINET#}
			{else}
				{$shop2.my.gr_login_form_header_cabinet|default:#AUTHORIZATION#}
			{/if}
		</div>
		<div class="login-form__body">
			{if isset($user.user_id)}
				
				<div class="user-block">
					<div class="user-block__info">
						<div class="user-block__title">
							{$shop2.my.gr_login_form_user_note|default:'Вы вошли как:'}
						</div>
						<div class="user-block__name">
							{if $shop2.my.gr_login_form_wrap_name}
								<a class="user-name-link" href="{$user_settings.link}?mode=user">
							{/if}
								{$user.name}
							{if $shop2.my.gr_login_form_wrap_name}
								</a>
							{/if}
						</div>
					</div>

					<div class="user-block__settings">
						<a href="{$user_settings.link}?mode=user" class="user-settings-btn user_settings_btn">
							{$shop2.my.gr_login_form_settings|default:#USER_SETTINGS#}
						</a>
					</div>

					<div class="user-block__btns">
						<div class="user-block__orders">
							<a href="{get_seo_url mode=orders uri_prefix=$shop2.uri}" class="user-orders-btn user_orders_btn">
								{$shop2.my.gr_login_form_orders|default:#SHOP2_MY_ORDERS#}
							</a>
						</div>
						<div class="user-block__logout">
							<a href="{get_seo_url mode=logout uri_prefix=$user_settings.link}" class="user-logout-btn user_logout_btn">
								{$shop2.my.gr_login_form_logout|default:#SHOP2_LOG_OUT#}
							</a>
						</div>
					</div>
				</div>

			{else}

				<form method="post"{if $user_settings.link} action="{$user_settings.link}"{/if}>
					<input type="hidden" name="mode" value="login" />

					<div class="login-form__row login gr-field-style">
						{if !$shop2.my.gr_login_form_placeholder}
							<div class="field-title">
								{$shop2.my.gr_login_form_login|default:#SHOP2_LOGIN#}
							</div>
						{/if}
						<input {if $shop2.my.gr_login_form_placeholder}placeholder="{$shop2.my.gr_login_form_login|default:#SHOP2_LOGIN#}"{/if} type="text" name="login" id="login" tabindex="1" value="" />
					</div>
					<div class="login-form__row gr-field-style">
						{if !$shop2.my.gr_login_form_placeholder}
							<div class="field-title">
								{$shop2.my.gr_login_form_password|default:#SHOP2_PASSWORD#}
							</div>
						{/if}
						<input {if $shop2.my.gr_login_form_placeholder}placeholder="{$shop2.my.gr_login_form_password|default:#SHOP2_PASSWORD#}"{/if} type="password" name="password" id="password" tabindex="2" value="" autocomplete />
					</div>

					<div class="login-form__btns">
						<div class="login-form__enter">
							<button type="submit" class="user-enter-btn user_enter_btn" tabindex="3">{#SHOP2_LOG_IN#}</button>
						</div>
						{if $shop2.my.gr_login_form_wrap_links}
							<div class="login-form__links">
						{/if}
							<div class="login-form__forgot">
								<a href="{get_seo_url mode=forgot_password uri_prefix=$user_settings.link}" class="user-forgot-btn user_forgot_btn">
									{#SHOP2_FORGOT_PASSWORD#}
								</a>
							</div>
							<div class="login-form__reg">
								<a href="{get_seo_url mode=register uri_prefix=$user_settings.link}" class="user-reg-btn user_reg_btn">
									{#SHOP2_REGISTRATION#}
								</a>
							</div>
						{if $shop2.my.gr_login_form_wrap_links}
							</div>
						{/if}
					</div>
				</form>
				
				{if $user_settings.social_params}
					<div class="g-auth__row g-auth__social-min">
						{*Блок соц. сетей*}
						{include file="global:block.g-social.tpl"}
					</div>
				{/if}

			{/if}

		</div>
	</div>
</div>