<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}/" />

<form id="donationForm" action="${root}campaign/portOnepayment" method="post">
    <input type="hidden" id="hiddenAmount" name="cam_amount">
    <input type="hidden" id="hiddenAnonymous" name="anonymous">
    <input type="hidden" name="campaignID" value="${readCampaignBean.campaignID}">
    <input type="hidden" name="donationID" value="${donationID}"> <!-- donationID 추가 -->
    <div class="modal fade" id="donationModal" tabindex="-1" role="dialog" aria-labelledby="donationModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="donationModalLabel">기부하기</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="donation-summary">
                        <img src="${root}upload/${readCampaignBean.cam_img}" class="img-thumbnail">
                        <div class="donation-details">
                            <h5>${readCampaignBean.cam_title}</h5>
                            <p>${readCampaignBean.cam_host}</p>
                        </div>
                    </div>
                    <hr>
                    <h6>기부금액</h6>
                    <div class="btn-group-wrapper">
                        <div class="btn-group mb-3" role="group">
                            <button type="button" class="btn btn-outline-secondary donation-btn" onclick="setDonationAmount(5000)">+ 5천원</button>
                            <button type="button" class="btn btn-outline-secondary donation-btn" onclick="setDonationAmount(10000)">+ 1만원</button>
                            <button type="button" class="btn btn-outline-secondary donation-btn" onclick="setDonationAmount(30000)">+ 3만원</button>
                            <button type="button" class="btn btn-outline-secondary donation-btn" onclick="setDonationAmount(50000)">+ 5만원</button>
                        </div>
                        <div class="btn-group mb-3" role="group">
                            <button type="button" class="btn btn-outline-secondary donation-btn" onclick="setDonationAmount(100000)">+ 10만원</button>
                            <button type="button" class="btn btn-outline-secondary donation-btn" onclick="setDonationAmount(500000)">+ 50만원</button>
                            <button type="button" class="btn btn-outline-secondary donation-btn" onclick="setDonationAmount(1000000)">+ 100만원</button>
                            <button type="button" class="btn btn-outline-secondary" onclick="enableCustomAmount()">직접입력</button>
                        </div>
                    </div>
                    <input type="text" id="customAmount" class="form-control" placeholder="기부금액을 입력하세요" disabled>
                    <small class="form-text text-muted">기부는 1천원부터 가능합니다</small>
                    <hr>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="true" id="anonymousCheck"> 
                        <label class="form-check-label" for="anonymousCheck">익명으로 기부하기</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="" id="kakaoCheck"> 
                        <label class="form-check-label" for="kakaoCheck">SMS 수신 동의 (선택)</label>
                    </div>
                    <small class="form-text text-muted">2CTC와 마케팅 메시지를 SMS로 받아보세요.</small> 
                    <small class="form-text text-muted">결제 수수료는 2CTC가 대신 부담합니다.</small> 
                    <small class="form-text text-muted">기부 완료 알림을 SMS로 발송해드려요.</small>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary btn-lg btn-block" onclick="submitDonationForm()">기부하기</button>
                </div>
            </div>
        </div> 
    </div>
</form>

<script>
// 기부 금액 설정
let donationAmount = 0;

function setDonationAmount(amount) {
    donationAmount = amount;
    document.getElementById('customAmount').disabled = true;

    document.querySelectorAll('.donation-btn').forEach(button => {
        button.classList.remove('active');
    });
    event.target.classList.add('active');
}

function enableCustomAmount() {
    document.getElementById('customAmount').disabled = false;
    donationAmount = 0;
    
    document.querySelectorAll('.donation-btn').forEach(button => {
        button.classList.remove('active');
    });
}

function submitDonationForm() {
    if (!document.getElementById('customAmount').disabled) {
        donationAmount = parseFloat(document.getElementById('customAmount').value);
    }

    if (donationAmount < 1000) {
        alert('기부금액은 최소 1,000원 이상이어야 합니다.');
        return;
    }

    document.getElementById('hiddenAmount').value = donationAmount;
    document.getElementById('hiddenAnonymous').value = document.getElementById('anonymousCheck').checked ? "true" : "false";
    document.getElementById('donationForm').submit();
}
</script>
