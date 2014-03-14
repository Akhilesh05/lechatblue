$(window).on "load", ->
	"test"

$ ->
	$("body").css "visibility", "visible"
	if $(window).height() > 464
		$("#left_section").height $(window).height()
	$("[data-href]").click ->
		href = $(this).attr("data-href")
		window.location = href