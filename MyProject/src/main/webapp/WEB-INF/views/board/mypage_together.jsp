<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>함께해요~ 중앙!</title>
	
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

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
    
    .box {
    	display:flex;
    }
    
    .like {
    	transition: transform 0.3s;
	}
	
	.like:hover {
		cursor:pointer;
	    transform: scale(1.4);
	}

</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/inc/header.jsp" %>
    
    <div style="display:flex;">
    <%@ include file="/WEB-INF/views/inc/menubar.jsp" %>
    <!-- 게시글 목록 컨테이너 -->
    <div class="col-9 container-lg mb-3 mt-3">
    	<div class="card h-100 border rounded shadow">

        <!-- 게시글 목록 -->
        <c:forEach items="${list}" var="dto">
		   <div class="card">
		       <div class="card-body">
		       	<div style="display:flex; justify-content: space-between;">
		            <h5 class="card-title">${dto.work_place}</h5>
		        	<p class="card-text text-danger bold">${dto.work_address}</p>
		           </div>
		           <p class="card-text">${dto.to_content}</p>
		           <!-- 클릭 이벤트 핸들러 추가 -->
		           <div style="display:flex; justify-content: space-between;">
		           	<div>
	           			<a class="btn btn-success" onclick="showDetails('${dto.work_place}', '${dto.work_address}', '${dto.to_content}', '${dto.to_num}')">수정하기</a>
	           			<a class="btn btn-danger" onclick="delAlert('${dto.to_num}')">삭제하기</a>
		           	</div>
		           	<div style="display:flex;">
		           		<img id="profile" class="profile" src="resources/img/로고.png">
		           		<p class="card-text mt-3 bold" style="display:flex; flex-direction: row-reverse;">(${dto.cus_id})</p>
		       		</div>
		       	</div>
		       </div>
		   </div>
		</c:forEach>
        
        <!-- 추가적인 게시글들을 위한 카드 복사 -->
		</div>
    </div>
    </div>
    
    <!-- 모달 창 -->
	<div class="modal" id="myModal">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <!-- 모달 헤더 -->
	            <div class="modal-header">
	                <h4 class="modal-title">댓글 수정하기</h4>
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

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
//자세히보기 -> showDetails -> 소통 공간
function showDetails(place, place_address, content, togetherNum) {
    // 콘솔에 로그 출력
    //console.log("showDetails 함수 호출");

    nownum = togetherNum;
    //console.log(talknum);

    // 모달 헤더 -> 제목
    document.querySelector(".modal-title").innerText = place + " 댓글 수정하기";

    // 모달 본문 -> 내용
    var modalContent = document.getElementById("modalContent");
    modalContent.innerHTML = 
        "<p><strong>플레이스 :</strong> " + place + "</p>" +
        "<p><strong>주소 :</strong> " + place_address + "</p>" +
        "<p><strong>작성하신 댓글 :</strong> " + content + "</p>" +
        "<hr>" +
        '<h5 class="mb-3 text-center fw-bold">😄수정하실 내용을 작성해주세요!!😄</h5>' +
        '<div id="dynamicContent"></div>' +
        '<hr>' +
        '<div class="mb-3 mt-3">' +
        '   <form>' +
        '       <div class="mb-3">' +
        '           <textarea class="form-control" id="inputReview" rows="3"></textarea>' +
        '       </div>' +
        '       <div class="text-center">' +
        '           <button type="button" id="editAnswer" class="btn btn-primary">수정 하기</button>' +
        '       </div>' +
        '   </form>' +
        '<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">' +
        '</div>';
        
 	// 모달 열기
    $("#myModal").modal('show');
 	
    $(document).on('click', '#editAnswer', function () {
    	
    	var reviewContent = $('#inputReview').val();
        
        // Ajax 요청
        $.ajax({
            url: '/project/editTogether.do',
            method: 'POST',
            data: {
                to_num : nownum,
                to_content: reviewContent
            },
            success: function (data) {
                // 댓글 성공 -> 갱신
                console.log('댓글 수정 성공:', data);
                //location.reload();
                showSweetAlert("수정이 완료 되었습니다", "변경 하신 댓글 : " + reviewContent, "success");

            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.error('댓글 수정 실패:', textStatus, errorThrown);
                //location.reload();
            }
        });
    	
    });
   
}

//모달 닫기
function closeDetails() {
	$("#myModal").modal('hide');
}

function showSweetAlert(title, text, icon) {
    
	Swal.fire({
        title: title,
        text: text,
        icon: icon,
        showCancelButton: true,
        confirmButtonText: "확인",
        cancelButtonText: "취소"
    }).then((result) => {
        
    	location.reload();
        
    });
}

function delAlert(to_num) {
	Swal.fire({
        title: "정말 삭제하시겠습니까?",
        text: "☢️삭제 하시면 복구 할 수 없습니다..",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "삭제하기",
        cancelButtonText: "취소하기"
    }).then((result) => {
        
        if (result.isConfirmed) {
            
        	location.href='/project/delTogether.do?to_num='+to_num
            showSweetAlert('삭제가 완료 되었습니다.', '바로 갱신 완료!😁', 'success');
               
        } else {
            
        }
    });

}


</script>
</body>
</html>