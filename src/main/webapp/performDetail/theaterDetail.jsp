<%@page import="dto.TheaterDTO"%>
<%@page import="dao.TheaterDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

String theaterId = (String)session.getAttribute("theaterId");
System.out.println("[theaterDetail] theaterId : " + theaterId);

TheaterDAO dao = new TheaterDAO();
TheaterDTO theater = dao.getTheater(theaterId);
dao.close();

System.out.println("[theaterDetail] theater : " + theater.toString());

%>    

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Perform Detail</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/performDetail.css">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>



</head>

<body>
	<div class="mx-auto theater_container">
		<!-- 공연장 정보 서브제목 -->
		<div id="theater_subtitle" class="mx-auto" style="width: 1300px;">
			<h3 class="pt-0">
				<p class="border-bottom border-2 mt-4 pb-1 border-primary-subtle"
					style="width: 170px; font-family:'Jeju Gothic'; ">공연장 정보</p>
			</h3>
		</div>
		<!-- 공연장 상세정보 -->
		<div class="theater_detail">
			<!-- 공연장 이름 -->
			<div class="border border-2 border-bottom-0 d-flex text-center">
				<h4 class="align-content-center">
					공연장 이름
					</h5>
			</div>
			<div class="border border-2 border-bottom-0 border-start-0 d-flex">
				<h5 id="theaterName" class="ms-3 my-auto">
					<%= theater.getVenue_name() %>
				</h5>
			</div>

			<!-- 상세 주소 -->
			<div class="border border-2 border-bottom-0 d-flex text-center">
				<h4 class="align-content-center">
					상세주소
					</h5>
			</div>
			<div class="border border-2 border-bottom-0 border-start-0 d-flex">
				<h5 id="theaterAddress" class="ms-3 my-auto">
				<%= theater.getAddress() %>
				</h5>
			</div>

			<!-- 좌석수 -->
			<div class="border border-2 border-bottom-0 d-flex text-center">
				<h4 class="align-content-center">
					좌석수
					</h5>
			</div>
			<div class="border border-2 border-bottom-0 border-start-0 d-flex">
				<h5 id="theaterSeatCount" class="ms-3 my-auto">
				${theater.total_seats}
				</h5>
			</div>

			<div class="border border-2 text-center d-flex"
				style="grid-column: span 2;">
				<h4 class="align-content-center">
					지도
					</h5>
			</div>
			
			
			<!-- 지도 API 연동 -->
			<div class="map_field border border-2 border-top-0" style="overflow:hidden;">
				<div id="map" style="width: 100%; height: 600px; overflow:hidden;"></div>
				<!-- <img style="width: 100%; height: auto;" -->
				<%--  src="${pageContext.request.contextPath}/resources/image/image1.JPG" alt=""> --%>
			</div>
			
		</div>
	</div>
</body>


<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	var address = '<%= theater.getAddress() %>';
	
	geocoder.addressSearch(address, function(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});   
	

</script>




</html>













