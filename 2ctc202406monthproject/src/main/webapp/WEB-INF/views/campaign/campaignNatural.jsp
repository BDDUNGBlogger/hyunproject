<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="root" value="${pageContext.request.contextPath}/" />
<c:set var="activePage" value="natural" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>campaignNatural</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<link href="${root}css/top_menu.css" rel="stylesheet" />
<link href="${root}css/campaignbanner.css" rel="stylesheet" />
<link href="${root}css/bottom_info.css" rel="stylesheet" />
<link href="${root}css/campaignMain.css" rel="stylesheet" />
</head>
<body>
    <!-- 상단 메뉴 부분 -->
    <c:import url="/WEB-INF/views/include/top_menu.jsp" />

    <!-- Include Banner -->
    <c:import url="/WEB-INF/views/campaign/campaignbanner.jsp" />

    <!-- support Category -->
    <div class="container mt-3" style="margin-top: 30px;">
        <div class="row centered-buttons">
            <div class="col-auto">
                <a href="${root}campaign/campaignMain" class="btn round-button ${activePage == 'main' ? 'active' : 'inactive'}">전체</a>
                <a href="${root}campaign/campaignNatural" class="btn round-button ${activePage == 'natural' ? 'active' : 'inactive'}">환경</a>
                <a href="${root}campaign/campaignAnimal" class="btn round-button ${activePage == 'animal' ? 'active' : 'inactive'}">동물</a>
            </div>
        </div>
    </div>

    <!-- Natural Campaigns -->
    <div class="container mt-5" style="margin-top: 10px">
        <div class="row">
            <div class="col-12">
                <h3 class="category-title">환경 ></h3>
            </div>
        </div>
        <div class="row" style="margin-top: 10px">
            <c:forEach var="natural" items="${naturalCampaigns}">
                <div class="col-12 col-md-4 mb-4">
                    <div class="card">
                        <a href="${root}campaign/campaignDetail?campaignID=${natural.campaignID}">
                            <img src="${root}upload/${natural.cam_img}" class="card-img-top" alt="${natural.cam_title}" width="100%">
                        </a>
                        <div class="card-body">
                            <a href="${root}campaign/campaignDetail?campaignID=${natural.campaignID}">
                                <h5 class="card-title">${natural.cam_title}</h5>
                            </a>
                            <p class="card-text">${natural.cam_host}</p>
                            <div class="progress">
                                <div class="progress-bar" role="progressbar" style="width: ${natural.current_amount / natural.goal_amount * 100}%" aria-valuenow="${natural.current_amount / natural.goal_amount * 100}" aria-valuemin="0" aria-valuemax="100">
                                    ${natural.current_amount / natural.goal_amount * 100}%
                                </div>
                            </div>
                            <p class="mt-2">
                                <fmt:formatNumber value="${natural.current_amount}" type="currency" currencySymbol="₩"/>
                            </p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Pagination -->
    <div class="container mt-5">
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
                <li class="page-item <c:if test='${pageBean.prevPage == 0}'>disabled</c:if>'">
                    <a class="page-link" href="${root}campaign/campaignNatural?page=${pageBean.prevPage}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <c:forEach begin="${pageBean.min}" end="${pageBean.max}" var="i">
                    <li class="page-item <c:if test='${pageBean.currentPage == i}'>active</c:if>'">
                        <a class="page-link" href="${root}campaign/campaignNatural?page=${i}">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item <c:if test='${pageBean.nextPage > pageBean.pageCnt}'>disabled</c:if>'">
                    <a class="page-link" href="${root}campaign/campaignNatural?page=${pageBean.nextPage}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>

    <!-- 하단메뉴 -->
    <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>
