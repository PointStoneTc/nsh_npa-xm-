/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 80012
Source Host           : localhost:3306
Source Database       : npa

Target Server Type    : MYSQL
Target Server Version : 80012
File Encoding         : 65001

Date: 2019-03-13 20:07:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for npa_loan_contract
-- ----------------------------
DROP TABLE IF EXISTS `npa_loan_contract`;
CREATE TABLE `npa_loan_contract` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `num_code` char(20) NOT NULL COMMENT '合同编号',
  `customer_no` varchar(20) DEFAULT NULL COMMENT '客户号',
  `lou_no` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '借据号',
  `borrower_id` bigint(20) unsigned NOT NULL COMMENT '借款人ID',
  `borrower_name` varchar(15) DEFAULT NULL COMMENT '借款人姓名',
  `is_impersonate` char(1) DEFAULT '0' COMMENT '是否借冒名',
  `amount` decimal(11,3) NOT NULL COMMENT '贷款金额',
  `issue_date` date NOT NULL COMMENT '贷款发放日',
  `due_date` date NOT NULL COMMENT '贷款到期日',
  `interest_rate` decimal(6,4) NOT NULL COMMENT '利率',
  `officer` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '信贷员',
  `corporate_org_id` bigint(20) NOT NULL COMMENT '所属支行ID',
  `corporate_org_name` varchar(50) DEFAULT NULL COMMENT '所属支行名称',
  `guarantee_mode` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '担保方式 信用:x 保证:b 抵押:d',
  `dispose_mode` char(1) DEFAULT NULL COMMENT '处理方式 核销:h 置换:z',
  `litigation_stat` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '诉讼状态 n:未诉讼 l:立案 f:一审 s:二审 g:再审 t:调解 e:诉讼终结 i:申请执行 a:执行 b:终止执行 c:终止本次执行 d:执行终结',
  `stat` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'n' COMMENT '状态 正常:n 终止:t 结束:e',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '备注',
  `is_submit` char(1) NOT NULL DEFAULT '0' COMMENT '是否提交',
  `interest_date` date DEFAULT NULL COMMENT '起息日',
  `recovery_principal` decimal(11,3) NOT NULL DEFAULT '0.000' COMMENT '收回本金',
  `recovery_interest` decimal(11,3) NOT NULL DEFAULT '0.000' COMMENT '收回利息',
  `hang_interes` decimal(11,3) NOT NULL DEFAULT '0.000' COMMENT '挂息',
  `create_by` varchar(15) DEFAULT NULL COMMENT '新建人',
  `create_date` datetime DEFAULT NULL COMMENT '新建时间',
  `update_by` varchar(15) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `is_delete` char(1) DEFAULT NULL COMMENT '是否删除',
  `delete_date` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `Index_num_code` (`num_code`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8 COMMENT='借款合同';
