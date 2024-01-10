<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>함께해요 중앙😊</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        @font-face {
            font-family: 'LINESeedKR-Bd';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Bd.woff2') format('woff2');
            font-weight: 700;
            font-style: normal;
        }

        body {
            background-color: #eee;
        }

        .title {
            font-family: LINESeedKR-Bd;
        }

        .rounded-4 {
            box-shadow: 0 0 30px #999;
        }

        .row {
            height: 500px;
        }

        .img-box {
            background-image: url(resources/img/login.png);
            background-repeat: no-repeat;
            background-position: center;
            background-size: cover;
        }

        @media (max-width: 990px) {
            .col-md-12 {
                border-bottom-left-radius: 5px;
                border-top-left-radius: 5px
            }
        }
        
        .login:hover {
        	transform: scale(1.1); 
	    	transition: transform 0.3s; 
        }
    </style>
</head>

<body>
    <%@ include file="/WEB-INF/views/inc/header.jsp" %>

    <section class="container-md d-flex justify-content-center">
        <div class="row d-flex align-content-center vh-100 w-75">
            <div class="img-box col-lg-7 p-0 rounded-start d-lg-flex d-md-none d-sm-none"></div>
            <div class="col-sm-12 col-md-12 col-lg-5 p-0 bg-white d-flex align-items-center rounded-end h-75">
                <div class="container-md d-flex flex-column align-items-center">
                    <h1 class="h1 text-center fw-bold title">로그인</h1>
                    <p class="fs-6 text-center">로그인 후 다양한 서비스를 이용하세요.</p>
                    <form method="POST" action="/project/login.do">
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="floatingInput" placeholder="아이디"
                                name="username" required>
                            <label for="floatingInput">아이디</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="password" class="form-control" id="floatingPassword" placeholder="패스워드"
                                name="password" required>
                            <label for="floatingPassword">패스워드</label>
                        </div>
                        
                        <div class="container-fluid p-0 mt-3">
                            <button class="btn w-100 login" style="background-color: #007bff; color:white;">로그인</button>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
                    </form>
                    <div class="mt-2">
                        <p class="fs-6 text-center">
                            회원이 아니신가요? <a href="/project/signup.do" class="login">회원가입</a>
                        </p>
                    </div>
                    <div>
                    	<a href="javascript:kakaoLogin()">
                    		<img src="resources/img/kakaoLogin.png" alt="카카오 로그인" class="social">
                    	</a>
                    </div>
                    <!-- 추가된 부분: Alert 메시지 -->
                    <!-- 
				    <div id="alert" class="alert alert-success alert-dismissible fade show mt-3" role="alert" style="display:none;">
				        <strong>${message}</strong>
				        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" onclick="showLoginSuccessMessage()"></button>
				    </div>
				     -->	
                </div>
            </div>
        </div>
    </section>

    <%@ include file="/WEB-INF/views/inc/footer.jsp" %>
    
    <script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>

//로그인 시 -> 실패,성공 alert 처리
function Login() {
	if('${message}' === '로그인 성공! 다양한 서비스를 즐겨보세요!!') {
		
		showSweetAlert('로그인 성공', '다양한 서비스를 즐겨보세요!!😊', 'success');
		
	}else if('${message}' === '로그인 실패. 아이디 또는 패스워드가 일치하지 않습니다.') {
		
		showSweetAlert2('로그인 실패', '아이디 또는 패스워드가 일치하지 않습니다..😢', 'warning');
		
	}else if('${message}' === '로그인 실패. 정지된 회원 입니다..') {
		
		showSweetAlert2('로그인 실패', '정지된 회원 입니다..🫥', 'warning');
		
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
        // 사용자가 확인 버튼을 눌렀을 때
        if (result.isConfirmed) {
            // 페이지 이동 처리
            window.location.href = "/project/board.do";
        } else {
            // 취소 버튼을 눌렀거나 창을 닫았을 때의 처리
            // 추가적인 로직을 작성할 수 있습니다.
        }
    });
}

function showSweetAlert2(title, text, icon) {
    // SweetAlert 메시지 표시
    Swal.fire({
        title: title,
        text: text,
        icon: icon,
        showCancelButton: true,
        confirmButtonText: "확인",
        cancelButtonText: "Cancel"
    }).then((result) => {
        // 사용자가 확인 버튼을 눌렀을 때
        if (result.isConfirmed) {
            // 페이지 이동 처리
            //window.location.href = "/project/board.do";
        } else {
            // 취소 버튼을 눌렀거나 창을 닫았을 때의 처리
            // 추가적인 로직을 작성할 수 있습니다.
        }
    });
}

Login();
</script>
<!-- 카카오 로그인 -->

<script>
//카카오 로그인
Kakao.init('f33e29bc7b6f07f18871e88c4e891026');
function kakaoLogin() {
    Kakao.Auth.login({
        success: function (response) {
            Kakao.API.request({
                url: '/v2/user/me',
                success: function (response) {
                	
                	//정보 받아오기
                	var data = {           			
               			id : response.id,
                       	email : response.kakao_account.email,
       		            nickname : response.kakao_account.profile.nickname,
       		            profile_image : response.kakao_account.profile.thumbnail_image_url,
                	};
                	
                	$.ajax({
                		type : 'POST',
                		url : '/project/socialLogin.do',
                		data : data,
                		success : data => {
                			
                			if (data == "success") {
                				showSweetAlert('로그인 성공', '다양한 서비스를 즐겨보세요!!😊', 'success');
                				
                			} else if (data == "failed") {
                				showSweetAlert2('로그인 실패', '회원 정보가 존재하지 않습니다..😢', 'warning');
                			}
                			
                		},
                		error : (a,b,c) => console.log(a,b,c)	
                	})
                	
              

                    
                },
                fail: function (error) {
                    alert(JSON.stringify(error));
                },
            })
        },
        fail: function (error) {
            alert(JSON.stringify(error));
        },
    })
}
</script>    


</body>

</html>