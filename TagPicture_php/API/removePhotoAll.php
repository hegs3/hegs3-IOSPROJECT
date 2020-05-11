<?php
$response = array();
if($_SERVER['REQUEST_METHOD']=='POST') {

  $uuidU = $_POST['uuid'];
  $authP = $_POST['auth'];



  require_once '../include/DBRemovePhotoAll.php';
  $db = new DBRemovePhotoAll($uuidU);

  if($db -> removePhotoAll($authP)) {
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
