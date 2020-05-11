<?php
$response = array();
if($_SERVER['REQUEST_METHOD']=='POST') {

  $uuidU = $_POST['uuid'];
  $authTB = $_POST['auth'];
  $picidTA = $_POST['picid'];
  $titleTA = $_POST['title'];
  $updateDTA = $_POST['updateD'];
  $URLTA = $_POST['URL'];
  $photosizeTA = $_POST['photosize'];



  require_once '../include/DBPick.php';
  $db = new DBPick($uuidU);

  if($db -> pick($picidTA, $titleTA, $updateDTA, $URLTA, $photosizeTA, $authTB)) {
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
