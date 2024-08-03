<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}/" />

<!-- D-DAY Update Script -->
<span id="clock" class="navbar-clock">1.5℃ 상승까지</span>
<script>
document.addEventListener("DOMContentLoaded", function() {
    

    function updateDDay() { 

        const targetDate = new Date('2030-04-18'); // 목표 날짜를 정확하게 설정 (UTC 시간)

        const now = new Date();

        const timeDiff = targetDate - now; // 밀리초 단위의 시간 차이 계산

        if (timeDiff < 0) {
            document.getElementById('clock').textContent = "1.5℃ 상승까지 0일";
            return;
        }

        const daysLeft = Math.ceil(timeDiff / (1000 * 60 * 60 * 24)); // 밀리초를 일수로 변환

        document.getElementById('clock').textContent = "1.5℃ 상승까지 "+daysLeft+"일";
    }

    setInterval(updateDDay, 1000);
    updateDDay(); // Initial call to display D-DAY immediately
});
</script>