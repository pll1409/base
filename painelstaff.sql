-- --------------------------------------------------------
-- Servidor:                     localhost
-- Versão do servidor:           10.4.32-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para thunder
CREATE DATABASE IF NOT EXISTS `thunder` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `thunder`;

-- Copiando estrutura para tabela thunder.ps_bans
CREATE TABLE IF NOT EXISTS `ps_bans` (
  `user_id` int(11) NOT NULL,
  `motivo` varchar(50) DEFAULT NULL,
  `banimento` int(11) DEFAULT NULL,
  `desbanimento` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `hwid` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela thunder.ps_bans: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela thunder.ps_tablet_fines
CREATE TABLE IF NOT EXISTS `ps_tablet_fines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `polices` text NOT NULL,
  `reason` text NOT NULL,
  `price` bigint(20) NOT NULL,
  `location` text NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela thunder.ps_tablet_fines: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela thunder.thunder_staff
CREATE TABLE IF NOT EXISTS `thunder_staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela thunder.thunder_staff: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela thunder.thunder_staff_warnings
CREATE TABLE IF NOT EXISTS `thunder_staff_warnings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_user_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `reason` text NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela thunder.thunder_staff_warnings: ~1 rows (aproximadamente)
INSERT INTO `thunder_staff_warnings` (`id`, `staff_user_id`, `user_id`, `reason`, `created`) VALUES
	(1, 23, 22, 'rdm teste', '2024-10-21 00:12:09');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
