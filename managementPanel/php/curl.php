<?php
include_once 'auth.php';
class curl {
public function __construct(){
  $auth = new auth();
$this->url = $auth->dbUrl;
}

public function __destruct(){
    die();
  }

    public function login (){
      echo"login";
      $this->curlHandler = curl_init($this->url);
      curl_setopt($this->curlHandler, CURLOPT_NOBODY, false);
      curl_setopt(CURLOPT_RETURNTRANSFER, false); //changing false to true is the answer!
      echo curl_exec($this->curlHandler);
      curl_close($this->curlHandler);
    }


    public function deneme(){
      echo"deneme";
    }



}


?>
