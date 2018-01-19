SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `personal_website` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `personal_website`;

DROP TABLE IF EXISTS `card_content`;
CREATE TABLE `card_content` (
  `card_id` int(11) NOT NULL,
  `id` varchar(127) NOT NULL,
  `card_type` int(2) NOT NULL COMMENT '0: Project, 1: Work Experience',
  `title` varchar(255) NOT NULL,
  `caption` varchar(1024) NOT NULL,
  `link` varchar(255) NOT NULL,
  `router_link` varchar(127) NOT NULL,
  `image_version` varchar(15) NOT NULL,
  `theme_color` varchar(31) NOT NULL DEFAULT '#428BCA',
  `github_link` varchar(255) NOT NULL DEFAULT 'https://github.com/kellenschmidt',
  `description` varchar(8192) NOT NULL,
  `visible` int(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `chip_content`;
CREATE TABLE `chip_content` (
  `chip_id` int(11) NOT NULL,
  `id` varchar(127) NOT NULL,
  `title` varchar(31) NOT NULL,
  `category` varchar(31) NOT NULL,
  `image_version` varchar(15) NOT NULL,
  `color` varchar(15) NOT NULL DEFAULT '#EEEEEE',
  `visible` int(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `course_content`;
CREATE TABLE `course_content` (
  `course_id` int(11) NOT NULL,
  `number` varchar(9) NOT NULL,
  `name` varchar(127) NOT NULL,
  `line_breaks` int(1) NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `interactions`;
CREATE TABLE `interactions` (
  `interaction_id` int(11) NOT NULL,
  `interaction_type` int(2) NOT NULL COMMENT '1 = remove link, 2 = click link, 3 = create link',
  `code` varchar(30) NOT NULL COMMENT 'Short URL code',
  `ip_address` varchar(15) NOT NULL,
  `browser` varchar(255) NOT NULL,
  `operating_system` varchar(255) NOT NULL,
  `interaction_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `links`;
CREATE TABLE `links` (
  `code` varchar(30) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '-1',
  `long_url` varchar(512) NOT NULL,
  `date_created` datetime NOT NULL,
  `count` int(16) NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `modal_content`;
CREATE TABLE `modal_content` (
  `name` varchar(255) NOT NULL,
  `header` varchar(255) NOT NULL,
  `body` varchar(8192) NOT NULL,
  `github_link` varchar(255) NOT NULL,
  `accent_color` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `page_visits`;
CREATE TABLE `page_visits` (
  `page_visit_id` int(11) NOT NULL,
  `site` varchar(255) NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `browser` varchar(255) NOT NULL,
  `operating_system` varchar(255) NOT NULL,
  `referrer` varchar(255) NOT NULL,
  `page_visit_datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` bigint(13) NOT NULL,
  `password` varchar(255) NOT NULL,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `verified_phone` int(1) NOT NULL DEFAULT '0',
  `verified_email` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


ALTER TABLE `card_content`
  ADD PRIMARY KEY (`card_id`);

ALTER TABLE `chip_content`
  ADD PRIMARY KEY (`chip_id`);

ALTER TABLE `course_content`
  ADD PRIMARY KEY (`course_id`);

ALTER TABLE `interactions`
  ADD PRIMARY KEY (`interaction_id`);

ALTER TABLE `links`
  ADD PRIMARY KEY (`code`);

ALTER TABLE `modal_content`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `name` (`name`);

ALTER TABLE `page_visits`
  ADD PRIMARY KEY (`page_visit_id`);

ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);


ALTER TABLE `card_content`
  MODIFY `card_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
ALTER TABLE `chip_content`
  MODIFY `chip_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=306;
ALTER TABLE `interactions`
  MODIFY `interaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1154;
ALTER TABLE `page_visits`
  MODIFY `page_visit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4472;
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
