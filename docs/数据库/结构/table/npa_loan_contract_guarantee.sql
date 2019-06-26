/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 80012
Source Host           : localhost:3306
Source Database       : npa

Target Server Type    : MYSQL
Target Server Version : 80012
File Encoding         : 65001

Date: 2019-03-05 14:50:06
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for npa_loan_contract_guarantee
-- ----------------------------
DROP TABLE IF EXISTS `npa_loan_contract_guarantee`;
CREATE TABLE `npa_loan_contract_guarantee` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `loan_contrac_id` bigint(20) unsigned NOT NULL COMMENT '借款合同id',
  `guarantee_id` bigint(20) unsigned NOT NULL COMMENT '担保人id',
  `guarantee_name` varchar(15) DEFAULT NULL COMMENT '担保人姓名',
  `is_impersonate` char(1) DEFAULT NULL COMMENT '是否借冒名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='借款合同担保人明细';
