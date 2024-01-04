<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Objects" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//현재 요청에 대한 세션 가져오기 (세션이 없으면 null 반환)
	HttpSession session2 = request.getSession(false);
	// 세션에 저장된 사용자 아이디 가져오기
	String userId = (String) session2.getAttribute("userId");
%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

	@font-face {
	     font-family: 'S-CoreDream-3Light';
	     src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/S-CoreDream-3Light.woff') format('woff');
	     font-weight: normal;
	     font-style: normal;
	}
		
	body {
		font-family: 'S-CoreDream-3Light' !important;
	}

    .navbar-custom {
        background-color: #333;
        padding: 15px;
    }

    /* 로고 텍스트 스타일 */
    .navbar-brand-custom {
        color: aliceblue;
        font-size: 24px;
    }

    /* 메뉴 항목의 텍스트 스타일 */
    .nav-link-custom {
        color: aliceblue;
        font-weight: bold;
    }
    
    .white {
	    color: white !important;
	}
	
	.white:hover {
	    color: red !important; 
	    font-weight : bold;
	    transform: scale(1.1);
	    transition: transform 0.3s; 
	}
	
	.logo:hover {
	    transform: scale(1.1); 
	    transition: transform 0.3s; 
	}
    
</style>

<body>

<!-- 상단 헤더 -->
<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container-fluid">
        <!-- 로고 -->
        <a class="logo" href="/project/board.do">
            <img class="img-fluid" src="resources/img/logo.png" style="width: 120px;">
        </a>

        <!-- 햄버거 아이콘(작은 화면에서 메뉴 열기/닫기) -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- 네비게이션 메뉴 -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <%-- 세션에 userId가 있을 경우(로그인 상태) --%>
                <% if (session.getAttribute("userId") != null) { %>
                    <li class="nav-item">
                        <a id="logout" class="nav-link nav-link-custom white" href="javascript:void(0);" onclick="confirmLogout('/project/logout.do')">로그아웃</a>
                    </li>
                    <li class="nav-item">
	                    <a class="nav-link nav-link-custom white" href="/project/mypage.do">마이페이지</a>
	                </li>
                    <li class="nav-item">
	                    <a class="nav-link nav-link-custom white" href="/project/talk.do">와글와글</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link nav-link-custom white" href="/project/together.do">함께해요</a>
	                </li>
                <% } else { %>
                    <%-- 세션에 userId가 없을 경우(로그아웃 상태) --%>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom white" href="/project/adminLogin.do">관리자</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom white" href="/project/login.do">로그인</a>
                    </li>
                    <li class="nav-item">
	                	<a class="nav-link nav-link-custom white" href="/project/find.do">ID,PW 찾기</a>
	                </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom white" href="/project/signup.do">회원가입</a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
</body>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>
//alert 로직 
function confirmLogout(logoutUrl) {
	showSweetAlert('로그아웃 하시겠습니까?', '로그아웃 시 메인으로 이동하게 됩니다..', 'warning');
}

function showSweetAlert(title, text, icon) {
    Swal.fire({
        title: title,
        text: text,
        icon: icon,
        showCancelButton: true,
        confirmButtonText: "로그아웃",
        cancelButtonText: "취소"
    }).then((result) => {
        
        if (result.isConfirmed) {
            
            showSweetAlert2('로그아웃 되었습니다.', '다음에도 함께해요 중앙!😁', 'success');
               
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
        confirmButtonText: "메인으로 이동합니다🚀",
        cancelButtonText: "취소"
    }).then((result) => {
        
        if (result.isConfirmed) {
            
        	window.location.href = "/project/logout.do";
        	
        } else {
            
        }
    });
}
</script>