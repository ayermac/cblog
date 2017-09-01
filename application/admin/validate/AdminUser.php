<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/5
 * Time: 21:01
 */
namespace app\admin\validate;

use think\Validate;

class AdminUser extends Validate{
    protected $rule = [
        'username'         => 'require|unique:admin_user',
        'old_password'     => 'requireWith:password',
        'password'         => 'confirm:confirm_password',
        'confirm_password' => 'confirm:password',
        'status'           => 'require',
        'group_id'         => 'require'
    ];

    protected $message = [
        'username.require'         => '请输入用户名',
        'username.unique'          => '用户名已存在',
        'old_password.requireWith' => '请填写旧密码',
        'password.confirm'         => '两次输入密码不一致',
        'confirm_password.confirm' => '两次输入密码不一致',
        'status.require'           => '请选择状态',
        'group_id'                 => '请选择所属权限组'
    ];

    protected $scene = [
        'profile'  =>  ['username', 'old_password', 'password', 'confirm_password'],
    ];
}