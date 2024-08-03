<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}/" />
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<!-- 아이콘 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<%-- footer CSS --%>
<link rel="stylesheet" href="${root}css/bottom_info.css" />
<link rel="stylesheet" href="${root}css/top_menu.css" />
<link rel="stylesheet" href="${root}css/mypage.css" />

</head>
<body>  
	<c:import url="/WEB-INF/views/include/top_menu.jsp" />
	<aside class="side-bar">
		<section class="side-bar__icon-box">
			<section class="side-bar__icon-1">
				<div></div>
				<div></div>
			</section>
		</section>
		<ul>
			<li><a href="${root}user/userList"><i
					class="fas fa-user"></i> 회원 정보</a></li>
			<li><a href="${root}campaign/donationHistory"><i
					class="fas fa-hand-holding-heart"></i> 후원내역</a></li>
			<li><a href="${root}board/main?board_IDX=2"><i
					class="fas fa-headset"></i> 문의사항</a></li>
			<li><a href="${root}product/cart"><i
					class="fas fa-shopping-cart"></i> 장바구니</a></li>
					
		</ul>
		<img src="${root}upload/2CTC로고(흰바탕).png" alt="이미지 설명"
			class="side-bar__image">
	</aside>

	<section class="my-page-content">
		<section class="profile-section">
			<img src="${root}upload/2CTC로고(투명).png" alt="이미지 설명"
				class="side-bar__image">
			<h2>내 정보</h2>
			<p>${modifyUserBean.name}</p>
			<p>${modifyUserBean.email}</p>
			<p>${modifyUserBean.phone}</p>
			<a href="${root}user/modify" class="edit-profile-btn">정보 수정</a>
		</section>

		<%-- 	<section class="notifications-section">
			<h2>알림</h2>
			<ul>
				<li><a href="#">알림 1</a></li>
				<li><a href="#">알림 2</a></li>
				<li><a href="#">알림 3</a></li>
			</ul>
			<a href="${root}user/notification-settings" class="settings-btn">알림
				설정</a>
		</section> --%>

		<%-- <section class="news-section">
			<h2>최신 뉴스</h2>
			<p>최신 업데이트와 뉴스를 확인하세요.</p>
			<a href="${root}user/news" class="view-all-btn">모든 뉴스 보기</a>
		</section> --%>


	</section>

	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>