<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 _ 내 활동</title>
	<link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
    />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <link rel="stylesheet" href="../resources/css/header.css" />
    <link rel="stylesheet" href="../resources/css/footer.css" />
    <link rel="stylesheet" href="../resources/css/activity.css" />
</head>
<body>
    <%@include file="/common/header.jsp" %>
    <%@include file="/common/side_background.jsp" %>
    
    <div class="container">
    <section>
        <div id="section-container">

          <div class="section-body">
            <!-- 유저의 메뉴 -->
            <div id="section-sidemenu">
              <div class="sidemenu-container">
                <a href="./member.jsp">회원 정보 관리</a>
                <a href="./wishlist.jsp">관심 목록</a>
                <a
                  href="./activity.jsp"
                  style="text-decoration: underline"
                  >내 활동 ></a
                >
              </div>
            </div>
            <div id="section-content">
              <ul class="tabnav">
                <li class="tab-link current" data-tab="myboard">게시글</li>
                <li class="tab-link" data-tab="myreview">한줄평</li>
                <li class="tab-link" data-tab="mycomment">댓글</li>
              </ul>
              <div id="tab-content" class="tab-content">
              </div>
            </div>
          </div>
        </div>
      </section>
    <%@include file="/common/footer.jsp" %>
    </div>
    
    
    <script src="../resources/js/mypage_activity.js"></script>
</body>
</html>