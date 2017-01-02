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
if(isset($_GET['iid'])){
  $pageTitle = "Issue Closing";
  $pageSubTitle = "Write answer to issue";
  $data = $curl->closeIssueForm($_GET['iid']);
}

if(isset($_POST['answertext'])&&isset($_POST['iid'])){
	  $pageTitle = "Issue Closing Result";
	$pageSubTitle = "Issue closed and the answer is,";
	$data = $curl->closeIssue($_POST['iid'], $_POST['answertext']);
}
require_once("template/mainTemplate.php");

}

 ?>
