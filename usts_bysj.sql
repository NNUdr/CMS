/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50549
Source Host           : localhost:3306
Source Database       : usts_bysj

Target Server Type    : MYSQL
Target Server Version : 50549
File Encoding         : 65001

Date: 2018-06-05 13:13:27
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_account`
-- ----------------------------
DROP TABLE IF EXISTS `t_account`;
CREATE TABLE `t_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cusId` int(11) DEFAULT NULL,
  `orderNo` varchar(40) DEFAULT NULL,
  `orderDate` date DEFAULT NULL,
  `orderCost` varchar(200) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_account
-- ----------------------------
INSERT INTO `t_account` VALUES ('1', '1', 'YW11', '2018-04-04', '1000', '1');
INSERT INTO `t_account` VALUES ('2', '1', 'YW12', '2018-02-08', '1000', '0');
INSERT INTO `t_account` VALUES ('3', '2', 'YW13', '2018-04-05', '2000', '1');
INSERT INTO `t_account` VALUES ('4', '3', 'YW14', '2018-06-01', '5000', '0');
INSERT INTO `t_account` VALUES ('5', '4', 'YW15', '2018-06-04', '10000', '0');
INSERT INTO `t_account` VALUES ('6', '5', 'YW16', '2018-06-05', '10000', '0');
INSERT INTO `t_account` VALUES ('7', '1', 'YW17', '2018-05-07', '3000', '1');

-- ----------------------------
-- Table structure for `t_accountdetail`
-- ----------------------------
DROP TABLE IF EXISTS `t_accountdetail`;
CREATE TABLE `t_accountdetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountId` int(11) DEFAULT NULL,
  `goodsName` varchar(100) DEFAULT NULL,
  `goodsNum` int(11) DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `sum` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_accountdetail
-- ----------------------------
INSERT INTO `t_accountdetail` VALUES ('1', '1', '1000元包年套餐', '2', '年', '1000', '2000');
INSERT INTO `t_accountdetail` VALUES ('2', '1', '100元包月套餐', '4', '月', '100', '400');
INSERT INTO `t_accountdetail` VALUES ('3', '2', '100元包月套餐', '6', '月', '100', '600');
INSERT INTO `t_accountdetail` VALUES ('4', '3', '1000元包年套餐', '1', '年', '1000', '1000');
INSERT INTO `t_accountdetail` VALUES ('5', '3', '10000永久使用', '1', '不限时', '10000', '10000');
INSERT INTO `t_accountdetail` VALUES ('6', '4', '10000终身使用', '1', '不限时', '10000', '10000');
INSERT INTO `t_accountdetail` VALUES ('7', '1', '100元包月套餐', '3', '月', '100', '300');

-- ----------------------------
-- Table structure for `t_cost`
-- ----------------------------
DROP TABLE IF EXISTS `t_cost`;
CREATE TABLE `t_cost` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `time` varchar(50) NOT NULL,
  `price` double(50,2) unsigned zerofill NOT NULL,
  `remark` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_cost
-- ----------------------------
INSERT INTO `t_cost` VALUES ('1', '100元包年套餐', '不限时长23123', '00000000000000000000000000000000000000000001003.00', '包年更优惠');
INSERT INTO `t_cost` VALUES ('2', '100元包月套餐', '不限时长', '00000000000000000000000000000000000000000000101.00', '一个月内不限时使用');
INSERT INTO `t_cost` VALUES ('5', '10小时体验套餐', '10小时', '00000000000000000000000000000000000000000000123.10', '免费体验');
INSERT INTO `t_cost` VALUES ('10', '100000元永久时长', '永久使用', '00000000000000000000000000000000000000000100000.00', '终身使用');
INSERT INTO `t_cost` VALUES ('12', '888元包10个月套餐', '10个月', '00000000000000000000000000000000000000000000888.00', '限时活动');
INSERT INTO `t_cost` VALUES ('13', '弹性云服务器', '60小时', '00000000000000000000000000000000000000000000060.00', '限时免费60小时');
INSERT INTO `t_cost` VALUES ('14', '创业型云服务器', '套餐内免费', '00000000000000000000000000000000000000000000253.00', '253元首月,920元/季,1680元/半年,2980元/年');
INSERT INTO `t_cost` VALUES ('15', '发展型云服务器', '套餐内免费', '00000000000000000000000000000000000000000000287.00', '287元首月,998元/季,1999元/半年,3380元/年');
INSERT INTO `t_cost` VALUES ('16', '舒适型云服务器', '套餐内免费', '00000000000000000000000000000000000000000001180.00', '适用于网上商城、团购网站等');
INSERT INTO `t_cost` VALUES ('17', '增强型云服务器', '套餐内免费', '00000000000000000000000000000000000000000001870.00', '适用于社区SNS/论坛/ERP/OACRM等');
INSERT INTO `t_cost` VALUES ('18', '企业型云服务器', '套餐内免费', '00000000000000000000000000000000000000000001800.00', '适用于网络游戏，其它高端应用等');

-- ----------------------------
-- Table structure for `t_customer`
-- ----------------------------
DROP TABLE IF EXISTS `t_customer`;
CREATE TABLE `t_customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `khno` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `area` varchar(20) DEFAULT NULL,
  `cusManager` varchar(20) DEFAULT NULL,
  `level` varchar(30) DEFAULT NULL,
  `xyd` varchar(30) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `postCode` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `khzh` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_customer
-- ----------------------------
INSERT INTO `t_customer` VALUES ('1', 'YeWu20180425052648', '网易', '江苏', '李旺', '普通客户', '☆☆☆☆', '132', '123', '132333', '123');
INSERT INTO `t_customer` VALUES ('2', 'YeWu20180425090925', '百度', '江苏', '王强', '重要客户', '☆☆☆☆', '123123', '21321', '3123123', '213123');
INSERT INTO `t_customer` VALUES ('3', 'YeWu20180425102434', '京东', '北京', '王强', '重要客户', '☆☆☆☆☆', '123', '12312312', '231123123', '1233');
INSERT INTO `t_customer` VALUES ('4', 'YeWu20180426092003', '苏州天平', '江苏', '李旺', '合作伙伴', '☆☆☆☆☆', '江苏苏州', '123123', '213123123', '123123123');
INSERT INTO `t_customer` VALUES ('5', 'YeWu20180426114320', '苏州科大电器', '江苏', '李旺', '战略伙伴', '☆☆☆', '南京市雨花台区', '123123', '213123123', 'TW1234');
INSERT INTO `t_customer` VALUES ('6', 'YeWu20180426114402', '爱迪大师', '北京', '李旺', '赞助商', '☆☆☆☆', '21312', '12312', '2312133', '1231');
INSERT INTO `t_customer` VALUES ('7', 'YeWu20180428032902', '阿里巴巴', '江苏', '剑豪', '重要客户', '☆☆☆☆☆', '浙江', '12312312', '1355566868', 'YW1213231');
INSERT INTO `t_customer` VALUES ('8', 'YeWu20180428033033', '耐克', '上海', '王强', '合作伙伴', '☆☆☆☆', '上海有点', '123123', '23123123', 'YW312312');

-- ----------------------------
-- Table structure for `t_datadic`
-- ----------------------------
DROP TABLE IF EXISTS `t_datadic`;
CREATE TABLE `t_datadic` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `dataDicName` varchar(50) DEFAULT NULL,
  `dataDicValue` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_datadic
-- ----------------------------
INSERT INTO `t_datadic` VALUES ('1', '客户等级', '普通客户');
INSERT INTO `t_datadic` VALUES ('2', '客户等级', '合作伙伴');
INSERT INTO `t_datadic` VALUES ('3', '客户等级', '重要客户');
INSERT INTO `t_datadic` VALUES ('4', '服务类型', '咨询');
INSERT INTO `t_datadic` VALUES ('5', '服务类型', '建议');
INSERT INTO `t_datadic` VALUES ('6', '服务类型', '投诉');
INSERT INTO `t_datadic` VALUES ('7', '服务类型', '外包');
INSERT INTO `t_datadic` VALUES ('8', '客户等级', '战略伙伴');
INSERT INTO `t_datadic` VALUES ('9', '客户等级', '赞助商');
INSERT INTO `t_datadic` VALUES ('11', '服务类型', '销售');
INSERT INTO `t_datadic` VALUES ('12', '服务类型', '宣传');

-- ----------------------------
-- Table structure for `t_note`
-- ----------------------------
DROP TABLE IF EXISTS `t_note`;
CREATE TABLE `t_note` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `noteTitle` varchar(50) DEFAULT NULL,
  `noteCreateTime` datetime DEFAULT NULL,
  `noteInfo` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_note
-- ----------------------------
INSERT INTO `t_note` VALUES ('1', '本周六员工体检', '2018-04-26 13:17:59', '请大家到最近的医院免费体检，谢谢合作！');
INSERT INTO `t_note` VALUES ('5', '系统维护', '2018-05-08 19:05:00', '维护升级2018年5月8日19:05:46');
INSERT INTO `t_note` VALUES ('9', '明天毕业啦', '2018-05-28 23:19:00', '明天毕业！！！');
INSERT INTO `t_note` VALUES ('11', '今天答辩！', '2018-05-31 11:58:00', '2018年5月31日11:58:34\r\n地点：苏州科技大学\r\n天气晴朗');

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `trueName` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `roleName` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'admin', 'admin', '杜锐', '792242185@qq.com', '17326165251', '超级管理员');
INSERT INTO `t_user` VALUES ('4', 'wangli', 'skd', '李旺', 'li@163.com', '312312', '客户经理');
INSERT INTO `t_user` VALUES ('14', 'sa', 'skd', '剑豪', '522212@qq.com', '132321', '客户经理');
INSERT INTO `t_user` VALUES ('16', 'wang', 'skd', '王强', 'wangq@163.com', '131231232', '客户经理');
INSERT INTO `t_user` VALUES ('18', 'zhangsan', 'admin', '张三', '86886@qq.com', '213123123', '客户经理');

-- ----------------------------
-- Table structure for `t_yewu`
-- ----------------------------
DROP TABLE IF EXISTS `t_yewu`;
CREATE TABLE `t_yewu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `yewuSource` varchar(300) DEFAULT NULL,
  `customerName` varchar(100) DEFAULT NULL,
  `overView` varchar(300) DEFAULT NULL,
  `linkMan` varchar(100) DEFAULT NULL,
  `linkPhone` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `createMan` varchar(100) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `assignMan` varchar(100) DEFAULT NULL,
  `assignTime` datetime DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_yewu
-- ----------------------------
INSERT INTO `t_yewu` VALUES ('1', '主动来找的', '苏州天平先进数字科技', '购买包年套餐', '王先生', '137234576543', '折扣', 'duriu', '2014-01-02 01:00:00', '剑豪', '2018-06-05 10:01:00', '1');
INSERT INTO `t_yewu` VALUES ('2', '广告宣传', '苏州华之杰', '购买包年套餐', '许先生', '137234576543', 'r', 'duriu', '2018-04-10 23:17:50', '王强', '2015-05-25 11:21:00', '1');
INSERT INTO `t_yewu` VALUES ('8', '广告宣传', '苏州碧桂园', '购买包年套餐', '许先生', '137234576543', null, 'duriu', '2018-04-24 23:17:57', '剑豪', '2018-05-09 12:34:56', '1');
INSERT INTO `t_yewu` VALUES ('9', '广告宣传', '苏州大理石', '购买包年套餐', '王先生', '137234576543', null, 'duriu', '2018-04-24 23:17:53', '李旺', '2018-05-18 12:35:00', '1');
INSERT INTO `t_yewu` VALUES ('10', '朋友介绍', '苏州幕墙', '购买包年套餐', '王先生', '3213', null, 'duri', '2018-04-24 23:18:00', '张三', '2018-05-31 12:35:00', '0');
INSERT INTO `t_yewu` VALUES ('11', '朋友介绍', '苏州今天谈', '购买包年套餐', '王先生', '', '', 'duriu', '2018-04-24 23:18:18', '张三', '2018-05-31 12:35:07', '0');
INSERT INTO `t_yewu` VALUES ('13', '朋友介绍', '绝地求生', '购买包年套餐', '王先生', '', '', 'duriu', '2018-04-17 23:18:07', '剑豪', '2018-05-31 12:35:10', '0');
INSERT INTO `t_yewu` VALUES ('14', '公司介绍', '王者荣耀', '购买包年套餐', '王先生', '4', '7', 'duriu', '2018-04-24 23:18:12', '剑豪', '2018-05-31 12:35:13', '0');
INSERT INTO `t_yewu` VALUES ('15', '公司介绍', '高先生', '购买包年套餐', '王先生', '213123', '', 'duriu', '2018-06-06 11:20:00', '剑豪', '2018-05-28 23:20:00', '1');
INSERT INTO `t_yewu` VALUES ('16', '公司互推', '李先生', '购买包年套餐', '王先生', '44', '77', 'duriu', '2024-06-01 11:20:00', '李旺', '2019-04-01 11:20:00', '0');
INSERT INTO `t_yewu` VALUES ('17', '公司互推', '王先生', '购买包年套餐', '王先生', '137234576543', '321', 'duriu', '2015-05-22 11:23:00', '李旺', '2018-05-31 12:35:16', '0');
INSERT INTO `t_yewu` VALUES ('18', '公司互推', '诸葛青梅', '购买包年套餐', '王先生', '137234576543', '321', 'Jack', '2015-05-22 11:43:00', '李旺', '2018-03-28 23:18:46', '0');
INSERT INTO `t_yewu` VALUES ('19', '公司互推', '王牌科技网络', '购买包年套餐', '许先生', '321', '321', 'Jack', '2015-05-24 11:33:00', '李旺', '2015-05-24 11:34:00', '0');
INSERT INTO `t_yewu` VALUES ('20', '公司互推', '菜鸟户外科技', '购买包年套餐', '许先生', '321', '321', 'Jack', '2015-05-24 11:35:00', '李旺', '2018-05-31 12:35:18', '0');
INSERT INTO `t_yewu` VALUES ('21', '行业介绍', '大鸟爱科技', '购买包年套餐', '张先生', '0231-321321', '发', 'Jack', '2015-06-10 16:32:00', '李旺', '2015-06-10 16:33:00', '0');
INSERT INTO `t_yewu` VALUES ('22', '朋友介绍', '鸟人科技', '购买包年套餐', '许先生', '137234576543', ',...', 'duriu', '2015-06-11 08:35:00', '李旺', '2015-06-11 08:36:00', '0');
INSERT INTO `t_yewu` VALUES ('24', '慕名而来', '苏州大地软件', '想要长期合作', '张三', '1312312312', '购买包年套餐 希望有优惠', '杜锐', '2018-04-19 09:18:00', '李旺', '2018-04-25 09:09:00', '0');
INSERT INTO `t_yewu` VALUES ('33', '主动来找的', '张三网络科技', '324', '张三', '234', '234', '杜锐', '2018-05-16 15:42:00', '张三', '2018-05-31 12:35:21', '0');
INSERT INTO `t_yewu` VALUES ('34', '广告宣传', '大王网咖', '12312', '组人', '137234576543', '半年业务', '杜锐', '2018-05-16 15:56:00', '剑豪', '2018-05-17 22:46:00', '0');
INSERT INTO `t_yewu` VALUES ('35', '主动来找的', '王五科技', '123', '王五', '213', '123', '杜锐', '2018-05-17 22:33:00', '王强', '2018-05-27 22:53:00', '0');
