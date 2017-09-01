/**
 * Created by Jason on 2017/7/5.
 */
$(function(){
    /**
     *加载树形授权菜单
     */
    var _id = $("#group_id").val();
    var tree = $("#tree");
    var zTree;

    //ztree配置项
    var setting = {
        view: {
            dblClickExpand: false,
            showLine: true,
            showIcon: false,
            selectedMulti: false
        },
        check: {
            enable: true
        },
        data: {
            simpleData: {
                enable: true,
                idKey: "id",
                pIdKey: "pid",
                rootpid: ""
            },
            key: {
                name: "title"
            }
        },
        edit: {
            enable: false
        }
    };

    $.ajax({
        url: "/admin/auth_group/getJson",
        type: "get",
        dataType: "json",
        cache: false,
        data: {
            id: _id
        },
        success: function (data) {
            zTree = $.fn.zTree.init(tree, setting, data);
        }
    });

    /**
     * 授权提交
     */
    $("#auth-btn").click(function(){
        var checked_ids,
           auth_rule_ids = [];
        var btn = $(this).button('loading');
        //获取选中的节点
        checked_ids = zTree.getCheckedNodes();
        $.each(checked_ids, function(index, item) {
           auth_rule_ids.push(item.id);
        });

        $.ajax({
            url:'/admin/auth_group/updateAuthGroupRule',
            type: "post",
            cache: false,
            data: {
                id: _id,
                auth_rule_ids: auth_rule_ids
            },
            success: function (data) {
                if(data.code === 1){
                    setTimeout(function () {
                        location.href = data.url;
                        //$.pjax.reload('#container', {
                        //    fragment: '#container',
                        //    timeout: 8000,
                        //    dataType: null
                        //});
                    }, 1000);
                } else {
                    btn.button('reset');
                }
                layer.msg(data.msg);
            }
        });
        //var doSomething = setTimeout(function(){
        //    clearTimeout(doSomething);
        //    btn.button('reset')
        //}, 8000);
    });
});
