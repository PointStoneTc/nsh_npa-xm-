/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 80012
Source Host           : localhost:3306
Source Database       : npa

Target Server Type    : MYSQL
Target Server Version : 80012
File Encoding         : 65001

Date: 2019-04-13 00:00:24
*/

SET FOREIGN_KEY_CHECKS=0;

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
-- Records of npa_natural_person_imp
-- ----------------------------
INSERT INTO `npa_natural_person_imp` VALUES ('96', '梁余成', '410126961119252', '1', '0', '001');
INSERT INTO `npa_natural_person_imp` VALUES ('97', '涂吉根', '420324195708281038', '1', '0', '002');
INSERT INTO `npa_natural_person_imp` VALUES ('98', '何忆', '422625196909010030', '1', '0', '003');
INSERT INTO `npa_natural_person_imp` VALUES ('99', '梅浩伟', '420324198402080018', '1', '0', '004');
INSERT INTO `npa_natural_person_imp` VALUES ('100', '梅书国', '422625196112140030', '1', '0', '005');
INSERT INTO `npa_natural_person_imp` VALUES ('101', '吴新艳', '422625197706234629', '1', '0', '006');
INSERT INTO `npa_natural_person_imp` VALUES ('102', '李春梅', '420324198108111047', '1', '0', '007');
INSERT INTO `npa_natural_person_imp` VALUES ('103', '陈科', '321324199105192218', '0', '1', '001');
INSERT INTO `npa_natural_person_imp` VALUES ('104', '段元婷', '321324199101272245', '0', '1', '002');
INSERT INTO `npa_natural_person_imp` VALUES ('105', '赵琦', '410102198012222016', '0', '1', '004');
INSERT INTO `npa_natural_person_imp` VALUES ('106', '张娜', '412821198305185721', '0', '1', '005');
INSERT INTO `npa_natural_person_imp` VALUES ('107', '赵琦', '410102198012222016', '0', '1', '005');
INSERT INTO `npa_natural_person_imp` VALUES ('108', '杨忠文', '422624196611060039', '0', '1', '006');
INSERT INTO `npa_natural_person_imp` VALUES ('109', '刘凯', '420324198710191019', '0', '1', '007');
INSERT INTO `npa_natural_person_imp` VALUES ('110', '郭芳前', '422625196810190019', '0', '1', '007');
INSERT INTO `npa_natural_person_imp` VALUES ('111', '肖琴', '420324198610145429', '0', '1', '007');
