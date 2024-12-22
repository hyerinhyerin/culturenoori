<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<link
  href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
  rel="stylesheet"
  integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
  crossorigin="anonymous"
/>
<script src="${pageContext.request.contextPath}/resources/js/header.js"></script>
<script
  src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
  integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
  crossorigin="anonymous"
></script>

<div id="search_bar">
  <form id="search" class="col-12 col-lg-auto mb-3 mb-lg-0" role="search">
    <input
      type="text"
      id="myInput"
      placeholder="제목을 검색하세요"
      aria-label="Search"
    />
    <input class="btn" type="submit" value="검색" />
    <span id="searchIcon"><i class="fa-solid fa-magnifying-glass fa-lg"></i></span>
  </form>
</div>


                
<!-- 파일 이동할 것 같음 -->
<!-- 이동 이후에 스트립트 파일로 빼면 될 것 같음  -->
<script>
  document
    .querySelector("#search")
    .addEventListener("submit", function (event) {
      event.preventDefault();
      const query = document.querySelector("#myInput").value;

  		console.log('[header_filter] submit : ', query);
//   		데이터 로드
			loadPerformList();
			location.href="${pageContext.request.contextPath}/main.jsp#list_subtitle";
    });
  
  document.querySelector("#searchIcon").addEventListener('click', function(){
	  document.querySelector("#search").dispatchEvent(new Event("submit"));
  });
</script>
