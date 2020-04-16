<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@	page import="javax.sql.*"%>
<%@	page import="javax.naming.*"%>
<%@	page import="java.util.*"%>

<%
	request.setCharacterEncoding("UTF-8");
	String emp_num = request.getParameter("emp_num");

	Connection con = null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = DriverManager.getConnection("jdbc:oracle:thin:@waglewagle.net:15212/orcl", "kinfox", "tiger1");

	Emp emp = getEmp(con, emp_num);

	String msg = "";
	String empname = "";
	String listbook_before = "";
	String listbook_after  = "";
	String co = "";
	String survey_yn = "";
	String list_set_end ="";
	int co_num = 0;

	
	 if(emp == null){%>
		<script>alert("존재하지 않는 사번입니다."); window.history.back(); </script>
		<%
		
		//RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		//rd.forward(request,response);
		
	}else{
		empname   = emp.getEmpname();	
		co        = emp.getCo_author();
		survey_yn = emp.getSurvey_yn();
		co_num    = Integer.parseInt(co);
		
		if(survey_yn == "Y"){%>
		<script>alert("이미 평가에 참여하셨습니다."); window.history.back(); </script>
		<%}	


		listbook_before = listBook(con, emp_num, "tb_book_coauthor_before");
		listbook_after = listBook(con, emp_num, "tb_book_coauthor_after");

			
	}
	con.close();
%>
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
<form action="book_evaluation_page_end(new).jsp" method="post">





<% switch (co_num) {
	case 0:%>
		<%=Listset(1, listbook_before)%>
		<%break;
		
	case 1:%>
		<%=Listset(1, listbook_before)%>
		<%=Listset(2, listbook_after)%>
		<%break;
		}%>
	<%=Listset_end(co_num)%>	
	
		







<input type="hidden" name="co_num" value="<%=co%>">
<input type="hidden" name="emp_num" value="<%=emp_num%>">
</form>
</body>
</html>




<%!
/*  Get emp info. */
public static Emp getEmp(Connection con, String emp_num) throws SQLException {

	String empno = "";
	String empname = "";
	String co_author = "";
	String survey_yn = "";

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	Emp emp = null;

	StringBuffer sb = new StringBuffer();

	sb.append(" SELECT empno, ");		//sql 선언문
	sb.append("        empname, ");
	sb.append("		   co_author,");
	sb.append("        survey_yn ");
	sb.append(" FROM   tb_emp " );
	sb.append(" WHERE  empno = ? ");

	pstmt = con.prepareStatement(sb.toString());	
	pstmt.setString(1, emp_num);

	rs = pstmt.executeQuery();

	if (rs.next()) {
		empno     = rs.getString("empno");
		empname   = rs.getString("empname");
		co_author = rs.getString("co_author");
		survey_yn = rs.getString("survey_yn");

		emp = new Emp(empno, empname, co_author, survey_yn);
	}

	rs.close();
	pstmt.close();

	return emp;
}
/*
 * Emp Class
 * 
 */
public static class Emp{
	String empno;
	String empname;
	String co_author;
	String survey_yn;
	
	public Emp(String empno, String empname, String co_author, String survey_yn) {
		super();
		this.empno = empno;
		this.empname = empname;
		this.co_author = co_author;
		this.survey_yn = survey_yn;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getEmpname() {
		return empname;
	}
	public void setEmpname(String empname) {
		this.empname = empname;
	}
	public String getCo_author() {
		return co_author;
	}
	public void setCo_author(String co_author) {
		this.co_author = co_author;
	}
	public String getSurvey_yn() {
		return survey_yn;
	}
	public void setSurvey_yn(String survey_yn) {
		this.survey_yn = survey_yn;
	}
}
public static String listBook(Connection con, String emp_num, String table_name) throws SQLException {
	String title = "";		//책제목
	String author = "";		//저자
	String cn = "";			//제어번호
	int    rating = 0;
	String url = "https://www.google.com/search?tbm=bks&q=";		//자세히 보기 기능을 위한 URL 
	String list = "";

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int i = 0;

	StringBuffer sb = new StringBuffer();

	sb.append(" SELECT empno, ");		//sql 선언문
	sb.append("        empname, ");
	sb.append("        regno, ");
	sb.append("        cn, ");
	sb.append("        title, ");
	sb.append("        author, ");
	sb.append("        available, ");
	sb.append("		   co_author,");
	sb.append("        prediction, ");
	sb.append("        rating ");
	sb.append(" FROM   " + table_name);
	sb.append(" WHERE  empno = ? ");

	pstmt = con.prepareStatement(sb.toString());	
	pstmt.setString(1, emp_num);

	rs = pstmt.executeQuery();
	
	if(table_name.equals("tb_book_coauthor_after")) i = 5;

	int j = 1;
	while (rs.next()) {
		title  = rs.getString("title");		//책 이름 tile에 저장
		author = rs.getString("author");	//저자명 author에 저장
		cn     = rs.getString("cn");		//제어번호 cn에 저장
		rating = rs.getInt("rating");	//평가 값 rating에 저장

		i++;

		list += "<tr><td class=\"text-center\">" + j + "</td>\n";
		list += "    <td class=\"text-left\" ><input type=\"hidden\" value=\"" + cn + "\" name=\"cn\">" + title + "<br>저자:" + author + "<a href=\"" + url + title + "\" target=\"_blank\">[Google 검색]</a></td>\n";
		list += "    <td class=\"text-center\"><input type=\"radio\" name=\"rating" + i	+ "\" value=\"1\"></td>\n";
		list += "    <td class=\"text-center\"><input type=\"radio\" name=\"rating" + i	+ "\" value=\"2\"></td>\n";
		list += "    <td class=\"text-center\"><input type=\"radio\" name=\"rating" + i	+ "\" value=\"3\"></td>\n";
		list += "    <td class=\"text-center\"><input type=\"radio\" name=\"rating" + i	+ "\" value=\"4\"></td>\n";
		list += "    <td class=\"text-center\"><input type=\"radio\" name=\"rating" + i	+ "\" value=\"5\"></td>\n";
		list += "</tr>\n";
		j++;
	}

	rs.close();		//닫기
	pstmt.close();

	return list;
}

public static String Listset(int list_number, String listbook_table) {
	
	String list_set ="";
	list_set += "<div class=\"row wrapper\">\n";
	list_set += "	<div class=\"col-lg-1\">\n";
	list_set += "	</div>\n";
	list_set += "	<div  class=\"col-lg-10\" id=\"header\">\n";
	list_set += "		<h2>추천 도서 만족도 평가</h2>\n";
	list_set += "		추천된 도서 목록의 만족도 점수를 평가해 주세요.\n";
	list_set += "	</div>\n";
	list_set += "	<div class=\"col-lg-1\">\n";
	list_set += "	</div>\n";
	list_set += "</div>\n";
	list_set += "<div class=\"row wrapper\">\n";
	list_set += "	<div class=\"col-lg-1\">\n";
	list_set += "	</div>\n";
	list_set += "	<div class=\"col-lg-10\" id=\"content\">\n";
	list_set += "		<pre><strong> 도서 추천 목록 " + list_number + "</strong></pre>\n";
	list_set += "	</div>\n";
	list_set += "	<div class=\"col-lg-1\">\n";
	list_set += "	</div>\n";
	list_set += "</div>\n";
	list_set += "<div class=\"row wrapper\">\n";
	list_set += "	<div class=\"col-lg-1\">\n";
	list_set += "	</div>\n";
	list_set += "	<div class=\"col-lg-10\" id=\"content\">\n";
	list_set += "		<table class=\"table table-data\">\n";
	list_set += "			<tr>\n";
	list_set += "				<th class=\"topside\">번호</th>\n";
	list_set += "				<th class=\"top\">제목</th>\n";
	list_set += "				<th class=\"top\">매우<br>읽고<br>싶지<br>않음</th>\n";
	list_set += "				<th class=\"top\">읽고<br>싶지<br>않음</th>\n";
	list_set += "				<th class=\"top\">보통</th>\n";
	list_set += "				<th class=\"top\">읽고<br>싶음</th>\n";
	list_set += "				<th class=\"top\">매우<br>읽고<br>싶음</th>\n";
	list_set += "			</tr>" + listbook_table + "\n";
	list_set += "		</table>\n";
	list_set += "	</div>\n";
	list_set += "	<div class=\"col-lg-1\">\n";
	list_set += "	</div>\n";
	list_set += "</div>\n";
	
	
return list_set;

}


public static String Listset_end(int co_) {
		 String list_set_end ="";

		 list_set_end +="<div class=\"row wrapper\">\n";
		 list_set_end +="	<div class=\"col-lg-1\">\n";
		 list_set_end +="	</div>\n";
		 
		 if (co_ == 1){
		 list_set_end +="	<div class=\"col-lg-10\" id=\"content\">\n";
		 list_set_end +="		질문 1. '도서 추천 목록 1'과 '도서 추천 목록 2' 중에서 어떤 목록이 더 읽고 싶은 도서를 추천해주나요? <br>\n";
		 
		 
				 
		 list_set_end +="		<br>\n";
		 list_set_end +="		<div class=\"col-lg-3\">\n";
		 list_set_end +="			<input type=\"radio\" name=\"best\" value=\"리스트1\"> 도서 추천 목록 1\n";
		 list_set_end +="		</div>";
		 list_set_end +="		<div class=\"col-lg-7\">\n";
		 list_set_end +="		</div>";
		 list_set_end +="		<div class=\"col-lg-3\">\n";
		 list_set_end +="			<input type=\"radio\" name=\"best\" value=\"리스트2\"> 도서 추천 목록 2\n";
		 list_set_end +="		</div>";
		 list_set_end +="		<div class=\"col-lg-7\">\n";
		 list_set_end +="		</div>";
		 list_set_end +="	</div>";
		 list_set_end +="	<div class=\"col-lg-1\">\n";
		 list_set_end +="	</div>\n";


		 }
		 list_set_end +="	<div class=\"col-lg-4\">\n";
		 list_set_end +="	</div>\n";
		 list_set_end +="	<div class=\"col-lg-5\">\n";
		 list_set_end +="		체크하지 않은 항목이 있는지 확인해 주시고 제출해 주세요.\n";
		 list_set_end +="		<button class=\"btn btn-success\"> 제출 </button>\n";
		 list_set_end +="	</div>\n";
		 list_set_end +="	<div class=\"col-lg-3\">\n";
		 list_set_end +="	</div>\n";
		 list_set_end +="	</div>\n";
		 list_set_end +="</div>\n";
		 
	return list_set_end;
}

%>
