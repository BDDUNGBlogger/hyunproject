<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}/" />
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>  
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<%-- footer CSS --%>

<link href="${root}/css/top_menu.css" rel="stylesheet" />
<link href="${root}/css/imageBoard.css" rel="stylesheet" />
<link href="${root}/css/banner.css" rel="stylesheet" />
<link href="${root}/css/bottom_info.css" rel="stylesheet" />
<link href="${root}/css/modify.css" rel="stylesheet" />

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function DaumPostCode() {

		new daum.Postcode(
				{
					oncomplete : function(data) {

						var fullRoadAddr = data.roadAddress;
						var jibunAddr = data.jibunAddress;
						var zonecode = data.zonecode;

						document.getElementById('post_num').value = zonecode;
						document.getElementById('address').value = fullRoadAddr ? fullRoadAddr
								: joiniogin;
					}
				}).open();
	}
</script>


<script>
function resetUserIdExist() {
    // 이메일 입력 시 사용자 ID 존재 여부 초기화
    document.getElementById('email-error').textContent = '';
}

function appendDomain() {
    var emailField = document.getElementById('email');
    var domainList = document.getElementById('domain-list');
    var selectedDomain = domainList.options[domainList.selectedIndex].value;

    if (selectedDomain !== '' && selectedDomain !== '이메일 선택') {
        var emailValue = emailField.value;
        var atPos = emailValue.indexOf('@');

        if (atPos !== -1) {
            emailField.value = emailValue.substring(0, atPos + 1) + selectedDomain;
        } else {
            emailField.value = emailValue + '@' + selectedDomain;
        }
    }
}
</script>

</head>
<body>

	<c:import url="/WEB-INF/views/include/top_menu.jsp" />

	<div class="container" style="margin-top: 100px">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-6">
				<div class="card shadow">
					<div class="card-body">
						<form:form action="${root}user/modify_pro" method="post"
							modelAttribute="modifyUserBean">
							<div class="form-group">
								<form:label path="name">이름</form:label>
								<form:input path="name" class="form-control" readonly="true" />
								<!-- disabled="true" : 정보수정 버튼을 눌러서 /modify_pro으로 이동할때 서버로 이름을 전송하지 않음 -->
								<%-- <form:input path="name" class="form-control" disabled="true" /> --%>
								<!-- readonly : true :  disabled="true" + read -->
							</div>

							<div class="form-group">
								<form:label path="userID">아이디</form:label>
								<form:input path="userID" class="form-control" readonly="true" />
							</div>

							<div>
								<form:label path="password">수정할비밀번호</form:label>
								<form:password path="password" class='form-control' />
								<form:errors path='password' style='color:red' />
							</div>
							
							<div>
								<form:label path="password2">2차비밀번호</form:label>
								<form:password path="password2" class='form-control' />
								<form:errors path='password2' style='color:red' />
							</div>

							<div class="form-group">
								<form:label path="email">이메일</form:label>
								<form:input path="email" class='form-control'
									onkeypress='resetUserIdExist()' />
								<form:errors path="email" style='color:red' />
								<p/>
								<select id="domain-list" onchange="appendDomain()">
									<option disabled value="" selected>선택</option>
									<option>이메일 선택</option>
									<option>naver.com</option>
									<option>gmail.com</option>
									<option>daum.net</option>
									<option>hanmail.net</option>
									<option>hotmail.com</option>
									<option>nate.com</option>
									<option>yahoo.co.kr</option>
									<option>empas.com</option>
									<option>freechal.com</option>
									<option>lycos.co.kr</option>
									<option>korea.com</option>
									<option>hanmir.com</option>
									<option>dreamwiz.com</option>
									<option>paran.com</option>
								</select>
							</div>
							
							<div class="form-group">
								<form:label path="phone">휴대폰번호</form:label>
								<form:input path="phone" class='form-control'
									placeholder="ㅡ 없이 숫자만 입력" />
								<form:errors path="phone" style='color:red' />
							</div>

							<div class="form-group">
								<form:label path="address">주소</form:label>
								<div class="input-group mb-2">
									<form:input path="post_num" id="post_num" placeholder="우편번호"
										class="form-control" />
									<div class="input-group-append">
										<button type="button" class="btn btn-dark"
											onclick="DaumPostCode()">검색</button>
									</div>
								</div>
								<form:input path="address" id="address" placeholder="도로명 주소"
									class='form-control space-between-inputs' />
							</div>

							<div class="form-group">
								<div class="text-right">
									<form:button class="btn btn-dark">정보수정</form:button>
									<a href="${root}user/main"></a>
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
			<div class="col-sm-3"></div>
		</div>
	</div>

	<footer class="footer site-footer">
		<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
	</footer>
</body>
</html>