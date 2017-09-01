<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/8/26
 * Time: 21:43
 */
namespace app\index\model;

use think\Model;
use think\Db;
use think\Cache;
/**
 * 文章模型
 * Class Article
 * @package app\index\model
 */
class Article extends Model{
    /**
     * 格式化发布时间
     * @param $value
     * @return bool|string
     */
    public function getPublishTimeAttr($value)
    {
        $value = substr($value, 0, 11);
        return $value;
    }

    /**
     * 从redis中获取阅读数
     * @param $value
     * @param $data
     * @return mixed
     */
    public function getreadingAttr($value, $data)
    {
        $value = Cache::get('articleReading'.$data['id']);
        return $value;
    }

    public function getTagsAttr($value)
    {
        $value = explode(',', $value);
        return $value;
    }
}