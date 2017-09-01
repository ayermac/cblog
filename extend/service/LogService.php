<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/17
 * Time: 21:58
 */
namespace service;

use think\Db;
use think\Request;
use think\Session;

/*
 * 系统日志服务
 */
class LogService
{

    /**
     * 写入操作日志
     * @param string $action
     * @param string $content
     * @return bool
     */
    public static function write($action = '行为', $content = '内容描述')
    {
        $request = Request::instance();
        $node    = strtolower(join('/', [$request->module(), $request->controller(), $request->action()]));
        $data    = ['ip' => $request->ip(), 'node' => $node, 'username' => Session::get('admin_name'), 'action' => $action, 'content' => $content];

        return Db::name('log')->insert($data) !== false;
    }
}