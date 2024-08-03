document.addEventListener("DOMContentLoaded", function () {
    function initializeTemperatureChart() {
        var ctx = document.getElementById("temperatureAreaChart").getContext("2d");
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ["January", "February", "March", "April", "May", "June", "July"],
                datasets: [{
                    label: "기온 변화",
                    data: [30, 25, 35, 28, 32, 30, 29],
                    borderColor: "rgba(75, 192, 192, 1)",
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }

    function initializeSeaLevelChart() {
        var ctx = document.getElementById("seaLevelAreaChart").getContext("2d");
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ["January", "February", "March", "April", "May", "June", "July"],
                datasets: [{
                    label: "해수면 변화",
                    data: [1.5, 1.6, 1.7, 1.8, 1.7, 1.6, 1.7],
                    borderColor: "rgba(153, 102, 255, 1)",
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }

    function initializePrecipitationChart() {
        var ctx = document.getElementById("precipitationAreaChart").getContext("2d");
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ["January", "February", "March", "April", "May", "June", "July"],
                datasets: [{
                    label: "강수량 변화",
                    data: [120, 130, 140, 135, 145, 150, 160],
                    borderColor: "rgba(54, 162, 235, 1)",
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }

    function initializeSeaTemperatureChart() {
        var ctx = document.getElementById("seaTemperatureAreaChart").getContext("2d");
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ["January", "February", "March", "April", "May", "June", "July"],
                datasets: [{
                    label: "해수면 온도 변화",
                    data: [15, 16, 17, 18, 17, 16, 15],
                    borderColor: "rgba(255, 159, 64, 1)",
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }

    // 차트 초기화
    initializeTemperatureChart();
    initializeSeaLevelChart();
    initializePrecipitationChart();
    initializeSeaTemperatureChart();
});
