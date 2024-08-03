<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var='root' value='${pageContext.request.contextPath}'/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 현황</title>
    <link rel="stylesheet" href="${root}/css/admin.css">
    <style>
        .hidden { display: none; }
        .chart-container { display: flex; justify-content: center; width: 75%; margin: 50px auto 0; gap: 20px; margin-top: 0px; }
        .chart-box { flex: 1; display: flex; flex-direction: column; align-items: center; padding: 20px; border: 1px solid #ccc; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .chart-box h2 { margin-bottom: 20px; font-size: 25px; }
        #productChart, #bar-chart { width: 100%; height: 400px; }
        .table-container { width: 80%; padding: 120px; margin: auto; }
        table, th, td { border: 1px solid black; border-collapse: collapse; padding: 5px; }
    </style>
    <script src="https://d3js.org/d3.v6.min.js"></script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/admin/sidebar.jsp" />
    <main class="main-content">
        <header class="navbar">
            <h1>주문 현황</h1>
            <div class="user-menu">
                <span>환영합니다, 관리자님</span>
            </div>
        </header>
        <div class="details donationdetail">
            <div class="chart-container">
                <div class="chart-box">
                    <h2>제품별 판매 금액</h2>
                    <svg id="productChart"></svg>
                </div>
                <div class="chart-box">
                    <h2>사용자별 구매 금액</h2>
                    <svg id="bar-chart"></svg>
                </div>
            </div>
            <div class="form-flex-box chartbox">
                <input type="text" id="search-product" placeholder="검색..." oninput="filterTable('details-content-product', this.value)" />
            </div>
            <form id="productForm" method="post" action="${root}/admin/updateProduct" enctype="multipart/form-data">
                <div id="details-content-product">
                    <table class="menubar" data-type="상품">
                        <thead class="menuthead">
                            <tr>
                                <th class="left"><button type="button" class="sort-button" data-column="0">유저 아이디</button></th>
                                <th><button type="button" class="sort-button" data-column="1">이름</button></th>
                                <th><button type="button" class="sort-button" data-column="2">구매 상품</button></th>
                                <th><button type="button" class="sort-button" data-column="3">구매 가격</button></th>
                                <th><button type="button" class="sort-button" data-column="4">주문 날짜</button></th>
                                <th><input type="checkbox" id="select-all" /> 선택</th>
                            </tr>            
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orderlist}">
                                <tr>
                                    <td>${order.userID}</td>
                                    <c:forEach var="member" items="${memberlist}">
                                        <c:if test="${member.userID == order.userID}">
                                            <td>${member.name}</td>
                                        </c:if>
                                    </c:forEach>
                                    <c:forEach var="product" items="${proudctlist}">
                                        <c:if test="${order.productID == product.productID}">
                                            <td>${product.product_name}</td>
                                            <td>${order.quantity * product.price}</td>
                                            <td>${order.orderDate}</td>
                                            <td class="sort-button2" ><input type="checkbox" class="select-row" name="selectedProducts" value="${product.productID}" /></td>
                                        </c:if>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </form>
        </div>
        <script>
        document.addEventListener("DOMContentLoaded", function() {
            const width = 400;
            const height = 300;
            const outerRadius = height / 2 - 10;
            const innerRadius = outerRadius * 0.5;
            const color = d3.scaleOrdinal(d3.schemeCategory10);

            const svg = d3.select("#productChart")
                .attr("viewBox", [-width / 2, -height / 2, width, height]);

            const arc = d3.arc()
                .innerRadius(innerRadius)
                .outerRadius(outerRadius);

            const pie = d3.pie().sort(null).value(d => d.total_amount);

            function updatePieChart(data) {
                const pieData = pie(data);
                const arcs = svg.selectAll(".arc")
                    .data(pieData);

                const gEnter = arcs.enter().append("g")
                    .attr("class", "arc");

                gEnter.append("path")
                    .attr("fill", (d, i) => color(i))
                    .attr("d", arc)
                    .each(function(d) { this._current = d; });

                gEnter.append("text")
                    .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
                    .attr("dy", "0.35em")
                    .attr("text-anchor", "middle")
                    .attr("font-size", "14px")
                    .attr("fill", "#fff")
                    .text(d => d.data.name);

                arcs.select("path")
                    .transition()
                    .duration(750)
                    .attrTween("d", function(d) {
                        const i = d3.interpolate(this._current, d);
                        this._current = i(0);
                        return t => arc(i(t));
                    });

                arcs.select("text")
                    .transition()
                    .duration(750)
                    .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
                    .text(d => d.data.name);

                arcs.exit().remove();
            }

            const initialData = [
                { name: '상품1', total_amount: 0 },
                { name: '상품2', total_amount: 0 }
            ];
            updatePieChart(initialData);

            function updateBarChart(data) {
                const width = 400;
                const height = 300;
                const margin = { top: 20, right: 20, bottom: 30, left: 40 };

                const svg = d3.select("#bar-chart")
                    .attr("width", width)
                    .attr("height", height)
                    .attr("viewBox", [0, 0, width, height])
                    .attr("style", "max-width: 100%; height: auto;");

                svg.selectAll("*").remove();

                const x = d3.scaleBand()
                    .domain(data.map(d => d.userName))
                    .range([margin.left, width - margin.right])
                    .padding(0.1);

                const y = d3.scaleLinear()
                    .domain([0, d3.max(data, d => d.total_amount)]).nice()
                    .range([height - margin.bottom, margin.top]);

                const backgroundColors = data.map(d => d.color || 'steelblue');

                svg.append("g")
                    .selectAll("rect")
                    .data(data)
                    .join("rect")
                    .attr("x", d => x(d.userName))
                    .attr("y", d => y(d.total_amount))
                    .attr("height", d => y(0) - y(d.total_amount))
                    .attr("width", x.bandwidth())
                    .attr("fill", (d, i) => backgroundColors[i]);

                svg.append("g")
                    .attr("class", "x-axis")
                    .attr("transform", `translate(0,${height - margin.bottom})`)
                    .call(d3.axisBottom(x).tickSize(0).tickPadding(6))
                    .selectAll("text")
                    .attr("font-size", "12px");

                svg.append("g")
                    .attr("class", "y-axis")
                    .attr("transform", `translate(${margin.left},0)`)
                    .call(d3.axisLeft(y).tickFormat(d3.format(".2s")))
                    .selectAll("text")
                    .attr("font-size", "12px");
            }

            function updateCharts() {
                const selectedRows = document.querySelectorAll('tbody tr input.select-row:checked');
                const pieChartData = [];
                const barChartData = {};

                selectedRows.forEach(function(checkbox) {
                    const row = checkbox.closest('tr');
                    const name = row.querySelector('td:nth-child(3)').innerText;
                    const userName = row.querySelector('td:nth-child(2)').innerText;
                    const totalAmount = parseFloat(row.querySelector('td:nth-child(4)').innerText);

                    const existingProduct = pieChartData.find(d => d.name === name);
                    if (existingProduct) {
                        existingProduct.total_amount += totalAmount;
                    } else {
                        pieChartData.push({ name: name, total_amount: totalAmount });
                    }

                    if (barChartData[userName] !== undefined) {
                        barChartData[userName].total_amount += totalAmount;
                    } else {
                        barChartData[userName] = { userName: userName, total_amount: totalAmount, color: color(userName) };
                    }
                });

                updatePieChart(pieChartData);

                const barChartArrayData = Object.values(barChartData);
                updateBarChart(barChartArrayData);
            }

            document.querySelectorAll('tbody tr input.select-row').forEach(function(checkbox) {
                checkbox.addEventListener('change', updateCharts);
            });

            document.getElementById('select-all').addEventListener('change', function(event) {
                const isChecked = event.target.checked;
                document.querySelectorAll('tbody tr input.select-row').forEach(function(checkbox) {
                    checkbox.checked = isChecked;
                });
                updateCharts();
            });

            window.filterTable = function(containerId, query) {
                const table = document.getElementById(containerId).querySelector("table");
                const rows = table.querySelectorAll("tbody tr");

                rows.forEach(function(row) {
                    const cells = row.querySelectorAll("td");
                    const match = Array.from(cells).some(function(cell) {
                        return cell.innerText.toLowerCase().includes(query.toLowerCase());
                    });
                    row.style.display = match ? "" : "none";
                });
            };
        });
        </script>
    </main>
</body>
</html>
