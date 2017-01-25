-- phpMyAdmin SQL Dump
-- version 4.0.10.14
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Jan 24, 2017 at 06:06 PM
-- Server version: 5.6.28-76.1-log
-- PHP Version: 5.6.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=5 ;


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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=2 ;


--
-- Table structure for table `tblFAQ`
--

CREATE TABLE IF NOT EXISTS `tblFAQ` (
  `intFAQID` int(11) NOT NULL AUTO_INCREMENT,
  `strTitle` tinytext NOT NULL,
  `strAnswer` text NOT NULL,
  `intParentID` int(11) NOT NULL DEFAULT '0',
  `intOrder` int(11) NOT NULL,
  `strLocale` tinytext NOT NULL,
  `strLanguage` tinytext NOT NULL,
  PRIMARY KEY (`intFAQID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=22 ;

--
-- Dumping data for table `tblFAQ`
--

INSERT INTO `tblFAQ` (`intFAQID`, `strTitle`, `strAnswer`, `intParentID`, `intOrder`, `strLocale`, `strLanguage`) VALUES
(1, 'What is HelpStream?', '', 0, 1, 'en_US', 'en'),
(2, 'HelpStream Overview', '<p>HelpStream is a framework that can be dropped into any iOS application, in order to add the following features:</p>\r\n\r\n<ul>\r\n<li>Contact form\r\n\r\n<ul>\r\n<li>Requires email address</li>\r\n<li>Requires a message</li>\r\n<li>Optional, supports sending debug information from the parent app</li>\r\n</ul></li>\r\n<li>FAQ list\r\n\r\n<ul>\r\n<li>List of Categories or Questions</li>\r\n<li>Tapping each will display a WebView of html content (image links can be hosted on your own server and referenced within the text)</li>\r\n</ul></li>\r\n<li>Chat Stream\r\n\r\n<ul>\r\n<li>Like HipChat or Slack, users can view the public chatting about your app</li>\r\n<li>Anonymous users can join the conversation (or add an avatar and name to deanonymize themselves)</li>\r\n<li>Messages can be personally muted (which will also flag themselves on the server)</li>\r\n</ul></li>\r\n</ul>', 1, 1, 'en_US', 'en'),
(3, 'How do I set it up?', '<p>The current implementation supports a PHP/MySQL back-end. The MySQL tables can be imported from the /MySQL folder. The PHP files (located in /PHP) can be used to make a simple REST API endpoint which will then be used by the iOS framework.</p>\r\n\r\n<p>The sample app in iOS/"Example Project" will show you a simple (one screen) application that has implemented and configured the app''s connection to a sample REST API.</p>', 1, 2, 'en_US', 'en'),
(4, 'Quick Installation Guide', '<ol>\r\n<li>Create a MySQL database, and add a database user to it with SELECT, INSERT, and UPDATE permissions</li>\r\n<li>Import the SQL from the /MySQL/helpstream.sql file (I used PHPMyAdmin and pasted the text into the SQL tab)</li>\r\n<li>Modify the /PHP/api/db_config.php to have the database name, database username, and database password for your database (created in step 1).</li>\r\n<li>Upload the PHP scripts in /PHP/api to a folder on your webserver</li>\r\n<li>In Xcode, load the iOS/Example Project/helpstream_demo.xcodeproj file</li>\r\n<li>Modify the helpstream_demo/ViewController.swift file to have the url path to your php scripts.</li>\r\n<li>Run it and try it out!</li>\r\n</ol>', 1, 3, 'en_US', 'en'),
(5, 'What is the Chat stream?', '<ul>\r\n<li>Like HipChat or Slack, users can view the public chatting about your app</li>\r\n<li>Anonymous users can join the conversation (or add an avatar and name to deanonymize themselves)</li>\r\n<li>Messages can be personally muted (which will also flag themselves on the server)</li>\r\n</ul>', 0, 2, 'en_US', 'en'),
(6, 'What is the FAQ/Help list?', '<ul>\r\n<li>List of Categories or Questions</li>\r\n<li>Tapping each will display a WebView of html content (image links can be hosted on your own server and referenced within the text)</li>\r\n</ul>', 0, 3, 'en_US', 'en'),
(7, 'What is the Contact form?', '<ul>\r\n<li>Requires email address</li>\r\n<li>Requires a message</li>\r\n<li>Optional, supports sending debug information from the parent app</li>\r\n</ul>', 0, 4, 'en_US', 'en'),
(8, 'Qu''est-ce que HelpStream?', '', 0, 1, 'fr_FR', 'fr'),
(9, 'HelpStream Vue d''ensemble', '<p>HelpStream est un framework qui peut être déposé dans n''importe quelle application iOS, afin d''ajouter les fonctionnalités suivantes:</p>\r\n\r\n<ul>\r\n<li>Contact form\r\n\r\n<ul>\r\n<li>Requires email address</li>\r\n<li>Requires a message</li>\r\n<li>Optional, supports sending debug information from the parent app</li>\r\n</ul></li>\r\n<li>FAQ list\r\n\r\n<ul>\r\n<li>List of Categories or Questions</li>\r\n<li>Tapping each will display a WebView of html content (image links can be hosted on your own server and referenced within the text)</li>\r\n</ul></li>\r\n<li>Chat Stream\r\n\r\n<ul>\r\n<li>Like HipChat or Slack, users can view the public chatting about your app</li>\r\n<li>Anonymous users can join the conversation (or add an avatar and name to deanonymize themselves)</li>\r\n<li>Messages can be personally muted (which will also flag themselves on the server)</li>\r\n</ul></li>\r\n</ul>', 8, 1, 'fr_FR', 'fr'),
(10, 'Comment puis-je le configurer?', '<p>The current implementation supports a PHP/MySQL back-end. The MySQL tables can be imported from the /MySQL folder. The PHP files (located in /PHP) can be used to make a simple REST API endpoint which will then be used by the iOS framework.</p>\r\n\r\n<p>The sample app in iOS/"Example Project" will show you a simple (one screen) application that has implemented and configured the app''s connection to a sample REST API.</p>', 8, 2, 'fr_FR', 'fr'),
(11, 'Guide d''installation rapide', '<ol>\r\n<li>Create a MySQL database, and add a database user to it with SELECT, INSERT, and UPDATE permissions</li>\r\n<li>Import the SQL from the /MySQL/helpstream.sql file (I used PHPMyAdmin and pasted the text into the SQL tab)</li>\r\n<li>Modify the /PHP/api/db_config.php to have the database name, database username, and database password for your database (created in step 1).</li>\r\n<li>Upload the PHP scripts in /PHP/api to a folder on your webserver</li>\r\n<li>In Xcode, load the iOS/Example Project/helpstream_demo.xcodeproj file</li>\r\n<li>Modify the helpstream_demo/ViewController.swift file to have the url path to your php scripts.</li>\r\n<li>Run it and try it out!</li>\r\n</ol>', 8, 3, 'fr_FR', 'fr'),
(12, 'Qu''est-ce que le Chat stream?', '<ul>\r\n<li>Like HipChat or Slack, users can view the public chatting about your app</li>\r\n<li>Anonymous users can join the conversation (or add an avatar and name to deanonymize themselves)</li>\r\n<li>Messages can be personally muted (which will also flag themselves on the server)</li>\r\n</ul>', 0, 2, 'fr_FR', 'fr'),
(13, 'Qu''est-ce que le FAQ?', '<ul>\r\n<li>List of Categories or Questions</li>\r\n<li>Tapping each will display a WebView of html content (image links can be hosted on your own server and referenced within the text)</li>\r\n</ul>', 0, 3, 'fr_FR', 'fr'),
(14, 'Qu''est-ce que le formulaire de contact?', '<ul>\r\n<li>Requires email address</li>\r\n<li>Requires a message</li>\r\n<li>Optional, supports sending debug information from the parent app</li>\r\n</ul>', 0, 4, 'fr_FR', 'fr'),
(15, 'HelpStreamとは何ですか？', '', 0, 1, 'ja_JA', 'ja'),
(16, 'HelpStreamの概要', '<p>HelpStreamは、以下の機能を追加するために、iOSアプリケーションにドロップできるフレームワークです：</p>\r\n\r\n<ul>\r\n<li>Contact form\r\n\r\n<ul>\r\n<li>Requires email address</li>\r\n<li>Requires a message</li>\r\n<li>Optional, supports sending debug information from the parent app</li>\r\n</ul></li>\r\n<li>FAQ list\r\n\r\n<ul>\r\n<li>List of Categories or Questions</li>\r\n<li>Tapping each will display a WebView of html content (image links can be hosted on your own server and referenced within the text)</li>\r\n</ul></li>\r\n<li>Chat Stream\r\n\r\n<ul>\r\n<li>Like HipChat or Slack, users can view the public chatting about your app</li>\r\n<li>Anonymous users can join the conversation (or add an avatar and name to deanonymize themselves)</li>\r\n<li>Messages can be personally muted (which will also flag themselves on the server)</li>\r\n</ul></li>\r\n</ul>', 15, 1, 'ja_JA', 'ja'),
(17, 'どうすれば設定できますか？', '<p>The current implementation supports a PHP/MySQL back-end. The MySQL tables can be imported from the /MySQL folder. The PHP files (located in /PHP) can be used to make a simple REST API endpoint which will then be used by the iOS framework.</p>\r\n\r\n<p>The sample app in iOS/"Example Project" will show you a simple (one screen) application that has implemented and configured the app''s connection to a sample REST API.</p>', 15, 2, 'ja_JA', 'ja'),
(18, 'クイックインストールガイド', '<ol>\r\n<li>Create a MySQL database, and add a database user to it with SELECT, INSERT, and UPDATE permissions</li>\r\n<li>Import the SQL from the /MySQL/helpstream.sql file (I used PHPMyAdmin and pasted the text into the SQL tab)</li>\r\n<li>Modify the /PHP/api/db_config.php to have the database name, database username, and database password for your database (created in step 1).</li>\r\n<li>Upload the PHP scripts in /PHP/api to a folder on your webserver</li>\r\n<li>In Xcode, load the iOS/Example Project/helpstream_demo.xcodeproj file</li>\r\n<li>Modify the helpstream_demo/ViewController.swift file to have the url path to your php scripts.</li>\r\n<li>Run it and try it out!</li>\r\n</ol>', 15, 3, 'ja_JA', 'ja'),
(19, 'チャットストリームとは何ですか？', '<ul>\r\n<li>Like HipChat or Slack, users can view the public chatting about your app</li>\r\n<li>Anonymous users can join the conversation (or add an avatar and name to deanonymize themselves)</li>\r\n<li>Messages can be personally muted (which will also flag themselves on the server)</li>\r\n</ul>', 0, 2, 'ja_JA', 'ja'),
(20, 'FAQ /ヘルプリストとは何ですか？', '<ul>\r\n<li>List of Categories or Questions</li>\r\n<li>Tapping each will display a WebView of html content (image links can be hosted on your own server and referenced within the text)</li>\r\n</ul>', 0, 3, 'ja_JA', 'ja'),
(21, '連絡先フォームとは何ですか？', '<ul>\r\n<li>Requires email address</li>\r\n<li>Requires a message</li>\r\n<li>Optional, supports sending debug information from the parent app</li>\r\n</ul>', 0, 4, 'ja_JA', 'ja');

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
