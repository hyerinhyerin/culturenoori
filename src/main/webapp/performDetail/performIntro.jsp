<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Perform Detail</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/performDetail.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/performIntro.css">

<%-- <script defer src="${pageContext.request.contextPath}/resources/js/tabmenu.js"></script> --%>

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
	<div class="border mx-auto perform_info_container">
		<!-- 이미지가 들어갈 영역 -->
		<div class="info_img">
			<%-- 			<img class="mx-auto" src="${detail.img_path}" alt="안보여2"> --%>
		</div>
	</div>

	<script>
	$(document).ready(function(){
		console.log("[performIntro.jsp] ready~");
		
    	let imgPaths = '${detail.img_path}'.split(',');

      // 이미지를 삽입할 컨테이너를 가져옵니다.
      const container = document.querySelector('.info_img');

      // 컨테이너의 기존 내용을 지웁니다.
      container.innerHTML = '';

      // 이미지 경로를 순회하며 img 요소를 생성합니다.
      imgPaths.forEach(path => {
          const imgElement = document.createElement('img');
          imgElement.src = path.trim(); // 여분의 공백을 제거합니다.
          imgElement.alt = '이미지를 불러올 수 없습니다';
          
          // 동작 오류 확인 필요
//           imgElement.style.display = 'block'; // 블록 요소로 설정합니다.
//           imgElement.style.margin = '10px auto'; // 가운데 정렬합니다.

				// imgElement.classList.add('mx-auto'); // 필요한 클래스를 추가합니다.
          container.appendChild(imgElement);
      });
	});

	//소개 이미지 없을 때 메인 포스터 가져오기 도전
// 	$(document).ready(function(){
// 		console.log("[performIntro.jsp] ready~");
		
//         // 이미지를 삽입할 컨테이너를 가져옵니다.
//         const container = document.querySelector('.info_img');

//         // 컨테이너의 기존 내용을 지웁니다.
//         container.innerHTML = '';
//         let	imgPaths = null;
        
// 		if('${detail.img_path}' == null){
// 			imgPaths = '${perform.img_path}';
// 			const performImgElement = document.createElement('img');
// 			performImgElement.src=imgPaths;
// 			performImgElement.alt ='이미지를 불러올 수 없습니다.'
// 			container.appendChild(performImgElement);
// 		}else{
// 			imgPaths = '${detail.img_path}'.split(',');
// 		      // 이미지 경로를 순회하며 img 요소를 생성합니다.
// 		      imgPaths.forEach(path => {
// 		          const imgElement = document.createElement('img');
// 		          imgElement.src = path.trim(); // 여분의 공백을 제거합니다.
// 		          imgElement.alt = '이미지를 불러올 수 없습니다';
		          
// 		          // 동작 오류 확인 필요
// //		           imgElement.style.display = 'block'; // 블록 요소로 설정합니다.
// //		           imgElement.style.margin = '10px auto'; // 가운데 정렬합니다.

// 						// imgElement.classList.add('mx-auto'); // 필요한 클래스를 추가합니다.
// 		          container.appendChild(imgElement);
// 		      });
// 		}



// 	});
	
	</script>
</body>
</html>