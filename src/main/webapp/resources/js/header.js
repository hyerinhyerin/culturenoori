/*최상단으로 올라가기 기능*/
function scrollToTop() {
    window.scrollTo({
      top: 0,  //페이지 최상단
      behavior: 'smooth'  //부드럽게 스크롤
    });
}
  
//뒤로가기 버튼
function historyBack(){
	history.back();
}

//Filter Bar 고정
