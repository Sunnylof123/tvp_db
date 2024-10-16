DROP TABLE IF EXISTS `tp_admin`;
CREATE TABLE `tp_admin` (
 `id` int NOT NULL AUTO_INCREMENT ,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `password` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `add_date` datetime DEFAULT NULL, 
  `is_del` int unsigned  DEFAULT '0', 
  `is_super` tinyint unsigned DEFAULT '0' COMMENT 'allow delete or not',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC COMMENT 'this table is seperate from the user table';

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
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `is_del` int DEFAULT '1', 
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS `tp_cate`;
CREATE TABLE `tp_cate` (
  `id` int unsigned NOT NULL AUTO_INCREMENT, 
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'category name', 
  `parent_id` int DEFAULT '0' COMMENT 'parent  0: not parenet else: other category', 
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'category description in json format', 
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '', 
  `is_del` int DEFAULT '0'COMMENT '0: available 1: not available', 
  `crm_id` char(36) DEFAULT '' COMMENT 'crm id',
  `type` varchar(1) NOT NULL DEFAULT 'g' COMMENT 'item type g: good c: course', 
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS `tp_coupon`; 
CREATE TABLE `tp_coupon` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'coupon name in json format', 
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `dedu_money` int DEFAULT '0' COMMENT 'deducted money', 
  `req_amount` decimal(10, 2)  DEFAULT '0.00' COMMENT 'required amount for using this coupon', 
  `beg_date` date DEFAULT NULL COMMENT 'coupon begin date', 
  `end_date` date DEFAULT NULL COMMENT 'coupon end date', 
  `score` int DEFAULT '0' COMMENT 'redeem score for coupon',
  `stock` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'coupon stock', 
  `is_del` int DEFAULT '0' COMMENT '0: available 1: not available', 
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC ;

DROP TABLE IF EXISTS `tp_user_coupon`;
CREATE TABLE `tp_user_coupon` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'coupon record id',
  `user_id` int DEFAULT NULL COMMENT 'user id', 
  `coupon_id` int DEFAULT NULL COMMENT 'coupon id', 
  `used_date` timestamp NULL DEFAULT NULL COMMENT 'coupong used date', 
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'coupon add date', 
  `status` int DEFAULT '0' COMMENT '0: not use 1: processing 2: used',
  `order_id` int NOT NULL COMMENT 'coupon used on order', 
  CHECK(`status` IN (0, 1, 2)),
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY (`user_id`) REFERENCES `tp_user`(`id`),
  FOREIGN KEY (`coupon_id`) REFERENCES `tp_coupon`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC COMMENT 'record of user coupon';

DROP TABLE IF EXISTS `tp_good`;
CREATE TABLE `tp_good` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'good id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'good name in json format', 
  `place` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'good from',
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci, 
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'good created date', 
  `update_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'good last update date', 
  `weight` int DEFAULT NULL COMMENT 'good weight (g)',
  `length` int unsigned DEFAULT '0' COMMENT 'good length',
  `width` int unsigned DEFAULT '0' COMMENT 'good width',
  `height` int unsigned DEFAULT '0' COMMENT 'good height',
  `cate_id` int unsigned DEFAULT NULL COMMENT 'good cate id', 
  `stock` int DEFAULT '0' COMMENT 'good stocking',
  `is_del` int DEFAULT '1' COMMENT '0: available 1: not available', 
  `low_stock_alert` int unsigned DEFAULT '0' COMMENT 'alert show in admin panel when the item qty reach the number',
  `desc` text COMMENT 'good description in json format',
  `is_recommended` tinyint unsigned DEFAULT '0' COMMENT 'good is recommend on the home page', 
  `sku_id` varchar(45) DEFAULT NULL COMMENT 'main good sku id',
  `is_new` tinyint NOT NULL DEFAULT '0' COMMENT 'is new item',
  `is_variation` varchar(100) NOT NULL DEFAULT 'false' COMMENT 'muti type item', 
  `crm_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'crm good id',
  `odoo_product_code` varchar(45) DEFAULT NULL COMMENT 'odoo good id',
  `type` varchar(1) DEFAULT 'g' COMMENT 'item type g: good c: course',
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY (`cate_id`) REFERENCES `tp_cate`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS `tp_good_sku`;
CREATE TABLE `tp_good_sku` (
  `id` varchar(255) NOT NULL DEFAULT '' COMMENT 'extend sku id base on the good sku id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'sku name in json format', 
  `image` varchar(2000)  DEFAULT '' COMMENT 'sku good image',
  `good_id` int NOT NULL DEFAULT '0' COMMENT 'sku good id', 
  `spec_value` text COMMENT 'sku good spec value, splited with comma, the value only match tp_good_setting.value', 
  `price` decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT 'sku good price',
  `special_price` decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT 'discount price for the good',
  `stock` int NOT NULL DEFAULT '0' COMMENT 'sku good stock',
  `weight` decimal(10, 3) NOT NULL DEFAULT '0.000' COMMENT 'sku good weigh',
  `volume` decimal(10, 3) NOT NULL DEFAULT '0.000' COMMENT 'sku good volume',
  `sale_num` int NOT NULL DEFAULT '0' COMMENT 'number of item sold',
  `is_selected` tinyint NOT NULL DEFAULT '0' COMMENT 'is selected', 
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY(`good_id`) REFERENCES `tp_good`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC COMMENT = 'good setting';

DROP TABLE IF EXISTS `tp_good_setting`;
CREATE TABLE `tp_good_setting` (
  `id` int NOT NULL AUTO_INCREMENT,
  `good_id` int NOT NULL DEFAULT '0' COMMENT 'good id', 
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'sku good setting column', 
  `value` text COMMENT 'sku good setting value store as array', 
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY(good_id) REFERENCES `tp_good`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC COMMENT = 'setting for good';

DROP TABLE IF EXISTS `tp_sf_area`;
CREATE TABLE `tp_sf_area` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_del` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, 
  PRIMARY KEY(`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC COMMENT 'for delivery options';

DROP TABLE IF EXISTS `tp_sf_sub_area`;
CREATE TABLE `tp_sf_sub_area` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `area_id` int DEFAULT NULL, 
  `is_del` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, 
  PRIMARY KEY (`id`),
  FOREIGN KEY (`area_id`) REFERENCES `tp_sf_area`(`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC COMMENT 'location for sf pickup';

DROP TABLE IF EXISTS `tp_sf_location`;
CREATE TABLE `tp_sf_location` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sub_id` int NOT NULL,
  `is_del` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, 
  PRIMARY KEY (`id`),
  FOREIGN KEY (`sub_id`) REFERENCES `tp_sf_sub_area`(`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC COMMENT 'location for sf pickup';

DROP TABLE IF EXISTS `tp_order`;
CREATE TABLE `tp_order` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'order id',
  `user_id` int NOT NULL COMMENT 'order user id', 
  `out_trade_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'out trade no from paypal',
  `coupon_id` int DEFAULT NULL COMMENT 'coupon id, if coupon is used',
  `amount` decimal(11, 2)  NOT NULL COMMENT 'total amount of order', 
  `dedu_amount` decimal(11, 2) COMMENT 'deducted amount of order', 
  `paid_amount` decimal(11, 2) NOT NULL COMMENT 'amount paid of order', 
  `pay_date` timestamp NULL DEFAULT NULL COMMENT 'pay day', 
  `qty` int DEFAULT NULL COMMENT 'order item quantity sum', 
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'order created date', 
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'order person',  
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'contact number', 
  `email` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'contact email',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'contact address', 
  `paypal_link` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'paypal pay intent link', 
  `crm_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'crm id',
  `cancel_date` timestamp NULL DEFAULT NULL COMMENT 'order cancel or refunded date depend on the status', 
  `complete_date` timestamp NULL DEFAULT NULL COMMENT 'order complete on status complete', 
  `remark` varchar(255) DEFAULT '' COMMENT 'order remark',
  `ship_date` datetime DEFAULT NULL COMMENT 'order ship date of status when the status is shipping', 
  `odoo_flag` varchar(20) DEFAULT NULL COMMENT 'odoo tag',
  `odoo_order_code` varchar(45) DEFAULT NULL COMMENT 'odoo order id ',
  `source` enum('app', 'web') NOT NULL DEFAULT 'web' COMMENT 'order source', 
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
  `type` enum( 
    'paypal',
    'other',
    'stripe',
    'cash',
    'bank',
    'alipay',
    'payme',
    'wechat'
  ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'paypal' COMMENT 'payment method',
  `send_type` enum( 
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

DROP TABLE IF EXISTS `tp_order_item`;
CREATE TABLE `tp_order_item` (
  `order_id` int NOT NULL COMMENT 'order id', 
  `good_id` int NOT NULL COMMENT 'main good id', 
  `sku_id` VARCHAR(255)NOT NULL COMMENT 'sku good id',
  `qty` int NOT NULL COMMENT 'order item quantity', 
  `unit_price` decimal(11, 2) NOT NULL COMMENT 'order item unit price at the moment', 
  `remark` varchar(255) DEFAULT '' COMMENT 'remark for order item, can store everything', 
  PRIMARY KEY (`order_id`, `sku_id`) USING BTREE,
  FOREIGN KEY (`order_id`) REFERENCES `tp_order`(`id`),
  FOREIGN KEY (`good_id`) REFERENCES `tp_good`(`id`),
  FOREIGN KEY (`sku_id`) REFERENCES `tp_good_sku`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS `tp_promote`;
CREATE TABLE `tp_promote` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) NOT NULL,
  `link_url` varchar(255) NOT NULL,
  `pic_urls` text,
  `is_del` int DEFAULT '1' COMMENT '0: 刪除 1:可用', 
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS `tp_score`;
CREATE TABLE `tp_score` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL, 
  `score` int NOT NULL,
  `year` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY(user_id) REFERENCES `tp_user`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS `tp_score_log`;
CREATE TABLE `tp_score_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `add_date` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP, 
  `score` int NOT NULL,
  `spend_score` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY(user_id) REFERENCES `tp_user`(`id`)

) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


DROP TABLE IF EXISTS `tp_user`;
CREATE TABLE `tp_user` (
  `id` int NOT  NULL AUTO_INCREMENT COMMENT 'user id',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'user email',
  `password` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'user password',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'user register date', 
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'user name',
  `user_type` tinyint NOT NULL DEFAULT '1' COMMENT 'user type', 
  `tel` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'user phone number',
  `sex` int DEFAULT NULL COMMENT 'user gender',
  `address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'user address', 
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'user icon', 
  `vip_level` int DEFAULT '0' COMMENT 'user vip level', 
  `stripe_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'user stripe pay id', 
  `platform` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'register platform (e.g web, android, ios etc.. maybe)',
  `platform_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'platform login key', 
  `is_del` int unsigned  DEFAULT '0' COMMENT 'is the user deleted', 
  `invite_user_id` int NULL  COMMENT 'invite by other users id',
  `crm_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'crm user id',
  `odoo_customer_code` varchar(45) DEFAULT NULL COMMENT 'odoo customer code',
  `is_odoo_sync` int unsigned NOT NULL DEFAULT '0' COMMENT 'is odoo sync-ed', 
  `odoo_id` int DEFAULT NULL COMMENT 'odoo user id',
  `is_verified` int NOT NULL DEFAULT '0' COMMENT 'is user verified by code', 
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY (`invite_user_id`) REFERENCES `tp_user`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS `tp_booking`;
CREATE TABLE `tp_booking` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'booking id',
  `user_id` int DEFAULT NULL COMMENT 'user id', 
  `first_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci, 
  `booking_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'booked time',
  `creact_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'booking created time',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'booking contact number',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'booking contact email',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL  COMMENT 'booking description',
  `status` int DEFAULT NULL COMMENT 'booking status (e.g. 0: created 1:completed 2: cancelled)',
  `is_del` tinyint DEFAULT '0', 
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY(user_id) REFERENCES `tp_user`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS `tp_verifi`; 
CREATE TABLE `tp_verifi` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'verify id',
  `user_id` int  NOT NULL COMMENT 'user id', 
  `send_time` timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT 'code send time',
  `code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY(`user_id`) REFERENCES `tp_user`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS `tp_system`;
CREATE TABLE `tp_system` (
  `id` int unsigned NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'name of type',
  `group` enum('base') NOT NULL DEFAULT 'base',
  `value` text COMMENT 'value of type'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC COMMENT 'system info eg. invoice header, address etc...';

DROP TABLE IF EXISTS `tp_user_level`;
CREATE TABLE `tp_user_level` (
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

DROP TABLE IF EXISTS `tp_common_info`;
CREATE TABLE `tp_common_info` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '名称',
  `type` varchar(100) NOT NULL DEFAULT '1' COMMENT '类型',
  `is_del` tinyint NOT NULL DEFAULT '1' COMMENT '是否已删除0删除1可用', 
  `create_time` int DEFAULT NULL,
  `update_time` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 ROW_FORMAT = DYNAMIC COMMENT = '公共配置表，针对只有name的情况';

DROP TABLE IF EXISTS `tp_pcset`;
CREATE TABLE `tp_pcset` (
  `id` int NOT NULL AUTO_INCREMENT,
  `whatsapp` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `work_time` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `work_time_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `workDate` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `workDateValue` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `address` text ,
  `phone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `company_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL, 
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


DROP TABLE IF EXISTS `tp_cart`;
CREATE TABLE `tp_cart` (
  `id` int NOT NULL AUTO_INCREMENT , 
  `user_id` int NOT NULL COMMENT 'user id', 
  `sku_id` varchar(255) NOT NULL DEFAULT '0' COMMENT 'skuid',
  `qty` int  DEFAULT '1' COMMENT 'item quantity', 
  `status` int unsigned DEFAULT '0' COMMENT '0: not pay 1:paid 2:removed', 
  `remark` varchar(255) DEFAULT '' COMMENT 'remark',
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY (`sku_id`) REFERENCES `tp_good_sku`(`id`),
  FOREIGN KEY (`user_id`) REFERENCES `tp_user`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC COMMENT 'for each item in the cart will only have one record with status 0';

DROP TABLE IF EXISTS `tp_favourite`;
CREATE TABLE `tp_favourite` (
  `user_id` int NOT NULL COMMENT 'user id', 
  `good_id` int NOT NULL COMMENT 'good id', 
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'item add date', 
  PRIMARY KEY (`user_id`,`good_id`) USING BTREE,
  FOREIGN KEY (`user_id`) REFERENCES `tp_user`(`id`),
  FOREIGN KEY (`good_id`) REFERENCES `tp_user`(`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;


