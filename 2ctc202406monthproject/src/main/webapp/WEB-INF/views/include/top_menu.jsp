<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}/" />

<!-- 상단 메뉴 부분 -->
<nav
   class="navbar navbar-expand-md bg-dark navbar-dark fixed-top shadow-lg">
   <div class="navbar-header">
      <!-- D-DAY 요소 추가 -->
      <c:import url="/WEB-INF/views/include/ddayclock.jsp" />
      <a class="navbar-brand" href="${root}main"> <img
         src="${root}upload/2CTC로고(투명).png" alt="2CTC 로고"> 2CTC
      </a>
   </div>
   <button class="navbar-toggler" type="button" data-toggle="collapse"
      data-target="#navMenu">
      <span class="navbar-toggler-icon"></span>
   </button>
   <div class="collapse navbar-collapse" id="navMenu">
      <ul class="navbar-nav">
         <li class="nav-item dropdown"><a href="${root}board/read"
            class="nav-link dropdown-toggle" data-toggle="dropdown">날씨</a>
            <ul class="dropdown-menu">
               <li><a href="${root}weather/oceanofsurface"
                  class="dropdown-item">해수면</a></li>
               <li><a href="${root}weather/seatemperature"
                  class="dropdown-item">해수 온도</a></li>
               <li><a href="${root}weather/rainfall" class="dropdown-item">강수량</a></li>
               <li><a href="${root}weather/temperature" class="dropdown-item">기온</a></li>
            </ul></li>
         <li class="nav-item dropdown"><a href="${root}board/read"
            class="nav-link dropdown-toggle" data-toggle="dropdown">참여하기</a>
            <ul class="dropdown-menu">
               <li><a href="${root}campaign/campaignMain"
                  class="dropdown-item">참여 캠페인</a></li>
               <li><a href="${root}product/productList" class="dropdown-item">그린상점</a></li>
            </ul></li>
         <li class="nav-item dropdown"><a href="${root}board/read"
            class="nav-link dropdown-toggle" data-toggle="dropdown">소식</a>
            <ul class="dropdown-menu">
               <c:forEach var='obj' items="${topMenuList}">
                  <li><a href="${root}board/main?board_IDX=${obj.board_IDX}"
                     class="dropdown-item">${obj.board_info_Nm}</a></li>
               </c:forEach>
            </ul></li>
      </ul>
      <ul class="navbar-nav_user nav-user ml-auto">
         <c:choose>
            <c:when
               test="${not empty loginUserBean and loginUserBean.userLogin}">
               <li class="nav-user">
                  <button id="whologin">${loginUserBean.name}</button>
               </li>
               <li class="nav-item dropdown"><a href="#"
                  class="nav-link nav-dropdown-toggle" data-toggle="dropdown">▼</a>
                  <ul class="dropdown-menu dropdown-menu-right">
                     <li><a href="${root}user/mypage" class="dropdown-item">마이페이지</a></li>
                     <li><a href="${root}product/cart" class="dropdown-item">장바구니</a></li>
                     <li><a href="${root}campaign/donationHistory"
                        class="dropdown-item">후원내역</a></li>
                     <li><a href="${root}board/main?board_IDX=2" class="dropdown-item">문의사항</a></li>
                  </ul></li>
               <li class="nav-user"><a href="${root}user/logout"
                  class="nav-link btn-logout">로그아웃</a></li>
            </c:when>
            <c:otherwise>
               <li class="nav-user"><a href="${root}user/login"
                  class="nav-link btn-login">로그인</a></li>
               <li class="nav-user"><a href="${root}user/join"
                  class="nav-link btn-join">회원가입</a></li>
            </c:otherwise>
         </c:choose>
            
             <li class="nav-item">
                <a href="${root}chat" class="nav-link">날씨 ChatBot</a>
               </li>
      </ul>
   </div>
</nav>

<script>
   document
         .addEventListener(
               "DOMContentLoaded",
               function() {
                  var whologin = document.getElementById("whologin");
                  whologin
                        .addEventListener(
                              "click",
                              function() {
                                 <c:choose>
                                 <c:when test="${loginUserBean.rolecd == 'M'}">
                                 window.location.href = "${root}admin/adminMain";
                                 </c:when>
                                 <c:otherwise>
                                 window.location.href = "${root}user/modify";
                                 </c:otherwise>
                                 </c:choose>
                              });
               });
</script>

