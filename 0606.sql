-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: medas_iot_rbac
-- ------------------------------------------------------
-- Server version	5.7.15-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tb_app`
--

DROP TABLE IF EXISTS `tb_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_app` (
  `id` bigint(20) NOT NULL,
  `app_id` varchar(45) NOT NULL,
  `create_on` datetime(6) DEFAULT NULL,
  `last_modify` datetime(6) DEFAULT NULL,
  `name` varchar(90) NOT NULL,
  `secret` varchar(90) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `p_id` bigint(20) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_app_id` (`app_id`),
  UNIQUE KEY `uq_app_name` (`name`),
  KEY `FKq6hn9xryok3fb09r7gyo6yv5a` (`p_id`),
  CONSTRAINT `FKq6hn9xryok3fb09r7gyo6yv5a` FOREIGN KEY (`p_id`) REFERENCES `tb_app` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_app`
--

LOCK TABLES `tb_app` WRITE;
/*!40000 ALTER TABLE `tb_app` DISABLE KEYS */;
INSERT INTO `tb_app` VALUES (62436208394895360,'M20200621','2020-06-21 14:59:12.137000','2020-06-27 09:50:30.957000','CMC123靜電采集程序','HDJJSUN8DSS99SSD',0,NULL,'Windows'),(62437489708630016,'M2020062115','2020-06-21 15:04:17.591000','2020-06-21 15:09:43.571000','靜電測試儀參數','H9HDADAD9DADADAKKLIIDKDS',0,62436208394895360,'靜電測試儀配置參數'),(62444854088564736,'M001','2020-06-21 15:33:33.389000','2020-06-21 15:33:33.396000','CMC716溫濕度采集程序','JKDHSJLKDFJLKJLKSDFJKJSD9SD',0,NULL,'Windows');
/*!40000 ALTER TABLE `tb_app` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_app_ver`
--

DROP TABLE IF EXISTS `tb_app_ver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_app_ver` (
  `id` bigint(20) NOT NULL,
  `create_on` datetime(6) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `link` varchar(255) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `ver` varchar(45) NOT NULL,
  `app_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `up_app_version` (`ver`,`app_id`),
  KEY `FKml5j6x2h26y5y4f2r5lbflcr6` (`app_id`),
  CONSTRAINT `FKml5j6x2h26y5y4f2r5lbflcr6` FOREIGN KEY (`app_id`) REFERENCES `tb_app` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_app_ver`
--

LOCK TABLES `tb_app_ver` WRITE;
/*!40000 ALTER TABLE `tb_app_ver` DISABLE KEYS */;
INSERT INTO `tb_app_ver` VALUES (62486989483540480,'2020-06-21 18:20:59.373000','創建版本','/app/62486959729283072.1.zip',0,'1.0',62436208394895360),(62487332447584256,'2020-06-21 18:22:21.037000','修改若干bug','/app/62487324889583616.1.zip',0,'1.1',62436208394895360),(64637762363457536,'2020-06-27 16:47:23.607000','修改若干bug','/app/64637751672311808.exe',0,'1.0.0.1',62444854088564736);
/*!40000 ALTER TABLE `tb_app_ver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_company`
--

DROP TABLE IF EXISTS `tb_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_company` (
  `id` bigint(20) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `code` varchar(45) NOT NULL,
  `county` varchar(255) DEFAULT NULL,
  `create_on` datetime(6) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `province` varchar(255) DEFAULT NULL,
  `region` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_company_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_company`
--

LOCK TABLES `tb_company` WRITE;
/*!40000 ALTER TABLE `tb_company` DISABLE KEYS */;
INSERT INTO `tb_company` VALUES (55101380746018816,NULL,NULL,NULL,'EBA01',NULL,'2020-06-01 09:13:13.043000','','A次集團',NULL,NULL,0),(55101818845265920,NULL,NULL,NULL,'EBA003',NULL,'2020-06-01 09:14:57.358000','','C次集團',NULL,NULL,0),(55177439566888960,NULL,NULL,NULL,'EBA03001',NULL,'2020-06-01 14:15:26.839000',NULL,'檢測塑應中心',NULL,NULL,0),(55453837858701312,NULL,NULL,NULL,'EBA0300101',NULL,'2020-06-02 08:33:45.393000',NULL,'華南檢測中心',NULL,NULL,0),(55454030171734016,NULL,'龍華',NULL,'EBA0300102',NULL,'2020-06-02 08:34:31.081000','','物聯網產品部',NULL,NULL,0),(55464266177708032,NULL,'龍華',NULL,'EBA03001002',NULL,'2020-06-02 09:15:11.546000','','生產課',NULL,NULL,0),(60036903147143168,'','龍華','','EBA03001003','','2020-06-15 00:05:13.288000','','研發課','','',0);
/*!40000 ALTER TABLE `tb_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_company_relation`
--

DROP TABLE IF EXISTS `tb_company_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_company_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ancestor` bigint(20) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `descendant` bigint(20) DEFAULT NULL,
  `root` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_company_relation` (`ancestor`,`descendant`),
  KEY `idx_company_relation_ancestor` (`ancestor`),
  KEY `idx_company_relation_descendant` (`descendant`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_company_relation`
--

LOCK TABLES `tb_company_relation` WRITE;
/*!40000 ALTER TABLE `tb_company_relation` DISABLE KEYS */;
INSERT INTO `tb_company_relation` VALUES (1,55101380746018816,0,55101380746018816,1),(2,55101818845265920,0,55101818845265920,1),(4,55101818845265920,1,55177439566888960,0),(5,55177439566888960,0,55177439566888960,0),(8,55101818845265920,2,55453837858701312,0),(9,55177439566888960,1,55453837858701312,0),(10,55453837858701312,0,55453837858701312,0),(11,55101818845265920,3,55454030171734016,0),(12,55177439566888960,2,55454030171734016,0),(13,55453837858701312,1,55454030171734016,0),(14,55454030171734016,0,55454030171734016,0),(21,55101818845265920,4,55464266177708032,0),(22,55177439566888960,3,55464266177708032,0),(23,55453837858701312,2,55464266177708032,0),(24,55454030171734016,1,55464266177708032,0),(25,55464266177708032,0,55464266177708032,0),(26,55101818845265920,4,60036903147143168,0),(27,55177439566888960,3,60036903147143168,0),(28,55453837858701312,2,60036903147143168,0),(29,55454030171734016,1,60036903147143168,0),(30,60036903147143168,0,60036903147143168,0);
/*!40000 ALTER TABLE `tb_company_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_company_role`
--

DROP TABLE IF EXISTS `tb_company_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_company_role` (
  `company_id` bigint(20) NOT NULL,
  `role` bigint(20) NOT NULL,
  KEY `FK7wg3quggihwbt0n8o6f16ncd6` (`role`),
  KEY `FK81gox1p9ew32spyueu2fpo9pu` (`company_id`),
  CONSTRAINT `FK7wg3quggihwbt0n8o6f16ncd6` FOREIGN KEY (`role`) REFERENCES `tb_role` (`id`),
  CONSTRAINT `FK81gox1p9ew32spyueu2fpo9pu` FOREIGN KEY (`company_id`) REFERENCES `tb_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_company_role`
--

LOCK TABLES `tb_company_role` WRITE;
/*!40000 ALTER TABLE `tb_company_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_company_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_dev`
--

DROP TABLE IF EXISTS `tb_dev`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_dev` (
  `id` bigint(20) NOT NULL,
  `create_on` datetime(6) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `model` varchar(45) NOT NULL,
  `name` varchar(90) NOT NULL,
  `param` varchar(255) DEFAULT NULL,
  `sn` varchar(32) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `dev_group_id` bigint(20) DEFAULT NULL,
  `ver_id` bigint(20) DEFAULT NULL,
  `firm_ver` varchar(45) DEFAULT NULL,
  `soft_ver` varchar(45) DEFAULT NULL,
  `app_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_dev_sn` (`sn`),
  KEY `FKi6veayihojw95427btimi5h9c` (`company_id`),
  KEY `FK13pb7hoj8uqjvfdbkmpm44h4q` (`dev_group_id`),
  KEY `FKf8ubnlwj1n7egp3ivanrsg3fd` (`ver_id`),
  KEY `FKga5c0m6lg7yeeqqqdt6svv7j6` (`app_id`),
  CONSTRAINT `FK13pb7hoj8uqjvfdbkmpm44h4q` FOREIGN KEY (`dev_group_id`) REFERENCES `tb_dev_group` (`id`),
  CONSTRAINT `FKf8ubnlwj1n7egp3ivanrsg3fd` FOREIGN KEY (`ver_id`) REFERENCES `tb_dev_version` (`id`),
  CONSTRAINT `FKga5c0m6lg7yeeqqqdt6svv7j6` FOREIGN KEY (`app_id`) REFERENCES `tb_app` (`id`),
  CONSTRAINT `FKi6veayihojw95427btimi5h9c` FOREIGN KEY (`company_id`) REFERENCES `tb_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_dev`
--

LOCK TABLES `tb_dev` WRITE;
/*!40000 ALTER TABLE `tb_dev` DISABLE KEYS */;
INSERT INTO `tb_dev` VALUES (61104059263746048,'2020-06-17 22:45:43.054000',NULL,'CMC123','靜電測試儀','{\"interval_collection\":\"5\",\"interval_exception\":\"300\"}','00036421345',0,55464266177708032,NULL,61062501906776064,NULL,NULL,62436208394895360),(61104059263746049,'2020-06-17 22:45:43.072000',NULL,'CMC123','靜電測試儀','{\"interval_collection\":\"5\",\"interval_exception\":\"300\"}','000362312234',0,60036903147143168,NULL,61062501906776064,NULL,NULL,62436208394895360),(61104459551342592,'2020-06-17 22:47:18.430000',NULL,'CMC123','靜電測試儀','{\"interval_collection\":\"10\",\"interval_exception\":\"3600\"}','22322112233',0,60036903147143168,NULL,61062501906776064,NULL,NULL,62436208394895360),(61104459551342593,'2020-06-17 22:47:18.434000',NULL,'CMC123','靜電測試儀',NULL,'332234453345',0,55464266177708032,NULL,61062501906776064,NULL,NULL,62436208394895360),(64532288418873344,'2020-06-27 09:48:16.529000',NULL,'CMC716','溫濕度監控器',NULL,'0003642156',0,NULL,NULL,64532030821498880,NULL,NULL,62444854088564736),(64532288418873345,'2020-06-27 09:48:16.531000',NULL,'CMC716','溫濕度監控器',NULL,'0003642157',0,NULL,NULL,64532030821498880,NULL,NULL,62444854088564736),(64532288418873346,'2020-06-27 09:48:16.534000',NULL,'CMC716','溫濕度監控器',NULL,'0003642158',0,NULL,NULL,64532030821498880,NULL,NULL,62444854088564736),(64532288418873347,'2020-06-27 09:48:16.537000',NULL,'CMC716','溫濕度監控器',NULL,'0003642159',0,NULL,NULL,64532030821498880,NULL,NULL,62444854088564736),(64532288418873348,'2020-06-27 09:48:16.540000',NULL,'CMC716','溫濕度監控器',NULL,'0003642160',0,NULL,NULL,64532030821498880,NULL,NULL,62444854088564736);
/*!40000 ALTER TABLE `tb_dev` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_dev_error`
--

DROP TABLE IF EXISTS `tb_dev_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_dev_error` (
  `id` bigint(20) NOT NULL,
  `create_on` datetime(6) DEFAULT NULL,
  `error` int(11) DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL,
  `normal` varchar(255) DEFAULT NULL,
  `sn` varchar(32) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_dev_error`
--

LOCK TABLES `tb_dev_error` WRITE;
/*!40000 ALTER TABLE `tb_dev_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_dev_error` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_dev_group`
--

DROP TABLE IF EXISTS `tb_dev_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_dev_group` (
  `id` bigint(20) NOT NULL,
  `create_on` datetime(6) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKsyb485pmtokyamii5ip5689ff` (`company_id`),
  CONSTRAINT `FKsyb485pmtokyamii5ip5689ff` FOREIGN KEY (`company_id`) REFERENCES `tb_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_dev_group`
--

LOCK TABLES `tb_dev_group` WRITE;
/*!40000 ALTER TABLE `tb_dev_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_dev_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_dev_group_relation`
--

DROP TABLE IF EXISTS `tb_dev_group_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_dev_group_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ancestor` bigint(20) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `descendant` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_dev_group_relation` (`ancestor`,`descendant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_dev_group_relation`
--

LOCK TABLES `tb_dev_group_relation` WRITE;
/*!40000 ALTER TABLE `tb_dev_group_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_dev_group_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_dev_type`
--

DROP TABLE IF EXISTS `tb_dev_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_dev_type` (
  `id` bigint(20) NOT NULL,
  `create_on` datetime(6) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `model` varchar(45) NOT NULL,
  `name` varchar(90) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_dev_type_model` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_dev_type`
--

LOCK TABLES `tb_dev_type` WRITE;
/*!40000 ALTER TABLE `tb_dev_type` DISABLE KEYS */;
INSERT INTO `tb_dev_type` VALUES (60390039305060352,'2020-06-15 23:28:27.469000','群組使用','CMC123','靜電測試儀'),(60758138642497536,'2020-06-16 23:51:09.093000','采集溫濕度、異常報警','CMC716','溫濕度監控器');
/*!40000 ALTER TABLE `tb_dev_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_dev_version`
--

DROP TABLE IF EXISTS `tb_dev_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_dev_version` (
  `id` bigint(20) NOT NULL,
  `create_on` datetime(6) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `hard_ver` varchar(45) DEFAULT NULL,
  `img_url` varchar(255) DEFAULT NULL,
  `ver` varchar(45) NOT NULL,
  `dev_type_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6jjdinvguqbd22tlccwrree96` (`dev_type_id`),
  CONSTRAINT `FK6jjdinvguqbd22tlccwrree96` FOREIGN KEY (`dev_type_id`) REFERENCES `tb_dev_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_dev_version`
--

LOCK TABLES `tb_dev_version` WRITE;
/*!40000 ALTER TABLE `tb_dev_version` DISABLE KEYS */;
INSERT INTO `tb_dev_version` VALUES (60729230211678208,'2020-06-16 21:56:16.894000','溫度精度±0.1，濕度精度±%5','8.0','/img/device/60729219453288448.jpg','9.0',60390039305060352),(61062501906776064,'2020-06-17 20:00:35.085000','','9.0','/img/device/61120648570867712.jpg','10.0',60390039305060352),(64532030821498880,'2020-06-27 09:47:15.167000','溫度精度±0.3，濕度精度±5%','1.10','/img/device/64532023699705856.jpg','2020.06',60758138642497536);
/*!40000 ALTER TABLE `tb_dev_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_error_code`
--

DROP TABLE IF EXISTS `tb_error_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_error_code` (
  `id` bigint(20) NOT NULL,
  `error` varchar(10) NOT NULL,
  `create_on` datetime(6) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `msg` varchar(255) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_error_code` (`error`),
  KEY `FKnwtylod8v6a8q0ufq8tmo402q` (`company_id`),
  CONSTRAINT `FKnwtylod8v6a8q0ufq8tmo402q` FOREIGN KEY (`company_id`) REFERENCES `tb_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_error_code`
--

LOCK TABLES `tb_error_code` WRITE;
/*!40000 ALTER TABLE `tb_error_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_error_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_permission`
--

DROP TABLE IF EXISTS `tb_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_permission` (
  `id` bigint(20) NOT NULL,
  `create_on` datetime(6) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `title` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_permission_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_permission`
--

LOCK TABLES `tb_permission` WRITE;
/*!40000 ALTER TABLE `tb_permission` DISABLE KEYS */;
INSERT INTO `tb_permission` VALUES (65444213487042560,'2020-06-29 22:11:56.469000','用戶信息增刪改查','authority_user_admin',0,'用戶管理'),(65454375018954752,'2020-06-29 22:52:19.123000','應用、版本、升級、日志增刪改查','authority_app_admin',0,'應用管理');
/*!40000 ALTER TABLE `tb_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_permission_res`
--

DROP TABLE IF EXISTS `tb_permission_res`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_permission_res` (
  `permission_id` bigint(20) NOT NULL,
  `res_id` bigint(20) NOT NULL,
  PRIMARY KEY (`permission_id`,`res_id`),
  KEY `FKdcdcnr9ir06hhnawwkojckqu8` (`res_id`),
  CONSTRAINT `FKb6s8krrn933fd14l2igak537o` FOREIGN KEY (`permission_id`) REFERENCES `tb_permission` (`id`),
  CONSTRAINT `FKdcdcnr9ir06hhnawwkojckqu8` FOREIGN KEY (`res_id`) REFERENCES `tb_res` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_permission_res`
--

LOCK TABLES `tb_permission_res` WRITE;
/*!40000 ALTER TABLE `tb_permission_res` DISABLE KEYS */;
INSERT INTO `tb_permission_res` VALUES (65444213487042560,65432848789667840),(65444213487042560,65433614363394048),(65454375018954752,65433768038498304),(65454375018954752,65434165050343424),(65454375018954752,65434279680671744),(65454375018954752,65434520383389696),(65454375018954752,65434684686860288),(65444213487042560,65434922684252160),(65444213487042560,65437955338010624),(65444213487042560,65438447006908416),(65444213487042560,65438572638896128),(65444213487042560,65438834988417024),(65444213487042560,65439007378505728);
/*!40000 ALTER TABLE `tb_permission_res` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_property_item`
--

DROP TABLE IF EXISTS `tb_property_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_property_item` (
  `id` bigint(20) NOT NULL,
  `details` varchar(255) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `title` varchar(45) DEFAULT NULL,
  `app_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKlwk6gwrn8qoa4o4qrqbioprhe` (`app_id`),
  CONSTRAINT `FKlwk6gwrn8qoa4o4qrqbioprhe` FOREIGN KEY (`app_id`) REFERENCES `tb_app` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_property_item`
--

LOCK TABLES `tb_property_item` WRITE;
/*!40000 ALTER TABLE `tb_property_item` DISABLE KEYS */;
INSERT INTO `tb_property_item` VALUES (62436637015015424,'單位秒','interval_collection','采集頻率',62436208394895360),(62436637015015425,'單位秒','interval_exception','異常上報頻率',62436208394895360);
/*!40000 ALTER TABLE `tb_property_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_res`
--

DROP TABLE IF EXISTS `tb_res`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_res` (
  `id` bigint(20) NOT NULL,
  `details` varchar(255) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `idx` int(11) DEFAULT NULL,
  `method` varchar(45) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `title` varchar(45) NOT NULL,
  `type` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_res_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_res`
--

LOCK TABLES `tb_res` WRITE;
/*!40000 ALTER TABLE `tb_res` DISABLE KEYS */;
INSERT INTO `tb_res` VALUES (65432848789667840,'','el-icon-s-custom',0,'GET','menu_user',0,'用戶管理',0,'GET'),(65433614363394048,'','',1,'GET','menu_list',0,'用戶列表',0,'/user/'),(65433768038498304,'','el-icon-s-promotion',2,'GET','menu_app',0,'應用管理',0,'GET'),(65434165050343424,'','',1,'GET','menu_app_list',0,'應用列表',0,'/app/list'),(65434279680671744,'','',2,'GET','menu_app_version',0,'應用版本',0,'/app/version'),(65434520383389696,'','',3,'GET','menu_app_task',0,'安排升級',0,'/app/task'),(65434684686860288,'','',4,'GET','menu_app_records',0,'升級記錄',0,'/app/records'),(65434922684252160,'','',1,'','button_user',0,'用戶管理按鈕',1,''),(65437955338010624,'新增用戶','el-icon-plus',0,'POST','button_user_new',0,'新增',1,'/api/user/'),(65438447006908416,'修改角色信息','el-icon-edit',1,'PUT','button_user_role',0,'角色',1,'/api/user/set/role'),(65438572638896128,'修改用戶信息','el-icon-edit',2,'PUT','button_user_edit',0,'修改',1,'/api/user/'),(65438834988417024,'重置密碼','el-icon-edit',3,'PUT','button_user_reset',0,'重置',1,'/api/user/reset_pwd'),(65439007378505728,'刪除用戶','el-icon-close',5,'DELETE','button_user_delete',0,'刪除',1,'/api/user/');
/*!40000 ALTER TABLE `tb_res` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_res_relation`
--

DROP TABLE IF EXISTS `tb_res_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_res_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ancestor` bigint(20) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `descendant` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_res_relation` (`ancestor`,`descendant`),
  KEY `idx_res_relation_ancestor` (`ancestor`),
  KEY `idx_res_relation_descendant` (`descendant`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_res_relation`
--

LOCK TABLES `tb_res_relation` WRITE;
/*!40000 ALTER TABLE `tb_res_relation` DISABLE KEYS */;
INSERT INTO `tb_res_relation` VALUES (1,65432848789667840,0,65432848789667840),(2,65433614363394048,0,65433614363394048),(3,65432848789667840,1,65433614363394048),(4,65433768038498304,0,65433768038498304),(5,65434165050343424,0,65434165050343424),(6,65433768038498304,1,65434165050343424),(7,65434279680671744,0,65434279680671744),(8,65433768038498304,1,65434279680671744),(9,65434520383389696,0,65434520383389696),(10,65433768038498304,1,65434520383389696),(11,65434684686860288,0,65434684686860288),(12,65433768038498304,1,65434684686860288),(13,65434922684252160,0,65434922684252160),(15,65437955338010624,0,65437955338010624),(16,65434922684252160,1,65437955338010624),(17,65438447006908416,0,65438447006908416),(18,65434922684252160,1,65438447006908416),(19,65438572638896128,0,65438572638896128),(20,65434922684252160,1,65438572638896128),(21,65438834988417024,0,65438834988417024),(22,65434922684252160,1,65438834988417024),(23,65439007378505728,0,65439007378505728),(24,65434922684252160,1,65439007378505728);
/*!40000 ALTER TABLE `tb_res_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_role`
--

DROP TABLE IF EXISTS `tb_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_role` (
  `id` bigint(20) NOT NULL,
  `create_on` datetime(6) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `name` varchar(90) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `title` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_role_name` (`name`),
  UNIQUE KEY `up_role_title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_role`
--

LOCK TABLES `tb_role` WRITE;
/*!40000 ALTER TABLE `tb_role` DISABLE KEYS */;
INSERT INTO `tb_role` VALUES (65447168164495360,'2020-06-29 22:23:40.879000','','role_admin',0,'系統管理員');
/*!40000 ALTER TABLE `tb_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_role_permission`
--

DROP TABLE IF EXISTS `tb_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_role_permission` (
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL,
  KEY `FKn1fuq85qvjb8i00n532hji0k5` (`permission_id`),
  KEY `FKopy61ig7uc3g8pc5xky4c9sqs` (`role_id`),
  CONSTRAINT `FKn1fuq85qvjb8i00n532hji0k5` FOREIGN KEY (`permission_id`) REFERENCES `tb_permission` (`id`),
  CONSTRAINT `FKopy61ig7uc3g8pc5xky4c9sqs` FOREIGN KEY (`role_id`) REFERENCES `tb_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_role_permission`
--

LOCK TABLES `tb_role_permission` WRITE;
/*!40000 ALTER TABLE `tb_role_permission` DISABLE KEYS */;
INSERT INTO `tb_role_permission` VALUES (65447168164495360,65444213487042560),(65447168164495360,65454375018954752);
/*!40000 ALTER TABLE `tb_role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_update_log`
--

DROP TABLE IF EXISTS `tb_update_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_update_log` (
  `id` bigint(20) NOT NULL,
  `app_id` varchar(45) NOT NULL,
  `create_on` datetime(6) DEFAULT NULL,
  `link` varchar(45) DEFAULT NULL,
  `sn` varchar(45) NOT NULL,
  `app_ver` varchar(45) NOT NULL,
  `app_name` varchar(90) DEFAULT NULL,
  `ver_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_update_log`
--

LOCK TABLES `tb_update_log` WRITE;
/*!40000 ALTER TABLE `tb_update_log` DISABLE KEYS */;
INSERT INTO `tb_update_log` VALUES (64635626128932864,'M20200621','2020-06-27 16:38:54.192000','/app/62487324889583616.1.zip','00036421345','1.1','CMC123靜電采集程序',62487332447584256),(64637162930307072,'M20200621','2020-06-27 16:45:00.620000','/app/62487324889583616.1.zip','000362312234','1.1','CMC123靜電采集程序',62487332447584256);
/*!40000 ALTER TABLE `tb_update_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_update_task`
--

DROP TABLE IF EXISTS `tb_update_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_update_task` (
  `id` bigint(20) NOT NULL,
  `create_on` datetime(6) DEFAULT NULL,
  `sn` varchar(45) DEFAULT NULL,
  `ver_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKnh18y5e7rf71iqdrsym22qyq6` (`ver_id`),
  CONSTRAINT `FKnh18y5e7rf71iqdrsym22qyq6` FOREIGN KEY (`ver_id`) REFERENCES `tb_app_ver` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_update_task`
--

LOCK TABLES `tb_update_task` WRITE;
/*!40000 ALTER TABLE `tb_update_task` DISABLE KEYS */;
INSERT INTO `tb_update_task` VALUES (64637803576688640,'2020-06-27 16:47:33.322000','0003642156',64637762363457536),(64637803585077248,'2020-06-27 16:47:33.326000','0003642157',64637762363457536),(64637803593465856,'2020-06-27 16:47:33.328000','0003642158',64637762363457536),(64637803597660160,'2020-06-27 16:47:33.330000','0003642160',64637762363457536),(64696977278894080,'2020-06-27 20:42:41.402000','00036421345',62487332447584256),(64696977287282688,'2020-06-27 20:42:41.404000','000362312234',62487332447584256),(64696977291476992,'2020-06-27 20:42:41.406000','22322112233',62487332447584256),(64696977299865600,'2020-06-27 20:42:41.408000','332234453345',62487332447584256);
/*!40000 ALTER TABLE `tb_update_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_user`
--

DROP TABLE IF EXISTS `tb_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_user` (
  `id` bigint(20) NOT NULL,
  `avatar_url` varchar(128) DEFAULT NULL,
  `create_on` datetime(6) DEFAULT NULL,
  `user_email` varchar(255) NOT NULL,
  `ext` varchar(20) DEFAULT NULL,
  `icivet_id` varchar(32) DEFAULT NULL,
  `user_name` varchar(255) NOT NULL,
  `user_no` varchar(32) NOT NULL,
  `open_id` varchar(32) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `pwd` varchar(255) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_no` (`user_no`),
  UNIQUE KEY `uq_user_email` (`user_email`),
  KEY `FKib3edn6o0l2nlr2vlpl48idfs` (`company_id`),
  CONSTRAINT `FKib3edn6o0l2nlr2vlpl48idfs` FOREIGN KEY (`company_id`) REFERENCES `tb_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user`
--

LOCK TABLES `tb_user` WRITE;
/*!40000 ALTER TABLE `tb_user` DISABLE KEYS */;
INSERT INTO `tb_user` VALUES (56305110317268992,NULL,'2020-06-04 16:56:24.417000','hzlh-cmc-rd1system@mail.foxconn.com','5060+73763','','盧昌利','W0515366','','13249466549','$2a$10$ib9kF5OYWius68sS0QhmyOatvat3Ss7JIURKKz3n2004Ah.yoLdku',0,55454030171734016),(64694084446453760,NULL,'2020-06-27 20:31:11.740000','hzlh-cmc-rfid@mail.foxconn.com','560+73766','','李成成','W0515367','','','$2a$10$JO.EE6EVrNxGpIXq7to9EeBj6EONaeYz6M/4dirr.jPOybz2tC7K2',0,55464266177708032);
/*!40000 ALTER TABLE `tb_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_user_role`
--

DROP TABLE IF EXISTS `tb_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_user_role` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  KEY `FKea2ootw6b6bb0xt3ptl28bymv` (`role_id`),
  KEY `FK7vn3h53d0tqdimm8cp45gc0kl` (`user_id`),
  CONSTRAINT `FK7vn3h53d0tqdimm8cp45gc0kl` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`id`),
  CONSTRAINT `FKea2ootw6b6bb0xt3ptl28bymv` FOREIGN KEY (`role_id`) REFERENCES `tb_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user_role`
--

LOCK TABLES `tb_user_role` WRITE;
/*!40000 ALTER TABLE `tb_user_role` DISABLE KEYS */;
INSERT INTO `tb_user_role` VALUES (56305110317268992,65447168164495360);
/*!40000 ALTER TABLE `tb_user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-29 22:55:24
