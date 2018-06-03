-- phpMyAdmin SQL Dump
-- version 4.4.15.6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2018-06-03 21:26:49
-- 服务器版本： 5.6.29-log
-- PHP Version: 7.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cblog`
--

-- --------------------------------------------------------

--
-- 表的结构 `think_admin_user`
--

CREATE TABLE IF NOT EXISTS `think_admin_user` (
  `id` smallint(5) unsigned NOT NULL,
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '管理员用户名',
  `password` varchar(60) NOT NULL DEFAULT '' COMMENT '管理员密码',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态 1 启用 0 禁用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(20) DEFAULT NULL COMMENT '最后登录IP',
  `avatar` varchar(128) DEFAULT NULL COMMENT '头像',
  `editor` varchar(8) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='管理员表';

--
-- 转存表中的数据 `think_admin_user`
--

INSERT INTO `think_admin_user` (`id`, `username`, `password`, `status`, `create_time`, `last_login_time`, `last_login_ip`, `avatar`, `editor`) VALUES
(1, 'admin', '$10$08IXXgCvjAYrkUgBTEcYMOl6UM.kgXypyc8TFCb.7Henwmf71jqHe', 1, '2016-10-18 15:28:37', '2018-06-03 17:48:08', '127.0.0.1', '', 'plain');

-- --------------------------------------------------------

--
-- 表的结构 `think_article`
--

CREATE TABLE IF NOT EXISTS `think_article` (
  `id` int(10) unsigned NOT NULL COMMENT '文章ID',
  `cid` smallint(5) unsigned NOT NULL COMMENT '分类ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `en_title` varchar(255) NOT NULL COMMENT '文章英文标题',
  `introduction` varchar(255) DEFAULT '' COMMENT '简介',
  `tags` varchar(255) DEFAULT '' COMMENT '标签',
  `content` longtext COMMENT '内容',
  `author` varchar(20) DEFAULT '' COMMENT '作者',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 -1 删除  0 待审核  1 审核',
  `reading` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '阅读量',
  `thumb` varchar(255) DEFAULT '' COMMENT '缩略图',
  `photo` text COMMENT '图集',
  `is_top` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否置顶  0 不置顶  1 置顶',
  `is_recommend` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐  0 不推荐  1 推荐',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `publish_time` datetime NOT NULL COMMENT '发布时间',
  `editor_type` varchar(8) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文章表';

--
-- 转存表中的数据 `think_article`
--

-- --------------------------------------------------------

--
-- 表的结构 `think_auth_group`
--

CREATE TABLE IF NOT EXISTS `think_auth_group` (
  `id` mediumint(8) unsigned NOT NULL,
  `title` varchar(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL COMMENT '权限组描述'
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `think_auth_group`
--

INSERT INTO `think_auth_group` (`id`, `title`, `status`, `rules`, `description`) VALUES
(1, '超级管理员', 1, '1,6,24,25,26,27,28,29,14,17,16,18,19,20,21,22,23,2,30,31,38,33,34,37', '管理所有权限'),
(3, 'guest', 1, '1,4,8,10,6,24,26,14,16,18,22,2,30,42,44,31,62,64,38,49,51,33,34,37,41,39,40,55,57', '游客，只能浏览页面');

-- --------------------------------------------------------

--
-- 表的结构 `think_auth_group_access`
--

CREATE TABLE IF NOT EXISTS `think_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `think_auth_group_access`
--

INSERT INTO `think_auth_group_access` (`uid`, `group_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- 表的结构 `think_auth_rule`
--

CREATE TABLE IF NOT EXISTS `think_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL,
  `name` varchar(80) NOT NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '规则说明',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `pid` smallint(5) NOT NULL COMMENT '父级id',
  `icon` varchar(50) DEFAULT NULL COMMENT '图标',
  `sort` smallint(5) DEFAULT NULL COMMENT '排序',
  `condition` char(100) NOT NULL DEFAULT ''
) ENGINE=MyISAM AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `think_auth_rule`
--

INSERT INTO `think_auth_rule` (`id`, `name`, `title`, `type`, `status`, `pid`, `icon`, `sort`, `condition`) VALUES
(1, 'admin/Auth/default', '权限管理', 1, 1, 0, 'fa fa-cogs', 1, ''),
(2, 'admin/Content/default', '内容管理', 1, 1, 0, 'fa fa-file-text-o', 5, ''),
(4, 'admin/Menu/index', '节点管理', 1, 1, 1, '', 10, ''),
(6, 'admin/AdminUser/index', '管理员管理', 1, 1, 1, 'fa fa-users', 13, ''),
(8, 'admin/Menu/add', '添加节点', 1, 1, 4, '', 3, ''),
(9, 'admin/Menu/save', '保存节点', 1, 1, 4, '', 5, ''),
(10, 'admin/Menu/edit', '编辑节点', 1, 1, 4, '', 6, ''),
(11, 'admin/Menu/update', '更新节点', 1, 1, 4, '', 6, ''),
(12, 'admin/Menu/delete', '删除节点', 1, 1, 4, '', 1, ''),
(13, 'admin/Menu/switchStatus', '节点状态开关控制', 1, 1, 4, '', 0, ''),
(14, 'admin/AuthGroup/index', '权限组管理', 1, 1, 1, '', 12, ''),
(17, 'admin/AuthGroup/save', '保存权限组', 1, 1, 14, '', NULL, ''),
(15, 'admin/Menu/sorting', '节点列表排序', 1, 1, 4, '', 1, ''),
(16, 'admin/AuthGroup/add', '添加权限组', 1, 1, 14, '', NULL, ''),
(18, 'admin/AuthGroup/edit', '编辑权限组', 1, 1, 14, '', NULL, ''),
(19, 'admin/AuthGroup/update', '更新权限组', 1, 1, 14, '', NULL, ''),
(20, 'admin/AuthGroup/delete', '删除权限组', 1, 1, 14, '', NULL, ''),
(21, 'admin/AuthGroup/switchStatus', '权限组状态开关控制', 1, 1, 14, '', NULL, ''),
(22, 'admin/AuthGroup/auth', '权限组授权', 1, 1, 14, '', NULL, ''),
(23, 'admin/AuthGroup/updateAuthGroupRule', '更新权限组权限', 1, 1, 14, '', NULL, ''),
(24, 'admin/AdminUser/add', '添加管理员', 1, 1, 6, '', NULL, ''),
(25, 'admin/AdminUser/save', '保存管理员', 1, 1, 6, '', NULL, ''),
(26, 'admin/AdminUser/edit', '编辑管理员', 1, 1, 6, '', NULL, ''),
(27, 'admin/AdminUser/update', '更新管理员', 1, 1, 6, '', NULL, ''),
(28, 'admin/AdminUser/delete', '删除管理员', 1, 1, 6, '', NULL, ''),
(29, 'admin/AdminUser/switchStatus', '管理员状态开关控制', 1, 1, 6, '', NULL, ''),
(30, 'admin/Article/index', '文章管理', 1, 1, 2, '', 1, ''),
(31, 'admin/Navigation/index', '导航管理', 1, 1, 2, '', 3, ''),
(38, 'admin/category/index', '分类管理', 1, 1, 2, '', 2, ''),
(33, 'admin/sys/default', '系统管理', 1, 1, 0, 'fa fa-cog', NULL, ''),
(34, 'admin/log/index', '日志管理', 1, 1, 33, 'fa fa-file-text-o', NULL, ''),
(35, 'admin/log/delete', '删除日志', 1, 1, 34, '', NULL, ''),
(37, 'admin/log/default', '日志管理首页', 1, 1, 34, '', NULL, ''),
(39, 'admin/extra/index', '扩展管理', 1, 1, 0, 'glyphicon glyphicon-fullscreen', NULL, ''),
(40, 'admin/link/index', '友情链接', 1, 1, 39, '', NULL, ''),
(41, 'admin/system/siteconfig', '站点配置', 1, 1, 33, '', NULL, ''),
(42, 'admin/Article/add', '添加文章', 1, 1, 30, '', NULL, ''),
(43, 'admin/Article/save', '保存文章', 1, 1, 30, '', NULL, ''),
(44, 'admin/Article/edit', '编辑文章', 1, 1, 30, '', NULL, ''),
(45, 'admin/Article/update', '更新文章', 1, 1, 30, '', NULL, ''),
(46, 'admin/Article/delete', '删除文章', 1, 1, 30, '', NULL, ''),
(47, 'admin/Article/sorting', '列表排序', 1, 1, 30, '', NULL, ''),
(48, 'admin/Article/toggle', '文章审核状态切换', 1, 1, 30, '', NULL, ''),
(49, 'admin/Category/add', '添加分类', 1, 1, 38, '', NULL, ''),
(50, 'admin/Category/save', '保存分类', 1, 1, 38, '', NULL, ''),
(51, 'admin/Category/edit', '编辑分类', 1, 1, 38, '', NULL, ''),
(52, 'admin/Category/update', '更新分类', 1, 1, 38, '', NULL, ''),
(53, 'admin/Category/delete', '删除栏目', 1, 1, 38, '', NULL, ''),
(54, 'admin/Category/sorting', '列表排序', 1, 1, 38, '', NULL, ''),
(55, 'admin/Link/add', '添加友情链接', 1, 1, 40, '', NULL, ''),
(56, 'admin/Link/save', '保存友情链接', 1, 1, 40, '', NULL, ''),
(57, 'admin/Link/edit', '编辑友情链接', 1, 1, 40, '', NULL, ''),
(58, 'admin/Link/update', '更新友情链接', 1, 1, 40, '', NULL, ''),
(59, 'admin/Link/delete', '删除友情链接', 1, 1, 40, '', NULL, ''),
(60, 'admin/Link/switchStatus', '状态开关控制', 1, 1, 40, '', NULL, ''),
(61, 'admin/Link/sorting', '列表排序', 1, 1, 40, '', NULL, ''),
(62, 'admin/Navigation/add', '添加导航', 1, 1, 31, '', NULL, ''),
(63, 'admin/Navigation/save', '保存导航', 1, 1, 31, '', NULL, ''),
(64, 'admin/Navigation/edit', '编辑导航', 1, 1, 31, '', NULL, ''),
(65, 'admin/Navigation/update', '更新导航', 1, 1, 31, '', NULL, ''),
(66, 'admin/Navigation/delete', '删除导航', 1, 1, 31, '', NULL, ''),
(67, 'admin/Navigation/switchStatus', '状态开关控制', 1, 1, 31, '', NULL, ''),
(68, 'admin/Navigation/sorting', '列表排序', 1, 1, 31, '', NULL, ''),
(69, 'admin/System/updateSiteConfig', '更新站点配置', 1, 1, 41, '', NULL, ''),
(70, 'admin/System/dbConfig', '数据库配置', 1, 1, 41, '', NULL, '');

-- --------------------------------------------------------

--
-- 表的结构 `think_category`
--

CREATE TABLE IF NOT EXISTS `think_category` (
  `id` int(10) unsigned NOT NULL COMMENT '分类ID',
  `name` varchar(50) NOT NULL COMMENT '分类名称',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '分类类型  1  列表  2 单页',
  `sort` smallint(5) unsigned DEFAULT '0' COMMENT '排序',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `seotitle` varchar(128) DEFAULT NULL COMMENT 'seo标题',
  `seokeys` varchar(255) DEFAULT NULL COMMENT 'seo关键字',
  `seodesc` varchar(255) DEFAULT NULL COMMENT 'seo描述'
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='分类表';

--
-- 转存表中的数据 `think_category`
--

INSERT INTO `think_category` (`id`, `name`, `type`, `sort`, `pid`, `seotitle`, `seokeys`, `seodesc`) VALUES
(5, '服务器', 1, 1, 0, '', '', ''),
(6, '分类一子分类', 1, 1, 5, '分类一', '分类一', '分类一'),
(7, '测试', 1, 2, 5, '', '', '');

-- --------------------------------------------------------

--
-- 表的结构 `think_link`
--

CREATE TABLE IF NOT EXISTS `think_link` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '链接名称',
  `link` varchar(255) DEFAULT '' COMMENT '链接地址',
  `thumb` varchar(255) DEFAULT '' COMMENT '链接图片',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态 0 隐藏 1 显示',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序'
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='友情链接表';

--
-- 转存表中的数据 `think_link`
--

-- --------------------------------------------------------

--
-- 表的结构 `think_log`
--

CREATE TABLE IF NOT EXISTS `think_log` (
  `id` bigint(20) unsigned NOT NULL,
  `ip` char(15) NOT NULL DEFAULT '' COMMENT '操作者IP地址',
  `node` char(200) NOT NULL DEFAULT '' COMMENT '当前操作节点',
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '操作人用户名',
  `action` varchar(200) NOT NULL DEFAULT '' COMMENT '操作行为',
  `content` text NOT NULL COMMENT '操作内容描述',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB AUTO_INCREMENT=526 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统操作日志表';

--
-- 转存表中的数据 `think_log`
--


-- --------------------------------------------------------

--
-- 表的结构 `think_navigation`
--

CREATE TABLE IF NOT EXISTS `think_navigation` (
  `id` int(10) unsigned NOT NULL,
  `pid` int(10) unsigned NOT NULL COMMENT '父ID',
  `name` varchar(20) NOT NULL COMMENT '导航名称',
  `alias` varchar(20) DEFAULT '' COMMENT '导航别称',
  `link` varchar(255) DEFAULT '' COMMENT '导航链接',
  `icon` varchar(255) DEFAULT '' COMMENT '导航图标',
  `target` varchar(10) DEFAULT '' COMMENT '打开方式',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态  0 隐藏  1 显示',
  `sort` int(11) DEFAULT '0' COMMENT '排序'
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='导航表';

--
-- 转存表中的数据 `think_navigation`
--

INSERT INTO `think_navigation` (`id`, `pid`, `name`, `alias`, `link`, `icon`, `target`, `status`, `sort`) VALUES
(1, 0, '首页', '', '/', 'fa fa-home', '_self', 1, 2),
(2, 1, '首页子导航', '', '', '', '_self', 0, 1),
(4, 1, '首页子导航二', '', '', '', '_self', 0, 0),
(6, 1, '首页子导航三', '', '', '', '_self', 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `think_system`
--

CREATE TABLE IF NOT EXISTS `think_system` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '配置项名称',
  `value` text NOT NULL COMMENT '配置项值'
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统配置表';

--
-- 转存表中的数据 `think_system`
--

INSERT INTO `think_system` (`id`, `name`, `value`) VALUES
(1, 'site_config', 'a:4:{s:10:"site_title";s:12:"Jason''s Blog";s:11:"seo_keyword";s:5:"CBlog";s:15:"seo_description";s:17:"Cblog Description";s:8:"is_close";s:1:"0";}');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `think_admin_user`
--
ALTER TABLE `think_admin_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`) USING BTREE;

--
-- Indexes for table `think_article`
--
ALTER TABLE `think_article`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `en_title` (`en_title`) USING BTREE;

--
-- Indexes for table `think_auth_group`
--
ALTER TABLE `think_auth_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `think_auth_group_access`
--
ALTER TABLE `think_auth_group_access`
  ADD UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `think_auth_rule`
--
ALTER TABLE `think_auth_rule`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `think_category`
--
ALTER TABLE `think_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `think_link`
--
ALTER TABLE `think_link`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `think_log`
--
ALTER TABLE `think_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `think_navigation`
--
ALTER TABLE `think_navigation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `think_system`
--
ALTER TABLE `think_system`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `think_admin_user`
--
ALTER TABLE `think_admin_user`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `think_article`
--
ALTER TABLE `think_article`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章ID',AUTO_INCREMENT=47;
--
-- AUTO_INCREMENT for table `think_auth_group`
--
ALTER TABLE `think_auth_group`
  MODIFY `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `think_auth_rule`
--
ALTER TABLE `think_auth_rule`
  MODIFY `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=71;
--
-- AUTO_INCREMENT for table `think_category`
--
ALTER TABLE `think_category`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `think_link`
--
ALTER TABLE `think_link`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `think_log`
--
ALTER TABLE `think_log`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=526;
--
-- AUTO_INCREMENT for table `think_navigation`
--
ALTER TABLE `think_navigation`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `think_system`
--
ALTER TABLE `think_system`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
