<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/3
 * Time: 20:50
 */
namespace app\admin\controller;

use think\Config;
use think\Controller;
use think\Db;
use think\Session;
use service\LogService;

/**
 * 后台登录
 * Class Login
 * @package app\admin\controller
 */
class Login extends Controller{
    public function index()
    {
        return $this->fetch();
    }

    /**
     * 登录验证
     */
    public function login()
    {
        if($this->request->isPost()) {
            $data = $this->request->only(['username', 'password', 'verify']);
            $validate_result = $this->validate($data, 'Login');

            if(true !== $validate_result) {
                $this->error($validate_result);
            } else {
                $where['username'] = $data['username'];

                $admin_user = Db::name('admin_user')
                                  ->field('id,username,status,password')
                                  ->where($where)
                                  ->find();
                $verify_password = password_verify($data['password'], $admin_user['password']);
                if(!empty($admin_user) && !empty($verify_password)) {
                    if($admin_user['status'] !=1 ) {
                        $this->error('当前用户已禁用');
                    } else {
                        Session::set('admin_id', $admin_user['id']);
                        Session::set('admin_name', $admin_user['username']);
                        Db::name('admin_user')->update(
                          [
                              'last_login_time' => date('Y-m-d H:i:s', time()),
                              'last_login_ip'   => $this->request->ip(),
                              'id'              => $admin_user['id']
                          ]
                        );
                        LogService::write('用户登录', '用户登录系统成功');
                        $this->success('登录成功', 'admin/index/index');
                    }
                } else {
                    $this->error('用户名或密码错误');
                }
            }
        }
    }

    /**
     * 退出登录
     */
    public function logout()
    {
        Session::delete('admin_id');
        Session::delete('admin_name');
        $this->redirect('admin/login/index');
    }
}