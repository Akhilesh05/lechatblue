removeClick = (e, t) ->
	e.preventDefault()
	self = $(t)
	num = self.attr "data-num"
	$("tr[data-num=\"" + num + "\"]").remove()
	$("#order_pizza_id_" + num).remove()
	updateRemove()

updateRemove = ->
	if $(".pizza_size").length > 1
		$(".pizza_size").each ->
			num = $(this).attr "data-num"
			$($($(this).children()[2]).children()[0]).html "<a href=\"\" class=\"remove\" data-num=\"" + num + "\">Remove this pizza</a>"
			$(".remove").on "click", (event) ->
				removeClick event, this
	else
		$($($(".pizza_size").children()[2]).children()[0]).html ""

$ ->
	#pizzaPrice = $.parseJSON window._pizzaPrice_
	$("#cancel_button").click (event) ->
		event.preventDefault()
		window.location = "/create-order/cancel"

	updateRemove()