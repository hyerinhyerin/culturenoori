<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/performList.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
<!--     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" -->
<!--         integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"> -->
<!--     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" -->
<!--         integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" -->
<!--         crossorigin="anonymous"></script> -->
</head>

<body>
	<!-- performList 표현을 위하 컨테이너 생성 -->
    <div id="performList_container" class="d-flex py-2 mx-auto border-top border-bottom border-2 border-primary">
<!--     performList_container 밑으로 스크립트에서 넣어주고 있다 -->
    	<!-- vr은 각 항목별 구분을 위한 구분선 -->
        <!-- 1개의 아이템이 들어갈 공간 -->
        <div class="d-flex border-top border-bottom list_item" onclick="location.href='./performDetail/performDetail.jsp';">
        	<!-- 이미지 파일을 불러올 공간 -->
            <div class="mx-2 my-auto list_item_img"><img class="align-middle"
                    src="${pageContext.request.contextPath}/resources/image/PF_PF216819_230415_031912.gif" alt=""></div>
            <!-- 이미지의 상세 정보를 표현할 부분 -->
            <div class="my-auto list_item_detail">
                <div class="border border-danger border-2 rounded-2 perform_status">공연종료</div>
                <p class="mb-4 item_title">이머시브씨어터, 카지노</p>
                <p class="mb-1 item_date"><b>기간</b> : 2023.04.28 ~ 오픈런</p>
                <p class="mb-1 item_theater"><b>장소</b> : 대학로스타시티 카지노 전용 글자수 줄이기 테스트</p>
            </div>
        </div>
        <div class="d-flex border-top border-bottom list_item">
            <div class="mx-2 my-auto list_item_img"><img class="align-middle"
                    src="${pageContext.request.contextPath}/resources/image/PF_PF216819_230415_031912.gif" alt=""></div>
            <div class="my-auto list_item_detail">
                <div class="border border-primary border-2 rounded-2 perform_status">공연예정</div>
                <p class="mb-4 item_title">이머시브씨어터, 카지노</p>
                <p class="mb-1 item_date"><b>기간</b> : 2023.04.28 ~ 오픈런</p>
                <p class="mb-1 item_theater"><b>장소</b> : 대학로스타시티 카지노 전용 글자수 줄이기 테스트</p>
            </div>
        </div>
        <div class="d-flex border-top border-bottom list_item">
            <div class="mx-2 my-auto list_item_img"><img class="align-middle"
                    src="${pageContext.request.contextPath}/resources/image/PF_PF216819_230415_031912.gif" alt=""></div>
            <div class="my-auto list_item_detail">
            	<div class="border border-success border-2 rounded-2 perform_status">공연중</div>
                <p class="mb-4 item_title">이머시브씨어터, 카지노</p>
                <p class="mb-1 item_date"><b>기간</b> : 2023.04.28 ~ 오픈런</p>
                <p class="mb-1 item_theater"><b>장소</b> : 대학로스타시티 카지노 전용 글자수 줄이기 테스트</p>
            </div>
        </div>
        <div class="d-flex border-top border-bottom list_item">
            <div class="mx-2 my-auto list_item_img"><img class="align-middle"
                    src="${pageContext.request.contextPath}/resources/image/PF_PF216819_230415_031912.gif" alt=""></div>
            <div class="my-auto list_item_detail">
            <div class="border border-success border-2 rounded-2 perform_status">공연중</div>
                <p class="mb-4 item_title">이머시브씨어터, 카지노</p>
                <p class="mb-1 item_date"><b>기간</b> : 2023.04.28 ~ 오픈런</p>
                <p class="mb-1 item_theater"><b>장소</b> : 대학로스타시티 카지노 전용 글자수 줄이기 테스트</p>
            </div>
        </div>
        <div class="d-flex border-top border-bottom list_item">
            <div class="mx-2 my-auto list_item_img"><img class="align-middle"
                    src="${pageContext.request.contextPath}/resources/image/PF_PF216819_230415_031912.gif" alt=""></div>
            <div class="my-auto list_item_detail">
            <div class="border border-success border-2 rounded-2 perform_status">공연중</div>
                <p class="mb-4 item_title">이머시브씨어터, 카지노</p>
                <p class="mb-1 item_date"><b>기간</b> : 2023.04.28 ~ 오픈런</p>
                <p class="mb-1 item_theater"><b>장소</b> : 대학로스타시티 카지노 전용 글자수 줄이기 테스트</p>
            </div>
        </div>
    </div>
</body>

</html>