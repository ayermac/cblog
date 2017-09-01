<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/7
 * Time: 15:01
 */
namespace app\admin\validate;

use think\Validate;

class AuthGroup extends Validate{
    protected $rule = [
        'title'         => 'require',
        'status'        => 'require',
    ];

    protected $message = [
        'title.require'        => '请填写权限组名称',
        'status.require'          => '请选择状态',
    ];
}