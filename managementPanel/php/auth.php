<?php
// login

class auth {

  public $dbUrl = "https://iflat-3b499.firebaseio.com";

  public function __construct(){



  }

  public function login($mail, $pass) {
      $this->url = $this->dbUrl . "/admins.json";
	  
    $this->curlHandler = curl_init($this->url);
    curl_setopt($this->curlHandler, CURLOPT_NOBODY, false);
    curl_setopt($this->curlHandler, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($this->curlHandler, CURLOPT_SSL_VERIFYPEER,false);
    $dataJson =  curl_exec($this->curlHandler);
	//echo "json" . $dataJson;
    curl_close($this->curlHandler);
	
    $data = json_decode($dataJson, TRUE);
    //session_start();
	
    foreach ($data as $key => $value) {
      if(strcasecmp($data[$key]['mail'],$mail) == 0){
        if(strcmp($data[$key]['pass'],$pass) == 0){
          if(strcmp($data[$key]['activated'],"1") == 0){
            $_SESSION['login'] = $data[$key];
          }else{
		  echo"<script language=javascript>alert('Account Disabled!');</script><br>";
		  }
        }
      }
    }

    if(isset($_SESSION['login'])){
      echo "Logged in!";
      header("Refresh: 1");
    }else{
      echo"<script language=javascript>alert('Login Failed! Email or Password wrong!');</script><br>";

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
    echo"Logout successfully!";
    header("Refresh: 0; url=index.php");
  }




}

?>
