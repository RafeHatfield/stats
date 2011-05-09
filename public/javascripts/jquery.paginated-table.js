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

	$.fn.paginated_table = function(data_url, limit) {
		// Save wrapped object as 'o'.
		var o = this;
		// If no wrapped object, return the empty wrap.
	  if (!o.length) { return o; }
		// Define a default limit.
		if (typeof limit == "undefined") {
		    var limit = 20;
		 }

		// Append the first set of data to the table
		// and remove the loading indicator.
		$.get(data_url, {limit : limit, offset : 0}, function(html){
      $(".loading", o).hide();
      $("table", o).append(html);
    }); 
    
		// When the 'more' button is clicked.
    $(".more", o).click(function(){
			// Show the loading indicator.
      $(".loading", o).show();
			// Append the next set of data to the table
			// and remove the loading indicator.
      $.get( data_url, {limit : limit, offset : $("tbody tr", o).length}, function(data){
          $("table", o).append(data);
          $(".loading", o).hide();
        }
      );
      return false;
    });
		
		return o;
		
	};

})(jQuery);
