<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/8/26
 * Time: 21:43
 */
namespace app\index\model;

use think\Model;
use think\Cache;
use think\Config;

/**
 * 文章模型
 * Class Article
 * @package app\index\model
 */
class Article extends Model{

    protected $parsedown;
    protected $purifier;

    public function __construct($data = [])
    {
        parent::__construct($data);
        $this->parsedown = new \Parsedown();

        /**
         * XSS 过滤
         */
        $config = \HTMLPurifier_Config::createDefault();
        $this->purifier = new \HTMLPurifier($config);
    }

    /**
     * 格式化发布时间
     * @param $value
     * @return bool|string
     */
    protected function getPublishTimeAttr($value)
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
    protected function getreadingAttr($value, $data)
    {
        $articleReadingKey = Config::get('rediskey.articleReadingkey');
        $value = Cache::get($articleReadingKey.$data['en_title']);
        return $value;
    }

    protected function getTagsAttr($value)
    {
        $value = explode(',', $value);
        return $value;
    }

    /**
     * Markdown 转 Html
     * XSS 过滤
     * @param $value
     * @return string
     */
    protected function getContentAttr($value)
    {
        if ($this->getAttr('editor_type') == 'markdown') {
            $value = $this->parsedown->text($value);
        }
        return $this->purifier->purify(htmlspecialchars_decode($value));
    }
}