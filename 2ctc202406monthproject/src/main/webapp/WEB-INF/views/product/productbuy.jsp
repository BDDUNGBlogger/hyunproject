<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<c:set var='root' value="${pageContext.request.contextPath }/"/> 
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">   
<title>구매 페이지</title> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

<link href="${root}css/top_menu.css" rel="stylesheet"/>
<link href="${root}css/bottom_info.css" rel="stylesheet"/>
<link href="${root}css/productbuy.css" rel="stylesheet"/>
</head>
<body>
<!-- 상단 메뉴 부분 --> 
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

   <div class="productbuy-container">
    <div class="productbuy-showpost">
        <div class="productbuy-title1">
            <h3>배송지</h3>
            <hr /> 
        </div>
        <div class="productbuy-customer">            
            <h4 id="customer-name" class="productbuy-name">${name}</h4>
            <p id="customer-phone" class="productbuy-phone">${phone}</p>
            <p id="customer-post_num" class="productbuy-post_num">${post_num}</p>
            <p id="customer-address" class="productbuy-address">${address}</p>
        </div>
        <div class="productbuy-change">
            <button class="productbuy-change-btn" id="change-button">변경</button>
        </div>               
         
        <div class="productbuy-request">               
            <select class="productbuy-request-option" id="requestOption">                   
                <option value="request1">요청사항 직접 입력하기</option>
                <option value="문 앞에 놓아주세요">문 앞에 놓아주세요</option>
                <option value="부재 시 연락 부탁드려요">부재 시 연락 부탁드려요</option>
                <option value="배송 전 미리 연락해 주세요">배송 전 미리 연락해 주세요</option>
            </select>
            <textarea class="productbuy-request-memo" id="requestMemo"></textarea>
        </div>
   </div> 

    <div class="productbuy-buy">
        <div class="productbuy-title2">
            <h3>주문 상품</h3>
            <hr />
        </div>
        <div class="productbuy-company">
            <h4 class="productbuy-companyname">SOLDESK</h4>
        </div>      
    <div class="productbuy-details">
        <div class="productbuy-img">
            <a href="${root}product/productdetail">
                <img src="${root}upload/${product_img}" alt="상품이미지">
            </a>
        </div>
        <div class="productbuy-info">
            <h4>${product_name}</h4>
            <p class="quantity-color">컬러: ${color}</p>
            <p class="productbuy-quantity">수량: ${quantity}개</p>
            <p class="productbuy-price1">가격: ${price}원</p>            
        </div>
    </div>
        <div class="productbuy-totalPrice">
            <h4>총 주문금액</h4>
            <h4 class="productbuy-price2">${totalprice}원</h4>
        </div>                     
    </div> 
    <!-- 구매하기 버튼 -->
    
    <div class="productbuy-realbuy" id="pay-button">
      <form id="paymentForm" method="POST" action="${root}product/product_payment">
            <input type="hidden" name="userID" value="${userID}">
            <input type="hidden" name="orderID" value="${orderID}">
            <input type="hidden" name=username value="${username}"> 
            <input type="hidden" name="phone" value="${phone}">
            <input type="hidden" name="post_num" value="${post_num}">
            <input type="hidden" name="address" value="${address}">
            <input type="hidden" name="totalprice" value="${totalprice}">         
            <input type="hidden" name="product_name" value="${product_name}" />
         <input type="hidden" name="product_img" value="${product_img}" />
         <input type="hidden" name="price" value="${price}" />
         <input type="hidden" name="quantity" value="${quantity}" />                        
         <input type="hidden" name="color" value="${color}" /> 
         <input type="hidden" name="productID" value="${productID}" />
            <button class="productbuy-realbuy-buy" id="pay-button" type="submit">구매하기</button> 
               </form>     
    </div>  
        
</div>
<!-- 하단메뉴 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />

<script>
$(document).ready(function() {
    $('#requestOption').change(function() {
        var selectedOption = $(this).val();
        var memoField = $('#requestMemo');
        if (selectedOption === 'request1') {
            memoField.val(''); // 직접 입력하기 선택 시 텍스트 영역 초기화
            memoField.prop('readOnly', false); // 텍스트 영역 수정 가능
        } else {
            memoField.val(selectedOption); // 선택한 요청사항을 텍스트 영역에 입력
            memoField.prop('readOnly', true); // 텍스트 영역 수정 불가
        }
    });

    $('#change-button').click(function() {
        window.open('${root}product/productmodify', '_blank', 'width=500, height=650, top=250, left=700');
    });

    $('#pay-button').click(function() {
        var form = $('<form method="POST" action="${root}product/product_payment"></form>');
        
        var fields = { 
            username: '${username}',
            phone: '${phone}',
            post_num: '${post_num}',
            address: '${address}', 
            product_img: '${product_img}',
            product_name: '${product_name}',
            color: '${param.color}',
            quantity: '${quantity}',
            price: '${price}',
            totalprice: '${param.totalprice}',
            orderID: '${orderID}',
            productID: '${productID}',
            userID: '${userID}' 
            
        };

        $.each(fields, function(key, value) {
            form.append('<input type="hidden" name="' + key + '" value="' + value + '">');
        });

        $('body').append(form);
        form.submit();
    }); 
});

//변경된 배송지 정보를 업데이트하는 함수
function updateDeliveryInfo(name, phone, post_num, address) {
    document.getElementById("customer-name").innerText = name;
    document.getElementById("customer-phone").innerText = phone;
    document.getElementById("customer-post_num").innerText = post_num;
    document.getElementById("customer-address").innerText = address;
}

//변경된 배송지 정보를 받아 업데이트하는 함수
function receiveDeliveryInfo(name, phone, post_num, address) {
    updateDeliveryInfo(name, phone, post_num, address);
    
}

</script>
</body>
</html>