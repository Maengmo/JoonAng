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
</style>
</head>
<style>
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/inc/header.jsp" %>
        	
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
				<input class="form-control" type="text" id="email" name="cus_name" value="${dto.cus_name}" disabled>
			</div>
			<div class="w-50 me-5 a-email">
				<p class="m-0 mb-2 w-auto">부서</p>
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
				<input class="form-control" type="email" id="email" name="cus_email" value="${dto.cus_email}" disabled>
			</div>
		</div>	
		<div class="fw-bold d-lg-flex align-items-center mb-3 mt-3">
			<div class="w-50 me-5 a-email">
				<p class="m-0 mb-2 w-auto">아이디</p>
				<input class="form-control" type="text" id="id" name="cus_id" value="${dto.cus_id}" disabled>	
			</div>
			<div class="w-50 me-5 a-email">
				<p class="m-0 mb-2 w-auto">비밀번호</p>
				<input class="form-control" type="password" id="password" name="cus_pw" value="${dto.cus_pw}" disabled>
			</div>
		</div>	
		
	</c:forEach>
			</div>
        </div>
    </div>
    
    <%@ include file="/WEB-INF/views/inc/footer.jsp" %>

    <!-- 부트스트랩 JS 및 Popper.js (햄버거 아이콘을 사용하기 위함) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>