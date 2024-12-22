	const usernameinput = document.querySelector(".username>input");
    const usernamebtn = document.querySelector(".username button");

    // x 표시
    usernameinput.addEventListener("input", (e) =>
      usernamebtn.classList.toggle("visible", e.target.value)
    );

    usernamebtn.addEventListener("click", (e) => {
      e.preventDefault();
      usernamebtn.classList.remove("visible");
      usernameinput.value = "";
    });

	//팝업 보이고 숨기고 보이고 숨기고

	// 특정 요소의 display 속성을 설정하는 함수
	function setDisplay(selector, display) {
	  document.querySelector(selector).style.display = display;
	}

	// 계정 찾기 팝업 열기
	document
	  .getElementById("findUserBtn")
	  .addEventListener("click", function () {
	    setDisplay("#findUser-popup", "block");
	    setDisplay("div.successPopup", "none");
	  });

	// 팝업 닫기
	document
	  .getElementById("popupClose")
	  .addEventListener("click", function () {
	    setDisplay("#findUser-popup", "none");
//			document.querySelector('div.accountCheck input[name="emailCode"]').disabled = true;
//			document.querySelector('input[name="newpassword"]').disabled = true;
	    setDisplay("p.pwMsg", "none");
	  });

	// 비밀번호 변경 후 팝업 닫기
	document
	  .querySelector("button.alertpopupClose")
	  .addEventListener("click", function () {
	    setDisplay("div.successPopup", "none");
	    setDisplay("#findUser-popup", "none");
	  });
	  
	  
	  
	  //이메일 인증번호 전송 이벤트
	  document.querySelector('button#emailBtn').addEventListener('click',function(){
		const account = document.querySelector('#findUser-account');
	      if (account.value == "") {
	          alert("이메일을 입력하세요.");
	          return;
	      }
	      
	      $.ajax({
	          type: "POST",
	          url: "sendEmailProc.jsp",
	          data: { account: account.value },
	          dataType: 'json',
	          success: function(res) {
	          	if(res.accountResult && res.emailResult){
	                  alert("인증 코드가 이메일로 발송되었습니다.");
										
										document.querySelector('div.accountCheck input[name="emailCode"]').disabled = false;
//					  document.querySelector('div.accountCheck').style.display = "flex";
						
	          	}else if(res.accountResult && !res.emailResult){
					 alert("인증 번호 전송에 실패하였습니다. ");
				}else if(!res.accountResult){
					 alert("계정을 찾지 못했습니다. 다시 확인해주세요.");
				}else{
                 	 alert("에러가 발생했습니다. 다시 시도해 주세요.");
	          	}
	          },
	          error: function() {
	              alert("에러가 발생했습니다. 다시 시도해 주세요.");
	          }
	      });
	  });
	  
	  
	  //이메일 인증번호 확인하기
	  document.getElementById('emailCheck').addEventListener('click',function(){
		const emailCode = document.querySelector('input[name="emailCode"]').value.trim();

		    if (emailCode === "") {
		      alert("인증번호를 입력하세요.");
		      return;
		    }

		    $.ajax({
		      type: "POST",
		      url: "emailcodeCheckProc.jsp", // 인증번호를 확인하는 JSP로 요청
		      data: { emailCode: emailCode },
		      dataType: 'json',
		      success: function (res) {
		        if (res.result) {
		          alert("인증번호가 일치합니다.");
				  //새 비밀번호 유효성 검사
  				  const newPasswordInput = document.querySelector(
  				    'input[name="newpassword"]'
  				  );
						newPasswordInput.disabled=false;
				  	const pwMessage = document.querySelector("p.pwMsg");
		          
				  	// 비밀번호 입력 필드를 보여줌
//		          newPasswordInput.style.display = 'block';
				  

				  newPasswordInput.addEventListener("input", function () {
				    const password = this.value;
				    const passwordRegex =
				      /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;

				    if (!passwordRegex.test(password)) {
				      newPasswordInput.style.borderColor = "#ff3636";
				      pwMessage.style.display = "block";
				    } else {
				      newPasswordInput.style.borderColor = "#7c8fb3";
				      pwMessage.style.display = "none";
				    }
				  });
		        } else {
		          alert("인증번호가 일치하지 않습니다.");
		        }
		      },
		      error: function () {
		        alert("에러가 발생했습니다. 다시 시도해 주세요.");
		      }
		    });
	  });
	  
	  
	  
	  //비밀번호 변경 이벤트
	  document.getElementById('completeBtn').addEventListener('click', function (event) {
//	      event.preventDefault(); // 폼 제출을 막음

	      const newPassword = document.querySelector('input[name="newpassword"]').value;
	      const account = document.querySelector('#findUser-account').value;

	      // 서버로 비밀번호 변경 요청을 보냄
	      $.ajax({
	        type: 'POST',
	        url: 'pwChangeProc.jsp', // 비밀번호 변경 처리하는 JSP 파일
	        data: {
	          account: account,
	          newPassword: newPassword
	        },
	        dataType: 'json',
	        success: function (res) {
	          if (res.result) {
	            // 비밀번호 변경 성공 시 successPopup을 보여줌
	            document.querySelector('.successPopup').style.display = 'block';
	          } else {
	            alert('비밀번호 변경에 실패했습니다. 다시 시도해주세요.');
	          }
	        },
	        error: function () {
	          alert('서버와의 통신 중 오류가 발생했습니다.');
	        }
	      });
	    });

			
//			// 이전 페이지로 돌아가는 스크립트
//      function goBack() {
//          if (window.history.length > 1) {
//              window.history.back();
//          } else {
//              window.location.href = '../main.jsp'; // 기본 페이지로 이동
//          }
//      }
