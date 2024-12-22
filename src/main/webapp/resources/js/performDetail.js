//공연목록 상세페이지 내에 탭메뉴기능 활성화를 위한 함수
$(document).ready(function() {
	
	// 공연목록 상세페이지 내에 탭메뉴기능 활성화를 위한 함수
	$(".content_view").load("performIntro.jsp"); // 최초 화면은 공연 소개 이미지가 나오는 페이지를 로드함

	$(".load_content").click(function() { // 탭 클릭 시 해당되는 jsp를 호출하여 화면에 보여줌
	    let file = $(this).data("file");
	    $(".content_view").load(file);
	});

	
	const averageRate = $('#average-rate').data('rate');
	console.log("Session averageRate from JSP: ", averageRate);  // 콘솔에서 값 확인
	const parsedRate = parseFloat(averageRate);
    // 평점 값이 유효하다면 별점 그리기
    if (!isNaN(parsedRate)) {
        drawStars(parsedRate);
		console.log("averageRate : ",parsedRate);
    } else {
        console.error("Invalid rating value");
    }
    // 좋아요 버튼 기능
    const likeButton = $('#like-button');
    const detailId = likeButton.attr('data-detailId');
    const userEmail = likeButton.attr('data-user-email'); // 세션에서 사용자 이메일을 가져옴
	
    likeButton.click(function() {
     
			if(userEmail === ''){
				openPopupOk({
					title : '확인',
					content : '로그인 이후에 사용할 수 있습니다.',
					onOk : function() {
						console.log('Ok 클릭 ');
					}
				});
				return;
			}   
			
			likeButton.toggleClass('checked');
				
				
        const icon = likeButton.find('i');
        let likeTF = false;
		

        if (likeButton.hasClass('checked')) {
            icon.removeClass('bi-heart').addClass('bi-heart-fill');
            likeTF = true;
			console.log("detailId : " +detailId);
			console.log("userEmail : " + userEmail);
            // 위시 리스트에 추가하는 AJAX 호출
            $.ajax({
                type: "POST",
				url: "../mypage/wishlistProc.jsp",
                data: {
                    user_email: userEmail,
                    perform_detail_id: detailId,
                    like: likeTF // 좋아요 상태 전송
                },
                success: function(response) {
                    console.log("위시 리스트에 추가되었습니다.");
                },
                error: function(err) {
                    console.error("위시 리스트 추가 중 오류 발생.", err);
                }
            });
        } else {
            icon.removeClass('bi-heart-fill').addClass('bi-heart');
            likeTF = false;

            // 위시 리스트에서 제거하는 AJAX 호출
            $.ajax({
                type: "POST",
                url: "../mypage/wishlistProc.jsp",
                data: {
                    user_email: userEmail,
                    perform_detail_id: detailId,
                    like: likeTF // 좋아요 상태 전송
                },
                success: function(response) {
                    console.log("위시 리스트에서 제거되었습니다.");
                },
                error: function(err) {
                    console.error("위시 리스트 제거 중 오류 발생.", err);
                }
            });
        }
    });
	
	function drawStars(rating) {
				const starContainers = document.querySelectorAll('.star-container');
				const ratingNumber = document.createElement('p');
				ratingNumber.innerText = `(${rating.toFixed(1)} / 5.0)`;
				ratingNumber.classList.add("list-append");
				starContainers.forEach(starContainer => {
					starContainer.innerHTML = ''; // 초기화

					for (let i = 0; i < 5; i++) {
						const star = document.createElement('span');  //별을 그리기 위한 span태그를 생성하여 star 변수에 저장
						star.classList.add('rating_star');						//생성된 span에 star 클래스(회색 별) 5개를 반복문으로 생성
						star.innerHTML = '★';							//내용은 별모양
						//rating값은 외부에서 받아올 평점이 들어갈 부분
						if (i < Math.floor(rating)) {					//rating을 소수점 내림하여 정수부분만 가져와서 비교
							star.classList.add('filled');				//해당되는 값만 전체색상을 칠하는 class 추가  => ex)3.7을 받을 경우 별 3개는 완전하게 칠한다.
						} else if (i < rating) {						//3.7일 경우 3보다 크고 4보다 작은 부분에 해당될 때
							const percentage = (rating - i) * 100;		//percentage 변수에 정수를 뺀 소숫점 부분에 100을 곱하여 %값을 구함
							star.classList.add('partial-filled');		//해당되는 별에는 부분칠하기 클래스를 추가
							star.style.background = `linear-gradient(90deg, #daa520 ${percentage}%, #ccc ${percentage}%)`;	//css 그라데이션 효과를 위에서 받은 퍼센트로 설정
							star.style.webkitBackgroundClip = 'text';
							star.style.webkitTextFillColor = 'transparent';
						}

						starContainer.appendChild(star);
										//위의 조건이 아닌 별(3.7일때 5번째 별)은 빈 별로 생성한다.
					}
					starContainer.appendChild(ratingNumber);
				});
			}
//	checkWish();
//	function checkWish(){
//			$.ajax({
//			        type: "GET",
//			        url: "../mypage/wishlistProc.jsp",
//			        data: {
//			            perform_detail_id: detailId,
//			            user_email: userEmail
//			        },
//			        dataType: "json",
//			        success: function(response) {
//			            if (response.result) {
//			                console.log("해당 사용자는 이미 좋아요를 눌렀습니다.");
//			                // UI 업데이트: 버튼을 "좋아요 취소"로 변경
//			                $('#like-button').removeClass('bi-heart').addClass('bi-heart-fill');
//			            } else {
//			                console.log("해당 사용자는 아직 좋아요를 누르지 않았습니다.");
//			                // UI 업데이트: 버튼을 "좋아요"로 변경
//			                $('#like-button').removeClass('bi-heart-fill').addClass('bi-heart');
//			            }
//			        },
//			        error: function(jqXHR, textStatus, errorThrown) {
//						console.error("오류가 발생했습니다: ", textStatus, errorThrown);
//			            alert("오류가 발생했습니다." + textStatus + ", " + errorThrown);
//			        }
//			    });
//		}
});



//$(document).ready(function() {
//	
//	// 공연목록 상세페이지 내에 탭메뉴기능 활성화를 위한 함수
//	$(".content_view").load("performIntro.jsp"); // 최초 화면은 공연 소개 이미지가 나오는 페이지를 로드함
//
//	$(".load_content").click(function() { // 탭 클릭 시 해당되는 jsp를 호출하여 화면에 보여줌
//	    let file = $(this).data("file");
//	    $(".content_view").load(file);
//	});
//	
//            const likeButton = $('#like-button');
//            const detailId = likeButton.attr('data-detailId');
//            const userEmail = likeButton.attr('data-user-email');
//
//            likeButton.click(function() {
//                likeButton.toggleClass('checked');
//                const icon = likeButton.find('i');
//                let likeTF = false;
//				checkWish();
//                if (likeButton.hasClass('checked')) {
//                    icon.removeClass('bi-heart').addClass('bi-heart-fill');
//                    likeTF = true;
//
//                    // 위시 리스트에 추가하는 AJAX 호출
//                    $.ajax({
//                        type: "POST",
//                        url: "../mypage/wishlistProc.jsp",
//                        data: {
//                            user_email: userEmail,
//                            perform_detail_id: detailId,
//                            like: likeTF // 좋아요 상태 전송
//                        },
//                        success: function(response) {
//							console.log("[performDetail2 > wish]perform_detail_id : " + detailId);
//							console.log("[performDetail2 > wish]userEmail : " + userEmail);
//                            console.log("위시 리스트에 추가되었습니다.");
//                        },
//                        error: function(err) {
//                            console.error("위시 리스트 추가 중 오류 발생.", err);
//                        }
//                    });
//                } else {
//                    icon.removeClass('bi-heart-fill').addClass('bi-heart');
//                    likeTF = false;
//
//                    // 위시 리스트에서 제거하는 AJAX 호출
//                    $.ajax({
//                        type: "POST",
//                        url: "../mypage/wishlistProc.jsp",
//                        data: {
//                            user_email: userEmail,
//                            perform_detail_id: detailId,
//                            like: likeTF // 좋아요 상태 전송
//                        },
//                        success: function(response) {
//                            console.log("위시 리스트에서 제거되었습니다.");
//                        },
//                        error: function(err) {
//                            console.error("위시 리스트 제거 중 오류 발생.", err);
//                        }
//                    });
//                }
//            });
//
//            // 페이지 로드 시 좋아요 상태 확인
//			function checkWish(){
//					    $.ajax({
//					        type: "GET",
//					        url: "../mypage/wishlistProc.jsp",
//					        data: {
//					            perform_detail_id: detailId,
//					            user_email: userEmail
//					        },
//					        dataType: "json",
//					        success: function(response) {
//					            if (response.result) {
//					                console.log("해당 사용자는 이미 좋아요를 눌렀습니다.");
//
//					                // UI 업데이트: 버튼을 "좋아요 취소"로 변경
//					                $('#like-button').removeClass('bi-heart').addClass('bi-heart-fill');
//					            } else {
//					                console.log("해당 사용자는 아직 좋아요를 누르지 않았습니다.");
//					                // UI 업데이트: 버튼을 "좋아요"로 변경
//					                $('#like-button').removeClass('bi-heart-fill').addClass('bi-heart');
//					            }
//					        },
//					        error: function() {
//					            alert("오류가 발생했습니다 At [performDetail.js checkWish()].");
//					        }
//					    });
//					}
//        });