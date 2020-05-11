<?php


class DBOperation {
  private $conn;

  function __construct() {
    require_once dirname(__FILE__) . '/DBConnect.php';
    $db = new DBConnect();
    $dbCheck = 'account';
    $this->conn = $db->connect($dbCheck);
  }
  public function verification($uuid, $cntDate) {
    //여기서 비교 >>> 검증

    //TRUNCATE 테이블명
    $sql = "SELECT * FROM uuidinfo WHERE uuid = ?";
    $stmt = $this->conn->prepare($sql);
    $stmt->bind_param("s", $uuid);
    $result = $stmt->execute();
    $re = $stmt->get_result();
    $data = $re->fetch_assoc();
    $stmt->fetch();
    $stmt->close();


      // IF NOT EXISTS
    if($data['uuid'] == null) {
        $sql = 'INSERT INTO
                  uuidinfo(uuid, cntDate)
                VALUES
                (?, ?)';
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("ss", $uuid, $cntDate);
        $re = $stmt->execute();
        $stmt->fetch();
        $stmt->close();
        //db변경(테이블 생성규칙 적용 >> -사용x)
        //길이도 너무김
        //고유 숫자로 변경하기...

          //$tablename;(변수)  sql 의 결과값 변수에 저장(table명으로 정의할 데이터)
//converter 추가하기
//           (int)$Variable
// // 문자타입을 숫자타입으로 바꾸기
//
// (string)$Variable
// // 숫자타입을 문자타입으로 바꾸기
//쿼터 더블쿼터 비교확인하기
        $sql = 'SELECT id FROM uuidinfo WHERE uuid = \''.$uuid.'\'';
        $stmt = $this->conn->prepare($sql);
        $re = $stmt->execute();
        $re = $stmt->get_result();
        $tablename = $re->fetch_assoc();
        $stmt->fetch();
        $stmt->close();

        $namerule1 = 'a';    //PICTUREtable 이름을 강제로 명명하기 위한 문자열
        $namerule2 = 'b';    //TAGtable 이름을 강제로 명명하기 위한 문자열
        $tablename = (string)$tablename['id'];    //uuid의 순번과 동일시

        // $tablename = $namerule.$tablename;
        // echo $tablename;
// $query = "select * from test where  '$o' = '$user_search'";
// $query = 'select * from test where '.$o.' =\''.$user_search.'\'';

        $stmt = mysqli_select_db($this->conn, "tagpicture_picture");
        $sql = 'CREATE TABLE IF NOT EXISTS '.$namerule1.$tablename.' LIKE uuidcopy';
        $stmt = $this->conn->prepare($sql);
        $re = $stmt->execute();
        $stmt->fetch();
        $stmt->close();

        $sql = 'CREATE TABLE IF NOT EXISTS '.$namerule2.$tablename.' LIKE tagcopy';
        $stmt = $this->conn->prepare($sql);
        $re = $stmt->execute();
        $stmt->fetch();
        $stmt->close();
        // echo "NEW ADD";


//특정문자열 제거
// echo str_replace('a','',$namerule.$tablename); ->>>>>>(int)$tablename
    } else {
        $sql = "UPDATE uuidinfo
                SET cntDate=?
                WHERE uuid=?";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("ss", $cntDate, $uuid);
        $re = $stmt->execute();
        $stmt->fetch();
        $stmt->close();


        $sql = 'SELECT id FROM uuidinfo WHERE uuid = \''.$uuid.'\'';
        $stmt = $this->conn->prepare($sql);
        $re = $stmt->execute();

        $re = $stmt->get_result();
        $tablename = $re->fetch_assoc();

        $stmt->fetch();
        $stmt->close();


        $namerule1 = 'a';    //PICTUREtable 이름을 강제로 명명하기 위한 문자열
        $namerule2 = 'b';    //TAGtable 이름을 강제로 명명하기 위한 문자열
        $tablename = (string)$tablename['id'];    //uuid의 순번과 동일시
        $tableID = $tablename;
        define('TABLEID', $tableID);// TABLEID



        $stmt = mysqli_select_db($this->conn, "tagpicture_picture");
        $sql = 'SELECT * FROM '.$namerule2.$tableID.' ORDER BY line ASC';
        $stmt = $this->conn->prepare($sql);
        $re = $stmt->execute();
        $re = $stmt->get_result();
        $rr = array();
        $i = 0;
        $test = array();
        while($row = $re->fetch_array()){
          $test[] = $row;
          $i++;
          // echo json_encode($row);
        }

        $stmt->fetch();
        $stmt->close();

        $sql = 'SELECT * FROM '.$namerule1.$tableID.' ORDER BY auth ASC';
        $stmt = $this->conn->prepare($sql);
        $re = $stmt->execute();
        $re = $stmt->get_result();
        $rr = array();
        $i = 0;
        $test2 = array();
        while($row = $re->fetch_array()){
          $test2[] = $row;
          $i++;
          // echo json_encode($row);
        }

        $stmt->fetch();
        $stmt->close();


        $json_array = array_merge($test,$test2);
        echo json_encode($json_array);

    }





    require_once 'encodeJson.php';
    $json = new EncodeJson();
    if ($result) {
      return true;
    } else {
      return false;
    }



  }
  // public function createPhotoInfo($photoPicID, $photoTitle, $photoUpdateD, $photoURL, $photoPhotoSize) {
  //   $sql = ""
  //   //데이터베이스 변경후 >>>>
  //
  //   $stmt = $this->conn->prepare($sql);
  //   $stmt->bind_param('sssss',$photoPicID, $photoTitle, $photoUpdateD, $photoURL, $photoPhotoSize);
  //   $result = $stml->execute();
  //   $stml->close();
  //
  //   if ($ressult) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
?>
