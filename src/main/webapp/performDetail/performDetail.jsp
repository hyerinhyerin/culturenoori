<%@page import="dao.TheaterDAO"%>
<%@page import="dao.PerformDetailDAO"%>
<%@page import="dao.PerformDAO"%>
<%@page import="dto.TheaterDTO"%>
<%@page import="dto.PerformDetailDTO"%>
<%@page import="dto.PerformDTO"%>
<%@page import="dto.UserDTO" %>
<%@page import="common.LoginManager" %>
<%@page import="dao.WishDAO" %>
<%@page import="dto.WishDTO" %>
<%@page import="common.JDBConnect" %>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!-- MVC중에서 Controller 역할을 하며, perform, detail, theater 정보를 가져와요 -->
<%@ include file="./performDetailProc.jsp"%>
<%
	UserDTO user = LoginManager.getUser();
	String userEmail = user != null ? user.getEmail() : "";
	JDBConnect jdbc = new JDBConnect(); // JDBConnect 인스턴스 생성
    Connection conn = jdbc.conn; // 데이터베이스 연결 가져오기

	System.out.println("[performDetail] user.getEmail : "+ userEmail);
    String performId = (String) session.getAttribute("detailId"); // 공연 ID를 가져옴
    System.out.println("[performDetail] performId : "+performId);

    WishDAO wishDAO = new WishDAO(jdbc.conn);
    boolean isWished = wishDAO.checkWish(performId, userEmail); // 사용자의 좋아요 여부 체크

//  JSP에서 JavaScript 변수를 설정하여 UI에서 사용할 수 있도록 함
    request.setAttribute("isWished", isWished);
    System.out.println("isWished : "+ isWished);
    
    jdbc.close();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Perform Detail</title>


<!--     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" -->
<!--     integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"> -->


<link rel="stylesheet" href="../resources/css/header.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/performDetail.css" />

<script defer src="${pageContext.request.contextPath}/resources/js/performDetail.js"></script>
<script defer src="${pageContext.request.contextPath}/resources/js/tabmenu.js"></script>
<%-- <script defer src="${pageContext.request.contextPath}/resources/js/main.js"></script> --%>
	
	
<!--     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" -->
<!--         integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" -->
<!--         crossorigin="anonymous"></script> -->


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- FIXME:JHK - 정리필요 -->
<script type="text/javascript"
src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=6b5fa56731e9aca5529c3185d00de61a&libraries=services"></script>
<!-- 	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=f6ded8ffd0b3189f666d877848aafdd0&libraries=services"></script> -->



<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" />
</head>

<body>
	<%@include file="/common/side_background.jsp"%>
	<jsp:include page="/common/header_filter.jsp" />
	<jsp:include page="/common/header.jsp" />
	<%@include file="../common/popupOk.jsp"%>
	
	<div id="detail_subtitle" class="mx-auto" style="width: 1300px">
		<h3 class="pt-0 mt-5">
			<p class="border-bottom border-2 pb-1 border-primary" style="width: 190px; margin-top:100px;">공연 상세 정보</p>
		</h3> 
	</div>
	<!-- 연극에 대한 상세정보 컨테이너 (9행 4열 Grid)-->
	<div id="detail_container"
		class="py-2 mx-auto border-bottom border-top border-2 border-primary-subtle">
		<!-- 연극 이미지 (1열, 9행 결합) -->
		<div id="perform_imgbox" class="p-1 mx-2 border-round-2">
			<img src="${perform.img_path}" alt="${perform.name}"
				style="width: 100%; height: 100%; border-radius:5px;" />
		</div>
		<!-- 분류코드 들어가는 부분 (1행 2열) -->
		<div class="p-2"></div>
		<!-- 차후 DB연동 시 Grid 수정을 위한 빈공간(1행 3열) -->
		<div></div>
		<!-- 예매사이트 바로가기 (1행 4열) -->
		<div class="d-flex justify-content-center pt-5" style="grid-row:span 2;">
			<a class="btn btn-light border justify-content-right text-align-center my-auto"
			 href="${detail.getReservation_link()}" target="_blank" style="background-color:#CDC1FF">예매사이트 바로가기</a>
		</div>

		<!-- 연극 제목 들어갈 부분 (2행 2~3열) -->
		<div class="d-flex p-1 perform_title" style="grid-column: span 2;">
			<!-- 좋아요 버튼 기능 들어갈 부분 -->
			<p class="like-button <%= isWished ? "checked" : "" %>" id="like-button" data-detailId="${detail.id}" data-user-email="<%=userEmail%>">
				<i class="<%= isWished ? "bi-heart-fill" : "bi-heart" %>" style="width: 100%; height: 100%">　</i>
			</p>
			<h3>${perform.name}</h3>
		</div>
		<!-- 차후 DB연동 시 제목이 길어졌을 때 Grid 수정을 위한 빈공간(3행 2열~4열) -->
		<div class="empty"></div>
		<!-- 장소 타이틀(4행 2열) -->
		<div class="justify-content-right border border-2"
			style="background: #f5f5f5">
			<h5 class="text-center align-content-center">장소</h5>
		</div>
		<!-- 장소 DB연동(4행 3~4열) -->
		<div style="grid-column: span 2" class="border-bottom me-3 border-2">
			<h5 class="ps-2 align-content-center">${theater.address}</h5>
		</div>
		<!-- 기간 타이틀(5행 2열) -->
		<div class="justify-content-right border border-2 border-top-0"
			style="background: #f5f5f5">
			<h5 class="text-center align-content-center">기간</h5>
		</div>
		<!-- 기간 DB연동(5행 3~4열) -->
		<div style="grid-column: span 2" class="border-bottom me-3 border-2">
			<h5 class="ps-2 align-content-center">${perform.start.split(" ")[0]}
				~ ${perform.end.split(" ")[0]}</h5>
		</div>
		<!-- 런타임 타이틀(6행 2열) -->
		<div class="justify-content-right border border-2 border-top-0"
			style="background: #f5f5f5">
			<h5 class="text-center align-content-center">런타임</h5>
		</div>
		<!-- 런타임 DB연동(6행 3~4열) -->
		<div style="grid-column: span 2" class="border-bottom me-3 border-2">
			<h5 class="ps-2 align-content-center">${detail.runtime}</h5>
		</div>
		<!-- 출연진 타이틀(7행 2열) -->
		<div class="justify-content-right border border-2 border-top-0"
			style="background: #f5f5f5">
			<h5 class="text-center align-content-center">출연진</h5>
		</div>
		<!-- 출연진 DB연동(7행 3~4열) -->
		<div style="grid-column: span 2" class="border-bottom me-3 border-2">
			<h5 class="ps-2 align-content-center">${detail.cast}</h5>
		</div>
		<!-- 가격 타이틀(8행 2열) -->
		<div class="justify-content-right border border-2 border-top-0"
			style="background: #f5f5f5">
			<h5 class="text-center align-content-center p-0 m-0">가격</h5>
		</div>
		<!-- 가격 DB연동(8행 3~4열) -->
		<div style="grid-column: span 2" class="border-bottom me-3 border-2">
			<h5 class="ps-2 align-content-center">${detail.price}</h5>
		</div>
		<!-- 평점 타이틀(9행 2열) -->
		<div class="justify-content-right border border-2 border-top-0"
			style="background: #f5f5f5">
			<h5 class="text-center align-content-center p-0 m02">평점</h5>
		</div>
		<!-- 평점 DB연동(9행 3~4열) -->
		<div style="grid-column: span 2" class="border-bottom me-3 border-2">
			<!-- main.js에서 drawStars 함수와 연동하여 평점에 따른 별 색칠 / performDetail로 옮길지 고민중 -->
			<div id="average-rate" class="pe-3 perform_starpoint star-container" style="font-family:'Jeju Gothic';" data-rate="${detail.average_rate}">
				</div>
		</div>
	</div>

	<!-- 탭 메뉴 코드 -->
	<!-- 3가지 탭 컨테이너 -->
	<div class="d-flex justify-content-between tab_btn mx-auto mt-3">
		<!-- 첫번째 탭 내용 코드 -->
		<div id="introtab" class="mx-auto tab_name text-center">
			<h3
				class="pt-1 border border-2 rounded-top-3 border-bottom-0 border-primary active load_content"
				data-file="./performIntro.jsp">소개</h3>
		</div>
		<!-- 두번째 탭 -->
		<div id="theatertab" class="mx-auto pt-0 tab_name text-center" style="font-family:'Jeju Gothic';">
			<h3
				class="pt-1 border border-2 rounded-top-3 border-bottom-0 border-primary-subtle bg-primary-subtle load_content"
				data-file="./theaterDetail.jsp">공연장</h3>
<%-- 				data-file="./theaterDetail.jsp?theaterId=${detail.Theater_id}">공연장</h3> --%>
				
		</div>
		<!-- 세번재 탭 -->
		<div id="reviewtab" class="mx-auto tab_name text-center" style="font-family:'Jeju Gothic';">
			<h3
				class="pt-1 border border-2 rounded-top-3 border-bottom-0 border-primary-subtle bg-primary-subtle load_content"
				data-file="review.jsp">한줄평</h3>
<!-- 				data-file="review.jsp">한줄평</h3> -->
		</div>
	</div>

	<!-- 선택 시 밑줄 표시/제거를 위한 컨테이너 -->
	<div class="d-flex mx-auto underline_container">
		<div class="border-2 border-top border-primary"></div>
		<div class="border-2 border-primary delete active"></div>
		<div class="border-2 border-top border-primary"></div>
		<div class="border-2 border-top border-primary" style="width: 119px"></div>
		<div class="border-2 border-top border-primary delete"></div>
		<div class="border-2 border-top border-primary"></div>
		<div class="border-2 border-top border-primary"></div>
		<div class="border-2 border-top border-primary delete"></div>
		<div class="border-2 border-top border-primary"></div>
	</div>

	<!-- 각 탭 선택 시 표시할 내용 부분 -->
	<div class="tab_content mt-3">
		<!-- 첫번째 탭(연극 소개) -->
		<%-- 첫번째 탭(연극 소개) 바로 위에 : ${detail.img_path} --%>
		<div class="mx-auto active content_view"></div>

		<!-- 두번째 탭(공연장 위치) -->
		<div class="mx-auto content_view"></div>
		<!-- 세번째 탭(한줄평) -->
		<div class="mx-auto content_view"></div>
	</div>
	<script type="text/javascript">
		let theaterJson = <%=theaterJson.toString()%>;
		console.log("theaterJson : ", theaterJson);
<%-- 		let detailId = <%= detail.getId() %>; --%>
// 		console.log("detailId : ", detailId);
	</script>
	<%@include file="/common/footer.jsp"%>
</body>


</html>
