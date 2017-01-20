<?
  require_once("db_config.php");
  
  $dateCreated = date ("Y-m-d H:i:s");
  $strIPCreated = $_SERVER[REMOTE_ADDR];

  function cleanString ($strInput) {
    $strInput = trim(strip_tags ($strInput));
    return (mysqli_real_escape_string ($strInput));
  }

  $_POST[a] = cleanString ($_POST[a]);
  $_POST[b] = cleanString ($_POST[b]);
  $_POST[c] = cleanString ($_POST[c]);
  $_POST[d] = cleanString ($_POST[d]);
  $_POST[e] = cleanString ($_POST[e]);
  $_POST[f] = cleanString ($_POST[f]);
  $_POST[g] = cleanString ($_POST[g]);
  $_POST[h] = cleanString ($_POST[h]);

  // check to see if UUID is in database
  // if not, add it

  $qry = mysqli_query ($mysqli, "SELECT intDeviceID, intTotalUpdates
    FROM tblDevices WHERE strDeviceUniqueIdentifier = '$_POST[f]'");

  if ($qry != "" && mysqli_num_rows ($qry) > 0) {
    $arr = mysqli_fetch_array ($qry);
    $intTotalUpdates = $arr[intTotalUpdates] + 1;
    $intDeviceID = $arr[intDeviceID];
    $qry2 = mysqli_query ($mysqli, "UPDATE tblDevices
      SET
        strDeviceName = '$_POST[a]',
        strDeviceModel = '$_POST[b]',
        strDeviceLocalizedModel = '$_POST[c]',
        strDeviceSystemName = '$_POST[d]',
        strDeviceSystemVersion = '$_POST[e]',
        strDeviceLocale = '$_POST[g]',
        strDeviceLanguage = '$_POST[h]',
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
      '$_POST[a]',
      '$_POST[b]',
      '$_POST[c]',
      '$_POST[d]',
      '$_POST[e]',
      '$_POST[f]',
      '$_POST[g]',
      '$_POST[h]',
      '$dateCreated',
      '$strIPCreated',
      '1'
    )");
  }

  echo "{ \"success\": true }";

?>