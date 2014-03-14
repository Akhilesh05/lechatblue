$(window).on "load", ->
	$("body").css "visibility", "visible"
	#$("#left_section").width ($(window).width() - 360) / 2
	if $(window).height() > 464
		$("#left_section").height $(window).height()
	#$("#long_flag > div:nth-child(1)").width $(window).width()/3
	#$("#long_flag > div:nth-child(2)").width $(window).width()/3
	#$("#long_flag > div:nth-child(3)").width $(window).width()/3

$ ->
	$("[data-href]").click ->
		href = $(this).attr("data-href")
		window.location = href