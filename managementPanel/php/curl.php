<?php
include_once 'auth.php';
class curl {
  public function __construct(){
    $auth = new auth();
    $this->url = $auth->dbUrl;
  }



  public function getIssues (){
    echo"Issue";
    $result = $this->getNodeCurl("issues.json");

    $data = json_decode($result, TRUE);
	
    $tableGen = "<table border=1><td>Status</td><td>Issuer</td><td>Issued</td><td>Title</td><td>Content</td><td>Answer</td>";
    $closedData = "<p>Closed Issues<br>" . $tableGen;
    $openData = "<p>Open Issues<br>" . $tableGen;
    foreach ($data as $key => $value) {
      $issueOutput = "";
        if($data[$key]['isOpen'] == "true"){
          $issueOutput .= "<tr bgcolor='#22ff22'>";
          $issueOutput .= "<td>OPEN</td>";
        }
        else{
          $issueOutput .= "<tr bgcolor='#ff3311'>";
          $issueOutput .= "<td>CLOSED</td>";
        }

      //$issueOutput .= "id: " . $key;
      $issueOutput .= "<td>" . $data[$key]['issuer'] . "</td>";
      $issueOutput .= "<td>" . $data[$key]['issued'] . "</td>";
      $issueOutput .= "<td>" . $data[$key]['title'] . "</td>";
      $issueOutput .= "<td>" . $data[$key]['content'] . "</td>";
      if(isset($data[$key]['answer'])){
        $issueOutput .= "<td>" . $data[$key]['answer'] . "</td>";
      }
      else{
        $issueOutput .= "<td><a href=/?iid=" . $key . ">Give Answer</a></td>";
      }

      $issueOutput .= "</tr>";

      if($data[$key]['isOpen'] == "true"){
        $openData .= $issueOutput;
      }
      else{
        $closedData .= $issueOutput;
      }
    }
    $openData .= "</table>";
    $closedData .= "</table>";

    return ($openData . "<hr>" . $closedData);
  }

public function closeIssueForm($iid){
	$form = "<form method=POST>";
	$form .= "<label>Answer</label>";
	$form .= "<input type=textbox name=answertext />";
	$form .= "<input type=hidden name=iid value=" . $iid . " />";
	$form .= "<input type=submit value= submit />";
	$form .= "</form>";
	
	return $form;
}
  
  
public function closeIssue($iid, $answer){
  echo"Close Issue";


$node = "/issues" . "/" . $iid . "/isOpen.json";
$result = $this->updateNodeCurl($node, "false");

$node = "/issues" . "/" . $iid . "/answer.json";
$result .= $this->updateNodeCurl($node, $answer);

  return $result;
}


public function getPromotions (){
    echo"Issue";
    $result = $this->getNodeCurl("promotions.json");

    $data = json_decode($result, TRUE);
	
    $tableGen = "<table border=1><td>Status</td><td>Title</td><td>Discount Rate</td><td>Description</td><td>Change Status</td>";
    $closedData = "<p>Passive Promotions<br>" . $tableGen;
    $openData = "<p>Active Promotions<br>" . $tableGen;
    foreach ($data as $key => $value) {
      $issueOutput = "";
        if($data[$key]['isActive'] == "true"){
          $issueOutput .= "<tr bgcolor='#22ff22'>";
          $issueOutput .= "<td>Active</td>";
        }
        else{
          $issueOutput .= "<tr bgcolor='#ff3311'>";
          $issueOutput .= "<td>Passive</td>";
        }

      //$issueOutput .= "id: " . $key;
      $issueOutput .= "<td>" . $data[$key]['title'] . "</td>";
      $issueOutput .= "<td>" . $data[$key]['discountRate'] . "</td>";
      $issueOutput .= "<td>%" . ($data[$key]['description']*100) . "</td>";
      
      if(isset($data[$key]['isActive'])){
        $issueOutput .= "<td><a href=?promoState=true&changePromoStatus=" . $key . ">Make Passive</a></td>";
      }
      else{
        $issueOutput .= "<td><a href=?promoState=false&changePromoStatus=" . $key . ">Make Active</a></td>";
      }

      $issueOutput .= "</tr>";

      if($data[$key]['isActive'] == "true"){
        $openData .= $issueOutput;
      }
      else{
        $closedData .= $issueOutput;
      }
    }
    $openData .= "</table>";
    $closedData .= "</table>";

    return ($openData . "<hr>" . $closedData);
  }


  public function getNodeCurl($requestingNode){
        $this->curlHandler = curl_init($this->url . "/" . $requestingNode);
    curl_setopt($this->curlHandler, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($this->curlHandler, CURLOPT_SSL_VERIFYPEER,false);
    $result = curl_exec($this->curlHandler);
    curl_close($this->curlHandler);
	return $result;
  }
    public function updateNodeCurl($updatingNode, $value){
    $data_json = json_encode($value);
$ch = curl_init();
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER,false);
curl_setopt($ch, CURLOPT_URL, $this->url . $updatingNode);
curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json','Content-Length: ' . strlen($data_json)));
curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
curl_setopt($ch, CURLOPT_POSTFIELDS,$data_json);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$result  = curl_exec($ch);
curl_close($ch);
return $result;
  }



}


?>
