<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="common.LoginManager"%>
<%@ page import="dto.UserDTO"%>
<%@ page import="dto.ReviewDTO"%>
<%@ page import="dao.ReviewDAO"%>
<%@ page import="java.util.*"%>
<%
String detailId = (String) session.getAttribute("detailId");
UserDTO user = LoginManager.getUser();
System.out.println("review2 detailId : " + detailId);
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Perform Detail</title>

<script defer
	src="${pageContext.request.contextPath}/resources/js/review.js">

<!-- <link rel="stylesheet" -->
<%-- 	href="${pageContext.request.contextPath}/resources/css/performDetail.css"> --%>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<link rel="stylesheet" href="../resources/css/common.css" />

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>

<style>
.d-none {
	display: none;
}

.star-rating {
	display: flex;
}

.star {
	appearance: none;
	padding: 1px;
	color: #ccc;
}

.star::after {
	content: '☆';
	color: #daa520;
	font-size: 1.5rem;
}

.star:hover::after, .star:has( ~ .star:hover)::after, .star:checked::after,
	.star:has( ~ .star:checked)::after {
	content: '★';
}

.star:hover ~ .star::after {
	content: '☆';
}

.rating_star {
	font-size: 1.5rem;
	color: #ccc;
}

* /

 	.rating_star.filled {
	color: goldenrod;
}

img.commentProfile {
	width: 3.5em;
	height: 3.5em;
	margin: 20px 20px;
	border-radius: 50%;
}
</style>

<script src="../resources/js/profileImage.js"></script>
<script>
    	$(document).ready(function() {
    		fetchReviews();
			});

    	function fetchReviews() {
    		let detailId = '<%=detailId%>';
        const data = {
        		detailId: detailId
            };
            
    		console.log("fetchReviews detailId : ", detailId);
    		
    	    $.ajax({
    	        url: "./reviewProcList.jsp", // 리뷰 데이터를 가져올 API 엔드포인트
    	        method: "GET",
    	        data: data,
    	        dataType: "json",
    	        success: function(response) {
    	        	
    	        	console.log("reviewProcList response : ", response);
    	        	
   	            response.forEach(function(review) {
   	                setReview(review); // 각 리뷰 데이터를 셋팅
   	            });
    	        },
    	        error: function(error) {
    	            console.error("리뷰 데이터를 가져오는 중 오류가 발생했습니다.", error);
    	        }
    	    });
    	}
    	
    	
    	function addReview() {
    		
    		// 로그인 체크
				let loginedUser = '<%=user%>';
				if(loginedUser === 'null'){
					loginNotice();
					return;
				}
				
				// 내용 체크
				let contents = $('#review').val();
				if(contents === ''){
				 	openPopupOk({
				 		title : '확인',
				 		content : '한줄평 내용을 입력해주세요.',
				 		onOk : function() {
				 			console.log('Ok 클릭 ');
				 		}
				 	});
				 	return;
				}
				
				// 별점 체크
				let star_num = $('input[name="star_num"]:checked').val();
				console.log('star_num : ', star_num);
				if(star_num === undefined){
					openPopupOk({
				 		title : '확인',
				 		content : '평점을 남겨주세요.',
				 		onOk : function() {
				 			console.log('Ok 클릭 ');
				 		}
				 	});
				 	return;
				}
    		
        		const data = {
			            detailId: '<%=detailId%>',
			            contents: contents,
			            star_num: star_num,
			        };

        		$.ajax({
		            type: "POST",
		            url: "./reviewProcAdd.jsp",
		            data: data,
		            success: function (response) {
		            	console.log("[review.jsp] response.result : ", response.result);
		            	console.log("[review.jsp] response.data : ", response.data);
		            	console.log("[review.jsp] response.data : ", response);
		               
		            	$('#review').val(''); // 입력 필드 초기화
		            	$('input[name="star_num"]:checked').prop('checked', false); // 별점 선택 해제
		            	
		            	setReview(response.data);
		            },
		            error: function (e) {
		            	console.log('오류 : ', e);
		              alert('오류가 발생했습니다.');
		            }
	        	});
    	}
    	
    	function updateReview(reviewId) {
    	    $.ajax({
    	        type: "POST",
    	        url: "./reviewProcUpdate.jsp",
    	        data: { reviewId: reviewId, contents: contents, star_num: starNum },
    	        success: function(response) {
    	            if (response.result) {
    	                console.log("[review2ProcUpdate] response.data : ", response)
    	                location.reload();  // 페이지 새로고침
    	            } else {
    	            }
    	        },
    	        error: function() {
    	            alert("오류가 발생했습니다.");
    	        }
    	    });
    	}
    	
    	function deleteReview(reviewId) {
	   	 	openPopupOkCancel({
	    		title : '확인',
	    		content : '정말로 이 리뷰를 삭제하시겠습니까?',
	    		onOk : function() {
	    			console.log('Ok 클릭 ');
   	        $.ajax({
   	            type: "POST",
   	            url: "./reviewProcDelete.jsp",
   	            data: { reviewId: reviewId },
   	            success: function(response) {
 	                if (response.result) {
										// alert("리뷰가 삭제되었습니다.");
										$('#review_'+reviewId).remove();
 	                } else {
 	                  alert("리뷰 삭제에 실패했습니다.");
 	                }
   	            },
   	            error: function() {
   	                alert("오류가 발생했습니다.");
   	            }
	   	        });	    			
	      		},
		    		onCancel : function() {
		    			console.log('Cancel 클릭 ');
		    		}
	    	});    		
    	}
    	
    	

//     	[수정]
//     	nickname 대체: 닉네임 대신 email을 표시합니다. JSON 데이터에 닉네임 정보가 없기 때문에 email을 닉네임 대신 사용했습니다.
//     	작성일 기본 값: formattedCreateAt이 없는 경우 기본 텍스트로 "작성일: 정보 없음"을 출력합니다.
//     	수정/삭제 버튼 제외: isAuthor 정보가 JSON에 없으므로, 수정 및 삭제 버튼 관련 로직은 생략했습니다.
//     	JSON 데이터 사용: 주어진 JSON 데이터 구조를 그대로 사용하여 리뷰 내용을 화면에 출력합니다.
    	
		function setReview(review) {		

			console.log('[setReview] review.img_path : ', review.img_path);
	
			let imageTag = '';
			if(review.img_path === undefined){
				imageTag = generateProfileImageSvgTag(128, 128, '#CBDCF5', 0);
			}else{
				const imgPath = getContextPath() + "/resources/image/profileImage/" + review.img_path;
				imageTag = '<img class="commentProfile" src="' + imgPath + '" style="margin:auto;">';
			}
			
			const create_at_dateOnly = review.create_at.split(' ')[0];
			
// 		    let formattedContent = review.contents.replace(/\n/g, "<br>");
			console.log("review.id : ",review.id+" review.star_num : " + review.star_num);
		    let reviewHTML = 
		        '<div id="review_' + review.id + '" class="d-flex container border-primary border-2 border-bottom pb-3 my-3">' +
		            '<div class="container d-flex flex-column py-3 my-auto" style="width: 195px; height: auto;">' +
		            
		                '<div id="profile" class="d-flex container  mx-auto my-0"> ' + imageTag + '</div>' +
		                
		                '<div class="border-bottom mb-2" style="width:90%;"></div>' +
		                '<div id="nickname" class="mb-0" style="overflow:hidden; width:100%;">' +
		                    '<h5 class="text-center m-0" style="width:auto; overflow:hidden">' + review.nickname + '</h5>' +
		                '</div>' +
		            '</div>' +
		
		            '<div class="border border-primary-subtle" style="width: 1px; height: 210px;"></div>' +
		            '<div class="container p-2 my-auto" style="width: 972px;">' +
		            '<div style="width:150px;">' +
                		'<div id="reviewStar_'+review.id+'" class="text-center m-0"></div>' +
            		'</div>' +
	              	  '<div id="editStarNum_'+review.id+'" class="d-flex flex-column justify-content-between d-none ms-3 mt-4" style="width: 120px;">' +
		              	'<div class="star-rating justify-content-between" name="star_num" style="margin-top:-20px;">' +
			                '<input type="radio" class="star" name="edit_star_num" value="1"' + (review.star_num == 1 ? ' checked' : '') + '>' +
			                '<input type="radio" class="star" name="edit_star_num" value="2"' + (review.star_num == 2 ? ' checked' : '') + '>' +
			                '<input type="radio" class="star" name="edit_star_num" value="3"' + (review.star_num == 3 ? ' checked' : '') + '>' +
			                '<input type="radio" class="star" name="edit_star_num" value="4"' + (review.star_num == 4 ? ' checked' : '') + '>' +
			                '<input type="radio" class="star" name="edit_star_num" value="5"' + (review.star_num == 5 ? ' checked' : '') + '>' +
	                  '</div>' +
            		'</div>'+
		                '<div id="reviewContent_' + review.id + '" class="pt-1 ps-2 ms-1 mt-1 border review_content" style="height:100px;">' + review.contents + '</div>' +
		                '<div id="editForm_' + review.id + '" class="ms-1 mt-1 review_content d-none" style="height:100px;">' +  // 수정 폼을 기본적으로 숨김
		                    '<textarea id="editReview_' + review.id + '" class="form-control" style="resize:none;">' + review.contents + '</textarea>' +
		                '</div>' +
		                '<div class="ms-1 d-flex review_subcontent">' +
		                    '<p class="me-auto my-auto">작성일 : '+ create_at_dateOnly +'</p>' +
	                    '<button class="btn btn-primary mt-1 p-1 me-2 editSubForm_'+review.id+' d-none" onclick="saveReview(' + review.id + ')">저장</button>' +
	                    '<button class="btn btn-secondary mt-1 p-1 me-3 editSubForm_'+review.id+' d-none" onclick="cancelEdit(' + review.id + ')">취소</button>';
            
	                    console.log("review.id : ",review.id+" review.star_num : " + review.star_num);
            
	    				let loginedEmail =  '<%=user != null ? user.getEmail() : ""%>';
	    				
	    				if(loginedEmail === ''){
	    					// 비로그인 상태이면
	    	        reviewHTML +=
	    					'<button class="btn btn-danger p-1 me-3 mt-1" onclick="loginNotice()">신고</button>' ;
	    				}else if(review.email === loginedEmail) {
	    					// 현재 로그인한 사용자와 작성자 같으면
	    		        reviewHTML +=
	    		                    '<button class="btn btn-outline-primary p-1 me-2 mt-1 reviewSubForm_'+review.id+'" onclick="showEditForm(' + review.id + ')">수정</button>' +
	    		                    '<button class="btn btn-danger p-1 mt-1 me-3 reviewSubForm_'+review.id+'" onclick="deleteReview(' + review.id + ')">삭제</button>';
	    				
	    		    }else{
	    		    	// 현재 로그인한 사용자와 작성자 다르면
	    		    	reviewHTML +=
	    	    					'<button class="btn btn-danger p-1 me-3 mt-1" onclick="reportReview(' + review.id + ', this)">신고</button>' ;
	    		    }
	    		
		    
		    
		
		    reviewHTML += 
		                '</div>' +
		            '</div>' +
		        '</div>';
		
		    $('#reviewsContainer').append(reviewHTML);
		    drawStars(review.star_num, review.id);
		}
		
		function showEditForm(reviewId) {
		    // 기존 리뷰 내용을 숨기고 수정 폼을 표시
		    $('#reviewContent_' + reviewId).addClass('d-none');  // 리뷰 내용을 숨김
		    $('.reviewSubForm_'+reviewId).addClass('d-none');    // 리뷰 기본 버튼을 표시
		    $('#reviewStar_' + reviewId).addClass('d-none');    // 수정 폼을 표시
		    $('#editForm_' + reviewId).removeClass('d-none');    // 수정 폼을 표시
		    $('#editStarNum_' + reviewId).removeClass('d-none');    // 수정 폼을 표시
		    $('.editSubForm_'+reviewId).removeClass('d-none');    // 수정 폼을 표시
		}
		
		function cancelEdit(reviewId) {
		    // 수정 취소 시 폼을 숨기고 리뷰 내용을 다시 표시
		    $('#editForm_' + reviewId).addClass('d-none');       // 수정 폼을 숨김
		    $('#editStarNum_' + reviewId).addClass('d-none');       // 수정 폼을 숨김
		    $('.editSubForm_'+reviewId).addClass('d-none');    // 수정 폼을 표시
		    $('#reviewContent_' + reviewId).removeClass('d-none'); // 리뷰 내용을 다시 표시
		    $('.reviewSubForm_'+reviewId).removeClass('d-none');    // 리뷰 기본 버튼을 표시
		    $('#reviewStar_' + reviewId).removeClass('d-none');    // 수정 폼을 표시
		}

    	
    	function saveReview(reviewId) {
    	    let updatedContent = $('#editReview_' + reviewId).val();
    	    let updatedStarNum = $('input[name="edit_star_num"]:checked').val();
    	    const targetElement = document.getElementById('reviewStar_'+reviewId);
    	    const childElements = targetElement.querySelectorAll('*');
    	    let intStarNum = parseInt($('input[name="edit_star_num"]:checked').val(), 10);
			console.log("updatedStarNum : ", updatedStarNum);
    	    $.ajax({
    	        type: "POST",
    	        url: "./reviewProcUpdate.jsp",
    	        data: { reviewId: reviewId, contents: updatedContent, star_num: updatedStarNum },
    	        success: function(response) {
    	            if (response.result) {
    	            	Array.from(childElements).forEach(child => {
    	            	    targetElement.removeChild(child);
    	            	});
    	            	drawStars(intStarNum, reviewId);
//     	                location.reload();  // 페이지 새로고침 (또는 해당 리뷰만 다시 로드)
						let updatedReview = response.data;
						
						$('#reviewContent_' + reviewId).text(updatedReview.contents);
// 						$('#review_' + reviewId).find('.starpoint').text("별점 " + updatedReview.star_num);
						
						cancelEdit(reviewId);
						

    	            } else {
    	                alert("리뷰 수정에 실패했습니다.");
    	            }
    	        },
    	        error: function() {
    	            alert("오류가 발생했습니다.");
    	        }
    	    });
    	}
    	
    	
			// 투트 경로 얻는 코드 
			function getContextPath() {
				var hostIndex = window.location.href.indexOf(window.location.host) + window.location.host.length;
				var contextPath = window.location.href.substring(hostIndex, window.location.href.indexOf('/', hostIndex + 1));
				return contextPath;
			}
			
			// 로그인 권유 
			function loginNotice() {
			 	openPopupOk({
			 		title : '확인',
			 		content : '로그인 이후에 사용할 수 있습니다.',
			 		onOk : function() {
			 			console.log('Ok 클릭 ');
			 		}
			 	});
			}
			
			// TODO:JHK - 신고(review, 한줄평) deleteReview() 처리해야 한다. -> reportReview()
			function reportReview(reviewId, element) {
				console.log("reviewId : " + reviewId);
				reportContent('review', reviewId, element);
				
			}
    	
    	
			// TODO:JHK - 중복코드, 공통으로 처리해야 한다
    	function reportContent(type, contentId, element){
    		console.log("reportContent type : ", type);
    		console.log("reportContent contentId : ", contentId);
    		console.log("reportContent element : ", element);
    		
				openPopupInput({
				  title: '이 한줄평을 신고하시겠습니까?',
				  placeholder: '신고 내용을 적어주세요',
				  onConfirm: function(content) {
				    console.log('확인 클릭:', content);
	    			 $.ajax({
	    					type: "POST",
	    					url: getContextPath() + "/manager/reportProc.jsp",
	    					data: {
	    						reason: content,
	    						type: type,
	    						reportedId: contentId
	    					},
	    					dataType: 'json',
	    					success: function(res) {
	    						if (res.result) {
	    							alert('한줄평이 신고되었습니다.');
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
	

			
    </script>
</head>

<body>
	<%-- 	<jsp:include page="reviewProc.jsp" /> --%>
	<%@include file="../common/popupInput.jsp"%>
	<%@include file="../common/popupOkCancel.jsp"%>
	<%@include file="../common/popupOk.jsp"%>

	<div id="review_subtitle" class="mx-auto" style="width: 1300px;">
		<h3 class="pt-0">
			<p
				class="border-bottom border-2 pb-1 border-primary-subtle mt-4 mb-0"
				style="width: 85px;">한줄평</p>
		</h3>
	</div>

	<div id="review_textarea"
		class="container border-2 border-primary border-bottom py-3 mt-0">
		<div class="w-100 mx-auto d-flex">
			<!-- 왼쪽 textarea 구역 -->
			<textarea class="form-control border-2 flex-grow-1 me-3"
				name="contents" id="review" style="height: 100px; resize: none;"></textarea>

			<!-- 오른쪽 별점 + 남기기 버튼 구역 -->
			<div class="d-flex flex-column justify-content-between"
				style="width: 150px;">
				<!-- 별점 입력 -->
				<div class="star-rating mb-3 justify-content-between"
					name="star_num" style="margin-top: -20px;">
					<input type="radio" class="star" name="star_num" value="1" checked>
					<input type="radio" class="star" name="star_num" value="2">
					<input type="radio" class="star" name="star_num" value="3">
					<input type="radio" class="star" name="star_num" value="4">
					<input type="radio" class="star" name="star_num" value="5">
				</div>

				<!-- 남기기 버튼 -->
				<button type="button" class="btn btn-outline-primary"
					onclick="addReview()"
					style="width: auto; height: 50px; margin-bottom: 15px;">남기기</button>
			</div>
		</div>
	</div>

	<!-- 리뷰 전제 목록을 보여주는 부분 -->
	<div id="reviewsContainer"></div>


</body>

</html>














