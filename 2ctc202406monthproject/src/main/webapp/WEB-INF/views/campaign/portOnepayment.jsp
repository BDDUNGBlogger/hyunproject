<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}/" />  
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결제하기</title>
    <!-- 포트원 결제 --> 
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <script>
        // UUID 생성 함수
        function generateUUID() {
            return 'xxxxxxx'.replace(/[xy]/g, function(c) {
                var r = Math.random() * 16 | 0, v = c === 'x' ? r : (r & 0x3 | 0x8);
                return v.toString(16);
            });
        }

        const paymentId = generateUUID();
        const totalAmount = '<%= request.getAttribute("cam_amount") %>';
        const campaignID = '<%= request.getAttribute("campaignID") %>';
        const anonymous = '<%= request.getAttribute("anonymous") %>';
        const buyerName = anonymous === "true" ? '익명' : '<%= request.getAttribute("buyerName") %>';
        const temporaryDonationID = '<%= request.getAttribute("temporaryDonationID") %>';
        
        const buyerEmail = '<%= request.getAttribute("buyerEmail") %>';
        const buyerPhone = '<%= request.getAttribute("buyerPhone") %>';
        const buyerAddress = '<%= request.getAttribute("buyerAddress") %>';
        const buyerPost_num = '<%= request.getAttribute("buyerPost_num") %>';
        

        function requestPayment() {
            IMP.init('imp11041543'); // 가맹점 식별코드
            IMP.request_pay({
                pg: "kakaopay.TC0ONETIME",
                pay_method: "card",
                merchant_uid: paymentId, // 상점에서 생성한 고유 주문번호
                name: "캠페인 기부",
                amount: totalAmount,
                buyer_email: buyerEmail,
                buyer_name: buyerName,
                buyer_tel: buyerPhone,
                buyer_addr: buyerAddress,
                buyer_postcode: buyerPost_num,
                m_redirect_url: "${root}campaign/payment_success?amount=" + totalAmount + "&campaignID=" + campaignID + "&anonymous=" + anonymous + "&temporaryDonationID=" + temporaryDonationID,
                appCard: true, // 설정시 신용카드 결제모듈에서 앱카드 결제만 활성화됩니다.
            }, function(rsp) { // callback 로직
                console.log(rsp); // 응답을 콘솔에 로그로 남김
                if (rsp.success) {
                    // 결제 성공 시 로직
                    alert('결제가 완료되었습니다.');
                    window.location.href = "${root}campaign/payment_success?amount=" + totalAmount + "&campaignID=" + campaignID + "&anonymous=" + anonymous + "&temporaryDonationID=" + temporaryDonationID;
                } else {
                    // 결제 실패 시 로직
                    alert('결제에 실패하였습니다. 다시 시도해주세요.');
                    window.location.href = "${root}campaign/payment_fail?campaignID=" + campaignID;
                }
            });
        }

        // 결제 요청 함수 호출
        $(document).ready(function() {
            requestPayment();
        });
    </script>
</head>
<body>
</body>
</html>
