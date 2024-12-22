// 입력 유효성 검사
const username = document.querySelector('input[name="nick"]');
const password = document.querySelector('input[name="passwd1"]');
const passwordCheck = document.querySelector('input[name="passwd2"]');
const email = document.querySelector('input[name="email"]');

const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/; //대문자, 소문자, 숫자, 특수문자


document.querySelector('button.emailCheckBtn').addEventListener('click',function(){
	let emailValue = email.value;
	if (emailValue == "") {
	        alert("이메일을 입력하세요.");
	        return;
	    }
	accountCheck(emailValue);
});
     
document.querySelector('button.username-check').addEventListener('click',function(){
	console.log("click");
	let nick = username.value;
	if (nick == "") {
	        alert("닉네임을 입력하세요.");
	        return;
	    }
	    
	    accountCheck(nick);
});

function setValue(nameKey, value){
	let element = document.getElementById(nameKey);
	if(element){
		element.value = value;
	}else{
		 console.log("Element not found : " + nameKey + ", " + value);
	}        	
}
        
function accountCheck(account){
    $.ajax({
        type: "GET",
        url: "./accountCheckProc.jsp",
        data: { account : account },
        dataType: 'json',
		success: function(res) {
        	
        	// 자바 스크립트에서 serDTO.EMAIL 사용할 방법은?
        	if(res.type == "email" && res.result == "possible"){
                
        		alert("사용 가능한 이메일입니다.");
        		setValue("emailCheckResult", "1");
                
        	}else if(res.type == "email" && res.result == "already"){
                
        		alert("이미 사용 중인 이메일입니다.");
        		setValue("emailCheckResult", "0");
                
        	}else if(res.type == "nickname" && res.result == "possible"){
                
        		alert("사용 가능한 닉네임입니다.");
        		setValue("nickCheckResult", "1");
        		
        	}else if(res.type == "nickname" && res.result == "already"){

        		alert("이미 사용 중인 닉네임입니다.");
        		setValue("nickCheckResult", "0");
        		
        	}
        },
        error: function() {
            alert("에러가 발생했습니다. 다시 시도해 주세요.");
        }
    });
}


//onkeyup="emailCheckInit();"
email.addEventListener('keyup', function(){
	setValue("emailCheckResult", "0");
});

//onkeyup="nickCheckInit();"
username.addEventListener('keyup', function(){
	setValue("nickCheckResult", "0");
});


//onclick="sendEmail()"
document.querySelector('button.emailBtn').addEventListener('click',function(){
    if (email.value == "") {
        alert("이메일을 입력하세요.");
        return;
    }
    
    $.ajax({
        type: "POST",
        url: "sendEmailProc.jsp",
        data: { email: email.value },
        dataType: 'json',
        success: function(res) {
        	if(res.result){
                alert("인증 코드가 이메일로 발송되었습니다.");
        	}else{
                alert("에러가 발생했습니다. 다시 시도해 주세요.");
        	}
        },
        error: function() {
            alert("에러가 발생했습니다. 다시 시도해 주세요.");
        }
    });
});


		


//유효성 검사
document.querySelector('form[name="joinForm"]')
  .addEventListener("submit", function (e) {
    e.preventDefault(); //기본 제출 동작 방지

    let valid = true; //제출할 수 있는 상태

    if (username.value.trim() === "") {
      alert("닉네임을 입력해주세요.");
      valid = false;
    } else if (username.value.length < 3) {
      alert("닉네임은 3자 이상 입력해주세요.");
      valid = false;
    }

    if (password.value.trim() === "") {
      alert("비밀번호를 입력해주세요.");
      valid = false;
    } else if (!passwordPattern.test(password.value)) {
      alert(
        "비밀번호는 최소 8자, 대소문자, 숫자, 특수문자 포함해야합니다."
      );
      valid = false;
    }

    if (email.value.trim() === "") {
      alert("이메일을 입력해주세요.");
      valid = false;
    } else if (!emailPattern.test(email.value)) {
      alert("유효한 이메일 주소를 입력하세요.");
      valid = false;
    }

    // 비밀번호와 비밀번호 확인 일치 여부 체크
    if (password.value !== passwordCheck.value) {
      alert("비밀번호가 일치하지 않습니다.");
      valid = false;
    }

    if (valid) {
      this.submit();
    }
  });

  
// 비밀번호 확인란 실시간 확인
passwordCheck.addEventListener("input", function () {
  if (password.value === passwordCheck.value) {
    passwordCheck.style.borderColor = "#CBDCF5"; // 비밀번호가 일치할 때 색상 변경
    document.querySelector("div.pw-check p.pwcheckMsg").style.display =
      "none"; // 메시지 숨김
  } else {
    passwordCheck.style.borderColor = "#FF5A5A"; // 비밀번호가 일치하지 않을 때 색상 변경
    document.querySelector("div.pw-check p.pwcheckMsg").style.display =
      "block"; // 메시지 표시
  }
});

//비밀번호 유효성 실시간 확인
password.addEventListener("input", function () {
  const pwValue = this.value;
  const pwMessage = document.querySelector("div.password p.pwMsg");

  if (passwordPattern.test(pwValue)) {
    password.style.borderColor = "#CBDCF5";
    document.querySelector("div.password span").style.top = "50%";
    pwMessage.style.display = "none";
  } else {
    password.style.borderColor = "#FF5A5A";
    document.querySelector("div.password span").style.top = "30%";
    pwMessage.style.display = "block";
  }
});

// 비밀번호에서 포커스 아웃되면 스타일 조정
password.addEventListener("focusout", function () {
  if (!passwordPattern.test(password.value)) {
    password.style.borderColor = "#FF5A5A"; // 비밀번호 유효하지 않을 경우 색상 유지
  } else {
    password.style.borderColor = "#CBDCF5"; // 비밀번호 유효할 경우 색상 변경
  }
});


//닉네임 실시간 유효성 확인
username.addEventListener("input", function () {
  const nick = this.value;
  const nickMessage = document.querySelector("div.username p.nickcheckMsg");

  if (nick.length < 3) {
    username.style.borderColor = "#FF5A5A";
    document.querySelector("div.username span").style.top = "30%";
    document.querySelector("button.username-check").style.top = "30%";
    nickMessage.style.display = "block";
  } else {
    username.style.borderColor = "#CBDCF5";
    document.querySelector("div.username span").style.top = "50%";
    document.querySelector("button.username-check").style.top = "50%";
    nickMessage.style.display = "none";
  }
});

//닉네임 입력란 포커스 아웃되면 스타일 조정
username.addEventListener("focusout", function () {
  if (username.value.length < 3) {
    password.style.borderColor = "#FF5A5A"; // 비밀번호 유효하지 않을 경우 색상 유지
  } else {
    password.style.borderColor = "#CBDCF5"; // 비밀번호 유효할 경우 색상 변경
  }
});