/**
 * 
 */
//파일 업로드 시 미리보기 표시하기
    const imgUpload = document.querySelector("input#contentImage");
    const imgPreview = document.querySelector("ul#imgPreview");

    function previewImg(e) {
      let sel_files = []; // 파일 저장 위치

      //미리보기 영역 초기화
      imgPreview.innerHTML = "";

      let files = e.target.files; //선택한 파일들 객체
			console.log("file count : "+ e.target.files.length);
      let fileArr = Array.from(files); //배열로 변환
      let index = 0;

      fileArr.forEach(function (file) {
        if (!file.type.match("image/*")) {
          alert("이미지만 업로드 가능합니다.");
          return;
        }

        if (files.length < 11) {
          sel_files.push(file); //파일 저장 배열에 파일 넣기
          let reader = new FileReader();
          //onload : reader가 파일을 성공적으로 읽었을 때 실행할 함수를 작성하는 것
          reader.onload = function (e) {
            let html = `<li><a id="img_id_${index}"><img src="${e.target.result}" data-file="${file.name}" alt="${file.name}" /></a></li>`; //미리보기에 추가할 컴포넌트
            imgPreview.innerHTML += html;
            index++;
          };
          //readAsDataURL: 비동기적으로 파일을 읽어 바이너리 데이터(이미지)를 url로 변환
          // 여기서 변환된 url이 <img src=""> 경로에 사용되는 것
          reader.readAsDataURL(file);
        }
      });

      if (files.length > 10) {
        alert("최대 10장까지 업로드 할 수 있습니다.");
      }
    }

    imgUpload.addEventListener("change", previewImg);

    //글 등록 시 셀렉트 확인
    document
      .querySelector('form[name="boardForm"]')
      .addEventListener("submit", function (e) {
        e.preventDefault();

		const boardTitle = document.getElementById('boardTitle').value;
//        const noticPriority = document.getElementById("noticPriority").value;
        const boardCategory = document.getElementById("boardCategory").value;
		const contentText = document.getElementById("contentText").value;

//        if (noticPriority === "priority") {
//          alert("우선순위를 선택해 주세요.");
//          return false;
//        }
				if(boardTitle === ""){
					alert("제목을 입력해주세요.");
					return false;
				}

        if(boardCategory === "category") {
          alert("카테고리를 선택해 주세요.");
          return false;
        }
				
				if(contentText === ""){
					alert("게시글 내용을 입력해주세요.");
					return false;
				}

        this.submit();
      });
			
			
			
	document.getElementById("boardBackBtn").addEventListener('click',function(){
		let boardId = document.querySelector('input[name="boardId"]').value;
		let noticeId = document.querySelector('input[name="noticeId"]').value;
		
		if(boardId || noticeId){
			if(noticeId){
				window.location.href="./boardDetail.jsp?noticeId="+noticeId;
			}else if(boardId){
				window.location.href="./boardDetail.jsp?boardId="+boardId;
			}
		}else{
			window.location.href="./boardList.jsp";
		}
	});