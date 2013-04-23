
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS eceboxigc;
GRANT ALL ON eceboxigc.* TO domouser@localhost IDENTIFIED BY 'kung-fu';
USE eceboxigc;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Structure of table `extra_tabs`
--

CREATE TABLE IF NOT EXISTS `extra_tabs` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tab_name` varchar(60) NOT NULL,
  `tab_icon` varchar(60) NOT NULL,
  `devices` varchar(1000) NOT NULL,
  `events` varchar(1000) NOT NULL,
  `heatings` varchar(1000) NOT NULL,
  `weather_temp` varchar(60) NOT NULL,
  `weather_hydro` varchar(60) NOT NULL,
  `weather_wind` varchar(60) NOT NULL,
  `weather_baro` varchar(60) NOT NULL,
  `one` varchar(20) NOT NULL,
  `two` varchar(20) NOT NULL,
  `three` varchar(20) NOT NULL,
  `four` varchar(20) NOT NULL,
  `five` varchar(20) NOT NULL,
  `graphs` varchar(1000) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Structure of table `tiles`
--

CREATE TABLE IF NOT EXISTS `tiles` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tile_name` varchar(60) NOT NULL,
  `tile_icon` varchar(60) NOT NULL,
  `device` varchar(1000) NOT NULL,
  `heating` varchar(1000) NOT NULL,
  `event` varchar(1000) NOT NULL,
  `counts` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Structure of table `locat`
--

CREATE TABLE IF NOT EXISTS `locat` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `locat_name` varchar(60) NOT NULL,
  `locat_icon` varchar(60) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
