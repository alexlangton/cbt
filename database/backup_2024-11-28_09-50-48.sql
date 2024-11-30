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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla que almacena los diferentes tipos de carteles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_tiposcarteles`
--

LOCK TABLES `c_tiposcarteles` WRITE;
/*!40000 ALTER TABLE `c_tiposcarteles` DISABLE KEYS */;
INSERT INTO `c_tiposcarteles` VALUES
(1,'Cartel Torrejón','{\r\n  \"ocupacionParkings\": [\r\n    {\r\n      \"nombre\": \"Parking A\",\r\n      \"ocupacion\": 120\r\n    },\r\n    {\r\n      \"nombre\": \"Parking B\",\r\n      \"ocupacion\": 85\r\n    },\r\n    {\r\n      \"nombre\": \"Parking C\",\r\n      \"ocupacion\": 150\r\n    },\r\n    {\r\n      \"nombre\": \"Parking D\",\r\n      \"ocupacion\": 60\r\n    }\r\n  ]\r\n}'),
(2,'Cartel Mini','{\r\n  \"ocupacionParkings\": [\r\n    {\r\n      \"nombre\": \"Parking A\",\r\n      \"ocupacion\": 120\r\n    },\r\n    {\r\n      \"nombre\": \"Parking B\",\r\n      \"ocupacion\": 85\r\n    },\r\n    {\r\n      \"nombre\": \"Parking C\",\r\n      \"ocupacion\": 150\r\n    },\r\n    {\r\n      \"nombre\": \"Parking D\",\r\n      \"ocupacion\": 60\r\n    }\r\n  ]\r\n}\r\n'),
(3,'Cartel Torrejón sin rotulo','{\r\n  \"ocupacionParkings\": [\r\n    {\r\n      \"nombre\": \"Parking A\",\r\n      \"ocupacion\": 120\r\n    },\r\n    {\r\n      \"nombre\": \"Parking B\",\r\n      \"ocupacion\": 85\r\n    },\r\n    {\r\n      \"nombre\": \"Parking C\",\r\n      \"ocupacion\": 150\r\n    },\r\n    {\r\n      \"nombre\": \"Parking D\",\r\n      \"ocupacion\": 60\r\n    }\r\n  ]\r\n}\r\n'),
(26,'kkk',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
(14,'yhyhyt',55.0000000,55.0000000,2,'yyyy'),
(16,'eeeee',44.0000000,180.0000000,1,'rr');
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
  `id_usuario` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Id de usuario',
  PRIMARY KEY (`id`),
  KEY `idx_logs_fecha` (`fecha`),
  KEY `idx_logs_tipo` (`tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=12075 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES
(11638,'2024-11-28 08:51:59','info','Se eliminaron 846 registros de logs',NULL,'2'),
(11639,'2024-11-28 08:52:58','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11640,'2024-11-28 08:52:58','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11641,'2024-11-28 08:52:58','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"User-Agent\":\"REST Client (API tester)\\/1.1\"}}',NULL),
(11642,'2024-11-28 08:52:58','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(11643,'2024-11-28 08:52:58','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11644,'2024-11-28 08:52:58','debug','Obteniendo token de header','{\"header\":\"ausente\"}',NULL),
(11645,'2024-11-28 08:52:58','debug','Token no encontrado',NULL,NULL),
(11646,'2024-11-28 08:52:58','debug','Autenticación fallida en constructor','{\"resultado\":{\"estado\":\"error\",\"mensaje\":\"Token no proporcionado\",\"codigo\":401},\"ruta\":\"\\/api\\/backup\\/ultimo\"}',NULL),
(11647,'2024-11-28 08:53:58','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11648,'2024-11-28 08:53:58','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11649,'2024-11-28 08:53:58','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"User-Agent\":\"REST Client (API tester)\\/1.1\",\"Authorization\":\"Bearer token\"}}',NULL),
(11650,'2024-11-28 08:53:58','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(11651,'2024-11-28 08:53:58','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11652,'2024-11-28 08:53:58','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(11653,'2024-11-28 08:53:58','debug','Token extraído correctamente','{\"token_length\":5}',NULL),
(11654,'2024-11-28 08:53:58','debug','Verificando token','{\"token_length\":5,\"token_start\":\"token...\"}',NULL),
(11655,'2024-11-28 08:53:58','error','Error al verificar token','{\"error\":\"Wrong number of segments\",\"trace\":\"#0 \\/var\\/www\\/html\\/app\\/lib\\/TokenManager.php(108): Firebase\\\\JWT\\\\JWT::decode(\'token\', Object(Firebase\\\\JWT\\\\Key))\\n#1 \\/var\\/www\\/html\\/app\\/controllers\\/AutenticacionController.php(92): TokenManager->verificarToken(\'token\')\\n#2 \\/var\\/www\\/html\\/app\\/controllers\\/AutenticacionController.php(26): AutenticacionController->verificarAutenticacion(Object(Base))\\n#3 \\/var\\/www\\/html\\/app\\/controllers\\/BaseDatosController.php(7): AutenticacionController->__construct()\\n#4 [internal function]: BaseDatosController->__construct(Object(Base), Array, \'BaseDatosContro...\')\\n#5 \\/var\\/www\\/html\\/vendor\\/bcosca\\/fatfree-core\\/base.php(1947): ReflectionClass->newInstanceArgs(Array)\\n#6 \\/var\\/www\\/html\\/vendor\\/bcosca\\/fatfree-core\\/base.php(1968): Base->grab(\'BaseDatosContro...\', Array)\\n#7 \\/var\\/www\\/html\\/vendor\\/bcosca\\/fatfree-core\\/base.php(1795): Base->call(\'BaseDatosContro...\', Array, \'beforeroute,aft...\')\\n#8 \\/var\\/www\\/html\\/index.php(51): Base->run()\\n#9 {main}\"}',NULL),
(11656,'2024-11-28 08:53:58','debug','Resultado verificación token','{\"valido\":false,\"tiene_usuario\":false,\"datos_usuario\":\"no disponible\"}',NULL),
(11657,'2024-11-28 08:53:58','debug','Token inválido o sin datos de usuario',NULL,NULL),
(11658,'2024-11-28 08:53:58','debug','Autenticación fallida en constructor','{\"resultado\":{\"estado\":\"error\",\"mensaje\":\"Token inv\\u00e1lido o expirado\",\"codigo\":401},\"ruta\":\"\\/api\\/backup\\/ultimo\"}',NULL),
(11659,'2024-11-28 08:54:24','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11660,'2024-11-28 08:54:24','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/carteles\",\"es_publica\":false}',NULL),
(11661,'2024-11-28 08:54:24','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/carteles\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"User-Agent\":\"REST Client (API tester)\\/1.1\",\"Authorization\":\"Bearer token\"}}',NULL),
(11662,'2024-11-28 08:54:24','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/carteles\",\"metodo\":\"GET\"}',NULL),
(11663,'2024-11-28 08:54:24','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/carteles\",\"es_publica\":false}',NULL),
(11664,'2024-11-28 08:54:24','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(11665,'2024-11-28 08:54:24','debug','Token extraído correctamente','{\"token_length\":5}',NULL),
(11666,'2024-11-28 08:54:24','debug','Verificando token','{\"token_length\":5,\"token_start\":\"token...\"}',NULL),
(11667,'2024-11-28 08:54:24','error','Error al verificar token','{\"error\":\"Wrong number of segments\",\"trace\":\"#0 \\/var\\/www\\/html\\/app\\/lib\\/TokenManager.php(108): Firebase\\\\JWT\\\\JWT::decode(\'token\', Object(Firebase\\\\JWT\\\\Key))\\n#1 \\/var\\/www\\/html\\/app\\/controllers\\/AutenticacionController.php(92): TokenManager->verificarToken(\'token\')\\n#2 \\/var\\/www\\/html\\/app\\/controllers\\/AutenticacionController.php(26): AutenticacionController->verificarAutenticacion(Object(Base))\\n#3 \\/var\\/www\\/html\\/app\\/controllers\\/BaseController.php(9): AutenticacionController->__construct()\\n#4 \\/var\\/www\\/html\\/app\\/recursos\\/CartelesController.php(5): BaseController->__construct(\'carteles\')\\n#5 [internal function]: CartelesController->__construct(Object(Base), Array, \'CartelesControl...\')\\n#6 \\/var\\/www\\/html\\/vendor\\/bcosca\\/fatfree-core\\/base.php(1947): ReflectionClass->newInstanceArgs(Array)\\n#7 \\/var\\/www\\/html\\/vendor\\/bcosca\\/fatfree-core\\/base.php(1968): Base->grab(\'CartelesControl...\', Array)\\n#8 \\/var\\/www\\/html\\/vendor\\/bcosca\\/fatfree-core\\/base.php(1795): Base->call(\'CartelesControl...\', Array, \'beforeroute,aft...\')\\n#9 \\/var\\/www\\/html\\/index.php(51): Base->run()\\n#10 {main}\"}',NULL),
(11668,'2024-11-28 08:54:24','debug','Resultado verificación token','{\"valido\":false,\"tiene_usuario\":false,\"datos_usuario\":\"no disponible\"}',NULL),
(11669,'2024-11-28 08:54:24','debug','Token inválido o sin datos de usuario',NULL,NULL),
(11670,'2024-11-28 08:54:24','debug','Autenticación fallida en constructor','{\"resultado\":{\"estado\":\"error\",\"mensaje\":\"Token inv\\u00e1lido o expirado\",\"codigo\":401},\"ruta\":\"\\/api\\/carteles\"}',NULL),
(11671,'2024-11-28 08:54:37','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11672,'2024-11-28 08:54:37','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/carteles\",\"es_publica\":false}',NULL),
(11673,'2024-11-28 08:54:37','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/carteles\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"User-Agent\":\"REST Client (API tester)\\/1.1\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3MTE1NjUsImV4cCI6MTczMjc5Nzk2NSwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.p7RQnnuGshJGbwNdKDavA41iXT6Fn\\\\\\/iYvPrlBLuSe8g=\"}}',NULL),
(11674,'2024-11-28 08:54:37','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/carteles\",\"metodo\":\"GET\"}',NULL),
(11675,'2024-11-28 08:54:37','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/carteles\",\"es_publica\":false}',NULL),
(11676,'2024-11-28 08:54:37','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(11677,'2024-11-28 08:54:37','debug','Token extraído correctamente','{\"token_length\":195}',NULL),
(11678,'2024-11-28 08:54:37','debug','Verificando token','{\"token_length\":195,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(11679,'2024-11-28 08:54:37','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(11680,'2024-11-28 08:54:37','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(11681,'2024-11-28 08:54:37','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(11682,'2024-11-28 08:54:37','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/carteles\"}','2'),
(11683,'2024-11-28 08:54:37','info','BaseController inicializado para tabla: carteles',NULL,'2'),
(11684,'2024-11-28 08:54:37','sql','SELECT * FROM carteles','{\"tabla\":\"carteles\",\"query_raw\":\"SELECT * FROM carteles\",\"parametros\":[]}',NULL),
(11685,'2024-11-28 08:54:52','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11686,'2024-11-28 08:54:52','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11687,'2024-11-28 08:54:52','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"User-Agent\":\"REST Client (API tester)\\/1.1\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3MTE1NjUsImV4cCI6MTczMjc5Nzk2NSwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.p7RQnnuGshJGbwNdKDavA41iXT6Fn\\\\\\/iYvPrlBLuSe8g=\"}}',NULL),
(11688,'2024-11-28 08:54:52','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(11689,'2024-11-28 08:54:52','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11690,'2024-11-28 08:54:52','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(11691,'2024-11-28 08:54:52','debug','Token extraído correctamente','{\"token_length\":195}',NULL),
(11692,'2024-11-28 08:54:52','debug','Verificando token','{\"token_length\":195,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(11693,'2024-11-28 08:54:52','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(11694,'2024-11-28 08:54:52','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(11695,'2024-11-28 08:54:52','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(11696,'2024-11-28 08:54:52','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/backup\\/ultimo\"}','2'),
(11697,'2024-11-28 08:54:52','info','Obteniendo información del último backup',NULL,NULL),
(11698,'2024-11-28 08:54:52','debug','Directorio de backups: /var/www/html/database',NULL,NULL),
(11699,'2024-11-28 08:54:52','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}',NULL),
(11700,'2024-11-28 08:54:52','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-33.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-38.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}',NULL),
(11701,'2024-11-28 08:54:52','debug','Último backup encontrado','{\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"fecha\":\"2024-11-27 15:01:18\"}',NULL),
(11702,'2024-11-28 08:54:52','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11703,'2024-11-28 08:54:52','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11704,'2024-11-28 08:57:00','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11705,'2024-11-28 08:57:00','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11706,'2024-11-28 08:57:00','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"Pragma\":\"no-cache\",\"Cache-Control\":\"no-cache\",\"Sec-Ch-Ua-Platform\":\"\\\"Android\\\"\",\"User-Agent\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Mobile Safari\\/537.36\",\"Accept\":\"application\\/json, text\\/plain, *\\/*\",\"Sec-Ch-Ua\":\"\\\"Google Chrome\\\";v=\\\"131\\\", \\\"Chromium\\\";v=\\\"131\\\", \\\"Not_A Brand\\\";v=\\\"24\\\"\",\"Sec-Ch-Ua-Mobile\":\"?1\",\"Sec-Fetch-Site\":\"same-origin\",\"Sec-Fetch-Mode\":\"cors\",\"Sec-Fetch-Dest\":\"empty\",\"Referer\":\"http:\\/\\/localhost\\/pages\\/backup\",\"Accept-Encoding\":\"gzip, deflate, br, zstd\",\"Accept-Language\":\"es-ES,es;q=0.9\"}}',NULL),
(11707,'2024-11-28 08:57:00','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(11708,'2024-11-28 08:57:00','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11709,'2024-11-28 08:57:00','debug','Obteniendo token de header','{\"header\":\"ausente\"}',NULL),
(11710,'2024-11-28 08:57:00','debug','Token no encontrado',NULL,NULL),
(11711,'2024-11-28 08:57:00','debug','Autenticación fallida en constructor','{\"resultado\":{\"estado\":\"error\",\"mensaje\":\"Token no proporcionado\",\"codigo\":401},\"ruta\":\"\\/api\\/backup\\/ultimo\"}',NULL),
(11712,'2024-11-28 08:58:58','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11713,'2024-11-28 08:58:58','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11714,'2024-11-28 08:58:58','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"Pragma\":\"no-cache\",\"Cache-Control\":\"no-cache\",\"Sec-Ch-Ua-Platform\":\"\\\"Android\\\"\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3ODI5ODAsImV4cCI6MTczMjg2OTM4MCwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.cMM1xLQD22\\/voJauKOGqYQ2RXsdv+0XUD0q7mmEF5Bw=\",\"User-Agent\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Mobile Safari\\/537.36\",\"Accept\":\"application\\/json, text\\/plain, *\\/*\",\"Sec-Ch-Ua\":\"\\\"Google Chrome\\\";v=\\\"131\\\", \\\"Chromium\\\";v=\\\"131\\\", \\\"Not_A Brand\\\";v=\\\"24\\\"\",\"Sec-Ch-Ua-Mobile\":\"?1\",\"Sec-Fetch-Site\":\"same-origin\",\"Sec-Fetch-Mode\":\"cors\",\"Sec-Fetch-Dest\":\"empty\",\"Referer\":\"http:\\/\\/localhost\\/pages\\/backup\",\"Accept-Encoding\":\"gzip, deflate, br, zstd\",\"Accept-Language\":\"es-ES,es;q=0.9\"}}',NULL),
(11715,'2024-11-28 08:58:58','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(11716,'2024-11-28 08:58:58','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11717,'2024-11-28 08:58:58','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(11718,'2024-11-28 08:58:58','debug','Token extraído correctamente','{\"token_length\":194}',NULL),
(11719,'2024-11-28 08:58:58','debug','Verificando token','{\"token_length\":194,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(11720,'2024-11-28 08:58:58','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(11721,'2024-11-28 08:58:58','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(11722,'2024-11-28 08:58:58','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(11723,'2024-11-28 08:58:58','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/backup\\/ultimo\"}','2'),
(11724,'2024-11-28 08:58:58','info','Obteniendo información del último backup',NULL,NULL),
(11725,'2024-11-28 08:58:58','debug','Directorio de backups: /var/www/html/database',NULL,NULL),
(11726,'2024-11-28 08:58:58','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}',NULL),
(11727,'2024-11-28 08:58:58','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-33.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-38.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}',NULL),
(11728,'2024-11-28 08:58:58','debug','Último backup encontrado','{\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"fecha\":\"2024-11-27 15:01:18\"}',NULL),
(11729,'2024-11-28 08:58:58','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11730,'2024-11-28 08:58:58','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11731,'2024-11-28 08:59:00','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11732,'2024-11-28 08:59:00','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11733,'2024-11-28 08:59:00','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"Pragma\":\"no-cache\",\"Cache-Control\":\"no-cache\",\"Sec-Ch-Ua-Platform\":\"\\\"Android\\\"\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3ODI5ODAsImV4cCI6MTczMjg2OTM4MCwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.cMM1xLQD22\\/voJauKOGqYQ2RXsdv+0XUD0q7mmEF5Bw=\",\"User-Agent\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Mobile Safari\\/537.36\",\"Accept\":\"application\\/json, text\\/plain, *\\/*\",\"Sec-Ch-Ua\":\"\\\"Google Chrome\\\";v=\\\"131\\\", \\\"Chromium\\\";v=\\\"131\\\", \\\"Not_A Brand\\\";v=\\\"24\\\"\",\"Sec-Ch-Ua-Mobile\":\"?1\",\"Sec-Fetch-Site\":\"same-origin\",\"Sec-Fetch-Mode\":\"cors\",\"Sec-Fetch-Dest\":\"empty\",\"Referer\":\"http:\\/\\/localhost\\/pages\\/backup\",\"Accept-Encoding\":\"gzip, deflate, br, zstd\",\"Accept-Language\":\"es-ES,es;q=0.9\"}}',NULL),
(11734,'2024-11-28 08:59:00','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(11735,'2024-11-28 08:59:00','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11736,'2024-11-28 08:59:00','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(11737,'2024-11-28 08:59:00','debug','Token extraído correctamente','{\"token_length\":194}',NULL),
(11738,'2024-11-28 08:59:00','debug','Verificando token','{\"token_length\":194,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(11739,'2024-11-28 08:59:00','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(11740,'2024-11-28 08:59:00','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(11741,'2024-11-28 08:59:00','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(11742,'2024-11-28 08:59:00','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/backup\\/ultimo\"}','2'),
(11743,'2024-11-28 08:59:00','info','Obteniendo información del último backup',NULL,NULL),
(11744,'2024-11-28 08:59:00','debug','Directorio de backups: /var/www/html/database',NULL,NULL),
(11745,'2024-11-28 08:59:00','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}',NULL),
(11746,'2024-11-28 08:59:00','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-33.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-38.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}',NULL),
(11747,'2024-11-28 08:59:00','debug','Último backup encontrado','{\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"fecha\":\"2024-11-27 15:01:18\"}',NULL),
(11748,'2024-11-28 08:59:00','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11749,'2024-11-28 08:59:00','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11750,'2024-11-28 09:01:24','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11751,'2024-11-28 09:01:24','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11752,'2024-11-28 09:01:24','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"Pragma\":\"no-cache\",\"Cache-Control\":\"no-cache\",\"Sec-Ch-Ua-Platform\":\"\\\"Android\\\"\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3ODI5ODAsImV4cCI6MTczMjg2OTM4MCwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.cMM1xLQD22\\/voJauKOGqYQ2RXsdv+0XUD0q7mmEF5Bw=\",\"User-Agent\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Mobile Safari\\/537.36\",\"Accept\":\"application\\/json, text\\/plain, *\\/*\",\"Sec-Ch-Ua\":\"\\\"Google Chrome\\\";v=\\\"131\\\", \\\"Chromium\\\";v=\\\"131\\\", \\\"Not_A Brand\\\";v=\\\"24\\\"\",\"Sec-Ch-Ua-Mobile\":\"?1\",\"Sec-Fetch-Site\":\"same-origin\",\"Sec-Fetch-Mode\":\"cors\",\"Sec-Fetch-Dest\":\"empty\",\"Referer\":\"http:\\/\\/localhost\\/pages\\/backup\",\"Accept-Encoding\":\"gzip, deflate, br, zstd\",\"Accept-Language\":\"es-ES,es;q=0.9\"}}',NULL),
(11753,'2024-11-28 09:01:24','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(11754,'2024-11-28 09:01:24','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11755,'2024-11-28 09:01:24','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(11756,'2024-11-28 09:01:24','debug','Token extraído correctamente','{\"token_length\":194}',NULL),
(11757,'2024-11-28 09:01:24','debug','Verificando token','{\"token_length\":194,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(11758,'2024-11-28 09:01:24','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(11759,'2024-11-28 09:01:24','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(11760,'2024-11-28 09:01:24','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(11761,'2024-11-28 09:01:24','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/backup\\/ultimo\"}','2'),
(11762,'2024-11-28 09:01:24','info','Obteniendo información del último backup',NULL,NULL),
(11763,'2024-11-28 09:01:24','debug','Directorio de backups: /var/www/html/database',NULL,NULL),
(11764,'2024-11-28 09:01:24','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}',NULL),
(11765,'2024-11-28 09:01:24','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-33.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-38.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}',NULL),
(11766,'2024-11-28 09:01:24','debug','Último backup encontrado','{\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"fecha\":\"2024-11-27 15:01:18\"}',NULL),
(11767,'2024-11-28 09:01:24','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11768,'2024-11-28 09:01:24','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11769,'2024-11-28 09:01:52','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11770,'2024-11-28 09:01:52','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11771,'2024-11-28 09:01:52','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"Pragma\":\"no-cache\",\"Cache-Control\":\"no-cache\",\"Sec-Ch-Ua-Platform\":\"\\\"Android\\\"\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3ODI5ODAsImV4cCI6MTczMjg2OTM4MCwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.cMM1xLQD22\\/voJauKOGqYQ2RXsdv+0XUD0q7mmEF5Bw=\",\"User-Agent\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Mobile Safari\\/537.36\",\"Accept\":\"application\\/json, text\\/plain, *\\/*\",\"Sec-Ch-Ua\":\"\\\"Google Chrome\\\";v=\\\"131\\\", \\\"Chromium\\\";v=\\\"131\\\", \\\"Not_A Brand\\\";v=\\\"24\\\"\",\"Sec-Ch-Ua-Mobile\":\"?1\",\"Sec-Fetch-Site\":\"same-origin\",\"Sec-Fetch-Mode\":\"cors\",\"Sec-Fetch-Dest\":\"empty\",\"Referer\":\"http:\\/\\/localhost\\/pages\\/backup\",\"Accept-Encoding\":\"gzip, deflate, br, zstd\",\"Accept-Language\":\"es-ES,es;q=0.9\"}}',NULL),
(11772,'2024-11-28 09:01:52','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(11773,'2024-11-28 09:01:52','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11774,'2024-11-28 09:01:52','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(11775,'2024-11-28 09:01:52','debug','Token extraído correctamente','{\"token_length\":194}',NULL),
(11776,'2024-11-28 09:01:52','debug','Verificando token','{\"token_length\":194,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(11777,'2024-11-28 09:01:52','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(11778,'2024-11-28 09:01:52','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(11779,'2024-11-28 09:01:52','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(11780,'2024-11-28 09:01:52','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/backup\\/ultimo\"}','2'),
(11781,'2024-11-28 09:01:52','info','Obteniendo información del último backup',NULL,NULL),
(11782,'2024-11-28 09:01:52','debug','Directorio de backups: /var/www/html/database',NULL,NULL),
(11783,'2024-11-28 09:01:52','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}',NULL),
(11784,'2024-11-28 09:01:52','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-33.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-38.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}',NULL),
(11785,'2024-11-28 09:01:52','debug','Último backup encontrado','{\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"fecha\":\"2024-11-27 15:01:18\"}',NULL),
(11786,'2024-11-28 09:01:52','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11787,'2024-11-28 09:01:52','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11788,'2024-11-28 09:02:00','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11789,'2024-11-28 09:02:00','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11790,'2024-11-28 09:02:00','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"User-Agent\":\"REST Client (API tester)\\/1.1\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3MTE1NjUsImV4cCI6MTczMjc5Nzk2NSwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.p7RQnnuGshJGbwNdKDavA41iXT6Fn\\\\\\/iYvPrlBLuSe8g=\"}}',NULL),
(11791,'2024-11-28 09:02:00','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(11792,'2024-11-28 09:02:00','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11793,'2024-11-28 09:02:00','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(11794,'2024-11-28 09:02:00','debug','Token extraído correctamente','{\"token_length\":195}',NULL),
(11795,'2024-11-28 09:02:00','debug','Verificando token','{\"token_length\":195,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(11796,'2024-11-28 09:02:00','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(11797,'2024-11-28 09:02:00','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(11798,'2024-11-28 09:02:00','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(11799,'2024-11-28 09:02:00','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/backup\\/ultimo\"}','2'),
(11800,'2024-11-28 09:02:00','info','Obteniendo información del último backup',NULL,NULL),
(11801,'2024-11-28 09:02:00','debug','Directorio de backups: /var/www/html/database',NULL,NULL),
(11802,'2024-11-28 09:02:00','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}',NULL),
(11803,'2024-11-28 09:02:00','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-33.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-38.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}',NULL),
(11804,'2024-11-28 09:02:00','debug','Último backup encontrado','{\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"fecha\":\"2024-11-27 15:01:18\"}',NULL),
(11805,'2024-11-28 09:02:00','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11806,'2024-11-28 09:02:00','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11807,'2024-11-28 09:02:08','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11808,'2024-11-28 09:02:08','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11809,'2024-11-28 09:02:08','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"Pragma\":\"no-cache\",\"Cache-Control\":\"no-cache\",\"Sec-Ch-Ua-Platform\":\"\\\"Android\\\"\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3ODI5ODAsImV4cCI6MTczMjg2OTM4MCwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.cMM1xLQD22\\/voJauKOGqYQ2RXsdv+0XUD0q7mmEF5Bw=\",\"User-Agent\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Mobile Safari\\/537.36\",\"Accept\":\"application\\/json, text\\/plain, *\\/*\",\"Sec-Ch-Ua\":\"\\\"Google Chrome\\\";v=\\\"131\\\", \\\"Chromium\\\";v=\\\"131\\\", \\\"Not_A Brand\\\";v=\\\"24\\\"\",\"Sec-Ch-Ua-Mobile\":\"?1\",\"Sec-Fetch-Site\":\"same-origin\",\"Sec-Fetch-Mode\":\"cors\",\"Sec-Fetch-Dest\":\"empty\",\"Referer\":\"http:\\/\\/localhost\\/pages\\/backup\",\"Accept-Encoding\":\"gzip, deflate, br, zstd\",\"Accept-Language\":\"es-ES,es;q=0.9\"}}',NULL),
(11810,'2024-11-28 09:02:08','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(11811,'2024-11-28 09:02:08','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11812,'2024-11-28 09:02:08','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(11813,'2024-11-28 09:02:08','debug','Token extraído correctamente','{\"token_length\":194}',NULL),
(11814,'2024-11-28 09:02:08','debug','Verificando token','{\"token_length\":194,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(11815,'2024-11-28 09:02:08','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(11816,'2024-11-28 09:02:08','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(11817,'2024-11-28 09:02:08','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(11818,'2024-11-28 09:02:08','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/backup\\/ultimo\"}','2'),
(11819,'2024-11-28 09:02:08','info','Obteniendo información del último backup',NULL,NULL),
(11820,'2024-11-28 09:02:08','debug','Directorio de backups: /var/www/html/database',NULL,NULL),
(11821,'2024-11-28 09:02:08','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}',NULL),
(11822,'2024-11-28 09:02:08','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-33.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-38.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}',NULL),
(11823,'2024-11-28 09:02:08','debug','Último backup encontrado','{\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"fecha\":\"2024-11-27 15:01:18\"}',NULL),
(11824,'2024-11-28 09:02:08','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11825,'2024-11-28 09:02:08','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11826,'2024-11-28 09:05:17','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11827,'2024-11-28 09:05:17','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11828,'2024-11-28 09:05:17','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"Pragma\":\"no-cache\",\"Cache-Control\":\"no-cache\",\"Sec-Ch-Ua-Platform\":\"\\\"Android\\\"\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3ODI5ODAsImV4cCI6MTczMjg2OTM4MCwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.cMM1xLQD22\\/voJauKOGqYQ2RXsdv+0XUD0q7mmEF5Bw=\",\"User-Agent\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Mobile Safari\\/537.36\",\"Accept\":\"application\\/json, text\\/plain, *\\/*\",\"Sec-Ch-Ua\":\"\\\"Google Chrome\\\";v=\\\"131\\\", \\\"Chromium\\\";v=\\\"131\\\", \\\"Not_A Brand\\\";v=\\\"24\\\"\",\"Sec-Ch-Ua-Mobile\":\"?1\",\"Sec-Fetch-Site\":\"same-origin\",\"Sec-Fetch-Mode\":\"cors\",\"Sec-Fetch-Dest\":\"empty\",\"Referer\":\"http:\\/\\/localhost\\/pages\\/backup\",\"Accept-Encoding\":\"gzip, deflate, br, zstd\",\"Accept-Language\":\"es-ES,es;q=0.9\"}}',NULL),
(11829,'2024-11-28 09:05:17','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(11830,'2024-11-28 09:05:17','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11831,'2024-11-28 09:05:17','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(11832,'2024-11-28 09:05:17','debug','Token extraído correctamente','{\"token_length\":194}',NULL),
(11833,'2024-11-28 09:05:17','debug','Verificando token','{\"token_length\":194,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(11834,'2024-11-28 09:05:17','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(11835,'2024-11-28 09:05:17','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(11836,'2024-11-28 09:05:17','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(11837,'2024-11-28 09:05:17','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/backup\\/ultimo\"}','2'),
(11838,'2024-11-28 09:05:17','info','Obteniendo información del último backup',NULL,NULL),
(11839,'2024-11-28 09:05:17','debug','Directorio de backups: /var/www/html/database',NULL,NULL),
(11840,'2024-11-28 09:05:17','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}',NULL),
(11841,'2024-11-28 09:05:17','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-33.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-38.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}',NULL),
(11842,'2024-11-28 09:05:17','debug','Último backup encontrado','{\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"fecha\":\"2024-11-27 15:01:18\"}',NULL),
(11843,'2024-11-28 09:05:17','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11844,'2024-11-28 09:05:17','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11845,'2024-11-28 09:05:22','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11846,'2024-11-28 09:05:22','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11847,'2024-11-28 09:05:22','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"Pragma\":\"no-cache\",\"Cache-Control\":\"no-cache\",\"Sec-Ch-Ua-Platform\":\"\\\"Android\\\"\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3ODI5ODAsImV4cCI6MTczMjg2OTM4MCwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.cMM1xLQD22\\/voJauKOGqYQ2RXsdv+0XUD0q7mmEF5Bw=\",\"User-Agent\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Mobile Safari\\/537.36\",\"Accept\":\"application\\/json, text\\/plain, *\\/*\",\"Sec-Ch-Ua\":\"\\\"Google Chrome\\\";v=\\\"131\\\", \\\"Chromium\\\";v=\\\"131\\\", \\\"Not_A Brand\\\";v=\\\"24\\\"\",\"Sec-Ch-Ua-Mobile\":\"?1\",\"Sec-Fetch-Site\":\"same-origin\",\"Sec-Fetch-Mode\":\"cors\",\"Sec-Fetch-Dest\":\"empty\",\"Referer\":\"http:\\/\\/localhost\\/pages\\/backup\",\"Accept-Encoding\":\"gzip, deflate, br, zstd\",\"Accept-Language\":\"es-ES,es;q=0.9\"}}',NULL),
(11848,'2024-11-28 09:05:22','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(11849,'2024-11-28 09:05:22','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11850,'2024-11-28 09:05:22','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(11851,'2024-11-28 09:05:22','debug','Token extraído correctamente','{\"token_length\":194}',NULL),
(11852,'2024-11-28 09:05:22','debug','Verificando token','{\"token_length\":194,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(11853,'2024-11-28 09:05:23','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(11854,'2024-11-28 09:05:23','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(11855,'2024-11-28 09:05:23','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(11856,'2024-11-28 09:05:23','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/backup\\/ultimo\"}','2'),
(11857,'2024-11-28 09:05:23','info','Obteniendo información del último backup',NULL,NULL),
(11858,'2024-11-28 09:05:23','debug','Directorio de backups: /var/www/html/database',NULL,NULL),
(11859,'2024-11-28 09:05:23','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}',NULL),
(11860,'2024-11-28 09:05:23','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-33.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-38.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}',NULL),
(11861,'2024-11-28 09:05:23','debug','Último backup encontrado','{\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"fecha\":\"2024-11-27 15:01:18\"}',NULL),
(11862,'2024-11-28 09:05:23','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11863,'2024-11-28 09:05:23','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11864,'2024-11-28 09:05:29','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11865,'2024-11-28 09:05:29','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11866,'2024-11-28 09:05:29','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"Pragma\":\"no-cache\",\"Cache-Control\":\"no-cache\",\"Sec-Ch-Ua-Platform\":\"\\\"Android\\\"\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3ODI5ODAsImV4cCI6MTczMjg2OTM4MCwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.cMM1xLQD22\\/voJauKOGqYQ2RXsdv+0XUD0q7mmEF5Bw=\",\"User-Agent\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Mobile Safari\\/537.36\",\"Accept\":\"application\\/json, text\\/plain, *\\/*\",\"Sec-Ch-Ua\":\"\\\"Google Chrome\\\";v=\\\"131\\\", \\\"Chromium\\\";v=\\\"131\\\", \\\"Not_A Brand\\\";v=\\\"24\\\"\",\"Sec-Ch-Ua-Mobile\":\"?1\",\"Sec-Fetch-Site\":\"same-origin\",\"Sec-Fetch-Mode\":\"cors\",\"Sec-Fetch-Dest\":\"empty\",\"Referer\":\"http:\\/\\/localhost\\/pages\\/backup\",\"Accept-Encoding\":\"gzip, deflate, br, zstd\",\"Accept-Language\":\"es-ES,es;q=0.9\"}}',NULL),
(11867,'2024-11-28 09:05:29','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(11868,'2024-11-28 09:05:29','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11869,'2024-11-28 09:05:29','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(11870,'2024-11-28 09:05:29','debug','Token extraído correctamente','{\"token_length\":194}',NULL),
(11871,'2024-11-28 09:05:29','debug','Verificando token','{\"token_length\":194,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(11872,'2024-11-28 09:05:29','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(11873,'2024-11-28 09:05:29','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(11874,'2024-11-28 09:05:29','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(11875,'2024-11-28 09:05:29','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/backup\\/ultimo\"}','2'),
(11876,'2024-11-28 09:05:29','info','Obteniendo información del último backup',NULL,NULL),
(11877,'2024-11-28 09:05:29','debug','Directorio de backups: /var/www/html/database',NULL,NULL),
(11878,'2024-11-28 09:05:29','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}',NULL),
(11879,'2024-11-28 09:05:29','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-33.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-38.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}',NULL),
(11880,'2024-11-28 09:05:29','debug','Último backup encontrado','{\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"fecha\":\"2024-11-27 15:01:18\"}',NULL),
(11881,'2024-11-28 09:05:29','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11882,'2024-11-28 09:05:29','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11883,'2024-11-28 09:06:25','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11884,'2024-11-28 09:06:25','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11885,'2024-11-28 09:06:25','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"Pragma\":\"no-cache\",\"Cache-Control\":\"no-cache\",\"Sec-Ch-Ua-Platform\":\"\\\"Android\\\"\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3ODI5ODAsImV4cCI6MTczMjg2OTM4MCwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.cMM1xLQD22\\/voJauKOGqYQ2RXsdv+0XUD0q7mmEF5Bw=\",\"User-Agent\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Mobile Safari\\/537.36\",\"Accept\":\"application\\/json, text\\/plain, *\\/*\",\"Sec-Ch-Ua\":\"\\\"Google Chrome\\\";v=\\\"131\\\", \\\"Chromium\\\";v=\\\"131\\\", \\\"Not_A Brand\\\";v=\\\"24\\\"\",\"Sec-Ch-Ua-Mobile\":\"?1\",\"Sec-Fetch-Site\":\"same-origin\",\"Sec-Fetch-Mode\":\"cors\",\"Sec-Fetch-Dest\":\"empty\",\"Referer\":\"http:\\/\\/localhost\\/pages\\/backup\",\"Accept-Encoding\":\"gzip, deflate, br, zstd\",\"Accept-Language\":\"es-ES,es;q=0.9\"}}',NULL),
(11886,'2024-11-28 09:06:25','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(11887,'2024-11-28 09:06:25','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11888,'2024-11-28 09:06:25','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(11889,'2024-11-28 09:06:25','debug','Token extraído correctamente','{\"token_length\":194}',NULL),
(11890,'2024-11-28 09:06:25','debug','Verificando token','{\"token_length\":194,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(11891,'2024-11-28 09:06:25','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(11892,'2024-11-28 09:06:25','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(11893,'2024-11-28 09:06:25','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(11894,'2024-11-28 09:06:25','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/backup\\/ultimo\"}','2'),
(11895,'2024-11-28 09:06:25','info','Obteniendo información del último backup',NULL,NULL),
(11896,'2024-11-28 09:06:25','debug','Directorio de backups: /var/www/html/database',NULL,NULL),
(11897,'2024-11-28 09:06:25','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}',NULL),
(11898,'2024-11-28 09:06:25','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-33.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-38.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}',NULL),
(11899,'2024-11-28 09:06:25','debug','Último backup encontrado','{\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"fecha\":\"2024-11-27 15:01:18\"}',NULL),
(11900,'2024-11-28 09:06:25','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11901,'2024-11-28 09:06:25','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11902,'2024-11-28 09:08:05','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11903,'2024-11-28 09:08:05','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11904,'2024-11-28 09:08:05','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"Pragma\":\"no-cache\",\"Cache-Control\":\"no-cache\",\"Sec-Ch-Ua-Platform\":\"\\\"Android\\\"\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3ODI5ODAsImV4cCI6MTczMjg2OTM4MCwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.cMM1xLQD22\\/voJauKOGqYQ2RXsdv+0XUD0q7mmEF5Bw=\",\"User-Agent\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Mobile Safari\\/537.36\",\"Accept\":\"application\\/json, text\\/plain, *\\/*\",\"Sec-Ch-Ua\":\"\\\"Google Chrome\\\";v=\\\"131\\\", \\\"Chromium\\\";v=\\\"131\\\", \\\"Not_A Brand\\\";v=\\\"24\\\"\",\"Sec-Ch-Ua-Mobile\":\"?1\",\"Sec-Fetch-Site\":\"same-origin\",\"Sec-Fetch-Mode\":\"cors\",\"Sec-Fetch-Dest\":\"empty\",\"Referer\":\"http:\\/\\/localhost\\/pages\\/backup\",\"Accept-Encoding\":\"gzip, deflate, br, zstd\",\"Accept-Language\":\"es-ES,es;q=0.9\"}}',NULL),
(11905,'2024-11-28 09:08:05','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(11906,'2024-11-28 09:08:05','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11907,'2024-11-28 09:08:05','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(11908,'2024-11-28 09:08:05','debug','Token extraído correctamente','{\"token_length\":194}',NULL),
(11909,'2024-11-28 09:08:05','debug','Verificando token','{\"token_length\":194,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(11910,'2024-11-28 09:08:05','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(11911,'2024-11-28 09:08:05','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(11912,'2024-11-28 09:08:05','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(11913,'2024-11-28 09:08:05','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/backup\\/ultimo\"}','2'),
(11914,'2024-11-28 09:08:05','info','Obteniendo información del último backup',NULL,NULL),
(11915,'2024-11-28 09:08:05','debug','Directorio de backups: /var/www/html/database',NULL,NULL),
(11916,'2024-11-28 09:08:05','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}',NULL),
(11917,'2024-11-28 09:08:05','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-33.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-38.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}',NULL),
(11918,'2024-11-28 09:08:05','debug','Último backup encontrado','{\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"fecha\":\"2024-11-27 15:01:18\"}',NULL),
(11919,'2024-11-28 09:08:05','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11920,'2024-11-28 09:08:05','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11921,'2024-11-28 09:08:26','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11922,'2024-11-28 09:08:26','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11923,'2024-11-28 09:08:26','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"Pragma\":\"no-cache\",\"Cache-Control\":\"no-cache\",\"Sec-Ch-Ua-Platform\":\"\\\"Android\\\"\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3ODI5ODAsImV4cCI6MTczMjg2OTM4MCwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.cMM1xLQD22\\/voJauKOGqYQ2RXsdv+0XUD0q7mmEF5Bw=\",\"User-Agent\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Mobile Safari\\/537.36\",\"Accept\":\"application\\/json, text\\/plain, *\\/*\",\"Sec-Ch-Ua\":\"\\\"Google Chrome\\\";v=\\\"131\\\", \\\"Chromium\\\";v=\\\"131\\\", \\\"Not_A Brand\\\";v=\\\"24\\\"\",\"Sec-Ch-Ua-Mobile\":\"?1\",\"Sec-Fetch-Site\":\"same-origin\",\"Sec-Fetch-Mode\":\"cors\",\"Sec-Fetch-Dest\":\"empty\",\"Referer\":\"http:\\/\\/localhost\\/pages\\/backup\",\"Accept-Encoding\":\"gzip, deflate, br, zstd\",\"Accept-Language\":\"es-ES,es;q=0.9\"}}',NULL),
(11924,'2024-11-28 09:08:26','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(11925,'2024-11-28 09:08:26','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11926,'2024-11-28 09:08:26','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(11927,'2024-11-28 09:08:26','debug','Token extraído correctamente','{\"token_length\":194}',NULL),
(11928,'2024-11-28 09:08:26','debug','Verificando token','{\"token_length\":194,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(11929,'2024-11-28 09:08:26','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(11930,'2024-11-28 09:08:26','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(11931,'2024-11-28 09:08:26','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(11932,'2024-11-28 09:08:26','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/backup\\/ultimo\"}','2'),
(11933,'2024-11-28 09:08:26','info','Obteniendo información del último backup',NULL,NULL),
(11934,'2024-11-28 09:08:26','debug','Directorio de backups: /var/www/html/database',NULL,NULL),
(11935,'2024-11-28 09:08:26','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}',NULL),
(11936,'2024-11-28 09:08:26','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-33.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-38.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}',NULL),
(11937,'2024-11-28 09:08:26','debug','Último backup encontrado','{\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"fecha\":\"2024-11-27 15:01:18\"}',NULL),
(11938,'2024-11-28 09:08:26','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11939,'2024-11-28 09:08:26','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11940,'2024-11-28 09:47:55','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11941,'2024-11-28 09:47:55','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11942,'2024-11-28 09:47:55','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"Pragma\":\"no-cache\",\"Cache-Control\":\"no-cache\",\"Sec-Ch-Ua-Platform\":\"\\\"Android\\\"\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3ODI5ODAsImV4cCI6MTczMjg2OTM4MCwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.cMM1xLQD22\\/voJauKOGqYQ2RXsdv+0XUD0q7mmEF5Bw=\",\"User-Agent\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Mobile Safari\\/537.36\",\"Accept\":\"application\\/json, text\\/plain, *\\/*\",\"Sec-Ch-Ua\":\"\\\"Google Chrome\\\";v=\\\"131\\\", \\\"Chromium\\\";v=\\\"131\\\", \\\"Not_A Brand\\\";v=\\\"24\\\"\",\"Sec-Ch-Ua-Mobile\":\"?1\",\"Sec-Fetch-Site\":\"same-origin\",\"Sec-Fetch-Mode\":\"cors\",\"Sec-Fetch-Dest\":\"empty\",\"Referer\":\"http:\\/\\/localhost\\/pages\\/backup\",\"Accept-Encoding\":\"gzip, deflate, br, zstd\",\"Accept-Language\":\"es-ES,es;q=0.9\"}}',NULL),
(11943,'2024-11-28 09:47:55','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(11944,'2024-11-28 09:47:55','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11945,'2024-11-28 09:47:55','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(11946,'2024-11-28 09:47:55','debug','Token extraído correctamente','{\"token_length\":194}',NULL),
(11947,'2024-11-28 09:47:55','debug','Verificando token','{\"token_length\":194,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(11948,'2024-11-28 09:47:55','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(11949,'2024-11-28 09:47:55','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(11950,'2024-11-28 09:47:55','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(11951,'2024-11-28 09:47:55','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/backup\\/ultimo\"}','2'),
(11952,'2024-11-28 09:47:55','info','Obteniendo información del último backup',NULL,NULL),
(11953,'2024-11-28 09:47:55','debug','Directorio de backups: /var/www/html/database',NULL,NULL),
(11954,'2024-11-28 09:47:55','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}',NULL),
(11955,'2024-11-28 09:47:55','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-33.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-38.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}',NULL),
(11956,'2024-11-28 09:47:55','debug','Último backup encontrado','{\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"fecha\":\"2024-11-27 15:01:18\"}',NULL),
(11957,'2024-11-28 09:47:55','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11958,'2024-11-28 09:47:55','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11959,'2024-11-28 09:48:46','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11960,'2024-11-28 09:48:46','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11961,'2024-11-28 09:48:46','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"Pragma\":\"no-cache\",\"Cache-Control\":\"no-cache\",\"Sec-Ch-Ua-Platform\":\"\\\"Android\\\"\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3ODI5ODAsImV4cCI6MTczMjg2OTM4MCwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.cMM1xLQD22\\/voJauKOGqYQ2RXsdv+0XUD0q7mmEF5Bw=\",\"User-Agent\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Mobile Safari\\/537.36\",\"Accept\":\"application\\/json, text\\/plain, *\\/*\",\"Sec-Ch-Ua\":\"\\\"Google Chrome\\\";v=\\\"131\\\", \\\"Chromium\\\";v=\\\"131\\\", \\\"Not_A Brand\\\";v=\\\"24\\\"\",\"Sec-Ch-Ua-Mobile\":\"?1\",\"Sec-Fetch-Site\":\"same-origin\",\"Sec-Fetch-Mode\":\"cors\",\"Sec-Fetch-Dest\":\"empty\",\"Referer\":\"http:\\/\\/localhost\\/pages\\/backup\",\"Accept-Encoding\":\"gzip, deflate, br, zstd\",\"Accept-Language\":\"es-ES,es;q=0.9\"}}',NULL),
(11962,'2024-11-28 09:48:46','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(11963,'2024-11-28 09:48:46','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11964,'2024-11-28 09:48:46','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(11965,'2024-11-28 09:48:46','debug','Token extraído correctamente','{\"token_length\":194}',NULL),
(11966,'2024-11-28 09:48:46','debug','Verificando token','{\"token_length\":194,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(11967,'2024-11-28 09:48:46','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(11968,'2024-11-28 09:48:46','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(11969,'2024-11-28 09:48:46','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(11970,'2024-11-28 09:48:46','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/backup\\/ultimo\"}','2'),
(11971,'2024-11-28 09:48:46','info','Obteniendo información del último backup',NULL,NULL),
(11972,'2024-11-28 09:48:46','debug','Directorio de backups: /var/www/html/database',NULL,NULL),
(11973,'2024-11-28 09:48:46','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}',NULL),
(11974,'2024-11-28 09:48:46','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-33.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-38.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}',NULL),
(11975,'2024-11-28 09:48:46','debug','Último backup encontrado','{\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"fecha\":\"2024-11-27 15:01:18\"}',NULL),
(11976,'2024-11-28 09:48:46','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11977,'2024-11-28 09:48:46','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11978,'2024-11-28 09:48:57','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11979,'2024-11-28 09:48:57','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11980,'2024-11-28 09:48:57','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"Pragma\":\"no-cache\",\"Cache-Control\":\"no-cache\",\"Sec-Ch-Ua-Platform\":\"\\\"Android\\\"\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3ODI5ODAsImV4cCI6MTczMjg2OTM4MCwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.cMM1xLQD22\\/voJauKOGqYQ2RXsdv+0XUD0q7mmEF5Bw=\",\"User-Agent\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Mobile Safari\\/537.36\",\"Accept\":\"application\\/json, text\\/plain, *\\/*\",\"Sec-Ch-Ua\":\"\\\"Google Chrome\\\";v=\\\"131\\\", \\\"Chromium\\\";v=\\\"131\\\", \\\"Not_A Brand\\\";v=\\\"24\\\"\",\"Sec-Ch-Ua-Mobile\":\"?1\",\"Sec-Fetch-Site\":\"same-origin\",\"Sec-Fetch-Mode\":\"cors\",\"Sec-Fetch-Dest\":\"empty\",\"Referer\":\"http:\\/\\/localhost\\/pages\\/backup\",\"Accept-Encoding\":\"gzip, deflate, br, zstd\",\"Accept-Language\":\"es-ES,es;q=0.9\"}}',NULL),
(11981,'2024-11-28 09:48:57','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(11982,'2024-11-28 09:48:57','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11983,'2024-11-28 09:48:57','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(11984,'2024-11-28 09:48:57','debug','Token extraído correctamente','{\"token_length\":194}',NULL),
(11985,'2024-11-28 09:48:57','debug','Verificando token','{\"token_length\":194,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(11986,'2024-11-28 09:48:57','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(11987,'2024-11-28 09:48:57','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(11988,'2024-11-28 09:48:57','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(11989,'2024-11-28 09:48:57','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/backup\\/ultimo\"}','2'),
(11990,'2024-11-28 09:48:57','info','Obteniendo información del último backup',NULL,NULL),
(11991,'2024-11-28 09:48:57','debug','Directorio de backups: /var/www/html/database',NULL,NULL),
(11992,'2024-11-28 09:48:57','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}',NULL),
(11993,'2024-11-28 09:48:57','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-33.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-38.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}',NULL),
(11994,'2024-11-28 09:48:57','debug','Último backup encontrado','{\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"fecha\":\"2024-11-27 15:01:18\"}',NULL),
(11995,'2024-11-28 09:48:57','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11996,'2024-11-28 09:48:57','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(11997,'2024-11-28 09:49:38','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(11998,'2024-11-28 09:49:38','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(11999,'2024-11-28 09:49:38','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"Pragma\":\"no-cache\",\"Cache-Control\":\"no-cache\",\"Sec-Ch-Ua-Platform\":\"\\\"Android\\\"\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3ODI5ODAsImV4cCI6MTczMjg2OTM4MCwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.cMM1xLQD22\\/voJauKOGqYQ2RXsdv+0XUD0q7mmEF5Bw=\",\"User-Agent\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Mobile Safari\\/537.36\",\"Accept\":\"application\\/json, text\\/plain, *\\/*\",\"Sec-Ch-Ua\":\"\\\"Google Chrome\\\";v=\\\"131\\\", \\\"Chromium\\\";v=\\\"131\\\", \\\"Not_A Brand\\\";v=\\\"24\\\"\",\"Sec-Ch-Ua-Mobile\":\"?1\",\"Sec-Fetch-Site\":\"same-origin\",\"Sec-Fetch-Mode\":\"cors\",\"Sec-Fetch-Dest\":\"empty\",\"Referer\":\"http:\\/\\/localhost\\/pages\\/backup\",\"Accept-Encoding\":\"gzip, deflate, br, zstd\",\"Accept-Language\":\"es-ES,es;q=0.9\"}}',NULL),
(12000,'2024-11-28 09:49:38','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(12001,'2024-11-28 09:49:38','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(12002,'2024-11-28 09:49:38','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(12003,'2024-11-28 09:49:38','debug','Token extraído correctamente','{\"token_length\":194}',NULL),
(12004,'2024-11-28 09:49:38','debug','Verificando token','{\"token_length\":194,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(12005,'2024-11-28 09:49:38','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(12006,'2024-11-28 09:49:38','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(12007,'2024-11-28 09:49:38','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(12008,'2024-11-28 09:49:38','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/backup\\/ultimo\"}','2'),
(12009,'2024-11-28 09:49:38','info','Obteniendo información del último backup',NULL,NULL),
(12010,'2024-11-28 09:49:38','debug','Directorio de backups: /var/www/html/database',NULL,NULL),
(12011,'2024-11-28 09:49:38','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}',NULL),
(12012,'2024-11-28 09:49:38','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-33.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-38.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}',NULL),
(12013,'2024-11-28 09:49:38','debug','Último backup encontrado','{\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"fecha\":\"2024-11-27 15:01:18\"}',NULL),
(12014,'2024-11-28 09:49:38','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(12015,'2024-11-28 09:49:38','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(12016,'2024-11-28 09:49:43','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(12017,'2024-11-28 09:49:43','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/database\\/download\",\"es_publica\":false}',NULL),
(12018,'2024-11-28 09:49:43','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/database\\/download\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"Pragma\":\"no-cache\",\"Cache-Control\":\"no-cache\",\"Sec-Ch-Ua-Platform\":\"\\\"Android\\\"\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3ODI5ODAsImV4cCI6MTczMjg2OTM4MCwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.cMM1xLQD22\\/voJauKOGqYQ2RXsdv+0XUD0q7mmEF5Bw=\",\"User-Agent\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Mobile Safari\\/537.36\",\"Accept\":\"application\\/json, text\\/plain, *\\/*\",\"Sec-Ch-Ua\":\"\\\"Google Chrome\\\";v=\\\"131\\\", \\\"Chromium\\\";v=\\\"131\\\", \\\"Not_A Brand\\\";v=\\\"24\\\"\",\"Sec-Ch-Ua-Mobile\":\"?1\",\"Sec-Fetch-Site\":\"same-origin\",\"Sec-Fetch-Mode\":\"cors\",\"Sec-Fetch-Dest\":\"empty\",\"Referer\":\"http:\\/\\/localhost\\/pages\\/backup\",\"Accept-Encoding\":\"gzip, deflate, br, zstd\",\"Accept-Language\":\"es-ES,es;q=0.9\"}}',NULL),
(12019,'2024-11-28 09:49:43','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/database\\/download\",\"metodo\":\"GET\"}',NULL),
(12020,'2024-11-28 09:49:43','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/database\\/download\",\"es_publica\":false}',NULL),
(12021,'2024-11-28 09:49:43','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(12022,'2024-11-28 09:49:43','debug','Token extraído correctamente','{\"token_length\":194}',NULL),
(12023,'2024-11-28 09:49:43','debug','Verificando token','{\"token_length\":194,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(12024,'2024-11-28 09:49:43','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(12025,'2024-11-28 09:49:43','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(12026,'2024-11-28 09:49:43','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(12027,'2024-11-28 09:49:43','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/database\\/download\"}','2'),
(12028,'2024-11-28 09:49:43','info','=== INICIANDO DESCARGA DE BASE DE DATOS ===',NULL,NULL),
(12029,'2024-11-28 09:49:43','info','Verificando mysqldump',NULL,NULL),
(12030,'2024-11-28 09:49:43','info','mysqldump encontrado en: /usr/bin/mysqldump',NULL,NULL),
(12031,'2024-11-28 09:49:43','info','Probando conexión a la base de datos',NULL,NULL),
(12032,'2024-11-28 09:49:43','info','Ejecutando mysqldump',NULL,NULL),
(12033,'2024-11-28 09:49:43','debug','Comando (sin password): mysqldump --no-tablespaces --skip-lock-tables --single-transaction --quick --add-drop-table --create-options --extended-insert --set-charset -h\'cbt-db\' -u\'cbt_user\' -p**** \'cityboardtorrejon\' > \'/tmp/sql_IUKN0I\' 2>&1',NULL,NULL),
(12034,'2024-11-28 09:50:42','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(12035,'2024-11-28 09:50:42','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(12036,'2024-11-28 09:50:42','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"Pragma\":\"no-cache\",\"Cache-Control\":\"no-cache\",\"Sec-Ch-Ua-Platform\":\"\\\"Android\\\"\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3ODI5ODAsImV4cCI6MTczMjg2OTM4MCwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.cMM1xLQD22\\/voJauKOGqYQ2RXsdv+0XUD0q7mmEF5Bw=\",\"User-Agent\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Mobile Safari\\/537.36\",\"Accept\":\"application\\/json, text\\/plain, *\\/*\",\"Sec-Ch-Ua\":\"\\\"Google Chrome\\\";v=\\\"131\\\", \\\"Chromium\\\";v=\\\"131\\\", \\\"Not_A Brand\\\";v=\\\"24\\\"\",\"Sec-Ch-Ua-Mobile\":\"?1\",\"Sec-Fetch-Site\":\"same-origin\",\"Sec-Fetch-Mode\":\"cors\",\"Sec-Fetch-Dest\":\"empty\",\"Referer\":\"http:\\/\\/localhost\\/pages\\/backup\",\"Accept-Encoding\":\"gzip, deflate, br, zstd\",\"Accept-Language\":\"es-ES,es;q=0.9\"}}',NULL),
(12037,'2024-11-28 09:50:42','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"metodo\":\"GET\"}',NULL),
(12038,'2024-11-28 09:50:42','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/ultimo\",\"es_publica\":false}',NULL),
(12039,'2024-11-28 09:50:42','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(12040,'2024-11-28 09:50:42','debug','Token extraído correctamente','{\"token_length\":194}',NULL),
(12041,'2024-11-28 09:50:42','debug','Verificando token','{\"token_length\":194,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(12042,'2024-11-28 09:50:42','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(12043,'2024-11-28 09:50:42','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(12044,'2024-11-28 09:50:42','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(12045,'2024-11-28 09:50:42','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/backup\\/ultimo\"}','2'),
(12046,'2024-11-28 09:50:42','info','Obteniendo información del último backup',NULL,NULL),
(12047,'2024-11-28 09:50:42','debug','Directorio de backups: /var/www/html/database',NULL,NULL),
(12048,'2024-11-28 09:50:42','debug','Directorio de backups encontrado','{\"directorio\":\"\\/var\\/www\\/html\\/database\"}',NULL),
(12049,'2024-11-28 09:50:42','debug','Archivos de backups encontrados','{\"archivos\":[\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-04-31.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-05-17.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-57-56.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-33.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_09-59-38.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2211241312.sql\",\"\\/var\\/www\\/html\\/database\\/backup_2511241114.sql\"]}',NULL),
(12050,'2024-11-28 09:50:42','debug','Último backup encontrado','{\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"fecha\":\"2024-11-27 15:01:18\"}',NULL),
(12051,'2024-11-28 09:50:42','debug','Información del último backup','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(12052,'2024-11-28 09:50:42','debug','Información del último backup obtenida correctamente','{\"infoBackup\":{\"timestamp\":\"2024-11-27T15:01:18+00:00\",\"fecha_formateada\":\"2024-11-27 15:01:18\",\"archivo\":\"backup_2024-11-27_15-01-18.sql\",\"tama\\u00f1o\":505251,\"ruta\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-27_15-01-18.sql\"}}',NULL),
(12053,'2024-11-28 09:50:47','debug','Constructor AutenticacionController - Inicio',NULL,NULL),
(12054,'2024-11-28 09:50:47','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/create\",\"es_publica\":false}',NULL),
(12055,'2024-11-28 09:50:47','debug','Ruta no pública, verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/create\",\"headers\":{\"Host\":\"localhost\",\"X-Real-Ip\":\"172.18.0.1\",\"X-Forwarded-For\":\"172.18.0.1\",\"X-Forwarded-Proto\":\"http\",\"Connection\":\"close\",\"Content-Length\":\"0\",\"Pragma\":\"no-cache\",\"Cache-Control\":\"no-cache\",\"Sec-Ch-Ua-Platform\":\"\\\"Android\\\"\",\"Authorization\":\"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3ODI5ODAsImV4cCI6MTczMjg2OTM4MCwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.cMM1xLQD22\\/voJauKOGqYQ2RXsdv+0XUD0q7mmEF5Bw=\",\"User-Agent\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Mobile Safari\\/537.36\",\"Accept\":\"application\\/json, text\\/plain, *\\/*\",\"Sec-Ch-Ua\":\"\\\"Google Chrome\\\";v=\\\"131\\\", \\\"Chromium\\\";v=\\\"131\\\", \\\"Not_A Brand\\\";v=\\\"24\\\"\",\"Sec-Ch-Ua-Mobile\":\"?1\",\"Origin\":\"http:\\/\\/localhost\",\"Sec-Fetch-Site\":\"same-origin\",\"Sec-Fetch-Mode\":\"cors\",\"Sec-Fetch-Dest\":\"empty\",\"Referer\":\"http:\\/\\/localhost\\/pages\\/backup\",\"Accept-Encoding\":\"gzip, deflate, br, zstd\",\"Accept-Language\":\"es-ES,es;q=0.9\"}}',NULL),
(12056,'2024-11-28 09:50:47','debug','Verificando autenticación','{\"ruta\":\"\\/api\\/backup\\/create\",\"metodo\":\"POST\"}',NULL),
(12057,'2024-11-28 09:50:47','debug','Verificando ruta pública','{\"ruta\":\"\\/api\\/backup\\/create\",\"es_publica\":false}',NULL),
(12058,'2024-11-28 09:50:47','debug','Obteniendo token de header','{\"header\":\"presente\"}',NULL),
(12059,'2024-11-28 09:50:47','debug','Token extraído correctamente','{\"token_length\":194}',NULL),
(12060,'2024-11-28 09:50:47','debug','Verificando token','{\"token_length\":194,\"token_start\":\"eyJ0eXAiOiJKV1QiLCJh...\"}',NULL),
(12061,'2024-11-28 09:50:47','debug','Token verificado correctamente','{\"usuario_id\":2,\"usuario_email\":\"agimeno@equinsa.es\"}',NULL),
(12062,'2024-11-28 09:50:47','debug','Resultado verificación token','{\"valido\":true,\"tiene_usuario\":true,\"datos_usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"}}',NULL),
(12063,'2024-11-28 09:50:47','debug','Usuario establecido en F3','{\"id\":2,\"email\":\"agimeno@equinsa.es\"}','2'),
(12064,'2024-11-28 09:50:47','debug','Autenticación exitosa en constructor','{\"usuario\":{\"id\":2,\"email\":\"agimeno@equinsa.es\"},\"ruta\":\"\\/api\\/backup\\/create\"}','2'),
(12065,'2024-11-28 09:50:47','debug','Creando backup',NULL,NULL),
(12066,'2024-11-28 09:50:47','debug','Directorio de backups: /var/www/html/database',NULL,NULL),
(12067,'2024-11-28 09:50:47','debug','BACKUP_DIR configurado: /var/www/html/database',NULL,NULL),
(12068,'2024-11-28 09:50:47','debug','Directorio de backups creado: /var/www/html/database',NULL,NULL),
(12069,'2024-11-28 09:50:48','debug','Directorio de backups tiene permisos de escritura','{\"directorio\":\"\\/var\\/www\\/html\\/database\",\"permisos\":16895}',NULL),
(12070,'2024-11-28 09:50:48','debug','Configuración de base de datos','{\"host\":\"cbt-db\",\"database\":\"cityboardtorrejon\",\"user\":\"cbt_user\"}',NULL),
(12071,'2024-11-28 09:50:48','debug','Archivo de backup a crear','{\"archivo\":\"\\/var\\/www\\/html\\/database\\/backup_2024-11-28_09-50-48.sql\"}',NULL),
(12072,'2024-11-28 09:50:48','debug','Timestamp','{\"timestamp\":\"2024-11-28_09-50-48\"}',NULL),
(12073,'2024-11-28 09:50:48','debug','mysqldump disponible','{\"output\":[\"\\/usr\\/bin\\/mysqldump\"]}',NULL),
(12074,'2024-11-28 09:50:48','debug','Ejecutando comando de backup',NULL,NULL);
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
  `token` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Token de autenticación del usuario',
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
(2,'Langton','agimeno@equinsa.es','8ae05fbff8d9b4fe1c8d1c0a773d65432a580b4f38f20525673174830e872338','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI3ODI5ODAsImV4cCI6MTczMjg2OTM4MCwidXN1YXJpbyI6eyJpZCI6MiwiZW1haWwiOiJhZ2ltZW5vQGVxdWluc2EuZXMifX0=.cMM1xLQD22/voJauKOGqYQ2RXsdv+0XUD0q7mmEF5Bw=','2024-11-28 08:36:20'),
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

-- Dump completed on 2024-11-28  9:50:48
