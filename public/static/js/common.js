/**
 * Created by Jason on 2017/7/3.
 */
/**
 *公用的js函数
 */

/**
 * 加载nprogress
 */
$(document).ready(function(){
    NProgress.start();
});
$(window).load(function(){
    NProgress.done();
});

/**
 * 初始化pjax
 */
function pjax_init(){
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
        $(document).on('submit', 'form[data-pjax]',function(event) {
            $.pjax.submit(event, '#content-container', {
                fragment: '#content-container',
                timeout: 8000,
                dataType: null
            });
        });
    }
}
pjax_init();

/**
 * 创建dom element,暂时只支持创建js和css
 * @param type
 * @param url
 */
function create_element(type, url){
    var head = document.head || document.getElementsByTagName('head')[0];
    var element = '';
    if(type == 'js'){
        element = document.createElement('script');
        element.type = 'text/javascript';
        element.src = url;
    }
    else if(type == 'css'){
        element = document.createElement('link');
        element.href = url;
        element.rel = 'stylesheet';
        element.type = 'text/css';
    }
    head.appendChild(element);
}

$(function(){
    layui.use(['layer'], function() {
        var layer = layui.layer
            , load;
        /**
         * 清除缓存
         */
        $(".refresh").on('click', function () {
            var _url = $(this).attr('data-url');
            $.ajax({
                url: _url,
                type: 'post',
                beforeSend: function(){
                    load = layer.load(2);
                },
                success: function (info) {
                    if (info.code === 1) {
                        swal({
                            title: info.msg,
                            text: "",
                            type: "success"
                        }).then(function () {
                            setTimeout(function () {
                                location.href = info.url;
                            }, 500);
                        });
                    } else {
                        swal(info.msg, "", "warning");
                    }
                    layer.close(load);
                }
            });
        });
    });
});