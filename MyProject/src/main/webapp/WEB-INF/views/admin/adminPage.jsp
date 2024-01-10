<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>함께해요~ 중앙😊</title>
	
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="resources/css/admin.css" />

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

.cont {
	background-color:white !important;
	margin:30px !important;
}

.line {
	border: 3px solid black !important;
	width:100%;
}

.mr {
	margin-right : 50px;
}

.card {
	height:180px !important;
}

</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/inc/AdminHeader.jsp" %>
    
    <div class="container-fluid p-0">
  		<img class="img-fluid w-100" src="resources/img/main3.jpg">
	</div>
	<div style="display:flex; justify-content: space-around;">
		<div class="container mt-4 cont shadow p-3 mb-5 bg-white rounded" style="width:100%">
			<h3 class="bold mt-3 text-center" style="width:100%" >합산 통계</h3>
			<hr class="line">
			<div style="display:flex; justify-content: space-around;">
			<p>총 회원 수 : <span class="bold">3,421</span></p>
			<p>전체 조회 수 : <span class="bold">124,432</span></p>
			<p>전체 작성된 글 수 : <span class="bold">1,238</span></p>
			<p>전체 작성된 댓글 수 : <span class="bold">20,423</span></p>
			</div>
			<div style="display:flex; justify-content: space-around;">
			<p>금일 회원 가입 수 : <span class="bold">168</span></p>
			<p>금일 조회 수 : <span class="bold">1,234</span></p>
			<p>금일 작성된 글 수 : <span class="bold">41</span></p>
			<p>금일 작성된 댓글 수 : <span class="bold">632</span></p>
			</div>
		</div>
	</div>
	
	<div style="display:flex;">
		<div class="container mt-4 cont shadow p-3 mb-5 bg-white rounded" style="display:flex; flex-direction: column;
	    align-items: center;">
			<h3 class="bold mt-3">현재 접속량 통계</h3>
			<hr class="line">
			<div class="mb-4">
				<canvas id="chart" width="200" height="200"></canvas>
			</div>
		</div>
		<div class="container mt-4 cont shadow p-3 mb-5 bg-white rounded" style="display:flex; flex-direction: column;
	    align-items: center;">
			<h3 class="bold mt-3">현재 부분별 접속량</h3>
			<hr class="line">
			<div class="mb-4">
				<canvas id="barChart" width="400" height="200"></canvas>
			</div>
		</div>
	</div>
	
	<div style="display:flex;">
		<div class="container mt-4 cont shadow p-3 mb-5 bg-white rounded" style="display:flex; flex-direction: column;
	    align-items: center;">
	    	<h3 class="bold mt-3">Recent 5 와글와글</h3>
			<hr class="line">
	        <div class="row">
	        	
	       	<c:forEach items="${list}" var="dto">
			    <div class="card">
			        <div class="card-body">
			        	<div style="display:flex; justify-content: space-between;">
				            <h5 class="card-title">${dto.talk_subject}</h5>
				        	<p class="card-text text-danger bold">${dto.dep_name}</p>
			            </div>
			            <p class="card-text">${dto.talk_content}</p>
			            <!-- 클릭 이벤트 핸들러 추가 -->
			            <div style="display:flex; justify-content: space-between;">
			            	<a class="btn btn-primary" onclick="showDetails('${dto.talk_subject}', '${dto.talk_content}', '${dto.cus_id}', '${dto.dep_name}', '${dto.talk_num}', '${dto.talk_like}')">자세히 보기</a>
			            	<div style="display:flex;">
			            		<img id="profile" class="profile" src="resources/img/로고.png">
			            		<p class="card-text mt-3 bold" style="display:flex; flex-direction: row-reverse;">${dto.cus_name}(${dto.cus_id})</p>
			        		</div>
			        	</div>
			        </div>
			    </div>
			</c:forEach> 
				
	        </div>
	    </div>
	    
	    <div class="container mt-4 cont shadow p-3 mb-5 bg-white rounded" style="display:flex; flex-direction: column;
	    align-items: center;">
	    	<h3 class="bold mt-3">Hot 5 와글와글</h3>
			<hr class="line">
	        <div class="row">
	        	
	       	<c:forEach items="${list2}" var="dto">
			    <div class="card">
			        <div class="card-body">
			        	<div style="display:flex; justify-content: space-between;">
				            <h5 class="card-title">${dto.talk_subject}</h5>
				        	<p class="card-text text-danger bold">${dto.dep_name}</p>
			            </div>
			            <p class="card-text">${dto.talk_content}</p>
			            <!-- 클릭 이벤트 핸들러 추가 -->
			            <div style="display:flex; justify-content: space-between;">
			            	<a class="btn btn-primary" onclick="showDetails('${dto.talk_subject}', '${dto.talk_content}', '${dto.cus_id}', '${dto.dep_name}', '${dto.talk_num}', '${dto.talk_like}')">자세히 보기</a>
			            	<div style="display:flex;">
			            		<img id="profile" class="profile" src="resources/img/로고.png">
			            		<p class="card-text mt-3 bold" style="display:flex; flex-direction: row-reverse;">${dto.cus_name}(${dto.cus_id})</p>
			        		</div>
			        	</div>
			        </div>
			    </div>
			</c:forEach> 
				
	        </div>
	    </div>
	    
    </div>
    
    <!-- 모달 창 -->
	<div class="modal" id="talk_detail">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <!-- 모달 헤더 -->
	            <div class="modal-header">
	                <h4 class="modal-title">자세히 보기</h4>
	                 <button type="button" class="close" data-dismiss="modal" onclick="closeDetails()">&times;</button>
	            </div>
	            
	            <!-- 모달 본문 -->
	            <div class="modal-body" id="modalContent">
	                <!-- 댓글 내용을 여기에 표시 -->
	            </div>
	        </div>
	    </div>
	</div>
    
    

    
    <%@ include file="/WEB-INF/views/inc/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>

// ----------------- 그래프 생성 Script -------------------
// 도넛 차트 데이터
var doughnutData = {
  labels: ['와글와글', '함께해요', '그외'],
  datasets: [{
    data: [2311, 3213, 2980], // 데이터 값
    backgroundColor: ['#CDB2DB', '#FFAFCD', '#A3D2FF'], // 각 섹션의 색상
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
	    data: [2311, 3213, 2980],
	    backgroundColor: ['#CDB2DB', '#FFAFCD', '#A3D2FF'],
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

//----------------- Talk Modal 처리 -------------------
var nownum;

//자세히보기 -> showDetails -> 소통 공간
function showDetails(subject, content, customerId, depname, talknum, talklike) {
    // 콘솔에 로그 출력
    //console.log("showDetails 함수 호출");

    nownum = talknum;
    //console.log(talknum);

    // 모달 헤더 -> 제목
    document.querySelector(".modal-title").innerText = subject;

    // 모달 본문 -> 내용
    var modalContent = document.getElementById("modalContent");
    modalContent.innerHTML = "<p><strong>내용 :</strong> " + content + "</p>" +
        "<p><strong>회사 :</strong> " + depname + "</p>" +
        "<p><strong>작성자 :</strong> " + customerId + "</p>" +
        '<p id="count"><div class="box"><div id="like" class="like">❤️</div> ' + talklike + '</p></div>' +
        "<hr>" +
        '<h5 class="mb-3 text-center fw-bold">😄열려있는 소통의 창구😄</h5>' +
        '<div id="dynamicContent"></div>';

    // Ajax -> 현재 클릭된 talk_num -> 해당 정보 json으로 가저와 -> 동적 생성
    $.ajax({
        url: '/project/talk/' + nownum,
        method: 'GET',
        data: JSON.stringify(),
        dataType: "json",
        success: function(data) {
            // 데이터를 받아와서 동적으로 HTML 생성
            var dynamicContent = document.getElementById("dynamicContent");
            data.forEach(function(dto2) {
            	console.log(dto2.ans_content);
                dynamicContent.innerHTML += '<div class="container border mb-2 mt-0">' +
                    '<div class="row">' +
                    '<div class="col-md-9">' +
                    '<p class="mt-2">' + dto2.ans_content + '</p>' +
                    '</div>' +
                    '<div class="col-md-3 text-end">' +
                    '<p class="mt-2">' + dto2.cus_id + '</p>' +
                    '</div>' +
                    '</div>' +
                    '</div>';
            });
        },
        error: function() {
            console.error('Failed to fetch additional data from the server.');
        }
    });

    // 모달 열기
    $("#talk_detail").modal('show');
    
    document.getElementById("like").addEventListener('click', function(){
    	
    	 var count = document.getElementById("count").innerHTML;
    	 console.log("클릭됨");
    	 console.log(talklike);
    	
    	 $.ajax({
    	        url: '/project/talk/like',
    	        method: 'GET',
    	        data: {
    	            talkNum : nownum,
    	            likeNum : talklike
    	        },
    	        success: function(data) {
    	            closeDetails();
    	            showDetails(subject, content, customerId, depname, talknum, data);
    	        	
    	            console.log("성공");
    	        	
    	        },
    	        error: function() {
    	            console.error('Failed to fetch additional data from the server.');
    	        }
    	    });
    	
    });
}

//모달 닫기
function closeDetails() {
	$("#talk_detail").modal('hide');
}

</script>
</body>
</html>