<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/8
 * Time: 12:20
 */
namespace app\admin\validate;

use think\Validate;

class Article extends Validate{
    protected $rule = [
       'cid'   => 'require|egt:1',
       'title' => 'require',
       'sort'  => 'require|number'
    ];

    protected $message = [
        'cid.require'   => '请选择所属栏目',
        'cid.egt'       => '请选择所属栏目',
        'title.require' => '请输入标题',
        'sort.require'  => '请输入排序',
        'sort.number'   => '排序只能填写数字'
    ];
}