<?
  $dateCreated = date ("Y-m-d H:i:s");
  $strIPCreated = $_SERVER[REMOTE_ADDR];

  function cleanString ($strInput) {
    global $mysqli;
  
    $strInput = mysqli_real_escape_string ($mysqli, trim(strip_tags ($strInput)));
    return ($strInput);
  }
?>