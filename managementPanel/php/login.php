<?php
// login
include('curl.php');
class auth {

  public function __construct(){
    $this->url = "https://iflat-3b499.firebaseio.com";
    $this->curlHandler = curl_init($curl->url);
    curl_setopt($this->curlHandler, CURLOPT_NOBODY, false);
    curl_setopt(CURLOPT_RETURNTRANSFER, false); //changing false to true is the answer!
    echo curl_exec($this->curlHandler);
    curl_close($this->curlHandler);
  }

  public function login($mail, $pass) {
    session_start();
    $_SESSION['login'] = "";
  }

  public function logout(){
    session_destroy();
  }


}
 ?>
