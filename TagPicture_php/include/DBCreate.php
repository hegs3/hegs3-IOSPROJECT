<?php
class DBCreate {
  private $conn;
   private $tableID;
  function __construct($uuid) {
    require_once dirname(__FILE__) . '/DBConnect.php';
    $db = new DBConnect();
    $dbCheck = 'account';
    $this->conn = $db->connect($dbCheck);

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

  }
  public function createTag($line, $subject) {
    // $test = $tableID;
      $tableID = 'b'.TABLEID;
    //    받아온데이터 떄려넣기
    //tagcopy 대신 tag0 ~ tag00 으로 변경될 예정
    // ex) $sql = 'SELECT id FROM uuidinfo WHERE uuid = \''.$uuid.'\'';`  `
        $stmt = mysqli_select_db($this->conn, "tagpicture_picture");

        $sql = 'INSERT INTO
        '.$tableID.'(line, subject)
        VALUES (?, ?)';
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("is", $line, $subject);
        $result = $stmt->execute();
        $stmt->fetch();
        $stmt->close();
//         "SELECT AUTO_INCREMENT FROM
// information_schema.tables WHERE table_name = '".$tableID."' AND table_schema = 'tagpicture_picture'";
        $sql = 'SELECT AUTO_INCREMENT FROM
                  information_schema.tables WHERE
                  table_name = \''.$tableID.'\' AND
                  table_schema = \'tagpicture_picture\'';
        $stmt = $this->conn->prepare($sql);
        $result = $stmt->execute();
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


        echo json_encode($test);





        if ($result) {
                return true;
            } else {
                return false;
            }

  }

}
?>
