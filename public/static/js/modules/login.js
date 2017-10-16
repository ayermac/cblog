/**
 * Created by Jason on 2017/7/2.
 */
layui.use('form', function(){
    var form = layui.form
        ,layer = layui.layer;

    //监听登录
    form.on('submit(login)', function(data){
        var btn = $(this).button('loading');
        var index;
        $.ajax({
            url: data.form.action,
            type: data.form.method,
            data: data.field,
            beforeSend: function() {
                index = layer.load(2);
            },
            success: function (info) {
                if (info.code === 1) {
                    setTimeout(function () {
                        location.href = info.url;
                    }, 1000);
                } else {
                    btn.button('reset');
                }
                $('.captcha').attr('src', '/captcha.html?time='+Math.random());
                layer.msg(info.msg);
                layer.close(index);
            }
        });

        return false;
    });
});
