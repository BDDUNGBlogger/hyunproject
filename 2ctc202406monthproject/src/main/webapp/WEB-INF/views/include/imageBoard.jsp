<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}/"/>


<div class="total" style="margin-top:100px">
    <div class="wrapper">
        <a href="${root}weather/surfaceofthesea" id="rain"><h2>Surface of Sea</h2><img src="upload/seaofsurface.jpg" class="rain-img"></a>
    </div>

    <div class="wrapper">
        <a href="${root}weather/seatemperature" id="rain"><h2>Ocean Temperatures</h2><img src="upload/seatemperature.jpg" class="ocean-img"></a>
    </div>

    <div class="wrapper">
        <a href="${root}weather/rainfall" id="rain"><h2>Rain fall</h2><img src="upload/rainfall.jpg" class="rainfall-img"></a>
    </div>

    <div class="wrapper">
        <a href="${root}weather/temperature" id="rain"><h2>Temperature</h2><img src="upload/temperature.jpg" class="temperature-img"></a>
    </div>
</div>