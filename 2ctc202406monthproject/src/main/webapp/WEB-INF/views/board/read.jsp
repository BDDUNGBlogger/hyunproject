<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>read</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- Custom CSS -->
	<link rel="stylesheet" href="../css/top_menu.css" />
	<link rel="stylesheet" href="../css/board.css" />
	<link rel="stylesheet" href="../css/bottom_info.css" />
	
	<style>
	.comment-input { width: 100%; height: 100px; padding: 10px; box-sizing: border-box; font-size: 14px; border: 1px solid #ccc; border-radius: 4px; resize: vertical; }
    .comment-form { margin-top: 20px; }
    .comment-list { margin-top: 20px; }
    .comment-item { border-bottom: 1px solid #ccc; padding: 10px 0; }
	</style>
</head>
<body>
	

<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

<!-- read -->
<div class="boardcontainer" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					<div class="card-body">
						<div class="form-group">
							<label for="board_writer_name">작성자</label> <input type="text"
								id="board_writer_name" name="board_writer_name"
								class="form-control"
								value="${readContentBean.content_writer_name}"
								disabled="disabled" />
						</div>
						<div class="form-group">
							<label for="board_subject">제목</label> <input type="text"
								id="board_subject" name="board_subject" class="form-control"
								value="${readContentBean.title}" disabled="disabled" />
						</div>
						<hr />
						<div class="form-group">
							<!-- <label for="board_content">내용</label> -->
							<c:out value="${readContentBean.content_text}" escapeXml="false" />
						</div>
						<div class="container">
						    <hr />
						 <!-- 댓글 -->
						 <div class="commentcontainer">
                              <div id="commentlist">
                                  <c:forEach var="comment" items="${commentlist}">
                                      <div class="comment-item">
                                          <strong style="font-size: ">${comment.com_userID}</strong><br/>
                                          <span style="font-size:larger;">${comment.comment_text}</span><br/>
                                          <small>${comment.create_date}</small><br/>
                                          <form method="post" action="${root}/comments/delete" class="comment-delete-form d-inline">
                                              <input type="hidden" name="comment_id" value="${comment.comment_id}" />
                                           <input type="hidden" name="com_content_idx" value="${noticeID}" />
											<c:if test="${loginUserBean.userID == comment.com_userID || loginUserBean.rolecd == 'M'}">
												<button type="submit" class="boardbtns delete">삭제</button>
											</c:if>
                                          </form>
                                      </div>
                                  </c:forEach>
                              </div>
                                <!-- 댓글 작성 폼 -->
                                <c:if test="${loginUserBean.rolecd != 'U' || board_IDX == 2}">
                                <form id="commentForm">
                                    <input type="hidden" id="com_content_idx" name="com_content_idx" value="${noticeID}" />
                                    <textarea id="comment_text" name="comment_text" class="comment-input" placeholder="댓글을 입력하세요..."></textarea>
                                    <button type="submit" class="boardbtns write">댓글 작성</button>
                                </form>
                                </c:if>
                            </div>
						 <!-- 댓글 -->
						<c:if test="${readContentBean.img != null}">
						<div id="gallery" class="form-group">
							<c:forEach var="imageUrl" items="${imageUrls}" varStatus="status">
								<img id="thumbnail-${status.index}" src="${root}upload/${readContentBean.img}">
							</c:forEach>
							<label for="board_file">첨부 이미지</label> <img
								src="${root}upload/${readContentBean.img}" />
						</div>
						</c:if>
						<div id="overlay" onclick="closeOverlay()">
							<img id="overlay-img" src="${root}upload/${readContentBean.img}" />
						</div>
						<div class="form-group">
							<label for="create_date">작성날짜</label> <input type="text"
								id="create_date" name="create_date" class="form-control"
								value="${readContentBean.create_date}" disabled="disabled" />
						</div>
						<div class="form-group">
							<label for="last_update">수정날짜</label> <input type="text"
								id="last_update" name="last_update" class="form-control"
								value="${readContentBean.last_update}" disabled="disabled" />
						</div>
						<div class="button-effect">
							<div class="text-right">
								<a class="boardbtns list" href="${root}board/main?board_IDX=${board_IDX}&page=${page}">목록보기</a>
								<c:if test="${loginUserBean.userID == readContentBean.writerID || loginUserBean.rolecd == 'M'}">
								<a class="boardbtns modify" href="${root}board/modify?board_IDX=${board_IDX}&noticeID=${noticeID}&page=${page}">수정하기</a>
								<a class="boardbtns delete" href="${root}board/delete?board_IDX=${board_IDX}&noticeID=${noticeID}">삭제하기</a>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div>
</div>


<!-- 하단메뉴 -->
<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>

<%-- js --%>
<script>
$(document).ready(function(){
    // 댓글 작성 폼 제출 이벤트 처리
    $('#commentForm').submit(function(event) {
        event.preventDefault(); // 기본 제출 이벤트 중지

        const formData = {
        	comment_text: $('#comment_text').val(),
        	com_content_idx: $('#com_content_idx').val()
        };

        $.ajax({
            type: 'POST',
            url: '${root}comments/add',
            data: formData,
            success: function(response) {
                updateComments(response);
                $('#commentForm')[0].reset(); // 폼 초기화
                alert("댓글을 작성하였습니다.");
            },
            error: function(xhr, status, error) {
                alert("댓글 작성에 실패했습니다. 다시 시도해 주세요.");
            }
        });
    });

    // 댓글 삭제 이벤트 처리
    $(document).on('submit', '.comment-delete-form', function(event) {
        event.preventDefault(); // 기본 제출 이벤트 중지

        const formData = $(this).serialize();

        $.ajax({
            type: 'POST',
            url: '${root}comments/delete',
            data: formData,
            success: function(response) {
                updateComments(response);
                alert("댓글이 삭제되었습니다.");
            },
            error: function(xhr, status, error) {
                alert("댓글 삭제에 실패했습니다. 다시 시도해 주세요.");
            }
        });
    });

    // 댓글 목록 업데이트 함수
    function updateComments(comments) {
        let commentListHtml = '';
        comments.forEach(function(comment) {
            commentListHtml += `
                <div class="comment-item">
                    <strong>${comment.com_userID}</strong><br/>
                    <span>${comment.comment_text}</span><br/>
                    <small>${comment.create_date}</small><br/>
                    <form method="post" action="${root}comments/delete" class="comment-delete-form d-inline">
                        <input type="hidden" name="comment_id" value="${comment.comment_id}" />
                        <input type="hidden" name="com_content_idx" value="${comment.com_content_idx}" />
                        <c:if test="${loginUserBean.userID == readContentBean.writerID || loginUserBean.rolecd == 'M'}">
                        <button type="submit" class="btn btn-danger btn-sm">삭제</button>
                        </c:if>
                    </form>
                </div>
            `;
        });
        $('#commentList').html(commentListHtml);
    }
});
</script>
<c:out value="<script src='../js/board.js'></script>" escapeXml="false" />
</body>
</html>
    