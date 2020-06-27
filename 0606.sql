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
-- Table structure for table `tb_button`
--

DROP TABLE IF EXISTS `tb_button`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_button` (
  `id` bigint(20) NOT NULL,
  `create_on` datetime(6) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `icon` varchar(45) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `method` varchar(45) DEFAULT NULL,
  `title` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_button_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_button`
--

LOCK TABLES `tb_button` WRITE;
/*!40000 ALTER TABLE `tb_button` DISABLE KEYS */;
INSERT INTO `tb_button` VALUES (57410030810431488,NULL,'新增部門','el-icon-plus','button_company_new',0,'/api/company/','POST','新增'),(57410377264136192,NULL,'修改部門','el-icon-edit','button_company_edit',0,'/api/company/','PUT','修改'),(57410870115827712,NULL,'禁用部門','el-icon-remove-outline','button_company_disable',0,'/api/company/disable/','PUT','禁用'),(57425509700599808,NULL,'刪除部門','el-icon-close','button_company_delete',0,'/api/company/','DELETE','删除'),(64717359973138432,NULL,'','','button_system_resource',0,'','','資源按鈕'),(64717865999138816,NULL,'','','button_system_company',0,'','','部門管理'),(64718658651291648,NULL,'新增菜單','primary el-icon-plus','button_menu_new',0,'/api/menu/','POST','新增'),(64725737394929664,NULL,'修改菜單','el-icon-edit','button_menu_edit',0,'/api/menu/','PUT','修改'),(64726019382181888,NULL,'刪除菜單','el-icon-close','button_menu_delete',0,'/api/menu/','DELETE','刪除'),(64726232394104832,NULL,'使能菜單','el-icon-remove-outline','button_menu_disable',0,'/api/menu/disable','PUT','使能'),(64726826232053760,NULL,'新增按鈕','el-icon-plus','button_button_new',0,'/api/button/','POST','新增'),(64726982134333440,NULL,'修改按鈕','el-icon-edit','button_button_edit',0,'/api/button/','PUT','修改'),(64727161809928192,NULL,'刪除按鈕','el-icon-close','button_button_delete',0,'/api/button/','DELETE','刪除'),(64727554312896512,NULL,'使能按鈕','el-icon-remove-outline','button_button_disable',0,'/api/button/','PUT','使能'),(64729345658191872,NULL,'','','button_user',0,'','','用戶按鈕'),(64729727885115392,NULL,'新增用戶','el-icon-plus','button_user_new',0,'/api/user/','POST','新增'),(64729923851386880,NULL,'修改用戶','el-icon-edit','button_user_edit',0,'/api/user/','PUT','修改'),(64730256740712448,NULL,'重置密碼','el-icon-refresh-right','button_user_reset',0,'/api/user/reset/','PUT','重置'),(64730423002923008,NULL,'刪除用戶','el-icon-close','button_user_delete',0,'/api/user/','DELETE','刪除'),(64730815581388800,NULL,'使能用戶','el-icon-remove-outline','button_user_disable',0,'/api/user/disable/','PUT','使能'),(64732445433397248,NULL,'','','button_dev_type',0,'','','應用類型按鈕'),(64732609233551360,NULL,'新增設備類型','el-icon-plus','button_dev_type_new',0,'/api/device/type/','POST','新增'),(64732794672119808,NULL,'修改設備類型','el-icon-edit','button_dev_type_edit',0,'/api/device/type/','PUT','修改'),(64733216287752192,NULL,'刪除設備類型','el-icon-close','button_dev_type_delete',0,'/api/device/type/','DELETE','刪除'),(64733434748076032,NULL,'使能設備類型','el-icon-remove-outline','button_dev_type_disable',0,'/api/device/type/disable/','PUT','使能'),(64734439120306176,NULL,'','','button_dev_ver',0,'','','設備版本按鈕'),(64734736995581952,NULL,'新增設備版本','el-icon-plus','button_dev_ver_new',0,'/api/device/version/','POST','新增'),(64735109005180928,NULL,'修改設備版本','el-icon-edit','button_dev_ver_edit',0,'/api/device/version/','PUT','修改'),(64735337888350208,NULL,'刪除設備版本','el-icon-close','button_dev_ver_delete',0,'/api/device/version/','DELETE','刪除'),(64735619451977728,NULL,'使能設備版本','el-icon-remove-outline','button_dev_ver_disable',0,'/api/device/version/disable','PUT','使能');
/*!40000 ALTER TABLE `tb_button` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_button_relation`
--

DROP TABLE IF EXISTS `tb_button_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_button_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ancestor` bigint(20) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `descendant` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_button_relation` (`ancestor`,`descendant`),
  KEY `idx_button_relation_ancestor` (`ancestor`),
  KEY `idx_button_relation_descendant` (`descendant`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_button_relation`
--

LOCK TABLES `tb_button_relation` WRITE;
/*!40000 ALTER TABLE `tb_button_relation` DISABLE KEYS */;
INSERT INTO `tb_button_relation` VALUES (1,57406125863075840,0,57406125863075840),(6,57410679434379264,0,57410679434379264),(10,57421403388903424,0,57421403388903424),(34,64717359973138432,0,64717359973138432),(43,64717865999138816,0,64717865999138816),(53,64717359973138432,1,64718486353477632),(74,64727161809928192,0,64727161809928192),(75,64717359973138432,1,64727161809928192),(76,64717359973138432,1,64718658651291648),(77,64718658651291648,0,64718658651291648),(78,64717359973138432,1,64725737394929664),(79,64725737394929664,0,64725737394929664),(80,64717359973138432,1,64726019382181888),(81,64726019382181888,0,64726019382181888),(82,64717359973138432,1,64726232394104832),(83,64726232394104832,0,64726232394104832),(84,64717359973138432,1,64726826232053760),(85,64726826232053760,0,64726826232053760),(86,64717359973138432,1,64726982134333440),(87,64726982134333440,0,64726982134333440),(88,64727554312896512,0,64727554312896512),(89,64717359973138432,1,64727554312896512),(92,64717865999138816,1,57410030810431488),(93,57410030810431488,0,57410030810431488),(94,64717865999138816,1,57410377264136192),(95,57410377264136192,0,57410377264136192),(96,64717865999138816,1,57410870115827712),(97,57410870115827712,0,57410870115827712),(98,64717865999138816,1,57425509700599808),(99,57425509700599808,0,57425509700599808),(100,64729345658191872,0,64729345658191872),(103,64729345658191872,1,64729727885115392),(104,64729727885115392,0,64729727885115392),(105,64729923851386880,0,64729923851386880),(106,64729345658191872,1,64729923851386880),(107,64730256740712448,0,64730256740712448),(108,64729345658191872,1,64730256740712448),(109,64730423002923008,0,64730423002923008),(110,64729345658191872,1,64730423002923008),(111,64730815581388800,0,64730815581388800),(112,64729345658191872,1,64730815581388800),(113,64732445433397248,0,64732445433397248),(128,64734439120306176,0,64734439120306176),(133,64734736995581952,0,64734736995581952),(134,64734439120306176,1,64734736995581952),(135,64732445433397248,1,64732609233551360),(136,64732609233551360,0,64732609233551360),(137,64732445433397248,1,64732794672119808),(138,64732794672119808,0,64732794672119808),(139,64732445433397248,1,64733216287752192),(140,64733216287752192,0,64733216287752192),(141,64732445433397248,1,64733434748076032),(142,64733434748076032,0,64733434748076032),(145,64734439120306176,1,64735109005180928),(146,64735109005180928,0,64735109005180928),(149,64734439120306176,1,64735337888350208),(150,64735337888350208,0,64735337888350208),(151,64735619451977728,0,64735619451977728),(152,64734439120306176,1,64735619451977728);
/*!40000 ALTER TABLE `tb_button_relation` ENABLE KEYS */;
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
-- Table structure for table `tb_menu`
--

DROP TABLE IF EXISTS `tb_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_menu` (
  `id` bigint(20) NOT NULL,
  `create_on` datetime(6) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `idx` int(11) DEFAULT NULL,
  `title` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_menu_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_menu`
--

LOCK TABLES `tb_menu` WRITE;
/*!40000 ALTER TABLE `tb_menu` DISABLE KEYS */;
INSERT INTO `tb_menu` VALUES (57038146436595712,'2020-06-06 17:29:13.831000','','el-icon-s-custom','menu_user',0,'/user',1,'用戶管理'),(57387567816900608,'2020-06-07 16:37:42.482000','','','menu_company_disabled',0,'/company/disabled',2,'禁用列表'),(64708401472471040,'2020-06-27 21:28:05.140000','','el-icon-s-promotion','menu_app',0,'',0,'應用管理'),(64708637112664064,'2020-06-27 21:29:01.318000','','','menu_app_list',0,'/app/list',1,'應用列表'),(64708764602728448,'2020-06-27 21:29:31.715000','','','menu_app_version',0,'/app/version',2,'應用版本'),(64709012037304320,'2020-06-27 21:30:30.708000','','','menu_app_task',0,'/app/task',3,'安排升級'),(64709151489523712,'2020-06-27 21:31:03.955000','','','menu_app_records',0,'/app/records',4,'升級記錄'),(64709249820786688,'2020-06-27 21:31:27.399000','','','menu_user_list',0,'/user/',1,'用戶列表'),(64709687035035648,'2020-06-27 21:33:11.638000','','el-icon-cpu','menu_device',0,'/device',0,'設備管理'),(64709823660294144,'2020-06-27 21:33:44.213000','','','menu_device_type',0,'/device/type',1,'設備類型'),(64710199159554048,'2020-06-27 21:35:13.739000','','','menu_device_version',0,'/device/version',2,'設備版本'),(64710418429378560,'2020-06-27 21:36:06.017000','','','menu_device_list',0,'/device/list',4,'設備列表'),(64710527057657856,'2020-06-27 21:36:31.915000','','','menu_device_data',0,'/device/data',5,'生產數據'),(64710710763978752,'2020-06-27 21:37:15.714000','','','menu_device_exception',0,'/device/exception',6,'異常數據'),(64710964972355584,'2020-06-27 21:38:16.322000','','el-icon-s-tools','menu_system',0,'/system',0,'系統管理'),(64711118173503488,'2020-06-27 21:38:52.849000','','','menu_system_resource',0,'/system/resource',1,'資源管理'),(64711257038520320,'2020-06-27 21:39:25.957000','','','menu_system_authority',0,'/system/authority',2,'權限管理'),(64711378295848960,'2020-06-27 21:39:54.867000','','','menu_system_role',0,'/system/role',3,'角色管理'),(64711481190514688,'2020-06-27 21:40:19.398000','','','menu_system_company',0,'/system/company',4,'部門管理'),(64712804866719744,'2020-06-27 21:45:34.989000','','','menu_device_add',0,'/device/add',3,'錄入設備');
/*!40000 ALTER TABLE `tb_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_menu_relation`
--

DROP TABLE IF EXISTS `tb_menu_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_menu_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ancestor` bigint(20) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `descendant` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_menu_relation` (`ancestor`,`descendant`),
  KEY `idx_menu_relation_ancestor` (`ancestor`),
  KEY `idx_menu_relation_descendant` (`descendant`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_menu_relation`
--

LOCK TABLES `tb_menu_relation` WRITE;
/*!40000 ALTER TABLE `tb_menu_relation` DISABLE KEYS */;
INSERT INTO `tb_menu_relation` VALUES (1,57028864446038016,0,57028864446038016),(4,57038146436595712,0,57038146436595712),(7,57028864446038016,1,57387567816900608),(8,57387567816900608,0,57387567816900608),(9,64708401472471040,0,64708401472471040),(10,64708637112664064,0,64708637112664064),(11,64708401472471040,1,64708637112664064),(12,64708764602728448,0,64708764602728448),(13,64708401472471040,1,64708764602728448),(14,64709012037304320,0,64709012037304320),(15,64708401472471040,1,64709012037304320),(16,64709151489523712,0,64709151489523712),(17,64708401472471040,1,64709151489523712),(20,57038146436595712,1,64709249820786688),(21,64709249820786688,0,64709249820786688),(22,64709687035035648,0,64709687035035648),(23,64709823660294144,0,64709823660294144),(24,64709687035035648,1,64709823660294144),(25,64710199159554048,0,64710199159554048),(26,64709687035035648,1,64710199159554048),(29,64710418429378560,0,64710418429378560),(30,64709687035035648,1,64710418429378560),(33,64709687035035648,1,64710527057657856),(34,64710527057657856,0,64710527057657856),(35,64710710763978752,0,64710710763978752),(36,64709687035035648,1,64710710763978752),(37,64710964972355584,0,64710964972355584),(38,64711118173503488,0,64711118173503488),(39,64710964972355584,1,64711118173503488),(40,64711257038520320,0,64711257038520320),(41,64710964972355584,1,64711257038520320),(42,64711378295848960,0,64711378295848960),(43,64710964972355584,1,64711378295848960),(44,64711481190514688,0,64711481190514688),(45,64710964972355584,1,64711481190514688),(46,64709687035035648,1,64710324783153152),(47,64710324783153152,0,64710324783153152),(48,64712804866719744,0,64712804866719744),(49,64709687035035648,1,64712804866719744);
/*!40000 ALTER TABLE `tb_menu_relation` ENABLE KEYS */;
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
INSERT INTO `tb_permission` VALUES (64731417417875456,'2020-06-27 22:59:32.566000','用戶信息的增、改、查、刪','authority_user_admin',0,'用戶管理員'),(64731681772273664,'2020-06-27 23:00:35.593000','查看用戶信息','authority_user_view',0,'查看用戶'),(64736525400670208,'2020-06-27 23:19:50.404000','類型、版本、錄入、升級、數據','authority_dev_admin',0,'設備管理員'),(64737262281162752,'2020-06-27 23:22:46.090000','查看設備、查看生產、異常數據','authority_dev_view',0,'查看設備');
/*!40000 ALTER TABLE `tb_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_permission_button`
--

DROP TABLE IF EXISTS `tb_permission_button`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_permission_button` (
  `permission_id` bigint(20) NOT NULL,
  `button_id` bigint(20) NOT NULL,
  KEY `FK2yhi8oeis3wf8rli6c2llm6g8` (`button_id`),
  KEY `FKsqilntlc4py6kd7x52cqxq2bk` (`permission_id`),
  CONSTRAINT `FK2yhi8oeis3wf8rli6c2llm6g8` FOREIGN KEY (`button_id`) REFERENCES `tb_button` (`id`),
  CONSTRAINT `FKsqilntlc4py6kd7x52cqxq2bk` FOREIGN KEY (`permission_id`) REFERENCES `tb_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_permission_button`
--

LOCK TABLES `tb_permission_button` WRITE;
/*!40000 ALTER TABLE `tb_permission_button` DISABLE KEYS */;
INSERT INTO `tb_permission_button` VALUES (64731417417875456,64729727885115392),(64731417417875456,64729923851386880),(64731417417875456,64730256740712448),(64731417417875456,64730423002923008),(64731417417875456,64730815581388800),(64736525400670208,64732609233551360),(64736525400670208,64732794672119808),(64736525400670208,64733216287752192),(64736525400670208,64733434748076032),(64736525400670208,64734736995581952),(64736525400670208,64735109005180928),(64736525400670208,64735337888350208),(64736525400670208,64735619451977728);
/*!40000 ALTER TABLE `tb_permission_button` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_permission_menu`
--

DROP TABLE IF EXISTS `tb_permission_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_permission_menu` (
  `permission_id` bigint(20) NOT NULL,
  `menu_id` bigint(20) NOT NULL,
  KEY `FKc03g80a0k4uljt3hx5198ja8a` (`menu_id`),
  KEY `FKk6ig97k7mk15l7lp2mgxhwlkj` (`permission_id`),
  CONSTRAINT `FKc03g80a0k4uljt3hx5198ja8a` FOREIGN KEY (`menu_id`) REFERENCES `tb_menu` (`id`),
  CONSTRAINT `FKk6ig97k7mk15l7lp2mgxhwlkj` FOREIGN KEY (`permission_id`) REFERENCES `tb_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_permission_menu`
--

LOCK TABLES `tb_permission_menu` WRITE;
/*!40000 ALTER TABLE `tb_permission_menu` DISABLE KEYS */;
INSERT INTO `tb_permission_menu` VALUES (64731417417875456,57038146436595712),(64731417417875456,64709249820786688),(64731681772273664,57038146436595712),(64731681772273664,64709249820786688),(64736525400670208,64709687035035648),(64736525400670208,64709823660294144),(64736525400670208,64710199159554048),(64736525400670208,64710418429378560),(64736525400670208,64710527057657856),(64736525400670208,64710710763978752),(64736525400670208,64712804866719744),(64737262281162752,64709687035035648),(64737262281162752,64710418429378560),(64737262281162752,64710527057657856),(64737262281162752,64710710763978752);
/*!40000 ALTER TABLE `tb_permission_menu` ENABLE KEYS */;
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
INSERT INTO `tb_role` VALUES (64736693365768192,'2020-06-27 23:20:30.456000','','role_system_admin',0,'系統管理員'),(64737358171340800,'2020-06-27 23:23:08.952000','查看用戶、查看設備基本信息','role_user',0,'基本用戶');
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
INSERT INTO `tb_role_permission` VALUES (64736693365768192,64731417417875456),(64736693365768192,64731681772273664),(64736693365768192,64736525400670208),(64737358171340800,64731681772273664),(64737358171340800,64737262281162752);
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

-- Dump completed on 2020-06-27 23:35:31
