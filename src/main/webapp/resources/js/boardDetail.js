/**
 * 
 */	

	//삭제하기 버튼
	function confirmDelete(id, isNotice){
		if(confirm("이 게시글을 삭제하시겠습니까?")){
			$.ajax({
	      type: "POST",
	      url: "deleteboardProc.jsp",
	      data: { 
					id:id,
					isNotice: isNotice
				},
	      dataType: 'json',
	      success: function(res) {
	      	if(res.result){
//	          alert("게시글이 삭제되었습니다.");
					  location.href="./boardList.jsp";
	      	}else{
         	 alert("게시글 삭제에 실패했습니다.");
	      	}
	      },
	      error: function() {
          alert("에러가 발생했습니다. 다시 시도해 주세요.");
	      }
		  });
		}
	}

	
	
	
	//목록보기 버튼 이벤트
	const boardListBtn = document.querySelector('#boardListBtn');
	boardListBtn.addEventListener('click', function(){
		location.href="./boardList.jsp";
	});

	//댓글 textarea 부분
	const commentTA = document.querySelector('#commentForm>textarea');

    //댓글 줄 바꿈 생길 때 textarea높이 자동으로 바뀌도록
    commentTA.addEventListener('input',function (){
        this.style.height = '53px';
        this.style.height = this.scrollHeight+'px';
    });

	//댓글 등록 폼
	document.getElementById("commentForm").addEventListener("submit",function(e){
		e.preventDefault();
		const userNick = document.querySelector('.commentInput').getAttribute('data-user-nick');
		const commentText = document.querySelector('textarea[name="comment"]').value;
		const boardId = document.querySelector('input[name="boardId"]').value;
		const userEmail = document.querySelector('input[name="userEmail"]').value;
		
		if(userEmail == "null" || userEmail == null){
			alert("로그인 후 댓글을 작성해주세요.");
			return;
		}
		
		console.log("comment - "+commentText+ " boardid- "+boardId+" usermail- "+userEmail);
		
		$.ajax({
			type: "POST",
      url: "./comment/commentProc.jsp",
      data: {
				userEmail: userEmail,
				boardId: boardId,
				commentText: commentText
			},
      dataType: 'json', // 서버 응답을 JSON으로 기대
      success: function(data) {
        if (data.success) {
					let profileImage;
					if (data.imgpath) {
						profileImage = `<img src="${data.imgpath}" class="commentProfile" alt="profile">`;
					} else {
						// JSP 함수를 호출하여 프로필 이미지를 생성
						profileImage = generateProfileImageSvgTag(70, 70, '#CBDCF5', 20);
					}
					
            const commentList = document.querySelector(".commentList");
            const newComment = `
              <div class="commt-container" data-comment-id="${data.id}" data-user-nick=${userNick}>
                <div class="commentItem">
                  ${profileImage}
                  <div class="commtItem-section">
                      <div class="commt-1">
                        <p class="nick">${data.nickname}</p>
                        <span class="likeIcon" data-comment-id="${data.id}" data-user-email="${data.useremail}">
												<i class="fa-regular fa-thumbs-up fa-lg"></i>
												<span class="likeCount"></span>
												</span>
                      </div>
                      <p class="commt" id="commentText${data.id}">${data.comment}</p>
											<textarea class="commt-textarea" id="commentTextarea${data.id}" style="display:none;">${data.comment}</textarea>
                      <div class="commt-2">
                        <p class="commtDate">${data.date}</p>
                        <button class="recommt" id="recommtBtn" data-comment-id="${data.id}">답글쓰기</button>
												<button class="recommt" id="editButton${data.id}" onclick="showEdit(${data.id})">수정하기</button>
												<button class="recommt" id="saveButton${data.id}" style="display:none;" onclick="saveComment(${data.id})">수정 완료</button>
												<button class="recommt" onclick="deleteComment(${data.id})">삭제하기</button>
												<span class="reportIcon" data-comment-id="${data.id}" data-user-email="${userEmail}">
				                <img src="../resources/image/siren.png" class="commentReport" alt="report">
				                </span>
                      </div>
                  </div>
                </div>
              </div>
            `;
//            commentList.innerHTML += newComment; // 새로운 댓글을 리스트에 추가
						commentList.insertAdjacentHTML('afterbegin', newComment); // 제일 앞에 추가
            document.querySelector("textarea").value = ""; // 입력 필드 비우기
						
						addReportEventListeners();	// 댓글, 답글 신고하기 버튼에 이벤트 등록	
						addLikeEventListeners();
						addCommentEventListeners();
          } else {
              alert("댓글 등록에 실패했습니다.");
          }
      },
      error: function() {
          alert("에러가 발생했습니다. 다시 시도해 주세요.");
      }
		});
		
	});
	
	function deleteComment(commentId) {
	  if (confirm("댓글을 삭제하시겠습니까?")) {
      $.ajax({
        type: "POST",
        url: "./comment/deleteCommentProc.jsp", // 댓글 삭제 처리 JSP 경로
        data: { commentId: commentId },
        success: function(response) {
            if (response.success) {
//              alert("댓글이 삭제되었습니다.");
              location.reload(); // 삭제 후 페이지 새로고침
            } else {
              alert("댓글 삭제에 실패했습니다.");
            }
        },
        error: function() {
          alert("에러가 발생했습니다. 다시 시도해 주세요.");
        }
      });
	  }
	}
	
	function showEdit(commentId) {
    const commentText = document.getElementById(`commentText${commentId}`);
    const commentTextarea = document.getElementById(`commentTextarea${commentId}`);
    const saveButton = document.getElementById(`saveButton${commentId}`);
    const editButton = document.getElementById(`editButton${commentId}`);

    // 기존 텍스트를 textarea로 전환
    commentText.style.display = 'none';
    commentTextarea.style.display = 'block';
    saveButton.style.display = 'inline-block';
		editButton.style.display = 'none';
	}
	
	//댓글 수정 기능
	function saveComment(commentId) {
    const commentTextarea = document.getElementById(`commentTextarea${commentId}`);
    const updatedContent = commentTextarea.value;

    // AJAX 요청 보내기
    $.ajax({
      type: "POST",
      url: "./comment/updateCommentProc.jsp", // 수정할 JSP 경로
      data: {
        commentId: commentId,
        updatedContent: updatedContent
      },
      success: function(data) {
        if (data.success) {
          const commentText = document.getElementById(`commentText${commentId}`);
          const saveButton = document.getElementById(`saveButton${commentId}`);
					const editButton = document.getElementById(`editButton${commentId}`);
					
          // textarea를 숨기고 업데이트된 내용을 표시
          commentText.innerText = updatedContent;
          commentText.style.display = 'block';
          commentTextarea.style.display = 'none';
          saveButton.style.display = 'none';
          editButton.style.display = 'block';
        } else {
          alert("댓글 수정에 실패했습니다.");
        }
      },
      error: function(xhr, status, error) {
        console.error('Error:', error);
      }
    });
	}

	
  //// 답글쓰기 버튼 누르면 답글 입력 폼 나오도록
	function addCommentEventListeners(){
	  document.querySelectorAll('button#recommtBtn').forEach(function(button) {
	      button.addEventListener('click', function() {
	          const commtContainer = this.closest('.commt-container');
						const parentID = this.getAttribute('data-comment-id');
						
						console.log("parentID:", parentID);

						const userEmail = document.querySelector('#commentForm>input[name="userEmail"]').value; // 사용자 이메일
	
						if(userEmail == "null" || userEmail == null){
							alert("로그인 후 답글을 작성해주세요.");
							return;
						}
						
						toggleRecommentInput(commtContainer,parentID);
	          
	      });
	  });
	}
	
	function toggleRecommentInput(container,parentID){
		const nickname = container.getAttribute("data-user-nick");
		const now = new Date();
		const formattedDate = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-${String(now.getDate()).padStart(2, '0')}`;
		// 답글 입력폼 HTML
    const recommtInputHTML = `
        <div class="recommtInput">
            <p>답글 입력 중</p>
            <form action="#" method="post" class="recommentForm">
                <textarea placeholder="답글 입력하세요"></textarea>
                <button type="submit">등록</button>
								<button class="closeRecomment" type="button">취소</button>
            </form>
        </div>
    `;
		
		// 입력폼이 없으면 추가하고, 있으면 보여줌
    if (!container.querySelector('.recommtInput')) {
        container.insertAdjacentHTML('beforeend', recommtInputHTML);
        addCloseButtonEvent(container); // 입력폼 취소 이벤트
				addRecommentFormEvent(container,parentID); //답글 입력 폼 이벤트
		}else{
			container.querySelector('.recommtInput').style.display = 'block';
		}
	}
	
	//답글 입력 폼 관련 이벤트
	function addRecommentFormEvent(container,parentID){
		const recommentTA = document.querySelector('.recommentForm>textarea');
    recommentTA.addEventListener('input', function() {
        this.style.height = '53px'; // 기본 높이
        this.style.height = this.scrollHeight + 'px'; // 내용에 맞게 조정
    });
		
		//답글 submit 처리
		const nickname = container.getAttribute("data-user-nick");
		const recommentForm = container.querySelector('.recommentForm');
		recommentForm.addEventListener('submit',function(e){
			e.preventDefault();
			
			if(nickname =="비회원" || nickname == null){
				alert("로그인 이후 이용해주세요.");
				return;
			}
			submitRecomment(container, recommentTA.value,parentID);
		});
	}
	
	
	function submitRecomment(container, recommentText,parentID){
		const boardId = document.querySelector('#commentForm>input[name="boardId"]').value; // 사용자 이메일
//    const parentcommentId = container.getAttribute('data-comment-id'); // 부모 댓글 ID
		const userEmail = document.querySelector('#commentForm>input[name="userEmail"]').value; // 사용자 이메일

		
		$.ajax({
        type: "POST",
        url: "./comment/recommentProc.jsp", // 답글 처리할 JSP 파일
        data: {
          boardId: boardId,
          userEmail: userEmail,
          parentCommentId: parentID,
          content: recommentText
        },
        dataType: 'json',
        success: function(response) {
          if (response.success) {
            addNewRecomment(container, response, recommentText);
          } else {
            alert("답글 등록에 실패했습니다.");
          }
        },
        error: function() {
       	 alert("에러가 발생했습니다. 다시 시도해 주세요.");
        }
    });
	}
	
	
	//답글 틀 추가 함수
	function addNewRecomment(container, response, recommentText){
		let profileImage;
		if (response.imgpath) {
			profileImage = `<img src="${response.imgpath}" class="commentProfile" alt="profile">`;
		} else {
			// JSP 함수를 호출하여 프로필 이미지를 생성
			profileImage = generateProfileImageSvgTag(70, 70, '#CBDCF5', 20);
		}
		const userEmail = document.querySelector('input[name="userEmail"]').value;
		const newRecomment = `
	    <div class="recommentItem">
	      ${profileImage}
	      <div class="commtItem-section">
	        <div class="commt-1">
	          <p class="nick">${response.nickname}</p>
	          <span class="likeIcon" data-comment-id="${response.id}" data-user-email="${response.userEmail}">
	            <i class="fa-regular fa-thumbs-up fa-lg"></i>
	            <span class="likeCount"></span>
	          </span>
	        </div>
	        <p class="commt" id="commentText${response.id}"><b>@${response.parentNick}</b> ${recommentText}</p>
					<textarea class="commt-textarea" id="commentTextarea${response.id}" style="display:none;">${recommentText}</textarea>
	        <div class="commt-2">
	          <p class="commtDate">${response.date}</p>
						<button class="recommt" id="recommtBtn" data-comment-id="${response.id}">답글쓰기</button>
						<button class="recommt" id="editButton${response.id}" onclick="showEdit(${response.id})">수정하기</button>
						<button class="recommt" id="saveButton${response.id}" style="display:none;" onclick="saveComment(${response.id})">수정 완료</button>
						<button class="recommt" onclick="deleteComment(${response.id})">삭제하기</button>
						<span class="reportIcon" data-reply-id="${response.id}" data-user-email="${userEmail}">
	          <img src="../resources/image/siren.png" class="commentReport" alt="report">
	          </span>
	        </div>
	      </div>
	    </div>
	  `;
		container.insertAdjacentHTML('beforeend', newRecomment);
		//답글 입력 폼 삭제
		container.querySelector('.recommtInput').remove();
		
		addReportEventListeners();	// 댓글, 답글 신고하기 버튼에 이벤트 등록
		addLikeEventListeners();
		addRecommentEventListeners();
	}
	
	//새 답글에 답글쓰기 버튼 이벤트 리스너 추가
	function addRecommentEventListeners(){
		document.querySelectorAll('.recommentItem button#recommtBtn').forEach(button => {
      button.addEventListener('click', function() {
        const commtContainer = this.closest('.commt-container');
				const parentID = this.getAttribute('data-comment-id');
        toggleRecommentInput(commtContainer, parentID);
      });
	  });
	}
		
  //답글 입력 폼에 취소 버튼 누르면 입력 폼 제거
  function addCloseButtonEvent(container) {
      container.querySelector('.closeRecomment').addEventListener('click', function() {
          const recommtInput = container.querySelector('.recommtInput');
          recommtInput.remove(); // 입력폼을 DOM에서 완전히 제거
      });
  }
		
	// 투트 경로 얻는 코드 
	function getContextPath() {
		var hostIndex = window.location.href.indexOf(window.location.host) + window.location.host.length;
		var contextPath = window.location.href.substring(hostIndex, window.location.href.indexOf('/', hostIndex + 1));
		return contextPath;
	}
	
	//신고하기(Board) 버튼 
	function confirmReport(reportedId, userEmail, type, element) {

		console.log("confirmReport reportedId : ", reportedId);
		console.log("confirmReport userEmail : ", userEmail);
		console.log("confirmReport type : ", type);
		console.log("confirmReport element : ", element);

		if (!userEmail || userEmail.trim() === "" || userEmail === "null") {
			
			openPopupOkCancel({
				title : '확인',
				content : '로그인 이후에 사용할 수 있습니다.',
				onOk : function() {
					console.log('Ok 클릭 ');
				},
				onCancel : function() {
					console.log('Cancel 클릭 ');
				}
			});
			
			return; // AJAX 요청 중단
		}
			
		let strAsk = "";
		let strRslt = "";

		switch (type) {
			case 'board':
				strAsk = "이 게시글을 신고하시겠습니까?";
				strRslt = "게시글이 신고되었습니다.";
				break;
			case 'comment':
				strAsk = "이 댓글을 신고하시겠습니까?";
				strRslt = "댓글이 신고되었습니다.";
				break;
			case 'reply':
				strAsk = "이 답글을 신고하시겠습니까?";
				strRslt = "답글이 신고되었습니다.";
				break;
		}
		
		openPopupInput({
			title: strAsk,
			placeholder: '신고 내용을 적어주세요',
			onConfirm: function(content) {
				console.log('확인 클릭:', content);
				if (content === '') {
					alert('신고 내용을 적어주세요.');
					return;
				}

				$.ajax({
					type: "POST",
					url: getContextPath() + "/manager/reportProc.jsp",
					data: {
						reason: content,
						type: type,
						reportedId: reportedId,
						userEmail: userEmail
					},
					dataType: 'json',
					success: function(res) {
						if (res.result) {
							alert(strRslt);
							// FIXME:test_report
							element.classList.add('test_report');
						} else {
							alert("신고에 실패했습니다.");
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
	
	
	// TODO:JHK - 신고버튼(comment, reply) 이벤트 등록
	function addReportEventListeners() {
		document.querySelectorAll('.reportIcon').forEach(icon => {
			console.log('[addReportEventListeners.reportIcon] : ', icon);
			icon.addEventListener('click', function() {
				const userEmail = this.getAttribute('data-user-email');
				
				console.log("userEmail 1 - " + userEmail);

				if (!userEmail || userEmail.trim() === "" || userEmail === "null") {
				
					console.log("userEmail 2 - " + userEmail);
		
					openPopupOkCancel({
						title : '확인',
						content : '로그인 이후에 사용할 수 있습니다.',
						onOk : function() {
							console.log('Ok 클릭 ');
						},
						onCancel : function() {
							console.log('Cancel 클릭 ');
						}
					});
					
					return; // AJAX 요청 중단
				}
				

				const commentId = this.getAttribute('data-comment-id');
				const replyId = this.getAttribute('data-reply-id');

				if (commentId) {
					confirmReport(commentId, userEmail, 'comment', this);
				} else if (replyId) {
					confirmReport(replyId, userEmail, 'reply', this);
				} else {
					alert("비정상 접근입니다.");
				}

			});
		});
	}
	
	//게시글, 댓글 통일 좋아요 기능
function addLikeEventListeners() {
	document.querySelectorAll('.likeIcon').forEach(icon => {
    icon.addEventListener('click', function() {
      const userEmail = this.getAttribute('data-user-email');

      console.log("userEmail - " + userEmail);
      if (!userEmail || userEmail.trim() === "" || userEmail === "null") {
        alert("로그인 이후 사용해주세요");
        return; // AJAX 요청 중단
      }

      const iconElement = this.querySelector('i');
			const likeCountElement = this.querySelector('.likeCount'); // 좋아요 수 표시 요소

      // 게시글 좋아요 처리
      const boardId = this.getAttribute('data-board-id');
      const commentId = this.getAttribute('data-comment-id');

      if (boardId) {
        // AJAX 요청으로 게시글 좋아요 추가
        $.ajax({
            type: "POST",
            url: "likeBoardProc.jsp",
            data: {
                boardId: boardId,
                userEmail: userEmail
            },
            dataType: 'json',
            success: function(response) {
	            if (response.result) {
                if (response.action === "like") {
//                    alert("좋아요가 추가되었습니다!");
                    iconElement.classList.add('clicked');
										likeCountElement.textContent = parseInt(likeCountElement.textContent || 0) + 1;
                } else if (response.action === "unlike") {
//                    alert("좋아요가 취소되었습니다!");
                    iconElement.classList.remove('clicked');
										likeCountElement.textContent = parseInt(likeCountElement.textContent || 0) - 1;
                }
	            } else {
                alert("좋아요 추가에 실패했습니다.");
         	 		}
            },
            error: function() {
              alert("에러가 발생했습니다. 다시 시도해 주세요.");
            }
        });
      } else if (commentId) {
        // AJAX 요청으로 댓글 좋아요 추가
        $.ajax({
          type: "POST",
          url: "./comment/likeCommentProc.jsp",  // 댓글 좋아요를 처리할 JSP 파일
          data: {
            commentId: commentId,
            userEmail: userEmail
          },
          dataType: 'json',
          success: function(response) {
            if (response.result) {
              if (response.action === "like") {
//                alert("댓글 좋아요가 추가되었습니다!");
                iconElement.classList.add('clicked');
								likeCountElement.textContent = parseInt(likeCountElement.textContent || 0) + 1;
              } else if (response.action === "unlike") {
//                alert("댓글 좋아요가 취소되었습니다!");
                iconElement.classList.remove('clicked');
								likeCountElement.textContent = parseInt(likeCountElement.textContent || 0) - 1;
              }
            } else {
              alert("댓글 좋아요 추가에 실패했습니다.");
            }
          },
          error: function() {
            alert("에러가 발생했습니다. 다시 시도해 주세요.");
          }
        });
    	}	
    });
	});
}
	
	
	//목록 누르면 조회수 증가하고 해당 게시글로 이동
	document.querySelectorAll("tr[data-board-id]").forEach((row) => {
	  row.addEventListener("click", function() {
	    const boardId = this.getAttribute("data-board-id");
			const searchField = this.getAttribute("data-search-field");
		  const searchWord = this.getAttribute("data-search-word");
			const sort = this.getAttribute("data-sort-value");
			const category = this.getAttribute("data-category-value");
	    
			$.ajax({
			  type: "post",
			  url: "viewcountProc.jsp",
			  data: { boardId: boardId},
			  dataType: 'json',
			  success: function(res) {
			  	if(res.result){
//			      alert("조회수 카운팅 성공");
					  location.href=`./boardDetail.jsp?boardId=${boardId}&sort=${sort}&category=${category}&searchField=${searchField}&searchWord=${searchWord}`;
			  	}else{
			   	 alert("조회수 카운팅 실패");
			  	}
			  },
			  error: function() {
			    alert("에러가 발생했습니다. 다시 시도해 주세요.");
			  }
			});
	  });
	});

	addReportEventListeners();	// 댓글, 답글 신고하기 버튼에 이벤트 등록	
	addLikeEventListeners(); //기본적 좋아요 기능 붙도록
	addCommentEventListeners();