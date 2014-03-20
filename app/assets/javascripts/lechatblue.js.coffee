resizeScreen = ->
	if $(window).height() > 469
		$("#left_section").height $(window).height()
	else
		$("#left_section").css "height", "auto"

$(window).on "load", ->
	"test"

$ ->
	resizeScreen()

	$("body").css "visibility", "visible"

	$(window).resize ->
		resizeScreen()

	apprise_options =
		buttons:
			confirm:
				text: '<span class="large lobster_two">Okay</span>'
				action: -> Apprise('close')

	if window._errorAny_
		Apprise("<span class=\"\">"+window._errorDetails_+"</span>", apprise_options)

	if window._alertAny_
		Apprise("<span class=\"\">"+window._alertDetails_+"</span>", apprise_options)

	#$("#content").height $(window).height() - 205       #### TRY UNCOMMENTING THIS LINE :D PRETTY COOL ;)
	$("[data-href]:not(.selected)").click ->
		href = $(this).attr("data-href")
		window.location = href