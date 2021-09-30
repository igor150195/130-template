{if $shop2.comment_settings.turned_on}

<div class="comments-block{if $form} comments_form{/if}">

	{if $comments}

		<div class="comments-block__items">
			{foreach from=$comments item=e}
				<div class="comment-item" id="comment-{$e.comment_number}">
					<div class="comment-item__head">
						<div class="comment-item__name">
							<a href="#comment-{$e.comment_number}">
								{$e.author_name|default:#SHOP2_ANONYMOUS_VISITOR#}
							</a>
						</div>
						<div class="comment-item__date" datetime="{$e.date_created|date_format_ex:"%Y-%m-%dT%H:%M"}">
							{$e.date_created|date_format:"%d.%m.%Y"}
						</div>
						{if $e.rating}
							<div class="comment-item__stars tpl-stars">
								<div class="tpl-rating tpl-rating-{$e.rating}"></div>
							</div>
						{/if}
					</div>
					<div class="comment-item__body">
						{$e.text|nl2br}
					</div>
				</div>
				{if $e.reply}
					<div class="comment-item__head comment_reply">
						<div class="comment-item__name"><b>{#ADMINISTRATOR#}</b></div>
					</div>
					<div class="comment-item__body comment_reply">
						{$e.reply|nl2br}
					</div>
				{/if}
			{/foreach}

			{if $pglst == -1}
				{include file="global:shop2-pagelist.tpl"}
			{else}
				{include file="global:shop2.v2-pagelist.tpl"}
			{/if}
		</div>

	{/if}


	{if $form}

		{if $comments_success}<div class="tpl-info">{$comments_success}</div>{/if}
		{if $moderation_result}<div class="tpl-info">{$moderation_result}</div>{/if}

		{if !$moderation_result}
			<div class="comments-form">
				{if $shop2.my.gr_comments_form_btn!=""}
					<div class="comments-form__btn">{$shop2.my.gr_comments_form_btn}</div>
				{/if}
				<div class="comments-form__body">
					<div class="comments-form__title">
						{$shop2.my.gr_comments_leave_review|default:#SHOP2_LEAVE_REVIEW#}
					</div>

					<div class="tpl-info">
						{#BOARD_FILL_REQUIRED_FIELDS#} <span class="tpl-required">*</span>.
					</div>

					<form method="post" class="tpl-form">
						{foreach from=$form->controls item=control}
							{if $control->type == 0}
								<input type="hidden" name="{$control->name}" value="{$control->value}" />
							{elseif $control->type==73}
								<div class="tpl-field tpl-field-reg">
									<div class="comments-chekbox">
										<label>
											<input type="checkbox" class="auth_reg" name="{$control->name}" value="1" {if $control->value}checked="checked"{/if} />
										</label>
										<span>{#PERSONAL_DATA_TITLE#}. <a href="{$control->params.url}" target="_blank">{#DETAILS#}</a></span>
									</div>
									{if $control->error}
										<div class="error-message">{$control->error_message}</div>
									{/if}
									{if $control->note}
										<div class="tpl-note">{$control->note}</div>
									{/if}
								</div>
							{elseif $control->type == 10}

								<div class="tpl-field {if $control->error && $control->error_message} field-error{/if}">
									<div class="field-title">
										{#FORM_ENTER_CAPTCHA_CODE#}
										<span class="tpl-required">*</span>

										{if $control->error}
											<div class="error-message">{#WRONG_CAPTCHA_ERROR#}</div>
										{/if}
									</div>
									<div class="tpl-value">
										{captcha name="_cn"}
									</div>
								</div>
							{else}

								<div class="tpl-field">
									{if $shop2.my.gr_comments_placeholdered==true}
											{if $control->type == 3}
												<label class="field-title" for="d[1]">
													{$control->localized_name}:
													{if $control->required}
														<span class="tpl-required">*</span>
													{/if}
													{if $control->error && $control->error_message}
														<div class="error-message">{$control->error_message}</div>
													{/if}
												</label>
											{/if}
									{else}
											<label class="field-title" for="d[1]">
												{$control->localized_name}:
												{if $control->required}
													<span class="tpl-required">*</span>
												{/if}
												{if $control->error && $control->error_message}
													<div class="error-message">{$control->error_message}</div>
												{/if}
											</label>
									{/if}
								
									<div class="tpl-value">
										{if $control->type == 1}
											<input {if $shop2.my.gr_comments_placeholdered}placeholder="{$control->localized_name}:{if $control->required}*{/if}"{/if} type="text" size="40" name="{$control->name}" {if $control->params.maxlength}maxlength="{$control->params.maxlength}"{/if} {if $control->value}value ="{$control->value}"{/if} />
										{elseif $control->type == 2}
											<textarea {if $shop2.my.gr_comments_placeholdered}placeholder="{$control->localized_name}:{if $control->required}*{/if}"{/if} cols="55" rows="3" name="{$control->name}">{$control->value}</textarea>
										{elseif $control->type == 3}

											{if $control->name == 'rating'}
												<div class="tpl-stars">
													<span>1</span>
													<span>2</span>
													<span>3</span>
													<span>4</span>
													<span>5</span>
													<input name="{$control->name}" type="hidden" value="0" />
												</div>
											{else}
												<ul>
													{foreach from=$control->options item=e}
														<li><label><input type="radio" name="{$control->name}" value="{$e.0}"> {$e.1}</label></li>
													{/foreach}
												</ul>
											{/if}

										{elseif $control->type == 12}
											<input type="password" size="{$control->params.size}" name="{$control->name}" {if $control->params.maxlength}maxlength="{$control->params.maxlength}"{/if} {if $control->value}value="{$control->value}"{/if} />
										{/if}
									</div>

									{if $control->note}
										<div class="tpl-note">{$control->note}</div>
									{/if}

								</div>
							{/if}
						{/foreach}

						<div class="tpl-field-button">
							<button type="submit">
								{#SHOP2_SEND2#}
							</button>
						</div>

					</form>

					
				</div>
			</div>
		{/if}

	{else}

		{if $user_settings.link}
			<div class="comments-reg">
				<div class="comments-reg__title">{#SHOP2_SIGN_IN_LEAVE_COMMENT#}</div>
				{include file="global:shop2.v2-authorization.tpl"}
			</div>
		{/if}
		
		{if $user_settings.social_params}
			<div class="shop2v2-cart-soc-block">
				{include file="global:block.g-social.tpl"}
			</div>
		{/if}

	{/if}

</div>

{/if}