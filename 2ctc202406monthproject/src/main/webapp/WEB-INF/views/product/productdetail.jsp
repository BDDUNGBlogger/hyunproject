<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<title>상품 상세 페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

<link href="${root}css/top_menu.css" rel="stylesheet"/>
<link href="${root}css/bottom_info.css" rel="stylesheet"/>
<link href="${root}css/productdetail.css" rel="stylesheet"/>
<style>
    button, button:focus, button:active {
        outline: none;
        box-shadow: none;
    }
    
    .prodetail-quantity-container {
        display: none;
    }
</style>
</head>
<body>

<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

<div class="prodetail-container" style="margin-top: 100px">
    <div class="prodetail-image-container">
        <img src="${root}upload/${product_img}" alt="상품 이미지" class="prodetail-image">
    </div>
    <form id="productForm" method="post">
        <input type="hidden" name="productID" value="${productID}">
        <input type="hidden" name="price" value="${price}">
        <input type="hidden" name="product_img" value="${product_img}">
        <input type="hidden" name="product_name" value="${product_name}">
        <input type="hidden" name="color" id="selected-color" value="" />
        <input type="hidden" id="totalPrice" name="totalPrice" value="">
        
        <div class="prodetail-details">
            <h2>${product_name}</h2>
            <p>사탕수수로 만든 텀블러</p>
            <ul>
                <li>가격: ${price}</li>
                <li>배송방법: 택배</li>
                <li>제조사: SOLDESK</li>
            </ul>
            <div>
                <label for="prodetail-color">색상:</label>
                <select class="prodetail-color" name="color" >
                    <option value="none">색상 선택</option>
                    <option value="red">빨간색</option>
                    <option value="blue">파란색</option>
                    <option value="green">초록색</option>
                </select>
            </div>

            <div class="prodetail-quantity-container"  style="margin-top: 10px"> 
                <label for="prodetail-quantity">수량:</label>
                <input type="number" class="prodetail-quantity" name="quantity" min="0" value="0">
            </div>
            <hr />
            <div class="prodetail-total-price">
                <h2>총 구매 금액:</h2>
            </div>
            <div class="prodetail-btns">
               <button type="button" onclick="submitForm('${root}product/productbuy')" class="prodetail-buy-btn">구매하기</button>
                <button type="button" onclick="submitForm('${root}product/cart_pro')" class="prodetail-cart-btn">장바구니</button>
            </div>
        </div>
    </form>
    <div class="prodetail-toggle-detail" style="margin-top: 50px">
        <button class="prodetail-show-detail">상세 정보 보기</button>
        <button class="prodetail-hide-detail">상세 정보 닫기</button>
    </div>
</div>

<div class="prodetail-detail-page" style="text-align: center;">
    <img src="https://shop-phinf.pstatic.net/20240527_167/1716804520123cJatI_PNG/%EB%A6%AC%EB%89%B4%EC%96%B4%EC%8A%A4_%EC%82%AC%ED%83%95%EC%88%98%EC%88%98%ED%85%80%EB%B8%94%EB%9F%AC_PDP_1000_%EC%B5%9C%EC%A2%85_(1).png?type=w860" data-src="https://shop-phinf.pstatic.net/20240527_167/1716804520123cJatI_PNG/%EB%A6%AC%EB%89%B4%EC%96%B4%EC%8A%A4_%EC%82%AC%ED%83%95%EC%88%98%EC%88%98%ED%85%80%EB%B8%94%EB%9F%AC_PDP_1000_%EC%B5%9C%EC%A2%85_(1).png?type=w860" alt="" class="se-image-resource">
</div>

<div class="prodetail-flex-container" style="margin-top: 100px">
    <div class="prodetail-prdInfo_line">
        <div class="prodetail-fleft3">
            <h2>
                <span>EXCHANGE</span> INFO
            </h2>
            <h3>교환 및 반품정보</h3>
        </div>
        <div class="prodetail-up-page">
            <a href="#">위로가기</a>
        </div>
        <div class="prodetail-prdInfo_text">
            <strong>교환 및 반품 주소</strong><br>- 서울시영등포구 선유로 130, 에이스하이테크시티3차 B106호<strong><br><br>교환 및 반품이 가능한 경우</strong><br>
- 상품을 공급 받으신 날로부터 7일이내 단, 가전제품의<br>
 &nbsp;경우 포장을 개봉하였거나 포장이 훼손되어 상품가치가 상실된 경우에는 교환/반품이 불가능합니다.<br>
- 공급받으신 상품 및 용역의 내용이 표시.광고 내용과<br>
 &nbsp;다르거나 다르게 이행된 경우에는 공급받은 날로부터 3월이내, 그사실을 알게 된 날로부터 30일이내<br>
<br>

<strong>교환 및 반품이 불가능한 경우</strong><br>
- 고객님의 책임 있는 사유로 상품등이 멸실 또는 훼손된 경우. 단, 상품의 내용을 확인하기 위하여<br>
 &nbsp;포장 등을 훼손한 경우는 제외<br>
- 포장을 개봉하였거나 포장이 훼손되어 상품가치가 상실된 경우<br>
 &nbsp;(예 : 가전제품, 식품, 음반 등, 단 액정화면이 부착된 노트북, LCD모니터, 디지털 카메라 등의 불량화소에<br>
 &nbsp;따른 반품/교환은 제조사 기준에 따릅니다.)<br>
- 고객님의 사용 또는 일부 소비에 의하여 상품의 가치가 현저히 감소한 경우 단, 화장품등의 경우 시용제품을 <br>
 &nbsp;제공한 경우에 한 합니다.<br>
- 시간의 경과에 의하여 재판매가 곤란할 정도로 상품등의 가치가 현저히 감소한 경우<br>
- 복제가 가능한 상품등의 포장을 훼손한 경우<br>
 &nbsp;(자세한 내용은 고객만족센터 1:1 E-MAIL상담을 이용해 주시기 바랍니다.)<br>
<br>
※ 고객님의 마음이 바뀌어 교환, 반품을 하실 경우 상품반송 비용은 고객님께서 부담하셔야 합니다.<br>
 &nbsp;(색상 교환, 사이즈 교환 등 포함)				
        </div>
    </div>
    <!-- 상품결제정보 -->
    <div class="prodetail-prdInfo_line">
        <div class="prodetail-fleft1">
            <h2>
                <span>PAYMENT</span> INFO
            </h2>
            <h3>상품결제정보</h3>
        </div>
        <div class="prodetail-up-page">
            <a href="#">위로가기</a>
        </div>
        <div class="prodetail-prdInfo_text">
            고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다. 확인과정에서 도난 카드의 사용이나
      정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다. &nbsp; <br>
      <br>
      무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다. &nbsp;<br>
      주문시 입력한&nbsp;입금자명과 실제입금자의 성명이 반드시 일치하여야 하며, 7일 이내로 입금을 하셔야 하며&nbsp;입금되지
      않은 주문은 자동취소 됩니다. <br>				
        </div>
    </div>
    <!-- 배송정보 -->
    <div class="prodetail-prdInfo_line">
        <div class="prodetail-fleft2">
            <h2>
                <span>DELIVERY</span> INFO
            </h2>
            <h3>배송정보</h3>
        </div>
        <div class="prodetail-up-page">
            <a href="#">위로가기</a>
        </div>
        <div class="prodetail-prdInfo_text">
            배송 방법 : 택배<br>
					배송 지역 : 전국지역<br>
					배송 비용 : 3,000원<br>
					배송 기간 : 3일 ~ 7일<br>
					배송 안내 : - 산간벽지나 도서지방은 별도의 추가금액을 지불하셔야 하는 경우가 있습니다.<br>
    고객님께서 주문하신 상품은 입금 확인후 배송해 드립니다. 다만, 상품종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.<br>

        </div>
    </div>
</div>

<!-- 하단메뉴 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />

<script>
function submitForm(action) {
	const quantity = $('.prodetail-quantity').val();
    if (quantity == 0) {
        alert('수량을 선택해 주세요.');
        return false;
    }
    
    const form = document.getElementById('productForm');
    form.action = action;
    form.submit();
}

$(document).ready(function() {
	
	// 초기에 상세 정보는 숨깁니다.
	$('.prodetail-detail-page').hide();

	$('.prodetail-show-detail').on('click', function() {
		$('.prodetail-detail-page').show();
		$(this).hide();
		$('.prodetail-hide-detail').show();
	});

	$('.prodetail-hide-detail').on('click', function() {
		$('.prodetail-detail-page').hide();
		$(this).hide();
		$('.prodetail-show-detail').show();
	});

	// 색상 선택 시 수량 입력란을 보이게 하고 초기화합니다.
	$('.prodetail-color').on('change', function() {
		$('.prodetail-quantity-container').show();
		$('.prodetail-quantity').val(0);
		$('#totalPrice').val(0);
		updateTotalPrice();
	});

	// 수량 체크 및 총 구매 금액 업데이트
	$('.prodetail-quantity').on('change', function() {
		if ($(this).val() < 1) {
			$(this).val(0);
		}
		updateTotalPrice();
	});

	// 총 구매 금액 계산
	function updateTotalPrice() {
		var quantity = $('.prodetail-quantity').val();
		var price = ${price}; // 상품 가격, 변경 가능
		var totalPrice = quantity * price;
		$('.prodetail-total-price h2').text('총 구매 금액: ' + totalPrice + '원');
		//컬러와 총 구매금액을 각가의 hidden 필드에 설정
		$('#totalPrice').val(totalPrice);
		$('#selected-color').val($('.prodetail-color').val());
	}
});
</script>

</body>
</html>
