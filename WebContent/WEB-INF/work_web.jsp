<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" url="img/icons8-laptop-64.png"arr5>

<!-- HTML4 규약을 따른다. -->
<link rel=”profile” href=”https://gmpg.org/xfn/11“>

<!-- font : kopubdotum -->
<link href="https://cdn.jsdelivr.net/font-kopub/1.0/kopubdotum.css">

<title>Hyosang | Developer</title>

<style>

body {
	
	font-family  : 'kopubdotum', sans-serif;
	margin-top   : 40px;
	margin-left  : 80px;
	margin-right : 80px;
	margin-bottom: 40px;
}

.boundary{

	margin-left  : 100px;
	margin-right : 100px;
}

.flex{

	display : flex;
	justify-content : space-around;
}
 
.bold {

	font-weight: bolder;
}

ul {

	list-style: none;
}

.nav_word {

	color: black;
	text-decoration: none;
}

.left_align {
	float : left;
}

.right_align {
	float : right;
}
.inline{
	display : inline;
}
.min-height{
	align-items: center;
}
.margin_mid{
	margin : 100px 200px;
}

</style>
</head>

<body>

	<div class = boundary>
	<header>
		<div class = 'flex'>
			<div class = ' left_align' id = "header" >
				<span class ='bold right' style="font-size: 40px;"> <a class="nav_word right" id="bold" href= index.jsp>Hyosang Seo</a> </span><br>
				<span >Junior Developer</span>
			</div>
			
	
			<nav>
				<ul class = 'flex right_align bold'>
					<li><a class="nav_word right" id="bold" href= worb_wep.jsp>Works &nbsp; </a></li>
					<li><a class="nav_word right" id="bold" href= about_wep.jsp>About &nbsp;</a></li>
					<li><a class="nav_word right" id="bold" href= experience_web.jsp>Experience &nbsp;</a></li>
					<li><a class="nav_word right" id="bold" href= contact_web_jsp#>Contact &nbsp; </a></li>
				</ul>
			</nav>
			
		</div>
	</header>

	<main  style = 'min-height : 400px;'>
	<div class = 'margin_mid'>
	 <span style = 'font-size : 40px;'>준비중</span>
	</div>
	
	</main>

	<footer>
	<div class = 'flex'> 
	<div class = 'left_align'> Python | Java | JavaScript | JSP | CSS | HTML | SQL </div>
	<div class = 'right_align bold'>contact me  &nbsp; <a href = #><img src = 'img/mail_icon.jpg'  width ='15px'></a>
	</div>
</div>
	</footer>
	</div>
</body>
</html>