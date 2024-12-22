CREATE DATABASE  IF NOT EXISTS `culturenoori` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `culturenoori`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: culturenoori
-- ------------------------------------------------------
-- Server version	8.4.2

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
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `views` int NOT NULL DEFAULT '0',
  `type` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `contents` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `like_count` int DEFAULT '0',
  `User_email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `img_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `report_state` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `board_id_UNIQUE` (`id`),
  KEY `fk_Board_User1_idx` (`User_email`),
  CONSTRAINT `fk_Board_User1` FOREIGN KEY (`User_email`) REFERENCES `user` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (7,'연극 워크숍 세부 안내 ','2024-10-11 10:50:55',6,'연극','안녕하세요, 회원 여러분!\r\n\r\n연극을 사랑하는 모든 분들을 위한 연극 워크숍이 11월 20일에 개최됩니다. 이번 워크숍에 대한 세부 내용을 아래에 안내드립니다.\r\n\r\n1. 워크숍 일정\r\n- 일시: 2023년 11월 20일 (월요일) 오후 2시 ~ 5시\r\n- 장소: [서울특별시 구로구 디지털로 306 (구로동, 대륭포스트타워 2차)]\r\n\r\n2. 주요 내용\r\n- 연기 기법: 기본적인 연기 기법을 배우고 실습합니다.\r\n- 대본 분석: 작품의 대본을 함께 분석하며 캐릭터의 깊이를 이해합니다.\r\n- 즉흥 연기: 즉흥 연기를 통해 표현력과 창의성을 키우는 시간을 가집니다.\r\n3. 참가 신청\r\n- 정원: 20명 (선착순)\r\n- 신청 방법: 댓글로 신청하신 후, 본인의 이메일 주소를 남겨주세요.\r\n- 신청 마감: 정원이 찰 경우 조기 마감될 수 있습니다.\r\n4. 참가비\r\n- 비용: 유료 (예: 20,000원) \r\n- 결제 방법: 계좌이체 (123-456-789012 00은행 길수홍) \r\n5. 기타 안내\r\n- 워크숍에 필요한 준비물이나 참고사항이 있다면 미리 공지할 예정입니다.\r\n- 궁금한 점이 있으시면 Q&A로 문의해 주세요!\r\n\r\n워크숍을 통해 새로운 경험을 쌓고, 동료들과의 소중한 인연을 만들어보세요. 많은 참여 부탁드립니다!\r\n\r\n감사합니다!',0,'ascent920@gmail.com','',0),(8,'새로운 연극 동아리 만들어요 !!!','2024-10-11 10:58:28',5,'연극','안녕하세요!!  연극을 사랑하는 여러분 !! 저는 연극을 함께 즐기고 활동할 동아리를 만들고 싶습니다. 동아리에서는 연극 관람, 스터디, 혹은 소규모 공연 제작 등을 계획하고 있어요. 관심 있으신 분들은 댓글로 알려주세요! 함께 좋은 시간을 보내고, 서로의 경험도 나누며 성장하는 기회를 만들고 싶습니다. 많은 참여 부탁드립니다! ',0,'rlawl5544@naver.com','',0),(9,'연극 주변 맛집 추천해주세요~~','2024-10-11 11:02:51',9,'소통','안녕하세요, 여러분! 이번에 혜화역에서 연극을 보러 가게 되었어요. 공연 전이나 후에 맛있는 식사를 하고 싶은데, 주변에 추천할 만한 맛집이 있으면 알려주시면 정말 감사하겠습니다. 특히, 저녁을 먹을 만한 장소나 간단히 디저트를 즐길 수 있는 곳이 있다면 좋겠어요. 여러분의 추천으로 좋은 경험을 더하고 싶습니다. ㅎㅎㅎㅎ',0,'wlgus123@naver.com','',0),(10,'요즘 보고 있는 연극 추천해주세요!','2024-10-11 11:15:54',2,'연극','안녕하세요, 연극을 사랑하는 여러분! 최근에 \"OOO\"라는 연극을 관람했는데 정말 감동적이었습니다. 스토리와 연기, 무대 연출 모두 훌륭했어요. 특히 [특정 장면/캐릭터]가 인상 깊었답니다. 여러분은 요즘 어떤 연극을 보고 계신가요? 추천해주실 만한 작품이 있다면 알려주세요. 함께 이야기를 나누고 싶습니다!',0,'wlgis23@naver.com','',0),(11,'\"OOO\" 연극 관람 후기','2024-10-11 11:16:36',3,'연극','안녕하세요! 저는 최근에 \"OOO\" 연극을 관람했습니다. 공연의 스토리와 연기, 무대의 모든 요소가 정말 훌륭했어요. 특히 [주요 장면]에서 [어떤 감정]이 느껴졌고, 그 부분이 가장 기억에 남습니다. 다른 분들은 이 연극을 어떻게 보셨나요? 여러분의 느낌이나 생각을 나눠주시면 좋겠습니다. 또 다른 추천 작품도 함께 이야기해봐요!',0,'dog1234@nave.com','',0),(12,'최근에 본 연극은 ?? ','2024-10-11 11:18:54',3,'소통','안녕하세요, 여러분! 최근에 관람한 연극이 있다면 감상이나 느낌을 나눠주세요~ 다음주에 가족들과 함께 보러 갈 예정이라서 여러분의 추천이 궁금해요! 좋은 연극 소개해 주시면 감사하겠습니다!',0,'rlawl5544@naver.com','',0);
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_like`
--

DROP TABLE IF EXISTS `board_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board_like` (
  `Board_id` int NOT NULL,
  `User_email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`Board_id`,`User_email`),
  KEY `fk_Board_Like_Board1_idx` (`Board_id`),
  KEY `fk_Board_Like_User1_idx` (`User_email`),
  CONSTRAINT `fk_Board_Like_Board1` FOREIGN KEY (`Board_id`) REFERENCES `board` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_Board_like_User1` FOREIGN KEY (`User_email`) REFERENCES `user` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_like`
--

LOCK TABLES `board_like` WRITE;
/*!40000 ALTER TABLE `board_like` DISABLE KEYS */;
/*!40000 ALTER TABLE `board_like` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `board_like_increase` BEFORE INSERT ON `board_like` FOR EACH ROW BEGIN
--     좋아요를 추가하기 전에 Board의 like_count를 증가시킴
    UPDATE Board
    SET like_count = like_count + 1
    WHERE id = NEW.Board_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `board_like_decrease` AFTER DELETE ON `board_like` FOR EACH ROW BEGIN
    -- 좋아요를 삭제한 후 Board의 like_count를 감소시킴
    UPDATE Board
    SET like_count = like_count - 1
    WHERE id = OLD.Board_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `parent_comment_id` int DEFAULT NULL,
  `like_count` int DEFAULT '0',
  `User_email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `report_state` int DEFAULT '0',
  `board_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `comment_id_UNIQUE` (`id`),
  KEY `fk_Comment_User1_idx` (`User_email`),
  KEY `fk_board` (`board_id`),
  KEY `fk_Comment_Parent` (`parent_comment_id`),
  CONSTRAINT `fk_board` FOREIGN KEY (`board_id`) REFERENCES `board` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_Comment_Parent_Comment` FOREIGN KEY (`parent_comment_id`) REFERENCES `comment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_Comment_User1` FOREIGN KEY (`User_email`) REFERENCES `user` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (9,'신청합니다 !!! elise1234@example.com','2024-10-11 10:55:39',NULL,0,'rlawl5544@naver.com',0,7),(10,'안녕하세요, 연기 경험이 없는 사람도 참여할 수 있나요 ?? ㅠㅠ','2024-10-11 10:59:55',NULL,1,'wlgus123@naver.com',0,8),(11,'헤화분식 추천드려요 !!!  떡볶이와 순대가 정말 맛있고 공연 전후에 간단하게 먹기 좋은 분식집이에요~~~','2024-10-11 11:07:11',NULL,1,'dog1234@nave.com',0,9),(12,'신청합니다 ! dog1234@nave.com','2024-10-11 11:08:15',NULL,0,'dog1234@nave.com',0,7),(13,'공연 후에 디저트를 즐기기 좋은 곳은 카페 드 파리 추천드립니다 !!!! ','2024-10-11 11:20:13',NULL,0,'rlawl5544@naver.com',0,9),(14,'그럼요~~~ 서로 배워가며 재미있는 경험을 쌓을 수 있을 거예요! ','2024-10-11 11:21:50',10,0,'rlawl5544@naver.com',0,8),(15,'여기 떡볶이 진짜 맛있어요 ~~~~','2024-10-11 11:23:05',11,0,'rlawl5544@naver.com',0,9);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_like`
--

DROP TABLE IF EXISTS `comment_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_like` (
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Comment_id` int NOT NULL,
  `User_email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`Comment_id`,`User_email`),
  KEY `fk_Comment_Like_Comment1_idx` (`Comment_id`),
  KEY `fk_Comment_Like_User1_idx` (`User_email`),
  CONSTRAINT `fk_Comment_Like_Comment1` FOREIGN KEY (`Comment_id`) REFERENCES `comment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_Comment_like_User1` FOREIGN KEY (`User_email`) REFERENCES `user` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_like`
--

LOCK TABLES `comment_like` WRITE;
/*!40000 ALTER TABLE `comment_like` DISABLE KEYS */;
INSERT INTO `comment_like` VALUES ('2024-10-11 11:29:44',10,'rlawl5544@naver.com'),('2024-10-11 11:20:17',11,'rlawl5544@naver.com');
/*!40000 ALTER TABLE `comment_like` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `comment_like_increase` BEFORE INSERT ON `comment_like` FOR EACH ROW BEGIN
--     좋아요를 추가하기 전에 comment의 like_count를 증가시킴
    UPDATE Comment
    SET like_count = like_count + 1
    WHERE id = NEW.Comment_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `comment_like_decrease` AFTER DELETE ON `comment_like` FOR EACH ROW BEGIN
--     좋아요를 삭제한 후에 comment의 like_count를 감소시킴
    UPDATE Comment
    SET like_count = like_count - 1
    WHERE id = OLD.Comment_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `faq`
--

DROP TABLE IF EXISTS `faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `contents` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `com_date` datetime DEFAULT NULL,
  `User_email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_FAQ_User1_idx` (`User_email`),
  CONSTRAINT `ffk_FAQ_User1` FOREIGN KEY (`User_email`) REFERENCES `user` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faq`
--

LOCK TABLES `faq` WRITE;
/*!40000 ALTER TABLE `faq` DISABLE KEYS */;
INSERT INTO `faq` VALUES (35,'워크숍 관련 질문있습니다 !!','워크숍에 필요한 준비물은 무엇인가요?? ','2024-10-11 10:54:39','특별한 준비물은 없습니다. 편안한 복장으로 참석해 주시면 되고, 개인적으로 사용하고 싶은 노트나 필기도구를 가져오시면 좋습니다! ','2024-10-11 11:26:06','rlawl5544@naver.com'),(36,'워크숍 관련 질문 ','워크숍 중 제공되는 음식이나 음료는 있나요? ','2024-10-11 11:09:57','기본적으로 음료는 제공되며, 간단한 스낵도 준비할 예정입니다. 개인의 식사 필요는 각자 준비해 오시면 됩니다. ','2024-10-11 11:27:03','dog1234@nave.com'),(37,'문의 사항 처리 기간','안녕하세요. 문의 사항에 대한 답변은 보통 얼마나 걸리나요 ??? ','2024-10-11 11:13:30',NULL,NULL,'wlgus123@naver.com'),(38,'기타 문의처','추가적인 문의가 필요할 때 어디에 연락하면 되나요 ?? ','2024-10-11 11:14:16',NULL,NULL,'wlgis23@naver.com'),(39,'워크숍 질문 ','워크숍 후 어떤 인증서나 수료증이 주어지나요 ?? ','2024-10-11 11:15:15','워크숍 종료 후 참여자에게 수료증을 발급할 예정입니다. 이를 통해 본인의 참여 기록으로 활용할 수 있습니다. ','2024-10-11 11:27:40','wlgis23@naver.com');
/*!40000 ALTER TABLE `faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login` (
  `id` int NOT NULL AUTO_INCREMENT,
  `User_email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `create_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_id_UNIQUE` (`id`),
  KEY `fk_Login_User1_idx` (`User_email`),
  CONSTRAINT `fk_Login_User1` FOREIGN KEY (`User_email`) REFERENCES `user` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `contents` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `priority` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notice_id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
INSERT INTO `notice` VALUES (1,'관람 후기 이벤트 ','공연을 관람하신 후, 후기를 남겨주신 분들 중 추첨을 통해 특별 선물을 드립니다! 참여 방법은 다음과 같습니다.\r\n\r\n1. 공연 관람 후, 본 사이트의 후기 게시판에 후기를 남겨주세요.\r\n2. 후기를 남기실 때, 본인의 이메일을 함께 기재해 주세요.\r\n(단, 이메일을 기재하지 않으실 경우, 당첨 기회는 다른 분에게 넘어가게 됩니다!!!!)\r\n\r\n추첨은 11월 5일에 진행되며, 당첨자는 개별 통지됩니다. 여러분의 소중한 의견을 기다립니다!\" \r\n','2024-10-11 10:29:47',3),(2,'(필독)게시글 작성 가이드 안내','안녕하세요, 회원 여러분!\r\n\r\n우리 커뮤니티의 원활한 소통과 건전한 환경 유지를 위해 게시글 작성 및 사용에 관한 가이드를 안내드립니다. 아래 사항을 꼭 준수해 주시기 바라며, 어길 경우 게시글은 삭제되며 활동에 제약이 있을 수 있습니다.\r\n\r\n1. 상호 존중과 배려\r\n모든 회원이 편안하게 활동할 수 있도록 서로 존중하며 배려하는 자세를 부탁드립니다. 비방이나 공격적인 언행은 금지합니다.\r\n\r\n2. 광고성 글 신고\r\n커뮤니티 내 광고성 게시글은 허용되지 않습니다. 이러한 글을 발견하시면 즉시 신고해 주시기 바랍니다.\r\n\r\n3. 게시글 중복 등록 금지\r\n동일한 내용으로 여러 개의 게시판에 등록하거나, 같은 내용을 반복해서 등록하는 행위는 금지합니다. 이러한 행위는 게시판의 혼잡을 초래하므로 자제해 주세요.\r\n\r\n4. 이메일 및 닉네임 도용\r\n만약 이메일이나 닉네임 도용으로 인해 게시글이 작성된 경우, Q&A 게시판을 통해 문의 주시면 신속하게 해결해 드리겠습니다.\r\n\r\n5. 답변 후 게시글 삭제 금지\r\n다른 회원이 정성스럽게 달아주신 답변에 대해 원하는 답변만 듣고 게시글을 삭제하는 행위는 삼가해 주시기 바랍니다. 이러한 행동은 커뮤니티의 신뢰를 저하시킬 수 있습니다.\r\n\r\n여러분의 적극적인 협조가 필요합니다. 모든 회원이 즐겁고 유익한 커뮤니티를 만들기 위해 함께 노력해 주세요. 감사합니다!','2024-10-11 10:29:01',1),(3,'연극 워크숍 개최 ','안녕하세요, 회원 여러분!! \r\n\r\n연극을 사랑하는 모든 분들을 위해 전문 강사를 초청하여 연극 관련 워크숍을 11월 20일에 개최합니다.\r\n \r\n이번 워크숍에서는 연기 기법, 대본 분석, 즉흥 연기 등 다양한 주제로 진행될 예정입니다. \r\n참가 신청은 선착순으로 진행되며, 정원에 한정이 있으니 서둘러 신청해 주세요. \r\n워크숍을 통해 새로운 경험을 쌓고, 동료들과의 소중한 인연을 만들어보세요. 자세한 내용은 커뮤니티 게시판을 통해 확인할 수 있습니다.','2024-10-11 10:40:55',2);
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perform`
--

DROP TABLE IF EXISTS `perform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perform` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `start` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `img_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `state` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `Perform_Detail_id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `perform_id_UNIQUE` (`id`),
  KEY `fk_Perform_Perform_Detail1_idx` (`Perform_Detail_id`),
  CONSTRAINT `fk_Perform_Perform_Detail1` FOREIGN KEY (`Perform_Detail_id`) REFERENCES `perform_detail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=474 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perform`
--

LOCK TABLES `perform` WRITE;
/*!40000 ALTER TABLE `perform` DISABLE KEYS */;
INSERT INTO `perform` VALUES (374,'사랑이,다 [전주]','2024-10-31 00:00:00','2024-11-03 00:00:00','PF_PF250914_241010_151344.gif','공연예정','PF250914'),(375,'뽁','2024-10-22 00:00:00','2024-10-27 00:00:00','PF_PF250911_241010_145923.jpg','공연예정','PF250911'),(376,'대구서울극장교류전, 거기, 푸른 담쟁이 동산 [대구]','2024-10-24 00:00:00','2024-11-02 00:00:00','PF_PF250910_241010_145747.jpg','공연예정','PF250910'),(377,'불멸의 여자 [대전]','2024-10-18 00:00:00','2024-10-27 00:00:00','PF_PF250906_241010_144607.gif','공연예정','PF250906'),(378,'러브레터 [서산]','2024-10-26 00:00:00','2024-10-26 00:00:00','PF_PF250893_241010_141557.gif','공연예정','PF250893'),(379,'머릿속에 천마리 벌','2024-10-30 00:00:00','2024-11-03 00:00:00','PF_PF250841_241010_105852.gif','공연예정','PF250841'),(380,'SAC ON SCREEN, 늙은 부부 이야기 [경남]','2024-11-14 00:00:00','2024-11-14 00:00:00','PF_PF250838_241010_105143.jpg','공연예정','PF250838'),(381,'혜화동1번지 동인 페스티벌: 장르 대축제, 무서운 게 딱 좋아','2024-10-25 00:00:00','2024-11-03 00:00:00','PF_PF250802_241008_140857.png','공연예정','PF250802'),(382,'어린이아트스테이지, 이야기 쏙! 이야기야!','2024-10-26 00:00:00','2024-10-26 00:00:00','PF_PF250799_241008_140408.gif','공연예정','PF250799'),(383,'애도의 방식 [대전]','2024-11-22 00:00:00','2024-11-23 00:00:00','PF_PF250794_241008_134919.jpg','공연예정','PF250794'),(384,'어쩌다보니 [거제]','2024-10-17 00:00:00','2024-10-17 00:00:00','PF_PF250787_241008_133258.jpg','공연예정','PF250787'),(385,'제2회 웬연극 페스티벌, 목마른 야채','2024-10-24 00:00:00','2024-10-26 00:00:00','PF_PF250766_241008_114226.jpg','공연예정','PF250766'),(386,'나는 XXX를 사랑한다','2024-11-20 00:00:00','2024-12-01 00:00:00','PF_PF250759_241008_112322.png','공연예정','PF250759'),(387,'꿀벌과 아스팔트','2024-10-23 00:00:00','2024-10-27 00:00:00','PF_PF250738_241008_102445.gif','공연예정','PF250738'),(388,'제21회 호러와 함께 대구국제 힐링공연예술제, 이웃집 쌀통','2024-10-22 00:00:00','2024-10-26 00:00:00','PF_PF250723_241008_095150.jpg','공연예정','PF250723'),(389,'구두는 잘 있습니까 [부천]','2024-10-18 00:00:00','2024-10-18 00:00:00','PF_PF250720_241008_093921.gif','공연예정','PF250720'),(390,'아르코 x 벽산, 하얀 밤을 보내고 있을 너에게','2024-11-01 00:00:00','2024-11-10 00:00:00','PF_PF250694_241007_165215.jpg','공연예정','PF250694'),(391,'템플 [보성]','2024-10-16 00:00:00','2024-10-17 00:00:00','PF_PF250689_241007_162952.jpg','공연예정','PF250689'),(392,'코마 [부산]','2024-10-22 00:00:00','2024-10-22 00:00:00','PF_PF250682_241007_160153.jpg','공연예정','PF250682'),(393,'제3회 연극 판 페스티벌, 세 판: 감마선에 노출되어 히어로가 된 세 명의 박사는 왜 지구를 지키려 하지 않는가','2024-11-06 00:00:00','2024-11-10 00:00:00','PF_PF250674_241007_154246.gif','공연예정','PF250674'),(394,'대한민국은 공연중, 별들의 낭독회: 게릴라 씨어터','2024-11-01 00:00:00','2024-11-03 00:00:00','PF_PF250656_241007_151511.gif','공연예정','PF250656'),(395,'마지막 포에티카','2024-10-19 00:00:00','2024-10-27 00:00:00','PF_PF250655_241007_151346.png','공연예정','PF250655'),(396,'블루하츠 [대구]','2024-10-25 00:00:00','2024-11-10 00:00:00','PF_PF250654_241008_135343.jpg','공연예정','PF250654'),(397,'청소하는 마음','2024-10-25 00:00:00','2024-11-02 00:00:00','PF_PF250647_241007_145651.gif','공연예정','PF250647'),(398,'알고리즘 [부산]','2024-10-17 00:00:00','2024-10-20 00:00:00','PF_PF250639_241007_144333.gif','공연예정','PF250639'),(399,'제7회 프로젝트10minutes, 행운','2024-10-23 00:00:00','2024-10-27 00:00:00','PF_PF250636_241007_143344.jpg','공연예정','PF250636'),(400,'기억의 숲 [대전]','2024-11-01 00:00:00','2024-12-29 00:00:00','PF_PF250634_241007_142927.jpg','공연예정','PF250634'),(401,'욕조가 무엇이든 [대학로]','2024-11-06 00:00:00','2024-11-10 00:00:00','PF_PF250626_241007_140932.gif','공연예정','PF250626'),(402,'신바람 삼대 [대전]','2024-12-05 00:00:00','2024-12-31 00:00:00','PF_PF250617_241007_134451.gif','공연예정','PF250617'),(403,'제9회 청공축제, 호세 어드벤처','2024-10-20 00:00:00','2024-10-20 00:00:00','PF_PF250610_241007_132313.jpg','공연예정','PF250610'),(404,'플랫폼 초이스, 사랑하기 때문에 [인천]','2024-10-26 00:00:00','2024-10-27 00:00:00','PF_PF250604_241007_131033.jpg','공연예정','PF250604'),(405,'제21회 호러와 함께 대구국제 힐링공연예술제 공식초청작, 빛을 따라가는 아이','2024-10-24 00:00:00','2024-10-27 00:00:00','PF_PF250599_241007_130557.gif','공연예정','PF250599'),(406,'보광동아트페스티벌, 사신수는 내 친구','2024-10-17 00:00:00','2024-10-19 00:00:00','PF_PF250587_241007_115712.jpg','공연예정','PF250587'),(407,'태양의 발견 [강릉]','2024-11-01 00:00:00','2024-11-03 00:00:00','PF_PF250585_241007_114425.gif','공연예정','PF250585'),(408,'이 아이 Cet Enfant','2024-10-29 00:00:00','2024-11-03 00:00:00','PF_PF250578_241007_112137.gif','공연예정','PF250578'),(409,'가리봉동 87번지','2024-10-16 00:00:00','2024-10-20 00:00:00','PF_PF250570_241007_110304.gif','공연예정','PF250570'),(410,'ACC 퍼니, 록산느를 위한 발라드','2024-12-05 00:00:00','2024-12-07 00:00:00','PF_PF250548_241007_101021.jpg','공연예정','PF250548'),(411,'비 오는 날의 인터뷰','2024-10-30 00:00:00','2024-11-17 00:00:00','PF_PF250428_241004_105913.gif','공연예정','PF250428'),(412,'동심놀이 반달정원 [양주]','2024-10-11 00:00:00','2024-10-12 00:00:00','PF_PF250412_241004_100825.gif','공연중','PF250412'),(413,'훈별정음 [세종]','2024-11-02 00:00:00','2024-11-02 00:00:00','PF_PF250407_241004_095044.jpg','공연예정','PF250407'),(414,'테베랜드','2024-11-20 00:00:00','2025-02-09 00:00:00','PF_PF250390_241002_181120.gif','공연예정','PF250390'),(415,'제7회 작강연극제, 돛단배 [부산]','2024-10-15 00:00:00','2024-10-15 00:00:00','PF_PF250375_241002_165730.JPG','공연예정','PF250375'),(416,'제7회 작강연극제, 닥치고 전진 [부산]','2024-10-21 00:00:00','2024-10-21 00:00:00','PF_PF250374_241002_164935.png','공연예정','PF250374'),(417,'내가 까마귀였을 때 [부산]','2024-10-30 00:00:00','2024-11-02 00:00:00','PF_PF250371_241008_154642.png','공연예정','PF250371'),(418,'깍두기 [대학로]','2024-10-21 00:00:00','2024-10-27 00:00:00','PF_PF250353_241002_152517.gif','공연예정','PF250353'),(419,'대한민국소극장열전, cycle [구미]','2024-10-16 00:00:00','2024-10-16 00:00:00','PF_PF250346_241002_145723.gif','공연예정','PF250346'),(420,'팥죽할멈과 호랑이 [천안]','2024-11-16 00:00:00','2024-11-23 00:00:00','PF_PF250343_241002_145033.jpg','공연예정','PF250343'),(421,'불편한 테레비 [하남]','2024-10-24 00:00:00','2024-10-24 00:00:00','PF_PF250339_241002_144138.gif','공연예정','PF250339'),(422,'BIRTH [부산]','2024-11-01 00:00:00','2024-11-03 00:00:00','PF_PF250287_241002_111304.jpg','공연예정','PF250287'),(423,'즐거운 우리집','2024-10-10 00:00:00','2024-10-13 00:00:00','PF_PF250282_241002_110011.png','공연중','PF250282'),(424,'대한민국소극장열전, 목발 요정','2024-10-18 00:00:00','2024-10-18 00:00:00','PF_PF250274_241002_104656.gif','공연예정','PF250274'),(425,'크리스마스 특별공연, 이프온리 [대학로]','2024-12-06 00:00:00','2024-12-29 00:00:00','PF_PF250250_241002_095829.png','공연예정','PF250250'),(426,'크리스마스 특별공연, 이프온리 [전주]','2024-12-24 00:00:00','2024-12-25 00:00:00','PF_PF250246_241002_094742.png','공연예정','PF250246'),(427,'갯골의 여자들 [경산]','2024-10-10 00:00:00','2024-10-12 00:00:00','PF_PF250244_241002_094427.png','공연중','PF250244'),(428,'제8회 대전어린이청소년연극축제, 공룡아빠','2024-10-15 00:00:00','2024-10-15 00:00:00','PF_PF250240_241002_093203.jpg','공연예정','PF250240'),(429,'제8회 대전어린이청소년연극축제, 곱단이','2024-10-16 00:00:00','2024-10-16 00:00:00','PF_PF250237_241002_092700.webp','공연예정','PF250237'),(430,'타임리스 [대학로]','2024-10-08 00:00:00','2024-10-13 00:00:00','PF_PF250233_240930_184628.gif','공연중','PF250233'),(431,'회린기 [고양]','2024-11-02 00:00:00','2024-11-03 00:00:00','PF_PF250228_240930_180916.jpg','공연예정','PF250228'),(432,'다만 나 혼자 기뻤다 [대구]','2024-10-25 00:00:00','2024-11-02 00:00:00','PF_PF250208_240930_165717.jpg','공연예정','PF250208'),(433,'카운팅','2024-10-31 00:00:00','2024-11-10 00:00:00','PF_PF250206_240930_164710.gif','공연예정','PF250206'),(434,'사람은 좋지만 인간은 싫습니다','2024-10-18 00:00:00','2024-10-27 00:00:00','PF_PF250203_240930_164046.gif','공연예정','PF250203'),(435,'낚시터 전쟁 [울산]','2024-10-15 00:00:00','2024-10-18 00:00:00','PF_PF250186_240930_155459.gif','공연예정','PF250186'),(436,'제7회 작강연극제, 월지문소나타','2024-10-19 00:00:00','2024-10-19 00:00:00','PF_PF250173_240930_152000.jpg','공연예정','PF250173'),(437,'신뺑파전 2 [춘천]','2024-10-19 00:00:00','2024-10-20 00:00:00','PF_PF250159_240930_143718.png','공연예정','PF250159'),(438,'오즈의 산타','2024-11-01 00:00:00','2024-12-31 00:00:00','PF_PF250148_240930_140733.jpeg','공연예정','PF250148'),(439,'전태일, 네 이름은 무엇이냐 [고양]','2024-11-22 00:00:00','2024-11-23 00:00:00','PF_PF250142_240930_135810.gif','공연예정','PF250142'),(440,'흑백다방 [부산]','2024-10-11 00:00:00','2024-10-13 00:00:00','PF_PF250134_240930_134219.jpg','공연중','PF250134'),(441,'최후의 분대장: 제1부 조선의용군','2024-10-26 00:00:00','2024-11-03 00:00:00','PF_PF250127_240930_133113.jpg','공연예정','PF250127'),(442,'달정이와 버들이 [대전]','2024-10-20 00:00:00','2024-10-20 00:00:00','PF_PF250113_240930_125227.gif','공연예정','PF250113'),(443,'뇌-까리다 다양성탐구','2024-10-24 00:00:00','2024-11-03 00:00:00','PF_PF250089_240930_111655.gif','공연예정','PF250089'),(444,'10월의 어느 ㅁㅊ 날에','2024-10-26 00:00:00','2024-10-26 00:00:00','PF_PF250086_240930_111012.jpg','공연예정','PF250086'),(445,'보광동아트페스티벌, 사랑의 편지','2024-10-27 00:00:00','2024-10-27 00:00:00','PF_PF250065_240930_101200.jpg','공연예정','PF250065'),(446,'제27회 광주소극장축제, 우리집 세입자','2024-10-17 00:00:00','2024-10-19 00:00:00','PF_PF250064_240930_101151.jpg','공연예정','PF250064'),(447,'광인일기 시즌2','2024-10-24 00:00:00','2024-11-03 00:00:00','PF_PF250063_240930_100551.gif','공연예정','PF250063'),(448,'상당한 가족 [삼척]','2024-10-12 00:00:00','2024-10-12 00:00:00','PF_PF250059_240930_095438.jfif','공연예정','PF250059'),(449,'큰 별 관광','2024-10-18 00:00:00','2024-10-27 00:00:00','PF_PF250051_240927_160541.gif','공연예정','PF250051'),(450,'진달래 장의사 [대학로]','2024-10-09 00:00:00','2024-10-13 00:00:00','PF_PF250047_240927_154455.gif','공연중','PF250047'),(451,'어느 물리학자의 낮잠 [대학로]','2024-10-30 00:00:00','2024-11-03 00:00:00','PF_PF250044_241007_190211.gif','공연예정','PF250044'),(452,'씨어터 페스티벌 실패주의, 엑스페리먼트: 6월 26일','2024-10-16 00:00:00','2024-10-17 00:00:00','PF_PF250026_240927_140733.gif','공연예정','PF250026'),(453,'제8회 대전어린이청소년연극축제, 탐이 나타났다 [대전]','2024-10-17 00:00:00','2024-10-17 00:00:00','PF_PF250022_240927_134702.jpg','공연예정','PF250022'),(454,'제21회 호러와 함께 대구국제 힐링공연예술제, 화몽: 삼색 제비꽃이 피는 날','2024-10-03 00:00:00','2024-10-06 00:00:00','PF_PF250006_240927_130302.jpeg','공연완료','PF250006'),(455,'파이로 [대전]','2024-10-02 00:00:00','2024-10-07 00:00:00','PF_PF250002_240927_124918.jpg','공연완료','PF250002'),(456,'달빛 연극 교류전, 원맨쇼 햄릿 [광주]','2024-10-03 00:00:00','2024-10-03 00:00:00','PF_PF249987_240927_110743.png','공연완료','PF249987'),(457,'제29회 서곶문화예술제, 검사와 여선생','2024-10-05 00:00:00','2024-10-05 00:00:00','PF_PF249965_240927_100433.jpg','공연완료','PF249965'),(458,'사랑아님','2024-10-03 00:00:00','2024-10-06 00:00:00','PF_PF249958_240927_093832.jpg','공연완료','PF249958'),(459,'제27회 광주소극장축제, 두만이 태만이','2024-10-12 00:00:00','2024-10-13 00:00:00','PF_PF249948_240927_090427.jpg','공연예정','PF249948'),(460,'제21회 호러와 함께 대구국제 힐링공연예술제 특별공연작, 스위치','2024-10-18 00:00:00','2024-10-19 00:00:00','PF_PF249939_240926_150010.jpg','공연예정','PF249939'),(461,'수상한 집주인 [세종]','2024-10-26 00:00:00','2024-10-26 00:00:00','PF_PF249937_240926_144930.gif','공연예정','PF249937'),(462,'생활의 비용','2024-10-22 00:00:00','2024-11-03 00:00:00','PF_PF249927_240926_141705.gif','공연예정','PF249927'),(463,'제21회 호러와 함께 대구국제 힐링공연예술제 공식초청작, 도둑들','2024-10-16 00:00:00','2024-10-20 00:00:00','PF_PF249906_240926_132253.png','공연예정','PF249906'),(464,'제7회 극장동국 연출가전, 홀연했던 사나이','2024-10-09 00:00:00','2024-10-20 00:00:00','PF_PF249903_240926_131316.gif','공연중','PF249903'),(465,'경숙이, 경숙아버지 [밀양]','2024-10-25 00:00:00','2024-10-26 00:00:00','PF_PF249897_240926_125737.jpg','공연예정','PF249897'),(466,'경숙이, 경숙아버지 [용인]','2024-11-13 00:00:00','2024-11-14 00:00:00','PF_PF249895_240926_125309.gif','공연예정','PF249895'),(467,'대한민국소극장열전 [구미]','2024-10-15 00:00:00','2024-10-18 00:00:00','PF_PF249885_240927_141544.png','공연예정','PF249885'),(468,'킬리 앤 두','2024-10-09 00:00:00','2024-10-13 00:00:00','PF_PF249881_240926_114259.gif','공연중','PF249881'),(469,'베일의 바다','2024-09-27 00:00:00','2024-10-18 00:00:00','PF_PF249876_240926_112820.png','공연중','PF249876'),(470,'전태일, 네 이름은 무엇이냐 [청주]','2024-11-06 00:00:00','2024-11-06 00:00:00','PF_PF249857_240926_102610.gif','공연예정','PF249857'),(471,'내 웨딩케이크는 누가 먹어버렸나 [양주]','2024-10-05 00:00:00','2024-10-05 00:00:00','PF_PF249852_241002_114208.jpg','공연완료','PF249852'),(472,'아모르파티 [제주]','2024-10-19 00:00:00','2024-10-19 00:00:00','PF_PF249836_240926_092311.gif','공연예정','PF249836'),(473,'고스트 [광주]','2024-10-24 00:00:00','2024-11-24 00:00:00','PF_PF249835_240926_092226.gif','공연예정','PF249835');
/*!40000 ALTER TABLE `perform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perform_detail`
--

DROP TABLE IF EXISTS `perform_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perform_detail` (
  `id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `average_rate` decimal(2,1) NOT NULL,
  `price` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `cast` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `Theater_id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `img_path` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `runtime` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `reservation_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `venue_name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `detail_id_UNIQUE` (`id`),
  KEY `fk_Perform_Detail_Theater1_idx` (`Theater_id`),
  CONSTRAINT `fk_Perform_Detail_Theater1` FOREIGN KEY (`Theater_id`) REFERENCES `theater` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perform_detail`
--

LOCK TABLES `perform_detail` WRITE;
/*!40000 ALTER TABLE `perform_detail` DISABLE KEYS */;
INSERT INTO `perform_detail` VALUES ('PF249835',0.0,'전석 40,000원','전시후, 전청일, 석현, 안예솔, 한서하, 정성조, 신은아 등','FC001234','PF_PF249835_240926_0922261.jpg,PF_PF249835_240926_0922260.jpg','1시간 50분','https://booking.naver.com/booking/12/bizes/1234206','기분좋은극장 [상무지구] (기분좋은극장 [상무지구])'),('PF249836',0.0,'전석 10,000원','','FC000918','PF_PF249836_240926_0923110.jpg','1시간 30분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24013803','제주특별자치도 설문대여성문화센터 (공연장)'),('PF249852',0.0,'전석 20,000원','','FC000134','PF_PF249852_240926_1012100.jpg','1시간 30분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24013765','양주문화예술회관 (소공연장)'),('PF249857',0.0,'전석 30,000원','김소연, 김태인, 남궁향, 배재우, 정민영, 박서희, 우다솔 등','FC001258','PF_PF249857_240926_1026100.jpg,PF_PF249857_240926_1026423.jpg,PF_PF249857_240926_1026422.jpg','1시간 50분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24013809','청주아트홀 (구. 청주시민회관) (청주아트홀 (구. 청주시민회관))'),('PF249876',0.0,'전석무료','정애란','FC004111','PF_PF249876_240926_1128202.png,PF_PF249876_240926_1128201.png,PF_PF249876_240926_1128200.png','50분','http://playticket.co.kr/nav/detail.html?idx=3254','얼굴박물관 [경기 광주] (얼굴박물관)'),('PF249881',0.0,'전석 20,000원','신다영, 이효민, 이주영, 이예은, 강주희, 정성원, 김진현 등','FC001631','PF_PF249881_240926_1142590.jpg','2시간','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24013651','창작플랫폼 경험과 상상 (창작플랫폼 경험과 상상)'),('PF249885',0.0,'일반 20,000원, 청소년 15,000원','김헌근, 최지은, 황지훈, 김장미, 이혜경, 김인수, 김정선 등','FC001237','PF_PF249885_240927_0216555.png,PF_PF249885_240927_0216554.png,PF_PF249885_240927_0216553.png,PF_PF249885_240927_0216552.png,PF_PF249885_240927_0216551.png','','https://booking.naver.com/booking/12/bizes/976927','소극장 공터 다 (소극장 공터 다)'),('PF249895',0.0,'전석 10,000원','서동갑, 고수희, 이승연, 이호열, 최유리, 안소영, 정해룡 등','FC002433','PF_PF249895_240926_1253090.jpg','1시간 30분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24013618','용인시평생학습관(여성회관) (큰어울마당)'),('PF249897',0.0,'전석 10,000원','안소영, 고수희, 서동갑, 이승연, 정해룡, 임모윤, 최유리 등','FC001675','PF_PF249897_240926_1257370.jpg','1시간 30분','https://mycf.lodev.kr/eventView.do?group_id=2000729','밀양아리랑아트센터 (소공연장)'),('PF249903',0.0,'전석 30,000원','노기홍, 유지선, 이주서, 이상헌, 김택수, 장준석, 김주영 등','FC001226','PF_PF249903_240927_0258572.jpg,PF_PF249903_240927_0258571.jpg','1시간 50분','http://www.maketicket.co.kr/ticket/GD26155','극장 동국 (극장 동국)'),('PF249906',0.0,'전석 30,000원','이창건, 권성윤, 채민경','FC001828','PF_PF249906_240926_0122530.jpg','1시간 20분','https://booking.naver.com/booking/12/bizes/1238215','아트벙커 (아트벙커)'),('PF249927',0.0,'전석 35,000원','김용준, 김은희, 이화정, 황철호','FC000258','PF_PF249927_240926_0217050.jpg','2시간 10분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24013637','미아리고개예술극장(구. 미아리예술극장) (미아리고개예술극장(구. 미아리예술극장))'),('PF249937',0.0,'R석 20,000원, S석 15,000원','민경, 김경환, 김은정, 석경환, 황운용, 김대운, 고문선','FC000433','PF_PF249937_240926_0249300.jpg','1시간 30분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24013801','세종문화예술회관 (대공연장)'),('PF249939',0.0,'전석 30,000원','','FC000858','PF_PF249939_240926_0300100.jpg','1시간 30분','https://booking.naver.com/booking/12/bizes/1238571','한울림소극장 (한울림소극장)'),('PF249948',0.0,'전석 30,000원','김태영, 최민결','FC001286','PF_PF249948_240927_0904272.jpg,PF_PF249948_240927_0904271.jpg,PF_PF249948_240927_0904270.jpg','1시간 30분','https://booking.naver.com/booking/12/bizes/1233821','공연일번지 (공연일번지)'),('PF249958',0.0,'전석 10,000원','김태형, 유찬희, 추지유, 이현우, 주동하, 박현정, 정해룡','FC001266','PF_PF249958_240927_0938320.jpg','1시간 30분','http://playticket.co.kr/nav/detail.html?idx=3250','소극장 공유 (소극장 공유)'),('PF249965',0.0,'전석무료','이상희, 최숙영, 함미빈, 이봉호','FC002833','PF_PF249965_240927_1004330.jpg','1시간 20분','https://www.enticket.com:469/pfm/sub01_view.html?p_idx=3577','청라복합문화센터 블루노바홀 (공연장)'),('PF249987',0.0,'전석 20,000원','이나경','FC001810','PF_PF249987_240930_1039553.png,PF_PF249987_240930_1039552.png,PF_PF249987_240930_1039551.png','1시간 10분','https://booking.naver.com/booking/12/bizes/1232812','예린소극장 (예린소극장)'),('PF250002',0.0,'전석 30,000원','전은영, 이우진, 지선경, 이은영, 김혜란, 김광원, 오은영 등','FC001255','PF_PF250002_240930_1139021.png','1시간 30분','https://booking.naver.com/booking/12/bizes/1108419','이음아트홀 [대전] (이음아트홀 [대전])'),('PF250006',0.0,'전석 30,000원','홍바다, 전소영, 박은솔','FC000858','PF_PF250006_240930_0347491.png','1시간 15분','https://booking.naver.com/booking/12/bizes/1093620','한울림소극장 (한울림소극장)'),('PF250022',0.0,'전석 20,000원','','FC001407','PF_PF250022_240930_0409063.jpg,PF_PF250022_240930_0409062.jpg,PF_PF250022_240930_0409061.jpg','1시간','https://booking.naver.com/booking/12/bizes/1232903','작은극장 다함 (작은극장 다함)'),('PF250026',0.0,'전석 20,000원','강대현, 정명훈','FC001327','PF_PF250026_240927_0207334.jpg,PF_PF250026_240927_0207333.jpg,PF_PF250026_240927_0207332.jpg,PF_PF250026_240927_0207331.jpg,PF_PF250026_240927_0207330.jpg','1시간 30분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24013715','소극장 함세상 (소극장 함세상)'),('PF250044',0.0,'전석 35,000원','류이재, 선명균, 윤현길, 이승헌, 임지형, 조성현, 최지혜','FC002588','PF_PF250044_241007_0702111.jpg','1시간 30분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24013918','씨어터 쿰 (씨어터 쿰)'),('PF250047',0.0,'VIP석 30,000원, R석 25,000원, S석 20,000원, A석 10,000원','이형빈, 문석희, 김주희, 임소영, 김련경, 이정민, 강미선 등','FC003249','PF_PF250047_240927_0344550.jpg','1시간 20분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24013817','한예극장 (한예극장)'),('PF250051',0.0,'전석 30,000원','고건영, 김병건, 박구용, 박희민, 이상숙, 이현직','FC001266','PF_PF250051_240927_0405410.jpg','1시간 30분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24013606','소극장 공유 (소극장 공유)'),('PF250059',0.0,'전석 10,000원','전무송, 전현아, 전진우, 김미림','FC000355','PF_PF250059_240930_0955160.png','1시간 10분','http://www.ticketlink.co.kr/product/52328','삼척문화예술회관 (대공연장)'),('PF250063',0.0,'전석 30,000원','기원, 권진이, 양진혁, 최지은, 차정훈, 홍민의, 하다윤','FC000774','PF_PF250063_240930_1005511.jpg,PF_PF250063_240930_1005510.jpg','1시간 30분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014039','대학로단막극장 (대학로단막극장)'),('PF250064',0.0,'전석 30,000원','박헝일, 조아라, 이석진, 김예진','FC003172','PF_PF250064_240930_1011512.jpg,PF_PF250064_240930_1011511.jpg,PF_PF250064_240930_1011510.jpg','1시간','https://booking.naver.com/booking/12/bizes/1233825','지니아트홀 (지니아트홀)'),('PF250065',0.0,'전석무료','강성욱, 조인영','FC002625','PF_PF250065_240930_1012000.jpg','1시간 20분','http://playticket.co.kr/nav/detail.html?idx=3251','보광극장 (보광극장)'),('PF250086',0.0,'전석 25,000원','김아름','FC003566','PF_PF250086_240930_1110120.png','1시간 10분','http://playticket.co.kr/nav/detail.html?idx=3260','원효로 예수성심성당 (예수성심성당)'),('PF250089',0.0,'전석 30,000원','민병욱, 이송아, 이지영, 유지수','FC000248','PF_PF250089_240930_1116551.jpg,PF_PF250089_240930_1116550.jpg','1시간 20분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014214','삼일로창고극장 (삼일로창고극장)'),('PF250113',0.0,'전석 20,000원','','FC000076','PF_PF250113_240930_1252271.jpg,PF_PF250113_240930_1252270.jpg','1시간','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24013780','대전예술의전당 (앙상블홀)'),('PF250127',0.0,'R석 40,000원, S석 30,000원','남명렬, 김세환, 김시유, 백운철, 서정식, 이갑선, 이다혜 등','FC002633','PF_PF250127_240930_0123290.jpg','3시간','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014042','대학로예술극장 (대극장)'),('PF250134',0.0,'전석 30,000원','이동희, 정충인','FC002674','PF_PF250134_240930_0142190.jpg,PF_PF250134_240930_0142443.jpg,PF_PF250134_240930_0142442.jpg','1시간 10분','https://booking.naver.com/booking/12/bizes/1240002','공간소극장 [대연역] (공간소극장 [대연역])'),('PF250142',0.0,'전석 30,000원','김소연, 김태인, 남궁향, 배재우, 정민영, 박서희, 우다솔 등','FC000819','PF_PF250142_240930_0158102.jpg,PF_PF250142_240930_0158101.jpg,PF_PF250142_240930_0158100.jpg','1시간 50분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24013611','고양어울림누리 (별모래극장)'),('PF250148',0.0,'전석 16,000원','','FC003364','PF_PF250148_240930_0207330.jpeg','40분','https://booking.naver.com/booking/12/bizes/1235604','송파어린이문화회관 (아이소리홀)'),('PF250159',0.0,'전석 30,000원','김학용, 박자희, 서정금, 이광복, 이다희, 손명호, 이재현 등','FC000680','PF_PF250159_241002_0519405.png,PF_PF250159_241002_0519404.png,PF_PF250159_241002_0519403.png,PF_PF250159_241002_0519402.png,PF_PF250159_241002_0519401.png','1시간 30분','https://booking.naver.com/booking/12/bizes/1236243','춘천인형극장 (대극장)'),('PF250173',0.0,'전석 20,000원','김주효, 박문현, 전현준','FC000257','PF_PF250173_240930_0320003.jpg,PF_PF250173_240930_0318050.jpg','1시간 25분','https://booking.naver.com/booking/12/bizes/1098603','부산예술회관 (부산예술회관)'),('PF250186',0.0,'전석 30,000원','','FC003387','PF_PF250186_240930_0354590.jpg','1시간 30분','https://booking.naver.com/booking/12/bizes/941255','아트홀 마당 (아트홀 마당)'),('PF250203',0.0,'전석 40,000원','김동규, 신정연, 안준호, 양믿음, 오승현, 이수영, 황윤지','FC002588','PF_PF250203_240930_0440460.jpg','2시간','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014002','씨어터 쿰 (씨어터 쿰)'),('PF250206',0.0,'전석 30,000원','김현중, 김서진, 김두은, 전국향, 김원진, 장용철, 임태산 등','FC000362','PF_PF250206_240930_0447102.jpg,PF_PF250206_240930_0447101.jpg,PF_PF250206_240930_0447100.jpg','1시간 40분','http://www.maketicket.co.kr/ticket/GD26195','선돌극장 (선돌극장)'),('PF250208',0.0,'전석 30,000원','이경자, 박세기, 석효진, 박나연, 홍준오, 임헌진','FC001827','PF_PF250208_240930_0457174.jpg,PF_PF250208_240930_0457173.jpg,PF_PF250208_240930_0457172.jpg,PF_PF250208_240930_0457171.jpg,PF_PF250208_240930_0457170.jpg','1시간 40분','https://tickets.interpark.com/goods/24014332','소극장 소금창고 (소극장 소금창고)'),('PF250228',0.0,'전석 30,000원','김호산, 이서현, 박주연, 견민성, 원경식, 김남표, 조한나 등','FC000127','PF_PF250228_240930_0609160.jpg','1시간 50분','http://www.artgy.or.kr/PF/PF0201V.aspx?showid=0000007642','고양아람누리 (새라새극장)'),('PF250233',0.0,'전석 30,000원','김기흥, 조정훈, 이수진, 최민기, 최치원, 김에녹','FC001085','PF_PF250233_240930_0646280.jpg','1시간 5분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24013797','소극장 혜화당(구. 까망소극장) (소극장 혜화당(구. 까망소극장))'),('PF250237',0.0,'전석 20,000원','','FC001407','PF_PF250237_241004_0125143.jpg,PF_PF250237_241004_0125142.jpg,PF_PF250237_241004_0125141.jpg','1시간','https://booking.naver.com/booking/12/bizes/1232903','작은극장 다함 (작은극장 다함)'),('PF250240',0.0,'전석 20,000원','','FC001407','PF_PF250240_241004_0134466.jpg,PF_PF250240_241002_0932031.jpg,PF_PF250240_241002_0932030.jpg','1시간','https://booking.naver.com/booking/12/bizes/1232903','작은극장 다함 (작은극장 다함)'),('PF250244',0.0,'전석무료','','FC000515','PF_PF250244_241002_0944274.png,PF_PF250244_241002_0944273.png,PF_PF250244_241002_0944272.png,PF_PF250244_241002_0944271.png,PF_PF250244_241002_0944270.png','1시간 40분','http://www.ticketlink.co.kr/product/52322','경산시민회관 (대강당)'),('PF250246',0.0,'전석 40,000원','','FC000479','PF_PF250246_241002_0947420.jpg','1시간 30분','https://booking.naver.com/booking/12/bizes/1240759','전북예술회관 (공연장)'),('PF250250',0.0,'전석 40,000원','김소정, 김해주, 조유진, 김윤식, 윤동환, 노영준, 임진유 등','FC000825','PF_PF250250_241002_0958290.jpg','1시간 30분','https://booking.naver.com/booking/12/bizes/1238760','피카소소극장 (1관)'),('PF250274',0.0,'전석 20,000원','김인수, 김정선, 김성식, 홍지인, 어우리, 전다린, 김건비','FC001237','PF_PF250274_241002_1046560.jpg','1시간 20분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24013371','소극장 공터 다 (소극장 공터 다)'),('PF250282',0.0,'전석 20,000원','유민주, 김민지, 김도광, 박지은, 심태연, 장종걸','FC001298','PF_PF250282_241002_1100113.png,PF_PF250282_241002_1100112.png,PF_PF250282_241002_1100111.png,PF_PF250282_241002_1100110.png','1시간 10분','http://playticket.co.kr/nav/detail.html?idx=3249','시온아트홀 (구. JK아트홀, 구. 샘아트홀) (시온아트홀(구. JK아트홀, 구. 샘아트홀))'),('PF250287',0.0,'전석무료','박지원, 김난현, 이아림, 최은서','FC002942','PF_PF250287_241002_1113040.jpg','1시간 15분','http://www.bscc.or.kr/01_perfor/?mcode=0401010200&mode=2&no=25162','전포와일드클럽 (전포와일드클럽)'),('PF250339',0.0,'전석 30,000원','이세령, 구다빈, 이영준, 강기헌, 윤현선, 권정은, 이동규 등','FC000095','PF_PF250339_241002_0241380.jpg','1시간 30분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014174','하남문화예술회관 (아랑홀(소극장))'),('PF250343',0.0,'전석 20,000원','','FC002054','PF_PF250343_241002_0250330.jpg','45분','https://booking.naver.com/booking/12/bizes/639926','홈플러스 [천안신방점] (홈플러스 [천안신방점])'),('PF250346',0.0,'전석 20,000원','최지은, 황지훈, 박노아, 윤상호, 이영숙, 김정국','FC001237','PF_PF250346_241002_0257230.jpg','1시간','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24013546','소극장 공터 다 (소극장 공터 다)'),('PF250353',0.0,'전석 30,000원','강해진, 김선경, 김태우, 안병찬, 이세형, 장시현, 정나진','FC000362','PF_PF250353_241002_0325170.jpg','1시간 30분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24013733','선돌극장 (선돌극장)'),('PF250371',0.0,'전석 30,000원','양성우, 이진희, 이경진, 박성호, 김시아, 이태규, 정성현','FC001376','PF_PF250371_241002_0437550.png','1시간 30분','https://booking.naver.com/booking/12/bizes/1237116','소극장 6번출구 (소극장 6번출구)'),('PF250374',0.0,'전석 20,000원','정지수, 김혜원, 김인우','FC000257','PF_PF250374_241008_0352495.png,PF_PF250374_241008_0352494.png,PF_PF250374_241008_0352493.jpg,PF_PF250374_241008_0352492.jpg,PF_PF250374_241008_0352491.png','1시간 10분','https://booking.naver.com/booking/12/bizes/1237754','부산예술회관 (부산예술회관)'),('PF250375',0.0,'전석 20,000원','김건, 엄주하, 유병영','FC000257','PF_PF250375_241002_0455410.jpg','1시간 10분','https://booking.naver.com/booking/12/bizes/1234046','부산예술회관 (부산예술회관)'),('PF250390',0.0,'R석 66,000원, S석 55,000원','이석준, 정희태, 길은성, 김남희, 이주승, 손우현, 정택운 등','FC000014','PF_PF250390_241002_0611200.jpg','2시간 45분','https://ticket.melon.com/performance/index.htm?prodId=210443','충무아트센터 (중극장 블랙)'),('PF250407',0.0,'R석 30,000원','','FC000433','PF_PF250407_241004_0950440.jpg','1시간','https://booking.naver.com/booking/12/bizes/958320','세종문화예술회관 (대공연장)'),('PF250412',0.0,'전석 20,000원','','FC000134','PF_PF250412_241004_1008250.jpg','45분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014127','양주문화예술회관 (소공연장)'),('PF250428',0.0,'전석 40,000원','강상준, 이기현, 홍미금, 이다은','FC000152','PF_PF250428_241004_1059130.jpg','1시간 20분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014293','한성아트홀(구. 인켈아트홀) (2관)'),('PF250548',0.0,'R석 30,000원, S석 20,000원','도준영, 안창현, 장석환, 최하윤','FC001270','PF_PF250548_241007_1010210.png','1시간 30분','https://www.acc.go.kr/main/performance.do?PID=0102&action=Read&bnkey=EM_0000007734','국립아시아문화전당 (극장2)'),('PF250570',0.0,'전석 30,000원','서광재, 조은영, 문경민, 김필주, 김마음, 이지혜, 최태욱 등','FC000516','PF_PF250570_241007_1103532.jpg,PF_PF250570_241007_1103531.jpg','1시간 35분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014237','열린극장 (열린극장)'),('PF250578',0.0,'전석 30,000원','김미숙, 김철영, 문재경, 주소윤, 강렬, 권혜원, 김세연 등','FC002677','PF_PF250578_241007_1121370.jpg','1시간 30분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014338','소극장 플랫폼74 (소극장 플랫폼74)'),('PF250585',0.0,'전석 10,000원','고은경, 김이환, 나규미, 민경준, 박혜림, 양현수, 이상훈 등','FC004120','PF_PF250585_241007_1144250.jpg','1시간 10분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014172','꿈꾸는사임당예술터 (1층)'),('PF250587',0.0,'전석 30,000원','김진서, 유은주, 정민복, 채윤, 최재은','FC002625','PF_PF250587_241007_1157121.jpg,PF_PF250587_241007_1157120.jpg','1시간 05분','http://playticket.co.kr/nav/detail.html?idx=3253','보광극장 (보광극장)'),('PF250599',0.0,'전석 20,000원','','FC001757','PF_PF250599_241007_0105570.png','1시간 20분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24013935','빈티지소극장 (빈티지소극장)'),('PF250604',0.0,'전석 30,000원','천수정, 한서후, 김하람, 박형준','FC001310','PF_PF250604_241007_0110330.jpg','1시간','http://playticket.co.kr/nav/detail.html?idx=3246','인천아트플랫폼 (공연장 (C동) )'),('PF250610',0.0,'전석무료','김인지, 김소연, 유봄빛, 박채원, 유풀잎','FC001682','PF_PF250610_241007_0125594.jpg,PF_PF250610_241007_0125593.jpg,PF_PF250610_241007_0125592.jpg,PF_PF250610_241007_0125591.jpg','40분','https://booking.naver.com/booking/12/bizes/1215877','민송아트홀 (구. 브로드웨이아트홀) (2관)'),('PF250617',0.0,'전석 40,000원','유일한, 강지훈, 신현용, 나승현, 강원석, 정승민, 김소민 등','FC001255','PF_PF250617_241007_0144510.jpg','1시간 30분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014333','이음아트홀 [대전] (이음아트홀 [대전])'),('PF250626',0.0,'전석 30,000원','오주영, 정은민, 변민영, 김영아','FC001414','PF_PF250626_241007_0209320.jpg','1시간','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24013982','코델아트홀 (코델아트홀)'),('PF250634',0.0,'전석 40,000원','','FC001407','PF_PF250634_241007_0229270.jpg','1시간 20분','https://booking.naver.com/booking/12/bizes/1199717','작은극장 다함 (작은극장 다함)'),('PF250636',0.0,'전석 15,000원','공정환, 김내리, 정기연, 최성우, 고성재, 김진현, 이현균 등','FC000516','PF_PF250636_241007_0233440.png','1시간 20분','http://playticket.co.kr/nav/detail.html?idx=3265','열린극장 (열린극장)'),('PF250639',0.0,'전석 30,000원','이혜민, 장재영, 양민우, 고은렬, 최은서, 박우일, 백규진 등','FC001676','PF_PF250639_241007_0243330.jpg','1시간 20분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014329','일터 소극장 (일터 소극장)'),('PF250647',0.0,'전석 20,000원','김보정, 박란주, 송희정','FC001854','PF_PF250647_241007_0256510.jpg','1시간 25분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014326','신촌문화발전소 (소극장)'),('PF250654',0.0,'전석 30,000원','이지영, 유이수, 최예나, 임도연','FC001553','PF_PF250654_241007_0308410.jpg','1시간 20분','https://booking.naver.com/booking/12/bizes/1238014','소극장 길 (소극장 길)'),('PF250655',0.0,'전석무료','김종운, 김채경, 박근영, 박혜정, 성수진, 양준혁, 윤정아 등','FC003832','PF_PF250655_241007_0313460.png','1시간 30분','http://playticket.co.kr/nav/detail.html?idx=3263','실험무대702 (실험무대702)'),('PF250656',0.0,'1층석 50,000원, 2층석 30,000원','황정민, 장영남, 이종혁, 음문석 등','FC000005','PF_PF250656_241007_0315110.jpg','1시간 30분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014343','국립극단 [명동] (명동예술극장)'),('PF250674',0.0,'전석 30,000원','신정만, 박신후, 민지혁, 류진현, 김연진, 이민아, 김준희','FC001203','PF_PF250674_241007_0342460.jpg','1시간 30분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014241','동숭무대소극장 (동숭무대소극장)'),('PF250682',0.0,'전석 10,000원','최현정, 박센, 이태경, 신새봄','FC004121','PF_PF250682_241007_0401530.jpg,PF_PF250682_241007_0402452.jpg','1시간 10분','https://booking.naver.com/booking/5/bizes/759952','스페이스 별일 (스페이스 별일)'),('PF250689',0.0,'전석 10,000원','김주연, 박희정, 박선혜, 윤성원, 이종훈, 마현진, 이승일 등','FC001398','PF_PF250689_241007_0429520.jpg','1시간 35분','http://www.ticketlink.co.kr/product/52408','보성군문화예술회관 (보성군문화예술회관)'),('PF250694',0.0,'전석 40,000원','신하진, 문현정, 신사랑, 노기용, 김현, 김슬기','FC002633','PF_PF250694_241007_0452150.jpg','1시간 30분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014313','대학로예술극장 (소극장)'),('PF250720',0.0,'전석 20,000원','남태현, 박찬호, 신덕칠, 김준, 도예영, 안수연','FC000122','PF_PF250720_241008_0939224.jpg,PF_PF250720_241008_0939213.jpg,PF_PF250720_241008_0939212.jpg,PF_PF250720_241008_0939211.jpg,PF_PF250720_241008_0939210.jpg','1시간 10분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014446','부천시민회관 (소공연장)'),('PF250723',0.0,'전석 30,000원','','FC001389','PF_PF250723_241008_0951503.jpg,PF_PF250723_241008_0951502.jpg,PF_PF250723_241008_0951501.jpg,PF_PF250723_241008_0951500.jpg','1시간 20분','https://booking.naver.com/booking/12/bizes/1240655','예술극장 온 (예술극장 온)'),('PF250738',0.0,'전석 30,000원','조은정, 황기석, 박경주, 안현정, 박진성, 장지수, 주민영','FC001216','PF_PF250738_241008_1024450.gif','1시간 20분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014312','서강대 메리홀 (소극장)'),('PF250759',0.0,'전석 40,000원, 야간공연 관람권 10,000원','조민령, 김소윤, 안효원, 진성준, 윤수현, 이희상, 김주영','FC000526','PF_PF250759_241008_1123220.png','1시간 40분','http://www.maketicket.co.kr/ticket/GD26200','연우소극장 (연우소극장)'),('PF250766',0.0,'전석 30,000원','김다예, 김현지, 서지아, 윤석배','FC001100','PF_PF250766_241008_1142260.jpg','1시간 10분','http://playticket.co.kr/nav/detail.html?idx=3229','도곡2문화센터 (오유아트홀)'),('PF250787',0.0,'전석 5,000원','김인하, 박준수, 채민수, 이은주, 장민','FC000878','PF_PF250787_241008_0132580.jpg','1시간 30분','https://ticket.geojeart.or.kr/eventView.do?group_id=2001613','거제문화예술회관 (소극장)'),('PF250794',0.0,'R석 20,000원, S석 10,000원','최태용, 김정아, 이은정, 신소영, 최호영, 김의태','FC000076','PF_PF250794_241008_0149191.jpg,PF_PF250794_241008_0149190.jpg','1시간 40분','http://ticket.yes24.com/Perf/51277','대전예술의전당 (앙상블홀)'),('PF250799',0.0,'전석 10,000원','','FC001198','PF_PF250799_241008_0204080.jpg','50분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014363','통진두레문화센터 (두레홀)'),('PF250802',0.0,'전석 30,000원','강혜련','FC001141','PF_PF250802_241008_0208570.jpeg','1시간 15분','http://playticket.co.kr/nav/detail.html?idx=3267','연극실험실 혜화동1번지 (연극실험실 혜화동1번지)'),('PF250838',0.0,'전석무료','김명곤, 차유경','FC001701','PF_PF250838_241010_1051430.jpg','1시간 40분','https://artcenter.gyeongnam.go.kr/concert/concertView.do?CONCERT_ID=CM0001260','경상남도문화예술회관 (대공연장)'),('PF250841',0.0,'전석 40,000원','윤영민, 정문선, 김정석, 최지영, 최희원, 이상탁, 공찬영','FC001529','PF_PF250841_241010_1058520.jpg','1시간 40분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014470','여행자극장 (여행자극장)'),('PF250893',0.0,'S석 20,000원, A석 10,000원','하희라, 박혁권','FC000429','PF_PF250893_241010_0215583.gif,PF_PF250893_241010_0215582.gif,PF_PF250893_241010_0215571.gif,PF_PF250893_241010_0215570.gif','1시간 40분','https://www.seosan.go.kr/culture/selectBbsNttView.do?key=818&bbsNo=36&nttNo=311641','서산시문화회관 (대공연장)'),('PF250906',0.0,'전석 30,000원','강미영, 문성필, 신선희, 민아비, 봉혜정','FC000623','PF_PF250906_241010_0246070.jpg','1시간 20분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014467','소극장 고도 (소극장 고도)'),('PF250910',0.0,'전석 30,000원','석민호, 류현주, 김정현, 유태한','FC000858','PF_PF250910_241010_0257474.jpg,PF_PF250910_241010_0257473.jpg,PF_PF250910_241010_0257472.jpg','1시간 15분','http://www.ticketlink.co.kr/product/52547','한울림소극장 (한울림소극장)'),('PF250911',0.0,'전석 35,000원','신정만, 김지훈, 김서연, 임예나, 박창희, 문대한, 김가현 등','FC001201','PF_PF250911_241010_0259234.jpg,PF_PF250911_241010_0259233.jpg,PF_PF250911_241010_0259232.jpg,PF_PF250911_241010_0259231.jpg,PF_PF250911_241010_0259230.jpg','1시간 30분','http://playticket.co.kr/nav/detail.html?idx=3266','제이원 씨어터 (구. 서완소극장, 구. 씨어터고리) (제이원 씨어터 (구. 서완소극장, 구. 씨어터고리) )'),('PF250914',0.0,'전석 30,000원','백호영, 양상아, 최욱로, 이건일, 김연재, 공선민','FC001312','PF_PF250914_241010_0313441.jpg,PF_PF250914_241010_0313440.jpg','1시간 20분','http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24014514','아하아트홀 (아하아트홀)');
/*!40000 ALTER TABLE `perform_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` enum('review','comment','board','reply') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `reported_id` int NOT NULL,
  `User_email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `report_id_UNIQUE` (`id`),
  KEY `fk_Report_User1_idx` (`User_email`),
  CONSTRAINT `fk_Report_User1` FOREIGN KEY (`User_email`) REFERENCES `user` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

LOCK TABLES `report` WRITE;
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
INSERT INTO `report` VALUES (1,'2024-10-10 12:13:22','아침이 싫어 ','board',4,'ascent920@gmail.com');
/*!40000 ALTER TABLE `report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_action`
--

DROP TABLE IF EXISTS `report_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_action` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `states` enum('pass','blind') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `reason` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `Report_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `action_id_UNIQUE` (`id`),
  KEY `fk_Report_Action_Report1_idx` (`Report_id`),
  CONSTRAINT `fk_Report_Action_Report1` FOREIGN KEY (`Report_id`) REFERENCES `report` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_action`
--

LOCK TABLES `report_action` WRITE;
/*!40000 ALTER TABLE `report_action` DISABLE KEYS */;
INSERT INTO `report_action` VALUES (1,'2024-10-10 12:15:04','blind','동의합니다 ',1);
/*!40000 ALTER TABLE `report_action` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_report_state` AFTER INSERT ON `report_action` FOR EACH ROW BEGIN
  IF NEW.states = 'blind' THEN
    IF (SELECT `type` FROM `report` WHERE `id` = NEW.`Report_id`) = 'board' THEN
      UPDATE `board`
      SET `report_state` = 1
      WHERE `id` = (SELECT `reported_id` FROM `report` WHERE `id` = NEW.`Report_id`);
    END IF;

    IF (SELECT `type` FROM `report` WHERE `id` = NEW.`Report_id`) IN ('comment', 'reply') THEN
      UPDATE `comment`
      SET `report_state` = 1
      WHERE `id` = (SELECT `reported_id` FROM `report` WHERE `id` = NEW.`Report_id`);
    END IF;

    IF (SELECT `type` FROM `report` WHERE `id` = NEW.`Report_id`) = 'review' THEN
      UPDATE `review`
      SET `report_state` = 1
      WHERE `id` = (SELECT `reported_id` FROM `report` WHERE `id` = NEW.`Report_id`);
    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `contents` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `star_number` decimal(2,1) NOT NULL,
  `User_email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `report_state` int DEFAULT '0',
  `perform_detail_id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `review_id_UNIQUE` (`id`),
  KEY `fk_Review_User1_idx` (`User_email`),
  KEY `fk_perform_detail` (`perform_detail_id`),
  CONSTRAINT `fk_perform_detail` FOREIGN KEY (`perform_detail_id`) REFERENCES `perform_detail` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_Review_User1` FOREIGN KEY (`User_email`) REFERENCES `user` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_average_rate_after_insert` AFTER INSERT ON `review` FOR EACH ROW BEGIN
    DECLARE total_stars DECIMAL(5, 1);
    DECLARE review_count INT;

    -- 총 별점과 리뷰 수 계산
    SELECT 
        SUM(star_number), COUNT(*) 
    INTO 
        total_stars, review_count
    FROM 
        review
    WHERE 
        perform_detail_id = NEW.perform_detail_id;

    -- 평균 별점 계산 및 업데이트
    IF review_count > 0 THEN
        UPDATE perform_detail
        SET average_rate = total_stars / review_count
        WHERE id = NEW.perform_detail_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_average_rate_after_update` AFTER UPDATE ON `review` FOR EACH ROW BEGIN
    DECLARE total_stars DECIMAL(5, 1);
    DECLARE review_count INT;

    -- 총 별점과 리뷰 수 계산
    SELECT 
        SUM(star_number), count(*)
        INTO total_stars, review_count
    FROM 
        review
    WHERE 
        perform_detail_id = NEW.perform_detail_id;

    -- 평균 별점 계산 및 업데이트
    IF review_count > 0 THEN
        UPDATE perform_detail
        SET average_rate = total_stars / review_count
        WHERE id = NEW.perform_detail_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_average_rate_after_delete` AFTER DELETE ON `review` FOR EACH ROW BEGIN
    DECLARE total_stars DECIMAL(5, 1);
    DECLARE review_count INT;

    -- 총 별점과 리뷰 수 계산
    SELECT 
        SUM(star_number), COUNT(*) 
        INTO total_stars, review_count
    FROM 
        review
    WHERE 
        perform_detail_id = OLD.perform_detail_id;

    -- 평균 별점 계산 및 업데이트
    IF review_count > 0 THEN
        UPDATE perform_detail
        SET average_rate = total_stars / review_count
        WHERE id = OLD.perform_detail_id;
    ELSE
        -- 리뷰가 없을 경우 average_rate를 NULL 또는 0으로 설정
        UPDATE perform_detail
        SET average_rate = 0 -- 또는 SET average_rate = 0;
        WHERE id = OLD.perform_detail_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `theater`
--

DROP TABLE IF EXISTS `theater`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `theater` (
  `id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `address` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `total_seats` int DEFAULT '0',
  `venue_name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `theater_id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `theater`
--

LOCK TABLES `theater` WRITE;
/*!40000 ALTER TABLE `theater` DISABLE KEYS */;
INSERT INTO `theater` VALUES ('FC000005','서울특별시 중구 명동길 35 (명동1가)',547,'국립극단 [명동]'),('FC000014','서울특별시 중구 퇴계로 387 (흥인동)',2045,'충무아트센터'),('FC000076','대전광역시 서구 둔산대로 135 (만년동)',3039,'대전예술의전당'),('FC000095','경기도 하남시 신평로 125 (덕풍동)',1291,'하남문화예술회관'),('FC000122','경기도 부천시 원미구 부일로 365 (중동)',1255,'부천시민회관'),('FC000127','경기도 고양시 일산동구 중앙로 1286 (마두동) 고양아람누리',4640,'고양아람누리'),('FC000134','경기도 양주시 광적면 부흥로618번길 303 양주문화예술회관',1851,'양주문화예술회관'),('FC000152','서울특별시 종로구 창경궁로 254 (명륜2가)',400,'한성아트홀(구. 인켈아트홀)'),('FC000248','서울특별시 중구 삼일대로9길 12 (저동1가)',50,'삼일로창고극장'),('FC000257','부산광역시 남구 용소로 78 (대연동)',240,'부산예술회관'),('FC000258','서울특별시 성북구 동소문로 177 (돈암동)',74,'미아리고개예술극장(구. 미아리예술극장)'),('FC000355','강원도 삼척시 엑스포로 45 (성남동)',2778,'삼척문화예술회관'),('FC000362','서울특별시 종로구 혜화로5길 5 (명륜1가)',130,'선돌극장'),('FC000429','충청남도 서산시 문화로 54 (읍내동)',709,'서산시문화회관'),('FC000433','세종특별자치시 조치원읍 문예회관길 22',842,'세종문화예술회관'),('FC000479','전라북도 전주시 완산구 팔달로 161 (경원동1가)',357,'전북예술회관'),('FC000515','경상북도 경산시 계양로 28 (계양동)',730,'경산시민회관'),('FC000516','서울특별시 종로구 창경궁로 258-12 (명륜2가)',150,'열린극장'),('FC000526','서울특별시 종로구 창경궁로35길 21 (혜화동)',100,'연우소극장'),('FC000623','대전광역시 중구 중앙로112번길 13 (대흥동)',80,'소극장 고도'),('FC000680','강원도 춘천시 영서로 3017 (사농동)',1443,'춘천인형극장'),('FC000774','서울특별시 종로구 동숭4길 16-3 (동숭동)',66,'대학로단막극장'),('FC000819','경기도 고양시 덕양구 어울림로 33 (성사동)',2156,'고양어울림누리'),('FC000825','서울특별시 종로구 대학로11길 38-11 (명륜4가)',140,'피카소소극장'),('FC000858','대구광역시 남구 계명중앙1길 35-1 (대명동)',90,'한울림소극장'),('FC000878','경상남도 거제시 장승로 145 (장승포동)',1933,'거제문화예술회관'),('FC000918','제주특별자치도 제주시 선덕로8길 12 (연동)',810,'제주특별자치도 설문대여성문화센터'),('FC001085','서울특별시 종로구 대학로12길 63 (동숭동)',115,'소극장 혜화당(구. 까망소극장)'),('FC001100','서울특별시 강남구 남부순환로378길 34-9 (도곡동)',138,'도곡2문화센터'),('FC001141','서울특별시 종로구 창경궁로35길 7 (혜화동)',70,'연극실험실 혜화동1번지'),('FC001198','경기도 김포시 통진읍 김포대로 2347-8',217,'통진두레문화센터'),('FC001201','서울특별시 종로구 창경궁로34길 18-12',98,'제이원 씨어터 (구. 서완소극장, 구. 씨어터고리)'),('FC001203','서울특별시 종로구 혜화로 35 (명륜1가)',150,'동숭무대소극장'),('FC001216','서울특별시 마포구 백범로 35 서강대학교',528,'서강대 메리홀'),('FC001226','서울특별시 종로구 창경궁로 259',82,'극장 동국'),('FC001234','광주광역시 서구 상무중앙로 90 (치평동) 우리은행상무지점',250,'기분좋은극장 [상무지구]'),('FC001237','경상북도 구미시 금오시장로 4 (원평동)',100,'소극장 공터 다'),('FC001255','대전광역시 유성구 도안대로 591 (봉명동)',180,'이음아트홀 [대전]'),('FC001258','충청북도 청주시 서원구 예체로 118-1 (사직동)',710,'청주아트홀 (구. 청주시민회관)'),('FC001266','서울특별시 종로구 창경궁로 303 (혜화동)',80,'소극장 공유'),('FC001270','광주광역시 동구 문화전당로 38 (광산동) 아시아문화전당',4274,'국립아시아문화전당'),('FC001286','광주광역시 동구 금남로 218-9 (금남로3가)',70,'공연일번지'),('FC001298','서울특별시 종로구 대학로8가길 52 (동숭동)',144,'시온아트홀 (구. JK아트홀, 구. 샘아트홀)'),('FC001310','인천광역시 중구 제물량로218번길 3 - 0 인천아트플랫폼',30,'인천아트플랫폼'),('FC001312','전라북도 전주시 완산구 전주객사4길 74-11 (고사동)',60,'아하아트홀'),('FC001327','대구광역시 남구 명덕로 98 - 2',70,'소극장 함세상'),('FC001376','부산광역시 수영구 수영로 477 (남천동)',90,'소극장 6번출구'),('FC001389','대구광역시 중구 경상감영길 294 (동인동2가)',70,'예술극장 온'),('FC001398','전라남도 보성군 보성읍 송재로 281-9',497,'보성군문화예술회관'),('FC001407','대전광역시 동구 대전로448번길 70 (가오동)',200,'작은극장 다함'),('FC001414','서울특별시 종로구 동숭길 78 (동숭동) 지하1층',120,'코델아트홀'),('FC001529','서울특별시 성북구 성북로5길 9-3 (성북동1가)',100,'여행자극장'),('FC001553','대구광역시 남구 명덕로22길 27 (대명동)',100,'소극장 길'),('FC001631','서울특별시 영등포구 선유동2로 56 (당산동5가, 유원제일2차아파트)',65,'창작플랫폼 경험과 상상'),('FC001675','경상남도 밀양시 밀양대공원로 112 (교동)',1001,'밀양아리랑아트센터'),('FC001676','부산광역시 동구 자성로141번길 13 (범일동)',100,'일터 소극장'),('FC001682','서울특별시 종로구 대학로 144 (혜화동) 중원빌딩 6층',466,'민송아트홀 (구. 브로드웨이아트홀)'),('FC001701','경상남도 진주시 강남로 215 (칠암동) 경남문화예술회관',1528,'경상남도문화예술회관'),('FC001757','대구광역시 남구 성당로60길 90 (대명동)',80,'빈티지소극장'),('FC001810','광주광역시 동구 예술길 23-1 (궁동)',36,'예린소극장'),('FC001827','대구광역시 남구 계명중앙1길 48 (대명동)',100,'소극장 소금창고'),('FC001828','대구광역시 남구 현충로 262 (대명동)',104,'아트벙커'),('FC001854','서울특별시 서대문구 연세로2나길 57 (창천동)',50,'신촌문화발전소'),('FC002054','충청남도 천안시 동남구 신촌1길 23 (신방동)',150,'홈플러스 [천안신방점]'),('FC002433','경기도 용인시 수지구 문정로7번길 15 (풍덕천동)',761,'용인시평생학습관(여성회관)'),('FC002588','서울특별시 종로구 창경궁로 253-7 (명륜2가)',111,'씨어터 쿰'),('FC002625','서울특별시 용산구 장문로19길 4 (보광동)',30,'보광극장'),('FC002633','서울특별시 종로구 대학로10길 17 (동숭동)',899,'대학로예술극장'),('FC002674','부산광역시 남구 수영로 지하 242 (대연동)',50,'공간소극장 [대연역]'),('FC002677','서울특별시 종로구 동숭길 74 (동숭동)',70,'소극장 플랫폼74'),('FC002833','인천광역시 서구 청라대로 20 (청라동)',486,'청라복합문화센터 블루노바홀'),('FC002942','부산광역시 부산진구 서전로37번길 14-1(전포동)',0,'전포와일드클럽'),('FC003172','광주광역시 동구 제봉로 116(장동)',0,'지니아트홀'),('FC003249','서울특별시 종로구 이화장길 66(동숭동)',671,'한예극장'),('FC003364','서울특별시 송파구 중대로 235(오금동)',154,'송파어린이문화회관'),('FC003387','울산광역시 중구 성안1길 101(성안동)',124,'아트홀 마당'),('FC003566','서울특별시 용산구 원효로19길 49 (원효로4가)',0,'원효로 예수성심성당'),('FC003832','서울특별시 서대문구 홍제천로 116 (연희동)',50,'실험무대702'),('FC004111','경기도 광주시 남종면 분원길 3-6',0,'얼굴박물관 [경기 광주]'),('FC004120','강원특별자치도 강릉시 죽헌길 140-12 (죽헌동)',0,'꿈꾸는사임당예술터'),('FC004121','부산광역시 부산진구 전포대로224번길 17 (전포동)',35,'스페이스 별일');
/*!40000 ALTER TABLE `theater` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `password` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `nickname` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `img_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`email`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `nickname_UNIQUE` (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('ascent920@gmail.com','12345','관리자',NULL),('dog1234@nave.com','0123','버니 ',NULL),('rlawl5544@naver.com','1234','엘리',NULL),('wlgis23@naver.com','4567','레이첼 ',NULL),('wlgus123@naver.com','1234','테리',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_user_wishlist`
--

DROP TABLE IF EXISTS `vw_user_wishlist`;
/*!50001 DROP VIEW IF EXISTS `vw_user_wishlist`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_user_wishlist` AS SELECT 
 1 AS `email`,
 1 AS `perform_detail_id`,
 1 AS `name`,
 1 AS `start`,
 1 AS `end`,
 1 AS `state`,
 1 AS `img_path`,
 1 AS `venue_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `wish`
--

DROP TABLE IF EXISTS `wish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wish` (
  `wish_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Perform_Detail_id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `User_email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  KEY `fk_Wish_Perform_Detail1_idx` (`Perform_Detail_id`),
  KEY `fk_Wish_User1_idx` (`User_email`),
  CONSTRAINT `fk_Wish_Perform_Detail1` FOREIGN KEY (`Perform_Detail_id`) REFERENCES `perform_detail` (`id`),
  CONSTRAINT `fk_wish_User1` FOREIGN KEY (`User_email`) REFERENCES `user` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wish`
--

LOCK TABLES `wish` WRITE;
/*!40000 ALTER TABLE `wish` DISABLE KEYS */;
/*!40000 ALTER TABLE `wish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'culturenoori'
--

--
-- Dumping routines for database 'culturenoori'
--

--
-- Final view structure for view `vw_user_wishlist`
--

/*!50001 DROP VIEW IF EXISTS `vw_user_wishlist`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_user_wishlist` AS select `u`.`email` AS `email`,`p`.`Perform_Detail_id` AS `perform_detail_id`,`p`.`name` AS `name`,`p`.`start` AS `start`,`p`.`end` AS `end`,`p`.`state` AS `state`,`p`.`img_path` AS `img_path`,`pd`.`venue_name` AS `venue_name` from (((`wish` `w` join `user` `u` on((`w`.`User_email` = `u`.`email`))) join `perform` `p` on((`w`.`Perform_Detail_id` = `p`.`Perform_Detail_id`))) join `perform_detail` `pd` on((`w`.`Perform_Detail_id` = `pd`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-11 12:52:58
