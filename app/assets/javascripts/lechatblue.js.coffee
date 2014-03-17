$(window).on "load", ->
	"test"

$ ->
	$("body").css "visibility", "visible"
	if $(window).height() > 469
		$("#left_section").height $(window).height()
	#$("#content").height $(window).height() - 205       #### TRY UNCOMMENTING THIS LINE :D PRETTY COOL ;)
	$("[data-href]:not(.selected)").click ->
		href = $(this).attr("data-href")
		window.location = href