<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}/" />
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<!-- Bootstrap CDN -->
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

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/5.5.2/ionicons.min.css">

<%-- footer CSS --%>
<link rel="stylesheet" href="${root}css/bottom_info.css" />
<link rel="stylesheet" href="${root}css/top_menu.css" />
<link rel="stylesheet" href="${root}css/login.css" />
</head>
<body>

	<c:import url="/WEB-INF/views/include/top_menu.jsp" />

	<div class="container" style="margin-top: 100px">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-6">
				<div class="card shadow">
					<div class="card-body">
						<c:if test="${fail==true}">
							<div class="alert alert-danger">
								<h3>로그인 실패</h3>
								<p>아이디 비밀번호를 확인해주세요</p>
								
							</div>
						</c:if>
						<form:form action="${root}user/login_pro" method="post"
							modelAttribute="tempLoginBean">
							<div class="form-group">
								<form:label path="userID">아이디</form:label>
								<form:input path="userID" class="form-control" />
								<form:errors path="userID" style='color:red' />
							</div>

							<div class="form-group">
								<form:label path="password">비밀번호</form:label>
								<form:password path="password" class='form-control' />
								<form:errors path='password' style='color:red' />
							</div>

							<div class="form-group text-right">
								<form:button class='btn btn-dark'>로그인</form:button>
								<a href="${root}user/join" class="btn btn-dark">회원가입</a>
							</div>
							
							<div class="remember-forgot">
								<a href="${root }user/find_id">아이디 찾기</a>
								<a href="${root }user/find_pw">비밀번호 찾기</a>
							</div>
							
							<div class="method-control">
                        <a href="${root}/user/getGoogleAuthUrl" class="method-action" id="customBtn"> <i
                           class="ion ion-logo-google"></i> <span>Google social login</span>
                        </a>
                     </div>

						</form:form>
					</div>
				</div>
			</div>
			<div class="col-sm-3"></div>
		</div>
	</div>

	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>