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
