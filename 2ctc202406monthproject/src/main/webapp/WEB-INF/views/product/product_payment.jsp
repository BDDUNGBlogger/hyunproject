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
        const totalprice = '<%= request.getParameter("totalprice") %>';
        const username = '<%= request.getParameter("username") %>';
        const buyerEmail = '<%= request.getParameter("email") %>';
        const phone = '<%= request.getParameter("phone") %>';
        const address = '<%= request.getParameter("address") %>';
        const post_num = '<%= request.getParameter("post_num") %>';
        const productID = '<%= request.getParameter("productID") %>'; 
        const product_name = '<%= request.getParameter("product_name") %>';
        const color = '<%= request.getParameter("color") %>';
        const quantity = '<%= request.getParameter("quantity") %>';
        const product_img = '<%= request.getParameter("product_img") %>';
        const orderID = '<%= request.getParameter("orderID") %>';
        const userID = '<%= request.getParameter("userID") %>';
        const price = '<%= request.getParameter("price") %>';
        

        function requestPayment() {
            IMP.init('imp11041543'); // 가맹점 식별코드를 실제로 사용하는 식별코드로 변경해야 합니다.
            IMP.request_pay({
                pg: "kakaopay.TC0ONETIME",
                pay_method: "card",
                merchant_uid: paymentId,
                name: "상품 구매",
                amount: totalprice,
                buyer_email: buyerEmail,
                buyer_name: username,
                buyer_tel: phone,
                buyer_addr: address,
                buyer_postcode: post_num,
                m_redirect_url: "${root}product/orderList?" + 
                "amount=" + totalprice + 
                "&orderID=" + orderID + 
                "&userID=" + userID +
                "&productID=" + productID + 
                "&productName=" + product_name + 
                "&username=" + username +
                "&phone=" + phone +
                "&address=" + address +
                "&post_num=" + post_num +
                "&productImg=" + product_img + 
                "&price=" + price + 
                "&quantity=" + quantity + 
                "&color=" + color,
                appCard: true,
            }, function(rsp) {  
                console.log(rsp);
                if (rsp.success) {
                    alert('결제가 완료되었습니다.');
                    window.location.href = "${root}product/orderList?" + 
                    "amount=" + totalprice + 
                    "&orderID=" + orderID +
                    "&userID=" + userID +
                    "&productID=" + productID + 
                    "&productName=" + product_name + 
                    "&username=" + username +
                    "&phone=" + phone +
                    "&address=" + address +
                    "&post_num=" + post_num +
                    "&productImg=" + product_img + 
                    "&price=" + price + 
                    "&quantity=" + quantity + 
                    "&color=" + color; 
                    
                } else {
                    alert('결제에 실패하였습니다. 다시 시도해주세요.');
                    window.location.href = "${root}product/productbuy?" +
                    "totalprice=" + totalprice + 
                    "&productID=" + productID + 
                    "&product_name=" + product_name + 
                    "&product_img=" + product_img + 
                    "&price=" + price + 
                    "&quantity=" + quantity + 
                    "&color=" + color +
                    "&username=" + username +
                    "&phone=" + phone +
                    "&address=" + address +
                    "&post_num=" + post_num;
                   
                }
            });
        }

        $(document).ready(function() {
            requestPayment();
        });
    </script>

</head>
<body>
</body>
</html>
