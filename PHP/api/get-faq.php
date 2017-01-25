{<?
  require_once("db_config.php");
  include_once("common.php");

  $_REQUEST[id] = cleanString ($_REQUEST[id]);

  // get UUID from database 

  $qry = mysqli_query ($mysqli, "SELECT intDeviceID, strDeviceLocale, strDeviceLanguage
    FROM tblDevices WHERE strDeviceUniqueIdentifier = '$_REQUEST[id]'");

  if ($qry != "" && mysqli_num_rows ($qry) > 0) {
  
    $arr = mysqli_fetch_array ($qry);
    $intDeviceID = $arr[intDeviceID];
    $strDeviceLocale = $arr[strDeviceLocale]; // en_US
    
    $lang = explode("-", $arr[strDeviceLanguage]);
    $strDeviceLanguage = strtolower($lang[0]); // en
    
    // check locale first in case of multiple languages localized for different regions (i.e. es_US)
    
    $compare_key = "strLocale";
    $compare_value = $strDeviceLocale;
    $c1 = mysqli_query ($mysqli, "SELECT COUNT(1) FROM tblFAQ WHERE strLocale = '$strDeviceLocale'");
    
    if ($c1 == "" || mysqli_num_rows($c1) == 0 || mysqli_result($c1) == 0) {
      $compare_key = "strLanguage";
      $compare_value = $strDeviceLanguage;
      $c2 = mysqli_query ($mysqli, "SELECT COUNT(1) FROM tblFAQ WHERE strLanguage = '$strDeviceLanguage'");
      if ($c2 == "" || mysqli_num_rows($c2) == 0 || mysqli_result($c2) == 0) {
        $compare_key = "strLocale"; // default to Base localization (configured in db_config.php)
        $compare_value = $default_locale;
      }
    }
    
    $qry1 = mysqli_query ($mysqli, "SELECT intFAQID, strTitle, strAnswer, intParentID, intOrder
      FROM tblFAQ
      WHERE " . $compare_key . " = '" . $compare_value . "'
      ORDER BY intParentID DESC, intOrder");
      
    print (' "FAQ": [');
    
    $comma = "";
    while ($row = mysqli_fetch_array($qry1, MYSQLI_ASSOC)) {
      print $comma;
      echo json_encode($row);
      $comma = ",";
    }
    
    print ('],');

  }
  
  print (' "script_completed": true ');

?>}