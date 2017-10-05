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
use think\Config;
/**
 * 文章模型
 * Class Article
 * @package app\index\model
 */
class Article extends Model{

    protected $parsedown;

    public function __construct($data = [])
    {
        parent::__construct($data);
        $this->parsedown = new \Parsedown();
    }

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
        $articleReadingKey = Config::get('rediskey.articleReadingkey');
        $value = Cache::get($articleReadingKey.$data['en_title']);
        return $value;
    }

    public function getTagsAttr($value)
    {
        $value = explode(',', $value);
        return $value;
    }

    /**
     * Markdown 转 Html
     * @param $value
     * @return string
     */
    public function getContentAttr($value)
    {
        $value = $this->parsedown->text($value);
        return $value;
    }
}