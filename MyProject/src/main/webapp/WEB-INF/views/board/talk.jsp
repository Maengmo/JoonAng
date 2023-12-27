<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>함께해요 중앙😊</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="resources/css/font.css" />
	
</head>
<style>
    body {
        background-color: #f8f9fa;
    }

    .container {
        margin-top: 20px;
    }

    .board-container {
        border: 2px solid #dee2e6;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .card {
        border: none;
        border-bottom: 1px solid #dee2e6;
        border-radius: 0;
        overflow: hidden;
        margin-bottom: 0;
        box-shadow: none;
        transition: transform 0.3s;
    }

    .card:hover {
        transform: translateY(-5px);
    }

    .card-body {
        padding: 20px;
    }

    .card-title {
        font-size: 1.5rem;
        font-weight: bold;
    }

    .card-text {
        color: #6c757d;
    }

    .btn-primary {
        background-color: #007BFF;
        border: none;
    }

    .btn-primary:hover {
        background-color: #0056b3;
    }

    .btn-write {
        position: fixed;
        bottom: 20px;
        right: 20px;
        z-index: 1000;
    }
    
    #profile {
    	width: 20px;
    	height: 20px;
    	margin-top: 17px;
    	margin-right: 5px;
    }
    
    .bold {
    	font-weight: bold;
    }
</style>
</head>
<body>
    <%@ include file="/WEB-INF/views/inc/header.jsp" %>
 
	<div class="container-fluid p-0">
  		<img class="img-fluid w-100" src="resources/img/main4.jpg">
	</div>
    
    <div class="container">
 
        <!-- 글쓰기 버튼 -->
        <a href="/project/addtalk.do" class="btn btn-primary btn-write">글쓰기</a>
		
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
		    <div style="display:flex; flex-direction: column;">
		    	<input type="text" class="form-control mb-3" id="searchInput" placeholder="원하시는 정보를 검색하세요...">
		  		<a href="#" class="btn btn-primary" onclick="performSearch()">검색</a>
		  	</div>
		  </div>
		</div>
		
        <!-- 게시글 목록 컨테이너 -->
        <div class="board-container mt-4 mb-4">
            
            <!-- 게시글 목록 -->
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
			            	<a class="btn btn-primary" onclick="showDetails('${dto.talk_subject}', '${dto.talk_content}', '${dto.cus_id}', '${dto.dep_name}', '${dto.talk_num}')">자세히 보기</a>
			            	<div style="display:flex;">
			            		<img id="profile" class="profile" src="resources/img/로고.png">
			            		<p class="card-text mt-3 bold" style="display:flex; flex-direction: row-reverse;">${dto.cus_name}(${dto.cus_id})</p>
			        		</div>
			        	</div>
			        </div>
			    </div>
			</c:forEach>
            
            <!-- 추가적인 게시글들을 위한 카드 복사 -->

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
    </div>

    <%@ include file="/WEB-INF/views/inc/footer.jsp" %>


<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>

var nownum;

//자세히보기 -> showDetails -> 소통 공간
function showDetails(subject, content, customerId, depname, talknum) {
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
        "<hr>" +
        '<h5 class="mb-3 text-center fw-bold">😄열려있는 소통의 창구😄</h5>' +
        '<div id="dynamicContent"></div>' +
        '<hr>' +
        '<div class="mb-3 mt-3">' +
        '   <form>' +
        '       <div class="mb-3">' +
        '           <textarea class="form-control" id="inputReview" rows="3"></textarea>' +
        '       </div>' +
        '       <div class="text-center">' +
        '           <button type="button" id="addAnswer" class="btn btn-primary">작성 완료</button>' +
        '       </div>' +
        '   </form>' +
        '</div>';

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
    $("#myModal").modal('show');
}

//모달 닫기
function closeDetails() {
	$("#myModal").modal('hide');
}

//버튼 클릭시 -> 답글 추가 Ajax
$(document).on('click', '#addAnswer', function () {
    console.log("클릭됨");

    var reviewContent = $('#inputReview').val();
    var userId = '';
    var token = localStorage.getItem('token');
    
    // Ajax 요청
    $.ajax({
        url: '/project/talk/addAnswer',
        method: 'POST',
        headers: {
            'Authorization': 'Bearer ' + token
        },
        data: {
            cus_id: userId,
            talk_num: nownum,
            ans_content: reviewContent
        },
        success: function (data) {
            // 댓글 성공 -> 갱신
            console.log('댓글 추가 성공:', data);
            location.reload();

            // 동적으로 콘텐츠 생성
            var dynamicContent = document.getElementById("dynamicContent");
            dynamicContent.innerHTML += '<div class="container border mb-0 mt-0">' +
                '<div class="row">' +
                '<div class="col-md-9">' +
                '<p class="mt-2">' + reviewContent + '</p>' +
                '</div>' +
                '<div class="col-md-3 text-end">' +
                '<p class="mt-2">' + userId + '</p>' +
                '</div>' +
                '</div>' +
                '</div>';
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.error('댓글 추가 실패:', textStatus, errorThrown);
            location.reload();
        }
    });
});
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
                    var newCard = '<div class="card">' +
                                    '<div class="card-body">' +
                                        '<div style="display:flex; justify-content: space-between;">' +
                                            '<h5 class="card-title">' + dto.talk_subject + '</h5>' +
                                            '<p class="card-text text-danger">' + dto.dep_name + '</p>' +
                                        '</div>' +
                                        '<p class="card-text">' + dto.talk_content + '</p>' +
                                        '<div style="display:flex; justify-content: space-between;">' +
                                            '<a class="btn btn-primary" onclick="showDetails(\'' + dto.talk_subject + '\', \'' + dto.talk_content + '\', \'' + dto.cus_id + '\', \'' + dto.dep_name + '\', \'' + dto.talk_num + '\')">자세히 보기</a>' +
                                            '<p class="card-text mt-3" style="display:flex; flex-direction: row-reverse;">' + dto.cus_id + '</p>' +
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
    var searchUrl = "/project/talk/text?search=" + encodeURIComponent(searchInputValue);

    // 페이지 이동
    window.location.href = searchUrl;
    
 	// 1. 기존의 카드들 지우기
    $(".board-container").empty();
    
    // 2. 띄워주기
    <c:forEach var="dto" items="${searchList}">
    console.log(dto.talk_subject);
        var newCard = '<div class="card">' +
                        '<div class="card-body">' +
                            '<div style="display:flex; justify-content: space-between;">' +
                                '<h5 class="card-title">' + dto.talk_subject + '</h5>' +
                                '<p class="card-text text-danger">' + dto.dep_name + '</p>' +
                            '</div>' +
                            '<p class="card-text">' + dto.talk_content + '</p>' +
                            '<div style="display:flex; justify-content: space-between;">' +
                                '<a class="btn btn-primary" onclick="showDetails(\'' + dto.talk_subject + '\', \'' + dto.talk_content + '\', \'' + dto.cus_id + '\', \'' + dto.dep_name + '\', \'' + dto.talk_num + '\')">자세히 보기</a>' +
                                '<p class="card-text mt-3" style="display:flex; flex-direction: row-reverse;">' + dto.cus_id + '</p>' +
                            '</div>' +
                        '</div>' +
                    '</div>';

        // 새로운 카드를 보드 컨테이너에 추가
        $(".board-container").append(newCard);
    </c:forEach>
    
};




</script>


</body>
</html>