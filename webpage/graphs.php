<html>
  <head>
    <title>rasPi Station</title>
    <link rel="stylesheet" href="http://kassid.local/styles.css"></link>
    <link rel="icon" type="image/png" href="http://kassid.local/water.png"></link>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
    <script src="http://code.highcharts.com/stock/highstock.js"></script>
    <script src="http://code.highcharts.com/highcharts-more.js"></script>
    <script src="http://code.highcharts.com/stock/modules/exporting.js"></script>
    <script src="styles.js"></script>
  </head>
  <body id="main">
    <ul><li><a href="http://kassid.local">Home</a></li>
       <li><a href="">About</a></li>
       <li>
         Graphs
         <ul>
           <li><a href="graphs.php">Temp & Humidity</a></li>
         </ul>
       </li>
       <li>
         Directories
         <ul>
           <li><a href="http://kassid.local/homecopy/" target="_blank">Elutuba</a></li>
           <li><a href="http://dussimeter.local/homecopy/" target="_blank">Dušširuum</a></li>
         </ul>
       </li>
       <li>
         Actions
         <ul>
           <li><a href="#" target="_blank">Meter Reading</a></li>
           <li><a href="http://kassid.local/test.php" target="_blank">Test</a></li>
         </ul>
       </li>
       <li><a href="">Contact</a></li>
     </ul>
    <script>

    $(function () {
        var seriesOptions = [],
            seriesCounter = 0,
            names = ['magatemp', 'elutemp', 'magahum', 'eluhum'],
            // create the chart when all data is loaded
            createChart = function () {

                $('#container').highcharts('StockChart', {

                    legend: {
                      enabled: true,
                      align: 'center',
                      verticalAlign: 'top',
                      x: 0,
                      y: 0,
                      floating: true
                    },
                    rangeSelector: {
                    
                      buttons: [{
                          type: 'hour',
                          count: 1,
                          text: 'h'
                      }, {
                          type: 'hour',
                          count: 6,
                          text: '6h'
                      }, {
                          type: 'day',
                          count: 1,
                          text: 'd'
                      }, {
                          type: 'week',
                          count: 1,
                          text: 'w'
                      }, {
                          type: 'month',
                          count: 1,
                          text: 'm'
                      }, {
                          type: 'all',
                          text: 'All'
                      }],
                      selected: 0
                    },

                    yAxis: {
                        title: {
                            text: 'Temp & Humidity'
                        },
                        plotLines: [{
                            value: 0,
                            width: 2,
                            color: 'silver'
                        }]
                    },

                    tooltip: {
                        valueDecimals: 1
                    },

                    series: seriesOptions
                });
            };
        $.each(names, function (i, name) {

            $.getJSON('/homecopy/Temps/data/' + name.toLowerCase() + '.json',    function (data) {

                seriesOptions[i] = {
                    name: name,
                    data: data
                };

                // As we're loading the data asynchronously, we don't know what order it will arrive. So
                // we keep a counter and create the chart when all the data is loaded.
                seriesCounter += 1;

                if (seriesCounter === names.length) {
                    createChart();
                }
            });
        });
    });
    </script>
    <div id="container" style="height: 400px; min-width: 310px"></div>
  </body>
</html>
