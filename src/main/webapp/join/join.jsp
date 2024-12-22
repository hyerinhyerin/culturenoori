<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join</title>
<link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
    />
   <link rel="stylesheet" href="../resources/css/header.css" />
   <link rel="stylesheet" href="../resources/css/footer.css" />
   <link rel="stylesheet" href="../resources/css/join.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   
</head>
<body>
		<%@include file="/common/side_background.jsp"%>
    <%@include file="../common/header.jsp" %>
    <div id="container">
    <section>
        <div class="join-container">
<!--           <div class="notify-join"> -->
<!--             <p>회원가입</p> -->
<!--             <hr /> -->
<!--           </div> -->
          <!--        로그인폼-->
          <div class="signup-container">
          
            <form name="joinForm" method="post" action="./joinProc.jsp" >
              <input type="hidden" name="redirect" value="<%= request.getParameter("redirect") %>">
              <input type="hidden" id="nikcCheckResult" value="0">
              <input type="hidden" id="emailCheckResult" value="0">
              <div class="signup-input">
                <div class="username">
                  <input
                    type="text"
                    placeholder="닉네임"
                    name="nick"
                    required
                  />
                  <span class="material-symbols-outlined"> person </span>
<!--                   <button type="button" class="username-check" onclick="nickCheck()"> -->
                  <button type="button" class="username-check" >
                    중복확인
                  </button>
                  <p class="nickcheckMsg">세 글자 이상 입력해주세요.</p>
                </div>
                <div class="password">
                  <input
                    type="password"
                    placeholder="비밀번호"
                    name="passwd1"
                    required
                  />
                  <span class="material-symbols-outlined"> lock </span>
                  <p class="pwMsg">
                    최소 8자, 대소문자, 숫자, 특수문자 포함하세요.
                  </p>
                </div>
                <div class="password pw-check">
                  <input type="password" name="passwd2" placeholder="비밀번호 확인" required />
                  <span class="material-symbols-outlined"> lock </span>
                  <p class="pwcheckMsg">비밀번호가 일치하지 않습니다.</p>
                </div>
                <div class="email">
                  <input
                    type="email"
                    autocomplete="off"
                    name="email"
                    required
                    
                  />
                  <span class="material-symbols-outlined"> email </span>
                  <label> Email address </label>
<!--                   <button class="emailCheckBtn" onclick="emailCheck()">중복확인</button> -->
                  <button class="emailCheckBtn" >중복확인</button>
                  <button class="emailBtn">인증번호 전송</button>
                </div>
                <div class="email email-check">
                  <input
                    type="text"
                    placeholder="인증번호"
                    name="emailCode"
                    required
                  />
                  <span><i class="fa-solid fa-check"></i></span>
                </div>
                <button type="submit" class="joinBtn">회원가입</button>
              </div>
            </form>
            
          </div>
        </div>
      </section>
    
    <%@include file="../common/footer.jsp" %>
    </div>
    <script src="../resources/js/join.js"></script>
</body>
</html>