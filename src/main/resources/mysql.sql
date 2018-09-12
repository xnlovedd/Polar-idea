/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50556
Source Host           : localhost:3306
Source Database       : polar

Target Server Type    : MYSQL
Target Server Version : 50556
File Encoding         : 65001

Date: 2018-07-26 14:22:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_polar_attachment
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_attachment`;
CREATE TABLE `t_polar_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visitPath` varchar(2000) NOT NULL COMMENT '访问路径',
  `attachmentId` varchar(50) NOT NULL COMMENT '外键编号',
  `typeStr` varchar(500) NOT NULL COMMENT '文件类型，一般以表名+字段名',
  `createDate` datetime NOT NULL COMMENT '创建时间',
  `createDateMillions` bigint(30) NOT NULL COMMENT '创建时间毫秒',
  `pid` varchar(50) DEFAULT NULL COMMENT '其他外键编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_polar_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for t_polar_columns
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_columns`;
CREATE TABLE `t_polar_columns` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tableId` bigint(20) NOT NULL,
  `name` varchar(500) NOT NULL COMMENT '字段名称',
  `commont` varchar(500) DEFAULT NULL COMMENT '注释',
  `type` int(2) NOT NULL COMMENT '字段类型,0-单行文本,1-文本域,2-整数,3-浮点数,4-日期,5-富文本编辑器,6-下拉列表,7-树形结构,8-隐藏,9-大整数,10-文件',
  `groupName` varchar(500) DEFAULT NULL COMMENT '组名,下拉或者树形菜单时有效。',
  `javaName` varchar(500) NOT NULL COMMENT 'java列名称',
  `remark` varchar(500) NOT NULL COMMENT 'listShown',
  `search` int(1) NOT NULL COMMENT '是否作为查询条件,0-否,1-是',
  `listShown` int(1) NOT NULL COMMENT '是否列表显示,0-否,1-是',
  `listReturn` int(1) DEFAULT '1' COMMENT '是否列表返回（0-否，1-是）',
  `innerEdit` int(1) NOT NULL COMMENT '是否表内编辑,0-否,1-是',
  `required` int(1) NOT NULL COMMENT '是否必填,0-否,1-是',
  `orderBy` int(1) NOT NULL DEFAULT '0' COMMENT '是否可排序,0-否,1-是',
  `phone` int(1) NOT NULL DEFAULT '0' COMMENT '是否为手机号,0-否,1-是',
  `email` int(1) NOT NULL DEFAULT '0' COMMENT '是否为邮箱,0-否,1-是',
  `identity` int(1) NOT NULL DEFAULT '0' COMMENT '是否为身份证号,0-否,1-是',
  `matchStyle` int(1) NOT NULL DEFAULT '0' COMMENT '匹配方式',
  `orderNum` int(5) DEFAULT '0' COMMENT '排序编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='代码生成器中生成的表的列属性';

-- ----------------------------
-- Records of t_polar_columns
-- ----------------------------

-- ----------------------------
-- Table structure for t_polar_dict
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_dict`;
CREATE TABLE `t_polar_dict` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键编号',
  `text` varchar(500) NOT NULL COMMENT '文本内容',
  `value` varchar(500) NOT NULL COMMENT '值',
  `remark` varchar(255) DEFAULT NULL,
  `orderNum` bigint(11) NOT NULL DEFAULT '0' COMMENT '排序号',
  `groupId` varchar(255) NOT NULL COMMENT '组名',
  `groupName` varchar(500) DEFAULT NULL COMMENT '组名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字典表';

-- ----------------------------
-- Records of t_polar_dict
-- ----------------------------

-- ----------------------------
-- Table structure for t_polar_logs
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_logs`;
CREATE TABLE `t_polar_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(5000) DEFAULT NULL COMMENT '错误信息',
  `interfaceName` varchar(2000) DEFAULT NULL COMMENT '接口名称',
  `caseBy` mediumtext COMMENT '引起的原因',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `createTimeMillions` bigint(11) DEFAULT NULL COMMENT '创建时间毫秒',
  `userId` varchar(50) DEFAULT NULL COMMENT '当前登录用户',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='日志记录表';

-- ----------------------------
-- Records of t_polar_logs
-- ----------------------------

-- ----------------------------
-- Table structure for t_polar_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_menu`;
CREATE TABLE `t_polar_menu` (
  `id` bigint(50) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `parentId` bigint(50) DEFAULT NULL,
  `name` varchar(500) NOT NULL COMMENT '菜单名称',
  `icon` varchar(255) DEFAULT NULL COMMENT '菜单图标',
  `path` varchar(2000) DEFAULT NULL COMMENT '访问路径',
  `orderNum` int(11) NOT NULL COMMENT '排序号',
  `defaultOpen` int(1) NOT NULL DEFAULT '0' COMMENT '默认展开（0-不展开，1-展开）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COMMENT='菜单';

-- ----------------------------
-- Records of t_polar_menu
-- ----------------------------
INSERT INTO `t_polar_menu` VALUES ('1', null, '首页', 'home', '/firstPage', '1', '0');
INSERT INTO `t_polar_menu` VALUES ('2', null, '数据管理', 'database', null, '2', '1');
INSERT INTO `t_polar_menu` VALUES ('3', '2', '字典管理', 'book', '/dict/web', '1', '0');
INSERT INTO `t_polar_menu` VALUES ('4', '2', '树结构管理', 'tree', '/tree/web', '2', '0');
INSERT INTO `t_polar_menu` VALUES ('5', null, '日志管理', 'file-text-o', '/logs/web', '3', '0');
INSERT INTO `t_polar_menu` VALUES ('6', null, '权限管理', 'lock', null, '4', '0');
INSERT INTO `t_polar_menu` VALUES ('7', '6', '权限管理', 'lock', '/permission/web', '1', '0');
INSERT INTO `t_polar_menu` VALUES ('8', '6', '角色管理', 'users', '/role/web', '2', '0');
INSERT INTO `t_polar_menu` VALUES ('9', '6', '资源管理', 'link', '/resource/web', '3', '0');
INSERT INTO `t_polar_menu` VALUES ('10', null, '菜单管理', 'reorder', null, '5', '0');
INSERT INTO `t_polar_menu` VALUES ('11', '10', '模板管理', 'edit', '/menuModel/web', '1', '0');
INSERT INTO `t_polar_menu` VALUES ('12', '10', '菜单管理', 'th-list', '/menu/web', '2', '0');
INSERT INTO `t_polar_menu` VALUES ('13', null, '代码生成', 'code', '/code/web', '6', '0');
INSERT INTO `t_polar_menu` VALUES ('14', '16', '用户管理', 'user', '/user/web', '1', '0');
INSERT INTO `t_polar_menu` VALUES ('15', null, '访问记录', 'history', '/records/web', '8', '0');
INSERT INTO `t_polar_menu` VALUES ('16', null, '系统管理', 'cog', null, '7', '0');
INSERT INTO `t_polar_menu` VALUES ('17', '16', '机构管理', 'group', '/org/web', '2', '0');
INSERT INTO `t_polar_menu` VALUES ('18', null, '开发文档', 'file-code-o', null, '9', '0');
INSERT INTO `t_polar_menu` VALUES ('19', '18', '前端', null, null, '1', '0');
INSERT INTO `t_polar_menu` VALUES ('20', '18', '后台', null, null, '2', '0');
INSERT INTO `t_polar_menu` VALUES ('21', '19', 'js文档', null, null, '2', '0');
INSERT INTO `t_polar_menu` VALUES ('22', '21', '加载器', null, '/developmentDocument?folder=front,js,loader,loader', '6', '0');
INSERT INTO `t_polar_menu` VALUES ('23', '21', '基础文档', null, '/developmentDocument?folder=front,js,common,common', '1', '0');
INSERT INTO `t_polar_menu` VALUES ('24', '21', '对话框', null, '/developmentDocument?folder=front,js,dialog,dialog', '2', '0');
INSERT INTO `t_polar_menu` VALUES ('25', '21', '图层', null, '/developmentDocument?folder=front,js,layer,layer', '5', '0');
INSERT INTO `t_polar_menu` VALUES ('26', '21', '表单', null, '/developmentDocument?folder=front,js,form,form', '4', '0');
INSERT INTO `t_polar_menu` VALUES ('27', '21', '表格', null, null, '7', '0');
INSERT INTO `t_polar_menu` VALUES ('28', '27', '普通表格', null, '/developmentDocument?folder=front,js,table,table', '1', '0');
INSERT INTO `t_polar_menu` VALUES ('29', '27', '静态表格', null, '/developmentDocument?folder=front,js,table,static', '2', '0');
INSERT INTO `t_polar_menu` VALUES ('30', '27', '树结构表格', null, '/developmentDocument?folder=front,js,table,tree', '3', '0');
INSERT INTO `t_polar_menu` VALUES ('31', '19', '标签库', null, null, '3', '0');
INSERT INTO `t_polar_menu` VALUES ('32', '31', '输入框', null, '/developmentDocument?folder=front,tag,input', '1', '0');
INSERT INTO `t_polar_menu` VALUES ('33', '31', '引入标签库', null, '/developmentDocument?folder=front,tag,importtag', '0', '0');
INSERT INTO `t_polar_menu` VALUES ('34', '31', '下拉列表', null, '/developmentDocument?folder=front,tag,select', '2', '0');
INSERT INTO `t_polar_menu` VALUES ('35', '31', '复选框', null, '/developmentDocument?folder=front,tag,ck', '3', '0');
INSERT INTO `t_polar_menu` VALUES ('36', '31', '区域选择', null, '/developmentDocument?folder=front,tag,area', '4', '0');
INSERT INTO `t_polar_menu` VALUES ('37', '31', '树结构', null, '/developmentDocument?folder=front,tag,tree', '5', '0');
INSERT INTO `t_polar_menu` VALUES ('38', '31', '文本域', null, '/developmentDocument?folder=front,tag,textarea', '6', '0');
INSERT INTO `t_polar_menu` VALUES ('39', '31', '富文本', null, '/developmentDocument?folder=front,tag,richtext', '7', '0');
INSERT INTO `t_polar_menu` VALUES ('40', '31', '图片上传', null, '/developmentDocument?folder=front,tag,img', '8', '0');
INSERT INTO `t_polar_menu` VALUES ('41', '31', '文件上传', null, '/developmentDocument?folder=front,tag,file', '9', '0');
INSERT INTO `t_polar_menu` VALUES ('42', '31', '数据操作', null, '/developmentDocument?folder=front,tag,data', '10', '0');
INSERT INTO `t_polar_menu` VALUES ('43', '19', 'css', null, null, '1', '0');
INSERT INTO `t_polar_menu` VALUES ('44', '43', '列表', null, '/developmentDocument?folder=front,css,list,list', '1', '0');
INSERT INTO `t_polar_menu` VALUES ('45', '43', '详情', null, '/developmentDocument?folder=front,css,detail,detail', '2', '0');
INSERT INTO `t_polar_menu` VALUES ('46', '20', '缓存', null, '/developmentDocument?folder=background,cache,cache', '1', '0');
INSERT INTO `t_polar_menu` VALUES ('47', '20', '异常处理', null, '/developmentDocument?folder=background,err,err', '2', '0');
INSERT INTO `t_polar_menu` VALUES ('48', '20', '数据校验', null, '/developmentDocument?folder=background,validate,validate', '3', '0');

-- ----------------------------
-- Table structure for t_polar_menu_model
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_menu_model`;
CREATE TABLE `t_polar_menu_model` (
  `id` bigint(50) NOT NULL AUTO_INCREMENT,
  `name` varchar(500) NOT NULL COMMENT '模板名称',
  `info` varchar(2000) DEFAULT NULL COMMENT '模板描述',
  `defaultMenu` int(11) NOT NULL DEFAULT '0' COMMENT '默认模板（0-否，1-是）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='菜单模板';

-- ----------------------------
-- Records of t_polar_menu_model
-- ----------------------------
INSERT INTO `t_polar_menu_model` VALUES ('1', '默认菜单', '默认菜单，所有后台用户默认使用此菜单。', '1');

-- ----------------------------
-- Table structure for t_polar_menumodel_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_menumodel_menu`;
CREATE TABLE `t_polar_menumodel_menu` (
  `id` bigint(50) NOT NULL AUTO_INCREMENT,
  `menuId` bigint(50) NOT NULL COMMENT '菜单编号',
  `menuModelId` bigint(50) NOT NULL COMMENT '菜单模板编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `union_key_menu_menuModel` (`menuId`,`menuModelId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='菜单模板-菜单表';

-- ----------------------------
-- Records of t_polar_menumodel_menu
-- ----------------------------
INSERT INTO `t_polar_menumodel_menu` VALUES ('18', '1', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('19', '2', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('20', '3', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('21', '4', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('22', '5', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('23', '6', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('24', '7', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('25', '8', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('26', '9', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('27', '10', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('28', '11', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('29', '12', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('30', '13', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('32', '14', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('34', '15', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('31', '16', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('33', '17', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('35', '18', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('36', '19', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('62', '20', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('40', '21', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('45', '22', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('41', '23', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('42', '24', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('44', '25', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('43', '26', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('46', '27', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('47', '28', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('48', '29', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('49', '30', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('50', '31', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('52', '32', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('51', '33', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('53', '34', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('54', '35', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('55', '36', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('56', '37', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('57', '38', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('58', '39', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('59', '40', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('60', '41', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('61', '42', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('37', '43', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('38', '44', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('39', '45', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('63', '46', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('64', '47', '1');
INSERT INTO `t_polar_menumodel_menu` VALUES ('65', '48', '1');

-- ----------------------------
-- Table structure for t_polar_org
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_org`;
CREATE TABLE `t_polar_org` (
  `id` bigint(50) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '机构名称',
  `parentId` bigint(50) DEFAULT NULL COMMENT '上级编号',
  `org_code` varchar(255) DEFAULT NULL COMMENT '编号',
  `contact_people` varchar(255) DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(255) DEFAULT NULL COMMENT '联系人手机号',
  `contact_email` varchar(255) DEFAULT NULL COMMENT '联系人邮箱',
  `org_describe` varchar(5000) DEFAULT NULL COMMENT '机构描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_polar_org
-- ----------------------------

-- ----------------------------
-- Table structure for t_polar_org_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_org_permission`;
CREATE TABLE `t_polar_org_permission` (
  `id` bigint(50) NOT NULL AUTO_INCREMENT,
  `permissionId` bigint(50) NOT NULL COMMENT '权限编号',
  `orgId` bigint(50) NOT NULL COMMENT '机构编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='机构-权限';

-- ----------------------------
-- Records of t_polar_org_permission
-- ----------------------------

-- ----------------------------
-- Table structure for t_polar_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_permission`;
CREATE TABLE `t_polar_permission` (
  `id` bigint(50) NOT NULL AUTO_INCREMENT COMMENT '排序号',
  `parentId` bigint(50) DEFAULT NULL COMMENT '父类ID',
  `name` varchar(200) NOT NULL COMMENT '权限名称',
  `text` varchar(500) NOT NULL COMMENT '权限中文名称',
  `info` varchar(2000) DEFAULT NULL COMMENT '权限描述',
  `orderNum` bigint(50) NOT NULL COMMENT '排序号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unoin_key_permission` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_polar_permission
-- ----------------------------
INSERT INTO `t_polar_permission` VALUES ('1', null, 'polar:backstage', '后台管理', '后台管理的基础角色，只有拥有此角色才可以管理后台。', '1');
INSERT INTO `t_polar_permission` VALUES ('2', null, 'polar:permission:empty', '权限管理', '权限管理的空白权限，用于分组', '2');
INSERT INTO `t_polar_permission` VALUES ('3', '2', 'polar:permission:add', '新增权限', '新增权限', '1');
INSERT INTO `t_polar_permission` VALUES ('4', '2', 'polar:permission:delete', '删除权限', '删除权限', '2');
INSERT INTO `t_polar_permission` VALUES ('5', '2', 'polar:permission:edit', '修改权限', '修改权限的权限', '3');
INSERT INTO `t_polar_permission` VALUES ('6', '2', 'polar:permission:view:list', '查看权限列表', '查看权限列表的权限', '4');
INSERT INTO `t_polar_permission` VALUES ('7', '2', 'polar:permission:view:detail', '权限详情', '查看权限详情的权限', '5');
INSERT INTO `t_polar_permission` VALUES ('8', null, 'polar:role:empty', '角色管理', '角色管理的空白权限，用于分组', '3');
INSERT INTO `t_polar_permission` VALUES ('9', '8', 'polar:role:add', '新增角色', '新增角色', '1');
INSERT INTO `t_polar_permission` VALUES ('10', '8', 'polar:role:delete', '删除角色', '删除角色', '2');
INSERT INTO `t_polar_permission` VALUES ('11', '8', 'polar:role:edit', '修改角色', '修改角色的权限', '3');
INSERT INTO `t_polar_permission` VALUES ('12', '8', 'polar:role:view:list', '查看角色列表', '查看角色列表的权限', '4');
INSERT INTO `t_polar_permission` VALUES ('13', '8', 'polar:role:view:detail', '角色详情', '查看角色详情的权限', '5');
INSERT INTO `t_polar_permission` VALUES ('14', null, 'polar:resource:empty', '资源管理', '资源管理的空白权限，用于分组', '4');
INSERT INTO `t_polar_permission` VALUES ('15', '14', 'polar:resource:add', '新增资源', '新增资源', '1');
INSERT INTO `t_polar_permission` VALUES ('16', '14', 'polar:resource:delete', '删除资源', '删除资源', '2');
INSERT INTO `t_polar_permission` VALUES ('17', '14', 'polar:resource:edit', '修改资源', '修改资源的权限', '3');
INSERT INTO `t_polar_permission` VALUES ('18', '14', 'polar:resource:view:list', '查看资源列表', '查看资源列表的权限', '4');
INSERT INTO `t_polar_permission` VALUES ('19', '14', 'polar:resource:view:detail', '资源详情', '查看资源详情的权限', '5');
INSERT INTO `t_polar_permission` VALUES ('20', '14', 'polar:resource:reload', '重新加载资源', '重新加载资源', '6');
INSERT INTO `t_polar_permission` VALUES ('21', null, 'polar:user:empty', '用户管理', '用户管理的空白权限，用于分组', '5');
INSERT INTO `t_polar_permission` VALUES ('22', '21', 'polar:user:add', '新增用户', '新增用户', '1');
INSERT INTO `t_polar_permission` VALUES ('23', '21', 'polar:user:delete', '删除用户', '删除用户', '2');
INSERT INTO `t_polar_permission` VALUES ('24', '21', 'polar:user:edit', '修改用户', '修改用户的权限', '3');
INSERT INTO `t_polar_permission` VALUES ('25', '21', 'polar:user:view:list', '查看用户列表', '查看用户列表的权限', '4');
INSERT INTO `t_polar_permission` VALUES ('26', '21', 'polar:user:view:detail', '用户详情', '查看用户详情的权限', '5');
INSERT INTO `t_polar_permission` VALUES ('27', '21', 'polar:user:role:empty', '分配角色', '给用户分配角色的权限', '6');
INSERT INTO `t_polar_permission` VALUES ('28', null, 'polar:menumodel', '菜单模板管理', '菜单模板管理的空白权限，用于分组', '6');
INSERT INTO `t_polar_permission` VALUES ('29', '28', 'polar:menumodel:add', '新增菜单模板', '新增菜单模板', '1');
INSERT INTO `t_polar_permission` VALUES ('30', '28', 'polar:menumodel:delete', '删除菜单模板', '删除菜单模板', '2');
INSERT INTO `t_polar_permission` VALUES ('31', '28', 'polar:menumodel:edit', '修改菜单模板', '修改菜单模板的权限', '3');
INSERT INTO `t_polar_permission` VALUES ('32', '28', 'polar:menumodel:view:list', '查看菜单模板列表', '查看菜单模板列表的权限', '4');
INSERT INTO `t_polar_permission` VALUES ('33', '28', 'polar:menumodel:view:detail', '菜单模板详情', '查看菜单模板详情的权限', '5');
INSERT INTO `t_polar_permission` VALUES ('34', '28', 'polar:menumodel:default', '设置默认菜单', '设置默认菜单', '6');
INSERT INTO `t_polar_permission` VALUES ('35', '28', 'polar:menumodel:menu', '分配菜单', '分配菜单', '7');
INSERT INTO `t_polar_permission` VALUES ('36', null, 'polar:menu:empty', '菜单管理', '菜单管理的空白权限，用于分组', '7');
INSERT INTO `t_polar_permission` VALUES ('37', '36', 'polar:menu:add', '新增菜单', '新增菜单', '1');
INSERT INTO `t_polar_permission` VALUES ('38', '36', 'polar:menu:delete', '删除菜单', '删除菜单', '2');
INSERT INTO `t_polar_permission` VALUES ('39', '36', 'polar:menu:edit', '修改菜单', '修改菜单的权限', '3');
INSERT INTO `t_polar_permission` VALUES ('40', '36', 'polar:menu:view:list', '查看菜单列表', '查看菜单列表的权限', '4');
INSERT INTO `t_polar_permission` VALUES ('41', '36', 'polar:menu:view:detail', '菜单详情', '查看菜单详情的权限', '5');
INSERT INTO `t_polar_permission` VALUES ('42', null, 'polar:dict:empty', '字典管理', '字典管理的空白权限，用于分组', '8');
INSERT INTO `t_polar_permission` VALUES ('43', '42', 'polar:dict:add', '新增字典', '新增字典', '1');
INSERT INTO `t_polar_permission` VALUES ('44', '42', 'polar:dict:delete', '删除字典', '删除字典', '2');
INSERT INTO `t_polar_permission` VALUES ('45', '42', 'polar:dict:edit', '修改字典', '修改字典的权限', '3');
INSERT INTO `t_polar_permission` VALUES ('46', '42', 'polar:dict:view:list', '查看字典列表', '查看字典列表的权限', '4');
INSERT INTO `t_polar_permission` VALUES ('47', '42', 'polar:dict:view:detail', '字典详情', '查看字典详情的权限', '5');
INSERT INTO `t_polar_permission` VALUES ('48', null, 'polar:tree:empty', '树结构管理', '树结构管理的空白权限，用于分组', '9');
INSERT INTO `t_polar_permission` VALUES ('49', '48', 'polar:tree:add', '新增树结构', '新增树结构', '1');
INSERT INTO `t_polar_permission` VALUES ('50', '48', 'polar:tree:delete', '删除树结构', '删除树结构', '2');
INSERT INTO `t_polar_permission` VALUES ('51', '48', 'polar:tree:edit', '修改树结构', '修改树结构的权限', '3');
INSERT INTO `t_polar_permission` VALUES ('52', '48', 'polar:tree:view:list', '查看树结构列表', '查看树结构列表的权限', '4');
INSERT INTO `t_polar_permission` VALUES ('53', '48', 'polar:tree:view:detail', '树结构详情', '查看树结构详情的权限', '5');
INSERT INTO `t_polar_permission` VALUES ('54', null, 'polar:log:empty', '日志管理', '日志管理的空白权限，用于分组', '10');
INSERT INTO `t_polar_permission` VALUES ('55', '54', 'polar:log:add', '新增日志', '新增日志', '1');
INSERT INTO `t_polar_permission` VALUES ('56', '54', 'polar:log:delete', '删除日志', '删除日志', '2');
INSERT INTO `t_polar_permission` VALUES ('57', '54', 'polar:log:edit', '修改日志', '修改日志的权限', '3');
INSERT INTO `t_polar_permission` VALUES ('58', '54', 'polar:log:view:list', '查看日志列表', '查看日志列表的权限', '4');
INSERT INTO `t_polar_permission` VALUES ('59', '54', 'polar:log:view:detail', '日志详情', '查看日志详情的权限', '5');
INSERT INTO `t_polar_permission` VALUES ('60', null, 'polar:code:empty', '代码生成管理', '代码生成管理的空白权限，用于分组', '11');
INSERT INTO `t_polar_permission` VALUES ('62', '60', 'polar:code:delete', '删除代码', '删除代码', '2');
INSERT INTO `t_polar_permission` VALUES ('63', '60', 'polar:code:edit', '修改代码', '修改代码的权限', '3');
INSERT INTO `t_polar_permission` VALUES ('64', '60', 'polar:code:view:list', '查看代码列表', '查看代码列表的权限', '4');
INSERT INTO `t_polar_permission` VALUES ('65', '60', 'polar:code:view:detail', '代码详情', '查看代码详情的权限', '5');
INSERT INTO `t_polar_permission` VALUES ('66', '60', 'polar:code:columns', '列配置', '代码生成的列操作权限', '6');
INSERT INTO `t_polar_permission` VALUES ('67', '60', 'polar:code:code', '生成代码', '生成代码的权限', '7');
INSERT INTO `t_polar_permission` VALUES ('68', '60', 'polar:code:setting', '生成配置', '生成配置的权限', '8');
INSERT INTO `t_polar_permission` VALUES ('70', '21', 'polar:user:reset', '重置缓存', '重置用户的缓存，包括其菜单、权限等数据', '8');
INSERT INTO `t_polar_permission` VALUES ('71', '8', 'polar:role:permission', '修改角色权限', '修改角色权限', '6');
INSERT INTO `t_polar_permission` VALUES ('72', '14', 'polar:resource:permission', '资源权限', '修改资源权限的权限', '7');
INSERT INTO `t_polar_permission` VALUES ('73', '21', 'polar:user:menu', '分配用户菜单', '分配用户菜单', '9');
INSERT INTO `t_polar_permission` VALUES ('74', '21', 'polar:user:clear:userMenu', '清除用户菜单缓存', '清除用户菜单缓存', '10');
INSERT INTO `t_polar_permission` VALUES ('75', '21', 'polar:user:clear:allMenu', '清除用户所有菜单缓存', '清除用户所有菜单缓存', '11');
INSERT INTO `t_polar_permission` VALUES ('76', '21', 'polar:user:clear:userInfo', '清除用户权限缓存', '清除用户权限缓存', '12');
INSERT INTO `t_polar_permission` VALUES ('77', '21', 'polar:user:clear:allInfo', '清除用户所有权限缓存', '清除用户所有权限缓存', '13');
INSERT INTO `t_polar_permission` VALUES ('78', null, 'polar:records:empty', '访问记录', '访问记录的空白权限，用于分组', '12');
INSERT INTO `t_polar_permission` VALUES ('79', '78', 'polar:records:list', '查看访问记录列表', '查看访问记录列表', '1');
INSERT INTO `t_polar_permission` VALUES ('80', '78', 'polar:records:detail', '查看访问记录详情', '查看访问记录详情', '2');
INSERT INTO `t_polar_permission` VALUES ('81', '78', 'polar:records:delete', '删除访问记录', '删除访问记录', '3');
INSERT INTO `t_polar_permission` VALUES ('82', '21', 'polar:online:view', '查看在线用户', '查看在线用户', '16');
INSERT INTO `t_polar_permission` VALUES ('83', '21', 'polar:online:downline', '强制下线', '强制下线', '17');
INSERT INTO `t_polar_permission` VALUES ('84', '21', 'polar:user:disableUser', '禁用用户', '禁用用户', '14');
INSERT INTO `t_polar_permission` VALUES ('85', '21', 'polar:user:enableUser', '启用用户', '启用用户', '15');
INSERT INTO `t_polar_permission` VALUES ('86', null, 'polar:org:empty', '机构管理', '机构管理的空白权限，用于分组', '18');
INSERT INTO `t_polar_permission` VALUES ('87', '86', 'polar:org:add', '新增机构', '新增机构', '1');
INSERT INTO `t_polar_permission` VALUES ('88', '86', 'polar:org:delete', '删除机构', '删除机构', '2');
INSERT INTO `t_polar_permission` VALUES ('89', '86', 'polar:org:edit', '修改机构', '修改机构的权限', '3');
INSERT INTO `t_polar_permission` VALUES ('90', '86', 'polar:org:view:list', '查看机构列表', '查看机构列表的权限', '4');
INSERT INTO `t_polar_permission` VALUES ('91', '86', 'polar:org:view:detail', '机构详情', '查看机构详情的权限', '5');
INSERT INTO `t_polar_permission` VALUES ('92', '86', 'polar:org:excell:import', '导入机构', '导入机构的权限', '6');
INSERT INTO `t_polar_permission` VALUES ('93', '86', 'polar:org:excell:export', '导出机构', '导出机构的权限', '7');
INSERT INTO `t_polar_permission` VALUES ('94', '86', 'polar:org:permission', '分配权限', '分配机构权限', '8');

-- ----------------------------
-- Table structure for t_polar_resource
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_resource`;
CREATE TABLE `t_polar_resource` (
  `id` bigint(50) NOT NULL AUTO_INCREMENT COMMENT '数据编号',
  `name` varchar(500) NOT NULL COMMENT '名称',
  `path` varchar(2000) NOT NULL COMMENT '访问路径',
  `info` varchar(2000) DEFAULT NULL COMMENT '描述',
  `orderNum` bigint(50) NOT NULL DEFAULT '1' COMMENT '排序号',
  `text` varchar(500) DEFAULT NULL COMMENT '中文名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源表';

-- ----------------------------
-- Records of t_polar_resource
-- ----------------------------

-- ----------------------------
-- Table structure for t_polar_resource_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_resource_permission`;
CREATE TABLE `t_polar_resource_permission` (
  `id` bigint(50) NOT NULL AUTO_INCREMENT,
  `resourceId` bigint(50) NOT NULL COMMENT '角色编号',
  `permissionId` bigint(50) NOT NULL COMMENT '权限编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unoin_key_resource_permission` (`resourceId`,`permissionId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源-权限管理表';

-- ----------------------------
-- Records of t_polar_resource_permission
-- ----------------------------

-- ----------------------------
-- Table structure for t_polar_role
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_role`;
CREATE TABLE `t_polar_role` (
  `id` bigint(50) NOT NULL AUTO_INCREMENT COMMENT '排序号',
  `parentId` bigint(50) DEFAULT NULL COMMENT '父类id',
  `name` varchar(200) NOT NULL COMMENT '角色名称',
  `text` varchar(500) NOT NULL COMMENT '角色中文名称',
  `info` varchar(2000) DEFAULT NULL COMMENT '角色描述',
  `orderNum` bigint(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unoin_key_role` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_polar_role
-- ----------------------------
INSERT INTO `t_polar_role` VALUES ('1', null, 'superAdmin', '超级管理员', '超级管理员，拥有所有的权限', '1');
INSERT INTO `t_polar_role` VALUES ('2', null, 'dataAdmin', '数据管理员', '数据管理员，可以管理：字典、日志、树结构', '2');
INSERT INTO `t_polar_role` VALUES ('3', null, 'menuAdmin', '菜单管理员', '可以管理菜单、菜单模板', '3');
INSERT INTO `t_polar_role` VALUES ('4', null, 'userAdmin', '用户管理员', '可以管理用户的信息', '4');
INSERT INTO `t_polar_role` VALUES ('5', null, 'itAdmin', '屌丝程序员', '可以生成代码', '5');
INSERT INTO `t_polar_role` VALUES ('6', null, 'bugReporter', 'BUG调试员', 'bug调试员，含有日志管理的权限', '6');

-- ----------------------------
-- Table structure for t_polar_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_role_permission`;
CREATE TABLE `t_polar_role_permission` (
  `id` bigint(50) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `roleId` bigint(50) NOT NULL COMMENT '角色编号',
  `permissionId` bigint(50) NOT NULL COMMENT '权限编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unoin_key_role_permission` (`roleId`,`permissionId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_polar_role_permission
-- ----------------------------
INSERT INTO `t_polar_role_permission` VALUES ('1', '1', '1');
INSERT INTO `t_polar_role_permission` VALUES ('2', '1', '2');
INSERT INTO `t_polar_role_permission` VALUES ('3', '1', '3');
INSERT INTO `t_polar_role_permission` VALUES ('4', '1', '4');
INSERT INTO `t_polar_role_permission` VALUES ('5', '1', '5');
INSERT INTO `t_polar_role_permission` VALUES ('6', '1', '6');
INSERT INTO `t_polar_role_permission` VALUES ('7', '1', '7');
INSERT INTO `t_polar_role_permission` VALUES ('8', '1', '8');
INSERT INTO `t_polar_role_permission` VALUES ('9', '1', '9');
INSERT INTO `t_polar_role_permission` VALUES ('10', '1', '10');
INSERT INTO `t_polar_role_permission` VALUES ('11', '1', '11');
INSERT INTO `t_polar_role_permission` VALUES ('12', '1', '12');
INSERT INTO `t_polar_role_permission` VALUES ('13', '1', '13');
INSERT INTO `t_polar_role_permission` VALUES ('14', '1', '14');
INSERT INTO `t_polar_role_permission` VALUES ('15', '1', '15');
INSERT INTO `t_polar_role_permission` VALUES ('16', '1', '16');
INSERT INTO `t_polar_role_permission` VALUES ('17', '1', '17');
INSERT INTO `t_polar_role_permission` VALUES ('18', '1', '18');
INSERT INTO `t_polar_role_permission` VALUES ('19', '1', '19');
INSERT INTO `t_polar_role_permission` VALUES ('20', '1', '20');
INSERT INTO `t_polar_role_permission` VALUES ('21', '1', '21');
INSERT INTO `t_polar_role_permission` VALUES ('22', '1', '22');
INSERT INTO `t_polar_role_permission` VALUES ('23', '1', '23');
INSERT INTO `t_polar_role_permission` VALUES ('24', '1', '24');
INSERT INTO `t_polar_role_permission` VALUES ('25', '1', '25');
INSERT INTO `t_polar_role_permission` VALUES ('26', '1', '26');
INSERT INTO `t_polar_role_permission` VALUES ('27', '1', '27');
INSERT INTO `t_polar_role_permission` VALUES ('28', '1', '28');
INSERT INTO `t_polar_role_permission` VALUES ('29', '1', '29');
INSERT INTO `t_polar_role_permission` VALUES ('30', '1', '30');
INSERT INTO `t_polar_role_permission` VALUES ('31', '1', '31');
INSERT INTO `t_polar_role_permission` VALUES ('32', '1', '32');
INSERT INTO `t_polar_role_permission` VALUES ('33', '1', '33');
INSERT INTO `t_polar_role_permission` VALUES ('34', '1', '34');
INSERT INTO `t_polar_role_permission` VALUES ('35', '1', '35');
INSERT INTO `t_polar_role_permission` VALUES ('36', '1', '36');
INSERT INTO `t_polar_role_permission` VALUES ('37', '1', '37');
INSERT INTO `t_polar_role_permission` VALUES ('38', '1', '38');
INSERT INTO `t_polar_role_permission` VALUES ('39', '1', '39');
INSERT INTO `t_polar_role_permission` VALUES ('40', '1', '40');
INSERT INTO `t_polar_role_permission` VALUES ('41', '1', '41');
INSERT INTO `t_polar_role_permission` VALUES ('42', '1', '42');
INSERT INTO `t_polar_role_permission` VALUES ('43', '1', '43');
INSERT INTO `t_polar_role_permission` VALUES ('44', '1', '44');
INSERT INTO `t_polar_role_permission` VALUES ('45', '1', '45');
INSERT INTO `t_polar_role_permission` VALUES ('46', '1', '46');
INSERT INTO `t_polar_role_permission` VALUES ('47', '1', '47');
INSERT INTO `t_polar_role_permission` VALUES ('48', '1', '48');
INSERT INTO `t_polar_role_permission` VALUES ('49', '1', '49');
INSERT INTO `t_polar_role_permission` VALUES ('50', '1', '50');
INSERT INTO `t_polar_role_permission` VALUES ('51', '1', '51');
INSERT INTO `t_polar_role_permission` VALUES ('52', '1', '52');
INSERT INTO `t_polar_role_permission` VALUES ('53', '1', '53');
INSERT INTO `t_polar_role_permission` VALUES ('54', '1', '54');
INSERT INTO `t_polar_role_permission` VALUES ('55', '1', '55');
INSERT INTO `t_polar_role_permission` VALUES ('56', '1', '56');
INSERT INTO `t_polar_role_permission` VALUES ('57', '1', '57');
INSERT INTO `t_polar_role_permission` VALUES ('58', '1', '58');
INSERT INTO `t_polar_role_permission` VALUES ('59', '1', '59');
INSERT INTO `t_polar_role_permission` VALUES ('60', '1', '60');
INSERT INTO `t_polar_role_permission` VALUES ('61', '1', '62');
INSERT INTO `t_polar_role_permission` VALUES ('62', '1', '63');
INSERT INTO `t_polar_role_permission` VALUES ('63', '1', '64');
INSERT INTO `t_polar_role_permission` VALUES ('64', '1', '65');
INSERT INTO `t_polar_role_permission` VALUES ('65', '1', '66');
INSERT INTO `t_polar_role_permission` VALUES ('66', '1', '67');
INSERT INTO `t_polar_role_permission` VALUES ('67', '1', '68');
INSERT INTO `t_polar_role_permission` VALUES ('68', '1', '69');
INSERT INTO `t_polar_role_permission` VALUES ('69', '1', '70');
INSERT INTO `t_polar_role_permission` VALUES ('70', '1', '71');
INSERT INTO `t_polar_role_permission` VALUES ('71', '1', '72');
INSERT INTO `t_polar_role_permission` VALUES ('72', '1', '73');
INSERT INTO `t_polar_role_permission` VALUES ('73', '1', '74');
INSERT INTO `t_polar_role_permission` VALUES ('74', '1', '75');
INSERT INTO `t_polar_role_permission` VALUES ('75', '1', '76');
INSERT INTO `t_polar_role_permission` VALUES ('76', '1', '77');
INSERT INTO `t_polar_role_permission` VALUES ('142', '1', '78');
INSERT INTO `t_polar_role_permission` VALUES ('143', '1', '79');
INSERT INTO `t_polar_role_permission` VALUES ('144', '1', '80');
INSERT INTO `t_polar_role_permission` VALUES ('145', '1', '81');
INSERT INTO `t_polar_role_permission` VALUES ('155', '1', '82');
INSERT INTO `t_polar_role_permission` VALUES ('156', '1', '83');
INSERT INTO `t_polar_role_permission` VALUES ('157', '1', '84');
INSERT INTO `t_polar_role_permission` VALUES ('158', '1', '85');
INSERT INTO `t_polar_role_permission` VALUES ('159', '1', '86');
INSERT INTO `t_polar_role_permission` VALUES ('160', '1', '87');
INSERT INTO `t_polar_role_permission` VALUES ('161', '1', '88');
INSERT INTO `t_polar_role_permission` VALUES ('162', '1', '89');
INSERT INTO `t_polar_role_permission` VALUES ('163', '1', '90');
INSERT INTO `t_polar_role_permission` VALUES ('164', '1', '91');
INSERT INTO `t_polar_role_permission` VALUES ('165', '1', '92');
INSERT INTO `t_polar_role_permission` VALUES ('166', '1', '93');
INSERT INTO `t_polar_role_permission` VALUES ('167', '1', '94');
INSERT INTO `t_polar_role_permission` VALUES ('77', '2', '1');
INSERT INTO `t_polar_role_permission` VALUES ('78', '2', '42');
INSERT INTO `t_polar_role_permission` VALUES ('79', '2', '43');
INSERT INTO `t_polar_role_permission` VALUES ('80', '2', '44');
INSERT INTO `t_polar_role_permission` VALUES ('81', '2', '45');
INSERT INTO `t_polar_role_permission` VALUES ('82', '2', '46');
INSERT INTO `t_polar_role_permission` VALUES ('83', '2', '47');
INSERT INTO `t_polar_role_permission` VALUES ('84', '2', '48');
INSERT INTO `t_polar_role_permission` VALUES ('85', '2', '49');
INSERT INTO `t_polar_role_permission` VALUES ('86', '2', '50');
INSERT INTO `t_polar_role_permission` VALUES ('87', '2', '51');
INSERT INTO `t_polar_role_permission` VALUES ('88', '2', '52');
INSERT INTO `t_polar_role_permission` VALUES ('89', '2', '53');
INSERT INTO `t_polar_role_permission` VALUES ('146', '2', '78');
INSERT INTO `t_polar_role_permission` VALUES ('147', '2', '79');
INSERT INTO `t_polar_role_permission` VALUES ('148', '2', '80');
INSERT INTO `t_polar_role_permission` VALUES ('149', '2', '81');
INSERT INTO `t_polar_role_permission` VALUES ('90', '3', '1');
INSERT INTO `t_polar_role_permission` VALUES ('91', '3', '28');
INSERT INTO `t_polar_role_permission` VALUES ('92', '3', '29');
INSERT INTO `t_polar_role_permission` VALUES ('93', '3', '30');
INSERT INTO `t_polar_role_permission` VALUES ('94', '3', '31');
INSERT INTO `t_polar_role_permission` VALUES ('95', '3', '32');
INSERT INTO `t_polar_role_permission` VALUES ('96', '3', '33');
INSERT INTO `t_polar_role_permission` VALUES ('97', '3', '34');
INSERT INTO `t_polar_role_permission` VALUES ('98', '3', '35');
INSERT INTO `t_polar_role_permission` VALUES ('99', '3', '36');
INSERT INTO `t_polar_role_permission` VALUES ('100', '3', '37');
INSERT INTO `t_polar_role_permission` VALUES ('101', '3', '38');
INSERT INTO `t_polar_role_permission` VALUES ('102', '3', '39');
INSERT INTO `t_polar_role_permission` VALUES ('103', '3', '40');
INSERT INTO `t_polar_role_permission` VALUES ('104', '3', '41');
INSERT INTO `t_polar_role_permission` VALUES ('105', '4', '1');
INSERT INTO `t_polar_role_permission` VALUES ('106', '4', '21');
INSERT INTO `t_polar_role_permission` VALUES ('107', '4', '22');
INSERT INTO `t_polar_role_permission` VALUES ('108', '4', '23');
INSERT INTO `t_polar_role_permission` VALUES ('109', '4', '24');
INSERT INTO `t_polar_role_permission` VALUES ('110', '4', '25');
INSERT INTO `t_polar_role_permission` VALUES ('111', '4', '26');
INSERT INTO `t_polar_role_permission` VALUES ('112', '4', '27');
INSERT INTO `t_polar_role_permission` VALUES ('113', '4', '69');
INSERT INTO `t_polar_role_permission` VALUES ('114', '4', '70');
INSERT INTO `t_polar_role_permission` VALUES ('115', '4', '73');
INSERT INTO `t_polar_role_permission` VALUES ('116', '4', '74');
INSERT INTO `t_polar_role_permission` VALUES ('117', '4', '75');
INSERT INTO `t_polar_role_permission` VALUES ('118', '4', '76');
INSERT INTO `t_polar_role_permission` VALUES ('119', '4', '77');
INSERT INTO `t_polar_role_permission` VALUES ('134', '5', '1');
INSERT INTO `t_polar_role_permission` VALUES ('120', '5', '54');
INSERT INTO `t_polar_role_permission` VALUES ('121', '5', '55');
INSERT INTO `t_polar_role_permission` VALUES ('122', '5', '56');
INSERT INTO `t_polar_role_permission` VALUES ('123', '5', '57');
INSERT INTO `t_polar_role_permission` VALUES ('124', '5', '58');
INSERT INTO `t_polar_role_permission` VALUES ('125', '5', '59');
INSERT INTO `t_polar_role_permission` VALUES ('126', '5', '60');
INSERT INTO `t_polar_role_permission` VALUES ('127', '5', '62');
INSERT INTO `t_polar_role_permission` VALUES ('128', '5', '63');
INSERT INTO `t_polar_role_permission` VALUES ('129', '5', '64');
INSERT INTO `t_polar_role_permission` VALUES ('130', '5', '65');
INSERT INTO `t_polar_role_permission` VALUES ('131', '5', '66');
INSERT INTO `t_polar_role_permission` VALUES ('132', '5', '67');
INSERT INTO `t_polar_role_permission` VALUES ('133', '5', '68');
INSERT INTO `t_polar_role_permission` VALUES ('135', '6', '1');
INSERT INTO `t_polar_role_permission` VALUES ('136', '6', '54');
INSERT INTO `t_polar_role_permission` VALUES ('137', '6', '55');
INSERT INTO `t_polar_role_permission` VALUES ('138', '6', '56');
INSERT INTO `t_polar_role_permission` VALUES ('139', '6', '57');
INSERT INTO `t_polar_role_permission` VALUES ('140', '6', '58');
INSERT INTO `t_polar_role_permission` VALUES ('141', '6', '59');
INSERT INTO `t_polar_role_permission` VALUES ('150', '6', '78');
INSERT INTO `t_polar_role_permission` VALUES ('151', '6', '79');
INSERT INTO `t_polar_role_permission` VALUES ('152', '6', '80');
INSERT INTO `t_polar_role_permission` VALUES ('153', '6', '81');

-- ----------------------------
-- Table structure for t_polar_tables
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_tables`;
CREATE TABLE `t_polar_tables` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tableName` varchar(500) NOT NULL COMMENT '表名',
  `tableRemark` varchar(255) NOT NULL COMMENT '表中文名',
  `moduleType` int(2) NOT NULL DEFAULT '0' COMMENT '模板方式',
  `tableType` int(2) NOT NULL DEFAULT '0' COMMENT '表单类型,0-单表，1-树结构，2-父表，3-子表 ',
  `parentField` varchar(200) DEFAULT NULL COMMENT '树结构中父编号字段',
  `childField` varchar(200) DEFAULT NULL COMMENT '树结构中子编号字段',
  `nameField` varchar(200) DEFAULT NULL COMMENT '树结构中名称字段',
  `valueField` varchar(200) DEFAULT NULL COMMENT '树结构中值字段',
  `parentTableId` varchar(200) DEFAULT NULL COMMENT '父子表中，子表指向的表',
  `childTableField` varchar(200) DEFAULT NULL COMMENT '父子表中，子表中保存父表外键的字段',
  `validateType` int(2) NOT NULL DEFAULT '0' COMMENT '校验方式(0-layui,1-bootstrap)',
  `listModule` int(2) DEFAULT '0' COMMENT '列表模板类型：0-layui-table,1-bootstrap-table',
  `deleteMode` int(1) NOT NULL DEFAULT '2' COMMENT '删除模式,0-全部,1-仅物理删除,2-仅逻辑删除。',
  `idField` varchar(500) NOT NULL DEFAULT '' COMMENT '主键名称',
  `idType` int(1) DEFAULT '0' COMMENT '主键类型（0-long,1-UUID）',
  `effectivenessField` varchar(500) DEFAULT NULL COMMENT '有效性字段名称',
  `effectivenessValue` varchar(500) DEFAULT NULL COMMENT '有效值',
  `effectivenessType` int(1) DEFAULT '0' COMMENT '有效性字段名称(0-字符串,1-数值)',
  `unEffectivenessValue` varchar(500) DEFAULT NULL COMMENT '无效值',
  `packageName` varchar(500) NOT NULL COMMENT '包名',
  `moduleName` varchar(500) NOT NULL COMMENT '模块名称',
  `moduleRemark` varchar(500) NOT NULL COMMENT '模块中文名称',
  `author` varchar(500) NOT NULL COMMENT '作者',
  `controllerWebPath` varchar(500) NOT NULL COMMENT '访问的路径',
  `controllerJsonPath` varchar(500) NOT NULL COMMENT '访问的路径',
  `controllerWebName` varchar(500) NOT NULL COMMENT '网页的类名',
  `controllerWebTag` varchar(500) NOT NULL COMMENT '网页的标签',
  `controllerJsonTag` varchar(500) NOT NULL COMMENT 'Json格式的标签,默认为空',
  `controllerJsonName` varchar(500) NOT NULL COMMENT 'Json格式的类名',
  `serviceImplName` varchar(500) NOT NULL COMMENT '服务实现类名称',
  `serviceName` varchar(500) NOT NULL COMMENT '服务类名称',
  `serviceTag` varchar(500) NOT NULL COMMENT '服务类标签',
  `daoName` varchar(500) NOT NULL COMMENT ' dao的名称',
  `daoTag` varchar(500) NOT NULL COMMENT 'dao的标签',
  `entityName` varchar(500) NOT NULL COMMENT '实体类类名',
  `entityAlias` varchar(500) NOT NULL COMMENT '实体类别名',
  `mapperFloderName` varchar(500) NOT NULL COMMENT '文件夹名称',
  `mapperFileName` varchar(500) NOT NULL COMMENT 'mapper文件名称',
  `jspListName` varchar(500) NOT NULL COMMENT ' JSP页面列表名称',
  `jspEditName` varchar(500) NOT NULL COMMENT 'JSP页面编辑页面名称',
  `createDate` datetime DEFAULT NULL COMMENT '创建日期',
  `updateDate` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='代码生成器中生成的表';

-- ----------------------------
-- Records of t_polar_tables
-- ----------------------------

-- ----------------------------
-- Table structure for t_polar_tree
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_tree`;
CREATE TABLE `t_polar_tree` (
  `id` bigint(50) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `text` varchar(500) NOT NULL COMMENT '文本内容',
  `value` varchar(500) NOT NULL COMMENT '值',
  `groupId` varchar(500) NOT NULL COMMENT '组编号',
  `groupName` varchar(500) NOT NULL COMMENT '组名',
  `textAlias` varchar(500) DEFAULT NULL COMMENT '别名',
  `parentId` varchar(50) DEFAULT NULL COMMENT '父级编号',
  `type` int(1) NOT NULL DEFAULT '1' COMMENT '类型',
  `textId` varchar(50) CHARACTER SET latin1 DEFAULT NULL COMMENT '编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='树结构';

-- ----------------------------
-- Records of t_polar_tree
-- ----------------------------

-- ----------------------------
-- Table structure for t_polar_user
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_user`;
CREATE TABLE `t_polar_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userName` varchar(500) NOT NULL COMMENT '用户名',
  `password` varchar(500) DEFAULT NULL COMMENT '密码',
  `logCount` bigint(20) DEFAULT '0' COMMENT '登陆次数',
  `headUrl` varchar(2000) DEFAULT NULL COMMENT '头像',
  `nickName` varchar(500) DEFAULT NULL COMMENT '昵称',
  `logInIp` varchar(255) DEFAULT NULL COMMENT '最后一次登陆的IP',
  `state` int(1) DEFAULT '1' COMMENT '状态(0-禁用，1-正常)',
  `createDate` datetime DEFAULT NULL COMMENT '创建日期',
  `phone` varchar(255) DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `logInDate` datetime DEFAULT NULL COMMENT '最后一次登陆日期',
  `org_id` varchar(500) DEFAULT NULL COMMENT '机构编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户表';

-- ----------------------------
-- Records of t_polar_user
-- ----------------------------
INSERT INTO `t_polar_user` VALUES ('1', 'admin', '19ee1f75b9174f927d79c73f810e173f5305d33b', '50', 'https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1502882341440&amp;di=541b6fc30e37d44d3f14f7cff822d6f4&amp;imgtype=0&amp;src=http%3A%2F%2Fpic2.ooopic.com%2F12%2F90%2F11%2F93b1OOOPICa6.jpg', '恩哥', '本地', '1', '2017-09-09 14:21:19', '18615625210', '1107061838@qq.com', '2017-09-14 19:01:23', null);

-- ----------------------------
-- Table structure for t_polar_user_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_user_menu`;
CREATE TABLE `t_polar_user_menu` (
  `id` bigint(50) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `userId` bigint(50) NOT NULL COMMENT '角色编号',
  `menuModelId` bigint(50) NOT NULL COMMENT '权限编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unoin_key_user_menuModel` (`userId`,`menuModelId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户菜单表';

-- ----------------------------
-- Records of t_polar_user_menu
-- ----------------------------
INSERT INTO `t_polar_user_menu` VALUES ('231', '1', '1');

-- ----------------------------
-- Table structure for t_polar_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_user_role`;
CREATE TABLE `t_polar_user_role` (
  `id` bigint(50) NOT NULL AUTO_INCREMENT COMMENT '主键编号',
  `userId` bigint(50) NOT NULL COMMENT '用户编号',
  `roleId` bigint(50) NOT NULL COMMENT '角色编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unoin_key_user_role` (`userId`,`roleId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户-角色表';

-- ----------------------------
-- Records of t_polar_user_role
-- ----------------------------
INSERT INTO `t_polar_user_role` VALUES ('1', '1', '1');

-- ----------------------------
-- Table structure for t_polar_vist_record
-- ----------------------------
DROP TABLE IF EXISTS `t_polar_vist_record`;
CREATE TABLE `t_polar_vist_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键编号',
  `pageName` varchar(500) DEFAULT NULL COMMENT '页面名称',
  `vistUrl` varchar(500) NOT NULL COMMENT '访问路径',
  `vistPlatform` int(1) NOT NULL COMMENT '访问平台(1-电脑，2-手机)',
  `vistDate` datetime NOT NULL COMMENT '访问时间',
  `vistPeople` varchar(50) DEFAULT '' COMMENT '访问人',
  `vistIp` varchar(50) DEFAULT NULL COMMENT '访问ip',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_polar_vist_record
-- ----------------------------
INSERT INTO `t_polar_vist_record` VALUES ('57', '菜单模板列表', '/menuModel/web', '1', '2018-07-26 14:22:23', '1', '本地');
INSERT INTO `t_polar_vist_record` VALUES ('58', '查询菜单模板', '/menuModel/json/pageList', '1', '2018-07-26 14:22:23', '1', '本地');
INSERT INTO `t_polar_vist_record` VALUES ('59', '查看模板菜单', '/menuModel/web/modelMenus', '1', '2018-07-26 14:22:25', '1', '本地');
INSERT INTO `t_polar_vist_record` VALUES ('60', '修改模板菜单', '/menu/json/updateModelMenus', '1', '2018-07-26 14:22:30', '1', '本地');
