<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/3
 * Time: 20:58
 */
namespace app\common\controller;

use org\Auth;
use think\Controller;
use think\Session;
use think\Db;
use think\Loader;

/*
 * 后台公用控制器
 */
class AdminCommon extends Controller{
    protected function _initialize()
    {
        parent::_initialize(); // TODO: Change the autogenerated stub

        $this->getMenu();
        $this->checkAuth();
        $adminInfo = Db::name('admin_user')->field('id, username, avatar')->find(Session::get('admin_id'));
        // 管理员信息
        $this->assign('adminInfo', $adminInfo);
        // 输出当前请求控制器（配合后台侧边菜单选中状态）
        $this->assign('controller', Loader::parseName($this->request->controller()));
    }

    /**
     * 权限检查
     */
    protected function checkAuth()
    {
        if(!Session::has('admin_id')) {
            $this->redirect('admin/login/index');
        }

        $module     = $this->request->module();
        $controller = $this->request->controller();
        $action     = $this->request->action();

        // 排除权限
        $not_check = [
            'admin/Index/index',
            'admin/AuthGroup/getjson',
            'admin/AdminUser/profile',
            'admin/AdminUser/updateprofile'
        ];

        if(!in_array($module . '/' . $controller . '/' . $action, $not_check)) {
            $admin_id = Session::get('admin_id');
            $auth  = new Auth();
            if (!$auth->check($module . '/' . $controller . '/' . $action, $admin_id) && $admin_id != 1) {
                $this->error('没有权限');
            }
        }
    }
    /**
     *获取侧边栏菜单
     */
    protected function getMenu()
    {
        $menu  = [];
        $admin_id = Session::get('admin_id');
        $auth  = new Auth();

        $auth_rule_list = Db::name('auth_rule')->where('status', 1)
                                               ->order(['sort' => 'DESC', 'id' => 'ASC'])
                                               ->select();
        foreach ($auth_rule_list as $value) {
            if($auth->check($value['name'], $admin_id) || $admin_id == 1) {
                $menu[] = $value;
            }
        }
        $menu = !empty($menu) ? build_tree($menu, 0) : [];
        $this->assign('menu', $menu);
    }
}