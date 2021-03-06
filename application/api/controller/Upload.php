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
use QCloud\Cos\Api;
use think\Config;

class Upload extends ApiCommon{

    protected $isOpen;
    protected $isCdn;
    protected $config;
    protected $cosApi;

    protected function _initialize()
    {
        // 判断是否开启云存储
        $this->isOpen = Config::get('bucket.open');
        // 判断是否使用cdn加速
        $this->isCdn  = Config::get('bucket.cdn');

        if ($this->isOpen) {
            // 腾讯云COS权限配置
            $this->config = Config::get('cos');
            $this->cosApi = new Api($this->config);
        }
        parent::_initialize();
    }

    /**
     * 图片上传
     * @return \think\response\Json
     */
    public function ImageUpload()
    {
        if ($this->isOpen) {
           return $this->CosUpload();
        } else {
           return $this->LocalUpload();
        }
    }

    /**
     * 腾讯云COS上传
     * @return \think\response\Json
     */
    public function CosUpload()
    {
        // 存储桶名字
        $bucket = Config::get('bucket.bucketname');

        $config = [
            'size' => 2097152,//大小2M
            'ext'  => 'jpg,jpeg,gif,png,bmp'
        ];
        $images = $this->request->file('images');

        // 上传到本地，并验证
        $upload_path = str_replace('\\', '/', ROOT_PATH . 'public' . DS . 'uploads');
        $info   = $images->validate($config)->move($upload_path);

        if($info) {
            $src = $info->getPathname();
            $dst = Config::get('bucket.dst') . date('Y_m') . '/' . $info->getFilename();
            // 上传图片
            $ret = $this->cosApi->upload($bucket, $src, $dst);

            if ($ret['message'] == 'SUCCESS') {
                $result = [
                    'error'   => 0,
                    'url'     => $this->isCdn ? $ret['data']['access_url'] : $ret['data']['source_url'],
                    'message' => '上传成功'
                ];
            } else {
                return json($ret);
            }
        } else {
            $result = [
                'error'   => 1,
                'message' => $images->getError()
            ];
        }
        return json($result);
    }

    /**
     * 通用图片上传接口, 本地上传
     * /api/upload/ImageUpload
     */
    public function LocalUpload()
    {
        $config = [
            'size' => 2097152,//大小2M
            'ext'  => 'jpg,jpeg,gif,png,bmp'
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