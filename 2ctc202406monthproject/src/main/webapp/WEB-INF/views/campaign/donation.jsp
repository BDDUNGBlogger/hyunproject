<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}/" /> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>donation</title>
    <!-- Bootstrap CDN -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- Custom CSS -->
<link href="${root}css/top_menu.css" rel="stylesheet" />
<link href="${root}css/bottom_info.css" rel="stylesheet" />
<link href="${root}css/donation.css" rel="stylesheet" />
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

<!-- 후원 내역 -->
    <div class="container mt-5">
        <h2>후원 내역</h2>
        <form method="get" action="mypage">
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="startDate">시작 날짜</label>
                    <input type="date" class="form-control" id="startDate" name="startDate">
                </div>
                <div class="form-group col-md-6">
                    <label for="endDate">종료 날짜</label>
                    <input type="date" class="form-control" id="endDate" name="endDate">
                </div>
            </div>
            <button type="submit" class="btn btn-primary">조회</button>
        </form>
        <hr>
        <div class="support-history">
            <c:forEach var="support" items="${supports}">
                <div class="support-entry">
                    <p>${support.supportDate}</p>
                    <p>${support.description}</p>
                    <p>${support.amount}원</p>
                </div>
                <hr>
            </c:forEach>
        </div>
    </div>
    
<!-- 하단메뉴 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>
</body>
</html>
