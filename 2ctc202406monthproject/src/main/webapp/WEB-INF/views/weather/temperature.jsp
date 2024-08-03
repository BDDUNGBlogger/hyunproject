<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="root" value="${pageContext.request.contextPath}/" />
<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>기온</title>
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
     <img src="${root}upload/temperature_2.jpg" alt="Header Image" class="header-image">
		 
        <div class="header-text">Temperature</div>
    </div>
    
     <div class="seatempcontainer container">
        <br>
        <br>
        <h1 class="text-center bold-text">기온 변화</h1>
        <hr>
        <div class="orange-box">
        <br>
           <p>산업 활동, 산림 ,벌채, 탄소 배출 등 인간의 활동으로 인해 대기 중 온실 가스 농도가 증가하면서 지구온도가 상승하고 있습니다.</p>
			<p>기온 상승으로 인하여 전세계 각지에서 산불, 화재 등 자연재해가 발생하고 있습니다.</p>
        </div>


        <div class="row">
            <aside class="col-12">
                <h4 class="center-bold-text">17~21년 & 22~23년 여름 기온 그래프</h4>
                <div class="chartcard">
                    <article class="chartcard-body">
                        <div id="chart-container-summer"></div>
                    </article>
                </div>
            </aside>
        </div>
        <div class="row">
            <aside class="col-12">
                <h4 class="center-bold-text">17~21년 & 22~23년 겨울 기온 그래프</h4>
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
                <p>17-21년도 대비 22-23년도 전체 지역 여름 기온 평균은 증가 하였습니다. </p>
                <p>17-21년도 여름 평균 기온 23.7°C에서 22-23년 여름 평균 기온 24.25°C로 상승하였고 17-21년도 겨울 평균 기온 3.49°C에서 22-23년 겨울 평균 3.21°C로 감소 하였습니다.</p>
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
                            <img class="d-block w-100" src="${root}upload/temperature_summer.png" alt="First slide">
                        </div>
                        <div class="carousel-item">
                            <img class="d-block w-100" src="${root}upload/temperature_winter.png" alt="Second slide">
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
                <p>모든 도시에서 평균적으로 여름 기온은 상승하였습니다. 겨울 기온은 전체적으로 낮아졌으며 태백에서 가장 큰차이로 낮아 졌습니다.</p>
                <p>여름과 겨울의 기온차가 증가 하였고, 기온 상승으로 인하여 가뭄, 건조한 날씨, 강한 바람으로 산불 피해가 증가 되고 있습니다.</p><br>
               
                <p>기상청에 따르면 2023년 우리나라의 평균 기온은 13.7ºC로. 최고 기온이었던 2016년 13.4ºC를 넘어섰고 이는 평년 기온보다 1.2ºC높은 수치입니다. 전국적으로 23개 지역에서 역대 최고 기온 기록을 경신했고, 9개 지역에서는 역대 최다 강수량 기록을 경신하기도 했습니다. 3월에는 이미 4월 하순 수준의 더위가 찾아왔고 더위가 한풀 꺾여야 하는 9월에도 높은 기온이  유지되면서 열대야 현상이 나타났습니다. 또한, 1월과 11월,12월에는 유독 일교차가 커서 하루에 가장 낮은 온도와 높은 온도의 차이가 20ºC까지 벌어지는 날들이 다수 관측되었습니다.</p>
               	
            </div>
        </div>
        
        <div class="row text-content-bottom">
            <div class="col-12">
                <h3> ◆ 기후 재난의 시대 대응과 회복을 위한 활동이 필요합니다.</h3><br>
                <p>올해 여름이 예사롭지 않게 시작되고 있습니다. 6월 초부터 벌써 폭염 주의보가 찾아왔고, 지난 10일엔 대구 등 영남 지역 곳곳에서 올해 첫 폭염주의보가 내려졌습니다. 빠르게 찾아온 폭염은 올여름 무더위의 경고처럼 들립니다.</p>
                <p>기후위기로 인해 지구의 온도가 올라가고 있다는 것은 이미 잘 알려진 사실입니다. 온실가스 배출로 인한 기온 상승은 이제 기후가 변화하는 수준을 넘어 위기 상황에 놓이게 되었고, 그래서 '기후변화'가 아닌 '기후위기'로 불리기 시작했죠. 영국의 한 미디어는 기후변화라는 단어로는 시급성을 담을 수 없기에 기후위기로 명칭을 통일하기도 했습니다. 안토니우 구테흐스 유엔 사무총장은 '끓는 지구의 시대'가 시작되었다는 발언도 했죠.</p>
                <p>기후 재난은 이제 우리의 일상이 되었습니다. 기후재난으로부터 안전한 사회를 만들기 위해 여러분의 관심과 참여가 필요합니다!</p>
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

            <c:forEach var="temp" items="${Temperatures2017To2021}">
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
            <c:forEach var="temp" items="${Temperatures2022To2023}">
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
                "Temperatures (Summer 17-23 and 22-23)",
                ['2017-2021 Summer', '2022-2023 Summer']
            );

            drawChart(
                "chart-container-winter",
                winterDataArray,
                "Temperatures (Winter 17-23 and 22-23)",
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
                vAxis: { title: "Temperature (°C)" },
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
