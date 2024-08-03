<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var='root' value='${pageContext.request.contextPath}/'/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 관리</title>
    <link rel="stylesheet" href="${root}css/admin.css">
    <style>
        .hidden { display: none; }
    </style>
</head>
<body>
   <jsp:include page="/WEB-INF/views/admin/sidebar.jsp" />
    <main class="main-content">
        <header class="navbar">
            <h1>회원 관리</h1>
            <div class="user-menu">
                <span>환영합니다, 관리자님</span>
            </div>
        </header>
<div class="details">
    <input type="text" id="search-member" placeholder="검색..." oninput="filterTable('details-content-member', this.value)" />
    <div id="details-content-member">
        <form id="memberForm" method="post" action="${root}admin/member/update">
            <table class="menubar" data-type="회원">
                <thead class="menuthead">
                    <tr>
                        <th class="left"><button type="button" class="sort-button" data-column="0">회원 ID</button></th>
                        <th><button type="button" class="sort-button" data-column="1">이름</button></th>
                        <th><button type="button" class="sort-button" data-column="2">이메일</button></th>
                        <th><button type="button" class="sort-button" data-column="3">후원 금액</button></th>
                        <th><button type="button" class="sort-button" data-column="4">캠페인 참여 내역</button></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="memberDetails" items="${memberList}">
                        <tr>
                            <td>${memberDetails.userID}</td>
                            <td>${memberDetails.name}</td>
                            <td>${memberDetails.email}</td>
                            <td>
                                <c:set var="hasDonation" value="false" />
                                <c:forEach var="donation" items="${donationBeanList}">
                                    <c:if test="${memberDetails.userID == donation.userID}">
                                    <fmt:formatNumber value="${donation.cam_amount}" type="currency" currencySymbol="₩"/>
                                      <%--   ${donation.cam_amount} --%>
                                        <c:set var="hasDonation" value="true" />
                                    </c:if>
                                </c:forEach>
                                <c:if test="${hasDonation == 'false'}">X</c:if>
                            </td>
                            <td>
                            
                                <c:set var="hasCampaign" value="false" />
                                <c:forEach var="donation" items="${donationadllList}">
                                    <c:if test="${memberDetails.userID == donation.userID}">
                                        <c:forEach var="campaign" items="${campaignList}">
                                            <c:if test="${campaign.campaignID == donation.campaignID}">
                                                ${campaign.cam_title}<br />
                                                <c:set var="hasCampaign" value="true" />
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${hasCampaign == 'false'}">X</c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </form>
    </div>
</div>
<script>
    function filterTable(containerId, query) {
        var table = document.getElementById(containerId).querySelector("table");
        if (!table) {
            console.error('Table not found for container:', containerId);
            return;
        }
        var rows = table.querySelectorAll("tbody tr");

        rows.forEach(function (row) {
            var cells = row.querySelectorAll("td");
            var match = Array.from(cells).some(function (cell) {
                return cell.innerText.toLowerCase().includes(query.toLowerCase());
            });
            row.style.display = match ? "" : "none";
        });
    }
</script>
</body>
</html>
