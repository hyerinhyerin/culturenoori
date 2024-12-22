<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
#common-popup-okcancel {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-55%, -50%);
	width: 360px;
	height: auto;
	min-height: 254px;
	background-color: #CBDCF5;
	border-radius: 15px;
	box-shadow: 3px 5px 5px #8c9091;
	display: none; /* 처음엔 숨김 */
	flex-direction: column;
	align-items: center;
	z-index: 9999; /* 최상위 레이어 */
}

#common-popup-okcancel>h3 {
	text-align: center;
	color: rgba(83, 80, 80, 0.96);
	margin-top: 25px;
}

.popup-okcancel-content {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.popup-okcancel-content > textarea {
	resize: none;
	width: 150%; /* 가로 크기 조정 */
	height: 110px; /* 세로 크기 조정 */
	background-color: #CBDCF5;
	justify-content: center;
	text-align: center;
	
  outline: none;
  padding: 10px 0px;
  margin-top: 20px;
  border-radius: 11px;
}

/* 버튼을 인라인으로 배치 */
.popup-okcancel-buttons {
	display: flex;
	justify-content: center;
	gap: 10px; /* 버튼 사이 간격 조정 */
	margin-top: 20px;
}

#popup-okcancel-ok, #popup-okcancel-cancel {
	background-color: #5377ad5e;
	font-size: 13px;
	border: none;
	border-radius: 10px;
	width: 93px;
	height: 30px;
	cursor: pointer;
}
</style>
<!-- 			rows="7" cols="30" -->

<div id="common-popup-okcancel">
	<h3 class="popup-okcancel-title">공통 팝업창</h3>
	<div class="popup-okcancel-content">
		<textarea name="popup-okcancel-content-area" id="popup-okcancel-content-area" readonly></textarea>
		<div class="popup-okcancel-buttons">
			<button type="button" id="popup-okcancel-ok">확인</button>
			<button type="button" id="popup-okcancel-cancel">닫기</button>
		</div>
	</div>
</div>

<script>
	// 팝업 열기 함수
	function openPopupOkCancel(options) {

		const popup = document.getElementById('common-popup-okcancel');
		const titleElement = document.querySelector('.popup-okcancel-title');
		const textarea = document.getElementById('popup-okcancel-content-area');

		// 팝업 내용 설정
		titleElement.innerText = options.title || '공통팝업창';
		textarea.value = options.content || '내용이 보입니다';

		// 확인 버튼 클릭 시 콜백 호출
		document.getElementById('popup-okcancel-ok').onclick = function() {
			if (options.onOk) {
				options.onOk();
			}
			popup.style.display = 'none'; // 팝업 닫기
		};

		// 닫기 버튼 클릭 시 취소 콜백 호출
		document.getElementById('popup-okcancel-cancel').onclick = function() {
			if (options.onCancel) {
				options.onCancel();
			}
			popup.style.display = 'none'; // 팝업 닫기
		};

		// 팝업 열기
		popup.style.display = 'flex';
	}
	
	// 예시 호출
// 	openPopupOkCancel({
// 		title : '111신고하세요',
// 		content : '111신고할 내용을 적어주세요',
// 		onOk : function() {
// 			console.log('Ok 클릭 ');
// 		},
// 		onCancel : function() {
// 			console.log('Cancel 클릭 ');
// 		}
// 	});
	
</script>


		