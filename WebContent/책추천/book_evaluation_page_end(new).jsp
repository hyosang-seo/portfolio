<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@	page import="javax.sql.*"%>
<%@	page import="javax.naming.*"%>
<%@	page import="java.util.*"%>


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
<title>도서 추천 결과 평가</title>

</head>
<body>

	<%
		//------------------------------------------------------------------------DB 연결하기-----------------------------------------------------------------------------
		request.setCharacterEncoding("UTF-8"); 	//UTF-8로 인코딩

		Connection con = null;		//연결하기 기능을 사용하기 위해 클래스 변수로 저장
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con = DriverManager.getConnection("jdbc:oracle:thin:@waglewagle.net:15212/orcl", "kinfox", "tiger1"); 	//DB주소

		//------------------------------------------------------------------------변수명 : 변수 값 받기 ---------------------------------------------------------------------

		String emp_num = request.getParameter("emp_num");		//사번 Post로 받기(주소창에 개인정보 출력 -get 방지)
		String best_list = request.getParameter("best");		//선호하는 리스트 Post로 받기
		String co = request.getParameter("co_num");		//공저자 유무 Post로 받기
		String[] cns = request.getParameterValues("cn"); 	//제어번호 불러오기
		List<String> ratings = new ArrayList<String>(); 	//ratings 배열 만들기  --------------------------1
		Enumeration e = request.getParameterNames(); 	//Enumeration으로 이름 값 배열 저장  

		while (e.hasMoreElements()) {	 //다음 변수가 있다면
			String name = (String) e.nextElement();		//그 변수 명  name으로 받기
			String[] values = request.getParameterValues(name);		//모든 변수 값(value) 배열(values)로 받기

			for (String value : values) {
				if (name.startsWith("rating")) {	 //naem(변수 명)이 rating로 시작하면    
					ratings.add(value); //ratings(1 참고 )에 순서대로 추가
					//out.println(rating);
				}

			} 	//rating_i값을 평가순서대로 
				//cns	   		= [ 순, 서, 대, 로, ...] 
				//ratings 		= [value, value, ...]	
				//저장!
		}
		//---------------------------------------------------------저장하기 함수 선언----------------------------------------------------------------------------------
	%>
	
	
	<%!// Update Book Table by.shin  //공저자 추가 전, 추가 후 각각 따로 쓰기 위해 테이블 명 추가 by.hs
	public synchronized void updateBook(Connection con, String emp_num, String[] cns, List<String> ratings, String table_name, String best_list) throws SQLException {	
		StringBuffer sb = new StringBuffer();
		PreparedStatement pstmt = null;

		sb.append(" UPDATE   " + table_name);
		sb.append(" SET    rating = ?, ");
		sb.append("        best = ? ");
		sb.append(" WHERE  empno = ? AND ");
		sb.append("        cn = ? ");

		pstmt = con.prepareStatement(sb.toString());

		int i = 0;

		for (String rating : ratings) {
			pstmt.setString(1, rating);
			pstmt.setString(2, best_list);
			pstmt.setString(3, emp_num);
			pstmt.setString(4, cns[i]);

			pstmt.executeUpdate();
			i++;
		}

		pstmt.close();

	}%>
	
	<%!// Update Emp servay 완료
	
	public void setEmp(Connection con, String emp_num) throws SQLException {
			StringBuffer sb = new StringBuffer();
			PreparedStatement pstmt = null;
	
			sb.append(" UPDATE tb_emp");
			sb.append(" SET    survey_yn = ?");
			sb.append(" WHERE  empno = ?");
	
	
			pstmt = con.prepareStatement(sb.toString());
	
			pstmt.setString(1, "Y");
			pstmt.setString(2, emp_num);
			pstmt.executeUpdate();
	
			pstmt.close();
	
		}
		%>
	

	<%
		//--------------------------------------------------------------공저자가 있으면 2번째 리스트도 db에 업데이트 by.hs----------------------------------------------
		switch (co) {
		case "0":		//co = 0이면 공저자 없는 경우
			updateBook(con, emp_num, cns, ratings, "tb_book_coauthor_before", best_list);		//DB "공저자 추가 전"에 평가 값(rating : value)저장
			setEmp(con, emp_num);		//DB 설문조사 완료 값 넣기			
			break;
		case "1":		//co = 1이면 공저자 있는 경우
			updateBook(con, emp_num, cns, ratings, "tb_book_coauthor_before", best_list);		//DB "공저자 추가 전"에 평가 값(rating : value)저장
			updateBook(con, emp_num, cns, ratings, "tb_book_coauthor_after", best_list);		//DB "공저자 추가 후"에 평가 값(rating : value)저장
			setEmp(con, emp_num);		//DB 설문조사 완료 값 넣기				
			break;
		}

		//----------------------------------------------평가에 참여해 주셔서 감사합니다.-------------------------------------------------------------------------------
	%>

<body>


	<div class="containter">
		<div class="row wrapper">
			<div class="col-lg-6"></div>
			<br> <br> <br> <br> <br> <br>
			<h1 style="text-align: center">평가에 참여해 주셔서 감사합니다.</h1>
		</div>
	</div>
</body>
</html>

