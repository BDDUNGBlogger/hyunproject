<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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

<script src="https://cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>

<%-- footer CSS --%>
<link rel="stylesheet" href="../css/top_menu.css" />
<link rel="stylesheet" href="../css/bottom_info.css" />
<link rel="stylesheet" href="../css/board.css" />
</head>
<body>

	<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

<div class="boardcontainer" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					<form:form action="${root}board/write_pro" method="post" modelAttribute="writeContentBean" enctype="multipart/form-data">
					<form:hidden path="board_IDX"/>
					
								
					<div class="form-group">
						<form:label path="title">제목</form:label>
						<form:input path="title" class='form-control'/>
						<form:errors path='title' style='color:red' />
					</div>
					<div class="form-group">
						<form:label path="content_text">내용</form:label>
						<form:textarea path="content_text" class="form-control" rows="10" style="resize:none"/>
						<form:errors path='content_text' style='color:red'/>
					</div>
					<div class="form-group">
					<form:label path="upload_img">첨부 이미지</form:label>
					<form:input type='file' path='upload_img' class="form-control" accept="upload/*"/>
					</div>
					<div class="button-effect">
						<div class="text-right">
							<form:button type="submit" class='boardbtns modify'>작성하기</form:button>
						</div>
					</div>
					</form:form>
				</div>
			</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div>

<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>
<c:out value="<script src='../js/board.js'></script>" escapeXml="false"/>
<script>
    CKEDITOR.replace('content_text');
</script>
</body>
</html>




