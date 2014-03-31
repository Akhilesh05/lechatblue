pizza = (name='', ingredients=Array(), description='', price=Object(), image='') ->
	$("#overlay_content").html("")
	this.name = name
	this.ingredients = "-&nbsp;" + ingredients.join("<br />-&nbsp;")
	this.description = description
	this.price = "<b>Small:</b> Rs" + price.small + " <b>Medium:</b> Rs" + price.medium + " <b>Large:</b> Rs" + price.large
	this.image = image + ".jpg"
	this.setName = (name) -> $("#hidden_pizza_name").html name
	this.setIngredients = (ingredients) -> $("#hidden_pizza_ingredients").html ingredients
	this.setDescription = (description) -> $("#hidden_pizza_description").html description
	this.setPrice = (price) -> $("#hidden_pizza_price").html price
	this.setImage = (image) -> $("#hidden_pizza_image").html image
	this.setName this.name
	this.setIngredients this.ingredients
	this.setDescription this.description
	this.setPrice this.price
	this.setImage this.image

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