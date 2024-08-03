<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <style>
        .menubar { width: 100%; border-collapse: collapse; }
        .menuthead { background-color: #f4f4f4; }
        .left { text-align: left; }
        .sort-button { background: none; border: none; cursor: pointer; color: blue; text-decoration: underline; }
        .card { display: inline-block; margin: 10px; padding: 10px; border: 1px solid #ccc; cursor: pointer; }
    </style>
</head>
<body>
    <div id="dashboard-menu">
        <button data-type="새로운 게시물" class="card">새로운 게시물</button>
        <button data-type="회원" class="card">회원</button>
        <button data-type="진행 중인 캠페인" class="card">진행 중인 캠페인</button>
        <button data-type="등록된 상품" class="card">등록된 상품</button>
        <button id="dashboard-button" class="card">대시보드</button>
    </div>
    <div id="details" style="display:none;">
        <div id="details-content"></div>
    </div>
    <div id="dashboard-content">
        <!-- 대시보드 내용 -->
        <h2>대시보드</h2>
        <p>여기에 대시보드 내용을 추가하세요.</p>
    </div>

    <script src="path/to/adminboard.js"></script>
</body>
</html>
