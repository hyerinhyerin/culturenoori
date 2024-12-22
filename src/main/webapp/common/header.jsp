<%@page import="utils.ProfileImage"%>
<%@page import="dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="common.LoginManager"%>
<link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
    />
<%
// 	String sessionLogined = LoginManager.getLoginedAccount(session);
	UserDTO userheader = LoginManager.getUser();
	boolean isAdmin = LoginManager.isAdmin(session);
	
	String mypageimagePath=ProfileImage.genSvgTag(50, 50, "#CBDCF5", 20);
// 	if(userheader != null && userheader.getImg_path() != null){
// 		mypageimagePath = request.getContextPath()+"/resources/image/profileImage/"+userheader.getImg_path();
		
// 	}
	System.out.println("<p>Image Path: " + mypageimagePath + "</p>");
	
%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>
<%--     <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css"> --%>
<%--     <script src="${pageContext.request.contextPath}/resources/js/header.js"></script> --%>
<!--    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" -->
<!--         integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" -->
<!--         crossorigin="anonymous"></script> -->
	<header>
        <div class="d-flex mx-auto header-container fixed">
          <a id="logo" href="${pageContext.request.contextPath}/main.jsp">
          <img src="${pageContext.request.contextPath}/resources/image/noorilogo.png" style="width:250px;"/>
          </a>

          <nav class="header-navbar" style="margin-right: 85px;">
            <div class="menu-container">
              <ul class="menulist">
                <li>
                  <a href="${pageContext.request.contextPath}/main.jsp#rank_carousel">주간랭킹</a>
                </li>
<!--                 <div class="vr mt-2"></div> -->
                <li>
                  <a href="${pageContext.request.contextPath}/main.jsp#list_subtitle">공연목록</a>
                </li>
<!--                 <div class="vr mt-2"></div> -->
                <li>
                  <a href="${pageContext.request.contextPath}/community/boardList.jsp">커뮤니티</a>
                </li>
<!--                 <div class="vr mt-2"></div> -->
                <li>
                  <a href="${pageContext.request.contextPath}/faq/faq.jsp">FAQ</a>
                </li>
              </ul>
            </div>
          </nav>
          
          <div class="login-list">
          <%
          	if(userheader == null){
          %>
          	<p id="loginP" onclick="redirectToLogin()" style="cursor:pointer;">로그인</p>
          	<p id="joinP" onclick="redirectToJoin()" style="cursor:pointer;">회원가입</p>
<%--             <a href="${pageContext.request.contextPath}/login/login.jsp">로그인</a> --%>
<%--             <a href="${pageContext.request.contextPath}/join/join.jsp">회원가입</a> --%>
           <%
          	}else{
          		if(isAdmin){
           %>
		            <a href="${pageContext.request.contextPath}/manager/manager_report.jsp">
		            <img src="${pageContext.request.contextPath}/resources/image/gear_black.png" id="myprofile"/>
		            </a>
		            <a href="${pageContext.request.contextPath}/login/logoutProc.jsp">
		            <span style="margin-right:40px;"><i class="fa-solid fa-arrow-right-from-bracket fa-lg"></i></span>
		            </a>
	            <%}else{ %>
									<%if(userheader != null && userheader.getImg_path() != null){ 
										mypageimagePath = request.getContextPath()+"/resources/image/profileImage/"+userheader.getImg_path();
									%>
									<a href="${pageContext.request.contextPath}/mypage/member.jsp">
									<img src="<%=mypageimagePath %>" id="myprofile"/>
									<%} else{ %>
									<a href="${pageContext.request.contextPath}/mypage/member.jsp" style="padding-top: 10px;">
									<%=mypageimagePath %>
									<%} %>
									</a>
            			<a href="${pageContext.request.contextPath}/login/logoutProc.jsp">
            			<span style="margin-right:40px;"><i class="fa-solid fa-arrow-right-from-bracket fa-xl"></i></span>
            			</a>
          <%}
          }
          %>

          </div>
        </div>
      </header>
      <script>
      function redirectToLogin() {
    	    var currentUrl = encodeURIComponent(window.location.href);
    	    location.href = '<%= request.getContextPath() %>/login/login.jsp?redirect=' + currentUrl;
    	}
      
      function redirectToJoin() {
  	    var currentUrl = encodeURIComponent(window.location.href);
  	    location.href = '<%= request.getContextPath() %>/join/join.jsp?redirect=' + currentUrl;
  	}
      </script>
