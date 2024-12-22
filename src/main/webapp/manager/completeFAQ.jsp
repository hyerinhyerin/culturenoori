<%@page import="dao.UserDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List"%>
<%@ page import="dao.FaqDAO, dto.FaqDTO"%>

<%
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>

<%
FaqDAO faqDAO = new FaqDAO();
//완료된 문의 가져오기 
List<FaqDTO> completedFaqs = faqDAO.getCompletedFaqs();

// completedFaqs를 request에 저장
request.setAttribute("completedFaqs", completedFaqs);
%>

<!-- /////////////////////////////////////////////////////////////// -->
<!-- /////////////////////////////////////////////////////////////// -->
<style>
@charset "UTF-8";

/* 신규 문의 본문 | 완료 문의 본문 */
div.div.completeFAQitem {
	position: relative;
}

/* 문의 div 윗부분 */
div.FAQitem-top {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	padding: 30px;
	margin: 10px 10px 0px 10px;
	background-color: rgb(231, 231, 231);
	border-top: 2px solid #4e92f1;
	border-bottom: 1px solid #4e92f1;
}
/* 문의자와 날짜를 25%로 설정 */
div.FAQnick-wrapper {
	width: 25%;
	text-align: left;
}
div.FAQTitleContent {
	width: 75%;
	display: flex;
	flex-direction: column;
}


div.FAQnick-wrapper p.FAQnick {
	font-size: 15px;
	font-weight: bold;
}

div.FAQnick-wrapper p.FAQDate {
	font-size: 15px;
	color: #808080;
	margin-top: 5px;
}


div.FAQTitleContent p.FAQTitle {
	font-size: 20px;
	font-weight: bold;
}

div.FAQTitleContent p.FAQContent {
	font-size: 20px;
	margin-top: 10px;
}



/* 문의 div 아래쪽 */
div.FAQitem-bottom {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	padding: 30px;
	margin: 0px 10px 0px 10px;
	background-color: rgb(231, 231, 231);
/* 	border-top: 1px solid #4e92f1; */
	border-bottom: 2px solid #4e92f1;
}

</style>
<!-- /////////////////////////////////////////////////////////////// -->
<!-- /////////////////////////////////////////////////////////////// -->


<%
//완료된 문의가 없는지 체크 
if (completedFaqs == null || completedFaqs.isEmpty()) {
%>
<p>완료된 문의가 없습니다.</p>
<%
} else {
System.out.println("완료된 문의 리스트: " + completedFaqs);
//완료된 문의 목록 출력 
UserDAO userdao = new UserDAO();

for (FaqDTO faq : completedFaqs) {
	String nickkname = userdao.findNicknameByEmail(faq.getUserEmail());
%>
<div class="completedFAQitem">

	<div class="FAQitem-top">
	
		<div class="FAQnick-wrapper">
			<p class="FAQnick" style="padding-bottom:10px;">작성자 : <%=nickkname%></p>
			<p class="FAQDate"><%=faq.getDate().toString().substring(0, 10)%></p>
			
		</div>
		
		<div class="FAQTitleContent">
			<p class="FAQTitle" style="padding-bottom:10px;">제목 : <%=faq.getTitle()%></p>
			<h4 class="FAQContent">내용 : <%=faq.getContents()%></h4>
		</div>
		
	</div>
	
	<div class="FAQitem-bottom">
	<img class="faq_icon" src="../resources/image/FAQ_icon.png" alt="문의답변" />
		<div class="FAQnick-wrapper">
			<p class="FAQCommentDate" style="padding-top:7px;"><%=faq.getComDate().toString().substring(0, 10)%></p>
		</div>
		<div class="FAQTitleContent">
			<p class="FAQComment">ㄴ 답변 : <%=faq.getComment()%></p>
		</div>
	</div>
	
</div>
<%
}
userdao.close();
}
%>







