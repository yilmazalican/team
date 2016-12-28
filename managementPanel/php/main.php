<?php
include_once 'auth.php';
include_once 'curl.php';

if($_GET['logout']){
  $auth = new auth();
  $auth->logout();
}

if(isset($_SESSION['login'])){
$curl = new curl();
if($_GET['route'] === "issue"){
  $pageTitle = "Issue Management";
  $pageSubTitle = "Listing Issues";
  $data = $curl->getIssues();
}
require_once('template/mainTemplate.php');

}

 ?>
