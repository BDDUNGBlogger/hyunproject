<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="root" value="${pageContext.request.contextPath}/" />
<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>강수량</title>
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
     <img src="${root}upload/rain.jpg" alt="Header Image" class="header-image">
		 
        <div class="header-text">Rainfall</div>
    </div>
    
     <div class="seatempcontainer container">
        <br>
        <br>
        <h1 class="text-center bold-text">강수량 변화</h1>
        <hr>
        <div class="orange-box">
           <br>
           <p>따뜻해진 대기는 더 많은 수증기를 함유하여 강수량이 증가합니다.</p>
           <p>온도가 상승함에 따라 바다, 호수, 강 등에서의 증발량이 증가하고, 대기 중의 수증기 양이 늘어납니다. 이는 강수량의 증가로 이어집니다.</p>
        </div>

        <div class="row">
            <aside class="col-12">
                <h4 class="center-bold-text">17~21년 & 22~23년 여름 강수량 그래프</h4>
                <div class="chartcard">
                    <article class="chartcard-body">
                        <div id="chart-container-summer"></div>
                    </article>
                </div>
            </aside>
        </div>
        <div class="row">
            <aside class="col-12">
                <h4 class="center-bold-text">17~21년 & 22~23년 겨울 강수량 그래프</h4>
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
                <p>여름에는 강수량 평균이 증가하고 겨울에는 강수량 평균이 감소했습니다.</p>
                <p>17-21 여름 평균 213.43mm 에서 22-23 여름 평균 260.6으로 47.17mm 증가 하였고, 17-21 겨울 평균 43.22mm에서 22-23 겨울 평균 33.03mm로 10.19mm 감소 하였습니다. </p>
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
                            <img class="d-block w-100" src="${root}upload/rainfall_summer.png" alt="First slide">
                        </div>
                        <div class="carousel-item">
                            <img class="d-block w-100" src="${root}upload/rainfall_winter.png" alt="Second slide">
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
                <p>모든 도시에서 여름에는 평균 강수량이 증가하였고, 겨울에는 평균 강수량이 감소 하였습니다.</p>
                <p>특히 여름 평균 강수량이 대폭 증가한 서울, 인천, 파주, 양평, 이천, 대전 등의 도시는 도심이 물에 잠기기도 대전의 경우 낮은 지대의 아파트는 지상 주차장이 물에 잠겨 수해 피해를 입었습니다. </p><br>
                <br>
                <p>평균 강수량에서는 드러나지 않더라도 2023년 전라도 지역은 극심한 가뭄이 일어났고, 포항에서는 태풍으로 집을 잃거나 사람들이 인명피해가 이따라 발생했습니다. 이러한 강수량 변화는 농업, 수자원 관리, 재난, 도시 계획 등 다양한 분야에 큰 영향을 미치며, 이에 대한 적응과 대응이 중요합니다.</p>
            </div>
        </div>
        
        <div class="row text-content-bottom">
            <div class="col-12">
                <h3> ◆ 전 세계가 직면한 기후재난</h3><br>
                <p>전 세계 곳곳에선 이미 폭염과 홍수 등으로 인한 피해가 심각합니다. 특히 아시아 국가들의 피해가 크게 나타나고 있습니다. 태국, 필리핀은 최고기온이 40℃가 넘는 것이 일상이 되어 버렸고, 인도는 50℃가 넘는 폭염으로, 스리랑카에선 갑작스러운 홍수로 인해 많은 인명피해가 발생했습니다.</p>
                <p>호주, 미국, 캐나다에서는 연례행사처럼 대규모 산불이 발생하고 그 빈도도 증가하고 있습니다. 지난해 캐나다에서 산불이 발생했을 땐 한국을 포함한 많은 국가에서 소방 지원을 했습니다. 기후재난은 한 국가 안에서 관리할 수 있는 수준을 넘어서고 있음을 보여주고 있습니다.</p>
                <p>이제 기후위기는 홍수, 폭염, 폭우, 태풍 등과 같은 다양한 재난 형태로 나타나 많은 지역에 큰 피해를 입히고 있습니다. 더욱 심각한 것은 기후위기를 위해 통제할 예측이 불가능하다는 점입니다. 기후위기로 인한 재난의 빈도와 강도는 점점 증가하고 있으며, 이에 대한 대비와 대응이 시급히 필요합니다.</p>
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

            <c:forEach var="temp" items="${RainfallBeans2017To2021}">
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
            <c:forEach var="temp" items="${RainfallBeans2022To2023}">
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
                "Rainfall (Summer 17-23 and 22-23)",
                ['2017-2021 Summer', '2022-2023 Summer']
            );

            drawChart(
                "chart-container-winter",
                winterDataArray,
                "Rainfall (Winter 17-23 and 22-23)",
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
                vAxis: { title: "Rainfall (mm)" },
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
