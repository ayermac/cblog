<?php
/**
 * Created by PhpStorm.
 * User: Jason
 * Date: 2017/7/3
 * Time: 22:00
 */
namespace  app\admin\controller;

use app\common\controller\AdminCommon;
use app\admin\model\Article as ArticleModel;
use app\admin\model\Category as CategoryModel;
use think\Db;
use service\LogService;
use think\Cache;
use think\Config;
/**
 * 文章管理控制器
 * Class Article
 * @package app\admin\controller
 */
class Article extends AdminCommon{

    protected $article_model;
    protected $category_model;
    protected $purifier;
    protected $articleKey;

    protected function _initialize()
    {
        parent::_initialize(); // TODO: Change the autogenerated stub
        $this->article_model  = new ArticleModel();
        $this->category_model = new CategoryModel();
        $this->articleKey     = Config::get('rediskey.articlekey');

        $category_list       = $this->category_model->select();
        $category_level_list = array2level($category_list);

        /**
         * 富文本过滤
         */
//        $config = \HTMLPurifier_Config::createDefault();
//        $this->purifier = new \HTMLPurifier($config);

        $this->assign('category_level_list', $category_level_list);
    }

    public function index($cid = 0, $keyword = '', $page = 1)
    {
        $map       = [];
        $query     = [];//分页url额外参数
        $field     = 'id,title,cid,author,reading,status,publish_time,sort';

        if($cid > 0) {
            $map['cid']   = ['eq', $cid];
            $query['cid'] = $cid;
        }
        if(!empty($keyword)) {
            $map['title'] = ['like', "%{$keyword}%"];
            $query['keyword'] = $keyword;
        }

        $map['status'] = ['egt', 0];
        //分页
        $article_list = $this->article_model
                             ->field($field)
                             ->where($map)
                             ->order(['publish_time' => 'DESC'])
                             ->paginate(8, false, [
                                 'query' => $query
                             ]);
        $category_list = $this->category_model->column('name', 'id');

        $page = $article_list->render();
        return $this->fetch('index', ['article_list' => $article_list, 'page' => $page, 'category_list' => $category_list, 'cid' => $cid, 'keyword' => $keyword]);
    }

    /**
     * 添加文章
     */
    public function add()
    {
        return $this->fetch();
    }

    /**
     * 保存文章
     */
    public function save()
    {
        if($this->request->isPost()) {
            $data            = $this->request->post();
//            $data['content'] = $this->purifier->purify(htmlspecialchars_decode($data['content']));

            $validate_result = $this->validate($data, 'Article');
            if(true !== $validate_result) {
                $this->error($validate_result);
            } else {
                $res = $this->article_model->allowField(true)->save($data);

                if(false !== $res) {
                    LogService::write('文章管理', '新增文章');
                    $this->success('保存成功');
                } else {
                    $this->error('保存失败');
                }
            }
        }
    }

    /**
     * 编辑文章
     */
    public function edit($id)
    {
        $article = $this->article_model->find($id)->toArray();

        return $this->fetch('edit', ['article' => $article]);
    }

    /*
     * 更新文章
     */
    public function update($id)
    {
        if ($this->request->isPost()) {
            $data            = $this->request->post();

            $validate_result = $this->validate($data, 'Article');
            if (true !== $validate_result) {
                $this->error($validate_result);
            } else {
                $res = $this->article_model->allowField(true)->save($data, $id);
                if ( false !== $res) {
                    LogService::write('文章管理', '更新文章'.$id);
                    // 清空缓存的文章
                    Cache::rm($this->articleKey.$data['en_title']);
                    $this->success('更新成功');
                } else {
                    $this->error('更新失败');
                }
            }
        }
    }

    /*
     * 删除文章
     */
    public function delete($id = 0)
    {
        $request_data = $this->request->param();
        if ($id) {
            $data = [
              'status' => -1,
              'id'     => $id
            ];
            $res = $this->article_model->save($data, $id);
            if (false !== $res) {
                LogService::write('文章管理', '删除文章'.$id);
                $this->success('删除成功');
            } else {
                $this->error('删除失败');
            }
        } elseif (!empty($request_data) && is_array($request_data)) {//批量删除
            foreach($request_data['ids'] as $value) {
                $data_ids[] = ['id' => $value, 'status' => -1];
            }
            $res = $this->article_model->saveAll($data_ids);
            if (false !== $res) {
                LogService::write('文章管理', '批量删除文章');
                $this->success('删除成功');
            } else {
                $this->error('删除失败');
            }
        }
        else {
            $this->error('请选择需要删除的文章');
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
                    $res = $this->article_model->save($sort, $sort['id']);
                }
            }
            if(false !== $res) {
                $this->success('排序成功');
            } else {
                $this->error('排序失败');
            }
        }
    }

    /**
     * 文章审核状态切换
     * @param array  $ids
     * @param string $type 操作类型
     */
    public function toggle($type = '')
    {
        $request_data = $this->request->param();
        $data   = [];
        $status = $type == 'audit' ? 1 : 0;

        if (!empty($request_data) && is_array($request_data)) {
            foreach ($request_data['ids'] as $value) {
                $data[] = ['id' => $value, 'status' => $status];
            }
            if ($this->article_model->saveAll($data)) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        } else {
            $this->error('请选择需要操作的文章');
        }
    }
}