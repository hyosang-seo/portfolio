<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">

<link rel="stylesheet" type="text/css" href="/ks/jquery/toastr/toastr.min.css">
<link rel="stylesheet" type="text/css" href="/ks/jquery/sweetalert/sweetalert.css">

<link rel="stylesheet" type="text/css" href="/ks/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/ks/css/bootstrap-helper.css">
<link rel="stylesheet" type="text/css" href="/ks/css/font-awesome.min.css">

<link rel="stylesheet" type="text/css" href="/ks/css/daum.css">
<link rel="stylesheet" type="text/css" href="/ks/css/style.css">
<link rel="stylesheet" type="text/css" href="/ks/css/animate.css">
<link rel="stylesheet" type="text/css" href="/ks/css/helper.css">
<link rel="stylesheet" type="text/css" href="/ks/css/base.css">

<link rel="stylesheet" type="text/css" href="/ks/css/bootstrap-24-grid.css">
<link rel="stylesheet" type="text/css" href="/ks/css/bootstrap-helper.css">
<style type="text/css">
body {
	padding-top: 10px;
	padding-left: 20px;
	padding-right: 20px;
	background: white !important;
}

</style>

<title>도서추천시스템_평가_intro</title>
</head>
<body>
	<center>
		<div class="containter">
			<div class="row wrapper">
				<div class="col-lg-3"></div>
				<div class="col-lg-6">

					<h2 style="text-align: center">
						2020 KISTI 도서추천시스템 평가<br> <br>
					</h2>
				</div>
				<div class="col-lg-3"></div>
			</div>

			<div class="row wrapper">
				<div class="col-lg-4"></div>
				<div class="col-lg-4"style="border: 1px dashed #BDBDBD; width: 550px; margin-left: auto; margin-right: auto; padding: 20px; text-align: left; line-height: 20px; vertical-align: middle;">
					<p>안녕하세요.</p>

					<p>KISTI 열람실에서는 원내 이용자에게 보다 적극적인 이용자 서비스를<br> 제공하기 위해 도서 추천 시스템을
						구축하고자 합니다.</p>
					
					<p>해당 시스템은 이용자의 대출이력 및 이용자 간 유사도를 구하는 <br>알고리즘을 이용하여 적합한 도서를 추천해주는 방식입니다.</p>

					<p>실제 이용자의 평가 및 의견을 듣고자 테스트 페이지를 구축하였습니다. <br> 다음 페이지에서 나타나는 추천
						도서 목록의 만족도 점수를 체크해주시면 감사하겠습니다.<br> <strong>(매우 읽고 싶지 않음/읽고 싶지 않음 /보통/읽고 싶음/ 매우 읽고 싶음)</strong>
					</p>
					<p>
						기타 문의사항은 콘텐츠큐레이션센터 정민경(내선 1758)으로 연락주시기 바랍니다.<br>
					</p>
				</div>
				<div class="col-lg-4">
				</div>
			</div>
			
			<div class="row wrapper">
				<div class="col-lg-3">
				</div>
				<div class="col-lg-6">
					<form action="book_evaluation_page(new).jsp" method="post">
						<div class="form-group mx-sm-3 mb-2">
						<br>
							<label for="empno" class="sr-only">사원번호</label>
							 <input	type="text" id="emp_num" placeholder="사원번호" name="emp_num">
						</div>
						<button type="submit" class="btn btn-primary mb-2">평가 시작하기</button>
					</form>
				</div>
				<div class="col-lg-3">
				</div>
			</div>
		</div>
	</center>

</body>
</html>