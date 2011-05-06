(function($) {

	$.fn.page_view_plot = function(data, utc_start_time_milliseconds) {

	  if (!this.length) { return this; }
	
		var milliseconds_in_day = 86400000;
	
		return new Highcharts.Chart({
			chart: {
		    renderTo: this.attr('id'),
		    defaultSeriesType: 'spline',
		    marginRight: 130,
		    marginBottom: 85
		  },
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
		  },
			series: [{
	      name: 'series',
	      pointInterval: milliseconds_in_day,
	      pointStart: utc_start_time_milliseconds,
	      data: data
	    }]
	
		});
	
	};

})(jQuery);
