/**
 * Created by Jason on 2017/7/4.
 */
/**
 项目JS主入口
 以依赖Layui的layer和form模块为例
 **/
layui.use(['layer', 'form', 'element', 'laydate'], function(){
    var layer    = layui.layer
        ,form    = layui.form
        ,element = layui.element
        ,laydate = layui.laydate
        ,tips;

    //设置sweetAlert全局默认参数
    swal.setDefaults({
        allowOutsideClick: false,
        allowEscapeKey: false,
        allowEnterKey: false
    });

    /**
     * 通用日期时间选择
     */
    laydate.render({
        elem: '#datetime',
        type: 'datetime'
    });

    //全选
    form.on('checkbox(allChoose)', function(data){
        var child = $(data.elem).parents('table').find('tbody td:first-child input[type="checkbox"]');
        child.each(function(index, item){
            item.checked = data.elem.checked;
        });
        form.render('checkbox');
    });
    form.render();
    /**
     * 通用批量操作
     */
    $(".batch-action").on('click', function(){
        var _url      = $(this).attr('href');
        var chk_value =[],
            load;
        $('input[name="ids"]:checked').each(function(){
            chk_value.push($(this).val());
        });
        if(chk_value == '') {
            layer.msg('请先选择一项再进行操作');
        } else {
            layer.open({
                shade: false,
                content: '确定执行此操作？',
                btn: ['确定', '取消'],
                yes: function (index) {
                    $.ajax({
                        url: _url,
                        data: {'ids': chk_value},
                        beforeSend: function() {
                          load = layer.load(2);
                        },
                        success: function (info) {
                            if (info.code === 1) {
                                swal({
                                    title: info.msg,
                                    text: "",
                                    type: "success"
                                }).then(function() {
                                    //setTimeout(function () {
                                    //    location.href = info.url;
                                    //}, 500);
                                    $.pjax.reload('#content-container', {
                                        fragment: '#content-container',
                                        timeout: 8000,
                                        dataType: null
                                    });
                                });
                            } else {
                                swal(info.msg, "", "warning");
                            }
                            //layer.msg(info.msg);
                            layer.close(load);
                        },
                        error: function () {
                            layer.msg('HTTP ERROR', function () {});
                        }
                    });
                    layer.close(index);
                }
            });
        }
    });

    /**
     * 通用表单提交(AJAX方式)
     */
    form.on('submit(*)', function (data) {
        var btn      = $(this).button('loading');
        var isreload = $(this).attr('isreload'); //判断是否重新加载页面
        var index;

        $.ajax({
            url: data.form.action,
            type: data.form.method,
            data: $(data.form).serialize(),
            beforeSend: function() {
                index = layer.load(2);
            },
            success: function (info) {
                if (info.code === 1) {
                    swal({
                        title: info.msg,
                        text: "",
                        type: "success"
                    }).then(function() {
                        if (isreload) {
                            setTimeout(function () {
                                location.href = info.url;
                            }, 500);
                        } else {
                            $.pjax.reload('#content-container', {
                                fragment: '#content-container',
                                timeout: 8000,
                                dataType: null
                            });
                        }
                    });
                } else {
                    swal(info.msg, "", "warning");
                    btn.button('reset');
                }
                layer.close(index);
            },
            error: function () {
                layer.msg('HTTP ERROR', function () {});
            }
        });
        return false;
    });


    /**
     *通用开关
     */
    form.on('switch(status)', function(data){
        var index
            ,_id = data.value
            ,_name = data.elem.name
            ,_url = $(data.elem).attr('data-url')
            ,_status;
        var isreload = $(data.elem).attr('isreload');

        data.elem.checked ? _status='1' : _status='0';

        $.ajax({
            url: _url,
            type: 'post',
            data: { 'status': _status, 'id': _id},
            beforeSend: function() {
                index = layer.load(2);
            },
            success: function (info) {
                if (info.code === 1) {
                    swal({
                        title: info.msg,
                        text: "",
                        type: "success"
                    }).then(function() {
                        if (isreload) {
                            setTimeout(function () {
                                location.href = info.url;
                            }, 500);
                        } else {
                            $.pjax.reload('#content-container', {
                                fragment: '#content-container',
                                timeout: 8000,
                                dataType: null
                            });
                        }
                    });
                } else {
                    swal(info.msg, "", "warning");
                    _status == 0 ? data.elem.checked = true : data.elem.checked = false;
                    form.render('checkbox');
                }
                layer.close(index);
            },
            error: function () {
                layer.msg('HTTP ERROR', function () {});
            }
        });
    });

    /**
     * 通用列表排序
     */
    $(".list-sorting").on('click', function(){
        var sorting    = $(this).parents('table').find('tbody input[name="sort"]');
        var sort_input = [],
            _url       = $(this).attr('data-url'),
            index;
        var isreload = $(this).attr('isreload');

        sorting.each(function(index,item) {
            if(!isNaN(item.value)) {
                sort_input.push([$(item).attr('data-id'), item.value]);
            }
        });

        $.ajax({
            url: _url,
            type: 'post',
            data: {'sort': sort_input},
            beforeSend: function() {
                index = layer.load(2);
            },
            success: function (info) {
                if (info.code === 1) {
                    swal({
                        title: info.msg,
                        text: "",
                        type: "success"
                    }).then(function() {
                        if (isreload) {
                            setTimeout(function () {
                                location.href = info.url;
                            }, 500);
                        } else {
                            $.pjax.reload('#content-container', {
                                fragment: '#content-container',
                                timeout: 8000,
                                dataType: null
                            });
                        }
                    });
                } else {
                    swal(info.msg, "", "warning");
                }
                layer.close(index);
            },
            error: function () {
                layer.msg('HTTP ERROR', function () {});
            }
        });
    });
    /**
     * 通用删除
     */
    $(".delete-action").on('click', function(){
        var _href    = $(this).attr('href'),
            isreload = $(this).attr('isreload'),
            load;

        layer.confirm('确定删除吗？', {
            btn: ['确定','取消'] //按钮
        }, function(index){
            $.ajax({
                url: _href,
                type: "get",
                beforeSend: function() {
                    load = layer.load(2);
                },
                success: function (info) {
                    if (info.code === 1) {
                        swal({
                            title: info.msg,
                            text: "",
                            type: "success"
                        }).then(function() {
                            if (isreload) {
                                setTimeout(function () {
                                    location.href = info.url;
                                }, 500);
                            } else {
                                $.pjax.reload('#content-container', {
                                    fragment: '#content-container',
                                    timeout: 8000,
                                    dataType: null
                                });
                            }
                        });
                    } else {
                        swal(info.msg, "", "warning");
                    }
                    layer.close(load);
                },
                error: function () {
                    layer.msg('HTTP ERROR', function () {});
                }
            });
            layer.close(index);
        }, function(){
        });
    });


    /**
     * 图标选择
     */
    $('.select-icon').on('click', function(){
       var index = layer.open({
           type: 2,
           title: '图标选择',
           area: ['800px','600px'],
           maxmin: true,
           content: '/admin/plugin/icon'
       });
       if(window.screen.width < 768) {
           layer.full(index);
       }
    });

    // api请求
    $('.api-action').on('click', function () {
        var btn      = $(this).button('loading');
        var _url     = $(this).attr('action-url');
        var index;
        $.ajax({
            url: _url,
            type: 'post',
            beforeSend: function() {
                index = layer.load(2);
            },
            success: function (info) {
                if (info.code === 1) {
                    swal({
                        title: info.msg,
                        text: "",
                        type: "success"
                    }).then(function() {
                        $.pjax.reload('#content-container', {
                            fragment: '#content-container',
                            timeout: 8000,
                            dataType: null
                        });
                    });
                } else {
                    swal(info.msg, "", "warning");
                    btn.button('reset');
                }
                layer.close(index);
            },
            error: function () {
                layer.msg('HTTP ERROR', function () {});
            }
        });
    });

    /**
     * iframe取消操作
     */
    $(".cancel-action").on('click', function(){
        layer.confirm('确认取消吗？', {
            btn: ['是','否'] //按钮
        }, function(){
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index); //再执行关闭
        }, function(){
        });
    });

    /**
     * 后台侧边栏菜单选中状态
     */
    $("#mainnav-menu").find('a').parent('li').removeClass('active-link').parents('.collapse ').removeClass('in').parents('.first-menu').removeClass('active-sub active');
    $(".list-group").find('a[href*="' + GL.current_controller + '"]').parent('li').addClass('active-link').parents('.collapse ').addClass('in').parents('.first-menu').addClass('active-sub active');

    /**
     * 清除缓存
     */
    $(".refresh").hover(function(){
        $(this).find('.glyphicon').addClass('fa-spin');
        var data_tips_text = $(this).attr('data-tips-text');
        tips = layer.tips(data_tips_text, this, {tips: 3});
    }, function(){
        $(this).find('.glyphicon').removeClass('fa-spin');
        layer.close(tips);
    });

});