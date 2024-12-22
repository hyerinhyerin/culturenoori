/**
 * 
 */

function deleteBoard(boardId){
	if(confirm("게시글을 삭제하시겠습니까?")){
		$.ajax({
			url:'./activityProc/deleteBoardProc.jsp',
			type:'POST',
			dataType:'json',
			data:{
				boardId:boardId
			},
			success:function(res){
				if(res.result){
//					alert("게시글이 삭제되었습니다.");
					location.reload();
				}else{
					alert("게시글 삭제에 실패하였습니다.");
				}
			},
			error:function(){
				alert("에러가 발생했습니다. 다시 시도해주세요.");
			}
		});
	}
}