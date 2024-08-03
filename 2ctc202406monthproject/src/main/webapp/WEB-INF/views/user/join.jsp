<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}/" />
<!DOCTYPE html>
<html>  
<head>
<meta charset="UTF-8">
<title>회원가입</title>
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
<link rel="stylesheet" href="../css/styles.css" />
<link rel="stylesheet" href="../css/join.css" /> 
<link rel="stylesheet" href="${root}/css/top_menu.css" />
<link rel="stylesheet" href="${root}/css/bottom_info.css" />

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function DaumPostCode() {
		
		 new daum.Postcode({
	            oncomplete: function(data) {
	            	
	            	var fullRoadAddr = data.roadAddress;
	            	var jibunAddr = data.jibunAddress;
	            	var zonecode = data.zonecode;
	            	
	            	document.getElementById('post_num').value = zonecode;
	                document.getElementById('address').value = fullRoadAddr ? fullRoadAddr : joiniogin;
	            }
		 }).open();
	}
</script>

</head>
<script>
   function checkUserIdExist(){
      var userID=$("#userID").val()
      
      //아이디를 입력하지 않았을 경우 예외처리
      if(userID.length==0){
         alert('아이디를 입력해주세요')
         return 
      }
      
      $.ajax({
         
         //요청할 주소
         url: '${root}user/checkUserIdExist/' + userID,
         //요청타입
         type: 'get',
         //응답결과
         dataType: 'text',
         //성공시 호출할 함수
         success:function(result){
            if(result.trim() == 'true'){
                     alert('사용할 수 있는 아이디입니다')
                     $("#userIdExist").val('true')
                  } else if(result.trim() == 'false'){
                     alert('사용할 수 없는 아이디 입니다')
                     $("#userIdExist").val('false')
                  }
         }
         
      }) //$.ajax
   }//checkUserIdExist()
   
   //사용자가 아이디란에 입력한 상태
   function resetUserIdExist(){
         $("#userIdExist").val('false') //처음에는 무조건 false
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

<body>

	<c:import url="/WEB-INF/views/include/top_menu.jsp" />

	<div class="container" style="margin-top: 100px">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-6">
				<div class="card shadow">
					<div class="card-body">
						<form:form action="${root}user/join_pro" method="post"
							modelAttribute="joinUserBean">
							<form:hidden path="userIdExist" />

							<div class="form-group">
								<form:label path="userID">아이디</form:label>
								<div class="input-group">
									<!-- onkeypress : input태그에 값이들어오면 자동으로 작동하는 메소드 호출 -->
									<form:input path="userID" class='form-control'
										onkeypress='resetUserIdExist()' />
									<div class="input-group-append">
										<button type="button" class="btn btn-dark"
											onclick='checkUserIdExist()'>중복확인</button>
									</div>
								</div>
								<form:errors path="userID" style='color:red' />

							</div>

							<div class="form-group">
								<form:label path="password">비밀번호</form:label>
								<form:password path="password" class='form-control' />
								<form:errors path="password" style='color:red' />
							</div>

							<div class="form-group">
								<form:label path="password2">2차비밀번호</form:label>
								<form:password path="password2" class='form-control' />
								<form:errors path="password2" style='color:red' />
							</div>

							<div class="form-group">
								<form:label path="name">이름</form:label>
								<form:input path="name" class='form-control' />
								<form:errors path="name" style='color:red' />
							</div>

							<div class="form-group">
								<form:label path="birthday">생년월일</form:label>
								<form:input path="birthday" id="birthday" class="form-control"
									type="date" />
								<form:errors path="birthday" cssClass="text-danger" />
							</div>

							<div class="form-group">
								<form:label path="gender">성별</form:label>
								<div class="form-check form-check-inline">
									<form:radiobutton path="gender" value="Male"
										class="form-check-input" id="male" />
									<label class="form-check-label" for="male">남성</label>
								</div>
								<div class="form-check form-check-inline">
									<form:radiobutton path="gender" value="Female"
										class="form-check-input" id="female" />
									<label class="form-check-label" for="female">여성</label>
								</div>
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

							<%-- <div class="form-row">
								<div class="form-group col-md-6">
									<form:label path="post_num">주소</form:label>
									<div class="input-group">
									<form:label path="address">주소</form:label>
									<form:label path="address2">상세주소</form:label>
										<form:input path="post_num" class="form-control" placeholder="우편번호"/>
										<div class="input-group-append">
											<button type="button" class="btn btn-primary"
												onclick="DaumPostCode">검색</button>
										</div>
									</div>
									<form:errors path="post_num" style="color: red" />
								</div>
							</div>

							<div class="form-group">
								<form:label path="address">주소</form:label>
								<form:input path="address" class='form-control' />
								<form:errors path="address" style='color:red' />
							</div>

							<div class="form-group">
								<form:label path="address2">상세주소</form:label>
								<form:input path="address2" class='form-control' />
								<form:errors path="address2" style='color:red' />
							</div> --%>

							<div class="form-group">
								<div class="text-right">
									<form:button class='btn btn-dark'>회원가입</form:button>
								</div>
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