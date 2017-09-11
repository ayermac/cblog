<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/5
 * Time: 13:42
 */
namespace app\admin\controller;

use app\common\controller\AdminCommon;
use app\admin\model\AdminUser as AdminUserModel;
use app\admin\model\AuthGroup as AuthGroupModel;
use app\admin\model\AuthGroupAccess as AuthGroupAccessModel;
use think\Db;
use service\LogService;
use think\Session;

/**
 * 管理员管理
 * Class AdminUser
 * @package app\admin\controller
 */
class AdminUser extends AdminCommon{

    protected $admin_user_model;
    protected $auth_group_model;
    protected $auth_group_access_model;

    protected function _initialize()
    {
        parent::_initialize(); // TODO: Change the autogenerated stub
        $this->admin_user_model = new AdminUserModel();
        $this->auth_group_model = new AuthGroupModel();
        $this->auth_group_access_model = new AuthGroupAccessModel();
    }

    /**
     * 管理员列表
     */
    public function index()
    {
        $admin_user_list = $this->admin_user_model->selectAdminUser();

        return $this->fetch('index', ['admin_user_list' => $admin_user_list]);
    }

    /**
     * 添加管理员
     */
    public function add()
    {
        $auth_group_list = $this->auth_group_model->where('status', 1)->select();

        return $this->fetch('add', ['auth_group_list'=>$auth_group_list]);
    }

    /**
     * 保存管理员
     * @param $group_id
     */
    public function save($group_id)
    {
        if($this->request->isPost()) {
            $data            = $this->request->post();
            $validate_result = $this->validate($data, 'AdminUser.add');

            if(true !== $validate_result) {
                $this->error($validate_result);
            } else {
                $data['password'] = password_hash($data['password'], PASSWORD_BCRYPT );

                $res = $this->admin_user_model->allowField(true)->save($data);

                if(false !== $res) {
                    $auth_group_access['uid']      = $this->admin_user_model->id;
                    $auth_group_access['group_id'] = $group_id;
                    $this->auth_group_access_model->save($auth_group_access);
                    LogService::write('管理员管理', '新增管理员');
                    $this->success('保存成功');
                } else {
                    $this->error('保存失败');
                }
            }
        }
    }

    /**
     * 编辑管理员
     * @param $id
     */
    public function edit($id)
    {
        $admin_user             = $this->admin_user_model->field('id,username,status')->find($id);
        $auth_group_list        = $this->auth_group_model->where('status',1)->select();
        $auth_group_acess       = $this->auth_group_access_model->where('uid', $id)->find();
        $admin_user['group_id'] = $auth_group_acess['group_id'];
        return $this->fetch('edit', ['admin_user' => $admin_user, 'auth_group_list' => $auth_group_list]);
    }

    /**
     * 更新管理员
     * @param $id
     * @param $group_id
     */
    public function update($id, $group_id)
    {
        if($this->request->isPost()) {
            $data            = $this->request->post();
            $validate_result = $this->validate($data, 'AdminUser.add');

            if ($id == 1 && $data['status'] != 1) {
                $this->error('默认管理员不可禁用');
            }

            if(true !== $validate_result) {
                $this->error($validate_result);
            } else {
                $admin_user = $this->admin_user_model->find($id);

                $admin_user->id       = $id;
                $admin_user->username = $data['username'];
                $admin_user->status   = $data['status'];

                if(!empty($data['password']) && !empty($data['confirm_password'])) {
                    $admin_user->password = password_hash($data['password'], PASSWORD_BCRYPT);
                }
                $res = $admin_user->save();
                if(false !== $res) {
                    $auth_group_access['uid']      = $id;
                    $auth_group_access['group_id'] = $group_id;
                    $this->auth_group_access_model->where('uid', $id)->update($auth_group_access);
                    LogService::write('管理员管理', '更新管理员'.$id);
                    $this->success('更新成功');
                } else {
                    $this->error('更新失败');
                }
            }
        }
    }

    /**
     * 删除管理员
     * @param $id
     */
    public function delete($id)
    {
        if($id == 1) {
            $this->error('默认管理员不可删除');
        }
        $res = $this->admin_user_model->destroy($id);

        if(false !== $res) {
            $this->auth_group_access_model->where('uid', $id)->delete();
            LogService::write('管理员管理', '删除管理员'.$id);
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
    }

    /**
     * 状态开关控制
     * @param $id
     */
    public function switchStatus($id)
    {
        if($this->request->isPost()) {
            $data = $this->request->post();

            if ($id == 1 && $data['status'] != 1) {
                $this->error('默认管理员不可禁用');
            }

            if(!is_array($data)) {
                $this->error('参数只能为数组');
            }
            $res = $this->admin_user_model->save($data, $id);

            if(false !== $res) {
                LogService::write('管理员管理', '修改ID为'.$id.'的管理员状态');
                $this->success('修改成功');
            } else {
                $this->error('修改失败');
            }
        }
    }

    /**
     * 管理员个人信息管理
     * @param $id
     */
    public function profile($id)
    {
        // 只有id为1的管理员可以访问和修改其他管理员的个人资料
        if($id != Session::get('admin_id') && Session::get('admin_id') != 1) {
            $this->error('没有权限');
        }
        $admin_user = $this->admin_user_model->field('id,username,avatar')->find($id);
        return $this->fetch('profile', ['admin_user'=>$admin_user]);
    }

    /**
     * 更新个人资料
     * @param $id
     */
    public function updateProfile($id)
    {
        if($this->request->isPost()) {
            if($id != Session::get('admin_id') && Session::get('admin_id') != 1) {
                $this->error('没有权限');
            }

            $data            = $this->request->post();
            $validate_result = $this->validate($data, 'AdminUser.profile');

            if(true !== $validate_result) {
                $this->error($validate_result);
            } else {
                $admin_user = $this->admin_user_model->find($id);

                // 验证旧密码
                if(!empty($data['old_password'])) {
                    $verify_old_password = password_verify($data['old_password'], $admin_user->password);
                    if (empty($verify_old_password)) {
                        $this->error('请输入正确的旧密码');
                    }
                }

                $admin_user->id = $id;
                $admin_user->username = $data['username'];
                $admin_user->avatar = $data['avatar'];

                if (!empty($data['password']) && !empty($data['confirm_password'])) {
                    $admin_user->password = password_hash($data['password'], PASSWORD_BCRYPT);
                }
                $res = $admin_user->allowField(true)->save();
                if (false !== $res) {
                    LogService::write('个人资料', '更新ID为' . $id . '的信息');
                    $this->success('更新成功');
                } else {
                    $this->error('更新失败');
                }
            }
        }
    }
}