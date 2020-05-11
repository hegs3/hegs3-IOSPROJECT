<?php
  $response = array();
  if($_SERVER['REQUEST_METHOD']=='POST') {
    $uuidU = $_POST['uuid'];
    $lineT = $_POST['line'];
    $subjectT = $_POST['subject'];

    //조건으로 null 이 아닐경우로  함수 호춣 가능

    require_once '../include/DBCreate.php';
    $db = new DBCreate($uuidU);

    if($db -> createTag($lineT, $subjectT)) {
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
