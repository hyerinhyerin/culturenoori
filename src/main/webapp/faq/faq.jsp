<%@page import="dto.UserDTO"%>
<%@page import="common.LoginManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	UserDTO user = LoginManager.getUser();
	
%> 

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>자주 묻는 질문(FAQ) 및 Q&A</title>
    <link rel="stylesheet" href="../resources/css/header.css" />
   	<link rel="stylesheet" href="../resources/css/footer.css" />
    <link rel="stylesheet" href="../resources/css/faq.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
</head>

<body>
		<%@include file="/common/side_background.jsp"%>
		<%@include file="/common/header.jsp" %>
		<div id="container">
	    <button class="tab" onclick="toggleSection('faq')" style="margin-left:73px;">자주 묻는 질문</button>
	    <button class="tab" onclick="toggleSection('qa')">Q&A(문의하기)</button>
	
	    <div id="faq" class="content">
	        <h3 class="title">자주 묻는 질문(FAQ)</h3>
	        <ul class="faq-container">
	            <li class="faq">
	                <div class="faq_question" onclick="toggleAnswer(this)">
	                    <h3 class="faq_title">문화누리는 어떤 사이트 입니까?</h3>
	                </div>
	                <div class="faq_answer">
	                    <p class="faq_text">
	                        연극을 사랑하는 모든 분들을 위한 사이트로 다양한 연극 정보를 제공하고, 소통의 장을 마련하기 위해 만들어졌습니다.
	                    </p>
	                </div>
	
	                <button class="faq_btn">
	                    <span class="faq_icon open">+</span>
	                    <span class="faq_icon close">-</span>
	                </button>
	
	            </li>
	            <li class="faq">
	                <div class="faq_question" onclick="toggleAnswer(this)">
	                    <h3 class="faq_title">이메일이나 닉네임을 찾고싶어요!!</h3>
	                </div>
	                <div class="faq_answer">
	                    <p class="faq_text">
	                        아이디나 닉네임을 잃어버리신 경우, 둘 중 하나만 알고 있어도 계정을 찾을 수 있습니다. 해당 정보를 입력하신 후, 안내에 따라 계정을 복구해 주시기 바랍니다.
	                    </p>
	                </div>
	
	                <button class="faq_btn">
	                    <span class="faq_icon open">+</span>
	                    <span class="faq_icon close">-</span>
	                </button>
	
	            </li>
	            <li class="faq">
	                <div class="faq_question" onclick="toggleAnswer(this)">
	                    <h3 class="faq_title">회원가입시 이메일 인증이 안돼요!!</h3>
	                </div>
	                <div class="faq_answer">
	                    <p class="faq_text">
	                        메일 전송 시스템의 일시적인 오류, 메일 서비스의 시스템 상태, 네트워크 오류 등의 이유로 메일 수신이 정상적으로 이루어지지 않을 수 있습니다. 5~10분 정도 기다려도
	                        메일이 도착하지 않거나, 스팸 메시지함에도 없을 경우, 문의글을 남겨주시면 확인 후 안내드리겠습니다.
	                    </p>
	                </div>
	
	                <button class="faq_btn">
	                    <span class="faq_icon open">+</span>
	                    <span class="faq_icon close">-</span>
	                </button>
	
	            </li>
	            <li class="faq">
	                <div class="faq_question" onclick="toggleAnswer(this)">
	                    <h3 class="faq_title">회원탈퇴는 어디서 하나요?</h3>
	                </div>
	                <div class="faq_answer">
	                    <p class="faq_text">
	                        로그인 후 [마이페이지] - [회원정보관리]를 이용하시면 회원탈퇴가 가능합니다. 회원탈퇴를 하시면 관련된 모든 정보가 삭제되므로, 신중하게 결정해 주시기 바랍니다.
	                    </p>
	                </div>
	
	                <button class="faq_btn">
	                    <span class="faq_icon open">+</span>
	                    <span class="faq_icon close">-</span>
	                </button>
	
	            </li>
	        </ul>
	    </div>
	 
	 
	 
	 
	    <div id="qa" class="content">
	        <h3 class="title">Q&A(문의하기)</h3>
	        <form id="questionForm">
	        <input type="hidden" value="<%= user != null ? user.getEmail() : ""%>" id = "account"> 
	        
	            <label for="questionInput"> 제목을 입력하세요:</label> <br>
	            
	            <input type="text" name="questionInput" id="questionInput" placeholder="제목을 입력하세요" required>
	
	
	            <label for="questionDetails"> 내용:</label>
	            <textarea id="questionDetails" name="questionDetails" placeholder="질문 내용을 입력하세요" rows="4"></textarea>
	
	            <button type="submit">질문 제출</button>
	        </form>
	        
	        
	        
	        
	        <ul class="qa-container">
	
<!-- 	            <li class="qa"> -->
<!-- 	                <div class="qa_question" onclick="toggleAnswer(this)"> -->
<!-- 	                    <h3 class="qa_title">질문1</h3> -->
<!-- 	                </div> -->
<!-- 	                <div class="qa_answer"> -->
<!-- 	                    <p class="qa_text"> -->
<!-- 	                        연극을 사랑하는 모든 분들을 위한 사이트로 다양한 연극 정보를 제공하고, 소통의 장을 마련하기 위해 만들어졌습니다. -->
<!-- 	                    </p> -->
<!-- 	                </div> -->
	
<!-- 	                <button class="qa_btn"> -->
<!-- 	                    <span class="qa_icon open">+</span> -->
<!-- 	                    <span class="qa_icon close">-</span> -->
	                          
<!-- 	                </button> -->
	         
				
<!-- 	  					  </li> -->
	          
	
<!-- 	            <li class="qa"> -->
<!-- 	                <div class="qa_question" onclick="toggleAnswer(this)"> -->
<!-- 	                    <h3 class="qa_title">질문2</h3> -->
<!-- 	                </div> -->
<!-- 	                <div class="qa_answer"> -->
<!-- 	                    <p class="qa_text"> -->
<!-- 	                        연극을 사랑하는 모든 분들을 위한 사이트로 다양한 연극 정보를 제공하고, 소통의 장을 마련하기 위해 만들어졌습니다. -->
<!-- 	                    </p> -->
<!-- 	                </div> -->
	
<!-- 	                <button class="qa_btn"> -->
<!-- 	                    <span class="qa_icon open">+</span> -->
<!-- 	                    <span class="qa_icon close">-</span> -->
<!-- 	                </button> -->
	
	         
	
<!-- 	            </li> -->
	
<!-- 	            <li class="qa"> -->
<!-- 	                <div class="qa_question" onclick="toggleAnswer(this)"> -->
<!-- 	                    <h3 class="qa_title">질문3</h3> -->
<!-- 	                </div> -->
<!-- 	                <div class="qa_answer"> -->
<!-- 	                    <p class="qa_text"> -->
<!-- 	                        연극을 사랑하는 모든 분들을 위한 사이트로 다양한 연극 정보를 제공하고, 소통의 장을 마련하기 위해 만들어졌습니다. -->
<!-- 	                    </p> -->
<!-- 	                </div> -->
	
<!-- 	                <button class="qa_btn"> -->
<!-- 	                    <span class="qa_icon open">+</span> -->
<!-- 	                    <span class="qa_icon close">-</span> -->
<!-- 	                </button> -->
	                
	         
	
	
<!-- 	            </li> -->
	
<!-- 	            <li class="qa"> -->
<!-- 	                <div class="qa_question" onclick="toggleAnswer(this)"> -->
<!-- 	                    <h3 class="qa_title">질문4</h3> -->
<!-- 	                </div> -->
<!-- 	                <div class="qa_answer"> -->
<!-- 	                    <p class="qa_text"> -->
<!-- 	                        연극을 사랑하는 모든 분들을 위한 사이트로 다양한 연극 정보를 제공하고, 소통의 장을 마련하기 위해 만들어졌습니다. -->
<!-- 	                    </p> -->
<!-- 	                </div> -->
	
<!-- 	                <button class="qa_btn"> -->
<!-- 	                    <span class="qa_icon open">+</span> -->
<!-- 	                    <span class="qa_icon close">-</span> -->
<!-- 	                </button> -->
	
	
<!-- 	            </li> -->

</ul>
	
	    </div>
      
   </div> 
   <%@include file="/common/footer.jsp" %>
 	<script>
      const currentUserEmail = '<%= user != null ? user.getEmail() : "" %>'; // JSP에서 가져온 사용자 이메일
  </script>
  <script src="../resources/js/faq.js"></script>
    

</body>

</html>