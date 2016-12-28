<?php
// login

class auth {

  public $dbUrl = "https://iflat-3b499.firebaseio.com";

  public function __construct(){

    $this->url = $this->dbUrl . "/admins.json";
    $this->curlHandler = curl_init($this->url);

  }

  public function login($mail, $pass) {
    curl_setopt($this->curlHandler, CURLOPT_NOBODY, false);
    curl_setopt($this->curlHandler, CURLOPT_RETURNTRANSFER, true);
    $dataJson =  curl_exec($this->curlHandler);
    curl_close($this->curlHandler);

    $data = json_decode($dataJson, TRUE);
    session_start();
    foreach ($data as $key => $value) {
      if(strcasecmp($data[$key]['mail'],$mail) == 0){
        if(strcmp($data[$key]['pass'],$pass) == 0){
          if(strcmp($data[$key]['activated'],"1") == 0){
            $_SESSION['login'] = $data[$key];
          }
        }
      }
    }

    if(isset($_SESSION['login'])){
      echo "Logged in!";
      header("Refresh: 1; url=php/main.php");
    }else{
      echo "Login failed!";

    }

  }

  public function loginForm(){
    //$data ="eren";
    require_once("template/loginTemplate.php");
    if(isset($_POST['email'])&&isset($_POST['password'])){
    $this->login($_POST['email'],$_POST['password']);
  }
  }

  public function logout(){
        session_start();
    session_destroy();
    echo "Logged out!";
  }

  public function handleLogin($class){
    echo "asdasd";
    if(!isset($_SESSION['login'])){
      echo "Please login!";
      header("Refresh: 2; url=../index.php");
      $class.die();
    }
  }


}

?>
