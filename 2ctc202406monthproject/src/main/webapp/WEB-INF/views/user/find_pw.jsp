<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}/" />
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>

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
            emailField.value = emailValue.substring(0, atPos + 1)
                  + selectedDomain;
         } else {
            emailField.value = emailValue + '@' + selectedDomain;
         }
      }
   }
</script>

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

                  <form:form type="post" action="${root}user/findpw_pro" modelAttribute="userBean" >         
                     <div class="form-group">
                        <form:label path="userID">아이디</form:label>
                        <form:input path="userID" class="form-control" />
                        <form:errors path="userID" style='color:red' />
                     </div>
                     
                      <div class="form-group">
                        <form:label path="name">이름</form:label>
                        <form:input path="name" class="form-control" />
                        <form:errors path="name" style='color:red' />
                     </div>

                     <div class="form-group">
                        <form:label path="email">이메일</form:label>

                        <form:input path="email" class='form-control'
                           onkeypress='resetUserIdExist()' />
                        <form:errors path="email" style='color:red' />
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
                        <div class="text-right">
                           <form:button type="submit" class="btn btn-primary">완료</form:button>
                        </div>
                        <div>
                        <a href="${root}user/login">뒤로가기</a>
                        </div>
                     </div>
                  </form:form>
               </div>
            </div>
         </div>
      </div>
   </div>

   <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>