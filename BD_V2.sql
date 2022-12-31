-- MySQL dump 10.13  Distrib 8.0.30, for Linux (x86_64)
--
-- Host: localhost    Database: rtmb
-- ------------------------------------------------------
-- Server version	8.0.30-0ubuntu0.20.04.2

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
-- Table structure for table `attraction`
--

DROP TABLE IF EXISTS `attraction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8 */;
CREATE TABLE `attraction` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `short_description` varchar(300) NOT NULL,
  `long_description` varchar(255) DEFAULT NULL,
  `cover_image` varchar(255) DEFAULT NULL,
  `images` text,
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `cantonId` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_5ad76f18db39092c5ab4f2fd3b3` (`cantonId`),
  CONSTRAINT `FK_5ad76f18db39092c5ab4f2fd3b3` FOREIGN KEY (`cantonId`) REFERENCES `canton` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attraction`
--

LOCK TABLES `attraction` WRITE;
/*!40000 ALTER TABLE `attraction` DISABLE KEYS */;
INSERT INTO `attraction` VALUES 
('04d0faa0-e383-4b99-9b4e-f48fdb39e9ba','Rio Matalanga',-4.08333,-80.1167,'Ubicado en la parroquia Chiquinal','Rio que posee una abundante flora y fauna, es famoso por la pureza de sus aguas, existe el mito que su fuente vienen del mítico lugar “Agua de Vida”, ya que su fuente se encuentra en el interior del cerro Matalanga.','https://bosquesecoturismo.com/x/cdn/?https://storage.googleapis.com/wzukusers/user-27851147/images/5923655eeed76YDGfImF/puyando2_d400.jpeg','string','2022-12-29 17:12:13.831407','2022-12-29 17:12:13.831407','b4f3beb0-5a8f-495b-b1ea-8ac46470d7b7'),
('2cd69e52-f5b6-4517-9245-597c27a0919d','Piedra del Indio',-4.04856,-79.6526,'Se encuentra a 25 km de la ciudad de catacocha.','Es un petroglifo grabado con la técnica del inciso, un bloque de piedra piramidal donde representa una figura de ser humano que está en posición de lamento','https://assets.isu.pub/document-structure/211119191325-c9a7f9c94f63b2301cfd43168955de60/v1/97b3dbbff5c1dfe21aaab3ad825e98e9.jpeg','string','2022-12-29 17:37:41.342794','2022-12-29 17:37:41.342794','1825a10d-bb7a-428b-b87e-e408cef7679f'),
('6c6fa523-050f-42f8-856b-1085012f6855','Mangahurco Huayacanes​',-4.15684,-80.4317,'description','La parroquia Mangahurco se encuentra en el epicentro de la reserva Natural del Bosque Seco y es punto de encuentro para los turistas que vistan el florecimiento de los guayacanes en los meses de lluvias.','assets/guayacanes.jpeg',NULL,'2022-11-15 07:22:09.120887','2022-12-23 21:48:02.209079','0a2736f3-4291-4124-a391-412c79424ee8'),
('  ','Bosque Protector Cardo Palto',-4.37245,-79.936,'string','​Ubicado a 1km de la ciudad, con una extensión de 90.83 hectáreas, incluyendo una granja de palto que conforma parte de un convenio entre el Colegio Técnico de Macara y PREDESUR','assets/protector.jpeg',NULL,'2022-11-15 07:11:02.404386','2022-12-23 21:53:33.360603','8f02e6b9-ffb8-44a7-b8c3-cc9884bcffe4'),
('d4f91900-b898-4832-a333-5da1510609f3','Reloj de ocho esferas',-4.01786,-80.0196,'Ubicado en la parroquia de Alamor','Fue fabricado en Alemania en el año 1917, es una joya única en el mundo puesto que no fue realizado en serie.','https://ec.viajandox.com/uploads/Reloj_2.jpg','string','2022-12-29 17:24:40.809438','2022-12-29 17:24:40.809438','397b2b92-0f9e-4af3-abed-90be4e7befc7'),
('ea39759e-8992-4be0-b50e-a47c93c8e94b','Cerro Huayrapungo​',-4.07527,-79.9605,'description','​Se encuentra a 11 km del centro de la ciudad y tiene una altura aproximada de 3500 metros sobre el nivel del mar. Se accede por una vía que está en buenas condiciones','assets/cerro.jpg',NULL,'2022-11-15 07:17:21.739523','2022-12-23 21:55:11.359542','3957d66d-1bc6-463e-bc28-61073b443fb6');
/*!40000 ALTER TABLE `attraction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canton`
--

DROP TABLE IF EXISTS `canton`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8 */;
CREATE TABLE `canton` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `province` varchar(255) NOT NULL DEFAULT 'Loja',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_86029953a3e2ed6ad0f13a7b94` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canton`
--

LOCK TABLES `canton` WRITE;
/*!40000 ALTER TABLE `canton` DISABLE KEYS */;
INSERT INTO `canton` VALUES ('0a2736f3-4291-4124-a391-412c79424ee8','Zapotillo','https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Bandera_del_Cant%C3%B3n_Zapotillo.png/200px-Bandera_del_Cant%C3%B3n_Zapotillo.png','Loja','2022-11-15 07:00:21.294454','2022-12-19 20:55:02.632591'),('1825a10d-bb7a-428b-b87e-e408cef7679f','Paltas ','https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Bandera_de_Paltas.png/800px-Bandera_de_Paltas.png','Loja','2022-11-15 07:00:44.283145','2022-12-19 20:59:54.193852'),('3957d66d-1bc6-463e-bc28-61073b443fb6','Celica','https://upload.wikimedia.org/wikipedia/commons/a/a6/Bandera_de_Celica.png','Loja','2022-11-15 07:00:28.095369','2022-12-19 20:58:01.140184'),('397b2b92-0f9e-4af3-abed-90be4e7befc7','Puyango','https://upload.wikimedia.org/wikipedia/commons/4/40/Bandera_de_Puyango.png','Loja','2022-11-15 07:00:50.971436','2022-12-19 21:01:43.552088'),('8f02e6b9-ffb8-44a7-b8c3-cc9884bcffe4','Macará','https://upload.wikimedia.org/wikipedia/commons/c/cd/Bandera_de_Macar%C3%A1.png','Loja','2022-11-15 07:00:11.473475','2022-12-19 20:55:40.700215'),('b4f3beb0-5a8f-495b-b1ea-8ac46470d7b7','Pindal','https://upload.wikimedia.org/wikipedia/commons/2/2b/Bandera_de_Pindal.png','Loja','2022-11-15 07:00:39.829845','2022-12-19 21:03:32.017588');
/*!40000 ALTER TABLE `canton` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8 */;
CREATE TABLE `rating` (
  `id` varchar(36) NOT NULL,
  `stars` int NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `userId` varchar(36) DEFAULT NULL,
  `attractionId` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_a6c53dfc89ba3188b389ef29a62` (`userId`),
  KEY `FK_5339a0f5bbf9e00838aaa1f660c` (`attractionId`),
  CONSTRAINT `FK_5339a0f5bbf9e00838aaa1f660c` FOREIGN KEY (`attractionId`) REFERENCES `attraction` (`id`),
  CONSTRAINT `FK_a6c53dfc89ba3188b389ef29a62` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating`
--

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
/*!40000 ALTER TABLE `rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourist_route`
--

DROP TABLE IF EXISTS `tourist_route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8 */;utf8_general_ci
CREATE TABLE `tourist_route` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `isUserRoute` tinyint NOT NULL DEFAULT '1',
  `views` int NOT NULL DEFAULT '1',
  `path_length` int DEFAULT NULL,
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `ownerId` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_c826793e666d89f2c8ba74cefcb` (`ownerId`),
  CONSTRAINT `FK_c826793e666d89f2c8ba74cefcb` FOREIGN KEY (`ownerId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourist_route`
--

LOCK TABLES `tourist_route` WRITE;
/*!40000 ALTER TABLE `tourist_route` DISABLE KEYS */;
INSERT INTO `tourist_route` VALUES ('c65e2c05-72b2-470a-aab0-768539ce8cc5','ruta 1',0,1,453321,'2022-12-21 22:44:02.010640','2022-12-21 22:44:02.010640',NULL),('c65e2c05-72b2-470a-aab0-768539ce8dd4','ruta turistica',1,1,NULL,'2022-12-21 18:50:30.695654','2022-12-21 18:50:30.695654','eef5e0e7-0e99-46c3-954f-0a94ae239fba'),('c65e2c05-72b2-470a-aab0-768539ce8ee6','ruta 2',0,1,3321,'2022-12-21 22:44:17.066958','2022-12-21 22:44:17.066958',NULL);
/*!40000 ALTER TABLE `tourist_route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourist_route_attractions_attraction`
--

DROP TABLE IF EXISTS `tourist_route_attractions_attraction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8 */;
CREATE TABLE `tourist_route_attractions_attraction` (
  `touristRouteId` varchar(36) NOT NULL,
  `attractionId` varchar(36) NOT NULL,
  PRIMARY KEY (`touristRouteId`,`attractionId`),
  KEY `IDX_bc241097877c2f9118c3b75953` (`touristRouteId`),
  KEY `IDX_97f4dbad8704a617b8693d9a28` (`attractionId`),
  CONSTRAINT `FK_97f4dbad8704a617b8693d9a28b` FOREIGN KEY (`attractionId`) REFERENCES `attraction` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_bc241097877c2f9118c3b759538` FOREIGN KEY (`touristRouteId`) REFERENCES `tourist_route` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourist_route_attractions_attraction`
--

LOCK TABLES `tourist_route_attractions_attraction` WRITE;
/*!40000 ALTER TABLE `tourist_route_attractions_attraction` DISABLE KEYS */;
INSERT INTO `tourist_route_attractions_attraction` VALUES ('c65e2c05-72b2-470a-aab0-768539ce8dd4','6c6fa523-050f-42f8-856b-1085012f6855'),('c65e2c05-72b2-470a-aab0-768539ce8dd4','abbc1efe-2bb4-49cf-aca7-4f48c3a90d09');
/*!40000 ALTER TABLE `tourist_route_attractions_attraction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` varchar(36) NOT NULL,
  `name` varchar(80) NOT NULL,
  `role` enum('Admin','Guest','User','Tourist Admin') NOT NULL DEFAULT 'User',
  `email` varchar(70) NOT NULL,
  `authSocialToken` varchar(255) DEFAULT NULL,
  `password` varchar(1024) NOT NULL,
  `isActive` tinyint NOT NULL DEFAULT '1',
  `imageUrl` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_e12875dfb3b1d92d7d7c5377e2` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('eef5e0e7-0e99-46c3-954f-0a94ae239fba','Juan','User','darlackwow76@gmail.com',NULL,'$2b$10$ntvBrJRKqaWN1xrVGmEb6u3z6awhQ1nktmETR599yC8UrlaOeE26.',1,NULL,NULL,'2022-11-15 06:40:26.228282','2022-11-15 06:40:26.228282');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-29 12:43:01
