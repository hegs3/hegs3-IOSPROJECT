<?php
$response = array();
if($_SERVER['REQUEST_METHOD']=='POST') {
  $uuidU = $_POST['uuid'];
  $authT = $_POST['auth'];


  require_once '../include/DBRemove.php';
  $db = new DBRemove($uuidU);

  if($db -> removeTag($authT)) {
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
