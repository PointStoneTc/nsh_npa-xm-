/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 80012
Source Host           : localhost:3306
Source Database       : npa

Target Server Type    : MYSQL
Target Server Version : 80012
File Encoding         : 65001

Date: 2019-04-12 23:56:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for a1
-- ----------------------------
DROP TABLE IF EXISTS `a1`;
CREATE TABLE `a1` (
  `id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cc_asset
-- ----------------------------
DROP TABLE IF EXISTS `cc_asset`;
CREATE TABLE `cc_asset` (
  `id` int(11) NOT NULL COMMENT '主键',
  `symbol` varchar(32) NOT NULL COMMENT '资产id',
  `name` varchar(64) DEFAULT NULL COMMENT '名称',
  `is_active` varchar(32) DEFAULT NULL COMMENT '加密类型\n1：数字加密货币 0：其他',
  `logo_img` varchar(32) NOT NULL COMMENT 'logo图片路径',
  `sort` int(11) DEFAULT NULL COMMENT '排序号',
  PRIMARY KEY (`id`,`symbol`),
  KEY `asset_id` (`symbol`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cc_btc_monitor_line_history
-- ----------------------------
DROP TABLE IF EXISTS `cc_btc_monitor_line_history`;
CREATE TABLE `cc_btc_monitor_line_history` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `base_symbol` varchar(11) DEFAULT NULL COMMENT 'comma-separated cryptocurrency symbols',
  `price_jpy` double DEFAULT NULL COMMENT 'Price in the specified currency',
  `price_usd` double DEFAULT NULL COMMENT 'Price in the specified currency',
  `price_eur` double DEFAULT NULL COMMENT 'Price in the specified currency',
  `price_cny` double DEFAULT NULL COMMENT 'Price in the specified currency',
  `last_updated` datetime DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BTC监视器固定汇率历史';

-- ----------------------------
-- Table structure for cc_btc_monitor_ohlcv_history
-- ----------------------------
DROP TABLE IF EXISTS `cc_btc_monitor_ohlcv_history`;
CREATE TABLE `cc_btc_monitor_ohlcv_history` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `base_symbol` varchar(32) DEFAULT NULL COMMENT 'comma-separated cryptocurrency symbols',
  `quote_symbol` varchar(32) DEFAULT NULL,
  `open` double DEFAULT NULL COMMENT 'Price from first datapoint of today in UTC time for the convert option requested.',
  `high` double DEFAULT NULL COMMENT 'Highest price so far today in UTC time for the convert option requested.',
  `low` double DEFAULT NULL COMMENT 'Lowest price today in UTC time for the convert option requested.',
  `close` double DEFAULT NULL COMMENT 'Latest price today in UTC time for the convert option requested. This is not the final price during close as the current day period is not over.',
  `volume` double DEFAULT NULL COMMENT 'Current volume for the convert option requested from last_updated to 24 hours before.',
  `last_updated` datetime DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BTC监视器固定OHLCV历史';

-- ----------------------------
-- Table structure for cc_btc_monitor_rate_history
-- ----------------------------
DROP TABLE IF EXISTS `cc_btc_monitor_rate_history`;
CREATE TABLE `cc_btc_monitor_rate_history` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `base_symbol` varchar(32) DEFAULT NULL COMMENT 'comma-separated cryptocurrency symbols',
  `price_aud` double DEFAULT NULL COMMENT 'Price in the specified currency',
  `price_brl` double DEFAULT NULL,
  `price_gbp` double DEFAULT NULL,
  `price_cad` double DEFAULT NULL,
  `price_clp` double DEFAULT NULL,
  `price_cny` double DEFAULT NULL,
  `price_czk` double DEFAULT NULL,
  `price_dkk` double DEFAULT NULL,
  `price_eur` double DEFAULT NULL,
  `price_hkd` double DEFAULT NULL,
  `price_huf` double DEFAULT NULL,
  `price_inr` double DEFAULT NULL,
  `price_idr` double DEFAULT NULL,
  `price_ils` double DEFAULT NULL,
  `price_jpy` double DEFAULT NULL,
  `price_myr` double DEFAULT NULL,
  `price_mxn` double DEFAULT NULL,
  `price_twd` double DEFAULT NULL,
  `price_nzd` double DEFAULT NULL,
  `price_nok` double DEFAULT NULL,
  `price_pkr` double DEFAULT NULL,
  `price_php` double DEFAULT NULL,
  `price_pln` double DEFAULT NULL,
  `price_rub` double DEFAULT NULL,
  `price_sgd` double DEFAULT NULL,
  `price_zar` double DEFAULT NULL,
  `price_krw` double DEFAULT NULL,
  `price_sek` double DEFAULT NULL,
  `price_chf` double DEFAULT NULL,
  `price_thb` double DEFAULT NULL,
  `price_try` double DEFAULT NULL,
  `price_usd` double DEFAULT NULL,
  `volume_24h_usd` double DEFAULT NULL,
  `percent_change_1h_usd` double DEFAULT NULL,
  `percent_change_24h_usd` double DEFAULT NULL,
  `percent_change_7d_usd` double DEFAULT NULL,
  `market_cap_usd` double DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BTC监视器固定法币费率历史';

-- ----------------------------
-- Table structure for cc_exchange
-- ----------------------------
DROP TABLE IF EXISTS `cc_exchange`;
CREATE TABLE `cc_exchange` (
  `id` int(10) NOT NULL,
  `exchangeid` int(11) NOT NULL COMMENT '主键',
  `slug` varchar(32) NOT NULL COMMENT '交易所id',
  `website` varchar(100) NOT NULL COMMENT '交易所网站地址',
  `name` varchar(64) NOT NULL COMMENT '交易所名称',
  `is_active` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `exchange_id` (`slug`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cc_float_exchange
-- ----------------------------
DROP TABLE IF EXISTS `cc_float_exchange`;
CREATE TABLE `cc_float_exchange` (
  `id` varchar(32) NOT NULL,
  `exchange_id` int(12) NOT NULL,
  `name` varchar(64) NOT NULL,
  `slug` varchar(32) NOT NULL,
  `num_market_pairs` int(11) NOT NULL,
  `b_volume_24h` double DEFAULT NULL,
  `q_volume_24h` double DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exchange_id` (`exchange_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cc_legalcurrency
-- ----------------------------
DROP TABLE IF EXISTS `cc_legalcurrency`;
CREATE TABLE `cc_legalcurrency` (
  `id` int(11) NOT NULL,
  `name` varchar(64) DEFAULT NULL COMMENT '名称',
  `en_name` varchar(64) DEFAULT NULL COMMENT '英文名',
  `jp_name` varchar(64) DEFAULT NULL COMMENT '日文名',
  `symbol` varchar(32) NOT NULL COMMENT '符号',
  `is_actived` varchar(1) DEFAULT NULL COMMENT '是否有效 是:Y 否:N',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='法定货币';

-- ----------------------------
-- Table structure for cc_specific_rate
-- ----------------------------
DROP TABLE IF EXISTS `cc_specific_rate`;
CREATE TABLE `cc_specific_rate` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `base_id` int(11) DEFAULT NULL,
  `base_symbol` varchar(32) DEFAULT NULL COMMENT '交易币种',
  `base_name` varchar(32) DEFAULT NULL,
  `quote_symbol` varchar(32) DEFAULT NULL COMMENT '兑换币种',
  `price` double DEFAULT NULL,
  `volume_24h` double DEFAULT NULL,
  `percent_change_1h` double DEFAULT NULL,
  `percent_change_24h` double DEFAULT NULL,
  `percent_change_7d` double DEFAULT NULL,
  `market_cap` double DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `base_symbol` (`base_symbol`) USING BTREE,
  KEY `quote_symbol` (`quote_symbol`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cc_symbol
-- ----------------------------
DROP TABLE IF EXISTS `cc_symbol`;
CREATE TABLE `cc_symbol` (
  `id` int(11) NOT NULL COMMENT '主键',
  `symbol_id` varchar(100) NOT NULL COMMENT '符号id',
  `exchange_id` varchar(32) NOT NULL COMMENT '交易所id',
  `symbol_type` varchar(32) NOT NULL COMMENT '符号类型:SPOT/FuTURES/OPTION',
  `asset_id_base` varchar(32) NOT NULL,
  `asset_id_quote` varchar(32) NOT NULL,
  PRIMARY KEY (`id`,`symbol_id`),
  KEY `symbol_id` (`symbol_id`) USING BTREE,
  KEY `exchange_id` (`exchange_id`) USING BTREE,
  KEY `asset_id_base` (`asset_id_base`) USING BTREE,
  KEY `asset_id_quote` (`asset_id_quote`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cgform_button
-- ----------------------------
DROP TABLE IF EXISTS `cgform_button`;
CREATE TABLE `cgform_button` (
  `ID` varchar(32) NOT NULL COMMENT '主键ID',
  `BUTTON_CODE` varchar(50) DEFAULT NULL COMMENT '按钮编码',
  `button_icon` varchar(20) DEFAULT NULL COMMENT '按钮图标',
  `BUTTON_NAME` varchar(50) DEFAULT NULL COMMENT '按钮名称',
  `BUTTON_STATUS` varchar(2) DEFAULT NULL COMMENT '按钮状态',
  `BUTTON_STYLE` varchar(20) DEFAULT NULL COMMENT '按钮样式',
  `EXP` varchar(255) DEFAULT NULL COMMENT '表达式',
  `FORM_ID` varchar(32) DEFAULT NULL COMMENT '表单ID',
  `OPT_TYPE` varchar(20) DEFAULT NULL COMMENT '按钮类型',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`ID`),
  KEY `index_formid` (`FORM_ID`) USING BTREE,
  KEY `index_button_code` (`BUTTON_CODE`) USING BTREE,
  KEY `index_button_status` (`BUTTON_STATUS`) USING BTREE,
  KEY `index_button_order` (`order_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cgform_button_sql
-- ----------------------------
DROP TABLE IF EXISTS `cgform_button_sql`;
CREATE TABLE `cgform_button_sql` (
  `ID` varchar(32) NOT NULL COMMENT '主键ID',
  `BUTTON_CODE` varchar(50) DEFAULT NULL COMMENT '按钮编码',
  `CGB_SQL` longtext COMMENT 'SQL内容',
  `CGB_SQL_NAME` varchar(50) DEFAULT NULL COMMENT 'Sql名称',
  `CONTENT` varchar(1000) DEFAULT NULL COMMENT '备注',
  `FORM_ID` varchar(32) DEFAULT NULL COMMENT '表单ID',
  PRIMARY KEY (`ID`),
  KEY `index_formid` (`FORM_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cgform_enhance_java
-- ----------------------------
DROP TABLE IF EXISTS `cgform_enhance_java`;
CREATE TABLE `cgform_enhance_java` (
  `id` varchar(36) NOT NULL,
  `button_code` varchar(32) DEFAULT NULL COMMENT '按钮编码',
  `cg_java_type` varchar(32) NOT NULL COMMENT '类型',
  `cg_java_value` varchar(200) NOT NULL COMMENT '数值',
  `form_id` varchar(32) NOT NULL COMMENT '表单ID',
  `active_status` varchar(2) DEFAULT '1' COMMENT '生效状态',
  PRIMARY KEY (`id`),
  KEY `index_fmid` (`form_id`) USING BTREE,
  KEY `index_buttoncode` (`button_code`) USING BTREE,
  KEY `index_status` (`active_status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cgform_enhance_js
-- ----------------------------
DROP TABLE IF EXISTS `cgform_enhance_js`;
CREATE TABLE `cgform_enhance_js` (
  `ID` varchar(32) NOT NULL COMMENT '主键ID',
  `CG_JS` longtext COMMENT 'JS增强内容',
  `CG_JS_TYPE` varchar(20) DEFAULT NULL COMMENT '类型',
  `CONTENT` varchar(1000) DEFAULT NULL COMMENT '备注',
  `FORM_ID` varchar(32) DEFAULT NULL COMMENT '表单ID',
  PRIMARY KEY (`ID`),
  KEY `index_fmid` (`FORM_ID`) USING BTREE,
  KEY `index_jstype` (`CG_JS_TYPE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cgform_field
-- ----------------------------
DROP TABLE IF EXISTS `cgform_field`;
CREATE TABLE `cgform_field` (
  `id` varchar(32) NOT NULL COMMENT '主键ID',
  `content` varchar(200) NOT NULL COMMENT '字段备注',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人名字',
  `dict_field` varchar(100) DEFAULT NULL COMMENT '字典code',
  `dict_table` varchar(100) DEFAULT NULL COMMENT '字典表',
  `dict_text` varchar(100) DEFAULT NULL COMMENT '字典Text',
  `field_default` varchar(20) DEFAULT NULL COMMENT '表字段默认值',
  `field_href` varchar(200) DEFAULT NULL COMMENT '跳转URL',
  `field_length` int(11) DEFAULT NULL COMMENT '表单控件长度',
  `field_name` varchar(32) NOT NULL COMMENT '字段名字',
  `field_valid_type` varchar(300) DEFAULT NULL COMMENT '表单字段校验规则',
  `field_must_input` varchar(2) DEFAULT NULL COMMENT '字段是否必填',
  `is_key` varchar(2) DEFAULT NULL COMMENT '是否主键',
  `is_null` varchar(5) DEFAULT NULL COMMENT '是否允许为空',
  `is_query` varchar(5) DEFAULT NULL COMMENT '是否查询条件',
  `is_show` varchar(5) DEFAULT NULL COMMENT '表单是否显示',
  `is_show_list` varchar(5) DEFAULT NULL COMMENT '列表是否显示',
  `length` int(11) NOT NULL COMMENT '数据库字段长度',
  `main_field` varchar(100) DEFAULT NULL COMMENT '外键主键字段',
  `main_table` varchar(100) DEFAULT NULL COMMENT '外键主表名',
  `old_field_name` varchar(32) DEFAULT NULL COMMENT '原字段名',
  `order_num` int(11) DEFAULT NULL COMMENT '原排列序号',
  `point_length` int(11) DEFAULT NULL COMMENT '小数点',
  `query_mode` varchar(10) DEFAULT NULL COMMENT '查询模式',
  `show_type` varchar(10) DEFAULT NULL COMMENT '表单控件类型',
  `type` varchar(32) NOT NULL COMMENT '数据库字段类型',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人名称',
  `table_id` varchar(32) NOT NULL COMMENT '表ID',
  `extend_json` varchar(500) DEFAULT NULL COMMENT '扩展参数JSON',
  `fill_rule_code` varchar(500) DEFAULT NULL COMMENT '填值规则code',
  PRIMARY KEY (`id`),
  KEY `inex_table_id` (`table_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cgform_ftl
-- ----------------------------
DROP TABLE IF EXISTS `cgform_ftl`;
CREATE TABLE `cgform_ftl` (
  `ID` varchar(32) NOT NULL COMMENT '主键ID',
  `CGFORM_ID` varchar(36) NOT NULL COMMENT '表单ID',
  `CGFORM_NAME` varchar(100) NOT NULL COMMENT '表单名字',
  `CREATE_BY` varchar(36) DEFAULT NULL COMMENT '创建人',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `CREATE_NAME` varchar(32) DEFAULT NULL COMMENT '创建人名字',
  `FTL_CONTENT` longtext COMMENT '设计模板内容',
  `FTL_STATUS` varchar(50) DEFAULT NULL COMMENT '模板激活状态',
  `FTL_VERSION` int(11) NOT NULL COMMENT '模板编号',
  `FTL_WORD_URL` varchar(200) DEFAULT NULL COMMENT '上传Word路径',
  `UPDATE_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
  `UPDATE_DATE` datetime DEFAULT NULL COMMENT '修改时间',
  `UPDATE_NAME` varchar(32) DEFAULT NULL COMMENT '修改人名字',
  `editor_type` varchar(10) DEFAULT '01' COMMENT '类型',
  PRIMARY KEY (`ID`),
  KEY `inex_table_id` (`CGFORM_ID`) USING BTREE,
  KEY `index_ftl_status` (`FTL_STATUS`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cgform_head
-- ----------------------------
DROP TABLE IF EXISTS `cgform_head`;
CREATE TABLE `cgform_head` (
  `id` varchar(32) NOT NULL COMMENT '主键ID',
  `content` varchar(200) NOT NULL COMMENT '表描述',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人名称',
  `is_checkbox` varchar(5) NOT NULL COMMENT '是否带checkbox',
  `is_dbsynch` varchar(20) NOT NULL COMMENT '同步数据库状态',
  `is_pagination` varchar(5) NOT NULL COMMENT '是否分页',
  `is_tree` varchar(5) NOT NULL COMMENT '是否是树',
  `jform_pk_sequence` varchar(200) DEFAULT NULL COMMENT '主键生成序列',
  `jform_pk_type` varchar(100) DEFAULT NULL COMMENT '主键类型',
  `jform_type` int(11) NOT NULL COMMENT '表类型:单表、主表、附表',
  `jform_version` varchar(10) NOT NULL COMMENT '表单版本号',
  `querymode` varchar(10) NOT NULL COMMENT '查询模式',
  `relation_type` int(11) DEFAULT NULL,
  `sub_table_str` varchar(1000) DEFAULT NULL COMMENT '子表',
  `tab_order` int(11) DEFAULT NULL COMMENT '附表排序序号',
  `table_name` varchar(50) NOT NULL COMMENT '表名',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人名字',
  `tree_parentid_fieldname` varchar(50) DEFAULT NULL COMMENT '树形表单父id',
  `tree_id_fieldname` varchar(50) DEFAULT NULL COMMENT '树表主键字段',
  `tree_fieldname` varchar(50) DEFAULT NULL COMMENT '树开表单列字段',
  `jform_category` varchar(50) NOT NULL DEFAULT 'bdfl_ptbd' COMMENT '表单分类',
  `form_template` varchar(50) DEFAULT NULL COMMENT 'PC表单模板',
  `form_template_mobile` varchar(50) DEFAULT NULL COMMENT '表单模板样式(移动端)',
  `table_type` varchar(50) DEFAULT NULL COMMENT '''0''为物理表，‘1’为配置表',
  `table_version` int(11) DEFAULT NULL COMMENT '表版本',
  `physice_id` varchar(32) DEFAULT NULL COMMENT '物理表id(配置表用)',
  PRIMARY KEY (`id`),
  KEY `index_table_type` (`table_type`) USING BTREE,
  KEY `index_physice_id` (`physice_id`) USING BTREE,
  KEY `index_form_templdate` (`form_template`) USING BTREE,
  KEY `index_templdate_mobile` (`form_template_mobile`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cgform_index
-- ----------------------------
DROP TABLE IF EXISTS `cgform_index`;
CREATE TABLE `cgform_index` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `index_name` varchar(100) DEFAULT NULL COMMENT '索引名称',
  `index_field` varchar(500) DEFAULT NULL COMMENT '索引栏位',
  `index_type` varchar(32) DEFAULT NULL COMMENT '索引类型',
  `table_id` varchar(32) DEFAULT NULL COMMENT '主表id',
  PRIMARY KEY (`id`),
  KEY `index_table_id` (`table_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cgform_template
-- ----------------------------
DROP TABLE IF EXISTS `cgform_template`;
CREATE TABLE `cgform_template` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `template_name` varchar(100) DEFAULT NULL COMMENT '模板名称',
  `template_code` varchar(50) DEFAULT NULL COMMENT '模板编码',
  `template_type` varchar(32) DEFAULT NULL COMMENT '模板类型',
  `template_share` varchar(10) DEFAULT NULL COMMENT '是否共享',
  `template_pic` varchar(100) DEFAULT NULL COMMENT '预览图',
  `template_comment` varchar(200) DEFAULT NULL COMMENT '模板描述',
  `template_list_name` varchar(200) DEFAULT NULL COMMENT '列表模板名称\r\n',
  `template_add_name` varchar(200) DEFAULT NULL COMMENT '录入模板名称',
  `template_update_name` varchar(200) DEFAULT NULL COMMENT '编辑模板名\r\n称',
  `template_detail_name` varchar(200) DEFAULT NULL COMMENT '查看页面模\r\n板名称',
  `status` int(11) DEFAULT NULL COMMENT '有效状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cgform_uploadfiles
-- ----------------------------
DROP TABLE IF EXISTS `cgform_uploadfiles`;
CREATE TABLE `cgform_uploadfiles` (
  `id` varchar(32) NOT NULL COMMENT '主键ID',
  `CGFORM_FIELD` varchar(100) NOT NULL COMMENT '表单字段',
  `CGFORM_ID` varchar(36) NOT NULL COMMENT '表单ID',
  `CGFORM_NAME` varchar(100) NOT NULL COMMENT '表单名称',
  PRIMARY KEY (`id`),
  KEY `FK_qwig8sn3okhvh4wye8nn8gdeg` (`id`) USING BTREE,
  KEY `index_fieldid` (`CGFORM_FIELD`) USING BTREE,
  KEY `index_formid` (`CGFORM_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jeecg_custom_info
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_custom_info`;
CREATE TABLE `jeecg_custom_info` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `cust_name` varchar(100) DEFAULT NULL COMMENT '客户名称',
  `cust_addr` varchar(200) DEFAULT NULL COMMENT '地址',
  `cust_code` varchar(50) DEFAULT NULL COMMENT '客户编号',
  `email` varchar(50) DEFAULT NULL COMMENT 'email',
  `cust_charge` varchar(50) DEFAULT NULL COMMENT '负责人',
  `sex` varchar(10) DEFAULT NULL COMMENT '性别',
  `age` varchar(32) DEFAULT NULL COMMENT '年龄',
  `position` varchar(32) DEFAULT NULL COMMENT '职务',
  `phone` varchar(32) DEFAULT NULL COMMENT '电话',
  `bank` varchar(100) DEFAULT NULL COMMENT '往来银行',
  `money` varchar(100) DEFAULT NULL COMMENT '现金情况',
  `promoter` varchar(50) DEFAULT NULL COMMENT '承办人',
  `account` varchar(100) DEFAULT NULL COMMENT '账号',
  `turnover` varchar(32) DEFAULT NULL COMMENT '资金周转',
  `payment_attr` varchar(100) DEFAULT NULL COMMENT '付款态度',
  `sax_num` varchar(100) DEFAULT NULL COMMENT '税号',
  `pay_date` varchar(100) DEFAULT NULL COMMENT '付款日期',
  `begin_pay_date` varchar(100) DEFAULT NULL COMMENT '开始交易日期',
  `main_bus` varchar(100) DEFAULT NULL COMMENT '主营产品',
  `bus_pro` varchar(100) DEFAULT NULL COMMENT '营业项目',
  `warehouse` varchar(100) DEFAULT NULL COMMENT '仓库情况',
  `people` varchar(100) DEFAULT NULL COMMENT '员工人数及素质',
  `transportation` varchar(100) DEFAULT NULL COMMENT '运输方式',
  `operation` varchar(100) DEFAULT NULL COMMENT '经营体制',
  `car` varchar(20) DEFAULT NULL COMMENT '服务车数目',
  `shopkeeper` varchar(100) DEFAULT NULL COMMENT '零售商数及覆盖情况',
  `wholesale` varchar(10) DEFAULT NULL COMMENT '批发商数',
  `bus_scope` varchar(100) DEFAULT NULL COMMENT '营业范围',
  `area` varchar(100) DEFAULT NULL COMMENT '门市面积',
  `management` varchar(200) DEFAULT NULL COMMENT '经营方针',
  `stock1` varchar(10) DEFAULT NULL COMMENT '进货',
  `stock2` varchar(10) DEFAULT NULL COMMENT '进货',
  `sale1` varchar(10) DEFAULT NULL COMMENT '销售',
  `sale2` varchar(10) DEFAULT NULL COMMENT '销售',
  `inventory1` varchar(100) DEFAULT NULL COMMENT '存货',
  `inventory2` varchar(100) DEFAULT NULL COMMENT '存货',
  `max_money` varchar(100) DEFAULT NULL COMMENT '最高信用额度',
  `cust_level` varchar(100) DEFAULT NULL COMMENT '客户等级',
  `all_avg_inventory` varchar(100) DEFAULT NULL COMMENT '总体月均库存数',
  `avg_inventory` varchar(100) DEFAULT NULL COMMENT '月均库存数',
  `price` varchar(100) DEFAULT NULL COMMENT '价格折扣',
  `promise` varchar(100) DEFAULT NULL COMMENT '支持和服务的承诺',
  `competing_goods` varchar(100) DEFAULT NULL COMMENT '竞品经营情况',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jeecg_custom_record
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_custom_record`;
CREATE TABLE `jeecg_custom_record` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `custom_id` varchar(32) DEFAULT NULL COMMENT '客户编号',
  `header` varchar(32) DEFAULT NULL COMMENT '负责人',
  `establish_date` datetime DEFAULT NULL COMMENT '成立日期',
  `custom_name` varchar(32) DEFAULT NULL COMMENT '客户名称',
  `capital_lines` double DEFAULT NULL COMMENT '资本额',
  `address` varchar(32) DEFAULT NULL COMMENT '地址',
  `phone` varchar(32) DEFAULT NULL COMMENT '电话',
  `business_type` varchar(32) DEFAULT NULL COMMENT '营业类型',
  `fax` varchar(32) DEFAULT NULL COMMENT '传真',
  `banks` varchar(32) DEFAULT NULL COMMENT '主要往来银行',
  `other_business` varchar(32) DEFAULT NULL COMMENT '其他投资事业',
  `turnover` varchar(32) DEFAULT NULL COMMENT '平均每日营业额',
  `business` varchar(32) DEFAULT NULL COMMENT '主要业务往来',
  `pay_type` varchar(32) DEFAULT NULL COMMENT '付款方式',
  `business_contacts` varchar(32) DEFAULT NULL COMMENT '与本公司往来',
  `collection` varchar(32) DEFAULT NULL COMMENT '收款记录',
  `business_important_contacts` varchar(32) DEFAULT NULL COMMENT '最近与本公司往来重要记录',
  `business_record` varchar(32) DEFAULT NULL COMMENT '最近交易数据跟踪',
  `customer_opinion` varchar(32) DEFAULT NULL COMMENT '客户意见',
  `credit_evaluation` varchar(32) DEFAULT NULL COMMENT '信用评定',
  `preparer` varchar(32) DEFAULT NULL COMMENT '填表人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jeecg_demo
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_demo`;
CREATE TABLE `jeecg_demo` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `age` int(10) DEFAULT NULL COMMENT '年龄',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `content` text COMMENT '个人介绍',
  `dep_id` varchar(255) DEFAULT NULL COMMENT '部门',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(255) DEFAULT NULL COMMENT '电话',
  `salary` double(16,2) DEFAULT NULL COMMENT '工资',
  `sex` varchar(255) DEFAULT NULL COMMENT '性别',
  `touxiang` varchar(255) DEFAULT NULL COMMENT '头像',
  `fujian` varchar(255) DEFAULT NULL COMMENT '附件',
  `status` varchar(255) DEFAULT NULL COMMENT '入职状态',
  `create_date` datetime DEFAULT NULL COMMENT 'createDate',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人id',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人',
  `sys_org_code` varchar(200) DEFAULT NULL COMMENT '部门编码',
  `sys_company_code` varchar(200) DEFAULT NULL COMMENT '公司编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jeecg_demo_excel
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_demo_excel`;
CREATE TABLE `jeecg_demo_excel` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `name` varchar(100) DEFAULT NULL COMMENT '姓名',
  `sex` varchar(3) DEFAULT NULL COMMENT '性别',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `depart` varchar(36) DEFAULT NULL COMMENT '关联部门',
  `fd_replace` varchar(255) DEFAULT NULL COMMENT '测试替换',
  `fd_convert` varchar(255) DEFAULT NULL COMMENT '测试转换',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='excel导入导出示例';

-- ----------------------------
-- Table structure for jeecg_multi_upload
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_multi_upload`;
CREATE TABLE `jeecg_multi_upload` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `test_file_1` longtext COMMENT '测试文件1',
  `test_file_2` longtext COMMENT '测试文件2',
  `test_file_3` longtext COMMENT '测试文件3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jeecg_order_custom
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_order_custom`;
CREATE TABLE `jeecg_order_custom` (
  `ID` varchar(32) NOT NULL,
  `CREATE_DT` datetime DEFAULT NULL,
  `CRTUSER` varchar(12) DEFAULT NULL,
  `CRTUSER_NAME` varchar(10) DEFAULT NULL,
  `DEL_DT` datetime DEFAULT NULL,
  `DELFLAG` int(11) DEFAULT NULL,
  `GO_ORDER_CODE` varchar(32) NOT NULL,
  `GOC_BUSS_CONTENT` varchar(33) DEFAULT NULL,
  `GOC_CONTENT` varchar(66) DEFAULT NULL,
  `GOC_CUS_NAME` varchar(16) DEFAULT NULL,
  `GOC_IDCARD` varchar(18) DEFAULT NULL,
  `GOC_PASSPORT_CODE` varchar(10) DEFAULT NULL,
  `GOC_SEX` varchar(255) DEFAULT NULL,
  `MODIFIER` varchar(12) DEFAULT NULL,
  `MODIFIER_NAME` varchar(10) DEFAULT NULL,
  `MODIFY_DT` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jeecg_order_main
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_order_main`;
CREATE TABLE `jeecg_order_main` (
  `ID` varchar(32) NOT NULL,
  `CREATE_DT` datetime DEFAULT NULL,
  `CRTUSER` varchar(12) DEFAULT NULL,
  `CRTUSER_NAME` varchar(10) DEFAULT NULL,
  `DEL_DT` datetime DEFAULT NULL,
  `DELFLAG` int(11) DEFAULT NULL,
  `GO_ALL_PRICE` decimal(10,2) DEFAULT NULL,
  `GO_CONTACT_NAME` varchar(16) DEFAULT NULL,
  `GO_CONTENT` varchar(66) DEFAULT NULL,
  `GO_ORDER_CODE` varchar(12) NOT NULL,
  `GO_ORDER_COUNT` int(11) DEFAULT NULL,
  `GO_RETURN_PRICE` decimal(10,2) DEFAULT NULL,
  `GO_TELPHONE` varchar(11) DEFAULT NULL,
  `GODER_TYPE` varchar(255) DEFAULT NULL,
  `MODIFIER` varchar(12) DEFAULT NULL,
  `MODIFIER_NAME` varchar(10) DEFAULT NULL,
  `MODIFY_DT` datetime DEFAULT NULL,
  `USERTYPE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jeecg_order_product
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_order_product`;
CREATE TABLE `jeecg_order_product` (
  `ID` varchar(32) NOT NULL,
  `CREATE_DT` datetime DEFAULT NULL,
  `CRTUSER` varchar(12) DEFAULT NULL,
  `CRTUSER_NAME` varchar(10) DEFAULT NULL,
  `DEL_DT` datetime DEFAULT NULL,
  `DELFLAG` int(11) DEFAULT NULL,
  `GO_ORDER_CODE` varchar(12) NOT NULL,
  `GOP_CONTENT` varchar(66) DEFAULT NULL,
  `GOP_COUNT` int(11) DEFAULT NULL,
  `GOP_ONE_PRICE` decimal(10,2) DEFAULT NULL,
  `GOP_PRODUCT_NAME` varchar(33) DEFAULT NULL,
  `GOP_PRODUCT_TYPE` varchar(1) NOT NULL,
  `GOP_SUM_PRICE` decimal(10,2) DEFAULT NULL,
  `MODIFIER` varchar(12) DEFAULT NULL,
  `MODIFIER_NAME` varchar(10) DEFAULT NULL,
  `MODIFY_DT` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jeecg_p3demo
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_p3demo`;
CREATE TABLE `jeecg_p3demo` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT NULL COMMENT '流程状态',
  `name` varchar(32) DEFAULT NULL COMMENT '姓名',
  `sex` int(11) DEFAULT NULL COMMENT '性别',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `address` varchar(32) DEFAULT NULL COMMENT '地址',
  `phone` varchar(32) DEFAULT NULL COMMENT '电话',
  `memo` text COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_cgdynamgraph_head
-- ----------------------------
DROP TABLE IF EXISTS `jform_cgdynamgraph_head`;
CREATE TABLE `jform_cgdynamgraph_head` (
  `ID` varchar(36) NOT NULL COMMENT '主键ID',
  `CGR_SQL` varchar(1000) NOT NULL COMMENT '移动报表SQL',
  `CODE` varchar(36) NOT NULL COMMENT '移动报表编码',
  `CONTENT` varchar(500) NOT NULL COMMENT '描述',
  `NAME` varchar(100) NOT NULL COMMENT '移动报表名字',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人id',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人id',
  `db_source` varchar(36) DEFAULT NULL COMMENT '动态数据源',
  `graph_type` varchar(36) DEFAULT NULL COMMENT '移动报表类型',
  `data_structure` varchar(36) DEFAULT NULL COMMENT '数据结构类型',
  `is_pagination` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `index_code` (`CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_cgdynamgraph_item
-- ----------------------------
DROP TABLE IF EXISTS `jform_cgdynamgraph_item`;
CREATE TABLE `jform_cgdynamgraph_item` (
  `ID` varchar(36) NOT NULL,
  `S_FLAG` varchar(2) DEFAULT NULL COMMENT '是否查询',
  `S_MODE` varchar(10) DEFAULT NULL COMMENT '查询模式',
  `CGRHEAD_ID` varchar(36) DEFAULT NULL COMMENT '报表ID',
  `DICT_CODE` varchar(36) DEFAULT NULL COMMENT '字段code',
  `FIELD_HREF` varchar(120) DEFAULT NULL COMMENT '字段跳转URL',
  `FIELD_NAME` varchar(36) DEFAULT NULL COMMENT '字段名字',
  `FIELD_TXT` longtext COMMENT '字段文本',
  `FIELD_TYPE` varchar(10) DEFAULT NULL COMMENT '字段类型',
  `IS_SHOW` varchar(5) DEFAULT NULL COMMENT '是否显示',
  `ORDER_NUM` int(11) DEFAULT NULL COMMENT '排序',
  `REPLACE_VA` varchar(36) DEFAULT NULL COMMENT '取值表达式',
  PRIMARY KEY (`ID`),
  KEY `index1` (`CGRHEAD_ID`) USING BTREE,
  KEY `index2` (`IS_SHOW`) USING BTREE,
  KEY `index3` (`ORDER_NUM`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_cgdynamgraph_param
-- ----------------------------
DROP TABLE IF EXISTS `jform_cgdynamgraph_param`;
CREATE TABLE `jform_cgdynamgraph_param` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `param_name` varchar(32) NOT NULL COMMENT '参数名称',
  `param_desc` varchar(32) DEFAULT NULL COMMENT '参数说明',
  `param_value` varchar(32) DEFAULT NULL COMMENT '数值',
  `seq` int(11) DEFAULT NULL COMMENT '排序',
  `cgrhead_id` varchar(36) DEFAULT NULL COMMENT '动态报表ID',
  PRIMARY KEY (`id`),
  KEY `index_headid` (`cgrhead_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_cgreport_head
-- ----------------------------
DROP TABLE IF EXISTS `jform_cgreport_head`;
CREATE TABLE `jform_cgreport_head` (
  `ID` varchar(36) NOT NULL,
  `CGR_SQL` varchar(1000) NOT NULL COMMENT '报表SQL',
  `CODE` varchar(36) NOT NULL COMMENT '报表编码',
  `CONTENT` varchar(1000) NOT NULL COMMENT '描述',
  `NAME` varchar(100) NOT NULL COMMENT '报表名字',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人id',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人id',
  `db_source` varchar(36) DEFAULT NULL COMMENT '动态数据源',
  `return_val_field` varchar(100) DEFAULT NULL COMMENT '返回值字段',
  `return_txt_field` varchar(100) DEFAULT NULL COMMENT '返回文本字段',
  `pop_retype` varchar(2) DEFAULT '1' COMMENT '返回类型，单选或多选',
  PRIMARY KEY (`ID`),
  KEY `index_code` (`CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_cgreport_item
-- ----------------------------
DROP TABLE IF EXISTS `jform_cgreport_item`;
CREATE TABLE `jform_cgreport_item` (
  `ID` varchar(36) NOT NULL,
  `S_FLAG` varchar(2) DEFAULT NULL COMMENT '是否查询',
  `S_MODE` varchar(10) DEFAULT NULL COMMENT '查询模式',
  `CGRHEAD_ID` varchar(36) DEFAULT NULL COMMENT '报表ID',
  `DICT_CODE` varchar(36) DEFAULT NULL COMMENT '字典CODE',
  `FIELD_HREF` varchar(120) DEFAULT NULL COMMENT '字段跳转URL',
  `FIELD_NAME` varchar(36) DEFAULT NULL COMMENT '字段名字',
  `FIELD_TXT` longtext COMMENT '字段文本',
  `FIELD_TYPE` varchar(10) DEFAULT NULL COMMENT '字段类型',
  `IS_SHOW` varchar(5) DEFAULT NULL COMMENT '是否显示',
  `ORDER_NUM` int(11) DEFAULT NULL COMMENT '排序',
  `REPLACE_VA` varchar(36) DEFAULT NULL COMMENT '取值表达式',
  PRIMARY KEY (`ID`),
  KEY `index_CGRHEAD_ID` (`CGRHEAD_ID`) USING BTREE,
  KEY `index_isshow` (`IS_SHOW`) USING BTREE,
  KEY `index_order_num` (`ORDER_NUM`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_cgreport_param
-- ----------------------------
DROP TABLE IF EXISTS `jform_cgreport_param`;
CREATE TABLE `jform_cgreport_param` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `param_name` varchar(32) NOT NULL COMMENT '参数名称',
  `param_desc` varchar(32) DEFAULT NULL COMMENT '参数说明',
  `param_value` varchar(32) DEFAULT NULL COMMENT '数值',
  `seq` int(11) DEFAULT NULL COMMENT '排序',
  `cgrhead_id` varchar(36) DEFAULT NULL COMMENT '动态报表ID',
  PRIMARY KEY (`id`),
  KEY `idx_cgrheadid` (`cgrhead_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_contact
-- ----------------------------
DROP TABLE IF EXISTS `jform_contact`;
CREATE TABLE `jform_contact` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `name` varchar(100) NOT NULL COMMENT '姓名',
  `sex` varchar(50) NOT NULL COMMENT '性别',
  `groups` varchar(200) DEFAULT NULL COMMENT '所属分组',
  `company` varchar(200) DEFAULT NULL COMMENT '公司名称',
  `position` varchar(100) DEFAULT NULL COMMENT '职位',
  `mobile` varchar(30) DEFAULT NULL COMMENT '移动电话',
  `office_phone` varchar(30) DEFAULT NULL COMMENT '办公电话',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_contact_group
-- ----------------------------
DROP TABLE IF EXISTS `jform_contact_group`;
CREATE TABLE `jform_contact_group` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `name` varchar(32) NOT NULL COMMENT '分组名称',
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`) USING BTREE,
  KEY `index_bpm_status` (`bpm_status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_employee_cost_claim
-- ----------------------------
DROP TABLE IF EXISTS `jform_employee_cost_claim`;
CREATE TABLE `jform_employee_cost_claim` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'id',
  `staff_name` varchar(50) DEFAULT NULL COMMENT '职工姓名',
  `depart` varchar(50) DEFAULT NULL COMMENT '部门',
  `staff_no` varchar(30) DEFAULT NULL COMMENT '员工编号',
  `staff_post` varchar(50) DEFAULT NULL COMMENT '职位',
  `pay_way` varchar(10) DEFAULT NULL COMMENT '打款方式',
  `acct_bank` varchar(100) DEFAULT NULL COMMENT '开户行',
  `card_no` varchar(30) DEFAULT NULL COMMENT '卡号',
  `tele_no` varchar(20) DEFAULT NULL COMMENT '联系手机号',
  `cost_all` decimal(7,2) DEFAULT NULL COMMENT '费用合计',
  `documents` varchar(2) DEFAULT NULL COMMENT '单据数量',
  `cost_upper` varchar(50) DEFAULT NULL COMMENT '费用大写',
  `prepaid_fee` decimal(7,2) DEFAULT NULL COMMENT '预支款项',
  `real_fee` decimal(7,2) DEFAULT NULL COMMENT '实际支付',
  `fill_time` date DEFAULT NULL,
  `apply_time` date DEFAULT NULL,
  `apply_by` varchar(50) DEFAULT NULL COMMENT '申请人',
  `comments` varchar(100) DEFAULT NULL COMMENT '备注',
  `depart_approve` varchar(100) DEFAULT NULL COMMENT '部门审批',
  `finance_approve` varchar(100) DEFAULT NULL COMMENT '财务审批',
  `mgr_approve` varchar(100) DEFAULT NULL COMMENT '总经理审批',
  `treasurer` varchar(100) DEFAULT NULL COMMENT '出纳',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_employee_entry
-- ----------------------------
DROP TABLE IF EXISTS `jform_employee_entry`;
CREATE TABLE `jform_employee_entry` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '填表日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `employee_name` varchar(32) DEFAULT NULL COMMENT '姓名',
  `employee_depart` varchar(50) DEFAULT NULL COMMENT '部门',
  `employee_job` varchar(32) DEFAULT NULL COMMENT '职务',
  `employee_birthday` datetime DEFAULT NULL COMMENT '生日',
  `employee_origin` varchar(50) DEFAULT NULL COMMENT '籍贯',
  `employee_degree` varchar(32) DEFAULT NULL COMMENT '学历',
  `employee_identification` varchar(50) DEFAULT NULL COMMENT '身份证',
  `employee_entry_date` datetime DEFAULT NULL COMMENT '入职日期',
  `employee_code` varchar(32) DEFAULT NULL COMMENT '工号',
  `employee_phone` varchar(32) DEFAULT NULL COMMENT '手机',
  `employee_mail` varchar(150) DEFAULT NULL COMMENT '邮箱',
  `employee_msn` varchar(32) DEFAULT NULL COMMENT 'MSN',
  `hr_pic` varchar(2) DEFAULT NULL COMMENT '照片',
  `hr_archives` varchar(2) DEFAULT NULL COMMENT '档案表',
  `hr_identification` varchar(2) DEFAULT NULL COMMENT '身份证',
  `hr_degree` varchar(2) DEFAULT NULL COMMENT '学位证',
  `hr_other` varchar(2) DEFAULT NULL COMMENT '其他证件',
  `hr_tel` varchar(2) DEFAULT NULL COMMENT '分配电话',
  `hr_op_user` varchar(32) DEFAULT NULL COMMENT '经办人',
  `hr_op_date` datetime DEFAULT NULL COMMENT '日期',
  `depart_opinion` varchar(200) DEFAULT NULL COMMENT '部门意见',
  `depart_op_user` varchar(32) DEFAULT NULL COMMENT '经办人',
  `depart_op_date` datetime DEFAULT NULL COMMENT '日期',
  `manager_opinion` varchar(200) DEFAULT NULL COMMENT '总经理意见',
  `manager_op_user` varchar(32) DEFAULT NULL COMMENT '经办人',
  `manager_op_date` datetime DEFAULT NULL COMMENT '日期',
  `employee_opinion` varchar(200) DEFAULT NULL COMMENT '新员工意见',
  `employee_op_user` varchar(32) DEFAULT NULL COMMENT '经办人',
  `employee_op_date` datetime DEFAULT NULL COMMENT '日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_employee_leave
-- ----------------------------
DROP TABLE IF EXISTS `jform_employee_leave`;
CREATE TABLE `jform_employee_leave` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `apply_date` datetime DEFAULT NULL COMMENT '申请日期',
  `duty` varchar(100) DEFAULT NULL COMMENT '职务',
  `leave_category` varchar(100) DEFAULT NULL COMMENT '请假类别',
  `leave_reason` varchar(100) DEFAULT NULL COMMENT '请假原因',
  `leave_start_date` datetime DEFAULT NULL COMMENT '请假开始时间',
  `leave_end_date` datetime DEFAULT NULL COMMENT '请假结束时间',
  `total` int(5) DEFAULT NULL COMMENT '共计',
  `contact_way` varchar(20) DEFAULT NULL COMMENT '紧急联系方式',
  `duty_deputy` varchar(100) DEFAULT NULL COMMENT '批定职务代理人',
  `leader_approval` varchar(50) DEFAULT NULL COMMENT '直接主管审批',
  `dept_principal_approval` varchar(50) DEFAULT NULL COMMENT '部门负责人审批',
  `hr_principal_approval` varchar(50) DEFAULT NULL COMMENT 'HR负责人审批',
  `hr_records` varchar(50) DEFAULT NULL COMMENT '行政部备案',
  `department` varchar(50) DEFAULT NULL COMMENT '部门',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_employee_meals_cost
-- ----------------------------
DROP TABLE IF EXISTS `jform_employee_meals_cost`;
CREATE TABLE `jform_employee_meals_cost` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'id',
  `fk_id` varchar(36) DEFAULT NULL COMMENT '外键',
  `meals_date` date DEFAULT NULL,
  `meals_cost` decimal(7,2) DEFAULT NULL COMMENT '餐费',
  `meals_addr` varchar(100) DEFAULT NULL COMMENT '吃饭地点',
  `meals_number` int(2) DEFAULT NULL COMMENT '同行人数',
  `comments` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_employee_other_cost
-- ----------------------------
DROP TABLE IF EXISTS `jform_employee_other_cost`;
CREATE TABLE `jform_employee_other_cost` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'id',
  `fk_id` varchar(36) DEFAULT NULL COMMENT '外键',
  `item` varchar(20) DEFAULT NULL COMMENT '事项',
  `cost` decimal(7,2) DEFAULT NULL COMMENT '费用',
  `begin_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `comments` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_employee_resignation
-- ----------------------------
DROP TABLE IF EXISTS `jform_employee_resignation`;
CREATE TABLE `jform_employee_resignation` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `name` varchar(32) DEFAULT NULL COMMENT '姓名',
  `code` varchar(32) DEFAULT NULL COMMENT '员工编号',
  `job` varchar(32) DEFAULT NULL COMMENT '职务',
  `join_time` datetime DEFAULT NULL COMMENT '入职时间',
  `out_type` varchar(32) DEFAULT NULL COMMENT '离职方式',
  `apply_out_time` datetime DEFAULT NULL COMMENT '申请离职日期',
  `out_time` datetime DEFAULT NULL COMMENT '正式离职日期',
  `id_card` varchar(32) DEFAULT NULL COMMENT '身份证编号',
  `out_content` varchar(200) DEFAULT NULL COMMENT '离职须知',
  `out_reason` varchar(100) DEFAULT NULL COMMENT '离职原因',
  `interview_record` varchar(100) DEFAULT NULL COMMENT '面谈记录',
  `office_change` varchar(100) DEFAULT NULL COMMENT '办公物品移交',
  `hr_check` varchar(32) DEFAULT NULL COMMENT '人力资源部审核',
  `should_send_salary` double(32,0) DEFAULT NULL COMMENT '应发薪资',
  `should_deduct_pay` double(32,0) DEFAULT NULL COMMENT '应扣薪资',
  `pay` double(32,0) DEFAULT NULL COMMENT '实发薪资',
  `get_time` datetime DEFAULT NULL COMMENT '领取日期',
  `boss_check` varchar(32) DEFAULT NULL COMMENT '总经理审批',
  `description` varchar(32) DEFAULT NULL COMMENT '说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_graphreport_head
-- ----------------------------
DROP TABLE IF EXISTS `jform_graphreport_head`;
CREATE TABLE `jform_graphreport_head` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `cgr_sql` varchar(1000) NOT NULL COMMENT '查询数据SQL',
  `code` varchar(36) NOT NULL COMMENT '编码',
  `content` varchar(1000) NOT NULL COMMENT '描述',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `ytext` varchar(100) NOT NULL COMMENT 'y轴文字',
  `categories` varchar(1000) NOT NULL COMMENT 'x轴数据',
  `is_show_list` varchar(5) DEFAULT NULL COMMENT '是否显示明细',
  `x_page_js` varchar(1000) DEFAULT NULL COMMENT '扩展JS',
  `create_date` datetime DEFAULT NULL,
  `create_by` varchar(50) DEFAULT NULL,
  `create_name` varchar(100) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_by` varchar(50) DEFAULT NULL,
  `update_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_code` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_graphreport_item
-- ----------------------------
DROP TABLE IF EXISTS `jform_graphreport_item`;
CREATE TABLE `jform_graphreport_item` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `search_flag` varchar(2) DEFAULT NULL COMMENT '是否查询',
  `search_mode` varchar(10) DEFAULT NULL COMMENT '查询模式',
  `cgreport_head_id` varchar(36) DEFAULT NULL COMMENT 'cgreportHeadId',
  `dict_code` varchar(500) DEFAULT NULL COMMENT '字典Code',
  `field_href` varchar(120) DEFAULT NULL COMMENT '字段href',
  `field_name` varchar(36) DEFAULT NULL COMMENT '字段名',
  `field_txt` varchar(1000) DEFAULT NULL COMMENT '字段文本',
  `field_type` varchar(10) DEFAULT NULL COMMENT '字段类型',
  `is_show` varchar(5) DEFAULT NULL COMMENT '是否显示',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  `replace_va` varchar(36) DEFAULT NULL COMMENT '取值表达式',
  `is_graph` varchar(5) DEFAULT NULL COMMENT '显示图表',
  `graph_type` varchar(50) DEFAULT NULL COMMENT '图表类型',
  `graph_name` varchar(100) DEFAULT NULL COMMENT '图表名称',
  `tab_name` varchar(50) DEFAULT NULL COMMENT '标签名称',
  PRIMARY KEY (`id`),
  KEY `index_headid` (`cgreport_head_id`) USING BTREE,
  KEY `index_isshow` (`is_show`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='jform_graphreport_item';

-- ----------------------------
-- Table structure for jform_leave
-- ----------------------------
DROP TABLE IF EXISTS `jform_leave`;
CREATE TABLE `jform_leave` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `title` varchar(50) NOT NULL COMMENT '请假标题',
  `people` varchar(20) NOT NULL COMMENT '请假人',
  `sex` varchar(10) NOT NULL COMMENT '性别',
  `begindate` datetime NOT NULL COMMENT '请假开始时间',
  `enddate` datetime NOT NULL COMMENT '请假结束时间',
  `day_num` int(11) DEFAULT NULL COMMENT '请假天数',
  `hol_dept` varchar(32) NOT NULL COMMENT '所属部门',
  `hol_reson` varchar(255) NOT NULL COMMENT '请假原因',
  `dep_leader` varchar(20) DEFAULT NULL COMMENT '部门审批人',
  `content` varchar(255) DEFAULT NULL COMMENT '部门审批意见',
  `file_str` varchar(300) DEFAULT NULL COMMENT '附件',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_order_customer
-- ----------------------------
DROP TABLE IF EXISTS `jform_order_customer`;
CREATE TABLE `jform_order_customer` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `name` varchar(100) DEFAULT NULL COMMENT '客户名',
  `money` double(10,2) DEFAULT NULL COMMENT '单价',
  `sex` varchar(4) DEFAULT NULL COMMENT '性别',
  `telphone` varchar(32) DEFAULT NULL COMMENT '电话1',
  `fk_id` varchar(36) NOT NULL COMMENT '外键',
  `sf_pic` varchar(500) DEFAULT NULL COMMENT '身份证扫描件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_order_main
-- ----------------------------
DROP TABLE IF EXISTS `jform_order_main`;
CREATE TABLE `jform_order_main` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `order_code` varchar(50) DEFAULT NULL COMMENT '订单号',
  `order_date` datetime DEFAULT NULL COMMENT '订单日期',
  `order_money` double(10,3) DEFAULT NULL COMMENT '订单金额',
  `content` varchar(500) DEFAULT NULL COMMENT '备注',
  `ctype` varchar(500) DEFAULT NULL COMMENT '订单扫描件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_order_ticket
-- ----------------------------
DROP TABLE IF EXISTS `jform_order_ticket`;
CREATE TABLE `jform_order_ticket` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `ticket_code` varchar(100) NOT NULL COMMENT '航班号',
  `tickect_date` datetime NOT NULL COMMENT '航班时间',
  `fck_id` varchar(36) NOT NULL COMMENT '外键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_price1
-- ----------------------------
DROP TABLE IF EXISTS `jform_price1`;
CREATE TABLE `jform_price1` (
  `id` varchar(36) NOT NULL,
  `a` double NOT NULL COMMENT '机构合计',
  `b1` double NOT NULL COMMENT '行政小计',
  `b11` varchar(100) NOT NULL COMMENT '行政省',
  `b12` varchar(100) NOT NULL COMMENT '行政市',
  `b13` varchar(100) NOT NULL COMMENT '行政县',
  `b2` double NOT NULL COMMENT '事业合计',
  `b3` double NOT NULL COMMENT '参公小计',
  `b31` varchar(100) NOT NULL COMMENT '参公省',
  `b32` varchar(100) NOT NULL COMMENT '参公市',
  `b33` varchar(100) NOT NULL COMMENT '参公县',
  `c1` double NOT NULL COMMENT '全额拨款',
  `c2` double NOT NULL COMMENT '差额拨款',
  `c3` double NOT NULL COMMENT '自收自支',
  `d` int(11) NOT NULL COMMENT '经费合计',
  `d1` longtext NOT NULL COMMENT '机构资质',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_resume_degree_info
-- ----------------------------
DROP TABLE IF EXISTS `jform_resume_degree_info`;
CREATE TABLE `jform_resume_degree_info` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `resume_id` varchar(36) DEFAULT NULL COMMENT '简历主键',
  `begin_date` datetime DEFAULT NULL COMMENT '开始时间',
  `end_date` datetime DEFAULT NULL COMMENT '结束时间',
  `school_name` varchar(100) DEFAULT NULL COMMENT '学校名称',
  `major` varchar(100) DEFAULT NULL COMMENT '专业',
  `degree` varchar(30) DEFAULT NULL COMMENT '学历',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_resume_exp_info
-- ----------------------------
DROP TABLE IF EXISTS `jform_resume_exp_info`;
CREATE TABLE `jform_resume_exp_info` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `resume_id` varchar(36) DEFAULT NULL COMMENT '简历信息表ID',
  `begin_date` datetime DEFAULT NULL COMMENT '开始日期',
  `end_date` datetime DEFAULT NULL COMMENT '结束日期',
  `company_name` varchar(200) NOT NULL COMMENT '公司名称',
  `depart_name` varchar(100) DEFAULT NULL COMMENT '部门名称',
  `post` varchar(50) DEFAULT NULL COMMENT '职位',
  `experience` varchar(2000) DEFAULT NULL COMMENT '工作描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_resume_info
-- ----------------------------
DROP TABLE IF EXISTS `jform_resume_info`;
CREATE TABLE `jform_resume_info` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `name` varchar(50) NOT NULL COMMENT '姓名',
  `sex` varchar(10) NOT NULL COMMENT '性别',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `telnum` varchar(30) DEFAULT NULL COMMENT '电话号码',
  `email` varchar(50) DEFAULT NULL COMMENT '电子邮箱',
  `degree` varchar(50) DEFAULT NULL COMMENT '最高学历',
  `workyear` varchar(20) DEFAULT NULL COMMENT '工作年限',
  `cardid` varchar(50) DEFAULT NULL COMMENT '身份证号',
  `habitation` varchar(100) DEFAULT NULL COMMENT '现居地',
  `residence` varchar(100) DEFAULT NULL COMMENT '户口所在地',
  `salary` varchar(20) DEFAULT NULL COMMENT '期望薪资',
  `work_place` varchar(50) DEFAULT NULL COMMENT '期望工作地点',
  `work_type` varchar(50) DEFAULT NULL COMMENT '工作类型',
  `arrival_time` datetime DEFAULT NULL COMMENT '到岗时间',
  `introduction` varchar(500) DEFAULT NULL COMMENT '自我评价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jform_tree
-- ----------------------------
DROP TABLE IF EXISTS `jform_tree`;
CREATE TABLE `jform_tree` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `name` varchar(32) DEFAULT NULL COMMENT '物料编码',
  `father_id` varchar(32) DEFAULT NULL COMMENT '父ID',
  `age` varchar(32) DEFAULT NULL COMMENT 'age',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jfrom_order
-- ----------------------------
DROP TABLE IF EXISTS `jfrom_order`;
CREATE TABLE `jfrom_order` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `receiver_name` varchar(56) DEFAULT NULL COMMENT '收货人',
  `receiver_mobile` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `receiver_state` varchar(32) DEFAULT NULL COMMENT '收货省',
  `receiver_city` varchar(32) DEFAULT NULL COMMENT '收货市',
  `receiver_district` varchar(32) DEFAULT NULL COMMENT '收货区',
  `receiver_address` varchar(128) DEFAULT NULL COMMENT '收货地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jfrom_order_line
-- ----------------------------
DROP TABLE IF EXISTS `jfrom_order_line`;
CREATE TABLE `jfrom_order_line` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `orderid` varchar(36) DEFAULT NULL COMMENT '订单ID',
  `item_name` varchar(128) DEFAULT NULL COMMENT '商品名称',
  `qty` int(32) DEFAULT NULL COMMENT '商品数量',
  `price` decimal(32,0) DEFAULT NULL COMMENT '商品价格',
  `amount` decimal(32,0) DEFAULT NULL COMMENT '金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jp_chat_message_his
-- ----------------------------
DROP TABLE IF EXISTS `jp_chat_message_his`;
CREATE TABLE `jp_chat_message_his` (
  `id` varchar(50) NOT NULL,
  `msg_from` varchar(255) NOT NULL,
  `msg_to` varchar(255) DEFAULT NULL,
  `msg_data` varchar(5000) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `readed` smallint(2) DEFAULT NULL COMMENT '消息是否已读 0 未读  1 已读',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jp_demo_activity
-- ----------------------------
DROP TABLE IF EXISTS `jp_demo_activity`;
CREATE TABLE `jp_demo_activity` (
  `id` varchar(32) NOT NULL COMMENT 'ID',
  `name` varchar(100) NOT NULL COMMENT '活动名称',
  `begin_time` datetime DEFAULT NULL COMMENT '活动开始时间',
  `end_time` datetime DEFAULT NULL COMMENT ' 活动结束时间',
  `hdurl` varchar(300) DEFAULT NULL COMMENT '入口地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='红包活动表';

-- ----------------------------
-- Table structure for jp_demo_auth
-- ----------------------------
DROP TABLE IF EXISTS `jp_demo_auth`;
CREATE TABLE `jp_demo_auth` (
  `id` bigint(20) unsigned NOT NULL COMMENT '序号',
  `auth_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '权限编码',
  `auth_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '权限名称',
  `auth_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '权限类型 0:菜单;1:功能',
  `auth_contr` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '权限控制',
  `parent_auth_id` char(12) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '上一级权限编码',
  `leaf_ind` char(2) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '是否叶子节点',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_authid` (`auth_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='运营系统权限表';

-- ----------------------------
-- Table structure for jp_demo_order_custom
-- ----------------------------
DROP TABLE IF EXISTS `jp_demo_order_custom`;
CREATE TABLE `jp_demo_order_custom` (
  `ID` varchar(32) NOT NULL,
  `CREATE_DT` datetime DEFAULT NULL,
  `CRTUSER` varchar(12) DEFAULT NULL,
  `CRTUSER_NAME` varchar(10) DEFAULT NULL,
  `DEL_DT` datetime DEFAULT NULL,
  `DELFLAG` int(11) DEFAULT '0',
  `GO_ORDER_CODE` varchar(12) NOT NULL COMMENT '团购订单号',
  `GOC_BUSS_CONTENT` varchar(33) DEFAULT NULL COMMENT '业务',
  `GOC_CONTENT` varchar(66) DEFAULT NULL COMMENT '备注',
  `GOC_CUS_NAME` varchar(16) DEFAULT NULL COMMENT '姓名',
  `GOC_IDCARD` varchar(18) DEFAULT NULL COMMENT '身份证号',
  `GOC_PASSPORT_CODE` varchar(10) DEFAULT NULL COMMENT '护照号',
  `GOC_SEX` varchar(255) DEFAULT NULL COMMENT '性别',
  `MODIFIER` varchar(12) DEFAULT NULL,
  `MODIFIER_NAME` varchar(10) DEFAULT NULL,
  `MODIFY_DT` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jp_demo_order_main
-- ----------------------------
DROP TABLE IF EXISTS `jp_demo_order_main`;
CREATE TABLE `jp_demo_order_main` (
  `ID` varchar(32) NOT NULL,
  `CREATE_DT` datetime DEFAULT NULL,
  `CRTUSER` varchar(12) DEFAULT NULL,
  `CRTUSER_NAME` varchar(10) DEFAULT NULL,
  `DEL_DT` datetime DEFAULT NULL,
  `DELFLAG` int(11) DEFAULT '0',
  `GO_ALL_PRICE` decimal(10,2) DEFAULT NULL COMMENT '总价(不含返款)',
  `GO_CONTACT_NAME` varchar(16) DEFAULT NULL COMMENT '联系人',
  `GO_CONTENT` varchar(66) DEFAULT NULL COMMENT '备注',
  `GO_ORDER_CODE` varchar(12) NOT NULL COMMENT '订单号',
  `GO_ORDER_COUNT` int(11) DEFAULT NULL COMMENT '订单人数',
  `GO_RETURN_PRICE` decimal(10,2) DEFAULT NULL COMMENT '返款',
  `GO_TELPHONE` varchar(11) DEFAULT NULL COMMENT '手机',
  `GODER_TYPE` varchar(255) DEFAULT NULL COMMENT '订单类型',
  `MODIFIER` varchar(12) DEFAULT NULL,
  `MODIFIER_NAME` varchar(10) DEFAULT NULL,
  `MODIFY_DT` datetime DEFAULT NULL,
  `USERTYPE` varchar(255) DEFAULT NULL COMMENT '顾客类型 : 1直客 2同行',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jp_demo_order_product
-- ----------------------------
DROP TABLE IF EXISTS `jp_demo_order_product`;
CREATE TABLE `jp_demo_order_product` (
  `ID` varchar(32) NOT NULL,
  `CREATE_DT` datetime DEFAULT NULL,
  `CRTUSER` varchar(12) DEFAULT NULL,
  `CRTUSER_NAME` varchar(10) DEFAULT NULL,
  `DEL_DT` datetime DEFAULT NULL,
  `DELFLAG` int(11) DEFAULT '0',
  `GO_ORDER_CODE` varchar(12) NOT NULL COMMENT '团购订单号',
  `GOP_CONTENT` varchar(66) DEFAULT NULL COMMENT '备注',
  `GOP_COUNT` int(11) DEFAULT NULL COMMENT '个数',
  `GOP_ONE_PRICE` decimal(10,2) DEFAULT NULL COMMENT '单价',
  `GOP_PRODUCT_NAME` varchar(33) DEFAULT NULL COMMENT '产品名称',
  `GOP_PRODUCT_TYPE` varchar(1) NOT NULL COMMENT '服务项目类型',
  `GOP_SUM_PRICE` decimal(10,2) DEFAULT NULL COMMENT '小计',
  `MODIFIER` varchar(12) DEFAULT NULL,
  `MODIFIER_NAME` varchar(10) DEFAULT NULL,
  `MODIFY_DT` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jp_inner_mail
-- ----------------------------
DROP TABLE IF EXISTS `jp_inner_mail`;
CREATE TABLE `jp_inner_mail` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `title` varchar(100) DEFAULT NULL COMMENT '主题',
  `attachment` varchar(1000) DEFAULT NULL COMMENT '附件',
  `content` longtext COMMENT '内容',
  `status` varchar(50) DEFAULT NULL COMMENT '状态',
  `receiver_names` varchar(300) DEFAULT NULL COMMENT '接收者姓名列表',
  `receiver_ids` varchar(300) DEFAULT NULL COMMENT '收件人标识列表',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jp_inner_mail_attach
-- ----------------------------
DROP TABLE IF EXISTS `jp_inner_mail_attach`;
CREATE TABLE `jp_inner_mail_attach` (
  `id` varchar(32) NOT NULL,
  `mailid` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jp_inner_mail_receiver
-- ----------------------------
DROP TABLE IF EXISTS `jp_inner_mail_receiver`;
CREATE TABLE `jp_inner_mail_receiver` (
  `id` varchar(36) NOT NULL,
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `mail_id` varchar(36) DEFAULT NULL COMMENT '邮件标识',
  `user_id` varchar(36) DEFAULT NULL COMMENT '收件人标识',
  `status` varchar(50) DEFAULT NULL COMMENT '收件状态',
  `isdelete` char(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_userid` (`user_id`) USING BTREE,
  KEY `index_mailid` (`mail_id`) USING BTREE,
  KEY `index_status` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jw_system_account_recharge
-- ----------------------------
DROP TABLE IF EXISTS `jw_system_account_recharge`;
CREATE TABLE `jw_system_account_recharge` (
  `id` varchar(32) NOT NULL COMMENT 'ID',
  `account_id` varchar(255) DEFAULT NULL COMMENT '账户表ID',
  `type` varchar(255) DEFAULT NULL COMMENT '支付类型',
  `amount` decimal(11,2) DEFAULT NULL COMMENT '支付金额',
  `status` varchar(255) DEFAULT NULL COMMENT '状态',
  `jwid` varchar(255) DEFAULT NULL COMMENT 'JWID',
  `openid` varchar(255) DEFAULT NULL COMMENT 'OPENID',
  `tran_no` varchar(255) DEFAULT NULL COMMENT '交易订单号',
  `return_code` varchar(255) DEFAULT NULL COMMENT '返回编码',
  `return_msg` text COMMENT '返回信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统账户充值记录表';

-- ----------------------------
-- Table structure for npa_corporate_org
-- ----------------------------
DROP TABLE IF EXISTS `npa_corporate_org`;
CREATE TABLE `npa_corporate_org` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `name_shorter` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '简称',
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '地址',
  `code` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '单位代码',
  `phone` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电话',
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
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8 COMMENT='借款合同担保人明细';

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
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=utf8 COMMENT=' 自然人，包含借款人及担保人，借款人用b表示，担保人用g表示。\r\n记录向银行借款，并签订借据的债务人的基本信息';

-- ----------------------------
-- Table structure for npa_natural_person_imp
-- ----------------------------
DROP TABLE IF EXISTS `npa_natural_person_imp`;
CREATE TABLE `npa_natural_person_imp` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(10) NOT NULL COMMENT '姓名',
  `id_number` char(18) NOT NULL COMMENT '身份证号',
  `is_borrower` char(1) NOT NULL DEFAULT '0' COMMENT '是否借款人',
  `is_guarantee` char(1) NOT NULL DEFAULT '0' COMMENT '是否担保人',
  `num_code` char(20) NOT NULL COMMENT '档案编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8;

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

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(120) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for super_query_field
-- ----------------------------
DROP TABLE IF EXISTS `super_query_field`;
CREATE TABLE `super_query_field` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `seq` varchar(32) DEFAULT NULL COMMENT '序号',
  `table_name` varchar(32) DEFAULT NULL COMMENT '表名',
  `name` varchar(32) DEFAULT NULL COMMENT '字段名',
  `txt` varchar(32) DEFAULT NULL COMMENT '字段文本',
  `ctype` varchar(32) DEFAULT NULL COMMENT '字段类型',
  `stype` varchar(32) DEFAULT NULL COMMENT '控件类型',
  `dict_table` varchar(32) DEFAULT NULL COMMENT '字典Table',
  `dict_code` varchar(32) DEFAULT NULL COMMENT '字典Code',
  `dict_text` varchar(32) DEFAULT NULL COMMENT '字典Text',
  `main_id` varchar(32) DEFAULT NULL COMMENT '外键'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字段配置';

-- ----------------------------
-- Table structure for super_query_history
-- ----------------------------
DROP TABLE IF EXISTS `super_query_history`;
CREATE TABLE `super_query_history` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `user_id` varchar(50) DEFAULT NULL COMMENT '用户id',
  `record` longtext COMMENT '记录',
  `query_type` varchar(255) DEFAULT NULL COMMENT '查询类型',
  `query_code` varchar(255) DEFAULT NULL COMMENT '查询编码',
  `history_name` varchar(255) DEFAULT NULL COMMENT '名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='高级查询历史记录';

-- ----------------------------
-- Table structure for super_query_main
-- ----------------------------
DROP TABLE IF EXISTS `super_query_main`;
CREATE TABLE `super_query_main` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `query_name` varchar(50) DEFAULT NULL COMMENT '查询规则名称',
  `query_code` varchar(50) DEFAULT NULL COMMENT '查询规则编码',
  `query_type` varchar(50) DEFAULT NULL COMMENT '查询类型',
  `content` varchar(32) DEFAULT NULL COMMENT '说明'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='高级查询';

-- ----------------------------
-- Table structure for super_query_table
-- ----------------------------
DROP TABLE IF EXISTS `super_query_table`;
CREATE TABLE `super_query_table` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `seq` varchar(32) DEFAULT NULL COMMENT '序号',
  `table_name` varchar(32) DEFAULT NULL COMMENT '表名',
  `instruction` varchar(255) DEFAULT NULL COMMENT '说明',
  `is_main` varchar(32) DEFAULT NULL COMMENT '是否是主表',
  `fk_field` varchar(32) DEFAULT NULL COMMENT '外键字段',
  `main_id` varchar(32) DEFAULT NULL COMMENT '外键id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='表组合';

-- ----------------------------
-- Table structure for test_person
-- ----------------------------
DROP TABLE IF EXISTS `test_person`;
CREATE TABLE `test_person` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `name` varchar(32) NOT NULL COMMENT '名字',
  `sex` varchar(32) DEFAULT NULL COMMENT '性别',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `conets` varchar(32) DEFAULT NULL COMMENT '个人简介',
  `salary` double(32,0) DEFAULT NULL COMMENT '工资',
  `fiel_jls` varchar(1000) DEFAULT NULL COMMENT '简历附件',
  `tou_pic` varchar(1000) DEFAULT NULL COMMENT '个人头像'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for test_rules
-- ----------------------------
DROP TABLE IF EXISTS `test_rules`;
CREATE TABLE `test_rules` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `name` varchar(32) DEFAULT NULL COMMENT '销售人员',
  `money` double(32,0) DEFAULT NULL COMMENT '订单金额',
  `product` varchar(200) DEFAULT NULL COMMENT '产品名字',
  `sale_date` datetime DEFAULT NULL COMMENT '下单时间',
  `eeee` varchar(32) DEFAULT NULL COMMENT 'cc',
  `dda` varchar(32) DEFAULT NULL COMMENT 'dd'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tmp_tables
-- ----------------------------
DROP TABLE IF EXISTS `tmp_tables`;
CREATE TABLE `tmp_tables` (
  `id` int(100) NOT NULL,
  `wl_table_name` varchar(100) DEFAULT NULL,
  `xt_table_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_attachment
-- ----------------------------
DROP TABLE IF EXISTS `t_s_attachment`;
CREATE TABLE `t_s_attachment` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `attachmentcontent` longblob COMMENT '附件内容',
  `attachmenttitle` varchar(100) DEFAULT NULL COMMENT '附件名称',
  `businesskey` varchar(32) DEFAULT NULL COMMENT '业务类主键',
  `createdate` datetime DEFAULT NULL COMMENT '创建时间',
  `extend` varchar(32) DEFAULT NULL COMMENT '扩展名',
  `note` longtext COMMENT 'note',
  `realpath` varchar(100) DEFAULT NULL COMMENT '附件路径',
  `subclassname` longtext COMMENT '子类名称全路径',
  `swfpath` longtext COMMENT 'swf格式路径',
  `BUSENTITYNAME` varchar(100) DEFAULT NULL COMMENT 'BUSENTITYNAME',
  `INFOTYPEID` varchar(32) DEFAULT NULL COMMENT 'INFOTYPEID',
  `USERID` varchar(32) DEFAULT NULL COMMENT '用户ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_base_user
-- ----------------------------
DROP TABLE IF EXISTS `t_s_base_user`;
CREATE TABLE `t_s_base_user` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `activitiSync` smallint(6) DEFAULT NULL COMMENT '同步流程',
  `browser` varchar(20) DEFAULT NULL COMMENT '浏览器',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `realname` varchar(50) DEFAULT NULL COMMENT '真实名字',
  `signature` blob COMMENT '签名',
  `status` smallint(6) DEFAULT NULL COMMENT '有效状态',
  `userkey` varchar(200) DEFAULT NULL COMMENT '用户KEY',
  `username` varchar(50) NOT NULL COMMENT '用户账号',
  `departid` varchar(32) DEFAULT NULL COMMENT '部门ID',
  `user_name_en` varchar(500) DEFAULT NULL COMMENT '英文名',
  `delete_flag` smallint(6) DEFAULT NULL COMMENT '删除状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_black_list
-- ----------------------------
DROP TABLE IF EXISTS `t_s_black_list`;
CREATE TABLE `t_s_black_list` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `ip` varchar(32) DEFAULT NULL COMMENT 'ip地址'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_category
-- ----------------------------
DROP TABLE IF EXISTS `t_s_category`;
CREATE TABLE `t_s_category` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `icon_id` varchar(32) DEFAULT NULL COMMENT '图标ID',
  `code` varchar(32) NOT NULL COMMENT '类型编码',
  `name` varchar(32) NOT NULL COMMENT '类型名称',
  `create_name` varchar(50) NOT NULL COMMENT '创建人名称',
  `create_by` varchar(50) NOT NULL COMMENT '创建人登录名称',
  `create_date` datetime NOT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `parent_id` varchar(32) DEFAULT NULL COMMENT '上级ID',
  `sys_org_code` varchar(10) NOT NULL COMMENT '机构',
  `sys_company_code` varchar(10) NOT NULL COMMENT '公司',
  `PARENT_CODE` varchar(32) DEFAULT NULL COMMENT '父邮编'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分类管理';

-- ----------------------------
-- Table structure for t_s_company_position
-- ----------------------------
DROP TABLE IF EXISTS `t_s_company_position`;
CREATE TABLE `t_s_company_position` (
  `id` varchar(32) NOT NULL COMMENT '序号',
  `company_id` varchar(36) DEFAULT NULL COMMENT '公司ID',
  `position_code` varchar(64) DEFAULT NULL COMMENT '岗位代码',
  `position_name` varchar(100) DEFAULT NULL COMMENT '岗位名称',
  `position_name_en` varchar(255) DEFAULT NULL COMMENT '岗位英文名',
  `position_name_abbr` varchar(255) DEFAULT NULL COMMENT '岗位缩写',
  `position_level` varchar(50) DEFAULT NULL COMMENT '岗位级别',
  `memo` varchar(500) DEFAULT NULL COMMENT '备注',
  `del_flag` int(11) DEFAULT NULL COMMENT '缩写',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人账号',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人账号',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '数据所属公司',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '数据所属部门'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统岗位表';

-- ----------------------------
-- Table structure for t_s_data_log
-- ----------------------------
DROP TABLE IF EXISTS `t_s_data_log`;
CREATE TABLE `t_s_data_log` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `table_name` varchar(32) DEFAULT NULL COMMENT '表名',
  `data_id` varchar(32) DEFAULT NULL COMMENT '数据ID',
  `data_content` text COMMENT '数据内容',
  `version_number` int(11) DEFAULT NULL COMMENT '版本号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_data_rule
-- ----------------------------
DROP TABLE IF EXISTS `t_s_data_rule`;
CREATE TABLE `t_s_data_rule` (
  `id` varchar(96) DEFAULT NULL COMMENT 'ID',
  `rule_name` varchar(96) DEFAULT NULL COMMENT '数据权限规则名称',
  `rule_column` varchar(300) DEFAULT NULL COMMENT '字段',
  `rule_conditions` varchar(300) DEFAULT NULL COMMENT '条件',
  `rule_value` varchar(300) DEFAULT NULL COMMENT '规则值',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(96) DEFAULT NULL,
  `create_name` varchar(96) DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(96) DEFAULT NULL COMMENT '修改人',
  `update_name` varchar(96) DEFAULT NULL COMMENT '修改人名字',
  `functionId` varchar(96) DEFAULT NULL COMMENT '菜单ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_data_source
-- ----------------------------
DROP TABLE IF EXISTS `t_s_data_source`;
CREATE TABLE `t_s_data_source` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `db_key` varchar(50) NOT NULL COMMENT '多数据源KEY',
  `description` varchar(50) NOT NULL COMMENT '描述',
  `driver_class` varchar(50) NOT NULL COMMENT '驱动class',
  `url` varchar(200) NOT NULL COMMENT 'db链接',
  `db_user` varchar(50) NOT NULL COMMENT '用户名',
  `db_password` varchar(50) DEFAULT NULL COMMENT '密码',
  `db_type` varchar(50) DEFAULT NULL COMMENT '数据库类型',
  `db_name` varchar(50) DEFAULT NULL COMMENT '数据源名字'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_depart
-- ----------------------------
DROP TABLE IF EXISTS `t_s_depart`;
CREATE TABLE `t_s_depart` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `departname` varchar(100) NOT NULL COMMENT '部门名称',
  `description` longtext COMMENT '描述',
  `parentdepartid` varchar(32) DEFAULT NULL COMMENT '父部门ID',
  `org_code` varchar(64) DEFAULT NULL COMMENT '机构编码',
  `org_type` varchar(1) DEFAULT NULL COMMENT '机构类型',
  `mobile` varchar(32) DEFAULT NULL COMMENT '手机号',
  `fax` varchar(32) DEFAULT NULL COMMENT '传真',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `depart_order` varchar(5) DEFAULT '0' COMMENT '排序',
  `departname_en` varchar(500) DEFAULT NULL COMMENT '英文名',
  `departname_abbr` varchar(500) DEFAULT NULL COMMENT '缩写',
  `memo` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人账号',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人账号',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '数据所属公司',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '数据所属部门'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_depart_authg_function_rel
-- ----------------------------
DROP TABLE IF EXISTS `t_s_depart_authg_function_rel`;
CREATE TABLE `t_s_depart_authg_function_rel` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `group_id` varchar(36) DEFAULT NULL COMMENT '权限组ID',
  `auth_id` varchar(36) DEFAULT NULL COMMENT '权限ID',
  `operation` varchar(2000) DEFAULT NULL COMMENT '页面操作权限',
  `datarule` varchar(1000) DEFAULT NULL COMMENT '数据权限',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人id',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_name` varchar(50) DEFAULT NULL COMMENT '修改人',
  `update_by` varchar(50) DEFAULT NULL COMMENT '修改人id',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_depart_authg_manager
-- ----------------------------
DROP TABLE IF EXISTS `t_s_depart_authg_manager`;
CREATE TABLE `t_s_depart_authg_manager` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `group_id` varchar(36) DEFAULT NULL COMMENT '权限组ID',
  `user_id` varchar(36) DEFAULT NULL COMMENT '用户ID',
  `type` int(3) DEFAULT NULL COMMENT '权限组类型',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人id',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_name` varchar(50) DEFAULT NULL COMMENT '修改人',
  `update_by` varchar(50) DEFAULT NULL COMMENT '修改人id',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_depart_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `t_s_depart_auth_group`;
CREATE TABLE `t_s_depart_auth_group` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `group_name` varchar(100) DEFAULT NULL COMMENT '权限组名称',
  `dept_id` varchar(36) DEFAULT NULL COMMENT '部门ID',
  `dept_code` varchar(50) DEFAULT NULL COMMENT '部门编码',
  `dept_name` varchar(100) DEFAULT NULL COMMENT '部门名称',
  `depart_type` varchar(2) DEFAULT NULL COMMENT '类型1/公司2/部门4/供应商',
  `level` int(10) DEFAULT NULL COMMENT '级别',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人id',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_name` varchar(50) DEFAULT NULL COMMENT '修改人',
  `update_by` varchar(50) DEFAULT NULL COMMENT '修改人id',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_dict_table_config
-- ----------------------------
DROP TABLE IF EXISTS `t_s_dict_table_config`;
CREATE TABLE `t_s_dict_table_config` (
  `id` varchar(36) NOT NULL,
  `table_name` varchar(100) DEFAULT NULL COMMENT '表名',
  `value_col` varchar(50) DEFAULT NULL COMMENT '值字段名',
  `text_col` varchar(50) DEFAULT NULL COMMENT '文本字段名',
  `dict_condition` varchar(255) DEFAULT NULL COMMENT '字典表查询条件',
  `isvalid` varchar(32) DEFAULT NULL COMMENT '是否启用',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字典表授权配置';

-- ----------------------------
-- Table structure for t_s_document
-- ----------------------------
DROP TABLE IF EXISTS `t_s_document`;
CREATE TABLE `t_s_document` (
  `id` varchar(32) NOT NULL,
  `typeid` varchar(32) DEFAULT NULL,
  `documentstate` smallint(6) DEFAULT NULL,
  `documenttitle` varchar(100) DEFAULT NULL,
  `pictureindex` blob,
  `showhome` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_fill_rule
-- ----------------------------
DROP TABLE IF EXISTS `t_s_fill_rule`;
CREATE TABLE `t_s_fill_rule` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `rule_code` varchar(255) DEFAULT NULL COMMENT '规则code',
  `rule_name` varchar(255) DEFAULT NULL COMMENT '规则名称',
  `rule_class` longtext COMMENT '规则实现类',
  `rule_param` longtext COMMENT '规则参数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_function
-- ----------------------------
DROP TABLE IF EXISTS `t_s_function`;
CREATE TABLE `t_s_function` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `functioniframe` smallint(6) DEFAULT NULL COMMENT '菜单地址打开方式',
  `functionlevel` smallint(6) DEFAULT NULL COMMENT '菜单等级',
  `functionname` varchar(50) NOT NULL COMMENT '菜单名字',
  `functionorder` varchar(255) DEFAULT NULL COMMENT '排序',
  `functionurl` varchar(500) DEFAULT NULL COMMENT 'URL',
  `parentfunctionid` varchar(32) DEFAULT NULL COMMENT '父菜单ID',
  `iconid` varchar(32) DEFAULT NULL COMMENT '图标ID',
  `desk_iconid` varchar(32) DEFAULT NULL COMMENT '桌面图标ID',
  `functiontype` smallint(6) DEFAULT NULL COMMENT '菜单类型',
  `function_icon_style` varchar(255) DEFAULT NULL COMMENT 'ace图标样式',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人id',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_icon
-- ----------------------------
DROP TABLE IF EXISTS `t_s_icon`;
CREATE TABLE `t_s_icon` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `extend` varchar(255) DEFAULT NULL COMMENT '图片后缀',
  `iconclas` varchar(200) DEFAULT NULL COMMENT '类型',
  `content` blob COMMENT '图片流内容',
  `name` varchar(100) NOT NULL COMMENT '名字',
  `path` longtext COMMENT '路径',
  `type` smallint(6) DEFAULT NULL COMMENT '类型 1系统图标/2菜单图标/3桌面图标'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_interface
-- ----------------------------
DROP TABLE IF EXISTS `t_s_interface`;
CREATE TABLE `t_s_interface` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `interface_name` varchar(50) NOT NULL COMMENT '权限名称',
  `interface_order` varchar(50) DEFAULT NULL COMMENT '排序',
  `interface_level` varchar(10) DEFAULT NULL COMMENT '接口等級',
  `interface_url` longtext COMMENT 'URL',
  `interface_code` varchar(64) NOT NULL COMMENT '接口编码',
  `interface_method` varchar(64) DEFAULT NULL COMMENT '请求方式',
  `parent_interface_id` varchar(32) DEFAULT NULL COMMENT '父菜单ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_interface_datarule
-- ----------------------------
DROP TABLE IF EXISTS `t_s_interface_datarule`;
CREATE TABLE `t_s_interface_datarule` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `rule_name` varchar(96) DEFAULT NULL COMMENT '接口权限规则名称',
  `rule_column` longtext COMMENT '字段',
  `rule_conditions` longtext COMMENT '条件',
  `rule_value` longtext COMMENT '规则值',
  `interface_id` varchar(32) DEFAULT NULL COMMENT '菜单id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_interrole
-- ----------------------------
DROP TABLE IF EXISTS `t_s_interrole`;
CREATE TABLE `t_s_interrole` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `role_code` varchar(10) DEFAULT NULL COMMENT '接口角色编码',
  `role_name` varchar(100) DEFAULT NULL COMMENT '接口角色名称',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改时间',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接口权限角色表';

-- ----------------------------
-- Table structure for t_s_interrole_interface
-- ----------------------------
DROP TABLE IF EXISTS `t_s_interrole_interface`;
CREATE TABLE `t_s_interrole_interface` (
  `id` varchar(32) NOT NULL COMMENT 'ID',
  `interface_id` varchar(32) DEFAULT NULL COMMENT '权限ID',
  `interrole_id` varchar(32) DEFAULT NULL COMMENT '接口角色ID',
  `data_rule` varchar(1000) DEFAULT NULL COMMENT '接口权限规则ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接口权限角色关联表';

-- ----------------------------
-- Table structure for t_s_interrole_user
-- ----------------------------
DROP TABLE IF EXISTS `t_s_interrole_user`;
CREATE TABLE `t_s_interrole_user` (
  `id` varchar(32) NOT NULL COMMENT 'ID',
  `interrole_id` varchar(32) DEFAULT NULL COMMENT '接口角色ID',
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接口角色和用户关联表';

-- ----------------------------
-- Table structure for t_s_log
-- ----------------------------
DROP TABLE IF EXISTS `t_s_log`;
CREATE TABLE `t_s_log` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `broswer` varchar(100) DEFAULT NULL COMMENT '浏览器',
  `logcontent` longtext NOT NULL COMMENT '日志内容',
  `loglevel` smallint(6) DEFAULT NULL COMMENT '日志级别',
  `note` longtext COMMENT 'IP',
  `operatetime` datetime NOT NULL COMMENT '操作时间',
  `operatetype` smallint(6) DEFAULT NULL COMMENT '操作类型',
  `userid` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `username` varchar(50) DEFAULT NULL COMMENT '用户账号',
  `realname` varchar(50) DEFAULT NULL COMMENT '真实名字'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_muti_lang
-- ----------------------------
DROP TABLE IF EXISTS `t_s_muti_lang`;
CREATE TABLE `t_s_muti_lang` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `lang_key` varchar(50) DEFAULT NULL COMMENT '语言主键',
  `lang_context` varchar(500) DEFAULT NULL COMMENT '内容',
  `lang_code` varchar(50) DEFAULT NULL COMMENT '语言',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人编号',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人姓名',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人编号',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人姓名'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_notice
-- ----------------------------
DROP TABLE IF EXISTS `t_s_notice`;
CREATE TABLE `t_s_notice` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'ID',
  `notice_title` varchar(255) DEFAULT NULL COMMENT '通知标题',
  `notice_content` longtext COMMENT '通知公告内容',
  `notice_type` varchar(2) DEFAULT NULL COMMENT '通知公告类型（1：通知，2:公告）',
  `notice_level` varchar(2) DEFAULT NULL COMMENT '通告授权级别（1:全员，2：角色，3：用户）',
  `notice_term` datetime DEFAULT NULL COMMENT '阅读期限',
  `create_user` varchar(32) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知公告表';

-- ----------------------------
-- Table structure for t_s_notice_authority_role
-- ----------------------------
DROP TABLE IF EXISTS `t_s_notice_authority_role`;
CREATE TABLE `t_s_notice_authority_role` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'ID',
  `notice_id` varchar(36) DEFAULT NULL COMMENT '通告ID',
  `role_id` varchar(32) DEFAULT NULL COMMENT '授权角色ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通告授权角色表';

-- ----------------------------
-- Table structure for t_s_notice_authority_user
-- ----------------------------
DROP TABLE IF EXISTS `t_s_notice_authority_user`;
CREATE TABLE `t_s_notice_authority_user` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'ID',
  `notice_id` varchar(36) DEFAULT NULL COMMENT '通告ID',
  `user_id` varchar(32) DEFAULT NULL COMMENT '授权用户ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通告授权用户表';

-- ----------------------------
-- Table structure for t_s_notice_read_user
-- ----------------------------
DROP TABLE IF EXISTS `t_s_notice_read_user`;
CREATE TABLE `t_s_notice_read_user` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'ID',
  `notice_id` varchar(36) DEFAULT NULL COMMENT '通告ID',
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `is_read` smallint(2) NOT NULL DEFAULT '0' COMMENT '是否已阅读',
  `del_flag` smallint(2) NOT NULL DEFAULT '0' COMMENT '是否已删除',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通告已读用户表';

-- ----------------------------
-- Table structure for t_s_operation
-- ----------------------------
DROP TABLE IF EXISTS `t_s_operation`;
CREATE TABLE `t_s_operation` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `operationcode` varchar(50) DEFAULT NULL COMMENT '页面控件code',
  `operationicon` varchar(100) DEFAULT NULL COMMENT '图标',
  `operationname` varchar(50) DEFAULT NULL COMMENT '页面名字',
  `status` smallint(6) DEFAULT NULL COMMENT '状态',
  `functionid` varchar(32) DEFAULT NULL COMMENT '菜单ID',
  `iconid` varchar(32) DEFAULT NULL COMMENT '图标ID',
  `operationtype` smallint(6) DEFAULT NULL COMMENT '规则类型：1/禁用 0/隐藏',
  `processnode_id` varchar(32) DEFAULT NULL COMMENT '流程节点id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_password_resetkey
-- ----------------------------
DROP TABLE IF EXISTS `t_s_password_resetkey`;
CREATE TABLE `t_s_password_resetkey` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `username` varchar(100) DEFAULT NULL COMMENT '用户名',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱地址',
  `is_reset` int(11) DEFAULT NULL COMMENT '是否已重置'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_region
-- ----------------------------
DROP TABLE IF EXISTS `t_s_region`;
CREATE TABLE `t_s_region` (
  `ID` varchar(10) NOT NULL COMMENT 'ID',
  `NAME` varchar(50) NOT NULL COMMENT '城市名',
  `PID` varchar(10) NOT NULL COMMENT '父ID',
  `NAME_EN` varchar(100) NOT NULL COMMENT '英文名'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_role
-- ----------------------------
DROP TABLE IF EXISTS `t_s_role`;
CREATE TABLE `t_s_role` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `rolecode` varchar(10) DEFAULT NULL COMMENT '角色编码',
  `rolename` varchar(100) NOT NULL COMMENT '角色名字',
  `depart_ag_id` varchar(32) DEFAULT NULL COMMENT '部门权限组ID',
  `role_type` varchar(2) DEFAULT NULL COMMENT '类型1部门角色/0系统角色',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人id',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_role_function
-- ----------------------------
DROP TABLE IF EXISTS `t_s_role_function`;
CREATE TABLE `t_s_role_function` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `operation` varchar(1000) DEFAULT NULL COMMENT '页面控件权限编码',
  `functionid` varchar(32) DEFAULT NULL COMMENT '菜单ID',
  `roleid` varchar(32) DEFAULT NULL COMMENT '角色ID',
  `datarule` varchar(1000) DEFAULT NULL COMMENT '数据权限规则ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_role_org
-- ----------------------------
DROP TABLE IF EXISTS `t_s_role_org`;
CREATE TABLE `t_s_role_org` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `org_id` varchar(32) DEFAULT NULL COMMENT '机构ID',
  `role_id` varchar(32) DEFAULT NULL COMMENT '角色ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_role_user
-- ----------------------------
DROP TABLE IF EXISTS `t_s_role_user`;
CREATE TABLE `t_s_role_user` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `roleid` varchar(32) DEFAULT NULL COMMENT '角色ID',
  `userid` varchar(32) DEFAULT NULL COMMENT '用户ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_sms
-- ----------------------------
DROP TABLE IF EXISTS `t_s_sms`;
CREATE TABLE `t_s_sms` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `es_title` varchar(32) DEFAULT NULL COMMENT '消息标题',
  `es_type` varchar(1) DEFAULT NULL COMMENT '消息类型',
  `es_sender` varchar(50) DEFAULT NULL COMMENT '发送人',
  `es_receiver` varchar(50) DEFAULT NULL COMMENT '接收人',
  `es_content` longtext COMMENT '内容',
  `es_sendtime` datetime DEFAULT NULL COMMENT '发送时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `es_status` varchar(1) DEFAULT NULL COMMENT '发送状态',
  `is_read` smallint(2) NOT NULL DEFAULT '0' COMMENT '是否已阅读'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_sms_sql
-- ----------------------------
DROP TABLE IF EXISTS `t_s_sms_sql`;
CREATE TABLE `t_s_sms_sql` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `sql_name` varchar(32) DEFAULT NULL COMMENT 'SQL名称',
  `sql_content` varchar(1000) DEFAULT NULL COMMENT 'SQL内容',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_sms_template
-- ----------------------------
DROP TABLE IF EXISTS `t_s_sms_template`;
CREATE TABLE `t_s_sms_template` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `template_type` varchar(1) DEFAULT NULL COMMENT '模板类型',
  `template_code` varchar(32) DEFAULT NULL COMMENT '模板CODE',
  `template_name` varchar(50) DEFAULT NULL COMMENT '模板名称',
  `template_content` varchar(1000) DEFAULT NULL COMMENT '模板内容',
  `template_test_json` varchar(1000) DEFAULT NULL COMMENT '模板测试json',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_sms_template_sql
-- ----------------------------
DROP TABLE IF EXISTS `t_s_sms_template_sql`;
CREATE TABLE `t_s_sms_template_sql` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `code` varchar(32) DEFAULT NULL COMMENT '配置CODE',
  `name` varchar(32) DEFAULT NULL COMMENT '配置名称',
  `sql_id` varchar(32) DEFAULT NULL COMMENT '业务SQLID',
  `template_id` varchar(32) DEFAULT NULL COMMENT '消息模本ID',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_timetask
-- ----------------------------
DROP TABLE IF EXISTS `t_s_timetask`;
CREATE TABLE `t_s_timetask` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `CREATE_BY` varchar(32) DEFAULT NULL COMMENT '创建人',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `CREATE_NAME` varchar(32) DEFAULT NULL COMMENT '创建人名字',
  `CRON_EXPRESSION` varchar(100) NOT NULL COMMENT 'cron表达式',
  `IS_EFFECT` varchar(1) NOT NULL COMMENT '是否生效 0/未生效,1/生效',
  `IS_START` varchar(1) NOT NULL COMMENT '是否运行0停止,1运行',
  `TASK_DESCRIBE` varchar(50) NOT NULL COMMENT '任务描述',
  `TASK_ID` varchar(100) NOT NULL COMMENT '任务ID',
  `CLASS_NAME` varchar(300) NOT NULL COMMENT '任务类名',
  `RUN_SERVER_IP` varchar(15) NOT NULL DEFAULT '本地' COMMENT '任务运行服务器IP',
  `RUN_SERVER` varchar(300) NOT NULL DEFAULT '本地' COMMENT '远程主机（域名/IP+项目路径）',
  `UPDATE_BY` varchar(32) DEFAULT NULL COMMENT '修改人',
  `UPDATE_DATE` datetime DEFAULT NULL COMMENT '修改时间',
  `UPDATE_NAME` varchar(32) DEFAULT NULL COMMENT '修改人名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_type
-- ----------------------------
DROP TABLE IF EXISTS `t_s_type`;
CREATE TABLE `t_s_type` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `typecode` varchar(50) DEFAULT NULL COMMENT '字典编码',
  `typename` varchar(50) DEFAULT NULL COMMENT '字典名称',
  `typepid` varchar(32) DEFAULT NULL COMMENT '无用字段',
  `typegroupid` varchar(32) DEFAULT NULL COMMENT '字典组ID',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(36) DEFAULT NULL COMMENT '创建用户',
  `order_num` int(3) DEFAULT NULL COMMENT '序号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_typegroup
-- ----------------------------
DROP TABLE IF EXISTS `t_s_typegroup`;
CREATE TABLE `t_s_typegroup` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `typegroupcode` varchar(50) DEFAULT NULL COMMENT '字典分组编码',
  `typegroupname` varchar(50) DEFAULT NULL COMMENT '字典分组名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(36) DEFAULT NULL COMMENT '创建用户'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_user
-- ----------------------------
DROP TABLE IF EXISTS `t_s_user`;
CREATE TABLE `t_s_user` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `mobilePhone` varchar(30) DEFAULT NULL COMMENT '手机号',
  `officePhone` varchar(20) DEFAULT NULL COMMENT '办公座机',
  `signatureFile` varchar(100) DEFAULT NULL COMMENT '签名文件',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人id',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人id',
  `portrait` varchar(100) DEFAULT NULL,
  `imsign` varchar(255) DEFAULT NULL,
  `dev_flag` varchar(2) NOT NULL DEFAULT '0' COMMENT '开发权限标志',
  `user_type` varchar(2) DEFAULT NULL COMMENT '用户类型',
  `person_type` varchar(2) DEFAULT NULL COMMENT '人员类型',
  `sex` varchar(2) DEFAULT NULL COMMENT '性别',
  `emp_no` varchar(36) DEFAULT NULL COMMENT '工号',
  `citizen_no` varchar(20) DEFAULT NULL COMMENT '身份证号',
  `fax` varchar(50) DEFAULT NULL COMMENT '传真',
  `address` varchar(1000) DEFAULT NULL COMMENT '联系地址',
  `post` varchar(10) DEFAULT NULL COMMENT '邮编',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_user_org
-- ----------------------------
DROP TABLE IF EXISTS `t_s_user_org`;
CREATE TABLE `t_s_user_org` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户id',
  `org_id` varchar(32) DEFAULT NULL COMMENT '部门id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_s_user_position_rel
-- ----------------------------
DROP TABLE IF EXISTS `t_s_user_position_rel`;
CREATE TABLE `t_s_user_position_rel` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户id',
  `position_id` varchar(32) DEFAULT NULL COMMENT '职务id',
  `company_id` varchar(32) DEFAULT NULL COMMENT '公司ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户-岗位-公司关联表';

-- ----------------------------
-- View structure for vi_contract_org_amount
-- ----------------------------
DROP VIEW IF EXISTS `vi_contract_org_amount`;
CREATE ALGORITHM=UNDEFINED DEFINER=`npa`@`%` SQL SECURITY DEFINER VIEW `vi_contract_org_amount` AS select `o`.`id` AS `orgId`,`o`.`name_shorter` AS `orgName`,round(ifnull(`c`.`v1`,0),0) AS `v1`,round(ifnull(`c`.`v2`,0),0) AS `v2` from (`npa_corporate_org` `o` left join (select sum(`c`.`recovery_principal`) AS `v1`,sum((`c`.`amount` - `c`.`recovery_principal`)) AS `v2`,`c`.`corporate_org_id` AS `id` from `npa_loan_contract` `c` where ((`c`.`is_submit` = '1') and (`c`.`is_delete` = '0')) group by `c`.`corporate_org_id`) `c` on((`o`.`id` = `c`.`id`))) order by `c`.`v1` ;

-- ----------------------------
-- View structure for vi_contract_org_borrower
-- ----------------------------
DROP VIEW IF EXISTS `vi_contract_org_borrower`;
CREATE ALGORITHM=UNDEFINED DEFINER=`npa`@`%` SQL SECURITY DEFINER VIEW `vi_contract_org_borrower` AS select `o`.`id` AS `id`,`o`.`name_shorter` AS `orgName`,ifnull(`c`.`ct`,0) AS `ct` from (`npa_corporate_org` `o` join (select count(distinct `c`.`borrower_id`) AS `ct`,`c`.`corporate_org_id` AS `id` from `npa_loan_contract` `c` where ((`c`.`is_submit` = '1') and (`c`.`is_delete` = '0')) group by `c`.`corporate_org_id`) `c` on((`o`.`id` = `c`.`id`))) order by `c`.`ct` ;

-- ----------------------------
-- View structure for vi_contract_qy
-- ----------------------------
DROP VIEW IF EXISTS `vi_contract_qy`;
CREATE ALGORITHM=UNDEFINED DEFINER=`npa`@`%` SQL SECURITY DEFINER VIEW `vi_contract_qy` AS select `c`.`id` AS `id`,`c`.`num_code` AS `num_code`,`c`.`customer_no` AS `customer_no`,`c`.`lou_no` AS `lou_no`,`p`.`name` AS `borrower_name`,`p`.`id_number` AS `id_number`,`c`.`amount` AS `amount`,(`c`.`amount` - `c`.`recovery_principal`) AS `amount_surplus`,`c`.`interest_rate` AS `o_interest_rate`,`c`.`issue_date` AS `issue_date`,`c`.`due_date` AS `due_date`,`r`.`interest_date` AS `interest_date`,`r`.`interest_rate` AS `adjust_interest_rate`,`c`.`officer` AS `officer`,`c`.`corporate_org_name` AS `corporate_org_name`,`c`.`hang_interes` AS `hang_interes`,`c`.`guarantee_mode` AS `guarantee_mode`,`c`.`dispose_mode` AS `dispose_mode`,`c`.`litigation_stat` AS `litigation_stat`,`c`.`stat` AS `stat` from ((`npa_loan_contract` `c` left join `vi_contract_recalllast` `r` on((`c`.`id` = `r`.`loan_contrac_id`))) join `npa_natural_person` `p` on((`c`.`borrower_id` = `p`.`id`))) where ((`c`.`is_delete` = 0) and (`c`.`is_submit` = 1)) ;

-- ----------------------------
-- View structure for vi_contract_recalllast
-- ----------------------------
DROP VIEW IF EXISTS `vi_contract_recalllast`;
CREATE ALGORITHM=UNDEFINED DEFINER=`npa`@`%` SQL SECURITY DEFINER VIEW `vi_contract_recalllast` AS with `ranked_recall` as (select `m`.`id` AS `id`,`m`.`loan_contrac_id` AS `loan_contrac_id`,`m`.`interest_bearing_principal` AS `interest_bearing_principal`,`m`.`interest_date` AS `interest_date`,`m`.`interest_rate` AS `interest_rate`,`m`.`recovery_date` AS `recovery_date`,`m`.`recovery_person` AS `recovery_person`,`m`.`recovery_principal` AS `recovery_principal`,`m`.`recovery_interest` AS `recovery_interest`,`m`.`hang_interest` AS `hang_interest`,`m`.`is_effect` AS `is_effect`,`m`.`create_by` AS `create_by`,`m`.`create_date` AS `create_date`,`m`.`update_by` AS `update_by`,`m`.`update_date` AS `update_date`,`m`.`is_delete` AS `is_delete`,`m`.`delete_date` AS `delete_date`,row_number() OVER (PARTITION BY `m`.`loan_contrac_id` ORDER BY `m`.`id` desc )  AS `rn` from `npa_recovery_money` `m` where (`m`.`is_effect` = '1')) select `s`.`id` AS `id`,`s`.`loan_contrac_id` AS `loan_contrac_id`,`s`.`interest_bearing_principal` AS `interest_bearing_principal`,`s`.`interest_date` AS `interest_date`,`s`.`interest_rate` AS `interest_rate`,`s`.`recovery_date` AS `recovery_date`,`s`.`recovery_person` AS `recovery_person`,`s`.`recovery_principal` AS `recovery_principal`,`s`.`recovery_interest` AS `recovery_interest`,`s`.`hang_interest` AS `hang_interest`,`s`.`is_effect` AS `is_effect`,`s`.`create_by` AS `create_by`,`s`.`create_date` AS `create_date`,`s`.`update_by` AS `update_by`,`s`.`update_date` AS `update_date`,`s`.`is_delete` AS `is_delete`,`s`.`delete_date` AS `delete_date`,`s`.`rn` AS `rn` from `ranked_recall` `s` where (`s`.`rn` = 1) ;

-- ----------------------------
-- View structure for vi_loan_contract_imp
-- ----------------------------
DROP VIEW IF EXISTS `vi_loan_contract_imp`;
CREATE ALGORITHM=UNDEFINED DEFINER=`npa`@`%` SQL SECURITY DEFINER VIEW `vi_loan_contract_imp` AS select `ci`.`id` AS `id`,`ci`.`num_code` AS `num_code`,`ci`.`customer_no` AS `customer_no`,`ci`.`lou_no` AS `lou_no`,`ci`.`borrower_name` AS `borrower_name`,`ci`.`borrower_number` AS `borrower_number`,`ci`.`is_impersonate` AS `is_impersonate`,`ci`.`guarantees` AS `guarantees`,`ci`.`amount` AS `amount`,`ci`.`issue_date` AS `issue_date`,`ci`.`due_date` AS `due_date`,`ci`.`interest_rate` AS `interest_rate`,`ci`.`officer` AS `officer`,`ci`.`corporate_org_name` AS `corporate_org_name`,`ci`.`guarantee_mode` AS `guarantee_mode`,`ci`.`dispose_mode` AS `dispose_mode`,`ci`.`litigation_stat` AS `litigation_stat`,`ci`.`stat` AS `stat`,`ci`.`interest_date` AS `interest_date`,`ci`.`recovery_principal` AS `recovery_principal`,`ci`.`recovery_interest` AS `recovery_interest`,`ci`.`hang_interes` AS `hang_interes`,(select `t`.`ct` from (select `npa_loan_contract_imp`.`num_code` AS `num_code`,count(1) AS `ct` from `npa_loan_contract_imp` where (`npa_loan_contract_imp`.`num_code` <> '') group by `npa_loan_contract_imp`.`num_code`) `t` where (`ci`.`num_code` = `t`.`num_code`)) AS `num_code_count_self`,(select `t`.`ct` from (select `npa_loan_contract_imp`.`lou_no` AS `lou_no`,count(1) AS `ct` from `npa_loan_contract_imp` where (`npa_loan_contract_imp`.`lou_no` <> '') group by `npa_loan_contract_imp`.`lou_no`) `t` where (`ci`.`lou_no` = `t`.`lou_no`)) AS `lou_no_count_self`,`c`.`num_code` AS `real_num_code` from (`npa_loan_contract_imp` `ci` left join `npa_loan_contract` `c` on((`ci`.`num_code` = `c`.`num_code`))) ;

-- ----------------------------
-- Procedure structure for pro_sysinit_lt
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_sysinit_lt`;
DELIMITER ;;
CREATE DEFINER=`npa`@`%` PROCEDURE `pro_sysinit_lt`(IN `dotId` tinyint,OUT `msg` varchar(30))
label: BEGIN
	DECLARE checkResult INT UNSIGNED DEFAULT 0;
	DECLARE dotName VARCHAR(20) DEFAULT '';
  #01)数据校验
  -- 01.01 不为空校验
	SELECT COUNT(1)
		FROM npa_loan_contract_imp
	 WHERE num_code IS NULL
			OR borrower_name IS NULL
			OR borrower_number IS NULL
			OR amount IS NULL
			OR issue_date IS NULL
			OR due_date IS NULL
			OR interest_rate IS NULL
			OR officer IS NULL
			OR corporate_org_name IS NULL
			OR dispose_mode IS NULL
			OR litigation_stat IS NULL
			OR stat IS NULL INTO checkResult;
  IF checkResult > 0 THEN
		SET msg = '有空值';
		LEAVE label;
	END IF;

  -- 01.02 档案号自身不能重名
	SELECT COUNT(1)
		FROM (SELECT num_code
						FROM npa_loan_contract_imp
					 GROUP BY num_code
					HAVING COUNT(1) > 1) t INTO checkResult;
  IF checkResult > 0 THEN
		SET msg = '档案号自身有重名';
		LEAVE label;
	END IF;

  -- 01.03 档案号自身不能与现有数据重名
	SELECT COUNT(1)
		FROM (SELECT c.num_code
						FROM npa_loan_contract_imp i
					 INNER JOIN npa_loan_contract c
							ON i.num_code = c.num_code) t INTO checkResult;
  IF checkResult > 0 THEN
		SET msg = '档案号与与现有数据重名';
		LEAVE label;
	END IF;

	-- 01.04 借据号自身不能重名
	SELECT COUNT(1)
		FROM (SELECT lou_no
						FROM npa_loan_contract_imp
					 GROUP BY lou_no
					HAVING COUNT(1) > 1) t INTO checkResult;
  IF checkResult > 0 THEN
		SET msg = '借据号自身有重名';
		LEAVE label;
	END IF;

	-- 01.05 贷款到期日不能小于贷款发放日
	SELECT COUNT(1)
		FROM npa_loan_contract_imp
	 WHERE issue_date >= due_date INTO checkResult;
  IF checkResult > 0 THEN
		SET msg = '贷款到期日有小于贷款发放日';
		LEAVE label;
	END IF;

	-- 01.06 导入支行名称正确
	SELECT name_shorter FROM npa_corporate_org WHERE id = dotId LIMIT 1 INTO dotName;
	IF dotName = '' THEN
		SET msg = '传入的支行id错误';
		LEAVE label;
	END IF;

	-- 01.07 起息日不能小于贷款到期日
	SELECT COUNT(1)
		FROM npa_loan_contract_imp
	 WHERE issue_date >= interest_date AND interest_date IS NOT NULL INTO checkResult;
  IF checkResult > 0 THEN
		SET msg = '起息日有小于贷款到期日';
		LEAVE label;
	END IF;
  
	-- 01.08起息日存在,收回本金、收回利息、挂息不能大于0
	SELECT COUNT(1)
		FROM npa_loan_contract_imp
	 WHERE interest_date IS NULL
		 AND (recovery_principal > 0 OR recovery_interest > 0 OR
				 hang_interes > 0) INTO checkResult;
  IF checkResult > 0 THEN
		SET msg = '起息日存在,收回本金、收回利息、挂息大于0';
		LEAVE label;
	END IF;

	-- 01.08起息日存在,收回本金不能大于贷款金额
	SELECT COUNT(1)		
		FROM npa_loan_contract_imp
	 WHERE interest_date IS NOT NULL AND recovery_principal > amount INTO checkResult;
  IF checkResult > 0 THEN
		SET msg = '收回本金有大于贷款金额';
		LEAVE label;
	END IF;

	-- 01.09判断是否有身份证相同,姓名不同的数据
	SELECT
		COUNT(1)
	FROM
		(
			SELECT
				id_number
			FROM
				(
					SELECT DISTINCT
						npi. NAME,
						npi.id_number
					FROM
						npa_natural_person_imp npi
					LEFT JOIN npa_natural_person p ON npi.id_number = p.id_number
					WHERE
						p.id_number IS NULL
				) t
			GROUP BY
				t.id_number
			HAVING
				COUNT(1) > 1
		) t INTO checkResult;
  
  IF checkResult > 0 THEN
		SET msg = '身份证相同,姓名不同';
		LEAVE label;
	END IF;

	#02)删除dotId下的所有历史数据
	DELETE m FROM npa_recovery_money m LEFT JOIN npa_loan_contract t ON m.loan_contrac_id = t.id
	 WHERE t.corporate_org_id = dotId;

	DELETE g FROM npa_loan_contract_guarantee g LEFT JOIN npa_loan_contract t ON g.loan_contrac_id = t.id
	 WHERE t.corporate_org_id = dotId;

	DELETE FROM npa_loan_contract WHERE corporate_org_id = dotId;

	#03)插入所有新增的借款人和担保人
	INSERT INTO npa_natural_person (NAME, id_number, create_by, create_date, is_delete) SELECT
		np.`name`,
		np.id_number,
		'admin',
		NOW(),
		'0'
	FROM
		npa_natural_person_imp np
	LEFT JOIN npa_natural_person npi ON np.id_number = npi.id_number
	WHERE
		npi.id_number IS NULL;

	#04)插入合同表
	INSERT INTO npa_loan_contract
		(num_code,
		 customer_no,
		 lou_no,
		 borrower_id,
		 borrower_name,
		 is_impersonate,
		 amount,
		 issue_date,
		 due_date,
		 interest_rate,
		 officer,
		 corporate_org_id,
		 corporate_org_name,
		 guarantee_mode,
		 dispose_mode,
		 litigation_stat,
		 is_submit,
		 interest_date,
		 recovery_principal,
		 recovery_interest,
		 hang_interes,
		 create_by,
		 create_date,
		 is_delete)
		SELECT c.num_code,
					 c.customer_no,
					 c.lou_no,
					 p.id,
					 c.borrower_name,
					 '0',
					 c.amount,
					 c.issue_date,
					 c.due_date,
					 c.interest_rate,
					 c.officer,
					 dotId,
					 dotName,
					 c.guarantee_mode,
					 c.dispose_mode,
					 c.litigation_stat,
					 '1',
					 c.interest_date,
					 c.recovery_principal,
					 c.recovery_interest,
					 c.hang_interes,
					 'admin',
					 NOW(),
					 '0'
			FROM npa_loan_contract_imp c
		 INNER JOIN npa_natural_person p
				ON c.borrower_number = p.id_number;

	#05)插入担保人表
	INSERT INTO npa_loan_contract_guarantee
  (loan_contrac_id, guarantee_id, guarantee_name, is_impersonate)
  SELECT c.id, p.id, p.name, 0
    FROM npa_natural_person_imp i
   INNER JOIN npa_natural_person p
      ON i.id_number = p.id_number
   INNER JOIN npa_loan_contract c
      ON i.num_code = c.num_code
   WHERE i.is_guarantee = '1';

  #06)更新自然人的是否借款人、是否担保人、生日及性别
	UPDATE npa_natural_person p JOIN (SELECT id_number
                                    FROM npa_natural_person_imp
                                   WHERE is_borrower = '1') t ON p.id_number = t.id_number
   set is_borrower = '1';

	UPDATE npa_natural_person p JOIN (SELECT id_number
                                    FROM npa_natural_person_imp
                                   WHERE is_guarantee = '1') t ON p.id_number = t.id_number
   set is_guarantee = '1';

	UPDATE npa_natural_person p JOIN (SELECT id_number
																			FROM npa_natural_person_imp) t ON p.id_number = t.id_number
		 set p.birthday = CASE
												WHEN LENGTH(p.id_number) = 18 THEN
												 SUBSTRING(p.id_number, 7, 8)
												WHEN LENGTH(p.id_number) = 15 THEN
												 CONCAT('19', SUBSTRING(p.id_number, 7, 6))
											END,
				 p.sex = CASE
									 WHEN LENGTH(p.id_number) = 18 THEN
										IF(MOD(SUBSTRING(p.id_number, 17, 1), 2), 'm', 'f')
									 WHEN LENGTH(p.id_number) = 15 THEN
										IF(MOD(SUBSTRING(p.id_number, 15, 1), 2), 'm', 'f')
								 END;

	SET msg = 'true';
END
;;
DELIMITER ;
