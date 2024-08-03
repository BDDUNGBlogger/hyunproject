<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="root" value="${pageContext.request.contextPath}/" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>미니 프로젝트</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- Custom CSS -->
<link rel="stylesheet" href="../css/top_menu.css" />
<link rel="stylesheet" href="../css/bottom_info.css" />
<link rel="stylesheet" href="../css/board.css" />

<script src="https://cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
	.boardbtns {
    display: inline;
}
.button-container {
    text-align: right;
}

.inline-form {
    display: inline;
}
</style>
</head>
<body>

	<c:import url="/WEB-INF/views/include/top_menu.jsp" />

	<div class="boardcontainer" style="margin-top: 100px">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-6">
				<div class="card shadow">
					<div class="card-body">
						<form:form action="${root}board/modify_pro" method="post"
							modelAttribute="modifyContentBean" enctype="multipart/form-data">
							<%-- 어떤 게시판? 	어떤 게시글? --%>
							<form:hidden path="board_IDX" />
							<%--어떤 게시글?--%>
							<form:hidden path="noticeID" />
							<input type="hidden" name="page" value="${page}" />
							<div class="form-group">
								<form:label path="content_writer_name">작성자</form:label>
								<form:input path="content_writer_name" class='form-control'
									readonly="true" />
							</div>
							<div class="form-group">
								<form:label path="title">제목</form:label>
								<form:input path="title" class='form-control' />
								<form:errors path="title" style='color:red' />
							</div>
							<div class="form-group">
								<form:label path="content_text">내용</form:label>
								<form:textarea path="content_text" class="form-control"
									rows="10" style="resize:none" />
								<form:errors path="content_text" style='color:red' />
							</div>
							<div class="form-group">
								<label for="img">첨부 이미지</label>
								<c:if test="${modifyContentBean.img != null }">
									<img src="${root}upload/${modifyContentBean.img}"
										width="100%" />
									<!-- 수정시 첨부파일 이미지 파일 변경없이 유지하도록 form태그에 담아둠-->
									<form:hidden path="img" />
								</c:if>
								<form:input path="upload_img" type='file' class="form-control"
									accept="upload/*" />
							</div>
							<div class="form-group">
								<div class="text-right">
									<button type="submit" class="boardbtns modify">수정완료</button>
									<a href="${root}board/read?board_IDX=${board_IDX}&noticeID=${noticeID}&page=${page}"
										class="boardbtns delete">취소</a>
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
			<div class="col-sm-3"></div>
		</div>
	</div>
	<!-- 하단메뉴 -->
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />
<script>
    CKEDITOR.replace('content_text');
</script>
</body>
</html>


