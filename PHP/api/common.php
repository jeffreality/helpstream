<?
  $dateCreated = date ("Y-m-d H:i:s");
  $strIPCreated = $_SERVER[REMOTE_ADDR];

  function cleanString ($strInput) {
    global $mysqli;
  
    $strInput = mysqli_real_escape_string ($mysqli, trim(strip_tags ($strInput)));
    return ($strInput);
  }
  
  function mysqli_result($res,$row=0,$col=0){ 
    $numrows = mysqli_num_rows($res); 
    if ($numrows && $row <= ($numrows-1) && $row >=0){
        mysqli_data_seek($res,$row);
        $resrow = (is_numeric($col)) ? mysqli_fetch_row($res) : mysqli_fetch_assoc($res);
        if (isset($resrow[$col])){
            return $resrow[$col];
        }
    }
    return false;
  }
?>