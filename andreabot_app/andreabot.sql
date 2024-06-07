-- MariaDB dump 10.19-11.3.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: andreabot-db
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

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
-- Table structure for table `lider`
--

DROP TABLE IF EXISTS `lider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lider` (
  `idlider` varchar(45) NOT NULL,
  `telefono` varchar(14) NOT NULL,
  `origen_idorigen` varchar(45) NOT NULL,
  PRIMARY KEY (`idlider`),
  KEY `fk_lider_origen1_idx` (`origen_idorigen`),
  CONSTRAINT `fk_lider_origen1` FOREIGN KEY (`origen_idorigen`) REFERENCES `origen` (`idorigen`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lider`
--

LOCK TABLES `lider` WRITE;
/*!40000 ALTER TABLE `lider` DISABLE KEYS */;
INSERT INTO `lider` VALUES
('Arami segundoww apellido apellidom','4492225555','Fundacion Andrhani'),
('Cinthya segundoww apellido apellidom','4492225555','Fundacion Andrhani'),
('Ramon Martinez JuasJuas','4492225555','Rancho Perez'),
('Valeria Vanesa Martinez JuasJuas','4495554444','Rancho Perez');
/*!40000 ALTER TABLE `lider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `origen`
--

DROP TABLE IF EXISTS `origen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `origen` (
  `idorigen` varchar(45) NOT NULL,
  PRIMARY KEY (`idorigen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `origen`
--

LOCK TABLES `origen` WRITE;
/*!40000 ALTER TABLE `origen` DISABLE KEYS */;
INSERT INTO `origen` VALUES
('Fundacion Andrhani '),
('Rancho Perez');
/*!40000 ALTER TABLE `origen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `red`
--

DROP TABLE IF EXISTS `red`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `red` (
  `idred` varchar(37) NOT NULL,
  `fecha_captura` datetime NOT NULL,
  `apellido_paterno` varchar(15) NOT NULL,
  `apellido_materno` varchar(15) NOT NULL,
  `nombre` varchar(25) NOT NULL,
  `domicilio` varchar(45) NOT NULL,
  `no_ext` varchar(6) NOT NULL,
  `no_int` varchar(6) DEFAULT NULL,
  `fraccionamiento` varchar(30) NOT NULL,
  `distrito` varchar(45) NOT NULL,
  `seccion` varchar(45) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `telefono` varchar(14) NOT NULL,
  `celular` varchar(14) DEFAULT NULL,
  `perfil_facebook` varchar(25) DEFAULT NULL,
  `clave_elector` varchar(19) NOT NULL,
  `responsable_red_usuario_idusuario` varchar(45) NOT NULL,
  PRIMARY KEY (`idred`),
  UNIQUE KEY `clave_elector_UNIQUE` (`clave_elector`),
  KEY `fk_red_responsable_red1_idx` (`responsable_red_usuario_idusuario`),
  CONSTRAINT `fk_red_responsable_red1` FOREIGN KEY (`responsable_red_usuario_idusuario`) REFERENCES `responsable_red` (`usuario_idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `red`
--

LOCK TABLES `red` WRITE;
/*!40000 ALTER TABLE `red` DISABLE KEYS */;
INSERT INTO `red` VALUES
('144e1ce5-b327-4490-aa77-0f10cc57bbf5','2024-05-08 20:43:16','donato','gonzález','luis','martiano olivero','100','0','las casuelas bonitas','5','3','1985-01-30','4495554444','','','clave03','cris_red'),
('1df1798d-c3eb-454c-979a-4b9583b48dfd','2024-05-08 20:44:42','donato','gonzález','luis','martiano olivero','100','0','las casuelas bonitas','4','2','1985-01-30','4495554444','','','clave01','karen_red'),
('4ac4a0aa-1c5b-473e-9beb-bd13d5076258','2024-05-10 11:44:54','donato','[e[o]]','luis','martiano olivero','100','','las casuelas bonitas','04','07','1985-01-30','4495554444','','','clave06','cris_red'),
('746386ad-a3a7-4bbc-8ce1-3d1e9435fe0a','2024-05-08 21:43:00','donato','gonzález','luis','martiano olivero','100','0','las casuelas bonitas','4','2','1985-01-30','4495554444','','','clave02','cris_red'),
('a3a329de-fa6e-4e40-9816-929f119d13e2','2024-05-08 21:00:05','donato','gonzález','luis','martiano olivero','100','0','las casuelas bonitas','4','2','1985-01-30','4495554444','','','clave05','cris_red'),
('e86d5ee4-d071-4be1-bd81-d6ecdf6b779d','2024-05-08 20:40:45','donato','gonzález','luis','martiano olivero','100','0','las casuelas bonitas','11','73','1985-01-30','4495554444','','','clave04','karen_red');
/*!40000 ALTER TABLE `red` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `responsable_red`
--

DROP TABLE IF EXISTS `responsable_red`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `responsable_red` (
  `usuario_idusuario` varchar(45) NOT NULL,
  `apellido_paterno` varchar(15) NOT NULL,
  `apellido_materno` varchar(15) NOT NULL,
  `nombre` varchar(25) NOT NULL,
  `domicilio` varchar(45) NOT NULL,
  `no_ext` varchar(6) NOT NULL,
  `no_int` varchar(6) DEFAULT NULL,
  `fraccionamiento` varchar(30) NOT NULL,
  `distrito` varchar(3) NOT NULL,
  `seccion` varchar(4) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `telefono` varchar(14) NOT NULL,
  `celular` varchar(14) DEFAULT NULL,
  `perfil_facebook` varchar(25) DEFAULT NULL,
  `clave_elector` varchar(19) NOT NULL,
  `lider_idlider` varchar(45) NOT NULL,
  PRIMARY KEY (`usuario_idusuario`),
  UNIQUE KEY `clave_elector_UNIQUE` (`clave_elector`),
  KEY `fk_responsable_red_lider1_idx` (`lider_idlider`),
  KEY `fk_responsable_red_usuario1_idx` (`usuario_idusuario`),
  CONSTRAINT `fk_responsable_red_lider1` FOREIGN KEY (`lider_idlider`) REFERENCES `lider` (`idlider`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_responsable_red_usuario1` FOREIGN KEY (`usuario_idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `responsable_red`
--

LOCK TABLES `responsable_red` WRITE;
/*!40000 ALTER TABLE `responsable_red` DISABLE KEYS */;
INSERT INTO `responsable_red` VALUES
('cris_red','donato','meza','crs','valor_domicilio','ext','int','fraccionamiento','11','73','1990-01-01','telefono','celular','perfil_facebook','valor_clave','Arami segundoww apellido apellidom'),
('jenny_red','paterno','materno','valor_nombre','valor_domicilio','ext','int','fraccionamiento','11','73','1990-01-01','telefono','celular','perfil_facebook','clave03','Arami segundoww apellido apellidom'),
('karen_red','paterno','materno','valor_nombre','valor_domicilio','ext','int','fraccionamiento','11','73','1990-01-01','telefono','celular','perfil_facebook','clave01','Arami segundoww apellido apellidom');
/*!40000 ALTER TABLE `responsable_red` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rol` (
  `idrol` varchar(20) NOT NULL,
  PRIMARY KEY (`idrol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES
('admin'),
('encuestador'),
('supervisor');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `idusuario` varchar(45) NOT NULL,
  `pass` varchar(61) NOT NULL,
  `activo` tinyint(4) NOT NULL,
  `rol_idrol` varchar(20) NOT NULL,
  PRIMARY KEY (`idusuario`),
  KEY `fk_usuario_rol1_idx` (`rol_idrol`),
  CONSTRAINT `fk_usuario_rol1` FOREIGN KEY (`rol_idrol`) REFERENCES `rol` (`idrol`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES
('cris_admin','$2b$10$PVEDsPqkbcKI4oTegtEFKOpiE2JxhPX8o7Gn0FXRCuqO6EZa5WVga',1,'admin'),
('cris_red','$2b$10$VEecMOEiITi8skqotttFvOmqHCCM/QW0Y4EhQRBNC5YM90T2fauv.',1,'encuestador'),
('cris_supervisor','$2b$10$IlH4Gfr5wiCXNzuS0yxyYe6F7RROeCZz5KLp2O3Z7K5U7v5Vvmcre',1,'supervisor'),
('jenny_red','$2b$10$3i5PqBDJxFtwH7hrkOu99.m9iacm0dcx0VTyc0ax6xrDPqRYn4OnW',0,'encuestador'),
('jenny_red2','$2b$10$magwkOJJLP5WkfV8hRtnRufJdjwHk78na2ZOMknXti.FpnSOzkOH6',0,'encuestador'),
('karen_red','$2b$10$DpGZxhQ7xybO9xWOC4uhxepYOB.HtGpaIaPmFiEOZy0NnaqvEkNWS',1,'encuestador');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'andreabot-db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-10 12:24:35
