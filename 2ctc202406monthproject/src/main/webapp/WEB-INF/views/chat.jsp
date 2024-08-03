<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ChatGPT Response</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="${root}css/top_menu.css" />
<link rel="stylesheet" href="${root}css/chat.css" />
<link rel="stylesheet" href="${root}css/bottom_info.css" />
</head>
<body>
<c:import url="/WEB-INF/views/include/top_menu.jsp"/> 
    <div class="chatbot-container">
        <h1>날씨 ChatBot</h1>
        <form action="${root}chat" method="get">
            <div class="chatbot-form-group">
                <label for="prompt">Enter your prompt:</label>
                <input type="text" class="chatbot-form-control" id="prompt" name="prompt" required>
                <p/>
            </div>
            <button type="submit" class="btn btn-dark">Submit</button>
        </form>
        <div class="chatbot-mt-4 chatbot-response">
            <h3>Response:</h3>
            <p>${response}</p>
        </div>
    </div>
<c:import url="/WEB-INF/views/include/bottom_info.jsp"/>
</body>
</html>
