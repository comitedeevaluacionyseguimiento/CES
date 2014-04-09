$('.userc').change(function(){

	var userscid = $('.userc :selected').val();
	var instructorid = $('.instructor :selected').val();
	var email = $('#emails').val();
	var namesusers = $('#names').val();
	if (userscid != "") {
		update_aprendices(userscid,email,namesusers,instructorid)
		$('.userc :selected').val("");
	};
	
})

$('.instructor').change(function(){
	
	var userscid = $('.userc :selected').val();
	var instructorid = $('.instructor :selected').val();
	var email = $('#emails').val();
	var namesusers = $('#names').val();
	if (instructorid  != "") {
		update_aprendices(userscid,email,namesusers,instructorid)
		$('.instructor :selected').val("");
	};

})

function  update_aprendices(user_id,email,name,instructor) {  
  jQuery.ajax({
    url: "/comites/emails_comite",
    type: "GET",
    data: ("committee_members_id=" + user_id + "&" + "email=" + email + "&" + "names=" + name + "&" + "instructor_id=" + instructor)
  });
}
