-- MySQL dump 10.13  Distrib 8.0.30, for Linux (x86_64)
--
-- Host: localhost    Database: RTMB
-- ------------------------------------------------------
-- Server version	8.0.30-0ubuntu0.20.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `RTMB`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `RTMB` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `RTMB`;

--
-- Table structure for table `attraction`
--

DROP TABLE IF EXISTS `attraction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attraction` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `long_description` varchar(255) DEFAULT NULL,
  `cover_image` varchar(255) DEFAULT NULL,
  `images` text,
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `cantonId` varchar(36) DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `short_description` varchar(300) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_5ad76f18db39092c5ab4f2fd3b3` (`cantonId`),
  CONSTRAINT `FK_5ad76f18db39092c5ab4f2fd3b3` FOREIGN KEY (`cantonId`) REFERENCES `canton` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attraction`
--

LOCK TABLES `attraction` WRITE;
/*!40000 ALTER TABLE `attraction` DISABLE KEYS */;
INSERT INTO `attraction` VALUES ('061672de-e0bb-4698-855c-abb63a00a05f','Bosque Protector Cardo Palto​',NULL,'assets/protector.jpeg',NULL,'2022-08-09 05:49:01.329565','2022-09-04 23:05:38.500214','f9ac9587-fa7e-11ec-804b-2cdb0751b50d',-4.37245,-79.936,''),('0de34c39-4105-4435-8c3f-dae5c019a115','Piscina Natural',NULL,'assets/pscina.jpeg',NULL,'2022-08-09 05:44:31.372676','2022-09-04 23:05:51.529528','c4c9c91a-fa7e-11ec-804b-2cdb0751b50d',-4.11058,-80.1121,''),('506a0289-93a3-41e8-ae53-1eef2f1d9b62','Cerro Huayrapungo​',NULL,'assets/cerro.jpg',NULL,'2022-08-09 05:46:14.431009','2022-09-04 23:06:07.594088','c4c9c91a-fa7e-11ec-804b-2cdb0751b50d',-4.07527,-79.9605,''),('674c5549-aa50-49e3-bb47-7588e6e04df9','Bosque Petrificado​',NULL,'assets/bosque.jpeg',NULL,'2022-08-09 05:47:08.888747','2022-09-04 23:06:40.988001','c4c9d4d6-fa7e-11ec-804b-2cdb0751b50d',-3.89363,-80.0676,''),('fbfae1ea-e070-407d-9cd6-e3c2feab3fe2','Mangahurco \'Huayacanes\'​',NULL,'assets/guayacanes.jpeg',NULL,'2022-08-09 05:48:15.822664','2022-09-04 23:07:07.433575','f9ac9587-fa7e-11ec-804b-2cdb0751b50d',-4.15684,-80.4317,'');
/*!40000 ALTER TABLE `attraction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canton`
--

DROP TABLE IF EXISTS `canton`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `canton` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `province` varchar(255) NOT NULL DEFAULT 'Loja',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_86029953a3e2ed6ad0f13a7b94` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canton`
--

LOCK TABLES `canton` WRITE;
/*!40000 ALTER TABLE `canton` DISABLE KEYS */;
INSERT INTO `canton` VALUES ('013fa008-fa7f-11ec-804b-2cdb0751b50d','Celica',NULL,'Loja','2022-06-26 04:09:27.747947','2022-07-03 03:19:53.037722'),('c4c9af57-fa7e-11ec-804b-2cdb0751b50d','Macará',NULL,'Loja','2022-06-26 04:09:26.943558','2022-07-03 03:18:11.601387'),('c4c9c91a-fa7e-11ec-804b-2cdb0751b50d','Pindal',NULL,'Loja','2022-06-26 04:09:28.209891','2022-07-03 03:18:11.601387'),('c4c9cebf-fa7e-11ec-804b-2cdb0751b50d','Paltas',NULL,'Loja','2022-06-26 04:09:29.061464','2022-07-03 03:18:11.601387'),('c4c9d4d6-fa7e-11ec-804b-2cdb0751b50d','Puyandgo',NULL,'Loja','2022-06-26 04:09:29.131751','2022-07-03 03:18:11.601387'),('f9ac9587-fa7e-11ec-804b-2cdb0751b50d','Zapotillo',NULL,'Loja','2022-06-26 04:09:27.643155','2022-07-03 03:19:40.330185');
/*!40000 ALTER TABLE `canton` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tourist_route` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `views` int NOT NULL DEFAULT '1',
  `path_length` int DEFAULT NULL,
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `userId` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_f5851694fc9dc8dbea9a558ecec` (`userId`),
  CONSTRAINT `FK_f5851694fc9dc8dbea9a558ecec` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourist_route`
--

LOCK TABLES `tourist_route` WRITE;
/*!40000 ALTER TABLE `tourist_route` DISABLE KEYS */;
/*!40000 ALTER TABLE `tourist_route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tourist_route_attractions_attraction`
--

DROP TABLE IF EXISTS `tourist_route_attractions_attraction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tourist_route_attractions_attraction` (
  `touristRouteId` varchar(36) NOT NULL,
  `attractionId` varchar(36) NOT NULL,
  PRIMARY KEY (`touristRouteId`,`attractionId`),
  KEY `IDX_bc241097877c2f9118c3b75953` (`touristRouteId`),
  KEY `IDX_97f4dbad8704a617b8693d9a28` (`attractionId`),
  CONSTRAINT `FK_97f4dbad8704a617b8693d9a28b` FOREIGN KEY (`attractionId`) REFERENCES `attraction` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_bc241097877c2f9118c3b759538` FOREIGN KEY (`touristRouteId`) REFERENCES `tourist_route` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tourist_route_attractions_attraction`
--

LOCK TABLES `tourist_route_attractions_attraction` WRITE;
/*!40000 ALTER TABLE `tourist_route_attractions_attraction` DISABLE KEYS */;
/*!40000 ALTER TABLE `tourist_route_attractions_attraction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` varchar(36) NOT NULL,
  `role` enum('Admin','Guest','User','Tourist Admin') NOT NULL DEFAULT 'User',
  `email` varchar(70) NOT NULL,
  `authSocialToken` varchar(255) DEFAULT NULL,
  `isActive` tinyint NOT NULL DEFAULT '1',
  `imageUrl` varchar(255) DEFAULT NULL,
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `password` varchar(255) NOT NULL,
  `name` varchar(80) NOT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_e12875dfb3b1d92d7d7c5377e2` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('00bf47e9-0ad1-4c5d-9394-1438d0e696d9','User','itest@test.com',NULL,1,NULL,'2022-09-04 04:19:27.983355','2022-09-04 04:19:27.983355','$2b$10$fPs6titJt1s7szBo71zXLu5gR7.fFM7zxzuU4lSN4N8bUunS9BzB2','itest',NULL),('17685f6a-595f-4a34-b0f1-9b0f823b979e','User','t@gmail.com',NULL,1,NULL,'2022-07-18 06:22:54.223033','2022-07-18 06:22:54.223033','test','',NULL),('38e53cc0-42b1-4d97-b1dc-af82bef8855a','Admin','tester@tester.com',NULL,1,NULL,'2022-08-25 15:57:00.838719','2022-08-25 15:57:00.838719','$2b$10$47CctLvVtetX4pV6r2vJh.NjGUoOwm3rE4gpJm7.uyFQzd/EwxfbG','tester',NULL),('48a8447e-aaf7-479f-8f4b-bb4a63606465','User','testing@test2.com',NULL,1,NULL,'2022-06-11 17:08:54.793942','2022-06-11 17:08:54.793942','$2b$10$Q2oI46BECHnqulAWDS0CPef7m273wE/3QgJDuggiMikJCedBDT3T2','',NULL),('4943e0bf-7fdc-47ab-bfd8-ba0e0648df8d','User','tt@gmail.com',NULL,1,NULL,'2022-07-18 06:38:16.662970','2022-07-18 06:38:16.662970','$2b$10$Va6Pwoy8HMZKdC0fW1NJdu/VSORoUBZUV3zoAq2Lv6dQ.YCPqjUmS','',NULL),('5e56ac58-eef1-4b9c-b6a2-71d93340bf94','User','israel@testing.com',NULL,1,NULL,'2022-06-06 03:51:06.545312','2022-06-06 03:51:06.545312','$2b$10$LUrBkXQJVrwkOQSFdLlir.5bLF6HN6QidEfs9YLcVnWBXOXnqmu3S','',NULL),('70635fdc-ec6e-48a5-b051-75054fe82f5e','User','test@test.com',NULL,1,NULL,'2022-06-06 03:32:12.881280','2022-06-06 03:32:12.881280','test','',NULL),('78225844-0876-4a6a-a870-9336f629a8e3','User','testing@test.com',NULL,1,NULL,'2022-06-11 17:07:17.052187','2022-06-11 17:07:17.052187','$2b$10$OTWUafQjH8Obo3z5L8rLgOYiaVed.GvLD6ETP8HAW.9qcLzZku7yC','',NULL),('7a2f535d-87f0-4bcb-9a2e-d7d8cc7a6315','User','test@tes.com',NULL,1,NULL,'2022-06-08 18:51:00.691923','2022-06-08 18:51:00.691923','$2b$10$WhH0DdPsXrfJk/N049x7cuauiu4gxewg.l341.FJ9k2f0ZC9Qcc3y','',NULL),('b1d2e712-068f-4923-aaa6-6440b2b6beba','User','t@t.com',NULL,1,NULL,'2022-07-18 06:51:23.188187','2022-07-18 06:51:23.188187','$2b$10$Vlewhu5ulHOHg3qFlevx0uhIqK1JZRo4NNHNPnTOlAJES3.UJXzZS','',NULL),('b2c57534-31f5-4718-ba27-d29b148feea2','User','isratest@test.com',NULL,1,NULL,'2022-08-09 00:00:36.649468','2022-08-09 00:00:36.649468','$2b$10$e6zUjKjokMQQrgjCTJ81gOUTddTpN48PugEJt6h7MNbZK0iGjaE.m','isratest',NULL),('b6dc7a82-3959-402b-ad92-063a143d0d21','User','tester@test.com',NULL,1,NULL,'2022-06-08 18:07:08.526892','2022-06-08 18:07:08.526892','$2b$10$pFQ3guTGFGYOycs19iNdduG5cu2Rw9uBIc5.xVU7GbJE4D2V5UTUW','',NULL),('c0b311b8-1617-40c6-819b-242d19e90a88','User','test@triger.com',NULL,1,NULL,'2022-06-11 22:37:00.406514','2022-06-11 22:37:00.406514','$2b$10$v4rUZfMNrjsOZWPTDthN8.9Owd2xMk2O9USncKscuNfZ6E/KeUDCe','',NULL),('cc5d7929-1d1d-4c15-9487-904fec51c723','User','test1@test.com',NULL,1,NULL,'2022-06-08 19:10:17.746781','2022-06-08 19:10:17.746781','$2b$10$/UN.xd7irf5AfOQu6kExJu35sewe9lgh.cf5sCwX1tPIZmkcxcNKy','',NULL),('df8069da-935d-48b5-aa33-b01c163ee9fb','User','test3@test.com',NULL,1,NULL,'2022-06-08 19:21:56.787680','2022-06-08 19:21:56.787680','$2b$10$VBrxb0IjSQvUoRU7LWnb5uV2uWqv2nbhLXBUSyIuzJWBazjSseztK','',NULL),('ee830e7a-f040-40e6-a911-64f47465e714','User','teasst@triger.com',NULL,1,NULL,'2022-06-11 22:37:42.425208','2022-06-11 22:37:42.425208','$2b$10$1wyvDi.Z7JSYyQq2QZ8VZOkeSLT2/m7.M8LirS3c.PtTFtFUwZ/7i','',NULL),('eec63b1d-c24b-4afc-bb62-63d601e1feb3','User','t21@gmail.com',NULL,1,NULL,'2022-07-18 06:34:24.196370','2022-07-18 06:34:24.196370','test21','',NULL),('fb6cb93b-8121-47e0-a55f-53e023ce4f6c','User','test2@test.com',NULL,1,NULL,'2022-06-08 19:20:47.550315','2022-06-08 19:20:47.550315','$2b$10$7H1dKTJMwUrXeqQPVP2EreYgpFiMyK2TWIk9jU2Xg3Q32BAWIfb.S','',NULL);
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

-- Dump completed on 2022-09-05  0:40:18
