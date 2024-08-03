<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}/" />    
<div class="banner-container">
    <div id="bannerCarousel" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#bannerCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#bannerCarousel" data-slide-to="1"></li>
        </ol> 
        <div class="carousel-inner">
            <div class="carousel-item active">
            <a href="${root}campaign/campaignNatural">
                <img src="${root}upload/campaignNaturalBanner.png" alt="Banner1">
                </a>
                <div class="carousel-caption">
                </div>
            </div>
            <div class="carousel-item">
                 <a href="${root}campaign/campaignAnimal">
       			 <img src="${root}upload/campaignAnimalBanner.png" alt="Banner2">
    				</a>
                <div class="carousel-caption">
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
