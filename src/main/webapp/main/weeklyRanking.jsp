<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ include file="./weeklyRankingProc.jsp"%>

<!DOCTYPE html>
<html>
<head>

<style type="text/css">
/* 캐러셀 전체 컨테이너 */
.carousel {
	width: 80%;
	margin: 0 auto;
	overflow: hidden;
	position: relative;
}

.carousel_container{
	width: 100%; 
	position: relative; 
	z-index: 1
}

/* 슬라이드 이미지들을 감싸는 래퍼 */
.carousel-inner {
	display: flex;
	width: 100%;
	transition: transform 0.5s ease-in-out;
}

/* 각각의 슬라이드 */
.carousel-item {
	min-width: 100%;
	transition: transform 0.5s ease-in-out;
}

/* 캐러셀 이미지 스타일 */
.carousel-item img {
	width: 100%;
	height: auto;
	display: block;
}

/* 이전, 다음 버튼 */
.carousel-control {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	background-color: rgba(0, 0, 0, 0.5);
	color: white;
	border: none;
	padding: 10px;
	cursor: pointer;
}
.rating_star{
	font-size : 1.5rem;
	color:#ccc;
}

.rating_star.filled{
	color:goldenrod;
}

.prev {
	left: 10px;
}

.next {
	right: 10px;
}
</style>


<script defer src="${pageContext.request.contextPath}/resources/js/weeklyRanking.js"></script>
</head>
<body>



	<!-- 캐러셀 활용한 주간 랭킹 -->
	<div id="rank_carousel" class="mx-auto carousel slide"
		data-ride="carousel" style="width: 80vw;">
		<h3 class="subtitle_style">
			<p
				class=" border-bottom border-2 border-primary pb-1 text-center mt-5"
				style="width: 125px; font-family:'Jeju Gothic';">주간 랭킹</p>
		</h3>
		<div
			class="container-fluid carousel_container border-top border-bottom border-primary-subtle border-2">
			<div class="nonclick" style="top: 0%; left: 0%"></div>
			<div class="nonclick" style="bottom: 0%; left: 0%"></div>
			<div class="nonclick" style="top: 0%; right: 0%"></div>
			<div class="nonclick" style="bottom: 0%; right: 0%"></div>
			<div class="carousel_container_outline"
				style="position: absolute; left: 0px; width: 50px; z-index: 0;">
			</div>


			<div class="carousel-inner mx-auto pt-4" style="width: 75vw;">




				<!-- 1 페이지 -->
				<div class="carousel-item active">


					<!-- 캐러셀 1페이지(1~5위) -->
					<div style="width: auto; height: 318px;"
						class="mx-auto carousel_size">

						<!-- 					justify-content-between  -->
						<!-- 캐러셀 크기 설정 -->
						<div id="carousel-container1"
							class="container-fluid bg-gray d-flex justify-content-between ps-5carousel_items"
							style="height: 300px; position: relative; padding-left: 40px; padding-right: 80px;">


							캐러셀 첫번째 항목 컨테이너
							<div onclick="location.href='./performDetail/performDetail.jsp';"
								class="container-fluid border bg-white ps-0 pe-5 carousel_item"
								style="position: relative;">

								숫자 <img src="./resources/image/1.png" alt=""
									style="width: 30%; position: absolute; left: -6%; top: 0%";>

								포스터 ; 연극 이미지 들어가는 태그 <img class="perform_img"
									src="./resources/image/PF_PF216819_230415_031912.gif" alt=""
									style="width: 100%;"> 마우스 호버시 세부정보
								<div class="rank_perform_grid">
									<p class="pt-2 ps-2 align-content-center fs-5 perform_title">
										이머시브씨어터, 카지노</p>
									<div class="perform_starpoint star-container"></div>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">장소 :</p>
									<p class="ps-2 pb-2 perform_theater">대학로스타시티 카지노 전용관</p>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">기간 :</p>
									<p class="ps-2 pb-0 perform_date">2024-09-21 ~ 2024-09-30</p>
									<p style="order: 6;"></p>
									JS로부터 별점을 받아 그리는 필드 (main.js의 drawStars)
								</div>
							</div>



							<div
								class="container-fluid border bg-white ms-5 ps-0 pe-3 carousel_item"
								style="position: relative;">
								<img src="./resources/image/2.png" alt=""
									style="width: 60px; position: absolute; top: 0%; left: -3%;">
								<img class="perform_img"
									src="./resources/image/PF_PF216819_230415_031912.gif" alt=""
									style="width: 100%;">
								<div class="rank_perform_grid">
									<p class="pt-2 ps-2 align-content-center fs-5 perform_title">
										이머시브씨어터, 카지노</p>
									<div class="perform_starpoint star-container"></div>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">장소 :</p>
									<p class="ps-2 pb-2 perform_theater">대학로스타시티 카지노 전용관</p>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">기간 :</p>
									<p class="ps-2 pb-0 perform_date">2024-09-21 ~ 2024-09-30</p>
									<p style="order: 6;"></p>
									JS로부터 별점을 받아 그리는 필드 (main.js의 drawStars)
								</div>
							</div>
							<div
								class="container-fluid border bg-white ms-5 ps-0 pe-3 carousel_item"
								style="position: relative;">
								<img src="./resources/image/3.png" alt=""
									style="width: 60px; position: absolute; top: 0%; left: -3%;">
								<img class="perform_img"
									src="./resources/image/PF_PF216819_230415_031912.gif" alt=""
									style="width: 100%;">
								<div class="rank_perform_grid">
									<p class="py-2 ps-2 align-content-center fs-5 perform_title">
										이머시브씨어터, 카지노</p>
									<div class="perform_starpoint star-container"></div>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">장소 :</p>
									<p class="ps-2 pb-2 perform_theater">대학로스타시티 카지노 전용관</p>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">기간 :</p>
									<p class="ps-2 pb-0 perform_date">2024-09-21 ~ 2024-09-30</p>
									<p style="order: 6;"></p>
									JS로부터 별점을 받아 그리는 필드 (main.js의 drawStars)
								</div>
							</div>
							<div
								class="container-fluid border bg-white ms-5 ps-0 pe-3 carousel_item"
								style="position: relative;">
								<img src="./resources/image/4.png" alt=""
									style="width: 60px; position: absolute; top: 0%; left: -3%;">
								<img class="perform_img"
									src="./resources/image/PF_PF216819_230415_031912.gif" alt=""
									style="width: 100%;">
								<div class="rank_perform_grid">
									<p class="pt-2 ps-2 align-content-center fs-5 perform_title">
										이머시브씨어터, 카지노</p>
									<div class="perform_starpoint star-container"></div>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">장소 :</p>
									<p class="ps-2 pb-2 perform_theater">대학로스타시티 카지노 전용관</p>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">기간 :</p>
									<p class="ps-2 pb-0 perform_date">2024-09-21 ~ 2024-09-30</p>
									<p style="order: 6;"></p>
									JS로부터 별점을 받아 그리는 필드 (main.js의 drawStars)
								</div>
							</div>
							<div
								class="container-fluid border bg-white ms-5 me-5 ps-0 pe-0 carousel_item"
								style="position: relative;">
								<img src="./resources/image/5.png" alt=""
									style="width: 60px; position: absolute; top: 0%; left: -3%;">
								<img class="perform_img"
									src="./resources/image/PF_PF216819_230415_031912.gif" alt=""
									style="width: 100%;">
								<div class="rank_perform_grid">
									<p class="pt-2 ps-2 align-content-center fs-5 perform_title">
										이머시브씨어터, 카지노</p>
									<div class="perform_starpoint star-container"></div>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">장소 :</p>
									<p class="ps-2 pb-2 perform_theater">대학로스타시티 카지노 전용관</p>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">기간 :</p>
									<p class="ps-2 pb-0 perform_date">2024-09-21 ~ 2024-09-30</p>
									<p style="order: 6;"></p>
									JS로부터 별점을 받아 그리는 필드 (main.js의 drawStars)
								</div>
							</div>




						</div>
					</div>
				</div>





				<!-- 캐러셀 2페이지(주간랭킹 6~10위) -->
				<div class="carousel-item" style="width: 50vw;">
					<div style="width: auto; height: 318px;" class="mx-auto">
						<div id="carousel-container2"
							class="container-fluid bg-gray justify-content-between d-flex ps-5carousel_items"
							style="height: 300px; position: relative; padding-left: 40px; padding-right: 30px;">
							<div
								class="container-fluid border bg-white ps-0 pe-0 carousel_item"
								style="position: relative;">
								<img src="./resources/image/6.png" alt=""
									style="width: 60px; position: absolute; top: 0%; left: -3%;">
								<img class="perform_img"
									src="./resources/image/PF_PF216819_230415_031912.gif" alt=""
									style="width: 100%;">
								<div class="rank_perform_grid">
									<p class="pt-2 ps-2 align-content-center fs-5 perform_title">
										이머시브씨어터, 카지노</p>
									<div class="perform_starpoint star-container"></div>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">장소 :</p>
									<p class="ps-2 pb-2 perform_theater">대학로스타시티 카지노 전용관</p>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">기간 :</p>
									<p class="ps-2 pb-0 perform_date">2024-09-21 ~ 2024-09-30</p>
									<p style="order: 6;"></p>
									<!-- JS로부터 별점을 받아 그리는 필드 (main.js의 drawStars)-->
								</div>
							</div>
							<div
								class="container-fluid border bg-white ms-5 ps-0 pe-0 carousel_item"
								style="position: relative;">
								<img src="./resources/image/7.png" alt=""
									style="width: 60px; position: absolute; top: 00%; left: -3%;">
								<img class="perform_img"
									src="./resources/image/PF_PF216819_230415_031912.gif" alt=""
									style="width: 100%;">
								<div class="rank_perform_grid">
									<p class="pt-2 ps-2 align-content-center fs-5 perform_title">
										이머시브씨어터, 카지노</p>
									<div class="perform_starpoint star-container"></div>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">장소 :</p>
									<p class="ps-2 pb-2 perform_theater">대학로스타시티 카지노 전용관</p>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">기간 :</p>
									<p class="ps-2 pb-0 perform_date">2024-09-21 ~ 2024-09-30</p>
									<p style="order: 6;"></p>
									<!-- JS로부터 별점을 받아 그리는 필드 (main.js의 drawStars)-->
								</div>
							</div>
							<div
								class="container-fluid border bg-white ms-5 ps-0 pe-0 carousel_item"
								style="position: relative;">
								<img src="./resources/image/8.png" alt=""
									style="width: 60px; position: absolute; top: 0%; left: -3%;">
								<img class="perform_img"
									src="./resources/image/PF_PF216819_230415_031912.gif" alt=""
									style="width: 100%;">
								<div class="rank_perform_grid">
									<p class="pt-2 ps-2 align-content-center fs-5 perform_title">
										이머시브씨어터, 카지노</p>
									<div class="perform_starpoint star-container"></div>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">장소 :</p>
									<p class="ps-2 pb-2 perform_theater">대학로스타시티 카지노 전용관</p>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">기간 :</p>
									<p class="ps-2 pb-0 perform_date">2024-09-21 ~ 2024-09-30</p>
									<p style="order: 6;"></p>
									<!-- JS로부터 별점을 받아 그리는 필드 (main.js의 drawStars)-->
								</div>
							</div>
							<div
								class="container-fluid border bg-white ms-5 ps-0 pe-0 carousel_item"
								style="position: relative;">
								<img src="./resources/image/9.png" alt=""
									style="width: 60px; position: absolute; top: 0%; left: -3%;">
								<img class="perform_img"
									src="./resources/image/PF_PF216819_230415_031912.gif" alt=""
									style="width: 100%;">
								<div class="rank_perform_grid">
									<p class="pt-2 ps-2 align-content-center fs-5 perform_title">
										이머시브씨어터, 카지노</p>
									<div class="perform_starpoint star-container"></div>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">장소 :</p>
									<p class="ps-2 pb-2 perform_theater">대학로스타시티 카지노 전용관</p>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">기간 :</p>
									<p class="ps-2 pb-0 perform_date">2024-09-21 ~ 2024-09-30</p>
									<p style="order: 6;"></p>
									<!-- JS로부터 별점을 받아 그리는 필드 (main.js의 drawStars)-->
								</div>
							</div>
							<div
								class="container-fluid border bg-white ms-5 me-5 ps-0 pe-0 carousel_item"
								style="position: relative;">
								<img src="./resources/image/10.png" alt=""
									style="width: 40px; height: 80px; position: absolute; top: 0%; left: 3%;">
								<img class="perform_img"
									src="./resources/image/PF_PF216819_230415_031912.gif" alt=""
									style="width: 100%;">
								<div class="rank_perform_grid">
									<p class="pt-2 ps-2 align-content-center fs-5 perform_title">
										이머시브씨어터, 카지노</p>
									<div class="perform_starpoint star-container"></div>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">장소 :</p>
									<p class="ps-2 pb-2 perform_theater">대학로스타시티 카지노 전용관</p>
									<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">기간 :</p>
									<p class="ps-2 pb-0 perform_date">2024-09-21 ~ 2024-09-30</p>
									<p style="order: 6;"></p>
									<!-- JS로부터 별점을 받아 그리는 필드 (main.js의 drawStars)-->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>


			<div class="carousel-indicators" style="position: relative;">
				<!-- 캐러셀 페이지 버튼 -->
				<button data-bs-target="#rank_carousel" data-bs-slide-to="0"
					class="active" style="background-color: black;"></button>
				<button data-bs-target="#rank_carousel" data-bs-slide-to="1"
					style="background-color: black;"></button>
			</div>

			<!-- 캐러셀 좌우 컨트롤 버튼 -->
			<button class="carousel-control-prev w-auto"
				data-bs-target="#rank_carousel" data-bs-slide="prev">
				<span class="carousel-control-prev-icon"
					style="border-radius: 50%; background-color: gray;"></span>
			</button>
			<button class="carousel-control-next w-auto"
				data-bs-target="#rank_carousel" data-bs-slide="next">
				<span class="carousel-control-next-icon"
					style="border-radius: 50%; background-color: gray;"></span>
			</button>



		</div>
	</div>

	<script>
		let weeklyRankListJson = <%=weeklyRankListJson%>;

		$(document).ready(function(){
// 			console.log("weeklyRankListJson 2 : ", weeklyRankListJson);
			populateCarousel();
			
			const averageRate = $('#average-rate').data('rate');
			console.log("Session averageRate from JSP: ", averageRate);  // 콘솔에서 값 확인
			const parsedRate = parseFloat(averageRate);
			// 평점 값이 유효하다면 별점 그리기
			if (!isNaN(parsedRate)) {
			    drawStars(parsedRate);
				console.log("averageRate : ",parsedRate);
			} else {
			    console.error("Invalid rating value");
			}
		});

		// 캐러셀 컨테이너에 데이터를 채워 넣는 함수
		function populateCarousel() {
			
		    const container1 = document.getElementById('carousel-container1');
		    const container2 = document.getElementById('carousel-container2');
		    
		    container1.innerHTML = ''; // 기존 내용 제거
		    container2.innerHTML = ''; // 기존 내용 제거
		
		    weeklyRankListJson.forEach((item, index) => {

		    	console.log("[weeklyRankListJson] index : ", index);
		    	
					// 항목을 동적으로 생성
					const carouselItem = 
					  '<div onclick="location.href=\'./performDetail/performDetail.jsp?id=' + item.perform.Perform_Detail_id + '\';"' +
					  ' class="container-fluid bg-white ps-0 pe-0 ms-3 me-3 carousel_item"' +
					  ' style="position: relative;">' +
					      
					      '<!-- 숫자 -->' +
					      '<img src="./resources/image/' + (index + 1) + '.png" alt=""' +
					      ' style="width: 30%; position: absolute; left: -4%; top: -1%; border-radius: 10px">' +
					 
					      '<!-- 포스터 ; 연극 이미지 들어가는 태그 -->' +
					      '<img class="perform_img" src="' + item.perform.img_path + '" alt=""' +
					      ' style="height: 100%; border-radius: 10px">' +
					
					      '<!-- 마우스 호버시 세부정보 -->' +
					      '<div class="rank_perform_grid">' +
					          '<p class="pt-2 ps-2 align-content-center fs-5 perform_title">' + item.perform.name + '</p>' +
					          '<div class="perform_starpoint star-container-'+index+'"></div>' +
					          '<p class="ps-2 mb-0 pb-0 fw-bold perform_theater">' + item.venue_name + '</p>' +
					          '<p class="ps-2 pb-2 perform_date">' + item.perform.start.split(' ')[0] + ' ~ ' + item.perform.end.split(' ')[0] + '</p>' +
					      '</div>' +
					  '</div>';

	
		        if(5 > index){
			        container1.innerHTML += carouselItem;
		        }else{
			        container2.innerHTML += carouselItem;
		        }
		        
		        drawStars(item.average_rate, index);
		    });
		}
				
    // JavaScript로 캐러셀 제어
    const carouselInner = document.getElementById('carouselInner');
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');

    let currentIndex = 0;
    const items = document.querySelectorAll('.carousel-item');
    const totalItems = items.length;

    function updateCarousel() {
        const translateX = -currentIndex * 100; // 슬라이드 위치 계산
        carouselInner.style.transform = `translateX(${translateX}%)`;
    }

    if(nextBtn != null){
        nextBtn.addEventListener('click', () => {
            currentIndex = (currentIndex + 1) % totalItems;
            updateCarousel();
        });
    }

    if(prevBtn != null){
        prevBtn.addEventListener('click', () => {
            currentIndex = (currentIndex - 1 + totalItems) % totalItems;
            updateCarousel();
        });
    }
    
</script>

</body>
</html>