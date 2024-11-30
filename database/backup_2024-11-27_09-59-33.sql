mysqldump: Error: 'Access denied; you need (at least one of) the PROCESS privilege(s) for this operation' when trying to dump tablespaces
-- MariaDB dump 10.19  Distrib 10.11.6-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: cbt-db    Database: cityboardtorrejon
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `c_estados`
--

DROP TABLE IF EXISTS `c_estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `c_estados` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del estado',
  `nombre_estado` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre del estado',
  `descripcion` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Descripción del estado',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_estados`
--

LOCK TABLES `c_estados` WRITE;
/*!40000 ALTER TABLE `c_estados` DISABLE KEYS */;
INSERT INTO `c_estados` VALUES
(1,'activo','El cartel está activo y funcionando correctamente'),
(2,'inactivo','El cartel está inactivo y no está mostrando contenido'),
(3,'mantenimiento','El cartel está en mantenimiento'),
(4,'desinstalado','El cartel ha sido desinstalado'),
(5,'error','El cartel presenta un error técnico'),
(6,'activo','El cartel está activo y funcionando correctamente'),
(7,'inactivo','El cartel está inactivo y no está mostrando contenido'),
(8,'mantenimiento','El cartel está en mantenimiento'),
(9,'desinstalado','El cartel ha sido desinstalado'),
(10,'error','El cartel presenta un error técnico'),
(11,'activo','El cartel está activo y funcionando correctamente'),
(12,'inactivo','El cartel está inactivo y no está mostrando contenido'),
(13,'mantenimiento','El cartel está en mantenimiento'),
(14,'desinstalado','El cartel ha sido desinstalado'),
(15,'error','El cartel presenta un error técnico'),
(16,'activo','El cartel está activo y funcionando correctamente'),
(17,'inactivo','El cartel está inactivo y no está mostrando contenido'),
(18,'mantenimiento','El cartel está en mantenimiento'),
(19,'desinstalado','El cartel ha sido desinstalado'),
(20,'error','El cartel presenta un error técnico'),
(21,'activo','El cartel está activo y funcionando correctamente'),
(22,'inactivo','El cartel está inactivo y no está mostrando contenido'),
(23,'mantenimiento','El cartel está en mantenimiento'),
(24,'desinstalado','El cartel ha sido desinstalado'),
(25,'error','El cartel presenta un error técnico'),
(26,'activo','El cartel está activo y funcionando correctamente'),
(27,'inactivo','El cartel está inactivo y no está mostrando contenido'),
(28,'mantenimiento','El cartel está en mantenimiento'),
(29,'desinstalado','El cartel ha sido desinstalado'),
(30,'error','El cartel presenta un error técnico'),
(31,'activo','El cartel está activo y funcionando correctamente'),
(32,'inactivo','El cartel está inactivo y no está mostrando contenido'),
(33,'mantenimiento','El cartel está en mantenimiento'),
(34,'desinstalado','El cartel ha sido desinstalado'),
(35,'error','El cartel presenta un error técnico'),
(36,'activo','El cartel está activo y funcionando correctamente'),
(37,'inactivo','El cartel está inactivo y no está mostrando contenido'),
(38,'mantenimiento','El cartel está en mantenimiento'),
(39,'desinstalado','El cartel ha sido desinstalado'),
(40,'error','El cartel presenta un error técnico'),
(41,'activo','El cartel está activo y funcionando correctamente'),
(42,'inactivo','El cartel está inactivo y no está mostrando contenido'),
(43,'mantenimiento','El cartel está en mantenimiento'),
(44,'desinstalado','El cartel ha sido desinstalado'),
(45,'error','El cartel presenta un error técnico');
/*!40000 ALTER TABLE `c_estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_tiposcarteles`
--

DROP TABLE IF EXISTS `c_tiposcarteles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `c_tiposcarteles` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del tipo de cartel',
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Descripción del tipo de cartel',
  `atributos` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Atributos adicionales del tipo de cartel',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla que almacena los diferentes tipos de carteles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_tiposcarteles`
--

LOCK TABLES `c_tiposcarteles` WRITE;
/*!40000 ALTER TABLE `c_tiposcarteles` DISABLE KEYS */;
INSERT INTO `c_tiposcarteles` VALUES
(1,'Cartel Torrejón','{\r\n  \"ocupacionParkings\": [\r\n    {\r\n      \"nombre\": \"Parking A\",\r\n      \"ocupacion\": 120\r\n    },\r\n    {\r\n      \"nombre\": \"Parking B\",\r\n      \"ocupacion\": 85\r\n    },\r\n    {\r\n      \"nombre\": \"Parking C\",\r\n      \"ocupacion\": 150\r\n    },\r\n    {\r\n      \"nombre\": \"Parking D\",\r\n      \"ocupacion\": 60\r\n    }\r\n  ]\r\n}'),
(2,'Cartel Mini','{\r\n  \"ocupacionParkings\": [\r\n    {\r\n      \"nombre\": \"Parking A\",\r\n      \"ocupacion\": 120\r\n    },\r\n    {\r\n      \"nombre\": \"Parking B\",\r\n      \"ocupacion\": 85\r\n    },\r\n    {\r\n      \"nombre\": \"Parking C\",\r\n      \"ocupacion\": 150\r\n    },\r\n    {\r\n      \"nombre\": \"Parking D\",\r\n      \"ocupacion\": 60\r\n    }\r\n  ]\r\n}\r\n'),
(3,'Cartel Torrejón sin rotulo','{\r\n  \"ocupacionParkings\": [\r\n    {\r\n      \"nombre\": \"Parking A\",\r\n      \"ocupacion\": 120\r\n    },\r\n    {\r\n      \"nombre\": \"Parking B\",\r\n      \"ocupacion\": 85\r\n    },\r\n    {\r\n      \"nombre\": \"Parking C\",\r\n      \"ocupacion\": 150\r\n    },\r\n    {\r\n      \"nombre\": \"Parking D\",\r\n      \"ocupacion\": 60\r\n    }\r\n  ]\r\n}\r\n');
/*!40000 ALTER TABLE `c_tiposcarteles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carteles`
--

DROP TABLE IF EXISTS `carteles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carteles` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del cartel',
  `nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Nombre del cartel',
  `latitud` decimal(10,7) unsigned DEFAULT NULL COMMENT 'Latitud geográfica del cartel',
  `longitud` decimal(10,7) NOT NULL COMMENT 'Longitud geográfica del cartel',
  `id_tipocartel` int NOT NULL COMMENT 'Id de tipo de cartel',
  `rotativo` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Texto rotativo o desplazante de cartel',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_latitud_longitud` (`latitud`,`longitud`),
  KEY `FK_carteles_c_tiposcarteles` (`id_tipocartel`),
  CONSTRAINT `FK_carteles_c_tiposcarteles` FOREIGN KEY (`id_tipocartel`) REFERENCES `c_tiposcarteles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carteles`
--

LOCK TABLES `carteles` WRITE;
/*!40000 ALTER TABLE `carteles` DISABLE KEYS */;
INSERT INTO `carteles` VALUES
(1,'Juzgados222',40.4581746,-3.4835560,2,'¡DESCUBRE TORREJÓN! EXPLORA CULTURA, GASTRONOMÍA Y NATURALEZA – #VIVATORREJÓN Y SUS PAISANOS!!'),
(2,'Cartel 443',40.4513001,-3.4698002,3,'TORREJÓN TE ESPERA: EVENTOS, PARQUES Y MUCHO MÁS – DISFRÚTALO A TOPE!!'),
(3,'Cartel 2',40.4458556,-3.4928928,3,'VIVE TORREJÓN: HISTORIA, SABORES Y NATURALEZA A TU ALCANCE'),
(13,'pppp',44.0000000,44.0000000,2,'4gg'),
(14,'yhyhyt',55.0000000,55.0000000,2,'yyyy');
/*!40000 ALTER TABLE `carteles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `tipo` enum('error','debug','info','sql','validador') COLLATE utf8mb4_unicode_ci NOT NULL,
  `contenido` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `metadata` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `idx_logs_fecha` (`fecha`),
  KEY `idx_logs_tipo` (`tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=4425 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES
(4058,'2024-11-26 17:09:56','info','Se eliminaron 107 registros de logs',NULL),
(4059,'2024-11-26 17:09:56','info','BaseController inicializado para tabla: logs',NULL),
(4060,'2024-11-26 17:09:56','sql','SELECT * FROM logs WHERE fecha >= \'2024-11-25 18:08:43\'','{\"tabla\":\"logs\",\"query_raw\":\"SELECT * FROM logs WHERE fecha >= ?\",\"parametros\":[\"2024-11-25 18:08:43\"]}'),
(4061,'2024-11-26 17:10:21','debug','Iniciando obtención de datos Leaflet',NULL),
(4062,'2024-11-26 17:10:21','info','BaseController inicializado para tabla: carteles',NULL),
(4063,'2024-11-26 17:10:21','info','BaseController inicializado para tabla: c_tiposcarteles',NULL),
(4064,'2024-11-26 17:10:21','sql','SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}'),
(4065,'2024-11-26 17:10:21','sql','SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}'),
(4066,'2024-11-26 17:10:21','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4067,'2024-11-26 17:10:21','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4068,'2024-11-26 17:10:21','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4069,'2024-11-26 17:10:26','debug','Iniciando obtención de datos Leaflet',NULL),
(4070,'2024-11-26 17:10:26','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4071,'2024-11-26 17:10:26','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4072,'2024-11-26 17:10:26','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4073,'2024-11-26 17:10:28','info','BaseController inicializado para tabla: carteles',NULL),
(4074,'2024-11-26 17:10:28','info','BaseController inicializado para tabla: c_tiposcarteles',NULL),
(4075,'2024-11-26 17:10:28','sql','SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}'),
(4076,'2024-11-26 17:10:28','sql','SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}'),
(4077,'2024-11-26 17:10:28','info','BaseController inicializado para tabla: c_tiposcarteles',NULL),
(4078,'2024-11-26 17:10:28','sql','SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}'),
(4079,'2024-11-26 17:10:29','info','BaseController inicializado para tabla: c_tiposcarteles',NULL),
(4080,'2024-11-26 17:10:29','sql','SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}'),
(4081,'2024-11-26 17:10:30','info','BaseController inicializado para tabla: parkings',NULL),
(4082,'2024-11-26 17:10:30','sql','SELECT * FROM parkings','{\"tabla\":\"parkings\",\"query_raw\":\"SELECT * FROM parkings\",\"parametros\":[]}'),
(4083,'2024-11-26 17:10:31','info','BaseController inicializado para tabla: logs',NULL),
(4084,'2024-11-26 17:10:31','sql','SELECT * FROM logs WHERE tipo = \'error\'','{\"tabla\":\"logs\",\"query_raw\":\"SELECT * FROM logs WHERE tipo = ?\",\"parametros\":[\"error\"]}'),
(4085,'2024-11-26 17:10:35','info','BaseController inicializado para tabla: usuarios',NULL),
(4086,'2024-11-26 17:10:35','sql','SELECT * FROM usuarios','{\"tabla\":\"usuarios\",\"query_raw\":\"SELECT * FROM usuarios\",\"parametros\":[]}'),
(4087,'2024-11-26 17:11:01','debug','Iniciando obtención de datos Leaflet',NULL),
(4088,'2024-11-26 17:11:01','info','BaseController inicializado para tabla: carteles',NULL),
(4089,'2024-11-26 17:11:01','info','BaseController inicializado para tabla: c_tiposcarteles',NULL),
(4090,'2024-11-26 17:11:01','sql','SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}'),
(4091,'2024-11-26 17:11:01','sql','SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}'),
(4092,'2024-11-26 17:11:01','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4093,'2024-11-26 17:11:01','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4094,'2024-11-26 17:11:01','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4095,'2024-11-26 17:11:06','debug','Iniciando obtención de datos Leaflet',NULL),
(4096,'2024-11-26 17:11:06','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4097,'2024-11-26 17:11:06','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4098,'2024-11-26 17:11:06','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4099,'2024-11-26 17:11:11','debug','Iniciando obtención de datos Leaflet',NULL),
(4100,'2024-11-26 17:11:11','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4101,'2024-11-26 17:11:11','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4102,'2024-11-26 17:11:11','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4103,'2024-11-26 17:11:16','debug','Iniciando obtención de datos Leaflet',NULL),
(4104,'2024-11-26 17:11:16','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4105,'2024-11-26 17:11:16','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4106,'2024-11-26 17:11:16','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4107,'2024-11-26 17:11:21','debug','Iniciando obtención de datos Leaflet',NULL),
(4108,'2024-11-26 17:11:21','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4109,'2024-11-26 17:11:21','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4110,'2024-11-26 17:11:21','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4111,'2024-11-26 17:11:26','debug','Iniciando obtención de datos Leaflet',NULL),
(4112,'2024-11-26 17:11:26','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4113,'2024-11-26 17:11:26','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4114,'2024-11-26 17:11:26','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4115,'2024-11-26 17:11:31','debug','Iniciando obtención de datos Leaflet',NULL),
(4116,'2024-11-26 17:11:31','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4117,'2024-11-26 17:11:31','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4118,'2024-11-26 17:11:31','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4119,'2024-11-26 17:11:36','debug','Iniciando obtención de datos Leaflet',NULL),
(4120,'2024-11-26 17:11:36','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4121,'2024-11-26 17:11:36','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4122,'2024-11-26 17:11:36','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4123,'2024-11-26 17:11:41','debug','Iniciando obtención de datos Leaflet',NULL),
(4124,'2024-11-26 17:11:41','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4125,'2024-11-26 17:11:41','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4126,'2024-11-26 17:11:41','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4127,'2024-11-26 17:11:46','debug','Iniciando obtención de datos Leaflet',NULL),
(4128,'2024-11-26 17:11:46','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4129,'2024-11-26 17:11:46','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4130,'2024-11-26 17:11:46','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4131,'2024-11-26 17:11:51','debug','Iniciando obtención de datos Leaflet',NULL),
(4132,'2024-11-26 17:11:51','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4133,'2024-11-26 17:11:51','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4134,'2024-11-26 17:11:51','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4135,'2024-11-26 17:11:56','debug','Iniciando obtención de datos Leaflet',NULL),
(4136,'2024-11-26 17:11:56','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4137,'2024-11-26 17:11:56','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4138,'2024-11-26 17:11:56','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4139,'2024-11-26 17:12:01','debug','Iniciando obtención de datos Leaflet',NULL),
(4140,'2024-11-26 17:12:01','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4141,'2024-11-26 17:12:01','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4142,'2024-11-26 17:12:01','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4143,'2024-11-26 17:12:06','debug','Iniciando obtención de datos Leaflet',NULL),
(4144,'2024-11-26 17:12:06','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4145,'2024-11-26 17:12:06','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4146,'2024-11-26 17:12:06','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4147,'2024-11-26 17:12:11','debug','Iniciando obtención de datos Leaflet',NULL),
(4148,'2024-11-26 17:12:11','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4149,'2024-11-26 17:12:11','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4150,'2024-11-26 17:12:11','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4151,'2024-11-26 17:12:16','debug','Iniciando obtención de datos Leaflet',NULL),
(4152,'2024-11-26 17:12:16','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4153,'2024-11-26 17:12:16','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4154,'2024-11-26 17:12:16','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4155,'2024-11-26 17:12:25','debug','Iniciando obtención de datos Leaflet',NULL),
(4156,'2024-11-26 17:12:25','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4157,'2024-11-26 17:12:25','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4158,'2024-11-26 17:12:25','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4159,'2024-11-26 17:12:27','info','BaseController inicializado para tabla: logs',NULL),
(4160,'2024-11-26 17:12:27','sql','SELECT * FROM logs WHERE tipo = \'error\'','{\"tabla\":\"logs\",\"query_raw\":\"SELECT * FROM logs WHERE tipo = ?\",\"parametros\":[\"error\"]}'),
(4161,'2024-11-26 17:12:58','info','BaseController inicializado para tabla: logs',NULL),
(4162,'2024-11-26 17:12:58','sql','SELECT * FROM logs WHERE tipo = \'error\'','{\"tabla\":\"logs\",\"query_raw\":\"SELECT * FROM logs WHERE tipo = ?\",\"parametros\":[\"error\"]}'),
(4163,'2024-11-26 17:13:58','info','BaseController inicializado para tabla: logs',NULL),
(4164,'2024-11-26 17:13:58','sql','SELECT * FROM logs WHERE tipo = \'error\'','{\"tabla\":\"logs\",\"query_raw\":\"SELECT * FROM logs WHERE tipo = ?\",\"parametros\":[\"error\"]}'),
(4165,'2024-11-27 08:34:23','debug','Iniciando proceso de login',NULL),
(4166,'2024-11-27 08:34:23','debug','Verificando credenciales','{\"email\":\"agimeno@equinsa.es\"}'),
(4167,'2024-11-27 08:34:23','sql','SELECT * FROM usuarios WHERE email = \'agimeno@equinsa.es\' AND pass = \'8ae05fbff8d9b4fe1c8d1c0a773d65432a580b4f38f20525673174830e872338\'','{\"tabla\":\"usuarios\",\"query_raw\":\"SELECT * FROM usuarios WHERE email = ? AND pass = ?\",\"parametros\":[\"agimeno@equinsa.es\",\"8ae05fbff8d9b4fe1c8d1c0a773d65432a580b4f38f20525673174830e872338\"]}'),
(4168,'2024-11-27 08:34:23','sql','UPDATE usuarios SET token = \'a4589677796909464e20eec998c117f32cf3d6875f4dfe5a9cf18398ac040eeb\' WHERE email = \'agimeno@equinsa.es\'','{\"tabla\":\"usuarios\",\"query_raw\":\"UPDATE usuarios SET token = ? WHERE email = ?\",\"parametros\":[\"a4589677796909464e20eec998c117f32cf3d6875f4dfe5a9cf18398ac040eeb\",\"agimeno@equinsa.es\"]}'),
(4169,'2024-11-27 08:34:23','info','Login exitoso','{\"usuario_id\":2,\"email\":\"agimeno@equinsa.es\"}'),
(4170,'2024-11-27 08:34:23','debug','Iniciando obtención de datos Leaflet',NULL),
(4171,'2024-11-27 08:34:23','info','BaseController inicializado para tabla: carteles',NULL),
(4172,'2024-11-27 08:34:23','info','BaseController inicializado para tabla: c_tiposcarteles',NULL),
(4173,'2024-11-27 08:34:23','sql','SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}'),
(4174,'2024-11-27 08:34:23','sql','SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}'),
(4175,'2024-11-27 08:34:24','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4176,'2024-11-27 08:34:24','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4177,'2024-11-27 08:34:24','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4178,'2024-11-27 08:40:14','info','Obteniendo información del último backup',NULL),
(4179,'2024-11-27 08:40:14','debug','Directorio de backups: /var/www/html/database',NULL),
(4180,'2024-11-27 08:40:14','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}'),
(4181,'2024-11-27 08:40:14','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}'),
(4182,'2024-11-27 08:40:14','debug','Último backup encontrado','{\"archivo\":\"backup_2511241114.sql\",\"fecha\":\"2024-11-25 11:14:04\"}'),
(4183,'2024-11-27 08:40:14','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-25T11:14:04+00:00\",\"fecha_formateada\":\"2024-11-25 11:14:04\",\"archivo\":\"backup_2511241114.sql\",\"tama\\u00f1o\":79701,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"}}'),
(4184,'2024-11-27 08:40:14','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-25T11:14:04+00:00\",\"fecha_formateada\":\"2024-11-25 11:14:04\",\"archivo\":\"backup_2511241114.sql\",\"tama\\u00f1o\":79701,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"}}'),
(4185,'2024-11-27 08:41:51','info','Obteniendo información del último backup',NULL),
(4186,'2024-11-27 08:41:51','debug','Directorio de backups: /var/www/html/database',NULL),
(4187,'2024-11-27 08:41:51','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}'),
(4188,'2024-11-27 08:41:51','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}'),
(4189,'2024-11-27 08:41:51','debug','Último backup encontrado','{\"archivo\":\"backup_2511241114.sql\",\"fecha\":\"2024-11-25 11:14:04\"}'),
(4190,'2024-11-27 08:41:51','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-25T11:14:04+00:00\",\"fecha_formateada\":\"2024-11-25 11:14:04\",\"archivo\":\"backup_2511241114.sql\",\"tama\\u00f1o\":79701,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"}}'),
(4191,'2024-11-27 08:41:51','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-25T11:14:04+00:00\",\"fecha_formateada\":\"2024-11-25 11:14:04\",\"archivo\":\"backup_2511241114.sql\",\"tama\\u00f1o\":79701,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"}}'),
(4192,'2024-11-27 08:41:56','info','Obteniendo información del último backup',NULL),
(4193,'2024-11-27 08:41:56','debug','Directorio de backups: /var/www/html/database',NULL),
(4194,'2024-11-27 08:41:56','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}'),
(4195,'2024-11-27 08:41:56','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}'),
(4196,'2024-11-27 08:41:56','debug','Último backup encontrado','{\"archivo\":\"backup_2511241114.sql\",\"fecha\":\"2024-11-25 11:14:04\"}'),
(4197,'2024-11-27 08:41:56','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-25T11:14:04+00:00\",\"fecha_formateada\":\"2024-11-25 11:14:04\",\"archivo\":\"backup_2511241114.sql\",\"tama\\u00f1o\":79701,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"}}'),
(4198,'2024-11-27 08:41:56','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-25T11:14:04+00:00\",\"fecha_formateada\":\"2024-11-25 11:14:04\",\"archivo\":\"backup_2511241114.sql\",\"tama\\u00f1o\":79701,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"}}'),
(4199,'2024-11-27 08:45:28','debug','Creando backup',NULL),
(4200,'2024-11-27 08:45:28','debug','Directorio de backups: /var/www/html/database',NULL),
(4201,'2024-11-27 08:45:28','debug','BACKUP_DIR configurado: /var/www/html/database',NULL),
(4202,'2024-11-27 08:45:28','debug','Directorio de backups creado: /var/www/html/database',NULL),
(4203,'2024-11-27 08:45:48','debug','Creando backup',NULL),
(4204,'2024-11-27 08:45:49','debug','Directorio de backups: /var/www/html/database',NULL),
(4205,'2024-11-27 08:45:49','debug','BACKUP_DIR configurado: /var/www/html/database',NULL),
(4206,'2024-11-27 08:45:49','debug','Directorio de backups creado: /var/www/html/database',NULL),
(4207,'2024-11-27 08:46:27','debug','Creando backup',NULL),
(4208,'2024-11-27 08:46:27','debug','Directorio de backups: /var/www/html/database',NULL),
(4209,'2024-11-27 08:46:27','debug','BACKUP_DIR configurado: /var/www/html/database',NULL),
(4210,'2024-11-27 08:46:27','debug','Directorio de backups creado: /var/www/html/database',NULL),
(4211,'2024-11-27 08:46:36','debug','Creando backup',NULL),
(4212,'2024-11-27 08:46:36','debug','Directorio de backups: /var/www/html/database',NULL),
(4213,'2024-11-27 08:46:36','debug','BACKUP_DIR configurado: /var/www/html/database',NULL),
(4214,'2024-11-27 08:46:36','debug','Directorio de backups creado: /var/www/html/database',NULL),
(4215,'2024-11-27 08:47:56','debug','Creando backup',NULL),
(4216,'2024-11-27 08:47:56','debug','Directorio de backups: /var/www/html/database',NULL),
(4217,'2024-11-27 08:47:56','debug','BACKUP_DIR configurado: /var/www/html/database',NULL),
(4218,'2024-11-27 08:47:56','debug','Directorio de backups creado: /var/www/html/database',NULL),
(4219,'2024-11-27 08:49:23','debug','Creando backup',NULL),
(4220,'2024-11-27 08:49:23','debug','Directorio de backups: /var/www/html/database',NULL),
(4221,'2024-11-27 08:49:23','debug','BACKUP_DIR configurado: /var/www/html/database',NULL),
(4222,'2024-11-27 08:49:23','debug','Directorio de backups creado: /var/www/html/database',NULL),
(4223,'2024-11-27 08:49:42','debug','Creando backup',NULL),
(4224,'2024-11-27 08:49:42','debug','Directorio de backups: /var/www/html/database',NULL),
(4225,'2024-11-27 08:49:42','debug','BACKUP_DIR configurado: /var/www/html/database',NULL),
(4226,'2024-11-27 08:49:42','debug','Directorio de backups creado: /var/www/html/database',NULL),
(4227,'2024-11-27 08:50:09','debug','Creando backup',NULL),
(4228,'2024-11-27 08:50:09','debug','Directorio de backups: /var/www/html/database',NULL),
(4229,'2024-11-27 08:50:09','debug','BACKUP_DIR configurado: /var/www/html/database',NULL),
(4230,'2024-11-27 08:50:09','debug','Directorio de backups creado: /var/www/html/database',NULL),
(4231,'2024-11-27 08:50:09','debug','Directorio de backups tiene permisos de escritura','{\"directorio\":\"\\/var\\/www\\/html\\/database\",\"permisos\":16895}'),
(4232,'2024-11-27 08:50:44','debug','Creando backup',NULL),
(4233,'2024-11-27 08:50:44','debug','Directorio de backups: /var/www/html/database',NULL),
(4234,'2024-11-27 08:50:44','debug','BACKUP_DIR configurado: /var/www/html/database',NULL),
(4235,'2024-11-27 08:50:44','debug','Directorio de backups creado: /var/www/html/database',NULL),
(4236,'2024-11-27 08:50:44','debug','Directorio de backups tiene permisos de escritura','{\"directorio\":\"\\/var\\/www\\/html\\/database\",\"permisos\":16895}'),
(4237,'2024-11-27 08:50:44','debug','Configuración de base de datos','{\"config\":{}}'),
(4238,'2024-11-27 08:51:40','debug','Creando backup',NULL),
(4239,'2024-11-27 08:51:40','debug','Directorio de backups: /var/www/html/database',NULL),
(4240,'2024-11-27 08:51:40','debug','BACKUP_DIR configurado: /var/www/html/database',NULL),
(4241,'2024-11-27 08:51:40','debug','Directorio de backups creado: /var/www/html/database',NULL),
(4242,'2024-11-27 08:51:40','debug','Directorio de backups tiene permisos de escritura','{\"directorio\":\"\\/var\\/www\\/html\\/database\",\"permisos\":16895}'),
(4243,'2024-11-27 08:51:40','debug','Configuración de base de datos','{\"config\":{}}'),
(4244,'2024-11-27 08:51:52','debug','Creando backup',NULL),
(4245,'2024-11-27 08:51:52','debug','Directorio de backups: /var/www/html/database',NULL),
(4246,'2024-11-27 08:51:52','debug','BACKUP_DIR configurado: /var/www/html/database',NULL),
(4247,'2024-11-27 08:51:52','debug','Directorio de backups creado: /var/www/html/database',NULL),
(4248,'2024-11-27 08:51:52','debug','Directorio de backups tiene permisos de escritura','{\"directorio\":\"\\/var\\/www\\/html\\/database\",\"permisos\":16895}'),
(4249,'2024-11-27 08:51:52','debug','Configuración de base de datos','{\"config\":{}}'),
(4250,'2024-11-27 08:54:51','debug','Creando backup',NULL),
(4251,'2024-11-27 08:54:51','debug','Directorio de backups: /var/www/html/database',NULL),
(4252,'2024-11-27 08:54:51','debug','BACKUP_DIR configurado: /var/www/html/database',NULL),
(4253,'2024-11-27 08:54:51','debug','Directorio de backups creado: /var/www/html/database',NULL),
(4254,'2024-11-27 08:54:51','debug','Directorio de backups tiene permisos de escritura','{\"directorio\":\"\\/var\\/www\\/html\\/database\",\"permisos\":16895}'),
(4255,'2024-11-27 08:54:51','debug','Configuración de base de datos','{\"config\":{}}'),
(4256,'2024-11-27 08:58:40','debug','Iniciando obtención de datos Leaflet',NULL),
(4257,'2024-11-27 08:58:40','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4258,'2024-11-27 08:58:40','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4259,'2024-11-27 08:58:40','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4260,'2024-11-27 08:58:55','debug','Iniciando obtención de datos Leaflet',NULL),
(4261,'2024-11-27 08:58:55','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4262,'2024-11-27 08:58:55','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4263,'2024-11-27 08:58:55','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4264,'2024-11-27 08:59:44','debug','Iniciando obtención de datos Leaflet',NULL),
(4265,'2024-11-27 08:59:44','info','Carteles obtenidos','{\"cantidad\":5,\"latitudes\":5,\"longitudes\":5}'),
(4266,'2024-11-27 08:59:44','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}'),
(4267,'2024-11-27 08:59:44','info','Datos del mapa calculados','{\"centro\":[42.463383155555555,8.267627066666668],\"limites\":[[40.4426216,-3.7083743],[55,55]],\"total_marcadores\":9}'),
(4268,'2024-11-27 09:03:30','debug','Creando backup',NULL),
(4269,'2024-11-27 09:03:30','debug','Directorio de backups: /var/www/html/database',NULL),
(4270,'2024-11-27 09:03:30','debug','BACKUP_DIR configurado: /var/www/html/database',NULL),
(4271,'2024-11-27 09:03:30','debug','Directorio de backups creado: /var/www/html/database',NULL),
(4272,'2024-11-27 09:03:30','debug','Directorio de backups tiene permisos de escritura','{\"directorio\":\"\\/var\\/www\\/html\\/database\",\"permisos\":16895}'),
(4273,'2024-11-27 09:03:30','debug','Configuración de base de datos','{\"config\":{}}'),
(4274,'2024-11-27 09:04:31','debug','Creando backup',NULL),
(4275,'2024-11-27 09:04:31','debug','Directorio de backups: /var/www/html/database',NULL),
(4276,'2024-11-27 09:04:31','debug','BACKUP_DIR configurado: /var/www/html/database',NULL),
(4277,'2024-11-27 09:04:31','debug','Directorio de backups creado: /var/www/html/database',NULL),
(4278,'2024-11-27 09:04:31','debug','Directorio de backups tiene permisos de escritura','{\"directorio\":\"\\/var\\/www\\/html\\/database\",\"permisos\":16895}'),
(4279,'2024-11-27 09:04:31','debug','Configuración de base de datos','{\"host\":\"cbt-db\",\"database\":\"cityboardtorrejon\",\"user\":\"cbt_user\"}'),
(4280,'2024-11-27 09:04:31','debug','Archivo de backup a crear','{\"archivo\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\"}'),
(4281,'2024-11-27 09:04:31','debug','Timestamp','{\"timestamp\":\"2024-11-27_09-04-31\"}'),
(4282,'2024-11-27 09:04:31','debug','mysqldump disponible','{\"output\":[\"\\/usr\\/bin\\/mysqldump\"]}'),
(4283,'2024-11-27 09:04:31','debug','Ejecutando comando de backup',NULL),
(4284,'2024-11-27 09:04:31','info','Backup creado exitosamente','{\"archivo\":\"backup_2024-11-27_09-04-31.sql\",\"fecha\":\"2024-11-27T09:04:31+00:00\",\"tama\\u00f1o\":66292,\"tama\\u00f1o_formateado\":\"64.74 KB\"}'),
(4285,'2024-11-27 09:05:12','info','=== INICIANDO DESCARGA DE BASE DE DATOS ===',NULL),
(4286,'2024-11-27 09:05:12','info','Verificando mysqldump',NULL),
(4287,'2024-11-27 09:05:12','info','mysqldump encontrado en: /usr/bin/mysqldump',NULL),
(4288,'2024-11-27 09:05:12','info','Probando conexión a la base de datos',NULL),
(4289,'2024-11-27 09:05:12','info','Ejecutando mysqldump',NULL),
(4290,'2024-11-27 09:05:12','debug','Comando (sin password): mysqldump --no-tablespaces --skip-lock-tables --single-transaction --quick --add-drop-table --create-options --extended-insert --set-charset -h\'cbt-db\' -u\'cbt_user\' -p**** \'cityboardtorrejon\' > \'/tmp/sql_Qu0iH4\' 2>&1',NULL),
(4291,'2024-11-27 09:05:17','debug','Creando backup',NULL),
(4292,'2024-11-27 09:05:17','debug','Directorio de backups: /var/www/html/database',NULL),
(4293,'2024-11-27 09:05:17','debug','BACKUP_DIR configurado: /var/www/html/database',NULL),
(4294,'2024-11-27 09:05:17','debug','Directorio de backups creado: /var/www/html/database',NULL),
(4295,'2024-11-27 09:05:17','debug','Directorio de backups tiene permisos de escritura','{\"directorio\":\"\\/var\\/www\\/html\\/database\",\"permisos\":16895}'),
(4296,'2024-11-27 09:05:17','debug','Configuración de base de datos','{\"host\":\"cbt-db\",\"database\":\"cityboardtorrejon\",\"user\":\"cbt_user\"}'),
(4297,'2024-11-27 09:05:17','debug','Archivo de backup a crear','{\"archivo\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\"}'),
(4298,'2024-11-27 09:05:17','debug','Timestamp','{\"timestamp\":\"2024-11-27_09-05-17\"}'),
(4299,'2024-11-27 09:05:17','debug','mysqldump disponible','{\"output\":[\"\\/usr\\/bin\\/mysqldump\"]}'),
(4300,'2024-11-27 09:05:17','debug','Ejecutando comando de backup',NULL),
(4301,'2024-11-27 09:05:17','info','Backup creado exitosamente','{\"archivo\":\"backup_2024-11-27_09-05-17.sql\",\"fecha\":\"2024-11-27T09:05:17+00:00\",\"tama\\u00f1o\":68276,\"tama\\u00f1o_formateado\":\"66.68 KB\"}'),
(4302,'2024-11-27 09:05:25','info','BaseController inicializado para tabla: logs',NULL),
(4303,'2024-11-27 09:05:25','sql','SELECT * FROM logs WHERE tipo = \'error\'','{\"tabla\":\"logs\",\"query_raw\":\"SELECT * FROM logs WHERE tipo = ?\",\"parametros\":[\"error\"]}'),
(4304,'2024-11-27 09:05:27','info','BaseController inicializado para tabla: logs',NULL),
(4305,'2024-11-27 09:05:27','sql','SELECT * FROM logs WHERE tipo = \'debug\'','{\"tabla\":\"logs\",\"query_raw\":\"SELECT * FROM logs WHERE tipo = ?\",\"parametros\":[\"debug\"]}'),
(4306,'2024-11-27 09:05:28','info','BaseController inicializado para tabla: logs',NULL),
(4307,'2024-11-27 09:05:29','sql','SELECT * FROM logs WHERE tipo = \'info\'','{\"tabla\":\"logs\",\"query_raw\":\"SELECT * FROM logs WHERE tipo = ?\",\"parametros\":[\"info\"]}'),
(4308,'2024-11-27 09:05:30','info','BaseController inicializado para tabla: logs',NULL),
(4309,'2024-11-27 09:05:30','sql','SELECT * FROM logs WHERE tipo = \'sql\'','{\"tabla\":\"logs\",\"query_raw\":\"SELECT * FROM logs WHERE tipo = ?\",\"parametros\":[\"sql\"]}'),
(4310,'2024-11-27 09:05:31','info','BaseController inicializado para tabla: logs',NULL),
(4311,'2024-11-27 09:05:31','sql','SELECT * FROM logs WHERE tipo = \'validador\'','{\"tabla\":\"logs\",\"query_raw\":\"SELECT * FROM logs WHERE tipo = ?\",\"parametros\":[\"validador\"]}'),
(4312,'2024-11-27 09:05:32','info','BaseController inicializado para tabla: logs',NULL),
(4313,'2024-11-27 09:05:32','sql','SELECT * FROM logs WHERE tipo = \'sql\'','{\"tabla\":\"logs\",\"query_raw\":\"SELECT * FROM logs WHERE tipo = ?\",\"parametros\":[\"sql\"]}'),
(4314,'2024-11-27 09:06:37','info','BaseController inicializado para tabla: c_tiposcarteles',NULL),
(4315,'2024-11-27 09:06:37','info','BaseController inicializado para tabla: carteles',NULL),
(4316,'2024-11-27 09:06:37','sql','SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}'),
(4317,'2024-11-27 09:06:37','sql','SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}'),
(4318,'2024-11-27 09:06:37','info','BaseController inicializado para tabla: c_tiposcarteles',NULL),
(4319,'2024-11-27 09:06:37','sql','SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}'),
(4320,'2024-11-27 09:06:45','info','BaseController inicializado para tabla: carteles',NULL),
(4321,'2024-11-27 09:06:45','info','Iniciando creación de nuevo registro en carteles',NULL),
(4322,'2024-11-27 09:06:45','debug','Body recibido: {\"nombre\":\"rfrfrf\",\"latitud\":55,\"longitud\":55,\"id_tipocartel\":2,\"rotativo\":\"tfhrthr\"}',NULL),
(4323,'2024-11-27 09:06:45','debug','Datos JSON decodificados: {\"nombre\":\"rfrfrf\",\"latitud\":55,\"longitud\":55,\"id_tipocartel\":2,\"rotativo\":\"tfhrthr\"}',NULL),
(4324,'2024-11-27 09:06:45','info','Iniciando creación en carteles',NULL),
(4325,'2024-11-27 09:06:45','debug','Datos recibidos para creación: {\"nombre\":\"rfrfrf\",\"latitud\":55,\"longitud\":55,\"id_tipocartel\":2,\"rotativo\":\"tfhrthr\"}',NULL),
(4326,'2024-11-27 09:06:45','validador','Inicializando validador','{\"directorio_logs\":\"\\/var\\/www\\/html\\/logs\\/\",\"validaciones_dir\":\".\\/app\\/validaciones\\/\"}'),
(4327,'2024-11-27 09:06:45','validador','Cargando reglas desde directorio: ./app/validaciones/',NULL),
(4328,'2024-11-27 09:06:45','validador','Reglas cargadas para tabla: c_tiposcarteles',NULL),
(4329,'2024-11-27 09:06:45','validador','Reglas cargadas para tabla: carteles',NULL),
(4330,'2024-11-27 09:06:45','validador','Reglas cargadas para tabla: logs',NULL),
(4331,'2024-11-27 09:06:45','validador','Reglas cargadas para tabla: parkings',NULL),
(4332,'2024-11-27 09:06:45','validador','Reglas cargadas para tabla: usuarios',NULL),
(4333,'2024-11-27 09:06:45','validador','Reglas cargadas exitosamente para 5 tablas',NULL),
(4334,'2024-11-27 09:06:45','validador','Iniciando validación','{\"tabla\":\"carteles\",\"es_actualizacion\":false,\"datos\":{\"nombre\":\"rfrfrf\",\"latitud\":55,\"longitud\":55,\"id_tipocartel\":2,\"rotativo\":\"tfhrthr\"}}'),
(4335,'2024-11-27 09:06:45','validador','Procesando campo','{\"tabla\":\"carteles\",\"campo\":\"nombre\",\"reglas\":[\"opcional\",\"string\",\"max:50\"],\"es_actualizacion\":false}'),
(4336,'2024-11-27 09:06:45','validador','Validando campo','{\"campo\":\"nombre\",\"valor\":\"rfrfrf\",\"reglas\":[\"opcional\",\"string\",\"max:50\"]}'),
(4337,'2024-11-27 09:06:45','validador','Aplicando regla','{\"campo\":\"nombre\",\"regla\":\"opcional\",\"parametros\":[]}'),
(4338,'2024-11-27 09:06:45','validador','Aplicando regla','{\"campo\":\"nombre\",\"regla\":\"string\",\"parametros\":[]}'),
(4339,'2024-11-27 09:06:45','validador','Validación string exitosa','{\"campo\":\"nombre\",\"valor\":\"rfrfrf\"}'),
(4340,'2024-11-27 09:06:45','validador','Aplicando regla','{\"campo\":\"nombre\",\"regla\":\"max\",\"parametros\":[\"50\"]}'),
(4341,'2024-11-27 09:06:45','validador','Procesando campo','{\"tabla\":\"carteles\",\"campo\":\"latitud\",\"reglas\":[\"opcional\",\"decimal\",\"min:-90\",\"max:90\"],\"es_actualizacion\":false}'),
(4342,'2024-11-27 09:06:45','validador','Validando campo','{\"campo\":\"latitud\",\"valor\":55,\"reglas\":[\"opcional\",\"decimal\",\"min:-90\",\"max:90\"]}'),
(4343,'2024-11-27 09:06:45','validador','Aplicando regla','{\"campo\":\"latitud\",\"regla\":\"opcional\",\"parametros\":[]}'),
(4344,'2024-11-27 09:06:45','validador','Aplicando regla','{\"campo\":\"latitud\",\"regla\":\"decimal\",\"parametros\":[]}'),
(4345,'2024-11-27 09:06:45','validador','Aplicando regla','{\"campo\":\"latitud\",\"regla\":\"min\",\"parametros\":[\"-90\"]}'),
(4346,'2024-11-27 09:06:45','validador','Validación min exitosa','{\"campo\":\"latitud\",\"valor\":55}'),
(4347,'2024-11-27 09:06:45','validador','Aplicando regla','{\"campo\":\"latitud\",\"regla\":\"max\",\"parametros\":[\"90\"]}'),
(4348,'2024-11-27 09:06:45','validador','Procesando campo','{\"tabla\":\"carteles\",\"campo\":\"longitud\",\"reglas\":[\"requerido\",\"decimal\",\"min:-180\",\"max:180\"],\"es_actualizacion\":false}'),
(4349,'2024-11-27 09:06:45','validador','Validando campo','{\"campo\":\"longitud\",\"valor\":55,\"reglas\":[\"requerido\",\"decimal\",\"min:-180\",\"max:180\"]}'),
(4350,'2024-11-27 09:06:45','validador','Aplicando regla','{\"campo\":\"longitud\",\"regla\":\"requerido\",\"parametros\":[]}'),
(4351,'2024-11-27 09:06:45','validador','Campo requerido validado correctamente','{\"campo\":\"longitud\",\"valor\":55}'),
(4352,'2024-11-27 09:06:45','validador','Aplicando regla','{\"campo\":\"longitud\",\"regla\":\"decimal\",\"parametros\":[]}'),
(4353,'2024-11-27 09:06:45','validador','Aplicando regla','{\"campo\":\"longitud\",\"regla\":\"min\",\"parametros\":[\"-180\"]}'),
(4354,'2024-11-27 09:06:45','validador','Validación min exitosa','{\"campo\":\"longitud\",\"valor\":55}'),
(4355,'2024-11-27 09:06:45','validador','Aplicando regla','{\"campo\":\"longitud\",\"regla\":\"max\",\"parametros\":[\"180\"]}'),
(4356,'2024-11-27 09:06:45','validador','Procesando campo','{\"tabla\":\"carteles\",\"campo\":\"id_tipocartel\",\"reglas\":[\"requerido\",\"entero\",\"min:1\"],\"es_actualizacion\":false}'),
(4357,'2024-11-27 09:06:45','validador','Validando campo','{\"campo\":\"id_tipocartel\",\"valor\":2,\"reglas\":[\"requerido\",\"entero\",\"min:1\"]}'),
(4358,'2024-11-27 09:06:45','validador','Aplicando regla','{\"campo\":\"id_tipocartel\",\"regla\":\"requerido\",\"parametros\":[]}'),
(4359,'2024-11-27 09:06:45','validador','Campo requerido validado correctamente','{\"campo\":\"id_tipocartel\",\"valor\":2}'),
(4360,'2024-11-27 09:06:45','validador','Aplicando regla','{\"campo\":\"id_tipocartel\",\"regla\":\"entero\",\"parametros\":[]}'),
(4361,'2024-11-27 09:06:45','validador','Validación entero exitosa','{\"campo\":\"id_tipocartel\",\"valor\":2}'),
(4362,'2024-11-27 09:06:45','validador','Aplicando regla','{\"campo\":\"id_tipocartel\",\"regla\":\"min\",\"parametros\":[\"1\"]}'),
(4363,'2024-11-27 09:06:45','validador','Validación min exitosa','{\"campo\":\"id_tipocartel\",\"valor\":2}'),
(4364,'2024-11-27 09:06:45','validador','Procesando campo','{\"tabla\":\"carteles\",\"campo\":\"rotativo\",\"reglas\":[\"opcional\",\"string\"],\"es_actualizacion\":false}'),
(4365,'2024-11-27 09:06:45','validador','Validando campo','{\"campo\":\"rotativo\",\"valor\":\"tfhrthr\",\"reglas\":[\"opcional\",\"string\"]}'),
(4366,'2024-11-27 09:06:45','validador','Aplicando regla','{\"campo\":\"rotativo\",\"regla\":\"opcional\",\"parametros\":[]}'),
(4367,'2024-11-27 09:06:45','validador','Aplicando regla','{\"campo\":\"rotativo\",\"regla\":\"string\",\"parametros\":[]}'),
(4368,'2024-11-27 09:06:45','validador','Validación string exitosa','{\"campo\":\"rotativo\",\"valor\":\"tfhrthr\"}'),
(4369,'2024-11-27 09:06:45','validador','Validación exitosa','{\"tabla\":\"carteles\",\"es_actualizacion\":false}'),
(4370,'2024-11-27 09:06:45','debug','Resultado de validación: {\"esValido\":true,\"errores\":[],\"datos\":{\"nombre\":\"rfrfrf\",\"latitud\":55,\"longitud\":55,\"id_tipocartel\":2,\"rotativo\":\"tfhrthr\"}}',NULL),
(4371,'2024-11-27 09:06:45','info','Validación exitosa para creación en carteles',NULL),
(4372,'2024-11-27 09:06:45','debug','Datos a procesar: {\"nombre\":\"rfrfrf\",\"latitud\":55,\"longitud\":55,\"id_tipocartel\":2,\"rotativo\":\"tfhrthr\"}',NULL),
(4373,'2024-11-27 09:06:45','sql','INSERT INTO carteles (nombre, latitud, longitud, id_tipocartel, rotativo) VALUES (\'rfrfrf\', 55, 55, 2, \'tfhrthr\')','{\"tabla\":\"carteles\",\"query_raw\":\"INSERT INTO carteles (nombre, latitud, longitud, id_tipocartel, rotativo) VALUES (?, ?, ?, ?, ?)\",\"parametros\":[\"rfrfrf\",55,55,2,\"tfhrthr\"]}'),
(4374,'2024-11-27 09:06:45','error','Error en consulta SQL','{\"mensaje\":\"SQLSTATE[23000]: Integrity constraint violation: 1062 Duplicate entry \'55.0000000-55.0000000\' for key \'carteles.unique_latitud_longitud\'\",\"codigo\":\"23000\",\"tabla\":\"carteles\",\"trace\":\"#0 \\/var\\/www\\/html\\/vendor\\/bcosca\\/fatfree-core\\/db\\/sql.php(230): PDOStatement->execute()\\n#1 \\/var\\/www\\/html\\/app\\/lib\\/ConsultasSQL.php(225): DB\\\\SQL->exec(Array, Array)\\n#2 \\/var\\/www\\/html\\/app\\/controllers\\/BaseController.php(108): ConsultasSQL->insertar(Array)\\n#3 \\/var\\/www\\/html\\/app\\/controllers\\/BaseController.php(151): BaseController->procesarGuardado(Array)\\n#4 \\/var\\/www\\/html\\/app\\/controllers\\/JsonController.php(69): BaseController->{closure}()\\n#5 \\/var\\/www\\/html\\/app\\/controllers\\/BaseController.php(137): JsonController->ejecutarOperacion(Object(Closure), \'Error al crear ...\')\\n#6 \\/var\\/www\\/html\\/vendor\\/bcosca\\/fatfree-core\\/base.php(1997): BaseController->guardarnuevo(Object(Base), Array, \'CartelesControl...\')\\n#7 \\/var\\/www\\/html\\/vendor\\/bcosca\\/fatfree-core\\/base.php(1795): Base->call(Array, Array, Array)\\n#8 \\/var\\/www\\/html\\/index.php(51): Base->run()\\n#9 {main}\"}'),
(4375,'2024-11-27 09:06:45','info','creación completada exitosamente en carteles',NULL),
(4376,'2024-11-27 09:06:45','debug','Registro resultante: {\"estado\":\"error\",\"mensaje\":\"Valor duplicado: carteles.unique_latitud_longitud = 55.0000000-55.0000000\",\"detalles\":{\"tipo\":\"duplicado\",\"campo\":\"carteles.unique_latitud_longitud\",\"valor\":\"55.0000000-55.0000000\",\"mensaje\":\"Valor duplicado: carteles.unique_latitud_longitud = 55.0000000-55.0000000\",\"codigo\":409},\"codigo\":409}',NULL),
(4377,'2024-11-27 09:06:45','info','BaseController inicializado para tabla: carteles',NULL),
(4378,'2024-11-27 09:06:45','sql','SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}'),
(4379,'2024-11-27 09:06:46','info','BaseController inicializado para tabla: carteles',NULL),
(4380,'2024-11-27 09:06:46','sql','SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}'),
(4381,'2024-11-27 09:06:48','info','BaseController inicializado para tabla: logs',NULL),
(4382,'2024-11-27 09:06:48','sql','SELECT * FROM logs WHERE tipo = \'error\'','{\"tabla\":\"logs\",\"query_raw\":\"SELECT * FROM logs WHERE tipo = ?\",\"parametros\":[\"error\"]}'),
(4383,'2024-11-27 09:06:58','info','BaseController inicializado para tabla: logs',NULL),
(4384,'2024-11-27 09:06:58','sql','SELECT * FROM logs WHERE tipo = \'debug\'','{\"tabla\":\"logs\",\"query_raw\":\"SELECT * FROM logs WHERE tipo = ?\",\"parametros\":[\"debug\"]}'),
(4385,'2024-11-27 09:07:01','info','BaseController inicializado para tabla: logs',NULL),
(4386,'2024-11-27 09:07:01','sql','SELECT * FROM logs WHERE tipo = \'info\'','{\"tabla\":\"logs\",\"query_raw\":\"SELECT * FROM logs WHERE tipo = ?\",\"parametros\":[\"info\"]}'),
(4387,'2024-11-27 09:07:02','info','BaseController inicializado para tabla: logs',NULL),
(4388,'2024-11-27 09:07:02','sql','SELECT * FROM logs WHERE tipo = \'sql\'','{\"tabla\":\"logs\",\"query_raw\":\"SELECT * FROM logs WHERE tipo = ?\",\"parametros\":[\"sql\"]}'),
(4389,'2024-11-27 09:07:11','info','BaseController inicializado para tabla: logs',NULL),
(4390,'2024-11-27 09:07:11','sql','SELECT * FROM logs','{\"tabla\":\"logs\",\"query_raw\":\"SELECT * FROM logs\",\"parametros\":[]}'),
(4391,'2024-11-27 09:07:31','info','BaseController inicializado para tabla: logs',NULL),
(4392,'2024-11-27 09:07:31','sql','SELECT * FROM logs WHERE fecha >= \'2024-11-26 10:06:48\'','{\"tabla\":\"logs\",\"query_raw\":\"SELECT * FROM logs WHERE fecha >= ?\",\"parametros\":[\"2024-11-26 10:06:48\"]}'),
(4393,'2024-11-27 09:57:56','debug','Creando backup',NULL),
(4394,'2024-11-27 09:57:56','debug','Directorio de backups: /var/www/html/database',NULL),
(4395,'2024-11-27 09:57:56','debug','BACKUP_DIR configurado: /var/www/html/database',NULL),
(4396,'2024-11-27 09:57:56','debug','Directorio de backups creado: /var/www/html/database',NULL),
(4397,'2024-11-27 09:57:56','debug','Directorio de backups tiene permisos de escritura','{\"directorio\":\"\\/var\\/www\\/html\\/database\",\"permisos\":16895}'),
(4398,'2024-11-27 09:57:56','debug','Configuración de base de datos','{\"host\":\"cbt-db\",\"database\":\"cityboardtorrejon\",\"user\":\"cbt_user\"}'),
(4399,'2024-11-27 09:57:56','debug','Archivo de backup a crear','{\"archivo\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\"}'),
(4400,'2024-11-27 09:57:56','debug','Timestamp','{\"timestamp\":\"2024-11-27_09-57-56\"}'),
(4401,'2024-11-27 09:57:56','debug','mysqldump disponible','{\"output\":[\"\\/usr\\/bin\\/mysqldump\"]}'),
(4402,'2024-11-27 09:57:56','debug','Ejecutando comando de backup',NULL),
(4403,'2024-11-27 09:57:56','info','Backup creado exitosamente','{\"archivo\":\"backup_2024-11-27_09-57-56.sql\",\"fecha\":\"2024-11-27T09:57:56+00:00\",\"tama\\u00f1o\":83281,\"tama\\u00f1o_formateado\":\"81.33 KB\"}'),
(4404,'2024-11-27 09:59:19','info','BaseController inicializado para tabla: logs',NULL),
(4405,'2024-11-27 09:59:19','sql','SELECT * FROM logs WHERE tipo = \'debug\' AND fecha >= \'2024-11-26 10:06:48\'','{\"tabla\":\"logs\",\"query_raw\":\"SELECT * FROM logs WHERE tipo = ? AND fecha >= ?\",\"parametros\":[\"debug\",\"2024-11-26 10:06:48\"]}'),
(4406,'2024-11-27 09:59:22','info','BaseController inicializado para tabla: logs',NULL),
(4407,'2024-11-27 09:59:22','sql','SELECT * FROM logs WHERE tipo = \'info\' AND fecha >= \'2024-11-26 10:06:48\'','{\"tabla\":\"logs\",\"query_raw\":\"SELECT * FROM logs WHERE tipo = ? AND fecha >= ?\",\"parametros\":[\"info\",\"2024-11-26 10:06:48\"]}'),
(4408,'2024-11-27 09:59:31','info','Obteniendo información del último backup',NULL),
(4409,'2024-11-27 09:59:31','debug','Directorio de backups: /var/www/html/database',NULL),
(4410,'2024-11-27 09:59:31','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}'),
(4411,'2024-11-27 09:59:31','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}'),
(4412,'2024-11-27 09:59:31','debug','Último backup encontrado','{\"archivo\":\"backup_2024-11-27_09-57-56.sql\",\"fecha\":\"2024-11-27 09:57:56\"}'),
(4413,'2024-11-27 09:59:31','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-27T09:57:56+00:00\",\"fecha_formateada\":\"2024-11-27 09:57:56\",\"archivo\":\"backup_2024-11-27_09-57-56.sql\",\"tama\\u00f1o\":83281,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\"}}'),
(4414,'2024-11-27 09:59:31','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-27T09:57:56+00:00\",\"fecha_formateada\":\"2024-11-27 09:57:56\",\"archivo\":\"backup_2024-11-27_09-57-56.sql\",\"tama\\u00f1o\":83281,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\"}}'),
(4415,'2024-11-27 09:59:33','debug','Creando backup',NULL),
(4416,'2024-11-27 09:59:33','debug','Directorio de backups: /var/www/html/database',NULL),
(4417,'2024-11-27 09:59:33','debug','BACKUP_DIR configurado: /var/www/html/database',NULL),
(4418,'2024-11-27 09:59:33','debug','Directorio de backups creado: /var/www/html/database',NULL),
(4419,'2024-11-27 09:59:33','debug','Directorio de backups tiene permisos de escritura','{\"directorio\":\"\\/var\\/www\\/html\\/database\",\"permisos\":16895}'),
(4420,'2024-11-27 09:59:33','debug','Configuración de base de datos','{\"host\":\"cbt-db\",\"database\":\"cityboardtorrejon\",\"user\":\"cbt_user\"}'),
(4421,'2024-11-27 09:59:33','debug','Archivo de backup a crear','{\"archivo\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-33.sql\"}'),
(4422,'2024-11-27 09:59:33','debug','Timestamp','{\"timestamp\":\"2024-11-27_09-59-33\"}'),
(4423,'2024-11-27 09:59:33','debug','mysqldump disponible','{\"output\":[\"\\/usr\\/bin\\/mysqldump\"]}'),
(4424,'2024-11-27 09:59:33','debug','Ejecutando comando de backup',NULL);
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parametros_cartel`
--

DROP TABLE IF EXISTS `parametros_cartel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parametros_cartel` (
  `fecha_actualizacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha y hora de la última actualización',
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de cada parámetro',
  `id_cartel` int NOT NULL COMMENT 'Referencia al ID del cartel relacionado',
  `clave` varchar(255) NOT NULL COMMENT 'Nombre del parámetro o clave',
  `valor` text NOT NULL COMMENT 'Valor asociado al parámetro',
  PRIMARY KEY (`id`),
  KEY `fk_parametros_cartel_id_cartel` (`id_cartel`),
  CONSTRAINT `fk_parametros_cartel_id_cartel` FOREIGN KEY (`id_cartel`) REFERENCES `carteles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla que almacena los parámetros y configuraciones de un cartel';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parametros_cartel`
--

LOCK TABLES `parametros_cartel` WRITE;
/*!40000 ALTER TABLE `parametros_cartel` DISABLE KEYS */;
/*!40000 ALTER TABLE `parametros_cartel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parametros_counters`
--

DROP TABLE IF EXISTS `parametros_counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parametros_counters` (
  `codinsclo` varchar(50) NOT NULL COMMENT 'Código de instalación en la nube',
  `id` int NOT NULL COMMENT 'Identificador único del contador',
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha y hora de la última actualización',
  `description` varchar(255) NOT NULL COMMENT 'Descripción del contador',
  `value_expression` varchar(50) DEFAULT NULL COMMENT 'Expresión del valor (si corresponde)',
  `value` int DEFAULT NULL COMMENT 'Valor del contador',
  PRIMARY KEY (`id`,`codinsclo`,`description`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla que almacena información sobre los contadores de espacios (Parámetros y sus valores)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parametros_counters`
--

LOCK TABLES `parametros_counters` WRITE;
/*!40000 ALTER TABLE `parametros_counters` DISABLE KEYS */;
INSERT INTO `parametros_counters` VALUES
('1067',1,'2024-10-14 17:14:01','Contador reservas dentro','',6),
('1362',1,'2024-10-15 10:46:00','Total plazas libres','PLZ1',1),
('1363',1,'2024-10-15 10:44:01','Total plazas libres','TPL',8),
('1364',1,'2024-10-15 10:46:01','Total plazas libres','TPL',29),
('1365',1,'2024-10-15 10:42:01','Plazas libres rotacion','PLZ1',714),
('1067',2,'2024-10-14 17:14:01','Plazas totales','TPA',600),
('1067',3,'2024-10-14 17:56:01','Plazas libres','TPL',590),
('1067',4,'2024-10-14 17:56:01','Plazas ocupadas','TPO',10),
('1067',5,'2024-10-14 18:28:01','vehicleEntranceCount','',0),
('1067',6,'2024-10-14 17:14:01','vehicleExitCount','',0);
/*!40000 ALTER TABLE `parametros_counters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parametros_signs`
--

DROP TABLE IF EXISTS `parametros_signs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parametros_signs` (
  `codinsclo` varchar(50) NOT NULL COMMENT 'Código de instalación en la nube',
  `id` int NOT NULL COMMENT 'Identificador único del cartel',
  `fecha_actualizacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha y hora de la última actualización',
  `description` varchar(255) NOT NULL COMMENT 'Descripción del cartel',
  `activation_expression` varchar(255) DEFAULT NULL COMMENT 'Expresión de activación del cartel',
  `activated` tinyint(1) NOT NULL COMMENT 'Estado de activación del cartel (0 o 1)',
  `forced` tinyint(1) NOT NULL COMMENT 'Estado forzado del cartel (0 o 1)',
  PRIMARY KEY (`id`,`description`,`codinsclo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla que almacena información sobre los carteles (Parámetros y sus valores)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parametros_signs`
--

LOCK TABLES `parametros_signs` WRITE;
/*!40000 ALTER TABLE `parametros_signs` DISABLE KEYS */;
INSERT INTO `parametros_signs` VALUES
('1067',1,'2024-10-15 10:46:01','Cartel 1','PLZ1 <= 0',0,0),
('1363',1,'2024-10-15 10:46:01','Cartel 1','TPL <= 0',0,1),
('1364',1,'2024-10-15 10:46:01','Cartel 1','TPL <= 0',0,0),
('1362',1,'2024-10-15 10:46:00','Cartel P','PLZ1 <= 0',0,0);
/*!40000 ALTER TABLE `parametros_signs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parametros_zones`
--

DROP TABLE IF EXISTS `parametros_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parametros_zones` (
  `codinsclo` varchar(50) NOT NULL COMMENT 'Código de instalación en la nube',
  `id` int NOT NULL COMMENT 'Identificador único de la zona',
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha y hora de la última actualización',
  `description` varchar(255) NOT NULL COMMENT 'Descripción de la zona',
  `total_spaces` int NOT NULL COMMENT 'Total de plazas en la zona',
  `available_spaces` int NOT NULL COMMENT 'Espacios disponibles en la zona',
  `occupied_spaces` int NOT NULL COMMENT 'Espacios ocupados en la zona',
  PRIMARY KEY (`id`,`description`,`codinsclo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla que almacena información sobre las zonas de estacionamiento (Parámetros y sus valores)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parametros_zones`
--

LOCK TABLES `parametros_zones` WRITE;
/*!40000 ALTER TABLE `parametros_zones` DISABLE KEYS */;
INSERT INTO `parametros_zones` VALUES
('1363',1,'2024-10-15 10:44:01','PLAZAS',100,8,92),
('1364',1,'2024-10-15 10:46:01','PLAZAS',247,29,218),
('1067',1,'2024-10-14 17:56:01','Rotacion',544,534,10),
('1362',1,'2024-10-15 10:46:00','Rotación',100,1,99),
('1365',1,'2024-10-15 10:42:01','Rotación',585,714,-129),
('1067',2,'2024-10-14 17:20:34','Abonados',150,150,0),
('1362',2,'2024-10-15 10:32:00','Abonados',200,15,185),
('1067',3,'2024-10-14 17:20:34','Reservas',10,10,0),
('1067',5,'2024-10-14 17:20:34','Apps',500,500,0),
('1067',6,'2024-10-14 17:20:34','Prueba 1',250,250,0),
('1067',7,'2024-10-14 17:20:34','Prueba 2',250,250,0),
('1067',8,'2024-10-14 17:20:34','Feria',2,2,0),
('1067',9,'2024-10-14 17:20:34','Carnaval',10,10,0);
/*!40000 ALTER TABLE `parametros_zones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parkings`
--

DROP TABLE IF EXISTS `parkings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parkings` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del parking',
  `codinsclo` bigint NOT NULL COMMENT 'Código de instalación en la nube',
  `latitud` decimal(10,7) DEFAULT NULL COMMENT 'Latitud geográfica del cartel',
  `longitud` decimal(10,7) DEFAULT NULL COMMENT 'Longitud geográfica del cartel',
  `nombre` varchar(255) NOT NULL COMMENT 'Nombre del parking',
  `direccion` varchar(255) DEFAULT NULL COMMENT 'Dirección del parking',
  `ciudad` varchar(100) DEFAULT NULL COMMENT 'Ciudad donde está ubicado el parking',
  `codigo_postal` varchar(10) DEFAULT NULL COMMENT 'Código postal del parking',
  `json_counters` text COMMENT 'Json obtenido de SagaCloudServidor',
  `ultima_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha y hora de la última actualización',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_codinsclo` (`codinsclo`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parkings`
--

LOCK TABLES `parkings` WRITE;
/*!40000 ALTER TABLE `parkings` DISABLE KEYS */;
INSERT INTO `parkings` VALUES
(2,1362,40.4637935,-3.4586709,'PARQUE CENTRAL','C/ Cervantes nº 9','Torrejon de Ardoz','28850','{\"zones\":[{\"id\":1,\"description\":\"Rotaci\\u00F3n\",\"total_spaces\":100,\"available_spaces\":61,\"occupied_spaces\":39}, {\"id\":2,\"description\":\"Abonados\",\"total_spaces\":200,\"available_spaces\":23,\"occupied_spaces\":177}],\"counters\":[{\"id\":1,\"description\":\"Total plazas libres\",\"value_expression\":\"PLZ1\",\"value\":61}],\"signs\":[{\"id\":1,\"description\":\"Cartel P\",\"activation_expression\":\"PLZ1 <= 0\",\"activated\":0,\"forced\":0}]}','2024-11-22 13:48:12'),
(3,1363,40.4557132,-3.4824138,'PLAZA ESPAÑA2','PZA. ESPAÑA S/N','TORREJON DE ARDOZ','28850','{\"zones\":[{\"id\":1,\"description\":\"PLAZAS\",\"total_spaces\":100,\"available_spaces\":6,\"occupied_spaces\":94}],\"counters\":[{\"id\":1,\"description\":\"Total plazas libres\",\"value_expression\":\"TPL\",\"value\":6}],\"signs\":[{\"id\":1,\"description\":\"Cartel 1\",\"activation_expression\":\"TPL <= 0\",\"activated\":0,\"forced\":1}]}','2024-11-20 15:20:44'),
(4,1364,40.4529898,-3.4956484,'PLAZA MAYOR','PLAZA MAYOR S/M','TORREJÓN DE ARDOZ','28850','{\"zones\":[{\"id\":1,\"description\":\"PLAZAS\",\"total_spaces\":247,\"available_spaces\":46,\"occupied_spaces\":201}],\"counters\":[{\"id\":1,\"description\":\"Total plazas libres\",\"value_expression\":\"TPL\",\"value\":46}],\"signs\":[{\"id\":1,\"description\":\"Cartel 1\",\"activation_expression\":\"TPL <= 0\",\"activated\":0,\"forced\":0}]}','2024-11-20 16:53:15'),
(5,1365,40.4426216,-3.7083743,'SOTO HENARES','FELIX CANDELA 54 5 A','MADRID','28055','{\"zones\":[{\"id\":1,\"description\":\"Rotaci\\u00F3n\",\"total_spaces\":585,\"available_spaces\":265,\"occupied_spaces\":320}],\"counters\":[{\"id\":1,\"description\":\"Plazas libres rotacion\",\"value_expression\":\"PLZ1\",\"value\":265}],\"signs\":[]}','2024-11-06 13:49:00');
/*!40000 ALTER TABLE `parkings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del usuario',
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre completo del usuario',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Correo electrónico único del usuario',
  `pass` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Contraseña del usuario encriptada',
  `token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Token de autenticación del usuario',
  `ultimo_inicio_sesion` datetime DEFAULT NULL COMMENT 'Fecha y hora del último acceso del usuario',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES
(2,'Langton','agimeno@equinsa.es','8ae05fbff8d9b4fe1c8d1c0a773d65432a580b4f38f20525673174830e872338','a4589677796909464e20eec998c117f32cf3d6875f4dfe5a9cf18398ac040eeb',NULL),
(6,'Langton2','agimeno@equinsa.es2','8ae05fbff8d9b4fe1c8d1c0a773d65432a580b4f38f20525673174830e872338',NULL,NULL),
(9,'pepe','pepe_agimeno@equinsa.es','8ae05fbff8d9b4fe1c8d1c0a773d65432a580b4f38f20525673174830e872338',NULL,NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variables`
--

DROP TABLE IF EXISTS `variables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variables` (
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha y hora de la última actualización',
  `clave` varchar(100) NOT NULL COMMENT 'Clave del parámetro',
  `valor` text NOT NULL COMMENT 'Valor del parámetro',
  PRIMARY KEY (`clave`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla de parámetros con claves, valores y fecha de actualización';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variables`
--

LOCK TABLES `variables` WRITE;
/*!40000 ALTER TABLE `variables` DISABLE KEYS */;
INSERT INTO `variables` VALUES
('2024-10-24 18:10:16','1035.counters.1.description','Total plazas ocupadas'),
('2024-10-24 18:10:16','1035.counters.1.value','322'),
('2024-10-24 18:10:16','1035.counters.1.value_expression','TPO'),
('2024-10-24 18:10:16','1035.counters.2.description','Total plazas libres'),
('2024-10-24 18:10:16','1035.counters.2.value','1388'),
('2024-10-24 18:10:16','1035.counters.2.value_expression','PLZ2 + PLZ1 + PLZ3 + PLZ4'),
('2024-10-24 18:10:16','1035.counters.3.description','Plazas Libres Rotación Subs.'),
('2024-10-24 18:10:16','1035.counters.3.value','475'),
('2024-10-24 18:10:16','1035.counters.3.value_expression','PLZ1'),
('2024-10-24 18:10:16','1035.counters.4.description','Plazas libres Abonados Subs.'),
('2024-10-24 18:10:16','1035.counters.4.value','337'),
('2024-10-24 18:10:16','1035.counters.4.value_expression','PLZ2'),
('2024-10-24 18:10:16','1035.counters.5.description','Plazas libres Rotación Superficie'),
('2024-10-24 18:10:16','1035.counters.5.value','491'),
('2024-10-24 18:10:16','1035.counters.5.value_expression','PLZ3'),
('2024-10-24 18:10:16','1035.counters.6.description','Abonados Superficie'),
('2024-10-24 18:10:16','1035.counters.6.value','85'),
('2024-10-24 18:10:16','1035.counters.6.value_expression','PLZ4'),
('2024-10-24 18:10:16','1035.zones.1.available_spaces','475'),
('2024-10-24 18:10:16','1035.zones.1.description','Rotacion Subterraneo'),
('2024-10-24 18:10:16','1035.zones.1.occupied_spaces','25'),
('2024-10-24 18:10:16','1035.zones.1.total_spaces','500'),
('2024-10-24 18:10:16','1035.zones.2.available_spaces','337'),
('2024-10-24 18:10:16','1035.zones.2.description','Abonados Subterraneo'),
('2024-10-24 18:10:16','1035.zones.2.occupied_spaces','133'),
('2024-10-24 18:10:16','1035.zones.2.total_spaces','470'),
('2024-10-24 18:10:16','1035.zones.3.available_spaces','491'),
('2024-10-24 18:10:16','1035.zones.3.description','Rotacion Superficie'),
('2024-10-24 18:10:16','1035.zones.3.occupied_spaces','109'),
('2024-10-24 18:10:16','1035.zones.3.total_spaces','600'),
('2024-10-24 18:10:16','1035.zones.4.available_spaces','85'),
('2024-10-24 18:10:16','1035.zones.4.description','Abonados Superficie'),
('2024-10-24 18:10:16','1035.zones.4.occupied_spaces','55'),
('2024-10-24 18:10:16','1035.zones.4.total_spaces','140'),
('2024-10-28 12:56:01','1067.counters.1.description','Contador reservas dentro'),
('2024-10-29 09:49:01','1067.counters.1.value','5'),
('2024-10-28 12:56:02','1067.counters.1.value_expression',''),
('2024-10-28 12:56:02','1067.counters.2.description','Plazas totales'),
('2024-10-28 12:56:02','1067.counters.2.value','600'),
('2024-10-28 12:56:02','1067.counters.2.value_expression','TPA'),
('2024-10-28 12:56:02','1067.counters.3.description','Plazas libres'),
('2024-10-29 12:19:01','1067.counters.3.value','556'),
('2024-10-28 12:56:02','1067.counters.3.value_expression','TPL'),
('2024-10-28 12:56:02','1067.counters.4.description','Plazas ocupadas'),
('2024-10-29 12:19:01','1067.counters.4.value','44'),
('2024-10-28 12:56:02','1067.counters.4.value_expression','TPO'),
('2024-10-28 12:56:02','1067.counters.5.description','vehicleEntranceCount'),
('2024-10-29 12:49:01','1067.counters.5.value','0'),
('2024-10-28 12:56:02','1067.counters.5.value_expression',''),
('2024-10-28 12:56:02','1067.counters.6.description','vehicleExitCount'),
('2024-10-28 12:56:02','1067.counters.6.value','0'),
('2024-10-28 12:56:02','1067.counters.6.value_expression',''),
('2024-10-29 14:17:02','1067.signs.1.activated','0'),
('2024-10-28 12:56:02','1067.signs.1.activation_expression','PLZ1 <= 0'),
('2024-10-28 12:56:02','1067.signs.1.description','Cartel 1'),
('2024-10-29 13:54:02','1067.signs.1.forced','1'),
('2024-10-29 12:19:01','1067.zones.1.available_spaces','500'),
('2024-10-28 12:56:02','1067.zones.1.description','Rotacion'),
('2024-10-29 12:19:01','1067.zones.1.occupied_spaces','44'),
('2024-10-28 12:56:02','1067.zones.1.total_spaces','544'),
('2024-10-28 12:56:02','1067.zones.2.available_spaces','150'),
('2024-10-28 12:56:02','1067.zones.2.description','Abonados'),
('2024-10-28 12:56:02','1067.zones.2.occupied_spaces','0'),
('2024-10-28 12:56:02','1067.zones.2.total_spaces','150'),
('2024-10-28 12:56:02','1067.zones.3.available_spaces','10'),
('2024-10-28 12:56:02','1067.zones.3.description','Reservas'),
('2024-10-28 12:56:02','1067.zones.3.occupied_spaces','0'),
('2024-10-28 12:56:02','1067.zones.3.total_spaces','10'),
('2024-10-28 12:56:02','1067.zones.5.available_spaces','500'),
('2024-10-28 12:56:02','1067.zones.5.description','Apps'),
('2024-10-28 12:56:02','1067.zones.5.occupied_spaces','0'),
('2024-10-28 12:56:02','1067.zones.5.total_spaces','500'),
('2024-10-28 12:56:02','1067.zones.6.available_spaces','250'),
('2024-10-28 12:56:02','1067.zones.6.description','Prueba 1'),
('2024-10-28 12:56:02','1067.zones.6.occupied_spaces','0'),
('2024-10-28 12:56:02','1067.zones.6.total_spaces','250'),
('2024-10-28 12:56:02','1067.zones.7.available_spaces','250'),
('2024-10-28 12:56:02','1067.zones.7.description','Prueba 2'),
('2024-10-28 12:56:02','1067.zones.7.occupied_spaces','0'),
('2024-10-28 12:56:02','1067.zones.7.total_spaces','250'),
('2024-10-28 12:56:02','1067.zones.8.available_spaces','2'),
('2024-10-28 12:56:02','1067.zones.8.description','Feria'),
('2024-10-28 12:56:02','1067.zones.8.occupied_spaces','0'),
('2024-10-28 12:56:02','1067.zones.8.total_spaces','2'),
('2024-10-28 12:56:02','1067.zones.9.available_spaces','10'),
('2024-10-28 12:56:02','1067.zones.9.description','Carnaval'),
('2024-10-28 12:56:02','1067.zones.9.occupied_spaces','0'),
('2024-10-28 12:56:02','1067.zones.9.total_spaces','10'),
('2024-10-15 17:37:23','1362.counters.1.description','Total plazas libres'),
('2024-10-31 13:01:00','1362.counters.1.value','20'),
('2024-10-15 17:37:23','1362.counters.1.value_expression','PLZ1'),
('2024-10-30 11:07:01','1362.signs.1.activated','0'),
('2024-10-15 17:37:23','1362.signs.1.activation_expression','PLZ1 <= 0'),
('2024-10-15 17:37:23','1362.signs.1.description','Cartel P'),
('2024-10-30 11:09:00','1362.signs.1.forced','0'),
('2024-10-31 13:01:00','1362.zones.1.available_spaces','20'),
('2024-10-15 17:37:23','1362.zones.1.description','Rotación'),
('2024-10-31 13:01:00','1362.zones.1.occupied_spaces','80'),
('2024-10-15 17:37:23','1362.zones.1.total_spaces','100'),
('2024-10-31 12:51:00','1362.zones.2.available_spaces','15'),
('2024-10-15 17:37:23','1362.zones.2.description','Abonados'),
('2024-10-31 12:51:00','1362.zones.2.occupied_spaces','185'),
('2024-10-15 17:37:23','1362.zones.2.total_spaces','200'),
('2024-10-15 17:37:23','1363.counters.1.description','Total plazas libres'),
('2024-10-31 13:01:00','1363.counters.1.value','7'),
('2024-10-15 17:37:23','1363.counters.1.value_expression','TPL'),
('2024-10-31 07:21:00','1363.signs.1.activated','0'),
('2024-10-15 17:37:24','1363.signs.1.activation_expression','TPL <= 0'),
('2024-10-15 17:37:24','1363.signs.1.description','Cartel 1'),
('2024-10-15 17:37:24','1363.signs.1.forced','1'),
('2024-10-31 13:01:00','1363.zones.1.available_spaces','7'),
('2024-10-15 17:37:23','1363.zones.1.description','PLAZAS'),
('2024-10-31 13:01:00','1363.zones.1.occupied_spaces','93'),
('2024-10-15 17:37:23','1363.zones.1.total_spaces','100'),
('2024-10-15 17:37:24','1364.counters.1.description','Total plazas libres'),
('2024-10-31 12:58:01','1364.counters.1.value','62'),
('2024-10-15 17:37:24','1364.counters.1.value_expression','TPL'),
('2024-10-15 17:37:24','1364.signs.1.activated','0'),
('2024-10-15 17:37:24','1364.signs.1.activation_expression','TPL <= 0'),
('2024-10-15 17:37:24','1364.signs.1.description','Cartel 1'),
('2024-10-15 17:37:24','1364.signs.1.forced','0'),
('2024-10-31 12:58:01','1364.zones.1.available_spaces','62'),
('2024-10-15 17:37:24','1364.zones.1.description','PLAZAS'),
('2024-10-31 12:58:01','1364.zones.1.occupied_spaces','185'),
('2024-10-15 17:37:24','1364.zones.1.total_spaces','247'),
('2024-10-15 17:37:24','1365.counters.1.description','Plazas libres rotacion'),
('2024-10-31 13:00:02','1365.counters.1.value','280'),
('2024-10-15 17:37:24','1365.counters.1.value_expression','PLZ1'),
('2024-10-31 13:00:02','1365.zones.1.available_spaces','280'),
('2024-10-15 17:37:24','1365.zones.1.description','Rotación'),
('2024-10-31 13:00:02','1365.zones.1.occupied_spaces','305'),
('2024-10-15 17:37:24','1365.zones.1.total_spaces','585'),
('2024-10-29 18:22:02','903.counters.1.description','Club'),
('2024-10-29 18:22:02','903.counters.1.value','3'),
('2024-10-29 18:22:02','903.counters.1.value_expression',''),
('2024-10-29 18:22:02','903.counters.10.description','Total plazas ocupadas'),
('2024-10-29 18:23:02','903.counters.10.value','151'),
('2024-10-29 18:22:02','903.counters.10.value_expression','POZ1'),
('2024-10-29 18:22:02','903.counters.11.description','ROTACION'),
('2024-10-29 18:24:01','903.counters.11.value','95'),
('2024-10-29 18:22:02','903.counters.11.value_expression',''),
('2024-10-29 18:22:02','903.counters.2.description','Motos'),
('2024-10-29 18:22:02','903.counters.2.value','12'),
('2024-10-29 18:22:02','903.counters.2.value_expression',''),
('2024-10-29 18:22:02','903.counters.3.description','Propietarios'),
('2024-10-29 18:22:02','903.counters.3.value','120'),
('2024-10-29 18:22:02','903.counters.3.value_expression',''),
('2024-10-29 18:22:02','903.counters.4.description','Mañanas'),
('2024-10-29 18:22:02','903.counters.4.value','0'),
('2024-10-29 18:22:02','903.counters.4.value_expression',''),
('2024-10-29 18:22:02','903.counters.5.description','Mañana y Tarde'),
('2024-10-29 18:22:02','903.counters.5.value','3'),
('2024-10-29 18:22:02','903.counters.5.value_expression',''),
('2024-10-29 18:22:02','903.counters.6.description','Nocturno'),
('2024-10-29 18:22:02','903.counters.6.value','0'),
('2024-10-29 18:22:02','903.counters.6.value_expression',''),
('2024-10-29 18:22:02','903.counters.7.description','Tarde'),
('2024-10-29 18:22:02','903.counters.7.value','0'),
('2024-10-29 18:22:02','903.counters.7.value_expression',''),
('2024-10-29 18:22:02','903.counters.8.description','24 Horas'),
('2024-10-29 18:22:02','903.counters.8.value','44'),
('2024-10-29 18:22:02','903.counters.8.value_expression',''),
('2024-10-29 18:22:02','903.counters.9.description','Total plazas libres'),
('2024-10-29 18:23:02','903.counters.9.value','188'),
('2024-10-29 18:22:02','903.counters.9.value_expression','PLZ1'),
('2024-10-29 18:22:02','903.signs.1.activated','0'),
('2024-10-29 18:22:02','903.signs.1.activation_expression','PLZ1 <= 0'),
('2024-10-29 18:22:02','903.signs.1.description','ENTRADA ARROYO'),
('2024-10-29 18:22:02','903.signs.1.forced','0'),
('2024-10-29 18:22:02','903.signs.2.activated','0'),
('2024-10-29 18:22:02','903.signs.2.activation_expression','PLZ1 <= 0'),
('2024-10-29 18:22:02','903.signs.2.description','ENTRADA LAGUILLO'),
('2024-10-29 18:22:02','903.signs.2.forced','0'),
('2024-10-29 18:23:02','903.zones.1.available_spaces','188'),
('2024-10-29 18:22:02','903.zones.1.description','Rotación y Abonados'),
('2024-10-29 18:23:02','903.zones.1.occupied_spaces','151'),
('2024-10-29 18:22:02','903.zones.1.total_spaces','339'),
('2024-10-29 18:22:02','903.zones.2.available_spaces','88'),
('2024-10-29 18:22:02','903.zones.2.description','Propietarios'),
('2024-10-29 18:22:02','903.zones.2.occupied_spaces','92'),
('2024-10-29 18:22:02','903.zones.2.total_spaces','180'),
('2024-10-29 18:25:02','904.counters.1.description','Total Plazas Libres'),
('2024-10-29 18:25:02','904.counters.1.value','197'),
('2024-10-29 18:25:02','904.counters.1.value_expression','TPL'),
('2024-10-29 18:25:02','904.counters.2.description','Productos codgrupro 2 o 90 estpre 3'),
('2024-10-29 18:25:02','904.counters.2.value','146'),
('2024-10-29 18:25:02','904.counters.2.value_expression',''),
('2024-10-29 18:25:02','904.counters.3.description','Free Spaces'),
('2024-10-29 18:25:02','904.counters.3.value','1280'),
('2024-10-29 18:25:02','904.counters.3.value_expression','PLZ1'),
('2024-10-29 18:25:03','904.counters.4.description','Morning Subscriber'),
('2024-10-29 18:25:03','904.counters.4.value','0'),
('2024-10-29 18:25:03','904.counters.4.value_expression',''),
('2024-10-29 18:38:01','904.signs.1.activated','0'),
('2024-10-29 18:25:03','904.signs.1.activation_expression','PLZ1 <= 0'),
('2024-10-29 18:25:03','904.signs.1.description','Cartel \"P\"'),
('2024-10-29 18:38:01','904.signs.1.forced','0'),
('2024-10-29 18:25:03','904.signs.2.activated','0'),
('2024-10-29 18:25:03','904.signs.2.activation_expression','TPL <= 0'),
('2024-10-29 18:25:03','904.signs.2.description','Cartel Norte'),
('2024-10-29 18:25:03','904.signs.2.forced','0'),
('2024-10-29 18:25:03','904.zones.1.available_spaces','1280'),
('2024-10-29 18:25:03','904.zones.1.description','Rotation + Subscribers'),
('2024-10-29 18:25:03','904.zones.1.occupied_spaces','-280'),
('2024-10-29 18:25:03','904.zones.1.total_spaces','1000'),
('2024-10-29 18:25:03','904.zones.2.available_spaces','67'),
('2024-10-29 18:25:03','904.zones.2.description','Abonados'),
('2024-10-29 18:25:03','904.zones.2.occupied_spaces','83'),
('2024-10-29 18:25:03','904.zones.2.total_spaces','150'),
('2024-10-29 18:25:03','904.zones.3.available_spaces','0'),
('2024-10-29 18:25:03','904.zones.3.description','Bolsa EQUINSA PAY'),
('2024-10-29 18:25:03','904.zones.3.occupied_spaces','100'),
('2024-10-29 18:25:03','904.zones.3.total_spaces','100'),
('2024-10-29 18:25:03','904.zones.4.available_spaces','0'),
('2024-10-29 18:25:03','904.zones.4.description','24 h Subscriber'),
('2024-10-29 18:25:03','904.zones.4.occupied_spaces','50'),
('2024-10-29 18:25:03','904.zones.4.total_spaces','50'),
('2024-10-29 18:25:03','904.zones.5.available_spaces','0'),
('2024-10-29 18:25:03','904.zones.5.description','Zona Oscura'),
('2024-10-29 18:25:03','904.zones.5.occupied_spaces','250'),
('2024-10-29 18:25:03','904.zones.5.total_spaces','250'),
('2024-10-29 18:25:03','904.zones.6.available_spaces','0'),
('2024-10-29 18:25:03','904.zones.6.description','Zona ElParking'),
('2024-10-29 18:25:03','904.zones.6.occupied_spaces','250'),
('2024-10-29 18:25:03','904.zones.6.total_spaces','250');
/*!40000 ALTER TABLE `variables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variables_calculadas`
--

DROP TABLE IF EXISTS `variables_calculadas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variables_calculadas` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la variable',
  `clave` varchar(255) NOT NULL COMMENT 'Nombre descriptivo de la variable calculada',
  `script` text NOT NULL COMMENT 'Código PHP que realiza el cálculo de la variable',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena variables calculadas con scripts en PHP';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variables_calculadas`
--

LOCK TABLES `variables_calculadas` WRITE;
/*!40000 ALTER TABLE `variables_calculadas` DISABLE KEYS */;
INSERT INTO `variables_calculadas` VALUES
(1,'1362.zones.2.color','if ({{1362.zones.2.available_spaces}} < ({{1362.zones.2.total_spaces}} / 10)) {echo \'{{compara}}\';} else {echo \'green\';} '),
(2,'Color2','$availableSpaces = {1362.zones.2.available_spaces};\n$totalSpaces = {1362.zones.2.total_spaces};\n$color = ($availableSpaces < ($totalSpaces / 20)) ? \'red\' : \'yellow\';\necho $color;'),
(3,'compara','if (1>0){echo \'a\';}'),
(4,'1363.zones.2.color','if ({{1363.zones.2.available_spaces}} < ({{1363.zones.2.total_spaces}} / 10)) {echo \'{{compara}}\';} else {echo \'green\';} ');
/*!40000 ALTER TABLE `variables_calculadas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-27  9:59:33
