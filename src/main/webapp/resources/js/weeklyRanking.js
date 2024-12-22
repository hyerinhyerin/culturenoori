function drawStars(rating, index) {
	const starContainers = document.querySelectorAll('.star-container-'+index);
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
				star.style.background = `linear-gradient(90deg, #daa520 ${percentage}%, #ccc ${percentage}%)`;
				star.style.webkitBackgroundClip = 'text';
				star.style.webkitTextFillColor = 'transparent';
			}
			starContainer.appendChild(star);
			//위의 조건이 아닌 별(3.7일때 5번째 별)은 빈 별로 생성한다.
		}
	});
}