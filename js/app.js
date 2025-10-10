function initApp(){
    deleteCookieLogin();
    dicountHelper.preInit();
    searchHelper.preInit();
    rating.init();
    $(".order-addressess a").click( function () {
        $(this).find(".orderBox").addClass("active");
    });
}
function evenDown() {
    $(".down-showAll").click(function () {
        $(this).text("Méně");
        $(this).removeClass("down-showAll");
        $(this).addClass("up-hide");
        $(this).parent(".cbx-left-filters").find(".vl-box-body ul li").each(function () {
            $(this).show()
        });
        eventUp()
    })
}
function eventUp() {
    $(".up-hide").click(function () {
        $(this).addClass("down-showAll");
        $(this).removeClass("up-hide");
        $(this).text("Další");
        addHeightFilter($(this).parent(".cbx-left-filters"));
        evenDown()
    })
}
function addHeightFilter(filter) {

    var a = 0;
    $(filter.find(".vl-box-body ul li").get()).each( function (item) {

        if( $(this).find("input").attr("checked") ) {
            a++;

            var $this = $(this);
            $this.insertBefore($this.siblings(':eq(0)'));
        } else {
            if(item > 3) {
                $(this).hide();
            }
        }
    });

    if(filter.find(".vl-box-body ul li").length > 4 && filter.find(".vl-box-body ul li").length != a ) {
        filter.find(".down-showAll").remove();
        filter.append('<span class="btn btn-basic btn-sm down-showAll">Další</span>');
    }

    function getCookie() {
        let matches = document.cookie.match(new RegExp(
            "([^;]*)=userid=([^;]*)"
        ));
        return matches ? decodeURIComponent(matches[1]) : undefined;
    }

    function delete_cookie(name) {
        if(name){
            document.cookie = name +'=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
        }
    }

    $("._logout").click(function(e){
        e.preventDefault();
        delete_cookie(getCookie());
        window.location = $(this).attr("href");
    })

}
function deleteCookieLogin() {

    function getCookie() {
        let matches = document.cookie.match(new RegExp(
            "([^;]*)=userid=([^;]*)"
        ));
        return matches ? decodeURIComponent(matches[1]) : undefined;
    }

    function delete_cookie(name) {
        if(name){
            document.cookie = name +'=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
        }
    }

    $("._logout").click(function(e){
        e.preventDefault();
        delete_cookie(getCookie());
        window.location = $(this).attr("href");
    })

}
function OdbZaokrouhleniAllFce(num, zaokrouhleni, zaokr_mista) {
    var rad = 0;
    var mnozstvi = 0;
    var delka = 0;
    switch (zaokr_mista) { case 9: rad = 100000; break; case 8: rad = 10000; break; case 7: rad = 1000; break; case 6: rad = 100; break; case 5: rad = 10; break; case 4: rad = 1; break; case 3: rad = .1; break; case 2: rad = .01; break; case 1: rad = .001; break; case 0: rad = .0001; break; };
    mnozstvi = (Math.abs(num) / rad).toFixed(4);
    if (rad > 0)
        delka = rad.toString().length - 1;

    if (zaokrouhleni == 0) {
        mnozstvi = Math.ceil(mnozstvi);
    }
    else if (zaokrouhleni == 1) {
        mnozstvi = Math.floor(mnozstvi);
    }
    else {
        mnozstvi = Math.round(mnozstvi);
    }
    return (Math.sign(num) * mnozstvi * rad).toFixed(delka);
}

/* Rating products */
var rating = {
    init: function() {

        $(".rating").each(function(){

            if( $(this).find(".ratingStar").length == 0 ) {
                const count = $(this).attr("date-star");

                $(this).addClass("ratingADD");

                for(let i = 0; i < count; i++ ) {
                    const span = document.createElement("span");
                    span.setAttribute("class", "ratingStar emptyRatingStar numberStar" + i);
                    span.setAttribute("data-numb", i);
                    $(this).append(span);
                }

            }

        });

        rating.events();
    },
    events: function() {
        $(".ratingStar").click( function() {

            var number = parseInt($(this).attr("data-numb"));

            $(this).parent(".rating").find(".ratingStar").each(function () {
                $(this).removeClass("filledRatingStar").addClass("emptyRatingStar");
            });

            for(let i = 0; i <= number; i++ ) {
                $(".numberStar" + i).removeClass("emptyRatingStar").addClass("filledRatingStar");
            }

            $(this).parent(".rating").find("input").val( number+1 );
        })

    }

}

/* IQ search list off search text in items, nomenclatures */
var nameClass = "._iqSearch";
var searchHelper = {
    preInit: function(){
        $(".iqSearch a").click( function () {
            window.location = $(this).attr("href");
        });

        if( $(nameClass).length > 0 ) {

            $("#search input[type='text']").keyup(function () {
                if( $(this).val().length > 0 ){
                    searchHelper.init( $(this).val() );
                }
            });

            $("#search input[type='submit']").click(function () {
                if( $("#search input[type='text']").val().length > 0 ){
                    $("#ctl00_ZasShopBodyPlaceHolder_UpdateProgress1").show();
                }
            });

            $("#search input[type='text']").keyup(function () {

                if( $(this).val().length > 0 ){
                    searchHelper.init( $(this).val() );
                }
            });

            $("#search input[type='text']").change(function () {
                if( $(this).val().length > 0 ){
                    searchHelper.init( $(this).val() );
                }
            });

            var template = "<div id='iqSearch'></div>";
            $(nameClass).append(template);
        }

        $("body").click( function () {
            $("#iqSearch").hide();
        })

        // On resume search page add text
        searchHelper.initResumeSearch();
    },
    init: function ( search ) {

        this.ajaxCall( "ft_txt=" + search, true);

    },
    initResumeSearch: function() {
        if( $("div[data-result-count='0']").length ) {
            this.ajaxCallTypo( $(".search-result-expr").text().replace(/"/g, "") , true);
        }
    },
    finish: function( data ){
        if(data.result[1].nomenklatura_items.nomenklatura_item.nazev) {
            $("div[data-result-count='0']").append( "<a href='/Search/cs-CZ/0/" + data.result[1].nomenklatura_items.nomenklatura_item.nazev + "'>" + $("div[data-result-count='0']").attr("data-noresult-text").replace("{0}", data.result[1].nomenklatura_items.nomenklatura_item.nazev) + "</a>");
        } else if(data.result[0].items.item.nazev) {
            $("div[data-result-count='0']").append( "<a href='/Search/cs-CZ/0/" + data.result[0].items.item.nazev + "'>" + $("div[data-result-count='0']").attr("data-noresult-text").replace("{0}", data.result[0].items.item.nazev) + "</a>");
        }
        $(".main-page-description").removeClass("hidden-xs");

    },
    initAddText: function(){
        $(".no_url").click( function () {
            $("#search .keyword").val( $(this).text() ).trigger("change");
        });
    },
    ajaxCallTypo: function (data_send, async) {

        $.ajax({
            url: "/ZasShopServicePage.aspx/&page-command=CHECK_SPELLING&text=" + data_send,
            async: async,
            success: function(data) {
                data = JSON.parse(data);
                if( data.root.results ) {
                    searchHelper.finish( data.root.results );
                }
            },
            error: function(msg) {
                console.debug(msg);
            },
            complete: function() {

            }
        });

    },
    ajaxCall: function (data_send, async) {

        $.ajax({
            url: "/ZasShopServicePage.aspx/&command=GET_FULLTEXT_RESULT&" + data_send,
            async: async,
            success: function(data) {
                data = JSON.parse(data);
                if(data.root.results) {
                    searchHelper.resultFormat(data.root.results.result);
                }
            },
            error: function(msg) {
                console.debug(msg);
            },
            complete: function() {

            }
        });

    },
    addItem: function( item ) {

        let a = document.createElement("a");
        let li = document.createElement("li");
        li.textContent = item.nazev;

        if( item.web_items_url ) {
            a.setAttribute("href", item.web_items_url);
        } else {
            a.setAttribute("class", "no_url");
        }

        if (item.pic_url) {
            let img = document.createElement("img");
            img.setAttribute("src", item.pic_url);
            img.setAttribute("class", "img");
            a.appendChild(img);
        }

        a.append(item.nazev);
        li.innerHTML = "";
        li.append(a);

        return li;

    },
    resultFormat: function(data) {

        let div = document.createElement("div");
        div.setAttribute('class', 'sectionAll');

        $.each( data,function () {

            let section = document.createElement("div");
            section.setAttribute('class', 'section');

            if( this.description ) {
                let spanMain = document.createElement('span');
                spanMain.setAttribute("class", "groupBlock");
                let span = document.createElement('span');
                span.setAttribute("class", "name");
                span.textContent = this.description;
                spanMain.appendChild(span);
                section.appendChild(spanMain);
            }

            let ul = document.createElement("ul");
            let itemsNode = false;
            if( this.items ) {
                itemsNode = this.items.item;
            } else if( this.nomenklatura_items ) {
                itemsNode = this.nomenklatura_items.nomenklatura_item;
            }

            if( itemsNode ) {
                if( itemsNode.length) {
                    $.each( itemsNode, function ( element, item ) {

                        let itemNode = searchHelper.addItem(item);
                        ul.appendChild(itemNode);

                    });
                } else {

                    let itemNode = searchHelper.addItem(itemsNode);
                    ul.appendChild(itemNode);

                }
            }

            section.appendChild(ul);
            div.appendChild(section);

        })

        let iqSearch = document.getElementById("iqSearch");
        iqSearch.innerHTML = "";
        iqSearch.append(div);

        let addAll = document.createElement("div");
        addAll.setAttribute("class", "addAll");
        addAll.setAttribute("onclick", '$("#search .button").trigger("click");');
        addAll.textContent = "Zobrazit všechny výsledky";

        iqSearch.append(addAll);

        if( $("#search input[type='text']").is(':focus') ) {
            $("#iqSearch").show();
        }

        $(".addAll").click( function () {
            $("#search .button").trigger("click");
        });

        searchHelper.initAddText();

    }
}

/* discount code - check exist discount code */
var dicountHelper = {
    preInit: function() {
        var discount = $(".RegFormDiscount input");
        discount.change( function (event) {
            event.preventDefault();
            dicountHelper.init();
        });
        discount.keydown( function (event) {
            if (event.keyCode == 13) {
                event.preventDefault();
                dicountHelper.init();
            }
        });

        if( $(".discountCodeContainer").val() ) {
            if( $(".discountCodeContainer").val().length > 0 ) {
                dicountHelper.init(true);
            }
        }
    },
    init: function (start) {
        $(".message_discount").hide();
        var value = "";

        if( start ) {
            $(".discountOk").remove();
            value = dicountHelper.removeUnique($(".discountCodeContainer").val());

        } else {
            value = dicountHelper.removeUnique($(".discountCode").val());
        }

        if( value.indexOf(",") >= 0 ) {
            value = value.split(',');
            $.each( value, function (el, item) {
                if( item.length > 0){
                    dicountHelper.ajaxCall(item);
                }
            });
        } else {
            dicountHelper.ajaxCall(value);
        }
    },
    removeUnique: function( value ) {
        value = value.split(',').filter(function(item,i,allItems){
            return i==allItems.indexOf(item);
        }).join(',');
        return value;
    },
    ajaxCall: function (data_send, async) {

        $.ajax({
            url: "/ZasShopServicePage.aspx/&command=CHECK_SL_KOD&sl_kod=" + data_send,
            async: async,
            success: function(data) {
                data = JSON.parse(data);
                if(data.root.is_ok == 1) {
                    dicountHelper.resultFinish( data_send );
                } else {
                    dicountHelper.resultFinishBadCode( data_send );
                }
            },
            error: function(msg) {
                console.debug(msg);
            },
            complete: function() {

            }
        });

    },
    initDiscountOk: function() {
        $(".discountOk .close").click( function () {
            var text = $(this).parent(".discountOk").text().replace("x", "");

            $(".discountCodeContainer").val( $(".discountCodeContainer").val().replace( text + ", ", "").replace( text, ""));

            $(this).parent(".discountOk").remove();
        });
    },
    generateDiv: function(value){

        let div = document.createElement("div");
        div.setAttribute("class", "discountOk");
        div.setAttribute("data", value.toUpperCase());
        div.innerText = value;
        let span = document.createElement("span");
        span.setAttribute("class", "close");
        span.innerText = "x";
        div.append(span);
        $(".RegFormDiscount").append(div);
    },
    resultFinish: function (value) {

        value = value.toUpperCase();
        var oldValue = $(".discountCodeContainer").val();
        if( value.indexOf(oldValue) < 1 ) {

            var newValue = oldValue + "," + value;
            $(".discountCode").val("");

            newValue = newValue.split(',').filter(function(item,i,allItems){
                return i==allItems.indexOf(item);
            }).join(',');


            $(".discountCodeContainer").val( newValue );

            if( $(".discountOk[data='" + value.toUpperCase() + "']").length <= 0 ) {
                dicountHelper.generateDiv(value);
            }
            dicountHelper.initDiscountOk();

        }


    },
    resultFinishBadCode: function (value) {
        $(".message_discount").show();
    }

}

$(document).ready(function() {
    initApp();
    evenDown();
    eventUp();

    $(".cbx-left-filters").each( function() {
        addHeightFilter( $(this) );
    });
    setTimeout( function () {
        $(".cbx-left-filters").each( function() {
            addHeightFilter( $(this) );
        });
        evenDown();
        eventUp();
    }, 1000)

    // Mobile menus
    $(".js-mobile-btn").click(function(e) {
        e.preventDefault();
        $(this).toggleClass("btn-basic");
        $("." + $(this).data("target")).toggleClass("hidden-xs");
    });

    // Mobile categories
    $(".left-menu > ul > li.has-submenu > span").click(function(e) {
        e.preventDefault();
        var parent = $(this).parent(".has-submenu");
        if(parent.hasClass("active")) {
            parent.removeClass("active");
        } else {
            parent.toggleClass("submenu-is-opened");
        }
    });


    // Hide buttons
    // - main description of page
    if(!$(".main-page-description").length) {
        $(".js-btn-description").hide();
    }
    if(!$(".custom-search-box").length) {
        $(".js-btn-filter").hide();
    }

    // Cart advanced buttons
    $(".js-btn-cart-advanced").click(function(e) {
        e.preventDefault();
        $(".cart-advanced-buttons").toggle();
    });

    // Admin bar
    $("#log-show-body").click(function(e) {
        e.preventDefault();
        $(".log-admin").toggleClass("log-body-opened");
    });

    // Keyword
    $('.keyword').bind('keyup', function (e) {
        var key = e.keyCode || e.which;
        if (key === 13) {
            $(this).siblings('.button').trigger('click');
        };
    });

    // Esc close popup
    document.onkeydown = function (evt) {
        evt = evt || window.event;
        var isEscape = false;
        if ("key" in evt) {
            isEscape = (evt.key == "Escape" || evt.key == "Esc");
        } else {
            isEscape = (evt.keyCode == 27);
        }
        if (isEscape) {
            $(".modal").prev().andSelf().hide();
        }
    };

    $(".user-popup-message").each(function () {
        var title = $(this).data('title');

        if ($(this).data('error'))
            title = '<span class="fa fa-times-circle fa-2x" '
                + 'style="vertical-align:middle;color:#e10000;">'
                + '</span>&nbsp' + title;
        alertify.alert(title, $(this).html());
        return false;
    });
    $(".user-popup-info").each(function () {
        var notification = alertify.notify($(this).html(), 'success', 5, function () { if (1 == 2) console.log('dismissed'); });
        return false;
    });

    //zaokrouhlovani
    $(".tb-quantity").change(function () {
        ModifyQuantity($(this));
        return true;
    });
    $(".tb-quantity").each(function () {
        ModifyQuantity($(this));
        return true;
    });

    function ModifyQuantity(obj) {
        var mj_zaokrouhleni = obj.data('mj_zaokrouhleni');
        var mj_zaokr_mista = obj.data('mj_zaokr_mista');
        var num = obj.val().replace(',', '.');

        if (mj_zaokrouhleni != null && mj_zaokr_mista != null) {
            if (!isNaN(mj_zaokr_mista) && !isNaN(mj_zaokrouhleni) && !isNaN(num) && mj_zaokr_mista != "" && mj_zaokrouhleni != "" && num != "") {
                num = OdbZaokrouhleniAllFce(num, mj_zaokrouhleni, mj_zaokr_mista);
                obj.val(num);
            }
        }
    }
});

Sys.WebForms.PageRequestManager.getInstance().add_endRequest(initApp);