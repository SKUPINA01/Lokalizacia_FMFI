-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 23, 2014 at 08:01 PM
-- Server version: 5.5.40-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `lokalizacia_fmfi`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `detaily_budovy`(IN `id_budovy` VARCHAR(80))
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Vrati `id` a `suradnice` budovy.'
select *
from budova
where id=id_budovy$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `detaily_podlazia`(IN `id_podlazia` VARCHAR(80))
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Vrati `id`, `nazov` a `suradnice` podlazia.'
select *
from podlazie
where id=id_podlazia$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `detaily_uzlu`(IN `id_uzlu` VARCHAR(80))
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Vrati `id`, `info`, `suradnice` a `typ` uzlu.'
select *
from uzol
where id = id_uzlu$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mapa_budov`()
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Vrati detaily vsetkych budov na mape.'
select *
from budova$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mapa_podlazia`(IN `id_podlazia` VARCHAR(80))
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Vrati detaily vsetkych uzlov na danom podlazi.'
select *
from uzol
where id in (
    select uzol
    from na_podlazi
    where podlazie=id_podlazia)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mapa_podlazia_uzlu`(IN `id_uzlu` VARCHAR(80))
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Vrati detaily vsetkych uzlov na podlazi s danym uzlom.'
call mapa_podlazia(id_podlazia_uzlu(id_uzlu))$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `podlazia`(IN `id_budovy` VARCHAR(80))
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Vrati detaily vsetkych podlazi danej budovy.'
select *
from podlazie
where id in (
    select podlazie
    from v_budove
    where budova=id_budovy)$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `id_podlazia_uzlu`(`id_uzlu` VARCHAR(80)) RETURNS varchar(80) CHARSET utf8 COLLATE utf8_slovak_ci
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Vrati `id` podlazia, na ktorom sa nachadza dany uzol.'
return (
    select podlazie
    from na_podlazi
    where uzol=id_uzlu)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `budova`
--

CREATE TABLE IF NOT EXISTS `budova` (
  `id` varchar(80) COLLATE utf8_slovak_ci NOT NULL COMMENT 'Sluzi aj ako nazov, napr. F1, F2, M, I, atd.',
  `suradnice` varchar(1000) COLLATE utf8_slovak_ci DEFAULT NULL COMMENT 'x1,y1,x2,y2,x3,y3,... vrcholy polygonu reprezentujuceho budovu na mape.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci COMMENT='Tabulka budov na mape';

--
-- Dumping data for table `budova`
--

INSERT INTO `budova` (`id`, `suradnice`) VALUES
('F1', 'súradnice F1'),
('F2', 'súradnice F2'),
('I', 'súradnice I'),
('M', 'súradnice M'),
('Posluchárne', 'súradnice Posluchární');

-- --------------------------------------------------------

--
-- Table structure for table `hrana`
--

CREATE TABLE IF NOT EXISTS `hrana` (
  `z_uzlu` varchar(80) COLLATE utf8_slovak_ci NOT NULL,
  `do_uzlu` varchar(80) COLLATE utf8_slovak_ci NOT NULL,
  KEY `fk_z_uzlu` (`z_uzlu`),
  KEY `fk_do_uzlu` (`do_uzlu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci COMMENT='Prechody medzi uzlami.';

--
-- Dumping data for table `hrana`
--

INSERT INTO `hrana` (`z_uzlu`, `do_uzlu`) VALUES
('M-I', 'M-I_dvere'),
('M-I_dvere', 'M-I'),
('M-II', 'M-II_dvere'),
('M-II_dvere', 'M-II'),
('M-VII', 'M-VII_dvere'),
('M-VII_dvere', 'M-VII'),
('M_P_chodba', 'M-II_dvere'),
('M_P_chodba', 'M-I_dvere'),
('M_P_chodba', 'M-VII_dvere'),
('M-VII_dvere', 'M_P_chodba'),
('M-I_dvere', 'M_P_chodba'),
('M-II_dvere', 'M_P_chodba'),
('M_P_WC-muzi', 'M_P_WC-muzi_dvere'),
('M_P_WC-muzi_dvere', 'M_P_WC-muzi'),
('M_P_chodba', 'M_P_WC-muzi_dvere'),
('M_P_WC-muzi_dvere', 'M_P_chodba');

-- --------------------------------------------------------

--
-- Table structure for table `na_podlazi`
--

CREATE TABLE IF NOT EXISTS `na_podlazi` (
  `podlazie` varchar(80) COLLATE utf8_slovak_ci NOT NULL,
  `uzol` varchar(80) COLLATE utf8_slovak_ci NOT NULL,
  KEY `fk_podlazie` (`podlazie`),
  KEY `fk_uzol` (`uzol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci COMMENT='Ktore uzly (miestnosti, chodby...) sa nachadzaju na ktorom podlazi.';

--
-- Dumping data for table `na_podlazi`
--

INSERT INTO `na_podlazi` (`podlazie`, `uzol`) VALUES
('M_P', 'M-I'),
('M_P', 'M-II'),
('M_P', 'M-II_dvere'),
('M_P', 'M-I_dvere'),
('M_P', 'M-VII'),
('M_P', 'M-VII_dvere'),
('M_P', 'M_P_chodba'),
('M_P', 'M_P_WC-muzi'),
('M_P', 'M_P_WC-muzi_dvere'),
('M_P', 'M_P_WC-zeny'),
('F1_P', 'F1');

-- --------------------------------------------------------

--
-- Table structure for table `podlazie`
--

CREATE TABLE IF NOT EXISTS `podlazie` (
  `id` varchar(80) COLLATE utf8_slovak_ci NOT NULL,
  `nazov` varchar(80) COLLATE utf8_slovak_ci NOT NULL COMMENT 'Napr. -1, P, 1, strecha, atd.',
  `suradnice` varchar(1000) COLLATE utf8_slovak_ci DEFAULT NULL COMMENT 'x1,y1,x2,y2,x3,y3,... vrcholy polygonu reprezentujuceho podlazie na mape.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci COMMENT='Jednotlive podlazia roznych budov.';

--
-- Dumping data for table `podlazie`
--

INSERT INTO `podlazie` (`id`, `nazov`, `suradnice`) VALUES
('F1_1', '1. poschodie', 'súradnice F1_1'),
('F1_P', 'prízemie', 'súradnice F1_P'),
('F2_P', 'prízemie', 'súradnice F2_P'),
('I_-1', '-1. poschodie', NULL),
('I_P', 'prízemie', 'súradnice I_P'),
('M_1', '1. poschodie', 'súradnice M_1'),
('M_2', '2. poschodie', 'súradnice M_2'),
('M_P', 'prízemie', 'súradnice M_P');

-- --------------------------------------------------------

--
-- Table structure for table `uzol`
--

CREATE TABLE IF NOT EXISTS `uzol` (
  `id` varchar(80) COLLATE utf8_slovak_ci NOT NULL COMMENT 'Sluzi zaroven ako nazov, napr. M-VII, F1-246, A, WC,...',
  `typ` varchar(80) COLLATE utf8_slovak_ci DEFAULT NULL COMMENT 'Napr. dvere, chodba, wc-muzi, poslucharen, atd.',
  `suradnice` varchar(1000) COLLATE utf8_slovak_ci DEFAULT NULL COMMENT 'x1,y1,x2,y2,x3,y3,... vrcholy polygonu reprezentujuceho miestnost, resp. suradnice dveri na mape.',
  `info` varchar(5000) COLLATE utf8_slovak_ci DEFAULT NULL COMMENT 'Informacie o miestnosti v HTLM formate.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci COMMENT='Miestnosti, chodby a dvere.';

--
-- Dumping data for table `uzol`
--

INSERT INTO `uzol` (`id`, `typ`, `suradnice`, `info`) VALUES
('A', 'poslucháreň', '0,0', '<strong>tá väčšia</strong>'),
('F1', 'poslucháreň', NULL, 'poslucháreň F1'),
('M_P_chodba', 'chodba', NULL, 'chodba v matike'),
('M_P_WC-muzi', 'WC-muži', NULL, NULL),
('M_P_WC-muzi_dvere', 'dvere', NULL, NULL),
('M_P_WC-zeny', 'WC-ženy', NULL, NULL),
('M-I', 'učebňa', NULL, '<strong>akvárko</strong>'),
('M-I_dvere', 'dvere', NULL, NULL),
('M-II', 'učebňa', NULL, '<strong>akvárko</strong>'),
('M-II_dvere', 'dvere', NULL, NULL),
('M-VII', 'miestnosť', '5,5,4,4,2,4', '<strong>akvárko</strong>'),
('M-VII_dvere', 'dvere', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `v_budove`
--

CREATE TABLE IF NOT EXISTS `v_budove` (
  `budova` varchar(80) COLLATE utf8_slovak_ci NOT NULL,
  `podlazie` varchar(80) COLLATE utf8_slovak_ci NOT NULL,
  KEY `fk_budova` (`budova`),
  KEY `fk_podlazie_v_budove` (`podlazie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci COMMENT='Ktore podlazia sa nachadzaju v ktorej budove.';

--
-- Dumping data for table `v_budove`
--

INSERT INTO `v_budove` (`budova`, `podlazie`) VALUES
('F1', 'F1_1'),
('F1', 'F1_P'),
('F2', 'F2_P'),
('I', 'I_-1'),
('I', 'I_P'),
('M', 'M_P'),
('M', 'M_1'),
('M', 'M_2');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `hrana`
--
ALTER TABLE `hrana`
  ADD CONSTRAINT `fk_do_uzlu` FOREIGN KEY (`do_uzlu`) REFERENCES `uzol` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_z_uzlu` FOREIGN KEY (`z_uzlu`) REFERENCES `uzol` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `na_podlazi`
--
ALTER TABLE `na_podlazi`
  ADD CONSTRAINT `fk_podlazie` FOREIGN KEY (`podlazie`) REFERENCES `podlazie` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_uzol` FOREIGN KEY (`uzol`) REFERENCES `uzol` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `v_budove`
--
ALTER TABLE `v_budove`
  ADD CONSTRAINT `fk_budova` FOREIGN KEY (`budova`) REFERENCES `budova` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_podlazie_v_budove` FOREIGN KEY (`podlazie`) REFERENCES `podlazie` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
