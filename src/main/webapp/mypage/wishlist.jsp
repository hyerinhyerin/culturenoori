<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="./wishlistProc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지_관심목록</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
	    />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<link rel="stylesheet" href="../resources/css/header.css" />
    <link rel="stylesheet" href="../resources/css/footer.css" />
    <link rel="stylesheet" href="../resources/css/wishlist.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
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
                        >회원 정보 관리</a
                        >
                        <a href="./wishlist.jsp"
                                style="text-decoration: underline">관심 목록 ></a>
                        <a href="./activity.jsp">내 활동</a>
                    </div>
                </div>
                <div id="section-content">
                	<div id="wish_content">
<!--                 		<div class="wish_content_img"> -->
<%--                 			<img src="${perform.img_path}" alt="${perform.name}" style="width: 100px; height: 100px" /> --%>
<!--                 		</div> -->
<%--                 		<div class="wish_content_title"><p>${perform.name}</p></div> --%>
<%--                 		<div class="wish_content_date"><p>${perform.start.split(" ")[0]} ~ ${perform.end.split(" ")[0]}</p></div> --%>
<!--                 		<button value="취소">취소</button> -->
                	</div>
                </div>
            </div>
        </div>
    </section>
    </div>
    
    <script>
    	let myWishListJson = <%= myWishListJson %>;
   		const container = document.getElementById('wish_content');
   		console.log("[myWishListJson] container : "+container);
    	
    	$(document).ready(function(){
    		myWishListFs();
    	});
    	
    	function myWishListFs() {
    	    container.innerHTML = '';

    	    myWishListJson.forEach((perform, index) => {
    	    	let statusClass = '';
    	    		switch(perform.state){
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
   	    		
    	        const wishListItem =
    	        	'<div class="d-flex border-top border-bottom list_item" ' + 
    	        	'onclick="location.href=\'../performDetail/performDetail.jsp?id=' + perform.perform_detail_id + '\'">' +
	          			'<div class="mx-2 my-auto list_item_img"><img class="align-middle"'+
	                    	'src="'+perform.img_path+'" alt="'+perform.name+'"></div>'+
	            		'<div class="my-auto list_item_detail">'+
	                	'<div class="border '+statusClass+' border-2 rounded-2 perform_status">'+perform.state+'</div>'+
	                	'<p class="mb-4 item_title">'+perform.name+'</p>'+
	                	'<p class="mb-1 item_date"><b>기간</b> : '+perform.start.split(" ")[0]+' ~ '+perform.end.split(" ")[0]+'</p>'+
	                	'<p class="mb-1 item_theater"><b>장소</b> : '+perform.venue_name+'</p>'+
		                '</div>'+
		            '</div>';
    	        	

//     	            '<div class="wish_content_img">' +
//     	                '<img src="'+perform.img_path+'" alt="'+perform.name+'" style="width: 100px; height: 100px" />'+
//     	            '</div>'+
//     	            '<div class="wish_content_title">'+
//     	                '<p>'+perform.name+'</p>'+
//     	            '</div>'+
//     	            '<div class="wish_content_date">'+
//     	                '<p>'+perform.start.split(" ")[0]+' ~ '+perform.end.split(" ")[0]+'</p>'+
//     	            '</div>'+
//     	            // Perform_Detail_id를 버튼에 data-id로 설정
//     	            '<button class="wish_cancel_btn" data-id="'+perform.perform_detail_id+'">취소</button>';

    	        container.innerHTML += wishListItem;
    	    });
    	};
    </script>
    <%@include file="/common/footer.jsp" %>
</body>
</html>