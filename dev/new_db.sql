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









--
-- Table structure for table `tp_user_address`
--

DROP TABLE IF EXISTS `tp_user_address`;

CREATE TABLE `tp_user_address` (
  -- `customer` varchar(64) NOT NULL, --[REMOVE]
  -- `delivery` enum('delivery') DEFAULT 'delivery', --[REMOVE]
  -- `selfpick_up_branch_id` int DEFAULT NULL, --[REMOVE]
  -- `phone_cn` varchar(255) DEFAULT NULL, --[REMOVE]
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'user address id',
  `user_id` int NOT NULL 'reference to user id', --[UPDATE ORIGN uid]
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'address created time', --[UPDATE ORIGN addDate]
  `phone` varchar(8) DEFAULT NULL COMMENT 'contact number', 
  `address` varchar(255) DEFAULT NULL COMMENT 'user address',
  `is_del` int DEFAULT '0' COMMENT 'the adress is deleted', --[UPDATE ORIGN isdel]
  `email` varchar(110) DEFAULT ''COMMENT 'user email',
  `is_default` tinyint unsigned DEFAULT '0' COMMENT 'is address user default',
  `delivery_type` enum( --[UPDATE ORIGN deliveryType]
    'selfpick-up',
    'sf-express',
    'direct',
    'mtr',
    'foreign'
  ) DEFAULT 'sf-express' COMMENT '运送方式。selfpick-up【客人到取】, sf-express【順豐快遞（智能自取櫃 + 送貨上門）】, direct【公司直送】, metro【地鐵交收】, foreign【海外寄貨】',
  `send_type` tinyint DEFAULT '0' COMMENT '1【自取】2【上门】', --[UPDATE ORIGN sendType]
  `area_id` varchar(255) DEFAULT '' COMMENT '区域', --[UPDATE ORIGN area]
  `sub_id` varchar(255) DEFAULT '' COMMENT 'reference tp_sf_sub', --[UPDATE ORIGN location]
  `location_id` varchar(255) DEFAULT '' COMMENT 'sf localtion id', --[UPDATE ORIGN locations]
  `room` varchar(255) DEFAULT '',
  `building` varchar(255) DEFAULT '',
  `housing` varchar(255) DEFAULT '',
  `block` varchar(255) DEFAULT '',
  `floor` varchar(255) DEFAULT '',
  `street` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL COMMENT 'user country',
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY (`user_id`) REFERENCES `tp_user`(`id`),
  FOREIGN KEY(`area_id`) REFERENCES `tp_sf_area`(`id`),
  FOREIGN KEY(sub_id) REFERENCES `tp_sf_sub_area`(`id`),
  FOREIGN KEY(location_id) REFERENCES `tp_sf_location`(`id`),
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;






