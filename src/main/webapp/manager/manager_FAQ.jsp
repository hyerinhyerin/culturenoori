<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.FaqDAO, dto.FaqDTO" %>   
<%@ page import="java.util.List" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // POST 요청으로부터 데이터 가져오기
//     String faqIdParam = request.getParameter("faqId");
//     String comment = request.getParameter("faqComment");

//     // 유효성 검사
//     if (faqIdParam != null && !faqIdParam.isEmpty() && comment != null && !comment.isEmpty()) {
//         int faqId = Integer.parseInt(faqIdParam);

//         // FaqDAO 인스턴스 생성 및 답변 저장 메서드 호출
//         FaqDAO faqDao = new FaqDAO();
//         faqDao.updateFaqAnswer(faqId, comment);
        
//         // 답변 후 완료 페이지로 리다이렉트
//         response.sendRedirect("newFAQ.jsp");
//         return; // 리다이렉트 후 코드 실행 중지
//     }
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
	<link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
    />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <link rel="stylesheet" href="../resources/css/common.css" />
    <link rel="stylesheet" href="../resources/css/header.css" />
    <link rel="stylesheet" href="../resources/css/footer.css" />
    <link rel="stylesheet" href="../resources/css/manager_common.css" />
<!--     <link rel="stylesheet" href="../resources/css/manager_report.css" /> -->
    <link rel="stylesheet" href="../resources/css/manager_FAQ.css" />
</head>
<body>



    <%@include file="/common/side_background.jsp" %>
    <%@include file="/common/header.jsp" %>
    <%@include file="../common/popupInput.jsp"%>
    
    <div class="container">
    <section>
        <div id="section-container">

          <div class="section-body">
            <!-- 유저의 메뉴 -->
            <div id="section-sidemenu">
              <div class="sidemenu-container-faq">
                <a href="./manager_report.jsp">
                	신고 관리
                </a>
                <a href="./manager_FAQ.jsp" style="text-decoration: underline">
                	문의 관리 >
               	</a>
              </div>
            </div>
            <div id="section-content">
              <ul class="tabnav">
                <li class="tab-link current" data-tab="newFAQ">신규 문의</li>
                <li class="tab-link" data-tab="completeFAQ">완료 문의</li>
              </ul>
              

              <!-- 신규 문의 -->
              <div id="tab-content" class="tab-content-faq current">
                <jsp:include page="newFAQ.jsp" />
                
              </div>

              <!-- 완료된 문의 -->
              <div id="tab-content" class="tab-content-faq">
                <jsp:include page="completeFAQ.jsp" />
                 
         
              </div>
              

              <!-- 신규 신고 본문 -->
<!--               <div id="tab-content" class="tab-content current"> -->
<!--               </div> -->
            </div>
          </div>
        </div>
      </section>
    <%@include file="/common/footer.jsp" %>
    </div>
    
    
    <script src="../resources/js/manager_FAQ.js"></script>
</body>
</html>