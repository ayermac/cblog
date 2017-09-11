<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/7
 * Time: 13:07
 */
namespace app\admin\controller;

use app\common\controller\AdminCommon;
use app\admin\model\Navigation as NavigationModel;

/**
 * 导航管理控制器
 * Class Navigation
 * @package app\admin\controller
 */
class Navigation extends AdminCommon{
    protected $navigation_model;

    protected function _initialize()
    {
        parent::_initialize(); // TODO: Change the autogenerated stub
        $this->navigation_model = new NavigationModel();
        $nav_list         = $this->navigation_model->order(['sort' => 'DESC', 'id' => 'ASC'])->select();
        $nav_level_list   = array2level($nav_list);

        $this->assign('nav_level_list', $nav_level_list);
    }
    public function index()
    {
        return $this->fetch();
    }

    /**
     * 添加导航
     */
    public function add($pid = '')
    {
        return $this->fetch('add', ['pid' => $pid]);
    }

    /**
     * 保存导航
     */
    public function save()
    {
        if($this->request->isPost()) {
            $data            = $this->request->post();
            $validate_result = $this->validate($data, 'Navigation');

            if(true !== $validate_result) {
                $this->error($validate_result);
            } else {
                $res = $this->navigation_model->allowField(true)->save($data);

                if(false !== $res) {
                    $this->success('保存成功');
                } else {
                    $this->error('保存失败');
                }
            }
        }
    }

    /**
     * 编辑导航
     * @param $id
     */
    public function edit($id)
    {
        $navigation = $this->navigation_model->find($id);
        return $this->fetch('edit', ['navigation' => $navigation]);
    }

    /**
     * 更新导航
     */
    public function update($id)
    {
        if($this->request->isPost()) {
            $data            = $this->request->post();
            $validate_result = $this->validate($data, 'Navigation');

            if(true !== $validate_result) {
                $this->error($validate_result);
            } else {
                $res = $this->navigation_model->allowField(true)->save($data, $id);

                if(false !== $res) {
                    $this->success('更新成功');
                } else {
                    $this->error('更新失败');
                }
            }
        }
    }

    /**
     * 删除导航
     * @param $id
     */
    public function delete($id)
    {
        if($this->request->isGet()) {
            $child_nav = $this->navigation_model->where(['pid' => $id])->find();

            if(!empty($child_nav)) {
                $this->error('此导航存在子导航，不可删除');
            }
            $res = $this->navigation_model->destroy($id);
            if(false !== $res) {
                $this->success('删除成功');
            } else {
                $this->error('删除失败');
            }
        }
    }

    /**
     * 状态开关控制
     * @param $id
     */
    public function switchStatus($id)
    {
        if($this->request->isPost()) {
            $data = $this->request->post();

            if(!is_array($data)) {
                $this->error('参数只能为数组');
            }
            $res = $this->navigation_model->save($data, $id);

            if(false !== $res) {
                $this->success('修改成功');
            } else {
                $this->error('修改失败');
            }
        }
    }

    /**
     * 列表排序
     */
    public function sorting($data = array())
    {
        if($this->request->isPost()) {
            $data      = $this->request->post();
            if(!is_array($data)) {
                $this->error('数据不是数组');
            }
            $sort_data = $data['sort'];

            foreach($sort_data as $v){
                $sort['id']   = $v[0];
                $sort['sort'] = $v[1];

                if(is_numeric($sort['sort'])) {
                    $res = $this->navigation_model->save($sort, $sort['id']);
                }
            }
            if(false !== $res) {
                $this->success('排序成功');
            } else {
                $this->error('排序失败');
            }
        }
    }
}