jQuery(document).ready(function() {    

	if ($('#downloadFiles').length) {
		
	$('#downloadFiles').click(function(){

		var url = "/pratiche/comuni/f/download";
		
    var $form = $('<form>', {
        action: url,
        method: 'post'
    });
    $('.idtodownload').each(function(index) {
    e = $(this);
    if (e.is(':checked')) {
         $('<input>').attr({
             type: "hidden",
             name: "idtodownload[]",
             value: e.attr("value")
         }).appendTo($form);
         }
    });
    
    var token = $('#ezxform_token_js').attr("title");
    $('<input>').attr({
             type: "hidden",
             name: "ezxform_token",
             value: token
         }).appendTo($form);
    
    $('.idtodownload').each(function(index) {
    		$(this).prop('checked', false);
    });
    
    $form.appendTo('body').submit();
    
    
    
	
	});


	}
	
	if ($('#browsesearch').length) {
		$('#browsesearch').click(function(){
		var searchtext = $('#SearchBrowse').val();
		

					$.ez( 'kcomuni::SearchBrowse', {searcht: searchtext, permitarray: permitclass}, function( data )
    		{
    		
    		});
    		
    		
		});
		
	
	}
	
	
	
	
   
});
