<?php
$response = array();
if($_SERVER['REQUEST_METHOD']=='POST') {

  $uuidU = $_POST['uuid'];
  $picidP = $_POST['picid'];



  require_once '../include/DBRemovePhoto.php';
  $db = new DBRemovePhoto($uuidU);

  if($db -> removePhoto($picidP)) {
  $response['error'] = false;
  $response['message'] = 'PhotoInfo added Successfully';
  } else {
  $response['error'] = true;
  $response['message'] = 'Could not add PhotoInfo';
  }

} else {
  $response['error'] = true;
  $response['message'] = 'Wrong Method';
}
echo json_encode($response);

?>
