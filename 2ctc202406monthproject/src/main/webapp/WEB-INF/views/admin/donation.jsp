<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var='root' value='${pageContext.request.contextPath}/'/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>후원 관리</title>
    <link rel="stylesheet" href="${root}/css/admin.css">
    <style>
        .hidden { display: none; }
        .chart-container { display: flex; justify-content: center; width: 75%; margin: 50px auto 0; gap: 20px; margin-top: 0px;}
        .chart-box { flex: 1; display: flex; flex-direction: column; align-items: center; padding: 20px; border: 1px solid #ccc; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .chart-box h2 { margin-bottom: 20px; }
        #donationStatisticsChart, #bar-chart { width: 100%; height: 400px; }
        .table-container { width: 80%; padding: 120px; margin: auto; }
        table, th, td { border: 1px solid black; border-collapse: collapse; padding: 5px; }
    </style>
    <script src="https://d3js.org/d3.v6.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/admin/sidebar.jsp"/>
    <main class="main-content">
        <header class="navbar">
            <h1>후원 관리</h1>
            <div class="user-menu">
                <span>환영합니다, 관리자님</span>
            </div>
        </header>
        <div class="details donationdetail">
            <div class="chart-container">
                <div class="chart-box">
                    <h2>카테고리별 후원 금액</h2>
                    <svg id="donationStatisticsChart"></svg>
                </div>
                <div class="chart-box">
                    <h2>캠페인별 후원 금액</h2>
                    <svg id="bar-chart"></svg>
                </div>
            </div>
            <div class="form-flex-box chartbox">
                <input type="text" id="search-donation" placeholder="검색..." oninput="filterTable('details-content-donation', this.value)"/>
            </div>
            <form method="post" id="updateForm" action="${root}admin/donation/update">
                <div id="details-content-donation">
                    <table class="menubar" data-type="후원">
                        <thead class="menuthead">
                            <tr>
                                <th class="left"><button type="button" class="sort-button" data-column="0">캠페인 ID</button></th>
                                <th><button type="button" class="sort-button" data-column="1">유저 ID</button></th>
                                <th><button type="button" class="sort-button" data-column="2">카테고리</button></th>
                                <th><button type="button" class="sort-button" data-column="3">익명 여부</button></th>
                                <th><button type="button" class="sort-button" data-column="4">후원 금액</button></th>
                                <th><button type="button" class="sort-button" data-column="5">후원 날짜</button></th>
                                <th><button type="button" class="sort-button" data-column="6">결제 방법</button></th>
                                <th><input type="checkbox" id="select-all" /> 선택</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="campaign" items="${campaignList}">
                                <c:forEach var="donation" items="${donationBeanList}">
                                    <c:if test="${donation.campaignID == campaign.campaignID}">
                                        <tr>
                                            <td class="root"><a href="${root}campaign/campaignDetail?campaignID=${campaign.campaignID}">${campaign.campaignID}</a></td>
                                            <td><span>${donation.userID}</span></td>
                                            <td><span>${campaign.category}</span></td>
                                            <td class="editable"><span>${donation.anonymous}</span> <input type="text" name="anonymous_${donation.donationID}" value="${donation.anonymous}" style="display: none;"/></td>
                                            <td class="editable"><span><fmt:formatNumber value="${donation.cam_amount}" type="currency" currencySymbol="₩"/></span> <input type="text" name="cam_amount_${donation.donationID}" value="${donation.cam_amount}" style="display: none;"/></td>
                                            <td>${donation.donation_date}</td>
                                            <td class="editable"><span>${donation.payment_method}</span> <input type="text" name="payment_method_${donation.donationID}" value="${donation.payment_method}" style="display: none;"/></td>
                                            <td><input type="hidden" name="donationID_${donation.donationID}" value="${donation.donationID}"/> <input type="hidden" name="campaignID_${donation.donationID}" value="${donation.campaignID}"/> <input type="checkbox" class="select-row" name="selectedDonations" value="${donation.donationID}"/></td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
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

    const svg = d3.select("#donationStatisticsChart")
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
            .attr("font-size", "12px")
            .attr("fill", "#fff")
            .text(d => d.data.category);

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
            .text(d => d.data.category);

        arcs.exit().remove();
    }

    function getColor(index) {
        const colors = ['skyblue', 'steelblue', 'orange', 'green', 'purple', 'red', 'yellow'];
        return colors[index % colors.length];
    }

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
            .domain(data.map(d => d.campaignID))
            .range([margin.left, width - margin.right])
            .padding(0.1);

        const y = d3.scaleLinear()
            .domain([0, d3.max(data, d => d.total_amount)]).nice()
            .range([height - margin.bottom, margin.top]);

        const backgroundColors = data.map((_, i) => getColor(i));

        svg.append("g")
            .selectAll("rect")
            .data(data)
            .join("rect")
            .attr("x", d => x(d.campaignID))
            .attr("y", d => y(d.total_amount))
            .attr("height", d => y(0) - y(d.total_amount))
            .attr("width", x.bandwidth())
            .attr("fill", (d, i) => backgroundColors[i]);

        svg.append("g")
            .attr("class", "x-axis")
            .attr("transform", `translate(0,${height - margin.bottom})`)
            .call(d3.axisBottom(x));

        svg.append("g")
            .attr("class", "y-axis")
            .attr("transform", `translate(${margin.left},0)`)
            .call(d3.axisLeft(y));
    }

    function updateCharts() {
        const selectedRows = document.querySelectorAll('tbody tr input.select-row:checked');
        const pieChartData = [];
        const barChartData = {};

        selectedRows.forEach(function(checkbox) {
            const row = checkbox.closest('tr');
            const category = row.querySelector('td:nth-child(3) span').innerText;
            const campaignID = row.querySelector('td:nth-child(1) a').innerText;
            const camAmount = parseFloat(row.querySelector('input[name^="cam_amount_"]').value);

            const existingCategory = pieChartData.find(d => d.category === category);
            if (existingCategory) {
                existingCategory.total_amount += camAmount;
            } else {
                pieChartData.push({ category: category, total_amount: camAmount });
            }

            if (barChartData[campaignID] !== undefined) {
                barChartData[campaignID] += camAmount;
            } else {
                barChartData[campaignID] = camAmount;
            }
        });

        updatePieChart(pieChartData);

        const barChartArrayData = Object.keys(barChartData).map(key => ({
            campaignID: key,
            total_amount: barChartData[key]
        }));

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
