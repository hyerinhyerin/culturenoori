<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <link rel="stylesheet" href="../resources/css/manager_report.css" />
    <link rel="stylesheet" href="../resources/css/manager_FAQ.css" />


<style type="text/css">

/* 본문 컨테이너 */
div.section-body{
    display: flex;
    width:84vw;
    margin: 0 auto;
    height: auto;
    align-items: center;
    justify-content: space-between;
}
/* 사이드 메뉴 */
div#section-sidemenu{
    position: relative;
    display: inline-block;
    width: 450px;
    height: 500px;
}
/* 본문 컨텐츠 */
div#section-content{
    position: relative;
    display: inline-block;
    width: 750px;
    height: auto;
    min-height: 550px;
    margin-left: 16%;
    margin-top: 6%;
}

</style>
    
    
</head>
<body>
		<%@include file="/common/side_background.jsp"%>
    <%@include file="/common/header.jsp" %>
		<%@include file="../common/popupInput.jsp"%>
    <div class="container">
    <section>
        <div id="section-container">

          <div class="section-body">
            <!-- 유저의 메뉴 -->
            <div id="section-sidemenu">
              <div class="sidemenu-container">
                <a href="./manager_report.jsp" style="text-decoration: underline">신고 관리 ></a>
                <a href="./manager_FAQ.jsp">문의 관리</a>
              </div>
            </div>
            <div id="section-content">
              <ul class="tabnav">
                <li class="tab-link current" data-tab="newReport">신규 신고</li>
                <li class="tab-link" data-tab="completeReport">처리 신고</li>
              </ul>

              <!-- 신규 신고 본문 -->
              <div id="tab-content" class="tab-content current">
              </div>
            </div>
          </div>
        </div>
      </section>
    <%@include file="/common/footer.jsp" %>
    </div>
    
    
    <script src="../resources/js/manager_report.js"></script>
</body>
</html>