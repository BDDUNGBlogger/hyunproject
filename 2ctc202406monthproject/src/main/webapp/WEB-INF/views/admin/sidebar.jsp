<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value='${pageContext.request.contextPath}/' />
<script defer src="${root}js/common.js"></script>
<script defer src="${root}js/adminboard.js"></script>
<aside class="sidebar">
    <a href="${root}admin/adminMain" class="admin">
        <h2>관리자</h2>
    </a>
    <ul>
    	<li><a href="${root}main" id="allmember-submenu">홈</a></li>
        <li><a href="${root}admin/Allmember" id="allmember-submenu">회원 목록</a></li>
        <li><a href="${root}admin/Allcampaign" id="allcampaign-submenu">캠페인 목록</a></li>
        <li><a href="${root}admin/Allproduct" id="allproduct-submenu">상품 목록</a></li>
        <li><a href="${root}admin/Allnotice" id="allnotice-submenu">게시물 목록</a></li>
        <li class="menu-item"><a href="#" id="campaign-management-menu">캠페인 관리</a>
            <ul class="submenu">
                <li><a href="${root}admin/environment" id="environment-menu">환경</a></li>
                <li><a href="${root}admin/animals" id="animals-menu">동물</a></li>
            </ul>
        </li>
        <li class="menu-item"><a href="#" id="board-management-menu">통계</a>
            <ul class="submenu">
                <li><a href="${root}admin/donation" id="notices-menu">후원</a></li>
                <li><a href="${root}admin/recently" id="inquiries-menu">최근동향</a></li>
            </ul>
        </li>
    </ul>
</aside>

