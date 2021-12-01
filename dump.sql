-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: payme
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `AccountNo` int NOT NULL,
  `Currency` varchar(4) NOT NULL,
  `balance` int NOT NULL,
  `Accountcol` varchar(45) NOT NULL,
  `ownerUsername` varchar(45) NOT NULL,
  PRIMARY KEY (`AccountNo`),
  KEY `Username_idx` (`ownerUsername`),
  CONSTRAINT `FK_ACCOUNT` FOREIGN KEY (`ownerUsername`) REFERENCES `user` (`Username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card`
--

DROP TABLE IF EXISTS `card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `card` (
  `PIN` int NOT NULL,
  `CardNo` int NOT NULL,
  `CardHolderName` varchar(45) NOT NULL,
  `ExpDate` date NOT NULL,
  `CSV` int NOT NULL,
  `Username` varchar(45) NOT NULL,
  PRIMARY KEY (`PIN`,`CardNo`),
  KEY `Username_idx` (`Username`),
  CONSTRAINT `Username` FOREIGN KEY (`Username`) REFERENCES `user` (`Username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card`
--

LOCK TABLES `card` WRITE;
/*!40000 ALTER TABLE `card` DISABLE KEYS */;
/*!40000 ALTER TABLE `card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rechargepoints`
--

DROP TABLE IF EXISTS `rechargepoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rechargepoints` (
  `PointID` int NOT NULL,
  `Address` varchar(45) NOT NULL,
  `PointName` varchar(45) NOT NULL,
  PRIMARY KEY (`PointID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rechargepoints`
--

LOCK TABLES `rechargepoints` WRITE;
/*!40000 ALTER TABLE `rechargepoints` DISABLE KEYS */;
/*!40000 ALTER TABLE `rechargepoints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `ServiceNo` int NOT NULL,
  `ServiceName` varchar(45) NOT NULL,
  `AccountNo` varchar(45) NOT NULL,
  PRIMARY KEY (`ServiceNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topup`
--

DROP TABLE IF EXISTS `topup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topup` (
  `PointID` int NOT NULL,
  `AccountNo` int NOT NULL,
  `Amount` int NOT NULL,
  PRIMARY KEY (`PointID`,`AccountNo`),
  KEY `FK_TOPUP_ACCOUNT_idx` (`AccountNo`),
  CONSTRAINT `FK_TOPUP_ACCOUNT` FOREIGN KEY (`AccountNo`) REFERENCES `account` (`AccountNo`),
  CONSTRAINT `FK_TOPUP_POINT` FOREIGN KEY (`PointID`) REFERENCES `rechargepoints` (`PointID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topup`
--

LOCK TABLES `topup` WRITE;
/*!40000 ALTER TABLE `topup` DISABLE KEYS */;
/*!40000 ALTER TABLE `topup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transfer`
--

DROP TABLE IF EXISTS `transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transfer` (
  `SenderAccountNo` int NOT NULL,
  `RecieverAccountNo` int NOT NULL,
  `Amount` int NOT NULL,
  PRIMARY KEY (`SenderAccountNo`,`RecieverAccountNo`),
  KEY `FK_TRANSFER_idx` (`RecieverAccountNo`),
  CONSTRAINT `FK_TRANSFER_REC` FOREIGN KEY (`RecieverAccountNo`) REFERENCES `account` (`AccountNo`),
  CONSTRAINT `FK_TRANSFER_SEN` FOREIGN KEY (`SenderAccountNo`) REFERENCES `account` (`AccountNo`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transfer`
--

LOCK TABLES `transfer` WRITE;
/*!40000 ALTER TABLE `transfer` DISABLE KEYS */;
/*!40000 ALTER TABLE `transfer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trustedservices`
--

DROP TABLE IF EXISTS `trustedservices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trustedservices` (
  `ServiceNo` int NOT NULL,
  `Username` varchar(45) NOT NULL,
  `Trusted` int NOT NULL,
  PRIMARY KEY (`ServiceNo`,`Username`),
  KEY `FK_TRUSTED_ACCOUNT_idx` (`Username`),
  CONSTRAINT `FK_TRUSTED_ACCOUNT` FOREIGN KEY (`Username`) REFERENCES `user` (`Username`) ON DELETE CASCADE,
  CONSTRAINT `FK_TRUSTED_SERVICE` FOREIGN KEY (`ServiceNo`) REFERENCES `service` (`ServiceNo`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trustedservices`
--

LOCK TABLES `trustedservices` WRITE;
/*!40000 ALTER TABLE `trustedservices` DISABLE KEYS */;
/*!40000 ALTER TABLE `trustedservices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `Username` varchar(45) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `userType` varchar(45) NOT NULL,
  `phone` int NOT NULL,
  `birth` date NOT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
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

-- Dump completed on 2021-11-21  1:05:37
