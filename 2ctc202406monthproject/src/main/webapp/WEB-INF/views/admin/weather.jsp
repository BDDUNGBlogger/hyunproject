<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='root' value='${pageContext.request.contextPath}/'/>
   
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>기업소식</title>
    <link rel="stylesheet" href="${root}css/admin.css">
    <style>
        .hidden { display: none; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/sidebar.jsp" />
<h2>기업 소식</h2>
<div class="details">
    <input type="text" id="search-environment" placeholder="검색..." oninput="filterTable('details-content-environment', this.value)" />
    <form id="newsForm" method="post" action="${root}admin/Board/update/news">
        <div id="details-content-environment">
            <table class="menubar" data-type="환경">
                <thead class="menuthead">
                    <tr>
                        <th class="left"><button type="button" class="sort-button" data-column="0">캠페인 ID</button></th>
                        <th><button type="button" class="sort-button" data-column="1">유저아이디</button></th>
                        <th><button type="button" class="sort-button" data-column="2">제목</button></th>
                        <th><button type="button" class="sort-button" data-column="3">내용</button></th>
                        <th><button type="button" class="sort-button" data-column="4">시작일</button></th>
                        <th><button type="button" class="sort-button" data-column="5">종료일</button></th>
                        <th>선택</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="boardNews" items="${boardNews}">
                        <tr>
                            <td class="root"><a href="${root}board/main">${boardNews.noticeID}</a></td>
                            <td class="editable">
                                <span>${boardNews.writerID}</span>
                                <input type="text" name="title_${boardNews.noticeID}" value="${boardNews.writerID}" style="display: none;" />
                            </td>
                            <td class="editable">
                                <span>${boardNews.title}</span>
                                <input type="text" name="status_${boardNews.noticeID}" value="${boardNews.title}" style="display: none;" />
                            </td>
                            <td class="editable">
                                <span>${boardNews.content_text}</span>
                                <input type="text" name="status_${boardNews.noticeID}" value="${boardNews.content_text}" style="display: none;" />
                            </td>
                            <td>${boardNews.create_date}</td>
                            <td>${boardNews.last_update}</td>
                            <td><input type="checkbox" class="select-row" name="selectedNotices" value="${boardNews.noticeID}" /></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </form>
    <div class="form-flex-box">
        <button type="button" class="soojung">수정</button> 
        <button type="submit" form="newsForm" class="OK" style="display: none;">확인</button>
        <form method="post" action="${root}/admin/delete/news">
            <button type="submit" class="delete">삭제</button>
        </form>
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

        document.querySelector('.delete').addEventListener('click', function (event) {
            var selectedRows = document.querySelectorAll('tbody tr input.select-row:checked');
            if (selectedRows.length > 0) {
                var confirmed = confirm('정말 삭제하시겠습니까?');
                if (!confirmed) {
                    event.preventDefault();
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
