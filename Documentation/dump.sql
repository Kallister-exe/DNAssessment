CREATE DATABASE  IF NOT EXISTS `whois` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `whois`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: whois
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `emails`
--

DROP TABLE IF EXISTS `emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emails` (
  `Email` varchar(50) NOT NULL DEFAULT 'auto@email.com',
  PRIMARY KEY (`Email`),
  UNIQUE KEY `Email_UNIQUE` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emails`
--

LOCK TABLES `emails` WRITE;
/*!40000 ALTER TABLE `emails` DISABLE KEYS */;
INSERT INTO `emails` VALUES ('admin@hull.ac.uk'),('B.C.Tompsett@hull.ac.uk'),('dmarder0@businessinsider.com'),('e.hodkin-2021@hull.ac.uk'),('glamshead2@intel.com'),('idillway3@discuz.net'),('jbatson4@linkedin.com'),('lcranmer1@nature.com'),('mzollner6@lycos.com'),('rmcpheat5@phpbb.com');
/*!40000 ALTER TABLE `emails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `location` varchar(10) NOT NULL,
  PRIMARY KEY (`location`),
  UNIQUE KEY `location_UNIQUE` (`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES ('In FR-052'),('In My Room'),('In RB-336'),('In The Lab');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logins`
--

DROP TABLE IF EXISTS `logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logins` (
  `LoginID` varchar(10) NOT NULL DEFAULT '000000',
  PRIMARY KEY (`LoginID`),
  UNIQUE KEY `LoginID_UNIQUE` (`LoginID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logins`
--

LOCK TABLES `logins` WRITE;
/*!40000 ALTER TABLE `logins` DISABLE KEYS */;
INSERT INTO `logins` VALUES ('183394'),('294560'),('515088'),('534254'),('706631'),('807369'),('921830'),('952101'),('ADMIN'),('cssbct');
/*!40000 ALTER TABLE `logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phones`
--

DROP TABLE IF EXISTS `phones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phones` (
  `Phone` varchar(25) NOT NULL,
  PRIMARY KEY (`Phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phones`
--

LOCK TABLES `phones` WRITE;
/*!40000 ALTER TABLE `phones` DISABLE KEYS */;
INSERT INTO `phones` VALUES ('+30 7392 79 9774'),('+44 1204 26 8274'),('+44 1204 46 3777'),('+44 1482 46 2222'),('+62 4644 80 6410'),('+62 7257 61 2073'),('+84 1332 76 5932'),('+86 4834 42 4992');
/*!40000 ALTER TABLE `phones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `positions`
--

DROP TABLE IF EXISTS `positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `positions` (
  `Position` varchar(40) NOT NULL,
  PRIMARY KEY (`Position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `positions`
--

LOCK TABLES `positions` WRITE;
/*!40000 ALTER TABLE `positions` DISABLE KEYS */;
INSERT INTO `positions` VALUES ('Admin'),('Demonstartor'),('Demonstrator'),('Professor of Mega Networks'),('Student');
/*!40000 ALTER TABLE `positions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `useremails`
--

DROP TABLE IF EXISTS `useremails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `useremails` (
  `UserID` varchar(10) NOT NULL,
  `Email` varchar(50) NOT NULL,
  PRIMARY KEY (`UserID`,`Email`),
  KEY `Email_idx` (`Email`),
  CONSTRAINT `Email` FOREIGN KEY (`Email`) REFERENCES `emails` (`Email`),
  CONSTRAINT `UserID` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `useremails`
--

LOCK TABLES `useremails` WRITE;
/*!40000 ALTER TABLE `useremails` DISABLE KEYS */;
INSERT INTO `useremails` VALUES ('202012345','admin@hull.ac.uk'),('202247792','admin@hull.ac.uk'),('784671909','admin@hull.ac.uk'),('202012345','B.C.Tompsett@hull.ac.uk'),('382198603','dmarder0@businessinsider.com'),('202208793','e.hodkin-2021@hull.ac.uk'),('672942406','glamshead2@intel.com'),('250853981','idillway3@discuz.net'),('742855890','jbatson4@linkedin.com'),('784671909','lcranmer1@nature.com'),('731608534','mzollner6@lycos.com'),('685637402','rmcpheat5@phpbb.com');
/*!40000 ALTER TABLE `useremails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userlogins`
--

DROP TABLE IF EXISTS `userlogins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userlogins` (
  `UserID` varchar(10) NOT NULL,
  `LoginID` varchar(10) NOT NULL,
  PRIMARY KEY (`UserID`,`LoginID`),
  KEY `LoginID1_idx` (`LoginID`),
  CONSTRAINT `LoginID1` FOREIGN KEY (`LoginID`) REFERENCES `logins` (`LoginID`),
  CONSTRAINT `UserID2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userlogins`
--

LOCK TABLES `userlogins` WRITE;
/*!40000 ALTER TABLE `userlogins` DISABLE KEYS */;
INSERT INTO `userlogins` VALUES ('250853981','183394'),('731608534','294560'),('742855890','515088'),('784671909','534254'),('202208793','706631'),('382198603','807369'),('685637402','921830'),('672942406','952101'),('202012345','ADMIN'),('202247792','ADMIN'),('784671909','ADMIN'),('202012345','cssbct');
/*!40000 ALTER TABLE `userlogins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpositions`
--

DROP TABLE IF EXISTS `userpositions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userpositions` (
  `UserID` varchar(10) NOT NULL,
  `Position` varchar(40) NOT NULL,
  PRIMARY KEY (`UserID`,`Position`),
  KEY `Position_idx` (`Position`) /*!80000 INVISIBLE */,
  CONSTRAINT `Position1` FOREIGN KEY (`Position`) REFERENCES `positions` (`Position`),
  CONSTRAINT `UserID1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpositions`
--

LOCK TABLES `userpositions` WRITE;
/*!40000 ALTER TABLE `userpositions` DISABLE KEYS */;
INSERT INTO `userpositions` VALUES ('202012345','Admin'),('202012345','Professor of Mega Networks'),('202208793','Student'),('202247792','Admin'),('250853981','Student'),('382198603','Student'),('672942406','Student'),('685637402','Student'),('731608534','Student'),('742855890','Demonstrator'),('742855890','Student'),('784671909','Admin'),('784671909','Demonstartor');
/*!40000 ALTER TABLE `userpositions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserID` varchar(10) NOT NULL DEFAULT '0000000000',
  `LoginID` varchar(10) NOT NULL DEFAULT '000000',
  `Surname` varchar(40) DEFAULT NULL,
  `Forenames` varchar(50) NOT NULL,
  `Title` varchar(50) NOT NULL,
  `Phone` varchar(25) NOT NULL,
  `location` varchar(10) NOT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `UserID_UNIQUE` (`UserID`),
  UNIQUE KEY `LoginID_UNIQUE` (`LoginID`),
  KEY `location_idx` (`location`),
  KEY `Phone_idx` (`Phone`),
  CONSTRAINT `location` FOREIGN KEY (`location`) REFERENCES `locations` (`location`),
  CONSTRAINT `LoginID` FOREIGN KEY (`LoginID`) REFERENCES `logins` (`LoginID`),
  CONSTRAINT `Phone` FOREIGN KEY (`Phone`) REFERENCES `phones` (`Phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('202012345','cssbct','Tompsett-Ince-O\'Malley-Mac Tavish 3rd','Charles Philip Arthur George','His Royal Highness Eur Ing Professor','+44 1482 46 2222','In RB-336'),('202208793','706631','Hodkin','Emma Louise','Ms','+44 1204 26 8274','In My Room'),('202247792','ADMIN','Hawtin','George Michael','Sir','+44 1204 46 3777','In The Lab'),('250853981','183394','Eyluserses','Tabbie','Ms','+62 7257 61 2073','In My Room'),('382198603','807369','Gulberg','Georgette','Honorable','+86 4834 42 4992','In RB-336'),('672942406','952101','Harrild','Juieta','Mr','+62 7257 61 2073','In My Room'),('685637402','921830','Corey','Marjie','Mrs','+62 4644 80 6410','In RB-336'),('731608534','294560','Torr','Lorene','Rev','+84 1332 76 5932','In FR-052'),('742855890','515088','Ensley','Celia','Mr','+30 7392 79 9774','In RB-336'),('784671909','534254','','Alric','Dr','+84 1332 76 5932','In FR-052');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'whois'
--

--
-- Dumping routines for database 'whois'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-19 23:00:18
