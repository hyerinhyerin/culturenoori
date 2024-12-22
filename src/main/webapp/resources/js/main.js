
let isLoading = false;
let currentPage = 1;

//주간 랭킹 마우스 이벤트
$(document).ready(function() {	//JQuery 사용을 위한 준비

	// jQuery load 에러 감지용
	if (typeof jQuery !== "undefined") {
		console.log("jQuery is loaded");
	} else {
		console.error("jQuery is not loaded");
	}

	// 스크롤 이벤트
	$(window).scroll(function() {

		// 무한 스크롤
		// 페이지 하단에 도달했을 때
		if ($(window).scrollTop() + $(window).height() >= $(document).height() - 300) {
			if (!isLoading) {
				isLoading = true;
				currentPage++;
				
				console.log("스크롤 하단을 감지, 요청할 페이지 : ", currentPage);
				
				loadMorePerformList();
			}
		}
	});


	$(document).on('mouseenter', '.carousel_item', function() {	//마우스가 올라갔을 때 Class가 carousel_item 대상으로 실행하는 함수
		//첫번째 이미지(숫자랭킹 이미지)를 제외한 나머지 영역에서만 작동하기위한 조건
		$(this).find('.rank_perform_grid').addClass('bgchange');
		$(this).find('.perform_title').addClass('title_change');
		$(this).find('.perform_theater').addClass('display');
		$(this).find('.perform_date').addClass('display');
		$(this).find('.perform_starpoint').addClass('stardisplay');		//현재 마우스가 올라간 요소 대상으로 Class 추가하여 css 적용

	});

	$(document).on('mouseleave', '.carousel_item', function() {	//위와 반대작용

		$(this).find('.rank_perform_grid').removeClass('bgchange');
		$(this).find('.perform_title').removeClass('title_change');
		$(this).find('.perform_theater').removeClass('display');
		$(this).find('.perform_date').removeClass('display');
		$(this).find('.perform_starpoint').removeClass('stardisplay');

	});

	// perform list 불러오기
	loadPerformList();

	// 제거 대상?
	// calendar data load
//	loadCanendarData();
	
});

//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
// 제거 대상?
//function loadCanendarData(){
//	
//	const url = getContextPath() + "/main/mainProc.jsp";
//	const data = {
//		month: 10
//	};
//
//	console.log("[loadCanendarData.url] : ", url);
//	console.log("[loadCanendarData.data] : ", data);
//
//	$.ajax({
//			type: "POST",
//			url: url,
//			data: data,
//			dataType: "json",
//			success: function(response) {
//				console.log("[loadCanendarData.response] ", response);
//				callbackSuccess(response);
//			},
//			error: function(jqXHR, textStatus, errorThrown) {
//				console.error("[loadCanendarData] AJAX Error: ", textStatus, errorThrown);
//				callbackError();
//			},
//		});
//}

// perform list 데이터를 불러오는 함수
function loadPerformList() {
	// 초기화
	currentPage = 1;

	console.log("[loadPerformList]~");
	requestPerformList(
		function(response) {
			console.log("[loadPerformList.performListToDOM]~");
			performListToDOM(response, false);
		},
		function(){
			// none
		}
	);
}
// 무한 스크롤용 데이터 불러오기
function loadMorePerformList() {

		console.log("[loadMorePerformList]~");

		requestPerformList(	function(response) {

			console.log("[loadMorePerformList.performListToDOM]~");

			performListToDOM(response, true);
			
			isLoading = false; // 로딩 상태 해제
		}, function() {
			isLoading = false; // 오류 발생 시에도 로딩 상태 해제
		}
	);
}
// 데이터 요청 공통
function requestPerformList(callbackSuccess, callbackError) {
	const url = getContextPath() + "/main/mainProc.jsp";
	const data = {
		perform_state: getPerformState(),
		search_keyword: getSearchKeywordValue(),
		currentPage: currentPage
	};

	console.log("[loadPerformList.data] ", data);
	console.log("[loadPerformList.url] ", url);

	$.ajax({
		type: "POST",
		url: url,
		data: data,
		dataType: "json",
		success: function(response) {
			console.log("[ loadPerformList.response ] ", response);
			callbackSuccess(response);
		},
		error: function(jqXHR, textStatus, errorThrown) {
			console.error("[ loadPerformList ] AJAX Error: ", textStatus, errorThrown);
			callbackError();
		},
	});
}
// 받은 데이터 톰에 추가
function performListToDOM(response, isAppend) {
	// 정리 필요
	// HTML 요소를 초기화 (필요 시)
	console.log("[performListToDOM] response : ", isAppend, response);
	
	const container = document.getElementById('performList_container');

    const totalRequiredItems = 12; // 최소로 채워야 하는 항목 수
    const itemsPerRow = 4; // 한 줄에 표현할 항목 개수
    
    // HTML 요소를 초기화 (필요 시)
	if (!isAppend) {
		if(container === null){
			console.log("[performListToDOM] getElementById('performList_container') is null");
		}else{
			container.innerHTML = ''; // 기존 내용 삭제 (옵션)
		}
	}
	
	// 불러온 데이터 갯수
    let totalItems = response.data.length;
    // response.data 배열을 반복하여 HTML 생성
    response.data.forEach((item, index) => {
		let statusClass = '';
		    switch (item.perform.state) {
		        case '공연중':
		            statusClass = 'border-success bg-success text-white fw-bold'; // 공연중은 green
		            break;
		        case '공연예정':
		            statusClass = 'border-primary bg-primary text-white fw-bold'; // 공연예정은 blue
		            break;
		        case '공연완료':
		            statusClass = 'border-danger bg-danger text-white fw-bold'; // 공연완료는 red
		            break;
		        default:
		            statusClass = 'border-secondary'; // 기본값 (예: 미정 상태)
		            break;
		    }
        const itemHTML = `
            <div class="d-flex border-top border-bottom list_item" 
                onclick="location.href='./performDetail/performDetail.jsp?id=${item.perform.Perform_Detail_id}';">
                <!-- 이미지 파일을 불러올 공간 -->
                <div class="mx-2 my-auto list_item_img">
                    <img class="align-middle" src="${item.perform.img_path}" alt="${item.perform.name}">
                </div>
                <!-- 이미지의 상세 정보를 표현할 부분 -->
                <div class="my-auto list_item_detail">
                    <div class="border border-2 rounded-2 ${statusClass} perform_status">${item.perform.state}</div>
                    <p class="mb-2 item_title">${item.perform.name}</p>
					<div class="mb-2 list_perform_starpoint list-star-container-${index}"></div>
                    <p class="mb-1 item_date"><b>기간</b> : ${item.perform.start.split(" ")[0]} ~ ${item.perform.end.split(" ")[0]}</p>
                    <p class="mb-1 item_theater"><b>장소</b> : ${item.venue_name} </p>
                </div>
            </div>
        `;
        // 각 항목을 컨테이너에 추가
        if (container === null) {
            console.log("[performListToDOM] getElementById('performList_container') is null");
        } else {
            container.innerHTML += itemHTML;
//			console.log("[mainProc] item.averageRate : ",item.averageRate);
			drawStar(item.average_rate, index);
        }
    });

    // 불러온 데이터가 12개 미만인 경우, 빈 항목 추가
    if (totalItems < totalRequiredItems && currentPage == 1) {
        let emptyItemsToAdd = totalRequiredItems - totalItems;
        for (let i = 0; i < emptyItemsToAdd; i++) {
            const emptyItemHTML = `
                <div class="d-flex border-top border-bottom list_item empty_item">
                    <div class="mx-2 my-auto placeholder-wave">
                        <div class="placeholder" style="width:101px; height:142px;"></div>
                    </div>
                    <div class="my-auto placeholder-wave">
                        <div class="placeholder" style="width:50px; margin-bottom:10px;"></b></div>
                        <p class="placeholder" style="width:250px; font-size:20px; margin-bottom:25px;">d</p>
                        <p class="placeholder" style="width:250px; margin-bottom:10px;"></p>
                        <p class="placeholder" style="width:250px;"></p>
                    </div>
                </div>
            `;
            container.innerHTML += emptyItemHTML;
        }
    }
    
    //temp~

	// response.data 배열을 반복하여 HTML 생성
//	response.data.forEach(item => {
//		// getContextPath() 사용해야 하나?
//		// location.href='./performDetail/performDetail.jsp
//		const itemHTML = `
//			        <div class="d-flex border-top border-bottom list_item" 
//			            onclick="location.href='./performDetail/performDetail.jsp?id=${item.perform.Perform_Detail_id}';">
//			            <!-- 이미지 파일을 불러올 공간 -->
//			            <div class="mx-2 my-auto list_item_img">
//			                <img class="align-middle" src="${item.perform.img_path}" alt="${item.perform.name}">
//			            </div>
//			            <!-- 이미지의 상세 정보를 표현할 부분 -->
//			            <div class="my-auto list_item_detail">
//			                <div class="border border-danger border-2 rounded-2 perform_status">${item.perform.state}</div>
//			                <p class="mb-4 item_title">${item.perform.name}</p>
//			                <p class="mb-1 item_date"><b>기간</b> : ${item.perform.start.split(" ")[0]} ~ ${item.perform.end.split(" ")[0]}</p>
//											<p class="mb-1 item_theater"><b>장소</b> : ${item.venue_name} </p>
//											<p class="mb-1 item_theater"><b>평점</b> : ${item.average_rate} </p>
//			            </div>
//			        </div>
//			    `;
//		// 각 항목을 컨테이너에 추가
//		if(container === null){
//			console.log("[performListToDOM] getElementById('performList_container') is null");
//		}else{
//			container.innerHTML += itemHTML;
//		}
//	});
	// temp
}
function drawStar(rating, index) {
	const starContainers = document.querySelectorAll('.list-star-container-'+index);
	const ratingNumber = document.createElement('strong');
	ratingNumber.innerText = `(${rating.toFixed(1)} / 5.0)`;
	starContainers.forEach(starContainer => {
		starContainer.innerHTML = ''; // 초기화

		for (let i = 0; i < 5; i++) {
			const star = document.createElement('span');  //별을 그리기 위한 span태그를 생성하여 star 변수에 저장
			star.classList.add('rating_star');						//생성된 span에 star 클래스(회색 별) 5개를 반복문으로 생성
			star.innerHTML = '★';							//내용은 별모양
			//rating값은 외부에서 받아올 평점이 들어갈 부분
			if (i < Math.floor(rating)) {					//rating을 소수점 내림하여 정수부분만 가져와서 비교
				star.classList.add('filled');				//해당되는 값만 전체색상을 칠하는 class 추가  => ex)3.7을 받을 경우 별 3개는 완전하게 칠한다.
			} else if (i < rating) {						//3.7일 경우 3보다 크고 4보다 작은 부분에 해당될 때
				const percentage = (rating - i) * 100;		//percentage 변수에 정수를 뺀 소숫점 부분에 100을 곱하여 %값을 구함
				star.classList.add('partial-filled');		//해당되는 별에는 부분칠하기 클래스를 추가
				star.style.background = `linear-gradient(90deg, #daa520 ${percentage}%, #ccc ${percentage}%)`;
				star.style.webkitBackgroundClip = 'text';
				star.style.webkitTextFillColor = 'transparent';
			}
			starContainer.appendChild(star);
			//위의 조건이 아닌 별(3.7일때 5번째 별)은 빈 별로 생성한다.
		}
		starContainer.appendChild(ratingNumber);
	});
}
// 투트 경로 얻는 코드 
function getContextPath() {
	var hostIndex = window.location.href.indexOf(window.location.host) + window.location.host.length;
	var contextPath = window.location.href.substring(hostIndex, window.location.href.indexOf('/', hostIndex + 1));
	return contextPath;
}
// 데이터 롤딩 요청
function clickFilterButton(clickedItem) {
	console.log('Clicked item:', clickedItem.dataset.value);
	loadPerformList();
}
// 선택된 필터 상태를 얻는다 : all, ing, ends, soon
function getPerformState() {
	const item = document.querySelector('.filter_list_item.clicked');
	if (item == null) {
		console.error('.filter_list_item.clicked is null');
		return '';
	}
	// 전체 선택일때는, 서버에 보낼때 빈 문자열을 보내한다.
	if (item.dataset.value === 'all') {
		return '';
	}
	return item.dataset.value;
}
// 검색 키워드를 얻는다.
function getSearchKeywordValue() {
	const item = document.querySelector("#myInput");
	if (item === null) {
		console.error("#myInput is null");
		return ''
	}
	return item.value;
}

//====================================================================================================================
//====================================================================================================================
//====================================================================================================================



//아래 주석처리한 코드는 include가 있을경우 Scroll이 씹히는 경우가 발생했을 때 사용
/*document.addEventListener("DOMContentLoaded", function() {
		if (window.location.hash) {
				const target = document.querySelector(window.location.hash);
				if (target) {
						smoothScrollTo(target.offsetTop, 3000); // 2000ms = 2초
				}
		}
});*/

//주간 랭킹, 공연 목록을 대상으로 화면을 Scroll하는 기능
function smoothScrollTo(targetPosition, duration) {
	const startPosition = window.pageYOffset;	//시작 위치(현재 화면의 Y좌표)
	const distance = targetPosition - startPosition;	//내가 가고자하는 위치에서 현재Y를 뺀 값, 즉 화면이 이동해야 하는 거리 측정
	let startTime = null;

	function animation(currentTime) {
		if (startTime === null) startTime = currentTime;
		const timeElapsed = currentTime - startTime;
		const run = startPosition + (distance * (timeElapsed / duration));
		window.scrollTo(0, run);
		if (timeElapsed < duration) {
			requestAnimationFrame(animation);
		} else {
			window.scrollTo(0, targetPosition);
		}
	}

	requestAnimationFrame(animation);
}

//별점그리기 함수
//1개단위로 채우는건 쉽게 했는데 소숫점단위는 너무 어려워서 일단 AI의 도움을 받았습니다.
//function drawStars(rating) {
//	const starContainers = document.querySelectorAll('.star-container');
//	starContainers.forEach(starContainer => {
//		starContainer.innerHTML = ''; // 초기화
//
//		for (let i = 0; i < 5; i++) {
//			const star = document.createElement('span');  //별을 그리기 위한 span태그를 생성하여 star 변수에 저장
//			star.classList.add('rating_star');						//생성된 span에 star 클래스(회색 별) 5개를 반복문으로 생성
//			star.innerHTML = '★';							//내용은 별모양
//			//rating값은 외부에서 받아올 평점이 들어갈 부분
//			if (i < Math.floor(rating)) {					//rating을 소수점 내림하여 정수부분만 가져와서 비교
//				star.classList.add('filled');				//해당되는 값만 전체색상을 칠하는 class 추가  => ex)3.7을 받을 경우 별 3개는 완전하게 칠한다.
//			} else if (i < rating) {						//3.7일 경우 3보다 크고 4보다 작은 부분에 해당될 때
//				const percentage = (rating - i) * 100;		//percentage 변수에 정수를 뺀 소숫점 부분에 100을 곱하여 %값을 구함
//				star.classList.add('partial-filled');		//해당되는 별에는 부분칠하기 클래스를 추가
//				star.style.background = `linear-gradient(90deg, #f39c12 ${percentage}%, #ccc ${percentage}%)`;	//css 그라데이션 효과를 위에서 받은 퍼센트로 설정
//				star.style.webkitBackgroundClip = 'text';
//				star.style.webkitTextFillColor = 'transparent';
//			}
//			starContainer.appendChild(star);
//			//위의 조건이 아닌 별(3.7일때 5번째 별)은 빈 별로 생성한다.
//		}
//	});
//}

document.addEventListener('DOMContentLoaded', function() {
	var items = document.querySelectorAll('.filter_list_item');

	// 첫 번째 항목을 클릭된 상태로 설정
	if (items.length > 0) {
		items[0].style.backgroundColor = 'lightblue';
		items[0].style.transform = 'scale(1.2)';
		items[0].style.boxSadhow = '5px 5px 10px rgba(0, 0, 0, 0.3)';
		items[0].classList.add('clicked'); // 'clicked' 클래스 추가
	}

	items.forEach(function(item) {
		item.addEventListener('click', function() {
			// 모든 항목의 배경색 초기화
			items.forEach(function(el) {
				el.style.backgroundColor = '';
				el.style.transform = '';
				el.style.boxSadhow = '5px 5px 10px rgba(0, 0, 0, 0.3)';
				el.classList.remove('clicked'); // 'clicked' 클래스 추가
			});

			// 클릭된 항목의 배경색 변경
			this.style.backgroundColor = '#b6d6f2';
			this.style.transform = 'sacle(1.2)';
			this.style.boxSadhow = '5px 5px 10px rgba(0, 0, 0, 0.3)';
			this.classList.add('clicked'); // 'clicked' 클래스 추가

			// 필터 버튼을 눌렀을 경우
			clickFilterButton(this);

		});
	});
});
















