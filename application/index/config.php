<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/29
 * Time: 10:50
 */
return [
    // +----------------------------------------------------------------------
    // | 前台模板设置
    // +----------------------------------------------------------------------

    'template' => [
        // 模板路径
        'view_path' => '../themes/index/'
    ],
    //分页配置
    'paginate'               => [
        'type'      => '\org\UikitPage',
        'var_page'  => 'page',
        'list_rows' => 15,
    ],
];