<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Objects" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   

<%
	//현재 요청에 대한 세션 가져오기 (세션이 없으면 null 반환)
	HttpSession session2 = request.getSession(false);
	// 세션에 저장된 사용자 아이디 가져오기
	String adminId = (String) session2.getAttribute("adminId");
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
	
	.additional-li {
        background-color: #333333;
        height: 30px;
        display: none;
        transition: height 10s ease;
    }

    .show-additional-menu {
        display: flex;
        flex-direction: row-reverse;
    }

    @media (max-width: 767px) {
        .additional-li.show-additional-menu {
            display: block;
            height: 60px; /* 추가 메뉴가 나타날 때의 높이 설정 */
        }
    }
    
    .mr2 {
		margin-right : 30px !important;
	}
	
    
</style>

<body>

<!-- 상단 헤더 -->
<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container-fluid">
        <!-- 로고 -->
        <a class="logo" href="/project/admin.do">
            <img class="img-fluid" src="resources/img/logo.png" style="width: 120px;">
        </a>

        <!-- 햄버거 아이콘(작은 화면에서 메뉴 열기/닫기) -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- 네비게이션 메뉴 -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <%-- 세션에 adminId가 있을 경우(로그인 상태) --%>
                <% if (session.getAttribute("adminId") != null) { %>
                    <li class="nav-item">
                        <a id="logout" class="nav-link nav-link-custom white" href="javascript:void(0);" onclick="confirmLogout('/project/adminLogout.do')">로그아웃</a>
                    </li>
                    <li class="nav-item">
	                    <a class="nav-link nav-link-custom white" href="/project/board.do">사용자 메인 페이지</a>
	                </li>
                    <li class="nav-item">
	                    <a class="nav-link nav-link-custom white" href="/project/adminMyPage.do">관리자 정보</a>
	                </li>
                    <li class="nav-item">
	                    <a class="nav-link nav-link-custom white" href="/project/adminUser.do">회원 정보 관리</a>
	                </li>
	                <li class="nav-item">
				        <a class="nav-link nav-link-custom white" href="/project/adminTalk.do">게시물 관리</a> 
				    </li>
                <% } else { %>
                    <%-- 세션에 adminId가 없을 경우(로그아웃 상태) --%>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom white" href="/project/adminLogin.do">관리자</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom white" href="/project/login.do">로그인</a>
                    </li>
                    <li class="nav-item">
	                	<a class="nav-link nav-link-custom white" href="/project/find.do">ID,PW 찾기</a>
	                </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<div class="additional-li" style="background-color:#333333; height:30px;">
    <ul class="additional-li" style="display:flex; flex-direction: row-reverse;">
     <!-- 추가적인 li 태그들을 여기에 추가 -->
     <li class="nav-item">
         <a class="nav-link nav-link-custom white mr2" href="/project/adminTogether.do">함께해요 게시물 관리</a>
        </li>
     <li class="nav-item">
         <a class="nav-link nav-link-custom white mr2" href="/project/adminTalk.do">와글와글 게시물 관리</a>
        </li>
 	</ul>
</div>
</body>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>
//alert 로직 
function confirmLogout(logoutUrl) {
	showSweetAlert('로그아웃 하시겠습니까?', '로그아웃 시 메인으로 이동하게 됩니다..', 'warning', logoutUrl);
}

function showSweetAlert(title, text, icon, logoutUrl) {
    Swal.fire({
        title: title,
        text: text,
        icon: icon,
        showCancelButton: true,
        confirmButtonText: "로그아웃",
        cancelButtonText: "취소"
    }).then((result) => {
        
        if (result.isConfirmed) {
            
            showSweetAlert2('로그아웃 되었습니다.', '다음에도 함께해요 중앙!😁', 'success', logoutUrl);
               
        } else {
            
        }
    });
}

function showSweetAlert2(title, text, icon, logoutUrl) {
   
    Swal.fire({
        title: title,
        text: text,
        icon: icon,
        showCancelButton: true,
        confirmButtonText: "메인으로 이동합니다🚀",
        cancelButtonText: "취소"
    }).then((result) => {
        
        if (result.isConfirmed) {
            
        	window.location.href = "/project/adminLogout.do";;
        	
        } else {
            
        }
    });
}

document.addEventListener('DOMContentLoaded', function () {
	
    var navItem = document.querySelector('.navbar-nav');
    var additionalMenu = document.querySelector('.additional-li');

    navItem.addEventListener('mouseenter', function () {
        additionalMenu.classList.add('show-additional-menu');
    });

    additionalMenu.addEventListener('mouseleave', function () {
        additionalMenu.classList.remove('show-additional-menu');
    });
});

</script>