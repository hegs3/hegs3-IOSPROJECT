<?php
$response = array();
if($_SERVER['REQUEST_METHOD']=='POST') {
  $uuidU = $_POST['uuid'];


  require_once '../include/DBRemoveAll.php';
  $db = new DBRemoveAll($uuidU);

  if($db -> removeTagAll()) {
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
