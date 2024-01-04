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
.card {
	margin-right : 20px;
}

.content {
	height:530px;
}

.card-body {
	background-color : #F8F9FA;
}
/* 호버 효과 */
.card:hover {
    /* 들썩이는 애니메이션 적용 */
    cursor : pointer;
    animation: bounce 0.3s ease 1;
}

/* 들썩이는 애니메이션 키프레임 정의 */
@keyframes bounce {
    0%, 20%, 50%, 80%, 100% {
        transform: translateY(0);
    }
    40% {
        transform: translateY(-10px);
    }
    60% {
        transform: translateY(-5px);
    }
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/inc/header.jsp" %>
    
    <div class="content text-center mt-5" style="display:flex; justify-content: center;">
	    <div class="col-md-4 mb-4" onclick="openModal('findIDModal')">
		    <div class="card h-100 border rounded shadow">
		        <img src="resources/img/find_ID2.png" class="card-img-top" alt="SLL">
		        <div class="card-body">
		        	<hr>
		            <h5 class="card-title text-center mb-3" style="font-size: 1.5rem; color: black; font-weight: bold;">ID 찾기</h5>
		            <p class="card-text text-muted">간단한 정보를 입력 후 ID를 찾아봐요!</p>
		        </div>
		    </div>
		</div>
		
		<div class="col-md-4 mb-4 mr-3" onclick="openModal('findPWModal')">
		    <div class="card h-100 border rounded shadow">
		        <img src="resources/img/find_PW.png" class="card-img-top" alt="SLL">
		        <div class="card-body">
		        	<hr>
		            <h5 class="card-title text-center mb-3" style="font-size: 1.5rem; color: black; font-weight: bold;">PW 찾기</h5>
		            <p class="card-text text-muted">간단한 정보를 입력 후 PW를 찾아봐요!</p>
		        </div>
		    </div>
		</div>
	</div>
    
    <!-- ID 찾기 모달 -->
	<div class="modal fade" id="findIDModal" tabindex="-1" role="dialog" aria-labelledby="findIDModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
				<div class="modal-header text-center">
					<h1 class="modal-title fs-5 m-weight"  id="staticBackdropLabel">ID 찾기</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form method="POST" action="">
						<div class="mb-1">✅ 이메일</div>
	                  		<div class="form-floating mb-3">
	                     	<input type="email" class="form-control" id="email"
	                        	placeholder="tel" name="cus_email" required> <label for="floatingPassword">user@ham.com</label>
	                    </div>
			            <div class="mb-3">
			                <label class="mb-2" for="departmentSelect">✅ 회사 선택</label>
			                <select class="form-control" id="departmentSelect" name="dep_num">
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
			            <button id="submitbtn" type="button" class="btn btn-primary w-100 mb-1 mt-1" onclick="find_id()">ID 찾기</button>
		            </form>
	            </div>
			</div>
		</div>
	</div>
	
	<!-- PW 찾기 모달 -->
	<div class="modal fade" id="findPWModal" tabindex="-1" role="dialog" aria-labelledby="findPWModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
				<div class="modal-header text-center">
					<h1 class="modal-title fs-5 m-weight"  id="staticBackdropLabel">PW 찾기</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form method="POST" action="">
						<div class="mb-1">아이디</div>
		                    <div class="form-floating mb-3">
		                       <input type="text" class="form-control" id="userid"
		                          placeholder="name@example.com" name="cus_id" required> <label
		                          for="floatingInput">4~15자 이내로 입력해주세요</label>
		                </div>
						<div class="mb-1">✅ 이메일</div>
	                  		<div class="form-floating mb-3">
	                     	<input type="email" class="form-control" id="email2"
	                        	placeholder="tel" name="cus_email" required> <label for="floatingPassword">user@ham.com</label>
	                    </div>
			            <div class="mb-3">
			                <label class="mb-2" for="departmentSelect">✅ 회사 선택</label>
			                <select class="form-control" id="departmentSelect2" name="dep_num">
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
			            <button id="submitbtn" type="button" class="btn btn-primary w-100 mb-1 mt-1" onclick="find_pw()">PW 찾기</button>
		            </form>
	            </div>
			</div>
		</div>
	</div>
	
    <%@ include file="/WEB-INF/views/inc/footer.jsp" %>

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
<script>

function openModal(modalId) {
    $('#' + modalId).modal('show');
}

function showSweetAlert(title, text, icon) {
    Swal.fire({
        title: title,
        text: text,
        icon: icon,
        showCancelButton: true,
        confirmButtonText: "로그인 하러 가기",
        cancelButtonText: "다시 시도하기"
    }).then((result) => {
        
        if (result.isConfirmed) {
        	window.location.href = "/project/login.do";
        } else {
            
        }
    });
}

function find_id() {
	
	var emailValue = document.getElementById("email").value;
	
	var departValue = document.getElementById("departmentSelect").value;
	
	// Ajax -> 부서 정보
    $.ajax({
        url: '/project/find/id',
        method: 'GET',
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        data: {
            cus_email : emailValue,
            cus_depart : departValue
        },
        success: function (data) {
        	showSweetAlert("입력 하신 정보에 따른 ID", data, "success");
        },
        error: function (error) {
            // 오류 발생 처리
            console.error(error);
        }
    });
	
}

function find_pw() {
	
	var idValue = document.getElementById("userid").value;
	var emailValue = document.getElementById("email2").value;
	var departValue = document.getElementById("departmentSelect2").value;
	
	// Ajax -> 부서 정보
    $.ajax({
        url: '/project/find/pw',
        method: 'GET',
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        data: {
        	cus_id : idValue,
            cus_email : emailValue,
            cus_depart : departValue
        },
        success: function (data) {
        	showSweetAlert("입력 하신 정보에 따른 PW", data, "success");
        },
        error: function (error) {
            // 오류 발생 처리
            console.error(error);
        }
    });
	
}



</script>

</body>
</html>