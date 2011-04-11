(function($) {
// What does the page_view_plot plugin do?
$.fn.page_view_plot = function(options) {

  if (!this.length) { return this; }
	
	var id = this.attr('id');
	var chart = {
		chart: {
	    renderTo: id,
	    defaultSeriesType: 'spline',
	    marginRight: 130,
	    marginBottom: 85
	  }
	};
	$.extend(true, options, chart);
	
  var page_view_opts = $.extend(true, {}, $.fn.page_view_plot.defaults, options);
	var page_view_plot = new Highcharts.Chart(page_view_opts);
  return page_view_plot;
};

// default options
$.fn.page_view_plot.defaults = {
  title: false,
  legend: {
    enabled: false
  },
  xAxis: {
    type: 'datetime'
  },
  yAxis: {
    title: false,
    min: 0
  },
  tooltip: {
    formatter: function() {
      return Highcharts.dateFormat("%B %e %Y", this.x) + ': ' + this.y;
    }
  },
  credits: {
    enabled: false
  }
};

})(jQuery);
