/**
 * 
 */

const sectionBottom = document.getElementById("section-bottom");


function addClickedClass(){
	const currentPage = parseInt(sectionBottom.getAttribute("data-current-page"));

  const moveBtnList = sectionBottom.querySelectorAll("button");
		
  moveBtnList.forEach((moveBtn) => {
    const pageNum = parseInt(moveBtn.textContent);
    if (pageNum === currentPage) {
      moveBtn.classList.add("clicked");
    }
  });
}

document.addEventListener("DOMContentLoaded", function () {
	addClickedClass();
});


document.getElementById('boardWriteBtn').addEventListener('click', function(){
	location.href="./boardAdd.jsp";
});


//tr click -> view count+1
function addRowClickEvent(){
	document.querySelectorAll("tr[data-board-id]").forEach((row) => {
	  row.addEventListener("click", function() {
	    const boardId = this.getAttribute("data-board-id");
			const searchField = document.getElementById('bSearchSelect').value;
		  const searchWord = document.getElementById('searchWordInput').value;
			const sort = sortSelect.value;
			const category = categorySelect.value;
//			const currentPage = sectionBottom.getAttribute("data-current-page");
	    
			$.ajax({
			  type: "post",
			  url: "viewcountProc.jsp",
			  data: { boardId: boardId},
			  dataType: 'json',
			  success: function(res) {
			  	if(res.result){
//			      alert("조회수 추가");
					  location.href=`./boardDetail.jsp?boardId=${boardId}&sort=${sort}&category=${category}&searchField=${searchField}&searchWord=${searchWord}`;
			  	}else{
			   	 alert("조회수 추가 실패");
			  	}
			  },
			  error: function() {
			    alert("에러가 발생했습니다. 다시 시도해주세요");
			  }
			});
	  });
	});
}

document.addEventListener("DOMContentLoaded", function() {
	document.querySelectorAll("tr[data-notice-id]").forEach((row) => {
	  row.addEventListener("click", function() {
			console.log("data-notice-id click");
	    const noticeId = this.getAttribute("data-notice-id");
			const searchField = document.getElementById('bSearchSelect').value;
		  const searchWord = document.getElementById('searchWordInput').value;
			const sort = sortSelect.value;
			const category = categorySelect.value;
//			const currentPage = sectionBottom.getAttribute("data-current-page");
			location.href=`./boardDetail.jsp?noticeId=${noticeId}&sort=${sort}&category=${category}&searchField=${searchField}&searchWord=${searchWord}`;

	  });
	});
});


//sort function
const sortSelect = document.getElementById("bSort");
const categorySelect = document.getElementById("bSort-category");


function updateBoardList(){
	const searchField = document.getElementById('bSearchSelect').value;
  const searchWord = document.getElementById('searchWordInput').value;
	const sortValue = sortSelect.value;
	const category = categorySelect.value;
	const currentPage = 1;

	$.ajax({
	  type: "get",
	  url: "boardSortProc.jsp",
	  data: { 
			currentPage:currentPage,
			sort: sortValue,
			category:category,
			searchField:searchField,
			searchWord:searchWord				
		},
	  dataType: 'json',
	  success: function(res) {
	  	refreshBoardList(res.boardList, res.noticeList);
	  	updatePagination(res.totalPages);
			
	    const newUrl = `./boardList.jsp?page=1&sort=${sortValue}&category=${category}&searchField=${searchField}&searchWord=${searchWord}`;
	    history.pushState(null, null, newUrl);
	  },
	  error: function() {
	    alert("에러가 발생했습니다.다시 시도해주세요.");
		}
	});
}

sortSelect.addEventListener("change", updateBoardList);
categorySelect.addEventListener("change", updateBoardList);
document.getElementById('searchButton').addEventListener('click',updateBoardList);
document.getElementById('searchWordInput').addEventListener('keydown', function(event) {
  if (event.key === 'Enter') {
    event.preventDefault();  // 폼 제출 방지
    updateBoardList();
  }
});

function refreshBoardList(boardList, noticeList){
	const tablebody = document.querySelector("tbody");

	if(noticeList.length > 0){
		const noticeHTML = noticeList.map(notice => {
			const truncatedTitle = notice.title.length>10 ? notice.title.substring(0,10)+"..." : notice.title;
			return `
			<tr data-notice-id="${notice.id}" style="cursor:pointer;" class="noticeBackground">
	      <td>${notice.id}</td>
	      <td>공지사항</td>
	      <td>${truncatedTitle}</td>
	      <td>관리자</td>
	      <td>${notice.date}</td>
	      <td>-</td>
	      <td>-</td>
	    </tr>
			`;
		}).join("");
		tablebody.innerHTML = noticeHTML;
	}else{
		tablebody.innerHTML = "";
	}

	
	const boardPerPageFirst = noticeList.length === 0 ? 8 : 5; // 첫 페이지에 표시할 게시글 수
	const boardPerPageOther = 8;
	const currentPage = parseInt(sectionBottom.getAttribute("data-current-page"));
			
	
	if (boardList.length === 0) {
		const noResultsRow = `<tr><td colspan='7' class='emptyRow'>게시글 결과가 없습니다.</td></tr>`;
    tablebody.innerHTML += noResultsRow;
		for (let i = 1; i < boardPerPageOther; i++) {
			const emptyRow = `<tr><td colspan='7' class='emptyRow'>&nbsp;</td></tr>`;
			tablebody.innerHTML += emptyRow;
		}
  } else {
  	boardList.forEach(board => {
			const truncatedTitle = board.title.length > 10 ? board.title.substring(0, 10) + "..." : board.title;
			
//			if(board.reportState === 1){
//				const reportrow = `
//				<tr style="cursor:pointer; background-color:#f8d7da;">
//					<td colspan="7" class="reportStateRow">신고처리된 게시글입니다.</td>
//				</tr>`;
//				tablebody.innerHTML += reportrow;
//				
//			}else{
				const row = `<tr data-board-id="${board.id}" style="cursor:pointer;">
				          <td>${board.id}</td>
				          <td>${board.type}</td>
				          <td>${truncatedTitle}</td>
				          <td>${board.nickname}</td>
				          <td>${board.date}</td>
				          <td>${board.views}</td>
				          <td>${board.likeCount}</td>
				      	</tr>`;
				      tablebody.innerHTML += row;
//			}
      
  	});
			
//			const remainingRows = (currentPage === 1 ? boardPerPageFirst : boardPerPageOther) - boardList.length;
			const remainingRows = boardPerPageFirst - boardList.length;
      if (remainingRows > 0) {
				for (let i = 0; i < remainingRows; i++) {
          const emptyRow = `<tr><td colspan='7' class='emptyRow'>&nbsp;</td></tr>`;
          tablebody.innerHTML += emptyRow;
        }
      }
    }
			
	addRowClickEvent();
}

function updatePagination(totalPages){
	let totalPage = parseInt(totalPages);
	console.log("js totalPages = ", totalPage);
	const sectionBottom = document.getElementById("section-bottom");
	sectionBottom.innerHTML="";
	
	const currentPage= 1;	
	sectionBottom.setAttribute("data-current-page", currentPage);
	const searchField = document.getElementById('bSearchSelect').value;
  const searchWord = document.getElementById('searchWordInput').value;
	const sortValue = sortSelect.value;
	const categoryValue = categorySelect.value;
		
	if (currentPage > 1) {
	    sectionBottom.innerHTML += `<button onclick="location.href='./boardList.jsp?page=${currentPage - 1}&sort=${sortValue}&category=${categoryValue}&searchField=${searchField}&searchWord=${searchWord}'">이전</button>`;
	} else {
	    sectionBottom.innerHTML += `<button onclick="location.reload()">이전</button>`;
	}

	for (let i = 1; i <= totalPage; i++) {
	    sectionBottom.innerHTML += `<button onclick="location.href='./boardList.jsp?page=${i}&sort=${sortValue}&category=${categoryValue}&searchField=${searchField}&searchWord=${searchWord}'">${i}</button>`;
	}

	if (currentPage < totalPage) {
	    sectionBottom.innerHTML += `<button onclick="location.href='./boardList.jsp?page=${currentPage + 1}&sort=${sortValue}&category=${categoryValue}&searchField=${searchField}&searchWord=${searchWord}'">다음</button>`;
	} else {
	    sectionBottom.innerHTML += `<button onclick="location.reload()">다음</button>`;
	}
	
	addClickedClass();
}


addRowClickEvent();