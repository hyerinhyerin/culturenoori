
// FIXME:JHK - test - 한줄평 탭변경하기
//changeTab(1);
//let tabName2 = "<%= tab %>";
//console.log(`탭고정2 : ${tabName2}`);



function changeTab(index) {
	const tabName = document.querySelectorAll(".tab_name > h3");
	const underline = document.querySelectorAll(".delete");

	underline.forEach(otherUnderline => {
		otherUnderline.classList.add('border-top');		
	});

	tabName.forEach(btn => {
		btn.classList.remove('border-primary', 'active');		
		btn.classList.add('border-primary-subtle', 'bg-primary-subtle', 'active');
	});
	
	tabName[index].classList.remove('border-primary-subtle', 'bg-primary-subtle', 'active');
	tabName[index].classList.add('border-primary', 'active');									
	underline[index].classList.remove('border-top');
}


// 클릭한 탭과 밑줄효과를 위한 요소들을 저장
const tabName = document.querySelectorAll(".tab_name > h3");
/*const tabContent = document.querySelectorAll(".tab_content > div");*/
const underline = document.querySelectorAll(".delete");

tabName.forEach((btn, index) => {

	btn.addEventListener('click', () => {	//한가지 메뉴를 클릭했을 때

		tabName.forEach(otherName => {		//tabName에 있는 요소를 하나씩 가져와 반복실행
			otherName.classList.remove('border-primary', 'active');		//클릭된 요소를 제외하고는 해당 Class를 지움
			otherName.classList.add('border-primary-subtle', 'bg-primary-subtle', 'active');	//또한 클릭한 요소를 제외한 나머지에 3개의 css를 추가함으로서 선택된 요소만 부각시킴
		});

		/*        tabContent.forEach(otherContent =>{
								otherContent.classList.remove('active');
						});*/

		underline.forEach(otherUnderline => {
			otherUnderline.classList.add('border-top');		//탭기능 시각적 효과를 위한 underline 추가삭제 css클래스
		});

		tabName[index].classList.remove('border-primary-subtle', 'bg-primary-subtle', 'active');	//현재 선택된 요소 대상 흐린효과를 제거하고
		tabName[index].classList.add('border-primary', 'active');									//현재 선택된 요소 대상 강조 효과를 추가한다.
		/*        tabContent[index].classList.add('active');*/
		underline[index].classList.remove('border-top');											//선택된 요소 아래에만 Underline을 삭제
	});


});










