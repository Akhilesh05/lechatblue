$ ->
	pizzaPrice = $.parseJSON window._pizzaPrice_
	$("#cancel_button").click (event) ->
		event.preventDefault()
		window.history.back()