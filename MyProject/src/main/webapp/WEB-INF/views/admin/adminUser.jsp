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

.card {
	height : 100px ;
	cursor : pointer;
}

.vertical-line {
  border-left: 2px solid #EEEEEE; /* 세로 선 색상 및 스타일 설정 */
  height: 260px; /* 세로 선의 높이 설정 */
  margin: 5px 10px; /* 여백 설정 (원하는 만큼 조절) */
}

.margin-b {
	width : 250px;
	margin-bottom : 10px;
	font-weight : bold;
	text-align : left;
}

.mr {
	margin-right : 10px;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/inc/AdminHeader.jsp" %>
    
    <div class="container">
 		
 		<div style="display:flex; justify-content: space-around;">
			<div class="container mt-4 cont shadow p-3 mb-5 bg-white rounded" style="width:100%">
				<h3 class="bold mt-3 text-center" style="width:100%; font-weight:bold;" >전체 회원 통계</h3>
				<hr class="line">
				<div style="display:flex; justify-content: space-around;">
					<p>총 회원 수 : <span class="bold">3,421</span></p>
					<p>금일 회원 가입 수 : <span class="bold">168</span></p>
				</div>
				<div style="display:flex; justify-content: space-around;">
					<p>메가박스 : <span class="bold">168</span></p>
					<p>휘닉스 : <span class="bold">1,234</span></p>
					<p>플레이타임 : <span class="bold">41</span></p>
					<p>JTBC : <span class="bold">632</span></p>
				</div>
				<div style="display:flex; justify-content: space-around;">
					<p>중앙일보 : <span class="bold">168</span></p>
					<p>스템커피 : <span class="bold">1,234</span></p>
					<p>콘텐트리중앙 : <span class="bold">41</span></p>
					<p>이외 : <span class="bold">632</span></p>
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
		    <label for="searchInput" class="bold">회원 검색</label>
		    <div style="display:flex;">
		    	<input type="text" class="form-control" id="searchInput" placeholder="회원명">
		  		<a id="searchBtn" class="btn btn-primary" style="width:100px; height:35px;" onclick="performSearch()">검색</a>
		  	</div>
		  </div>
		  
		  <div class="form-group mt-2">
		    <label for="searchInput" class="bold">정지 및 활동 회원 검색</label>
		    <div style="display:flex;">
		  		<a class="btn btn-danger mr" style="width:100px; height:35px;" onclick="stopList()">정지 회원</a>
		  		<a class="btn btn-primary" style="width:100px; height:35px;" onclick="activeList()">활동 회원</a>
		  	</div>
		  </div>
		  
		</div>
		
        <!-- 게시글 목록 컨테이너 -->
        <div class="board-container mt-4 mb-4">
            <div class="mt-3" style="display:flex; justify-content: space-between;">
            	<p class="bold" style="margin-left:40px;">이름(아이디)</p>
            	<p class="bold" style="margin-right:30px;">부서명</p>
            </div>
            <!-- 게시글 목록 -->
            <c:forEach items="${list}" var="dto">
			    <div class="card">
			        <div class="card-body" onclick="user_detail('${dto.cus_id}')">
			        	<div style="display:flex; justify-content: space-between;">
				            <div style="display:flex;">
			            		<img id="profile" class="profile" src="resources/img/로고.png">
			            		<p class="card-text bold" style="display:flex; flex-direction: row-reverse;">${dto.cus_name}(${dto.cus_id})</p>
			        		</div>
				        	<p class="card-text text-danger bold">${dto.dep_name}</p>
				        	<input id="id" type="hidden" value="${dto.cus_id}">
			            </div>
			        </div>
			    </div>
			</c:forEach>
            
            <!-- 추가적인 게시글들을 위한 카드 복사 -->

        </div>
        
        <!-- 모달 창 -->
		<div class="modal" id="detailCustomer">
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
function user_detail(id) {
	
	$.ajax({
        url: '/project/adminUser' + id,
        method: 'GET',
        data: id,
        dataType: "json",
        success: function(data) {
        	
        	data.forEach(function(dto) {
        		
        		document.querySelector(".modal-title").innerText = dto.cus_name + "님의 회원정보";
        		
        		// 모달 본문 -> 내용
        	    var modalContent = document.getElementById("modalContent");
        	    modalContent.innerHTML = 
        	    	"<div style='display:flex;'>" +
        	    	"<div>" +
        	    		"<p><strong>이름 :</strong> " +
        	        	"<p><strong>아이디 :</strong> " +
        	        	"<p><strong>비밀번호 :</strong> " +
        	        	"<p><strong>이메일 :</strong> " +
        	        	"<p><strong>생년월일 :</strong> " +
        	        	"<p><strong>계열사 :</strong> " +
        	        	"<p><strong>현재 상태 :</strong> " +
        	        "</div>" +
        	        "<div class='vertical-line'></div>" +
        	        "<div style='display:flex; flex-direction:column;'>" +
        	        	"<input class='margin-b' type='text' value='" + dto.cus_name + "' disabled>" +
        	        	"<input class='margin-b' type='text' value='" + dto.cus_id + "' disabled>" +
        	        	"<input class='margin-b' type='text' value='" + dto.cus_pw + "' disabled>" +
        	        	"<input class='margin-b' type='text' value='" + dto.cus_email + "' disabled>" +
        	        	"<input class='margin-b' type='text' value='" + dto.cus_birth + "' disabled>" +
        	        	"<input class='margin-b' type='text' value='" + dto.dep_name + "' disabled>" +
        	        	"<input id='state' class='margin-b' type='text' value='" + dto.cus_state_name + "' disabled>" +
        	        "</div>" +
        	        "</div>" +
        	        "<hr>" +
        	        '<h5 class="mb-3 text-center fw-bold">회원 관리</h5>' +
        	        '<div id="dynamicContent"></div>' +
        	        '<hr>' +
        	        '<div class="mb-3 mt-3">' +
        	        '       <div id="buttonGroup" class="text-center">' +
        	        '           <button type="button" id="stopUser" class="btn btn-secondary" onclick="stopUser(' + "'" + dto.cus_id + "'" + ')">회원 정지</button>' +
        	        '           <button type="button" id="combackUser" class="btn btn-primary" onclick="comebackUser(' + "'" + dto.cus_id + "'" + ')">회원 복구</button>' + 
        	        '           <button type="button" id="delUser" class="btn btn-danger" onclick="delUser(' + "'" + dto.cus_id + "'" + ')">회원 탈퇴</button>' +
        	        '       </div>' +
        	        '</div>';
        	});
        },
        error: function() {
            console.error('Failed to fetch additional data from the server.');
        }
    });
        	
    $("#detailCustomer").modal('show');
	
}

//모달 닫기
function closeDetails() {
	$("#detailCustomer").modal('hide');
}

function stopUser(id) {
	
	StopAlert("해당 유저를 \n정지 시키시겠습니까?", "정지 시 모든 서비스를 이용할 수 없게 됩니다", 'warning', id);
}

function comebackUser(id) {
	
	ComebackAlert("해당 유저를 \n복구 시키시겠습니까?", "복구 시 모든 서비스를 이용할 수 있게 됩니다", 'warning', id);
}

function delUser(id) {
	
	DelAlert("해당 유저를 \n탈퇴 시키시겠습니까?", "탈퇴 시 영구적으로 복구 할 수 없게 됩니다", 'warning', id);
}

function StopAlert(title, text, icon, id) {
    Swal.fire({
        title: title,
        text: text,
        icon: icon,
        showCancelButton: true,
        confirmButtonText: "정지",
        cancelButtonText: "취소"
    }).then((result) => {
    	
   	    if (result.value) {
    	$.ajax({
            url: '/project/stopUser' + id,
            method: 'GET',
            data: id,
            success: function(data) {
            	$("#state").val("정지된 회원 🫥");
            	SuccessAlert("정지 처리 완료!", "해당 회원 " + id + " 님은 정지처리 되었습니다.", "success");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.error('실패:', textStatus, errorThrown);
            }
            
    	 });
   	    } else {
   	    	
   	    }
    });
}

function ComebackAlert(title, text, icon, id) {
    Swal.fire({
        title: title,
        text: text,
        icon: icon,
        showCancelButton: true,
        confirmButtonText: "복구",
        cancelButtonText: "취소"
    }).then((result) => {
    	
   	    if (result.value) {
    	$.ajax({
            url: '/project/comebackUser' + id,
            method: 'GET',
            data: id,
            success: function(data) {
            	$("#state").val("활동 중 회원 😊");
            	SuccessAlert("복구 처리 완료!", "해당 회원 " + id + " 님은 정상 복구처리 되었습니다.", "success");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.error('실패:', textStatus, errorThrown);
            }
            
    	 });
   	    } else {
   	    	
   	    }
    });
}

function DelAlert(title, text, icon, id) {
    Swal.fire({
        title: title,
        text: text,
        icon: icon,
        showCancelButton: true,
        confirmButtonText: "탈퇴",
        cancelButtonText: "취소"
    }).then((result) => {
    	
   	    if (result.value) {
    	$.ajax({
            url: '/project/delUser' + id,
            method: 'GET',
            data: id,
            success: function(data) {
            	SuccessAlert2("탈퇴 처리 완료!", "해당 회원 " + id + " 님은 탈퇴 처리 되었습니다.", "success");
        
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.error('실패:', textStatus, errorThrown);
            }
            
    	 });
   	    } else {
   	    	
   	    }
    });
}


function SuccessAlert(title, text, icon) {
    Swal.fire({
        title: title,
        text: text,
        icon: icon,
        showCancelButton: true,
        confirmButtonText: "확인",
        cancelButtonText: "닫기"
    }).then((result) => {

    });
}

function SuccessAlert2(title, text, icon) {
    Swal.fire({
        title: title,
        text: text,
        icon: icon,
        showCancelButton: true,
        confirmButtonText: "확인",
        cancelButtonText: "닫기"
    }).then((result) => {
    	location.reload();
    });
}

//부서 SELECT Box 처리 
$(document).ready(function () {
	
    // 부서 선택이 변경시
    $("#departmentSelect").change(function () {
        
    	// 선택한 부서의 값 가져오기
        var selectedDepartmentId = $(this).val();

        // Ajax -> select 한 부서 정보 가져오기
        $.ajax({
            url: '/project/adminUser/dep' + selectedDepartmentId,
            method: 'GET',
            data: JSON.stringify(),
            dataType: "json",
            success: function (data) {
                //성공시 -> 기존 카드를 제거
                $(".board-container").empty();
                
             	//데이터가 비어있는 경우 처리
                if (data.length === 0) {
                    $(".board-container").append('<h4 class="text-center" style="font-weight:bold;">이 부서에대한 회원이 존재하지 않습니다..</h4>');
                    return; // 데이터가 없으므로 함수를 종료합니다.
                }

                //받아온 데이터 -> 동적 처리
                data.forEach(function(dto) {
                    var newCard = '<div class="card">' +
                                    '<div class="card-body" onclick="user_detail('+ "'" +  dto.cus_id + "'" + ')">' +
                                        '<div style="display:flex; justify-content: space-between;">' +
                                        	'<div style="display:flex;">' +
                                            '<img id="profile" class="profile" src="resources/img/로고.png">' +
                                            '<p style="display:flex; flex-direction: row-reverse;" class="card-text bold">' + dto.cus_name + '(' + dto.cus_id + ')</p>' +
                                        '</div>' +
                                        '<p class="card-text text-danger bold">' + dto.dep_name + '</p>' +
            				        	'<input id="id" type="hidden" value=' + '"' + dto.cus_id + '">' +
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
    var searchUrl = "/project/adminUser/text" + searchInputValue;
    
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
        	//성공시 -> 기존 카드를 제거
            $(".board-container").empty();
            
         	//데이터가 비어있는 경우 처리
            if (searchList.length === 0) {
                $(".board-container").append('<h4 class="text-center" style="font-weight:bold;">해당 검색에 대한 회원이 존재하지 않습니다..</h4>');
                return; // 데이터가 없으므로 함수를 종료합니다.
            }

            //받아온 데이터 -> 동적 처리
            searchList.forEach(function(dto) {
                var newCard = '<div class="card">' +
                                '<div class="card-body" onclick="user_detail('+ "'" +  dto.cus_id + "'" + ')">' +
                                    '<div style="display:flex; justify-content: space-between;">' +
                                    	'<div style="display:flex;">' +
                                        '<img id="profile" class="profile" src="resources/img/로고.png">' +
                                        '<p style="display:flex; flex-direction: row-reverse;" class="card-text bold">' + dto.cus_name + '(' + dto.cus_id + ')</p>' +
                                    '</div>' + 
                                    '<p class="card-text text-danger bold">' + dto.dep_name + '</p>' +
        				        	'<input id="id" type="hidden" value=' + '"' + dto.cus_id + '">' +
                                    '</div>' +
                                '</div>' +
                            '</div>';

                //새로운 카드를 보드 컨테이너에 추가
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


function stopList() {
	
	// 1. 기존의 카드들 지우기
    $(".board-container").empty();

    // 2. Ajax로 검색 결과 가져오기
    $.ajax({
    	url: '/project/adminUser/stopList' ,
        type: "GET",
        data: JSON.stringify(),
        dataType: "json",
        success: function(stopList) {
        	//성공시 -> 기존 카드를 제거
            $(".board-container").empty();
            
         	//데이터가 비어있는 경우 처리
            if (stopList.length === 0) {
                $(".board-container").append('<h4 class="text-center" style="font-weight:bold;">정지 회원이 존재하지 않습니다..</h4>');
                return; // 데이터가 없으므로 함수를 종료합니다.
            }

            //받아온 데이터 -> 동적 처리
            stopList.forEach(function(dto) {
                var newCard = '<div class="card">' +
                                '<div class="card-body" onclick="user_detail('+ "'" +  dto.cus_id + "'" + ')">' +
                                    '<div style="display:flex; justify-content: space-between;">' +
                                    	'<div style="display:flex;">' +
                                        '<img id="profile" class="profile" src="resources/img/로고.png">' +
                                        '<p style="display:flex; flex-direction: row-reverse;" class="card-text bold">' + dto.cus_name + '(' + dto.cus_id + ')</p>' +
                                    '</div>' + 
                                    '<p class="card-text text-danger bold">' + dto.dep_name + '</p>' +
        				        	'<input id="id" type="hidden" value=' + '"' + dto.cus_id + '">' +
                                    '</div>' +
                                '</div>' +
                            '</div>';

                //새로운 카드를 보드 컨테이너에 추가
                $(".board-container").append(newCard);
            });
        },
        error: function(error) {
            console.error("Error fetching search results: ", error);
            
        }
    });
	
}

function activeList() {
	
	// 1. 기존의 카드들 지우기
    $(".board-container").empty();

    // 2. Ajax로 검색 결과 가져오기
    $.ajax({
    	url: '/project/adminUser/activeList' ,
        type: "GET",
        data: JSON.stringify(),
        dataType: "json",
        success: function(stopList) {
        	//성공시 -> 기존 카드를 제거
            $(".board-container").empty();
            
         	//데이터가 비어있는 경우 처리
            if (stopList.length === 0) {
                $(".board-container").append('<h4 class="text-center" style="font-weight:bold;">정지 회원이 존재하지 않습니다..</h4>');
                return; // 데이터가 없으므로 함수를 종료합니다.
            }

            //받아온 데이터 -> 동적 처리
            stopList.forEach(function(dto) {
                var newCard = '<div class="card">' +
                                '<div class="card-body" onclick="user_detail('+ "'" +  dto.cus_id + "'" + ')">' +
                                    '<div style="display:flex; justify-content: space-between;">' +
                                    	'<div style="display:flex;">' +
                                        '<img id="profile" class="profile" src="resources/img/로고.png">' +
                                        '<p style="display:flex; flex-direction: row-reverse;" class="card-text bold">' + dto.cus_name + '(' + dto.cus_id + ')</p>' +
                                    '</div>' + 
                                    '<p class="card-text text-danger bold">' + dto.dep_name + '</p>' +
        				        	'<input id="id" type="hidden" value=' + '"' + dto.cus_id + '">' +
                                    '</div>' +
                                '</div>' +
                            '</div>';

                //새로운 카드를 보드 컨테이너에 추가
                $(".board-container").append(newCard);
            });
        },
        error: function(error) {
            console.error("Error fetching search results: ", error);
            
        }
    });
	
}


</script>
</body>
</html>