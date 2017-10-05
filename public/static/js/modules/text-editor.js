/**
 * Created by Jason on 2017/7/4.
 */
layui.use(['layer', 'layedit'], function(){
    var layer    = layui.layer
        ,layedit = layui.layedit;
    /**
     * 初始化编辑器
     */
    layedit.build('lay-edit');

    /**
     * 初始化编辑器
     */

    // 自定义图片上传
    var Image = function (context) {
        var ui = $.summernote.ui;
        // create button
        var button = ui.button({
            contents: '<i class="fa fa-image"/>',
            tooltip: '图片',
            elem: 'editor_upload',//设置按钮id
            click: function () {

            }
        });
        return button.render();   // return button as jquery object
    };

    $('#editor').summernote({
        height : '500px'
        ,lang: 'zh-CN'//语言
        ,placeholder: 'write here...'
        ,dialogsFade: true//弹出框动画
        ,toolbar: [
            ['paragraphstyle', ['style', 'height', 'ol', 'ul', 'paragraph']],
            ['fontstyle', ['fontname', 'fontsize', 'color', 'bold', 'italic', 'underline', 'strikethrough', 'superscript', 'subscript', 'clear']],
            ['insert', ['image', 'link', 'video', 'table', 'hr']],
            ['misc', ['fullscreen', 'codeview', 'undo', 'redo', 'help']],
            //['noteimage', ['picture']] //编辑器自带上传图片以及插入图片链接
        ],
        buttons: {
            image: Image
        }
    });
});