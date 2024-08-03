<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송지 변경 페이지</title> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

<link href="${root}css/productmodify.css" rel="stylesheet"/>


</head>
<body>
<!-- 주소 API 스크립트 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- 배송지 변경 폼 -->
<div class="container">
	<div class="modify-container">
    	<h3>배송지 변경</h3>   
    	<form>    	
	        <div class="form-group1">
	            <label for="sample6_postcode" class="sample6_postcode">우편번호</label>
	            <button type="button" class="addr-btn" onclick="DaumPostCode()">주소검색</button>
	            <br />
	            <input type="text" name="post_num" class="form-control" id="post_num" placeholder="우편번호">
	        </div>
	    
	        <div class="form-group2">
	            <label for="sample6_address" class="sample6_address">주소</label>
	            <input type="text" name="address" class="form-control" id="address" placeholder="주소"> 
	        </div>
	     
	        <div class="form-group3">
	            <label for="sample6_detailAddress" class="sample6_detailAddress">상세 주소</label>
	            <input type="text" name="address" class="form-control" id="address_detail" placeholder="상세 주소" onKeyDown="onKeyDown(event, 'receiver')">
	        </div>
	     
	    	<div class="form-group4" id="name-group" >
	            <label for="name" class="name">수령인</label>
	            <input type="text" name="name" class="form-control" id="name" placeholder="수령인" onKeyDown="onKeyDown(event, 'phone')">
	        </div>
	        <div class="form-group5" id="phone-group" >
	            <label for="phone" class="phone">전화번호</label>
	            <input type="text" name="phone" class="form-control" id="phone" placeholder="전화번호" onKeyDown="onKeyDown(event, 'save')" onkeyup="formatPhoneNumber(this)">
	        </div>			 	     
     	</form>
     	<div class="modify-save">
     		<form:form method="post"  modelAttribute="updateordersInfo">
     			<input type="hidden" name="orderID" value="${orderID}">
     			<input type="hidden" name="name" value="${name}">
			    <input type="hidden" name="phone" value="${phone}">
			    <input type="hidden" name="post_num" value="${post_num}">
			    <input type="hidden" name="address" value="${address}">
     			<button class="modify-save-btn" id="save" onclick="saveDeliveryInfo()">저장</button>
     		</form:form>
     	</div>
     </div>
</div>

<script>
function DaumPostCode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = ''; // 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 도로명 주소
                addr = data.roadAddress;
            } else { // 지번 주소
                addr = data.jibunAddress;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('post_num').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("address_detail").focus();
        },
        width : '100%',
        height : '100%'
    }).open({
        left: (window.screen.width / 2) - 260,  // 창의 가로 위치를 중앙으로 설정
        top: (window.screen.height / 2) - 250,  // 창의 세로 위치를 중앙으로 설정
        popupName: 'postcodePopup'
    });
}

// 저장 버튼 클릭 시 변경된 정보를 부모 창으로 전달하는 함수
function saveDeliveryInfo() {
    var name = document.getElementById("name").value;
    var phone = document.getElementById("phone").value;
    var post_num = document.getElementById("post_num").value;
    var address = document.getElementById("address").value + " " + document.getElementById("address_detail").value;

    // 부모 창으로 변경된 배송지 정보 전달
    window.opener.receiveDeliveryInfo(name, phone, post_num, address);
    window.close()
    
   
}

function onKeyDown(event, nextElementId) {
    if (event.key === 'Enter') {
        event.preventDefault();
        document.getElementById(nextElementId).focus();
       
    }
}

function formatPhoneNumber(element) {
    // 입력된 내용에서 숫자만 추출
    let cleaned = ('' + element.value).replace(/\D/g, '');
    
    // 숫자를 3자리, 4자리, 4자리로 나눔
    let formatted = '';
    if (cleaned.length > 3) {
        formatted += cleaned.substr(0, 3) + '-';
        if (cleaned.length > 7) {
            formatted += cleaned.substr(3, 4) + '-';
            formatted += cleaned.substr(7, 4);
        } else {
            formatted += cleaned.substr(3);
        }
    } else {
        formatted = cleaned;
    }
    
    // 최종 결과를 입력 필드에 표시
    element.value = formatted;
}


</script>

</body>
</html>