<?php
	error_reporting(0);
  include 'php/curl.php';
  include_once 'php/auth.php';

  //$curl = new curl();
  //$curl->deneme();
session_start();
if(!isset($_SESSION['login'])){
$auth = new auth();
//$auth->logout();
  //$auth->login("erEn.ay@isik.edu.tr","123");
echo  $auth->loginForm();
}else{
  require_once('php/main.php');
}
?>
