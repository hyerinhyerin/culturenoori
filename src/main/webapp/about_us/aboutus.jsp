<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>about-us</title>

<link rel="stylesheet" href="../resources/css/footer.css" />
<link rel="stylesheet" href="../resources/css/header.css" />
<link rel="stylesheet" href="../resources/css/aboutus.css" />
</head>
<body>
<!-- <section id="mypage-header" class="header"> -->
<!--       <div class="mypage"> -->
<!--         <h3>마이페이지</h3> -->
<!--       </div> -->

<!--       <div class="button-container"> -->
<!--         <p>공연목록</p> -->
<!--         <p>주간랭킹</p> -->
<!--         <p>커뮤니티</p> -->
<!--         <p>마이페이지</p> -->
        
        
        
<!--       </div> -->
<!--     </section> -->
		<%@include file="/common/side_background.jsp"%>
		<%@include file="/common/header.jsp" %>

    <section id="content" class="content-container">
      <div class="aboutus">
        <h3>About US</h3>
      </div>

      <div class="title">
        <h3>사이트 소개</h3>
      </div>
      <div class="about-content">
        <p>
          환영합니다! "문화누리"에 오신 것을 진심으로 환영합니다.
          <br />"문화누리"는 연극을 사랑하는 모든 분들을 위한 사이트로 다양한
          연극 정보를 제공하고, 소통의 장을 마련하기 위해 만들어졌습니다.<br />
          우리는 연극의 매력을 함께 나누고자 하며, 다음과 같은 서비스를
          제공합니다. <br />
          <br />
          1. 최신 연극 정보 <br />
          "문화누리"는 매일 업데이트되는 연극 일정과 정보를 통해 최신 작품, 공연
          날짜, 시간, 장소, 캐스팅을 손쉽게 확인할 수 있습니다. <br />
          각 연극에 대한 상세 설명과 관람 후기를 통해 관객 여러분이 더 나은
          선택을 할 수 있도록 돕습니다.<br /><br />
          2.연극 한줄평과 평점 <br />
          관객들이 직접 작성한 한줄평와 평점을 통해, 다양한 시각에서 연극을
          평가하고 감상을 공유할 수 있습니다. <br />
          이를 통해 여러분이 관람할 연극을 선택하는 데 큰 도움이 될 것입니다.<br /><br />
          3.주간 인기 연극 랭킹 <br />
          현재 가장 핫한 연극을 한눈에 볼 수 있는 주간 랭킹 시스템을 도입하여,
          놓치지 말아야 할 인기 작품을 쉽게 확인할 수 있습니다.<br />
          인기 연극을 통해 새로운 문화 경험을 즐겨보세요! <br /><br />
          4. 연극 커뮤니티 <br />
          "문화누리"는 관객들이 서로의 경험을 나누고, 감상평을 공유할 수 있는
          공간을 제공합니다. <br />연극에 대한 다양한 이야기를 나누며, 함께
          소통할 수 있는 커뮤니티에 여러분을 초대합니다.<br /><br />
          "문화누리"는 연극을 사랑하는 모든 이들을 위한 공간입니다.
          <br />여러분이 이곳에서 새로운 연극 정보를 얻고, 다른 사람들과
          소통하며, 특별한 문화 경험을 쌓아가길 바랍니다. <br />저희와 함께
          연극의 매력에 푹 빠져보세요! <br />많은 관심과 참여를 부탁드리며,
          앞으로도 지속적으로 더 나은 서비스를 제공하기 위해 노력하겠습니다.
          감사합니다!
        </p>
      </div>
    </section>

    <section id="introduce" class="introduce-container">
      <div class="intro">
        <h3>팀원소개</h3>
      </div>
      <div class="members">
        <ul>
          <li>
           <img src="../resources/image/3D_Cat.png" alt="김지현" class="member-image"> 
           </li>
          <li>
          <img src="../resources/image/3D_Puppy.png" alt="정혜린" class="member-image">
          </li>
          <li>
          <img src="../resources/image/3D_Lion.png" alt="정회광" class="member-image">
          </li>
          <li>
          <img src="../resources/image/Wolf.png" alt="한형호" class="member-image">
          </li>
        </ul>
      </div>
      <div class="email">
        <ul>
          <li>KJH</li>
          <li>JHR</li>
          <li>JHK</li>
          <li>HHH</li>
        </ul>
      </div>
    </section>
    <%@include file="/common/footer.jsp" %>
</body>
</html>