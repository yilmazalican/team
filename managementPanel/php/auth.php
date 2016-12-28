<?php
// login

class auth {

  public function __construct(){
    echo "cont";
    $this->url = "https://iflat-3b499.firebaseio.com/admins.json";
    $this->curlHandler = curl_init($this->url);

  }

  public function login($mail, $pass) {
    echo "login";
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
    }else{
      echo "Login failed!";
    }

  }

  public function logout(){
        session_start();
    session_destroy();
    echo "Logged out!";
  }


}
?>
