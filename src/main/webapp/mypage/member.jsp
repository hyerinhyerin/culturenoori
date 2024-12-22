<%@page import="utils.ProfileImage"%>
<%@page import="dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	UserDTO user = LoginManager.getUser();

	// TODO:JHK 프로필SVG - 회원 정보 관리1
	// : request.getContextPath()+"/resources/image/comment_profile.png";
	String imagePath = (user.getImg_path() != null && !user.getImg_path().isEmpty()) ?
			request.getContextPath()+"/resources/image/profileImage/"+user.getImg_path() : "";
	
	System.out.println("[member] userImage - "+user.getImg_path());
	String isDefaultImage = (user.getImg_path() != null && !user.getImg_path().isEmpty()) ? "false" : "true";
%>

<!-- TODO:JHK 공통팝업 - 수정 등록 -->
<%@include file="../common/popupOkCancel.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지_계정관리</title>
<link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
    />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <link rel="stylesheet" href="../resources/css/common.css" />
    <link rel="stylesheet" href="../resources/css/header.css" />
    <link rel="stylesheet" href="../resources/css/footer.css" />
    <link rel="stylesheet" href="../resources/css/member.css" />
</head>
<body>
	<%@include file="/common/side_background.jsp" %>
    <%@include file="/common/header.jsp" %>
    
    <div class="container">
          <section>
        <div id="section-container">
          <div class="section-body">
            <!-- 유저의 메뉴 -->
            <div id="section-sidemenu">
              <div class="sidemenu-container">
                <!--            <button class="userManageBtn">회원 정보 관리</button>-->
                <!--            <button class="wishlistBtn">관심 목록</button>-->
                <a
                  href="./member.jsp"
                  style="text-decoration: underline"
                  >회원 정보 관리 ></a
                >
                <a href="./wishlist.jsp">관심 목록</a>
                <a href="./activity.jsp">내 활동</a>
              </div>
            </div>
            <div id="section-content">
              <div class="userInfo">
                <form class="profile_form" action="./memberProc/editmemberProc.jsp" method="post" enctype="multipart/form-data">
                  <div class="profileImg">
                    <div class="previewImage">
<!--                	TODO:JHK 프로필SVG - 회원 정보 관리2 -->
											<% if(imagePath.isEmpty()) { %>
											    <%= ProfileImage.genSvgTag(183, 183, "#CBDCF5", 0) %> 
											<% } else { %>
											    <img src="<%= imagePath %>" alt="profile">
											<% } %>  
                    </div>
                    <div class="button">
                    	<label class="cn-btn" for="profileUpload">프로필 업로드</label>
	                    <input
	                      type="file"
	                      name="profileUpload"
	                      id="profileUpload"
	                      accept="image/*"
	                    />
	                    <p></p>
	                    <input type="hidden" name="isDefaultImage" value=<%=isDefaultImage %>/>
	                    <button class="cn-btn" id="deleteProfileImage" type="button">기본 프로필</button>
                    </div>
                  </div>

                  <div class="username">
                    <input type="text" value="<%=user.getNickname() %>" name="username" />
                    <span class="material-symbols-outlined"> person </span>
                    <button type="button" class="username-check">
                      중복확인
                    </button>
                  </div>
                  <div class="password">
                    <input
                      type="password"
                      value="<%= user.getPassword() %>"
                      name="password"
                    />
                    <span class="material-symbols-outlined"> lock </span>
                    <p class="pwMsg">
	                    최소 8자, 대소문자, 숫자, 특수문자 포함하세요.
	                  </p>
                  </div>
                  <div class="email">
                    <input
                      type="email"
                      autocomplete="off"
                      name="email"
                      value="<%= user.getEmail()%>"
                      readonly
                    />
                    <span class="material-symbols-outlined"> email </span>
                    <label> 이메일 변경 불가 </label>
                  </div>
                  <button class="cn-btn" id="userInfo_edit" type="button">수정 등록</button>
                  <button class="cn-btn" id="userInfo_default" type="reset">수정 취소</button>
                  <button class="cn-btn" id="userInfo_delete" type="button">계정 탈퇴</button>
                </form>


								<!-- TODO:JHK 공통팝업 - 정보 수정 알림창 -->
                <!-- form 수정 버튼 클릭 시 확인 알림창 -->
<!--                 <div class="editPopup"> -->
<!--                   <h3>정보 수정 알림창</h3> -->
<!--                   <p>정보를 수정하시겠습니까?</p> -->
<!--                   <button id="editPopupBtn" type="button">수정 등록</button> -->
<!--                   <button class="popupClose" type="button">닫기</button> -->
<!--                 </div> -->
                
                <!-- TODO:JHK 공통팝업 - 계정 삭제 알림창 -->
                <!-- form 탈퇴 버튼 클릭 시 확인 알림창 -->
<!--                 <div class="deletePopup"> -->
<!--                   <h3>계정 삭제 알림창</h3> -->
<!--                   <p>계정을 삭제하시겠습니까?</p> -->
<!--                   <button id="deletePopupBtn" type="button">탈퇴하기</button> -->
<!--                   <button class="popupClose" type="button">닫기</button> -->
<!--                 </div> -->
                
              </div>
              <!-- 팝업창 뜰 때 사용되는 검은 막.... -->
<!--               <div class="blackSubDiv"></div> -->
            </div>
          </div>
        </div>
      </section>
    </div>
    <script type="text/javascript">let originalImagePath = "<%= imagePath%>"</script>
		<script src="../resources/js/profileImage.js" ></script>
    <script src="../resources/js/mypage_member.js"></script>
        <%@include file="/common/footer.jsp" %>
</body>
</html>





