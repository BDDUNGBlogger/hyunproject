<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value="${pageContext.request.contextPath}/" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>해수면 상승 관리</title>
    <link rel="stylesheet" href="${root}css/admin.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .chart-container {
            width: 70%;
            height: 400px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        #seaLevelBarChart {
            width: 80%;
            height: 300px;
        }
        .table-container {
            width: 100%;
            padding: 20px;
        }
        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
            padding: 5px;
        }
        .temp-flex {
            display: flex;
            justify-content: center;
            margin-bottom: 5%;
        }
        .soojung-box {
            display: flex;
            justify-content: right;
            padding: 20px 0 0 0;
        }
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const ctx = document.getElementById('seaLevelBarChart').getContext('2d');
            const initialData = {
                labels: [],
                datasets: [{
                    label: '해수면 높이',
                    data: [],
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1,
                    fill: true
                }]
            };

            const seaLevelBarChart = new Chart(ctx, {
                type: 'bar',
                data: initialData,
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            document.querySelector('.update-chart').addEventListener('click', function () {
                var selectedRows = document.querySelectorAll('tbody tr input[type="checkbox"]:checked');
                var chartData = [];

                selectedRows.forEach(function (checkbox) {
                    var row = checkbox.closest('tr');
                    var city = row.cells[1].innerText;
                    var year = row.cells[2].innerText;
                    var label = city + ' ' + year;
                    var seaLevel = parseFloat(row.cells[3].innerText);
                    chartData.push({ label: label, seaLevel: seaLevel });
                });

                updateChart(chartData);
            });

            function updateChart(data) {
                const labels = data.map(d => d.label);
                const seaLevels = data.map(d => d.seaLevel);

                seaLevelBarChart.data.labels = labels;
                seaLevelBarChart.data.datasets[0].data = seaLevels;
                seaLevelBarChart.update();
            }

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
            };
        });
    </script>
</head>
<body>
 <jsp:include page="/WEB-INF/views/admin/sidebar.jsp" />
 <main class="main-content">
        <header class="navbar">
            <h1>해수면 상승 관리</h1>
            <div class="user-menu">
                <span>환영합니다, 관리자님</span>
            </div>
        </header>
<div class="details">
    <div class="temp-flex">
        <div class="chart-container">
            <canvas id="seaLevelBarChart"></canvas>
        </div>
    </div>
    <div class="soojung-box">
        <button class="update-chart">차트 업데이트</button>
    </div>
    <input type="text" id="search-sea-level" placeholder="검색..." oninput="filterTable('details-content-sea-level', this.value)">
    <div id="details-content-sea-level">
        <table class="menubar" data-type="해수면 상승">
            <thead class="menuthead">
                <tr>
                    <th class="left"><button class="sort-button" data-column="0">기록 ID</button></th>
                    <th><button class="sort-button" data-column="1">도시</button></th>
                    <th><button class="sort-button" data-column="2">년도</button></th>
                    <th><button class="sort-button" data-column="3">해수면 높이</button></th>
                    <th>선택</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ocean" items="${seaLevel}">
                    <tr>
                        <td>${ocean.ofsweatherID}</td>
                        <td>${ocean.city}</td>
                        <td>${ocean.years}</td>
                        <td>${ocean.figures}</td>
                        <td><input type="checkbox" /></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
