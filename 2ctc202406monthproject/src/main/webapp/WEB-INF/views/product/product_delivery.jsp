<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<c:set var='root' value="${pageContext.request.contextPath }/"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송조회</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

<link href="${root}css/top_menu.css" rel="stylesheet"/>
<link href="${root}css/bottom_info.css" rel="stylesheet"/>
<link href="${root}css/product_delivery.css" rel="stylesheet"/>
</head>
<body>
<!-- 상단 메뉴 부분 --> 
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

<div class="container">
    <div class="delivery-title">
        <h2 class="title">배송조회</h2>
    </div>
   
        <div class="delivery-container">    
			<div class="row">
            <!-- 배송대기 -->
            <div class="col-md-4">
                <div class="delivery-status1">
                    <h3>상품준비</h3>
                    <img src="${root}upload/box.jpg" alt="배송대기 이미지">
                    <p>주문하신 상품이 준비 중입니다.</p>
                </div>
            </div>
            <!-- 배송중 -->
            <div class="col-md-4">
                <div class="delivery-status2">
                    <h3>배송중</h3>
                    <img src="${root}upload/delivery.jpg" alt="배송중 이미지">
                    <p>현재 상품이 배송 중에 있습니다.</p>
                </div>
            </div>
            <!-- 배송완료 -->
            <div class="col-md-4">
                <div class="delivery-status3">
                    <h3>배송완료</h3>
                    <img src="${root}upload/delivery_success.jpg" alt="배송완료 이미지">
                    <p>상품이 정상적으로 배송되었습니다.</p>
                </div>
            </div>
        </div>                                 
      </div>
     <div class="delivery-bottom">
     	<h3>배송조회는 배송중부터 조회가능합니다.</h3>	
     </div>     
</div>

<!-- 하단메뉴 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />

</body>
</html>