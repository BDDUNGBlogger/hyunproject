<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var='root' value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>campaignDetail</title>
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link href="${root}css/campaignDetail.css" rel="stylesheet" />
    <link href="${root}css/top_menu.css" rel="stylesheet" />
    <link href="${root}css/bottom_info.css" rel="stylesheet" />
    <link href="${root}css/campaignMain.css" rel="stylesheet" />
</head>
<body>
    <!-- 상단 메뉴 부분 -->
    <div style="margin-bottom: 100px;">
        <c:import url="/WEB-INF/views/include/top_menu.jsp" />
    </div>

    <!-- support Category -->
    <div class="container mt-3 support-category">
        <div class="row centered-buttons">
            <div class="col-auto">
                <a href="${root}campaign/campaignMain" class="btn round-button ${activePage == 'main' ? 'active' : 'inactive'}">전체</a>
                <a href="${root}campaign/campaignNatural" class="btn round-button ${activePage == 'natural' ? 'active' : 'inactive'}">환경</a>
                <a href="${root}campaign/campaignAnimal" class="btn round-button ${activePage == 'animal' ? 'active' : 'inactive'}">동물</a>
            </div>
        </div>
    </div>

    <div class="container mt-5" style="margin-top: 50px">
        <div class="row">
            <div class="col-md-8">
                <img src="${root}upload/${readCampaignBean.cam_img}" class="img-fluid rounded">
            </div>
            <div class="col-md-4">
                <div class="donation-info">
                    <h5># ${readCampaignBean.category}</h5>
                    <h3>${readCampaignBean.cam_title}</h3>
                    <p class="amount">
                        <fmt:formatNumber value="${readCampaignBean.current_amount}" type="currency" currencySymbol="₩" />
                        <small>목표 <fmt:formatNumber value="${readCampaignBean.goal_amount}" type="currency" currencySymbol="₩" /></small>
                    </p>
                    <div class="progress">
                        <div class="progress-bar" role="progressbar" style="width: ${readCampaignBean.current_amount / readCampaignBean.goal_amount * 100}%" aria-valuenow="${readCampaignBean.current_amount / readCampaignBean.goal_amount * 100}" aria-valuemin="0" aria-valuemax="100">
                            ${readCampaignBean.current_amount / readCampaignBean.goal_amount * 100}% 달성
                        </div>
                    </div>
                    <p class="remaining-days">${remainingDays}일 남음</p>
                    <p class="participation-info">
                        총 <strong>${readCampaignBean.donor_count}명</strong>이 참여중입니다.<br> 기부 (${readCampaignBean.donor_count}명):
                        <fmt:formatNumber value="${readCampaignBean.current_amount}" type="currency" currencySymbol="₩" />
                    </p>
                    <button class="btn btn-primary btn-lg btn-block" data-toggle="modal" data-target="#donationModal">기부하기</button>
                    <p class="social-info">기부금은 100% 단체에 전달됩니다.</p>
                </div>
            </div>
        </div>
        <div class="row mt-5">
            <div class="col-12">
                <ul class="nav nav-tabs">
                    <li class="nav-item"><a class="nav-link active" href="#intro" data-toggle="tab">모금소개</a></li>
                    <li class="nav-item"><a class="nav-link" href="#progress" data-toggle="tab">기부현황</a></li>
                    <li class="nav-item"><a class="nav-link" href="#news" data-toggle="tab">소식</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="intro">
                        <h4>${readCampaignBean.cam_title}</h4>
                         <p><c:out value="${introWithBreaks}" escapeXml="false" /></p>
                    </div>
                    <div class="tab-pane" id="progress">
                        <h5>기부 내역</h5>
                        <c:forEach var="donation" items="${donations}">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <p><strong>${donation.maskedUserID}</strong>님이</p>
                                    <p><fmt:formatNumber value="${donation.cam_amount}" type="currency" currencySymbol="₩" />를 기부하셨습니다.</p>
                                    <p><fmt:formatDate value="${donation.donation_date}" pattern="yyyy-MM-dd HH:mm" /></p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="tab-pane" id="news">
                         <p><c:out value="${newsWithBreaks}" escapeXml="false" /></p>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-5">
            <div class="col-12">
                <h5>모금함 상세정보</h5>
                <div class="card">
                    <div class="card-body">
                        <ul class="list-unstyled">
                            <li>프로젝트팀: ${readCampaignBean.cam_host}</li>
                            <li>모금기간: ${readCampaignBean.start_date} ~ ${readCampaignBean.end_date}</li>
                            <li>사업기간: ${readCampaignBean.start_date} ~ ${readCampaignBean.end_date}</li>
                            <li>영수증 발급기관: 사랑의열매 사회복지공동모금회</li>
                        </ul>
                        <p>본 모금은 사랑의열매 사회복지공동모금회에서 사업 검토 및 기부금 집행, 사후관리를 담당하고 있습니다.</p>
                        
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-5">
            <div class="col-12">
                <!-- Added Buttons Section -->
                <c:if test="${loginUserBean.rolecd == 'M'}">
                    <div class="mb-3">
                        <button type="button" class="btn btn-primary" onclick="location.href='${root}campaign/campaign_modify?campaignID=${readCampaignBean.campaignID}'">수정</button>
                        <button type="button" class="btn btn-primary" onclick="location.href='${root}campaign/campaign_delete?campaignID=${readCampaignBean.campaignID}'">삭제</button>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Donation Modal -->
        <c:import url="/WEB-INF/views/campaign/donationModal.jsp" />

        <!-- 하단메뉴 -->
        <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
</body>
</html>
