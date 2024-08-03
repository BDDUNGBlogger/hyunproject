<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="news-layout" style="margin-top:100px">
<!-- 온도시계 -->
<div class="navbar-clock-main">
    <span id="clock">
        <a class="time">1.5℃ 상승까지</a>
    </span>
</div>
    <div class="main">
    
    <div class="box1">
            <c:forEach var='boardlists' items="${list}" varStatus="idx">
            <c:choose>
            <c:when test="${board_list[idx.index].board_IDX == 3}">
            <div class="card shadow">
                <div class="card-body">
                    <h4 class="card-title">${board_list[idx.index].board_info_Nm}</h4>
                    <table class="table table-hover" id='board_list'>
                        <thead>
                            <tr>
                                <th class="text-center w-25">글번호</th>
                                <th>제목</th>
                                <th class="text-center w-25 d-none d-xl-table-cell">작성날짜</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach var='obj' items="${boardlists}">
                            <tr>
                                <td class="text-center">${obj.noticeID}</td>
                                <th><a href='${root}board/read?board_IDX=${board_list[idx.index].board_IDX}&noticeID=${obj.noticeID}&page=1' class="text-title">${obj.title}</a></th>
                                <td class="text-center d-none d-xl-table-cell">${obj.create_date}</td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <a href="${root}board/main?board_IDX=${board_list[idx.index].board_IDX}" class="btn btn-primary">더보기</a>
                </div>
            </div>
            </c:when>
            </c:choose>
            </c:forEach>
       </div> 
        <div class="box2">
            <c:forEach var='boardlists' items="${list}" varStatus="idx">
            <c:choose>
            <c:when test="${board_list[idx.index].board_IDX == 1}">
            <div class="card shadow">
                <div class="card-body">
                    <h4 class="card-title">${board_list[idx.index].board_info_Nm}</h4>
                    <table class="table table-hover" id='board_list'>
                        <thead>
                            <tr>
                                <th class="text-center w-25">글번호</th>
                                <th>제목</th>
                                <th class="text-center w-25 d-none d-xl-table-cell">작성날짜</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach var='obj' items="${boardlists}">
                            <tr>
                                <td class="text-center">${obj.noticeID}</td>
                                <th><a href='${root}board/read?board_IDX=${board_list[idx.index].board_IDX}&noticeID=${obj.noticeID}&page=1' class="text-title">${obj.title}</a></th>
                                <td class="text-center d-none d-xl-table-cell">${obj.create_date}</td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <a href="${root}board/main?board_IDX=${board_list[idx.index].board_IDX}" class="btn btn-primary">더보기</a>
                </div>
            </div>
            </c:when>
            </c:choose>
            </c:forEach>
        </div>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    function updateDDay() {
       

        const targetDate = new Date('2030-04-18'); // 목표 날짜를 정확하게 설정 (UTC 시간)
       
        const now = new Date();

        const timeDiff = targetDate - now; // 밀리초 단위의 시간 차이 계산
      

        if (timeDiff < 0) {
            console.error("The target date is in the past Main");
            document.querySelector('.time').textContent = "1.5℃ 상승까지 0일";
            document.querySelector('.date').textContent = "날짜가 지났습니다.";
            return;
        }

        const daysLeft = Math.ceil(timeDiff / (1000 * 60 * 60 * 24)); // 밀리초를 일수로 변환

        document.querySelector('.time').textContent = "1.5℃ 상승까지 " + daysLeft + "일";
    }

    setInterval(updateDDay, 1000);
    updateDDay(); // Initial call to display D-DAY immediately
});
</script>