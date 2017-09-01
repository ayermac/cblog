<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/13
 * Time: 15:43
 */
namespace app\api\controller;

use think\Session;
use app\common\controller\ApiCommon;

class Upload extends ApiCommon{
    protected function _initialize()
    {
        parent::_initialize();
    }

    /**
     * 通用图片上传接口
     * /api/upload/ImageUpload
     */
    public function ImageUpload()
    {
        $config = [
            'size' => 2097152,//大小2M
            'ext'  => 'jpg,gif,png,bmp'
        ];
        $images = $this->request->file('images');

        $upload_path = str_replace('\\', '/', ROOT_PATH . 'public' . DS . 'uploads');
        $save_path   = '/uploads/';
        $info   = $images->validate($config)->move($upload_path);
        if($info) {
            $result = [
               'error' => 0,
               'url'   => str_replace('\\', '/', $save_path . $info->getSaveName()),
               'message' => '上传成功'
            ];
        } else {
            $result = [
                'error'   => 1,
                'message' => $images->getError()
            ];
        }

        return json($result);
    }
}