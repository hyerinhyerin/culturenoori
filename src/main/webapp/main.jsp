<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
// 디버깅시 유용해서 출력중이다
System.out.println("[main] RealPath : " + application.getRealPath("/"));
%>


<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MainPage</title>
<script defer
	src="${pageContext.request.contextPath}/resources/js/main.js"></script>

<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" -->
<!--         integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"> -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">
<!--     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" -->
<!--         integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" -->
<!--         crossorigin="anonymous"></script> -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>



</head>

<body>
<!-- 헤더 삽입 -->
	<div class="header_container">
		<%@include file="/common/side_background.jsp"%>
		<%@include file="/common/header_filter.jsp"%>
		<%@include file="/common/header.jsp"%>
	</div>

<!-- calendar -->
 	<div class="container-fluid calendar_container mx-0"
		style="width: 100%; height: auto; background-size: cover; background-position-y: 50%; margin-top: 80px;">
		<div class="size background_opacity pb-5"
			style="width: 100%; height: 100%; background-color: rgba(200, 200, 231, 0.5);">

			<%@include file="/main/calendar.jsp"%>

		</div>
	</div>


<!-- 	weeklyRanking  -->
	<%@include file="/main/weeklyRanking.jsp" %>
	
	
<!-- 	performList -->
	<div class="mx-auto" style="width: 80vw;">
		<div id="list_subtitle" class="subtitle_style">
			<h3
				class="border-bottom border-2 border-primary pb-1 mt-5 text-center"
				style="width: 125px; font-family:'Jeju Gothic';'">연극 목록</h3>
			<div class="filter_contain">
				<ul>
					<li class="filter_list_item" data-value="all"><a>전체</a></li>
					<li class="filter_list_item" data-value="ing"><a>공연중</a></li>
					<li class="filter_list_item" data-value="soon"><a>공연예정</a></li>
					<li class="filter_list_item" data-value="ends"><a>공연완료</a></li>
				</ul>
			</div>
		</div>
	</div>
	<jsp:include page="/performList/performList.jsp" />
	
	
<!-- 	footer -->
	<!--     <div style="height: 200vh;"></div> -->
	<%@include file="/common/footer.jsp"%>

</body>
</html>














