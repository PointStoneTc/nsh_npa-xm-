/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 80012
Source Host           : localhost:3306
Source Database       : npa

Target Server Type    : MYSQL
Target Server Version : 80012
File Encoding         : 65001

Date: 2019-04-13 00:00:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for npa_loan_contract_imp
-- ----------------------------
DROP TABLE IF EXISTS `npa_loan_contract_imp`;
CREATE TABLE `npa_loan_contract_imp` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `num_code` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '合同编号',
  `customer_no` varchar(20) DEFAULT NULL COMMENT '客户号',
  `lou_no` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '借据号',
  `borrower_name` varchar(15) DEFAULT NULL COMMENT '借款人姓名',
  `borrower_number` varchar(18) DEFAULT NULL COMMENT '借款人身份证号',
  `is_impersonate` char(1) DEFAULT '0' COMMENT '是否借冒名',
  `guarantees` varchar(200) DEFAULT NULL COMMENT '担保人',
  `amount` decimal(11,3) DEFAULT NULL COMMENT '贷款金额',
  `issue_date` date DEFAULT NULL COMMENT '贷款发放日',
  `due_date` date DEFAULT NULL COMMENT '贷款到期日',
  `interest_rate` decimal(6,4) DEFAULT NULL COMMENT '利率',
  `officer` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '信贷员',
  `corporate_org_name` varchar(20) DEFAULT NULL COMMENT '所属支行id',
  `guarantee_mode` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '担保方式 信用:x 保证:b 抵押:d',
  `dispose_mode` char(1) DEFAULT NULL COMMENT '处理方式 核销:h 置换:z',
  `litigation_stat` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '诉讼状态 n:未诉讼 l:立案 f:一审 s:二审 g:再审 t:调解 e:诉讼终结 i:申请执行 a:执行 b:终止执行 c:终止本次执行 d:执行终结',
  `stat` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'n' COMMENT '状态 正常:n 终止:t 结束:e',
  `interest_date` date DEFAULT NULL COMMENT '起息日',
  `recovery_principal` decimal(11,3) DEFAULT '0.000' COMMENT '收回本金',
  `recovery_interest` decimal(11,3) DEFAULT '0.000' COMMENT '收回利息',
  `hang_interes` decimal(11,3) DEFAULT '0.000' COMMENT '挂息',
  PRIMARY KEY (`id`),
  KEY `Index_num_code` (`num_code`)
) ENGINE=InnoDB AUTO_INCREMENT=363 DEFAULT CHARSET=utf8 COMMENT='借款合同初始化导入表';
