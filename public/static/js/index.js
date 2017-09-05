var init_load = {
    init: function () {
        this.pjax_init();//初始化pjax
        this.backToTop();//返回到顶部
    },
    pjax_init: function () {
        if ($.support.pjax) {
            $(document).on('pjax:start', function () {
                NProgress.start();
            });
            $(document).on('pjax:end', function () {
                NProgress.done();
            });
            document.addEventListener('DOMContentLoaded', function () {
                if ($.support.pjax) {
                    $(document).pjax('a', '#content-container', {
                        fragment: '#content-container',
                        timeout: 8000,
                        dataType: null
                    });
                }
            });
        }
    },
    backToTop: function () {
        var blogScrollTop = $('.scroll-top'),
            blogWindow = $(window),
            isMobile = function(){
                return ( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) )
            }();

        blogWindow.scroll(function () {
            if ($(this).scrollTop() > 250) {
                blogScrollTop.fadeIn();
            } else {
                blogScrollTop.fadeOut();
            }
        });

        // blogScrollTop.on('click', function (e) {
        //     e.preventDefault();
        //     $('html, body').animate({scrollTop: 0}, 500);
        //     return false;
        // });
    }
};
$(document).ready(function(){
    NProgress.start();
});
$(window).load(function(){
    NProgress.done();
});

init_load.init();

