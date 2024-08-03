<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var='root' value='${pageContext.request.contextPath}'/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>등록된 상품</title>
    <link rel="stylesheet" href="${root}/css/admin.css">
    <style>
        .hidden { display: none; }
        
        .add {
            justify-content: center;
            display: flex;
            width: 70px;
            height: 50px;
            background-color: gray;
            align-items: center;
            border-radius: 5px;
            border: 1px solid rgb(210, 210, 210, 0.5);
        }
        
        .add2 {
            justify-content: center;
            display: flex;
            width: 70px;
            height: 50px;
            background-color: gray;
            align-items: center;
            border-radius: 5px;
            border: 1px solid rgb(210, 210, 210, 0.5);
        }
        
        .add3 {
            justify-content: center;
            display: flex;
            width: 70px;
            height: 50px;
            background-color: gray;
            align-items: center;
            border-radius: 5px;
            border: 1px solid rgb(210, 210, 210, 0.5);
        }
        
        .addbutton {
            display: flex;
            gap: 20px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/admin/sidebar.jsp" />
    <main class="main-content">
        <header class="navbar">
            <h1>등록된 상품</h1>
            <div class="user-menu">
                <span>환영합니다, 관리자님</span>
            </div>
        </header>   

        <div class="details">
            <input type="text" id="search-product" placeholder="검색..." oninput="filterTable('details-content-product', this.value)" />
            <form id="productForm" method="post" action="${root}/admin/updateProduct" enctype="multipart/form-data">
                <div id="details-content-product">
                    <table class="menubar" data-type="상품">
                        <thead class="menuthead">
                            <tr>
                                <th class="left"><button class="sort-button" data-column="0">상품</button></th>
                                <th><button class="sort-button" data-column="1">상품 이름</button></th>
                                <th><button class="sort-button" data-column="2">가격</button></th>
                                <th><button class="sort-button" data-column="3">수량</button></th>
                                <th><button class="sort-button" data-column="4">상태</button></th>
                                <th>선택</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${productlist}">
                                <tr>
                                    <td class="root">
                                        <a href="${root}/product/productdetail?product_name=${product.product_name}&productID=${product.productID}&price=${product.price}&product_img=${product.product_img}">
                                            <img src="${root}/upload/${product.product_img}" alt="${product.product_name}" style="width: 100px; height: auto;">
                                        </a>
                                    </td>
                                    <td class="editable">
                                        <span>${product.product_name}</span>
                                        <input type="text" name="product_name_${product.productID}" value="${product.product_name}" style="display: none;" />
                                    </td>
                                    <td class="editable">
                                           <span><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₩"/></span>
                                        <input type="text" name="price_${product.productID}" value="${product.price}" style="display: none;" />
                                    </td>
                                    <td class="editable">
                                        <span>${product.inventory}</span>
                                        <input type="text" name="inventory_${product.productID}" value="${product.inventory}" style="display: none;" />
                                    </td>
                                    <td class="editable">
                                        <span>${product.status}</span>
                                        <input type="text" name="status_${product.productID}" value="${product.status}" style="display: none;" />
                                    </td>
                                    <td><input type="checkbox" class="select-row" name="selectedProducts" value="${product.productID}" /></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </form>

            <form id="addProductForm" method="post" action="${root}/admin/addProduct" enctype="multipart/form-data" class="hidden">
                <h3>새 상품 추가</h3>
                <label for="newProductName">상품 이름:</label>
                <input type="text" id="newProductName" name="product_name" required>
                <label for="newProductPrice">가격:</label>
                <input type="text" id="newProductPrice" name="price" required>
                <label for="newProductInventory">수량:</label>
                <input type="text" id="newProductInventory" name="inventory" required>
                <label for="newProductStatus">상태:</label>
                <input type="text" id="newProductStatus" name="status" required>
                <label for="newProductImage">이미지:</label>
                <input type="file" id="newProductImage" name="upload_file" accept="upload/*" required>
                <div class="addbutton">
                    <button type="submit" class="add2">추가</button>
                    <button type="button" id="cancelAdd" class="add3">취소</button>
                </div>
            </form>

            <form id="deleteProductForm" method="post" action="${root}/admin/delete/product" class="hidden">
            </form>

            <div class="form-flex-box">
                <button type="button" class="soojung">수정</button>
                <button type="submit" form="productForm" class="OK" style="display: none;">확인</button>
                <button type="button" class="add">추가</button>
                <button type="button" class="delete">삭제</button>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                document.querySelector('.soojung').addEventListener('click', function () {
                    var selectedRows = document.querySelectorAll('tbody tr input.select-row:checked');
                    if (selectedRows.length === 0) {
                        alert('수정할 항목을 선택하세요.');
                        return;
                    }
                    selectedRows.forEach(function (checkbox) {
                        var row = checkbox.closest('tr');
                        row.querySelectorAll('.editable').forEach(function (cell) {
                            cell.querySelector('span').style.display = 'none';
                            cell.querySelector('input').style.display = 'inline-block';
                        });
                    });
                    document.querySelector('.OK').style.display = 'inline-block';
                    this.style.display = 'none';
                });

                document.querySelector('.OK').addEventListener('click', function (event) {
                    var selectedRows = document.querySelectorAll('tbody tr input.select-row:checked');
                    if (selectedRows.length > 0) {
                        var confirmed = confirm('수정하시겠습니까?');
                        if (!confirmed) {
                            event.preventDefault();
                        }
                    }
                });

                document.querySelector('.add').addEventListener('click', function () {
                    document.getElementById('addProductForm').classList.remove('hidden');
                    document.querySelector('.soojung').style.display = 'none';
                    document.querySelector('.add').style.display = 'none';
                    document.querySelector('.OK').style.display = 'none';
                });

                document.getElementById('cancelAdd').addEventListener('click', function () {
                    document.getElementById('addProductForm').classList.add('hidden');
                    document.querySelector('.soojung').style.display = 'inline-block';
                    document.querySelector('.OK').style.display = 'none';
                });

                document.querySelector('.delete').addEventListener('click', function (event) {
                    var selectedRows = document.querySelectorAll('tbody tr input.select-row:checked');
                    if (selectedRows.length > 0) {
                        var confirmed = confirm('정말 삭제하시겠습니까?');
                        if (!confirmed) {
                            event.preventDefault();
                        } else {
                            var deleteForm = document.getElementById('deleteProductForm');
                            selectedRows.forEach(function (checkbox) {
                                var input = document.createElement('input');
                                input.type = 'hidden';
                                input.name = 'selectedNotices';
                                input.value = checkbox.value;
                                deleteForm.appendChild(input);
                            });
                            deleteForm.submit();
                        }
                    } else {
                        alert('삭제할 항목을 선택하세요.');
                        event.preventDefault();
                    }
                });

                window.filterTable = function(containerId, query) {
                    var table = document.getElementById(containerId).querySelector("table");
                    var rows = table.querySelectorAll("tbody tr");

                    rows.forEach(function (row) {
                        var cells = row.querySelectorAll("td");
                        var match = Array.from(cells).some(function (cell) {
                            return cell.innerText.toLowerCase().includes(query.toLowerCase());
                        });
                        row.style.display = match ? "" : "none";
                    });
                }
            });
        </script>
    </main>
</body>
</html>
