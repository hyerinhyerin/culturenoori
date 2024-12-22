<%@page import="common.LoginManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String savedAccount = LoginManager.getSavedAccount(request);
String checkBoxFlag = savedAccount.isEmpty() ? "" : "checked";

System.out.println("[C] getSavedAccount > savedAccount : " + savedAccount);
System.out.println("[C] checkBoxFlag : " + checkBoxFlag);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
   <link
     rel="stylesheet"
     href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"
   />
   <link
     rel="stylesheet"
     href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
   />
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
   <link rel="stylesheet" href="../resources/css/header.css" />
   <link rel="stylesheet" href="../resources/css/footer.css" />
   <link rel="stylesheet" href="../resources/css/login.css" />


  
</head>
<body>
	<%@include file="/common/side_background.jsp"%>
	<%@include file="/common/header.jsp" %>
	<div class="container-fluid">
	<section>
        <div class="login-wrapper">
<!--           <div class="notify-login"> -->
<!--             <p>로그인</p> -->
<!--             <hr /> -->
<!--           </div> -->
          <!--        로그인폼-->
          <div class="login-container">
            <form  method="post"  action="./loginProc.jsp" name="loginForm">
            <input type="hidden" name="redirect" value="<%= request.getParameter("redirect") %>">
              <div class="login-input">
<!--               형호님 로그인 코드 -->
<!--                 <div class="form-floating username"> -->
<!--                   <input -->
<!--                     type="text" -->
<!--                     name="user_account"  -->
<!--                     placeholder="이메일이나 닉네임을 입력하세요" -->
<!--                     required -->
<!--                   /> -->
<!--                   <span class="material-symbols-outlined"> person </span> -->
<!--                   <button> -->
<!--                     <span class="material-symbols-outlined"> close </span> -->
<!--                   </button> -->
<!--                 </div> -->
<!--                 <div class="form-floating password"> -->
<!--                   <input id="pwd" class="form-control" type="password" name="user_pw" placeholder="비밀번호" required /> -->
<!--                   <label for="pwd">비밀번호</label> -->
<!--                   <span class="material-symbols-outlined"> lock </span> -->
<!--                 </div> -->
<!-- 				혜린 로그인 코드 -->
				<div class="username">
					<div class="account_save">
                    <input
                      type="checkbox"
                      name="save_check"
                      id="save_check"
                      <%= checkBoxFlag %>
                    />
                    <label for="save_check">아이디/이메일 저장하기</label>
                  </div>
                  <input
                    type="text"
                    name="user_account" 
                    placeholder="이메일이나 닉네임을 입력하세요"
                    value="<%= savedAccount %>"
                    required
                  />
                  <span class="material-symbols-outlined"> person </span>
                  <button type="button">
                    <span class="material-symbols-outlined"> close </span>
                  </button>
                </div>
                <div class="password">
                  <input id="pwd" type="password" name="user_pw" placeholder="비밀번호" required />
                  <span class="material-symbols-outlined"> lock </span>
                </div>
                <button type="submit" class="loginBtn">로그인</button>
              </div>
            </form>
            <ul>
              <li>
                <button type="button" id="findUserBtn">계정 및 비밀번호 찾기</button>
              </li>
              <li><a href="../join/join.jsp">회원가입</a></li>
            </ul>
          </div>
         </div>
          
          
		<div id="findUser-popup">
          <h3>계정 및 비밀번호 찾기</h3>
          <div class="findUser">
              <div class="account">
                <input
                  type="text"
                  name="findUser-account"
                  id="findUser-account"
                  placeholder="닉네임이나 이메일을 입력하세요"
                />
                <button type="button" id="emailBtn">인증번호 전송</button>
              </div>

              <div class="accountCheck">
                <input type="text" placeholder="인증번호" name="emailCode" disabled/>
                <button type="button" id="emailCheck">확인</button>
              </div>

							<div class="pwdiv">
								<input
	                type="password"
	                placeholder="새 비밀번호"
	                name="newpassword"
	                disabled
	              />
	              <p class="pwMsg">
	                최소 8자, 대소문자, 숫자, 특수문자 포함하세요.
	              </p>
							</div>
              
              <div class="btns">
                <button type="button" id="completeBtn">계속</button>
                <button type="button" id="popupClose">닫기</button>
              </div>
          
            <!-- 비밀번호 변경 성공 시 팝업 -->
            <div class="successPopup">
              <h5>알림</h5>
              <p>비밀번호가 변경되었습니다.</p>
              <p>다시 로그인을 시도해주세요.</p>
              <button type="button" class="alertpopupClose">닫기</button>
            </div>

          </div>
        </div>
      </section>
      <%@include file="/common/footer.jsp" %>
	</div>
	 <script src="../resources/js/login.js" ></script>
</body>
</html>