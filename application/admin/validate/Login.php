<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/5
 * Time: 22:56
 */
namespace app\admin\validate;

use think\Validate;

/**
 * 后台登录验证
 * Class Login
 * @package app\admin\validate
 */
class Login extends Validate{
    protected $rule = [
        'username' => 'require',
        'password' => 'require',
        'verify'   => 'require|captcha'
    ];

    protected $message = [
        'username.require' => '请输入用户名',
        'password.require' => '请输入密码',
        'verify.require'   => '验证码不能为空',
        'verify.captcha'   => '验证码不正确'
    ];
}