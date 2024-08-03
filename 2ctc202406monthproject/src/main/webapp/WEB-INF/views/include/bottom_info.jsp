<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}/" />

<footer class="footer-site-footer">
  <div class="container">
  <hr />
    <div class="row">
      <div class="">
        <h6>2CTC Climate Change</h6> 
        <h6>Tracking Community</h6>
      </div>
      <div class="col-lg-2">
        <h6>날씨</h6>
        <ul class="footer-navbar-weather">
          <li><a href="${root}weather/surfaceofthesea" class="footer-nav-link">해수면</a></li>
          <li><a href="${root}weather/seatemperature" class="footer-nav-link">해수온도</a></li>
          <li><a href="${root}weather/rainfall" class="footer-nav-link">강수량</a></li>
          <li><a href="${root}weather/temperature" class="footer-nav-link">기온</a></li>
        </ul>
      </div>
      <div class="col-lg-2">
        <h6>참여하기</h6>
        <ul class="footer-navbar-campaign">
          <li><a href="${root}campaign/campaignMain" class="footer-nav-link">참여 캠페인</a></li>
          <li><a href="${root}product/productList" class="footer-nav-link">지구 상점</a></li>
        </ul>
      </div>
      <div class="col-lg-2">
        <h6>소식</h6>
        <ul class="footer-navbar-news">
			<c:forEach var='obj' items="${topMenuList}">
				<li><a href="${root}board/main?board_IDX=${obj.board_IDX}">${obj.board_info_Nm}</a></li>
			</c:forEach>
        </ul>
      </div>
      <div class="col-lg-2">
        <h6>마이페이지</h6>
        <ul class="footer-navbar-news">
          <li class="footer-nav-news"><a href="${root}user/mypage" class="footer-nav-link">마이페이지</a></li>
          <li class="footer-nav-news"><a href="${root}product/orderList" class="footer-nav-link">구매내역</a></li>
          <li class="footer-nav-news"><a href="${root}campaign/donationHistory" class="footer-nav-link">후원내역</a></li>
          <li class="footer-nav-news"><a href="${root}board/main?board_IDX=2" class="footer-nav-link">문의사항</a></li>
          <li class="footer-nav-news"><a href="${root}product/cart" class="footer-nav-link">장바구니</a></li>
        </ul>
      </div>
    </div>
    <%-- <div class="row">
      <div class="col-md-8 col-sm-6 col-xs-12">
        <p class="copyright-text">http://www.softSoldesk.co.kr</p>
      </div>
    </div> --%>
  </div>
</footer>
