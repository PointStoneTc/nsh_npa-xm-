/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 80012
Source Host           : localhost:3306
Source Database       : npa

Target Server Type    : MYSQL
Target Server Version : 80012
File Encoding         : 65001

Date: 2019-03-13 20:07:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for npa_natural_person
-- ----------------------------
DROP TABLE IF EXISTS `npa_natural_person`;
CREATE TABLE `npa_natural_person` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(10) NOT NULL COMMENT '姓名',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '性别 男:m 女:f',
  `birthday` date DEFAULT NULL COMMENT '出生年月',
  `province` varchar(10) DEFAULT '' COMMENT '省',
  `city` varchar(10) DEFAULT '' COMMENT '市',
  `county` varchar(10) DEFAULT '' COMMENT '县',
  `id_number` char(18) NOT NULL COMMENT '身份证号',
  `phone` char(11) DEFAULT '' COMMENT '手机号码',
  `address` varchar(50) DEFAULT '' COMMENT '通讯地址',
  `is_borrower` char(1) NOT NULL DEFAULT '0' COMMENT '是否借款人',
  `is_guarantee` char(1) NOT NULL DEFAULT '0' COMMENT '是否担保人',
  `create_by` varchar(15) DEFAULT NULL COMMENT '新建人',
  `create_date` datetime DEFAULT NULL COMMENT '新建时间',
  `update_by` varchar(15) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `is_delete` char(1) DEFAULT NULL COMMENT '是否删除',
  `delete_date` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_id_number` (`id_number`),
  KEY `Index_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT=' 自然人，包含借款人及担保人，借款人用b表示，担保人用g表示。\r\n记录向银行借款，并签订借据的债务人的基本信息';
