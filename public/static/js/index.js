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
    }
}
// 如果不想要pjax效果可以把下面注释
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