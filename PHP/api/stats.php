{<?
  require_once("db_config.php");
  include_once("common.php");

  $_REQUEST[a] = cleanString ($_REQUEST[a]);
  $_REQUEST[b] = cleanString ($_REQUEST[b]);
  $_REQUEST[c] = cleanString ($_REQUEST[c]);
  $_REQUEST[d] = cleanString ($_REQUEST[d]);
  $_REQUEST[e] = cleanString ($_REQUEST[e]);
  $_REQUEST[f] = cleanString ($_REQUEST[f]);
  $_REQUEST[g] = cleanString ($_REQUEST[g]);
  $_REQUEST[h] = cleanString ($_REQUEST[h]);

  // check to see if UUID is in database
  // if not, add it

  $qry = mysqli_query ($mysqli, "SELECT intDeviceID, intTotalUpdates
    FROM tblDevices WHERE strDeviceUniqueIdentifier = '$_REQUEST[f]'");

  if ($qry != "" && mysqli_num_rows ($qry) > 0) {
    $arr = mysqli_fetch_array ($qry);
    $intTotalUpdates = $arr[intTotalUpdates] + 1;
    $intDeviceID = $arr[intDeviceID];
    $qry2 = mysqli_query ($mysqli, "UPDATE tblDevices
      SET
        strDeviceName = '$_REQUEST[a]',
        strDeviceModel = '$_REQUEST[b]',
        strDeviceLocalizedModel = '$_REQUEST[c]',
        strDeviceSystemName = '$_REQUEST[d]',
        strDeviceSystemVersion = '$_REQUEST[e]',
        strDeviceLocale = '$_REQUEST[g]',
        strDeviceLanguage = '$_REQUEST[h]',
        dateUpdated = '$dateCreated',
        strIPUpdated = '$strIPCreated',
        intTotalUpdates = '$intTotalUpdates'
      WHERE
        intDeviceID = '$intDeviceID'");

  } else {
    $qry2 = mysqli_query ($mysqli, "INSERT INTO tblDevices (
      strDeviceName,
      strDeviceModel,
      strDeviceLocalizedModel,
      strDeviceSystemName,
      strDeviceSystemVersion,
      strDeviceUniqueIdentifier,
      strDeviceLocale,
      strDeviceLanguage,
      dateCreated,
      strIPCreated,
      intTotalUpdates
    ) VALUES (
      '$_REQUEST[a]',
      '$_REQUEST[b]',
      '$_REQUEST[c]',
      '$_REQUEST[d]',
      '$_REQUEST[e]',
      '$_REQUEST[f]',
      '$_REQUEST[g]',
      '$_REQUEST[h]',
      '$dateCreated',
      '$strIPCreated',
      '1'
    )");
    
  }
  
  print (' "script_completed": true ');

?>}