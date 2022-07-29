$(function () {

//------------------------------------Vertical chart------------------------------------------------------

    Date.prototype.getWeek = function (dowOffset) {
        /*getWeek() was developed by Nick Baicoianu at MeanFreePath: http://www.meanfreepath.com */

        dowOffset = typeof (dowOffset) == 'number' ? dowOffset : 0; //default dowOffset to zero
        var newYear = new Date(this.getFullYear(), 0, 1);
        var day = newYear.getDay() - dowOffset; //the day of week the year begins on
        day = (day >= 0 ? day : day + 7);
        var daynum = Math.floor((this.getTime() - newYear.getTime() -
            (this.getTimezoneOffset() - newYear.getTimezoneOffset()) * 60000) / 86400000) + 1;
        var weeknum;
        //if the year starts before the middle of a week
        if (day < 4) {
            weeknum = Math.floor((daynum + day - 1) / 7) + 1;
            if (weeknum > 52) {
                nYear = new Date(this.getFullYear() + 1, 0, 1);
                nday = nYear.getDay() - dowOffset;
                nday = nday >= 0 ? nday : nday + 7;
                /*if the next year starts before the middle of
                  the week, it is week #1 of that year*/
                weeknum = nday < 4 ? 1 : 53;
            }
        }
        else {
            weeknum = Math.floor((daynum + day - 1) / 7);
        }
        return weeknum;
    };

    var verticalChartCanvas = $('#verticalChart').get(0).getContext('2d');
    var verticalChartCanvasModal = $('#verticalChartModal').get(0).getContext('2d');

    new Chart(verticalChartCanvas, {
        type: 'bar',
        data: {
            labels: ["W" + new Date('2013-02-01').getWeek(), "W" + new Date('2013-03-01').getWeek(), "W" + new Date('2013-04-01').getWeek(), "W" + new Date('2013-05-01').getWeek()],
            datasets: [
                {
                    label: "CC# 111111",
                    data: [0, 20, 20, 0],
                    backgroundColor: '#f56954',
                    order: 1,
                },
                {
                    label: "CC# 222222",
                    data: [0, 0, 0, 10],
                    backgroundColor: '#00a65a',
                    order: 1,
                },
                {
                    label: "CC# 333333",
                    data: [10, 0, 0, 0],
                    backgroundColor: '#f39c12',
                    order: 1,
                },
                {
                    label: "CC# 444444",
                    data: [0, 0, 10, 0],
                    backgroundColor: '#00c0ef',
                    order: 1,
                },
                {
                    label: "CC# 454545",
                    data: [0, 0, 0, 10],
                    backgroundColor: '#3c8dbc',
                    order: 1,
                },
                {
                    label: 'Demand',
                    borderColor: 'orange',
                    data: [20, 40, 40, 15],
                    type: 'line',
                    fill: false,
                    order: 0,
                    borderDash: [5, 5],
                }
            ]
        },
        options: {
            annotation: {
                annotations: [
                    {
                        id: 'maxcapacity',
                        type: 'line',
                        mode: 'horizontal',
                        scaleID: 'y-axis-0',
                        value: 90,
                        borderColor: 'red',
                        borderWidth: 3,
                        borderDash: [5, 5],
                        label: {
                            enabled: true,
                            content: 'Max Capacity',
                            position: 'top'
                        }
                    },
                    {
                        id: 'capacity',
                        type: 'line',
                        mode: 'horizontal',
                        scaleID: 'y-axis-0',
                        value: 70,
                        borderColor: 'green',
                        borderWidth: 3,
                        label: {
                            enabled: true,
                            content: 'Capacity',
                            position: 'top'
                        }
                    },
                ]
            },
            //  plugins: {
            //    datalabels: {
            //        display: false,
            //        color: 'black',
            //        formatter: function (value, context) {
            //            console.log('bis', context.chart.data.datasets[context.dataIndex].data);
            //            return value;
            //        },

            //    }
            //},
            plugins: {
                datalabels: {
                    display: false,
                }
            },
            scales: {
                xAxes: [{
                    stacked: true,
                    //type: 'time',
                    //time: {
                    //    unit: 'month',
                    //},
                    //ticks: {
                    //    min: new Date('2013-01-20'),
                    //    max: new Date('2013-05-20'),
                    //},
                }],

                yAxes: [{
                    stacked: true,
                    ticks: {
                        beginAtZero: true,
                        max: 120
                    }
                }],
            }
        }
    })


    new Chart(verticalChartCanvasModal, {
        type: 'bar',
        data: {
            labels: ["W" + new Date('2013-02-01').getWeek(), "W" + new Date('2013-03-01').getWeek(), "W" + new Date('2013-04-01').getWeek(), "W" + new Date('2013-05-01').getWeek()],
            datasets: [
                {
                    label: "CC# 111111",
                    data: [0, 20, 20, 0],
                    backgroundColor: '#f56954',
                    order: 1,
                },
                {
                    label: "CC# 222222",
                    data: [0, 0, 0, 10],
                    backgroundColor: '#00a65a',
                    order: 1,
                },
                {
                    label: "CC# 333333",
                    data: [10, 0, 0, 0],
                    backgroundColor: '#f39c12',
                    order: 1,
                },
                {
                    label: "CC# 444444",
                    data: [0, 0, 10, 0],
                    backgroundColor: '#00c0ef',
                    order: 1,
                },
                {
                    label: "CC# 454545",
                    data: [0, 0, 0, 10],
                    backgroundColor: '#3c8dbc',
                    order: 1,
                },
                {
                    label: 'Demand',
                    borderColor: 'orange',
                    data: [20, 40, 40, 15],
                    type: 'line',
                    fill: false,
                    order: 0,
                    borderDash: [5, 5],
                }
            ]
        },
        options: {
            annotation: {
                annotations: [
                    {
                        id: 'maxcapacity',
                        type: 'line',
                        mode: 'horizontal',
                        scaleID: 'y-axis-0',
                        value: 90,
                        borderColor: 'red',
                        borderWidth: 3,
                        borderDash: [5, 5],
                        label: {
                            enabled: true,
                            content: 'Max Capacity',
                            position: 'top'
                        }
                    },
                    {
                        id: 'capacity',
                        type: 'line',
                        mode: 'horizontal',
                        scaleID: 'y-axis-0',
                        value: 70,
                        borderColor: 'green',
                        borderWidth: 3,
                        label: {
                            enabled: true,
                            content: 'Capacity',
                            position: 'top'
                        }
                    },
                ]
            },
            //  plugins: {
            //    datalabels: {
            //        display: false,
            //        color: 'black',
            //        formatter: function (value, context) {
            //            console.log('bis', context.chart.data.datasets[context.dataIndex].data);
            //            return value;
            //        },

            //    }
            //},
            plugins: {
                datalabels: {
                    display: false,
                }
            },
            scales: {
                xAxes: [{
                    stacked: true,
                    //type: 'time',
                    //time: {
                    //    unit: 'month',
                    //},
                    //ticks: {
                    //    min: new Date('2013-01-20'),
                    //    max: new Date('2013-05-20'),
                    //},
                }],

                yAxes: [{
                    stacked: true,
                    ticks: {
                        beginAtZero: true,
                        max: 120
                    }
                }],
            }
        }
    })

    //-------------------------------------- END Vertical chart------------------------------------------------------


    //-------------------------------------- Line and Bar chart------------------------------------------------------

    var lineAndBarChartCanvas = $('#lineAndBarChart').get(0).getContext('2d');
    var lineAndBarChartCanvasModal = $('#lineAndBarChartModal').get(0).getContext('2d');
    //var lineChartOptions = $.extend(true, {}, areaChartOptions)
    //var lineChartData = $.extend(true, {}, areaChartData)
    //lineChartData.datasets[0].fill = false;
    //lineChartData.datasets[1].fill = false;
    //lineChartOptions.datasetFill = false

    //var lineChart = new Chart(lineChartCanvas, {
    //  type: 'line',
    //  data: lineChartData,
    //  options: lineChartOptions
    //})

    new Chart(lineAndBarChartCanvas, {
        type: 'bar',
        data: {
            labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
            datasets: [
                {
                    label: 'Digital Goods',
                    borderColor: 'rgb(255, 99, 132)',
                    backgroundColor: '#f56954',
                    data: [10, 20, 30, 40, 50, 60, 70],
                    order: 1,
                    type: 'bar',
                    yAxisID: 'A'
                },
                {
                    label: 'Electronics',
                    borderColor: 'rgb(216, 6, 43)',
                    backgroundColor: '#00a65a',
                    data: [70, 60, 50, 40, 30, 20, 10],
                    order: 1,
                    type: 'bar',
                    yAxisID: 'B',
                },
                {
                    label: 'Capacity',
                    borderColor: '#f39c12',
                    data: [50, 60, 40, 70, 30, 80, 10],
                    type: 'line',
                    fill: false,
                    order: 0,
                    yAxisID: 'A',
                },
                {
                    label: 'Quantity',
                    borderColor: '#00c0ef',
                    data: [30, 40, 20, 60, 50, 90, 80],
                    type: 'line',
                    fill: false,
                    order: 0,
                    yAxisID: 'B',
                },
            ]
        },
        responsive: true,
        options: {
            plugins: {
                datalabels: {
                    display: false,
                }
            },
            scales: {
                yAxes: [
                    {
                        id: 'A',
                        type: 'linear',
                        position: 'left',
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Capacity / Digital Goods'
                        },
                        ticks: {
                            beginAtZero: true
                        }
                    },
                    {
                        id: 'B',
                        type: 'linear',
                        position: 'right',
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Quantity / Electronics'
                        },
                        ticks: {
                            beginAtZero: true
                        }
                    }
                ]
            },
        }
    })

    new Chart(lineAndBarChartCanvasModal, {
        type: 'bar',
        data: {
            labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
            datasets: [
                {
                    label: 'Digital Goods',
                    borderColor: 'rgb(255, 99, 132)',
                    backgroundColor: '#f56954',
                    data: [10, 20, 30, 40, 50, 60, 70],
                    order: 1,
                    type: 'bar',
                    yAxisID: 'A'
                },
                {
                    label: 'Electronics',
                    borderColor: 'rgb(216, 6, 43)',
                    backgroundColor: '#00a65a',
                    data: [70, 60, 50, 40, 30, 20, 10],
                    order: 1,
                    type: 'bar',
                    yAxisID: 'B',
                },
                {
                    label: 'Capacity',
                    borderColor: '#f39c12',
                    data: [50, 60, 40, 70, 30, 80, 10],
                    type: 'line',
                    fill: false,
                    order: 0,
                    yAxisID: 'A',
                },
                {
                    label: 'Quantity',
                    borderColor: '#00c0ef',
                    data: [30, 40, 20, 60, 50, 90, 80],
                    type: 'line',
                    fill: false,
                    order: 0,
                    yAxisID: 'B',
                },
            ]
        },
        responsive: true,
        options: {
            plugins: {
                datalabels: {
                    display: false,
                }
            },
            scales: {
                yAxes: [
                    {
                        id: 'A',
                        type: 'linear',
                        position: 'left',
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Capacity / Digital Goods',
                            fontSize: 15,
                            //fontColor: 'red',
                            fontStyle: 'bold'
                        },
                        ticks: {
                            beginAtZero: true,
                            //fontSize: 40
                        }
                    },
                    {
                        id: 'B',
                        type: 'linear',
                        position: 'right',
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Quantity / Electronics',
                            fontSize: 15,
                            fontStyle: 'bold'
                        },
                        ticks: {
                            beginAtZero: true
                        }
                    }
                ]
            },
        }
    })

        //-------------------------------------- END Line and Bar chart------------------------------------------------------

  //-------------------------------------- Horizontal Timeline chart------------------------------------------------------
    var timelineChartCanvas = $('#timelineChart').get(0).getContext('2d');
    var timelineChartCanvasModal = $('#timelineChartModal').get(0).getContext('2d');

    //Create pie or douhnut chart
    // You can switch between pie and douhnut using the method below.


    function convert(str) {
        var date = new Date(str),
            mnth = ("0" + (date.getMonth() + 1)).slice(-2),
            day = ("0" + date.getDate()).slice(-2);

        return [day, mnth, date.getFullYear()].join("-");
    };

    const calculateday = (date1, date2) => {
        const ONE_DAY = 1000 * 60 * 60 * 24;
        const numberofday = Math.round(Math.abs((date1 - date2) / ONE_DAY));
        return numberofday;
    };

    const checkcolor = (dataArray, defaultColor) => {
        const backgroundcolor = [];
        for (i = 0; i < dataArray.length; i++) {
            const numberofday = calculateday(dataArray[i][0], dataArray[i][1]);
            if (numberofday <= 100) {
                backgroundcolor.push(defaultColor);
            }
            else if (numberofday > 100 && numberofday <= 200) {
                backgroundcolor.push('yellow');
            }
            else {
                backgroundcolor.push('red');
            }
        }
        return backgroundcolor;
    };

    const lineFreeData = [
        [new Date('2021-01-01'), new Date('2021-03-01')],
        [new Date('2021-03-01'), new Date('2021-06-01')],
        [new Date('2021-01-01'), new Date('2021-06-01')],
    ];

    const noneTappingData = [
        [new Date('2021-03-01'), new Date('2021-09-01')],
        [], []
    ];

    const tappingData = [
        [],
        [new Date('2021-01-01'), new Date('2021-03-01')],
        []
    ];

    const thermoBondingData = [
        [],
        [new Date('2021-06-01'), new Date('2021-09-01')],
        [],
    ];

    const mixProcessesData = [
        [],
        [new Date('2021-09-01'), new Date('2021-12-01')],
        [],
    ];

    const forcecastData = [
        [new Date('2021-09-01'), new Date('2021-12-01')],
        [],
        [],
    ];

    const defaultColor = ['#f56954', '#00a65a', '#f39c12', '#00c0ef', '#3c8dbc', '#d2d6de'];

    new Chart(timelineChartCanvas, {
        type: 'horizontalBar',
        data: {
            labels: ['Line 1', 'Line 2', 'Line 3'],
            datasets: [
                {
                    label: 'Line Free',
                    data: lineFreeData,
                    backgroundColor: checkcolor(lineFreeData, defaultColor[0]),
                    borderWidth: 1,
                },
                {
                    label: 'None Tapping',
                    data: noneTappingData,
                    backgroundColor: checkcolor(noneTappingData, defaultColor[1]),
                    borderWidth: 1
                },
                {
                    label: 'Tapping',
                    data: tappingData,
                    backgroundColor: checkcolor(tappingData, defaultColor[2]),
                    borderWidth: 1
                },
                {
                    label: 'Thermo Bonding',
                    data: thermoBondingData,
                    backgroundColor: checkcolor(thermoBondingData, defaultColor[3]),
                    borderWidth: 1
                },
                {
                    label: 'Mix Processes',
                    data: mixProcessesData,
                    backgroundColor: checkcolor(mixProcessesData, defaultColor[4]),
                    borderWidth: 1
                },
                {
                    label: 'Forcecast',
                    data: forcecastData,
                    backgroundColor: checkcolor(forcecastData, defaultColor[5]),
                    borderWidth: 1,
                },
            ]
        },
        options: {
            legend: {
                display: false
            },
            tooltips: {
                enabled: true,
                mode: 'point',
                displayColors: false,
                titleAlign: 'center',
                callbacks: {
                    title: function (ctx) {
                        return "==== " + ctx[0].label + " ====";
                    },
                    label: function (tooltipItems, data) {
                        //console.log('tool', tooltipItems);
                        //console.log('data', data);

                        const dataLabel = [];
                        for (i = 0; i < data.datasets.length; i++) {
                            if (data.datasets[i].data[tooltipItems.index].length > 0) {
                                //dataLabel.push(data.datasets[i].label + ": " + convert(data.datasets[i].data[tooltipItems.index][0]) + " To " + convert(data.datasets[i].data[tooltipItems.index][1]));
                                dataLabel.push(data.datasets[i].label + ": " + calculateday(data.datasets[i].data[tooltipItems.index][0], data.datasets[i].data[tooltipItems.index][1]) + " days");
                            } else {
                                dataLabel.push("");
                            }
                        }
                        return dataLabel.filter(String);
                    }
                }
            },
            responsive: true,
            // annotation: {
            //    annotations: [{
            //        type: 'line',
            //        mode: 'vertical',
            //        scaleID: 'x-axis-0',
            //        value: new Date('2021-11-30'),
            //        borderColor: 'red',
            //        borderWidth: 1,
            //        label: {
            //            enabled: true,
            //            content: 'Max Capacity',
            //            position: 'top'
            //        }
            //    }]
            //},
            plugins: {
                datalabels: {
                    display: true,
                    color: 'black',
                    formatter: function (value, context) {
                        if (value.length > 0) {
                            return context.dataset.label + "\n" + 'From: ' + convert(value[0]) + "\n" + "To: " + convert(value[1]);
                        }
                        else {
                            return " ";
                        }
                    },
                    font: {
                        weight: 'bold',
                        size: 8,
                    }
                }
            },
            scales: {
                xAxes: [{
                    type: 'time',
                    time: {
                        unit: 'month'
                    },
                    ticks: {
                        min: new Date('2020-12-01'),
                        max: new Date('2022-01-01'),
                    },

                }],
                yAxes: [{
                    stacked: true,
                }]
            }
        }
    });


    new Chart(timelineChartCanvasModal, {
        type: 'horizontalBar',
        data: {
            labels: ['Line 1', 'Line 2', 'Line 3'],
            datasets: [
                {
                    label: 'Line Free',
                    data: lineFreeData,
                    backgroundColor: checkcolor(lineFreeData, defaultColor[0]),
                    borderWidth: 1,
                },
                {
                    label: 'None Tapping',
                    data: noneTappingData,
                    backgroundColor: checkcolor(noneTappingData, defaultColor[1]),
                    borderWidth: 1
                },
                {
                    label: 'Tapping',
                    data: tappingData,
                    backgroundColor: checkcolor(tappingData, defaultColor[2]),
                    borderWidth: 1
                },
                {
                    label: 'Thermo Bonding',
                    data: thermoBondingData,
                    backgroundColor: checkcolor(thermoBondingData, defaultColor[3]),
                    borderWidth: 1
                },
                {
                    label: 'Mix Processes',
                    data: mixProcessesData,
                    backgroundColor: checkcolor(mixProcessesData, defaultColor[4]),
                    borderWidth: 1
                },
                {
                    label: 'Forcecast',
                    data: forcecastData,
                    backgroundColor: checkcolor(forcecastData, defaultColor[5]),
                    borderWidth: 1,
                },
            ]
        },
        options: {
            legend: {
                display: false
            },
            tooltips: {
                enabled: true,
                mode: 'point',
                displayColors: false,
                titleAlign: 'center',
                callbacks: {
                    title: function (ctx){
                        return "==== " + ctx[0].label + " ====";
                    },
                    label: function (tooltipItems, data) {
                        //console.log('tool', tooltipItems);
                        //console.log('data', data);

                        const dataLabel = [];
                        for (i = 0; i < data.datasets.length; i++) {
                            if (data.datasets[i].data[tooltipItems.index].length > 0) {
                                //dataLabel.push(data.datasets[i].label + ": " + convert(data.datasets[i].data[tooltipItems.index][0]) + " To " + convert(data.datasets[i].data[tooltipItems.index][1]));
                                dataLabel.push(data.datasets[i].label + ": " + calculateday(data.datasets[i].data[tooltipItems.index][0],data.datasets[i].data[tooltipItems.index][1]) + " days");
                            } else {
                                dataLabel.push("");
                            }
                        }
                        return dataLabel.filter(String);
                    }
                }
            },
            responsive: true,
            // annotation: {
            //    annotations: [{
            //        type: 'line',
            //        mode: 'vertical',
            //        scaleID: 'x-axis-0',
            //        value: new Date('2021-11-30'),
            //        borderColor: 'red',
            //        borderWidth: 1,
            //        label: {
            //            enabled: true,
            //            content: 'Max Capacity',
            //            position: 'top'
            //        }
            //    }]
            //},
            plugins: {
                datalabels: {
                    display: true,
                    color: 'black',
                    formatter: function (value, context) {
                        if (value.length > 0) {
                            return context.dataset.label + "\n" + 'From: ' + convert(value[0]) + "\n" + "To: " + convert(value[1]);
                        }
                        else {
                            return " ";
                        }
                    },
                    font: {
                        //weight: 'bold',
                        size: 12,
                    }
                }
            },
            scales: {
                xAxes: [{
                    type: 'time',
                    time: {
                        unit: 'month'
                    },
                    ticks: {
                        min: new Date('2020-12-01'),
                        max: new Date('2022-01-01'),
                    },

                }],
                yAxes: [{
                    stacked: true,
                }]
            }
        }
    });

   //--------------------------------------END Horizontal Timeline chart------------------------------------------------------


     //--------------------------------------Pie chart------------------------------------------------------
    var pieChartCanvas = $('#pieChart').get(0).getContext('2d');
    var pieChartCanvasModal = $('#pieChartModal').get(0).getContext('2d');

    var  pieChartData = {
        labels: [
            'Chrome',
            'IE',
            'FireFox',
            'Safari',
            'Opera',
            'Navigator',
        ],
        datasets: [
            {
                data: [700, 500, 400, 600, 300, 300],
                backgroundColor: ['#f56954', '#00a65a', '#f39c12', '#00c0ef', '#3c8dbc', '#d2d6de'],
            }
        ]
    }

    //var donutOptions = {
    //    maintainAspectRatio: false,
    //    responsive: true,
    //    plugins: {
    //        datalabels: {
    //            display: false,
    //        }
    //    },
    //}

    var pieData = pieChartData;
    var pieOptions = {
        maintainAspectRatio: false,
        responsive: true,
        plugins: {
            datalabels: {
                display: true,
                formatter: (value, ctx) => {
                    let sum = 0;
                    let dataArr = ctx.dataset.data;
                    dataArr.map((data) => {
                        sum += data;
                    });
                    let percentage = (value * 100 / sum).toFixed(2) + "%";
                    return percentage;
                    //console.log('pie', ctx.dataset.data);
                },
                color: 'black',
            }
        },
    }
    //Create pie or douhnut chart
    // You can switch between pie and douhnut using the method below.
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

 //--------------------------------------END Pie chart------------------------------------------------------


 //--------------------------------------Bar chart------------------------------------------------------

    var barAndStakedBarChartData = {
        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
        datasets: [
            {
                label: 'Digital Goods',
                backgroundColor: 'rgba(60,141,188,0.9)',
                borderColor: 'rgba(60,141,188,0.8)',
                pointRadius: false,
                pointColor: '#3b8bba',
                pointStrokeColor: 'rgba(60,141,188,1)',
                pointHighlightFill: '#fff',
                pointHighlightStroke: 'rgba(60,141,188,1)',
                data: [28, 48, 40, 19, 86, 27, 90]
            },
            {
                label: 'Electronics',
                backgroundColor: 'rgba(210, 214, 222, 1)',
                borderColor: 'rgba(210, 214, 222, 1)',
                pointRadius: false,
                pointColor: 'rgba(210, 214, 222, 1)',
                pointStrokeColor: '#c1c7d1',
                pointHighlightFill: '#fff',
                pointHighlightStroke: 'rgba(220,220,220,1)',
                data: [65, 59, 80, 81, 56, 55, 40]
            },
        ]
    }

    //var areaChartOptions = {
    //    plugins: {
    //        datalabels: {
    //            display: false,
    //        }
    //    },
    //    maintainAspectRatio: false,
    //    responsive: true,
    //    legend: {
    //        display: false
    //    },
    //    scales: {
    //        xAxes: [{
    //            gridLines: {
    //                display: false,
    //            }
    //        }],
    //        yAxes: [{
    //            gridLines: {
    //                display: false,
    //            }
    //        }]
    //    }
    //}


    var barChartCanvas = $('#barChart').get(0).getContext('2d');
    var barChartCanvasModal = $('#barChartModal').get(0).getContext('2d');
    var barChartData = $.extend(true, {}, barAndStakedBarChartData)
    var temp0 = barAndStakedBarChartData.datasets[0]
    var temp1 = barAndStakedBarChartData.datasets[1]
    barChartData.datasets[0] = temp1
    barChartData.datasets[1] = temp0

    var barChartOptions = {
        responsive: true,
        maintainAspectRatio: false,
        datasetFill: false,
        plugins: {
            datalabels: {
                display: false,
            }
        },
    }

    new Chart(barChartCanvas, {
        type: 'bar',
        data: barChartData,
        options: barChartOptions
    })

    new Chart(barChartCanvasModal, {
        type: 'bar',
        data: barChartData,
        options: barChartOptions
    })

     //-------------------------------------- END Bar chart------------------------------------------------------

     //--------------------------------------Stacked Bar chart------------------------------------------------------
    var stackedBarChartCanvas = $('#stackedBarChart').get(0).getContext('2d');
    var stackedBarChartCanvasModal = $('#stackedBarChartModal').get(0).getContext('2d');

    var stackedBarChartData = $.extend(true, {}, barAndStakedBarChartData)

    var stackedBarChartOptions = {
        plugins: {
            datalabels: {
                display: false,
            }
        },
        responsive: true,
        maintainAspectRatio: false,
        scales: {
            xAxes: [{
                stacked: true,
            }],
            yAxes: [{
                stacked: true
            }]
        }
    }

    new Chart(stackedBarChartCanvas, {
        type: 'bar',
        data: stackedBarChartData,
        options: stackedBarChartOptions
    })

    new Chart(stackedBarChartCanvasModal, {
        type: 'bar',
        data: stackedBarChartData,
        options: stackedBarChartOptions
    })

     //--------------------------------------END Stacked Bar chart------------------------------------------------------
})

//END of function

