shop2.facets.search.wrapper = "";
shop2.options.msgTime = 2000;

(function(){
	if (!!document.querySelector('#product-tabs')) {
		let gr_active_tab = localStorage.getItem('gr_tab_href');
					
		if (gr_active_tab!=null && $(gr_active_tab).length) {
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
			
			let gr_active_tabs = document.querySelectorAll('[href="'+gr_active_tab+'"]');
			for (i = 0; i < gr_active_tabs.length; i++) {
				gr_active_tabs[i].parentNode.classList.add('r-tabs-state-active');
			};
		};
	};
})();

shop2.search.getParams = function (folder_id, func) {
	var gr_filter_max_count = shop2.my.gr_filter_max_count;
    var url;

    shop2.trigger("beforeGetFolderCustomFields");
    
    if (folder_id > 0) {
        url =
            "/my/s3/api/shop2/?cmd=getFolderCustomFields" +
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

shop2.msg = function(text, obj) {
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
    
    $.s3throttle('msg', function() {
		msg.hide();
    }, shop2.options.msgTime);

    $(document).on('click', '#shop2-msg', function() {
        $(this).fadeOut(150);
    });
};

shop2.queue.question = function() {
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

shop2.queue.compare = function() {
	var popup_data;
	var compare_arrow = '<i><svg class="gr-svg-icon"><use xlink:href="#icon_shop_notify_arr"></use></svg></i>';
	if (shop2.my.gr_popup_compare) {
		popup_data = ' data-remodal-target="compare-preview-popup"';
	};
	
	let $document = $(document);
	if ($('html').attr('lang') == 'ru') {
		var compareBtn = '<a href="' + shop2.uri + '/compare" class="go-to-compare-btn"'+popup_data+' target="_blank">к сравнению'+compare_arrow+'</a>';
		var compareBtn2 = '<a href="' + shop2.uri + '/compare" class="go-to-compare-btn"'+popup_data+' target="_blank">Перейти к сравнению'+compare_arrow+'</a>';
	} else {
		var compareBtn = '<a href="' + shop2.uri + '/compare" class="go-to-compare-btn"'+popup_data+' target="_blank">сompare'+compare_arrow+'</a>';
		var compareBtn2 = '<a href="' + shop2.uri + '/compare" class="go-to-compare-btn"'+popup_data+' target="_blank">Compare'+compare_arrow+'</a>';
	};

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
			if ($('html').attr('lang') == 'ru') {
				shop2.msg('<span class="go-to-compare-count">'+res.count+'</span>' + 'Товар добавлен ' + compareBtn, $('body'));
			} else {
				shop2.msg('<span class="go-to-compare-count">'+res.count+'</span>' + 'Added to ' + compareBtn, $('body'));
			};
		};

		if (res.panel) {
			$('#shop2-panel').replaceWith(res.panel);
		};

	}

	$document.on('click', '.product-compare input:checkbox', function() {
		let $this = $(this),
			action = $this.attr('checked') ? 'del' : 'add';
			
		shop2.compare.action(action, $this.val(), function(res, status) {
			if (status == 'success') {
				

				if (res.errstr) {
					if (!$('.compare-remodal').hasClass('remodal-is-opened')) {
						shop2.msg(res.errstr + '<div class="go-to-compare-error">'+compareBtn2+'</div>', $('body'));
					}
					$this.prop('checked', false);
				} else {
					update($this, res);
					
					if (action == 'del' && !$('.compare-remodal').hasClass('remodal-is-opened')) {
						if ($('html').attr('lang') == 'ru') {
							shop2.msg('Товар удален из сравнения', $('body'));
						} else {
							shop2.msg('Product removed from comparison', $('body'));
						};
					}
				}
				
			}
		});
	});
};

shop2.product.getProductListItem = function(product_id, kind_id, func) {
    var gr_images_size = $('.product-list').data('images-size');
    var gr_images_view = $(".product-list").data("images-view");
    var gr_mode_catalog = $(".product-list").data("mode-catalog");
	var url = "/my/s3/api/shop2/?cmd=getProductListItem&hash=" + shop2.apiHash.getProductListItem + "&ver_id=" + shop2.verId + "&gr_images_view=" + gr_images_view + "&gr_images_size=" + gr_images_size + "&gr_mode_catalog=" + gr_mode_catalog;
	
    shop2.trigger('beforeGetProductListItem');

    $.post(
        url, {
            product_id: product_id,
            kind_id: kind_id
        },
        function(d, status) {
            shop2.fire('afterGetProductListItem', func, d, status);
            shop2.trigger('afterGetProductListItem', d, status);
        }
    );
};

shop2.queue.lazyLoad = function() {
    var $document = $(document),
        $window = $(window),
        blocked = false,
        products = $('.product-list');

    function path(url, param, value) {
        return url + (~url.indexOf("?") ? "&" : "?") + param + "=" + value;
    }
    
    if (shop2.my.lazy_load_subpages && products.get(0)) {
        $document.on('click', '.lazy-pagelist-btn', function(e){
        	
        	e.preventDefault();
        	
            var pagelist = $('.shop-pagelist');
            var next = pagelist.find('.active-num').next().find('a');

            if (!next.length) {
                return;
            }

            if (!blocked && next.get(0)) {
                blocked = true;
              
                $.get(path(next.attr('href'), 'products_only', 1), function(data) {
                	
                	var productsHtml = $(data).filter('.product-list').html();
                	var $lazyLoad = $(data).filter('.lazy-pagelist');
                	
                	$('.lazy-pagelist').remove();
                	
                	$('.product-list').append(productsHtml);
                	$('.product-list').after($lazyLoad);
                	
                	shop2.trigger('afterProductsLazyLoaded');
				    
				    pagelist = $('.shop-pagelist');
				    
                    pagelist.find('a').each(function() {
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

shop2.queue.addToCart = function() {
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
};

shop2.filter.sort = function(name, elem) {
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

shop2.queue.sort = function() {
    var wrap = $('.sorting');

    wrap.find('.sort-param').on('click', function(e) {
        var $this = $(this),
            name = $this.data('name');

        e.preventDefault();
        shop2.filter.sort(name, $this);
        shop2.filter.go();
    });

    wrap.find('.sort-reset').on('click', function(e) {
        e.preventDefault();
        shop2.filter.remove('s[sort_by]');
        shop2.filter.go();
    });
};

shop2.queue.colorPopup = function() {
	var handle;

	$(document).on('click', '.shop2-color-ext-list li', function() {
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
		'/my/s3/xapi/public/?method=cart/applyBonusPoints', {
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
		'/my/s3/xapi/public/?method=cart/RemoveBonusPoints', {
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

	$('.bonus-apply').on('click', function (e) {
		var bonus = $('#bonus-points'),
			points = Number(bonus.val()),
			bonus_user = Number($('.bonus-amount').data('bonus-amount'));

		switch (true) {
			case points == "":

				e.preventDefault();
				
				shop2.msg('Введите значение', $(this));

				break;
				
			case points > bonus_user:
			
				shop2.msg('Вам доступно только '+bonus_user+' бонусов', $(this));
			
				break;
				
			case bonus_user >= points:

				shop2.cart.applyBonusPoint(points);

				break;
		};
	});

	$('.bonus-delete').on('click', function (e) {
		shop2.cart.removeBonusPoint();
	});
	
	$('.cart-bonuses__title label').on('click', function(e){
		e.preventDefault();
        var $check = $(':checkbox', this);
        $check.prop('checked', !$check.prop('checked'));
        
		$('.cart-bonuses__container').toggleClass('show_bonuses');
		
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
	
(function($, myObject) {
		
	var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent),
		isApple = /iPod|iPad|iPhone/i.test(navigator.userAgent),
		$doc = $(document),
		$win = $(window),
		$html = $(document.documentElement);
		
	var shop2_gr = {
		queue: {},
		methods : {},
		init: function() {

			$(function() {

				let queue = shop2_gr.queue;

				if (isMobile) $html.addClass('mobile');

				for (key in queue) {
					let f = queue[key];
					if (typeof f === 'function') {
						setTimeout(function(){
							f();
						});			
					};
				}
				
			});

		}
	};
	
	shop2_gr.queue = {
		ajaxRequestsComplete: function() {
			
			$.ajaxSetup({
				complete: function() {
					setTimeout(function(){
						shop2_gr.methods.changeFlagsColor();
					});
				}
			});

			shop2.on('afterProductReloaded', function(){
				
				setTimeout(function(){
					shop2_gr.methods.viewLots();
					shop2_gr.methods.amountInit();
					shop2_gr.methods.changeFlagsColor();

					$('.shop2-product-item .buy-one-click').attr('data-api-url', $('.product-list').data('popup-form'));
					$('.shop2-product-item .buy-one-click.product_info_form').attr('data-api-url', $('.product-list').data('info-popup-form'));

					$('.product-list .gr_images_lazy_load').each(function(){
					    $(this).attr('src', $(this).attr('data-src'));
					});
					
					if (!isMobile) {
						$('.quick-view-trigger').elemToolTip({
					    	text: 'Быстрый просмотр',
					    	margin: 12
					    });
					};
				    
				    $('#shop2-tooltip').hide();

					$('.shop2-product-item').eq(gr_reloaded_product_index).addClass('active');

				    setTimeout(function () {
				    	var hideText = $('html').attr('lang') == 'ru' ? 'Свернуть' : 'Hide';
				    	
				        $('.shop2-product-item.active .gr-options-more__btn').addClass('active');
				        $('.shop2-product-item.active .gr-options-more__btn ins').text(hideText);
				        $('.shop2-product-item.active .gr-options-container').show();
				        $('.shop2-product-item').removeClass('active');
				        
				        $('.product-list.thumbs .product-price').matchHeight('remove');
						$('.product-list.thumbs .product-price').matchHeight();
				    });
				});
			});
			
			shop2.on('afterProductsLazyLoaded', function(){
				$('.product-list .gr_images_lazy_load').each(function(){
			   		$(this).attr('src', $(this).attr('data-src'));
				});
				
				$('.quick-view-trigger').elemToolTip({
			    	text: 'Быстрый просмотр',
			    	margin: 12
			    });

				//$('.product-list.thumbs .product-item__bottom-left').matchHeight('remove');
        		$('.product-list.thumbs .product-item__bottom-right').matchHeight('remove');
				$('.product-list.thumbs .product-price').matchHeight('remove');
        		//$('.product-list.thumbs .product-item__bottom').matchHeight('remove');

        		$('.product-list.thumbs .product-item__bottom-right').matchHeight();
				$('.product-list.thumbs .product-price').matchHeight();
				//$('.product-list.thumbs .product-item__bottom-left').matchHeight();
        		//$('.product-list.thumbs .product-item__bottom').matchHeight();
            	
            	shop2_gr.methods.viewLots();
            	shop2_gr.methods.amountInit();
			});

		}, /*Обновление скриптов при аякс-запросах*/
		
		ajaxCompare: function(){
			if (shop2.mode=="") {
				var url = document.location.origin;
				$.ajax({
					url: url,
						success: function(data){
						var compare_btn = $(data).find('.gr-compare-btn');
						var cart_btn = $(data).find('.gr-cart-popup-btn');
						$('.gr-compare-btn').replaceWith(compare_btn);
						$('.gr-cart-popup-btn').replaceWith(cart_btn);
					}
				});	
			}
		}, /*Сравнение на страницах "не магазина"*/

		checkboxes: function() {
			$('#orderForm input[name="personal_data"]').parents('label').next('a').appendTo($('#orderForm input[name="personal_data"]').parents('label'));
			
			$('.shop2-order-form input[type="checkbox"], .shop2-order-form input[type="radio"], .comments-block .tpl-field.checkbox input, .tpl-field-reg input, .gr-authorization-checkbox, .shop2-order-options.shop2-payment-options .payment_methods-column input[type="radio"], #orderForm input[name="personal_data"]').mgStyler();
			
			$('#orderForm .mg-styler-label--checkbox a').on('click', function(e){
				var $label = $(this).parent();
				var $input = $(this).parents('label').find('input');
				var href = $(this).attr('href');
				window.open(href, '_blank');
				
				if ($('.mg-styler-label--checkbox input').is(':checked')) {
					setTimeout(function(){
						$input.prop('checked', true);
						$label.addClass('checked');
					}, 10);
				} else {
					setTimeout(function(){
						$input.prop('checked', false);
						$label.removeClass('checked');
					}, 10);
				}
			});

			$(document).on('click', '.shop2-edost-variant > label', function(){
				if ($('.shop2-edost-variant > label > .shop2-edost-control input[type="radio"]:checked')) {
					$('.shop2-edost-variant > label > .shop2-edost-control').removeClass("active");
					$('.shop2-edost-variant > label > .shop2-edost-control input[type="radio"]:checked').parent().addClass('active');
				}
				
				if ($('.shop2-edost-office > label > .shop2-edost-control input[type="radio"]:checked')) {
					$('.shop2-edost-office > label > .shop2-edost-control').removeClass("active");
					$('.shop2-edost-office > label > .shop2-edost-control input[type="radio"]:checked').parent().addClass('active');
				}
			});

			$(document).on("click", ".shop2-edost-office > label", function(){
				if ($('.shop2-edost-office > label > .shop2-edost-control input[type="radio"]:checked')) {
					$('.shop2-edost-office > label > .shop2-edost-control').removeClass("active");
					$('.shop2-edost-office > label > .shop2-edost-control input[type="radio"]:checked').parent().addClass('active');
				}
			});
		}, /*Чекбоксы*/

		facetSelect: function() {
			$(document).on('click', '.shop-search-color-select li', function(){
				var $input = $(this).find('input');
				var value = $(this).data('value');

				if ($(this).hasClass('shop2-color-ext-selected')) {
					$input.val("");
					$(this).removeClass('shop2-color-ext-selected');
				} else {
					$(this).addClass('shop2-color-ext-selected');
					$input.val(value);
				}
				
				if (shop2.facets.enabled) {
					var url = '/my/s3/api/shop2/?cmd=getSearchMatches&hash=' +
				        shop2.apiHash.getSearchMatches +
				        '&ver_id=' + shop2.verId + '&',
				    	fullUrl = url + $(shop2.facets.search.wrapper).serialize();
				
					shop2.facets.getDataSearch(fullUrl);
				};
			});
			
			$(document).on('click', '.type-checkbox [data-name]', function(){
            	if (shop2.facets.enabled) {
                    var url = '/my/s3/api/shop2/?cmd=getSearchMatches&hash=' +
                        shop2.apiHash.getSearchMatches +
                        '&ver_id=' + shop2.verId + '&',
                        fullUrl = url + $(shop2.facets.search.wrapper).serialize();
                	
                    shop2.facets.getDataSearch(fullUrl);
                };
            });
		}, /*Допполя в фасетном поиске*/

		headerBlock: function() {
			
			console.log('Header!');
			
		}, /*Шапка*/

		footerBlock: function() {

			console.log('Footer!');

		}, /*Подвал*/
		
		recentBlock: function() {
		
			var sliderAutoplay = $('.recent-block__items').data("autoplay");
			var respSettings = {
				320: {controls: false,items: 1,gutter: 0},
				768: {controls: false,items: 2,gutter: 20},
				1024: {controls: false,items: 2,gutter: 20},
				1261: {controls: false,items: 3,gutter: 20},
				1341: {controls: true,items: 3,gutter: 20}
			};
	
			if ($('.recent-block__items').length>0) {
				var recentSlider = tns({
			        loop: true,
			        container: '.recent-block__items',
			        slideBy: 1,
			        autoplayHoverPause: true,
			        mode: "carousel",
			        axis: "horizontal",
			        autoplay: sliderAutoplay,
			        autoplayButtonOutput: false,
			        mouseDrag: true,
			        center: false,
			        autoWidth: false,
			        nav: true,
			        navPosition: "bottom",
			        controlsText: shop2_gr.settings.sliderControls,
			        preventActionWhenRunning: true,
			        responsive: respSettings
			    });
			};
			
			shop2_gr.methods.arrowsPosition('.recent-block__items', '.gr-recent-image');
			
		}, /*Недавно просмотренные товары*/
		
		sortingPanel : function() {

			$('.shop-view').on('click', '.shop-view__btn', function(){
				$(this).parents('.shop-view__inner').toggleClass('active');
			});

			$(document).on('click', function(e){
			    if (!$(e.target).closest('.shop-view .shop-view__btn').length) {
			    	$('.shop-view .shop-view__inner').removeClass('active');
			    };
			});

			/*$(document).on('click', '.sorting-button', function(){
				$('.sorting-block').addClass('active');
			});

			$(document).on('click', '.sorting-block__title', function(){
				$('.sorting-block').removeClass('active');
			});*/

			$('.sorting-block__body').on('click', function(){
				$(this).next().stop().slideToggle(250);
				$(this).parent().toggleClass('active');
			});

			shop2_gr.methods.viewLots();
			
		}, /*Сортировка и виды*/

		searchBlock: function() {

			$(document).on('click', '.search-form .row-title', function(){
				$(this).toggleClass('active');
				$(this).next().slideToggle(250);
			});
			
			function searchMoreFields() {
	            var hideText         = $('html').attr('lang') == 'ru' ? 'Свернуть' : 'Hide';
				var currentText  	 = $('html').attr('lang') == 'ru' ? shop2.my.gr_filter_select_btn || 'Показать ещё' : shop2.my.gr_filter_select_btn || 'Show more';
				
				$('.search-rows__row').each(function() {
		            var $this            = $(this);
		            var $btn             = $this.find('.gr-filter-more__btn');
		            
		            $btn.find('.gr-filter-more__text').text(currentText);
	
					$btn.off('click').on('click', function(){
			            var $hiddenCkeckbox  = $this.find('ul li:hidden');
	
			            $hiddenCkeckbox.addClass('hidden_item');
	
						if ($this.find('.hidden_item').hasClass('active')) {
							$btn.find('.gr-filter-more__text').text(currentText);
							$this.find('.hidden_item').removeClass('active');
						} else {
							$btn.find('.gr-filter-more__text').text(hideText);
							$this.find('.hidden_item').addClass('active');
						};
						
						setTimeout(function(){
							$('.search-rows__row').matchHeight();
						});
					});
				});
			};
			
			searchMoreFields();
			
			shop2.on('afterGetFolderCustomFields', function(){
				searchMoreFields();
				
				if (shop2.facets.enabled) {
					var url = '/my/s3/api/shop2/?cmd=getSearchMatches&hash=' +
				        shop2.apiHash.getSearchMatches +
				        '&ver_id=' + shop2.verId + '&',
				    	fullUrl = url + $(shop2.facets.search.wrapper).serialize();
				
					shop2.facets.getDataSearch(fullUrl);
				};
			});

		}, /*Поиск*/

		actionsBlock: function() {
			var actionEventName = 'mouseenter';
			if (isMobile) {
				actionEventName = 'click';
			};
			$(document).on(actionEventName, '.shop2-product-actions dt:not(.promo-action)', function(){
			    $('.shop2-product-actions dt').removeClass('dt_hover');
			    $('.shop2-product-actions dd').css('left', 'auto');

			    if (!isMobile) {
				    $(this).addClass('dt_hover');
				};

			    $(this).next().css('left', $(this).position().left);
			    $(this).next().css('top', $(this).position().top - $(this).next().outerHeight());

			    var nextLeft = $(this).next().offset().left;
			    var nextWidth = $(this).next().outerWidth();
			    var offsetSum = nextLeft + nextWidth;
			    var winWidth = $(window).width();

			    if ((offsetSum) > winWidth) {
			    	$(this).next().css('left', $(this).position().left - (offsetSum - winWidth))
			    }
			});

			$(document).on('mouseleave', '.shop2-product-actions dl', function(){
			    $('.shop2-product-actions dt').removeClass('dt_hover');
			    $('.shop2-product-actions dd').css('left', 'auto');
			});
			
			$(document).off('click.getPromoLink').off('click.promoPagelist');
			
			var gr_promo_info = {};

		    $(document).on('click', '.get-promo-link', function (e) {
			    e.preventDefault();
			    var ver_id = $(this).data('ver-id'),
			        cmd = $(this).data('cmd'),
			        hash = shop2.apiHash.getPromoProducts,
			        is_main = $(this).data('is-main'),
			        kind_id = $(this).data('kind-id'),
			        discount_id = $(this).data('discount-id');
			        
			    gr_promo_title = $(this).text(),
		        gr_promo_desc =  $(this).parents('.promo-action').find('.promo-action__text').html();
		        
		        var gr_images_size = $('.product-list').data('images-size');
    			var gr_images_view = $(".product-list").data("images-view");
    			
    			var url = '/my/s3/api/shop2/?ver_id=' + ver_id + '&cmd=' + cmd + '&hash=' + hash + '&kind_id=' + kind_id + '&discount_id=' + discount_id + '&is_main=' + is_main;
    			
    			if (gr_images_view){
			    	url += "&gr_images_view=" + gr_images_view;
			    };
			    
			    if (gr_images_size){
			    	url += "&gr_images_size=" + gr_images_size;
			    };
    			
		        
			    $.ajax({
			        url: url,
			        type: 'POST',
			        dataType: 'json',
			        data: {},
			        success: function (res) {
			            shop2.alert(res.data, 'Закрыть', 'promo-products-list');
			
			            setTimeout(function () {
			            	$('.promo-header__title').html(gr_promo_title);
			            	if (!gr_promo_desc) {
			            		$('.promo-header__desc').hide();
			            	};
			            	$('.promo-header__desc').html(gr_promo_desc);
			            	
			            	if (!$('.promo-products-list .shop-pagelist').length) {
			            		$('.promo-products-list .product-list.list .product-item:last-child').css('border-bottom', 'none');
			            	};
			            	
			            	$('.promo-products-list').click().addClass('custom-scroll scroll-width-thin scroll');
			            	$('.promo-products-list .product-item').each(function() {
								var $flags = $(this).find('.product-flags');
								var $flagsContainer = $(this).find('.product-item__bottom-left');
			
								$flags.prependTo($flagsContainer);
							});
			            
			                $('.product-list .gr_images_lazy_load').each(function () {
			                    $(this).attr('src', $(this).attr('data-src'));
			                });
			                
			                shop2_gr.methods.amountInit();
			            }, 100);
			        }
			    });
			    
			    return gr_promo_info = {
			    	gr_promo_title: gr_promo_title,
			    	gr_promo_desc: gr_promo_desc
			    }
			});
			
			$(document).on('click', '.promo-products-list li', function (e) {
			    e.preventDefault();
			    var url = $(this).find('a').attr('href');
			    
			    $.ajax({
			        url: url,
			        type: 'POST',
			        dataType: 'json',
			        data: {},
			        success: function (res) {
			            shop2.alert(res.data, 'Закрыть', 'promo-products-list');
			            
			            setTimeout(function () {
			            	$('.promo-header__title').html(gr_promo_info.gr_promo_title);
			            	if (!gr_promo_info.gr_promo_desc) {
			            		$('.promo-header__desc').hide();
			            	};
			            	$('.promo-header__desc').html(gr_promo_info.gr_promo_desc);
			            	
			            	$('.promo-products-list').click().addClass('custom-scroll scroll-width-thin scroll');
			            	$('.promo-products-list .product-item').each(function() {
								var $flags = $(this).find('.product-flags');
								var $flagsContainer = $(this).find('.product-item__bottom-left');
			
								$flags.prependTo($flagsContainer);
							});
			            
			                $('.product-list .gr_images_lazy_load').each(function () {
			                    $(this).attr('src', $(this).attr('data-src'));
			                });
			                shop2_gr.methods.amountInit();
			            }, 100);
			        }
			    });
			});

		}, /*Подарок/Акция*/
		
		filterBlock: function() {

			$('.shop2-filter__title').on('click', function(){
				$(this).toggleClass('active');
				$(this).next().slideToggle(250);
			});

			$('.shop2-filter__item').each(function() {
	            var $this            = $(this);
	            var $btn             = $this.find('.gr-filter-more__btn');
	            var hideText         = $('html').attr('lang') == 'ru' ? 'Свернуть' : 'Hide';

				$btn.on('click', function(){
		            var $hiddenCkeckbox  = $this.find('.shop2-filter__checkbox:hidden');
		            var $hiddenColor     = $this.find('.shop2-color-ext-list__item:hidden');
					var currentText  = $btn.data('text');

		            $hiddenCkeckbox.addClass('hidden_item');
		            $hiddenColor.addClass('hidden_item');

					if ($this.find('.hidden_item').hasClass('active')) {
						$btn.find('.gr-filter-more__text').text(currentText);
						$this.find('.hidden_item').removeClass('active');
					} else {
						$btn.find('.gr-filter-more__text').text(hideText);
						$this.find('.hidden_item').addClass('active');
					};
				});
			});

		}, /*Фильтр*/
		
		productsBlock: function() {

			$(document).on('click', '.gr-options-more__btn', function(){
				var $parent     = $(this).parents('.gr-product-options');
				var $params     = $parent.find('.gr-options-container');
				var currentText = $(this).data('text');
				var hideText    = $('html').attr('lang') == 'ru' ? 'Свернуть' : 'Hide';

				if ($(this).hasClass('active')) {
					$(this).removeClass('active');
					$(this).find('ins').text(currentText);
				} else {
					$(this).addClass('active');
					$(this).find('ins').text(hideText);
				};

				$params.stop().slideToggle(250);
			});

			$('.shop2-color-ext-select .shop2-color-ext-options').on('click', function() {
				if ($(this).closest('.shop2-color-ext-select').hasClass('active')) {
					$(this).closest('.shop2-color-ext-select').removeClass('active');
				} else {
					$(this).closest('.shop2-color-ext-select').addClass('active');
				}
			});

			$('#shop2-color-ext-select').on('click', function() {
				$('.shop2-color-ext-select').removeClass('active');
			});

			$(document).on('click', '.shop2-color-ext-select', function() {
				if ($(this).parents('.product-item').length>0) {
					$('#shop2-color-ext-select').addClass('product_item_color');
				}

				if ($(this).parents('.shop2-product').length>0) {
					$('#shop2-color-ext-select').addClass('shop_product_color');
				}
			});

			$(document).on('click', '#shop2-color-ext-select', function() {
				$(this).removeClass('product_item_color');
				$(this).removeClass('shop_product_color');
			});

			$(document).on('click', function(e){
			    if (!$(e.target).closest('#shop2-color-ext-select').length) {
			    	$('#shop2-color-ext-select').removeClass('product_item_color');
			    	$('#shop2-color-ext-select').removeClass('shop_product_color');
			    }
			});

		}, /*Товар*/
		
		cardPage: function(){
			
			if ($('.order-info-block').length) {
					if (!isMobile) {
					$('.order-info-block__title').hover(function(){
						$(this).next().show();	
						$('.order-info-block__popup').removeClass('right_popup');
						
						if ($(document).outerWidth() > $(window).outerWidth()) {
			                $(this).next().addClass('right_popup');
			            };
					}, function(e){
						$(this).next().hide();
						$('.order-info-block__popup').removeClass('right_popup');
					});
				} else {
					$('.order-info-block__title').on('click', function(){
						$('.order-info-block__popup').hide();
						$('.order-info-block__popup').removeClass('right_popup');
						$(this).next().show();
						
						if ($(document).outerWidth() > $(window).outerWidth()) {
			                $(this).next().addClass('right_popup');
			            };
					});
					
					$('.order-info-block__close').on('click', function(){
						$('.order-info-block__popup').hide();
						$('.order-info-block__popup').removeClass('right_popup');
					});
				};
			};

			var $cardHiddenOptions = $('.card-page .shop2-product .gr-product-options .option-item:hidden');
			
			if ($cardHiddenOptions.length>0) {
				$('.shop2-product .gr-product-options-more').addClass('show_more_btn');
			};

			$(document).on('click', '.card-page .shop2-product .gr-product-options-more__btn', function(){
				var currentText = $(this).data('text');
				var hideText    = $('html').attr('lang') == 'ru' ? 'Свернуть' : 'Hide';

				if ($(this).hasClass('active')) {
					$(this).removeClass('active');
					$(this).find('ins').text(currentText);
				} else {
					$(this).addClass('active');
					$(this).find('ins').text(hideText);
				};

				$cardHiddenOptions.stop().slideToggle(250);
			});


			if ($('.card-slider__thumbs-slider').length>0) {
	 			var vslider = tns({
				    container: '.card-slider__items-slider',
				    slideBy: 1,
				    mode: 'gallery',
				    axis: 'horizontal',
				    autoplay: false,
				    mouseDrag: true,
				    center: true,
				    autoWidth: false,
				    loop: false,
				    rewind: true,
				    preventActionWhenRunning: false,
				    nav: true,
				    lazyload: true,
				    swipeAngle: 50,
					navPosition: 'bottom',
				    controlsText: shop2_gr.settings.sliderControls,
                    responsive: {
                        320: {
                            controls: false,
				    		nav: true
                        },
                        768: {
                            controls: true,
				    		nav: true
                        }
                    }
			  	});

				var small_slider = tns({
					container: '.card-slider__thumbs-slider',
					loop: false,
					gutter: 10,
					center:false,
					mouseDrag: true,
					nav: false,
					controls: false,
					navPosition: 'bottom',
					preventActionWhenRunning: false,
					axis: 'horizontal',
                    responsive: {
                        320: {
                            items: 3
                        },
                        640: {
                            items: 3
                        },
                        768: {
                            items: 3
                        },
                        1024: {
                            items: 4
                        },
                        1261: {
                            items: 4
                        },
                        1340: {
                            items: 4
                        }
                    }
				});
				
				var navIndex = $('.card-slider__items .tns-nav-active').index();
	  			$('.card-slider__thumbs-slider .card-slider__thumb').removeClass('tns-nav-active');
	  			$('.card-slider__thumbs-slider .card-slider__thumb').eq(navIndex).addClass('tns-nav-active');
				
				vslider.events.on('indexChanged', function(){
		  			var navIndex = $('.card-slider__items .tns-nav-active').index();
		  			$('.card-slider__thumbs-slider .card-slider__thumb').removeClass('tns-nav-active');
		  			$('.card-slider__thumbs-slider .card-slider__thumb').eq(navIndex).addClass('tns-nav-active');

			  		/*if (vslider.getInfo().index>vslider.getInfo().indexCached) {
			  			//console.log('right')
			  		} else {
			  			//console.log('left')
			  		}*/
			  	});

			  	$(document).on('click', '.card-slider__thumbs-slider .card-slider__thumb', function(){
			  		var thisIndex = $(this).index();
			  		$('.card-slider__items .tns-nav button').eq(thisIndex).click();
			  	});

				vslider.events.on('indexChanged', function(){
					small_slider.goTo(vslider.getInfo().index);
			  	});
			};
			
			if (!isMobile && jQuery().zoom) {
				$('.gr-image-zoom').zoom({
					magnify: 1,
					duration: 10,
					onZoomIn: function(){
						$(this).parent().addClass('hide_small_pic');
					},
					onZoomOut: function(){
						$(this).parent().removeClass('hide_small_pic');
					},
					callback: function(){
						var $zoomImg = $(this);
						var containerHeight = $zoomImg.parent().outerHeight();
						var containerWidth = $zoomImg.parent().outerWidth();
						var zoomImgHeight = Math.floor($zoomImg.height());
						var zoomImgWidth = Math.floor($zoomImg.width());
						var floatHeight = Math.floor(20 * zoomImgHeight / 100);
						var floatWidth = Math.floor(20 * zoomImgWidth / 100);
						var prevWidth = Math.floor($(this).prev().outerWidth());
						var prevHeight = Math.floor($(this).prev().outerHeight());
						
						var zoomFloatHeight = zoomImgHeight + floatHeight;
						var zoomFloatWidth = zoomImgWidth + floatWidth;
						var finalHeight = prevHeight+floatHeight;
						var finalWidth = prevWidth+floatWidth;
						
						if (zoomFloatHeight<=prevHeight-floatHeight || zoomFloatWidth<=prevWidth-floatWidth) {
							$(this).parent().addClass('hide_big_pic');
						};
						
						if (zoomImgHeight<=prevHeight || zoomImgWidth <=prevWidth) {
							$zoomImg.css({
								'width': finalWidth,
								'height': finalHeight
							});
						}
						
						if (finalHeight<=containerHeight && finalWidth<=containerWidth) {
							$(this).parent().addClass('hide_zoom_pic');
						}
					}
				});
			};
			
			
			if (shop2.mode == 'product') {
				shop2_gr.methods.grLazyFunc({selector:'.shop-product-share'}, function(){
					var url_1 = 'https://yastatic.net/es5-shims/0.0.2/es5-shims.min.js';
					var url_2 = 'https://yastatic.net/share2/share.js';
					
					$('.shop-product-share').append('<script src="'+url_1+'"></script><script src="'+url_2+'"></script>');
					$('#product-yashare-noscript').remove();
			    });
			};

		}, /*Слайдер в карточке товара*/
		
		responsiveTabs: function() {
		    if ($('#product-tabs').length) {
			    $('.shop-product-data__nav li, .r-tabs-accordion-title').on('click', function(e){
					e.preventDefault();
					let href = $(this).find('a').attr('href');
					let $descArea = $(href);
					
					localStorage.setItem('gr_tab_href', href);
				
					if ($descArea.is(':hidden')) {
						$('.shop-product-data__nav li, .r-tabs-accordion-title').removeClass('r-tabs-state-active');
						$('.shop-product-data__desc .desc-area').stop().slideUp(300);
					};
					
					if (window.matchMedia("(min-width: 768px)").matches) {
						$('#product-tabs a[href="'+ href +'"]').parent().addClass('r-tabs-state-active');
						$descArea.stop().slideDown(300);
					} else {
						$('#product-tabs a[href="'+ href +'"]').parent().toggleClass('r-tabs-state-active');
						$descArea.stop().slideToggle(300);
						if ($('.r-tabs-accordion-title.r-tabs-state-active').length) {
							setTimeout(function(){
								$('html, body').stop().animate({
									scrollTop: $('.r-tabs-accordion-title.r-tabs-state-active').offset().top - 70	
								}, 500);
							}, 301);
						};
					};
				});
			};

		}, /*Табы*/
		
		commentsBlock: function() {
			$('.comments-form__btn').on('click', function(){
				$(this).next().slideToggle(200);	
			});
		}, /*Комментарии*/

		amountBlock: function() {
			var lazyAmount = false;
			
			shop2_gr.methods.grLazyFunc({selector:'.shop2-product-amount'}, function() {
				if (!lazyAmount) {
	                shop2_gr.methods.amountInit();
				};
                return lazyAmount = true;
            });
		}, /*Количество*/

		buyOneClick: function() {

			$(document).on('click', '.buy-one-click', function(e) {
				var productName = $(this).data('product-name');
				var productLink = $(this).data('product-link');
				var $this = $(this);
				
				if (shop2.mode == 'product' && $(this).parents('.kind-item').length<1) {
					var productAmount = $(this).parents('.shop2-product').find('.shop2-product-amount input').val();
				} else if ($('.product-quick-view').length>0 && $(this).parents('.kind-item').length<1) {
					var productAmount = $(this).parents('.shop2-product').find('.shop2-product-amount input').val();
				} else if ($(this).parents('.kind-item').length>0) {
					var productAmount = $(this).parents('.kind-item').find('.shop2-product-amount input').val();
				} else {
					var productAmount = $(this).parents('.shop2-product-item').find('.shop2-product-amount input').val();
				}
				
				$.ajax({
					url: $(this).data('api-url'),
					dataType: 'json',
					success: function(response) {
						if (!response.result.error) {
							
							$('.remodal[data-remodal-id="buy-one-click"] .tpl-anketa').remove();
							$(response.result.html).appendTo('.remodal[data-remodal-id="buy-one-click"]');
							if ($this.hasClass('product_info_form')) {
								var nameValue = productName;
							} else {
								var nameValue = productName  + ', количество - ' + productAmount;
							}
							
							$('.remodal[data-remodal-id="buy-one-click"] .tpl-field__product-link input').val(productLink);
							$('.remodal[data-remodal-id="buy-one-click"] .tpl-field__product-name input').val(nameValue);

							s3From.initForms($('.remodal[data-remodal-id="buy-one-click"]'), function(){
								$('.remodal[data-remodal-id="buy-one-click"] .tpl-field__product-link input').val(productLink);
								$('.remodal[data-remodal-id="buy-one-click"] .tpl-field__product-name input').val(nameValue);
							});
							grFormDatePicker.init();
							
						}
					}
				});
			});
						
		}, /*Купить в 1 клик*/
		
		cartPreview: function(){
			
			$(document).on('click', '.gr_order_one_page', function(e){
				eraseCookie('gr_delivery_scroll');
	    		createCookie('gr_delivery_scroll', 1, 30);
			});
			
			if (readCookie('gr_delivery_scroll') == '1') {
				eraseCookie('gr_delivery_scroll');
				
				setTimeout(function(){
					$('html, body').animate({
						scrollTop: $('.shop2-delivery').offset().top - 30
					}, 800);
				}, 1000);
			};
				
		}, /*Скролл на странице корзины до доставки*/

		cartPage: function() {

			$(document).on('click', '.cart-params__more-btn', function(){
				var $parent     = $(this).parents('.cart-params');
				var $params     = $parent.find('.cart-params__body');
				var currentText = $(this).data('text');
				var hideText    = $('html').attr('lang') == 'ru' ? 'Свернуть' : 'Hide';

				if ($(this).hasClass('active')) {
					$(this).removeClass('active');
					$(this).find('ins').text(currentText);
				} else {
					$(this).addClass('active');
					$(this).find('ins').text(hideText);
				};

				$params.stop().slideToggle(250);
			});


			if (shop2.mode=='cart') {
				$('.shop2-warning').prependTo('.cart-page__left');		
			};
			
			/*Автопересчет в корзине*/
			if (shop2.mode=='cart') {
				var cartURL = shop2.uri + "/cart",
			        ajax, hash, $idd,
			        shopCartDiv = $('.cart-page'),
			        cartPreloader = '<div class="gr-preloader-holder"><div class="gr-preloader"><svg xmlns="http://www.w3.org/2000/svg" width="34" height="26" viewBox="0 0 120 30" fill="#fff"><script xmlns=""></script> <circle cx="15" cy="15" r="15"> <animate attributeName="r" from="15" to="15" begin="0s" dur="0.8s" values="15;9;15" calcMode="linear" repeatCount="indefinite"></animate> <animate attributeName="fill-opacity" from="1" to="1" begin="0s" dur="0.8s" values="1;.5;1" calcMode="linear" repeatCount="indefinite"></animate> </circle> <circle cx="60" cy="15" r="9" fill-opacity="0.3"> <animate attributeName="r" from="9" to="9" begin="0s" dur="0.8s" values="9;15;9" calcMode="linear" repeatCount="indefinite"></animate> <animate attributeName="fill-opacity" from="0.5" to="0.5" begin="0s" dur="0.8s" values=".5;1;.5" calcMode="linear" repeatCount="indefinite"></animate> </circle> <circle cx="105" cy="15" r="15"> <animate attributeName="r" from="15" to="15" begin="0s" dur="0.8s" values="15;9;15" calcMode="linear" repeatCount="indefinite"></animate> <animate attributeName="fill-opacity" from="1" to="1" begin="0s" dur="0.8s" values="1;.5;1" calcMode="linear" repeatCount="indefinite"></animate> </circle></svg></div></div>';
			        
			    $('.shop2-order-form ~ .form-item.form-item-submit button.shop2-btn').append(cartPreloader);
			
			    $.get(cartURL + "?gethash=1", function(d) {
			        d = $.trim(d).replace(/<script[\s\S]*/, '');
			        d = $.trim(d).replace(/.*(\{[^}]*\})/g, "$1");
			        d = $.trim(d).replace(/<!--(.*?)-->/gm, "");
			        d = $.trim(d);
			        hash = JSON.parse(d);
			        shop2.on("afterCartAddItem", function(d, status) {
			            if (!d.errstr.length) {
			                getCart();
			            };
			        });
			    });
			    
			    $(document).on('click', '#shop2-color-ext-select li.param-value:not(.shop2-color-ext-selected)', function() {
					clearTimeout($idd);
			        $idd = setTimeout(updateForm, 500);
			        $('.shop2-cart-update').hide();
				});
			
			    function getCart(callback) {
			        if (ajax) ajax.abort();
			        ajax = $.ajax({
			            url: cartURL + "?cart_only=1",
			            async: true,
			            success: function(data) {
			            	var $shopWarning = $(data).filter('.shop2-warning').clone();

			                $('.cart-page__top').html($(data).find('.cart-page__top').html());
			                $('.cart-page__bottom').html($(data).find('.cart-page__bottom').html());
			                
			                $shopWarning.prependTo('.cart-page__left');
			                initCart(shopCartDiv);
			                
			                $('.shop2-order-form ~ .form-item.form-item-submit button.shop2-btn').removeClass('gr-preloader-active');
			                
			                if (typeof callback === 'function') {
			                	callback();
			                }
			            }
			        });
			    };
			    
			    function initDelivery() {
			    	if ($('.shop2-order-form ~ .form-item.form-item-submit button.shop2-btn').find('.gr-preloader-holder').length<1) {
			    		$('.shop2-order-form ~ .form-item.form-item-submit button.shop2-btn').append(cartPreloader);
			    	};
			    	
			    	/*Код из shop2.queue.cart*/
			    	$('#shop2-deligate-calc').on('click', function(e) {
					    var data = {},
					        delivery = $('#shop2-order-delivery'),
					        tabs = delivery.find('.shop2-delivery--item__tab');
					
					    $('#shop2-perfect-form').find('input, textearea, select').each(function() {
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
					
					    $.ajax({
					        url: '/my/s3/xapi/public/?method=deligate/calc&param[get_vars][]',
					        type: 'post',
					        dataType: 'json',
					        data: data,
					        success: function(result) {
					            delivery.removeClass('preloader');
					            $('#shop2-delivery-wait').hide();
					            $('#shop2-order-delivery').html(result.result.html);
					            $('#shop2-order-delivery').append('<div class="preloader"><div class="spinner"></div></div>');
					            $('#shop2-order-delivery').find('.delivery-items').each(function() {
					                var $this = $(this);
					                if ($.trim($this.text()) == "") {
					                    $this.parents('.shop2-delivery--item__tab:first').addClass('disabled');
					                }
					            });
					            if (result.result.error) {
					                shop2.alert(result.result.error);
					            } else {
					
					                var dadataJson = $.parseJSON($('#dadata').val()),
					                    coordsCenter = [dadataJson.geo_lat, dadataJson.geo_lon];
					
					                shop2.queue.edost2();
					                $('#shop2-ems-calc, #shop2-edost-calc').on('click', function(e) {
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
					
					                    shop2.delivery.calc(attach_id, 'to=' + to + '&zip=' + zip + '&order_value=' + order_value, function(d) {
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
					                    });
					
					                });
					                $('#shop2-deligate-calc').hide();
					            }
					        }
					    });
					});	
					/*Код из shop2.queue.cart*/
					
					/*Код из shop2.queue.delivery*/
					$('#shop2-order-delivery').find('.delivery-items').each(function() {
					    var $this = $(this);
					    if ($.trim($this.text()) == "") {
					        $this.parents('.shop2-delivery--item__tab:first').addClass('disabled');
					    }
					});
					$('#shop2-ems-calc, #shop2-edost-calc').on('click', function(e) {
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
					
					    shop2.delivery.calc(attach_id, 'to=' + to + '&zip=' + zip + '&order_value=' + order_value, function(d) {
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
					    });
					
					});
					/*Код из shop2.queue.delivery*/
			    };
			
			    function initCart($div) {
			        var $form = $div.find("#shop2-cart"),
			            $inp = $form.find("input:text"),
			            $item = $form.find(".cart-products__item"),
			            $recalc = $("a.shop2-cart-update"),
			            $minus = $form.find(".amount-minus"),
			            $plus = $form.find(".amount-plus");
			
			        if (!$form.length) return;
			        
			        shop2_gr.methods.amountInit();
			        
			        if (shop2.mode=='cart') {
						$('.shop2-warning').prependTo('.cart-page__left');		
					};
			        
			        $('.cart-total-checkout, .cart-total-order-checkout, .cart-registration-btn').append(cartPreloader);
			        
			        $('[data-remodal-id="cart-auth-remodal"]').remodal({
						hashTracking: false
					});
					
					$('[data-remodal-id="coupon-remodal"]').remodal({
						hashTracking: false
					});
			        
			        $('#shop2-cart .cart-delete a').off('click');
			        
			        $item.each(function(){
			        	var $del = $(this).find(".cart-delete a");
			        	var $input = $(this).find(".shop2-product-amount input");
			        	var $button = $(this).find(".shop2-product-amount button");
			        	var $select = $(this).find("select.param-value");
			        	
						
						$select.on('change', function() {
							clearTimeout($idd);
					        $idd = setTimeout(updateForm, 500);
					        $('.shop2-cart-update').hide();
						});
			        	
			        	$input.on('change', function() {
					        clearTimeout($idd);
				            $idd = setTimeout(updateForm, 1000);
				            $('.shop2-cart-update').hide();
				            
				            $('.cart-total-checkout, .cart-total-order-checkout, .cart-registration-btn, .shop2-order-form ~ .form-item.form-item-submit button.shop2-btn').addClass('gr-preloader-active');
					    });
					    
					    $button.on('click', function() {
					        clearTimeout($idd);
				            $idd = setTimeout(updateForm, 1000);
				            $('.shop2-cart-update').hide();
				            
				            $('.cart-total-checkout, .cart-total-order-checkout, .cart-registration-btn, .shop2-order-form ~ .form-item.form-item-submit button.shop2-btn').addClass('gr-preloader-active');
					    });
			        	
			        	$del.on("click", function(e) {
				        	var $this = $(this),
				                kind_id = $this.data('id');
				                
							e.preventDefault();
							
							$('.cart-total-checkout, .cart-total-order-checkout, .cart-registration-btn, .shop2-order-form ~ .form-item.form-item-submit button.shop2-btn').addClass('gr-preloader-active');
				
				            kind_id = kind_id.toString().replace(/\"/g, '\\"').replace(/\'/g, '"');
				            kind_id = $.parseJSON(kind_id);
				
				            shop2.trigger('beforeCartRemoveItem');
				
				            $.ajax({
				                url: '/my/s3/api/shop2/?cmd=cartRemoveItem',
				                async: true,
				                dataType: "json",
				                data: {
				                    hash: hash.del,
				                    ver_id: shop2.verId,
				                    kind_id: kind_id
				                },
				                success: function (d, status) {
				                    sessionStorage.setItem('cart-reload', 1);
				                    getCart();
				                    setTimeout(function(){
				                    	$('.gr-cart-total-amount').text($('#shop2-cart').data('cart-amount') || '0');
				                    }, 1100);
				                    
				                    if (d.data.cart.length == 0) {
										document.location = shop2.uri + "?mode=cart&action=cleanup";
				                    };
				                }
				            });
				
				            return false;
				        });
			        });
			
			        $recalc.on("click", function(e) {
			            e.preventDefault();
			            updateForm();
			            return false;
			        });
			        
			        
			        shop2.on('afterCartAddCoupon, afterCartRemoveCoupon', function() {
					    document.location.reload();
					});
					
					$('.coupon-btn').on('click', function(e) {
					    var coupon = $('#coupon'),
					        code = coupon.val();
					
					    e.preventDefault();
					
					    if (code) {
					        shop2.cart.addCoupon(code);
					    }
					});
					
					
					$('.coupon-delete').on('click', function(e) {
					    var $this = $(this),
					        code = $this.data('code');
					
					    e.preventDefault();
					
					    if (code) {
					        shop2.cart.removeCoupon(code);
					    }
					});
			    };
			    
			    function updateForm() {
		        	var data = $("#shop2-cart").serialize();
		        	
		            shop2.trigger('beforeCartUpdate');
		
		            $.ajax({
		                type: "POST",
		                url: 
		                '/my/s3/api/shop2/?cmd=cartUpdate' +
		                '&ver_id=' + shop2.verId +
		                '&hash=' + hash.up +
		                '&' + data,
		                async: true,
		                success: function (d, status) {
		                    sessionStorage.setItem('cart-reload', 1);
		                    getCart(function(){
		                    	$('.gr-cart-total-amount').text($('#shop2-cart').data('cart-amount') || '0');
			                    $('.gr-cart-total-sum ins').text($('.last_item .cart-total__body').data('total-price'));
		                    });
		                    shop2.trigger('afterCartUpdated');
		                    initDelivery();
		                }
		            });
		
		            return false;
		        };
			    
			    initCart(shopCartDiv);
			};
		    /*Автопересчет в корзине*/
		    
		    $('.cart-products__item').each(function(){
			    if ($(this).find('.amount-min').length) {
			        $(this).find('.cart-sum').css('margin-top', $(this).find('.amount-min').outerHeight(true))
			    };
			});
			
			var cart_amount_min_timeout;

		    $(window).on('resize', function() {
		        if (cart_amount_min_timeout) {
		            clearTimeout(cart_amount_min_timeout);
		        };

		        cart_amount_min_timeout = setTimeout(function() {
		            $('.cart-products__item').each(function(){
					    if ($(this).find('.amount-min').length) {
					        $(this).find('.cart-sum').css('margin-top', $(this).find('.amount-min').outerHeight(true))
					    };
					});
		        }, 50);
		    });
			
		}, /*Корзина*/

		lightGallery: function() {
			if ($('.card-slider__items').length) {
				$('.card-slider__items').lightGallery({
					thumbnail: false,
				    download: false,
				    loop: false,
				    counter: false,
				    getCaptionFromTitleOrAlt: true,
					selector: '.card-slider__image a'
			    });
			};
			
			if ($('.gr_cart_param_img').length) {
			    $('.gr_cart_param_img').lightGallery({
					thumbnail: false,
				    download: false,
				    loop: false,
				    counter: false,
				    getCaptionFromTitleOrAlt: true,
					selector: 'a'
			    });
			};

		}, /*Галерея*/

		toolTips: function(){
			if (!isMobile) {
		    	$('.shop-view .shop-view__item.thumbs').elemToolTip({
			    	position: 'top',
			    	text: 'Витрина',
			    	margin: 12
			    });
			    
			    $('.shop-view .shop-view__item.simple').elemToolTip({
			    	position: 'top',
			    	text: 'Простой',
			    	margin: 12
			    });
	
			    $('.shop-view .shop-view__item.pricelist').elemToolTip({
			    	position: 'top',
			    	text: 'Прайс-лист',
			    	margin: 12
			    });
	
			    $('.quick-view-trigger').elemToolTip({
			    	position: 'top',
			    	text: 'Быстрый просмотр',
			    	margin: 12
			    });
			};
		}, /*Тултипы*/

		alignElements : function() {
			window.addEventListener('orientationchange', function() {
				setTimeout(function(){
					$.fn.matchHeight._update();
				}, 300);
			}, false);
				    
			var lazyFuncTime, lazyFuncScroll = false;
			
			if ($(window).scrollTop()>0) {
				if (lazyFuncTime) {
		            clearTimeout(lazyFuncTime);
		        };

		        lazyFuncTime = setTimeout(function() {
		        	if (!lazyFuncScroll) {
						shop2_gr.methods.grLazyFunc({selector:'.product-list.thumbs'}, function(){
							if (!$('.main-blocks').length) {
								$('.product-list.thumbs .product-price').matchHeight('remove');
								$('.product-list.thumbs .product-price').matchHeight();
							};
					    });
		        	};
		        	
		        	return lazyFuncScroll = true;
		        }, 50);
			};
			
			$(window).on('scroll', function() {
		        if (lazyFuncTime) {
		            clearTimeout(lazyFuncTime);
		        };

		        lazyFuncTime = setTimeout(function() {
		        	if (!lazyFuncScroll) {
						shop2_gr.methods.grLazyFunc({selector:'.product-list.thumbs'}, function(){
							if (!$('.main-blocks').length) {
						    	$('.product-list.thumbs .product-price').matchHeight('remove');
								$('.product-list.thumbs .product-price').matchHeight();
							};
					    });
		        	};
		        	
		        	return lazyFuncScroll = true;
		        }, 50);
		        
		        return lazyFuncScroll;
		    });

		    
		    shop2_gr.methods.grLazyFunc({selector:'.mods_block'}, function(){
				$('.mods_block .kinds-block__items .kind-item__top').matchHeight();
				$('.mods_block .kinds-block__items .kind-additional').matchHeight();
				$('.mods_block .kinds-block__items .kind-price').matchHeight();
		    });
		}, /*Выравнивание блоков по высоте*/

		otherScripts : function() {
			if ($('table').length) {
				$('table').wrap('<div class="table-wrapper"></div>');
			};
			if (shop2.facets.enabled && $('.shop2-filter').length) {
				shop2.filter.count();
			};
			
			$('body').removeClass('gr_hide_onload');

			// Нажатие на клавишу Esc
				$(document).on('keyup.esc_keyup', function(keyUp){
				    if (keyUp.keyCode 
				    	== 27) {
				    		$('html').removeClass('overflowHidden');
							$('.sorting-block').removeClass('active');
							$('.shop2-color-ext-select').removeClass('active');
							$('.gr-favorite-popup').removeClass('opened');
							$('#shop2-alert-ok').trigger('click');
				        return false;
				    };
				});
			// Нажатие на клавишу Esc

		    // Клик по документу
			$(document).on('click', function(e){
				if (!$(e.target).closest('.price-old.question, .shop2-cart-total .question').length) {
			    	$('.shop2-product-discount-desc').hide();
			    };
			    
			    if (!$(e.target).closest('.sorting-block').length && !$(e.target).closest('.sorting-button').length) {
			    	$('.sorting-block').removeClass('active');
			    };

			    if (!$(e.target).closest('.shop2-color-ext-select .shop2-color-ext-options, #shop2-color-ext-select').length) {
			    	$('.shop2-color-ext-select').removeClass('active');
			    };

			    setTimeout(function(){
			    	$('#shop2-alert-ok').html('<span><svg class="gr-svg-icon gr_big_icon"><use xlink:href="#icon_site_close"></use></svg><svg class="gr-svg-icon"><use xlink:href="#icon_site_close_small"></use></svg><svg class="gr-svg-icon gr_small_icon"><use xlink:href="#icon_site_close_mini"></use></svg></span>');
			    }, 250)
			});
		    // Клик по документу

		    shop2_gr.methods.changeFlagsColor();
		    
		    shop2_gr.methods.grLazyLoad();
		    
		    if (readCookie('rootMarginCookie')) {
		    	shop2_gr.methods.grLazyLoad({
			    	selector: 'gr_lazy_load_block',
			    	margin: '10px'
			    });
		    } else {
			    shop2_gr.methods.grLazyLoad({
			    	selector: 'gr_lazy_load_block'
			    });
		    };
		    if (!readCookie('rootMarginCookie')) {
		    	createCookie('rootMarginCookie', 1, 1); // Создаем куку, чтобы увеличить расстояние, при котором появляются блоки
		    }; 
		    
		    jQuery.event.special.touchstart = {
		        setup: function( _, ns, handle ){
		            this.addEventListener("touchstart", handle, { passive: true });
		        }
		    };
		    
		    jQuery.event.special.touchend = {
		        setup: function( _, ns, handle ){
		            this.addEventListener("touchend", handle, { passive: true });
		        }
		    };
		    
		    jQuery.event.special.touchmove = {
		        setup: function( _, ns, handle ){
		            this.addEventListener("touchmove", handle, { passive: true });
		        }
		    };
		} /*Разное*/


	};
	
	shop2_gr.settings = {
		imageObserver: null,
		searchIcon: '<i class="search-block__icon"><svg class="gr-svg-icon"><use xlink:href="#icon_shop_search"></use></svg></i>',
		sliderControls: ['<svg class="gr-svg-icon"><use xlink:href="#icon_shop_slider_prev"></use></svg><svg class="gr-svg-icon gr_small_icon"><use xlink:href="#icon_shop_slider_prev_small"></use></svg>', '<svg class="gr-svg-icon"><use xlink:href="#icon_shop_slider_next"></use></svg><svg class="gr-svg-icon gr_small_icon"><use xlink:href="#icon_shop_slider_next_small"></use></svg>']
	};

	shop2_gr.methods = {
		grLazyFunc: function(params, callback) {
			var elem = params.selector;
			var margin = '10px';
			
			if (params.margin) {
				margin = params.margin
			}
			
			let options = {
	            rootMargin: margin
	        };
	        
	        const imageObserver = new IntersectionObserver((entries, imgObserver) => {
	            entries.forEach((entry) => {
	                if (entry.isIntersecting) {
	                    const lazyItem = entry.target // Текущий элемент
	                    
	                    if (callback) {
	                    	callback();
	                    };
	                    
	                    imgObserver.unobserve(lazyItem);
	                }
	            })
	        }, options);
			
			if (typeof elem == 'object') {
		        imageObserver.observe(elem);
			} else {
				if (document.querySelector(elem)!=null) {
					if (document.querySelectorAll(elem).length>1) {
						const arr = document.querySelectorAll(elem);
			            arr.forEach((v) => {
			                imageObserver.observe(v);
			            });
					} else {
						imageObserver.observe(document.querySelector(elem));
					}
				}
			}
		}, /*Отложенная загрузка скрипта*/
		
		grLazyLoad: function(params) {
			var elem = 'gr_images_lazy_load';
			var margin = '10px';

			if (params) {
				if (params.selector) {
					elem = params.selector;	
				};
				
				if (params.margin) {
					margin = params.margin;	
				};
			};
			
	        let options = {
	            rootMargin: margin
	        };
	        shop2_gr.settings.imageObserver = new IntersectionObserver((entries, imgObserver) => {
	            entries.forEach((entry) => {
	                if (entry.isIntersecting) {
	                    const lazyImage = entry.target // Текущий элемент
	                    
	                    if (lazyImage.tagName == 'IMG') { // для обычных картинок
	                        if (lazyImage.dataset.srcset) {
	                            // Чтобы загружать картинки маленьких размеров с помощью srcset
	                            lazyImage.srcset = lazyImage.dataset.srcset // Адрес картинки data-srcset=""
	                            lazyImage.classList.remove(elem);
	                            imgObserver.unobserve(lazyImage);
	                        } else {
	                            lazyImage.src = lazyImage.dataset.src // Адрес картинки data-src=""
	                            lazyImage.classList.remove(elem); 
	                            imgObserver.unobserve(lazyImage); 
	                        }
	                    } else if (lazyImage.dataset.bg) {
	                        if (window.innerWidth <= 768 && lazyImage.dataset.minbg) {
	                            lazyImage.style.backgroundImage = 'url(' + lazyImage.dataset.minbg + ')';
	                            lazyImage.classList.remove(elem);
	                            imgObserver.unobserve(lazyImage);
	                        } else {
	                            lazyImage.style.backgroundImage = 'url(' + lazyImage.dataset.bg + ')';
	                            lazyImage.classList.remove(elem);
	                            imgObserver.unobserve(lazyImage);
	                        }
	                    } else if (lazyImage.dataset.func) { // Если элемент содержит data-func
	                        if (typeof shop2_gr.methods[lazyImage.dataset.func] == 'function') {
	                            shop2_gr.methods[lazyImage.dataset.func](lazyImage); // Вызов функции
	                            lazyImage.classList.remove(elem);
	                            imgObserver.unobserve(lazyImage);
	                        }
	                    } else {
	                        lazyImage.classList.remove(elem);
	                        imgObserver.unobserve(lazyImage);
	                    }
	                }
	            })
	        }, options);

	        const arr = document.querySelectorAll('.' + elem);
	        
            arr.forEach((v) => {
                shop2_gr.settings.imageObserver.observe(v);
            });
		}, /*Отложенная загрузка*/
		
		forEach: function(array, callback, scope) {
			for (var i = 0; i < array.length; i++) {
		        callback.call(scope, i, array[i]);
		    };
		}, /*Для тини слайдера*/
		
		changeFlagsColor: function(){
			$('.product-flags__item.custom_item span').each(function(){
		    	if ($(this).data('custom-bg')) {
				    var custom_bg = shop2_gr.methods.grConvertToRgb($(this).data('custom-bg'));
				    var text_color = Math.round(((parseInt(custom_bg[0]) * 299) + (parseInt(custom_bg[1]) * 587) + (parseInt(custom_bg[2]) * 114)) /1000);
				    
				    if(text_color > 140) {
				        $(this).css('color', '#000');
				    }else{ 
				        $(this).css('color', '#fff');
				    };
		    	};
			});	
		}, /*Перекраска цвета текста кастомных флагов*/
		
		mainBlocks: function(lazyElem) {
			if ($('.main-products').length) {
				$('.product-list').removeClass('simple').removeClass('list').addClass('thumbs');
				
				var slider = lazyElem.querySelector('.main_blocks_list');
				var main_items = slider.getAttribute('data-main-items');
				var respSettings = {};
				
				var gr_images_size = slider.dataset["imagesSize"];	
			    var gr_images_view = slider.dataset["imagesView"];
			    var gr_mode_catalog = slider.dataset["modeCatalog"];
			    var url = '/my/s3/xapi/public/?method=shop2/getProductsBySearchMatches';
			    
			    if (gr_images_view){
			    	url += "&gr_images_view=" + gr_images_view;
			    };
			    
			    if (gr_images_size){
			    	url += "&gr_images_size=" + gr_images_size;
			    };
			    
			    if (gr_mode_catalog){
			    	url += "&gr_mode_catalog=" + gr_mode_catalog;
			    };
			    
				if (main_items == 5) {
					var main_items_1280 = 5,main_items_1024 = 4,main_items_768 = 3,main_items_320 = 2;
				} else if (main_items == 4) {
					var main_items_1280 = 4,main_items_1024 = 4,main_items_768 = 3,main_items_320 = 2;
				} else if (main_items == 3) {
					var main_items_1280 = 3,main_items_1024 = 3,main_items_768 = 3,main_items_320 = 2;
				} else if (main_items == 2) {
					var main_items_1280 = 2,main_items_1024 = 2,main_items_768 = 2,main_items_320 = 2;
				};

				respSettings = {
					320: {controls: false,items: main_items_320,gutter: 12},
					768: {controls: false,items: main_items_768,gutter: 20},
					1024: {controls: false,items: main_items_1024,gutter: 20},
					1261: {controls: true,items: main_items_1280,gutter: 20},
					1341: {controls: true,items: main_items_1280,gutter: 20}
				};
	            
	            if ($(slider).length) {
	            	var sliderAutoplay = +slider.getAttribute('data-autoplay');
	                var multislider = tns({
	                    loop: false,
	                    rewind: true,
	                    container: slider,
	                    slideBy: 1,
	                    autoplayHoverPause: true,
	                    mode: 'carousel',
	                    axis: 'horizontal',
	                    autoplay: sliderAutoplay,
	                    autoplayButtonOutput: false,
	                    mouseDrag: true,
	                    center: false,
	                    autoWidth: false,
	                    nav: true,
	                    swipeAngle: 50,
						controlsText: shop2_gr.settings.sliderControls,
	                    navPosition: 'bottom',
	                    preventActionWhenRunning: false,
	                    responsive: respSettings
	                });
	                
		            setTimeout(function(){
		            	shop2_gr.methods.arrowsPosition($(lazyElem).find('.main_blocks_list'), '.gr-product-image');
		            	if (!shop2.my.gr_main_blocks_ajax) {
			            	$(lazyElem).addClass('main_products_loaded');
			            }
		            }, 10);
		            
		            if (shop2.my.gr_main_blocks_ajax) {
		            	var empty_products = slider.querySelectorAll('.gr_empty_product');
		                var active_products = slider.querySelectorAll('.tns-slide-active');
		                var active_array = [];
		                
		                Array.prototype.forEach.call(active_products, function(item, i){
							active_array[i] = item.dataset['mainProductId'];
						});
						
						shop2_gr.methods.getMainProducts(url, active_array, empty_products, function(){
							shop2_gr.methods.arrowsPosition($(lazyElem).find('.main_blocks_list'), '.gr-product-image');
							
		    				shop2_gr.methods.changeFlagsColor();
		    				
							setTimeout(function(){
				                $(lazyElem).find('.product-item__bottom').matchHeight('remove');
								$(lazyElem).find('.product-item__bottom-left').matchHeight('remove');
				                $(lazyElem).find('.product-item__bottom-right').matchHeight('remove');
				                $(lazyElem).find('.product-price').matchHeight('remove');
				                
				                $(lazyElem).find('.product-item__bottom').matchHeight();
				                $(lazyElem).find('.product-item__bottom-left').matchHeight();
				                $(lazyElem).find('.product-item__bottom-right').matchHeight();
				                $(lazyElem).find('.product-price').matchHeight();
							}, 300);
		    				
							$(slider).find('.gr_images_lazy_load').each(function(){
							    $(this).attr('src', $(this).attr('data-src'));
							});
							$(lazyElem).addClass('main_products_loaded');
							$(slider).find('.buy-one-click').attr('data-api-url', $(slider).data('popup-form'));
							$(slider).find('.buy-one-click.product_info_form').attr('data-api-url', $(slider).data('info-popup-form'));
							shop2_gr.methods.viewLots($(lazyElem).find('.product-list'));
	                		shop2_gr.methods.amountInit($(lazyElem).find('.shop2-product-item'));
	                		
	                		
	                		if (!isMobile) {
		                		$(lazyElem).find('.quick-view-trigger').elemToolTip({
							    	text: 'Быстрый просмотр',
							    	margin: 12
							    });
	                		};
						});
		            
		            
			            function slider_handler(current_slider) {
			            	if (!current_slider.container.classList.contains('all_products_done')) {
				            	var simple_products = current_slider.container.querySelectorAll('.gr_empty_product');
				            	
				            	if (simple_products[0]) {
				            		var active_array = [];
								                
					                Array.prototype.forEach.call(simple_products, function(simple_product, i){
										active_array[i] = simple_product.dataset['mainProductId'];
									});
									
									shop2_gr.methods.getMainProducts(url, active_array, simple_products, function(){
										shop2_gr.methods.arrowsPosition($(current_slider.container).find('.main_blocks_list'), '.gr-product-image');
										
										$(current_slider.container).find('.gr_images_lazy_load').each(function(){
										    $(this).attr('src', $(this).attr('data-src'));
										});
										$(lazyElem).addClass('main_products_loaded');
										$(current_slider.container).find('.buy-one-click').attr('data-api-url', $(current_slider.container).data('popup-form'));
										$(current_slider.container).find('.buy-one-click.product_info_form').attr('data-api-url', $(current_slider.container).data('info-popup-form'));
										shop2_gr.methods.viewLots($(current_slider.container).find('.product-list'));
				                		shop2_gr.methods.amountInit($(current_slider.container).find('.shop2-product-item'));
				                		
				                		if (!isMobile) {
					                		$(current_slider.container).find('.quick-view-trigger').elemToolTip({
										    	text: 'Быстрый просмотр',
										    	margin: 12
										    });
				                		};
				                		
				                		shop2_gr.methods.changeFlagsColor();
		                				
		                				setTimeout(function(){
		                					$(current_slider.container).find('.product-item__bottom').matchHeight('remove');
		                					$(current_slider.container).find('.product-item__bottom-left').matchHeight('remove');
					                		$(current_slider.container).find('.product-item__bottom-right').matchHeight('remove');
		                					$(current_slider.container).find('.product-price').matchHeight('remove');
		                					
		                					$(current_slider.container).find('.product-item__bottom').matchHeight();
					                		$(current_slider.container).find('.product-item__bottom-left').matchHeight();
					                		$(current_slider.container).find('.product-item__bottom-right').matchHeight();
		                					$(current_slider.container).find('.product-price').matchHeight();
		                				}, 300);
									});
									
									current_slider.container.classList.add('all_products_done');
				            	};
			            	} else {
			            		return;
			            	};
			            };
			            
			            
			            
			            multislider.events.on('indexChanged', slider_handler);
		                multislider.events.on('newBreakpointEnd', slider_handler);
		            };
		            
		            if (!shop2.my.gr_main_blocks_ajax) {
			            shop2_gr.methods.grLazyFunc({selector:lazyElem}, function() {
	    					$(lazyElem).find('.product-item__bottom').matchHeight('remove');
			                $(lazyElem).find('.product-item__bottom-left').matchHeight('remove');
	                		$(lazyElem).find('.product-item__bottom-right').matchHeight('remove');
	    					$(lazyElem).find('.product-price').matchHeight('remove');
	    					
	    					$(lazyElem).find('.product-item__bottom').matchHeight();
	                		$(lazyElem).find('.product-item__bottom-left').matchHeight();
	                		$(lazyElem).find('.product-item__bottom-right').matchHeight();
	    					$(lazyElem).find('.product-price').matchHeight();
			            });
		            };
	                
		            var mainLazyFuncTime, mainLazyFuncScroll = false;
					$(window).on('scroll', function() {
					    if (mainLazyFuncTime) {
					        clearTimeout(mainLazyFuncTime);
					    };
					    mainLazyFuncTime = setTimeout(function() {
					        if (!mainLazyFuncScroll) {
					            shop2_gr.methods.grLazyFunc({selector:lazyElem}, function() {
                					$(lazyElem).find('.product-item__bottom').matchHeight('remove');
					                $(lazyElem).find('.product-item__bottom-left').matchHeight('remove');
			                		$(lazyElem).find('.product-item__bottom-right').matchHeight('remove');
                					$(lazyElem).find('.product-price').matchHeight('remove');
                					
                					$(lazyElem).find('.product-item__bottom').matchHeight();
			                		$(lazyElem).find('.product-item__bottom-left').matchHeight();
			                		$(lazyElem).find('.product-item__bottom-right').matchHeight();
                					$(lazyElem).find('.product-price').matchHeight();
					            });
					        };
					
					        return mainLazyFuncScroll = true;
					    }, 50);
					    return mainLazyFuncScroll;
					});
	            };
			};
		}, /*Блоки на главной*/
		
		kindsBlock: function(lazyElem) {

			if ($('.kinds-block__items.kinds_slider').length>0) {
				var slider = lazyElem.querySelector('.kinds-block__items.kinds_slider');
				var kind_items = slider.getAttribute('data-kind-items');
			    var respSettings = {};
			
				if (kind_items == 5) {
					var kind_items_1280 = 5,kind_items_1024 = 4,kind_items_768 = 3,kind_items_320 = 2;
				} else if (kind_items == 4) {
					var kind_items_1280 = 4,kind_items_1024 = 4,kind_items_768 = 3,kind_items_320 = 2;
				} else if (kind_items == 3) {
					var kind_items_1280 = 3,kind_items_1024 = 3,kind_items_768 = 3,kind_items_320 = 2;
				} else if (kind_items == 2) {
					var kind_items_1280 = 2,kind_items_1024 = 2,kind_items_768 = 2,kind_items_320 = 2;
				}
			
				respSettings = {
					320: {controls: false,items: kind_items_320,gutter: 12},
					768: {controls: false,items: kind_items_768,gutter: 20},
					1024: {controls: false,items: kind_items_1024,gutter: 20},
					1261: {controls: true,items: kind_items_1280,gutter: 20},
					1341: {controls: true,items: kind_items_1280,gutter: 20}
				};
			
			    if ($(slider).length) {
				    var sliderAutoplay = +slider.getAttribute('data-autoplay');
			
				    var multislider = tns({
			            loop: false,
			            rewind: true,
			            container: slider,
			            slideBy: 1,
			            autoplayHoverPause: true,
			            mode: 'carousel',
			            axis: 'horizontal',
			            autoplay: sliderAutoplay,
			            autoplayButtonOutput: false,
			            mouseDrag: true,
			            center: false,
			            autoWidth: false,
			            nav: true,
			            swipeAngle: 50,
						controlsText: shop2_gr.settings.sliderControls,
			            navPosition: 'bottom',
			            preventActionWhenRunning: false,
			            responsive: respSettings
			        });
			
			         setTimeout(function(){
			        	shop2_gr.methods.arrowsPosition($(lazyElem).find('.kinds-block__items.kinds_slider'), '.kind-image');
			        }, 10);
				    
				    var kindLazyFuncTime, kindLazyFuncScroll = false;
				    
				    if ($(window).scrollTop()>0) {
				    	if (kindLazyFuncTime) {
					        clearTimeout(kindLazyFuncTime);
					    };
					    kindLazyFuncTime = setTimeout(function() {
					        if (!kindLazyFuncScroll) {
					        	if (readCookie('rootMarginCookie')) {
								    shop2_gr.methods.grLazyFunc({selector:lazyElem, margin: '200px'}, function() {
								    	
								    	setTimeout(function(){
								    		$(lazyElem).find('.kinds-block__items.kinds_slider .kind-item__top').matchHeight('remove');
											$(lazyElem).find('.kinds-block__items.kinds_slider .kind-item__bottom').matchHeight('remove');
											$(lazyElem).find('.kinds-block__items.kinds_slider .kind-price').matchHeight('remove');
											
							                $(lazyElem).find('.kinds-block__items.kinds_slider .kind-item__top').matchHeight();
											$(lazyElem).find('.kinds-block__items.kinds_slider .kind-item__bottom').matchHeight();
											$(lazyElem).find('.kinds-block__items.kinds_slider .kind-price').matchHeight();
								    	}, 300);
						            });
							    } else {
							        shop2_gr.methods.grLazyFunc({selector:lazyElem}, function() {
						                setTimeout(function(){
						                	$(lazyElem).find('.kinds-block__items.kinds_slider .kind-item__top').matchHeight('remove');
											$(lazyElem).find('.kinds-block__items.kinds_slider .kind-item__bottom').matchHeight('remove');
											$(lazyElem).find('.kinds-block__items.kinds_slider .kind-price').matchHeight('remove');
						                	
							                $(lazyElem).find('.kinds-block__items.kinds_slider .kind-item__top').matchHeight();
											$(lazyElem).find('.kinds-block__items.kinds_slider .kind-item__bottom').matchHeight();
											$(lazyElem).find('.kinds-block__items.kinds_slider .kind-price').matchHeight();
								    	}, 300);
						            });
							    };
					        };
					
					        return kindLazyFuncScroll = true;
					    }, 50);
				    };
				};
			};

		}, /*Коллекции*/
		
		getMainProducts: function (url, active_array_id, empty_products, callback){
			$.ajax({
				url: url,
				dataType: "JSON",
				data: {
					param: {
						s: {
							product_id: active_array_id
						},
						limit: (active_array_id.length + 1),
						template: "global:shop2.2.130-product-list.tpl"
					}
				},
				error: (error) => {
					alert(error);
					console.warn(error);
					return false;
				},
				success: (response) => {
					if( response.error ){
						console.warn('Ошибка аякса: ', response);
					}else if (response.result.success) {
						var gr_has_compare = typeof gr_compare_kind_id;
						$(response.result.html).find('.shop2-product-item').each(function(){
							var _this_item = this;
							var id_product = _this_item.querySelector('[name="product_id"]').value;
							Array.prototype.forEach.call(empty_products, function(item, i){
								if( +item.dataset['mainProductId'] == +id_product ){
									item.innerHTML = '';
									item.appendChild(_this_item.cloneNode(true));
									
									if (gr_has_compare!='undefined' && gr_compare_kind_id[item.querySelector('[name="kind_id"]').value]) {
										product_compare = item.querySelector('.product-compare');
										product_compare.classList.add( 'product-compare-added' );
										product_compare.innerHTML = `<label class="gr-compare-checkbox">
										<svg class="gr-svg-icon"><use xlink:href="#icon_shop_compare_added"></use></svg>
										<svg class="gr-svg-icon gr_small_icon"><use xlink:href="#icon_shop_compare_added_small"></use></svg>
							<input type="checkbox" value="`+item.querySelector('[name="kind_id"]').value+`" checked="true" autocomplete="off"></label>
		<a class="link-reset custom-underlined-link" data-remodal-target="compare-preview-popup" href="/magazin/compare" target="_blank">Cравнить&nbsp;<span>`+Object.keys(gr_compare_kind_id).length+`</span></a>
				</div>`;
									};
									item.classList.remove('gr_empty_product');
								};
							});
						});
						
						if (callback) {
							callback();
						};
					}
				}
			});
		}, /*Получение товаров на главной*/
		
		grConvertToRgb: function(hexCode){
		    var hex = hexCode.replace('#','');
	
		    if (hex.length === 3) {
		        hex = hex[0] + hex[0] + hex[1] + hex[1] + hex[2] + hex[2];
		    }
	
		    var r = parseInt(hex.substring(0,2), 16),
		        g = parseInt(hex.substring(2,4), 16),
		        b = parseInt(hex.substring(4,6), 16);
	
		    return [r,g,b];
		}, /*Конвертация HEX в RGB*/

		viewLots: function(elem) {
			if (elem) {
				var $productList 		= $(elem);
				var	$productItem 		= $productList.find('.product-item');
				var loadedValue = $('.shop-view__item.active-view').data('value');
			} else {
				var $productList 		= $('.product-list');
				var	$productItem 		= $('.product-item');
				var loadedValue = $('.shop-view__item.active-view').data('value');
			};
			
			if ( loadedValue == 'thumbs' ) {
				$('.product-list-titles').addClass('hide');

				$productItem.each(function() {
					var $flags = $(this).find('.product-flags');
					var $flagsContainer = $(this).find('.product-item__top');

					$flags.appendTo($flagsContainer);
				});
			} else if ( loadedValue == 'simple' ) {
				$('.product-list-titles').addClass('hide');

				$productItem.each(function() {
					var $flags = $(this).find('.product-flags');
					var $flagsContainer = $(this).find('.product-item__top');

					$flags.appendTo($flagsContainer);
				});
			} else if ( loadedValue == 'list' ) {
				$('.product-list-titles').removeClass('hide');

				$productItem.each(function() {
					var $flags = $(this).find('.product-flags');
					var $flagsContainer = $(this).find('.product-item__bottom-left');

					$flags.prependTo($flagsContainer);
				});
			};

			$('.shop-view .shop-view__item').on('click', function(e) {
				var $this 			= $(this),
					value 			= $this.data('value');

				if ( value == 'thumbs' ) {
					$('.product-list-titles').addClass('hide');

					$productItem.each(function() {
						var $flags = $(this).find('.product-flags');
						var $flagsContainer = $(this).find('.product-item__top');

						$flags.appendTo($flagsContainer);
					});
				} else if ( value == 'simple' ) {
					$('.product-list-titles').addClass('hide');

					$productItem.each(function() {
						var $flags = $(this).find('.product-flags');
						var $flagsContainer = $(this).find('.product-item__top');

						$flags.appendTo($flagsContainer);
					});
				} else if ( value == 'list' ) {
					$('.product-list-titles').removeClass('hide');

					$productItem.each(function() {
						var $flags = $(this).find('.product-flags');
						var $flagsContainer = $(this).find('.product-item__bottom-left');

						$flags.prependTo($flagsContainer);
					});
				};

				$this
					.addClass('active-view')
					.siblings()
					.removeClass('active-view');

				if ($productList.length>0) {
					$productList
						.removeClass($productList.attr('class').replace( /[a-zA-Z0-9_-]+(?=\s)/, "" ))
						.addClass(value);
				};

				$(this).parents('.shop-view__inner').removeClass('active');
				
				createCookie('views', value, 30);

				setTimeout(function() {
			 		$.fn.matchHeight._update();
				}, 300);
				
				e.preventDefault();

				return false;
			});
		}, /*Преключение видов отображения товаров в категории*/

		amountInit: function(elem) {
			var items = '.cart-products__item, .shop2-product-item, .shop2-product, .kind-item, .popup-product';
			if (elem) {
				var items = elem;
			};
			$(items).each(function() {
				var $this       = $(this);
				var $amountWrap = $this.find('.shop2-product-amount');
				var $input      = $amountWrap.find('input[type="text"]');
				var $buttons    = $amountWrap.find('button');
				var $minus      = $amountWrap.find('button.amount-minus');
				var $plus       = $amountWrap.find('button.amount-plus');
				var min 		= $amountWrap.find('input').data('min');
				var inputVal    = +$input.val();
				

				if (inputVal<=min) {
					$minus.attr('disabled', 'disabled');
				}
				
				$buttons.on('click', function(){
					var parent = $(this).parent();
					var input  = parent.find('input');

					setTimeout(function(){
						var inputVal = +input.val();
						
						if (inputVal<=min) {
							$minus.attr('disabled', 'disabled');
						} else {
							$minus.removeAttr('disabled');
						}
					}, 100);
				});
				
				$input.on('change', function(e) {
		        	var curVal = +$(this).val();
		        	
		        	if (curVal < min) {
		        		$(this).val(min);
		        	} else if (curVal == min) {
		        		$minus.attr('disabled', 'disabled');
		        	} else if (curVal > min) {
		        		$minus.removeAttr('disabled');
		        	}
		        });
			});
		}, /*Количество*/

		arrowsPosition: function(slider, item) {
			if ($(slider).length){
			    var arrows_timeout;
			    
			    $(slider).each(function() {
			        var $this = $(this);
			        var $image = $this.find(item);
			        var $controls = $this.parents('.tns-outer').find('.tns-controls');

					if ($image.parents('form').length) {
						var paddingTop = $image.offset().top - $image.parents('form').offset().top;
			        	var imgHeight = ($image.outerHeight() + paddingTop) - ($image.outerHeight() / 2);
					} else {
			        	var imgHeight = $image.outerHeight() / 2;
					};
			        
			        $controls.css({
			            "top": imgHeight
			        });
			    });
	
			    $(window).on('resize', function() {
			        if (arrows_timeout) {
			            clearTimeout(arrows_timeout);
			        };
	
			        arrows_timeout = setTimeout(function() {
			            $(slider).each(function() {
			                var $this = $(this);
			                var $image = $this.find(item);
			                var $controls = $this.parents('.tns-outer').find('.tns-controls');

			                if ($image.parents('form').length) {
								var paddingTop = $image.offset().top - $image.parents('form').offset().top;
								var imgHeight = ($image.outerHeight() + paddingTop) - ($image.outerHeight() / 2);
							} else {
								var imgHeight = $image.outerHeight() / 2;
							};
	
			                $controls.css({
			                    "top": imgHeight
			                });
			            });
			        }, 50);
			    });
			};
		}, /*Позиционирование навигации слайдера относительно блоков*/

	}

	shop2_gr.init();
	myObject.shop2_gr = shop2_gr;

})(jQuery, window);