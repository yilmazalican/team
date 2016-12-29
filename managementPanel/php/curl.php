<?php
include_once 'auth.php';
class curl {
public function __construct(){
  $auth = new auth();
$this->url = $auth->dbUrl;
}



    public function getIssues (){
      echo"Issue";
      $this->curlHandler = curl_init($this->url . "/issues.json");
      curl_setopt($this->curlHandler, CURLOPT_NOBODY, false);
      curl_setopt($this->curlHandler, CURLOPT_RETURNTRANSFER, true);
      $result = curl_exec($this->curlHandler);
      curl_close($this->curlHandler);

      $data = json_decode($result, TRUE);

      $issueOutput = "<p>";
      foreach ($data as $key => $value) {
        $issueOutput .= "id: " . $key;
        $issueOutput .= " title: " . $data[$key]['title'];
        $issueOutput .= " content: " . $data[$key]['content'];
        $issueOutput .= " isOpen: " . $data[$key]['isOpen'];
        $issueOutput .= " answer: " . $data[$key]['answer'];
        $issueOutput .= "<br>";
      }

      return $issueOutput;
    }


    public function deneme(){
      //echo"deneme";
    }



}


?>
