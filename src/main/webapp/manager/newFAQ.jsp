

<%@page import="dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="dao.FaqDAO, dto.FaqDTO"%>
<%@ page import="java.util.List"%>




<!-- /////////////////////////////////////////////////////////// -->
<!-- /////////////////////////////////////////////////////////// -->
<!-- /////////////////////////////////////////////////////////// -->
  
<style>
@charset "UTF-8";

/* 신규 문의 본문 | 완료 문의 본문 */
div.newFAQitem, div.completeFAQitem {
	position: relative;
}

/* 문의 div 윗부분 */
div.FAQitem-top {
	display: flex;
	justify-content: space-between;
	padding: 30px;
	margin: 10px 10px 0px 10px;
	background-color: rgb(231, 231, 231);
	border-top: 2px solid #4e92f1;
	border-bottom: 2px solid #4e92f1;
}

/* 문의자와 날짜를 25%로 설정 */
div.FAQnick-wrapper {
	width: 25%;
	text-align: left;
}
div.FAQnick-wrapper h3, h4{
	margin:0;
	display:inline;
}
div.FAQTitleContent {
	width: 50%;
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
	font-size: 16px;
	margin-top: 10px;
}
div.FAQTitleContent p.FAQContent h4 {
	margin-bottom:10px;
	display:inline;
}



</style>
<!-- /////////////////////////////////////////////////////////// -->
<!-- /////////////////////////////////////////////////////////// -->
<!-- /////////////////////////////////////////////////////////// -->
 
 
 
 
<%
FaqDAO faqDAO = new FaqDAO();
List<FaqDTO> newFaqs = faqDAO.getNewFaqs();
System.out.println("Fetched new FAQs: " + newFaqs); // 데이터 확인
%>

<%
if (newFaqs == null || newFaqs.isEmpty()) {
%>
<p>신규 문의가 없습니다.</p>
<%
} else {
for (FaqDTO faq : newFaqs) {
	UserDAO userdao = new UserDAO();
	String nickkname = userdao.findNicknameByEmail(faq.getUserEmail());
	userdao.close();
%>
<div class="faq-list">
	<div class="newFAQitem">
		<div class="FAQitem-top" style="background-color:rgb(231,231,231);">
		
			<div class="FAQnick-wrapper">
				<p class="FAQnick"><h3>작성자 : </h3><%=nickkname%></p>
				
			</div>
			
			<div class="FAQTitleContent">
				<p class="FAQTitle">
					<h3 style="margin-bottom:5px;">제목 : <%=faq.getTitle()%></h3>
				</p>
				<p class="FAQContent"><h4>내용 : <%=faq.getContents()%></h4></p>
				<p class="FAQDate" style="margin-top : 20px;">작성일 : <%=faq.getDate().substring(0, 10)%></p>
			</div>
			<div>
				<p><button class="cn-btn cn-btn-left" onclick="registAnswer(<%=faq.getId()%>)">답변 등록</button></p>
			</div>
			
		</div>
	</div>
</div>
<%
}
}
%>

<script type="text/javascript">
	function registAnswer(faqId) {
		console.log('faqId : ', faqId);
		
		openPopupInput({
			title : '관리자에게 문의하기',
			placeholder : '문의하실 내용을 적어주세요',
			onConfirm : function(content) {
				console.log('확인 클릭:', content);
				$.ajax({
					type: "POST",
					url: "./getAnswerFaq.jsp",
					data: {
						faqId: faqId,
						faqComment: content
					},
					dataType: 'json',
					success: function(res) {
						if (res.result) {
							console.log('문의등록 성공');
							window.location.href = "./manager_FAQ.jsp";
						} else {
							alert("문의등록에 실패했습니다.");
							// 임시
							window.location.href = "./manager_FAQ.jsp";
						}
					},
					error: function() {
						console.log('에러가 발생했습니다. 다시 시도해 주세요.');
						// 임시
						window.location.href = "./manager_FAQ.jsp";
// 						alert("에러가 발생했습니다. 다시 시도해 주세요.");
					}
				});				
			},
			onCancel : function() {
				console.log('팝업 닫기 취소');
			}
		});
		
	}
</script>

 
 
 
 
 
  