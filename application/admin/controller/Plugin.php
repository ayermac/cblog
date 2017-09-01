<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/6
 * Time: 21:30
 */
namespace app\admin\controller;

use think\Controller;

class Plugin extends Controller{
    /**
     * 图标选择
     */
    public function icon()
    {
        return $this->fetch();
    }

    /**
     * plupload上传插件中文文档
     */
    public function plupload()
    {
        return $this->fetch();
    }
}
