<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>함께해요~ 중앙!</title>
	
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
#himg {
	width : 200px;
	
}

.card-body {
	height : 660px;
}

</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/inc/header.jsp" %>
    <div style="display:flex;">
    <%@ include file="/WEB-INF/views/inc/menubar.jsp" %>
    <div class="col-9 container-lg mb-3 mt-3">
    	<div class="card h-100 border rounded shadow">
        	<div class="card-body">
    <c:forEach var="dto" items="${list}">
		<div class="container-lg mb-4 p-0">
			<h3 class="h3 mb-3 pb-2 fw-bold border-bottom border-2 border-dark">${dto.cus_name}님의 프로필🙋‍♀️🙋‍♂️</h3>
		</div>
		<div class="fw-bold d-lg-flex align-items-center" style="display:flex; justify-content: center;">
			<img id="himg" src="resources/img/human2.png" class="text-center" alt="사람이미지">
		</div>	
		<div class="fw-bold d-lg-flex align-items-center mb-3 mt-3">
			<div class="w-50 me-5 a-email">
				<p class="m-0 mb-2 w-auto">이름</p>
				<input class="form-control" type="text" id="name" name="cus_name" value="${dto.cus_name}" disabled>
			</div>
			<div class="w-50 me-5 a-email">
				<p class="m-0 mb-2 w-auto">기업명</p>
				<input class="form-control" type="text" id="depart" name="cus_depart" value="${dto.dep_name}" disabled>
			</div>
		</div>	
		<div class="fw-bold d-lg-flex align-items-center mb-3 mt-3">
			<div class="w-50 me-5 a-email">
				<p class="m-0 mb-2 w-auto">생년월일</p>
				<input class="form-control" type="date" id="date" name="cus_date" value="${dto.cus_birth}" disabled>
			</div>
			<div class="w-50 me-5 a-email">
				<p class="m-0 mb-2 w-auto">이메일</p>
				<div style="display:flex; height:40px;">
					<input class="form-control" type="email" id="email" name="cus_email" value="${dto.cus_email}">
					<button id="editEmail" type="button" class="btn btn-primary mr-1" style="width:80px;" onclick="confirmEdit()">수정</button>
				</div>
			</div>
		</div>	
		<div class="fw-bold d-lg-flex align-items-center mb-3 mt-3">
			<div class="w-50 me-5 a-email">
				<p class="m-0 mb-2 w-auto">아이디</p>
				<input class="form-control" type="text" id="id" name="cus_id" value="${dto.cus_id}" disabled>	
			</div>
			<div class="w-50 me-5 a-email">
				<p class="m-0 mb-2 w-auto">비밀번호</p>
				<div style="display:flex; height:40px;">
					<input class="form-control" type="password" id="password" name="cus_pw" value="${dto.cus_pw}">
					<button id="editEmail" type="button" class="btn btn-primary mr-1" style="width:80px;" onclick="confirmEdit2()">수정</button>
				</div>
			</div>
		</div>	
		
	</c:forEach>
			</div>
        </div>
    </div>
    </div>
    
    <%@ include file="/WEB-INF/views/inc/footer.jsp" %>

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    

<script>

function confirmEdit() {
	showSweetAlert_edit('정말 수정하시겠습니까?', '수정 시 수정정보가 바로 갱신됩니다..', 'warning');
}

function confirmEdit2() {
	showSweetAlert_pw('정말 수정하시겠습니까?', '수정 시 수정정보가 바로 갱신됩니다..', 'warning');
}

function showSweetAlert_edit(title, text, icon) {
    Swal.fire({
        title: title,
        text: text,
        icon: icon,
        showCancelButton: true,
        confirmButtonText: "수정하기",
        cancelButtonText: "취소하기"
    }).then((result) => {
        
        if (result.isConfirmed) {
            
        	editEmail();
            showSweetAlert2('수정이 되었습니다.', '바로 갱신 완료!😁', 'success');
               
        } else {
            
        }
    });
}

function showSweetAlert_pw(title, text, icon) {
    Swal.fire({
        title: title,
        text: text,
        icon: icon,
        showCancelButton: true,
        confirmButtonText: "수정하기",
        cancelButtonText: "취소하기"
    }).then((result) => {
        
        if (result.isConfirmed) {
            
        	editPw();
            showSweetAlert2('수정이 되었습니다.', '바로 갱신 완료!😁', 'success');
               
        } else {
            
        }
    });
}

function showSweetAlert2(title, text, icon) {
   
    Swal.fire({
        title: title,
        text: text,
        icon: icon,
        showCancelButton: true,
        confirmButtonText: "확인",
        cancelButtonText: "취소"
    }).then((result) => {
        
        if (result.isConfirmed) {
            
        	
        	
        } else {
            
        }
    });
}

var emailIsValid = false;
var pwIsValid = false;


function editEmail() {
	//이메일 유효성 검사
	var emailInput = document.getElementById('email');
	var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	
	var emailValue = emailInput.value;
	console.log(emailValue);
	emailIsValid = emailPattern.test(emailValue);
	
	if(emailIsValid == 1) {
		
		// Ajax -> 부서 정보
        $.ajax({
            url: '/project/mypage/editEmail',
            method: 'GET',
            data: {
                cus_email : emailValue
            },
            success: function (data) {
                console.log("성공");
            },
            error: function (error) {
                // 오류 발생 처리
                console.error(error);
            }
        });
		
	}else {
		alert("올바르지 않음");
	}
	
}

function editPw() {
	
	//비밀번호 유효성 검사 
	var pwInput = document.getElementById('password');
	var pwPattern =  /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,25}$/
	
	var pwValue = pwInput.value;
	pwIsValid = pwPattern.test(pwValue);
	
	if(pwIsValid == 1) {
		
		// Ajax -> 부서 정보
        $.ajax({
            url: '/project/mypage/editPw',
            method: 'GET',
            data: {
                cus_pw : pwValue
            },
            success: function (data) {
                console.log("성공");
            },
            error: function (error) {
                // 오류 발생 처리
                console.error(error);
            }
        });
		
	}else {
		alert("올바르지 않음");
	}
	
}




</script>
</body>
</html>