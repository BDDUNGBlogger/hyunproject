<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<c:set var='root' value="${pageContext.request.contextPath }/"/> 
<!DOCTYPE html>
<html>
<head>  
<meta charset="UTF-8">  
<title>주문 상세보기</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

<link href="${root}css/top_menu.css" rel="stylesheet"/>
<link href="${root}css/bottom_info.css" rel="stylesheet"/>
<link href="${root}css/order_detail.css" rel="stylesheet"/>
</head>
<body>
	<!-- 상단 메뉴 부분 --> 
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

<div class="container">
    <div class="order-detail-title">
        <h2 class="title">주문 상세보기</h2>
    </div>
    
        <div class="order-detail-info">    
            <div class="order-detail-date1">
                <h3>주문상세</h3>
                <hr /> 
            </div>
            <div class="order-details">
                <div class="order-detail-img">
                    <a href="${root}product/productdetail">
                        <img src="${root}upload/${product_img}" alt="상품이미지">
                    </a>
                </div>
                <div class="order-detail-infodetail">
                    <p class="order-detail-color">상품이름</p>
                    <p class="order-detail-color">컬러</p>
                    <p class="order-detail-quantity">수량</p>
                    <p class="order-detail-price1">구매금액</p>
                </div>
                <div class="order-detail-infodetail">
                    <p class="order-detail-product_name">${product_name}</p>
                    <p class="order-detail-color">${color}</p>
                    <p class="order-detail-quantity">${quantity}</p>
                    <p class="order-detail-price1">${totalPrice}</p>
                </div>
            </div>
            
            
            <div class="order-detail-date2">
                <h3>받는사람 정보</h3>
                <hr /> 
            </div>
            <div class="order-details">               
                <div class="order-detail-infodetail">
                    <p class="order-detail-color">받는사람</p>
                    <p class="order-detail-color">연락처</p>
                    <p class="order-detail-quantity">받는주소</p>
                    <p class="order-detail-price1">배송요청사항</p>
                </div>
                <div class="order-detail-infodetail">
                    <p class="order-detail-color">${username}</p>
                    <p class="order-detail-color">${phone}</p>
                    <p class="order-detail-quantity">${address}</p>
                    <p class="order-detail-price1">배송요청사항 문 앞에 놓아주세요</p>
                </div>
            </div>
           	
                   
            <div class="order-detail-date3">
                <h3>결제정보</h3>
                <hr /> 
            </div>
            <div class="order-details">               
                <div class="order-detail-infodetail">
                    <p class="order-detail-color">결제수단</p>
                    <p class="order-detail-color">총 상품가격</p>
                    <p class="order-detail-quantity">총 결제금액</p>
                </div>
                <div class="order-detail-infodetail">
                    <p class="order-detail-color">카카오페이</p>
                    <p class="order-detail-color">${totalPrice}</p>
                    <p class="order-detail-quantity">${totalPrice}</p>
                </div>
            </div>       
                                
        </div>        

</div>

<!-- 하단메뉴 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>