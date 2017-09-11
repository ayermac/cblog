<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/4
 * Time: 17:31
 */
namespace app\admin\validate;

use think\Validate;

class Menu extends Validate{
    protected $rule = [
       'pid'        => 'require',
       'title'      => 'require',
       'name'       => 'require|unique:auth_rule',
       '__token__'  => 'require|token'
    ];

    protected $message = [
        'pid.require'   => '请选择上级菜单',
        'title.require' => '请输入菜单名称',
        'name.require'  => '请输入控制器方法',
        'name.unique'   => '控制器方法已存在'
    ];
}