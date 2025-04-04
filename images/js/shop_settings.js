shop2.options.msgTime = 2000;

shop2.queue.kindAvailable = function () {
    var sentAjax_preorder = function (data, callback) {
        $.ajax({
            url: '/-/x-api/v1/public/?method=shop2/addKindEmailNotification',
            method: 'post',
            xhrFields: {
                withCredentials: true
            },
            data: data,
            success: function (result) {
                callback(result);
            }
        });
    };

    var object_preorder = {};
    $(document).on('click', '.preorder-btn-js', function (e) {
        e.preventDefault();
        object_preorder.data = {};

        object_preorder.jQbtn = $(this);
        object_preorder.data.kind_id = object_preorder.jQbtn.data('product-kind_id');
        object_preorder.data.email = object_preorder.jQbtn.data('user-email') || 0;

        if (object_preorder.data.email) {
            var temp_email = `
            <div class="preorder-field preorder-email tpl-field type-email field-required">
                <span class="preorder-email_text">
                    ${shop2.my.preorder_email_text || 'Данный email указан при регистрации.'}
                </span>
                <div class="preorder-email-input">
                    <div class="preorder-field-title field-title">E-mail: <span class="field-required-mark">*</span></div>
                    <div class="preorder-field-value">
                        <input type="text" name="email" required value="${object_preorder.data.email}">
                    </div>
                </div>
            </div>
            `;

        } else {
            var temp_email = `
            <div class="preorder-field preorder-email tpl-field type-email field-required">
                <div class="preorder-email-input">
                    <div class="preorder-field-title field-title">E-mail: <span class="field-required-mark">*</span></div>
                    <div class="preorder-field-value">
                        <input type="text" name="email" required value="">
                    </div>
                </div>
            </div>
            `;
        }

        let temp_html = `
                    <div class="preorder-form-wrap preorder-block">
                        <form class="preorder_body" action="/-/x-api/v1/public/?method=shop2/addKindEmailNotification" method="get">
                            <div class="preorder-title tpl-anketa__title">
                                ${shop2.my.preorder_form_title || 'Узнать о поступлении'}
                            </div>
                            <div class="preorder_text preorder-field type-html tpl-field type-html">
                                ${shop2.my.preorder_form_text || 'Оставьте почту и мы напишем вам, когда товар появится в наличии.'}
                            </div>
                            ${temp_email}
                            <input type="hidden" name="kind_id" value="${object_preorder.data.kind_id}">
                            
                            <div class="preorder-field tpl-field tpl-field-button">
                                <button type="submit" class="tpl-form-button">${shop2.my.preorder_form_submitt || 'Отправить'}</button>
                            </div>
                            
                        </form>
                        <div class="block-recaptcha"></div>
                    </div>
                        `;

        let this_remodal = $('.remodal[data-remodal-id="buy-one-click"]');

        this_remodal.find('.preorder-form-wrap').add(this_remodal.find('.tpl-anketa')).remove();

        this_remodal.append(temp_html);

        this_remodal.remodal().open();

        this_remodal.on('closed.preorder', function (e) {

            this_remodal.find('.preorder-form-wrap').remove();
            this_remodal.off('closed.preorder');
        });
    });

    $(document).on('submit', '.block-recaptcha form', function (e) {
        e.preventDefault();

        var serializeArray = $(this).serializeArray();

        for (let i = 0; i < serializeArray.length; i++) {
            if (serializeArray[i]['name'] == '_sitekey') { object_preorder.data['_sitekey'] = serializeArray[i]['value']; }
            if (serializeArray[i]['name'] == 'g-recaptcha-response') { object_preorder.data['g-recaptcha-response'] = serializeArray[i]['value']; }
        };

        sentAjax_preorder(object_preorder.data, (data) => {

            object_preorder.jQbtn.addClass('disabled').get(0).setAttribute('disabled', 'disabled');

            $('.preorder-form-wrap').html(`
				<div class="preorder_success tpl-anketa__right tpl-anketa__posted">
					<div class="tpl-anketa-success-note">${shop2.my.preorder_form_success || 'Спасибо!'}</div>
				</div>
            `);

            if (object_preorder.jQbtn.closest('form').length) {
                let $favorite_btn = object_preorder.jQbtn.closest('form').find('.gr-favorite-btn');

                if ($favorite_btn.length && !$favorite_btn.is(":hidden")) {
                    $favorite_btn.trigger('click');
                };
            };
        });

    });

    shop2.on('afterFavoriteAddItem', function () {
        if ($('.preorder-form-wrap').length) {
            $('#shop2-msg').hide();
        };
    });

    $(document).on('submit', '.preorder_body', function (e) {
        e.preventDefault();
        var $form = $(this);

        object_preorder.data.email = this.email.value;
        const _regexEmeil = /^[\w-\.]+@[\w-]+\.[a-z]{2,4}$/i;

        let valid = _regexEmeil.test(object_preorder.data.email);

        if (valid) {
            $.get('/-/x-api/v1/public/?method=shop2/addKindEmailNotification', function (data) {
                console.log(object_preorder);

                const _regexBody = new RegExp(/<body[^>]*>(.*?)<\/body>/ig);

                let body = data.result.html.match(_regexBody);

                $form.parent('.preorder-block').find('.block-recaptcha').html(body);
            });
        } else {

            if (!$form.find('.preorder-email').hasClass('field-error'))
                $form
                    .find('.preorder-email')
                    .addClass('field-error')
                    .find('.preorder-email-input .preorder-field-value')
                    .before(`<div class="error-message">Неверный формат адреса электронной почты</div>`);
        }

    });
};

(function () {
    if (!!document.querySelector('#product-tabs')) {
        let gr_active_tab = localStorage.getItem('gr_tab_href');

        if (gr_active_tab != null && $(gr_active_tab).length) {
            let desktopFirst = document.querySelectorAll('.shop-product-data__nav li')[0];
            let mobileFirst = document.querySelectorAll('.r-tabs-accordion-title')[0];
            let firstTab = document.querySelectorAll('.shop-product-data__desc .desc-area')[0];

            if (!!desktopFirst && !!mobileFirst) {
                desktopFirst.classList.remove('r-tabs-state-active');
                mobileFirst.classList.remove('r-tabs-state-active');
            };
            if (!!firstTab) {
                firstTab.style.display = 'none';
            };

            document.querySelectorAll(gr_active_tab)[0].style.display = 'block';

            let gr_active_tabs = document.querySelectorAll('[href="' + gr_active_tab + '"]');
            for (i = 0; i < gr_active_tabs.length; i++) {
                gr_active_tabs[i].parentNode.classList.add('r-tabs-state-active');
            };
        };
    };
})();

/*shop2.search.getParams = function (folder_id, func) {
    var gr_filter_max_count = shop2.my.gr_filter_max_count;
    var url;

    shop2.trigger("beforeGetFolderCustomFields");
    
    if (folder_id > 0) {
        url =
            "/-/shop2-api/?cmd=getFolderCustomFields" +
            "&hash=" +
            shop2.apiHash.getFolderCustomFields +
            "&ver_id=" +
            shop2.verId +
            "&folder_id=" +
            folder_id +
            "&" +
            decodeURIComponent(document.location.search).replace(/[^&]*=(&|$)/g,"");
   
        if (gr_filter_max_count) {
            url = url + `gr_filter_max_count=${gr_filter_max_count}&`;
        };

        $.getJSON(url, function (d, status) {
            shop2.fire("afterGetFolderCustomFields", func, d, status);
            shop2.trigger("afterGetFolderCustomFields", d, status);
        });
    };
};*/

shop2.search.getParams = function (folder_id, func) {
    var gr_filter_max_count = shop2.my.gr_filter_max_count;
    var url;

    shop2.trigger('beforeGetFolderCustomFields');

    if (folder_id > 0) {

        $.getJSON('/-/x-api/v1/public/?method=shop2/getFolderCustomFields', {
            param: {
                folder_id: folder_id,
                html: 1
            },
            gr_filter_max_count: gr_filter_max_count
        }, function (d, status) {
            shop2.fire('afterGetFolderCustomFields', func, d.result, status);
            shop2.trigger('afterGetFolderCustomFields', d.result, status);
        });
    }
};

shop2.queue.product = function () {

    shop2.product._reload = function (node) {
        var $node = $(node);
        var kinds = shop2.product.getNodeData(node, 'kinds', true);
        var paramName = shop2.product.getNodeData(node, 'name');
        var paramValue = shop2.product.getNodeData(node, 'value');
        var $form = $node.closest('form');
        var form = $form.get(0);
        var meta;
        var kind_id;
        var product_id;
        var keys = {};
        var params = {};
        var is_param_select = false;

        window.gr_reloaded_product_node = $node.parents('.shop2-product-item');
        window.gr_reloaded_product_index = $node.parents('.shop2-product-item').index();

        if ($('.product-item-wrap').length) {
            window.gr_reloaded_product_index = $node.parents('.product-item-wrap').index();
            window.gr_reloaded_wrap_index = $node.parents('.main-products').index();
        }

        if (kinds && $.type(paramName) !== 'undefined' && $.type(paramValue) !== 'undefined' && form) {
            meta = $form.find('input[name=meta]').val();
            product_id = $form.find('input[name=product_id]').val();
            $form.find('[name=submit]').prop('disabled', true);
            $form.find('select.shop2-cf>option, li.shop2-cf, li.shop2-color-ext-selected, ul.shop2-color-ext-list>li').each(function () {
                var name = $(this).data('name');
                if (name) {
                    keys[name] = true;
                }
            });
            kind_id = shop2.product.findKindId(product_id, kinds, paramName, paramValue, meta, keys);
            if (!kind_id) {
                kind_id = $form.find('[name=kind_id]').val();
                is_param_select = true;
            }
            // select
            $form.find('.js-calc-custom-fields.additional-cart-params').each(function () {
                var ref_code = $(this).attr('name');
                params[ref_code] = $(this).find('option:selected').data('item-id');
            });
            // colore ref
            $form.find('.js-calc-custom-fields.shop2-color-ext-selected').each(function () {
                var ref_code = $(this).data('name');
                params[ref_code] = $(this).data('item-id');
            });
            // Selected params
            if (is_param_select) {
                shop2.product.getProductListItem(product_id, kind_id, function (d, status) {
                    if (status === 'success') {
                        var body = $.trim(d.data.body);
                        var product_price = $(".product-price", body).html();
                        var product_actions = $(".shop2-product-actions", body).html();
                        $form.find('.product-price').html(product_price);
                        $form.find('.shop2-product-actions').html(product_actions);
                        shop2.trigger('afterProductReloaded');
                        shop2.queue.heights();
                    }
                }, params);
            } else {
                if (shop2.mode === 'product') {
                    if (shop2.uri) {
                        document.location = shop2.uri + '/product/' + kind_id;
                    } else {
                        document.location = document.location.href.replace(/\/product\/.+/, '/product/' + kind_id);
                    }
                } else {
                    shop2.product.getProductListItem(product_id, kind_id, function (d, status) {
                        var cont, newCont, body;
                        if (status === 'success') {
                            shop2.trigger('afterProductReloaded');
                            cont = $node.closest('.shop2-product-item');
                            cont.hide();
                            body = $.trim(d.data.body);
                            newCont = $(body).insertBefore(cont);
                            cont.remove();
                            shop2.queue.heights();
                        }
                    }, params);
                }
            }
        }
    };

    $.on('select.shop2-cf', {
        change: function () {
            shop2.product._reload(this);
        }
    });

    $.on('li.shop2-cf:not(.active-color, .active-texture)', {
        click: function () {
            shop2.product._reload(this);
        }
    });

    $.on('span.shop2-path-show-folders', {
        click: function (e) {
            e.preventDefault();
            $(this).next().show();
            $(this).hide();
        }
    });

};

shop2.msg = function (text, obj) {
    var selector = '#shop2-msg',
        msg = $(selector),
        offset = obj.offset(),
        width = obj.outerWidth(true),
        height = obj.outerHeight(true);

    if (!msg.get(0)) {
        msg = $('<div id="shop2-msg">');
        $(document.body).append(msg);
        msg = $(selector);
    }

    msg.html(text).fadeIn(150);

    var msgWidth = msg.outerWidth();
    var msgHeight = msg.outerHeight();
    var left = offset.left + width;
    var top = offset.top + height;

    if (left + msgWidth > $(window).width()) {
        left = offset.left - msgWidth;
    }

    msg.css({
        left: 50 + '%',
        top: 50 + '%',
        'position': 'fixed',
        'margin-left': msgWidth / 2 * -1,
        'margin-top': msgHeight / 2 * -1
    });

    $.s3throttle('msg', function () {
        msg.hide();
    }, shop2.options.msgTime);

    $(document).on('click', '#shop2-msg', function () {
        $(this).fadeOut(150);
    });
};

shop2.queue.question = function () {
    var cls = '.price-old.question, .cart-total .question';

    $(document)
        .on("mouseenter", cls, function () {
            var $this = $(this),
                win = $this.next().show(),
                position = $this.position(),
                height = win.outerHeight(true);

            win.css({
                top: position.top - height - 5,
                left: position.left,
            });

            if (win.offset().left + win.outerWidth() > $(window).width()) {
                win.css({
                    left: (win.outerWidth() - win.offset().left) * -1,
                });
            };
        })
        .on("mouseleave", cls, function () {
            var $this = $(this),
                win = $this.next();

            win.hide();
        });
};

shop2.queue.compare = function () {
    var popup_data;
    var compare_arrow = '<i><svg class="gr-svg-icon"><use xlink:href="#icon_shop_notify_arr"></use></svg></i>';
    if (shop2.my.gr_popup_compare) {
        popup_data = ' data-remodal-target="compare-preview-popup"';
    };

    let $document = $(document);
    var compareBtn = '<a href="' + shop2.uri + '/compare" class="go-to-compare-btn"' + popup_data + ' target="_blank">' + _s3Lang.SHOP2_ADD_TO_COMPARE3 + ' ' + compare_arrow + '</a>';
    var compareBtn2 = '<a href="' + shop2.uri + '/compare" class="go-to-compare-btn"' + popup_data + ' target="_blank">' + _s3Lang.SHOP2_GO_TO_COMPARE + ' ' + compare_arrow + '</a>';

    function update(el, res) {

        $('input[type=checkbox][value=' + el.val() + ']').closest('.product-compare').replaceWith(res.data);
        $('.product-compare-added a span').html(res.count);
        $('.gr-compare-btn .gr-compare-btn-amount').html(res.count);

        if (+$('.gr-compare-btn .gr-compare-btn-amount').text() == '0') {
            $('.gr-compare-btn').removeClass('active');
        } else {
            $('.gr-compare-btn').addClass('active');
        };

        if (!$('.compare-remodal').hasClass('remodal-is-opened')) {
            shop2.msg('<span class="go-to-compare-count">' + res.count + '</span>' + ' ' + _s3Lang.SHOP2_PRODUCT_ADDED + ' ' + compareBtn, $('body'));
        };

        if (res.panel) {
            $('#shop2-panel').replaceWith(res.panel);
        };

    }

    $document.on('click', '.product-compare input:checkbox', function () {
        let $this = $(this),
            action = $this.attr('checked') ? 'del' : 'add';

        shop2.compare.action(action, $this.val(), function (res, status) {
            if (status == 'success') {


                if (res.errstr) {
                    if (!$('.compare-remodal').hasClass('remodal-is-opened')) {
                        shop2.msg(res.errstr + '<div class="go-to-compare-error">' + compareBtn2 + '</div>', $('body'));
                    }
                    $this.prop('checked', false);
                } else {
                    update($this, res);

                    if (action == 'del' && !$('.compare-remodal').hasClass('remodal-is-opened')) {
                        shop2.msg(_s3Lang.SHOP2_PRODUCT_REMOVED_COMPARE, $('body'));
                    }
                }

            }
        });
    });
};

shop2.product.getProductListItem = function (product_id, kind_id, func) {
    var gr_images_size = $('.product-list').data('images-size');
    var gr_images_view = $(".product-list").data("images-view");
    var gr_mode_catalog = $(".product-list").data("mode-catalog");
    var url = "/-/shop2-api/?cmd=getProductListItem&hash=" + shop2.apiHash.getProductListItem + "&ver_id=" + shop2.verId + "&gr_images_view=" + gr_images_view + "&gr_images_size=" + gr_images_size + "&gr_mode_catalog=" + gr_mode_catalog;

    shop2.trigger('beforeGetProductListItem', kind_id);

    $.post(
        url, {
        product_id: product_id,
        kind_id: kind_id
    },
        function (d, status) {
            shop2.fire('afterGetProductListItem', func, d, status);
            shop2.trigger('afterGetProductListItem', d, status);
        }
    );
};

shop2.queue.lazyLoad = function () {
    var $document = $(document),
        $window = $(window),
        blocked = false,
        products = $('.product-list');

    function path(url, param, value) {
        return url + (~url.indexOf("?") ? "&" : "?") + param + "=" + value;
    }

    if (shop2.my.lazy_load_subpages && products.get(0)) {
        $document.on('click', '.lazy-pagelist-btn', function (e) {

            e.preventDefault();

            var pagelist = $('.shop-pagelist');
            var next = pagelist.find('.active-num').next().find('a');

            if (!next.length) {
                return;
            }

            if (!blocked && next.get(0)) {
                blocked = true;

                $.get(path(next.attr('href'), 'products_only', 1), function (data) {

                    var productsHtml = $(data).filter('.product-list').html();
                    var $lazyLoad = $(data).filter('.lazy-pagelist');

                    $('.lazy-pagelist').remove();

                    $('.product-list').append(productsHtml);
                    $('.product-list').after($lazyLoad);

                    shop2.trigger('afterProductsLazyLoaded');

                    pagelist = $('.shop-pagelist');

                    pagelist.find('a').each(function () {
                        var $this = $(this),
                            href = $this.attr('href');
                        $this.attr('href', href.replace(/[&|\?]*products_only=[^&]/, ""));
                    });

                    blocked = false;
                });
            }
        });
    }
};

/*shop2.queue.addToCart = function() {
    $(document).on('click', '.shop-product-btn', function(e) {

        var $this = $(this),
            $form = $this.closest('form'),
            form = $form.get(0),
            adds = $form.find('.additional-cart-params'),
            len = adds.length,
            i, el,
            a4 = form.amount.value,
            kind_id = form.kind_id.value;
	
        e.preventDefault();

        if (len) {
            a4 = {
                amount: a4
            };

            for (i = 0; i < len; i += 1) {
                el = adds[i];
                if (el.value) {
                    a4[el.name] = el.value;
                }
            }
        }
    	
        shop2.cart.add(kind_id, a4, function(d) {
            $('#shop2-cart-preview').replaceWith(d.data);
        	
            var totalCartAmount = +$(d.data).find('.gr-cart-total-amount').text();
            var totalCartSum = $(d.data).find('.gr-cart-total-sum').data('total-price');
        	
            if (totalCartAmount>0) {
                $('.gr-cart-popup-btn').removeClass('pointer_events_none');
                $('.gr-cart-total-amount').text(totalCartAmount);
                $('.gr-cart-total-sum ins').text(totalCartSum);
            } else{
                $('.gr-cart-popup-btn').addClass('pointer_events_none');
                $('.gr-cart-total-amount').text('0');
                $('.gr-cart-total-sum ins').text('0');
            };

            if (d.errstr) {
                shop2.msg(d.errstr, $this);
            } else {
                var $text = window._s3Lang.JS_SHOP2_ADD_CART_WITH_LINK;
                var $text = $text.replace("</a>", "<i><svg class='gr-svg-icon'><use xlink:href='#icon_shop_notify_arr'></use></svg></i></a>");
            	
                shop2.msg($text.replace("%s", shop2.uri + "/cart"), $this);
            }

            if (d.panel) {
                $('#shop2-panel').replaceWith(d.panel);
            };
        });
    });
};*/

shop2.queue.addToCart = function () {

    $(document).on('click', '.shop-product-btn', function (e) {

        var $this = $(this),
            $form = $this.closest('form'),
            form = $form.get(0),
            adds = $form.find('.additional-cart-params'),
            len = adds.length,
            i, el,
            a4 = form.amount.value,
            kind_id = form.kind_id.value,
            params = {};

        e.preventDefault();

        if (len) {

            for (i = 0; i < len; i += 1) {
                el = adds[i];
                if (el.value) {
                    params[el.name] = el.value;
                }
            }
        }

        shop2.cart.add(kind_id, a4, params, function (d) {
            $('#shop2-cart-preview').replaceWith(d.html);


            var totalCartAmount = +$(d.html).find('.gr-cart-total-amount').text();
            var totalCartSum = $(d.html).find('.gr-cart-total-sum').data('total-price');

            if (totalCartAmount > 0) {
                $('.gr-cart-popup-btn').removeClass('pointer_events_none');
                $('.gr-cart-total-amount').text(totalCartAmount);
                $('.gr-cart-total-sum ins').text(totalCartSum);
            } else {
                $('.gr-cart-popup-btn').addClass('pointer_events_none');
                $('.gr-cart-total-amount').text('0');
                $('.gr-cart-total-sum ins').text('0');
            };

            if (d.errstr) {
                shop2.msg(d.errstr, $this);
            } else {
                var $text = window._s3Lang.JS_SHOP2_ADD_CART_WITH_LINK;
                var $text = $text.replace("</a>", "<i><svg class='gr-svg-icon'><use xlink:href='#icon_shop_notify_arr'></use></svg></i></a>");

                shop2.msg($text.replace('%s', shop2.uri + '/cart'), $this);
            }

            if (d.panel) {
                $('#shop2-panel').replaceWith(d.panel);
            }
        });

    });

};

shop2.cart.add = function (kind_id, a4, params, func) {

    shop2.trigger('beforeCartAddItem');

    $.post(
        '/-/x-api/v1/public/?method=cart/addItem', {
        kind_id,
        amount: a4,
        params
    },
        function (d, status) {
            shop2.fire('afterCartAddItem', func, d.result, status);
            shop2.trigger('afterCartAddItem', d.result, status);
        },
        'json'
    );
};
shop2.cart.addMultiple = function (params, func) {

    shop2.trigger('beforeCartAddMultipleItems');

    // Формируем массив items на основе params.kind_id и params.amount
    var newParams = params.kind_id.map(function (kind_id) {
        return {
            kind_id: kind_id,
            amount: params.amount[kind_id],
            // Добавьте здесь другие необходимые параметры, если они у вас есть
        };
    });

    // Новый объект параметров с items вместо kind_id и amount
    var items = {
        items: newParams  // Используем новый массив items
    };

    $.post('/-/x-api/v1/public/?method=cart/addItems', items, function (d, status) {

        shop2.fire('afterCartAddMultipleItems', func, d, status);
        shop2.trigger('afterCartAddMultipleItems', d, status);
    }, 'json');
};

shop2.filter.sort = function (name, elem) {
    var re = new RegExp(this.escape('s[sort_by]') + '=([^&]*)'),
        params = this.str.match(re),
        desc = name + ' desc',
        asc = name + ' asc',
        isDesc = (elem.is('.sort-param-desc'));


    params = (params && params.length > 1) ? params[1] : "";

    params = (isDesc) ? desc : asc;

    this.remove('s[sort_by]');
    this.add('s[sort_by]', params);
    return this;
};

shop2.queue.sort = function () {
    var wrap = $('.sorting');

    wrap.find('.sort-param').on('click', function (e) {
        var $this = $(this),
            name = $this.data('name');

        e.preventDefault();
        shop2.filter.sort(name, $this);
        shop2.filter.go();
    });

    wrap.find('.sort-reset').on('click', function (e) {
        e.preventDefault();
        shop2.filter.remove('s[sort_by]');
        shop2.filter.go();
    });
};

shop2.queue.colorPopup = function () {
    var handle;

    $(document).on('click', '.shop2-color-ext-list li', function () {
        var caption = $(this);
        var wrap = caption.closest('.shop2-color-ext-popup');
        var ul = wrap.find('.shop2-color-ext-list');
        var offset = caption.offset();
        var $this = $(this);
        var data = $this.data();
        var input = $this.parent().find('input.additional-cart-params');
        var isSelected = $this.is('.shop2-color-ext-selected');

        colors = ul.children('li');

        if (typeof data.kinds !== 'undefined' || input.length) {
            $this.addClass('shop2-color-ext-selected').siblings().removeClass('shop2-color-ext-selected');

            if (input.length) {
                input.val(data.value);
            } else {
                if (!isSelected) {
                    shop2.product._reload(this);
                }
            }

        } else {
            var index = $this.index();

            colors.eq(index).toggleClass('shop2-color-ext-selected');
            shop2.filter.toggle(data.name, data.value);
            shop2.filter.count();

            var offsetTop = $(this).position().top;

            $('.result-popup').css({
                'top': offsetTop,
                'visibility': 'visible',
                'opacity': '1',
                'display': 'block'
            });

        }
        return false;
    });
};

shop2.queue.coupon = function () {
    shop2.on('afterCartAddCoupon, afterCartRemoveCoupon', function () {
        document.location.reload();
    });

    $('.coupon-btn').on('click', function (e) {
        var coupon = $('#coupon'),
            code = coupon.val();

        e.preventDefault();

        if (code) {
            shop2.cart.addCoupon(code);
        } else {
            shop2.msg('Введите код купона', $(this));
        }

    });


    $('.coupon-delete').on('click', function (e) {
        var $this = $(this),
            code = $this.data('code');

        e.preventDefault();

        if (code) {
            shop2.cart.removeCoupon(code);
        }
    });
};

shop2.cart.applyBonusPoint = function (bonus_points, func) {

    shop2.trigger('beforeCartApplyBonus');

    $.getJSON(
        '/-/x-api/v1/public/?method=cart/applyBonusPoints', {
        param: {
            hash: shop2.hash.cart,
            bonus_points: bonus_points
        }
    },
        function (d, status) {
            shop2.fire('afterCartApplyBonusPoints', func, d, status);
            shop2.trigger('afterCartApplyBonusPoints', d, status);
        }
    );

    return false;
};

shop2.cart.removeBonusPoint = function (func) {

    shop2.trigger('beforeCartRemoveCartBonusPoints');

    $.getJSON(
        '/-/x-api/v1/public/?method=cart/RemoveBonusPoints', {
        param: {
            hash: shop2.hash.cart
        }
    },
        function (d, status) {
            shop2.fire('afterCartRemoveCartBonusPoints', func, d, status);
            shop2.trigger('afterCartRemoveCartBonusPoints', d, status);
        }
    );
};

shop2.queue.bonus = function () {

    shop2.on('afterCartApplyBonusPoints, afterCartRemoveCartBonusPoints', function () {
        document.location.reload();
    });

    $(document).on('click', '.bonus-apply', function (e) {
        var bonus = $('#bonus-points'),
            points = Number(bonus.val()),
            bonus_user = Number($('.bonus-amount').data('bonus-amount'));

        switch (true) {
            case points == "":

                e.preventDefault();

                shop2.msg('Введите значение', $(this));

                break;

            case points > bonus_user:

                shop2.msg('Вам доступно только ' + bonus_user + ' бонусов', $(this));

                break;

            case bonus_user >= points:

                shop2.cart.applyBonusPoint(points);

                break;
        };
    });

    $(document).on('click', '.bonus-delete', function (e) {
        shop2.cart.removeBonusPoint();
    });

    $(document).off('click.bonusLabel').on('click.bonusLabel', '.cart-bonuses__title label', function (e) {
        e.preventDefault();
        var $check = $(':checkbox', this);
        $check.prop('checked', !$check.prop('checked'));

        $('.cart-bonuses__container').toggleClass('show_bonuses');
        $('.accrual_or_using_js').toggle();

        if (!$check.prop('checked') && $('.cart-total__item.bonus_item').length) {
            shop2.cart.removeBonusPoint();
        };
    });

    $.fn.inputFilter = function (inputFilter) {
        return this.on("input keydown keyup mousedown mouseup select contextmenu drop", function () {
            if (inputFilter(this.value)) {
                this.oldValue = this.value;
                this.oldSelectionStart = this.selectionStart;
                this.oldSelectionEnd = this.selectionEnd;
            } else if (this.hasOwnProperty("oldValue")) {
                this.value = this.oldValue;
                this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
            }
        });
    };

    $("#bonus-points").inputFilter(function (value) {
        return /^\d*$/.test(value);
    });
};

shop2.delivery.calc = function (attach_id, params, func) {

    shop2.trigger('beforeDeliveryCalc');

    var paramString = params;
    var paramArray = paramString.split("&");
    var params = {};

    paramArray.forEach(function (part) {
        var item = part.split("=");
        // Декодируем компоненты URI и присваиваем их объекту `params`
        params[decodeURIComponent(item[0])] = decodeURIComponent(item[1] || '');
    });

    $.getJSON(
        '/-/x-api/v1/public/?method=delivery/calc', {
        param: {
            attach_id: attach_id,
            params: params,
        },
    },
        function (d, status) {
            shop2.fire('afterDeliveryCalc', func, d, status);
            shop2.trigger('afterDeliveryCalc', d, status);
        }
    );
};

shop2.queue.cart = function () {

    var updateBtn = $('.shop2-cart-update'),
        cartTable = $('.shop2-cart-table'),
        form = $('#shop2-cart');

    shop2.on('afterCartRemoveItem, afterCartUpdate', function () {
        document.location.reload();
    });

    function updateBtnShow() {
        updateBtn.show();
    }

    var eventName;

    ['keypress', 'keyup', 'keydown'].forEach(function (item) {
        if ('on' + item in document) {
            eventName = item;
            return false;
        }
    });

    cartTable.find('input:text').on(eventName, function (e) {
        if (e.keyCode == 13) {
            shop2.cart.update(form);
        } else {
            updateBtnShow();
        }
    });

    $(document).on('click', 'li.param-value:not(.shop2-color-ext-selected)', function () {
        updateBtnShow();
    });

    $(document).on('change', 'select.param-value', function () {
        updateBtnShow();
    });

    cartTable.find('.amount-minus, .amount-plus').on('click', updateBtnShow);

    updateBtn.on('click', function (e) {
        e.preventDefault();
        shop2.cart.update(form);
        return false;
    });


    $('.cart-delete a').on('click', function (e) {
        var $this = $(this),
            $cartItem = $this.closest('.cart-products__item'),
            cartItemPos = $cartItem.data('position'),
            id = $this.data('id'),
            params = {};

        console.log(cartItemPos)

        e.preventDefault();

        if (typeof id !== 'number') {
            // Попытаемся найти первый ключ с помощью регулярного выражения
            var matches = id.match(/^\{'(\d+)':\{/);
            var firstKey = matches[1];

            // Продолжаем работать с оставшейся частью строки, чтобы вытащить остальные свойства.
            var params = {};
            // Удаляем первый ключ из строки
            var paramsStr = id.match(/\{(.+?)\}\}$/)[1];
            // Извлекаем пары ключ-значение
            var re = /'([^']+?)':'([^']*)'/g;
            var match;
            while ((match = re.exec(paramsStr)) !== null) {
                params[match[1]] = match[2];
            }

            id = firstKey;
        }

        shop2.cart.remove(id, params, cartItemPos);

    });

    $(document).on('click', '#shop2-deligate-calc', function (e) {
        var data = {},
            delivery = $('#shop2-order-delivery'),
            tabs = delivery.find('.shop2-delivery--item__tab');

        $('#shop2-perfect-form').find('input, textearea, select').each(function () {
            var $this = $(this);
            if (this.tagName === 'INPUT' && this.type === 'checkbox') {
                if (this.checked) {
                    data[this.name] = 'on';
                }
            } else {
                data[this.name] = $(this).val();
            }
        });

        e.preventDefault();
        tabs.removeClass('active-tab');
        tabs.removeClass('point');
        delivery.addClass('preloader');
        $('#shop2-delivery-wait').show();
        $('input#address').blur();
        $('#shop2-deligate-calc').hide();
        //$('#form_g-anketa .text-right button').prop('disabled', true).addClass('g-button--disabled');

        $.ajax({
            url: '/-/x-api/v1/public/?method=deligate/calc&param[get_vars][]',
            type: 'post',
            dataType: 'json',
            data: data,
            success: function (result) {
                delivery.removeClass('preloader');
                $('#shop2-delivery-wait').hide();
                $('#shop2-order-delivery').html(result.result.html);
                $('#shop2-order-delivery').append('<div class="preloader"><div class="spinner"></div></div>');
                $('#shop2-order-delivery').find('.delivery-items').each(function () {
                    var $this = $(this);
                    if ($.trim($this.text()) == "") {
                        $this.parents('.shop2-delivery--item__tab:first').addClass('disabled');
                    }
                });
                if (result.result.error) {
                    shop2.alert(result.result.error);
                    /* Deligate. Корзина. Доработка валидации поля для ввода города  /GR_Task/10 */
                    let on_shop2_btn = shop2.my.on_shop2_btn ? '.shop2-btn' : '.g-button';
                    if ($('.order_design_five').length) {
                        if ($('.order_design_five  ul li').length <= 1) {
                            $('.order_design_five  ul li').before(`<li>${result.result.error}</li>`);
                        }
                        $(`.form-item ${on_shop2_btn}`).addClass('shop2-disabled');
                        $(`.order_design_five`).removeClass('hide');
                    }
                    /* Deligate. Корзина. Доработка валидации поля для ввода города  /GR_Task/10 */
                } else {

                    var dadataJson = $.parseJSON($('#dadata').val()),
                        coordsCenter = [dadataJson.geo_lat, dadataJson.geo_lon];

                    /* Deligate. Корзина. Доработка валидации поля для ввода города  /GR_Task/10 */
                    let on_shop2_btn = shop2.my.on_shop2_btn ? '.shop2-btn' : '.g-button';
                    if ($('.order_design_five ').length) {
                        if ($('.order_design_five  ul li').length > 1) {
                            $('.order_design_five  ul li').first().remove();
                        }
                        $(`.form-item ${on_shop2_btn}`).removeClass('shop2-disabled');
                        $(`.order_design_five`).addClass('hide');
                    }
                    /* Deligate. Корзина. Доработка валидации поля для ввода города  /GR_Task/10 */
                    shop2.queue.edost2();
                    $('#shop2-ems-calc, #shop2-edost-calc').on('click', function (e) {
                        var $this = $(this);
                        var attach_id = $this.data('attach-id');
                        var to = $('select[name=' + attach_id + '\\[to\\]]');
                        var zip = $('input[name=' + attach_id + '\\[zip\\]]');
                        var order_value = $('input[name=' + attach_id + '\\[order_value\\]]');

                        if (to.length == 0) {
                            to = $('#shop2-edost2-to');
                        }

                        e.preventDefault();

                        to = to.get(0) ? to.val() : '';
                        zip = zip.get(0) ? zip.val() : '';
                        order_value = order_value.prop("checked") ? 'on' : '';

                        /*shop2.delivery.calc(attach_id, 'to=' + to + '&zip=' + zip + '&order_value=' + order_value, function(d) {
                          if (!d.data && d.errstr) {
                            shop2.alert(d.errstr);
                            $('#delivery-' + attach_id + '-cost').html(0);
                          } else {
                            $('#delivery-' + attach_id + '-cost').html(d.data.cost);
            
                            if (d.data.html) {
                              $('#delivery-' + attach_id + '-html').html(d.data.html);
                              shop2.queue.edost();
                            }
                          }
                        });*/

                        shop2.delivery.calc(attach_id, 'to=' + to + '&zip=' + zip + '&order_value=' + order_value, function (d) {
                            if (!d.data && d.errstr) {
                                shop2.alert(d.errstr);
                                $('#delivery-' + attach_id + '-cost').html(0);
                            } else {
                                $('#delivery-' + attach_id + '-cost').html(d.result.data.cost);

                                if (d.result.data.html) {
                                    $('#delivery-' + attach_id + '-html').html(d.result.data.html);
                                    shop2.queue.edost();
                                }
                            }
                        });

                    });
                    $('#shop2-deligate-calc').hide();
                }
            }
        });
    });
};

shop2.queue.delivery = function () {
    $('#shop2-order-delivery').find('.delivery-items').each(function () {
        var $this = $(this);
        if ($.trim($this.text()) == "") {
            $this.parents('.shop2-delivery--item__tab:first').addClass('disabled');
        }
    });
    $(document).on('change', '.map-select select', function () {
        var $this = $(this),
            index = $this.find('option:selected').index(),
            pos = $this.find('option:selected').text(),
            id = $this.val();

        if (index == 0) {
            shop2.delivery.ymapsMap.balloon.close();
            return;
        }

        var it = shop2.delivery.ymapsMap.geoObjects.getIterator(),
            ss;
        while (ss = it.getNext()) {
            for (var i = 0, len = ss.getLength(); i < len; i++) {
                var placemark = ss.get(i);
                if (placemark.properties.get('id') === id) {
                    placemark.options.set('iconImageHref', shop2.delivery.ymapsIconsData['selected']);
                    if (placemark.balloon.isOpen()) {
                        placemark.balloon.close();
                    } else {
                        placemark.balloon.open();
                    }
                    //return;
                } else {
                    placemark.options.set('iconImageHref', shop2.delivery.ymapsIconsData['default']);
                }
            }
            return;
        }

    });

    $(".shop2-payment-options .option-type").each(function () {

        if ($(this).hasClass("option-payment-systems") && $(this).hasClass("active-type")) {
            var payment_btn = $('.shop2-payment-options .shop2-payment-btn');
            var continue_text = $('.shop2-payment-options .shop2-payment-btn').attr('data-continue-text');
            var pay_text = $('.shop2-payment-options .shop2-payment-btn').attr('data-pay-text');

            payment_btn.text(pay_text);
        }
    });

    $(document).on('click', '.shop2-cart-order-payments .options-list .option-type:not(.active-type) .option-label.payments-label', function (e) {
        e.stopPropagation();
        var $this = $(this),
            groups = $(document).find('.shop2-cart-order-payments .option-type');

        groups.removeClass('active-type');
        $this.parent().addClass('active-type');
    }); // Обработка клика на полученные способы оплаты после выбора доставки

    $(document).on('click', '.option-label:not(.payments-label)', function (e) {
        var $this = $(this),
            options = $(document).find('.option-label'),
            groups = $(document).find('.option-type'),
            details = options.next(),
            index = $this.parent().index();

        if (e.target.nodeName != 'INPUT' && shop2.delivery.deligate && shop2.mode != 'orders') {
            e.preventDefault();
        }

        if (shop2.delivery.ymapsMap) {
            shop2.delivery.ymapsMap.destroy();
            shop2.delivery.ymapsMap = null;
        }
        /* Deligate. Корзина. Доработка валидации поля для ввода города  /GR_Task/10 */
        if (true) {
            let on_shop2_btn = shop2.my.on_shop2_btn ? '.shop2-btn' : '.g-button';
            if ($this.hasClass('ymap')) {
                if ($(`.form-item ${on_shop2_btn}`).length) {
                    $(`.form-item ${on_shop2_btn}`).addClass('shop2-disabled');
                    $(`.order_design_five`).removeClass('hide');
                }
            } else {
                if ($(`.form-item ${on_shop2_btn}.shop2-disabled`).length) {
                    $(`.form-item ${on_shop2_btn}.shop2-disabled`).removeClass('shop2-disabled');
                    $(`.order_design_five`).addClass('hide');
                }
            }
        }
        /* Deligate. Корзина. Доработка валидации поля для ввода города  /GR_Task/10 */
        groups.removeClass('active-type');
        $this.parent().addClass('active-type');
        details.find('input, textarea, select').prop('disabled', true);
        $this.next().find('input, textarea, select').prop('disabled', false);
        if (shop2.delivery.deligate) {
            $this.find('input:first').prop('checked', true);
        }

        if ($this.hasClass('ymap')) {
            shop2.delivery.YmapsInit($this.data('service-code'));
        }

        if ($(".shop2-payment-options .shop2-btn").hasClass("shop2-payment-btn")) {

            var payment_btn = $('.shop2-payment-options .shop2-payment-btn');
            var continue_text = $('.shop2-payment-options .shop2-payment-btn').attr('data-continue-text');
            var pay_text = $('.shop2-payment-options .shop2-payment-btn').attr('data-pay-text');


            if ($this.parent().hasClass('option-payment-systems')) {
                payment_btn.text(pay_text);
            } else {
                payment_btn.text(continue_text);
            }
        }

    });
    $(document).on('click', '.shop2-delivery--item__tab .tab-label', function () {
        var groups = $(document).find('.shop2-delivery--item__tab'),
            $this = $(this),
            parent = $this.parents('.shop2-delivery--item__tab:first'),
            index = parent.index();

        if (parent.hasClass('disabled')) return false;
        if (parent.hasClass('active-tab')) {
            parent.removeClass('active-tab');
            return;
        }

        groups.removeClass('active-tab').eq(index).addClass('active-tab');

        var activeTabOffsetTop = $('.active-tab .tab-label').offset().top - 10;
        $('html, body').animate({
            scrollTop: activeTabOffsetTop
        }, 800);
    });

    $(document).on("click", ".option-label:not(.payments-label)", function () {
        var $this = $(this),
            attach_id = $this.data("attach_id"),
            siblings = $this.parent().siblings(".option-type"),
            tabsSib = $this.parents('.shop2-delivery--item__tab:first').siblings();
        $("#delivery_id_deligate").val(attach_id);
        $("#deligate_points_fields .fields").empty();
        $("#deligate_points_fields").hide();
        tabsSib.find('.option-type input').prop('checked', false);
        tabsSib.removeClass('point');
        siblings.find('input').prop('checked', false);
    });

    $('#shop2-ems-calc, #shop2-edost-calc').on('click', function (e) {
        var $this = $(this);
        var attach_id = $this.data('attach-id');
        var to = $('select[name=' + attach_id + '\\[to\\]]');
        var zip = $('input[name=' + attach_id + '\\[zip\\]]');
        var order_value = $('input[name=' + attach_id + '\\[order_value\\]]');

        if (to.length == 0) {
            to = $('#shop2-edost2-to');
        }

        e.preventDefault();

        to = to.get(0) ? to.val() : '';
        zip = zip.get(0) ? zip.val() : '';
        order_value = order_value.prop("checked") ? 'on' : '';

        /*shop2.delivery.calc(attach_id, 'to=' + to + '&zip=' + zip + '&order_value=' + order_value, function (d) {
            if (!d.data && d.errstr) {
                shop2.alert(d.errstr);
                $('#delivery-' + attach_id + '-cost').html(0);
            } else {
                $('#delivery-' + attach_id + '-cost').html(d.data.cost);

                if (d.data.html) {
                    $('#delivery-' + attach_id + '-html').html(d.data.html);
                    shop2.queue.edost();
                }
            }
        });*/

        shop2.delivery.calc(attach_id, 'to=' + to + '&zip=' + zip + '&order_value=' + order_value, function (d) {
            if (!d.data && d.errstr) {
                shop2.alert(d.errstr);
                $('#delivery-' + attach_id + '-cost').html(0);
            } else {
                $('#delivery-' + attach_id + '-cost').html(d.result.data.cost);

                if (d.result.data.html) {
                    $('#delivery-' + attach_id + '-html').html(d.result.data.html);
                    shop2.queue.edost();
                }
            }
        });

    });
};




shop2.filter.count = function (func) {

    var str = this.str;
    var pre_params = this._pre_params;

    str = str.replace(/s(?=\[)/g, '');
    pre_params = pre_params.replace(/&s/, '&');

    // Разделение str на пары ключ=значение
    var keyValuePairs = str.split('&');
    var params = {};

    // Обработка строки str
    keyValuePairs.forEach(function (pair) {
        var parts = pair.split('=');
        var key = parts[0]; // Удаление всех квадратных скобок
        var value = parts[1];
        if (key) {
            params[`param[s]${key}`] = value; // Добавление в params
        }
    });

    // Обработка строки pre_params и добавление значения в params
    var keyValuePairs2 = pre_params.split('&');

    keyValuePairs2.forEach(function (pair) {
        var parts = pair.split('=');
        var key = parts[0]; // Удаление всех квадратных скобок
        var value = parts[1];
        if (key) {
            params[`param[s]${key}`] = value; // Добавление в params
        }
    });

    shop2.trigger('beforeGetSearchMatches');

    $.get(
        '/-/x-api/v1/public/?method=shop2/getSearchMatches',
        params,
        function (d, status) {
            if (status == 'success') {
                if ($.type(d) === 'string') {
                    d = $.parseJSON(d);
                }
            }

            if (shop2.facets.enabled) {
                shop2.facets.aggregation(d.result);
            }

            shop2.fire('afterGetSearchMatches', func, d, status);
            shop2.trigger('afterGetSearchMatches', d, status);
        }
    );
};

shop2.queue.filter = function () {

    var wrap = $('.shop2-filter'),
        result = $('.result');

    shop2.filter.init();

    shop2.on('afterGetSearchMatches', function (d, status) {
        if (d.error) return;

        if (d.result.data.total_found === 0) {

            result.addClass('no-result');
        } else {
            result.removeClass('no-result');
        }

        if (shop2.facets.enabled) {
            shop2.facets.set('filter');
        }

        $('#filter-result').html(d.result.data.total_found);

        result.removeClass('hide');
    });

    wrap.find('.param-val').on('click', function (e) {
        var $this = $(this),
            name = $this.data('name'),
            value = $this.data('value');

        e.preventDefault();

        $this.toggleClass('active-val');
        shop2.filter.toggle(name, value);
        shop2.filter.count();
    });

    wrap.find('select').on('change', function () {
        var $this = $(this),
            name = this.name,
            value = $this.val();

        shop2.filter.add(name, value);
        shop2.filter.count();
    });

    wrap.find('input:text').keyup(function () {
        var $this = $(this),
            name = $this.attr('name');

        $.s3throttle('filter: ' + name, function () {
            var value = $this.val();

            shop2.filter.add(name, value);
            shop2.filter.count();
        }, 500);
    });

    wrap.find('.shop2-filter-go').on('click', function (e) {
        e.preventDefault();
        shop2.filter.go();
    });

};

shop2.facets.searchSetup = function () {
    if (!this.search) {
        return;
    }

    var $form = $(this.search.wrapper);

    if (!$form.length) {
        return;
    }

    var $items = $form.find(this.search.items);
    var self = this;
    var url = '/-/x-api/v1/public/?method=shop2/getSearchMatches';
    var formData = $form.serialize();

    this.getDataSearch(url, formData);

    $items.on('change', function (e) {
    	e.stopPropagation();
    	
        if (e.target.name == "s[products_per_page]") {
            return;
        }

        var formData = $form.serialize();

        self.getDataSearch(url, formData);
    });
};
shop2.facets.getDataSearch = function (url, formData) {

    // Example formData:
    var str = decodeURIComponent(formData);

    // Prepare params object
    var params = {};

    // Split the string into key-value pairs
    var keyValuePairs = str.split('&');

    // Process each pair
    keyValuePairs.forEach(function (pair) {
        var parts = pair.split('=');
        var key = parts[0];
        var value = parts[1] || ''; // Defaulting to empty string if value is undefined

        // Split the key into its components based on '[' and ']'
        key = key.replace(/\]$/, ''); // Remove closing bracket at the end of key
        var keyParts = key.split('[').map(function (k) {
            return k.replace(/[\[\]]/g, ''); // Removing extra brackets just in case
        });

        // Construct new key path
        if (keyParts.length > 0) {
            var newKey = 'param';
            keyParts.forEach(function (part) {
                newKey += '[' + part + ']';
            });

            params[newKey] = value;
        }
    });

    $.get(
        url, params,
        function (d, status) {

            if (status == 'success') {

                if ($.type(d.result) === 'string') {
                    d.result = $.parseJSON(d.result);
                }

                shop2.facets.aggregation(d.result);
                shop2.facets.set('search');
            }
        }
    );
};
shop2.facets.aggregation = function (d) {
    if (typeof d === 'object' && d.data.aggs) {
        this.aggs = this.dataSetup(d.data.aggs);
    }

    return this.aggs;
};