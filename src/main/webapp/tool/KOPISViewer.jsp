<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
System.out.println("ContextPath : " + request.getContextPath());
System.out.println("RealPath : " + application.getRealPath("/"));
%>


<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <link rel="stylesheet" href="./css/tab.css">
<!--     <script type="text/javascript"> -->
<%-- 		var imageRealPath = <%= imageRealPath %>; --%>
<!--     </script> -->
	<script src="./js/event.js"></script>

    <title>KOPIS APIs Viewer</title>

  </head>
  <body>	
    <!-- ================================================================================= -->
	<!-- TAPs MENU -->
    <div class="tab-menu">
      <button class="tab-link active" onclick="openTab(event, 'Tab1')">
        KOPIS
      </button>
      <button class="tab-link" onclick="openTab(event, 'Tab2')">
        DataBase
      </button>
      <br />
    </div>
    <!-- ================================================================================= -->
	<!-- TAB1 > Search -->
    <div id="Tab1" class="tab-content active">
      <div class="form-search">
        <form method="post">
          <label for="startday">시작일 : </label>
          <input type="date" id="startday" name="startday" />
          <label for="endday">종료일 : </label>
          <input type="date" id="endday" name="endday" /><br />
          <label for="page">요청 페이지 : </label>
          <input
            type="number"
            id="page"
            name="page"
            value="1"
            min="1"
            max="20"
          />
          <label for="numOfpage">페이지당 목록 수 : </label>
          <input
            type="number"
            id="numOfpage"
            name="numOfpage"
            value="4"
            min="100"
            max="1000"
            step="100"
          /><br />
          <label for="shcate">장르코드 : </label>
          <select name="shcate" id="shcate">
            <option value="">전체</option>
            <option value="AAAA">연극</option>
            <option value="BBBC">무용(서양/한국무용)</option>
            <option value="BBBE">대중무용</option>
            <option value="CCCA">서양음악(클래식)</option>
            <option value="CCCC">한국음악(국악)</option>
            <option value="CCCD">대중음악</option>
            <option value="EEEA">복합</option>
            <option value="EEEB">서커스/마술</option>
            <option value="GGGA">뮤지컬</option>
          </select>
          <br />
          <button type="button" id="submitBtn" onclick="button_load_api()">API에서 불러오기</button>
          <button type="button" id="insertDbBtn" onclick="button_insertAll_to_db()">DB에 반영하기</button>
          <button type="button" id="clearDbBtn" onclick="button_deletAll_to_db()">DB 내용 지우기</button>
        </form>
      </div>
      <hr />
      	<div>
      	<button id = "history-goto-list" onclick="history_goto_list()"> Goto List</button>
      	<button id = "history-goto-detail" onclick="history_goto_detail()"> Goto Detail</button>
      	</div>
		<!-- ================================================================================= -->
		<!-- TAB1 > result-list -->
      	<div id="result-list"></div>
      	<div id="result-detail"></div>
      	<div id="result-theater"></div>
    </div>
    <!-- ================================================================================= -->
	<!-- TAB2 Buttons -->
    <div id="Tab2" class="tab-content">
	  <div class="form-db-filter">
        <form method="post">
          <label for="prfstate">상태 : </label>
          <select name="prfstate" id="prfstate">
            <option value="">전체</option>
            <option value="공연중">공연중</option>
            <option value="공연예정">공연예정</option>
            <option value="공연완료">공연완료</option>
          </select>
          <label for="sortdate">정렬 : </label>
          <select name="sortdate" id="sortdate">
            <option value="ASC">최신순</option>
            <option value="DESC">오래된순</option>
          </select>
          <br/>
          
          <label for="showPage">요청 페이지 : </label>
          <input type="number" id="showPage" name="showPage" value="1" min="1" />
          <label for="searchword">검색 : </label>
          <input type="text" name="searchword" id="searchword">
          <br/>
          <button type="button" id="loadToDbBtn" onclick="btnLoadFromDB()">DB에서 불러오기</button>
          <button type="button" id="clearDbBtn" onclick="btnClearPage()">화면 지우기</button>
        </form>
      </div>
		<!-- ================================================================================= -->
		<!-- TAB2 > "db-result-list" -->
	    <div id="db-result-list">
	    </div>
    </div>
    <!-- ================================================================================= -->
	<!-- TAB script -->
    <script src="./js/tab.js"></script>
  </body>
</html>












