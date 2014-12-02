-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 02, 2014 at 02:31 PM
-- Server version: 5.5.40-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `fmfi_localization`
--

-- --------------------------------------------------------

--
-- Table structure for table `administrator`
--

CREATE TABLE IF NOT EXISTS `administrator` (
  `id` varchar(80) COLLATE utf8_slovak_ci NOT NULL COMMENT 'Administrator''s name',
  `password` varchar(80) COLLATE utf8_slovak_ci NOT NULL COMMENT 'Admin''s password',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci COMMENT='Table of administators.';

--
-- Dumping data for table `administrator`
--

INSERT INTO `administrator` (`id`, `password`) VALUES
('admin', '21232f297a57a5a743894a0e4a801fc3');

-- --------------------------------------------------------

--
-- Table structure for table `building`
--

CREATE TABLE IF NOT EXISTS `building` (
  `id` varchar(80) COLLATE utf8_slovak_ci NOT NULL COMMENT 'Unique name of building like ''F1'', ''F2'', ''P'', ''M'', ''I'', etc.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci COMMENT='Table of all buildings.';

--
-- Dumping data for table `building`
--

INSERT INTO `building` (`id`) VALUES
('F1'),
('F2'),
('I'),
('M'),
('P');

-- --------------------------------------------------------

--
-- Table structure for table `floor`
--

CREATE TABLE IF NOT EXISTS `floor` (
  `id` varchar(80) COLLATE utf8_slovak_ci NOT NULL COMMENT 'Unique name of floor among all floors of all buildings like ''F1_0'', ''F1_1'', ''F1_2'', ''I_-1'', ''I_0'', etc.',
  `level` int(11) NOT NULL COMMENT 'Vertical position of floor in building.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci COMMENT='All floors of all buildings included in map.';

--
-- Dumping data for table `floor`
--

INSERT INTO `floor` (`id`, `level`) VALUES
('F1_0', 0),
('F1_1', 1),
('F1_2', 2),
('F1_3', 3),
('I_-1', -1),
('I_0', 0),
('M_0', 0),
('M_1', 1),
('M_2', 2),
('P_0', 0);

-- --------------------------------------------------------

--
-- Table structure for table `floor_location`
--

CREATE TABLE IF NOT EXISTS `floor_location` (
  `building_id` varchar(80) COLLATE utf8_slovak_ci NOT NULL COMMENT 'ID of building, in which is located the floor.',
  `floor_id` varchar(80) COLLATE utf8_slovak_ci NOT NULL COMMENT 'ID of floor located in the building.',
  KEY `building_id` (`building_id`),
  KEY `floor_id` (`floor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci COMMENT='Which floors are located in which building.';

--
-- Dumping data for table `floor_location`
--

INSERT INTO `floor_location` (`building_id`, `floor_id`) VALUES
('F1', 'F1_0'),
('F1', 'F1_1'),
('F1', 'F1_2'),
('F1', 'F1_3'),
('I', 'I_-1'),
('I', 'I_0'),
('P', 'P_0'),
('M', 'M_0'),
('M', 'M_1'),
('M', 'M_2');

-- --------------------------------------------------------

--
-- Table structure for table `path`
--

CREATE TABLE IF NOT EXISTS `path` (
  `from_point_id` varchar(80) COLLATE utf8_slovak_ci NOT NULL COMMENT 'ID of point connected to the point with ID "to_point_id".',
  `to_point_id` varchar(80) COLLATE utf8_slovak_ci NOT NULL COMMENT 'ID of point connected from point with ID "from_point_id".',
  KEY `from_point_id` (`from_point_id`),
  KEY `to_point_id` (`to_point_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci COMMENT='Table of connection from one path point to another.';

-- --------------------------------------------------------

--
-- Table structure for table `point`
--

CREATE TABLE IF NOT EXISTS `point` (
  `id` varchar(80) COLLATE utf8_slovak_ci NOT NULL COMMENT 'Unique name of point among all points of all floors of all buildings. Must be exactly the same as room''s ID, if point represents a room.',
  `x` int(11) NOT NULL COMMENT 'X-coordinate of point at map graphics.',
  `y` int(11) NOT NULL COMMENT 'Y-coordinate of point at map graphics.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci COMMENT='These path points are used to draw path from one room to another.';

--
-- Dumping data for table `point`
--

INSERT INTO `point` (`id`, `x`, `y`) VALUES
('A', 0, 0),
('B', 0, 0),
('F1', 0, 0),
('F1-108', 0, 0),
('F2', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `point_location`
--

CREATE TABLE IF NOT EXISTS `point_location` (
  `floor_id` varchar(80) COLLATE utf8_slovak_ci NOT NULL COMMENT 'ID of floor, at which is located the point.',
  `point_id` varchar(80) COLLATE utf8_slovak_ci NOT NULL COMMENT 'ID of point located at the floor.',
  KEY `floor_id` (`floor_id`),
  KEY `point_id` (`point_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci COMMENT='Which points are located at which floors';

--
-- Dumping data for table `point_location`
--

INSERT INTO `point_location` (`floor_id`, `point_id`) VALUES
('P_0', 'A'),
('P_0', 'B'),
('F1_0', 'F1'),
('F1_0', 'F2'),
('F1_1', 'F1-108');

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE IF NOT EXISTS `room` (
  `id` varchar(80) COLLATE utf8_slovak_ci NOT NULL COMMENT 'Unique name of room matching one of points.',
  `type` varchar(80) COLLATE utf8_slovak_ci NOT NULL,
  `shape_coords` varchar(80) COLLATE utf8_slovak_ci NOT NULL COMMENT 'Coordinates needed to display room over map graphics.',
  `embedded_data` varchar(4000) COLLATE utf8_slovak_ci NOT NULL COMMENT 'Information about room in HTLM format that will be seen by users.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci COMMENT='Table of rooms that will be interactive.';

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`id`, `type`, `shape_coords`, `embedded_data`) VALUES
('A', 'poslucháreň', '0,0,0,0,0,0,0,0', '<strong>Poslucháreň A</strong>'),
('B', 'poslucháreň', '1,1,1,1,1,1,1,1,1,11,1,1', '<strong>Poslucháreň B</strong>'),
('F1', 'poslucháreň', '5,55,5,5,5,55,55,5', 'poslucháreň F1'),
('F1-108', 'učebňa', 'vera', 'Tá oná...'),
('F2', '', '0,0', 'Efdvojka');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `floor_location`
--
ALTER TABLE `floor_location`
  ADD CONSTRAINT `floor_location_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `building` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `floor_location_ibfk_2` FOREIGN KEY (`floor_id`) REFERENCES `floor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `path`
--
ALTER TABLE `path`
  ADD CONSTRAINT `path_ibfk_1` FOREIGN KEY (`from_point_id`) REFERENCES `point` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `path_ibfk_2` FOREIGN KEY (`to_point_id`) REFERENCES `point` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `point_location`
--
ALTER TABLE `point_location`
  ADD CONSTRAINT `point_location_ibfk_1` FOREIGN KEY (`floor_id`) REFERENCES `floor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `point_location_ibfk_2` FOREIGN KEY (`point_id`) REFERENCES `point` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `room_ibfk_1` FOREIGN KEY (`id`) REFERENCES `point` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
