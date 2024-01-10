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
	margin-right : 5px;
}


</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/inc/AdminHeader.jsp" %>
	
	<div style="display:flex; justify-content: space-around;">
		<div class="container mt-4 cont shadow p-3 mb-5 bg-white rounded" style="width:100%">
			<h3 class="bold mt-3 text-center" style="width:100%" >와글와글 게시판 통계</h3>
			<hr class="line">
			<div style="display:flex; justify-content: space-around;">
			<p>전체 조회 수 : <span class="bold">124,432</span></p>
			<p>전체 작성된 글 수 : <span class="bold">1,238</span></p>
			<p>전체 작성된 댓글 수 : <span class="bold">20,423</span></p>
			</div>
			<div style="display:flex; justify-content: space-around;">
			<p>금일 조회 수 : <span class="bold">1,234</span></p>
			<p>금일 작성된 글 수 : <span class="bold">41</span></p>
			<p>금일 작성된 댓글 수 : <span class="bold">632</span></p>
			</div>
		</div>
	</div>
	
	<div style="display:flex;">
		<div class="container mt-4 cont shadow p-3 mb-5 bg-white rounded" style="display:flex; flex-direction: column;
	    align-items: center;">
			<h3 class="bold mt-3">전체 게시물 통계</h3>
			<hr class="line">
			<div class="mb-4">
				<canvas id="chart" width="200" height="200"></canvas>
			</div>
		</div>
		<div class="container mt-4 cont shadow p-3 mb-5 bg-white rounded" style="display:flex; flex-direction: column;
	    align-items: center;">
			<h3 class="bold mt-3">현재 게시물 통계</h3>
			<hr class="line">
			<div class="mb-4">
				<canvas id="barChart" width="400" height="200"></canvas>
			</div>
		</div>
	</div>
	
	<div class="container mt-5">
	  <div class="form-group">
	    <label for="departmentSelect" class="bold">회사 선택</label>
	    <select class="form-control" id="departmentSelect">
	      <option value="1">메가박스</option>
	      <option value="2">휘닉스</option>
	      <option value="3">플레이타임</option>
	      <option value="4">JTBC</option>
	      <option value="5">중앙일보</option>
	      <option value="6">스템커피</option>
	      <option value="7">콘텐트리중앙</option>
	      <option value="8">이외 근무처</option>
	    </select>
	  </div>
	
	  <div class="form-group mt-2">
	    <label for="searchInput" class="bold">검색창</label>
	    <div style="display:flex;">
	    	<input type="text" class="form-control" id="searchInput" placeholder="원하시는 정보를 검색하세요.">
	  		<a id="searchBtn" class="btn btn-primary" style="width:100px; height:35px;" onclick="performSearch()">검색</a>
	  	</div>
	  </div>
	  
	  <div class="form-group mt-2">
	    <label for="searchInput" class="bold">인기 및 최신 검색</label>
	    <div style="display:flex;">
	  		<a class="btn btn-danger mr" style="width:100px; height:35px;" onclick="popularity()">인기순</a>
	  		<a class="btn btn-primary" style="width:100px; height:35px;" onclick="latest()">최신순</a>
	  	</div>
	  </div>
	</div>
    
    <div class="col-9 container-lg mb-3 mt-5">
    	<div class="card h-100 border rounded shadow board-container">
        	<!-- 게시글 목록 -->
	        <c:forEach items="${talkList}" var="dto">
			   <div class="card">
			       <div class="card-body">
			       	<div style="display:flex; justify-content: space-between;">
			            <h5 class="card-title">${dto.talk_subject}</h5>
			        	<p class="card-text text-danger bold">${dto.dep_name}</p>
			           </div>
			           <p class="card-text">${dto.talk_content}</p>
			           <!-- 클릭 이벤트 핸들러 추가 -->
			           <div style="display:flex; justify-content: space-between;">
			           	<div>
			           		<a class="btn btn-primary" onclick="showDetails('${dto.talk_subject}', '${dto.talk_content}', '${dto.cus_id}', '${dto.dep_name}', '${dto.talk_num}', '${dto.talk_like}')">자세히 보기</a>
		           			<a class="btn btn-danger" onclick="delAlert('${dto.talk_num}')">삭제하기</a>
			           	</div>
			           	<div style="display:flex;">
			           		<img id="profile" class="profile" src="resources/img/로고.png">
			           		<p class="card-text bold" style="display:flex; flex-direction: row-reverse;">${dto.cus_name}(${dto.cus_id})</p>
			       		</div>
			       	</div>
			       </div>
			   </div>
			</c:forEach>
        </div>
    </div>
    
    <!-- 모달 창 -->
	<div class="modal" id="myModal">
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
//---------------------------------- 차트 생성 ----------------------------------
// 도넛 차트 데이터
var doughnutData = {
  labels: ['전체 조회수', '전체 작성된 글 수', '전체 작성된 댓글 수'],
  datasets: [{
    data: [124432, 1238, 20423], // 데이터 값
    backgroundColor: ['#023048', '#8DCBE6', '#229EBD'], // 각 섹션의 색상
  }]
};

// 도넛 차트 옵션
var doughnutOptions = {
  cutout: '50%', // 중앙의 빈 공간 크기 (도넛 차트 특유의 옵션)
  
};

//막대 그래프 데이터
var barData = {
  labels: ['금일 조회수', '금일 작성된 글 수', '금일 작성된 댓글 수'],
  datasets: [
	{
	    label: '금일 조회수',
	    data: [1234, 41, 632],
	    backgroundColor: ['#023048', '#8DCBE6', '#229EBD'], // 각 섹션의 색상
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
//--------------------------------------- 게시물 자세히 보기 -------------------------------------------
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
        '<div id="dynamicContent"></div>' +
        '<hr>' 

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
                    '<div style="display:flex; justify-content: center; flex-direction: column;">' +
                    '<button type="button" class="btn btn-danger" onclick="delAnswer(\'' + dto2.ans_num + '\', \'' + dto2.talk_num + '\')">댓글 삭제</button>'
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
    $("#myModal").modal('show');
    
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
	$("#myModal").modal('hide');
}

//---------------------------------------- 게시물 삭제 ------------------------------------------- 
function delAlert(talk_num) {
	Swal.fire({
        title: "정말 삭제하시겠습니까?",
        text: "☢️삭제 하시면 복구 할 수 없습니다..",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "삭제하기",
        cancelButtonText: "취소하기"
    }).then((result) => {
        
        if (result.isConfirmed) {
            
        	confirmAlert('삭제가 완료 되었습니다.', '바로 갱신 완료!😁', 'success', talk_num);
               
        } else {
            
        }
    });

}

function confirmAlert(title, text, icon, talk_num) {
    Swal.fire({
        title: title,
        text: text,
        icon: icon,
        showCancelButton: true,
        confirmButtonText: "확인",
        cancelButtonText: "닫기"
    }).then((result) => {
    
		if (result.isConfirmed) {
            
        	location.href='/project/adminTalk/delTalk.do?talk_num='+talk_num;
               
        } else {
            
        }
    
    });
}
//---------------------------------------- 댓글 삭제 ------------------------------------------- 
function delAnswer(ans_num, talk_num) {
	
	delAnswer_alert(ans_num, talk_num);
	console.log(ans_num, talk_num);
	
}

function delAnswer_alert(ans_num, talk_num) {
	Swal.fire({
        title: "정말 삭제하시겠습니까?",
        text: "☢️삭제 하시면 복구 할 수 없습니다..",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "삭제하기",
        cancelButtonText: "취소하기"
    }).then((result) => {
        
        if (result.isConfirmed) {
        	
        	$.ajax({
                url: '/project/adminTalk/delAnswer',
                method: 'GET',
                data: {
                    ans_num: ans_num,
                    talk_num: talk_num
                },dataType: "json",
                success: function(data) {
                    // 데이터를 받아와서 동적으로 HTML 생성
                    var dynamicContent = document.getElementById("dynamicContent");
                    
                    $("#dynamicContent").empty();
                    
                    data.forEach(function(dto2) {
                    	console.log(dto2.ans_content);
                        dynamicContent.innerHTML += '<div class="container border mb-2 mt-0">' +
                            '<div class="row">' +
                            '<div class="col-md-9">' +
                            '<p class="mt-2">' + dto2.ans_content + '</p>' +
                            '</div>' +
                            '<div class="col-md-3 text-end">' +
                            '<p class="mt-2">' + dto2.cus_id + '</p>' +
                            '<button type="button" class="btn btn-danger" onclick="delAnswer(\'' + dto2.ans_num + '\', \'' + dto2.talk_num + '\')">댓글 삭제</button>'
                            '</div>' +
                            '</div>' +
                            '</div>';
                    });
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.error('실패:', textStatus, errorThrown);
                }
                
        	 });
            
        	//confirmAlert('삭제가 완료 되었습니다.', '바로 갱신 완료!😁', 'success', talk_num);
               
        } else {
            
        }
    });

}


//-------------------------------------- select, 검색창 처리 -------------------------------------
//부서 SELECT Box 처리 
$(document).ready(function () {
	
    // 부서 선택이 변경시
    $("#departmentSelect").change(function () {
          	
    	// 선택한 부서의 값 가져오기
        var selectedDepartmentId = $(this).val();

        // Ajax -> select 한 부서 정보 가져오기
        $.ajax({
            url: '/project/talk/dep' + selectedDepartmentId,
            method: 'GET',
            data: JSON.stringify(),
            dataType: "json",
            success: function (data) {
                //성공시 -> 기존 카드를 제거
                $(".board-container").empty();
                
             	//데이터가 비어있는 경우 처리
                if (data.length === 0) {
                    $(".board-container").append('<h4 class="text-center" style="font-weight:bold;">이 부서에서 작성한 글이 없습니다..</h4>');
                    return; // 데이터가 없으므로 함수를 종료합니다.
                }

                //받아온 데이터 -> 동적 처리
                data.forEach(function(dto) {
                    var newCard = 
                    	'<div class="card">' +
	                        '<div class="card-body">' +
	                            '<div style="display:flex; justify-content: space-between;">' +
	                                '<h5 class="card-title">' + dto.talk_subject + '</h5>' +
	                                '<p class="card-text text-danger bold">' + dto.dep_name + '</p>' +
	                            '</div>' +
	                            '<p class="card-text">' + dto.talk_content + '</p>' +
	                            '<div style="display:flex; justify-content: space-between;">' +
	                                '<div>' +
	                                    '<a class="btn btn-primary mr" onclick="showDetails(\'' + dto.talk_subject + '\', \'' + dto.talk_content + '\', \'' + dto.cus_id + '\', \'' + dto.dep_name + '\', \'' + dto.talk_num + '\', \'' + dto.talk_like + '\')">자세히 보기</a>' +
	                                    '<a class="btn btn-danger" onclick="delAlert(\'' + dto.talk_num + '\')">삭제하기</a>' +
	                                '</div>' +
	                                '<div style="display:flex;">' +
	                                    '<img id="profile" class="profile" src="resources/img/로고.png">' +
	                                    '<p class="card-text bold" style="display:flex; flex-direction: row-reverse;">' + dto.cus_name + '(' + dto.cus_id + ')</p>' +
	                                '</div>' +
	                            '</div>' +
	                        '</div>' +
	                    '</div>';

                    //새로운 카드를 보드 컨테이너에 추가
                    $(".board-container").append(newCard);
                });

            },
            error: function (xhr, status, error) {
                // 오류 발생 시
                console.error('부서 정보 가져오기 실패:', status, error);
            }
        });
    });
});

//검색어 -> 처리
function performSearch() {
    // 검색어 가져오기
    var searchInputValue = document.getElementById("searchInput").value;

    // 검색어+URL
    var searchUrl = "/project/talk/text" + searchInputValue;
    
    console.log(searchUrl);

    // 1. 기존의 카드들 지우기
    $(".board-container").empty();

    // 2. Ajax로 검색 결과 가져오기
    $.ajax({
        url: searchUrl,
        type: "GET",
        data: JSON.stringify(),
        dataType: "json",
        success: function(searchList) {
            // 3. 띄워주기
            $.each(searchList, function(index, dto) {
                console.log(dto.talk_subject);
                var newCard = 
                	'<div class="card">' +
                    '<div class="card-body">' +
                        '<div style="display:flex; justify-content: space-between;">' +
                            '<h5 class="card-title">' + dto.talk_subject + '</h5>' +
                            '<p class="card-text text-danger bold">' + dto.dep_name + '</p>' +
                        '</div>' +
                        '<p class="card-text">' + dto.talk_content + '</p>' +
                        '<div style="display:flex; justify-content: space-between;">' +
                            '<div>' +
                                '<a class="btn btn-primary mr" onclick="showDetails(\'' + dto.talk_subject + '\', \'' + dto.talk_content + '\', \'' + dto.cus_id + '\', \'' + dto.dep_name + '\', \'' + dto.talk_num + '\', \'' + dto.talk_like + '\')">자세히 보기</a>' +
                                '<a class="btn btn-danger" onclick="delAlert(\'' + dto.talk_num + '\')">삭제하기</a>' +
                            '</div>' +
                            '<div style="display:flex;">' +
                                '<img id="profile" class="profile" src="resources/img/로고.png">' +
                                '<p class="card-text bold" style="display:flex; flex-direction: row-reverse;">' + dto.cus_name + '(' + dto.cus_id + ')</p>' +
                            '</div>' +
                        '</div>' +
                    '</div>' +
                '</div>';

                // 새로운 카드를 보드 컨테이너에 추가
                $(".board-container").append(newCard);
            });
        },
        error: function(error) {
            console.error("Error fetching search results: ", error);
            
        }
    });
}

document.getElementById('searchInput').addEventListener('keyup', function(event) {
    // Enter 키의 키코드는 13
    if (event.keyCode === 13) {
        // Enter 키를 눌렀을 때 버튼 클릭 실행
        document.getElementById('searchBtn').click();
    }
});

function popularity() {
	
	// Ajax -> select 한 부서 정보 가져오기
    $.ajax({
        url: '/project/adminTalk/popular',
        method: 'GET',
        data: JSON.stringify(),
        dataType: "json",
        success: function (data) {
            //성공시 -> 기존 카드를 제거
            $(".board-container").empty();
            
         	//데이터가 비어있는 경우 처리
            if (data.length === 0) {
                $(".board-container").append('<h4 class="text-center" style="font-weight:bold;">이 부서에서 작성한 글이 없습니다..</h4>');
                return; // 데이터가 없으므로 함수를 종료합니다.
            }

            //받아온 데이터 -> 동적 처리
            data.forEach(function(dto) {
                var newCard = 
                	'<div class="card">' +
                        '<div class="card-body">' +
                            '<div style="display:flex; justify-content: space-between;">' +
                                '<h5 class="card-title">' + dto.talk_subject + '</h5>' +
                                '<p class="card-text text-danger bold">' + dto.dep_name + '</p>' +
                            '</div>' +
                            '<p class="card-text">' + dto.talk_content + '</p>' +
                            '<div style="display:flex; justify-content: space-between;">' +
                                '<div>' +
                                    '<a class="btn btn-primary mr" onclick="showDetails(\'' + dto.talk_subject + '\', \'' + dto.talk_content + '\', \'' + dto.cus_id + '\', \'' + dto.dep_name + '\', \'' + dto.talk_num + '\', \'' + dto.talk_like + '\')">자세히 보기</a>' +
                                    '<a class="btn btn-danger" onclick="delAlert(\'' + dto.talk_num + '\')">삭제하기</a>' +
                                '</div>' +
                                '<div style="display:flex;">' +
                                    '<img id="profile" class="profile" src="resources/img/로고.png">' +
                                    '<p class="card-text bold" style="display:flex; flex-direction: row-reverse;">' + dto.cus_name + '(' + dto.cus_id + ')</p>' +
                                '</div>' +
                            '</div>' +
                        '</div>' +
                    '</div>';

                //새로운 카드를 보드 컨테이너에 추가
                $(".board-container").append(newCard);
            });

        },
        error: function (xhr, status, error) {
            // 오류 발생 시
            console.error('부서 정보 가져오기 실패:', status, error);
        }
    });
	
}

function latest() {
	
	// Ajax -> select 한 부서 정보 가져오기
    $.ajax({
        url: '/project/adminTalk/latest',
        method: 'GET',
        data: JSON.stringify(),
        dataType: "json",
        success: function (data) {
            //성공시 -> 기존 카드를 제거
            $(".board-container").empty();
            
         	//데이터가 비어있는 경우 처리
            if (data.length === 0) {
                $(".board-container").append('<h4 class="text-center" style="font-weight:bold;">이 부서에서 작성한 글이 없습니다..</h4>');
                return; // 데이터가 없으므로 함수를 종료합니다.
            }

            //받아온 데이터 -> 동적 처리
            data.forEach(function(dto) {
                var newCard = 
                	'<div class="card">' +
                        '<div class="card-body">' +
                            '<div style="display:flex; justify-content: space-between;">' +
                                '<h5 class="card-title">' + dto.talk_subject + '</h5>' +
                                '<p class="card-text text-danger bold">' + dto.dep_name + '</p>' +
                            '</div>' +
                            '<p class="card-text">' + dto.talk_content + '</p>' +
                            '<div style="display:flex; justify-content: space-between;">' +
                                '<div>' +
                                    '<a class="btn btn-primary mr" onclick="showDetails(\'' + dto.talk_subject + '\', \'' + dto.talk_content + '\', \'' + dto.cus_id + '\', \'' + dto.dep_name + '\', \'' + dto.talk_num + '\', \'' + dto.talk_like + '\')">자세히 보기</a>' +
                                    '<a class="btn btn-danger" onclick="delAlert(\'' + dto.talk_num + '\')">삭제하기</a>' +
                                '</div>' +
                                '<div style="display:flex;">' +
                                    '<img id="profile" class="profile" src="resources/img/로고.png">' +
                                    '<p class="card-text bold" style="display:flex; flex-direction: row-reverse;">' + dto.cus_name + '(' + dto.cus_id + ')</p>' +
                                '</div>' +
                            '</div>' +
                        '</div>' +
                    '</div>';

                //새로운 카드를 보드 컨테이너에 추가
                $(".board-container").append(newCard);
            });

        },
        error: function (xhr, status, error) {
            // 오류 발생 시
            console.error('부서 정보 가져오기 실패:', status, error);
        }
    });
	
}

</script>
</body>
</html>