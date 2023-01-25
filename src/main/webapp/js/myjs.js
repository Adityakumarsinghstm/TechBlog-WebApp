function doLike(pid, uid)
{
	console.log(pid+","+uid)
	const d={
		uid: uid,
		pid: pid,
		operation:'like'
	}
	$.ajax({
		url: "LikedServlet",
		data: d,
		success: function(data, textStatus, jqXHR)
		{
			console.log(data);
		},
        error: function(jqXHR, textStatus, errorThrown) {
            console.log(data);
        }
      
	})
}

/*$(document).ready(function(){
	alert("loaded");
})*/