<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>함께해요 중앙😊</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<style>
.bold {
    font-weight: bold;
}
</style>
</head>
<body>
    <%@ include file="/WEB-INF/views/inc/header.jsp" %>
    
    <div class="container mt-5 mb-5">
        <div class="card shadow-lg">
            <img src="resources/img/main4.jpg" class="card-img-top" alt="이미지">
            <div class="card-body">
                <h3 class="card-title mb-3 text-center bold">와글와글 글 작성하기😊</h3>
                <form id="talkForm" method="POST" action="/project/addtalk.do" onsubmit="return submitForm()">
                    <div class="mb-3">
                        <label for="formTitle" class="form-label bold">제목</label>
                        <input type="text" class="form-control" id="formTitle" name="talk_subject" required placeholder="제목을 입력하세요">
                    </div>
                    <div class="mb-3">
                        <label for="formContent" class="form-label bold">내용</label>
                        <textarea class="form-control" id="formContent" rows="3" name="talk_content" required placeholder="내용을 입력하세요"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">제출</button>
                	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
                </form>
            </div>
        </div>
    </div>
    
<%@ include file="/WEB-INF/views/inc/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script>
//Custom alert -> 전송 처리
function submitForm() {
    // alert 성공 후 ->
    showSweetAlert().then((result) => {
        // 확인 버튼을 눌렀을 때 폼을 제출
        if (result.isConfirmed) {
            document.getElementById("talkForm").submit();
        }
    });
    return false; // 폼 제출을 막음
}

function showSweetAlert() {
    
    return Swal.fire({
        title: "글 작성이 성공적으로 완료 되었습니다!",
        text: "와글와글 게시판으로 이동합니다~",
        icon: "success",
        showCancelButton: true,
        confirmButtonText: "확인",
        cancelButtonText: "Cancel"
    });
}
</script>
</html>