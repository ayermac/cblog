<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/8
 * Time: 10:15
 */
namespace app\admin\model;

use think\Model;
use think\Session;

/**
 * 文章管理模型
 * Class Article
 * @package app\admin\model
 */
class Article extends Model{

    protected $purifier;
    protected $insert = ['create_time'];

    public function __construct($data = [])
    {
        parent::__construct($data);
        /**
         * XSS 过滤
         */
        $config = \HTMLPurifier_Config::createDefault();
        $this->purifier = new \HTMLPurifier($config);
    }

    /**
     * 文章作者
     * @param $value
     * @return mixed
     */
    protected function setAuthorAttr($value)
    {
        return $value ? $value : Session::get('admin_name');
    }

    /**
     * 创建时间
     * @return bool|string
     */
    protected function setCreateTimeAttr()
    {
        return date('Y-m-d H:i:s');
    }

    /**
     * XSS 过滤
     * @param $value
     * @return string
     */
    protected function getContentAttr($value)
    {
        return $this->purifier->purify(htmlspecialchars_decode($value));
    }

    /**
     * 发布时间
     * @param $value
     */
    protected function setPublishTimeAttr($value)
    {
        return $value ? $value : date('Y-m-d H:i:s');
    }


}