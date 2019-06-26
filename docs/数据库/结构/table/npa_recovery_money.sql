/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 80012
Source Host           : localhost:3306
Source Database       : npa

Target Server Type    : MYSQL
Target Server Version : 80012
File Encoding         : 65001

Date: 2019-03-13 20:06:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for npa_recovery_money
-- ----------------------------
DROP TABLE IF EXISTS `npa_recovery_money`;
CREATE TABLE `npa_recovery_money` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `loan_contrac_id` bigint(20) NOT NULL COMMENT '借款合同id',
  `interest_bearing_principal` decimal(11,3) NOT NULL COMMENT '计息本金',
  `interest_date` date NOT NULL COMMENT '起息日',
  `interest_rate` decimal(6,4) NOT NULL COMMENT '利率',
  `recovery_date` date NOT NULL COMMENT '收回时间',
  `recovery_person` varchar(15) NOT NULL COMMENT '收回人',
  `recovery_principal` decimal(11,3) NOT NULL COMMENT '收回本金',
  `recovery_interest` decimal(11,3) NOT NULL COMMENT '收回利息',
  `recovery_mode` char(1) NOT NULL DEFAULT 'c' COMMENT '收回方式 c:现金收回 d:法院扣划',
  `hang_interest` decimal(11,3) NOT NULL COMMENT '挂息',
  `is_effect` char(1) NOT NULL DEFAULT '1' COMMENT '是否生效',
  `create_by` varchar(15) DEFAULT NULL COMMENT '新建人',
  `create_date` datetime DEFAULT NULL COMMENT '新建时间',
  `update_by` varchar(15) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `is_delete` char(1) DEFAULT NULL COMMENT '是否删除',
  `delete_date` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='收回款明细';
