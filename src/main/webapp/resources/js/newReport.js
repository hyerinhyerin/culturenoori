/**
 * 
 */
/////////////////////////////////////////////////////////////////////////
// 
$(document).ready(function() {
	// 신고된 리스트 불러오기
	loadReports();
});

// FIXME:JHK - getContextPath() 공통으로 빼야 한다.
function getContextPath() {
	var hostIndex = window.location.href.indexOf(window.location.host) + window.location.host.length;
	var contextPath = window.location.href.substring(hostIndex, window.location.href.indexOf('/', hostIndex + 1));
	return contextPath;
}

function loadReports() {
	$.ajax({
		type: "POST",
		url: getContextPath() + "/manager/newReportProc.jsp",
		dataType: 'json',
		success: function(res) {
			console.log("[newReport] result : ", res.result);
			console.log("[newReport] reportViews : ", res.reportViews);

			if (res.result) {
				insertReportItem(res.reportViews);
				/////////////////////////////////////////////////////////////////////////
				// 2. 리포트 인포 리스트에 이벤트 붙이기 
				addReportActionEventListeners();
			} else {
				console.log("[reportListProc] failed : ", res.result);
			}
		},
		error: function(e) {
			console.log("[newReport] error : ", e);
		}
	});
}
function insertReportItem(reportViews) {
	const reportList = document.getElementById("new-report-list");
	reportList.innerHTML = "";  // 기존 내용을 비움
	reportViews.forEach(r => {

		// 종류
		let linkKey = '';
		let type = '';

		switch (r.report.type) {
			case "BOARD": {
				linkKey = 'boardId=';
				type = "게시글";
			} break;
			case "COMMENT": {
				// FIXME:JHK - comment 테이블 접근해서, boardid를 얻어야 날아갈 수 있다
				linkKey = 'boardId=';
				type = "댓글";
			} break;
			case "REPLY": {
				// FIXME:JHK - comment 테이블 접근해서, boardid를 얻어야 날아갈 수 있다
				linkKey = 'boardId=';
				type = "답글";
			} break;
			case "REVIEW": {
				// FIXME:JHK - reivew 테이블 접근해서, detailid를 얻어야 날아갈 수 있다
				linkKey = 'id=';
				type = "한줄평";
			} break;
			default:
				break;
		}

		// 신고 날짜
		const date = new Date(r.report.date);
		const formattedDate = `${date.getFullYear()}.${date.getMonth() + 1}.${date.getDate()}`;

		// 링크
		let link = '#';

		if (linkKey === 'boardId=') {
			link = getContextPath() + '/community/boardDetail.jsp?' + linkKey + r.linkId;
			link += '&sort=&category=&searchField=&searchWord=';
		} else if (linkKey === 'id=') {
			link = getContextPath() + '/performDetail/performDetail.jsp?' + linkKey + r.linkId + '&tab=review';
		}

		console.log("linkKey", linkKey);
		console.log("link", link);

//		var reportItem =
//			'<div class="report-item">' +
//			'<a href="' + link + '">' +
//			'<h3>신고자 : ' + r.reporterName + '</h3>' +
//			'<p>작성자 : ' + r.writerName + '</p>' +
//			'<p>종류 : ' + type + '</p>' +
//			'<p>신고내용 : ' + r.report.reason + '</p>' +
//			'<p>신고 날짜 : ' + formattedDate + '</p>' +
//			'</a>' +
//			'<img class="report-pass" data-report-id="' + r.report.id + '"' +
//			' src="../resources/image/report_actionPass.png" alt="신고글 패스" />' +
//			'<img class="report-blind" data-report-id="' + r.report.id + '"' +
//			' src="../resources/image/report_actionBlock.png" alt="신고글 블락" />' +
//			'</div>';
			
			var reportItem = 
			    '<div class="report-item">' +
			        '<div class="border">' +
			            '<div class="column2">' +
			                '<a href="' + link + '">' +
													'<p class="writer"><h4>신고대상 : </h4>'+ r.writerName + '</p>' +
													'<p >-----------------</p>' +
			                    '<p class="reporter"><h4>신 고 자 : </h4>' + r.reporterName + '</p>' +
			                
			            '</div>' +
			            '<div class="column3">' +
											'<p class="write-type"><h3 style="margin-bottom:10px;">구분 : </h3>' + type + '</p>' +
			                '<p class="report-content"><h4 style="color:red;">신고 사유 : </h4>' + r.report.reason + '</p>' +
			            '</div>' +
						'<p class="report-date"><h4>신고일자 : </h4>' + formattedDate + '</p>' +
						'</a>' +
									'<div class="column1">' +
									    '<img class="report-pass" data-report-id="' + r.report.id + '"' +
									    ' src="../resources/image/report_actionPass.png" alt="신고글 패스" />' +
									    '<img class="report-blind" data-report-id="' + r.report.id + '"' +
									    ' src="../resources/image/report_actionBlock.png" alt="신고글 블라인드" />' +
									'</div>' +
			        '</div>' +
			    '</div>';
			
		reportList.innerHTML += reportItem;  // 새로운 항목을 추가
	});
}
function removeReportItem(reportId) {
	const reportItem = document.querySelector(`.report-item img[data-report-id="${reportId}"]`).closest('.report-item');
	if (reportItem) {
		reportItem.remove();
	} else {
		console.log('Report item not found');
	}
}
/////////////////////////////////////////////////////////////
// 신고 처리 버튼 이벤트 등록
function addReportActionEventListeners() {
	// .report-pass
	document.querySelectorAll('.report-pass').forEach(icon => {
		icon.addEventListener('click', function() {
			const reportId = this.getAttribute('data-report-id');
			confirmReportAction(reportId, 'pass');
		});
	});
	// .report-blind
	document.querySelectorAll('.report-blind').forEach(icon => {
		icon.addEventListener('click', function() {
			const reportId = this.getAttribute('data-report-id');
			confirmReportAction(reportId, 'blind');
		});
	});
}


function confirmReportAction(reportId, states) {

	console.log("confirmReportAction reportId : ", reportId);
	console.log("confirmReportAction states : ", states);

	let ask = 'pass or blind?';
	if (states === 'pass') {
		ask = '신고 사항을 "pass" 처리 하시겠습니까?';
	} else if (states === 'blind') {
		ask = '신고 사항을 "blind" 처리 하시겠습니까?';
	}
	
	
	openPopupInput({
		title: ask,
		placeholder: '신고 내용을 적어주세요',
		onConfirm: function(content) {
			console.log('확인 클릭:', content);
			if (content === '') {
				alert('처리 사유를 입력하세요.');
				return;
			}
			
			$.ajax({
				type: "POST",
				url: getContextPath() + "/manager/reportActionProc.jsp",
				data: {
					reason: content,
					states: states,
					reportId: reportId
				},
				dataType: 'json',
				success: function(res) {
					if (res.result) {
						// 목록에서 제거 작업
						removeReportItem(reportId);
					} else {
						alert("신고처리에 실패했습니다.");
					}
				},
				error: function() {
					alert("에러가 발생했습니다. 다시 시도해 주세요.");
				}
			});
		},
		onCancel: function() {
		 	console.log('팝업 닫기 취소');
		}
	});



}




