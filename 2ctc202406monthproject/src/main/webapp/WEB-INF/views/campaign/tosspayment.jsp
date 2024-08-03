<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='root' value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title>결제하기</title>
  <!-- 토스페이먼츠 결제창 SDK 추가 -->
  <script src="https://js.tosspayments.com/v1/payment"></script>
</head>
<body>
  <script>
    // ------ 클라이언트 키로 객체 초기화 ------
    var clientKey = 'test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq'
    var tossPayments = TossPayments(clientKey)
    // ------ 결제창 띄우기 ------
    tossPayments
      .requestPayment('카드', {
        // 결제수단 파라미터 (카드, 계좌이체, 가상계좌, 휴대폰 등)
        // 결제 정보 파라미터
        // 더 많은 결제 정보 파라미터는 결제창 Javascript SDK에서 확인하세요.
        // https://docs.tosspayments.com/reference/js-sdk
        amount: 100, // 결제 금액
        orderId: '6zebdTSPluOPx206nzUU-', // 주문번호(주문번호는 상점에서 직접 만들어주세요.)
        orderName: '테스트 결제', // 구매상품
        customerName: '김토스', // 구매자 이름
        successUrl: 'http://localhost:9088/2CTC_Project/support/tosspament_success', // 결제 성공 시 이동할 페이지(이 주소는 예시입니다. 상점에서 직접 만들어주세요.)
        failUrl: 'http://localhost:9088/2CTC_Project/support/tosspayment_fail', // 결제 실패 시 이동할 페이지(이 주소는 예시입니다. 상점에서 직접 만들어주세요.)
      })
      // ------결제창을 띄울 수 없는 에러 처리 ------
      // 메서드 실행에 실패해서 reject 된 에러를 처리하는 블록입니다.
      // 결제창에서 발생할 수 있는 에러를 확인하세요.
      // https://docs.tosspayments.com/reference/error-codes#결제창공통-sdk-에러
      .catch(function (error) {
        if (error.code === 'USER_CANCEL') {
          // 결제 고객이 결제창을 닫았을 때 에러 처리
        } else if (error.code === 'INVALID_CARD_COMPANY') {
          // 유효하지 않은 카드 코드에 대한 에러 처리
        }
      })
  </script>
</body>
</html>