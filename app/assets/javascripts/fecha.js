/* funcion para sacar la fecha como calendario*/


$(document).ready(function(){
	
  	$('.time_picker').timepicker();
  	
	$(".datepicker").datepicker({
		"format":"yyyy-mm-dd",
		"weekStart":1,
		"language":'es',
		"autoclose":true
	});

	$('.llamado_oculto').css('display', 'none')

	$(".check_box").change(function(){ 
		var checked_box = $(this).is(':checked') 
		if (checked_box) {
			$('.llamado_oculto').css('display', 'block')
		}else{
			$('.llamado_oculto').css('display', 'none')
		}

	});

/*
	// AJAX Form Submit
  $(".submit").click(function(event) {
 
      // Show Progress Indicator
      $(".ajax-progress").show();
 
    });
// END
*/

});
