window._overlay_ =
	privateDuration: 300
	close: -> $("#overlay").animate {"opacity": "0"}, this.privateDuration, -> $("#overlay").css("display", "none")
	open: ->
		$("#overlay").css("display", "block")
		$("#overlay").animate {"opacity": "1"}, this.privatDuration
	html: (string) -> $("#overlay_content").html(string)
	htmlAndOpen: (string) -> this.html(string) ; this.open()

resizeScreen = ->
	$("#overlay > div#overlay_content").height $(window).height() - 150
	if $(window).height() > 469
		$("#left_section").height $(window).height()
	else
		$("#left_section").css "height", "auto"

$(window).on "load", ->
	"test"

$ ->
	window._csrfToken_ = $("meta[name=csrf-token]").attr "content"
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

	$("#overlay_close").click -> window._overlay_.close()