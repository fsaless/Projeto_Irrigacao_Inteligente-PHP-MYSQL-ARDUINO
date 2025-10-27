-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           8.0.30 - MySQL Community Server - GPL
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para projeto_arduino
CREATE DATABASE IF NOT EXISTS `projeto_arduino` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `projeto_arduino`;

-- Copiando estrutura para tabela projeto_arduino.datasensors
CREATE TABLE IF NOT EXISTS `datasensors` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `temperatura` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `umidade_ar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `umidade_solo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `recorded_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `datasensors_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela projeto_arduino.datasensors: ~4 rows (aproximadamente)
DELETE FROM `datasensors`;
INSERT INTO `datasensors` (`id`, `user_id`, `temperatura`, `umidade_ar`, `umidade_solo`, `recorded_at`) VALUES
	(1, 1, '22.8', '55', '25', '2024-12-30 23:39:28'),
	(2, 1, '24.3', '60', '28', '2024-12-30 23:39:28'),
	(3, 1, '26.7', '65', '33', '2024-12-30 23:39:28'),
	(4, 1, '18', '36', '40', '2024-12-30 23:41:25');

-- Copiando estrutura para tabela projeto_arduino.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `email` varbinary(50) DEFAULT '',
  `password` varbinary(255) DEFAULT NULL,
  `wifiName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `wifiPassword` varbinary(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_login` datetime DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela projeto_arduino.users: ~1 rows (aproximadamente)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `name`, `email`, `password`, `wifiName`, `wifiPassword`, `created_at`, `updated_at`, `last_login`, `code`, `deleted_at`) VALUES
	(1, 'Sales', _binary 0xeb001c26eec483c777a6efa1ddfb6b551607727233337f1ebf31a136df28ddb7, _binary 0x24327924313024772f30745953662e49313758717265316b745a75384f2e46524648522f58516b4d4261637963593835466c5549566a2e52484e464f, 'NET', _binary 0x8e716f9398f5bb345735886d5315e9e4, '2024-12-30 20:29:33', '2025-01-31 09:05:37', '2025-01-31 09:05:37', '256051', NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
