# ************************************************************
# Sequel Pro SQL dump
# Version 3408
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.17)
# Database: roc
# Generation Time: 2012-07-24 01:02:21 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table colony
# ------------------------------------------------------------

DROP TABLE IF EXISTS `colony`;

CREATE TABLE `colony` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `title` varchar(48) NOT NULL DEFAULT '',
  `created` bigint(11) unsigned NOT NULL,
  `updated` bigint(11) unsigned NOT NULL,
  `points` int(11) unsigned NOT NULL,
  `population` int(11) unsigned NOT NULL,
  `r_wood` double unsigned NOT NULL,
  `r_food` double unsigned NOT NULL,
  `r_stone` double unsigned NOT NULL,
  `r_iron` double unsigned NOT NULL,
  `b_main` tinyint(11) unsigned NOT NULL,
  `b_barracks` tinyint(11) unsigned NOT NULL,
  `b_stable` tinyint(11) unsigned NOT NULL,
  `b_archery` tinyint(11) unsigned NOT NULL,
  `b_garage` tinyint(11) unsigned NOT NULL,
  `b_snob` tinyint(11) unsigned NOT NULL,
  `b_smith` tinyint(11) unsigned NOT NULL,
  `b_place` tinyint(11) unsigned NOT NULL,
  `b_statue` tinyint(11) unsigned NOT NULL,
  `b_market` tinyint(11) unsigned NOT NULL,
  `b_wood` tinyint(11) unsigned NOT NULL,
  `b_stone` tinyint(11) unsigned NOT NULL,
  `b_iron` tinyint(11) unsigned NOT NULL,
  `b_farm` tinyint(11) unsigned NOT NULL,
  `b_storage` tinyint(11) unsigned NOT NULL,
  `b_hide` tinyint(11) unsigned NOT NULL,
  `b_wall` tinyint(11) unsigned NOT NULL,
  `u_spear` int(11) unsigned NOT NULL,
  `u_sword` int(11) unsigned NOT NULL,
  `u_axe` int(11) unsigned NOT NULL,
  `u_spy` int(11) unsigned NOT NULL,
  `u_light` int(11) unsigned NOT NULL,
  `u_heavy` int(11) unsigned NOT NULL,
  `u_archer` int(11) unsigned NOT NULL,
  `u_marcher` int(11) unsigned NOT NULL,
  `u_ram` int(11) unsigned NOT NULL,
  `u_catapult` int(11) unsigned NOT NULL,
  `u_knight` int(11) unsigned NOT NULL,
  `u_snob` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table movement
# ------------------------------------------------------------

DROP TABLE IF EXISTS `movement`;

CREATE TABLE `movement` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `colony_id` int(11) unsigned NOT NULL,
  `type` enum('attack','assist','trade','return') NOT NULL DEFAULT 'attack',
  `colony_from` int(11) unsigned NOT NULL,
  `colony_to` int(11) unsigned NOT NULL,
  `start` bigint(20) unsigned NOT NULL,
  `end` bigint(20) unsigned NOT NULL,
  `r_wood` int(11) unsigned NOT NULL,
  `r_food` int(11) unsigned NOT NULL,
  `r_stone` int(11) unsigned NOT NULL,
  `r_iron` int(11) unsigned NOT NULL,
  `u_spear` int(11) unsigned NOT NULL,
  `u_sword` int(11) unsigned NOT NULL,
  `u_axe` int(11) unsigned NOT NULL,
  `u_spy` int(11) unsigned NOT NULL,
  `u_light` int(11) unsigned NOT NULL,
  `u_heavy` int(11) unsigned NOT NULL,
  `u_archer` int(11) unsigned NOT NULL,
  `u_marcher` int(11) unsigned NOT NULL,
  `u_ram` int(11) unsigned NOT NULL,
  `u_catapult` int(11) unsigned NOT NULL,
  `u_knight` int(11) unsigned NOT NULL,
  `u_snob` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `queue`;

CREATE TABLE `queue` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `colony_id` int(11) unsigned NOT NULL,
  `type` enum('build','barracks','stable','archery','garage','statue','snob') NOT NULL DEFAULT 'build',
  `subtype` varchar(48) NOT NULL DEFAULT '',
  `qty` int(11) unsigned NOT NULL,
  `start` bigint(11) unsigned NOT NULL,
  `end` bigint(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(48) NOT NULL DEFAULT '',
  `password` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `created` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
