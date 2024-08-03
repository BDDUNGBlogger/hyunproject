<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var='root' value='${pageContext.request.contextPath }/'/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>campaign_modify</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

<!-- CKEditor CDN -->
<script src="https://cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>

<link href="${root}css/top_menu.css" rel="stylesheet" />
<link href="${root}css/bottom_info.css" rel="stylesheet" />
<link href="${root}css/campaignMain.css" rel="stylesheet" />
<link href="${root}css/campaignBoard.css" rel="stylesheet" />

</head>
<body>

<%-- 상단 메뉴 --%>
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

<div class="container" style="margin-top:100px">
   <div class="row">
      <div class="col-sm-3"></div>
      <div class="col-sm-6">
         <div class="card shadow">
            <div class="card-body">
               <form:form action="${root}campaign/campaign_modify_pro" method="post" modelAttribute="modifyCampaignBean" enctype="multipart/form-data">
               <form:hidden path="campaignID"/>
               <div class="form-group">
                  <form:label path="cam_title">제목</form:label>
                  <form:input path="cam_title" class='form-control'/>
                  <form:errors path='cam_title' style='color:red' />
               </div>
               
                <div class="form-group">
                  <form:label path="category">카테고리</form:label>
                  <form:select path="category" class="form-control">
                     <form:option value="환경" label="환경" />
                     <form:option value="동물" label="동물" />
                  </form:select>
                  <form:errors path='category' style='color:red' />
               </div>
               
               <div class="form-group">
                  <form:label path="cam_host">후원 주최</form:label>
                  <form:input path="cam_host" class='form-control'/>
                  <form:errors path='cam_host' style='color:red' />
               </div>
               
               <div class="form-group">
                  <form:label path="goal_amount">목표 금액</form:label>
                  <form:input path="goal_amount" class='form-control'/>
                  <form:errors path='goal_amount' style='color:red' />
               </div>
                  
                  <div class="form-group">
                     <form:label path="start_date">시작 날짜</form:label>
                     <form:input path="start_date" class='form-control' type="date"/>
                     <form:errors path='start_date' style='color:red' />
                  </div>
                  
                    <div class="form-group">
                     <form:label path="end_date">종료 날짜</form:label>
                     <form:input path="end_date" class='form-control' type="date"/>
                     <form:errors path='end_date' style='color:red' />
                  </div>
               
                <div class="form-group">
                     <form:label path="cam_intro">모금소개</form:label>
                     <form:textarea path="cam_intro" class="form-control" rows="10" style="resize:none"/>
                     <form:errors path='cam_intro' style='color:red'/>
                  </div>
                  
                  <div class="form-group">
                     <form:label path="cam_news">소식</form:label>
                     <form:textarea path="cam_news" class="form-control" rows="10" style="resize:none"/>
                     <form:errors path='cam_news' style='color:red'/>
                  </div>
               
                	<div class="form-group">
                     <form:label path="upload_file">첨부 이미지</form:label>
                     <form:input type='file' path='upload_file' class="form-control" accept="upload/*"/>
                     <c:if test="${not empty modifyCampaignBean.cam_img}">
                         <img src="${root}upload/${modifyCampaignBean.cam_img}" class="img-fluid mt-2" alt="Campaign Image">
                     </c:if>
                  </div>
               
                <div class="form-group">
                     <div class="text-right">
                        <form:button type="submit" class="btn btn-primary">수정하기</form:button>
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
<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>

<script>
    // CKEditor 초기화
    CKEDITOR.replace('cam_intro');
    CKEDITOR.replace('cam_progress');
    CKEDITOR.replace('cam_news');
</script>

</body>
</html>
