Table structure for table `tp_course`
-- [TODO ???]
DROP TABLE IF EXISTS `tp_course`;

CREATE TABLE `tp_course` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, --[UPDATE ORIGN addDate]
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tw_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '', --[UPDATE ORIGN twName]
  `cn_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '', --[UPDATE ORIGN cnName]
  `branch_id` int DEFAULT NULL, --[UPDATE ORIGN branchId]
  `price` decimal(10, 2) unsigned DEFAULT '0.00',
  `people_num` smallint unsigned DEFAULT '0', --[UPDATE ORIGN peopleNum]
  `date_list` varchar(255) DEFAULT '' COMMENT '日期（多选）', --[UPDATE ORIGN dateList]
  `time_range` varchar(255) DEFAULT '' COMMENT '时间范围', --[UPDATE ORIGN timeRange]
  `long` smallint DEFAULT NULL COMMENT '时长（单位分）',
  `end_date` date DEFAULT NULL COMMENT '截止期限', --[UPDATE ORIGN endDate]
  `instructor_uid` int unsigned DEFAULT '0' COMMENT '教练', --[UPDATE ORIGN instructorUid]
  `pic_list` text, --[UPDATE ORIGN picList]
  `description` text,
  `terms` text,
  `update_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP, --[UPDATE ORIGN updateDate]
  `status` tinyint unsigned DEFAULT '0' COMMENT '是否上架',
  `good_id` int unsigned DEFAULT '0' COMMENT '关联的商品ID', --[UPDATE ORIGN goodsId]
  `is_del` int DEFAULT '1', --[UPDATE ORIGN isdel]
  `course_no` varchar(45) DEFAULT NULL,
  `cateId` int DEFAULT NULL,
  `place` varchar(255) DEFAULT '' COMMENT '地址',
  `address` varchar(255) DEFAULT '' COMMENT '详细地址',
  `vip_price` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */
;


Table structure for table `tp_class`
-- [REMOVE]
DROP TABLE IF EXISTS `tp_class`;

CREATE TABLE `tp_class` (
  `classId` int NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` int DEFAULT '0',
  `level` int DEFAULT NULL,
  `rand` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sort` int DEFAULT NULL,
  `classDesc` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `classImage` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_del` int DEFAULT '1' --[UPDATE ORIGN isdel]
) ENGINE = MyISAM DEFAULT CHARSET = utf8mb3 COLLATE = utf8_unicode_ci ROW_FORMAT = DYNAMIC;
;

Table structure for table `tp_cartlistpay`
--[REMOVE]

DROP TABLE IF EXISTS `tp_cartlistpay`;

CREATE TABLE `tp_cartlistpay` (
  `id` int NOT NULL,
  `uid` int DEFAULT NULL,
  `good_id` int DEFAULT NULL, --[UPDATE ORIGN goodsId]
  `totalamt` int DEFAULT NULL,
  `price` int DEFAULT NULL,
  `quantity` int DEFAULT '0',
  `out_trade_no` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `payStatus` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `goodsType` int DEFAULT NULL,
  `booktime` text CHARACTER SET utf8 COLLATE utf8_unicode_ci
) ENGINE = MyISAM DEFAULT CHARSET = utf8mb3 COLLATE = utf8_unicode_ci ROW_FORMAT = DYNAMIC;
;

Table structure for table `tp_branch`
-- [REMOVE]

DROP TABLE IF EXISTS `tp_branch`;

CREATE TABLE `tp_branch` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, --[UPDATE ORIGN addDate]
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, --[UPDATE ORIGN updateDate]
  `contact` varchar(64) DEFAULT '',
  `business_time` varchar(30) DEFAULT '', --[UPDATE ORIGN buinessTime]
  `is_del` int DEFAULT '1' COMMENT '0: 刪除 1:可用', --[UPDATE ORIGN isdel]
  `tw_name` varchar(255) DEFAULT NULL, --[UPDATE ORIGN twName]
  `cn_name` varchar(255) DEFAULT NULL, --[UPDATE ORIGN cnName]
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;
;
Dumping data for table `tp_branch`
LOCK TABLES `tp_branch` WRITE;
UNLOCK TABLES;


Table structure for table `tp_admin_group`
-- [REMOVE]
DROP TABLE IF EXISTS `tp_admin_group`;

CREATE TABLE `tp_admin_group` (
  `id` int unsigned NOT NULL,
  `name` varchar(110) NOT NULL,
  `access` text,
  `power` int unsigned DEFAULT '0',
  `addDate` datetime DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */
;


--
-- Table structure for table `tp_course_booking`
--[REMOVE]

DROP TABLE IF EXISTS `tp_course_booking`;

CREATE TABLE `tp_course_booking` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `uid` int NOT NULL,
  `courseId` int NOT NULL,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, --[UPDATE ORIGN addDate]
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `order_id` int DEFAULT NULL, 
  `is_del` int DEFAULT '1', --[UPDATE ORIGN isdel]
  `status` tinyint unsigned DEFAULT '0' COMMENT '状态：0【未支付】，1【已支付】',
  `datetime` varchar(255) DEFAULT NULL,
  `date_list` varchar(1000) DEFAULT NULL, --[UPDATE ORIGN dateList]
  PRIMARY KEY (`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

--
-- Table structure for table `tp_good_composite`
-- [REMOVE][UPDATE ORIGN tp_goods_composite]
DROP TABLE IF EXISTS `tp_good_composite`;

CREATE TABLE `tp_good_composite` (
  `id` int NOT NULL AUTO_INCREMENT,
  `good_id` int NOT NULL, --[UPDATE ORIGN goodsId]
  `compositeGoodsName` varchar(255) NOT NULL,
  `compositeGoodsId` int NOT NULL COMMENT '组合商品ID',
  `rate` int NOT NULL COMMENT '比例%',
  `is_del` int DEFAULT '1' COMMENT '0: 刪除 1:可用', --[UPDATE ORIGN isdel]
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

--
-- Table structure for table `tp_homebanner`
-- [REMOVE]
DROP TABLE IF EXISTS `tp_homebanner`;

CREATE TABLE `tp_homebanner` (
  `id` int NOT NULL,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_icelandic_ci DEFAULT NULL,
  `subtitle` varchar(255) CHARACTER SET utf8 COLLATE utf8_icelandic_ci NOT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_icelandic_ci NOT NULL,
  `image` varchar(200) DEFAULT NULL,
  `is_del` int DEFAULT '1' --[UPDATE ORIGN isdel]
) ENGINE = MyISAM DEFAULT CHARSET = latin1 ROW_FORMAT = DYNAMIC;

--
-- Table structure for table `tp_html`
-- [REMOVE]
DROP TABLE IF EXISTS `tp_html`;

CREATE TABLE `tp_html` (
  `id` int NOT NULL,
  `navTitle` varchar(50) DEFAULT NULL,
  `content` text
) ENGINE = MyISAM DEFAULT CHARSET = utf8mb3 ROW_FORMAT = DYNAMIC;



--
-- Table structure for table `tp_model`
-- [REMOVE]

DROP TABLE IF EXISTS `tp_model`;

CREATE TABLE `tp_model` (
  `id` int NOT NULL,
  `modelName` varchar(255) NOT NULL,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, --[UPDATE ORIGN addDate]
  `is_del` int DEFAULT '1' COMMENT '0: 刪除 1:可用' --[UPDATE ORIGN isdel]
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;



--
-- Table structure for table `tp_model_option`
-- [REMOVE]

DROP TABLE IF EXISTS `tp_model_option`;

CREATE TABLE `tp_model_option` (
  `id` int NOT NULL,
  `modelId` int NOT NULL,
  `optionName` varchar(255) NOT NULL,
  `is_del` int DEFAULT '1' COMMENT '0: 刪除 1:可用' --[UPDATE ORIGN isdel]
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;


--
-- Table structure for table `tp_course_cate`
-- [REMOVE]
DROP TABLE IF EXISTS `tp_course_cate`;

CREATE TABLE `tp_course_cate` (
  `cateId` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tw_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '', --[UPDATE ORIGN twName]
  `cn_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '', --[UPDATE ORIGN cnName]
  `parent_id` int DEFAULT '0' COMMENT 'parent cate_id only for muti spec item i guess',
  `rand` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '', --[REMOVE]
  `sort` int unsigned DEFAULT '0',
  `cate_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci, --[UPDATE ORIGN cateDesc]
  `cate_image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '', --[UPDATE ORIGN cateImage]
  `is_del` int DEFAULT '1', --[UPDATE ORIGN isdel]
  `status` int unsigned DEFAULT '0',
  `crm_id` char(36) DEFAULT '' COMMENT '对应CRM ID',
  PRIMARY KEY (`cateId`) USING BTREE
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;


--
-- Table structure for table `tp_voucher_log`
-- [REMOVE]
DROP TABLE IF EXISTS `tp_voucher_log`;

CREATE TABLE `tp_voucher_log` ( 
  `id` int NOT NULL,
  `uid` int NOT NULL,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, --[UPDATE ORIGN addDate]
  `yhId` int DEFAULT NULL COMMENT '通过后台添加的这里的值是0',
  `orderId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '通过后台添加的这里的值是0',
  `total_value` decimal(10, 2) DEFAULT NULL COMMENT '增值券总额度',
  `value_num` decimal(10, 2) DEFAULT '0.00' COMMENT '剩余增值券额度',
  `odoo_uid` int DEFAULT NULL COMMENT 'odoo会员id',
  `is_odoo_synchronized` int unsigned NOT NULL DEFAULT '0' COMMENT '是否odoo同步的会员',
  `is_synchronized_odoo` int unsigned NOT NULL DEFAULT '0' COMMENT '是否已经同步到odoo,0没有1有'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

--
-- Table structure for table `tp_msg`
-- [REMOVE]

DROP TABLE IF EXISTS `tp_msg`;

CREATE TABLE `tp_msg` (
  `id` int NOT NULL,
  `title` varchar(100) DEFAULT '',
  `content` varchar(255) DEFAULT '',
  `add_date` datetime DEFAULT NULL, --[UPDATE ORIGN addDate]
  `uid` int DEFAULT NULL,
  `isRead` int DEFAULT '0',
  `fromUid` int DEFAULT '0'
) ENGINE = MyISAM DEFAULT CHARSET = utf8mb3 ROW_FORMAT = DYNAMIC;


--
-- Table structure for table `tp_orderitem`
-- [REMOVE]

DROP TABLE IF EXISTS `tp_orderitem`;

CREATE TABLE `tp_orderitem` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderId` int DEFAULT NULL,
  `good_id` int DEFAULT NULL, --[UPDATE ORIGN goodsId]
  `number` int DEFAULT NULL,
  `price` float(11, 2) DEFAULT NULL,
  `uid` int DEFAULT NULL,
  `bookTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM DEFAULT CHARSET = utf8mb3 ROW_FORMAT = FIXED;

LOCK TABLES `tp_orderitem` WRITE;
/*!40000 ALTER TABLE `tp_orderitem` DISABLE KEYS */
;
/*!40000 ALTER TABLE `tp_orderitem` ENABLE KEYS */
;
UNLOCK TABLES;

--
-- Dumping data for table `tp_orderitem`
--

--
-- Table structure for table `tp_pageset`
--[REMOVE]

DROP TABLE IF EXISTS `tp_pageset`;

CREATE TABLE `tp_pageset` (
  `id` int unsigned NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_icelandic_ci NOT NULL,
  `group` enum(
    'home',
    'app',
    'page',
    'courses',
    'products',
    'member',
    'aboutus'
  ) NOT NULL,
  `subtitle` varchar(255) CHARACTER SET utf8 COLLATE utf8_icelandic_ci NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_icelandic_ci NOT NULL,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, --[UPDATE ORIGN addDate]
  `image` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `videoUrl` varchar(255) DEFAULT '',
  `is_del` int DEFAULT '1' --[UPDATE ORIGN isdel]
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

--
-- Table structure for table `tp_wenda`
--[REMOVE]

DROP TABLE IF EXISTS `tp_wenda`;

CREATE TABLE `tp_wenda` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `answer` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lang` int NOT NULL,
  `is_del` int NOT NULL DEFAULT '1', --[UPDATE ORIGN isdel]
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM  DEFAULT CHARSET = latin1 ROW_FORMAT = DYNAMIC;


--
-- Dumping data for table `tp_wenda`
--

LOCK TABLES `tp_wenda` WRITE;
/*!40000 ALTER TABLE `tp_wenda` DISABLE KEYS */
;
INSERT INTO `tp_wenda`
VALUES (8, 'QuesC', 'AnsC', 1, 0),
(
    2,
    'InSmile 的美齒功效能維持多久？',
    '美齒功效能維持的時間，確實因人而異；一些生活習慣例如吸煙、喝咖啡、紅酒等等，很可能縮短美白效果的時間；因此，每次美齒體驗後，InSmile 的美容顧問會因應不同顧客，提出幫助顧客保養更得宜的意見*！',
    1,
    1
  ),
(
    3,
    '敏感牙齒能否進行InSmile的療程？又會否傷害牙齒健康？',
    'InSmile 的美齒療程除了採用遵從歐盟 2011/84/EU 指令的美白因子，更是一種溫和安全的配方，溫和地穿透琺瑯質與象牙質的微小管道，與色素份子結合、產生反應，從以達至美白效果，溫和而對牙齒無傷害。因此，敏感牙齒同樣適合進行 InSmile 的療程。',
    1,
    1
  ),
(
    4,
    '除了多種認證，InSmile所採用的美白技術有何特別？',
    'InSmile 的療程使用的配方遵從歐盟 2011/84/EU 指令，由意大利生產及以美容產品出口。 歐盟 2011/84/EU 指令規定，以美容產品出口之美齒產品，所含 H2O2 不能超過 0.1%',
    1,
    1
  ),
(
    5,
    'How long can InSmile’s esthetic effect last?',
    'The maintenance time of esthetic effects varies from person to person; some habits such as smoking, coffee, red wine, etc., may shorten the time for whitening effects; therefore, InSmile’s Consultants will respond to each esthetic experience. Different customers, put forward suggestions to help customers better care*!',
    2,
    1
  ),
(
    6,
    'Can InSmile be treated with sensitive teeth? Will it hurt dental health?',
    'InSmile’s esthetic treatment course uses a whitening factor that complies with the European Union’s 2011/84/EU directive. It is a gentle and safe formula that gently penetrates the tiny channels of enamel and ivory and binds and reacts with pigments, ahieving whitening effect with no harm to the teeth. Therefore, sensitive teeth are also suitable for InSmile treatment.',
    2,
    1
  ),
(
    7,
    'In addition to multiple certifications, what is special about the whitening technology used by InSmile?',
    'InSmile’s treatment uses recipes that comply with the EU Directive 2011/84/EU, produced by Italy and exported as beauty products. EU Directive 2011/84/EU stipulates that H2O2 contained in cosmetic products exported from cosmetic products must not exceed 0.1%',
    2,
    1
  ),
(9, 'QuesE', 'AnsE', 2, 0),
(10, 'QuesE2', 'AnsE2', 2, 0),
(11, 'QuesE1', 'AnsE1', 2, 0),
(12, 'QuesC2', 'AnsC2', 1, 0);
/*!40000 ALTER TABLE `tp_wenda` ENABLE KEYS */
;
UNLOCK TABLES;nvby7bv7

--
-- Table structure for table `tp_order_action_log`
-- [REMOVE]

DROP TABLE IF EXISTS `tp_order_action_log`;

CREATE TABLE `tp_order_action_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderId` int NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, --[UPDATE ORIGN addDate]
  `uid` int NOT NULL,
  `remark` varchar(255) DEFAULT '',
  `origin_data` text,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

--
-- Table structure for table `tp_product_variation`
-- [REMOVE]

DROP TABLE IF EXISTS `tp_product_variation`;

CREATE TABLE `tp_product_variation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, --[UPDATE ORIGN addDate]
  `updateDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `variation_key` varchar(100) NOT NULL COMMENT '变体名称',
  `variation_value` text NOT NULL COMMENT '变体值',
  `is_del` int NOT NULL DEFAULT '1' COMMENT '0: 刪除 1:可用', --[UPDATE ORIGN isdel]
  `good_id` int NOT NULL COMMENT '产品id', --[UPDATE ORIGN goods_id]
  `coverImg` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = '产品变体表';

--
-- Table structure for table `tp_schedule`
-- [REMOVE]

DROP TABLE IF EXISTS `tp_schedule`;

CREATE TABLE `tp_schedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `allData` text NOT NULL,
  `rand` varchar(20) DEFAULT NULL,
  `is_del` tinyint(1) NOT NULL DEFAULT '1', --[UPDATE ORIGN isdel]
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

--
-- Table structure for table `tp_shop`
-- [REMOVE]

DROP TABLE IF EXISTS `tp_shop`;

CREATE TABLE `tp_shop` (
  `id` int NOT NULL AUTO_INCREMENT,
  `image` varchar(255) DEFAULT '',
  `name` varchar(255) DEFAULT '',
  `desc1` text,
  `desc2` text,
  `phone` varchar(255) DEFAULT '',
  `whatsApp` varchar(50) DEFAULT '',
  `facebook` varchar(50) DEFAULT '',
  `instagram` varchar(50) NOT NULL,
  `pinterest` varchar(50) NOT NULL,
  `wechat` varchar(50) NOT NULL,
  `youtube` varchar(50) NOT NULL, 
  `address` varchar(255) DEFAULT '',
  `workTime` varchar(50) NOT NULL,
  `add_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP, --[UPDATE ORIGN addDate]
  `rand` varchar(10) DEFAULT NULL,
  `is_del` int DEFAULT '1', --[UPDATE ORIGN isdel]
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM  DEFAULT CHARSET = utf8mb3 ROW_FORMAT = DYNAMIC;

--
-- Table structure for table `tp_sms_log`
-- [REMOVE]

DROP TABLE IF EXISTS `tp_sms_log`;

CREATE TABLE `tp_sms_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, --[UPDATE ORIGN addDate]
  `mobile` varchar(45) NOT NULL,
  `options` varchar(500) DEFAULT NULL,
  `error_info` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;


--
-- Dumping data for table `tp_sms_log`
--

LOCK TABLES `tp_sms_log` WRITE;
/*!40000 ALTER TABLE `tp_sms_log` DISABLE KEYS */
;
/*!40000 ALTER TABLE `tp_sms_log` ENABLE KEYS */
;
UNLOCK TABLES;


--
-- Table structure for table `tp_user_rel_crm`
-- [REMOVE]

DROP TABLE IF EXISTS `tp_user_rel_crm`;

CREATE TABLE `tp_user_rel_crm` (
  `uid` int unsigned NOT NULL COMMENT 'WEB用户ID',
  `account_id` char(36) NOT NULL COMMENT 'CRM客户ID',
  PRIMARY KEY (`uid`, `account_id`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 ROW_FORMAT = DYNAMIC;


--
-- Dumping data for table `tp_user_rel_crm`
--

LOCK TABLES `tp_user_rel_crm` WRITE;
/*!40000 ALTER TABLE `tp_user_rel_crm` DISABLE KEYS */
;
/*!40000 ALTER TABLE `tp_user_rel_crm` ENABLE KEYS */
;
UNLOCK TABLES;



--
-- Table structure for table `tp_user_voucher_log`
-- [REMOVE]


DROP TABLE IF EXISTS `tp_user_voucher_log`;

CREATE TABLE `tp_user_voucher_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, --[UPDATE ORIGN addDate]
  `uid` int NOT NULL,
  `num` decimal(10, 2) NOT NULL DEFAULT '0.00' COMMENT '变动数量',
  `before_num` decimal(10, 2) unsigned NOT NULL DEFAULT '0.00' COMMENT '变动前数量',
  `type` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '变动类型。1【增加】2【减少】',
  `remark` varchar(255) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC COMMENT = '用户增值券变化记录';



--
-- Table structure for table `tp_voucher`
-- [REMOVE]

DROP TABLE IF EXISTS `tp_voucher`;

CREATE TABLE `tp_voucher` (
  `yhId` int unsigned NOT NULL AUTO_INCREMENT,
  `price` decimal(10, 2) DEFAULT '0.00' COMMENT '购买价',
  `value_amount` decimal(10, 2) DEFAULT '0.00' COMMENT '增值额',
  `total_value` decimal(10, 2) DEFAULT '0.00' COMMENT '总值额',
  `desc` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `good_id` int unsigned DEFAULT '0' COMMENT '关联的商品ID', --[UPDATE ORIGN goodsId]
  PRIMARY KEY (`yhId`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;


--
-- Dumping data for table `tp_voucher`
--

LOCK TABLES `tp_voucher` WRITE;
/*!40000 ALTER TABLE `tp_voucher` DISABLE KEYS */
;
/*!40000 ALTER TABLE `tp_voucher` ENABLE KEYS */
;
UNLOCK TABLES;



--
-- Table structure for table `tp_user_action_log`
--
DROP TABLE IF EXISTS `tp_user_action_log`;

CREATE TABLE `tp_user_action_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `editUid` int NOT NULL COMMENT '被编辑的用户ID',
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, --[UPDATE ORIGN addDate]
  `uid` int NOT NULL COMMENT '操作管理账户ID',
  `remark` varchar(255) DEFAULT '',
  `origin_data` text,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

