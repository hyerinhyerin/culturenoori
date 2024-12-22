/**
 * 
 */

function deleteReview(reviewId, userEmail){
	if(confirm("한줄평을 삭제하시겠습니까?")){
		$.ajax({
			url:'./activityProc/deleteReviewProc.jsp',
			type:'POST',
			dataType:'json',
			data:{
				reviewId:reviewId,
				userEmail:userEmail
			},
			success:function(res){
				if(res.result){
//					alert("한줄평이 삭제되었습니다.");
					location.reload();
				}else{
					alert("한줄평 삭제에 실패하였습니다.");
				}
			},
			error:function(){
				alert("에러가 발생했습니다. 다시 시도해주세요.");
			}
		});
	}
}

function showEdit(reviewId,e){
	e.preventDefault();
	const reviewText = document.getElementById('reviewText'+reviewId);
	const reviewTA = document.getElementById('reviewTA'+reviewId);
	const saveButton = document.getElementById('saveButton'+reviewId);
	const reviewLink = document.getElementById('reviewLink'+reviewId);
	
	if(reviewTA.style.display === "none"){
		reviewText.style.display ="none";
		reviewTA.style.display="block";
		saveButton.style.display ="inline";
		
		reviewLink.onclick = function(e){e.preventDefault();};
	}
}


function saveReview(reviewId){
	const updateContent= document.getElementById('reviewTA'+reviewId).value;
	
	$.ajax({
		url:'./activityProc/updateReviewProc.jsp',
		type:'post',
		dataType:'json',
		data:{
			reviewId:reviewId,
			content:updateContent
		},
		success:function(res){
			if(res.success){
				const reviewText = document.getElementById('reviewText'+reviewId);
				const reviewTA = document.getElementById('reviewTA'+reviewId);
				const saveButton = document.getElementById('saveButton'+reviewId);
				const reviewLink = document.getElementById('reviewLink'+reviewId);
				const reviewDate = document.getElementById('reviewDate'+reviewId);
				
				reviewText.innerText = updateContent;
				reviewText.style.display = "block";
				reviewTA.style.display="none";
				saveButton.style.display ="none";
				
				const now = new Date();
        const formattedDate = now.toISOString().split('T')[0]; // YYYY-MM-DD 형식으로 변환
        reviewDate.innerText = formattedDate;
				
				reviewLink.onclick = function(){
					location.href=reviewLink.href;
				};
			}else{
				alert("한줄평 수정에 실패했습니다. 다시 시도해주세요.");
			}
		},error:function(){
			alert("서버에 문제가 발생했습니다. 나중에 다시 시도해주세요.");
		}
	});
}