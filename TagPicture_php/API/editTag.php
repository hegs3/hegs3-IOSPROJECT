<?php
$response = array();
if($_SERVER['REQUEST_METHOD']=='POST') {
  $uuidU = $_POST['uuid'];
  $authT = $_POST['auth'];
  $subjectT = $_POST['subject'];


  require_once '../include/DBEdit.php';
  $db = new DBEdit($uuidU);

  if($db -> editTag($authT, $subjectT)) {
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
