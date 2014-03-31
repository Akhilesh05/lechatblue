class AjaxController < ApplicationController
	def get_pizza_details
		@pizza = Pizza.find_by id: params[:pizza_id]   ## did not used Pizza.find since it throws 404 automatically if pizza id not found
		if @pizza.nil?
			render json: {:error => "404"}
		else
			render json: @pizza
		end
	end
end
