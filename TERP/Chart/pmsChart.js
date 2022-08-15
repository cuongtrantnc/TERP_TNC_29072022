$(function () {

    var ajaxcall = function () {
        $.ajax({
            type: "POST",
            url: "Default.aspx/CountPRApproved",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                clearInterval(interval);
            },
            success: function (result) {
                $('#TERPContentPlaceHolder_Default_txtPRApproved').html(result.d);
            }
        })

        $.ajax({
            type: "POST",
            url: "Default.aspx/CountPRRejected",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                clearInterval(interval);
            },
            success: function (result) {
                $('#TERPContentPlaceHolder_Default_txtPRRejected').html(result.d);
            }
        })

        $.ajax({
            type: "POST",
            url: "Default.aspx/CountPRUnApproved",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                clearInterval(interval);
            },
            success: function (result) {
                $('#TERPContentPlaceHolder_Default_txtPRUnapproved').html(result.d);
            }
        })

        $.ajax({
            type: "POST",
            url: "Default.aspx/CountPROnProcess",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                clearInterval(interval);
            },
            success: function (result) {
                $('#TERPContentPlaceHolder_Default_txtPROnProcess').html(result.d);
            }
        })

        $.ajax({
            type: "POST",
            url: "Default.aspx/CountPOApproved",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                clearInterval(interval);
            },
            success: function (result) {
                $('#TERPContentPlaceHolder_Default_txtPOApproved').html(result.d);
            }
        })

        $.ajax({
            type: "POST",
            url: "Default.aspx/CountPORejected",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                clearInterval(interval);
            },
            success: function (result) {
                $('#TERPContentPlaceHolder_Default_txtPORejected').html(result.d);
            }
        })

        $.ajax({
            type: "POST",
            url: "Default.aspx/CountPOUnApproved",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                clearInterval(interval);
            },
            success: function (result) {
                $('#TERPContentPlaceHolder_Default_txtPOUnapproved').html(result.d);
            }
        })

        $.ajax({
            type: "POST",
            url: "Default.aspx/CountPOOnProcess",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                clearInterval(interval);
            },
            success: function (result) {
                $('#TERPContentPlaceHolder_Default_txtPOOnProcess').html(result.d);
            }
        })

        $.ajax({
            type: "POST",
            url: "Default.aspx/CountTotalUnapproved",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                clearInterval(interval);
            },
            success: function (result) {
                $('#TERPContentPlaceHolder_Default_lbTotalUnApprovalValue').html(result.d);
                $('#TERPContentPlaceHolder_Default_lbTotalUnApprovalValueModal').html(result.d);
                
            }
        })

         //--------------------------------------Pie chart------------------------------------------------------
        $.ajax({
            type: "POST",
            url: "Default.aspx/PieChartData",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                clearInterval(interval);
            },
            success: function (result) {
                //console.log(result.d);
                let dataArr = [];
                dataArr = (result.d).split(',');
                //if (dataArr[0] == 0 && dataArr[1] == 0 && dataArr[2] == 0) {
                //    dataArr = [1,1,1];
                //} else {
                //    dataArr = dataArr;
                //}
               
                var pieChartCanvas = $('#pieChart').get(0).getContext('2d');
                var pieChartCanvasModal = $('#pieChartModal').get(0).getContext('2d');

                var pieChartData = {
                    labels: [
                        'Approved PO: ' + dataArr[0],
                        'Unapproved Po > 3 Days: ' + dataArr[1],
                        'Unapproved Po > 7 Days: ' + dataArr[2],
                    ],
                    datasets: [
                        {
                            data: dataArr ,
                            backgroundColor: ['#00a65a', '#f39c12', '#f56954'],
                        }
                    ]
                }
                var pieData = pieChartData;
                var pieOptions = {
                    events: [],
                    legend: {
                        display: true,
                        labels: {
                            fontSize: 15,
                            fontStyle: 'bold'
                        }
                    },
                    animation: false,
                    maintainAspectRatio: false,
                    responsive: true,
                    tooltips: {
                        enabled: false
                    },
                    plugins: {
                        datalabels: {
                            display: true,
                            formatter: (value, ctx) => {
                                let sum = 0;
                                let dataArr = ctx.dataset.data;
                                dataArr.map((data) => {
                                    sum += parseInt(data);
                                });
                                if (sum == 0) {
                                    sum = 1;
                                } else {
                                    sum = sum;
                                }
                                let percentage = "";
                                let data = (value * 100 / sum).toFixed(2);
                                console.log(data);
                                if (data == 0) {
                                    percentage = " ";
                                }
                                else {
                                    percentage = data + "%";
                                }
                                //let percentage = (value * 100 / sum).toFixed(2) + "%";
                                return percentage;
                                //console.log('pie', ctx.dataset.data);
                            },
                            color: 'black',
                        }
                    },
                }

                new Chart(pieChartCanvasModal, {
                    type: 'pie',
                    data: pieData,
                    options: pieOptions
                })

                new Chart(pieChartCanvas, {
                    type: 'pie',
                    data: pieData,
                    options: pieOptions
                })
            }
        })
         //--------------------------------------END Pie chart------------------------------------------------------

         //--------------------------------------Line chart------------------------------------------------------
        $.ajax({
            type: "POST",
            url: "Default.aspx/LineChartData",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                clearInterval(interval);
            },
            success: function (result) {
                let dataArr = [];
                dataArr = (result.d).split(',');
                if (dataArr[0] == 0 && dataArr[1] == 0 && dataArr[2] == 0) {
                    dataArr = [0, 0, 0];
                } else {
                    dataArr = dataArr;
                }
                var maxvalue = (Math.max(...dataArr));
                var lineChartCanvas = $('#lineChart').get(0).getContext('2d');
                var lineChartCanvasModal = $('#lineChartModal').get(0).getContext('2d');

                new Chart(lineChartCanvas, {
                    type: 'line',
                    data: {
                        labels: ['This Month', 'Last Month', 'Last 2 Month'],
                        datasets: [
                            {
                                //backgroundColor: 'rgba(60,141,188,0.9)',
                                borderColor: 'rgba(60,141,188,0.8)',
                                pointRadius: 2,
                                pointColor: '#3b8bba',
                                pointStrokeColor: 'rgba(60,141,188,1)',
                                pointHighlightFill: '#fff',
                                pointHighlightStroke: 'rgba(60,141,188,1)',
                                data: dataArr
                            },
                        ]
                    },
                    options: {
                        events: [],
                        animation: false,
                        plugins: {
                            datalabels: {
                                display: true,
                                anchor: 'end',
                                align: 'right',
                            }
                        },
                        maintainAspectRatio: false,
                        responsive: true,
                        legend: {
                            display: false,
                        },
                        scales: {
                            xAxes: [{
                                gridLines: {
                                    display: true,
                                },
                                ticks: {
                                    fontColor: 'black',
                                    fontSize: 13,
                                    fontStyle: 'bold'
                                }
                            }],
                            yAxes: [{
                                gridLines: {
                                    display: true,
                                },
                                ticks: {
                                    beginAtZero: true,
                                    //max: maxvalue + 10
                                }
                            }]
                        }
                    }
                })

                new Chart(lineChartCanvasModal, {
                    type: 'line',
                    data: {
                        labels: ['This Month', 'Last Month', 'Last 2 Month'],
                        datasets: [
                            {
                                //backgroundColor: 'rgba(60,141,188,0.9)',
                                borderColor: 'rgba(60,141,188,0.8)',
                                pointRadius: 2,
                                pointColor: '#3b8bba',
                                pointStrokeColor: 'rgba(60,141,188,1)',
                                pointHighlightFill: '#fff',
                                pointHighlightStroke: 'rgba(60,141,188,1)',
                                data: dataArr
                            },
                        ]
                    },
                    options: {
                        events: [],
                        animation: false,
                        plugins: {
                            datalabels: {
                                display: true,
                                anchor: 'end',
                                align: 'right',
                                font: {
                                    weight: 'bold',
                                    size: 15
                                },
                            }
                        },
                        maintainAspectRatio: false,
                        responsive: true,
                        legend: {
                            display: false
                        },
                        scales: {
                            xAxes: [{
                                gridLines: {
                                    display: true,
                                },
                                ticks: {
                                    fontColor: 'black',
                                    fontSize: 15,
                                    fontStyle: 'bold'
                                }
                            }],
                            yAxes: [{
                                gridLines: {
                                    display: true,
                                },
                                ticks: {
                                    fontSize: 15,
                                    beginAtZero: true,
                                    //max: maxvalue + 10
                                }
                            }]
                        }
                    }
                })
            }
        })
        //--------------------------------------End Line chart------------------------------------------------------

        //--------------------------------------Bar chart------------------------------------------------------
        $.ajax({
            type: "POST",
            url: "Default.aspx/LineChartData",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                clearInterval(interval);
            },
            success: function (result) {
                let dataArr = [];
                dataArr = (result.d).split(',');
                if (dataArr[0] == 0 && dataArr[1] == 0 && dataArr[2] == 0) {
                    dataArr = [0, 0, 0];
                } else {
                    dataArr = dataArr;
                }
                var maxvalue = (Math.max(...dataArr));
                var barChartCanvas = $('#barChart').get(0).getContext('2d');
                var barChartCanvasModal = $('#barChartModal').get(0).getContext('2d');

                new Chart(barChartCanvas, {
                    type: 'bar',
                    data: {
                        labels: ['This Month', 'Last Month', 'Last 2 Month'],
                        datasets: [
                            {
                                backgroundColor: ['#f56954', '#00a65a', '#f39c12'],
                                borderColor: 'rgba(60,141,188,0.8)',
                                pointRadius: 2,
                                pointColor: '#3b8bba',
                                pointStrokeColor: 'rgba(60,141,188,1)',
                                pointHighlightFill: '#fff',
                                pointHighlightStroke: 'rgba(60,141,188,1)',
                                data: dataArr
                            },
                        ]
                    },
                    options: {
                        events: [],
                        animation: false,
                        plugins: {
                            datalabels: {
                                display: false,
                                anchor: 'end',
                                align: 'right',
                            }
                        },
                        maintainAspectRatio: false,
                        responsive: true,
                        legend: {
                            display: false,
                        },
                        scales: {
                            xAxes: [{
                                gridLines: {
                                    display: true,
                                },
                                ticks: {
                                    fontColor: 'black',
                                    fontSize: 13,
                                    fontStyle: 'bold'
                                }
                            }],
                            yAxes: [{
                                gridLines: {
                                    display: true,
                                },
                                ticks: {
                                    beginAtZero: true,
                                    //max: maxvalue + 10
                                }
                            }]
                        }
                    }
                })

                new Chart(barChartCanvasModal, {
                    type: 'bar',
                    data: {
                        labels: ['This Month', 'Last Month', 'Last 2 Month'],
                        datasets: [
                            {
                                backgroundColor: ['#f56954', '#00a65a', '#f39c12'],
                                borderColor: 'rgba(60,141,188,0.8)',
                                pointRadius: 2,
                                pointColor: '#3b8bba',
                                pointStrokeColor: 'rgba(60,141,188,1)',
                                pointHighlightFill: '#fff',
                                pointHighlightStroke: 'rgba(60,141,188,1)',
                                data: dataArr
                            },
                        ]
                    },
                    options: {
                        events: [],
                        animation: false,
                        plugins: {
                            datalabels: {
                                display: false,
                                anchor: 'end',
                                align: 'right',
                                font: {
                                    weight: 'bold',
                                    size: 15
                                },
                            }
                        },
                        maintainAspectRatio: false,
                        responsive: true,
                        legend: {
                            display: false
                        },
                        scales: {
                            xAxes: [{
                                gridLines: {
                                    display: true,
                                },
                                ticks: {
                                    fontColor: 'black',
                                    fontSize: 15,
                                    fontStyle: 'bold'
                                }
                            }],
                            yAxes: [{
                                gridLines: {
                                    display: true,
                                },
                                ticks: {
                                    fontSize: 15,
                                    beginAtZero: true,
                                    //max: maxvalue + 10
                                }
                            }]
                        }
                    }
                })
            }
        })
        //--------------------------------------End Bar chart------------------------------------------------------
    }

    var interval = setInterval(ajaxcall, 1000);

})

//END of function

