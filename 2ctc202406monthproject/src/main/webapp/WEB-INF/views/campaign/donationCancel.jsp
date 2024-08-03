<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Donation Cancel</title>
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <!-- Custom CSS -->
    <link href="${root}css/top_menu.css" rel="stylesheet"/>
    <link href="${root}css/bottom_info.css" rel="stylesheet"/>
    <link href="${root}css/donationCancel.css" rel="stylesheet"/>
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

<div class="cancel-container" style="margin-top:120px">
    <h1>사유를 입력해주세요.</h1>
    <div class="item-info">
        <div class="item-details">
				<dl>
					<dt>후원 날짜</dt>
					<dd>${donation.donation_date}</dd>
					<dt>캠페인 제목</dt>
					<dd>${donation.campaign.cam_title}</dd>
					<dt>후원 금액</dt>
					<dd><fmt:formatNumber value="${donation.cam_amount}" type="currency" currencySymbol="₩"/></dd>
					<dt>캠페인 호스트</dt>
					<dd>${donation.campaign.cam_host}</dd>
				</dl>
		</div>
    </div>
    <div class="reason-select">
        <label for="reason-list">취소 사유 선택</label>
        <div class="select-container">
        <select id="reason-list" class="form-control" onchange="showReasonDetails()">
            <option disabled value="" selected>선택</option>
            <option value="simple-change">단순 변심</option>
            <option value="mistake">후원 실수</option>
            <option value="dissatisfaction">서비스 불만족</option>
        </select>
        </div>
    </div>
    <div id="reason-details" class="reason-details"></div>
    <div class="detail-reason">
        <label for="detailed-reason">상세 사유 입력</label>
        <textarea id="detailed-reason" placeholder="상세 사유를 입력해주세요."></textarea>
        <p class="char-counter">0/500</p>
    </div>
    <div class="warning">
        <p>카드 취소시 카드사에 따라 결제 취소 기간이 다를 수 있습니다.</p>
    </div>
    <button class="cancel-button" onclick="cancelDonation('${donation.donationID}', '${donation.campaignID}', ${donation.cam_amount})">취소 신청하기</button>
</div>

<!-- 하단메뉴 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>
    
<script>
    function cancelDonation(donationID, campaignID, cam_amount) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${root}campaign/cancelDonation';

        const donationIDField = document.createElement('input');
        donationIDField.type = 'hidden';
        donationIDField.name = 'donationID';
        donationIDField.value = donationID;
        form.appendChild(donationIDField);

        const campaignIDField = document.createElement('input');
        campaignIDField.type = 'hidden';
        campaignIDField.name = 'campaignID';
        campaignIDField.value = campaignID;
        form.appendChild(campaignIDField);

        const cam_amountField = document.createElement('input');
        cam_amountField.type = 'hidden';
        cam_amountField.name = 'cam_amount';
        cam_amountField.value = cam_amount;
        form.appendChild(cam_amountField);

        document.body.appendChild(form);
        form.submit();
    }

    const textarea = document.getElementById('detailed-reason');
    const charCounter = document.querySelector('.char-counter');
    
    textarea.addEventListener('input', () => {
        charCounter.textContent = `${textarea.value.length}/500`;
    });

    function showReasonDetails() {
        const reasonList = document.getElementById('reason-list');
        const reasonDetails = document.getElementById('reason-details');
        const selectedReason = reasonList.value;

        let detailsHtml = '';

        if (selectedReason === 'simple-change') {
            detailsHtml = '<p>단순 변심 사유에 대한 내용입니다.</p>';
        } else if (selectedReason === 'mistake') {
            detailsHtml = '<p>후원 실수 사유에 대한 내용입니다.</p>';
        } else if (selectedReason === 'dissatisfaction') {
            detailsHtml = '<p>서비스 불만족 사유에 대한 내용입니다.</p>';
        }

        reasonDetails.innerHTML = detailsHtml;
    }
</script>
</body>
</html>
