<html>
<head>
	<title>iFlat Management Panel - Main Page</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<link rel="stylesheet" href="css/mainStyle.css">


</head>
<body>

<div class="flex-container">
<header>
  <h1>iFlat Management Panel</h1>
</header>

<nav class="nav">
	<strong>Menu</strong>
	<hr>
<ul>
  <li><a href="?route=issue">Issue Management</a></li>
  <li><a href="?route=promo">Promotion Management</a></li>
  <li><a href="?route=uman">User Management</a></li>
</ul>
<hr>
<div class="quickstart-user-details-container">
	Logged user :
	<pre><code id="quickstart-account-details"><?php echo $_SESSION['login']['mail']; ?></code></pre>
</div>
<a href="?logout=true"><button class="mdl-button mdl-js-button mdl-button--raised" id="quickstart-sign-in" name="signin">Sign Out</button></a>
</nav>

<article class="article">
  <h1><?php echo $pageTitle; ?></h1>
  <p><strong><?php echo $pageSubTitle; ?></strong></p>
  <p><?php echo $data; ?></p>
</article>

<footer>iFlat</footer>
</div>

</body>
</html>
