<?

  // This file contains the configuration information specific to your server

  $mysqli = mysqli_connect ("localhost", "DATABASE_USER_NAME", "DATABASE_USER_PASSWORD", "DATABASE_NAME");
  
  // default locale for FAQ (equivalent of "Base localization" in iOS)
  $default_locale = "en_US";
  
  
  
  
  
  //===================================
  
  /* check connection */
  if (mysqli_connect_errno()) {
    print('"fatal_error": "connect failed: ' . mysqli_connect_error() . '" }');
    exit();
  }
  mysqli_set_charset($mysqli, 'utf8');
  
?>