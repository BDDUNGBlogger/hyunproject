<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="root" value="${pageContext.request.contextPath}/" />
<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>해수면</title>
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
     <img src="${root}upload/surfaceofthesea.jpg" alt="Header Image" class="header-image">
		 
        <div class="header-text">Surface of Sea</div>
    </div>
    
     <div class="seatempcontainer container">
        <br>
        <br>
        <h1 class="text-center bold-text">해수면(조위) 변화</h1>
        <hr>
        <div class="orange-box">
        <br>
            <p>산업 활동, 산림 ,벌채, 탄소 배출 등 인간의 활동으로 인해 대기 중 온실 가스 농도가 증가하면서 지구온도가 상승하고 있습니다.</p>
			<p>지구 온난화로 인해 빙화와 빙산이 녹아 해양에 추가적인 물이 유입되어 해수면이 상승하고, 바닷물의 열팽창으로 해수면이 상승하고 있습니다.</p>
        </div>

        <div class="row">
            <aside class="col-12">
                <h4 class="center-bold-text">93~97년 & 13~17년 조위 그래프</h4>
                <div class="chartcard">
                    <article class="chartcard-body">
                        <div id="chart-container-ocean"></div>
                    </article>
                </div>
            </aside>
        </div>
        
        <div class="row text-content">
            <div class="col-12">
                <h3>◆ 1993-1997년과 2013-2017년 조위 비교 분석</h3><br>
                <p>상기 그래프에 나온 선별된 도시 93-97년 평균 166.5075에서 13-17년 평균 175.431로 평균적으로 조위가 8.9235 증가했습니다.</p>
                <p>그래프에 표기되어 있지 않은 전국의 조위 관측 도시들의 평균은 93-97년 평균 179.8976에서 13-17년 평균 187.8148로 7.9172 증가했습니다.</p>
            </div>
        </div>
        
         <div class="row text-content-image">
            <div class="col-6 image-slider-container">
                <!-- 이미지 슬라이더를 위한 HTML -->
                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" data-interval="false">
                    <ol class="carousel-indicators">
                        <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                            
                    </ol>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img class="d-block w-100" src="${root}upload/surfaceofthesea.png" alt="First slide">
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
                <h4>◆ 1993-1997년과 2013-2017년 조위 평균 변화</h4><br>
                <p>모든 도시에서 조위가 전반적으로 상승했습니다. 특히 울릉도의 변화량이 가장 큽니다.</p>
                <p>선별된 도시 연평균과 모든 도시 평균이 모두 상승하여 기후변화가 광범위하게 영향을 미쳤습니다.</p><br>
                <h5>◆ 현재 추세로 저감 없이 온실가스가 배출되는 경우</h5>
                <p>2050년에는 한반도 해수면이 0.4m 상승하여 전국침수인구는 약 4037명(총 인구의 0.01%)이 침수될 예정이며 아파트 약 1층미만 높이가 침수됩니다. 침수면적은 256.80㎢ 이며 여의도 면적대비 88.55배 입니다.</p>
               	<h5>◆ 온실가스 저감 정책이 상당히 실현되는 경우</h5>
                <p>2050년에는 한반도 해수면이 0.34m 상승하여 전국침수인구는 약 3,448명(총 인구의 0.01%)이 침수될 예정이며 아파트 약 1층미만 높이가 침수됩니다. 침수면적은 242.86㎢ 이며 여의도 면적대비 87.75배 입니다.</p>
            </div>
        </div>
        
        <div class="row text-content-bottom">
            <div class="col-12">
                <h3> ◆ 숨막히는 폭염, 이제는 '기후재난'을 이야기 할 때</h3><br>
                <p>올해 여름이 예사롭지 않게 시작되고 있습니다. 6월 초부터 벌써 폭염 주의보가 찾아왔고, 지난 10일엔 대구 등 영남 지역 곳곳에서 올해 첫 폭염주의보가 내려졌습니다. 빠르게 찾아온 폭염은 올여름 무더위의 경고처럼 들립니다.</p>
                <p>기후위기로 인해 지구의 온도가 올라가고 있다는 것은 이미 잘 알려진 사실입니다. 온실가스 배출로 인한 기온 상승은 이제 기후가 변화하는 수준을 넘어 위기 상황에 놓이게 되었고, 그래서 '기후변화'가 아닌 '기후위기'로 불리기 시작했죠. 영국의 한 미디어는 기후변화라는 단어로는 시급성을 담을 수 없기에 기후위기로 명칭을 통일하기도 했습니다. 안토니우 구테흐스 유엔 사무총장은 '끓는 지구의 시대'가 시작되었다는 발언도 했죠.</p>
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
        var oldDataPoints = {};
        var newDataPoints = {};

        <c:forEach var="temp" items="${OceanofSurface1993To1997}">
            if (!oldDataPoints['${temp.city}']) oldDataPoints['${temp.city}'] = [null, null];
            oldDataPoints['${temp.city}'][0] = parseFloat('${temp.figures}');
        </c:forEach>

        <c:forEach var="temp" items="${OceanofSurface2013To2017}">
            if (!newDataPoints['${temp.city}']) newDataPoints['${temp.city}'] = [null, null];
            newDataPoints['${temp.city}'][1] = parseFloat('${temp.figures}');
        </c:forEach>

        var dataArray = [];
        for (var city in oldDataPoints) {
            if (newDataPoints[city]) {
                dataArray.push([city, oldDataPoints[city][0], newDataPoints[city][1]]);
            } else {
                dataArray.push([city, oldDataPoints[city][0], null]);
            }
        }

        drawChart(
            "chart-container-ocean",
            dataArray,
            "Ocean of Surface (1993-1997 and 2013-2017)",
            ['1993-1997', '2013-2017']
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
            vAxis: { title: "Ocean of Surface (cm/s)" },
            width: '100%',
            height: 600,
            chartArea: { width: '85%', height: '70%' },
            series: {
                0: { color: '#1c91c0' }, // 1993-1997 data in blue
                1: { color: '#e2431e' }  // 2013-2017 data in red
            }
        };

        var chart = new google.visualization.LineChart(document.getElementById(containerId));
        chart.draw(data, options);
    }
</script>
   
    <c:import url="/WEB-INF/views/include/bottom_info.jsp"/>
</body>
</html>
