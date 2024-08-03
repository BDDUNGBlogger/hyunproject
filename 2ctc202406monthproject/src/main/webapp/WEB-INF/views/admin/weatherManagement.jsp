<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
   <jsp:include page="/WEB-INF/views/admin/sidebar.jsp" />
<title>날씨 관리</title>

<link rel="stylesheet" href="${root}css/admin.css">
<script defer src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script defer src="${root}js/common.js"></script>
<script defer src="${root}js/weatherManagement.js"></script>
</head>
<body>
    <div class="container">
        <aside class="sidebar">
            <h2>관리자</h2>
            <ul>
                <li><a href="${root}admin.jsp">대시보드</a></li>
                <li class="menu-item">
                    <a href="#">날씨 관리</a>
                    <ul class="submenu">
                        <li><a href="${root}admin/weatherManagement.jsp?type=temperature">기온</a></li>
                        <li><a href="${root}admin/weatherManagement.jsp?type=seaLevel">해수면 상승</a></li>
                        <li><a href="${root}admin/weatherManagement.jsp?type=precipitation">강수량</a></li>
                        <li><a href="${root}admin/weatherManagement.jsp?type=seaTemperature">해수면 온도</a></li>
                    </ul>
                </li>
                <!-- 다른 메뉴 항목들 추가 -->
            </ul>
        </aside>
        <main class="main-content">
            <header class="navbar">
                <h1>관리자 대시보드</h1>
                <div class="user-menu">
                    <span>환영합니다, 관리자님</span>
                    <img src="${root}images/user-avatar.png" alt="사용자 아바타">
                </div>
            </header>
            <section class="content active">
                <h2>날씨 관리 - ${param.type}</h2>
                <div class="details">
                    <input type="text" id="search-${param.type}" placeholder="검색..." oninput="filterTable('details-content-${param.type}', this.value)">
                    <div id="details-content-${param.type}"></div>
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-chart-area me-1"></i> ${param.type} 변화 차트
                        </div>
                        <div class="card-body">
                            <canvas class="mb-0" id="${param.type}AreaChart" width="100%" height="40"></canvas>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </div>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var type = "${param.type}";
            if (type === "temperature") {
                initializeTemperatureChart();
            } else if (type === "seaLevel") {
                initializeSeaLevelChart();
            } else if (type === "precipitation") {
                initializePrecipitationChart();
            } else if (type === "seaTemperature") {
                initializeSeaTemperatureChart();
            }
        });
    </script>
</body>
</html>
