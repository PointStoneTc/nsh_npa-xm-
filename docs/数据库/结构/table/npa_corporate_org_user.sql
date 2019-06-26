/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 80012
Source Host           : localhost:3306
Source Database       : npa

Target Server Type    : MYSQL
Target Server Version : 80012
File Encoding         : 65001

Date: 2019-03-05 14:49:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for npa_corporate_org_user
-- ----------------------------
DROP TABLE IF EXISTS `npa_corporate_org_user`;
CREATE TABLE `npa_corporate_org_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `corporate_org_id` bigint(20) NOT NULL COMMENT '法人组织机构id',
  `userid` varchar(32) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=373 DEFAULT CHARSET=utf8 COMMENT='记录银行支行法人单位的用户。';
