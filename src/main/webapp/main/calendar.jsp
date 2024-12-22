<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="./calendarProc.jsp"%>

<head>
<style>
table{
	border:solid 1px gray;
}
thead{
	background-color: darkgray;
}
th{
	height: 40px;
}
th, tr, td{
	border: solid 1px gray;
	text-align: center;
}
td {
	width: 70px;
	height: 70px;
	vertical-align: middle;
}


/* 공연이 있는 날짜 배경색 */
.perform-day {
	background-color: #87c8db;  /* 공연이 있는 날짜 배경을 빨간색으로 */
	color: black;           /* 글자 색상 흰색 */
}

/* 선택된 날짜 테두리 */
.selected-day {
 	border: 2px solid blue; /* 선택된 날짜 테두리 파란색 */ 
 	background-color: #ffdd57; 
 	box-sizing : border-box; 
 	padding : 4px; 
}

/* 공연 리스트 출력 영역 */
#selected-day {
	font-size: 14px;
}

.calendar_pointer {
	cursor: pointer;
}

#eventList {
	overflow-y: scroll;
	width: 500px;
	height: 350px;
}
#eventList::-webkit-scrollbar{
	width:15px;
}
#eventList::-webkit-scrollbar-thumb{
	background-color:#82b3f7;
	border-radius:10px;
}

#eventList::-webkit-scrollbar-track{
	background-color:rgba(255,255,255,0);
	border-radius:10px;
}

#eventList > li {
	padding-bottom: 10px;
}

</style>

</head>



<!-- <html> -->


<!-- <title>JSP Calendar</title> -->

<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<script>
	let currentYear = <%=year%>;
	let currentMonth = <%=month%>;
	
	let dayInPerformList = <%=dailyPerformList.toString()%>;
	let selectedElement = null;
	
	function showDetails(day) {
		
		console.log("day : " + day);

	    // 선택한 날짜에 테두리 적용
	    if (selectedElement) {
	        selectedElement.classList.remove('selected-day');
	    }
	
	    const dayElement = document.getElementById('day-' + day);
	    if (dayElement) {
	        dayElement.classList.add('selected-day');
	        selectedElement = dayElement;
	    }
	
	    // 공연 이름 리스트를 출력
	    let eventTitleElement = document.getElementById('selectedDate');
	    eventTitleElement.innerHTML = day + '일 공연 정보<br>';

	    let performListElement = document.getElementById('eventList');
	    performListElement.innerHTML = "";
	
	    const performs = dayInPerformList[day];
	    if (performs && performs.length > 0) {
	        performs.forEach(perform => {
	        	 // 공연 이름에 클릭 이벤트 추가
	        	 let uri = getContextPath() + "/performDetail/performDetail.jsp?id=" + perform.detailId;
	           performListElement.innerHTML += "<li class=\"calendar_pointer\" onclick=\"location.href='" + uri + "'\">" + perform.name + "</li>";
	        });
	    } else {
	        performListElement.innerHTML = "<li>공연 없음</li>";
	    }
	}
	

	function changeMonth(delta) {

		  // 현재 년도와 월을 가져옵니다.
		  console.log("currentYear currentMonth : ", currentYear, currentMonth);
	    let changeYear = currentYear;
		  let changeMonth = currentMonth;
		  
	    // 월을 변경합니다.
	    changeMonth += delta;

	    // 월이 1~12 범위를 넘지 않도록 조정합니다.
	    if (changeMonth < 1) {
	    	changeMonth = 12;
	        changeYear--;
	    } else if (changeMonth > 12) {
	    	changeMonth = 1;
	        changeYear++;
	    }
	    
	    console.log("changeMonth click : ", changeYear, changeMonth);
	    
	 		// AJAX 요청 보내기
	 		let url = getContextPath() + "/main/calendarProcChangeMonth.jsp";
	    $.ajax({
	        url: url,
	        type: 'GET',
	        data: {
	            year: changeYear,
	            month: changeMonth
	        },
	        dataType: "json",
	        success: function(response) {
	    	    console.log("changeMonth response ", response.year, response.month);
		          
	    	    currentYear = response.year;
	    	    currentMonth = response.month;
	    	    dayInPerformList = response.dailyPerformList;
	    	    
	    	    // 새로운 달력 HTML을 #calendarContainer에 삽입
            $('#calendarContainer').html(response.calendarHtml);
	    	    
            // 연도와 월을 업데이트
            $('span#currentMonth').text(response.year + '년 ' + response.month + '월');
	            
	        },
	        error: function(xhr, status, error) {
	            console.error("AJAX Error: " + status + error);
	        }
	    });
	}

			
</script>


<!-- <body> -->
	<div class="container-fluid d-flex w-100 justify-content-between px-5 pb-3 pt-3">
		<!-- 아래는 좌측 캘린더 -->
		<div
			class="border rounded-5 bg-white mx-auto mt-3 p-3 d-flex justify-content-center opacity:50"
			style="opacity: 90%; box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.5);">
			<div class="justify-content-center mx-5">
				<div class="controls justify-content-center">



					<h1 class="d-flex justify-content-center">
						<button class="btn btn-light" onclick="changeMonth(-1)">◀</button>
						<span id="currentMonth" style="margin: 0 20px; font-family:'SeoulNamsanM'; "><%=year%>년
							<%=month%>월</span>
						<button class="btn btn-light" onclick="changeMonth(1)">▶</button>
					</h1>

					<div id='calendarContainer'>
					
						<%
						// 중복 코드 존재한다. 추후 정리필요 generateCalendarHtml()
						out.println("<table class='w-100'>");
						out.println(
								"<thead><tr><th>Sun</th><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th></tr></thead>");
						out.println("<tbody><tr>");

						for (int i = 1; i < startDay; i++) {
							out.println("<td></td>");
						}

						for (int day = 1; day <= lastDay; day++) {
							// 공연이 있는 날짜 확인
							List<PerformDTO> performs = dayInPerformList.get(day);
							boolean hasPerform = performs != null && !performs.isEmpty();

							// 공연이 있는 날짜는 배경색 다르게 표시
							String tdClass = hasPerform ? "perform-day" : "";
							out.println("<td  class=\"calendar_pointer "+tdClass+"\" id='day-" + day + "'" + tdClass + " onclick='showDetails(" + day + ")'>");

							out.println(day);

							if (hasPerform) {
								// 공연이 있는 날짜에 아이콘 또는 표시를 추가
								out.println("<div class='event-indicator'>•</div>");
							}

							out.println("</td>");

							if ((startDay + day - 1) % 7 == 0) {
								out.println("</tr><tr>");
							}
						}
						out.println("</tr></tbody>");
						out.println("</table>");
						%>
					</div>


				</div>
			</div>


			<!-- 우측 Detail부분 -->
			<div id="detail_container"
				class="border bg-white rounded-5 mx-5 mt-3 d-flex justify-content-center"
				style="width: 525px; font-family:'SeoulNamsanM'; opacity: 90%;">
				<div id="detail" class="p-3 justify-content-center">
					<h2 class="d-flex justify-content-center mb-3" id="selectedDate">
						확인하실 일정을 클릭해 주세요</h2>
					<p id="item_1" style="width: 400px;" class="m-0"></p>
					<ul id="eventList">
						<!-- 여기에 선택된 날짜의 일정을 표시하세요. -->
					</ul>
				</div>
			</div>


		</div>
<!-- </body> -->

<!-- </html> -->






