<?php
$response = array();
if($_SERVER['REQUEST_METHOD']=='POST') {
  $uuidU = $_POST['uuid'];
  // $arr = array();
  $lineArrayT = json_decode($_POST['lineArray']);
  $authArrayT = json_decode($_POST['authArray']);


  // swift에서 넘어온 배열을 php의 입맛에 맞게 변경
  // string함수 사용해서 변수에 따로저장 후 배열변수에 입력>> 사용해볼것...

  require_once '../include/DBMove.php';
  $db = new DBMove($uuidU);

  if($db -> moveTag($lineArrayT, $authArrayT)) {
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
