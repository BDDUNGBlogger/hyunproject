<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="root" content="${root}">
    <meta name="_csrf" content="${_csrf.token}">
    <meta name="_csrf_header" content="${_csrf.headerName}">
    <title>장바구니</title>
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${root}/css/cart.css">
    <link rel="stylesheet" href="${root}/css/top_menu.css">
    <link rel="stylesheet" href="${root}/css/bottom_info.css">
</head>
<body>
    <c:import url="/WEB-INF/views/include/top_menu.jsp"/>

    <div class="containers">
        <div class="header">
            <h1 class="title">장바구니</h1>
            <span class="step">01 장바구니 /</span>
            <span class="step">02 결제 /</span>
            <span class="step">03 완료</span>
        </div>
        <form:form method="post" action="${root}product/cartbuyList" id="orderForm">
            <div class="cartup-container">
                <c:forEach var="cart" items="${cartItems}">
                    <div class="cartup">
                        <div class="cart">
                            <div class="cart-item">
                                <input type="checkbox" class="form-checkbox" name="productIDs" value="${cart.productID}" />
                                <img src="${root}upload/${cart.product_img}" alt="Product Image" class="product-image" />
                                <div class="item-details">
                                    <h2 class="product-name">${cart.product_name}</h2>
                                    <input type="hidden" class="productID" value="${cart.productID}" />
                                    <input type="hidden" class="productName" value="${cart.product_name}" />
                                    <input type="hidden" class="product_img" value="${cart.product_img}" />
                                    <input type="hidden" class="price" value="${cart.price}" />
                                    <input type="hidden" class="quantity" value="${cart.quantity}" />
                                    <p class="arrival-date">${cart.product_name}</p>
                                    <p class="product-price">${cart.price}</p>
                                </div>
                                <div class="quantity">
                                    <button class="minus-button" type="button">-</button>
                                    <input type="text" value="${cart.quantity}" class="quantity-input" readonly />
                                    <button class="plus-button" type="button">+</button>
                                </div>
                                <button class="button delete" type="button">삭제</button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="total">
                <div>
                    <span>선택된 상품</span>
                    <span class="selected-Prod">0원</span>
                </div>
                <div>
                    <span>총 배송비</span>
                    <span class="ship-price">1000원</span>
                </div> 
                <div class="bold">
                    <span>총 주문 금액</span>
                    <span class="total-price">0원</span>
                </div>
                <input type="hidden" name="totalprice" class="totalprice" value="0" />
                <button class="button-order" type="submit">주문하기</button>
            </div>
        </form:form>
    </div>

    <c:import url="/WEB-INF/views/include/bottom_info.jsp"/>
    <script src="${root}/js/cart.js"></script>
</body>
</html>
