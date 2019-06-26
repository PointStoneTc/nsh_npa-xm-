/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 80012
Source Host           : localhost:3306
Source Database       : npa

Target Server Type    : MYSQL
Target Server Version : 80012
File Encoding         : 65001

Date: 2019-03-05 14:49:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for npa_corporate_org
-- ----------------------------
DROP TABLE IF EXISTS `npa_corporate_org`;
CREATE TABLE `npa_corporate_org` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL COMMENT '姓名',
  `name_shorter` varchar(50) DEFAULT NULL,
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '地址',
  `code` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '单位代码',
  `phone` char(11) DEFAULT NULL,
  `is_effect` char(1) NOT NULL DEFAULT '1' COMMENT '是否生效',
  `create_by` varchar(15) DEFAULT NULL COMMENT '新建人',
  `create_date` datetime DEFAULT NULL COMMENT '新建时间',
  `update_by` varchar(15) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `is_delete` char(1) DEFAULT NULL COMMENT '是否删除',
  `delete_date` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='记录银行支行法人单位的基本信息，包括名称、地址、单位代码。';
