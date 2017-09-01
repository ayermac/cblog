<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/5
 * Time: 13:48
 */
namespace app\admin\model;

use think\Model;
use think\Db;
/**
 * 管理员模型
 * Class AdminUser
 * @package app\admin\model
 */
class AdminUser extends Model
{
    protected $insert = ['create_time'];

    /**
     * 创建时间
     * @return bool|string
     */
    protected function setCreateTimeAttr()
    {
        return date('Y-m-d H:i:s');
    }

    public function selectAdminUser()
    {
        $res = Db::view('admin_user','id,username,status,last_login_time,last_login_ip')
                    ->view('auth_group_access','uid','auth_group_access.uid=admin_user.id')
                    ->view('auth_group','title','auth_group_access.group_id=auth_group.id')
                    ->select();
        return $res;
    }
}