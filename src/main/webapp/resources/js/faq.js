function toggleSection(section) {
  const sections = document.querySelectorAll('.content');
  sections.forEach(sec => {
      sec.style.display = sec.id === section ? 'block' : 'none';
  });
}

// 모든 질문에 대한 답변 토글
function toggleAnswer(element) {
  const answer = element.nextElementSibling; // 질문 다음의 형제 요소인 답변 찾기
  const isVisible = answer.style.display === 'block';
	
//답변 표시 상태 토글 
  answer.style.display = isVisible ? 'none' : 'block';
	

	// 버튼을 찾고 상태에 따라 텍스트 변경
  const faqItem = element.closest('.faq'); // 현재 질문 항목 찾기
  const openIcon = faqItem.querySelector('.faq_icon.open');
  const closeIcon = faqItem.querySelector('.faq_icon.close');

  // 아이콘 표시 상태 변경
  if (isVisible) {
    openIcon.style.display = 'block';
    closeIcon.style.display = 'none';
  } else {
    openIcon.style.display = 'none';
    closeIcon.style.display = 'block';
  }
}


// FAQ 버튼 클릭 이벤트 추가
document.querySelectorAll('.faq_btn').forEach(btn => {
  btn.addEventListener('click', function () {
      const faqItem = btn.closest('.faq'); // 부모 요소인 faq 항목 찾기
			const answer = faqItem.querySelector('.faq_question');
			toggleAnswer(answer); // 질문 요소를 인자로 전달 
  });
});


function toggleQAnswer(element) {
  const answer = element.nextElementSibling; // 질문 다음의 형제 요소인 답변 찾기
  const isVisible = answer.style.display === 'block';
	
//답변 표시 상태 토글 
  answer.style.display = isVisible ? 'none' : 'block';
	

	// 버튼을 찾고 상태에 따라 텍스트 변경
  const qaItem = element.closest('.qa'); // 현재 질문 항목 찾기
  const openIcon = qaItem.querySelector('.qa_icon.open');
  const closeIcon = qaItem.querySelector('.qa_icon.close');

  // 아이콘 표시 상태 변경
  if (isVisible) {
    openIcon.style.display = 'block';
    closeIcon.style.display = 'none';
  } else {
    openIcon.style.display = 'none';
    closeIcon.style.display = 'block';
  }
}



// Q&A 버튼 클릭 이벤트 추가
function attachQAButtonEvents() {
	document.querySelectorAll('.qa_btn').forEach(btn => {
	  btn.addEventListener('click', function () {
	      const qaItem = btn.closest('.qa'); // 부모 요소인 qa 항목 찾기
	      const answer = qaItem.querySelector('.qa_question');
				toggleQAnswer(answer);
	
	  });
	});
}

function deleteQa(button) {
    // 클릭된 삭제 버튼의 부모 li 요소를 찾아서 삭제
    const qaItem = button.closest('.qa');
    if (qaItem) {
        qaItem.remove();
    }
}






// 질문 제출 폼 처리
document.getElementById('questionForm').addEventListener('submit', function (event) {
  event.preventDefault(); // 기본 제출 방지

	let questionInput = document.getElementById('questionInput');
	if(questionInput === null){
		console.error("questionInput is null");
		return;
	}
	
  const title = document.getElementById('questionInput').value;
  const content = document.getElementById('questionDetails').value;
	const userEmail = document.getElementById('account').value;
	
	if(userEmail == null || userEmail == ""){
		alert("로그인 후 이용해주세요.");
		return;
	}

  document.getElementById('questionInput').value = '';
  document.getElementById('questionDetails').value = '';
	
	
	// AJAX 요청
	$.ajax({
	    type: "POST",
	    url: "addQuestion.jsp", // 질문 등록을 처리할 JSP 파일
	    data: {
	        title: title,
	        contents: content,
	        User_email: userEmail
					
	    },
	    dataType: 'json',
	    success: function(response) {
	        if (response.success) {
//	            alert("질문이 성공적으로 등록되었습니다!");
	            $('#questionForm')[0].reset(); // 폼 초기화
							loadQuestions();
							//질문 목록을 새로 로드하여 새로고침 없이 갱신
	        } else {
	            alert("질문 등록 실패: " + response.message);
	        }
	    },
	    error: function() {
	        alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
	    }
	});
});

// 페이지 로드 시 첫 섹션 표시
document.addEventListener('DOMContentLoaded', () => {
  toggleSection('faq'); // 기본적으로 FAQ 섹션 표시
  loadQuestions(); //질문 목록 로드 
});	
	
function loadQuestions() {
    $.ajax({
        type: "GET",
        url: "getQuestion.jsp", // 질문 목록을 가져오는 JSP 파일
        dataType: 'json',
        success: function(response) {
            const qaContainer = document.querySelector('.qa-container');
            qaContainer.innerHTML = ''; // 기존 질문 목록 초기화
						
            response.forEach(question => {
                const qaItem = document.createElement('li');
                qaItem.className = 'qa';
								
								console.log("댓글:", question.comment); // 각 질문의 댓글 확인
							  console.log("댓글 날짜:", question.comdate); // 각 질문의 댓글 날짜 확인
								
				
						//작성자 이메일과 현재 사용자 이메일 비교 
								const deleteButton = (question.User_email === currentUserEmail) 
								? `<button class="delete_btn" onclick="deleteQuestion(${question.id})">삭제</button>`
								: ''; // 삭제 버튼 생성 
								
                qaItem.innerHTML = `
                    <div class="qa_question" onclick="toggleQAnswer(this)">
						<div class=qa_header>
                        	<h3 class="qa_title">${question.title}</h3>
								<div class="delete-container">					
									${deleteButton}
								</div>
						</div>
								<p class="qa_meta">작성자: ${question.nickname} | 작성일: ${new Date(question.date).toLocaleDateString('ko-KR')}</p>
												
                    </div>
               <div class="qa_answer" style="display: none;">
                    <p class="qa_text">${question.contents}</p>
					<div class= "comment">	
						<p class="qa_comment">답변:${question.comment}</p>
						<p class="qa_comdate">${question.com_date}</p>
                    </div>
				</div>
								
                    <button class="qa_btn">
                        <span class="qa_icon open">+</span>
                        <span class="qa_icon close">-</span>
                    </button>
					
                `;
								
               qaContainer.appendChild(qaItem);
							 
            });
						attachQAButtonEvents();
        },
        error: function(xhr, status, error) {
					console.error("Error loading questions", status, error);
            alert("질문 목록을 불러오는 데 오류가 발생했습니다.");
        }
    });
}

function deleteQuestion(questionId) {
    if (confirm("이 질문을 삭제하시겠습니까?")) {
        $.ajax({
            type: "POST",
            url: "deleteQuestion.jsp", // 질문 삭제를 처리할 JSP 파일
            data: { id: questionId },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
//                    alert("질문이 삭제되었습니다!");
                    loadQuestions(); // 질문 목록을 새로 로드하여 삭제된 질문 반영
                } else {
                    alert("질문 삭제 실패: " + response.message);
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
    }
}



