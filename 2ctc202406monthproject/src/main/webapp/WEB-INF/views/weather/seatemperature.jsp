<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath}/" />
<!DOCTYPE html>
<html>
<head>

     <meta charset="UTF-8">
    <title>해수면 온도</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <style>
        .seatempcontainer {
            max-width: 70%;
            margin: auto;
            padding-left: 10px;
            padding-right: 10px;
        }
        .chartcard {
            margin: 20px 0;
            overflow: hidden;
        }
        .chartcard-body {
            padding: 0;
        }
        #chart-container-summer, #chart-container-winter {
            height: 600px;
            width: 100%;
        }
        .text-content {
            margin-top: 40px;
            padding: 20px;
            background-color: #f9f9f9;
        }
        .text-content-bottom {
            margin-top: 80px;
            padding: 20px;
            background-color: #fffff;
        }
        .text-content-bottom h3{
        	font-weight: bold;
 			}
        
        .text-content-image {
            margin-top: 50px;
            height: auto;
            padding: 20px;
            background-color: #f9f9f9;
            display: flex;
            position : center;
        }
        .header-image-container {
            position: relative;
            width: 100%;
            height: 600px;
        }
        .header-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.8; /* 이미지 투명도 */
        }
        .header-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.5); /* 흰색 필터와 투명도 */
        }
        .header-text {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: white;
            font-size: 48px;
            font-weight: bold;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5); /* 텍스트 그림자 효과 */
        }
        .center-bold-text {
            text-align: center;
            font-weight: bold;
        }
        .bold-text {
            font-weight: bold;
            margin-bottom: 20px; /* 아래 마진 추가 */
        }
        .orange-box {
            background-color: #FFA500; /* 귤색 */
            color: white; /* 텍스트 색상 */
            padding: 10px; /* 패딩 */
            margin-bottom: 20px; /* 아래 마진 */
            text-align: center; /* 가운데 정렬 */
            font-weight: bold; /* 볼드체 */
            border-radius: 5px; /* 모서리 둥글게 */
        }
        .row-content {
            display: flex;
            flex-wrap: wrap;
            margin-top: 80px; /* 텍스트 컨테이너와의 간격 추가 */
        }
        .image-slider-container, .text-box-container {
            width: 50%;
            height: auto;
        }
        .text-box-container h4, .text-box-container h5 {
        	font-weight: bold;
        }
        .image-slider {
            width: 100%;
            height: 100%;
        }
        .image-slider img {
            width: 100%;
            height: 100%; 
        }
        .text-box {
            width: 100%;
            height: 100%;
            border: 1px solid #ccc;
            padding: 10px;
            box-sizing: border-box;
            background-color: #f9f9f9; /* 배경색 */
        }
        .campaign-button {
            margin-top: 30px;
            background-color: black;
            color: white;
            padding: 10px 20px;
            text-decoration: none; /* 글씨 밑줄 제거 */
            border-radius: 15px; /* 버튼을 라운드로 만들기 */
            font-size: 24px;
            font-weight: bold;
        }
        .campaign-button:hover {
            text-decoration: none; /* 글씨 밑줄 제거 */
            background-color: darkgray;
            color: black;
        }
        .button-container {
            text-align: center; /* 버튼을 가운데 정렬 */
            margin-bottom: 100px;
        }
    </style>
    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <%-- footer CSS --%>
    <link rel="stylesheet" href="${root}css/top_menu.css">
    <link rel="stylesheet" href="${root}css/bottom_info.css">
    <link rel="stylesheet" href="${root}css/board.css">
</head>
<body>
    <c:import url="/WEB-INF/views/include/top_menu.jsp"/>
    
     <div class="header-image-container">
     <img src="${root}upload/iceberg.png" alt="Header Image" class="header-image">
		 
        <div class="header-text">Ocean Temperature</div>
    </div>
    
     <div class="seatempcontainer container">
        <br>
        <br>
        <h1 class="text-center bold-text">해수온 변화</h1>
        <hr>
        <div class="orange-box">
        	<br>
            <p>화석 연료의 연소, 산업 활동, 농업 및 기타 인간 활동에서 발생하는 이산화탄소와 메탄은 대기에 축적되어 지구 온난화를 촉진합니다. 이로 인해 대기 온도가 상승하고, 그 열이 바다로 흡수됩니다.</p>
			<p>바다는 지구 표면의 약 70%를 차지하며, 대기에서 발생하는 여분의 열을 흡수하는 중요한 역할을 합니다. 온실가스 증가로 인해 대기 온도가 상승하면, 이 열이 바다에 흡수되어 해수 온도가 상승합니다.</p>
        </div>

        <div class="row">
            <aside class="col-12">
                <h4 class="center-bold-text">17~21년 & 22~23년 여름 해수온 그래프</h4>
                <div class="chartcard">
                    <article class="chartcard-body">
                        <div id="chart-container-summer"></div>
                    </article>
                </div>
            </aside>
        </div>
        <div class="row">
            <aside class="col-12">
                <h4 class="center-bold-text">17~21년 & 22~23년 겨울 해수온 그래프</h4>
                <div class="chartcard">
                    <article class="chartcard-body">
                        <div id="chart-container-winter"></div>
                    </article>
                </div>
            </aside>
        </div>

        <div class="row text-content">
            <div class="col-12">
                <h3>◆ 2017-2021년과 2022-2022년 계절 그래프 분석</h3><br>
                <p>전체적으로 해수온이 상승했습니다. 하지만 내려간 지역도 있습니다.</p>
                <p>17-21년 여름 평균 22.76에서 22-23년 여름 평균 23.03로 0.27증가했고, 17-21년 겨울 평균 10.47에서 22-23년 겨울 평균 -0.05하락 했습니다.</p>
            </div>
        </div>
        
         <div class="row text-content-image">
            <div class="col-6 image-slider-container">
                <!-- 이미지 슬라이더를 위한 HTML -->
                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" data-interval="false">
                    <ol class="carousel-indicators">
                        <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>    
                    </ol>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img class="d-block w-100" src="${root}upload/seatemperature_summer.png" alt="First slide">
                        </div>
                        <div class="carousel-item">
                            <img class="d-block w-100" src="${root}upload/seatemperature_winter.png" alt="Second slide">
                        </div>
                    
                    </div>
                    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </div>
            <div class="col-6 text-box-container">
                <h4>◆ 2017-2021년과 2022-2022년 계절 변화</h4><br>
                <p>두미도의 경우 17-21년 평균 기온이 30.61°C → 24.01°C 하락 하였습니다. 이렇게 변화 폭이 큰경우 어장에 변화가 생겨 문제가 생기기도 합니다.</p>
                <p>여름과 겨울의 평균 해수온 차이가 커져 지구 온난화로 인한 기온 양극화 현상이 일어났습니다.</p><br>
                <h5>◆ 기후변화 완화 및 사회경제 발전 정도가 중간 단계를 가정하는 경우</h5>
                <p>2060년에는 우리나라 해수온도는 동해 18.18°C 남해 19.15°C 서해 16.80°C 입니다 2020년 대비 동해 0.51°C 상승 남해 0.25°C 상승 서해 0.59°C 상승합니다.</p>
               	<h5>◆ 어장변화</h5>
                <p>기후 변화의 영향으로 동해에서는 많이 잡히지 않던 고등어, 전갱이 등이 동해에서도 어획량이 증가하고 있습니다. </p>
            </div>
        </div>
        
        <div class="row text-content-bottom">
            <div class="col-12">
                <h3> ◆ 지구 온난화 시대는 끝났다. 지구가 끓는 시대가 시작됐다.</h3><br>
                <p>지구는 빠르게 뜨거워지고 있다. 유엔 산하 세계기상기구(WMO)는 향후 5년 이내로 지구 평균 기온이 산업화 이전(1850~1900)활동 배경 및 목표년) 시기보다 1.5도 이상 높아질 확률이 66%에 달한다고 예측했습니다.</p>
                <p>최근 몇 년간 폭염, 혹한, 폭우, 가뭄 등 극한 기후 현상이 증가하고 있다. 전 세계가 최악의 상황을 피하기 위해 지구 온도 상승 폭을 1.5도 이내로 제한해야만 하며 기후위기에 대응하기 위한 즉각적인 조치가 필요한 상황입니다.</p>
                <p>캠페인으로 기후위기를 늦추는 행동에 동참해 주세요.</p>
            	<br>
            	<br>
            	 <div class="button-container">
            	<a href="${root}campaign/campaignMain" class="campaign-button">참여하기</a>
            	</div>
            </div>
        </div> 
    </div>
    
    <script>
        google.charts.load("current", { packages: ["corechart"] });
        google.charts.setOnLoadCallback(drawCharts);

        function drawCharts() {
            var summerDataPoints = {};
            var winterDataPoints = {};

            <c:forEach var="temp" items="${SeaTemperatureList2017To2021}">
                <c:choose>
                    <c:when test="${temp.season == '여름'}">
                        if (!summerDataPoints['${temp.city}']) summerDataPoints['${temp.city}'] = [null, null];
                        summerDataPoints['${temp.city}'][0] = parseFloat('${temp.figures}');
                    </c:when>
                    <c:when test="${temp.season == '겨울'}">
                        if (!winterDataPoints['${temp.city}']) winterDataPoints['${temp.city}'] = [null, null];
                        winterDataPoints['${temp.city}'][0] = parseFloat('${temp.figures}');
                    </c:when>
                </c:choose>
            </c:forEach>
            <c:forEach var="temp" items="${SeaTemperatureList2022To2023}">
                <c:choose>
                    <c:when test="${temp.season == '여름'}">
                        if (!summerDataPoints['${temp.city}']) summerDataPoints['${temp.city}'] = [null, null];
                        summerDataPoints['${temp.city}'][1] = parseFloat('${temp.figures}');
                    </c:when>
                    <c:when test="${temp.season == '겨울'}">
                        if (!winterDataPoints['${temp.city}']) winterDataPoints['${temp.city}'] = [null, null];
                        winterDataPoints['${temp.city}'][1] = parseFloat('${temp.figures}');
                    </c:when>
                </c:choose>
            </c:forEach>

            var summerDataArray = [];
            for (var city in summerDataPoints) {
                summerDataArray.push([city].concat(summerDataPoints[city]));
            }

            var winterDataArray = [];
            for (var city in winterDataPoints) {
                winterDataArray.push([city].concat(winterDataPoints[city]));
            }

            drawChart(
                "chart-container-summer",
                summerDataArray,
                "Sea Temperatures (Summer 17-23 and 22-23)",
                ['2017-2021 Summer', '2022-2023 Summer']
            );

            drawChart(
                "chart-container-winter",
                winterDataArray,
                "Sea Temperatures (Winter 17-23 and 22-23)",
                ['2017-2021 Winter', '2022-2023 Winter']
            );
        }

        function drawChart(containerId, dataPoints, title, seriesNames) {
            var data = new google.visualization.DataTable();
            data.addColumn("string", "City");
            data.addColumn("number", seriesNames[0]);
            data.addColumn("number", seriesNames[1]);
            data.addRows(dataPoints);

            var options = {
                title: title,
                curveType: "function",
                legend: { position: "bottom" },
                hAxis: { title: "City" },
                vAxis: { title: "SeaTemperature (°C)" },
                width: '100%',
                height: 600,
                chartArea: { width: '85%', height: '70%' },
                series: {
                    0: { color: '#1c91c0' }, // 2017-2021 data in blue
                    1: { color: '#e2431e' }  // 2022-2023 data in red
                }
            };

            var chart = new google.visualization.LineChart(document.getElementById(containerId));
            chart.draw(data, options);
        }
    </script>
   
    <c:import url="/WEB-INF/views/include/bottom_info.jsp"/>
</body>
</html>
