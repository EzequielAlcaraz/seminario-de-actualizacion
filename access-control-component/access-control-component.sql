-- Adminer 4.8.1 MySQL 8.0.29 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP DATABASE IF EXISTS `access-control-component`;
CREATE DATABASE `access-control-component` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `access-control-component`;

DELIMITER ;;

CREATE PROCEDURE `createGroup`(IN `name` varchar(45), IN `description` varchar(200))
BEGIN
    DECLARE id_group INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
       BEGIN
           ROLLBACK;
           RESIGNAL;
       END;
    START TRANSACTION;
         INSERT INTO `group`(name, description) VALUES (name, description);

    COMMIT;
    ROLLBACK;
END;;

CREATE PROCEDURE `createUser`(IN `name` varchar(45), IN `password` varchar(45))
INSERT INTO `user`(name, password) VALUES(name, password);;

DELIMITER ;

DROP TABLE IF EXISTS `action`;
CREATE TABLE `action` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `group_accesses`;
CREATE TABLE `group_accesses` (
  `id_group` int NOT NULL,
  `id_action` int NOT NULL,
  KEY `id_group` (`id_group`),
  KEY `id_action` (`id_action`),
  CONSTRAINT `group_accesses_ibfk_1` FOREIGN KEY (`id_group`) REFERENCES `group` (`id`),
  CONSTRAINT `group_accesses_ibfk_2` FOREIGN KEY (`id_action`) REFERENCES `action` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `group_member`;
CREATE TABLE `group_member` (
  `id_user` int NOT NULL,
  `id_group` int NOT NULL,
  KEY `id_user` (`id_user`),
  KEY `id_group` (`id_group`),
  CONSTRAINT `group_member_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`),
  CONSTRAINT `group_member_ibfk_2` FOREIGN KEY (`id_group`) REFERENCES `group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `user_information`;
CREATE TABLE `user_information` (
  `id_user` int NOT NULL,
  KEY `id_user` (`id_user`),
  CONSTRAINT `user_information_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;


-- 2022-07-12 16:20:58
