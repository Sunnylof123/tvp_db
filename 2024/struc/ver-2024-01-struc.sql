-- MySQL dump 10.13  Distrib 8.0.38, for macos14 (x86_64)
--
-- Host: 192.168.1.128    Database: db_work_mmigh_sys1
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tp_admin`
--

DROP TABLE IF EXISTS `tp_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `password` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `add_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_del` int unsigned DEFAULT '0',
  `is_super` tinyint unsigned DEFAULT '0' COMMENT 'allow delete or not',
  `permission` int unsigned NOT NULL DEFAULT 0xffffffff,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='this table is seperate from the user table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tp_banner`
--

DROP TABLE IF EXISTS `tp_banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_banner` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `group` enum('home','booking','app','page','courses','products','member','aboutus','promote','coupon','account') COLLATE utf8mb4_general_ci NOT NULL,
  `subtitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `is_del` int DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tp_booking`
--

DROP TABLE IF EXISTS `tp_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_booking` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'booking id',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'booking created time',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'booking description',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'booking name',
  `booking_datetime` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `max_capacity` int DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `min_capacity` int DEFAULT NULL,
  `image` text COLLATE utf8mb4_general_ci,
  `instructor` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_on_shelf` tinyint NOT NULL DEFAULT '1',
  `terms_and_condition` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_require_login` tinyint NOT NULL DEFAULT '1',
  `type` enum('course','enquiry') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'course',
  `booking_end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tp_booking_cate`
--

DROP TABLE IF EXISTS `tp_booking_cate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_booking_cate` (
  `booking_id` int unsigned NOT NULL,
  `cate_id` int unsigned NOT NULL,
  PRIMARY KEY (`booking_id`,`cate_id`),
  KEY `cate_id` (`cate_id`),
  CONSTRAINT `tp_booking_cate_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `tp_booking` (`id`),
  CONSTRAINT `tp_booking_cate_ibfk_2` FOREIGN KEY (`cate_id`) REFERENCES `tp_cate` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tp_cart`
--

DROP TABLE IF EXISTS `tp_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT 'user id',
  `sku_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT 'skuid',
  `qty` int DEFAULT '1' COMMENT 'item quantity',
  `status` int unsigned DEFAULT '0' COMMENT '0: not pay 1:paid 2:removed',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'remark',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`),
  KEY `tp_cart_ibfk_1` (`sku_id`),
  CONSTRAINT `tp_cart_ibfk_1` FOREIGN KEY (`sku_id`) REFERENCES `tp_good_sku` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tp_cart_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `tp_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='for each item in the cart will only have one record with status 0';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tp_cate`
--

DROP TABLE IF EXISTS `tp_cate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_cate` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'category name',
  `parent_id` int DEFAULT '0' COMMENT 'parent  0: not parenet else: other category',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'category description in json format',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `is_del` int DEFAULT '0' COMMENT '0: available 1: not available',
  `crm_id` char(36) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'crm id',
  `type` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'g' COMMENT 'item type g: good b: booking',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tp_common_info`
--

DROP TABLE IF EXISTS `tp_common_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_common_info` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '类型',
  `is_del` tinyint NOT NULL DEFAULT '1' COMMENT '是否已删除0删除1可用',
  `create_time` int DEFAULT NULL,
  `update_time` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='公共配置表，针对只有name的情况';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tp_coupon`
--

DROP TABLE IF EXISTS `tp_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_coupon` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'coupon name in json format',
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `dedu_amount` int DEFAULT '0' COMMENT 'deducted money',
  `req_amount` decimal(10,2) DEFAULT '0.00' COMMENT 'required amount for using this coupon',
  `beg_date` date DEFAULT NULL COMMENT 'coupon begin date',
  `end_date` date DEFAULT NULL COMMENT 'coupon end date',
  `score` decimal(10,2) DEFAULT '0.00' COMMENT 'redeem score for coupon',
  `stock` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'coupon stock',
  `is_del` int DEFAULT '0' COMMENT '0: available 1: not available',
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tp_favourite`
--

DROP TABLE IF EXISTS `tp_favourite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_favourite` (
  `user_id` int NOT NULL COMMENT 'user id',
  `good_id` int NOT NULL COMMENT 'good id',
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'item add date',
  PRIMARY KEY (`user_id`,`good_id`) USING BTREE,
  KEY `good_id` (`good_id`),
  CONSTRAINT `tp_favourite_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tp_user` (`id`),
  CONSTRAINT `tp_favourite_ibfk_2` FOREIGN KEY (`good_id`) REFERENCES `tp_good` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Table structure for table `tp_good`
--

DROP TABLE IF EXISTS `tp_good`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_good` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'good id',
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'good name in json format',
  `place` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'good from',
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'good created date',
  `update_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'good last update date',
  `weight` int DEFAULT NULL COMMENT 'good weight (g)',
  `length` int unsigned DEFAULT '0' COMMENT 'good length',
  `width` int unsigned DEFAULT '0' COMMENT 'good width',
  `height` int unsigned DEFAULT '0' COMMENT 'good height',
  `stock` int DEFAULT '0' COMMENT 'good stocking',
  `is_del` int DEFAULT '1' COMMENT '0: available 1: not available',
  `low_stock_alert` int unsigned DEFAULT '0' COMMENT 'alert show in admin panel when the item qty reach the number',
  `desc` text COLLATE utf8mb4_general_ci COMMENT 'good description in json format',
  `is_recommended` tinyint unsigned DEFAULT '0' COMMENT 'good is recommend on the home page',
  `sku_id` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'main good sku id',
  `is_new` tinyint NOT NULL DEFAULT '0' COMMENT 'is new item',
  `is_variation` tinyint DEFAULT '0' COMMENT 'muti type item',
  `crm_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'crm good id',
  `odoo_product_code` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'odoo good id',
  `is_on_shelf` int DEFAULT '1' COMMENT 'is the item on shelf',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tp_good_cate`
--

DROP TABLE IF EXISTS `tp_good_cate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_good_cate` (
  `good_id` int NOT NULL,
  `cate_id` int unsigned NOT NULL,
  PRIMARY KEY (`good_id`,`cate_id`),
  KEY `cate_id` (`cate_id`),
  CONSTRAINT `tp_good_cate_ibfk_1` FOREIGN KEY (`good_id`) REFERENCES `tp_good` (`id`),
  CONSTRAINT `tp_good_cate_ibfk_2` FOREIGN KEY (`cate_id`) REFERENCES `tp_cate` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tp_good_setting`
--

DROP TABLE IF EXISTS `tp_good_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_good_setting` (
  `id` int NOT NULL AUTO_INCREMENT,
  `good_id` int NOT NULL DEFAULT '0' COMMENT 'good id',
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'sku good setting column',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `good_id` (`good_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='setting for good';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tp_good_setting_value`
--

DROP TABLE IF EXISTS `tp_good_setting_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_good_setting_value` (
  `id` varchar(255) NOT NULL,
  `setting_id` int NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `setting_id` (`setting_id`),
  KEY `id` (`id`),
  CONSTRAINT `tp_good_setting_value_ibfk_1` FOREIGN KEY (`setting_id`) REFERENCES `tp_good_setting` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tp_good_sku`
--

DROP TABLE IF EXISTS `tp_good_sku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_good_sku` (
  `id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'extend sku id base on the good sku id',
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'sku name in json format',
  `image` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'sku good image',
  `good_id` int NOT NULL DEFAULT '0' COMMENT 'sku good id',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'sku good price',
  `stock` int NOT NULL DEFAULT '0' COMMENT 'sku good stock',
  `weight` decimal(10,3) NOT NULL DEFAULT '0.000' COMMENT 'sku good weigh',
  `volume` decimal(10,3) NOT NULL DEFAULT '0.000' COMMENT 'sku good volume',
  `sale_num` int NOT NULL DEFAULT '0' COMMENT 'number of item sold',
  `is_selected` tinyint NOT NULL DEFAULT '0' COMMENT 'is selected',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `good_id` (`good_id`),
  CONSTRAINT `tp_good_sku_ibfk_1` FOREIGN KEY (`good_id`) REFERENCES `tp_good` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='good setting';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tp_good_sku_value`
--

DROP TABLE IF EXISTS `tp_good_sku_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_good_sku_value` (
  `sku_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value_id` varchar(255) NOT NULL,
  PRIMARY KEY (`sku_id`,`value_id`) USING BTREE,
  KEY `tp_good_sku_value_ibfk_2` (`value_id`),
  CONSTRAINT `tp_good_sku_value_ibfk_1` FOREIGN KEY (`sku_id`) REFERENCES `tp_good_sku` (`id`),
  CONSTRAINT `tp_good_sku_value_ibfk_2` FOREIGN KEY (`value_id`) REFERENCES `tp_good_setting_value` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tp_order`
--

DROP TABLE IF EXISTS `tp_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_order` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'order id',
  `user_id` int NOT NULL COMMENT 'order user id',
  `out_trade_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'out trade no from paypal',
  `coupon_id` int DEFAULT NULL COMMENT 'coupon id, if coupon is used',
  `amount` decimal(11,2) NOT NULL COMMENT 'total amount of order',
  `dedu_amount` decimal(11,2) DEFAULT NULL COMMENT 'deducted amount of order',
  `paid_amount` decimal(11,2) NOT NULL COMMENT 'amount paid of order',
  `pay_date` timestamp NULL DEFAULT NULL COMMENT 'pay day',
  `qty` int DEFAULT NULL COMMENT 'order item quantity sum',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'order created date',
  `recipient` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'order person',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'contact number',
  `email` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'contact email',
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'contact address',
  `paypal_link` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'paypal pay intent link',
  `crm_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'crm id',
  `cancel_date` timestamp NULL DEFAULT NULL COMMENT 'order cancel or refunded date depend on the status',
  `complete_date` timestamp NULL DEFAULT NULL COMMENT 'order complete on status complete',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'order remark',
  `ship_date` date DEFAULT NULL,
  `odoo_flag` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'odoo tag',
  `odoo_order_code` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'odoo order id ',
  `source` enum('app','web') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'web' COMMENT 'order source',
  `status` enum('paying','paid','pending','packaging','shipping','complete','cancelled','refunded','unpaid') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'paying' COMMENT 'order status',
  `payment_method_type` enum('paypal','other','stripe','cash','bank') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'paypal' COMMENT 'payment method',
  `delivery_type` enum('pickup','delivery','pickup-sf-express') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'pickup' COMMENT 'order send type ',
  `tracking_no` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'package tracking number',
  `is_del` tinyint NOT NULL DEFAULT '0' COMMENT 'is delete',
  `payment_method_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`),
  KEY `coupon_id` (`coupon_id`),
  KEY `tp_order_ibfk_3_idx` (`payment_method_id`),
  CONSTRAINT `tp_order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tp_user` (`id`),
  CONSTRAINT `tp_order_ibfk_2` FOREIGN KEY (`coupon_id`) REFERENCES `tp_coupon` (`id`),
  CONSTRAINT `tp_order_ibfk_3` FOREIGN KEY (`payment_method_id`) REFERENCES `tp_payment_method` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tp_order_item`
--

DROP TABLE IF EXISTS `tp_order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_order_item` (
  `order_id` int NOT NULL COMMENT 'order id',
  `good_id` int NOT NULL COMMENT 'main good id',
  `sku_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'sku good id',
  `qty` int NOT NULL COMMENT 'order item quantity',
  `unit_price` decimal(11,2) NOT NULL COMMENT 'order item unit price at the moment',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'remark for order item, can store everything',
  PRIMARY KEY (`order_id`,`sku_id`) USING BTREE,
  KEY `tp_order_item_ibfk_3` (`sku_id`),
  KEY `tp_order_item_ibfk_2` (`good_id`),
  CONSTRAINT `tp_order_item_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `tp_order` (`id`),
  CONSTRAINT `tp_order_item_ibfk_2` FOREIGN KEY (`good_id`) REFERENCES `tp_good` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tp_order_item_ibfk_3` FOREIGN KEY (`sku_id`) REFERENCES `tp_good_sku` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tp_payment_method`
--

DROP TABLE IF EXISTS `tp_payment_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_payment_method` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `image` text COLLATE utf8mb4_general_ci NOT NULL,
  `is_del` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tp_pcset`
--

DROP TABLE IF EXISTS `tp_pcset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_pcset` (
  `id` int NOT NULL AUTO_INCREMENT,
  `whatsapp` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `work_time` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `work_date` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_general_ci,
  `phone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `company_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `facebook` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `instagram` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `fax` varchar(110) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(110) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `about` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `google_map` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `payment_qrcode` text COLLATE utf8mb4_general_ci COMMENT 'qr code image json',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tp_promote`
--

DROP TABLE IF EXISTS `tp_promote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_promote` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `subtitle` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `link_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `pic_urls` text COLLATE utf8mb4_general_ci,
  `is_del` int DEFAULT '1' COMMENT '0: 刪除 1:可用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tp_score`
--

DROP TABLE IF EXISTS `tp_score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_score` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `score` int NOT NULL,
  `year` varchar(4) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`),
  CONSTRAINT `tp_score_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tp_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tp_score_log`
--

DROP TABLE IF EXISTS `tp_score_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_score_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `score` int NOT NULL,
  `score_delta` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`),
  CONSTRAINT `tp_score_log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tp_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tp_sf_area`
--

DROP TABLE IF EXISTS `tp_sf_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_sf_area` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_del` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='for delivery options';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tp_sf_location`
--

DROP TABLE IF EXISTS `tp_sf_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_sf_location` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sub_id` int NOT NULL,
  `is_del` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sub_id` (`sub_id`),
  CONSTRAINT `tp_sf_location_ibfk_1` FOREIGN KEY (`sub_id`) REFERENCES `tp_sf_sub_area` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='location for sf pickup';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tp_sf_sub_area`
--

DROP TABLE IF EXISTS `tp_sf_sub_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_sf_sub_area` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `area_id` int DEFAULT NULL,
  `is_del` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `area_id` (`area_id`),
  CONSTRAINT `tp_sf_sub_area_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `tp_sf_area` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='location for sf pickup';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tp_system`
--

DROP TABLE IF EXISTS `tp_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_system` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'name of type',
  `group` enum('base') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'base',
  `value` text COLLATE utf8mb4_general_ci COMMENT 'value of type',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='system info eg. invoice header, address etc...';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tp_user`
--

DROP TABLE IF EXISTS `tp_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'user id',
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
  `is_del` int unsigned DEFAULT '0' COMMENT 'is the user deleted',
  `invite_user_id` int DEFAULT NULL COMMENT 'invite by other users id',
  `crm_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'crm user id',
  `odoo_customer_code` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'odoo customer code',
  `is_odoo_sync` int unsigned NOT NULL DEFAULT '0' COMMENT 'is odoo sync-ed',
  `odoo_id` int DEFAULT NULL COMMENT 'odoo user id',
  `is_verified` int NOT NULL DEFAULT '0' COMMENT 'is user verified by code',
  `reset_code` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `invite_user_id` (`invite_user_id`),
  CONSTRAINT `tp_user_ibfk_1` FOREIGN KEY (`invite_user_id`) REFERENCES `tp_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tp_user_address`
--

DROP TABLE IF EXISTS `tp_user_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_user_address` (
  `phone_cn` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'user address id',
  `user_id` int NOT NULL COMMENT 'reference to user id',
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'address created time',
  `phone` varchar(8) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'contact number',
  `address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'user address',
  `is_del` int DEFAULT '0' COMMENT 'the adress is deleted',
  `email` varchar(110) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'user email',
  `is_default` tinyint unsigned DEFAULT '0' COMMENT 'is address user default',
  `delivery_type` enum('pickup','pickup-sf-express','delivery') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'pickup' COMMENT '运送方式。selfpick-up【客人到取】, sf-express【順豐快遞（智能自取櫃 + 送貨上門）】, direct【公司直送】, metro【地鐵交收】, foreign【海外寄貨】',
  `area_id` int DEFAULT NULL COMMENT '区域',
  `sub_id` int DEFAULT NULL COMMENT 'reference tp_sf_sub',
  `location_id` int DEFAULT NULL COMMENT 'sf localtion id',
  `room` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `building` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `housing` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `block` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `floor` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `street` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'user country',
  `recipient` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'deliver to ',
  `district` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`),
  KEY `area_id` (`area_id`),
  KEY `sub_id` (`sub_id`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `tp_user_address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tp_user` (`id`),
  CONSTRAINT `tp_user_address_ibfk_2` FOREIGN KEY (`area_id`) REFERENCES `tp_sf_area` (`id`),
  CONSTRAINT `tp_user_address_ibfk_3` FOREIGN KEY (`sub_id`) REFERENCES `tp_sf_sub_area` (`id`),
  CONSTRAINT `tp_user_address_ibfk_4` FOREIGN KEY (`location_id`) REFERENCES `tp_sf_location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tp_user_booking`
--

DROP TABLE IF EXISTS `tp_user_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_user_booking` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` int unsigned NOT NULL,
  `user_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `booking_date` datetime DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0',
  `price` decimal(11,2) DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tp_user_booking_ibfk_1` (`booking_id`),
  CONSTRAINT `tp_user_booking_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `tp_booking` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tp_user_coupon`
--

DROP TABLE IF EXISTS `tp_user_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_user_coupon` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'coupon record id',
  `user_id` int DEFAULT NULL COMMENT 'user id',
  `coupon_id` int DEFAULT NULL COMMENT 'coupon id',
  `used_date` timestamp NULL DEFAULT NULL COMMENT 'coupong used date',
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'coupon add date',
  `status` int DEFAULT '0' COMMENT '0: not use 1: processing 2: used',
  `order_id` int NOT NULL COMMENT 'coupon used on order',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`),
  KEY `coupon_id` (`coupon_id`),
  CONSTRAINT `tp_user_coupon_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tp_user` (`id`),
  CONSTRAINT `tp_user_coupon_ibfk_2` FOREIGN KEY (`coupon_id`) REFERENCES `tp_coupon` (`id`),
  CONSTRAINT `tp_user_coupon_chk_1` CHECK ((`status` in (0,1,2)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='record of user coupon';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tp_user_level`
--

DROP TABLE IF EXISTS `tp_user_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_user_level` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'level id',
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='设置用户等级表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tp_verifi`
--

DROP TABLE IF EXISTS `tp_verifi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tp_verifi` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'verify id',
  `user_id` int NOT NULL COMMENT 'user id',
  `send_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'code send time',
  `code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`),
  CONSTRAINT `tp_verifi_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tp_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40000 ALTER TABLE `tp_verifi` DISABLE KEYS */;
/*!40000 ALTER TABLE `tp_verifi` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-25 10:18:32
