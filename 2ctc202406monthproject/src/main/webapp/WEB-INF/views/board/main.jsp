<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var='root' value="${pageContext.request.contextPath}/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>미니 프로젝트</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<%-- footer CSS --%>
<link rel="stylesheet" href="../css/top_menu.css" />
<link rel="stylesheet" href="../css/bottom_info.css" />
<link rel="stylesheet" href="../css/board.css" />
<style>
.boardcontainer{
	display: flex;
	margin-top: 200px;
	justify-content: center;
}
.button-group {
    display: flex;
    justify-content: center;
    margin-bottom: 20px;
}

.round-button {
    border-radius: 10px; /* 약간의 라운드 */
    font-size: 15px;
    font-weight: bold;
    padding: 10px 20px;
    margin: 5px; /* 여백 추가 */
    transition: background-color 0.3s, color 0.3s;
    display: inline-block; /* 버튼을 인라인 블록으로 설정 */
    text-decoration: none; /* 링크의 밑줄 제거 */
    text-align: center; /* 텍스트 가운데 정렬 */
}

.round-button.active {
    background-color: black;
    color: white;
}

.round-button.inactive {
    background-color: white;
    color: black;
    border: 2px solid black;
}

.centered-button-addsupport {
    display: flex;
    justify-content: flex-end; /* 오른쪽 정렬 */
    margin-top: 20px; /* 추가 */
}

.round-button-addsupport {
    border-radius: 10px; /* 약간의 라운드 */
    font-size: 15px;
    font-weight: bold;
    padding: 10px 20px;
    margin: 5px; /* 여백 추가 */
    background-color: white; /* 기본 배경색 설정 */
    color: black; /* 기본 텍스트 색상 설정 */
    border: 2px solid black; /* 테두리 설정 */
    transition: background-color 0.3s, color 0.3s; /* 호버 효과를 위한 트랜지션 추가 */
}

.round-button-addsupport:hover {
    background-color: black;
    color: white;
}

.centered-buttons {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 20px;
}
</style>
</head>
<body>

	<!-- 상단 메뉴 부분 -->
	<c:import url="/WEB-INF/views/include/top_menu.jsp" />

	<!-- 게시글 리스트 -->
	<div class="boardcontainer">
		<div class="card shadow" style="width: 70%;">
			<div class="centered-buttons">
				<c:forEach var='obj' items="${topMenuList}">
                        <a href="${root}board/main?board_IDX=${obj.board_IDX}" 
                           class="round-button ${board_IDX == obj.board_IDX ? 'active' : 'inactive'}">
                           ${obj.board_info_Nm}
                        </a>
				</c:forEach>
			</div>
			<div class="card-body">
				<table class="table table-hover" id='board_list'>
					<thead>
						<tr>
							<th class="text-center d-none d-md-table-cell">글번호</th>
							<th class="w-50">제목</th>
							<th class="text-center d-none d-md-table-cell">작성날짜</th>
							<th class="text-center d-none d-md-table-cell">수정날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var='obj' items="${contentList}">
							<tr>
								<td class="text-center d-none d-md-table-cell"><fmt:formatNumber value="${fn:substringAfter(obj.noticeID, 'N')}" /></td>
								<th class="w-50"><a
									href="${root}board/read?board_IDX=${board_IDX}&noticeID=${obj.noticeID}&page=${page}" style="color: black;">${obj.title}</a></th>
								<th class="text-center d-none d-md-table-cell">${obj.create_date}</th>
								<th class="text-center d-none d-md-table-cell">${obj.last_update}</th>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<div class="d-none d-md-block">
					<ul class="pagination justify-content-center">

					</ul>
				</div>
				<%-- class="d-none d-md-block" 부트스트랩 --%>
				<div class="d-none d-md-block">
            <ul class="pagination justify-content-center">
               <c:choose>
                  <c:when test="${pageBean.prevPage <= 0}">
                     <li class="page-item disabled">
                        <a href="#" class="page-link">이전</a>
                     </li>
                  </c:when>
                  
                  <c:otherwise>
                     <li class="page-item">
                     <a href="${root }board/main?board_IDX=${board_IDX}&page=${pageBean.prevPage}" class="page-link">이전</a>
                     </li>
                  </c:otherwise>
               </c:choose>
               
               <c:forEach var="idx" begin="${pageBean.min}" end="${pageBean.max}">
                  <c:choose>
                     <c:when test="${idx == pageBean.currentPage}">
                        <li class="page-item active">
                           <a href="${root }board/main?board_IDX=${board_IDX}&page=${idx}" class="page-link">${idx}</a>
                        </li>
                     </c:when>
                     <c:otherwise>
                        <li class="page-item">
                           <a href="${root }board/main?board_IDX=${board_IDX}&page=${idx}" class="page-link">${idx}</a>
                        </li>
                     </c:otherwise>
                     </c:choose>
            </c:forEach>
                  <c:choose>
                     <c:when test="${pageBean.max >= pageBean.pageCnt }">
                        <li class="page-item disabled"><a href="#"
                           class="page-link">다음</a></li>
                     </c:when>
                     <c:otherwise>
                        <li class="page-item"><a
                           href="${root }board/main?board_IDX=${board_IDX}&page=${pageBean.nextPage}"
                           class="page-link">다음</a></li>
                     </c:otherwise>
                  </c:choose>
               </ul>
            </div>


				<div class="button-effect">
					<div class="text-right">
						<a href="${root}board/write?board_IDX=${board_IDX}"
							class="boardbtns write">글쓰기</a>
					</div>
				</div>

			</div>
		</div>
	</div>

	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />

</body>
</html>







