<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/17
 * Time: 21:48
 */
namespace app\admin\controller;

use app\common\controller\AdminCommon;
use app\admin\model\Log as LogModel;
use think\Db;

/**
 * 系统日志管理
 * Class Log
 * @package app\admin\controller
 */
class Log extends AdminCommon{

    protected $log_model;

    protected function _initialize()
    {
        parent::_initialize(); // TODO: Change the autogenerated stub
        $this->log_model = new LogModel();
    }

    public function index()
    {
        $log_list  = $this->log_model->order(['id' => 'DESC'])->paginate(20);
        $ip = new \Ip2Region();
        foreach($log_list as $vo) {
            $result = $ip->btreeSearch($vo['ip']);
            $vo['isp'] = isset($result['region']) ? $result['region'] : '';
            $vo['isp'] = str_replace(['|0|0|0|0', '0', '|'], ['', '', ' '], $vo['isp']);
        }
        $page      = $log_list->render();
        return $this->fetch('index', ['log_list'=>$log_list, 'page'=>$page]);
    }

    /*
     * 删除日志
     */
    public function delete($id = 0)
    {
        $request_data = $this->request->param();
        if (!empty($request_data) && is_array($request_data)) {//批量删除
            foreach($request_data['ids'] as $value) {
                $res = $this->log_model->destroy($value);
            }
            if (false !== $res) {
                $this->success('删除成功');
            } else {
                $this->error('删除失败');
            }
        }
        else {
            $this->error('请选择需要删除的文章');
        }
    }
}