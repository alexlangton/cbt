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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carteles`
--

LOCK TABLES `carteles` WRITE;
/*!40000 ALTER TABLE `carteles` DISABLE KEYS */;
INSERT INTO `carteles` VALUES
(1,'Juzgados222',40.4581746,-3.4835560,2,'¡DESCUBRE TORREJÓN! EXPLORA CULTURA, GASTRONOMÍA Y NATURALEZA – #VIVATORREJÓN Y SUS PAISANOS!!'),
(2,'Cartel 443',40.4513001,-3.4698002,3,'TORREJÓN TE ESPERA: EVENTOS, PARQUES Y MUCHO MÁS – DISFRÚTALO A TOPE!!'),
(3,'Cartel 2',40.4458556,-3.4928928,3,'VIVE TORREJÓN: HISTORIA, SABORES Y NATURALEZA A TU ALCANCE');
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_logs_fecha` (`fecha`),
  KEY `idx_logs_tipo` (`tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=262 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES
(1,'2024-11-25 10:40:07','sql','SQL Query [usuarios]: INSERT INTO usuarios (email, pass, nombre) VALUES (\'agimeno@equinsa.es2\', \'8ae05fbff8d9b4fe1c8d1c0a773d65432a580b4f38f20525673174830e872338\', \'Langton2\')','{\"tabla\":\"usuarios\",\"query_raw\":\"INSERT INTO usuarios (email, pass, nombre) VALUES (?, ?, ?)\",\"parametros\":[\"agimeno@equinsa.es2\",\"8ae05fbff8d9b4fe1c8d1c0a773d65432a580b4f38f20525673174830e872338\",\"Langton2\"]}','2024-11-25 10:40:07'),
(2,'2024-11-25 10:40:09','sql','SQL Query [usuarios]: INSERT INTO usuarios (email, pass, nombre) VALUES (\'agimeno@equinsa.es2\', \'8ae05fbff8d9b4fe1c8d1c0a773d65432a580b4f38f20525673174830e872338\', \'Langton2\')','{\"tabla\":\"usuarios\",\"query_raw\":\"INSERT INTO usuarios (email, pass, nombre) VALUES (?, ?, ?)\",\"parametros\":[\"agimeno@equinsa.es2\",\"8ae05fbff8d9b4fe1c8d1c0a773d65432a580b4f38f20525673174830e872338\",\"Langton2\"]}','2024-11-25 10:40:09'),
(3,'2024-11-25 10:40:13','sql','SQL Query [carteles]: SELECT * FROM carteles WHERE id = 2','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles WHERE id = ?\",\"parametros\":[2]}','2024-11-25 10:40:13'),
(4,'2024-11-25 10:40:21','sql','SQL Query [carteles]: SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}','2024-11-25 10:40:21'),
(5,'2024-11-25 10:40:22','sql','SQL Query [carteles]: SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}','2024-11-25 10:40:22'),
(6,'2024-11-25 10:40:39','sql','SQL Query [c_tiposcarteles]: SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}','2024-11-25 10:40:39'),
(7,'2024-11-25 10:40:54','sql','SQL Query [c_tiposcarteles]: SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}','2024-11-25 10:40:54'),
(8,'2024-11-25 10:40:55','sql','SQL Query [carteles]: SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}','2024-11-25 10:40:55'),
(9,'2024-11-25 10:47:30','sql','SQL Query [carteles]: SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}','2024-11-25 10:47:30'),
(10,'2024-11-25 10:47:30','sql','SQL Query [c_tiposcarteles]: SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}','2024-11-25 10:47:30'),
(11,'2024-11-25 10:47:32','sql','SQL Query [carteles]: SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}','2024-11-25 10:47:32'),
(12,'2024-11-25 10:47:32','sql','SQL Query [c_tiposcarteles]: SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}','2024-11-25 10:47:32'),
(13,'2024-11-25 10:47:32','sql','SQL Query [c_tiposcarteles]: SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}','2024-11-25 10:47:32'),
(14,'2024-11-25 10:47:33','sql','SQL Query [c_tiposcarteles]: SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}','2024-11-25 10:47:33'),
(15,'2024-11-25 10:47:35','sql','SQL Query [parkings]: SELECT * FROM parkings','{\"tabla\":\"parkings\",\"query_raw\":\"SELECT * FROM parkings\",\"parametros\":[]}','2024-11-25 10:47:35'),
(16,'2024-11-25 10:47:39','sql','SQL Query [parkings]: SELECT * FROM parkings','{\"tabla\":\"parkings\",\"query_raw\":\"SELECT * FROM parkings\",\"parametros\":[]}','2024-11-25 10:47:39'),
(17,'2024-11-25 10:47:51','sql','SQL Query [usuarios]: SELECT * FROM usuarios WHERE email = \'agimeno@equinsa.es\' AND pass = \'8ae05fbff8d9b4fe1c8d1c0a773d65432a580b4f38f20525673174830e872338\'','{\"tabla\":\"usuarios\",\"query_raw\":\"SELECT * FROM usuarios WHERE email = ? AND pass = ?\",\"parametros\":[\"agimeno@equinsa.es\",\"8ae05fbff8d9b4fe1c8d1c0a773d65432a580b4f38f20525673174830e872338\"]}','2024-11-25 10:47:51'),
(18,'2024-11-25 10:47:51','sql','SQL Query [usuarios]: UPDATE usuarios SET token = \'9e199b6734d92f4710dcaca5cb3ae4b855a766ed861357312aa256397b1c025e\' WHERE email = \'agimeno@equinsa.es\'','{\"tabla\":\"usuarios\",\"query_raw\":\"UPDATE usuarios SET token = ? WHERE email = ?\",\"parametros\":[\"9e199b6734d92f4710dcaca5cb3ae4b855a766ed861357312aa256397b1c025e\",\"agimeno@equinsa.es\"]}','2024-11-25 10:47:51'),
(19,'2024-11-25 10:47:51','sql','SQL Query [c_tiposcarteles]: SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}','2024-11-25 10:47:51'),
(20,'2024-11-25 10:47:51','sql','SQL Query [carteles]: SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}','2024-11-25 10:47:51'),
(21,'2024-11-25 10:48:30','sql','SQL Query [c_tiposcarteles]: SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}','2024-11-25 10:48:30'),
(22,'2024-11-25 10:48:30','sql','SQL Query [carteles]: SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}','2024-11-25 10:48:30'),
(23,'2024-11-25 10:48:30','sql','SQL Query [c_tiposcarteles]: SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}','2024-11-25 10:48:30'),
(24,'2024-11-25 10:48:30','sql','SQL Query [c_tiposcarteles]: SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}','2024-11-25 10:48:30'),
(25,'2024-11-25 10:48:31','sql','SQL Query [parkings]: SELECT * FROM parkings','{\"tabla\":\"parkings\",\"query_raw\":\"SELECT * FROM parkings\",\"parametros\":[]}','2024-11-25 10:48:31'),
(26,'2024-11-25 10:54:32','sql','SQL Query [c_tiposcarteles]: SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}','2024-11-25 10:54:32'),
(27,'2024-11-25 10:54:32','sql','SQL Query [carteles]: SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}','2024-11-25 10:54:32'),
(28,'2024-11-25 10:56:15','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 10:56:15'),
(29,'2024-11-25 10:56:15','sql','SQL Query [carteles]: SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}','2024-11-25 10:56:15'),
(30,'2024-11-25 10:56:15','sql','SQL Query [c_tiposcarteles]: SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}','2024-11-25 10:56:15'),
(31,'2024-11-25 10:56:15','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 10:56:15'),
(32,'2024-11-25 10:56:15','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 10:56:15'),
(33,'2024-11-25 10:56:15','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 10:56:15'),
(34,'2024-11-25 10:56:17','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 10:56:17'),
(35,'2024-11-25 10:56:17','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 10:56:17'),
(36,'2024-11-25 10:56:17','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 10:56:17'),
(37,'2024-11-25 10:56:17','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 10:56:17'),
(38,'2024-11-25 10:56:20','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 10:56:20'),
(39,'2024-11-25 10:56:20','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 10:56:20'),
(40,'2024-11-25 10:56:20','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 10:56:20'),
(41,'2024-11-25 10:56:20','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 10:56:20'),
(42,'2024-11-25 10:56:25','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 10:56:25'),
(43,'2024-11-25 10:56:25','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 10:56:25'),
(44,'2024-11-25 10:56:25','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 10:56:25'),
(45,'2024-11-25 10:56:25','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 10:56:25'),
(46,'2024-11-25 10:56:30','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 10:56:30'),
(47,'2024-11-25 10:56:30','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 10:56:30'),
(48,'2024-11-25 10:56:30','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 10:56:30'),
(49,'2024-11-25 10:56:30','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 10:56:31'),
(50,'2024-11-25 10:56:35','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 10:56:35'),
(51,'2024-11-25 10:56:35','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 10:56:35'),
(52,'2024-11-25 10:56:35','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 10:56:35'),
(53,'2024-11-25 10:56:35','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 10:56:35'),
(54,'2024-11-25 10:56:40','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 10:56:40'),
(55,'2024-11-25 10:56:40','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 10:56:40'),
(56,'2024-11-25 10:56:40','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 10:56:40'),
(57,'2024-11-25 10:56:40','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 10:56:40'),
(58,'2024-11-25 10:56:40','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 10:56:40'),
(59,'2024-11-25 10:56:40','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 10:56:40'),
(60,'2024-11-25 10:56:40','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 10:56:40'),
(61,'2024-11-25 10:56:40','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 10:56:40'),
(62,'2024-11-25 10:57:21','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 10:57:21'),
(63,'2024-11-25 10:57:21','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 10:57:21'),
(64,'2024-11-25 10:57:21','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 10:57:21'),
(65,'2024-11-25 10:57:21','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 10:57:21'),
(66,'2024-11-25 10:58:21','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 10:58:21'),
(67,'2024-11-25 10:58:21','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 10:58:21'),
(68,'2024-11-25 10:58:21','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 10:58:21'),
(69,'2024-11-25 10:58:21','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 10:58:21'),
(70,'2024-11-25 10:59:16','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 10:59:16'),
(71,'2024-11-25 10:59:16','info','BaseController inicializado para tabla: c_tiposcarteles',NULL,'2024-11-25 10:59:16'),
(72,'2024-11-25 10:59:16','info','BaseController inicializado para tabla: carteles',NULL,'2024-11-25 10:59:16'),
(73,'2024-11-25 10:59:16','sql','SQL Query [c_tiposcarteles]: SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}','2024-11-25 10:59:16'),
(74,'2024-11-25 10:59:16','sql','SQL Query [carteles]: SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}','2024-11-25 10:59:16'),
(75,'2024-11-25 10:59:16','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 10:59:16'),
(76,'2024-11-25 10:59:16','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 10:59:16'),
(77,'2024-11-25 10:59:16','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 10:59:16'),
(78,'2024-11-25 10:59:21','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 10:59:21'),
(79,'2024-11-25 10:59:21','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 10:59:21'),
(80,'2024-11-25 10:59:21','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 10:59:21'),
(81,'2024-11-25 10:59:21','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 10:59:21'),
(82,'2024-11-25 10:59:26','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 10:59:26'),
(83,'2024-11-25 10:59:26','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 10:59:26'),
(84,'2024-11-25 10:59:26','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 10:59:26'),
(85,'2024-11-25 10:59:26','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 10:59:26'),
(86,'2024-11-25 10:59:31','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 10:59:31'),
(87,'2024-11-25 10:59:31','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 10:59:31'),
(88,'2024-11-25 10:59:31','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 10:59:31'),
(89,'2024-11-25 10:59:31','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 10:59:31'),
(90,'2024-11-25 10:59:36','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 10:59:36'),
(91,'2024-11-25 10:59:36','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 10:59:36'),
(92,'2024-11-25 10:59:36','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 10:59:36'),
(93,'2024-11-25 10:59:36','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 10:59:36'),
(94,'2024-11-25 10:59:41','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 10:59:41'),
(95,'2024-11-25 10:59:41','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 10:59:41'),
(96,'2024-11-25 10:59:41','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 10:59:41'),
(97,'2024-11-25 10:59:41','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 10:59:41'),
(98,'2024-11-25 11:00:21','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:00:21'),
(99,'2024-11-25 11:00:21','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:00:21'),
(100,'2024-11-25 11:00:21','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:00:21'),
(101,'2024-11-25 11:00:21','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:00:21'),
(102,'2024-11-25 11:01:21','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:01:21'),
(103,'2024-11-25 11:01:21','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:01:21'),
(104,'2024-11-25 11:01:21','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:01:21'),
(105,'2024-11-25 11:01:21','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:01:21'),
(106,'2024-11-25 11:02:17','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:02:17'),
(107,'2024-11-25 11:02:17','info','BaseController inicializado para tabla: carteles',NULL,'2024-11-25 11:02:17'),
(108,'2024-11-25 11:02:17','info','BaseController inicializado para tabla: c_tiposcarteles',NULL,'2024-11-25 11:02:17'),
(109,'2024-11-25 11:02:17','sql','SQL Query [carteles]: SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}','2024-11-25 11:02:17'),
(110,'2024-11-25 11:02:17','sql','SQL Query [c_tiposcarteles]: SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}','2024-11-25 11:02:17'),
(111,'2024-11-25 11:02:17','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:02:17'),
(112,'2024-11-25 11:02:17','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:02:17'),
(113,'2024-11-25 11:02:17','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:02:17'),
(114,'2024-11-25 11:02:22','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:02:22'),
(115,'2024-11-25 11:02:22','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:02:22'),
(116,'2024-11-25 11:02:22','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:02:22'),
(117,'2024-11-25 11:02:22','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:02:22'),
(118,'2024-11-25 11:02:27','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:02:27'),
(119,'2024-11-25 11:02:27','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:02:27'),
(120,'2024-11-25 11:02:27','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:02:27'),
(121,'2024-11-25 11:02:27','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:02:27'),
(122,'2024-11-25 11:02:32','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:02:32'),
(123,'2024-11-25 11:02:32','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:02:32'),
(124,'2024-11-25 11:02:32','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:02:32'),
(125,'2024-11-25 11:02:32','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:02:32'),
(126,'2024-11-25 11:02:37','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:02:37'),
(127,'2024-11-25 11:02:37','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:02:37'),
(128,'2024-11-25 11:02:37','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:02:37'),
(129,'2024-11-25 11:02:37','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:02:37'),
(130,'2024-11-25 11:02:42','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:02:42'),
(131,'2024-11-25 11:02:42','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:02:42'),
(132,'2024-11-25 11:02:42','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:02:42'),
(133,'2024-11-25 11:02:42','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:02:42'),
(134,'2024-11-25 11:03:21','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:03:21'),
(135,'2024-11-25 11:03:21','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:03:21'),
(136,'2024-11-25 11:03:21','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:03:21'),
(137,'2024-11-25 11:03:21','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:03:21'),
(138,'2024-11-25 11:04:21','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:04:21'),
(139,'2024-11-25 11:04:21','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:04:21'),
(140,'2024-11-25 11:04:21','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:04:21'),
(141,'2024-11-25 11:04:21','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:04:21'),
(142,'2024-11-25 11:05:18','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:05:18'),
(143,'2024-11-25 11:05:18','info','BaseController inicializado para tabla: c_tiposcarteles',NULL,'2024-11-25 11:05:18'),
(144,'2024-11-25 11:05:18','info','BaseController inicializado para tabla: carteles',NULL,'2024-11-25 11:05:18'),
(145,'2024-11-25 11:05:18','sql','SQL Query [c_tiposcarteles]: SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}','2024-11-25 11:05:18'),
(146,'2024-11-25 11:05:18','sql','SQL Query [carteles]: SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}','2024-11-25 11:05:18'),
(147,'2024-11-25 11:05:18','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:05:18'),
(148,'2024-11-25 11:05:18','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:05:18'),
(149,'2024-11-25 11:05:18','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:05:18'),
(150,'2024-11-25 11:05:23','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:05:23'),
(151,'2024-11-25 11:05:23','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:05:23'),
(152,'2024-11-25 11:05:23','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:05:23'),
(153,'2024-11-25 11:05:23','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:05:23'),
(154,'2024-11-25 11:05:28','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:05:28'),
(155,'2024-11-25 11:05:28','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:05:28'),
(156,'2024-11-25 11:05:28','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:05:28'),
(157,'2024-11-25 11:05:28','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:05:28'),
(158,'2024-11-25 11:05:33','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:05:33'),
(159,'2024-11-25 11:05:33','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:05:33'),
(160,'2024-11-25 11:05:33','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:05:33'),
(161,'2024-11-25 11:05:33','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:05:33'),
(162,'2024-11-25 11:05:38','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:05:38'),
(163,'2024-11-25 11:05:38','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:05:38'),
(164,'2024-11-25 11:05:38','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:05:38'),
(165,'2024-11-25 11:05:38','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:05:38'),
(166,'2024-11-25 11:05:43','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:05:43'),
(167,'2024-11-25 11:05:43','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:05:43'),
(168,'2024-11-25 11:05:43','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:05:43'),
(169,'2024-11-25 11:05:43','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:05:43'),
(170,'2024-11-25 11:06:21','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:06:21'),
(171,'2024-11-25 11:06:21','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:06:21'),
(172,'2024-11-25 11:06:21','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:06:21'),
(173,'2024-11-25 11:06:21','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:06:21'),
(174,'2024-11-25 11:06:36','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:06:36'),
(175,'2024-11-25 11:06:37','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:06:37'),
(176,'2024-11-25 11:06:37','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:06:37'),
(177,'2024-11-25 11:06:37','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:06:37'),
(178,'2024-11-25 11:06:38','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:06:38'),
(179,'2024-11-25 11:06:38','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:06:38'),
(180,'2024-11-25 11:06:38','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:06:38'),
(181,'2024-11-25 11:06:38','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:06:38'),
(182,'2024-11-25 11:10:22','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:10:22'),
(183,'2024-11-25 11:10:22','info','BaseController inicializado para tabla: carteles',NULL,'2024-11-25 11:10:22'),
(184,'2024-11-25 11:10:22','info','BaseController inicializado para tabla: c_tiposcarteles',NULL,'2024-11-25 11:10:22'),
(185,'2024-11-25 11:10:22','sql','SQL Query [carteles]: SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}','2024-11-25 11:10:22'),
(186,'2024-11-25 11:10:22','sql','SQL Query [c_tiposcarteles]: SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}','2024-11-25 11:10:22'),
(187,'2024-11-25 11:10:22','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:10:22'),
(188,'2024-11-25 11:10:22','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:10:22'),
(189,'2024-11-25 11:10:22','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:10:22'),
(190,'2024-11-25 11:10:27','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:10:27'),
(191,'2024-11-25 11:10:27','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:10:27'),
(192,'2024-11-25 11:10:27','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:10:27'),
(193,'2024-11-25 11:10:27','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:10:27'),
(194,'2024-11-25 11:10:32','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:10:32'),
(195,'2024-11-25 11:10:32','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:10:32'),
(196,'2024-11-25 11:10:32','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:10:32'),
(197,'2024-11-25 11:10:32','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:10:32'),
(198,'2024-11-25 11:10:37','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:10:37'),
(199,'2024-11-25 11:10:37','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:10:37'),
(200,'2024-11-25 11:10:37','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:10:37'),
(201,'2024-11-25 11:10:37','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:10:37'),
(202,'2024-11-25 11:10:42','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:10:42'),
(203,'2024-11-25 11:10:42','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:10:42'),
(204,'2024-11-25 11:10:42','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:10:42'),
(205,'2024-11-25 11:10:42','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:10:42'),
(206,'2024-11-25 11:11:21','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:11:21'),
(207,'2024-11-25 11:11:21','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:11:21'),
(208,'2024-11-25 11:11:21','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:11:21'),
(209,'2024-11-25 11:11:21','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:11:21'),
(210,'2024-11-25 11:12:21','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:12:21'),
(211,'2024-11-25 11:12:21','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:12:21'),
(212,'2024-11-25 11:12:21','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:12:21'),
(213,'2024-11-25 11:12:21','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:12:21'),
(214,'2024-11-25 11:13:21','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:13:21'),
(215,'2024-11-25 11:13:21','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:13:21'),
(216,'2024-11-25 11:13:21','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:13:21'),
(217,'2024-11-25 11:13:21','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:13:21'),
(218,'2024-11-25 11:13:26','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:13:26'),
(219,'2024-11-25 11:13:26','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:13:26'),
(220,'2024-11-25 11:13:26','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:13:26'),
(221,'2024-11-25 11:13:26','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:13:26'),
(222,'2024-11-25 11:13:27','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:13:27'),
(223,'2024-11-25 11:13:27','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:13:27'),
(224,'2024-11-25 11:13:27','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:13:27'),
(225,'2024-11-25 11:13:27','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:13:27'),
(226,'2024-11-25 11:13:28','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:13:28'),
(227,'2024-11-25 11:13:28','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:13:28'),
(228,'2024-11-25 11:13:28','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:13:28'),
(229,'2024-11-25 11:13:28','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:13:28'),
(230,'2024-11-25 11:13:43','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:13:43'),
(231,'2024-11-25 11:13:43','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:13:43'),
(232,'2024-11-25 11:13:43','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:13:43'),
(233,'2024-11-25 11:13:43','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:13:43'),
(234,'2024-11-25 11:13:44','info','BaseController inicializado para tabla: parkings',NULL,'2024-11-25 11:13:44'),
(235,'2024-11-25 11:13:44','sql','SQL Query [parkings]: SELECT * FROM parkings','{\"tabla\":\"parkings\",\"query_raw\":\"SELECT * FROM parkings\",\"parametros\":[]}','2024-11-25 11:13:44'),
(236,'2024-11-25 11:13:49','debug','Iniciando proceso de login',NULL,'2024-11-25 11:13:49'),
(237,'2024-11-25 11:13:49','debug','Verificando credenciales','{\"email\":\"agimeno@equinsa.es\"}','2024-11-25 11:13:49'),
(238,'2024-11-25 11:13:49','sql','SQL Query [usuarios]: SELECT * FROM usuarios WHERE email = \'agimeno@equinsa.es\' AND pass = \'8ae05fbff8d9b4fe1c8d1c0a773d65432a580b4f38f20525673174830e872338\'','{\"tabla\":\"usuarios\",\"query_raw\":\"SELECT * FROM usuarios WHERE email = ? AND pass = ?\",\"parametros\":[\"agimeno@equinsa.es\",\"8ae05fbff8d9b4fe1c8d1c0a773d65432a580b4f38f20525673174830e872338\"]}','2024-11-25 11:13:49'),
(239,'2024-11-25 11:13:49','sql','SQL Query [usuarios]: UPDATE usuarios SET token = \'227f7dd8e25a535be523a5859a541f07d2dc5308390d695401c2b82630870593\' WHERE email = \'agimeno@equinsa.es\'','{\"tabla\":\"usuarios\",\"query_raw\":\"UPDATE usuarios SET token = ? WHERE email = ?\",\"parametros\":[\"227f7dd8e25a535be523a5859a541f07d2dc5308390d695401c2b82630870593\",\"agimeno@equinsa.es\"]}','2024-11-25 11:13:49'),
(240,'2024-11-25 11:13:49','info','Login exitoso','{\"usuario_id\":2,\"email\":\"agimeno@equinsa.es\"}','2024-11-25 11:13:49'),
(241,'2024-11-25 11:13:49','debug','Iniciando obtención de datos Leaflet',NULL,'2024-11-25 11:13:49'),
(242,'2024-11-25 11:13:49','info','BaseController inicializado para tabla: carteles',NULL,'2024-11-25 11:13:49'),
(243,'2024-11-25 11:13:49','sql','SQL Query [carteles]: SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}','2024-11-25 11:13:49'),
(244,'2024-11-25 11:13:49','info','Carteles obtenidos','{\"cantidad\":3,\"latitudes\":3,\"longitudes\":3}','2024-11-25 11:13:49'),
(245,'2024-11-25 11:13:49','info','Parkings obtenidos','{\"cantidad\":4,\"latitudes\":4,\"longitudes\":4}','2024-11-25 11:13:49'),
(246,'2024-11-25 11:13:49','info','BaseController inicializado para tabla: c_tiposcarteles',NULL,'2024-11-25 11:13:49'),
(247,'2024-11-25 11:13:50','info','Datos del mapa calculados','{\"centro\":[40.4529212,-3.513050914285714],\"limites\":[[40.4426216,-3.7083743],[40.4637935,-3.4586709]],\"total_marcadores\":7}','2024-11-25 11:13:50'),
(248,'2024-11-25 11:13:50','sql','SQL Query [c_tiposcarteles]: SELECT * FROM c_tiposcarteles','{\"tabla\":\"c_tiposcarteles\",\"query_raw\":\"SELECT * FROM c_tiposcarteles\",\"parametros\":[]}','2024-11-25 11:13:50'),
(249,'2024-11-25 11:14:03','debug','Inicializado BackupController','{\"max_backups\":10,\"backup_dir\":\"\\/var\\/www\\/html\\/database\"}','2024-11-25 11:14:03'),
(250,'2024-11-25 11:14:03','info','=== INICIO DEL PROCESO DE BACKUP ===',NULL,'2024-11-25 11:14:03'),
(251,'2024-11-25 11:14:03','info','PASO 1: Verificando configuración',NULL,'2024-11-25 11:14:03'),
(252,'2024-11-25 11:14:03','info','Configuración DB: {\"host\":\"cbt-db\",\"user\":\"cbt_user\",\"pass\":\"****\",\"name\":\"cityboardtorrejon\"}',NULL,'2024-11-25 11:14:03'),
(253,'2024-11-25 11:14:03','info','PASO 2: Verificando directorio',NULL,'2024-11-25 11:14:03'),
(254,'2024-11-25 11:14:03','info','Directorio a usar: /var/www/html/database',NULL,'2024-11-25 11:14:03'),
(255,'2024-11-25 11:14:03','info','PASO 3: Gestionando backups antiguos',NULL,'2024-11-25 11:14:03'),
(256,'2024-11-25 11:14:03','info','Analizando backups existentes','{\"total_actual\":3,\"maximo_permitido\":10,\"se_necesita_limpiar\":\"No\"}','2024-11-25 11:14:03'),
(257,'2024-11-25 11:14:03','info','PASO 4: Preparando archivo',NULL,'2024-11-25 11:14:03'),
(258,'2024-11-25 11:14:03','info','PASO 5: Ejecutando backup',NULL,'2024-11-25 11:14:03'),
(259,'2024-11-25 11:14:03','info','Iniciando mysqldump con opciones optimizadas...',NULL,'2024-11-25 11:14:03'),
(260,'2024-11-25 11:14:03','debug','Ejecutando comando mysqldump (password oculto)',NULL,'2024-11-25 11:14:03'),
(261,'2024-11-25 11:14:03','debug','mysqldump --no-tablespaces --skip-lock-tables --single-transaction --quick --add-drop-table --create-options --extended-insert --set-charset -h \'cbt-db\' -u \'cbt_user\' -p**** \'cityboardtorrejon\' > \'/var/www/html/database/backup_2511241114.sql\' 2>&1',NULL,'2024-11-25 11:14:03');
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
(2,'Langton','agimeno@equinsa.es','8ae05fbff8d9b4fe1c8d1c0a773d65432a580b4f38f20525673174830e872338','227f7dd8e25a535be523a5859a541f07d2dc5308390d695401c2b82630870593',NULL),
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

-- Dump completed on 2024-11-25 11:14:04
