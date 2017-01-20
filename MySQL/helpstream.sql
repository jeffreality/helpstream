-- phpMyAdmin SQL Dump
-- version 4.0.10.14
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Jan 14, 2017 at 12:30 AM
-- Server version: 5.6.28-76.1-log
-- PHP Version: 5.6.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `helpstream`
--

-- --------------------------------------------------------

--
-- Table structure for table `tblContacts`
--

CREATE TABLE IF NOT EXISTS `tblContacts` (
  `intContactID` int(11) NOT NULL AUTO_INCREMENT,
  `intDeviceID` int(11) NOT NULL,
  `strEmail` tinytext NOT NULL,
  `strMessage` mediumtext NOT NULL,
  `strDebug` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  PRIMARY KEY (`intContactID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tblDevices`
--

CREATE TABLE IF NOT EXISTS `tblDevices` (
  `intDeviceID` int(11) NOT NULL AUTO_INCREMENT,
  `strDeviceName` tinytext NOT NULL,
  `strDeviceModel` tinytext NOT NULL,
  `strDeviceLocalizedModel` tinytext NOT NULL,
  `strDeviceSystemName` tinytext NOT NULL,
  `strDeviceSystemVersion` tinytext NOT NULL,
  `strDeviceUniqueIdentifier` tinytext NOT NULL,
  `strDeviceLocale` tinytext NOT NULL,
  `strDeviceLanguage` tinytext NOT NULL,
  `intTotalUpdates` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `strIPCreated` tinytext NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `strIPUpdated` tinytext NOT NULL,
  PRIMARY KEY (`intDeviceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tblFAQ`
--

CREATE TABLE IF NOT EXISTS `tblFAQ` (
  `intFAQID` int(11) NOT NULL AUTO_INCREMENT,
  `strTitle` tinytext NOT NULL,
  `strAnswer` text NOT NULL,
  `intParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`intFAQID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tblStreams`
--

CREATE TABLE IF NOT EXISTS `tblStreams` (
  `intStreamID` int(11) NOT NULL AUTO_INCREMENT,
  `intUserID` int(11) NOT NULL DEFAULT '0',
  `strMessage` tinytext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `intDeviceID` int(11) NOT NULL,
  PRIMARY KEY (`intStreamID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tblUsers`
--

CREATE TABLE IF NOT EXISTS `tblUsers` (
  `intUserID` int(11) NOT NULL AUTO_INCREMENT,
  `strName` tinytext NOT NULL,
  `strAvatarURL` tinytext NOT NULL,
  `intDeviceID` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  PRIMARY KEY (`intUserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
