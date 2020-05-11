<?php
$response = array();
if($_SERVER['REQUEST_METHOD']=='POST') {
  $uuidU = $_POST['uuid'];
  $cntDateU = $_POST['cntDate'];


  require_once '../include/DBOperation.php';
  $db = new DBOperation();

  if($db -> verification($uuidU, $cntDateU)) {
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
// echo json_encode($response);

?>
