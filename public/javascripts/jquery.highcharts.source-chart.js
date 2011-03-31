(function($) {
// What does the page_view_plot plugin do?
$.fn.source_chart = function(options) {

  if (!this.length) { return this; }
	
  var source_chart_opts = $.extend(true, {}, $.fn.source_chart.defaults, options);
	var source_chart = new Highcharts.Chart(source_chart_opts);
  return source_chart;
};

// default options
$.fn.source_chart.defaults = {
  chart: {
     renderTo: 'source_chart',
     plotBackgroundColor: null,
     plotBorderWidth: null,
     plotShadow: false,
     marginLeft: 100,
     marginRight: 100,
     marginBottom: 50,
     marginTop: 50
  },
  title: {
     text: ''
  },
  tooltip: {
     formatter: function() {
        return '<b>'+ this.point.name +'</b>: '+ this.y;
     }
  },
  credits: {
    enabled: false
  },
  plotOptions: {
     pie: {
        allowPointSelect: true,
        cursor: 'pointer',
        dataLabels: {
           enabled: true,
           color: '#000000',
           connectorColor: '#000000',
           formatter: function() {
              return '<b>'+ this.point.name +'</b>: '+ this.y;
           }
        }
     }
  }
};

})(jQuery);