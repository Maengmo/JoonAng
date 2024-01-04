<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>함께해요~ 중앙!</title>
	
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<style>
body {
	background-color : #EEEEEE !important;
}

#chart {
	width:500px !important;
	height:500px !important;
}

#barChart {
	width:500px !important;
	height:500px !important;
}

.bold {
	font-weight:bold;
}

.container {
	background-color:white !important;
	margin:30px !important;
}

.line {
	border: 5px solid black !important;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/inc/AdminHeader.jsp" %>
    
    <div class="container-fluid p-0">
  		<img class="img-fluid w-100" src="resources/img/main3.jpg">
	</div>
	
	<div style="display:flex;">
		<div class="container mt-4" style="display:flex; flex-direction: column;
	    align-items: center;">
			<h3 class="bold">현재 부분별 접속량</h3>
			<div style="display:flex;">
				<canvas id="chart" width="200" height="200"></canvas>
			</div>
		</div>
		<div class="container mt-4" style="display:flex; flex-direction: column;
	    align-items: center;">
			<h3 class="bold">현재 부분별 접속량</h3>
			<hr class="line">
			<div style="display:flex;">
				<canvas id="barChart" width="400" height="200"></canvas>
			</div>
		</div>
	</div>
	
	<div class="container mt-4">
        <div class="row">
        	
        	<div class="col-md-4 mb-4" onclick="redirectToLink('https://www.megabox.co.kr/')">
			    <div class="card h-100 border rounded shadow">
			        <img src="resources/img/mega.png" class="card-img-top" alt="메가박스">
			        <div class="card-body">
			        	<hr>
			            <h5 class="card-title text-center mb-3" style="font-size: 1.5rem; color: black; font-weight: bold;">메가박스 중앙</h5>
			            <p class="card-text text-muted">현재 작성된 </p>
			        </div>
			    </div>
			</div>
        	
        </div>
    </div>
    
    <%@ include file="/WEB-INF/views/inc/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
// 도넛 차트 데이터
var doughnutData = {
  labels: ['와글와글', '함께해요', '그외'],
  datasets: [{
    data: [2300, 3000, 3000], // 데이터 값
    backgroundColor: ['red', 'green', 'blue'], // 각 섹션의 색상
  }]
};

// 도넛 차트 옵션
var doughnutOptions = {
  cutout: '50%', // 중앙의 빈 공간 크기 (도넛 차트 특유의 옵션)
  
};

//막대 그래프 데이터
var barData = {
  labels: ['와글와글', '함께해요', '그외'],
  datasets: [
	{
	    label: '실시간 접속량',
	    data: [2300, 3000, 3000],
	    backgroundColor: ['red', 'green', 'blue'],
	    borderWidth: 1
 	}
	]
};

// 막대 그래프 옵션
var barOptions = {
  scales: {
    y: {
      beginAtZero: true
    }
  }
};

// 도넛 차트 생성
var doughnutCtx = document.getElementById('chart').getContext('2d');
var doughnutChart = new Chart(doughnutCtx, {
  type: 'doughnut',
  data: doughnutData,
  options: doughnutOptions
});

// 막대 그래프 생성
var barCtx = document.getElementById('barChart').getContext('2d');
var barChart = new Chart(barCtx, {
  type: 'bar',
  data: barData,
  options: barOptions
});
</script>
</body>
</html>