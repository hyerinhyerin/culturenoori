/**
 * 
 */
const imagePreview = document.querySelector("div.previewImage");
const imageUpload = document.querySelector("input#profileUpload");
const originalUsername = document.querySelector('input[name="username"]').value;
// 파일 고르면 미리보기처럼 div.previewImage에 띄우도록
function getImageFiles(e) {
  const file = e.currentTarget.files[0]; //선택한 첫번째 파일
	console.log(file ? file.name : "파일 선택 안됨");
  // 이미지 파일 검사
  if (!file.type.match("image/.*")) {
    alert("이미지 파일만 업로드 가능합니다.");
    return;
  }

  const reader = new FileReader();
  reader.onload = (e) => {
    const img = document.createElement("img");
    img.setAttribute("src", e.target.result);
    img.setAttribute("data-file", file.name);
    imagePreview.innerHTML = "";
    imagePreview.appendChild(img);

    // console.log(e.target.result);
  };
  reader.readAsDataURL(file);
}

imagePreview.addEventListener("click", () => {
  imageUpload.click();
  console.log("click");
});

imageUpload.addEventListener("change", function(e){
	console.log("파일 선택 이벤트 발생");
	document.querySelector("input[name='isDefaultImage']").value="false";
	getImageFiles(e);
});


document.getElementById('userInfo_default').addEventListener('click',function(){
	//	imagePreview.innerHTML=`<img src="${originalImagePath}" alt="profile">`;
	imagePreview.innerHTML = generateProfileImageSvgTag(183, 183, '#CBDCF5', 0);
});

document.getElementById("deleteProfileImage").addEventListener('click',function(){
	
	// 기존 : imagePreview.querySelector('img').src="../resources/image/comment_profile.png";
	imagePreview.innerHTML = generateProfileImageSvgTag(183, 183, '#CBDCF5', 0);
	
	document.querySelector("input[name='isDefaultImage']").value="true";
});


$(function () {

  // $("div.editPopup").hide();
	

//  $("div.deletePopup").hide();

  // 수정 버튼 클릭 시 확인 팝업창 보임
  $("button#userInfo_edit").click(function () {
    // $("div.blackSubDiv").toggleClass("blackOverlay");
    
		// TODO:JHK 공통팝업 - 정보 수정 알림창
		// $("div.editPopup").show();
		openPopupOkCancel({
			title : '정보 수정 알림창',
			content : '정보를 수정하시겠습니까?',
			onOk : function() {
				console.log('Ok 클릭 ');

				if(originalUsername === document.querySelector('input[name="username"]').value){
					isUsernameCheck=true;
				}

				if(!isUsernameCheck){
					alert("닉네임 중복확인을 해주세요");
					return;
				}

				const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/; //대문자, 소문자, 숫자, 특수문자
				const pwValue = document.querySelector("input[name='password']").value;
				if(!passwordPattern.test(pwValue)){
					alert("비밀번호는 최소 8자, 대소문자, 숫자, 특수문자 포함해야합니다.");
					return;
				}
				document.querySelector('form').submit();
				
			},
			onCancel : function() {
				console.log('Cancel 클릭 ');
				
				// 팝업창 닫으면 버튼 활성화
				$("button#userInfo_edit").prop("disabled", false);
				$("button#userInfo_delete").prop("disabled", false);
				$("input#profileUpload").prop("disabled", false);
			}
		});
		
    // 팝업창 뜨면 기존 수정,탈퇴 버튼 비활성화
    $("button#userInfo_edit").prop("disabled", true);
    $("button#userInfo_delete").prop("disabled", true);
//    $("input#profileUpload").prop("disabled", true);
  });

  // 팝업 닫기 버튼 클릭 이벤트
//  $("div.editPopup button.popupClose").click(function () {
//    $("div.editPopup").hide();
//    // 팝업창 닫으면 버튼 활성화
//    $("button#userInfo_edit").prop("disabled", false);
//    $("button#userInfo_delete").prop("disabled", false);
//    $("input#profileUpload").prop("disabled", false);
//  });


  //   삭제 팝업창
  $("button#userInfo_delete").click(function () {

		// $("div.deletePopup").show();
		// 팝업창 뜨면 기존 수정,탈퇴 버튼 비활성화
		$("button#userInfo_edit").prop("disabled", true);
		$("button#userInfo_delete").prop("disabled", true);
		$("input#profileUpload").prop("disabled", true);
		
		openPopupOkCancel({
			title : '계정 삭제 알림창',
			content : '계정을 삭제하시겠습니까?',
			onOk : function() {
				console.log('Ok 클릭 ');
				$.ajax({
				    url: './memberProc/deleteUserProc.jsp', // 사용자 삭제 처리 JSP 경로
				    type: 'POST',
						dataType:'json',
				    data: { email: document.querySelector('input[name="email"]').value }, // 이메일 전달
				    success: function(res) {
				      if (res.result === 'success') {
				        alert("계정이 성공적으로 삭제되었습니다.");
				        // 로그아웃하거나 메인 페이지로 이동
				        window.location.href = '../login/login.jsp'; // 또는 원하는 페이지로 이동
				      } else {
				        alert("계정 삭제에 실패했습니다. 다시 시도해 주세요.");
				      }
				    },
				    error: function() {
				   	 alert("서버 오류가 발생했습니다. 나중에 다시 시도해 주세요.");
				    }
				});				
			},
			onCancel : function() {
				console.log('Cancel 클릭 ');
				// 팝업창 닫으면 버튼 활성화
				$("button#userInfo_edit").prop("disabled", false);
				$("button#userInfo_delete").prop("disabled", false);
				$("input#profileUpload").prop("disabled", false);
			}
		});

  });

//  $("div.deletePopup button.popupClose").click(function () {
//    $("div.deletePopup").hide();
//    // 팝업창 닫으면 버튼 활성화
//    $("button#userInfo_edit").prop("disabled", false);
//    $("button#userInfo_delete").prop("disabled", false);
//    $("input#profileUpload").prop("disabled", false);
//  });
});


let isUsernameCheck = false;

document.querySelector('button.username-check').addEventListener('click',function(){
	const username = document.querySelector('input[name="username"]').value;
	
	if(username){
		$.ajax({
			url:'./memberProc/usernameCheckProc.jsp',
			type:'GET',
			data:{username: username},
			dataType:'json',
			success:function(res){
				if(res.result === 'available'){
					alert("사용가능한 닉네임입니다.");
					isUsernameCheck=true;
				}else{
					alert("이미 사용중인 닉네임입니다.");
					isUsernameCheck=false;
				}
			}
		});
	}else{
		alert("닉네임을 입력해주세요");
	}
});

document.querySelector('input[name="username"]').addEventListener('input', function(){
	isUsernameCheck = false;
});



//수정 팝업에서 수정 등록 누르면 form제출
//document.getElementById('editPopupBtn').addEventListener('click',function(){
//	if(originalUsername === document.querySelector('input[name="username"]').value){
//		isUsernameCheck=true;
//	}
//	
//	if(!isUsernameCheck){
//		alert("닉네임 중복확인을 해주세요");
//		return;
//	}
//	
//	const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/; //대문자, 소문자, 숫자, 특수문자
//	const pwValue = document.querySelector("input[name='password']").value;
//	if(!passwordPattern.test(pwValue)){
//		alert("비밀번호는 최소 8자, 대소문자, 숫자, 특수문자 포함해야합니다.");
//		return;
//	}
//	document.querySelector('form').submit();
//});


document.querySelector('input[name="password"]').addEventListener('input',function(){
	const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/; //대문자, 소문자, 숫자, 특수문자

	const pwValue = this.value;
	const pwMSG = document.querySelector("p.pwMsg");
	
	if(passwordPattern.test(pwValue)){
		this.style.borderColor = "#CBDDF5";
		document.querySelector("div.password span").style.top = "50%";
		pwMSG.style.display="none";
	}else{
		this.style.borderColor = "#FF5A5A";
				document.querySelector("div.password span").style.top = "34%";
				pwMSG.style.display="block";
	}
});

// TODO:JHK 공통팝업 - 계정 삭제 알림창
//document.getElementById("deletePopupBtn").addEventListener("click",function(){
//	$.ajax({
//      url: './memberProc/deleteUserProc.jsp', // 사용자 삭제 처리 JSP 경로
//      type: 'POST',
//			dataType:'json',
//      data: { email: document.querySelector('input[name="email"]').value }, // 이메일 전달
//      success: function(res) {
//        if (res.result === 'success') {
//          alert("계정이 성공적으로 삭제되었습니다.");
//          // 로그아웃하거나 메인 페이지로 이동
//          window.location.href = '../login/login.jsp'; // 또는 원하는 페이지로 이동
//        } else {
//          alert("계정 삭제에 실패했습니다. 다시 시도해 주세요.");
//        }
//      },
//      error: function() {
//     	 alert("서버 오류가 발생했습니다. 나중에 다시 시도해 주세요.");
//      }
//  });
//});



