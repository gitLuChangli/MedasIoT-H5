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
INSERT INTO `tb_button` VALUES (57406125863075840,NULL,'無實際按鈕功能，只爲分組使用','','button_company',0,'/api/company/','GET','部門按鈕'),(57410030810431488,NULL,'','el-icon-plus','button_company_new',0,'/api/company/','POST','新增'),(57410377264136192,NULL,'','el-icon-edit','button_company_edit',0,'/api/company/','PUT','修改'),(57410870115827712,NULL,'','el-icon-remove-outline','button_company_disable',0,'/api/company/disable/','PUT','禁用'),(57425509700599808,NULL,'','el-icon-close','button_company_delete',0,'/api/company/','DELETE','删除');
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_button_relation`
--

LOCK TABLES `tb_button_relation` WRITE;
/*!40000 ALTER TABLE `tb_button_relation` DISABLE KEYS */;
INSERT INTO `tb_button_relation` VALUES (1,57406125863075840,0,57406125863075840),(2,57410030810431488,0,57410030810431488),(3,57406125863075840,1,57410030810431488),(4,57410377264136192,0,57410377264136192),(5,57406125863075840,1,57410377264136192),(6,57410679434379264,0,57410679434379264),(7,57406125863075840,1,57410679434379264),(8,57410870115827712,0,57410870115827712),(9,57406125863075840,1,57410870115827712),(10,57421403388903424,0,57421403388903424),(11,57406125863075840,1,57421403388903424),(21,57425509700599808,0,57425509700599808),(22,57406125863075840,1,57425509700599808);
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_dev_sn` (`sn`),
  KEY `FKi6veayihojw95427btimi5h9c` (`company_id`),
  KEY `FK13pb7hoj8uqjvfdbkmpm44h4q` (`dev_group_id`),
  KEY `FKf8ubnlwj1n7egp3ivanrsg3fd` (`ver_id`),
  CONSTRAINT `FK13pb7hoj8uqjvfdbkmpm44h4q` FOREIGN KEY (`dev_group_id`) REFERENCES `tb_dev_group` (`id`),
  CONSTRAINT `FKf8ubnlwj1n7egp3ivanrsg3fd` FOREIGN KEY (`ver_id`) REFERENCES `tb_dev_version` (`id`),
  CONSTRAINT `FKi6veayihojw95427btimi5h9c` FOREIGN KEY (`company_id`) REFERENCES `tb_company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_dev`
--

LOCK TABLES `tb_dev` WRITE;
/*!40000 ALTER TABLE `tb_dev` DISABLE KEYS */;
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
INSERT INTO `tb_menu` VALUES (57028864446038016,'2020-06-06 16:52:20.947000','選擇子菜單時，父菜單必須勾選','el-icon-office-building','menu_company',0,'/company',0,'部門管理'),(57033074608701440,'2020-06-06 17:09:04.691000','','','menu_company_list',0,'/company/list',1,'部門列表'),(57038146436595712,'2020-06-06 17:29:13.831000','','el-icon-s-custom','menu_user',0,'/user',1,'用戶管理'),(57387567816900608,'2020-06-07 16:37:42.482000','','','menu_company_disabled',0,'/company/disabled',2,'禁用列表');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_menu_relation`
--

LOCK TABLES `tb_menu_relation` WRITE;
/*!40000 ALTER TABLE `tb_menu_relation` DISABLE KEYS */;
INSERT INTO `tb_menu_relation` VALUES (1,57028864446038016,0,57028864446038016),(2,57033074608701440,0,57033074608701440),(3,57028864446038016,1,57033074608701440),(4,57038146436595712,0,57038146436595712),(5,57387567816900608,0,57387567816900608),(6,57028864446038016,1,57387567816900608);
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
INSERT INTO `tb_permission` VALUES (58168019393708032,'2020-06-09 20:18:56.616000','','authority_company_admin',0,'部門管理-系統管理員'),(59903363919118336,'2020-06-14 15:14:34.913000','','authority_company_view',0,'查看部門');
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
INSERT INTO `tb_permission_button` VALUES (58168019393708032,57410377264136192),(58168019393708032,57425509700599808),(58168019393708032,57410870115827712),(58168019393708032,57410030810431488);
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
INSERT INTO `tb_permission_menu` VALUES (58168019393708032,57387567816900608),(58168019393708032,57033074608701440),(58168019393708032,57028864446038016),(59903363919118336,57028864446038016),(59903363919118336,57033074608701440);
/*!40000 ALTER TABLE `tb_permission_menu` ENABLE KEYS */;
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
INSERT INTO `tb_role` VALUES (59936479765331968,'2020-06-14 17:26:10.433000','可以使用所有功能','role_admin',0,'系統管理員');
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
INSERT INTO `tb_role_permission` VALUES (59936479765331968,58168019393708032),(59936479765331968,59903363919118336);
/*!40000 ALTER TABLE `tb_role_permission` ENABLE KEYS */;
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
INSERT INTO `tb_user` VALUES (56305110317268992,NULL,'2020-06-04 16:56:24.417000','hzlh-cmc-rd1system@mail.foxconn.com','5060+73763','','盧昌利','W0515366','','13249466549','$2a$10$n7oExiKKWEXe2a.V5UX9i.4ebFH4PQhiVdfNHk9SR6tDWGrZTsep2',0,55454030171734016),(56946040233787392,NULL,'2020-06-06 11:23:14.039000','hzlh-cmc-rfid@mail.foxconn.com','5060+73763','','盧昌利2','W0515367','','13249466548','$2a$10$AYskrIkEUj5YeOb2uLq41uVy3NHcEixwcRq2y9KDQlZ43qnXPGkVy',0,55464266177708032);
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

-- Dump completed on 2020-06-15  0:29:09
