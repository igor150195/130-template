{include file="global:shop2.v2-login.tpl"}
<br>
<hr>
<br>
<div class="shop2-block login-form ">
    <div class="login-form__inner">
        <div class="login-form__header">
            Личный кабинет
        </div>
        <div class="login-form__body">
            <div class="user-block">
                <div class="user-block__info">
                    <div class="user-block__title">
                        Вы вошли как:
                    </div>
                    <div class="user-block__name">
                        Джекки Чан!
                    </div>
                </div>
                <div class="user-block__settings">
                    <a href="?mode=user" class="user-settings-btn user_settings_btn">
                    Настройки
                    </a>
                </div>
                <div class="user-block__btns">
                    <div class="user-block__orders">
                        <a href="orders" class="user-orders-btn user_orders_btn">
                        Мои заказы
                        </a>
                    </div>
                    <div class="user-block__logout">
                        <a href="logout" class="user-logout-btn user_logout_btn">
                        Выйти
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<br>
<hr>
<br>
{include file="global:shop2.v2-search-form.tpl"}
<br>
<hr>
<br>
<div class="filter-block">
    <div class="filter-block__inner">
        <form action="#" class="shop2-filter">
            <a id="shop2-filter"></a>
            <div class="shop2-filter__header">
                Фильтр
            </div>
            <div class="shop2-filter__items">
                <div class="shop2-filter__item gr-field-style">
                    <div class="shop2-filter__title active">
                        <span>
                            Цена<ins>:</ins> р.
                            <span class="shop2-filter__title-icon">
                                <svg class="gr-svg-icon gr_filter_plus">
                                    <use xlink:href="#icon_shop_filter_plus"></use>
                                </svg>
                                <svg class="gr-svg-icon gr_filter_minus">
                                    <use xlink:href="#icon_shop_filter_minus"></use>
                                </svg>
                            </span>
                        </span>
                    </div>
                    <div class="shop2-filter__body">
                        <label class="input-from">
                        <span class="input-from__title">от</span>
                        <input placeholder="от" class="shop2-input-float" type="text" value="" name="s[price][min]" Шаблон="" shop2.v2-facets-data.tpl="" не="" найден="" data-range_min="0">
                        </label>
                        <label class="input-to">
                        <span class="input-to__title">до</span>
                        <input placeholder="до" class="shop2-input-float" type="text" value="" name="s[price][max]" Шаблон="" shop2.v2-facets-data.tpl="" не="" найден="" data-range_max="200000">
                        </label>
                    </div>
                </div>
                <div class="shop2-filter__item gr-field-style">
                    <div class="shop2-filter__title">
                        <span>
                            Int<ins>:</ins> mm
                            <span class="shop2-filter__title-icon">
                                <svg class="gr-svg-icon gr_filter_plus">
                                    <use xlink:href="#icon_shop_filter_plus"></use>
                                </svg>
                                <svg class="gr-svg-icon gr_filter_minus">
                                    <use xlink:href="#icon_shop_filter_minus"></use>
                                </svg>
                            </span>
                        </span>
                    </div>
                    <div class="shop2-filter__body"><label class="input-from"><span class="input-from__title">от</span><input placeholder="от" class="shop2-input-int" type="text" value="" name="s[Int][min]" Шаблон="" shop2.v2-facets-data.tpl="" не="" найден=""></label><label class="input-to"><span class="input-to__title">до</span><input placeholder="до" class="shop2-input-int" type="text" value="" name="s[Int][max]" Шаблон="" shop2.v2-facets-data.tpl="" не="" найден=""></label></div>
                </div>
                <div class="shop2-filter__item gr-field-style">
                    <div class="shop2-filter__title">
                        <span>
                            Float<ins>:</ins> cm
                            <span class="shop2-filter__title-icon">
                                <svg class="gr-svg-icon gr_filter_plus">
                                    <use xlink:href="#icon_shop_filter_plus"></use>
                                </svg>
                                <svg class="gr-svg-icon gr_filter_minus">
                                    <use xlink:href="#icon_shop_filter_minus"></use>
                                </svg>
                            </span>
                        </span>
                    </div>
                    <div class="shop2-filter__body"><label class="input-from"><span class="input-from__title">от</span><input placeholder="от" class="shop2-input-float" type="text" value="" name="s[Float][min]" Шаблон="" shop2.v2-facets-data.tpl="" не="" найден=""></label><label class="input-to"><span class="input-to__title">до</span><input placeholder="до" class="shop2-input-float" type="text" value="" name="s[Float][max]" Шаблон="" shop2.v2-facets-data.tpl="" не="" найден=""></label></div>
                </div>
                <div class="shop2-filter__item gr-field-style">
                    <div class="shop2-filter__title">
                        <span>
                            Checkbox<ins>:</ins>
                            <span class="shop2-filter__title-icon">
                                <svg class="gr-svg-icon gr_filter_plus">
                                    <use xlink:href="#icon_shop_filter_plus"></use>
                                </svg>
                                <svg class="gr-svg-icon gr_filter_minus">
                                    <use xlink:href="#icon_shop_filter_minus"></use>
                                </svg>
                            </span>
                        </span>
                    </div>
                    <div class="shop2-filter__body">
                        <div class="shop2-filter__checkbox"><a href="#" data-name="s[Checkbox][1]" data-value="1" class="param-val Шаблон shop2.v2-facets-data.tpl не найден">да</a></div>
                    </div>
                </div>
                <div class="shop2-filter__item gr-field-style">
                    <div class="shop2-filter__title">
                        <span>
                            Select<ins>:</ins>
                            <span class="shop2-filter__title-icon">
                                <svg class="gr-svg-icon gr_filter_plus">
                                    <use xlink:href="#icon_shop_filter_plus"></use>
                                </svg>
                                <svg class="gr-svg-icon gr_filter_minus">
                                    <use xlink:href="#icon_shop_filter_minus"></use>
                                </svg>
                            </span>
                        </span>
                    </div>
                    <div class="shop2-filter__body">
                        <div class="shop2-filter__params">
                            <div class="shop2-filter__checkbox"><a href="#" data-name="s[Select][]" data-value="325855621" class="param-val Шаблон shop2.v2-facets-data.tpl не найден">вариант 1</a></div>
                            <div class="shop2-filter__checkbox"><a href="#" data-name="s[Select][]" data-value="325855821" class="param-val Шаблон shop2.v2-facets-data.tpl не найден">вариант 2</a></div>
                            <div class="shop2-filter__checkbox"><a href="#" data-name="s[Select][]" data-value="325856021" class="param-val Шаблон shop2.v2-facets-data.tpl не найден">вариант 3</a></div>
                        </div>
                    </div>
                </div>
                <div class="shop2-filter__item gr-field-style">
                    <div class="shop2-filter__title">
                        <span>
                            Multiselect<ins>:</ins>
                            <span class="shop2-filter__title-icon">
                                <svg class="gr-svg-icon gr_filter_plus">
                                    <use xlink:href="#icon_shop_filter_plus"></use>
                                </svg>
                                <svg class="gr-svg-icon gr_filter_minus">
                                    <use xlink:href="#icon_shop_filter_minus"></use>
                                </svg>
                            </span>
                        </span>
                    </div>
                    <div class="shop2-filter__body">
                        <div class="shop2-filter__params">
                            <div class="shop2-filter__checkbox"><a href="#" data-name="s[Multiselect][]" data-value="325856221" class="param-val Шаблон shop2.v2-facets-data.tpl не найден">вариант 1,1</a></div>
                            <div class="shop2-filter__checkbox"><a href="#" data-name="s[Multiselect][]" data-value="325856421" class="param-val Шаблон shop2.v2-facets-data.tpl не найден">вариант 1,2</a></div>
                            <div class="shop2-filter__checkbox"><a href="#" data-name="s[Multiselect][]" data-value="325856621" class="param-val Шаблон shop2.v2-facets-data.tpl не найден">вариант 1,3</a></div>
                        </div>
                    </div>
                </div>
                <div class="shop2-filter__item gr-field-style">
                    <div class="shop2-filter__title">
                        <span>
                            Справочник цветов <ins>:</ins>
                            <span class="shop2-filter__title-icon">
                                <svg class="gr-svg-icon gr_filter_plus">
                                    <use xlink:href="#icon_shop_filter_plus"></use>
                                </svg>
                                <svg class="gr-svg-icon gr_filter_minus">
                                    <use xlink:href="#icon_shop_filter_minus"></use>
                                </svg>
                            </span>
                        </span>
                    </div>
                    <div class="shop2-filter__body">
                        <div class="shop2-color-ext-popup">
                            <ul class="shop2-color-ext-list">
                                <li data-name="s[spravochnik_cvetov][0]" data-value="694909821" Шаблон="" shop2.v2-facets-data.tpl="" не="" найден="">
                                    <div class="filter-color-add">
                                        <ins class="filter-color-icon" style="background-image: url(http://dummyimage.com/90x90/ccc/fff&amp;text=90c90)"></ins>
                                        <ins class="filter-color-subtitle">Серый</ins>
                                    </div>
                                </li>
                                <li data-name="s[spravochnik_cvetov][1]" data-value="694910021" Шаблон="" shop2.v2-facets-data.tpl="" не="" найден="">
                                    <div class="filter-color-add">
                                        <ins class="filter-color-icon" style="background-image: url(http://dummyimage.com/90x90/ccc/fff&amp;text=90c90)"></ins>
                                        <ins class="filter-color-subtitle">Зеленый</ins>
                                    </div>
                                </li>
                                <li data-name="s[spravochnik_cvetov][2]" data-value="694910221" Шаблон="" shop2.v2-facets-data.tpl="" не="" найден="">
                                    <div class="filter-color-add">
                                        <ins class="filter-color-icon" style="background-image: url(http://dummyimage.com/90x90/ccc/fff&amp;text=90c90)"></ins>
                                        <ins class="filter-color-subtitle">Синий</ins>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="shop2-filter__item type-select gr-field-style">
                    <div class="shop2-filter__title">
                        <span>
                            Новинки<ins>:</ins>
                            <span class="shop2-filter__title-icon">
                                <svg class="gr-svg-icon gr_filter_plus">
                                    <use xlink:href="#icon_shop_filter_plus"></use>
                                </svg>
                                <svg class="gr-svg-icon gr_filter_minus">
                                    <use xlink:href="#icon_shop_filter_minus"></use>
                                </svg>
                            </span>
                        </span>
                    </div>
                    <div class="shop2-filter__body">
                        <select name="s[flags][]">
                            <option value="" selected="selected">Все</option>
                            <option value="1">да</option>
                            <option value="0">нет</option>
                        </select>
                    </div>
                </div>
                <div class="shop2-filter__item type-select gr-field-style">
                    <div class="shop2-filter__title">
                        <span>
                            Спецпредложения<ins>:</ins>
                            <span class="shop2-filter__title-icon">
                                <svg class="gr-svg-icon gr_filter_plus">
                                    <use xlink:href="#icon_shop_filter_plus"></use>
                                </svg>
                                <svg class="gr-svg-icon gr_filter_minus">
                                    <use xlink:href="#icon_shop_filter_minus"></use>
                                </svg>
                            </span>
                        </span>
                    </div>
                    <div class="shop2-filter__body">
                        <select name="s[flags][]">
                            <option value="" selected="selected">Все</option>
                            <option value="1">да</option>
                            <option value="0">нет</option>
                        </select>
                    </div>
                </div>
                <div class="shop2-filter__item type-select gr-field-style">
                    <div class="shop2-filter__title">
                        <span>
                            Тестовый флаг<ins>:</ins>
                            <span class="shop2-filter__title-icon">
                                <svg class="gr-svg-icon gr_filter_plus">
                                    <use xlink:href="#icon_shop_filter_plus"></use>
                                </svg>
                                <svg class="gr-svg-icon gr_filter_minus">
                                    <use xlink:href="#icon_shop_filter_minus"></use>
                                </svg>
                            </span>
                        </span>
                    </div>
                    <div class="shop2-filter__body">
                        <select name="s[flags][]">
                            <option value="" selected="selected">Все</option>
                            <option value="1">да</option>
                            <option value="0">нет</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="shop2-filter__add">
                <div class="shop2-filter-btns">
                    <a href="#" class="shop2-filter-go gr_filter_go">
                    <span>Показать</span>
                    <span id="filter-result" class="result">
                    0                                        </span>
                    </a>
                    <a href="/" class="shop2-filter-reset gr_filter_reset">
                        <span>
                            Сбросить фильтр
                            <svg class="gr-svg-icon">
                                <use xlink:href="#icon_shop_refresh"></use>
                            </svg>
                            <svg class="gr-svg-icon gr_small_icon">
                                <use xlink:href="#icon_shop_refresh"></use>
                            </svg>
                        </span>
                    </a>
                </div>
            </div>
        </form>
    </div>
</div>
<br>
<hr>
<br>
	<div class="tpl-stars">
		<div class="tpl-rating tpl-active" style="width: 90%;"></div>
	</div>
<br>
<hr>
<br>
<div class="comments-block">
	<div class="comments-form">
		<form method="post" class="tpl-form">
			<input type="hidden" name="comment_id" value="">

			<div class="tpl-field">
				<div class="tpl-value">
					<input placeholder="Имя:*" type="text" size="40" name="author_name">
				</div>

			</div>

			<div class="tpl-field">
				<label class="field-title">E-mail:</label>

				<div class="tpl-value">
					<input type="text" size="40" name="author">
				</div>

			</div>

			<div class="tpl-field">
				<label class="field-title">
					Комментарий:
					<span class="tpl-required">*</span>
				</label>

				<div class="tpl-value">
					<textarea cols="55" rows="3" name="text"></textarea>
				</div>

			</div>

			<div class="tpl-field">
				<label class="field-title">
					Оценка:
					<span class="tpl-required">*</span>
				</label>

				<div class="tpl-value">

					<div class="tpl-stars">
						<span class=""></span>
						<span class=""></span>
						<span class=""></span>
						<span class=""></span>
						<span class=""></span>
						<input name="rating" type="hidden" value="0">
					</div>

				</div>

			</div>
			<div class="tpl-field tpl-field-reg">
				<div class="comments-chekbox">
					<label class="mg-styler-label--checkbox">
						<input type="checkbox" class="auth_reg" name="personal_data" value="1"></label>
					<a href="http://lighting-shop.oml.ru/users/agreement" target="_blank">Подробнее</a>
				</div>
			</div>

			<div class="tpl-field-button">
				<button type="submit" class="gr-btn-1">Отправить</button>
			</div>

		</form>
	</div>
</div>
<br>
<hr>
<br>
<div class="card-page">
    <div class="shop-product-tags">
        <div class="shop-product-tags__title"><span>теги:</span></div>
        <div class="shop-product-tags__items">
            <a href="/" class="shop-product-tags__item">
                <span>
                    Тег номер 1
                    <svg class="gr-svg-icon">
                        <use xlink:href="#icon_shop_tag_arr"></use>
                    </svg>
                    <svg class="gr-svg-icon gr_small_icon">
                        <use xlink:href="#icon_shop_tag_arr_small"></use>
                    </svg>
                </span>
            </a>
            <a href="/" class="shop-product-tags__item">
                <span>
                    Тег номер 2
                    <svg class="gr-svg-icon">
                        <use xlink:href="#icon_shop_tag_arr"></use>
                    </svg>
                    <svg class="gr-svg-icon gr_small_icon">
                        <use xlink:href="#icon_shop_tag_arr_small"></use>
                    </svg>
                </span>
            </a>
            <a href="/" class="shop-product-tags__item">
                <span>
                    Тег номер 3
                    <svg class="gr-svg-icon">
                        <use xlink:href="#icon_shop_tag_arr"></use>
                    </svg>
                    <svg class="gr-svg-icon gr_small_icon">
                        <use xlink:href="#icon_shop_tag_arr_small"></use>
                    </svg>
                </span>
            </a>
            <a href="/" class="shop-product-tags__item">
                <span>
                    Тег номер 4
                    <svg class="gr-svg-icon">
                        <use xlink:href="#icon_shop_tag_arr"></use>
                    </svg>
                    <svg class="gr-svg-icon gr_small_icon">
                        <use xlink:href="#icon_shop_tag_arr_small"></use>
                    </svg>
                </span>
            </a>
            <a href="/" class="shop-product-tags__item">
                <span>
                    Тег номер 5
                    <svg class="gr-svg-icon">
                        <use xlink:href="#icon_shop_tag_arr"></use>
                    </svg>
                    <svg class="gr-svg-icon gr_small_icon">
                        <use xlink:href="#icon_shop_tag_arr_small"></use>
                    </svg>
                </span>
            </a>
        </div>
    </div>
</div>
<br>
<hr>
<br>
    <div class="card-page">
    	<div class="shop-product-folders">
            <div class="shop-product-folders__title"><span>Находится в разделах</span></div>
            <div class="shop-product-folders__items">
                <a href="/shopfoldershop/folder/kategoriya-tovarov-1" class="shop-product-folders__item gr-btn-2">
                    <span>
                        Категория товаров 1
                        <svg class="gr-svg-icon">
                            <use xlink:href="#icon_shop_tag_arr"></use>
                        </svg>
                        <svg class="gr-svg-icon gr_small_icon">
                            <use xlink:href="#icon_shop_tag_arr_small"></use>
                        </svg>
                    </span>
                </a>
                <a href="/shopfoldershop/folder/kategoriya-tovarov-3" class="shop-product-folders__item gr-btn-2">
                    <span>
                        Категория товаров 3
                        <svg class="gr-svg-icon">
                            <use xlink:href="#icon_shop_tag_arr"></use>
                        </svg>
                        <svg class="gr-svg-icon gr_small_icon">
                            <use xlink:href="#icon_shop_tag_arr_small"></use>
                        </svg>
                    </span>
                </a>
                <a href="/shopfoldershop/folder/gruppa-tovarov-b" class="shop-product-folders__item gr-btn-2">
                    <span>
                        Группа товаров Б
                        <svg class="gr-svg-icon">
                            <use xlink:href="#icon_shop_tag_arr"></use>
                        </svg>
                        <svg class="gr-svg-icon gr_small_icon">
                            <use xlink:href="#icon_shop_tag_arr_small"></use>
                        </svg>
                    </span>
                </a>
                <a href="/shopfoldershop/folder/gruppa-tovarov-v" class="shop-product-folders__item gr-btn-2">
                    <span>
                        Группа товаров В
                        <svg class="gr-svg-icon">
                            <use xlink:href="#icon_shop_tag_arr"></use>
                        </svg>
                        <svg class="gr-svg-icon gr_small_icon">
                            <use xlink:href="#icon_shop_tag_arr_small"></use>
                        </svg>
                    </span>
                </a>
            </div>
        </div>
    </div>
<br>
<hr>
<br>
    <div class="shop2-product-actions">
        <dl>
            <dt class="gift-action">
                <span class="icon-action">
                    <svg class="gr-svg-icon">
                        <use xlink:href="#icon_shop_gift"></use>
                    </svg>
                    <svg class="gr-svg-icon gr_small_icon">
                        <use xlink:href="#icon_shop_gift_small"></use>
                    </svg>
                </span>
                <span class="name-action">Подарок</span>
            </dt>
            <dd>
                <div class="name-action">Подарок</div>
                <div class="desc-action">
                    <p>Описание подарок</p>
                </div>
                <div class="close-desc-action">
                    <svg class="gr-svg-icon gr_big_icon">
                        <use xlink:href="#icon_shop_close"></use>
                    </svg>
                    <svg class="gr-svg-icon">
                        <use xlink:href="#icon_shop_close_small"></use>
                    </svg>
                    <svg class="gr-svg-icon gr_small_icon">
                        <use xlink:href="#icon_shop_close_mini"></use>
                    </svg>
                </div>
            </dd>
            <dt>
                <span class="icon-action">
                    <svg class="gr-svg-icon">
                        <use xlink:href="#icon_shop_sale"></use>
                    </svg>
                    <svg class="gr-svg-icon gr_small_icon">
                        <use xlink:href="#icon_shop_sale_small"></use>
                    </svg>
                </span>
                <span class="name-action">Подарок</span>
            </dt>
            <dd>
                <div class="name-action">Акция</div>
                <div class="desc-action">
                    <p>Описание подарок</p>
                </div>
                <div class="close-desc-action">
                    <svg class="gr-svg-icon gr_big_icon">
                        <use xlink:href="#icon_shop_close"></use>
                    </svg>
                    <svg class="gr-svg-icon">
                        <use xlink:href="#icon_shop_close_small"></use>
                    </svg>
                    <svg class="gr-svg-icon gr_small_icon">
                        <use xlink:href="#icon_shop_close_mini"></use>
                    </svg>
                </div>
            </dd>
        </dl>
    </div>
<br>
<hr>
<br>
	<div class="product-flags">
		<div class="product-flags__left">
			<div class="product-flags__item new_item">
				<span>New</span>
			</div>
			<div class="product-flags__item spec_item">
				<span>Sale</span>
			</div>
		</div>
		<div class="product-flags__right">
			<div class="product-flags__item custom_item">
				<span style="background: #008efc;">Кастомный</span>
			</div>
		</div>
	</div>
<br>
<hr>
<br>
	<div class="shop2-warning">
		<h2>.shop2-warning</h2>
	</div>
	<div class="shop2-info">
		<h2>.shop2-info</h2>
	</div>
<br>
<hr>
<br>
	<h2>.tpl-info</h2>
	<div class="tpl-info">
		Заполните обязательные поля <span class="tpl-required">*</span>.
	</div>
<br>
<hr>
<br>
	<h2>Параметры .shop2-product-options</h2>
	<div class="gr-product-options">
        <div class="gr-options-container" style="display: block;">
            <div class="shop2-product-options">
                <div class="option-item odd" data-option-type="text">
                    <div class="option-item__inner">
                        <div class="option-title">Text</div>
                        <div class="option-body">текст 1,1 шт</div>
                    </div>
                </div>
                <div class="option-item even" data-option-type="int">
                    <div class="option-item__inner">
                        <div class="option-title">Int</div>
                        <div class="option-body">1 mm</div>
                    </div>
                </div>
                <div class="option-item odd" data-option-type="float">
                    <div class="option-item__inner">
                        <div class="option-title">Float</div>
                        <div class="option-body">1.5 cm</div>
                    </div>
                </div>
                <div class="option-item even" data-option-type="checkbox">
                    <div class="option-item__inner">
                        <div class="option-title">Checkbox</div>
                        <div class="option-body">да</div>
                    </div>
                </div>
                <div class="option-item gr_color_option odd gr_type_color" data-option-type="color">
                    <div class="option-item__inner">
                        <div class="option-title">Color</div>
                        <div class="option-body">
                            <ul class="shop2-color-pick">
                                <li data-kinds="405841621" data-name="Color" data-value="#ccff00" class="active-color shop2-cf"><span style="background-color: #ccff00;">&nbsp;</span></li>
                                <li data-kinds="405907821" data-name="Color" data-value="#009900" class=" shop2-cf"><span style="background-color: #009900;">&nbsp;</span></li>
                                <li data-kinds="405912421" data-name="Color" data-value="#03f" class=" shop2-cf"><span style="background-color: #03f;">&nbsp;</span></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="option-item even" data-option-type="textarea">
                    <div class="option-item__inner">
                        <div class="option-title">Textarea</div>
                        <div class="option-body">текст 1,2</div>
                    </div>
                </div>
                <div class="option-item odd gr_type_select" data-option-type="select">
                    <div class="option-item__inner">
                        <div class="option-title">Select</div>
                        <div class="option-body gr-field-style">
                            <select name="cf_Select" class="shop2-cf small-field">
                                <option value="325855621" data-name="Select" data-value="325855621" data-kinds="405841621" selected="selected">вариант 1</option>
                                <option value="325855821" data-name="Select" data-value="325855821" data-kinds="405907821">вариант 2</option>
                                <option value="325856021" data-name="Select" data-value="325856021" data-kinds="405912421">вариант 3</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="option-item even" data-option-type="multiselect">
                    <div class="option-item__inner">
                        <div class="option-title">Multiselect</div>
                        <div class="option-body">вариант 1,1, вариант 1,3</div>
                    </div>
                </div>
                <div class="option-item gr_color_option odd gr_type_texture" data-option-type="image2">
                    <div class="option-item__inner">
                        <div class="option-title">Image</div>
                        <div class="option-body">
                            <ul class="shop2-texture-pick">
                                <li data-kinds="405841621" data-name="Image" data-value="1600854621" class="active-texture shop2-cf"><img src="http://dummyimage.com/225x225/ccc/fff&amp;text=225c225" alt="Image"></li>
                                <li data-kinds="405907821" data-name="Image" data-value="1600855221" class=" shop2-cf"><img src="http://dummyimage.com/225x225/ccc/fff&amp;text=225c225" alt="Image"></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="option-item even" data-option-type="file2">
                    <div class="option-item__inner">
                        <div class="option-title">File</div>
                        <div class="option-body">
                            <a href="/d/442666/d/document_1.docx" class="file">
                                <span>
                                    Скачать
                                    <svg class="gr-svg-icon">
                                        <use xlink:href="#icon_shop_file"></use>
                                    </svg>
                                    <svg class="gr-svg-icon gr_small_icon">
                                        <use xlink:href="#icon_shop_file_small"></use>
                                    </svg>
                                </span>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="option-item gr_color_option odd" data-option-type="color2">
                    <div class="option-item__inner">
                        <div class="option-title">Выбор цвета</div>
                        <div class="option-body">
                            <ul class="shop2-color-ext-list">
                                <li data-kinds="405841621" data-name="vybor_cveta" data-value="697c1c6d8fcf5d065fa153f43504f500" style="background-image: url(http://dummyimage.com/36x36/ccc/fff&amp;text=36c36)" class="shop2-color-ext-selected">
                                    <span></span>
                                    <div>
                                        <img src="http://dummyimage.com/96x96/ccc/fff&amp;text=96r96" alt="">
                                        Красный
                                    </div>
                                </li>
                                <li data-kinds="405907821" data-name="vybor_cveta" data-value="2ea42ca977968a6620ea9887b135a74e" style="background-color:#009933">
                                    <span></span>
                                    <div>
                                        <img src="/g/spacer.gif" style="background: #009933;" width="96" height="96" alt="">
                                        Зеленый
                                    </div>
                                </li>
                                <li data-kinds="405912421" data-name="vybor_cveta" data-value="10a7cfcf915c4c9a839ab0834db8aed2" style="background-color:#0099ff">
                                    <span></span>
                                    <div>
                                        <img src="/g/spacer.gif" style="background: #0099ff;" width="96" height="96" alt="">
                                        Синий
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="option-item gr_color_option even" data-option-type="color_ref">
                    <div class="option-item__inner">
                        <div class="option-title">Справочник цветов </div>
                        <div class="option-body">
                            <ul class="shop2-color-ext-multi">
                                <li style="background-image:url(http://dummyimage.com/96x96/ccc/fff&amp;text=96c96)">
                                    <ul>
                                        <li>
                                            <span style="background-image:url(http://dummyimage.com/96x96/ccc/fff&amp;text=96c96)"></span>
                                            <div>Серый</div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="option-item gr_color_option odd" data-option-type="color2">
                    <div class="option-item__inner">
                        <div class="option-title">Рас выбор цвета ВЫПАДАЮЩИЙ</div>
                        <div class="option-body">
                            <div class="shop2-color-ext-select">
                                <i></i>
                                <ul class="shop2-color-ext-options">
                                    <li data-kinds="35949851" data-name="ras_vybor_cveta_vypadausij" data-value="61c778c6948d7c42b57acba78dd484da" class="shop2-color-ext-selected">
                                        <span style="background-color:#9933ff"><em></em></span>
                                        <div>Розовый</div>
                                        <ins></ins>
                                    </li>
                                    <li data-kinds="35950051" data-name="ras_vybor_cveta_vypadausij" data-value="6b5fc12d7910a5ed99b42b500e7eff2c">
                                        <span style="background-color:#66ffff"><em></em></span>
                                        <div>Зеленый</div>
                                        <ins></ins>
                                    </li>
                                    <li data-kinds="35950251" data-name="ras_vybor_cveta_vypadausij" data-value="bd572bfffada5d42af95af2da3156ac8">
                                        <span style="background-color:#3333cc"><em></em></span>
                                        <div>Синий</div>
                                        <ins></ins>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<br>
<hr>
<br>
	<h2>Параметры .shop2-product-params</h2>
	<div class="shop2-product-params">
        <div class="param-item odd" data-option-type="text">
            <div class="param-item__inner">
                <div class="param-title">Text</div>
                <div class="param-body">текст 1,1 шт</div>
            </div>
        </div>
        <div class="param-item even" data-option-type="int">
            <div class="param-item__inner">
                <div class="param-title">Int</div>
                <div class="param-body">1 mm</div>
            </div>
        </div>
        <div class="param-item odd" data-option-type="float">
            <div class="param-item__inner">
                <div class="param-title">Float</div>
                <div class="param-body">1.5 cm</div>
            </div>
        </div>
        <div class="param-item even" data-option-type="checkbox">
            <div class="param-item__inner">
                <div class="param-title">Checkbox</div>
                <div class="param-body">да</div>
            </div>
        </div>
        <div class="param-item gr_color_option odd gr_type_color" data-option-type="color">
            <div class="param-item__inner">
                <div class="param-title">Color</div>
                <div class="param-body">
                    <ul class="shop2-color-pick">
                        <li class="active-color"><span style="background-color: #ccff00;">&nbsp;</span></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="param-item even" data-option-type="textarea">
            <div class="param-item__inner">
                <div class="param-title">Textarea</div>
                <div class="param-body">текст 1,2</div>
            </div>
        </div>
        <div class="param-item odd" data-option-type="select">
            <div class="param-item__inner">
                <div class="param-title">Select</div>
                <div class="param-body">вариант 1</div>
            </div>
        </div>
        <div class="param-item even" data-option-type="multiselect">
            <div class="param-item__inner">
                <div class="param-title">Multiselect</div>
                <div class="param-body">вариант 1,1, вариант 1,3</div>
            </div>
        </div>
        <div class="param-item gr_color_option odd gr_type_texture" data-option-type="image2">
            <div class="param-item__inner">
                <div class="param-title">Image</div>
                <div class="param-body">
                    <ul class="shop2-texture-pick">
                        <li class="active-texture"><img src="http://dummyimage.com/225x225/ccc/fff&amp;text=225c225" alt="Image"></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="param-item even" data-option-type="file2">
            <div class="param-item__inner">
                <div class="param-title">File</div>
                <div class="param-body">
                    <a href="/d/442666/d/document_1.docx" class="file">
                        <span>
                            Скачать
                            <svg class="gr-svg-icon">
                                <use xlink:href="#icon_shop_file"></use>
                            </svg>
                            <svg class="gr-svg-icon gr_small_icon">
                                <use xlink:href="#icon_shop_file_small"></use>
                            </svg>
                        </span>
                    </a>
                </div>
            </div>
        </div>
        <div class="param-item gr_color_option odd" data-option-type="color2">
            <div class="param-item__inner">
                <div class="param-title">Выбор цвета</div>
                <div class="param-body">
                    <ul class="shop2-color-ext-list">
                        <li style="background-image: url(http://dummyimage.com/32x32/ccc/fff&amp;text=32c32)" class="shop2-color-ext-selected">
                            <div>
                                <img src="http://dummyimage.com/96x96/ccc/fff&amp;text=96r96" alt="">
                                Красный
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="param-item gr_color_option even" data-option-type="color_ref">
            <div class="param-item__inner">
                <div class="param-title">Справочник цветов </div>
                <div class="param-body">
                    <ul class="shop2-color-ext-list">
                        <li style="background-image: url(http://dummyimage.com/32x32/ccc/fff&amp;text=32c32)" class="shop2-color-ext-selected">
                            <div>
                                <img src="http://dummyimage.com/96x96/ccc/fff&amp;text=96r96" alt="">
                                Серый
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
<br>
<hr>
<br>
    <h2>Параметры .cart-params</h2>
    <div class="cart-params">
        <div class="cart-params__body" style="display: block;">
            <ul class="cart-params__list">
                <li class="gr_vendor_name">
                    <div class="cart-params__item">
                        <div class="cart-params__title">Производитель</div>
                        <div class="cart-params__value">
                            <a href="/shopvendorshop/vendor/proizvoditel-2">Производитель №2</a>
                        </div>
                    </div>
                </li>
                <li class="gr_type_text">
                    <div class="cart-params__item">
                        <div class="cart-params__title">Text:</div>
                        <div class="cart-params__value">текст 1,1 шт</div>
                    </div>
                </li>
                <li class="gr_type_text">
                    <div class="cart-params__item">
                        <div class="cart-params__title">Int:</div>
                        <div class="cart-params__value">1 mm</div>
                    </div>
                </li>
                <li class="gr_type_text">
                    <div class="cart-params__item">
                        <div class="cart-params__title">Float:</div>
                        <div class="cart-params__value">1.5 cm</div>
                    </div>
                </li>
                <li class="gr_type_checkbox">
                    <div class="cart-params__item">
                        <div class="cart-params__title">Checkbox:</div>
                        <div class="cart-params__value">да</div>
                    </div>
                </li>
                <li class="gr_type_color">
                    <div class="cart-params__item">
                        <div class="cart-params__title">Color:</div>
                        <div class="cart-params__value">
                            <ul class="shop2-color-pick">
                                <li class="active-color"><span style="background-color: #ccff00;">&nbsp;</span></li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li class="gr_type_text">
                    <div class="cart-params__item">
                        <div class="cart-params__title">Textarea:</div>
                        <div class="cart-params__value">текст 1,2 </div>
                    </div>
                </li>
                <li class="gr_type_select">
                    <div class="cart-params__item">
                        <div class="cart-params__title">Select:</div>
                        <div class="cart-params__value">вариант 1</div>
                    </div>
                </li>
                <li class="gr_type_multiselect">
                    <div class="cart-params__item">
                        <div class="cart-params__title">Multiselect:</div>
                        <div class="cart-params__value">
                            вариант 1,1,                                                                                                                    вариант 1,3                                                                                                         
                        </div>
                    </div>
                </li>
                <li class="gr_type_image2">
                    <div class="cart-params__item">
                        <div class="cart-params__title">Image:</div>
                        <div class="cart-params__value gr_cart_param_img">
                            <a href="/d/442666/d/1_1_0.jpg">
                            <img src="http://dummyimage.com/225x225/ccc/fff&amp;text=225c225">
                            </a>
                        </div>
                    </div>
                </li>
                <li class="gr_type_file2">
                    <div class="cart-params__item">
                        <div class="cart-params__title">File:</div>
                        <div class="cart-params__value">
                            <a href="/d/442666/d/document_1.docx" class="file">
                                <span>
                                    Скачать
                                    <svg class="gr-svg-icon">
                                        <use xlink:href="#icon_shop_file"></use>
                                    </svg>
                                    <svg class="gr-svg-icon gr_small_icon">
                                        <use xlink:href="#icon_shop_file_small"></use>
                                    </svg>
                                </span>
                            </a>
                        </div>
                    </div>
                </li>
                <li class="gr_type_color_ref">
                    <div class="cart-params__item">
                        <div class="cart-params__title">Выбор цвета:</div>
                        <div class="cart-params__value">
                            <ul class="shop2-color-ext-list">
                                <li style="background-image: url(http://dummyimage.com/32x32/ccc/fff&amp;text=32c32)" class="shop2-color-ext-selected">
                                    <div>
                                        <img src="http://dummyimage.com/96x96/ccc/fff&amp;text=96r96" alt="">
                                        Красный
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li class="gr_type_color_ref">
                    <div class="cart-params__item">
                        <div class="cart-params__title">Справочник цветов :</div>
                        <div class="cart-params__value">
                            <ul class="shop2-color-ext-list">
                                <li style="background-image: url(http://dummyimage.com/32x32/ccc/fff&amp;text=32c32)" class="shop2-color-ext-selected">
                                    <div>
                                        <img src="http://dummyimage.com/96x96/ccc/fff&amp;text=96r96" alt="">
                                        Серый
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li class="gr-field-style">
                    <div class="cart-params__title">Выпад список множ СПИСОК</div>
                    <div class="cart-params__value">
                        <select name="amounts[35948251][0][vypad_spisok_mnoz_spisok]" class="param-value additional-cart-params">
                            <option value="Выпад список множ СПИСОК: JJJJJ" selected="">
                                JJJJJ
                            </option>
                            <option value="Выпад список множ СПИСОК: IIIIII">
                                IIIIII
                            </option>
                            <option value="Выпад список множ СПИСОК: OOOOO">
                                OOOOO
                            </option>
                        </select>
                    </div>
                </li>
                <li class="gr-field-style">
                    <div class="cart-params__title">Справочник цветов ВЫПаДАЮЩИЙ</div>
                    <div class="cart-params__value">
                        <div class="shop2-color-ext-select">
                            <i></i>
                            <ul class="shop2-color-ext-options">
                                <li data-value="Справочник цветов ВЫПаДАЮЩИЙ: 5588851" class="param-value shop2-color-ext-selected">
                                    <span style="background-color: #bc1339"><em></em></span>
                                    <div>Синий</div>
                                    <ins></ins>
                                </li>
                                <li data-value="Справочник цветов ВЫПаДАЮЩИЙ: 5589051" class="param-value">
                                    <span style="background-color: #b3bc20"><em></em></span>
                                    <div>Зеленый</div>
                                    <ins></ins>
                                </li>
                                <li data-value="Справочник цветов ВЫПаДАЮЩИЙ: 5589251" class="param-value">
                                    <span style="background-color: #a369af"><em></em></span>
                                    <div>Красный</div>
                                    <ins></ins>
                                </li>
                            </ul>
                            <input type="hidden" class="additional-cart-params" value="Справочник цветов ВЫПаДАЮЩИЙ: 5588851" name="amounts[35948251][0][spravocnik_cvetov_vypodausij]">
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
<br>
<hr>
<br>
	{* Балванка *}

	<link rel="stylesheet" href="/g/basestyle/1.0.0/user/user.blue.css">
	<h2>.shop2-cart-auth</h2>

    {include file="db:test-cart-delivery.tpl"}

	<h2>.shop2-order-options</h2>
	<form method="post" action="#" class="shop2-order-options shop2-payment-options">
		<div class="options-list">
			<div class="option-type">
				<label class="option-label">
					<input name="payment_id" value="-18" checked="checked" type="radio">
					<span class="label-name">PSTest</span>
					<span class="label-icons">
						<img src="/g/s3/s3_shop2/payments/medium/ic_master_card.png" alt="">
						<img src="/g/s3/s3_shop2/payments/medium/ic_euro_net.png" alt="">
						<img src="/g/s3/s3_shop2/payments/medium/ic_megafon.png" alt="">
						<img src="/g/s3/s3_shop2/payments/medium/ic_beeline.png" alt=""></span>
				</label>
			</div>
			<div class="option-type active-type">
				<label class="option-label">
					<input name="payment_id" value="-54" type="radio">
					<span class="label-name">asdasdas</span>
					<span class="label-icons">
						<span class="payment_methods-column">
							<label data-count="2">
								<input type="radio" name="-54[method_id]" value="1" checked="checked">
								<img src="/g/s3/s3_shop2/payments/medium/ic_visa.png" alt="">(Наценка 1.01%)</label>
							<label data-count="2">
								<input type="radio" name="-54[method_id]" value="2">
								<img src="/g/s3/s3_shop2/payments/medium/ic_master_card.png" alt="">(Наценка 1.01%)</label>
						</span>
						<span class="payment_methods-column">
							<label data-count="2">
								<input type="radio" name="-54[method_id]" value="6">
								<img src="/g/s3/s3_shop2/payments/medium/ic_euro_net.png" alt="">(Наценка 1.01%)</label>
						</span>
					</span>
				</label>
			</div>
		</div>

		<input type="hidden" name="step" value="payments">
		<input type="hidden" name="mode" value="order">
		<input type="hidden" name="action" value="save">
		<input type="hidden" name="amount" value="">
		<input type="hidden" name="shop_id" value="">

		<div class="text-center">
			<button class="shop2-btn" type="submit">Продолжить</button>
		</div>
	</form>

{* Балванка *}
<br>
<hr>
<br>