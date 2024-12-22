<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
#common-popup {
	position: fixed; /* 스크롤 상관없이 화면 중앙에 고정 */
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%); /* 완벽한 중앙 정렬 */
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

#common-popup>h3 {
	text-align: center;
	color: rgba(83, 80, 80, 0.96);
	margin-top: 25px;
}

.popup-content {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.popup-content input::placeholder {
	color: #c5d7f2;
	text-align: center;
}

#popup-content-text {
	resize: none;
	outline:none;
  padding: 14px 10px;
  margin-top: 11px;
  border-radius: 10px;
}

/* 버튼을 인라인으로 배치 */
.popup-buttons {
	display: flex;
	justify-content: center;
	gap: 10px; /* 버튼 사이 간격 조정 */
	margin-top: 20px;
}

#popup-ok,
#popup-cancel {
	background-color: #5377ad5e;
	font-size: 13px;
	border: none;
	border-radius: 10px;
	width: 93px;
	height: 30px;
	cursor: pointer;
}
</style>


<div id="common-popup">
	<h3 class="popup-title">공통 팝업창</h3>
	<div class="popup-content">
		<textarea 
			name="popup-content-text" 
			id="popup-content-text" 
			rows="7" cols="30"
			placeholder="내용을 입력하세요"
		></textarea>
		<div class="popup-buttons">
			<button type="button" id="popup-ok">확인</button>
			<button type="button" id="popup-cancel">닫기</button>
		</div>
	</div>
</div>

<script>
// 팝업 열기 함수
function openPopupInput(options) {
	
	const popup = document.getElementById('common-popup');
	const titleElement = document.querySelector('.popup-title');
	const textarea = document.getElementById('popup-content-text');
	
	// 팝업 내용 설정
	titleElement.innerText = options.title || '공통 팝업창';
	textarea.placeholder = options.placeholder || '내용을 입력하세요';
	textarea.value = ''; // 초기화
	
	// 확인 버튼 클릭 시 콜백 호출
	document.getElementById('popup-ok').onclick = function() {
		const value = textarea.value;
		if (options.onConfirm) {
			options.onConfirm(value);  // 내용 전달
		}
		popup.style.display = 'none';  // 팝업 닫기
	};
	
	// 닫기 버튼 클릭 시 취소 콜백 호출
	document.getElementById('popup-cancel').onclick = function() {
		if (options.onCancel) {
			options.onCancel();  // 취소 콜백
		}
		popup.style.display = 'none';  // 팝업 닫기
	};
	
	// 팝업 열기
	popup.style.display = 'flex';
}

// 예시 호출
// openPopupInput({
//     title: '팝업 제목 예시',
//     placeholder: '입력할 내용을 적어주세요',
//     onConfirm: function(content) {
//         console.log('확인 클릭:', content);
//     },
//     onCancel: function() {
//         console.log('팝업 닫기 취소');
//     }
// });
</script>
