<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var='root' value='${pageContext.request.contextPath}/'/>
<!DOCTYPE html>
<html lang="ko">
<head>                        
    <meta charset="UTF-8">
    <title>동물 캠페인 관리</title>
    <link rel="stylesheet" href="${root}/css/admin.css">
    <style>
        .hidden { display: none; }
    </style>
</head>
<body>
   <jsp:include page="/WEB-INF/views/admin/sidebar.jsp" />
    <main class="main-content">
        <header class="navbar">
            <h1>동물 캠페인 관리</h1>
            <div class="user-menu">
                <span>환영합니다, 관리자님</span>
            </div>
        </header>
        <div class="details">
            <input type="text" id="search-animals" placeholder="검색..." oninput="filterTable('details-content-animals', this.value)" />
            <form id="animalsForm" method="post" action="${root}admin/campaign/update/animals">
                <div id="details-content-animals">
                    <table class="menubar" data-type="동물">
                        <thead class="menuthead">
                            <tr>
                                <th class="left"><button class="sort-button" data-column="0">캠페인</button></th>
                                <th><button class="sort-button" data-column="1">카테고리</button></th>
                                <th><button class="sort-button" data-column="2">제목</button></th>
                                <th><button class="sort-button" data-column="3">주체</button></th>
                                <th><button class="sort-button" data-column="4">현재 모금된 금액</button></th>
                                <th><button class="sort-button" data-column="5">목표금액</button></th>
                                <th><button class="sort-button" data-column="6">시작일</button></th>
                                <th><button class="sort-button" data-column="7">종료일</button></th>
                                <th><button class="sort-button" data-column="8">기부한 사람의 수</button></th>
                                <th>선택</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="campaign" items="${animalCamlist}">
                                <tr>
                                    <td class="root"><a href="${root}campaign/campaignDetail?campaignID=${campaign.campaignID}">
                                    <img src="${root}upload/${campaign.cam_img}" alt="${campaign.campaignID}" style="width: 100px; height: auto;"></a></td>
                                    <td class="editable">
                                        <span>${campaign.category}</span>
                                        <select name="category_${campaign.campaignID}" style="display: none;">
                                            <option value="환경" <c:if test="${campaign.category == '환경'}">selected</c:if>>환경</option>
                                            <option value="동물" <c:if test="${campaign.category == '동물'}">selected</c:if>>동물</option>
                                        </select>
                                    </td>
                                    <td class="editable">
                                        <span>${campaign.cam_title}</span>
                                        <input type="text" name="cam_title_${campaign.campaignID}" value="${campaign.cam_title}" style="display: none;" />
                                    </td>
                                    <td class="editable">
                                        <span>${campaign.cam_host}</span>
                                        <input type="text" name="cam_host_${campaign.campaignID}" value="${campaign.cam_host}" style="display: none;" />
                                    </td>
                                    <td class="editable">
                                     <span><fmt:formatNumber value="${campaign.current_amount}" type="currency" currencySymbol="₩"/></span>
                                        <input type="text" name="current_amount_${campaign.campaignID}" value="${campaign.current_amount}" style="display: none;" />
                                    </td>
                                    <td class="editable">
                                        <span><fmt:formatNumber value="${campaign.goal_amount}" type="currency" currencySymbol="₩"/></span>
                                        <input type="text" name="goal_amount_${campaign.campaignID}" value="${campaign.goal_amount}" style="display: none;" />
                                    </td>
                                    <td class="editable">
                                        <span><fmt:formatDate value="${campaign.start_date}" pattern="yyyy-MM-dd" /></span>
                                        <input type="date" name="start_date_${campaign.campaignID}" value="<fmt:formatDate value='${campaign.start_date}' pattern='yyyy-MM-dd' />" style="display: none;" />
                                    </td>
                                    <td class="editable">
                                        <span><fmt:formatDate value="${campaign.end_date}" pattern="yyyy-MM-dd" /></span>
                                        <input type="date" name="end_date_${campaign.campaignID}" value="<fmt:formatDate value='${campaign.end_date}' pattern='yyyy-MM-dd' />" style="display: none;" />
                                    </td>
                                    <td>${campaign.donor_count}</td>
                                    <td><input type="checkbox" class="select-row" name="selectedNotices" value="${campaign.campaignID}" /></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </form>
            <div class="form-flex-box">
                <button type="button" class="soojung">수정</button>
                <button type="submit" form="animalsForm" class="OK" style="display: none;">확인</button>
                <form id="deleteanimal" method="post" action="${root}admin/campaign/delete/animals">
                    <button type="submit" class="delete">삭제</button>
                </form>
            </div>
        </div>
    </main>
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
                    var spanElement = cell.querySelector('span');
                    var inputElement = cell.querySelector('input, select');
                    if (spanElement && inputElement) {
                        spanElement.style.display = 'none';
                        inputElement.style.display = 'inline-block';
                    }
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
                } else {
                    document.getElementById('animalsForm').submit();
                }
            }
        });

        document.querySelector('.delete').addEventListener('click', function (event) {
            var selectedRows = document.querySelectorAll('tbody tr input.select-row:checked');
            if (selectedRows.length > 0) {
                var confirmed = confirm('정말 삭제하시겠습니까?');
                if (!confirmed) {
                    event.preventDefault();
                } else {
                    var deleteForm = document.getElementById('deleteanimal');
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
</body>
</html>
