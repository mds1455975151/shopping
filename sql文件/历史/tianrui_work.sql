/*
Navicat MySQL Data Transfer

Source Server         : localhost_8889
Source Server Version : 50538
Source Host           : localhost:8889
Source Database       : tianrui_work

Target Server Type    : MYSQL
Target Server Version : 50538
File Encoding         : 65001

Date: 2017-08-01 22:40:27
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin_user`
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user` (
  `id` varchar(32) NOT NULL DEFAULT '',
  `acount` varchar(255) DEFAULT '' COMMENT '账号',
  `acount_status` varchar(255) DEFAULT NULL COMMENT '账号状态1-正常 0-禁用',
  `password` varchar(255) DEFAULT '' COMMENT '密码',
  `username` varchar(255) DEFAULT '' COMMENT '用户名称',
  `telphone` varchar(255) DEFAULT '' COMMENT '联系电话',
  `logintime` bigint(20) DEFAULT NULL COMMENT '登录时间',
  `user_role` varchar(255) DEFAULT '' COMMENT '用户权限',
  `createtime` bigint(20) DEFAULT NULL COMMENT '添加时间',
  `login_num` int(11) DEFAULT NULL COMMENT '登录次数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin_user
-- ----------------------------
INSERT INTO `admin_user` VALUES ('admin', 'admin', '1', '666666', '超级管理员', '18337129805', '1501591887324', 'admin', null, '25');
INSERT INTO `admin_user` VALUES ('e74df26737f04dd8a74f41dd0c53204b', 'xiao', '1', '111111', '小娟', '15138912934', '1501333433508', '', '1501333364608', '1');

-- ----------------------------
-- Table structure for `configuration_info`
-- ----------------------------
DROP TABLE IF EXISTS `configuration_info`;
CREATE TABLE `configuration_info` (
  `paramkey` varchar(100) DEFAULT NULL COMMENT '参数键',
  `paramvalue` varchar(100) DEFAULT NULL COMMENT '参数值',
  `depict` varchar(256) DEFAULT NULL COMMENT '描述',
  `flag` varchar(3) DEFAULT '1' COMMENT '维护标志:0-失效;1-有效',
  KEY `index_1` (`paramkey`),
  KEY `index_2` (`flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配置信息表';

-- ----------------------------
-- Records of configuration_info
-- ----------------------------

-- ----------------------------
-- Table structure for `goods_classify`
-- ----------------------------
DROP TABLE IF EXISTS `goods_classify`;
CREATE TABLE `goods_classify` (
  `classify_id` varchar(50) NOT NULL COMMENT '分类ID',
  `classify_name` varchar(30) DEFAULT NULL COMMENT '分类名称',
  `parent_id` varchar(50) DEFAULT NULL COMMENT '父ID',
  `descr` varchar(256) DEFAULT NULL COMMENT '备注说明',
  PRIMARY KEY (`classify_id`),
  KEY `index_1` (`classify_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品分类信息表';

-- ----------------------------
-- Records of goods_classify
-- ----------------------------

-- ----------------------------
-- Table structure for `goods_info`
-- ----------------------------
DROP TABLE IF EXISTS `goods_info`;
CREATE TABLE `goods_info` (
  `goods_id` varchar(50) NOT NULL COMMENT '商品ID',
  `classify_id` varchar(50) DEFAULT NULL COMMENT '分类ID',
  `classify_name` varchar(255) DEFAULT NULL,
  `goods_name` varchar(256) DEFAULT NULL COMMENT '商品名称',
  `goods_img` longtext COMMENT '商品图片(图片地址)',
  `goods_status` varchar(3) DEFAULT NULL COMMENT '商品状态:1-已上架;2-已下架',
  `goods_type` varchar(3) DEFAULT NULL COMMENT '商品类型:1-大众商品;2-宏包商品',
  `goods_price` double(10,2) DEFAULT NULL COMMENT '商品价格',
  `red_packet` int(10) DEFAULT NULL COMMENT '宏包',
  `goods_details` varchar(256) DEFAULT NULL COMMENT '详情',
  `goods_param` double(10,2) DEFAULT NULL COMMENT '参数',
  `express_fee` double(10,2) DEFAULT NULL COMMENT '快递费',
  `inventory` int(10) DEFAULT NULL COMMENT '库存',
  `salesvolume` int(10) DEFAULT NULL COMMENT '销量',
  `buy_num` int(10) DEFAULT NULL COMMENT '购买数量',
  `browse_num` int(10) DEFAULT NULL COMMENT '浏览记录',
  `sifting` varchar(3) DEFAULT '0' COMMENT '筛选条件:0-普通商品;1-推荐商品;2-新品上市;3-热卖商品;4-促销商品;5-卖家包邮;6-限时抢购',
  PRIMARY KEY (`goods_id`),
  KEY `index_1` (`goods_id`),
  KEY `index_2` (`classify_id`),
  KEY `index_3` (`goods_status`),
  KEY `index_4` (`goods_type`),
  KEY `index_5` (`sifting`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品信息表';

-- ----------------------------
-- Records of goods_info
-- ----------------------------

-- ----------------------------
-- Table structure for `member_address`
-- ----------------------------
DROP TABLE IF EXISTS `member_address`;
CREATE TABLE `member_address` (
  `address_id` varchar(50) NOT NULL COMMENT '地址ID',
  `member_id` varchar(50) NOT NULL COMMENT '会员ID',
  `recipients` varchar(20) DEFAULT NULL COMMENT '收件人',
  `phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `city` varchar(30) DEFAULT NULL COMMENT '所在地区',
  `detail_address` varchar(256) DEFAULT NULL COMMENT '详细地址',
  `is_default` varchar(3) DEFAULT '0' COMMENT '是否默认:0-非默认;1-默认',
  PRIMARY KEY (`address_id`),
  KEY `index_1` (`address_id`),
  KEY `index_2` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员地址信息表';

-- ----------------------------
-- Records of member_address
-- ----------------------------

-- ----------------------------
-- Table structure for `member_follow_footprint`
-- ----------------------------
DROP TABLE IF EXISTS `member_follow_footprint`;
CREATE TABLE `member_follow_footprint` (
  `id` varchar(50) NOT NULL DEFAULT '',
  `member_id` varchar(50) DEFAULT NULL COMMENT '会员ID',
  `goods_id` varchar(50) DEFAULT NULL COMMENT '商品ID',
  `ff_type` varchar(3) DEFAULT NULL COMMENT '关注足迹类型:1-关注;2-足迹',
  `seethe_time` bigint(20) DEFAULT NULL COMMENT '查看时间',
  `goods_name` varchar(256) DEFAULT NULL COMMENT '商品名称',
  `goods_img` longtext COMMENT '商品图片',
  `goods_price` double(102,0) DEFAULT NULL COMMENT '商品价格',
  `createtime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_1` (`member_id`,`ff_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员关注足迹信息表';

-- ----------------------------
-- Records of member_follow_footprint
-- ----------------------------

-- ----------------------------
-- Table structure for `member_info`
-- ----------------------------
DROP TABLE IF EXISTS `member_info`;
CREATE TABLE `member_info` (
  `member_id` varchar(50) NOT NULL COMMENT '会员ID',
  `member_name` varchar(20) DEFAULT '' COMMENT '会员名称',
  `wechat` varchar(50) DEFAULT '' COMMENT '微信号',
  `wechat_img` varchar(256) DEFAULT '' COMMENT '微信头像(图片地址)',
  `wechat_name` varchar(20) DEFAULT '' COMMENT '微信名称',
  `balance` double(10,2) DEFAULT NULL COMMENT '余额',
  `red_packet` double(10,2) DEFAULT NULL COMMENT '宏包',
  `cellphone` varchar(20) DEFAULT '' COMMENT '手机号',
  `birth_time` varchar(20) DEFAULT '' COMMENT '出生日期',
  `city` varchar(30) DEFAULT '' COMMENT '所在城市',
  `rp_exchange_ratio` double(10,2) DEFAULT NULL COMMENT '宏包兑换比例:0.3;0.4;0.5;0.6;0.7;0.8;0.9;1.0',
  `rp_trade_mark` varchar(3) DEFAULT '' COMMENT '宏包交易标志:0-关闭;1-打开',
  `rp_listing_ratio` varchar(10) DEFAULT '0' COMMENT '挂牌宏包比例:*(不限制);500;1000;5000;10000;20000;50000;100000',
  `createtime` bigint(20) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`member_id`),
  KEY `index_1` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员信息表';

-- ----------------------------
-- Records of member_info
-- ----------------------------
INSERT INTO `member_info` VALUES ('oxN_Gwa24d7SC2WsAVAKTNkkwg_o', '', 'oxN_Gwa24d7SC2WsAVAKTNkkwg_o', 'http://wx.qlogo.cn/mmopen/icMVrWV8Nt9ic3XBhic2l6VMV7J5JXbzFQ0DiaGpt1ZGK0Lh1JzDbL5EwUyR54icdKVnNrvyiarqH0dU6kywRdv96OkIx1icarWic58y/0', '小娟', '0.00', '0.00', '', '', '', '1.00', '0', '*', '1501423347898');
INSERT INTO `member_info` VALUES ('oxN_GwUfDDT47iFOpJz3LQ70z4KI', '', 'oxN_GwUfDDT47iFOpJz3LQ70z4KI', 'http://wx.qlogo.cn/mmopen/icMVrWV8Nt98yshm81GicqiblYz1BDI5WrsYuaO90iaqYsxOnBxehss9UNn7cQIHxeYL8eGR6iacJsYKGz9ZiazpUgDGyJXcZqDtyia/0', '李思佳', '0.00', '0.00', '15689568952', '', '郑州', '1.00', '0', '*', '1501422673820');

-- ----------------------------
-- Table structure for `member_recharge`
-- ----------------------------
DROP TABLE IF EXISTS `member_recharge`;
CREATE TABLE `member_recharge` (
  `recharge_id` varchar(50) NOT NULL COMMENT '充值订单ID',
  `member_id` varchar(50) NOT NULL COMMENT '会员ID',
  `recharge_amount` double(10,2) DEFAULT NULL COMMENT '充值金额',
  `recharge_status` varchar(3) DEFAULT NULL COMMENT '充值状态:1-成功;2-失败',
  `recharge_time` datetime DEFAULT NULL COMMENT '充值时间',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`recharge_id`),
  KEY `index_2` (`member_id`),
  KEY `index_1` (`recharge_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员充值订单表';

-- ----------------------------
-- Records of member_recharge
-- ----------------------------

-- ----------------------------
-- Table structure for `member_rp_gain`
-- ----------------------------
DROP TABLE IF EXISTS `member_rp_gain`;
CREATE TABLE `member_rp_gain` (
  `id` varchar(50) NOT NULL,
  `member_id` varchar(50) NOT NULL COMMENT '会员ID',
  `rp_type` varchar(3) DEFAULT NULL COMMENT '1-金额  2-宏包',
  `rp_num` double(10,2) DEFAULT NULL COMMENT '数量 增加为+  消费为-',
  `source_id` varchar(50) DEFAULT NULL COMMENT '来源ID:1-活动，活动ID;2-消费，订单ID;3-买进，宏包订单ID;4-卖出，宏包订单ID',
  `source_describe` varchar(256) DEFAULT NULL COMMENT '来源描述',
  `createtime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_1` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员宏包获取信息表';

-- ----------------------------
-- Records of member_rp_gain
-- ----------------------------

-- ----------------------------
-- Table structure for `member_settings`
-- ----------------------------
DROP TABLE IF EXISTS `member_settings`;
CREATE TABLE `member_settings` (
  `member_id` varchar(50) NOT NULL COMMENT '会员ID',
  `ddtj` varchar(3) DEFAULT '1' COMMENT '订单提交:0-关闭;1-打开',
  `ddqx` varchar(3) DEFAULT '1' COMMENT '订单取消:0-关闭;1-打开',
  `gmcg` varchar(3) DEFAULT '1' COMMENT '购买成功:0-关闭;1-打开',
  `ddfh` varchar(3) DEFAULT '1' COMMENT '订单发货:0-关闭;1-打开',
  `tksq` varchar(3) DEFAULT '1' COMMENT '退款申请:0-关闭;1-打开',
  `tkjg` varchar(3) DEFAULT '1' COMMENT '退款结果:0-关闭;1-打开',
  `czcg` varchar(3) DEFAULT '1' COMMENT '充值成功:0-关闭;1-打开',
  `txsq` varchar(3) DEFAULT '1' COMMENT '提现申请:0-关闭;1-打开',
  `txcg` varchar(3) DEFAULT '1' COMMENT '提现成功:0-关闭;1-打开',
  `txsb` varchar(3) DEFAULT '1' COMMENT '提现失败:0-关闭;1-打开',
  PRIMARY KEY (`member_id`),
  KEY `index_1` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员消息提醒配置表';

-- ----------------------------
-- Records of member_settings
-- ----------------------------

-- ----------------------------
-- Table structure for `member_withdrawal`
-- ----------------------------
DROP TABLE IF EXISTS `member_withdrawal`;
CREATE TABLE `member_withdrawal` (
  `withdrawal_id` varchar(50) NOT NULL COMMENT '提现订单ID',
  `member_id` varchar(50) NOT NULL COMMENT '会员ID',
  `withdrawal_amount` double(10,2) DEFAULT NULL COMMENT '提现金额',
  `withdrawal_status` varchar(3) DEFAULT NULL COMMENT '提现状态:0-申请;1-成功;2-失败',
  `withdrawal_time` datetime DEFAULT NULL COMMENT '提现时间',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`withdrawal_id`),
  KEY `index_1` (`withdrawal_id`),
  KEY `index_2` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员提现订单表';

-- ----------------------------
-- Records of member_withdrawal
-- ----------------------------

-- ----------------------------
-- Table structure for `order_info`
-- ----------------------------
DROP TABLE IF EXISTS `order_info`;
CREATE TABLE `order_info` (
  `order_id` varchar(50) NOT NULL COMMENT '订单ID',
  `order_code` varchar(50) NOT NULL COMMENT '订单编号',
  `member_id` varchar(50) DEFAULT NULL COMMENT '会员ID',
  `goods_type` varchar(3) DEFAULT NULL COMMENT '商品类型:1-大众商品;2-宏包商品',
  `goods_num` int(10) DEFAULT NULL COMMENT '商品数量',
  `goods_subtotal` double(10,2) DEFAULT NULL COMMENT '商品小计',
  `express_fee` double(10,2) DEFAULT NULL COMMENT '运费',
  `order_amount` double(10,2) DEFAULT NULL COMMENT '订单总金额',
  `order_red_packet` int(10) DEFAULT NULL COMMENT '订单总宏包',
  `order_status` varchar(3) DEFAULT NULL COMMENT '订单状态:1-待付款;2-待发货;3-待收货;4-已完成;5-退款申请;6-退款结果;7-已取消;8-已删除;9-彻底删除',
  `buyer_word` varchar(256) DEFAULT NULL COMMENT '买家留言',
  `creation_time` datetime DEFAULT NULL COMMENT '创建时间',
  `recipients` varchar(20) DEFAULT NULL COMMENT '收件人',
  `phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `city` varchar(30) DEFAULT NULL COMMENT '所在地区',
  `detail_address` varchar(50) DEFAULT NULL COMMENT '详细地址',
  PRIMARY KEY (`order_id`),
  KEY `index_1` (`order_id`),
  KEY `index_2` (`member_id`),
  KEY `index_3` (`goods_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单信息表';

-- ----------------------------
-- Records of order_info
-- ----------------------------

-- ----------------------------
-- Table structure for `red_packet_order`
-- ----------------------------
DROP TABLE IF EXISTS `red_packet_order`;
CREATE TABLE `red_packet_order` (
  `rp_order_id` varchar(50) NOT NULL COMMENT '宏包订单ID',
  `seller_member_id` varchar(50) DEFAULT NULL COMMENT '卖家ID',
  `buyers_member_id` varchar(50) DEFAULT NULL COMMENT '买家ID',
  `rp_exchange_ratio` double(2,2) DEFAULT NULL COMMENT '宏包兑换比例',
  `rp_num` int(10) DEFAULT NULL COMMENT '购买宏包数量',
  PRIMARY KEY (`rp_order_id`),
  KEY `index_1` (`rp_order_id`),
  KEY `index_2` (`seller_member_id`),
  KEY `index_3` (`buyers_member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='宏包订单信息表';

-- ----------------------------
-- Records of red_packet_order
-- ----------------------------

-- ----------------------------
-- Table structure for `shop_creditor`
-- ----------------------------
DROP TABLE IF EXISTS `shop_creditor`;
CREATE TABLE `shop_creditor` (
  `id` varchar(32) NOT NULL DEFAULT '' COMMENT '债权发布主键id',
  `creditor_status` varchar(6) DEFAULT '' COMMENT '信息状态 1-正常  0-作废',
  `creditor_type` varchar(6) DEFAULT NULL COMMENT '1-债权人 2-债务人',
  `creditor_name` varchar(255) DEFAULT '' COMMENT '债权人名称',
  `creditor_phone` varchar(255) DEFAULT '' COMMENT '债权人电话',
  `creditor_idcard` varchar(255) DEFAULT '' COMMENT '债权人身份证号',
  `creditor_sex` varchar(6) DEFAULT '' COMMENT '债权人性别 xx-女 xy-男',
  `creditor_address` varchar(255) DEFAULT '' COMMENT '债权人地址',
  `creditor_company` varchar(255) DEFAULT '' COMMENT '债权人公司',
  `creditor_company_address` varchar(255) DEFAULT '' COMMENT '债权人公司地址',
  `debtor_name` varchar(255) DEFAULT '' COMMENT '债务人名称',
  `debtor_phone` varchar(255) DEFAULT '' COMMENT '债务人电话',
  `debtor_idcrd` varchar(255) DEFAULT '' COMMENT '债务人身份证',
  `debtor_sex` varchar(6) DEFAULT '' COMMENT '债务人性别 xx-女 xy-男',
  `debtor_address` varchar(255) DEFAULT '' COMMENT '债务人身份证地址',
  `debtor_company` varchar(255) DEFAULT '' COMMENT '债务人公司名称',
  `debtor_company_address` varchar(255) DEFAULT '' COMMENT '债务人公司地址',
  `debt_amount` double(20,0) DEFAULT NULL COMMENT '债务金额',
  `debt_time` bigint(20) DEFAULT NULL COMMENT '债务产生时间',
  `debt_type` varchar(6) DEFAULT '' COMMENT '1-公司债务，2-借条债务，3-欠条债务，4-判决债务，5-其他债务',
  `creator` varchar(255) DEFAULT '' COMMENT '创建人',
  `creatorImg` varchar(255) DEFAULT '' COMMENT '添加人头像',
  `creator_time` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `updatetor` varchar(255) DEFAULT '' COMMENT '修改人',
  `update_time` bigint(20) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_creditor
-- ----------------------------
INSERT INTO `shop_creditor` VALUES ('6611690576694fa7a1a7170260d24526', '0', null, '', '', '', '', '', '', '', '', '', '', '', '', '', '', null, null, '', '', null, '1500988050902', '', null);
INSERT INTO `shop_creditor` VALUES ('debb28e5016f4ff391eb5f07717040a4', '0', '1', '流浪哥', '18337129856', '4125698741254231', 'xy', '斯蒂芬森分', '首发机会公司', '啊二个对手犯规', '', '', '', '', '', '', '', '200', '1500912000000', '1', '', null, '1500989991574', '', null);
INSERT INTO `shop_creditor` VALUES ('f5f0ccc56a28455eb4c9e79638c2901d', '1', '1', '', '', '', '', '', '', '', '', '', '', '', '', '', '', null, null, '1', '', null, '1500990318759', '', null);

-- ----------------------------
-- Table structure for `shopping_cart`
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart` (
  `goods_id` varchar(50) DEFAULT NULL COMMENT '商品ID',
  `member_id` varchar(50) DEFAULT NULL COMMENT '会员ID',
  `order_id` varchar(50) DEFAULT NULL COMMENT '订单ID',
  `creation_time` datetime DEFAULT NULL COMMENT '添加时间',
  `goods_name` varchar(256) DEFAULT NULL COMMENT '商品名称',
  `goods_img` longtext COMMENT '商品图片',
  `goods_price` double(10,2) DEFAULT NULL COMMENT '商品价格',
  `goods_red_packet` int(10) DEFAULT NULL COMMENT '商品宏包',
  `goods_num` int(10) DEFAULT NULL COMMENT '商品数量',
  `goods_type` varchar(3) DEFAULT NULL COMMENT '商品类型:1-大众商品;2-宏包商品',
  `shopping_cart_status` varchar(3) DEFAULT NULL COMMENT '购物车商品状态:1-已添加;2-已购买;3-已删除',
  KEY `index_1` (`member_id`),
  KEY `index_2` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购物车信息表';

-- ----------------------------
-- Records of shopping_cart
-- ----------------------------
