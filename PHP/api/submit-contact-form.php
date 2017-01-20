{<?
  require_once("db_config.php");
  include_once("common.php");

  $_REQUEST[id] = cleanString ($_REQUEST[id]);
  $_REQUEST[email] = cleanString ($_REQUEST[email]);
  $_REQUEST[message] = cleanString ($_REQUEST[message]);
  $_REQUEST[debug] = cleanString ($_REQUEST[debug]);

  // get UUID from database

  $qry = mysqli_query ($mysqli, "SELECT intDeviceID, intTotalUpdates
    FROM tblDevices WHERE strDeviceUniqueIdentifier = '$_REQUEST[id]'");

  if ($qry != "" && mysqli_num_rows ($qry) > 0) {
  
    $arr = mysqli_fetch_array ($qry);
    $intTotalUpdates = $arr[intTotalUpdates] + 1;
    $intDeviceID = $arr[intDeviceID];
    $qry1 = mysqli_query ($mysqli, "UPDATE tblDevices
      SET
        dateUpdated = '$dateCreated',
        strIPUpdated = '$strIPCreated',
        intTotalUpdates = '$intTotalUpdates'
      WHERE
        intDeviceID = '$intDeviceID'");
        
    $qry2 = mysqli_query ($mysqli, "INSERT INTO tblContacts (
      intDeviceID,
      strEmail,
      strMessage,
      strDebug,
      dateCreated
    ) VALUES (
      '$intDeviceID',
      '$_REQUEST[email]',
      '$_REQUEST[message]',
      '$_REQUEST[debug]',
      '$dateCreated'
    )");

  }
  
  print (' "script_completed": true ');

?>}