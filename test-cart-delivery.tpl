<div class="shop2-cart-registration">
	<div class="shop2-info">
		Вы авторизованы как test@mail.ru
	</div>
</div>

<div class="shop-cart-text">
	Для получения персональных и сезонных  скидок, а также уникальных предложений предлагаем Вам пройти несложную процедуру 
	Для получения персональных и сезонных  скидок, а также уникальных предложений предлагаем Вам пройти несложную процедуру 
	Для получения персональных и сезонных  скидок, а также уникальных предложений предлагаем Вам пройти несложную процедуру 
	Для получения персональных и сезонных  скидок, а также уникальных предложений предлагаем Вам пройти несложную процедуру
</div>


<div class="shop2-cart-auth">
	<div class="shop2-cart-auth__row">
		Cовершаете покупки впервые? Вы можете пройти несложную процедуру <a href="/registraciya/register">Регистрации в магазине</a>
	</div>
	<div class="shop2-cart-auth__row">
		<a href="#" class="shop2-cart-auth__expand js-shop2-cart-auth__expand">Войдите в Личный кабинет</a>, если совершали покупки ранее.
	</div>

	<form class="shop2-cart-auth__form js-shop2-cart-auth__form" method="post" action="{$user_settings.link}">
		<input type="hidden" name="mode" value="login" />
		<div class="gr-field-style login_field">
			<div class="field-title">{#SHOP2_LOGIN#}<span>:</span></div>
			<input type="text" name="login" />
		</div>
		<div class="gr-field-style password_field">
			<div class="field-title">{#SHOP2_PASSWORD#}<span>:</span></div>
			<input type="text" name="password" />
		</div>
		<button class="shop2-cart-auth__btn" type="submit">
			<span>{#SHOP2_LOG_IN_PLACE_ORDER#}</span>
		</button>
        
        <link rel="stylesheet" href="/g/basestyle/1.0.0/user/user.blue.css">
		<div class="shop2v2-cart-soc-block">
            <div class="g-form-field__title"> <b>Также Вы можете войти через:</b>
            </div>
            <div class="g-social">
                <a href="#" class="g-social__item g-social__item--fb">Facebook</a>
                <a href="#" class="g-social__item g-social__item--gp">Google</a>
                <a href="#" class="g-social__item g-social__item--tw">Twitter</a>
            </div>
            <div class="g-auth__personal-note">
                Я согласен(на) на обработку моих персональных данных.
                <a href="/registraciya?mode=agreement" target="_blank">Подробнее</a>
            </div>
        </div>
	</form>

	<div class="shop2-cart-auth__row shop2-cart-auth__row--top-offset">
        Или продолжите оформление заказа <strong>без регистрации</strong>
    </div>
</div>


<form action="/magazin/cart?action=save" method="post" class="shop2-cart-order-form shop2-order-options shop2-order-in-one-page-form shop2-delivery" id="form_g-anketa">
    <h2>Доставка</h2>
    <div class="shop2-order-options shop2-delivery">
        <div class="options-list">
            <div class="option-type active-type">
                <label class="option-label">
                    <input name="delivery_id" type="radio" autocomplete="off" checked="checked" value="219051">
                    <span>Почта Россииn - бесплатно</span>
                </label>
                <div class="option-details">
                    <div class="option-item">
                        <label>
                            <span>ФИО<span class="required">*</span>
                            </span>
                            <input class="shop2-input" name="219051[0]" type="text" size="30" maxlength="100" value="">
                        </label>
                    </div>
                    <div class="option-item">
                        <label>
                            <span>
                                Адрес доставки<span class="required">*</span>
                            </span>
                            <textarea name="219051[1]" cols="50" rows="5" class="shop2-textarea"></textarea>
                        </label>
                    </div>
                    <div class="option-item">
                        <label>
                            <span>
                                Почтовый индекс<span class="required">*</span>
                            </span>
                            <input class="shop2-input" name="219051[2]" type="text" size="30" maxlength="100" value="">
                        </label>
                    </div>
                    <div class="option-item">
                        <label>
                            <span>Телефон</span>
                            <input class="shop2-input" name="219051[3]" type="text" size="30" maxlength="100" value="">
                        </label>
                    </div>
                </div>
            </div>
            <div class="option-type">
                <label class="option-label">
                    <input name="delivery_id" type="radio" autocomplete="off" value="219251">
                    <span>Ems</span>
                </label>
                <div class="option-details">
                    <div class="option-item">
                        <label>
                            <span>Адрес доставки<span class="required">*</span>
                            </span>
                            <textarea name="219251[0]" disabled="" cols="50" rows="5" class="shop2-textarea"></textarea>
                        </label>
                    </div>
                    <div class="option-item">
                        <label>
                            <span>Почтовый индекс<span class="required">*</span>
                            </span>
                            <input class="shop2-input" name="219251[1]" disabled="" type="text" size="30" maxlength="100" value="">
                        </label>
                    </div>
                    <div class="option-item">
                        <label>
                            <span>Телефон</span>
                            <input class="shop2-input" name="219251[2]" disabled="" type="text" size="30" maxlength="100" value="">
                        </label>
                    </div>
                    <div class="option-item">
                        <label>
                            <span>Город<span class="required">*</span></span>
                            <label class="gr-select-wrapper">
                                <select id="delivery-to" name="219251[to]" disabled="">
                                    <option value="">--выберите город--</option>
                                    <optgroup label="Город">
                                        <option value="city--abakan">АБАКАН</option>
                                        <option value="city--anadyr">АНАДЫРЬ</option>
                                        <option value="city--anapa">АНАПА</option>
                                    </optgroup>
                                    <optgroup label="Регионы">
                                        <option value="region--respublika-adygeja">АДЫГЕЯ РЕСПУБЛИКА</option>
                                        <option value="region--respublika-altaj">АЛТАЙ РЕСПУБЛИКА</option>
                                        <option value="region--altajskij-kraj">АЛТАЙСКИЙ КРАЙ</option>
                                    </optgroup>
                                </select>
                            </label>
                        </label>
                    </div>
                    <label>
                        <a class="shop2-btn" href="#" data-attach-id="219251" id="shop2-ems-calc">Рассчитать</a>
                        <span id="delivery-219251-cost">0</span> р.
                    </label>
                </div>
            </div>
            <div class="option-type">
                <label class="option-label">
                    <input name="delivery_id" type="radio" autocomplete="off" value="219451">
                    <span>Курьер - 1&nbsp;500 р.</span>
                </label>
                <div class="option-details">
                    <p><b>При выборе данного способа доставки необходимо выбрать способ оплаты на следующей странице.</b><br></p>
                    <div class="option-item">
                        <label>
                            <span>Адрес доставки<span class="required">*</span>
                            </span>
                            <textarea name="219451[0]" disabled="" cols="50" rows="5" class="shop2-textarea"></textarea>
                        </label>
                    </div>
                    <div class="option-item">
                        <label>
                            <span>Телефон</span>
                            <input class="shop2-input" name="219451[1]" disabled="" type="text" size="30" maxlength="100" value="">
                        </label>
                    </div>
                    <div class="option-item">
                        <label>
                            <span>Дата и время доставки</span>
                            <input class="shop2-input" name="219451[2]" disabled="" type="text" size="30" maxlength="100" value="">
                        </label>
                    </div>
                </div>
            </div>
            <div class="option-type">
                <label class="option-label">
                    <input name="delivery_id" type="radio" autocomplete="off" value="219651">
                    <span>Самовывоз - бесплатно</span>
                </label>
                <div class="option-details">
                    <div class="option-item">
                        <label>
                            <span>Дополнительный коментарий </span>
                            <textarea name="219651[0]" cols="50" rows="5" class="shop2-textarea" disabled=""></textarea>
                        </label>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <h2>Форма заказа</h2>
    <div class="shop2-order-form shop2-order-form--offset-left">
        <div class="form-item">
            <label>
                <strong>ФИО<span class="required">*</span></strong>
                <input type="text" maxlength="100" size="50" name="order[fio]" id="user_fio" value="" class="shop2-input">
            </label>
        </div>
        <div class="form-item">
            <label>
                <strong>Компания</strong>
                <input type="text" maxlength="100" size="50" name="order[company]" id="user_company" value="" class="shop2-input">
            </label>
        </div>
        <div class="form-item">
            <label>
                <strong>Телефон<span class="required">*</span></strong>
                <input type="text" maxlength="100" size="50" name="order[phone]" id="user_phone" value="" class="shop2-input">
            </label>
        </div>
        <div class="form-item">
            <label>
                <strong>Email<span class="required">*</span></strong>
                <input type="text" maxlength="100" size="50" name="order[email]" id="user_email" value="" class="shop2-input">
            </label>
        </div>
        <div class="form-item">
            <label>
                <strong>Дополнительная информация</strong>
                <textarea rows="7" cols="50" name="order[note]" id="user_note" class="shop2-textarea"></textarea>
            </label>
        </div>
        <div class="form-item form-item__captcha">
            <label>
                <strong>
                </strong>
                <div data-name="invisible_captcha" data-msize="4" data-sitekey="6LeVwogUAAAAALIZPKgL8kWMMsJVhCXo9ftH1dSN" data-lang="ru" data-rsize="compact" data-type="image" data-theme="light">
                    <div class="grecaptcha-badge" data-style="bottomright" style="width: 256px; height: 60px; display: block; transition: right 0.3s ease 0s; position: fixed; bottom: 14px; right: -186px; box-shadow: gray 0px 0px 5px; border-radius: 2px; overflow: hidden;">
                        <div class="grecaptcha-logo"><iframe src="https://www.google.com/recaptcha/api2/anchor?ar=1&amp;k=6LeVwogUAAAAALIZPKgL8kWMMsJVhCXo9ftH1dSN&amp;co=aHR0cDovL2dyLW5ldy1kZWZhdWx0LXNob3AyLm9tbC5ydTo4MA..&amp;hl=ru&amp;type=image&amp;v=AFBwIe6h0oOL7MOVu88LHld-&amp;theme=light&amp;size=invisible&amp;cb=eprqe9nf8kiv" width="256" height="60" role="presentation" name="a-muigab7oitfp" frameborder="0" scrolling="no" sandbox="allow-forms allow-popups allow-same-origin allow-scripts allow-top-navigation allow-modals allow-popups-to-escape-sandbox"></iframe></div>
                        <div class="grecaptcha-error"></div>
                        <textarea id="g-recaptcha-response" name="g-recaptcha-response" class="g-recaptcha-response" style="width: 250px; height: 40px; border: 1px solid rgb(193, 193, 193); margin: 10px 25px; padding: 0px; resize: none; display: none;"></textarea>
                    </div>
                    <iframe __idm_frm__="557" style="display: none;"></iframe>
                </div>
            </label>
        </div>
    </div>
    <script src="/shared/misc/calendar.gen.js" type="text/javascript" language="javascript" charset="utf-8"></script>
    <div class="form-item form-item-submit">
        <button type="submit" class="shop2-btn">Оформить заказ</button>
    </div>
</form>