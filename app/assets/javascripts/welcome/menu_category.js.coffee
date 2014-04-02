pizza = (name='', ingredients=Array(), description='', price=Object(), image='') ->
	$("#overlay_content").html ""
	this.name = "<div id=\"hidden_pizza_name\" class=\"heading\" style=\"padding-left: 0\">" + name + "</div>"
	this.ingredients = "<div id=\"hidden_pizza_ingredients\">" + "-&nbsp;" + ingredients.join("<br />-&nbsp;") + "</div>"
	this.description = "<div id=\"hidden_pizza_description\">" + description + "</div>"
	this.price = "<div id=\"hidden_pizza_price\">" + "<b>Small:</b> Rs" + price.small + " <b>Medium:</b> Rs" + price.medium + " <b>Large:</b> Rs" + price.large + "</div>"
	this.image = "<img src=\"" + "/images/items/p_" + image + ".jpg" + "\" />"
	this.innerHtml =    "<aside id=\"hidden\">" +
							"<div id=\"hidden_pizza\">" +
								"<div style=\"width: 431px; margin: 0 auto\">" + this.name + "</div>" +
								"<table style=\"margin: 0 auto\">" +
									"<tr>" +
										"<td>" +
											"<div>" + "<div id=\"hidden_pizza_image\">" + this.image + "</div>" + "</div>" +
										"</td>" +
										"<td style=\"width: 300px\">" +
											"<div>" + this.ingredients + "</div>" +
											"<div>" + this.description + "</div>" +
											"<div>" + this.price + "</div>" +
										"</td>" +
									"</tr>" +
								"</table>" +
							"</div>" +
						"</aside>"
	$("#overlay_content").html this.innerHtml

openPizzaOverlay = (pizzaId) ->
	$.ajax "/ajax/get_pizza_details.json",
		type: 'post',
		data: { authenticity_token: window._csrfToken_, pizza_id: pizzaId},
		success: (JSON) ->
			if JSON.error == "404"
				window._overlay_.htmlAndOpen "Error 404"
			else
				new pizza JSON.name, JSON.ingredients, JSON.description, JSON.price, JSON.image
				window._overlay_.htmlAndOpen $("#hidden_pizza").html()

jQuery ->
	$(".menu_details").width $(".menu:first-child").width() - 125

	pizzaId = window.location.hash.split("#")[1] unless window.location.hash == ""
	openPizzaOverlay pizzaId unless isNaN(pizzaId) or window.location.hash == ""

	$(".pizza").click (event) ->
		openPizzaOverlay $(this).attr("data-id")