<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
.mar-left {
	margin-left : 50px !important;
	margin-right : -300px !important;
}
</style>
<body>
<div class="col-3 container-lg mt-5 mar-left">
	<nav class="nav d-flex flex-column">
		<div class="mb-1 fw-bold">회원정보</div>
		<ul class="list-unstyled ps-3 mb-2">
			<li class="nav-item pb-1 active"><a
				class="text-decoration-none text-dark" href="/project/mypage.do">마이 프로필</a></li>
		</ul>
		<div class="mb-1 fw-bold">와글와글</div>
		<ul class="list-unstyled ps-3 mb-2">
			<li class="nav-item pb-1"><a
				class="text-decoration-none text-dark" href="/project/mypage_talk.do">내가 작성한 글</a></li>
		</ul>
		<div class="mb-1 fw-bold">함께해요</div>
		<ul class="list-unstyled ps-3 mb-2">
			<li class="nav-item pb-1"><a
				class="text-decoration-none text-dark" href="/project/mypage_together.do">내가 작성한 댓글</a></li>
		</ul>
	</nav>
</div>
</body>