<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/26
 * Time: 2:14
 */
namespace app\admin\validate;

use think\Validate;

/**
 * 友情链接验证器
 * Class Link
 * @package app\admin\validate
 */
class Link extends Validate
{
    protected $rule = [
        'name'       => 'require|max:20',
        '__token__'  => 'require|token'
    ];

    protected $message = [
        'name.require' => '请输入名称',
        'name.max'     => '字符串最长不能超过20'
    ];
}