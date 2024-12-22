/**
 * 
 */
function deleteComment(commentId){
	if(confirm("댓글을 삭제하시겠습니까?")){
		$.ajax({
			url:'./activityProc/deleteCommentProc.jsp',
			type:'POST',
			dataType:'json',
			data:{
				commentId:commentId
			},
			success:function(res){
				if(res.result){
//					alert("댓글이 삭제되었습니다.");
					location.reload();
				}else{
					alert("댓글 삭제에 실패하였습니다.");
				}
			},
			error:function(){
				alert("에러가 발생했습니다. 다시 시도해주세요.");
			}
		});
	}
}


function showEdit(commentId,e){
	e.preventDefault();
	const commentText = document.getElementById('commentText'+commentId);
	const commentTA = document.getElementById('commentTA'+commentId);
	const saveButton = document.getElementById('saveButton'+commentId);
	const commentLink = document.getElementById('commentLink'+commentId);
	
	if(commentTA.style.display === "none"){
		commentText.style.display ="none";
		commentTA.style.display="block";
		saveButton.style.display ="inline";
		
		commentLink.onclick = function(e){e.preventDefault();};
	}
}

function saveComment(commentId){
	const updateContent= document.getElementById('commentTA'+commentId).value;
	
	$.ajax({
		url:'./activityProc/updateCommentProc.jsp',
		type:'post',
		dataType:'json',
		data:{
			commentid:commentId,
			content:updateContent
		},
		success:function(res){
			if(res.success){
				const commentText = document.getElementById('commentText'+commentId);
				const commentTA = document.getElementById('commentTA'+commentId);
				const saveButton = document.getElementById('saveButton'+commentId);
				const commentDate = document.getElementById('commentDate'+commentId);
				const commentLink = document.getElementById('commentLink'+commentId);
				
				commentText.innerText = updateContent;
				commentText.style.display = "block";
				commentTA.style.display="none";
				saveButton.style.display ="none";
				
				const now = new Date();
        const formattedDate = now.toISOString().split('T')[0]; // YYYY-MM-DD 형식으로 변환
        commentDate.innerText = formattedDate;
				
				commentLink.onclick = function(){
					location.href=commentLink.href;
				};
			}else{
				alert("댓글 수정에 실패했습니다. 다시 시도해주세요.");
			}
		},error:function(){
			alert("서버에 문제가 발생했습니다. 나중에 다시 시도해주세요.");
		}
	});
}