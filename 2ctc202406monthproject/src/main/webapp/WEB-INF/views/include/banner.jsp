<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}/" />   
    <div class="banner-container">
        <div id="bannerCarousel" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#bannerCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#bannerCarousel" data-slide-to="1"></li>
                <li data-target="#bannerCarousel" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="upload/banner1.png" alt="Banner1">
                    <div class="carousel-caption">
                        <h1>Climate Change Indicators</h1>
                        <p>지금 지구의 변화를 확인하고, 우리의 미래를 보호하세요</p>
                        <a href="${root}weather/temperature" class="banner-button">자세히 보기</a>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="upload/banner2.jpg" alt="Banner2">
                    <div class="carousel-caption">
                        <h1>Climate Action Now for Future Generations</h1>
                        <p>함께 만드는 지속 가능한 미래, 기후 변화 대응 캠페인에 동참하세요</p>
                        <a href="${root}campaign/campaignMain" class="banner-button">참여하기</a>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="upload/banner3.jpg" alt="Banner3">
                    <div class="carousel-caption">
                        <h1>Join the Green Movement</h1>
                        <p>환경 보호를 위한 리사이클 상품으로 함께하세요</p>
                        <a href="${root}product/productList" class="banner-button">시작하기</a>
                    </div>
                </div>
            </div>
            <a class="carousel-control-prev" href="#bannerCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#bannerCarousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>
