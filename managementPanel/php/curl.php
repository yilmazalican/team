<?php

class curl {
  const url = "https://iflat-3b499.firebaseio.com";
public function __construct(){

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
