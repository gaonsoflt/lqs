function printClock() {

	var clock = document.getElementById("clock"); // 출력할 장소 선택
	var date = document.getElementById("date"); // 출력할 장소 선택
	var currentDate = new Date(); // 현재시간
	var calendar = currentDate.getFullYear() + "-"
			+ (currentDate.getMonth() + 1) + "-" + currentDate.getDate() // 현재
																			// 날짜
	var amPm = 'AM'; // 초기값 AM
	var currentHours = addZeros(currentDate.getHours(), 2);
	var currentMinute = addZeros(currentDate.getMinutes(), 2);
	var currentSeconds = addZeros(currentDate.getSeconds(), 2);

	var currentYear= currentDate.getYear() + 1900;
	var currentMonth = addZeros(currentDate.getMonth() + 1, 2);
	var currentDay = addZeros(currentDate.getDate(), 2);
	var currentWeek = convertWeek(currentDate.getDay());
	
	if (currentHours >= 12) { // 시간이 12보다 클 때 PM으로 세팅, 12를 빼줌
		amPm = 'PM';
		currentHours = addZeros(currentHours - 12, 2);
	}

	if (currentSeconds >= 50) {// 50초 이상일 때 색을 변환해 준다.
		currentSeconds = '<span style="color:#de1951;">' + currentSeconds + '</span>'
	}
	clock.innerHTML = currentHours + ":" + currentMinute + ":" + currentSeconds
			+ " <span style='font-size:30px;'>" + amPm + "</span>"; // 날짜를 출력해 줌
	date.innerHTML = currentYear + "-" + currentMonth + "-" + currentDay + " (" + currentWeek + ")";

	setTimeout("printClock()", 1000); // 1초마다 printClock() 함수 호출
}

function addZeros(num, digit) { // 자릿수 맞춰주기
	var zero = '';
	num = num.toString();
	if (num.length < digit) {
		for (i = 0; i < digit - num.length; i++) {
			zero += '0';
		}
	}
	return zero + num;
}

function convertWeek(day) { // 자릿수 맞춰주기
	if(day == 0) {
		return 'SUN';
	} else if(day == 1) {
		return 'MON';
	} else if(day == 2) {
		return 'TUE';
	} else if(day == 3) {
		return 'WED';
	} else if(day == 4) {
		return 'THU';
	} else if(day == 5) {
		return 'FRI';
	} else {
		return 'SAT';
	}
}
