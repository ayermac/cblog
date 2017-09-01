<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/7
 * Time: 14:00
 */
namespace app\admin\validate;

use think\Validate;

class Navigation extends Validate{
    protected $rule = [
      'pid'   => 'require',
      'name'  => 'require',
      'sort'  => 'require|number',
    ];

    protected $message = [
      'pid.require'  => '请选择上级导航',
      'name.require' => '请输入导航名称',
      'sort.require' => '请输入排序',
      'sort.number'  => '排序只能填写数字',
    ];
}