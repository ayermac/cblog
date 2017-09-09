/**
 * Created by Jason on 2017/7/13.
 */
$(function(){

    layui.use(['layer', 'element', 'upload'], function(){
        var layer    = layui.layer
            ,element = layui.element()
            ,load;

        layui.upload({
            url: '/api/upload/ImageUpload' //上传接口
            ,title: '上传头像'
            ,success: function(res){ //上传成功后的回调
                if (res.error == 0) {
                    avatar_upload.src = res.url;
                    avatar.value = res.url;
                } else {
                    layer.msg(res.message, function() {});
                }
            }
        });

        /**
         * 缩略图上传
         * @type {plupload.Uploader}
         */
        var uploader = new plupload.Uploader({
            runtimes: 'html5,flash,silverlight,html4', //上传插件初始化选用那种方式的优先级顺序
            browse_button : 'start_upload', //触发文件选择对话框的按钮，为那个元素id
            url : '/api/upload/ImageUpload', //服务器端的上传页面地址
            flash_swf_url : '/static/lb/plupload/Moxie.swf', //swf文件，当需要使用swf方式进行上传时需要配置该参数
            silverlight_xap_url : '/static/lb/plupload/Moxie.xap', //silverlight文件，当需要使用silverlight方式进行上传时需要配置该参数
            filters: {
                max_file_size: '2mb', //最大上传文件大小（格式100b, 10kb, 10mb, 1gb）
                mime_types: [//允许文件上传类型
                    {title: "Image files", extensions: "jpg,png,gif"}
                ]
            },
            multi_selection: false, //true:ctrl多文件上传, false 单文件上传
            file_data_name: 'images',
            resize: {//图片压缩，只对jpg格式的图片有效
                width: 800,
                height: 600,
                crop: false,
                quality: 50,
                preserve_headers: false
            },
            init: {
                FilesAdded: function (up, files) { //文件上传前
                    $(".layui-progress").html('<div class="layui-progress-bar layui-bg-green" lay-percent="0%"></div>');
                    element.init();
                    uploader.start();
                },
                UploadProgress: function (up, file) { //上传中，显示进度条
                    var percent = file.percent;
                    element.progress('thumb', percent+'%');
                },
                FileUploaded: function (up, file, info) { //文件上传成功的时候触发
                    var data = JSON.parse(info.response);

                    if (data.error === 0) {
                        thumb_upload.src = data.url;
                        name_thumb.value = data.url;
                    }
                    layer.msg(data.message);
                },
                Error: function (up, err) { //上传出错的时候触发
                    layer.msg(err.message, function(){});
                }
            }
        });
        //在实例对象上调用init()方法进行初始化
        uploader.init();

        /**
         * 编辑器图片上传
         * @type {plupload.Uploader}
         */
        var editor_uploader = new plupload.Uploader({
            runtimes: 'html5,flash,silverlight,html4', //上传插件初始化选用那种方式的优先级顺序
            browse_button : 'editor_upload', //触发文件选择对话框的按钮，为那个元素id
            url : '/api/upload/ImageUpload', //服务器端的上传页面地址
            flash_swf_url : '/static/lb/plupload/Moxie.swf', //swf文件，当需要使用swf方式进行上传时需要配置该参数
            silverlight_xap_url : '/static/lb/plupload/Moxie.xap', //silverlight文件，当需要使用silverlight方式进行上传时需要配置该参数
            filters: {
                max_file_size: '10mb', //最大上传文件大小（格式100b, 10kb, 10mb, 1gb）
                mime_types: [//允许文件上传类型
                    {title: "Image files", extensions: "jpg,png,gif"}
                ]
            },
            multi_selection: false, //true:ctrl多文件上传, false 单文件上传
            file_data_name: 'images',
            resize: {//图片压缩, 只对jpg格式的图片有效
                crop: false,
                quality: 50,
                preserve_headers: false
            },
            init: {
                FilesAdded: function (up, files) { //文件上传前
                    editor_uploader.start();
                    load = layer.load(2);
                },
                UploadProgress: function (up, file) { //上传中，显示进度条
                    var percent = file.percent;
                },
                FileUploaded: function (up, file, info) { //文件上传成功的时候触发
                    var data = JSON.parse(info.response);
                    if (data.error === 0) {
                        $('#summernote').summernote('insertImage', data.url);
                    }
                    layer.close(load);
                    layer.msg(data.message);
                },
                Error: function (up, err) { //上传出错的时候触发
                    layer.msg(err.message, function(){});
                }
            }
        });
        //在实例对象上调用init()方法进行初始化
        editor_uploader.init();
    });
});

