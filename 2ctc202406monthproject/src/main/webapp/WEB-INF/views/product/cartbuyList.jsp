<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<c:set var='root' value="${pageContext.request.contextPath }/"/> 
<!DOCTYPE html>
<html>
<head>  
<meta charset="UTF-8">  
<title>구매내역</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

<link href="${root}css/top_menu.css" rel="stylesheet"/>
<link href="${root}css/bottom_info.css" rel="stylesheet"/>
<link href="${root}css/orderList.css" rel="stylesheet"/>
</head>
<body>
<!-- 상단 메뉴 부분 --> 
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

<div class="container">
    <div class="order-title">
        <h2 class="title">구매내역</h2>
    </div>
    
    <!-- 검색 바 -->
    <div class="order-serch">
        <input type="text" class="form-control" id="searchInput" placeholder="구매내역을 검색 할 수 있어요!" aria-label="Recipient's username" aria-describedby="button-addon2">
        <div class="order-serch-btn">
            <button class="btn btn-outline-secondary" type="button" id="button-addon2">검색</button>
        </div>
    </div>
    
    <c:forEach var="productID" items="${productIDs}" varStatus="status">
        <div class="order-info">    
            <div class="order-date">
                <h3>${orderSuccessMessage} - ${status.index + 1}번째 상품</h3>
                <hr /> 
            </div>
            <div class="order-state">  
                <h4 class="order-statedetail">배송상태</h4> 
                <a href="#" class="order-showdetail">주문 상세보기 〉</a>             
            </div>
            <div class="order-details">
                <div class="order-img">
                    <a href="${root}product/productdetail">
                        <img src="${root}upload/${productImgs[status.index]}" alt="상품이미지">
                    </a>
                </div>
                <div class="order-infodetail">
                    <p>${productNames[status.index]}</p>
                    <p class="quantity-color">컬러: ${colors[status.index]}</p>
                    <p class="productbuy-quantity">수량: ${quantities[status.index]}</p>
                    <p class="productbuy-price1">${prices[status.index]}원</p>
                </div>
            </div>
            <div class="order-btns">
                <button class="btn check">배송조회</button>
                <button class="btn cancel">주문, 배송 취소</button>
                <button class="btn apply">교환, 반품 신청</button>                
            </div>                     
        </div>
    </c:forEach>
</div>

<!-- 하단메뉴 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />

<script>
// Enter 키 입력 감지하여 검색 버튼 클릭
document.getElementById("searchInput").addEventListener("keyup", function(event) {
    if (event.key === "Enter") {
        event.preventDefault();
        document.getElementById("button-addon2").click();
    }
});

// 검색 버튼 엔터 키 입력 감지하여 검색
document.getElementById("button-addon2").addEventListener("keyup", function(event) {
    if (event.key === "Enter") {
        event.preventDefault();
        // 검색 기능 수행하는 함수 호출 (여기에 검색 기능을 넣어주세요)
     }
}); 
</script>
</body>
</html>
