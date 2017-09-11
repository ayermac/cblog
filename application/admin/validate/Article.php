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
       'cid'        => 'require|egt:1',
       'title'      => 'require',
       'en_title'   => 'require|unique:article',
       'sort'       => 'require|number',
       '__token__'  => 'require|token'
    ];

    protected $message = [
        'cid.require'      => '请选择所属栏目',
        'cid.egt'          => '请选择所属栏目',
        'title.require'    => '请输入标题',
        'en_title.require' => '请输入英文标题',
        'en_title.unique'  => '英文标题已经存在，请重新输入',
        'sort.require'     => '请输入排序',
        'sort.number'      => '排序只能填写数字'
    ];
}