/**
 * 
 */
/////////////////////////////////////////////////////////////////////////
// 
$(document).ready(function() {
	// 신고치러된 리스트 불러오기
	loadReportActionList();
});
// FIXME:JHK - getContextPath() 공통으로 빼야 한다.
function getContextPath() {
	var hostIndex = window.location.href.indexOf(window.location.host) + window.location.host.length;
	var contextPath = window.location.href.substring(hostIndex, window.location.href.indexOf('/', hostIndex + 1));
	return contextPath;
}
function loadReportActionList() {
	$.ajax({
		type: "POST",
		url: getContextPath() + "/manager/completeReportProc.jsp",
		dataType: 'json',
		success: function(res) {
			console.log("[completeReport] result : ", res.result);
			console.log("[completeReport] actionInfos : ", res.actionInfos);

			if (res.result) {
				// 리스트 만들기
				insertReportActionItem(res.actionInfos);
			} else {
				console.log("[reportListProc] failed : ", res.result);
			}
		},
		error: function(e) {
			console.log("[newReport] error : ", e);
		}
	});
}


function insertReportActionItem(reportActionViews) {
	const reportList = document.getElementById("complete-report-list");
	reportList.innerHTML = "";  // 기존 내용을 비움
	reportActionViews.forEach(r => {

		// 종류
		let keyValueId = 'boardId=1';
		let type = "한줄평";
		switch (r.report.type) {
			case "BOARD": {
				keyValueId = 'boardId=' + r.report.id;
				type = "게시글";
			} break;
			case "COMMENT": {
				keyValueId = 'boardId=' + r.report.id;
				type = "댓글";
			} break;
			case "REPLY": {
				keyValueId = 'boardId=' + r.report.id;
				type = "답글";
			} break;
			case "REVIEW": {
				keyValueId = 'boardId=' + r.report.id;
				type = "한줄평";
			} break;
			default: type = "한줄평"; break;
		}

		// 처리 내용
		const reason = r.reason;

		// 링크
		let link = getContextPath() + '/community/boardDetail.jsp?' + keyValueId;
		link += '&sort=&category=&searchField=&searchWord=';
		console.log("link", link);

		// 신고 날짜
		const date1 = new Date(r.reportDate);
		const date2 = new Date(r.actionDate);
		const formattedDate1 = `${date1.getFullYear()}.${date1.getMonth() + 1}.${date1.getDate()}`;
		const formattedDate2 = `${date2.getFullYear()}.${date2.getMonth() + 1}.${date2.getDate()}`;

		var reportItem =
			'<div class="reporteditem">' +
			'<a href="' + link + '">' +
			'<div style="width:200px;">'+
			'<p><h4>신고자 : </h4>' + r.reporterName + '</p>' +
			'<p>------------------</p>'+
			'<p><h4>작성자 : </h4>' + r.writerName + '</p>' +
			'</div>'+
			'<div style="width:300px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">'+
			'<p"><h3>구분 : </h3>' + type + '</p>' +
			'<p style="height:10px;"></p>' +
			'<p><h4 style="color:blue;">처리내용 : </h4>' + reason + '</p>' +
			'</div>'+
			'<p><h4>신고 날짜 : </h4>' + formattedDate1 + '</p>' +
			'<p><h4>처리 날짜 : </h4>' + formattedDate2 + '</p>' +
			'</a>' +
			'</div>';
		reportList.innerHTML += reportItem;  // 새로운 항목을 추가
	});
}

















