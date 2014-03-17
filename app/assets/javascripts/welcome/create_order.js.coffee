removeClick = (e, t) ->
	e.preventDefault()
	self = $(t)
	num = self.attr "data-num"
	$("tr[data-num=\"" + num + "\"]").remove()
	$("#order_pizza_id_" + num).remove()
	$.get(self.attr "href" )
	updateRemove()

updateRemove = ->
	if $(".pizza_size").length > 1
		$(".remove").each ->
			$(this).html "Remove this pizza"
	else
		$(".remove").html ""

$ ->
	$(".remove").click (event) ->
		removeClick event, this
	#pizzaPrice = $.parseJSON window._pizzaPrice_
	$("#cancel_button").click (event) ->
		event.preventDefault()
		window.location = "/create-order/cancel"

	updateRemove()