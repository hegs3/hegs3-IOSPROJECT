<?php
class DbConnect
{
    private $conn;


    function __construct()
    {

    }

    function connect($dbCheck)
    {
        require_once 'Config.php';


            if ($dbCheck == 'account') {
              $this->conn = new mysqli(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME1);
            } elseif ($dbCheck == 'picture') {
              $this->conn = new mysqli(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME2);
            }


        if (mysqli_connect_errno()) {
            echo "Failed to connect to MySQL: ".mysqli_connect_error();
        }

        return $this->conn;
    }
}
?>
