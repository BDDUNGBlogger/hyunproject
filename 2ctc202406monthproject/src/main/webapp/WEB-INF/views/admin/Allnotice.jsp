<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var='root' value='${pageContext.request.contextPath}/'/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>모든 게시물</title>
    <link rel="stylesheet" href="${root}css/admin.css">
    <style>
        .hidden { display: none; }
        .noticeboard {
            margin-top: 5%;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/admin/sidebar.jsp" />
    <main class="main-content">
        <header class="navbar">
            <h1>모든 게시물</h1>
            <div class="user-menu">
                <span>환영합니다, 관리자님</span>
            </div>
        </header>
        <div class="details">
            <input type="text" id="search-all-posts" placeholder="검색..." oninput="filterTable('details-content-posts', this.value)" />
            <form id="newsForm" method="post" action="${root}admin/Board/update/Allnotice">
                <div id="details-content-posts">
                    <h3>게시물 목록</h3>
                    <table class="menubar" data-type="게시물">
                        <thead class="menuthead">
                            <tr>
                                <th class="left"><button class="sort-button" data-column="0">게시물 ID</button></th>
                                <th><button class="sort-button" data-column="1">제목</button></th>
                                <th><button class="sort-button" data-column="2">카테고리</button></th>
                                <th><button class="sort-button" data-column="3">작성자</button></th>
                                <th><button class="sort-button" data-column="4">작성일</button></th>
                                <th>선택</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="board" items="${boardList}">
                                <c:forEach var="info" items="${boarinfoList}">
                                    <c:if test="${info.board_IDX == board.board_IDX}">
                                        <tr class="${info.board_info_Nm == '공지사항' ? 'notice-row' : ''}">
                                            <td class="root"><a href="${root}board/read?board_IDX=${board.board_IDX}&noticeID=${board.noticeID}">${board.noticeID}</a></td>
                                            <td class="editable">
                                                <span>${board.title}</span>
                                                <input type="text" name="title_${board.noticeID}" value="${board.title}" style="display: none;" />
                                            </td>
                                            <td>${info.board_info_Nm}</td>
                                            <td>${board.writerID}</td>
                                            <td>${board.create_date}</td>
                                            <td><input type="checkbox" class="select-row" name="selectedNotices" value="${board.noticeID}" /></td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="form-flex-box">
                    <button type="button" class="soojung">수정</button>
                    <button type="submit" class="OK" style="display: none;">확인</button>
                    <button type="button" class="delete">삭제</button>
                </div>
            </form>
        </div>
    </main>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 수정 버튼 이벤트 리스너
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
                } else {
                    var deleteForm = document.createElement('form');
                    deleteForm.method = 'post';
                    deleteForm.action = '${root}admin/Board/delete/Allnotice';
                    selectedRows.forEach(function (checkbox) {
                        var input = document.createElement('input');
                        input.type = 'hidden';
                        input.name = 'selectedNotices';
                        input.value = checkbox.value;
                        deleteForm.appendChild(input);
                    });
                    document.body.appendChild(deleteForm);
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

        // 공지사항이 위로 오도록 테이블 정렬
        var table = document.querySelector("table.menubar tbody");
        var rows = Array.from(table.rows);
        rows.sort(function(a, b) {
            var aIsNotice = a.classList.contains('notice-row');
            var bIsNotice = b.classList.contains('notice-row');
            return aIsNotice === bIsNotice ? 0 : aIsNotice ? -1 : 1;
        });
        rows.forEach(function(row) {
            table.appendChild(row);
        });
    });
</script>
</body>
</html>
