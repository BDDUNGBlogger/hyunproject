<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var='root' value='${pageContext.request.contextPath}/' />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>관리자 대시보드</title>
<link rel="stylesheet" href="${root}css/admin.css">
<link rel="stylesheet" href="${root}css/yj.css">
<script src="https://kit.fontawesome.com/4be7b8dcc6.js"
   crossorigin="anonymous"></script>

<script
   src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
   crossorigin="anonymous"></script>
<script defer src="${root}js/common.js"></script>
<%-- <script defer src="${root}js/adminboard.js"></script> --%>
<script>
   var root = "${root}";
</script>
<style>
.clock-container {
   display: flex;
   justify-content: center; /* 수평 중앙 정렬 */
   align-items: center; /* 수직 중앙 정렬 */
   margin-top: 20px;
   font-size: 55px;
   background: black;
   color: red;
   height: 80px;
}
#environment-menu{
   background: gray;
    justify-content: center;
    display: flex;
    width: 150px;
    margin-left: 10px;

}
/* <c:import url="/WEB-INF/views/include/top_menu.jsp"/>
<c:import url="/WEB-INF/views/include/bottom_info.jsp"/> */
#animals-menu{
   background: gray;
    justify-content: center;
    display: flex;
    width: 150px;
    margin-left: 10px;
}

#notices-menu{
   background: gray;
    justify-content: center;
    display: flex;
    width: 150px;
    margin-left: 10px;
}

#inquiries-menu{
   background: gray;
    justify-content: center;
    display: flex;
    width: 150px;
    margin-left: 10px;
}



</style>
</head>
<body>
   <div class="container">
      <aside class="sidebar">
         <a href="${root}admin/adminMain" class="admin">
            <h2>관리자</h2>
         </a>
         <ul>
         <li><a href="${root}main" id="allmember-submenu">홈</a></li>
            <li><a href="${root}admin/Allmember" id="allmember-submenu">회원
                  목록</a></li>
            <li><a href="${root}admin/Allcampaign" id="allcampaign-submenu">캠페인
                  목록</a></li>
            <li><a href="${root}admin/Allproduct" id="allproduct-submenu">상품
                  목록</a></li>
            <li><a href="${root}admin/Allnotice" id="allnotice-submenu">게시물
                  목록</a></li>
            <li class="menu-item"><a href="#" id="campaign-management-menu">캠페인
                  관리</a>
               <ul class="submenu">
                  <li><a href="${root}admin/environment" id="environment-menu">환경</a></li>
                  <li><a href="${root}admin/animals" id="animals-menu">동물</a></li>
               </ul></li>
            <li class="menu-item"><a href="#" id="board-management-menu">통계</a>
               <ul class="submenu">
                  <li><a href="${root}admin/donation" id="notices-menu">후원</a></li>
                  <li><a href="${root}admin/recently" id="inquiries-menu">최근동향</a></li>
               </ul></li>
         </ul>
      </aside>
      <main class="main-content">
         <header class="navbar">
            <h1>관리자 대시보드</h1>
            <div class="user-menu">
               <span>환영합니다, 관리자님</span>
            </div>
         </header>
         
         <section>
            <div class="dashboard">
               <div class="dash_flex_box">
                  <a href="${root}admin/Allmember" class="comm">
                     <div class="cont_box cont1">
                        <div class="cont_flex">
                           <i class="fa-solid fa-users"></i>
                           <div>
                              <div>${membercount}</div>
                              <div>회원수</div>
                           </div>
                        </div>
                        <div>
                           전체 회원 <span></span>
                        </div>
                     </div>
                  </a> <a href="${root}admin/Allproduct" class="comm">
                     <div class="cont_box cont2">
                        <div class="cont_flex">
                           <i class="fa-solid fa-cart-shopping"></i>
                           <div>
                              <div>${productcount}</div>
                              <div>상품</div>
                           </div>
                        </div>
                        <div>
                           상품 등록 <span></span>
                        </div>
                     </div>
                  </a> <a href="${root}admin/donation" class="comm">
                     <div class="cont_box cont3">
                        <div class="cont_flex">
                           <i class="fa-solid fa-hand-holding-dollar"></i>
                           <div>
                              <div>${donationcount}</div>
                              <div>후원</div>
                           </div>
                        </div>
                        <div>
                           후원 관리 <span></span>
                        </div>
                     </div>
                  </a> <a href="${root}admin/Allcampaign" class="comm">
                     <div class="cont_box cont4">
                        <div class="cont_flex">
                           <i class="fa-solid fa-heart-pulse"></i>
                           <div>
                              <div>${campaigncount}</div>
                              <div>캠페인</div>
                           </div>
                        </div>
                        <div>
                           캠페인 관리 <span></span>
                        </div>
                     </div>
                  </a>
               </div>
               <div class="bott_box">
                  <div class="left_box">
                     <div class="left_cont">

                        <div>최근 게시물</div>

                        <c:forEach var="board" items="${top3BoardPosts}">
                           <div class="root">
                              <li><a
                                 href="${root}board/read?board_IDX=${board.board_IDX}&noticeID=${board.noticeID}">${board.title}</a></li>
                           </div>
                        </c:forEach>

                     </div>
                     <div class="left_cont">
                        <div>최근 캠페인</div>

                        <c:forEach var="campaign" items="${top3Campaigns}">
                           <div class="root">
                              <li><a
                                 href="${root}campaign/campaignDetail?campaignID=${campaign.campaignID}">${campaign.cam_title}</a></li>
                           </div>
                        </c:forEach>
                     </div>
                     <div class="left_cont">
                        <div>최근 가입한 회원</div>

                        <c:forEach var="user" items="${top3create_User}">
                           <div class="root">
                              <li>이름: ${user.name}               가입날짜 : (${user.create_date})</li>
                           </div>
                        </c:forEach>

                     </div>
                     

                  </div>
                  <div class="right_box">
                     <div class="right_cont Rcont1">
                        <div>후원 TOP3</div>
                        <div>
                           <div class="inner_cont">
                              <div class="rank_box">
                                 <c:forEach var="donor" items="${top3donor}">
                                    <c:choose>
                                       <c:when test="${donor == top3donor[1]}">
                                          <div class="silver">
                                             <i class="fa-solid fa-trophy fa-5x"></i>
                                             <div>2등 ${donor.name}</div>
                                          </div>
                                       </c:when>
                                       <c:when test="${donor == top3donor[0]}">
                                          <div class="gold">
                                             <i class="fa-solid fa-trophy fa-6x"></i>
                                             <div>1등 ${donor.name}</div>
                                          </div>
                                       </c:when>
                                       <c:when test="${donor == top3donor[2]}">
                                          <div class="bronze">
                                             <i class="fa-solid fa-trophy fa-4x"></i>
                                             <div>3등 ${donor.name}</div>
                                          </div>
                                       </c:when>
                                    </c:choose>
                                 </c:forEach>
                              </div>
                           </div>
                        </div>
                     </div>
                     <div class="right_cont Rcont2">
                        <div>후원자 목록</div>
                        <div>
                           <div class="inner_cont">
                              <div class="rank_list">
                                 <c:forEach var="donoruser" items="${top3donation}" varStatus="status">
                                       <c:if  test="${status.index<3}">
                                          <div>후원자 : 솔데스크 후원 금액:
                                             <fmt:formatNumber value="${donoruser.cam_amount}" type="currency" currencySymbol="₩"/>  </div>
                                      </c:if>
                                    </c:forEach>
                              
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>

            </div>
         </section>
      </main>
   </div>
</body>
</html>