<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>main</title>
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <!-- Custom CSS -->
	<link href="css/top_menu.css" rel="stylesheet"/>
	<link href="css/imageBoard.css" rel="stylesheet"/>
	<link href="css/banner.css" rel="stylesheet"/>
	<link href="css/bottom_info.css" rel="stylesheet"/>
	<link href="css/newsBoard.css" rel="stylesheet"/>
	<link href="css/camBoard.css" rel="stylesheet"/>
	<link href="css/camBoard.css" rel="stylesheet"/>
	
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

<!-- Include Banner -->
<c:import url="/WEB-INF/views/include/banner.jsp"/>

<!-- 날씨 바로가기 메뉴 -->
<c:import url="/WEB-INF/views/include/imageBoard.jsp"/>

<!-- 캠페인 바로가기 메뉴 -->
<c:import url="/WEB-INF/views/include/camBoard.jsp"/>


<!-- 뉴스레터 -->
<c:import url="/WEB-INF/views/include/newsBoard.jsp"/>

<!-- 하단메뉴 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>
</body>
</html>
