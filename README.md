# helpstream
iOS Framework for adding skinnable, multilingual customer chat, FAQ, and contact form

## Overview
This is a framework that can be dropped into any iOS application, in order to add the following features:

* Contact form
  * Requires email address
  * Requires a message
  * Optional, supports sending debug information from the parent app
* FAQ list
  * List of Categories or Questions
  * Tapping each will display a WebView of html content (image links can be hosted on your own server and referenced within the text)
* Chat Stream
   * Like HipChat or Slack, users can view the public chatting about your app
   * Anonymous users can join the conversation (or add an avatar and name to deanonymize themselves)
   * Messages can be personally muted (which will also flag themselves on the server)

## Setup

The current implementation supports a PHP/MySQL back-end. The MySQL tables can be imported from the /MySQL folder. The PHP files (located in /PHP) can be used to make a simple REST API endpoint which will then be used by the iOS framework.

The sample app in iOS/"Example Project" will show you a simple (one screen) application that has implemented and configured the app's connection to a sample REST API.

## Quick Installation

1. Create a MySQL database, and add a database user to it with SELECT, INSERT, and UPDATE permissions
2. Import the SQL from the /MySQL/helpstream.sql file (I used PHPMyAdmin and pasted the text into the SQL tab)
3. Modify the /PHP/api/db_config.php to have the database name, database username, and database password for your database (created in step 1).
4. Upload the PHP scripts in /PHP/api to a folder on your webserver
5. In Xcode, load the iOS/Example Project/helpstream_demo.xcodeproj file
6. Modify the helpstream_demo/ViewController.swift file to have the url path to your php scripts.
7. Run it and try it out!

***Please let me know if you're stuck on any of these steps, so I can update this document!***