<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>

<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

<link href="${root}css/top_menu.css" rel="stylesheet"/>
<link href="${root}css/bottom_info.css" rel="stylesheet"/>
<link href="${root}css/productList.css" rel="stylesheet"/>
<!-- 상점 제목 폰트 바꾸기(구글웹폰트) -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
</head>
<body>

<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>
   
<!-- 지구 상점 제목 -->
<div class="prolist-title-container" style="margin-top: 100px">
    <h1>지구 상점</h1>   
</div>
<hr />

<div class="prolist-container" style="margin-top: 50px">
    <div class="prolist-box">
        <c:forEach var="product" items="${products}">
            <div class="prolist-item">
                <div class="prolist-image">
                    <form:form method="Post" action="${root}product/productdetail">
                        <input type="hidden" name="product_name" value="${product.product_name}" />
                        <input type="hidden" name="productID" value="${product.productID}" />
                        <input type="hidden" name="price" value="${product.price}" />
                        <input type="hidden" name="product_img" value="${product.product_img}" />
                        <button type="submit" style="border: none; background: none; padding: 0; outline: none;">
                            <img src="${root}upload/${product.product_img}" alt="${product.product_name}" style="cursor: pointer;" />
                        </button>
                    </form:form>
                </div>
                <div class="prolist-content">
                    <form:form method="post" action="${root}product/cart_pro">
                        <input type="hidden" name="productID" value="${product.productID}" />
                        <input type="hidden" name="quantity" value="1" />
                        <input type="hidden" name="price" value="${product.price}" />
                        <input type="hidden" name="product_name" value="${product.product_name}" />
                        <button type="submit" style="border: none; background: none; padding: 0;">
                            <img src="${root}upload/carticon.jpg" alt="장바구니" style="cursor: pointer;" />
                        </button>
                    </form:form>
                    <h3>${product.product_name}</h3>
                    <p>${product.price}원</p>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- 페이지 표시 영역 -->
<div class="prolist-page-count">
    <button class="prolist-prevBtn" id="prevBtn"><</button>
    <button class="prolist-pageNumbers" id="currentPage">1</button>
    <button class="prolist-nextBtn" id="nextBtn">></button>
</div>

<!-- 하단메뉴 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>

<script>
    // 페이지 표시
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');
    const currentPageElement = document.getElementById('currentPage');
    
    let currentPage = 1; // 현재 페이지
    
    // 이전 페이지로 이동
    prevBtn.addEventListener('click', () => {
        if (currentPage > 1) {
            currentPage--;
            updatePage();
        }
    });
    
    // 다음 페이지로 이동
    nextBtn.addEventListener('click', () => {
        const totalPages = 5; // 총 페이지 수
        if (currentPage < totalPages) {
            currentPage++;
            updatePage();
        }
    });
    
    // 페이지 업데이트
    function updatePage() {
        currentPageElement.textContent = currentPage;
    }
    
    // 페이지 로딩 시 초기 페이지로 백업
    updatePage();
</script>
</body>
</html>
