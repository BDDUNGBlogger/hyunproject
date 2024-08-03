<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value="${pageContext.request.contextPath}/" />

<div class="container-campaign">
    <div class="box-campaign">
        <c:forEach var="natural" items="${naturalCampaigns}" varStatus="status">
            <c:if test="${status.index < 2}">
                <div class="item-campaign">
                    <div class="image-campaign">
                        <a href="${root}campaign/campaignDetail?campaignID=${natural.campaignID}">
                            <img src="${root}upload/${natural.cam_img}" alt="${natural.cam_title}">
                        </a>
                    </div>
                    <div class="content-campaign">
                        <h4>${natural.cam_title}</h4>
                        <p>${natural.cam_intro}</p>
                        <a href="${root}campaign/campaignDetail?campaignID=${natural.campaignID}" class="btn-campaign">후원하기</a>
                    </div>
                </div>
            </c:if>
        </c:forEach>
        <c:forEach var="animal" items="${animalCampaigns}" varStatus="status">
            <c:if test="${status.index < 2}">
                <div class="item-campaign">
                    <div class="image-campaign">
                        <a href="${root}campaign/campaignDetail?campaignID=${animal.campaignID}">
                            <img src="${root}upload/${animal.cam_img}" alt="${animal.cam_title}">
                        </a>
                    </div>
                    <div class="content-campaign">
                        <h4>${animal.cam_title}</h4>
                        <p>${animal.cam_intro}</p>
                        <a href="${root}campaign/campaignDetail?campaignID=${animal.campaignID}" class="btn-campaign">후원하기</a>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>