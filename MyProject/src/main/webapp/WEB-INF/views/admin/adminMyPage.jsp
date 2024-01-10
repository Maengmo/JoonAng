<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>     

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>함께해요~ 중앙😊</title>
	
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<style>
body {
	background-color : #EEEEEE !important;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/inc/AdminHeader.jsp" %>
    
    <div class="col-9 container-lg mb-3 mt-3">
    	<div class="card h-100 border rounded shadow">
        	<div class="card-body">
    <c:forEach var="dto" items="${list}">
		<div class="container-lg mb-4 p-0">
			<h3 class="h3 mb-3 pb-2 fw-bold border-bottom border-2 border-dark"><span class="text-danger">Admin(DT 개발팀)</span> ${dto.ad_name}님 👩‍💻👨‍💻</h3>
		</div>
		<div class="fw-bold d-lg-flex align-items-center" style="display:flex; justify-content: center;">
			<img id="himg" src="resources/img/admin2.png" class="text-center" alt="사람이미지">
		</div>	
		<div class="fw-bold d-lg-flex align-items-center mb-3 mt-3">
			<div class="w-50 me-5 a-email">
				<p class="m-0 mb-2 w-auto">이름</p>
				<input class="form-control" type="text" id="name" name="cus_name" value="${dto.ad_name}" disabled>
			</div>
			<div class="w-50 me-5 a-email">
				<p class="m-0 mb-2 w-auto">직급</p>
				<input class="form-control" type="text" id="depart" name="cus_depart" value="${dto.ad_rank}" disabled>
			</div>
		</div>	
		<div class="fw-bold d-lg-flex align-items-center mb-3 mt-3">
			<div class="w-50 me-5 a-email">
				<p class="m-0 mb-2 w-auto">부서</p>
				<input class="form-control" type="text" id="name" name="cus_name" value="${dto.ad_depart}" disabled>
			</div>
			<div class="w-50 me-5 a-email">
				<p class="m-0 mb-2 w-auto">핸드폰</p>
				<input class="form-control" type="text" id="depart" name="cus_depart" value="${dto.ad_phone}" disabled>
			</div>
		</div>	
		<div class="fw-bold d-lg-flex align-items-center mb-3 mt-3">
			<div class="w-50 me-5 a-email">
				<p class="m-0 mb-2 w-auto">생년월일</p>
				<input class="form-control" type="date" id="date" name="cus_date" value="${dto.ad_birth}" disabled>
			</div>
			<div class="w-50 me-5 a-email">
				<p class="m-0 mb-2 w-auto">이메일</p>
				<div style="display:flex; height:40px;">
					<input class="form-control" type="email" id="email" name="cus_email" value="${dto.ad_email}" disabled>
				</div>
			</div>
		</div>	
		<div class="fw-bold d-lg-flex align-items-center mb-3 mt-3">
			<div class="w-50 me-5 a-email">
				<p class="m-0 mb-2 w-auto">아이디</p>
				<input class="form-control" type="text" id="id" name="cus_id" value="${dto.ad_id}" disabled>	
			</div>
			<div class="w-50 me-5 a-email">
				<p class="m-0 mb-2 w-auto">비밀번호</p>
				<div style="display:flex; height:40px;">
					<input class="form-control" type="password" id="password" name="cus_pw" value="${dto.ad_pw}" disabled>
				</div>
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