// jQuery plugin to make a table into a lazy-ajax-loading table
// with a "load more" button, and a loading indicator.
// Structure:
//	#object_id
//		%table
//			%thead
//				...
//			%tbody
//				[ajax loaded content]		
//		.loading
//		.more
// Calling:
//	$("#object_id").paginated_table("url_to_load_data");
// Server-side:
//	The loading url should accept 'limit', and 'offset' parameters
// 	and return the appropriate data in html table row format.

(function($) {

	$.fn.paginated_table = function(data_url) {
		var o = this;
	  if (!o.length) { return o; }
	
		$.get(data_url, {}, function(html){
      $(".loading", o).hide();
      $("table", o).append(html);
    }); 
    
    $(".more", o).click(function(){
      $(".loading", o).show();
      $.get( data_url, {limit : 20, offset : $("tbody tr", o).length}, function(data){
          $("table", o).append(data);
          $(".loading", o).hide();
        }
      );
      return false;
    });
		
		return o;
		
	};

})(jQuery);
