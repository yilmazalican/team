<?php
include_once 'auth.php';
include_once 'curl.php';

if(isset($_GET['logout'])){
  $auth = new auth();
  $auth->logout();
}

if(isset($_SESSION['login'])){
$curl = new curl();
if($_GET['route'] === "issue"){
  $pageTitle = "Issue Management";
  $pageSubTitle = "Listing Issues<hr>";
  $data = $curl->getIssues();
}else if($_GET['route'] === "promo"){
  $pageTitle = "Promotion Management";
  $pageSubTitle = "Listing Promotions<hr>";
  $data = $curl->getPromotions();
}else if($_GET['route'] === "uman"){
$pageTitle = "User Management";
  $pageSubTitle = "Listing Users<hr>";
  $data = $curl->getUsers();
}else if(isset($_GET['promoState'])&&isset($_GET['changePromoStatus'])){
	$curl->changeStatusOfPromo($_GET['changePromoStatus'], $_GET['promoState']);
  $pageTitle = "Promotion Management";
  $pageSubTitle = "Listing Promotions<hr>";
  $data = $curl->getPromotions();
}
else if(isset($_GET['userState'])&&isset($_GET['changeUserStatus'])){
	$curl->changeStatusOfUser($_GET['changeUserStatus'], $_GET['userState']);
  $pageTitle = "User Management";
  $pageSubTitle = "Listing Users<hr>";
  $data = $curl->getUsers();
}
else if($_GET['route'] === "addPromo"){
  $pageTitle = "Promotion Management";
  $pageSubTitle = "Add Promotion<hr>";
  $data = $curl->addPromotionForm();
  if(isset($_POST['promoTitle'])&&isset($_POST['promoRatio'])&&isset($_POST['promoDesc'])){
  $pageTitle = "Promotion Management";
  $pageSubTitle = "Added Promotion<hr>";
  $data = $curl->addPromotion($_POST['promoTitle'], $_POST['promoRatio'], $_POST['promoDesc']);
}
}

else if(isset($_GET['iid'])){
  $pageTitle = "Issue Closing";
  $pageSubTitle = "Write answer to issue";
  $data = $curl->closeIssueForm($_GET['iid']);
  if(isset($_POST['answertext'])&&isset($_POST['iid'])){
	  $pageTitle = "Issue Closing Result";
	$pageSubTitle = "Issue closed and the answer is,";
	$data = $curl->closeIssue($_POST['iid'], $_POST['answertext']);
}
}
require_once("template/mainTemplate.php");

}

 ?>
