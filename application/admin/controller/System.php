<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/28
 * Time: 19:53
 */
namespace app\admin\controller;

use app\common\controller\AdminCommon;
use think\Cache;
use think\Db;

/**
 * 系统配置
 * Class System
 * @package app\admin\controller
 */
class System extends AdminCommon{

    public function _initialize()
    {
        parent::_initialize(); // TODO: Change the autogenerated stub
    }

    /**
     * 站点配置
     */
    public function siteConfig()
    {
        $site_config = Db::name('system')
                       ->field('value')
                       ->where('name', 'site_config')
                       ->find();

        $site_config = unserialize($site_config['value']);

        return $this->fetch('siteconfig', ['site_config' => $site_config]);
    }

    public function dbConfig()
    {
        return $this->fetch('dbconfig');
    }

    /**
     * 更新站点配置
     */
    public function updateSiteConfig()
    {
        if($this->request->isPost())
        {
            $site_config   = $this->request->post('site_config/a');
            $data['value'] = serialize($site_config);

            $res = Db::name('system')
                   ->where('name', 'site_config')
                   ->update($data);
            if(false !== $res) {
                $this->success('保存成功');
            } else {
                $this->error('保存失败');
            }
        }
    }

    /**
     * 清除缓存
     */
    public function clear()
    {
        if (delete_dir_file(CACHE_PATH) || delete_dir_file(TEMP_PATH)) {
            $this->success('清除缓存成功');
        } else {
            $this->error('清除缓存失败');
        }
    }
}