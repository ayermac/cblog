CBlog
===============
* **CBlog**  是一个基于ThinkPHP5开发的博客系统。
* 演示: 个人博客[http://www.totoroc.cn/](http://www.totoroc.cn/)
* **CBlog** 后台是一个通用的后台系统，拥有完整的权限管理，可以用作个人博客的后台也可以用作其他CMS的后台。


前后台UI框架
=============
前台
* Uikit
  ![](http://cblog-1252077432.cossh.myqcloud.com/%E5%89%8D%E5%8F%B0.png)

后台
* Bootstrap
* Nifty
* Layui
  ![](http://cblog-1252077432.cossh.myqcloud.com/%E5%90%8E%E5%8F%B0.png)


部署
===============
* 直接上传到服务器指定目录, 数据库文件存放在根目录下sql文件夹里。
* 数据库配置文件application/database.php
* 后台管理员默认用户名：*admin*，密码：*admin*


服务器环境
==============
* `PHP5.4`以上版本（注意：`PHP5.4dev`版本和`PHP6`均不支持）, 推荐使用`PHP7`以达到最优效果
* 博客文章内容以及阅读数用`Redis`做缓存，所以需先安装`Redis`，缓存配置文件application/config.php
* `Nginx` 可以在`Nginx.conf`中配置如下转发规则: 

```
location / { 
   if (!-e $request_filename) {
   rewrite  ^(.*)$  /index.php?s=/$1  last;
   break;
    }
 }
```
其他配置具体请参考`ThinkPHP`官方文档配置,[官方文档链接](https://www.kancloud.cn/manual/thinkphp5/129745)

**最后在此感谢我学习借鉴过的各位前辈。**
