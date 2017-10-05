/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : cblog

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2017-08-31 22:41:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for think_admin_user
-- ----------------------------
DROP TABLE IF EXISTS `think_admin_user`;
CREATE TABLE `think_admin_user` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '管理员用户名',
  `password` varchar(60) NOT NULL DEFAULT '' COMMENT '管理员密码',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态 1 启用 0 禁用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(20) DEFAULT NULL COMMENT '最后登录IP',
  `avatar` varchar(128) DEFAULT NULL COMMENT '头像',
  `editor` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of think_admin_user
-- ----------------------------
INSERT INTO `think_admin_user` VALUES ('1', 'admin', '$2y$10$MgRfMREFvWlPHSxweCD3g.eR5.sI2nXsnFFG7aZ2A/D.8lEORZWui', '1', '2016-10-18 15:28:37', '2017-08-31 22:29:56', '127.0.0.1', '');

-- ----------------------------
-- Table structure for think_article
-- ----------------------------
DROP TABLE IF EXISTS `think_article`;
CREATE TABLE `think_article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `cid` smallint(5) unsigned NOT NULL COMMENT '分类ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
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
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='文章表';

-- ----------------------------
-- Records of think_article
-- ----------------------------
INSERT INTO `think_article` VALUES ('32', '5', '文章', '', '', '<p><br></p>', 'admin', '1', '0', '', null, '1', '1', '0', '2017-08-31 21:04:53', '2017-08-31 21:04:17');

-- ----------------------------
-- Table structure for think_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `think_auth_group`;
CREATE TABLE `think_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL COMMENT '权限组描述',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_auth_group
-- ----------------------------
INSERT INTO `think_auth_group` VALUES ('1', '超级管理员', '1', '1,6,24,25,26,27,28,29,14,17,16,18,19,20,21,22,23,2,30,31,38,33,34,37', '管理所有权限');
INSERT INTO `think_auth_group` VALUES ('3', 'guest', '1', '1,4,8,10,6,24,26,14,16,18,2,30,42,44,31,62,64,38,49,51,33,34,37,41,39,40,55,57', '游客，只能浏览页面');

-- ----------------------------
-- Table structure for think_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `think_auth_group_access`;
CREATE TABLE `think_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_auth_group_access
-- ----------------------------
INSERT INTO `think_auth_group_access` VALUES ('1', '1');

-- ----------------------------
-- Table structure for think_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `think_auth_rule`;
CREATE TABLE `think_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '规则说明',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `pid` smallint(5) NOT NULL COMMENT '父级id',
  `icon` varchar(50) DEFAULT NULL COMMENT '图标',
  `sort` smallint(5) DEFAULT NULL COMMENT '排序',
  `condition` char(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of think_auth_rule
-- ----------------------------
INSERT INTO `think_auth_rule` VALUES ('1', 'admin/Auth/default', '权限管理', '1', '1', '0', 'fa fa-cogs', '1', '');
INSERT INTO `think_auth_rule` VALUES ('2', 'admin/Content/default', '内容管理', '1', '1', '0', 'fa fa-file-text-o', '5', '');
INSERT INTO `think_auth_rule` VALUES ('4', 'admin/Menu/index', '节点管理', '1', '1', '1', '', '10', '');
INSERT INTO `think_auth_rule` VALUES ('6', 'admin/AdminUser/index', '管理员管理', '1', '1', '1', 'fa fa-users', '13', '');
INSERT INTO `think_auth_rule` VALUES ('8', 'admin/Menu/add', '添加节点', '1', '1', '4', '', '3', '');
INSERT INTO `think_auth_rule` VALUES ('9', 'admin/Menu/save', '保存节点', '1', '1', '4', '', '5', '');
INSERT INTO `think_auth_rule` VALUES ('10', 'admin/Menu/edit', '编辑节点', '1', '1', '4', '', '6', '');
INSERT INTO `think_auth_rule` VALUES ('11', 'admin/Menu/update', '更新节点', '1', '1', '4', '', '6', '');
INSERT INTO `think_auth_rule` VALUES ('12', 'admin/Menu/delete', '删除节点', '1', '1', '4', '', '1', '');
INSERT INTO `think_auth_rule` VALUES ('13', 'admin/Menu/switchStatus', '节点状态开关控制', '1', '1', '4', '', '0', '');
INSERT INTO `think_auth_rule` VALUES ('14', 'admin/AuthGroup/index', '权限组管理', '1', '1', '1', '', '12', '');
INSERT INTO `think_auth_rule` VALUES ('17', 'admin/AuthGroup/save', '保存权限组', '1', '1', '14', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('15', 'admin/Menu/sorting', '节点列表排序', '1', '1', '4', '', '1', '');
INSERT INTO `think_auth_rule` VALUES ('16', 'admin/AuthGroup/add', '添加权限组', '1', '1', '14', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('18', 'admin/AuthGroup/edit', '编辑权限组', '1', '1', '14', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('19', 'admin/AuthGroup/update', '更新权限组', '1', '1', '14', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('20', 'admin/AuthGroup/delete', '删除权限组', '1', '1', '14', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('21', 'admin/AuthGroup/switchStatus', '权限组状态开关控制', '1', '1', '14', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('22', 'admin/AuthGroup/auth', '权限组授权', '1', '1', '14', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('23', 'admin/AuthGroup/updateAuthGroupRule', '更新权限组权限', '1', '1', '14', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('24', 'admin/AdminUser/add', '添加管理员', '1', '1', '6', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('25', 'admin/AdminUser/save', '保存管理员', '1', '1', '6', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('26', 'admin/AdminUser/edit', '编辑管理员', '1', '1', '6', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('27', 'admin/AdminUser/update', '更新管理员', '1', '1', '6', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('28', 'admin/AdminUser/delete', '删除管理员', '1', '1', '6', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('29', 'admin/AdminUser/switchStatus', '管理员状态开关控制', '1', '1', '6', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('30', 'admin/Article/index', '文章管理', '1', '1', '2', '', '1', '');
INSERT INTO `think_auth_rule` VALUES ('31', 'admin/Navigation/index', '导航管理', '1', '1', '2', '', '3', '');
INSERT INTO `think_auth_rule` VALUES ('38', 'admin/category/index', '分类管理', '1', '1', '2', '', '2', '');
INSERT INTO `think_auth_rule` VALUES ('33', 'admin/sys/default', '系统管理', '1', '1', '0', 'fa fa-cog', null, '');
INSERT INTO `think_auth_rule` VALUES ('34', 'admin/log/index', '日志管理', '1', '1', '33', 'fa fa-file-text-o', null, '');
INSERT INTO `think_auth_rule` VALUES ('35', 'admin/log/delete', '删除日志', '1', '1', '34', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('37', 'admin/log/default', '日志管理首页', '1', '1', '34', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('39', 'admin/extra/index', '扩展管理', '1', '1', '0', 'glyphicon glyphicon-fullscreen', null, '');
INSERT INTO `think_auth_rule` VALUES ('40', 'admin/link/index', '友情链接', '1', '1', '39', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('41', 'admin/system/siteconfig', '站点配置', '1', '1', '33', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('42', 'admin/Article/add', '添加文章', '1', '1', '30', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('43', 'admin/Article/save', '保存文章', '1', '1', '30', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('44', 'admin/Article/edit', '编辑文章', '1', '1', '30', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('45', 'admin/Article/update', '更新文章', '1', '1', '30', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('46', 'admin/Article/delete', '删除文章', '1', '1', '30', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('47', 'admin/Article/sorting', '列表排序', '1', '1', '30', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('48', 'admin/Article/toggle', '文章审核状态切换', '1', '1', '30', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('49', 'admin/Category/add', '添加分类', '1', '1', '38', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('50', 'admin/Category/save', '保存分类', '1', '1', '38', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('51', 'admin/Category/edit', '编辑分类', '1', '1', '38', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('52', 'admin/Category/update', '更新分类', '1', '1', '38', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('53', 'admin/Category/delete', '删除栏目', '1', '1', '38', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('54', 'admin/Category/sorting', '列表排序', '1', '1', '38', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('55', 'admin/Link/add', '添加友情链接', '1', '1', '40', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('56', 'admin/Link/save', '保存友情链接', '1', '1', '40', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('57', 'admin/Link/edit', '编辑友情链接', '1', '1', '40', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('58', 'admin/Link/update', '更新友情链接', '1', '1', '40', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('59', 'admin/Link/delete', '删除友情链接', '1', '1', '40', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('60', 'admin/Link/switchStatus', '状态开关控制', '1', '1', '40', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('61', 'admin/Link/sorting', '列表排序', '1', '1', '40', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('62', 'admin/Navigation/add', '添加导航', '1', '1', '31', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('63', 'admin/Navigation/save', '保存导航', '1', '1', '31', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('64', 'admin/Navigation/edit', '编辑导航', '1', '1', '31', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('65', 'admin/Navigation/update', '更新导航', '1', '1', '31', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('66', 'admin/Navigation/delete', '删除导航', '1', '1', '31', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('67', 'admin/Navigation/switchStatus', '状态开关控制', '1', '1', '31', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('68', 'admin/Navigation/sorting', '列表排序', '1', '1', '31', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('69', 'admin/System/updateSiteConfig', '更新站点配置', '1', '1', '41', '', null, '');
INSERT INTO `think_auth_rule` VALUES ('70', 'admin/System/dbConfig', '数据库配置', '1', '1', '41', '', null, '');

-- ----------------------------
-- Table structure for think_category
-- ----------------------------
DROP TABLE IF EXISTS `think_category`;
CREATE TABLE `think_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(50) NOT NULL COMMENT '分类名称',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '分类类型  1  列表  2 单页',
  `sort` smallint(5) unsigned DEFAULT '0' COMMENT '排序',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `seotitle` varchar(128) DEFAULT NULL COMMENT 'seo标题',
  `seokeys` varchar(255) DEFAULT NULL COMMENT 'seo关键字',
  `seodesc` varchar(255) DEFAULT NULL COMMENT 'seo描述',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='分类表';

-- ----------------------------
-- Records of think_category
-- ----------------------------
INSERT INTO `think_category` VALUES ('5', '分类一', '1', '0', '0', '', '', '');

-- ----------------------------
-- Table structure for think_link
-- ----------------------------
DROP TABLE IF EXISTS `think_link`;
CREATE TABLE `think_link` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '链接名称',
  `link` varchar(255) DEFAULT '' COMMENT '链接地址',
  `thumb` varchar(255) DEFAULT '' COMMENT '链接图片',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态 0 隐藏 1 显示',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='友情链接表';

-- ----------------------------
-- Records of think_link
-- ----------------------------

-- ----------------------------
-- Table structure for think_log
-- ----------------------------
DROP TABLE IF EXISTS `think_log`;
CREATE TABLE `think_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ip` char(15) NOT NULL DEFAULT '' COMMENT '操作者IP地址',
  `node` char(200) NOT NULL DEFAULT '' COMMENT '当前操作节点',
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '操作人用户名',
  `action` varchar(200) NOT NULL DEFAULT '' COMMENT '操作行为',
  `content` text NOT NULL COMMENT '操作内容描述',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=254 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统操作日志表';

-- ----------------------------
-- Records of think_log
-- ----------------------------

-- ----------------------------
-- Table structure for think_navigation
-- ----------------------------
DROP TABLE IF EXISTS `think_navigation`;
CREATE TABLE `think_navigation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL COMMENT '父ID',
  `name` varchar(20) NOT NULL COMMENT '导航名称',
  `alias` varchar(20) DEFAULT '' COMMENT '导航别称',
  `link` varchar(255) DEFAULT '' COMMENT '导航链接',
  `icon` varchar(255) DEFAULT '' COMMENT '导航图标',
  `target` varchar(10) DEFAULT '' COMMENT '打开方式',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态  0 隐藏  1 显示',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='导航表';

-- ----------------------------
-- Records of think_navigation
-- ----------------------------
INSERT INTO `think_navigation` VALUES ('1', '0', '首页', '', '/', 'fa fa-home', '_self', '1', '0');

-- ----------------------------
-- Table structure for think_system
-- ----------------------------
DROP TABLE IF EXISTS `think_system`;
CREATE TABLE `think_system` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '配置项名称',
  `value` text NOT NULL COMMENT '配置项值',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统配置表';

-- ----------------------------
-- Records of think_system
-- ----------------------------
INSERT INTO `think_system` VALUES ('1', 'site_config', 'a:4:{s:10:\"site_title\";s:4:\"Blog\";s:11:\"seo_keyword\";s:4:\"Blog\";s:15:\"seo_description\";s:16:\"Blog Description\";s:8:\"is_close\";s:1:\"0\";}');
