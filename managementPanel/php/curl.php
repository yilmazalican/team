<?php

class curl {
  const URL = "https://iflat-3b499.firebaseio.com";
  public function login (){
    $this->curlHandler = curl_init($this->URL);
    curl_setopt($this->curlHandler, CURLOPT_NOBODY, false);
    curl_setopt(CURLOPT_RETURNTRANSFER, false); //changing false to true is the answer!
    echo curl_exec($this->curlHandler);
    curl_close($this->curlHandler);
  }
}
?>
