<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件
use think\Db;

/**
 * 数组层级缩进转换
 * @param array $array 源数组
 * @param int   $pid
 * @param int   $level
 * @return array
 */
function array2level($array, $pid = 0, $level = 1)
{
    static $list = [];
    foreach ($array as $v) {
        if ($v['pid'] == $pid) {
            $v['level'] = $level;
            $list[]     = $v;
            array2level($array, $v['id'], $level + 1);
        }
    }

    return $list;
}


/**
 * [findChild 寻找树的节点]
 * @param  [type] &$arr [description]
 * @param  [type] $id   [description]
 * @return [type]       [description]
 */
function findChild(&$arr,$id){
    $childs=array();

    foreach ($arr as $k => $v){
        if($v['pid']== $id){
            $childs[]=$v;
        }
    }
    return $childs;
}

/**
 * [build_tree 构建树]
 * @param  [type] $rows    [description]
 * @param  [type] $root_id [description]
 * @return [type]          [description]
 */
function build_tree($rows,$root_id){
    $childs=findChild($rows,$root_id);
    if(empty($childs)){
        return null;
    }
    foreach ($childs as $k => $v){
        $rescurTree=build_tree($rows,$v['id']);
        if( null != $rescurTree) {
            $childs[$k]['children']=$rescurTree;
        }
    }
    return $childs;
}

/**
 * 循环删除目录和文件
 * @param string $dir_name
 * @return bool
 */
function delete_dir_file($dir_name)
{
    $result = false;
    if (is_dir($dir_name)) {
        if ($handle = opendir($dir_name)) {
            while (false !== ($item = readdir($handle))) {
                if ($item != '.' && $item != '..') {
                    if (is_dir($dir_name . DS . $item)) {
                        delete_dir_file($dir_name . DS . $item);
                    } else {
                        unlink($dir_name . DS . $item);
                    }
                }
            }
            closedir($handle);
            if (rmdir($dir_name)) {
                $result = true;
            }
        }
    }

    return $result;
}