<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}/" /> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Donation History</title>
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <!-- Custom CSS -->
    <link href="${root}css/top_menu.css" rel="stylesheet" />
    <link href="${root}css/bottom_info.css" rel="stylesheet" />
    <link href="${root}css/donationHistory.css" rel="stylesheet" />
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

<!-- 후원 내역 -->
    <div class="container mt-5" style="margin-top:120px">
        <h2>후원 내역</h2>
        <form method="get" action="${root}campaign/donationHistory">
            <h5>후원 날짜 조회</h5>
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="donation_startDate">시작</label>
                    <input type="date" class="form-control" id="donation_startDate" name="donation_startDate">
                </div>
                <div class="form-group col-md-6">
                    <label for="donation_endDate">종료</label>
                    <input type="date" class="form-control" id="donation_endDate" name="donation_endDate">
                </div>
                <div class="form-group col-md-12 text-right">
                    <button type="submit" class="btn btn-primary">조회</button>
                </div>
            </div>
        </form>
        <hr>
        <div class="support-history">
            <c:forEach var="donation" items="${donationList}">
                <div class="support-entry">
                    <dl>
                        <dt>후원 날짜</dt>
                        <dd>${donation.donation_date}</dd>
                        <dt>캠페인 제목</dt>
                        <dd>${donation.campaign.cam_title}</dd>
                        <dt>시작 날짜</dt>
                        <dd>${donation.campaign.start_date}</dd>
                        <dt>종료 날짜</dt>
                        <dd>${donation.campaign.end_date}</dd>
                        <dt>후원 금액</dt>
                        <dd><fmt:formatNumber value="${donation.cam_amount}" type="currency" currencySymbol="₩"/></dd>
                        <dt>익명 여부</dt>
                        <dd>${donation.anonymous == 'T' ? '익명' : '비익명'}</dd>
                    </dl>
                    <div class="btn-group">
                        <button type="button" onclick="location.href='${root}campaign/donationCancel?donationID=${donation.donationID}&campaignID=${donation.campaignID}&cam_amount=${donation.cam_amount}'" class="btn btn-danger">후원 취소하기</button>
                    </div>
                </div>
                <hr>
            </c:forEach>
        </div>
    </div>
    
<!-- 하단메뉴 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>

<script>
    // 메시지가 있을 경우 알림 창 표시
     <c:if test="${not empty alertMessage}">
        alert('${alertMessage}');
    </c:if>
</script>
</body>
</html>
