-- MySQL dump 10.13  Distrib 5.1.49, for apple-darwin10.4.0 (i386)
--
-- Host: localhost    Database: wwxx_development
-- ------------------------------------------------------
-- Server version	5.1.49

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
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_bin NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20090109150158'),('20090113134455'),('20090113134818'),('20090113164151'),('20090114123954'),('20090114132026'),('20090114152516'),('20090114162527'),('20090118112732'),('20090122210918'),('20090122231446'),('20090123105843'),('20090209115742'),('20090209131727'),('20090304194555'),('20090304201512'),('20090305125959'),('20090305170545'),('20090306141747'),('20090306171538'),('20090309120542'),('20090313203655'),('20090314122914'),('20090324093449'),('20090324105223'),('20090331100343'),('20090331154859'),('20090408093506'),('20090409092029'),('20090414100954'),('20090415150916'),('20090429090124'),('20090504090903'),('20090504132046'),('20090525085632'),('20090610101338'),('20090611080838'),('20090611094941'),('20090611103736'),('20090611105206'),('20090611111725'),('20090611131659'),('20090616110215'),('20090616130541'),('20090617095033'),('20090617215448'),('20090618074717'),('20090623132533'),('20090624090214'),('20090624092757'),('20090625092101'),('20090629110624'),('20090703144457'),('20090708090214'),('20090708113427'),('20090715140659'),('20090716110651'),('20090716135522'),('20090716165631'),('20090717105824'),('20090717141900'),('20090922095000'),('20091105135116'),('20091118072604'),('20091207122933'),('20100114113242'),('20100120121139'),('20100120135433'),('20100201103842'),('20100203145439'),('20100210084311'),('20100310114023'),('20100312103027'),('20100315100519'),('20100315130157'),('20100315135734'),('20100316102306'),('20100316120016'),('20100316134508'),('20100316145538'),('20100316164226'),('20100319223358'),('20100323145306'),('20100325145444'),('20100329075514'),('20100329110801'),('20100401112550'),('20100401124312'),('20100402123548'),('20100406140533'),('20100408141816'),('20100408195347'),('20100413083449'),('20100415131908'),('20100416124947'),('20100416131739'),('20100420210552'),('20100420221736'),('20100420225933'),('20100421110816'),('20100421122559'),('20100421135227'),('20100422084952'),('20100423125844'),('20100426123827'),('20100512084255'),('20100518124845'),('20100519123101'),('20100525125724'),('20100525152744'),('20100526141839'),('20100527135124'),('20100527135136'),('20100609111053'),('20100610100449'),('20100611134039'),('20100614122638'),('20100614133250'),('20100616085031'),('20100621084144'),('20100629075350'),('20100630094841'),('20100630180824'),('20100701125424'),('20100703155326'),('20100706092310'),('20100706152357'),('20100707142738'),('20100707142804'),('20100708122432'),('20100709081230'),('20100712134443'),('20100714132054'),('20100714144547'),('20100721100244'),('20100805101250'),('20100806091141'),('20100811094857'),('20100818144554');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-11-15 14:43:45
