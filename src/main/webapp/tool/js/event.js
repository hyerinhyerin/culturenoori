/**
 * 
 */

//===================================================================
// loaded done
$(document).ready(function () {
  console.log("ready~~");
  
	var today = new Date();
  var startDay = new Date();
  startDay.setFullYear(today.getFullYear() - 1);
  var todayStr = today.toISOString().split("T")[0];
  var startDayStr = startDay.toISOString().split("T")[0];

  $("#startday").val(startDayStr);
  $("#endday").val(todayStr);

	$("#history-goto-list").hide();
	$("#history-goto-detail").hide();
});
//===================================================================
// API에서 불러오기
function button_load_api(){
	console.log("button_load_api~");
	
	var data = {
	  startday: $("#startday").val(),
	  endday: $("#endday").val(),
	  page: $("#page").val(),
	  numOfpage: $("#numOfpage").val(),
	  shcate: $("#shcate").val(),
	};

	console.log("data : ", data);
	
	$.ajax({
	  type: "POST",
	  url: "./KOPISViewerAPIProcList.jsp",
	  data: data,
	  dataType: "json",
	  success: function (response) {
			$("#result-detail").hide();
			$("#result-theater").hide();
			let targetTag = $("#result-list");
			targetTag.empty();
			targetTag.show();
	    displayJson(response.dbs.db, targetTag);
	  },
	  error: function (jqXHR, textStatus, errorThrown) {
	    console.error("AJAX Error: ", textStatus, errorThrown);
	    alert("에러가 발생했습니다. 다시 시도해 주세요.");
	  },
	});
}
//===================================================================
// aLinkDetail
function aLinkDetail(id){
	console.log("aLinkDetail root click : " + id);
	$("#history-goto-list").show();
	$("#history-goto-detail").hide();

  $.ajax({
    url: "./KOPISViewerAPIProcDetail.jsp?",
    type: "GET",
    data: { id: id },
		dataType: "json",
    success: function (response) {
			$("#result-list").hide();
			$("#result-theater").hide();
			let targetTag = $("#result-detail");
			targetTag.empty();
			targetTag.show();
			displayJson(response.dbs.db, targetTag);
    },
    error: function (xhr, status, error) {
      console.error("Error fetching the link:", error);
    },
  });
}
//===================================================================
// aLinkTheater
function aLinkTheater(id){
	console.log("aLinkTheater root click : " + id);
	$("#history-goto-list").show();
	$("#history-goto-detail").show();

  $.ajax({
    url: "./KOPISViewerAPIProcTheater.jsp?",
    type: "GET",
    data: { id: id },
		dataType: "json",
    success: function (response) {
			$("#result-list").hide();
			$("#result-detail").hide();
			let targetTag = $("#result-theater");
			targetTag.empty();
			targetTag.show();
			displayJson(response.dbs.db, targetTag);
    },
    error: function (xhr, status, error) {
      console.error("Error fetching the link:", error);
    },
  });
}
//===================================================================
// history
function history_goto_list(){
	console.log("history-goto-list click ~~");

	$("#history-goto-list").hide();
	$("#history-goto-detail").hide();

	$("#result-list").show();
	$("#result-detail").hide();
	$("#result-theater").hide();
}
function history_goto_detail(){
	console.log("history-goto-detail click ~~");
	
	$("#history-goto-list").show();
	$("#history-goto-detail").hide();
	
	$("#result-list").hide();
	$("#result-detail").show();
	$("#result-theater").hide();
}
//===================================================================
// displayJson
function displayJson(db, resultTag) {

	let rows = "";
	let indentLevel = 0;
	
	$.each(db, function (key, value) {
	    processValue(key, value);
	});
		
	resultTag.append(rows);

  function processValue(key, value) {
	  if (typeof value === "object" && value !== null) {
      if (Array.isArray(value)) {
	      rows += "<p>" + addIndentation() + "[ " + key + " Array] [</p>";
	      indentLevel++;
	      value.forEach(function (item, index) {
						processValue(index, item);
	      });
	      indentLevel--;
	      rows += "<p>" + addIndentation() + "]</p>";
      } else {
	      rows += "<p>" + addIndentation() + "[ " + key + " Object] {</p>";
	      indentLevel++;
	      $.each(value, function (subKey, subValue) {
	          processValue(subKey, subValue);
	      });
	      indentLevel--;
	      rows += "<p>" + addIndentation() + "}</p>";
      }
	  } else {
			rows += "<p>" + addIndentation() + "[ " + key + "] " + checkKey(key, value) + "</p>";
	  }
  }
	function addIndentation() {
	  return " ".repeat(indentLevel * 4);
	}
	function checkKey(key, value){
		let rows = "";
		console.log("checkKey : " + key +", " + value);
		switch(key){
			case "0":
			case "1":
			case "poster":
			case "img_path":{
//				rows = '<img src="' + value + '" alt="' + value + ' " width=400">';		
			
				const stringValue = String(value); 
				console.log("stringValue : " + stringValue);
				const valueArray = stringValue.split(',');
				valueArray.forEach((url, index)=>{
					rows += '<img src="' + url + '" alt="' + url + ' " width=400">';
					console.log("valueArray url ; " + url);
				});	
				
			}break;
			case "styurl":{  // 소개 이미지들
				rows += '<img src="' + value + '" alt="' + value + ' " width=400">';

//				const stringValue = String(value); 
//				console.log("stringValue : " + stringValue);
//				const valueArray = stringValue.split(',');
//				valueArray.forEach((url, index)=>{
//					rows += '<img src="' + url + '" alt="' + url + ' " width=400">';
//					console.log("valueArray url ; " + url);
//				});
			}break;
			case "relateurl":{ // 예매처 링크
				rows = '<a href="' + value + '" >"' + value +'" </a ">';
			}break;
			case "mt20id":{
				rows = '<h3><a href="#" onclick="aLinkDetail(\'' + value + '\');">' + value + '</a></h3>';
			}break;
			case "mt10id":{// 공연장 링크
				rows = '<h3><a href="#" onclick="aLinkTheater(\'' + value + '\');">' + value + '</a></h3>';
			}break;
			case "Perform_Detail_id":{// 
				rows = '<h3><a href="#" onclick="aLinkDB_DetailId(\'' + value + '\');">' + value + '</a></h3>';
			}break;
		}
		
    if(rows === "")
    	return value;
    return rows;
	}	
}
//===================================================================
//===================================================================
//===================================================================
//===================================================================
//===================================================================
// DB에 반영하기
function button_insertAll_to_db(){
	console.log("button_insertAll_to_db~");
	$.ajax({
	  type: "GET",
	  url: "./KOPISViewerAPIProcInsertDB.jsp",
	  dataType: "json",
	  success: function (response) {
	  	switch(response.result){
	  	case 1:
	        	alert("성공 DataBase 탭에서 확인 가능 합니다.");
	        	break;
	  	case -1:
	        	alert("먼저 KOPIS API를 사용해서 데이터를 불러 오세요.");
	        	break;
	  	}
	  },
	  error: function () {
	    alert("에러가 발생했습니다. 다시 시도해 주세요.");
	  },
	});	
}
//===================================================================
// DB 내용 지우기
function button_deletAll_to_db(){
	console.log("button_deletAll_to_db~");
	$.ajax({
	  type: "POST",
	  url: "./KOPISViewerAPIProcClearDB.jsp",
	  dataType: "json",
	  success: function (response) {
	  	switch(response.result){
	  	case 1:
	        	alert("DB 내용 지우기 성공.");
	        	break;
	  	case 0:
	        	alert("DB 내용 지우기 실패 : " + response.result);
	        	break;
	  	}
	  },
	  error: function () {
	    alert("에러가 발생했습니다. 다시 시도해 주세요.");
	  },
	});	
}
//===================================================================
// btnLoadFromDB
function btnLoadFromDB(){
	console.log("btnLoadFromDB~");
	var data = {
	  prfstate: $("#prfstate").val(),
	  sortdate: $("#sortdate").val(),
		searchword: $("#searchword").val(),
		showPage: $("#showPage").val(),
		shcate: $("#shcate").val()
	};
	
	console.log("data : ", data);
		
		$.ajax({
		  type: "POST",
		  url: "./KOPISViewerDBProcList.jsp",
		  data: data,
		  dataType: "json",
		  success: function (response) {
				console.log(response);
				$("#db-result-list").empty();
				displayJson(response, $("#db-result-list"));
		  },
		  error: function (jqXHR, textStatus, errorThrown) {
		    console.error("AJAX Error: ", textStatus, errorThrown);
		    alert("에러가 발생했습니다. 다시 시도해 주세요.");
		  },
		});
		
}
//===================================================================
// btnClearPage
function btnClearPage(){
	console.log("btnClearPage~");
	$("#db-result-list").empty();
}
//===================================================================
// aLinkDB_DetailId
function aLinkDB_DetailId(id){
	console.log("aLinkDB_DetailId root click : " + id);

  $.ajax({
    url: "./KOPISViewerDBProcDetail.jsp?",
    type: "GET",
    data: { id: id },
		dataType: "json",
    success: function (response) {
			console.log("response : ", response);
			$("#db-result-list").empty();

			console.log("jsonResult : ", response.jsonResult);
			console.log("jsonData : ", response.jsonData);

			$("#db-result-list").empty();
			if(response.jsonResult.result === "success"){
				
				$("#db-result-list").append("===[ detail ]===================================================================");
				displayJson(response.jsonData.detail, $("#db-result-list"));
				$("#db-result-list").append("===[ theater ]===================================================================");
				displayJson(response.jsonData.theater, $("#db-result-list"));
				$("#db-result-list").append("===[ perform ]===================================================================");
				displayJson(response.jsonData.perform, $("#db-result-list"));
				
			}else{
				console.log("response.jsonResult : ", response.jsonResult);
			}
//			displayJson(response.dbs.db, targetTag);
    },
    error: function (xhr, status, error) {
      console.error("Error fetching the link:", error);
    },
  });
}

//===================================================================
//===================================================================
//===================================================================
//===================================================================
	
	