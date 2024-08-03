<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}/" />
<!DOCTYPE html>
<html>   
<head>
<meta charset="UTF-8">
<title>회원정보</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<%-- footer CSS --%>
<link rel="stylesheet" href="${root}css/bottom_info.css" />
<link rel="stylesheet" href="${root}css/top_menu.css" />
</head>
<body>
	<c:import url="/WEB-INF/views/include/top_menu.jsp" />

	<div class="container" style="margin-top: 100px">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-6">
				<div class="card shadow">
					<div class="card-body">

						<div class="form-group">
							<label path="name">이름</label> <input id="name"
								class="form-control" value="${modifyUserBean.name}"
								disabled="disabled" />
						</div>

						<div class="form-group">
							<label path="userID">아이디</label> <input id="userID"
								value="${modifyUserBean.userID}" class="form-control"
								disabled="disabled" />
						</div>

						<div class="form-group">
							<label path="birthday">생년월일</label> <input path="birthday"
								id="birthday" value="${modifyUserBean.birthday}"
								class="form-control" type="date" disabled="disabled" />
						</div>

						<div class="form-group">
							<label path="gender">성별</label> <input path="gender"
								value="${modifyUserBean.gender}" class="form-control"
								disabled="disabled" />
						</div>

						<div class="form-group">
							<label path="email">이메일</label> <input path="email"
								value="${modifyUserBean.email}" class="form-control"
								disabled="disabled" />
						</div>

						<div class="form-group">
							<label path="phone">휴대폰번호</label> <input path="phone"
								value="${modifyUserBean.phone}" class="form-control"
								disabled="disabled" />
						</div>

						<div class="form-group">
							<label path="post_num">우편번호</label> <input path="post_num"
								value="${modifyUserBean.post_num}" class="form-control"
								disabled="disabled" />
						</div>

						<div class="form-group">
							<label path="address">주소</label> 
							<input path="address" value="${modifyUserBean.address}" class="form-control"
								disabled="disabled" />
						</div>
						<div class="form-group">
							<div class="text-right">
								<a href="${root}user/modify" class="btn btn-dark">정보수정</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-3"></div>
		</div>
	</div>


	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />

</body>
</html>