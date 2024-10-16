-- DRAW A COMMON SENSE IN THIS DB 
-- ISDEL: 
  -- 0: AVAILABLE
  -- 1: NOT AVAILABLE 

-- NAME && DESC IN JSON FORMAT:
  --{'en':'name', 'tw':'tw_name', 'cn':'cn_name'}

-- FOR EACH GOOD IN THE SYSTEM MUST HAVE AT LEAST ONE SKU ID


--
-- Table structure for table `tp_admin`
-- 
DROP TABLE IF EXISTS `tp_admin`;
CREATE TABLE `tp_admin` (
  -- `group_id` int unsigned DEFAULT '0' COMMENT '管理组', --[REMOVE]
  -- `account_id` varchar(45) DEFAULT NULL, --[REMOVE]
  -- `branch_id` int unsigned DEFAULT '0' COMMENT '所属分店。默认0【全部分店】', --[REMOVE]
  -- `rand` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '', --[REMOVE]
  `id` int NOT NULL AUTO_INCREMENT ,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `password` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `add_date` datetime DEFAULT NULL, --[UPDATE ORIGN addDate]
  `is_del` int unsigned  DEFAULT '0', --[UPDATE ORIGN isdel]
  `is_super` tinyint unsigned DEFAULT '0' COMMENT 'allow delete or not',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC COMMENT 'this table is seperate from the user table';


--
-- Table structure for table `tp_banner`
--

DROP TABLE IF EXISTS `tp_banner`;

CREATE TABLE `tp_banner` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `group` enum(
    'home',
    'booking',
    'app',
    'page',
    'courses',
    'products',
    'member',
    'aboutus',
    'promote',
    'coupon',
    'account'
  ) NOT NULL,
  `subtitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, --[UPDATE ORIGN addDate]
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `is_del` int DEFAULT '1', --[UPDATE ORIGN isdel]
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

--
-- Table structure for table `tp_cart`
--

DROP TABLE IF EXISTS `tp_cart`;

CREATE TABLE `tp_cart` (
  -- `customer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci, --[REMOVE]
  -- `email` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci, --[REMOVE]
  -- `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[REMOVE]
  -- `location` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci, --[TODO ???] --[REMOVE]
  -- `locations` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci, --[TODO ???] --[REMOVE]
  -- `book_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP, --[UPDATE ORIGN booktime] --[REMOVE]
  -- `good_type` int DEFAULT '0', --[UPDATE ORIGN goodsType] --[REMOVE]
  -- `out_trade_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[REMOVE]
  -- `d_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[UPDATE ORIGN dName] --[REMOVE]
  -- `d_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[UPDATE ORIGN dPhone] --[REMOVE]
  -- `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[REMOVE]
  -- `is_del` int DEFAULT '1' COMMENT '0: 刪除 1:可用', --[UPDATE ORIGN isdel] --[REMOVE]
  -- `crm_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '对应CRM ID', --[REMOVE]
  -- `model_data_info` varchar(2000) DEFAULT '', --[UPDATE ORIGN modelDataInfo] --[REMOVE]
  -- `price` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci, --[REMOVE]
  -- `name` varchar(255) NOT NULL, --[REMOVE]
  -- `good_id` int DEFAULT NULL, --[UPDATE ORIGN goodsId] --[REMOVE]
  `id` int NOT NULL AUTO_INCREMENT , --[UPDATE ORIGN cartId]
  `user_id` int NOT NULL COMMENT 'user id', --[UPDATE ORIGN uid]
  `sku_id` varchar(255) NOT NULL DEFAULT '0' COMMENT 'skuid',
  `qty` int  DEFAULT '1' COMMENT 'item quantity', --[UPDATE ORIGN quantity]
  `status` int unsigned DEFAULT '0' COMMENT '0: not pay 1:paid 2:removed', 
  `remark` varchar(255) DEFAULT '' COMMENT 'remark',
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY (`sku_id`) REFERENCES `tp_good_sku`(`id`),
  FOREIGN KEY (`user_id`) REFERENCES `tp_user`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC COMMENT 'for each item in the cart will only have one record with status 0';


--
-- Table structure for table `tp_cate`
--
DROP TABLE IF EXISTS `tp_cate`;

CREATE TABLE `tp_cate` (
  -- `tw_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '', --[UPDATE ORIGN twName] --[REMOVE]
  -- `cn_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '', --[UPDATE ORIGN cnName] --[REMOVE]
  -- `rand` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  -- `sort` int unsigned DEFAULT '0', --[REMOVE]
  -- `status` int unsigned DEFAULT '0', --[REMOVE]
  `id` int unsigned NOT NULL AUTO_INCREMENT, --[UPDATE ORIGN cateId]
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'category name', --JSON FORMAT
  `parent_id` int DEFAULT '0' COMMENT 'parent  0: not parenet else: other category', --[UPDATE ORIGN pid]
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'category description in json format', --[UPDATE ORIGN cateDesc]
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '', --[UPDATE ORIGN cateImage]
  `is_del` int DEFAULT '0'COMMENT '0: available 1: not available', --[UPDATE ORIGN isdel]
  `crm_id` char(36) DEFAULT '' COMMENT 'crm id',
  `type` varchar(1) NOT NULL DEFAULT 'g' COMMENT 'item type g: good c: course', --[UPDATE ORIGN tagName]
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


--
-- Table structure for table `tp_coupon`
--

DROP TABLE IF EXISTS `tp_coupon`; --[UPDATE ORIGN yhCard]

CREATE TABLE `tp_coupon` (
  -- `tw_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[UPDATE ORIGN twName] --[REMOVE]
  -- `cn_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[UPDATE ORIGN cnName] --[REMOVE]
  -- `rand` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[REMOVE]
  -- `type` enum('coupon', 'voucher') DEFAULT 'coupon' COMMENT '类型。coupon【优惠券】voucher【代金券】', --[REMOVE]
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'coupon name in json format', -- JSON FORMAT
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `dedu_money` int DEFAULT '0' COMMENT 'deducted money', --[UPDATE ORIGN deduMoney]
  `req_amount` decimal(10, 2)  DEFAULT '0.00' COMMENT 'required amount for using this coupon', --[UPDATE ORIGN reqMoney]
  `beg_date` date DEFAULT NULL COMMENT 'coupon begin date', --[UPDATE ORIGN begDate]
  `end_date` date DEFAULT NULL COMMENT 'coupon end date', --[UPDATE ORIGN endDate] 
  `score` int DEFAULT '0' COMMENT 'redeem score for coupon',
  `stock` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'coupon stock', --[UPDATE ORIGN yhNum] --[REMOVE]
  `is_del` int DEFAULT '0' COMMENT '0: available 1: not available', --[UPDATE ORIGN isdel]
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, --[UPDATE ORIGN addDate] 
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC ;

--
-- Table structure for table `tp_user_coupon`
--
DROP TABLE IF EXISTS `tp_user_coupon`;
CREATE TABLE `tp_user_coupon` (
  -- `score` int DEFAULT '0', --[REMOVE]
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'coupon record id',
  `user_id` int DEFAULT NULL COMMENT 'user id', --[UPDATE ORIGN uid]
  `coupon_id` int DEFAULT NULL COMMENT 'coupon id', --[UPDATE ORIGN yhId]
  `used_date` timestamp NULL DEFAULT NULL COMMENT 'coupong used date', --[UPDATE ORIGN usedDate]
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'coupon add date', --[UPDATE ORIGN addDate]
  `status` int DEFAULT '0' COMMENT '0: not use 1: processing 2: used',
  `order_id` int NOT NULL COMMENT 'coupon used on order', --[UPDATE ORIGN orderId]
  CHECK(`status` IN (0, 1, 2)),
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY (`user_id`) REFERENCES `tp_user`(`id`),
  FOREIGN KEY (`coupon_id`) REFERENCES `tp_coupon`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC COMMENT 'record of user coupon';


--
-- Table structure for table `tp_favorite`
--
DROP TABLE IF EXISTS `tp_favourite`;

CREATE TABLE `tp_favourite` (
  `user_id` int NOT NULL COMMENT 'user id', --[UPDATE ORIGN uid]
  `good_id` int NOT NULL COMMENT 'good id', --[UPDATE ORIGN goodsId]
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'item add date', --[UPDATE ORIGN create_date]
  PRIMARY KEY (`user_id`,`good_id`) USING BTREE,
  FOREIGN KEY (`user_id`) REFERENCES `tp_user`(`id`),
  FOREIGN KEY (`good_id`) REFERENCES `tp_user`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


--
-- Table structure for table `tp_good`
-- [UPDATE ORIGN tp_goods]
DROP TABLE IF EXISTS `tp_good`;

CREATE TABLE `tp_good` (
  -- `tw_name` varchar(255) NOT NULL, --[UPDATE ORIGN twName] --[REMOVE]
  -- `cn_name` varchar(255) NOT NULL, --[UPDATE ORIGN cnName] --[REMOVE]
  -- `one_hour_stock` int DEFAULT '1', --[UPDATE ORIGN oneHourStock] --[REMOVE]
  -- `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci, --[REMOVE]
  -- `rand` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[REMOVE]
  -- `cndesc` text, --[REMOVE]
  -- `twdesc` text, --[REMOVE]
  -- `hour` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0', --[REMOVE]
  -- `model_data` text COMMENT '选项参数', --[UPDATE ORIGN modelData] --[REMOVE]
  -- `price` decimal(10, 2) DEFAULT NULL COMMENT 'good price', -- [REMOVE]
  -- `special_price` decimal(10, 2) DEFAULT NULL COMMENT 'special price for the good', --[UPDATE ORIGN student_price] --[REMOVE]
  -- `score` int DEFAULT '0', --[REMOVE]
  -- `end_date` date DEFAULT NULL, --[UPDATE ORIGN endDate] --[REMOVE]
  -- `is_composite_material` tinyint unsigned DEFAULT '0' COMMENT '是否复合商品', --[UPDATE ORIGN isCompositeMaterial] --[REMOVE]
  -- `is_show` int DEFAULT '1', --[UPDATE ORIGN isShow] --[REMOVE]
  -- `suitable_age` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'All ages', --[REMOVE≈]
  -- `status` tinyint(1) DEFAULT '1', --[REMOVE]
  -- `start_date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[UPDATE ORIGN startDate] --[REMOVE]
  -- `days` int DEFAULT NULL, --[REMOVE]
  -- `sign` enum('normal', 'course', 'voucher') DEFAULT 'normal' COMMENT '商品类型。normal【普通】course【课程】voucher【代金券】', --[REMOVE]
  -- `goods_cate` varchar(255) DEFAULT NULL, --[REMOVE]
  -- `student_type` tinyint NOT NULL DEFAULT '1' COMMENT '开放类型', --[REMOVE]
  -- `is_student` tinyint NOT NULL DEFAULT '0' COMMENT '1是0否', --[REMOVE]
  -- `goods_type` int DEFAULT '1' COMMENT '1商品, 2优惠服务, 3预约服务', --[UPDATE ORIGN goodType] --[REMOVE]


  `id` int NOT NULL AUTO_INCREMENT COMMENT 'good id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'good name in json format', --JSON FORMAT
  `place` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'good from',
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci, --[UPDATE ORGIN coverImg]
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'good created date', --[UPDATE ORIGN addDate]
  `update_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'good last update date', --[UPDATE ORIGN updateDate]
  `weight` int DEFAULT NULL COMMENT 'good weight (g)',
  `length` int unsigned DEFAULT '0' COMMENT 'good length',
  `width` int unsigned DEFAULT '0' COMMENT 'good width',
  `height` int unsigned DEFAULT '0' COMMENT 'good height',
  `cate_id` int unsigned DEFAULT NULL COMMENT 'good cate id', --[UPDATE ORIGN cateId]
  `stock` int DEFAULT '0' COMMENT 'good stocking',
  `is_del` int DEFAULT '1' COMMENT '0: available 1: not available', --[UPDATE ORIGN isdel]
  `low_stock_alert` int unsigned DEFAULT '0' COMMENT 'alert show in admin panel when the item qty reach the number',
  `desc` text COMMENT 'good description in json format',
  `is_recommended` tinyint unsigned DEFAULT '0' COMMENT 'good is recommend on the home page', --[UPDATE ORIGN isHomeRecommand]
  `sku_id` varchar(45) DEFAULT NULL COMMENT 'main good sku id',
  `is_new` tinyint NOT NULL DEFAULT '0' COMMENT 'is new item',
  `is_variation` varchar(100) NOT NULL DEFAULT 'false' COMMENT 'muti type item', --[UPDATE ORIGN isVariationPresent]
  `crm_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'crm good id',
  `odoo_product_code` varchar(45) DEFAULT NULL COMMENT 'odoo good id',
  `type` varchar(1) DEFAULT 'g' COMMENT 'item type g: good c: course',
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY (`cate_id`) REFERENCES `tp_cate`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

--
-- Table structure for table `tp_good_sku`
-- [UPDATE ORIGN tp_goods_sku]
DROP TABLE IF EXISTS `tp_good_sku`;

CREATE TABLE `tp_good_sku` (
  -- `sku_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '商品sku_id', --[REMOVE]
  -- `cn_sku_name` varchar(500) DEFAULT NULL, --[REMOVE]
  -- `en_sku_name` varchar(500) DEFAULT NULL, --[REMOVE]
  -- `cn_sku_spec_format` text, --[REMOVE]
  -- `en_sku_spec_format` text, --[REMOVE]
  -- `market_price` decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '划线价', --[REMOVE]
  -- `student_price` decimal(10, 2) DEFAULT '0.00', --[REMOVE]
  -- `member_price` text COMMENT '会员价，json格式，指定会员价，数据结构为：{"level_1":"10.00","level_2":"10.00"}', --[REMOVE]
  -- `cost_price` decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT 'sku成本价', --[REMOVE]
  `id` varchar(255) NOT NULL DEFAULT '' COMMENT 'extend sku id base on the good sku id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'sku name in json format', --JSON FORMAT
  `image` varchar(2000)  DEFAULT '' COMMENT 'sku good image',
  `good_id` int NOT NULL DEFAULT '0' COMMENT 'sku good id', --[UPDATE ORIGN goods_id]
  `spec_value` text COMMENT 'sku good spec value, splited with comma, the value only match tp_good_setting.value', --[UPDATE ORIGN spec_format]
  `price` decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT 'sku good price',
  `special_price` decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT 'discount price for the good',
  `stock` int NOT NULL DEFAULT '0' COMMENT 'sku good stock',
  `weight` decimal(10, 3) NOT NULL DEFAULT '0.000' COMMENT 'sku good weigh',
  `volume` decimal(10, 3) NOT NULL DEFAULT '0.000' COMMENT 'sku good volume',
  `sale_num` int NOT NULL DEFAULT '0' COMMENT 'number of item sold',
  `is_selected` tinyint NOT NULL DEFAULT '0' COMMENT 'is selected', --[UPDATE ORIGN is_default]
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY(`good_id`) REFERENCES `tp_good`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC COMMENT = '商品规格表';


--
-- Table structure for table `tp_good_spec`
-- [TODO ???][UPDATE ORIGN tp_goods_spec]
DROP TABLE IF EXISTS `tp_good_setting`;

CREATE TABLE `tp_good_setting` (
  -- `id` int NOT NULL AUTO_INCREMENT COMMENT '规格id', --[UPDATE ORIGN spec_id] --[REMOVE]
  `id` int NOT NULL AUTO_INCREMENT,
  `good_id` int NOT NULL DEFAULT '0' COMMENT '关联商品id', --[UPDATE ORIGN goods_id]
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'sku good setting column', --[UPDATE ORIGN spec_name]
  `value` text COMMENT 'sku good setting value store as array', --[UPDATE ORIGN spec_values] 
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY(good_id) REFERENCES `tp_good`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC COMMENT = '商品规格项/值表';

DROP TABLE IF EXISTS `tp_good_setting`;
CREATE TABLE `tp_good_setting` (
  `good_id` int NOT NULL DEFAULT '0' COMMENT '关联商品id', 
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'sku good setting column', 
  `value` text COMMENT 'sku good setting value store as array', 
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC COMMENT = '商品规格项/值表';


--
-- Table structure for table `tp_sf_area`
-- [UPDATE ORGIN tp_area]
DROP TABLE IF EXISTS `tp_sf_area`;

CREATE TABLE `tp_sf_area` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_del` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[ORGIN isdel]
  PRIMARY KEY(`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC COMMENT 'for delivery options';

--
-- Table structure for table `tp_sf_sub_area`
-- [UPDATE ORGIN tp_location]

DROP TABLE IF EXISTS `tp_sf_sub_area`;

CREATE TABLE `tp_sf_sub_area` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `area_id` int DEFAULT NULL, --[UPDATE ORIGN areaId]
  `is_del` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[UPDATE ORIGN isdel]
  PRIMARY KEY (`id`),
  FOREIGN KEY (`area_id`) REFERENCES `tp_sf_area`(`id`),

) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC COMMENT 'location for sf pickup';


--
-- Table structure for table `tp_locations`
--

DROP TABLE IF EXISTS `tp_sf_location`;

CREATE TABLE `tp_sf_location` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sub_id` int NOT NULL, --[UPDATE ORGIN cateId]
  `is_del` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[UPDATE ORIGN isdel]
  PRIMARY KEY (`id`),
  FOREIGN KEY (`sub_id`) REFERENCES `tp_sf_sub_area`(`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC COMMENT 'location for sf pickup';






--
-- Table structure for table `tp_order`
--


DROP TABLE IF EXISTS `tp_order`;

CREATE TABLE `tp_order` (
  -- `pay_status` int DEFAULT '0' COMMENT '0: not pay, 1: in progress, 2: paid',  --[UPDATE ORIGN payStatus] --[REMOVE]
  -- `other_payment_info` varchar(110) DEFAULT NULL COMMENT '其它支付方式备注', --[UPDATE ORIGN otherPayInfo] --[REMOVE]
  -- `orderUserData` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci, --[RMEOVE]
  -- `orderServerDay` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[RMEOVE]
  -- `orderServerHour` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[RMEOVE]
  -- `is_del` int DEFAULT '1', --[UPDATE ORIGN isdel] --[REMOVE]
  -- `tracking_no` varchar(64) DEFAULT '' COMMENT '物流单号', --[REMOVE]
  -- `logistics_co` varchar(255) DEFAULT '' COMMENT '物流公司', --[REMOVE]
  -- `refundDate` timestamp NULL DEFAULT NULL COMMENT '退款日期', --[REMOVE]
  -- `reference_no` varchar(64) DEFAULT '', --[REMOVE]
  -- `customer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci, --[REMOVE]
  -- `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[REMOVE]
  -- `area` varchar(255) DEFAULT '' COMMENT '区域', --[REMOVE]
  -- `location` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci, --[REMOVE]
  -- `locations` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci, --[REMOVE]
  -- `sign` enum('normal', 'course', 'voucher') DEFAULT 'normal' COMMENT '订单类型。normal【普通】course【课程】voucher【代金券】', --[REMOVE]
  -- `use_voucher_id` int unsigned DEFAULT '0' COMMENT '使用增值券ID', --[REMOVE]
  -- `use_voucher_num` decimal(10, 2) DEFAULT '0.00' COMMENT '使用增值券数量', --[REMOVE]
  -- `remain_voucher_num` decimal(10, 2) DEFAULT '0.00' COMMENT '剩余增值券数量', --[REMOVE]
  -- `address_id` int DEFAULT NULL, --[REMOVE]
  -- `score_earned` int DEFAULT '0', --[REMOVE
  -- `room` varchar(255) DEFAULT '', --[REMOVE]
  -- `building` varchar(255) DEFAULT '', --[REMOVE]
  -- `housing` varchar(255) DEFAULT '', --[REMOVE]
  -- `block` varchar(255) DEFAULT '', --[REMOVE]
  -- `floor` varchar(255) DEFAULT '', --[REMOVE]
  -- `street` varchar(255) DEFAULT NULL, --[REMOVE]
  -- `send_type` tinyint(1) DEFAULT '0' COMMENT '1【自取】2【上门】', --[UPDATE ORIGN sendType] --[REMOVE]
  -- `selfpick_up_branch_id` int DEFAULT NULL, --[REMOVE]
  -- `shipany_order_id` varchar(255) DEFAULT '' COMMENT 'Shipany Order ID', --[REMOVE]
  -- `shipany_order_status` varchar(100) DEFAULT '' COMMENT 'Shipany Order Status', --[REMOVE]
  -- `country` varchar(255) DEFAULT '中國香港特別行政區', --[REMOVE]
  -- `delivery_method` enum('delivery') DEFAULT NULL COMMENT '收货方式', --[REMOVE]
  -- `good_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[UPDATE ORIGN goodsId] --[REMOVE]
  -- `payment_email` varchar(110) DEFAULT '' COMMENT 'payment email return by paypal ', --[UPDATE ORING payAccount] --[REMOVE]

  `id` int NOT NULL AUTO_INCREMENT COMMENT 'order id',
  `user_id` int NOT NULL COMMENT 'order user id', --[UPDATE ORIGN uid]
  `out_trade_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'out trade no from paypal',
  `coupon_id` int DEFAULT NULL COMMENT 'coupon id, if coupon is used',
  `amount` decimal(11, 2)  NOT NULL COMMENT 'total amount of order', --[UPDATE ORIGN money]
  `dedu_amount` decimal(11, 2) COMMENT 'deducted amount of order', --[UPDATE ORIGN deduMoney]
  `paid_amount` decimal(11, 2) NOT NULL COMMENT 'amount paid of order', --[UPDATE ORIGN allMoney]
  `pay_date` timestamp NULL DEFAULT NULL COMMENT 'pay day', --[UPDATE ORIGN payDate]
  `qty` int DEFAULT NULL COMMENT 'order item quantity sum', --[UPDATE ORIGN quantity]
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'order created date', --[UPDATE ORIGN addDate]
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'order person',  --[UPDATE ORIGN dName]
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'contact number', --[UPDATE ORIGN dPhone]
  `email` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'contact email',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'contact address', 
  `paypal_link` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'paypal pay intent link', --[UPDATE ORIGN paypalLink]
  `crm_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'crm id',
  `cancel_date` timestamp NULL DEFAULT NULL COMMENT 'order cancel or refunded date depend on the status', --[UPDATE ORGIN cancelDate]
  `complete_date` timestamp NULL DEFAULT NULL COMMENT 'order complete on status complete', --[UPDATE ORIGN completeDate]
  `remark` varchar(255) DEFAULT '' COMMENT 'order remark',
  `ship_date` datetime DEFAULT NULL COMMENT 'order ship date of status when the status is shipping', --[UPDATE ORIGN shipDate]
  `odoo_flag` varchar(20) DEFAULT NULL COMMENT 'odoo tag',
  `odoo_order_code` varchar(45) DEFAULT NULL COMMENT 'odoo order id ',
  `source` enum('app', 'web') NOT NULL DEFAULT 'web' COMMENT 'order source', --[UPDATE ORIGN order_source]
  `status` enum(
    'paying',
    'unpaid',
    'paid',
    'pending',
    'packaging',
    'shipping',
    'complete',
    'cancelled',
    'refunded'
  ) DEFAULT 'unpaid' NOT NULL COMMENT 'order status',
  `type` enum( --[UPDATE ORIGN payType]
    'paypal',
    'other',
    'stripe',
    'cash',
    'bank',
    'alipay',
    'payme',
    'wechat'
  ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'paypal' COMMENT 'payment method',
  `send_type` enum( --[UPDATE ORGIN deliveryType]
    'selfpick-up',
    'sf-express',
    'delivery',
    'mtr',
    'foreign'
  ) DEFAULT 'sf-express' COMMENT 'order send type ',
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY (`user_id`) REFERENCES `tp_user`(`id`),
  FOREIGN KEY (`coupon_id`) REFERENCES `tp_coupon`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;



--
-- Table structure for table `tp_order_item`
--
DROP TABLE IF EXISTS `tp_order_item`;
CREATE TABLE `tp_order_item` (
  -- `modelDataInfo` varchar(2000) DEFAULT '', --[REMOVE]
  -- `sku_name` varchar(255) int NOT NULL DEFAULT '', --[REMOVE]
  -- `uid` DEFAULT NULL, --[REMOVE]
  -- `bookTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP, --[REMOVE]
  -- `id` int NOT NULL AUTO_INCREMENT COMMENT 'order item id', --[REMOVE]
  `order_id` int NOT NULL COMMENT 'order id', --[REMOVE]
  `good_id` int NOT NULL COMMENT 'main good id', --[UPDATE ORIGN goodsId]
  `sku_id` VARCHAR(255)NOT NULL COMMENT 'sku good id',
  `qty` int NOT NULL COMMENT 'order item quantity', --[UPDATE ORIGN number]
  `unit_price` decimal(11, 2) NOT NULL COMMENT 'order item unit price at the moment', --[UPDATE ORIGN price]
  `remark` varchar(255) DEFAULT '' COMMENT 'remark for order item, can store everything', 
  PRIMARY KEY (`order_id`, `sku_id`) USING BTREE,
  FOREIGN KEY (`order_id`) REFERENCES `tp_order`(`id`),
  FOREIGN KEY (`good_id`) REFERENCES `tp_good`(`id`),
  FOREIGN KEY (`sku_id`) REFERENCES `tp_good_sku`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


--
-- Table structure for table `tp_promote`
-- 

DROP TABLE IF EXISTS `tp_promote`;

CREATE TABLE `tp_promote` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) NOT NULL,
  `link_url` varchar(255) NOT NULL,
  `pic_urls` text,
  `is_del` int DEFAULT '1' COMMENT '0: 刪除 1:可用', --[UPDATE ORIGN isdel]

  -- FOR FUTURE
  -- `good_id int NOT NULL`
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;





--
-- Table structure for table `tp_score`
--
DROP TABLE IF EXISTS `tp_score`;

CREATE TABLE `tp_score` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL, --[UPDATE ORIGN uid]
  `score` int NOT NULL,
  `year` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY(user_id) REFERENCES `tp_user`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

--
-- Table structure for table `tp_score_log`
-- [NEW]
DROP TABLE IF EXISTS `tp_score_log`;

CREATE TABLE `tp_score_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `add_date` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP, --[UPDATE ORIGN addDate]
  `score` int NOT NULL,
  `spend_score` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY(user_id) REFERENCES `tp_user`(`id`)

) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


DROP TABLE IF EXISTS `tp_user`;

CREATE TABLE `tp_user` (
  -- `phoneArea` varchar(20) DEFAULT '852' COMMENT '号码区域', --[REMOVE]
  -- `rand` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[REMOVE]
  -- `isLogin` int DEFAULT '0', --[REMOVE]
  -- `is_svip` tinyint NOT NULL DEFAULT '0' COMMENT '是否超级会员0否1是', --[REMOVE]
  -- `dPhone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[REMOVE]
  -- `dName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[REMOVE]
  -- `udid` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '', --[REMOVE]
  -- `lang` int DEFAULT '1', -- [REMOVE]
  -- `score` int DEFAULT '0', --[REMOVE]
  -- `member_id` varchar(45) DEFAULT NULL, --[REMOVE]
  -- `parent` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '姓', --[REMOVE]
  -- `school` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci, --[REMOVE]
  -- `date` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci, --[REMOVE]
  -- `is_odoo_synchronized` int unsigned NOT NULL DEFAULT '0' COMMENT '是否odoo同步的会员', --[REMOVE]
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'user id',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'user email',
  `password` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'user password',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'user register date', --[UPDATE ORIGN regDate]
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'user name',
  `user_type` tinyint NOT NULL DEFAULT '1' COMMENT 'user type', --[OPTIONAL] --[UPDATE ORIGN type]
  `tel` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'user phone number',
  `sex` int DEFAULT NULL COMMENT 'user gender',
  `address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'user address', --[REMOVE]
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'user icon', --[OPTIONAL] --[UPDATE ORGIN headImg]
  `vip_level` int DEFAULT '0' COMMENT 'user vip level', --[UPDATE ORIGN vipLevel]
  `stripe_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'user stripe pay id', --[UPDATE ORIGN stripeUid]
  `platform` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'register platform (e.g web, android, ios etc.. maybe)',
  `platform_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'platform login key', --[UPDATE ORGIN platformLogin] 
  `is_del` int unsigned  DEFAULT '0' COMMENT 'is the user deleted', --[UPDATE ORIGN isdel]
  `invite_user_id` int NULL COMMENT 'invite by other users id',
  `crm_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'crm user id',
  `odoo_customer_code` varchar(45) DEFAULT NULL COMMENT 'odoo customer code',
  `is_odoo_sync` int unsigned NOT NULL DEFAULT '0' COMMENT 'is odoo sync-ed', --[UPDATE ORGIN is_synchronized_odoo]
  `odoo_id` int DEFAULT NULL COMMENT 'odoo user id',
  `is_verified` int NOT NULL DEFAULT '0' COMMENT 'is user verified by code', -- [UPDATE ORGIN isVerified]

  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY (`invite_user_id`) REFERENCES `tp_user`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


--
-- Table structure for table `tp_booking`
--

DROP TABLE IF EXISTS `tp_booking`;

CREATE TABLE `tp_booking` (
  -- `scheduleId` int DEFAULT NULL, --[REMOVE]
  -- `trade_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[REMOVE]
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'booking id',
  `user_id` int DEFAULT NULL COMMENT 'user id', --[UPDATE ORIGN uid]
  `first_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci, --[UPDATE ORIGN firstName]
  `booking_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'booked time',
  `creact_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'booking created time',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'booking contact number',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'booking contact email',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL  COMMENT 'booking description',
  `status` int DEFAULT NULL COMMENT 'booking status (e.g. 0: created 1:completed 2: cancelled)',
  `is_del` tinyint DEFAULT '0', --[UPDATE ORIGN isdel]
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY(user_id) REFERENCES `tp_user`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

--
-- Table structure for table `tp_yzm`
--

DROP TABLE IF EXISTS `tp_verifi`; --[UPDATE ORGIN tp_yzm]

CREATE TABLE `tp_verifi` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'verify id',
  `user_id` int  NOT NULL COMMENT 'user id', --[UPDATE ORIGN to_user]
  `send_time` timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT 'code send time',
  `code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY(`user_id`) REFERENCES `tp_user`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 ROW_FORMAT = COMPACT;
--
-- Table structure for table `tp_system`
-- 

DROP TABLE IF EXISTS `tp_system`;

CREATE TABLE `tp_system` (
  `id` int unsigned NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'name of type',
  `group` enum('base') NOT NULL DEFAULT 'base',
  `value` text COMMENT 'value of type'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC COMMENT 'system info eg. invoice header, address etc...';


--
-- table structure for table `tp_user_level`
-- [new]

DROP TABLE IF EXISTS `tp_user_level`;
CREATE TABLE `tp_user_level` (
  -- `tw_name` varchar(255) NOT NULL DEFAULT '' COMMENT '繁会员名称', --[remove]
  -- `cn_name` varchar(255) NOT NULL DEFAULT '' COMMENT '中会员名称', --[remove]
  `id` int not null auto_increment COMMENT 'level id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'level name in json format',
  `exp_num` int NOT NULL DEFAULT '0' COMMENT 'required score',
  `is_show` tinyint NOT NULL DEFAULT '0' COMMENT '是否显示 1=显示,0=隐藏',
  `grade` int NOT NULL DEFAULT '0' COMMENT '会员等级',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '会员卡背景',
  `color` varchar(32) NOT NULL DEFAULT '' COMMENT ' 字体颜色',
  `icon` varchar(255) NOT NULL DEFAULT '' COMMENT '会员图标',
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `is_del` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除.1=删除,0=未删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=innodb AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='设置用户等级表';


--
-- Table structure for table `tp_common_info`
-- 
DROP TABLE IF EXISTS `tp_common_info`;

CREATE TABLE `tp_common_info` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '名称',
  `type` varchar(100) NOT NULL DEFAULT '1' COMMENT '类型',
  `is_del` tinyint NOT NULL DEFAULT '1' COMMENT '是否已删除0删除1可用', --[UPDATE ORIGN isdel]
  `create_time` int DEFAULT NULL,
  `update_time` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 ROW_FORMAT = DYNAMIC COMMENT = '公共配置表，针对只有name的情况';

DROP TABLE IF EXISTS `tp_pcset`;
CREATE TABLE `tp_pcset` (
  -- `navTitle` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci, --[REMOVE]
  -- `rand` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[REMOVE]
  -- `address2` varchar(255) DEFAULT '', --[REMOVE]
  -- `address3` varchar(255) DEFAULT '', --[REMOVE]
  -- `twaboutHtml` text, --[REMOVE]
  -- `cnaboutHtml` text, --[REMOVE]
  -- `companyName2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[REMOVE]
  -- `lang` enum('en') NOT NULL, --[REMOVE]
  -- `workDateValue` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  -- `work_time_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '', --[REMOVE]
  `id` int NOT NULL AUTO_INCREMENT,
  `whatsapp` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `work_time` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `work_date` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[UPDATE ORIGN workDate]
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `phone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `company_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, --[UPDATE ORIGN companyName1] 
  `fackbook` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `instagram` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `fax` varchar(110) DEFAULT NULL,
  `email` varchar(110) DEFAULT NULL,
  `about` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `alipay_qrcode_url` varchar(255) DEFAULT NULL,
  `payme_qrcode_url` varchar(255) DEFAULT NULL,
  `google_map` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;



DROP TABLE IF EXISTS `tp_user_address`;

CREATE TABLE `tp_user_address` (
  -- `customer` varchar(64) NOT NULL, 
  -- `delivery` enum('delivery') DEFAULT 'delivery', 
  -- `selfpick_up_branch_id` int DEFAULT NULL, 
  `phone_cn` varchar(255) DEFAULT NULL, 
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'user address id',
  `user_id` int NOT NULL COMMENT 'reference to user id', 
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'address created time', 
  `phone` varchar(8) DEFAULT NULL COMMENT 'contact number', 
  `address` varchar(255) DEFAULT NULL COMMENT 'user address',
  `is_del` int DEFAULT '0' COMMENT 'the adress is deleted', 
  `email` varchar(110) DEFAULT NULL COMMENT 'user email',
  `is_default` tinyint unsigned DEFAULT '0' COMMENT 'is address user default',
  `delivery_type` enum( 
    'selfpick-up',
    'sf-express',
    'direct',
    'mtr',
    'foreign'
  ) DEFAULT 'sf-express' COMMENT '运送方式。selfpick-up【客人到取】, sf-express【順豐快遞（智能自取櫃 + 送貨上門）】, direct【公司直送】, metro【地鐵交收】, foreign【海外寄貨】',
  `send_type` tinyint DEFAULT '0' COMMENT '1【自取】2【上门】', 
  `area_id` int DEFAULT NULL COMMENT '区域', 
  `sub_id` int DEFAULT NULL COMMENT 'reference tp_sf_sub', 
  `location_id` int DEFAULT NULL COMMENT 'sf localtion id', 
  `room` varchar(255) DEFAULT NULL,
  `building` varchar(255) DEFAULT NULL,
  `housing` varchar(255) DEFAULT NULL,
  `block` varchar(255) DEFAULT NULL,
  `floor` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL COMMENT 'user country',
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY (`user_id`) REFERENCES `tp_user`(`id`),
  FOREIGN KEY(`area_id`) REFERENCES `tp_sf_area`(`id`),
  FOREIGN KEY(sub_id) REFERENCES `tp_sf_sub_area`(`id`),
  FOREIGN KEY(location_id) REFERENCES `tp_sf_location`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


