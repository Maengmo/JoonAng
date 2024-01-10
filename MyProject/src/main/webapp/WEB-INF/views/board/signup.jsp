<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>함께해요 중앙😊</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
.img-box2 {
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
    width:100%;
}

#alert {
    position: relative;
    z-index: 1000; /* 원하는 값으로 조절 */
}

body {
	background-color: #F6F1ED !important;
}

.col-md-6 {
	width : 800px !important;
    background-color: #3498db;
    box-shadow: 10px 10px 20px rgba(0, 0, 0, 0.3),
                -10px -10px 20px rgba(255, 255, 255, 0.3);
    /* 다른 스타일링 속성 추가 가능 */
}
</style>
</head>
<body>
    <%@ include file="/WEB-INF/views/inc/header.jsp" %>

    
    <section class="container-md mt-5">
        <div class="row justify-content-center" style="background-color: #F6F1ED; padding: 50px 0;">
		    <div class="col-md-6 bg-light rounded p-4">
		        <h1 class="text-center mb-4">회원가입</h1>
	        	<img class="img-box2 mb-3" src="resources/img/signup.png">
		        <form method="POST" action="/project/signup.do">
		            <div class="mb-1">아이디</div>
	                    <div class="form-floating mb-3">
	                       <input type="text" class="form-control" id="userid"
	                          placeholder="name@example.com" name="cus_id" required> <label
	                          for="floatingInput">4~15자 이내로 입력해주세요</label>
	                </div>
		            <div class="mb-1">비밀번호</div>
	                    <div class="form-floating mb-3">
	                       <input type="password" class="form-control" id="password" name="cus_pw"
	                          placeholder="Password" name="m_pw" required> <label for="floatingPassword">최소
	                          6자 이상(알파벳, 숫자 필수)</label>
	                    </div>
	                    <div class="mb-1">비밀번호 확인</div>
                    <div class="form-floating mb-3">
                        <input type="password" class="form-control" id="passwordcheck" 
                           placeholder="Password" required> <label for="floatingPassword">비밀번호를
                           다시 입력하세요</label>
                    </div>
		            <div class="mb-1">이름</div>
                  		<div class="form-floating mb-3">
                     	<input type="text" class="form-control" id="name"
                        	placeholder="name" name="cus_name" required> <label for="floatingPassword">한글 2~5자</label>
                    </div>
		            <div class="mb-3">
		                <label for="birthdate" class="form-label">생년월일</label>
		                <input type="date" class="form-control" id="birthdate" name="cus_birth" required>
		            </div>
		            <div class="mb-1">이메일</div>
                  		<div class="form-floating mb-3">
                     	<input type="email" class="form-control" id="email"
                        	placeholder="tel" name="cus_email" required> <label for="floatingPassword">user@ham.com</label>
                    </div>
		            <div class="mb-3">
		                <label class="mb-2" for="departmentSelect">회사 선택</label>
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
		    <!-- 
		    <div id="alert" class="alert alert-success alert-dismissible fade show mt-3" role="alert" style="display:none;">
		         <c:if test="${success == 1}">
		             <p>회원가입이 성공적으로 완료되었습니다.</p>
		         </c:if>
		         <c:if test="${success != 1}">
		             <p>회원가입이 실패했습니다.</p>
		         </c:if>
		        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" onclick="showLoginSuccessMessage()"></button>
		    </div>
		     -->
		            <button id="submitbtn" type="submit" class="btn btn-primary w-100 mb-1 mt-1">가입하기</button>
		        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
		        </form>
		    </div>
		</div>	
    </section>
    
    

    <%@ include file="/WEB-INF/views/inc/footer.jsp" %>
    
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
//회원가입 alert 처리 -> 성공,실패 여부 -> alert
function Signup() {
	if('${success}' === '1') {
		showSweetAlert('회원가입 성공!😍', '로그인 후, 다양한 서비스를 즐겨보세요!!😉', 'success');
		
	}else if('${success}' === '0') {
		showSweetAlert2('회원가입 실패', '회원가입에 실패했습니다 정보를 살펴보세요..😒', 'warning');
	}else {
		
	}
}

function showSweetAlert(title, text, icon) {
    
    Swal.fire({
        title: title,
        text: text,
        icon: icon,
        showCancelButton: true,
        confirmButtonText: "확인",
        cancelButtonText: "Cancel"
    }).then((result) => {
        
        if (result.isConfirmed) {
            
            window.location.href = "/project/login.do";
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
        cancelButtonText: "Cancel"
    }).then((result) => {
        
        if (result.isConfirmed) {
           
        } else {
           
        }
    });
}

Signup();

//유효성 검사
var idIsValid = false;
var pwIsValid = false;
var pwcIsValid = false;
var emailIsValid = false;
var nameIsValid = false;

//id 유효성 검사 Ajax
var idInput = document.getElementById('userid');
var idPattern = /^(?=.*[a-zA-Z])(?=.*[0-9]).{4,15}$/;

idInput.addEventListener('input', function() {
    var idValue = idInput.value;
    idIsValid = idPattern.test(idValue);
    
     $.ajax({
       url: '/project/idcheck',
       type: 'GET',
       data: {id : idValue},
       dataType: 'json',
       success: (result) => {
                
          if (idIsValid && result == 0) {
             $('#userid + label').text('사용할 수 있는 아이디입니다.');
              idInput.classList.remove('is-invalid');
              idInput.classList.add('is-valid');
              idIsValid = true;
          } else {
             if (result > 0) {
                $('#userid + label').text('아이디가 중복됩니다.');
             } else {
                $('#userid + label').text('4~15자 이내로 입력해주세요');
             }
             
              idInput.classList.remove('is-valid');
              idInput.classList.add('is-invalid');
          }
             
       },
       error: (a,b,c) => console.log(a,b,c)
       
    }); 
    
});     

//비밀번호 유효성 검사 
var pwInput = document.getElementById('password');
var pwPattern =  /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,25}$/

pwInput.addEventListener('input', function() {
    var pwValue = pwInput.value;
    pwIsValid = pwPattern.test(pwValue);
    
    if (pwIsValid) {
        pwInput.classList.remove('is-invalid');
        pwInput.classList.add('is-valid');
    } else {
        pwInput.classList.remove('is-valid');
        pwInput.classList.add('is-invalid');
    }
});

//비밀번호 확인 유효성 검사
var pwcInput = document.getElementById('passwordcheck');

pwcInput.addEventListener('input', function() {
   var pwValue = pwInput.value;
    var pwcValue = pwcInput.value;
    
    pwcIsValid = (pwValue == pwcValue);
    
    if (pwcIsValid) {
        pwcInput.classList.remove('is-invalid');
        pwcInput.classList.add('is-valid');
    } else {
        pwcInput.classList.remove('is-valid');
        pwcInput.classList.add('is-invalid');
    }
});

//이름 유효성 검사
var nameInput = document.getElementById('name');
var namePattern = /^[가-힣]{2,5}$/;

nameInput.addEventListener('input', function() {
    var nameValue = nameInput.value;
    nameIsValid = namePattern.test(nameValue);
    
    if (nameIsValid) {
       nameInput.classList.remove('is-invalid');
       nameInput.classList.add('is-valid');
    } else {
       nameInput.classList.remove('is-valid');
       nameInput.classList.add('is-invalid');
    }
});

//이메일 유효성 검사
var emailInput = document.getElementById('email');
var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

emailInput.addEventListener('input', function() {
    var emailValue = emailInput.value;
    emailIsValid = emailPattern.test(emailValue);
    
    if (emailIsValid) {
        emailInput.classList.remove('is-invalid');
        emailInput.classList.add('is-valid');
    } else {
        emailInput.classList.remove('is-valid');
        emailInput.classList.add('is-invalid');
    }
});
// 전송 버튼 비활성화
$('#submitbtn').prop('disabled', true);

// 유효성 검사 및 버튼 활성화
function checkValidityAndEnableButton() {

	if (idIsValid && pwIsValid && pwcIsValid && emailIsValid && nameIsValid) {
        console.log(idIsValid && pwIsValid && pwcIsValid && emailIsValid);
        $('#submitbtn').prop('disabled', false);
    }
}

$('input').on('input', function() {
    checkValidityAndEnableButton();
});
</script>

</body>
</html>