<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var='root' value='${pageContext.request.contextPath}/' />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>캠페인 관리</title>
<link rel="stylesheet" href="${root}css/admin.css">
<style>
.hidden {
    display: none;
}

.expired-campaign {
    margin-top: 5%;
}

.delete-but {
    justify-content: center;
    display: flex;
    width: 70px;
    height: 50px;
    background-color: rgb(255, 255, 255);
    align-items: center;
    border-radius: 5px;
    border: 1px solid rgb(210, 210, 210, 0.5);
    margin-top: 1%;
    margin-left: 95%;
}
</style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/admin/sidebar.jsp" />
    <main class="main-content">
        <header class="navbar">
            <h1>캠페인 관리</h1>
            <div class="user-menu">
                <span>환영합니다, 관리자님</span>
            </div>
        </header>
        <div class="details">
            <input type="text" id="search-campaign" placeholder="검색..."
                oninput="filterTable('details-content-campaign', this.value)" />
            <div id="details-content-campaign">
                <h3>진행 중인 캠페인</h3>
                <table class="menubar" data-type="캠페인">
                    <thead class="menuthead">
                        <tr>
                            <th class="left"><button type="button" class="sort-button"
                                    data-column="0">캠페인</button></th>
                            <th><button type="button" class="sort-button"
                                    data-column="1">주제</button></th>
                            <th><button type="button" class="sort-button"
                                    data-column="2">제목</button></th>
                            <th><button type="button" class="sort-button"
                                    data-column="3">주최</button></th>
                            <th><button type="button" class="sort-button"
                                    data-column="4">현재 모금된 금액</button></th>
                            <th><button type="button" class="sort-button"
                                    data-column="5">목표금액</button></th>
                            <th><button type="button" class="sort-button"
                                    data-column="6">시작일</button></th>
                            <th><button type="button" class="sort-button"
                                    data-column="7">종료일</button></th>
                            <th><button type="button" class="sort-button"
                                    data-column="8">기부한 사람의 수</button></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="campaign" items="${CampaignList}">
                            <c:if
                                test="${campaign.current_amount < campaign.goal_amount && campaign.end_date >= now}">
                                <tr data-end-date="${campaign.end_date}"
                                    data-current-amount="${campaign.current_amount}"
                                    data-goal-amount="${campaign.goal_amount}"
                                    data-donor-count="${campaign.donor_count}">
                                    <td class="root"><a
                                        href="${root}campaign/campaignDetail?campaignID=${campaign.campaignID}">
                                            <img src="${root}upload/${campaign.cam_img}"
                                            alt="${campaign.campaignID}"
                                            style="width: 100px; height: auto;">
                                    </a></td>
                                    
                                    <td>${campaign.category}</td>
                                    <td>${campaign.cam_title}</td>
                                    <td>${campaign.cam_host}</td>
                                    <td><fmt:formatNumber value="${campaign.current_amount}" type="currency" currencySymbol="₩"/></td>
                                    <td><fmt:formatNumber value="${campaign.goal_amount}"
                                            type="currency" currencySymbol="₩" /></td>
                                    <td>${campaign.start_date}</td>
                                    <td>${campaign.end_date}</td>
                                    <td>${campaign.donor_count}</td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div id="details-content-expired-campaign" class="expired-campaign">
                <input type="text" id="search-expired-campaign" placeholder="검색..."
                    oninput="filterTable('details-content-expired-campaign', this.value)" />
                <h3 style="color: red;">마감된 캠페인</h3>
                <form id="expiredCampaignForm" method="post" action="${root}admin/deleteallcampaign">
                    <table class="menubar" data-type="캠페인">
                        <thead class="menuthead">
                            <tr>
                                <th class="left"><button type="button" class="sort-button"
                                        data-column="0">캠페인 ID</button></th>
                                <th><button type="button" class="sort-button"
                                        data-column="1">주제</button></th>
                                <th><button type="button" class="sort-button"
                                        data-column="2">제목</button></th>
                                <th><button type="button" class="sort-button"
                                        data-column="3">주최</button></th>
                                <th><button type="button" class="sort-button"
                                        data-column="4">현재 모금된 금액</button></th>
                                <th><button type="button" class="sort-button"
                                        data-column="5">목표금액</button></th>
                                <th><button type="button" class="sort-button"
                                        data-column="6">시작일</button></th>
                                <th><button type="button" class="sort-button"
                                        data-column="7">종료일</button></th>
                                <th><button type="button" class="sort-button"
                                        data-column="8">기부한 사람의 수</button></th>
                                <th><button type="button" class="sort-button"
                                        data-column="9">선택</button></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="campaign" items="${CampaignList}">
                                <c:if
                                    test="${campaign.current_amount >= campaign.goal_amount || campaign.end_date < now}">
                                    <tr class="expired-campaign"
                                        data-end-date="${campaign.end_date}"
                                        data-current-amount="${campaign.current_amount}"
                                        data-goal-amount="${campaign.goal_amount}"
                                        data-donor-count="${campaign.donor_count}">
                                        <td class="root">
                                            <a href="${root}admin/${fn:trim(campaign.category) == '환경' ? 'environment' : (fn:trim(campaign.category) == '동물' ? 'animals' : fn:trim(campaign.category))}">
                                                <img src="${root}upload/${campaign.cam_img}" alt="${campaign.campaignID}" style="width: 100px; height: auto;">
                                            </a>
                                        </td>
                                        <td>${campaign.category}</td>
                                        <td>${campaign.cam_title}</td>
                                        <td>${campaign.cam_host}</td>
                                        <td><fmt:formatNumber value="${campaign.current_amount}" type="currency" currencySymbol="₩"/></td>
                                        <td><fmt:formatNumber value="${campaign.goal_amount}"
                                                type="currency" currencySymbol="₩" /></td>
                                        <td>${campaign.start_date}</td>
                                        <td>${campaign.end_date}</td>
                                        <td>${campaign.donor_count}</td>
                                        <td><input type="checkbox" name="selectedCampaigns" value="${campaign.campaignID}" /></td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                    <button type="button" class="delete delete-but">삭제</button>
                </form>
            </div>
        </div>
    </main>
</body>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const rows = document.querySelectorAll('tbody tr');

        rows.forEach(row => {
            const endDate = new Date(row.getAttribute('data-end-date'));
            const currentAmount = parseFloat(row.getAttribute('data-current-amount'));
            const goalAmount = parseFloat(row.getAttribute('data-goal-amount'));
            const now = new Date();

            if (endDate < now || currentAmount >= goalAmount) {
                row.classList.add('expired-campaign');
            }
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
        }

        document.querySelector('.delete').addEventListener('click', function (event) {
            const selectedRows = document.querySelectorAll('tbody tr input[name="selectedCampaigns"]:checked');
            const invalidCampaigns = [];
            
            selectedRows.forEach(function(checkbox) {
                const row = checkbox.closest('tr');
                const donorCount = parseInt(row.getAttribute('data-donor-count'), 10);
                if (donorCount > 0) {
                    invalidCampaigns.push(row.querySelector('.root a').innerText);
                }
            });

            if (invalidCampaigns.length > 0) {
                alert('다음 캠페인은 후원한 사람이 있어 삭제할 수 없습니다: ' + invalidCampaigns.join(', '));
                event.preventDefault();
                return;
            }

            if (selectedRows.length > 0) {
                const confirmed = confirm('정말 삭제하시겠습니까?');
                if (!confirmed) {
                    event.preventDefault();
                } else {
                    const deleteForm = document.getElementById('expiredCampaignForm');
                    selectedRows.forEach(function(checkbox) {
                        const input = document.createElement('input');
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
    });
</script>
</html>
